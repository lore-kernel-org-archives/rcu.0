Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A6C47259
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D875206A4
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Q2B4aCtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgEDMFX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 08:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728736AbgEDMFW (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 08:05:22 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F40C061A0E
        for <rcu@vger.kernel.org>; Mon,  4 May 2020 05:05:22 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i14so4961238qka.10
        for <rcu@vger.kernel.org>; Mon, 04 May 2020 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ydaOOfsxC1i1hohFCypA/4rum6oeyLPVfobGP4mXwT0=;
        b=Q2B4aCtGTUZ6doa2hBXAQ2FH97i8d5tvTfKaZBmka+JCid0qoiI233NLyMPi513N9W
         F6tHt3uqTiZ2kETNk+H+QgbLDI32RE2UZwXJq3AR+DLP1BJrsafuDuZp04Lf/EKRX+ns
         fTEyVtO76/XIYOthtRLsU9uqKl5YHJxxbeN6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ydaOOfsxC1i1hohFCypA/4rum6oeyLPVfobGP4mXwT0=;
        b=iFFLlixAAGbalMA7Xm5ikyMEtahBQyepcwGFdBEISJ/nKv+zQn/N81c6Q2Ivf0oh8W
         yde/WLeI2TCaWeyHt0R+Ko8RVQrPyePCt45TTeGbelMXyODE6LVoI/8+ZaKBQxjBkSzQ
         Rfc5lCrZHLHWOEVIrVraUmFeve8/ihdZwjlzW/NiVX99sufidffLEKDtuUSB7esYhPY+
         V5qFotVZlyoln6NSoKcEak0XOLz7HKAGqumVBxzbZIvKxnFM4uxQwiCoZWP4NM9V5XK2
         4g6hpGZxWlKLOVvokULbXZElOM8iacj2phF1cjpyLTD+GpyqTLMt++NvCLdFeS7RRzXj
         BrDg==
X-Gm-Message-State: AGi0PubmL5LvxXdo8MbU7atCOK4+iBeTT86k+XNFk5VSoNVU47n0LBiv
        x75kqZ/jSoGnqvPOSgYE9LQsKQ==
X-Google-Smtp-Source: APiQypKCbOx/YjqWJXg3vzHgY/cZ2UaXnUtcB/T5wYm8lZXAzrGcv7V8ax3IiBjAd5BJstTX4wnGVw==
X-Received: by 2002:a37:95c5:: with SMTP id x188mr1123704qkd.119.1588593920974;
        Mon, 04 May 2020 05:05:20 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y50sm6194534qta.56.2020.05.04.05.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:05:20 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
        Petr Mladek <pmladek@suse.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, tglx@linutronix.de, vpillai@digitalocean.com
Subject: [PATCH v3 4/5] rcu/tree: Remove dynticks_nmi_nesting counter
Date:   Mon,  4 May 2020 08:05:04 -0400
Message-Id: <20200504120505.89351-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200504120505.89351-1-joel@joelfernandes.org>
References: <20200504120505.89351-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The dynticks_nmi_nesting counter serves 3 purposes:

      (a) rcu_is_cpu_rrupt_from_idle() needs to be able to detect first
          interrupt nesting level.

      (b) We need to detect half-interrupts till we are sure they're not an
          issue. However, change the comparison to DYNTICK_IRQ_NONIDLE with 0.

      (c) When a quiescent state report is needed from a nohz_full CPU.
          The nesting counter detects we are a first level interrupt.

For (a), we can just use dyntick_nesting == 1 to determine this. Only the
outermost interrupt that interrupted an RCU-idle state can set it to 1.

For (b), this warning condition has not occurred for several kernel
releases.  But we still keep the warning but change it to use
in_irq() instead of the nesting counter. In a later year, we can remove
the warning.

For (c), the nest check is not really necessary since forced_tick would
have been set to true in the outermost interrupt, so the nested/NMI
interrupts will check forced_tick anyway, and bail.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../Data-Structures/Data-Structures.rst       | 31 ++++-------
 Documentation/RCU/stallwarn.rst               |  6 +--
 kernel/rcu/tree.c                             | 54 +++++++------------
 kernel/rcu/tree.h                             |  4 +-
 kernel/rcu/tree_stall.h                       |  4 +-
 5 files changed, 36 insertions(+), 63 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index 4a48e20a46f2b..a5a907f434a1a 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -936,10 +936,9 @@ This portion of the rcu_data structure is declared as follows:
 ::
 
      1   long dynticks_nesting;
-     2   long dynticks_nmi_nesting;
-     3   atomic_t dynticks;
-     4   bool rcu_need_heavy_qs;
-     5   bool rcu_urgent_qs;
+     2   atomic_t dynticks;
+     3   bool rcu_need_heavy_qs;
+     4   bool rcu_urgent_qs;
 
 These fields in the rcu_data structure maintain the per-CPU dyntick-idle
 state for the corresponding CPU. The fields may be accessed only from
@@ -948,26 +947,14 @@ the corresponding CPU (and from tracing) unless otherwise stated.
 The ``->dynticks_nesting`` field counts the nesting depth of process
 execution, so that in normal circumstances this counter has value zero
 or one. NMIs, irqs, and tracers are counted by the
-``->dynticks_nmi_nesting`` field. Because NMIs cannot be masked, changes
+``->dynticks_nesting`` field as well. Because NMIs cannot be masked, changes
 to this variable have to be undertaken carefully using an algorithm
 provided by Andy Lutomirski. The initial transition from idle adds one,
 and nested transitions add two, so that a nesting level of five is
-represented by a ``->dynticks_nmi_nesting`` value of nine. This counter
+represented by a ``->dynticks_nesting`` value of nine. This counter
 can therefore be thought of as counting the number of reasons why this
-CPU cannot be permitted to enter dyntick-idle mode, aside from
-process-level transitions.
-
-However, it turns out that when running in non-idle kernel context, the
-Linux kernel is fully capable of entering interrupt handlers that never
-exit and perhaps also vice versa. Therefore, whenever the
-``->dynticks_nesting`` field is incremented up from zero, the
-``->dynticks_nmi_nesting`` field is set to a large positive number, and
-whenever the ``->dynticks_nesting`` field is decremented down to zero,
-the the ``->dynticks_nmi_nesting`` field is set to zero. Assuming that
-the number of misnested interrupts is not sufficient to overflow the
-counter, this approach corrects the ``->dynticks_nmi_nesting`` field
-every time the corresponding CPU enters the idle loop from process
-context.
+CPU cannot be permitted to enter dyntick-idle mode. It counts both the
+process-level and interrupt transitions.
 
 The ``->dynticks`` field counts the corresponding CPU's transitions to
 and from either dyntick-idle or user mode, so that this counter has an
@@ -1000,7 +987,9 @@ code.
 +-----------------------------------------------------------------------+
 | Because this would fail in the presence of interrupts whose handlers  |
 | never return and of handlers that manage to return from a made-up     |
-| interrupt.                                                            |
+| interrupt. NOTE: The counters have now been combined however          |
+| a temporary warning has been left to make sure this condition never   |
+| occurs.                                                               |
 +-----------------------------------------------------------------------+
 
 Additional fields are present for some special-purpose builds, and are
diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 08bc9aec4606a..d7042d893b167 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -184,8 +184,8 @@ For non-RCU-tasks flavors of RCU, when a CPU detects that it is stalling,
 it will print a message similar to the following::
 
 	INFO: rcu_sched detected stalls on CPUs/tasks:
-	2-...: (3 GPs behind) idle=06c/0/0 softirq=1453/1455 fqs=0
-	16-...: (0 ticks this GP) idle=81c/0/0 softirq=764/764 fqs=0
+	2-...: (3 GPs behind) idle=06c/0 softirq=1453/1455 fqs=0
+	16-...: (0 ticks this GP) idle=81c/0 softirq=764/764 fqs=0
 	(detected by 32, t=2603 jiffies, g=7075, q=625)
 
 This message indicates that CPU 32 detected that CPUs 2 and 16 were both
@@ -236,7 +236,7 @@ an estimate of the total number of RCU callbacks queued across all CPUs
 In kernels with CONFIG_RCU_FAST_NO_HZ, more information is printed
 for each CPU::
 
-	0: (64628 ticks this GP) idle=dd5/3fffffffffffffff/0 softirq=82/543 last_accelerate: a345/d342 dyntick_enabled: 1
+	0: (64628 ticks this GP) idle=dd5/3fffffffffffffff softirq=82/543 last_accelerate: a345/d342 dyntick_enabled: 1
 
 The "last_accelerate:" prints the low-order 16 bits (in hex) of the
 jiffies counter when this CPU last invoked rcu_try_advance_all_cbs()
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d6df8abdcc21f..1c962736b58fa 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -391,15 +391,9 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	/* Check for counter underflows */
 	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
 			 "RCU dynticks_nesting counter underflow!");
