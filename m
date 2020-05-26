Return-Path: <SRS0=yR10=7I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A7AC433E2
	for <rcu@archiver.kernel.org>; Tue, 26 May 2020 13:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1442068D
	for <rcu@archiver.kernel.org>; Tue, 26 May 2020 13:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbgEZNmL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 26 May 2020 09:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgEZNmL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 26 May 2020 09:42:11 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E2C03E96D;
        Tue, 26 May 2020 06:42:10 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdZpn-0003ZA-0O; Tue, 26 May 2020 15:41:35 +0200
Date:   Tue, 26 May 2020 15:41:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: [PATCH] srcu: Avoid local_irq_save() before acquiring spinlock_t
Message-ID: <20200526134134.5uq62linhbog43q3@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
 <20200520184345.GU2869@paulmck-ThinkPad-P72>
 <20200522151255.rtqnuk2cl3dpruou@linutronix.de>
 <20200522173953.GI2869@paulmck-ThinkPad-P72>
 <20200523150831.wdrthklakwm6wago@linutronix.de>
 <20200524190356.eqohmrmbilonm4u7@linutronix.de>
 <20200525032717.GV2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525032717.GV2869@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

SRCU disables interrupts to get a stable per-CPU pointer and then
acquires the spinlock which is in the per-CPU data structure. The
release uses spin_unlock_irqrestore(). While this is correct on a non-RT
kernel, this conflicts with the RT semantics because the spinlock is
converted to a 'sleeping' spinlock. Sleeping locks can obviously not be
acquired with interrupts disabled.

Acquire the per-CPU pointer `ssp->sda' without disabling preemption and
then acquire the spinlock_t of the per-CPU data structure. The lock
will ensure that the data is consistent.
The added check_init_srcu_struct() is now needed because a statically 
defined srcu_struct may remain uninitialized until this point and the
newly introduced locking operation requires an initialized spinlock_t.

This change was tested for four hours with 8*SRCU-N and 8*SRCU-P without
causing any warnings.

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rcu@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/srcutree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0c71505f0e19c..9459bca58c380 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -764,14 +764,15 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 	unsigned long t;
 	unsigned long tlast;
 
+	check_init_srcu_struct(ssp);
 	/* If the local srcu_data structure has callbacks, not idle.  */
-	local_irq_save(flags);
-	sdp = this_cpu_ptr(ssp->sda);
+	sdp = raw_cpu_ptr(ssp->sda);
+	spin_lock_irqsave_rcu_node(sdp, flags);
 	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
-		local_irq_restore(flags);
+		spin_unlock_irqrestore_rcu_node(sdp, flags);
 		return false; /* Callbacks already present, so not idle. */
 	}
-	local_irq_restore(flags);
+	spin_unlock_irqrestore_rcu_node(sdp, flags);
 
 	/*
 	 * No local callbacks, so probabalistically probe global state.
@@ -851,9 +852,8 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	}
 	rhp->func = func;
 	idx = srcu_read_lock(ssp);
-	local_irq_save(flags);
-	sdp = this_cpu_ptr(ssp->sda);
-	spin_lock_rcu_node(sdp);
+	sdp = raw_cpu_ptr(ssp->sda);
+	spin_lock_irqsave_rcu_node(sdp, flags);
 	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_gp_seq));
-- 
2.27.0.rc0

