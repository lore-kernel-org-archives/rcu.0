Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296487DA64;
	Fri, 16 Aug 2024 04:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781047; cv=none; b=bGAnCoZAxhGj5rrmVw5DKvGCOlb5hQDE9Yute0rGP/a8S+MOyJ1F69k7oF+zIvEUUY/2mWTR7LmHhEqRtSEhokDVUSTKcsU16EJy5ePVDl83wdP+eWHbOlVDNCWvD0Kvg9v9T4I50b0V5MvxE9+YJF0gu8QcM5ai7uwzJVKvdj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781047; c=relaxed/simple;
	bh=EJMjMl2JpJHeHT8KAgtkO4gbK13CfBULyS/uGa67NYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWAv9a4OwrV5ZO/WwyIMBUtDoB3G/674nt0tDRPvu/6YKNLBaGb7Bh/jjFApnID2yMvZd3pQFV2izx3yzOtcSugdTz7TxWuWWFnR6eaU+LWCfOmE9O7mVZQj1e5N89pwBosgzwx6PgMfiMrZKGfi6oGMCpsBIzJfM0m0G8Qqtkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLuE+A8e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLuE+A8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D22C4AF09;
	Fri, 16 Aug 2024 04:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781046;
	bh=EJMjMl2JpJHeHT8KAgtkO4gbK13CfBULyS/uGa67NYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLuE+A8eJoXqHy79K1PA3LnVNoHw+elr5ZISjKMs0nnOh9AusIITfSERECRXqmMtu
	 7h18ib6QrvFyr16lDRncuJ7cyliv8MxmZecdcjjG8tD985ZVZH59uLUiZMfkaLYuXZ
	 s94vy3TaEASy6zfdqZFFO9jSWt8U01fRF1p47ZSPLEt11KeeyLk9DKwXUb8FjHihMa
	 5xP6tRHJoI24dUIFEqr/kBby29ndoH8BTdQeufgUR5ZeXMfE0K9PsV7ZaGMLsxbh1I
	 lQwMO/9jxJtNLnJbLfDMXF0EdCIBUv0WXFUFWEBRa0UPOnfDWFTFSt4KL4E7iguiPa
	 dL4m6wgxsJKMg==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH rcu 06/26] context_tracking, rcu: Rename struct context_tracking .dynticks_nesting into .nesting
Date: Fri, 16 Aug 2024 09:32:21 +0530
Message-Id: <20240816040241.17776-6-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816040030.GA16986@neeraj.linux>
References: <20240816040030.GA16986@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, reflect that change in the related helpers.

[ neeraj.upadhyay: Fix htmldocs build error reported by Stephen Rothwell ]

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 .../RCU/Design/Data-Structures/Data-Structures.rst     | 10 +++++-----
 include/linux/context_tracking_state.h                 |  6 +++---
 include/trace/events/rcu.h                             |  2 +-
 kernel/context_tracking.c                              | 10 +++++-----
 kernel/rcu/tree.c                                      |  8 ++++----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index b34990c7c377..69860bbec202 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -935,7 +935,7 @@ This portion of the rcu_data structure is declared as follows:
 
 ::
 
-     1   long dynticks_nesting;
+     1   long nesting;
      2   long dynticks_nmi_nesting;
      3   atomic_t dynticks;
      4   bool rcu_need_heavy_qs;
@@ -945,7 +945,7 @@ These fields in the rcu_data structure maintain the per-CPU dyntick-idle
 state for the corresponding CPU. The fields may be accessed only from
 the corresponding CPU (and from tracing) unless otherwise stated.
 
-The ``->dynticks_nesting`` field counts the nesting depth of process
+The ``->nesting`` field counts the nesting depth of process
 execution, so that in normal circumstances this counter has value zero
 or one. NMIs, irqs, and tracers are counted by the
 ``->dynticks_nmi_nesting`` field. Because NMIs cannot be masked, changes
@@ -960,9 +960,9 @@ process-level transitions.
 However, it turns out that when running in non-idle kernel context, the
 Linux kernel is fully capable of entering interrupt handlers that never
 exit and perhaps also vice versa. Therefore, whenever the
-``->dynticks_nesting`` field is incremented up from zero, the
+``->nesting`` field is incremented up from zero, the
 ``->dynticks_nmi_nesting`` field is set to a large positive number, and
-whenever the ``->dynticks_nesting`` field is decremented down to zero,
+whenever the ``->nesting`` field is decremented down to zero,
 the ``->dynticks_nmi_nesting`` field is set to zero. Assuming that
 the number of misnested interrupts is not sufficient to overflow the
 counter, this approach corrects the ``->dynticks_nmi_nesting`` field
