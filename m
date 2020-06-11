Return-Path: <SRS0=g6Hr=7Y=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78443C433E0
	for <rcu@archiver.kernel.org>; Thu, 11 Jun 2020 23:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0F02078C
	for <rcu@archiver.kernel.org>; Thu, 11 Jun 2020 23:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591919587;
	bh=9Kq7QR4PY+mdo9B6IiW2v/lydSSIPYNGctpPA8Buqj4=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=MirHU2fobfv0lmKKl1DmbS6G2lagYSZgmWHpF5ZT8K+wqSUyhDcLFbr3Y8IpBhuj0
	 IVa7p06ZGFcNK5rl/0lKvZmwxfCYznDX5iCTOuCHKmoZ2E9GGaWL5Vr1M+SwAMBzDd
	 FiA6D4n7/iYY5XtIkEjFrIWfWnE7IhkfUf0oH3pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgFKXxH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgFKXxG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 11 Jun 2020 19:53:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C9DD20731;
        Thu, 11 Jun 2020 23:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591919586;
        bh=9Kq7QR4PY+mdo9B6IiW2v/lydSSIPYNGctpPA8Buqj4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=mGUxFSOChSvImovoU7jRz2j7zBTVSwgbQZe+Rx+hzCwsrb60BQLgH326V/rZzU6xy
         dFm90PHnxDZDIr2nrLvUqXBdtxDfWdQmZCkG29pX0RldZIP4LQx9KMWk7mPSDsW1SY
         pKj20wI3/Ab0ct9OdmSd9yoJc5fOvdxBWtxisv5c=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0988D35228C7; Thu, 11 Jun 2020 16:53:06 -0700 (PDT)
Date:   Thu, 11 Jun 2020 16:53:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     tglx@linutronix.de, luto@kernel.org, x86@kernel.org,
        frederic@kernel.org, rostedt@goodmis.org, joel@joelfernandes.org,
        mathieu.desnoyers@efficios.com, will@kernel.org,
        peterz@infradead.org
Subject: [PATCH RFC] x86/entry: Ask RCU if it needs rcu_irq_{enter,exit}()
Message-ID: <20200611235305.GA32342@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU needs to detect when one if its interrupt handlers interrupted an idle
state, where an idle state is either the idle loop itself or nohz_full
userspace execution.  When a CPU has been interrupted from one of these
idle states, RCU can report a quiescent state, helping the current grace
period to come to an end.

However, there are optimized kernel-entry paths where handlers that
would normally be executed in interrupt context are instead executed
directly from the base process context, but with interrupts disabled.
When such a directly-executed handler is followed by softirq processing
(which re-enables interrupts), it is possible that one of RCU's interrupt
handlers will interrupt this softirq processing.  This situation can cause
RCU to incorrectly assume that the CPU has passed through a quiescent
state, when in fact the CPU is instead in the midst of softirq processing,
and might well be within an RCU read-side critical section.  In that case,
reporting a quiescent state can result in too-short RCU grace periods,
leading to arbitrary memory corruption and a sharp degradation in the
actuarial statistics of your kernel.

The fix is for the optimized kernel-entry paths to replace the current
call to __rcu_is_watching() with a call to a new rcu_needs_irq_enter()
function, which returns true iff RCU needs explicit calls to
rcu_irq_enter() and rcu_irq_exit() surrounding the optimized invocation
of the handler.  These explicit calls are never required in Tiny RCU,
and in Tree RCU are required only if the CPU might have interrupted
nohz_full userspace execution or the idle loop.  There is the usual
precision/overhead tradeoff, with the current implementation majoring
in low common-case overhead.

While in the area, the commit also returns rcu_is_cpu_rrupt_from_idle()
to its original semantics.

This has been subjected only to very light rcutorture testing, so use
appropriate caution.  The placement of the new rcu_needs_irq_enter()
is not ideal, but the more natural include/linux/hardirq.h location has
#include issues.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index f4d5778..50d002a 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -517,6 +517,41 @@ SYSCALL_DEFINE0(ni_syscall)
 	return -ENOSYS;
 }
 
