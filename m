Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A902C43460
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5A761184
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhEKWyQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhEKWyN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6DEB6192B;
        Tue, 11 May 2021 22:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773586;
        bh=YTmkCZi2/uwcp+0lPCpWWxdI96DueAEbjEKyymxKsM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OPpIENIAWdNGH2RIb1cV2QMToQoCy2Unyc/VZs9VDTE8alVYVin+ES8PyzL55igvu
         ba0B7CYyIqnL5N2Y04bAzzgWLrvfxLC/C2oaYN2G+JeEwSRslj+KERxlGUqhVWazJ/
         TokSlW3mfHEfWtRz/MmRzvBKxMtQCu+iekCHIKpJIkzhqAcABsSaZwbqDvuVW6fSlZ
         xD/fWFa1V4WxONS1d48olLd1wdIivijDs/3H/bRf+JhWsVvl6z4fZ5n/1wXDYL1Piy
         a+ZUfYxRl8XLaBZGJIZ9R5yu9dVyqsgtyjVlO65zuMGXr+PuzmCJaHBMyMqKWg5fLH
         TV3QIGZGykQoA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8ECB85C0B55; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/19] rcu: Invoke rcu_spawn_core_kthreads() from rcu_spawn_gp_kthread()
Date:   Tue, 11 May 2021 15:52:49 -0700
Message-Id: <20210511225304.2893154-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, rcu_spawn_core_kthreads() is invoked via an early_initcall(),
which works, except that rcu_spawn_gp_kthread() is also invoked via an
early_initcall() and rcu_spawn_core_kthreads() relies on adjustments to
kthread_prio that are carried out by rcu_spawn_gp_kthread().  There is
no guaranttee of ordering among early_initcall() handlers, and thus no
guarantee that kthread_prio will be properly checked and range-limited
at the time that rcu_spawn_core_kthreads() needs it.

In most cases, this bug is harmless.  After all, the only reason that
rcu_spawn_gp_kthread() adjusts the value of kthread_prio is if the user
specified a nonsensical value for this boot parameter, which experience
indicates is rare.

Nevertheless, a bug is a bug.  This commit therefore causes the
rcu_spawn_core_kthreads() function to be invoked directly from
rcu_spawn_gp_kthread() after any needed adjustments to kthread_prio have
been carried out.

Fixes: 48d07c04b4cc ("rcu: Enable elimination of Tree-RCU softirq processing")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 06f3de96997c..2532e584e95f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2889,7 +2889,6 @@ static int __init rcu_spawn_core_kthreads(void)
 		  "%s: Could not start rcuc kthread, OOM is now expected behavior\n", __func__);
 	return 0;
 }
-early_initcall(rcu_spawn_core_kthreads);
 
 /*
  * Handle any core-RCU processing required by a call_rcu() invocation.
@@ -4450,6 +4449,7 @@ static int __init rcu_spawn_gp_kthread(void)
 	wake_up_process(t);
 	rcu_spawn_nocb_kthreads();
 	rcu_spawn_boost_kthreads();
+	rcu_spawn_core_kthreads();
 	return 0;
 }
 early_initcall(rcu_spawn_gp_kthread);
-- 
2.31.1.189.g2e36527f23

