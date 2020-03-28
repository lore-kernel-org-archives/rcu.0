Return-Path: <SRS0=Mmc0=5N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD02C2D0ED
	for <rcu@archiver.kernel.org>; Sat, 28 Mar 2020 22:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1F02073E
	for <rcu@archiver.kernel.org>; Sat, 28 Mar 2020 22:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="G1+IStQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgC1WRQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 28 Mar 2020 18:17:16 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40826 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1WRQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 28 Mar 2020 18:17:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id c9so11930632qtw.7
        for <rcu@vger.kernel.org>; Sat, 28 Mar 2020 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m89I4XhrMXLizw8ZILnG2X0aoXzNxs7KCBj8fTGgVG0=;
        b=G1+IStQggXjI1IExHL339T67xP9hQMgtKUmvwEVsaOKYXTFshEZW4xsT6tPXB5sgfi
         UQroQXC9OvEKowh2bl2td2ZnjoTVCag+H+3okkRKdpzxaC9BjhVg4m/ItDaHbNSWbWhv
         fjZdC5KAp1bAM/8J8lJ4C2Wurl0UUWqbipXZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m89I4XhrMXLizw8ZILnG2X0aoXzNxs7KCBj8fTGgVG0=;
        b=lUMO8W0Y100pfIAZmFDcxNsCqDLD2CPucmqTXP+tev8IPCH2Zf8ivEd4J9VxviruCo
         cL4fK9+inoTf21mAh46M35H5HNL7AZDm12q67IXfDZZJrx+c9neVNVbiKMqGKQ+GIUBa
         F6gkhPw4dUUWb1xqqVT4iiK7l1BEMZRvT7FBEcZUohTfRyI4/cBNKxLvnpEdy2f3Sd3l
         ZSlh4CtJPyWCdpaEm/mAYSbguGk6U4k6ff7eo2mGjlyQwNAQgdgHnzvjLLJOW44bbN8p
         5IqYzw3Y4Na9ppB7tgSIHklZ3wE8IeUd15MmGRK0RMVX674O++l7F5xF7tra1t8wGfya
         Owtg==
X-Gm-Message-State: ANhLgQ1NLXkMHJrQmUATHLm2b+c2wo9swDKrEpuzLzIG/AHGmIQ8UWIx
        zUIswQToDife4vkCVaQCTyPTyQ==
X-Google-Smtp-Source: ADFU+vsPSRyu1XtLGSGS67LBA3PD0Li1lLO/bidutdcxtWOrsKjzfP/g4nyiVBpfvWvmtJ84tQCHEA==
X-Received: by 2002:ac8:5291:: with SMTP id s17mr5514483qtn.156.1585433834946;
        Sat, 28 Mar 2020 15:17:14 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k66sm6742950qke.10.2020.03.28.15.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 15:17:14 -0700 (PDT)
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
Subject: [PATCH v2 4/4] rcu/tree: Remove dynticks_nmi_nesting counter
Date:   Sat, 28 Mar 2020 18:17:03 -0400
Message-Id: <20200328221703.48171-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200328221703.48171-1-joel@joelfernandes.org>
References: <20200328221703.48171-1-joel@joelfernandes.org>
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
 .../Data-Structures/Data-Structures.rst       | 31 ++++------
 Documentation/RCU/stallwarn.txt               |  6 +-
 kernel/rcu/tree.c                             | 56 +++++++------------
 kernel/rcu/tree.h                             |  4 +-
 kernel/rcu/tree_stall.h                       |  4 +-
 5 files changed, 37 insertions(+), 64 deletions(-)

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
diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
index a360a8796710a..a8c068d82373e 100644
--- a/Documentation/RCU/stallwarn.txt
+++ b/Documentation/RCU/stallwarn.txt
@@ -173,8 +173,8 @@ For non-RCU-tasks flavors of RCU, when a CPU detects that it is stalling,
 it will print a message similar to the following:
 
 	INFO: rcu_sched detected stalls on CPUs/tasks:
