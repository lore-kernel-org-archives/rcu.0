Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEED15B0F4
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832329; cv=none; b=Hw61RI2n9SFIQTLjSuDNwM2blULRcT260qyLgWZCiWxeZoZjxYeJIBekRoUushlBKVXBXQJTHYZS8u1pz0s/I2bpfnjA/e2UAp+97vLOghAbq2x7lQGwXdTBaHGUDzhK0pWkb7IRjGjknZN1wQvSH/0jQmLu11Vori96vp5x27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832329; c=relaxed/simple;
	bh=BWZheEWVQzHreiLwIFEMWuhQioM7tIgoKULUv7lhDw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hjlee12Wi2MUNERRA2bB4w4pgrqFC5KCpr6UqlW31lMeen2cU8N+TVmh2Oy5JcvSwtIbjod1Pl1+hKjilLNGuxepD3k1DhKNzpAsH+s2Aolv08zMrSMFazlTt5sIrl71UxBr+zdUc+ouxAEFBAfZBgH119imT6J3GEDJjnm0EJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXU68SYq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXU68SYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWI2N6h73fir2Mzhqluev2TCp24JB1WB8Q+de+9PYY0=;
	b=LXU68SYq59c+8SSO5C5GvlGqonZ5vPonnYCf9qlMaA2hpQJcAGgY1PzKkGCWhd2jSYkuNe
	OR6YpsxHSy8E1MrunBnmRxnk8mj9dQ9iyZtjcE2R26LS1ILHm5gUQwHVkm7IgrliOPWqWZ
	skMIv55y1/M8nTF65zIiLokblJZcPi4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-YoEY9ZXvMPCwY2kUdugafg-1; Wed,
 24 Jul 2024 10:45:22 -0400
X-MC-Unique: YoEY9ZXvMPCwY2kUdugafg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C45D1955D4B;
	Wed, 24 Jul 2024 14:45:16 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FF5B1955F40;
	Wed, 24 Jul 2024 14:45:11 +0000 (UTC)
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
Subject: [PATCH v3 09/25] context_tracking, rcu: Rename struct context_tracking .dynticks_nmi_nesting into .nmi_nesting
Date: Wed, 24 Jul 2024 16:43:09 +0200
Message-ID: <20240724144325.3307148-10-vschneid@redhat.com>
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
RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
meaning.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../Data-Structures/Data-Structures.rst       | 14 ++++-----
 include/linux/context_tracking_state.h        |  6 ++--
 kernel/context_tracking.c                     | 30 +++++++++----------
 kernel/rcu/tree.c                             |  4 +--
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index 57ffc33d3cce2..5389cc49bea13 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -936,7 +936,7 @@ This portion of the rcu_data structure is declared as follows:
 ::
 
      1   long nesting;
-     2   long dynticks_nmi_nesting;
+     2   long nmi_nesting;
      3   atomic_t dynticks;
      4   bool rcu_need_heavy_qs;
      5   bool rcu_urgent_qs;
@@ -948,11 +948,11 @@ the corresponding CPU (and from tracing) unless otherwise stated.
 The ``->nesting`` field counts the nesting depth of process
 execution, so that in normal circumstances this counter has value zero
 or one. NMIs, irqs, and tracers are counted by the
-``->dynticks_nmi_nesting`` field. Because NMIs cannot be masked, changes
+``->nmi_nesting`` field. Because NMIs cannot be masked, changes
 to this variable have to be undertaken carefully using an algorithm
 provided by Andy Lutomirski. The initial transition from idle adds one,
 and nested transitions add two, so that a nesting level of five is
-represented by a ``->dynticks_nmi_nesting`` value of nine. This counter
+represented by a ``->nmi_nesting`` value of nine. This counter
 can therefore be thought of as counting the number of reasons why this
 CPU cannot be permitted to enter dyntick-idle mode, aside from
 process-level transitions.
@@ -961,11 +961,11 @@ However, it turns out that when running in non-idle kernel context, the
 Linux kernel is fully capable of entering interrupt handlers that never
 exit and perhaps also vice versa. Therefore, whenever the
 ``->nesting`` field is incremented up from zero, the
