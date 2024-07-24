Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A8C15E5C1
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832312; cv=none; b=qqmD+8M6ieY2pcKvDQevRAnKJjOPBD9bn1CQf0mwRJ0QrUkOeqM3N1me2wsuRZoAn941sKg/fvy9OaJ0Y3KHX4jR1MT+VfmVDJPrz39uwQwRpEaoDBvCS49L6Zl+xeaT7txZAyHKnl/YGOID/Gqz/ng6H+H3A5TwhVYcyJxi0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832312; c=relaxed/simple;
	bh=V+TO/2PGIsju3SD2jTxyX+xDMaJDL3RtFuDEQkCgddw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMJzJsrWhncAjxtEBJp1VMRCbyU5Zke7iee+LFVKE3CxNIILfyjuAZ5v5k8+E5CwLTlzlIZn/UORRP4rrLWXF9rzz7buJhmJpSM0wzIa6uu0QLMQEFHF6TVVCUzKadPDJLWg0sEvycuwsjS+yt+WZDnp5ssM3AeKaJYrs2630GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmRw14vb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmRw14vb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5QaER1rI7N2KXE2eK+nVX6ZhEPB3AWcfBIDx4BX8lQ=;
	b=AmRw14vblvhJZWfirU57EJWwrJaQR75Tsgd0yVcbpvwtKjtzBM/qUxzEUN4BIcNf/XfIiF
	LNbfU4yYpJv0trcPkq7Su9bv3puRWF1tDnXAW9lcP2UdNLcnfFb8ptaVPdlSUTkZjEla2q
	MKFiaK7WEgQ8SBOkUTS7KVFws3f007c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-TI7faRB6OgqE_MU8C8Sfzw-1; Wed,
 24 Jul 2024 10:45:05 -0400
X-MC-Unique: TI7faRB6OgqE_MU8C8Sfzw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8C3F1955F49;
	Wed, 24 Jul 2024 14:45:02 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC2081955F3B;
	Wed, 24 Jul 2024 14:44:58 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v3 06/25] context_tracking, rcu: Rename struct context_tracking .dynticks_nesting into .nesting
Date: Wed, 24 Jul 2024 16:43:06 +0200
Message-ID: <20240724144325.3307148-7-vschneid@redhat.com>
In-Reply-To: <20240724144325.3307148-1-vschneid@redhat.com>
References: <20240724144325.3307148-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, reflect that change in the related helpers.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../RCU/Design/Data-Structures/Data-Structures.rst     | 10 +++++-----
 include/linux/context_tracking_state.h                 |  6 +++---
 include/trace/events/rcu.h                             |  2 +-
 kernel/context_tracking.c                              | 10 +++++-----
 kernel/rcu/tree.c                                      |  8 ++++----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index b34990c7c3778..57ffc33d3cce2 100644
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
+| Why not simply combine the ``->nesting`` and                 |
 | ``->dynticks_nmi_nesting`` counters into a single counter that just   |
 | counts the number of reasons that the corresponding CPU is non-idle?  |
 +-----------------------------------------------------------------------+
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index ad6570ffeff3c..65290e7677e6c 100644
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
index 31b3e0d3e65f7..4066b6d51e46a 100644
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
index 868ae0bcd4bed..5cfdfc03b4018 100644
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
index 273d223bd8efc..16007911c7890 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -381,7 +381,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 
 	/* Check for counter underflows */
 	RCU_LOCKDEP_WARN(ct_dynticks_nesting() < 0,
-			 "RCU dynticks_nesting counter underflow!");
+			 "RCU nesting counter underflow!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() <= 0,
 			 "RCU dynticks_nmi_nesting counter underflow/zero!");
 
@@ -589,7 +589,7 @@ void rcu_irq_exit_check_preempt(void)
 	lockdep_assert_irqs_disabled();
 
 	RCU_LOCKDEP_WARN(ct_dynticks_nesting() <= 0,
-			 "RCU dynticks_nesting counter underflow/zero!");
+			 "RCU nesting counter underflow/zero!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() !=
 			 DYNTICK_IRQ_NONIDLE,
 			 "Bad RCU  dynticks_nmi_nesting counter\n");
@@ -4792,7 +4792,7 @@ rcu_boot_init_percpu_data(int cpu)
 	/* Set up local state, ensuring consistent view of global state. */
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
-	WARN_ON_ONCE(ct->dynticks_nesting != 1);
+	WARN_ON_ONCE(ct->nesting != 1);
 	WARN_ON_ONCE(rcu_dynticks_in_eqs(ct_rcu_watching_cpu(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
@@ -4886,7 +4886,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->qlen_last_fqs_check = 0;
 	rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
 	rdp->blimit = blimit;
-	ct->dynticks_nesting = 1;	/* CPU not up, no tearing. */
+	ct->nesting = 1;	/* CPU not up, no tearing. */
 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
 
 	/*
-- 
2.43.0