-	2-...: (3 GPs behind) idle=06c/0/0 softirq=1453/1455 fqs=0
-	16-...: (0 ticks this GP) idle=81c/0/0 softirq=764/764 fqs=0
+	2-...: (3 GPs behind) idle=06c/0 softirq=1453/1455 fqs=0
+	16-...: (0 ticks this GP) idle=81c/0 softirq=764/764 fqs=0
 	(detected by 32, t=2603 jiffies, g=7075, q=625)
 
 This message indicates that CPU 32 detected that CPUs 2 and 16 were both
@@ -225,7 +225,7 @@ an estimate of the total number of RCU callbacks queued across all CPUs
 In kernels with CONFIG_RCU_FAST_NO_HZ, more information is printed
 for each CPU:
 
-	0: (64628 ticks this GP) idle=dd5/3fffffffffffffff/0 softirq=82/543 last_accelerate: a345/d342 dyntick_enabled: 1
+	0: (64628 ticks this GP) idle=dd5/3fffffffffffffff softirq=82/543 last_accelerate: a345/d342 dyntick_enabled: 1
 
 The "last_accelerate:" prints the low-order 16 bits (in hex) of the
 jiffies counter when this CPU last invoked rcu_try_advance_all_cbs()
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f1c7cbad97d09..36222fed2f512 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -347,15 +347,9 @@ static int rcu_is_cpu_rrupt_from_idle(void)
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
@@ -513,8 +507,7 @@ static void rcu_eqs_enter(bool user)
 	 * mean usermode upcalls or idle exit happened from interrupts. Remove
 	 * the warning by 2020.
 	 */
-	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
-		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
+	WARN_ON_ONCE(in_irq());
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     rdp->dynticks_nesting == 0);
@@ -574,9 +567,8 @@ void rcu_user_enter(void)
 
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
@@ -586,16 +578,13 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
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
@@ -704,8 +693,7 @@ static void rcu_eqs_exit(bool user)
 	 * mean usermode upcalls or idle exit happened from interrupts. Remove
 	 * the warning by 2020.
 	 */
-	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
-		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
+	WARN_ON_ONCE(in_irq());
 }
 
 /**
@@ -746,14 +734,13 @@ void rcu_user_exit(void)
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
@@ -762,15 +749,16 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 
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
 
@@ -784,8 +772,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 
 		incby = 1;
 	} else if (tick_nohz_full_cpu(rdp->cpu) &&
-		   !rdp->dynticks_nmi_nesting && READ_ONCE(rdp->rcu_urgent_qs)
-		   && !rdp->rcu_forced_tick) {
+		   READ_ONCE(rdp->rcu_urgent_qs) && !rdp->rcu_forced_tick) {
 		raw_spin_lock_rcu_node(rdp->mynode);
 		// Recheck under lock.
 		if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
@@ -801,9 +788,6 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 
 	WRITE_ONCE(rdp->dynticks_nesting, /* Prevent store tearing. */
 		   rdp->dynticks_nesting + incby);
-
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
-		   rdp->dynticks_nmi_nesting + 1);
 	barrier();
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 0c87e4c161c2f..b2e611ef6d43b 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -175,8 +175,8 @@ struct rcu_data {
 
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
index 55f9b84790d3f..f0f179f21cb2d 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -333,7 +333,7 @@ static void print_cpu_stall_info(int cpu)
 	}
 	print_cpu_stall_fast_no_hz(fast_no_hz, cpu);
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld softirq=%u/%u fqs=%ld %s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
 	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
@@ -343,7 +343,7 @@ static void print_cpu_stall_info(int cpu)
 				"!."[!delta],
 	       ticks_value, ticks_title,
 	       rcu_dynticks_snap(rdp) & 0xfff,
-	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
+	       rdp->dynticks_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       READ_ONCE(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
 	       fast_no_hz);
-- 
2.26.0.rc2.310.g2932bb562d-goog

