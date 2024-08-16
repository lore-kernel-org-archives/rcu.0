Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D6678B60;
	Fri, 16 Aug 2024 04:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781072; cv=none; b=ahGnXm42+GCHePDNkHn07OeQ+/a5y/l/wRB6IsBSCmQ9SOJUdCPyp/O5RZKqV6x+IlQVph/i/I1830hpd/LqudwDv3eQ6BDOQF0xezJQObCbzbdoiaRbPLxiakUo2doxUh0XOAU3ybVXt9jJLHZSlhmDTFta2B6BcQOcGKroeZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781072; c=relaxed/simple;
	bh=WKrFlGc311b417Ae3nBtrZ9FiooyNB5o0plOQxiWj2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RfF7WT28ubTqwohxrosgK5sBsFozLewiw4f0GqfUEDaCwmESgyPGxuxJwEDUnLbG6KKbxXIU34CA6yncOFWlwkttcLSdYjI3exiMBv30qwDANiJ4g0A1lqGzCvi1W9QjPKC4uvkj+czBHN2/a8Wpz0WEbHQTJBtmRyhCONb1nTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4fuhgTD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4fuhgTD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CABC4AF0B;
	Fri, 16 Aug 2024 04:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781071;
	bh=WKrFlGc311b417Ae3nBtrZ9FiooyNB5o0plOQxiWj2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4fuhgTDHN+mcCtJhvJaeMAEXWSp8pDBuR7x2kaaFP+6OfRrJD5+8wiR0DRopMZuT
	 J6o/l9p/+4Qq3B7qSW2bWTd5ZHtONLrOvEpZHJLrbS1aYkTOpO8OthLC8/PsdJTvgm
	 2hWnu/2sJQwRSiqK7PTfF8PdB7JMyhuV8wrBck/STeS7ZrgZQQ7AtLv+zlRI6cIhMJ
	 SZURHVHE1TGwJMtL9CSuW+p7jaRsEyXrgijdh4mPPuNYP/MVc/0gmZmk/qfSU1cYAT
	 k8LT8BUFT1FcKawfBXCxbXc7x9iyx3pY11JwQ19gq5RcXFE1mB2PwlexU393JMrpxD
	 MyP1EVJeIdQ5Q==
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
Subject: [PATCH rcu 09/26] context_tracking, rcu: Rename struct context_tracking .dynticks_nmi_nesting into .nmi_nesting
Date: Fri, 16 Aug 2024 09:32:24 +0530
Message-Id: <20240816040241.17776-9-neeraj.upadhyay@kernel.org>
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
RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
meaning.

[ neeraj.upadhyay: Fix htmldocs build error reported by Stephen Rothwell ]

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 .../Data-Structures/Data-Structures.rst       | 14 ++++-----
 include/linux/context_tracking_state.h        |  6 ++--
 kernel/context_tracking.c                     | 30 +++++++++----------
 kernel/rcu/tree.c                             |  4 +--
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index 69860bbec202..28d9f9e1783f 100644
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
 | Why not simply combine the ``->nesting`` and                          |
-| ``->dynticks_nmi_nesting`` counters into a single counter that just   |
+| ``->nmi_nesting`` counters into a single counter that just            |
 | counts the number of reasons that the corresponding CPU is non-idle?  |
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index fd42d8120ac2..12d00adf29e1 100644
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
index a951bde0bbcb..ae94215aa132 100644
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
index cf69a234080f..934f6b34a551 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -391,7 +391,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	RCU_LOCKDEP_WARN(ct_nesting() < 0,
 			 "RCU nesting counter underflow!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() <= 0,
-			 "RCU dynticks_nmi_nesting counter underflow/zero!");
+			 "RCU nmi_nesting counter underflow/zero!");
 
 	/* Are we at first interrupt nesting level? */
 	nesting = ct_dynticks_nmi_nesting();
@@ -600,7 +600,7 @@ void rcu_irq_exit_check_preempt(void)
 			 "RCU nesting counter underflow/zero!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() !=
 			 DYNTICK_IRQ_NONIDLE,
-			 "Bad RCU  dynticks_nmi_nesting counter\n");
+			 "Bad RCU  nmi_nesting counter\n");
 	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
 			 "RCU in extended quiescent state!");
 }
-- 
2.40.1