-``->dynticks_nmi_nesting`` field is set to a large positive number, and
+``->nmi_nesting`` field is set to a large positive number, and
 whenever the ``->nesting`` field is decremented down to zero,
-the ``->dynticks_nmi_nesting`` field is set to zero. Assuming that
+the ``->nmi_nesting`` field is set to zero. Assuming that
 the number of misnested interrupts is not sufficient to overflow the
-counter, this approach corrects the ``->dynticks_nmi_nesting`` field
+counter, this approach corrects the ``->nmi_nesting`` field
 every time the corresponding CPU enters the idle loop from process
 context.
 
@@ -993,7 +993,7 @@ code.
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
 | Why not simply combine the ``->nesting`` and                 |
-| ``->dynticks_nmi_nesting`` counters into a single counter that just   |
+| ``->nmi_nesting`` counters into a single counter that just   |
 | counts the number of reasons that the corresponding CPU is non-idle?  |
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index fd42d8120ac29..12d00adf29e1e 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -40,7 +40,7 @@ struct context_tracking {
 #endif
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 	long nesting;		/* Track process nesting level. */
-	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
+	long nmi_nesting;	/* Track irq/NMI nesting level. */
 #endif
 };
 
@@ -89,14 +89,14 @@ static __always_inline long ct_nesting_cpu(int cpu)
 
 static __always_inline long ct_dynticks_nmi_nesting(void)
 {
-	return __this_cpu_read(context_tracking.dynticks_nmi_nesting);
+	return __this_cpu_read(context_tracking.nmi_nesting);
 }
 
 static __always_inline long ct_dynticks_nmi_nesting_cpu(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
-	return ct->dynticks_nmi_nesting;
+	return ct->nmi_nesting;
 }
 #endif /* #ifdef CONFIG_CONTEXT_TRACKING_IDLE */
 
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index a951bde0bbcbb..ae94215aa132a 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -29,7 +29,7 @@
 DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 	.nesting = 1,
-	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
+	.nmi_nesting = DYNTICK_IRQ_NONIDLE,
 #endif
 	.state = ATOMIC_INIT(CT_RCU_WATCHING),
 };
@@ -117,7 +117,7 @@ static noinstr void ct_kernel_enter_state(int offset)
  * Enter an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
  *
- * We crowbar the ->dynticks_nmi_nesting field to zero to allow for
+ * We crowbar the ->nmi_nesting field to zero to allow for
  * the possibility of usermode upcalls having messed up our count
  * of interrupt nesting level during the prior busy period.
  */
@@ -126,7 +126,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
 	WARN_ON_ONCE(ct_dynticks_nmi_nesting() != DYNTICK_IRQ_NONIDLE);