-	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
-			 "RCU dynticks_nmi_nesting counter underflow/zero!");
 
-	/* Are we at first interrupt nesting level? */
-	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
-		return false;
-
-	/* Does CPU appear to be idle from an RCU standpoint? */
-	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
+	/* Are we the outermost interrupt that arrived when RCU was idle? */
+	return __this_cpu_read(rcu_data.dynticks_nesting) == 1;
 }
 
 #define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch ... */
@@ -562,8 +556,7 @@ static void rcu_eqs_enter(bool user)
 	 * mean usermode upcalls or idle exit happened from interrupts. Remove
 	 * the warning by 2020.
 	 */
-	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
-		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
+	WARN_ON_ONCE(in_irq());
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     rdp->dynticks_nesting == 0);
@@ -626,9 +619,8 @@ void rcu_user_enter(void)
 
 /*
  * If we are returning from the outermost NMI handler that interrupted an
- * RCU-idle period, update rdp->dynticks and rdp->dynticks_nmi_nesting
- * to let the RCU grace-period handling know that the CPU is back to
- * being RCU-idle.
+ * RCU-idle period, update rdp->dynticks to let the RCU grace-period handling
+ * know that the CPU is back to being RCU-idle.
  *
  * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
@@ -638,16 +630,13 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	/*
-	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
+	 * Check for ->dynticks_nesting underflow and bad ->dynticks.
 	 * (We are exiting an NMI handler, so RCU better be paying attention
 	 * to us!)
 	 */
 	WARN_ON_ONCE(rdp->dynticks_nesting <= 0);
