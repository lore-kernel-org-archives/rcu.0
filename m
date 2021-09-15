Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D695C4332F
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6751C61157
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhIOXra (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233157AbhIOXr0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:47:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49C006120D;
        Wed, 15 Sep 2021 23:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749566;
        bh=tX6PK4Xu/jV33tVuc75TOgCLcTmhlRNJ/OIgyOD6Nbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aB6K4O8vxW3OnwOnn00I1kfG5FUUZyh2oEs1WS+RF9IiCyqcYOMFXnlgP+ei9WJuL
         sd9Oqk2Tc7L467Abc9HN3z1/a7cnT2yb8P7hzIY41CtOOO0VBv69O+T6ac8LoexPyk
         mIZdQ6Rx1XelU1baOjn1cy35v2z9Va4OyG/VayfegkwUo7fNBkg1zqT9F0TQoVWlJ9
         XWQcOKJPUiFJeWSF/ZXOfSe5aHWRIVANX6JjwmrWMM92VmO+Kl4AV5eUUkoP8LQpBx
         T9un5d0yO56VyO8oXrBT7sOaDp9qAgRdTpuN/7hisY8Qk9SOuDtNa6s23KhMmsMxim
         mIKzXSoCLFWpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CDFE25C0B1B; Wed, 15 Sep 2021 16:46:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/13] rcu-tasks: Correct comparisons for CPU numbers in show_stalled_task_trace
Date:   Wed, 15 Sep 2021 16:46:00 -0700
Message-Id: <20210915234604.3907802-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

Valid CPU numbers can be zero or greater, but the checks for
->trc_ipi_to_cpu and tick_nohz_full_cpu()'s argument are for strictly
greater than.  This commit therefore corrects the check for no_hz_full
cpu in show_stalled_task_trace() so as to include cpu 0.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e2ec548fc0c4..af7388849bed 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1084,9 +1084,9 @@ static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 	cpu = task_cpu(t);
 	pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d\n",
 		 t->pid,
-		 ".I"[READ_ONCE(t->trc_ipi_to_cpu) > 0],
+		 ".I"[READ_ONCE(t->trc_ipi_to_cpu) >= 0],
 		 ".i"[is_idle_task(t)],
-		 ".N"[cpu > 0 && tick_nohz_full_cpu(cpu)],
+		 ".N"[cpu >= 0 && tick_nohz_full_cpu(cpu)],
 		 READ_ONCE(t->trc_reader_nesting),
 		 " N"[!!READ_ONCE(t->trc_reader_special.b.need_qs)],
 		 cpu);
-- 
2.31.1.189.g2e36527f23

