Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A748C6377C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89C261283
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbhGUTkx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FDCA6124B;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898889;
        bh=CDG/Ffh6JXlYsOb6vAJ1rFVJxEpimCt7Bmo04hXqOt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fbgf4hRxIdliPAydwHvUxdCsrE/K67szEHFiat49kIh5T6FFTfa71qbz0qYO2EThN
         Gv4M6Jl5nXHa6icvpmDinEB4hsKG6nJzoqRUsufaawZ5t0qBQVuNUD2zAclSaVfBRe
         b7ZR63siNRPG7UcnJk4lbtko9wO50fivhrQvobTZahTM4hpNaIQCrH+lwC98maXTDi
         BvL+cXY0OGd7zv8ekgXHirev1z6JlL+ja9+rsUow9qCEKrCnfRjIx2x7po8UUjLvz9
         qQOHPxozoM6Ty20NpLaoqtzBJpHrkUm16o67gYqquMXni0jtdD5Psp5dX72/MXS1c3
         ic0w8ICDthXNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0D9605C09A4; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Yanfei Xu <yanfei.xu@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/18] rcu: Fix to include first blocked task in stall warning
Date:   Wed, 21 Jul 2021 13:21:09 -0700
Message-Id: <20210721202127.2129660-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

The for loop in rcu_print_task_stall() always omits ts[0], which points
to the first task blocking the stalled grace period.  This in turn fails
to count this first task, which means that ndetected will be equal to
zero when all CPUs have passed through their quiescent states and only
one task is blocking the stalled grace period.  This zero value for
ndetected will in turn result in an incorrect "All QSes seen" message:

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:    Tasks blocked on level-1 rcu_node (CPUs 12-23):
        (detected by 15, t=6504 jiffies, g=164777, q=9011209)
rcu: All QSes seen, last rcu_preempt kthread activity 1 (4295252379-4295252378), jiffies_till_next_fqs=1, root ->qsmask 0x2
BUG: sleeping function called from invalid context at include/linux/uaccess.h:156
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 70613, name: msgstress04
INFO: lockdep is turned off.
Preemption disabled at:
[<ffff8000104031a4>] create_object.isra.0+0x204/0x4b0
CPU: 15 PID: 70613 Comm: msgstress04 Kdump: loaded Not tainted
5.12.2-yoctodev-standard #1
Hardware name: Marvell OcteonTX CN96XX board (DT)
Call trace:
 dump_backtrace+0x0/0x2cc
 show_stack+0x24/0x30
 dump_stack+0x110/0x188
 ___might_sleep+0x214/0x2d0
 __might_sleep+0x7c/0xe0

This commit therefore fixes the loop to include ts[0].

Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 6c76988cc019f..2e96f9741666d 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -280,8 +280,8 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 			break;
 	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	for (i--; i; i--) {
-		t = ts[i];
+	while (i) {
+		t = ts[--i];
 		if (!try_invoke_on_locked_down_task(t, check_slow_task, &rscr))
 			pr_cont(" P%d", t->pid);
 		else
-- 
2.31.1.189.g2e36527f23