@@ -992,7 +992,7 @@ code.
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
-| Why not simply combine the ``->dynticks_nesting`` and                 |
+| Why not simply combine the ``->nesting`` and                          |
 | ``->dynticks_nmi_nesting`` counters into a single counter that just   |
 | counts the number of reasons that the corresponding CPU is non-idle?  |
 +-----------------------------------------------------------------------+
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index ad6570ffeff3..65290e7677e6 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -39,7 +39,7 @@ struct context_tracking {
 	atomic_t state;
 #endif
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
-	long dynticks_nesting;		/* Track process nesting level. */
+	long nesting;		/* Track process nesting level. */
 	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
 #endif
 };
@@ -77,14 +77,14 @@ static __always_inline int ct_rcu_watching_cpu_acquire(int cpu)
 
 static __always_inline long ct_dynticks_nesting(void)
 {
-	return __this_cpu_read(context_tracking.dynticks_nesting);
+	return __this_cpu_read(context_tracking.nesting);
 }
 
 static __always_inline long ct_dynticks_nesting_cpu(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
-	return ct->dynticks_nesting;
+	return ct->nesting;
 }
 
 static __always_inline long ct_dynticks_nmi_nesting(void)
diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 31b3e0d3e65f..4066b6d51e46 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -469,7 +469,7 @@ TRACE_EVENT(rcu_stall_warning,
  * polarity: "Start", "End", "StillNonIdle" for entering, exiting or still not
  *            being in dyntick-idle mode.
  * context: "USER" or "IDLE" or "IRQ".
- * NMIs nested in IRQs are inferred with dynticks_nesting > 1 in IRQ context.
+ * NMIs nested in IRQs are inferred with nesting > 1 in IRQ context.
  *
  * These events also take a pair of numbers, which indicate the nesting
  * depth before and after the event of interest, and a third number that is
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 868ae0bcd4be..5cfdfc03b401 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -28,7 +28,7 @@
 
 DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
-	.dynticks_nesting = 1,
+	.nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 #endif
 	.state = ATOMIC_INIT(CT_RCU_WATCHING),
@@ -131,7 +131,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 		     ct_dynticks_nesting() == 0);
 	if (ct_dynticks_nesting() != 1) {
 		// RCU will still be watching, so just do accounting and leave.
-		ct->dynticks_nesting--;
+		ct->nesting--;
 		return;
 	}
 
@@ -145,7 +145,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 	instrument_atomic_write(&ct->state, sizeof(ct->state));
 
 	instrumentation_end();
-	WRITE_ONCE(ct->dynticks_nesting, 0); /* Avoid irq-access tearing. */
+	WRITE_ONCE(ct->nesting, 0); /* Avoid irq-access tearing. */
 	// RCU is watching here ...
 	ct_kernel_exit_state(offset);
 	// ... but is no longer watching here.
@@ -170,7 +170,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
 	if (oldval) {
 		// RCU was already watching, so just do accounting and leave.
-		ct->dynticks_nesting++;
+		ct->nesting++;
 		return;
 	}
 	rcu_dynticks_task_exit();
@@ -184,7 +184,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 
 	trace_rcu_dyntick(TPS("End"), ct_dynticks_nesting(), 1, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
-	WRITE_ONCE(ct->dynticks_nesting, 1);
+	WRITE_ONCE(ct->nesting, 1);
 	WARN_ON_ONCE(ct_dynticks_nmi_nesting());
 	WRITE_ONCE(ct->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
 	instrumentation_end();
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 45a9f3667c2a..0d5a539acd58 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -389,7 +389,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 
 	/* Check for counter underflows */
 	RCU_LOCKDEP_WARN(ct_dynticks_nesting() < 0,
-			 "RCU dynticks_nesting counter underflow!");
+			 "RCU nesting counter underflow!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() <= 0,
 			 "RCU dynticks_nmi_nesting counter underflow/zero!");
 
@@ -597,7 +597,7 @@ void rcu_irq_exit_check_preempt(void)
 	lockdep_assert_irqs_disabled();
 
 	RCU_LOCKDEP_WARN(ct_dynticks_nesting() <= 0,
-			 "RCU dynticks_nesting counter underflow/zero!");
+			 "RCU nesting counter underflow/zero!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() !=
 			 DYNTICK_IRQ_NONIDLE,
 			 "Bad RCU  dynticks_nmi_nesting counter\n");
@@ -4804,7 +4804,7 @@ rcu_boot_init_percpu_data(int cpu)
 	/* Set up local state, ensuring consistent view of global state. */
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
-	WARN_ON_ONCE(ct->dynticks_nesting != 1);
+	WARN_ON_ONCE(ct->nesting != 1);
 	WARN_ON_ONCE(rcu_dynticks_in_eqs(ct_rcu_watching_cpu(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
@@ -4898,7 +4898,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->qlen_last_fqs_check = 0;
 	rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
 	rdp->blimit = blimit;
-	ct->dynticks_nesting = 1;	/* CPU not up, no tearing. */
+	ct->nesting = 1;	/* CPU not up, no tearing. */
 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
 
 	/*
-- 
2.40.1