-	WARN_ON_ONCE(rdp->dynticks_nmi_nesting <= 0);
 	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
 
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
-		   rdp->dynticks_nmi_nesting - 1);
 	/*
 	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
 	 * leave it in non-RCU-idle state.
@@ -761,8 +750,7 @@ static void rcu_eqs_exit(bool user)
 	 * mean usermode upcalls or idle exit happened from interrupts. Remove
 	 * the warning by 2020.
 	 */
-	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
-		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
+	WARN_ON_ONCE(in_irq());
 }
 
 /**
@@ -803,14 +791,13 @@ void rcu_user_exit(void)
  * rcu_nmi_enter_common - inform RCU of entry to NMI context
  * @irq: Is this call from rcu_irq_enter?
  *
- * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
- * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
- * that the CPU is active.  This implementation permits nested NMIs, as
- * long as the nesting level does not overflow an int.  (You will probably
- * run out of stack space first.)
+ * If the CPU was idle from RCU's viewpoint, update rdp->dynticks to let the
+ * RCU grace-period handling know that the CPU is active.  This implementation
+ * permits nested NMIs, as long as the nesting level does not overflow a long.
+ * (You will probably run out of stack space first.)
  *
- * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
- * with CONFIG_RCU_EQS_DEBUG=y.
+ * If you add or remove a call to rcu_nmi_enter_common(), be sure to test with
+ * CONFIG_RCU_EQS_DEBUG=y.
  */
 static __always_inline void rcu_nmi_enter_common(bool irq)
 {
@@ -819,15 +806,16 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 
 	/* Complain about underflow. */
 	WARN_ON_ONCE(rdp->dynticks_nesting < 0);
-	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
 
 	/*
 	 * If idle from RCU viewpoint, atomically increment ->dynticks
-	 * to mark non-idle and increment ->dynticks_nmi_nesting by one.
-	 * Otherwise, increment ->dynticks_nmi_nesting by two.  This means
-	 * if ->dynticks_nmi_nesting is equal to one, we are guaranteed
+	 * to mark non-idle and increment ->dynticks_nesting by one.
+	 * Otherwise, increment ->dynticks_nesting by two.  This means
+	 * if ->dynticks_nesting is equal to one, we are guaranteed
 	 * to be in the outermost NMI handler that interrupted an RCU-idle
-	 * period (observation due to Andy Lutomirski).
+	 * period (observation due to Andy Lutomirski). An exception
+	 * is if the interrupt arrived in kernel mode; in this case we would
+	 * be the outermost interrupt but still increment by 2 which is Ok.
 	 */
 	if (rcu_dynticks_curr_cpu_in_eqs()) {
 
@@ -843,7 +831,6 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 
 		incby = 1;
 	} else if (irq && tick_nohz_full_cpu(rdp->cpu) &&
-		   !rdp->dynticks_nmi_nesting &&
 		   READ_ONCE(rdp->rcu_urgent_qs) &&
 		   !READ_ONCE(rdp->rcu_forced_tick)) {
 		// We get here only if we had already exited the extended
@@ -868,9 +855,6 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 
 	WRITE_ONCE(rdp->dynticks_nesting, /* Prevent store tearing. */
 		   rdp->dynticks_nesting + incby);
-
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
-		   rdp->dynticks_nmi_nesting + 1);
 	barrier();
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 43991a40b0849..2803f85d9bd21 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -177,8 +177,8 @@ struct rcu_data {
 
 	/* 3) dynticks interface. */
 	int dynticks_snap;		/* Per-GP tracking for dynticks. */
-	long dynticks_nesting;		/* Track process nesting level. */
-	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
+	long dynticks_nesting;		/* Track dyntick (non-IDLE) nesting
+					 * level for kernel entry and interrupt. */
 	atomic_t dynticks;		/* Even value for idle, else odd. */
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b899883a42478..f8521e9564fc7 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -412,7 +412,7 @@ static void print_cpu_stall_info(int cpu)
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s%s\n",
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld softirq=%u/%u fqs=%ld %s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
 	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
@@ -422,7 +422,7 @@ static void print_cpu_stall_info(int cpu)
 				"!."[!delta],
 	       ticks_value, ticks_title,
 	       rcu_dynticks_snap(rdp) & 0xfff,
-	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
+	       rdp->dynticks_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
 	       fast_no_hz,
-- 
2.26.2.526.g744177e7f7-goog