+/*
+ * RCU needs to detect when one if its interrupt handlers interrupted
+ * an idle state, where an idle state is either the idle loop itself or
+ * nohz_full userspace execution.  When a CPU has been interrupted from
+ * one of these idle states, RCU can report a quiescent state, helping
+ * the current grace period to come to an end.
+ *
+ * However, there are optimized kernel-entry paths where handlers that
+ * would normally be executed in interrupt context are instead executed
+ * directly from the base process context, but with interrupts disabled.
+ * When such a directly-executed handler is followed by softirq processing
+ * (which re-enables interrupts), it is possible that one of RCU's interrupt
+ * handlers will interrupt this softirq processing.  This situation
+ * can cause RCU to incorrectly assume that the CPU has passed through a
+ * quiescent state, when in fact the CPU is instead in the midst of softirq
+ * processing, and might well be within an RCU read-side critical section.
+ * In that case, reporting a quiescent state can result in too-short
+ * RCU grace periods, leading to arbitrary memory corruption and a sharp
+ * degradation in the actuarial statistics of your kernel.
+ *
+ * The fix is for the optimized kernel-entry paths to make use of
+ * this function, which returns true iff RCU needs explicit calls to
+ * rcu_irq_enter() and rcu_irq_exit() surrounding the optimized invocation
+ * of the handler.  These explicit calls are never required in Tiny RCU,
+ * and in Tree RCU are required only if the CPU might have interrupted
+ * nohz_full userspace execution or the idle loop.  There is the usual
+ * precision/overhead tradeoff, with the current implementation majoring
+ * in low common-case overhead.
+ */
+static __always_inline bool rcu_needs_irq_enter(void)
+{
+	return !IS_ENABLED(CONFIG_TINY_RCU) &&
+               (context_tracking_enabled_cpu(smp_processor_id()) || is_idle_task(current));
+}
+
 /**
  * idtentry_enter_cond_rcu - Handle state tracking on idtentry with conditional
  *			     RCU handling
@@ -557,7 +592,7 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
 		return false;
 	}
 
-	if (!__rcu_is_watching()) {
+	if (rcu_needs_irq_enter()) {
 		/*
 		 * If RCU is not watching then the same careful
 		 * sequence vs. lockdep and tracing is required
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 8512cae..957ed29 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -87,7 +87,6 @@ static inline void rcu_scheduler_starting(void) { }
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
-static inline bool __rcu_is_watching(void) { return true; }
 static inline void rcu_momentary_dyntick_idle(void) { }
 static inline void kfree_rcu_scheduler_running(void) { }
 static inline bool rcu_gp_might_be_stalled(void) { return false; }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index d5cc9d67..e7072a0 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -64,7 +64,6 @@ extern int rcu_scheduler_active __read_mostly;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-bool __rcu_is_watching(void);
 #ifndef CONFIG_PREEMPTION
 void rcu_all_qs(void);
 #endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c716ead..d833e10 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -429,30 +429,25 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 {
 	long nesting;
 
-	/*
-	 * Usually called from the tick; but also used from smp_function_call()
-	 * for expedited grace periods. This latter can result in running from
-	 * the idle task, instead of an actual IPI.
-	 */
+	// Usually called from the tick; but also used from smp_function_call()
+	// for expedited grace periods. This latter can result in running from
+	// the idle task, instead of an actual IPI.
 	lockdep_assert_irqs_disabled();
 
-	/* Check for counter underflows */
+	// Check for counter underflows
 	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
 			 "RCU dynticks_nesting counter underflow!");
 	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
 			 "RCU dynticks_nmi_nesting counter underflow/zero!");
 
-	/* Are we at first interrupt nesting level? */
+	// Are we at first interrupt nesting level?
 	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
-	if (nesting > 1)
-		return false;
-
-	/*
-	 * If we're not in an interrupt, we must be in the idle task!
-	 */
+	// If we're not in an interrupt, we must be in the idle task!
 	WARN_ON_ONCE(!nesting && !is_idle_task(current));
+	if (nesting != 1)
+		return false; // Not in irq or in nested irq.
 
-	/* Does CPU appear to be idle from an RCU standpoint? */
+	// Does CPU appear to be idle from an RCU standpoint?
 	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
 }
 
@@ -1058,11 +1053,6 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
 	}
 }
 
-noinstr bool __rcu_is_watching(void)
-{
-	return !rcu_dynticks_curr_cpu_in_eqs();
-}
-
 /**
  * rcu_is_watching - see if RCU thinks that the current CPU is not idle
  *