-	WRITE_ONCE(ct->dynticks_nmi_nesting, 0);
+	WRITE_ONCE(ct->nmi_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     ct_nesting() == 0);
 	if (ct_nesting() != 1) {
@@ -156,7 +156,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
  * Exit an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
  *
- * We crowbar the ->dynticks_nmi_nesting field to DYNTICK_IRQ_NONIDLE to
+ * We crowbar the ->nmi_nesting field to DYNTICK_IRQ_NONIDLE to
  * allow for the possibility of usermode upcalls messing up our count of
  * interrupt nesting level during the busy period that is just now starting.
  */
@@ -186,7 +186,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(ct->nesting, 1);
 	WARN_ON_ONCE(ct_dynticks_nmi_nesting());
-	WRITE_ONCE(ct->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
+	WRITE_ONCE(ct->nmi_nesting, DYNTICK_IRQ_NONIDLE);
 	instrumentation_end();
 }
 
@@ -194,7 +194,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
  * ct_nmi_exit - inform RCU of exit from NMI context
  *
  * If we are returning from the outermost NMI handler that interrupted an
- * RCU-idle period, update ct->state and ct->dynticks_nmi_nesting
+ * RCU-idle period, update ct->state and ct->nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
@@ -207,7 +207,7 @@ void noinstr ct_nmi_exit(void)
 
 	instrumentation_begin();
 	/*
-	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
+	 * Check for ->nmi_nesting underflow and bad ->dynticks.
 	 * (We are exiting an NMI handler, so RCU better be paying attention
 	 * to us!)
 	 */
@@ -221,7 +221,7 @@ void noinstr ct_nmi_exit(void)
 	if (ct_dynticks_nmi_nesting() != 1) {
 		trace_rcu_dyntick(TPS("--="), ct_dynticks_nmi_nesting(), ct_dynticks_nmi_nesting() - 2,
 				  ct_rcu_watching());
-		WRITE_ONCE(ct->dynticks_nmi_nesting, /* No store tearing. */
+		WRITE_ONCE(ct->nmi_nesting, /* No store tearing. */
 			   ct_dynticks_nmi_nesting() - 2);
 		instrumentation_end();
 		return;
@@ -229,7 +229,7 @@ void noinstr ct_nmi_exit(void)
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
 	trace_rcu_dyntick(TPS("Startirq"), ct_dynticks_nmi_nesting(), 0, ct_rcu_watching());
-	WRITE_ONCE(ct->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
+	WRITE_ONCE(ct->nmi_nesting, 0); /* Avoid store tearing. */
 
 	// instrumentation for the noinstr ct_kernel_exit_state()
 	instrument_atomic_write(&ct->state, sizeof(ct->state));
@@ -247,7 +247,7 @@ void noinstr ct_nmi_exit(void)
  * ct_nmi_enter - inform RCU of entry to NMI context
  *
  * If the CPU was idle from RCU's viewpoint, update ct->state and
- * ct->dynticks_nmi_nesting to let the RCU grace-period handling know
+ * ct->nmi_nesting to let the RCU grace-period handling know
  * that the CPU is active.  This implementation permits nested NMIs, as
  * long as the nesting level does not overflow an int.  (You will probably
  * run out of stack space first.)
@@ -264,10 +264,10 @@ void noinstr ct_nmi_enter(void)
 	WARN_ON_ONCE(ct_dynticks_nmi_nesting() < 0);
 
 	/*
-	 * If idle from RCU viewpoint, atomically increment ->dynticks
-	 * to mark non-idle and increment ->dynticks_nmi_nesting by one.
-	 * Otherwise, increment ->dynticks_nmi_nesting by two.  This means
-	 * if ->dynticks_nmi_nesting is equal to one, we are guaranteed
+	 * If idle from RCU viewpoint, atomically increment CT state
+	 * to mark non-idle and increment ->nmi_nesting by one.
+	 * Otherwise, increment ->nmi_nesting by two.  This means
+	 * if ->nmi_nesting is equal to one, we are guaranteed
 	 * to be in the outermost NMI handler that interrupted an RCU-idle
 	 * period (observation due to Andy Lutomirski).
 	 */
@@ -298,7 +298,7 @@ void noinstr ct_nmi_enter(void)
 			  ct_dynticks_nmi_nesting(),
 			  ct_dynticks_nmi_nesting() + incby, ct_rcu_watching());
 	instrumentation_end();
-	WRITE_ONCE(ct->dynticks_nmi_nesting, /* Prevent store tearing. */
+	WRITE_ONCE(ct->nmi_nesting, /* Prevent store tearing. */
 		   ct_dynticks_nmi_nesting() + incby);
 	barrier();
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 35042ffeca73b..4ccb4bb8df1d3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -383,7 +383,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	RCU_LOCKDEP_WARN(ct_nesting() < 0,
 			 "RCU nesting counter underflow!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() <= 0,
-			 "RCU dynticks_nmi_nesting counter underflow/zero!");
+			 "RCU nmi_nesting counter underflow/zero!");
 
 	/* Are we at first interrupt nesting level? */
 	nesting = ct_dynticks_nmi_nesting();
@@ -592,7 +592,7 @@ void rcu_irq_exit_check_preempt(void)
 			 "RCU nesting counter underflow/zero!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() !=
 			 DYNTICK_IRQ_NONIDLE,
-			 "Bad RCU  dynticks_nmi_nesting counter\n");
+			 "Bad RCU  nmi_nesting counter\n");
 	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
 			 "RCU in extended quiescent state!");
 }
-- 
2.43.0

