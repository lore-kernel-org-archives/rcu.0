Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA7A1367
	for <rcu@vger.kernel.org>; Mon, 16 Mar 2026 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773619510; cv=none; b=jOgCn4nK3TcWooWRLmcwNUiVUSoFxdqH0Y93P7nnvs5S0d+VcVu6QIpbd3Ap4tUZ0L1U1+LlaNgLlP5p9WlQXGnY3U26L2Gn7UNsSTgZ+4Cp5nwVrl6E+bcBn2Pug/uvJezggSDDFhCFYw73ED26p1s9lZ+w8aqlCAgZGFxqIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773619510; c=relaxed/simple;
	bh=gEzI1R2hS+KIO4O8FKvuhTQAD05Stfy4dre/mC3omvM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kuZqPK+zPU2C37Tm0n4aCklYFq7BT1Amht8eZcpyni66wkwdcTPSfKhqy2xZW0fFrDjJwxPqY/YOnSIAIAAXlB8W0FfPMFyX/GsJuzXX0CVLrZgBRtgcF+s0jP+Iam/SPdIFE0rzBErV2g8ZxC+J2ZYAaidFCWP+su++aSTv82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoxpH06u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoxpH06u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D039C4CEF7;
	Mon, 16 Mar 2026 00:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773619510;
	bh=gEzI1R2hS+KIO4O8FKvuhTQAD05Stfy4dre/mC3omvM=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=DoxpH06uXxeHwpMoX78gQO8VBMx/UsOnNh5W1lE4a1CiE46M+YmEDEZjv4jtbEYt/
	 QdtGAruuMz1Pe70nzsxFfcRNE0ZV88SHBfNXHOHUQgEVk229uFF2Fpcn1cBu78xoey
	 tDUu5JKtKzzxEGGsCR/DRa5QCo4XDeULIa5xRbIRxWgD+lDNqwZqRAxiAk+nrDGuto
	 1yFtC09U0m2pKGukvll4BVcFZNEuFvpeQzAuRqe82v5k1q5e6rD+Ipx640NOaT9i38
	 KDFhXBtxl+0Tz4CNJ/EO49WpbJX9gwJT5I8KSaG+1GyOkEpHI8h3SbD8Rhc60lg2jx
	 nbEq9tPgXc7rA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CA281CE0ECF; Sun, 15 Mar 2026 17:05:09 -0700 (PDT)
Date: Sun, 15 Mar 2026 17:05:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Possible addition to the v7.0 post-merge-window pile...
Message-ID: <841c8a0b-0f50-4617-98b2-76523e13b910@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I missed the fact that BPF needs to invoke call_srcu() from
preempt-disabled regions of code, which does not play well with SRCU's
non-raw spinlocks.  Kumar Kartikeya Dwivedi (CCed) is testing the patch
shown below, which has a corresponding rcutorture patch that is lower
priority:

7c29d1ce52e5 ("rcutorture: Test call_srcu() with preemption disabled and not")

							Thanx, Paul

------------------------------------------------------------------------

commit b540c63cf6e500e2f81d20b5de6ea11df8b7d22e
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Sat Mar 14 04:12:58 2026 -0700

    srcu: Use raw spinlocks so call_srcu() can be used under preempt_disable()
    
    Tree SRCU has used non-raw spinlocks for many years, motivated by a desire
    to avoid unnecessary real-time latency and the absence of any reason to
    use raw spinlocks.  However, the recent use of SRCU in tracing as the
    underlying implementation of RCU Tasks Trace means that call_srcu()
    is invoked from preemption-disabled regions of code, which in turn
    requires that any locks acquired by call_srcu() or its callees must be
    raw spinlocks.
    
    This commit therefore converts SRCU's spinlocks to raw spinlocks.
    
    Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index ad783d4dd3677..b122c560a59cf 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -34,7 +34,7 @@ struct srcu_data {
 						/* Values: SRCU_READ_FLAVOR_.*  */
 
 	/* Update-side state. */
-	spinlock_t __private lock ____cacheline_internodealigned_in_smp;
+	raw_spinlock_t __private lock ____cacheline_internodealigned_in_smp;
 	struct rcu_segcblist srcu_cblist;	/* List of callbacks.*/
 	unsigned long srcu_gp_seq_needed;	/* Furthest future GP needed. */
 	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
@@ -55,7 +55,7 @@ struct srcu_data {
  * Node in SRCU combining tree, similar in function to rcu_data.
  */
 struct srcu_node {
-	spinlock_t __private lock;
+	raw_spinlock_t __private lock;
 	unsigned long srcu_have_cbs[4];		/* GP seq for children having CBs, but only */
 						/*  if greater than ->srcu_gp_seq. */
 	unsigned long srcu_data_have_cbs[4];	/* Which srcu_data structs have CBs for given GP? */
@@ -74,7 +74,7 @@ struct srcu_usage {
 						/* First node at each level. */
 	int srcu_size_state;			/* Small-to-big transition state. */
 	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
-	spinlock_t __private lock;		/* Protect counters and size state. */
+	raw_spinlock_t __private lock;		/* Protect counters and size state. */
 	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
 	unsigned long srcu_gp_seq;		/* Grace-period seq #. */
 	unsigned long srcu_gp_seq_needed;	/* Latest gp_seq needed. */
@@ -156,7 +156,7 @@ struct srcu_struct {
 
 #define __SRCU_USAGE_INIT(name)									\
 {												\
-	.lock = __SPIN_LOCK_UNLOCKED(name.lock),						\
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(name.lock),						\
 	.srcu_gp_seq = SRCU_GP_SEQ_INITIAL_VAL,							\
 	.srcu_gp_seq_needed = SRCU_GP_SEQ_INITIAL_VAL_WITH_STATE,				\
 	.srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL,					\
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 37e7a8a9e375d..fa6d30ce73d1f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -502,6 +502,15 @@ do {									\
 	___locked;							\
 })
 
+#define raw_spin_trylock_irqsave_rcu_node(p, flags)			\
+({									\
+	bool ___locked = raw_spin_trylock_irqsave(&ACCESS_PRIVATE(p, lock), flags); \
+									\
+	if (___locked)							\
+		smp_mb__after_unlock_lock();				\
+	___locked;							\
+})
+
 #define raw_lockdep_assert_held_rcu_node(p)				\
 	lockdep_assert_held(&ACCESS_PRIVATE(p, lock))
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index aef8e91ad33e4..2328827f8775c 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -77,42 +77,6 @@ static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
 static void process_srcu(struct work_struct *work);
 static void srcu_delay_timer(struct timer_list *t);
 
-/* Wrappers for lock acquisition and release, see raw_spin_lock_rcu_node(). */
-#define spin_lock_rcu_node(p)							\
-do {										\
-	spin_lock(&ACCESS_PRIVATE(p, lock));					\
-	smp_mb__after_unlock_lock();						\
-} while (0)
-
-#define spin_unlock_rcu_node(p) spin_unlock(&ACCESS_PRIVATE(p, lock))
-
-#define spin_lock_irq_rcu_node(p)						\
-do {										\
-	spin_lock_irq(&ACCESS_PRIVATE(p, lock));				\
-	smp_mb__after_unlock_lock();						\
-} while (0)
-
-#define spin_unlock_irq_rcu_node(p)						\
-	spin_unlock_irq(&ACCESS_PRIVATE(p, lock))
-
-#define spin_lock_irqsave_rcu_node(p, flags)					\
-do {										\
-	spin_lock_irqsave(&ACCESS_PRIVATE(p, lock), flags);			\
-	smp_mb__after_unlock_lock();						\
-} while (0)
-
-#define spin_trylock_irqsave_rcu_node(p, flags)					\
-({										\
-	bool ___locked = spin_trylock_irqsave(&ACCESS_PRIVATE(p, lock), flags); \
-										\
-	if (___locked)								\
-		smp_mb__after_unlock_lock();					\
-	___locked;								\
-})
-
-#define spin_unlock_irqrestore_rcu_node(p, flags)				\
-	spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags)			\
-
 /*
  * Initialize SRCU per-CPU data.  Note that statically allocated
  * srcu_struct structures might already have srcu_read_lock() and
@@ -131,7 +95,7 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
 	 */
 	for_each_possible_cpu(cpu) {
 		sdp = per_cpu_ptr(ssp->sda, cpu);
-		spin_lock_init(&ACCESS_PRIVATE(sdp, lock));
+		raw_spin_lock_init(&ACCESS_PRIVATE(sdp, lock));
 		rcu_segcblist_init(&sdp->srcu_cblist);
 		sdp->srcu_cblist_invoking = false;
 		sdp->srcu_gp_seq_needed = ssp->srcu_sup->srcu_gp_seq;
@@ -186,7 +150,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 
 	/* Each pass through this loop initializes one srcu_node structure. */
 	srcu_for_each_node_breadth_first(ssp, snp) {
-		spin_lock_init(&ACCESS_PRIVATE(snp, lock));
+		raw_spin_lock_init(&ACCESS_PRIVATE(snp, lock));
 		BUILD_BUG_ON(ARRAY_SIZE(snp->srcu_have_cbs) !=
 			     ARRAY_SIZE(snp->srcu_data_have_cbs));
 		for (i = 0; i < ARRAY_SIZE(snp->srcu_have_cbs); i++) {
@@ -242,7 +206,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	if (!ssp->srcu_sup)
 		return -ENOMEM;
 	if (!is_static)
-		spin_lock_init(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
+		raw_spin_lock_init(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
 	ssp->srcu_sup->srcu_size_state = SRCU_SIZE_SMALL;
 	ssp->srcu_sup->node = NULL;
 	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
@@ -394,20 +358,20 @@ static void srcu_transition_to_big(struct srcu_struct *ssp)
 	/* Double-checked locking on ->srcu_size-state. */
 	if (smp_load_acquire(&ssp->srcu_sup->srcu_size_state) != SRCU_SIZE_SMALL)
 		return;
-	spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
+	raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
 	if (smp_load_acquire(&ssp->srcu_sup->srcu_size_state) != SRCU_SIZE_SMALL) {
-		spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
+		raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 		return;
 	}
 	__srcu_transition_to_big(ssp);
-	spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
+	raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 }
 
 /*
  * Check to see if the just-encountered contention event justifies
  * a transition to SRCU_SIZE_BIG.
  */
-static void spin_lock_irqsave_check_contention(struct srcu_struct *ssp)
+static void raw_spin_lock_irqsave_check_contention(struct srcu_struct *ssp)
 {
 	unsigned long j;
 
@@ -429,16 +393,16 @@ static void spin_lock_irqsave_check_contention(struct srcu_struct *ssp)
  * to SRCU_SIZE_BIG.  But only if the srcutree.convert_to_big module
  * parameter permits this.
  */
-static void spin_lock_irqsave_sdp_contention(struct srcu_data *sdp, unsigned long *flags)
+static void raw_spin_lock_irqsave_sdp_contention(struct srcu_data *sdp, unsigned long *flags)
 {
 	struct srcu_struct *ssp = sdp->ssp;
 
-	if (spin_trylock_irqsave_rcu_node(sdp, *flags))
+	if (raw_spin_trylock_irqsave_rcu_node(sdp, *flags))
 		return;
-	spin_lock_irqsave_rcu_node(ssp->srcu_sup, *flags);
-	spin_lock_irqsave_check_contention(ssp);
-	spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, *flags);
-	spin_lock_irqsave_rcu_node(sdp, *flags);
+	raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, *flags);
+	raw_spin_lock_irqsave_check_contention(ssp);
+	raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, *flags);
+	raw_spin_lock_irqsave_rcu_node(sdp, *flags);
 }
 
 /*
@@ -447,12 +411,12 @@ static void spin_lock_irqsave_sdp_contention(struct srcu_data *sdp, unsigned lon
  * to SRCU_SIZE_BIG.  But only if the srcutree.convert_to_big module
  * parameter permits this.
  */
-static void spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsigned long *flags)
+static void raw_spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsigned long *flags)
 {
-	if (spin_trylock_irqsave_rcu_node(ssp->srcu_sup, *flags))
+	if (raw_spin_trylock_irqsave_rcu_node(ssp->srcu_sup, *flags))
 		return;
-	spin_lock_irqsave_rcu_node(ssp->srcu_sup, *flags);
-	spin_lock_irqsave_check_contention(ssp);
+	raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, *flags);
+	raw_spin_lock_irqsave_check_contention(ssp);
 }
 
 /*
@@ -470,13 +434,13 @@ static void check_init_srcu_struct(struct srcu_struct *ssp)
 	/* The smp_load_acquire() pairs with the smp_store_release(). */
 	if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed))) /*^^^*/
 		return; /* Already initialized. */
-	spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
+	raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
 	if (!rcu_seq_state(ssp->srcu_sup->srcu_gp_seq_needed)) {
-		spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
+		raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 		return;
 	}
 	init_srcu_struct_fields(ssp, true);
-	spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
+	raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 }
 
 /*
@@ -742,9 +706,9 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 	unsigned long delay;
 	struct srcu_usage *sup = ssp->srcu_sup;
 
-	spin_lock_irq_rcu_node(ssp->srcu_sup);
+	raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
 	delay = srcu_get_delay(ssp);
-	spin_unlock_irq_rcu_node(ssp->srcu_sup);
+	raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	if (WARN_ON(!delay))
 		return; /* Just leak it! */
 	if (WARN_ON(srcu_readers_active(ssp)))
@@ -960,7 +924,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	mutex_lock(&sup->srcu_cb_mutex);
 
 	/* End the current grace period. */
-	spin_lock_irq_rcu_node(sup);
+	raw_spin_lock_irq_rcu_node(sup);
 	idx = rcu_seq_state(sup->srcu_gp_seq);
 	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
 	if (srcu_gp_is_expedited(ssp))
@@ -971,7 +935,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	gpseq = rcu_seq_current(&sup->srcu_gp_seq);
 	if (ULONG_CMP_LT(sup->srcu_gp_seq_needed_exp, gpseq))
 		WRITE_ONCE(sup->srcu_gp_seq_needed_exp, gpseq);
-	spin_unlock_irq_rcu_node(sup);
+	raw_spin_unlock_irq_rcu_node(sup);
 	mutex_unlock(&sup->srcu_gp_mutex);
 	/* A new grace period can start at this point.  But only one. */
 
@@ -983,7 +947,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	} else {
 		idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
 		srcu_for_each_node_breadth_first(ssp, snp) {
-			spin_lock_irq_rcu_node(snp);
+			raw_spin_lock_irq_rcu_node(snp);
 			cbs = false;
 			last_lvl = snp >= sup->level[rcu_num_lvls - 1];
 			if (last_lvl)
@@ -998,7 +962,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 			else
 				mask = snp->srcu_data_have_cbs[idx];
 			snp->srcu_data_have_cbs[idx] = 0;
-			spin_unlock_irq_rcu_node(snp);
+			raw_spin_unlock_irq_rcu_node(snp);
 			if (cbs)
 				srcu_schedule_cbs_snp(ssp, snp, mask, cbdelay);
 		}
@@ -1008,27 +972,27 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	if (!(gpseq & counter_wrap_check))
 		for_each_possible_cpu(cpu) {
 			sdp = per_cpu_ptr(ssp->sda, cpu);
-			spin_lock_irq_rcu_node(sdp);
+			raw_spin_lock_irq_rcu_node(sdp);
 			if (ULONG_CMP_GE(gpseq, sdp->srcu_gp_seq_needed + 100))
 				sdp->srcu_gp_seq_needed = gpseq;
 			if (ULONG_CMP_GE(gpseq, sdp->srcu_gp_seq_needed_exp + 100))
 				sdp->srcu_gp_seq_needed_exp = gpseq;
-			spin_unlock_irq_rcu_node(sdp);
+			raw_spin_unlock_irq_rcu_node(sdp);
 		}
 
 	/* Callback initiation done, allow grace periods after next. */
 	mutex_unlock(&sup->srcu_cb_mutex);
 
 	/* Start a new grace period if needed. */
-	spin_lock_irq_rcu_node(sup);
+	raw_spin_lock_irq_rcu_node(sup);
 	gpseq = rcu_seq_current(&sup->srcu_gp_seq);
 	if (!rcu_seq_state(gpseq) &&
 	    ULONG_CMP_LT(gpseq, sup->srcu_gp_seq_needed)) {
 		srcu_gp_start(ssp);
-		spin_unlock_irq_rcu_node(sup);
+		raw_spin_unlock_irq_rcu_node(sup);
 		srcu_reschedule(ssp, 0);
 	} else {
-		spin_unlock_irq_rcu_node(sup);
+		raw_spin_unlock_irq_rcu_node(sup);
 	}
 
 	/* Transition to big if needed. */
@@ -1059,19 +1023,19 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
 			if (WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, s)) ||
 			    (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s)))
 				return;
-			spin_lock_irqsave_rcu_node(snp, flags);
+			raw_spin_lock_irqsave_rcu_node(snp, flags);
 			sgsne = snp->srcu_gp_seq_needed_exp;
 			if (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s)) {
-				spin_unlock_irqrestore_rcu_node(snp, flags);
+				raw_spin_unlock_irqrestore_rcu_node(snp, flags);
 				return;
 			}
 			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
-			spin_unlock_irqrestore_rcu_node(snp, flags);
+			raw_spin_unlock_irqrestore_rcu_node(snp, flags);
 		}
-	spin_lock_irqsave_ssp_contention(ssp, &flags);
+	raw_spin_lock_irqsave_ssp_contention(ssp, &flags);
 	if (ULONG_CMP_LT(ssp->srcu_sup->srcu_gp_seq_needed_exp, s))
 		WRITE_ONCE(ssp->srcu_sup->srcu_gp_seq_needed_exp, s);
-	spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
+	raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 }
 
 /*
@@ -1109,12 +1073,12 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
 			if (WARN_ON_ONCE(rcu_seq_done(&sup->srcu_gp_seq, s)) && snp != snp_leaf)
 				return; /* GP already done and CBs recorded. */
-			spin_lock_irqsave_rcu_node(snp, flags);
+			raw_spin_lock_irqsave_rcu_node(snp, flags);
 			snp_seq = snp->srcu_have_cbs[idx];
 			if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
 				if (snp == snp_leaf && snp_seq == s)
 					snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
-				spin_unlock_irqrestore_rcu_node(snp, flags);
+				raw_spin_unlock_irqrestore_rcu_node(snp, flags);
 				if (snp == snp_leaf && snp_seq != s) {
 					srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
 					return;
@@ -1129,11 +1093,11 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 			sgsne = snp->srcu_gp_seq_needed_exp;
 			if (!do_norm && (srcu_invl_snp_seq(sgsne) || ULONG_CMP_LT(sgsne, s)))
 				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
-			spin_unlock_irqrestore_rcu_node(snp, flags);
+			raw_spin_unlock_irqrestore_rcu_node(snp, flags);
 		}
 
 	/* Top of tree, must ensure the grace period will be started. */
-	spin_lock_irqsave_ssp_contention(ssp, &flags);
+	raw_spin_lock_irqsave_ssp_contention(ssp, &flags);
 	if (ULONG_CMP_LT(sup->srcu_gp_seq_needed, s)) {
 		/*
 		 * Record need for grace period s.  Pair with load
@@ -1160,7 +1124,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		else if (list_empty(&sup->work.work.entry))
 			list_add(&sup->work.work.entry, &srcu_boot_list);
 	}
-	spin_unlock_irqrestore_rcu_node(sup, flags);
+	raw_spin_unlock_irqrestore_rcu_node(sup, flags);
 }
 
 /*
@@ -1172,9 +1136,9 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 {
 	unsigned long curdelay;
 
-	spin_lock_irq_rcu_node(ssp->srcu_sup);
+	raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
 	curdelay = !srcu_get_delay(ssp);
-	spin_unlock_irq_rcu_node(ssp->srcu_sup);
+	raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
 
 	for (;;) {
 		if (srcu_readers_active_idx_check(ssp, idx))
@@ -1285,12 +1249,12 @@ static bool srcu_should_expedite(struct srcu_struct *ssp)
 		return false;
 	/* If the local srcu_data structure has callbacks, not idle.  */
 	sdp = raw_cpu_ptr(ssp->sda);
-	spin_lock_irqsave_rcu_node(sdp, flags);
+	raw_spin_lock_irqsave_rcu_node(sdp, flags);
 	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
-		spin_unlock_irqrestore_rcu_node(sdp, flags);
+		raw_spin_unlock_irqrestore_rcu_node(sdp, flags);
 		return false; /* Callbacks already present, so not idle. */
 	}
-	spin_unlock_irqrestore_rcu_node(sdp, flags);
+	raw_spin_unlock_irqrestore_rcu_node(sdp, flags);
 
 	/*
 	 * No local callbacks, so probabilistically probe global state.
@@ -1350,7 +1314,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
 	else
 		sdp = raw_cpu_ptr(ssp->sda);
-	spin_lock_irqsave_sdp_contention(sdp, &flags);
+	raw_spin_lock_irqsave_sdp_contention(sdp, &flags);
 	if (rhp)
 		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	/*
@@ -1410,7 +1374,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 		sdp->srcu_gp_seq_needed_exp = s;
 		needexp = true;
 	}
-	spin_unlock_irqrestore_rcu_node(sdp, flags);
+	raw_spin_unlock_irqrestore_rcu_node(sdp, flags);
 
 	/* Ensure that snp node tree is fully initialized before traversing it */
 	if (ss_state < SRCU_SIZE_WAIT_BARRIER)
@@ -1522,7 +1486,7 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
 
 	/*
 	 * Make sure that later code is ordered after the SRCU grace
-	 * period.  This pairs with the spin_lock_irq_rcu_node()
+	 * period.  This pairs with the raw_spin_lock_irq_rcu_node()
 	 * in srcu_invoke_callbacks().  Unlike Tree RCU, this is needed
 	 * because the current CPU might have been totally uninvolved with
 	 * (and thus unordered against) that grace period.
@@ -1701,7 +1665,7 @@ static void srcu_barrier_cb(struct rcu_head *rhp)
  */
 static void srcu_barrier_one_cpu(struct srcu_struct *ssp, struct srcu_data *sdp)
 {
-	spin_lock_irq_rcu_node(sdp);
+	raw_spin_lock_irq_rcu_node(sdp);
 	atomic_inc(&ssp->srcu_sup->srcu_barrier_cpu_cnt);
 	sdp->srcu_barrier_head.func = srcu_barrier_cb;
 	debug_rcu_head_queue(&sdp->srcu_barrier_head);
@@ -1710,7 +1674,7 @@ static void srcu_barrier_one_cpu(struct srcu_struct *ssp, struct srcu_data *sdp)
 		debug_rcu_head_unqueue(&sdp->srcu_barrier_head);
 		atomic_dec(&ssp->srcu_sup->srcu_barrier_cpu_cnt);
 	}
-	spin_unlock_irq_rcu_node(sdp);
+	raw_spin_unlock_irq_rcu_node(sdp);
 }
 
 /**
@@ -1761,7 +1725,7 @@ static void srcu_expedite_current_cb(struct rcu_head *rhp)
 	bool needcb = false;
 	struct srcu_data *sdp = container_of(rhp, struct srcu_data, srcu_ec_head);
 
-	spin_lock_irqsave_sdp_contention(sdp, &flags);
+	raw_spin_lock_irqsave_sdp_contention(sdp, &flags);
 	if (sdp->srcu_ec_state == SRCU_EC_IDLE) {
 		WARN_ON_ONCE(1);
 	} else if (sdp->srcu_ec_state == SRCU_EC_PENDING) {
@@ -1771,7 +1735,7 @@ static void srcu_expedite_current_cb(struct rcu_head *rhp)
 		sdp->srcu_ec_state = SRCU_EC_PENDING;
 		needcb = true;
 	}
-	spin_unlock_irqrestore_rcu_node(sdp, flags);
+	raw_spin_unlock_irqrestore_rcu_node(sdp, flags);
 	// If needed, requeue ourselves as an expedited SRCU callback.
 	if (needcb)
 		__call_srcu(sdp->ssp, &sdp->srcu_ec_head, srcu_expedite_current_cb, false);
@@ -1795,7 +1759,7 @@ void srcu_expedite_current(struct srcu_struct *ssp)
 
 	migrate_disable();
 	sdp = this_cpu_ptr(ssp->sda);
-	spin_lock_irqsave_sdp_contention(sdp, &flags);
+	raw_spin_lock_irqsave_sdp_contention(sdp, &flags);
 	if (sdp->srcu_ec_state == SRCU_EC_IDLE) {
 		sdp->srcu_ec_state = SRCU_EC_PENDING;
 		needcb = true;
@@ -1804,7 +1768,7 @@ void srcu_expedite_current(struct srcu_struct *ssp)
 	} else {
 		WARN_ON_ONCE(sdp->srcu_ec_state != SRCU_EC_REPOST);
 	}
-	spin_unlock_irqrestore_rcu_node(sdp, flags);
+	raw_spin_unlock_irqrestore_rcu_node(sdp, flags);
 	// If needed, queue an expedited SRCU callback.
 	if (needcb)
 		__call_srcu(ssp, &sdp->srcu_ec_head, srcu_expedite_current_cb, false);
@@ -1848,17 +1812,17 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 	 */
 	idx = rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq)); /* ^^^ */
 	if (idx == SRCU_STATE_IDLE) {
-		spin_lock_irq_rcu_node(ssp->srcu_sup);
+		raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
 		if (ULONG_CMP_GE(ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed)) {
 			WARN_ON_ONCE(rcu_seq_state(ssp->srcu_sup->srcu_gp_seq));
-			spin_unlock_irq_rcu_node(ssp->srcu_sup);
+			raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
 			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return;
 		}
 		idx = rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq));
 		if (idx == SRCU_STATE_IDLE)
 			srcu_gp_start(ssp);
-		spin_unlock_irq_rcu_node(ssp->srcu_sup);
+		raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
 		if (idx != SRCU_STATE_IDLE) {
 			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* Someone else started the grace period. */
@@ -1872,10 +1836,10 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 			return; /* readers present, retry later. */
 		}
 		srcu_flip(ssp);
-		spin_lock_irq_rcu_node(ssp->srcu_sup);
+		raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
 		rcu_seq_set_state(&ssp->srcu_sup->srcu_gp_seq, SRCU_STATE_SCAN2);
 		ssp->srcu_sup->srcu_n_exp_nodelay = 0;
-		spin_unlock_irq_rcu_node(ssp->srcu_sup);
+		raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	}
 
 	if (rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
@@ -1913,7 +1877,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 
 	ssp = sdp->ssp;
 	rcu_cblist_init(&ready_cbs);
-	spin_lock_irq_rcu_node(sdp);
+	raw_spin_lock_irq_rcu_node(sdp);
 	WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
@@ -1924,7 +1888,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	 */
 	if (sdp->srcu_cblist_invoking ||
 	    !rcu_segcblist_ready_cbs(&sdp->srcu_cblist)) {
-		spin_unlock_irq_rcu_node(sdp);
+		raw_spin_unlock_irq_rcu_node(sdp);
 		return;  /* Someone else on the job or nothing to do. */
 	}
 
@@ -1932,7 +1896,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	sdp->srcu_cblist_invoking = true;
 	rcu_segcblist_extract_done_cbs(&sdp->srcu_cblist, &ready_cbs);
 	len = ready_cbs.len;
-	spin_unlock_irq_rcu_node(sdp);
+	raw_spin_unlock_irq_rcu_node(sdp);
 	rhp = rcu_cblist_dequeue(&ready_cbs);
 	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
 		debug_rcu_head_unqueue(rhp);
@@ -1947,11 +1911,11 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	 * Update counts, accelerate new callbacks, and if needed,
 	 * schedule another round of callback invocation.
 	 */
-	spin_lock_irq_rcu_node(sdp);
+	raw_spin_lock_irq_rcu_node(sdp);
 	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
 	sdp->srcu_cblist_invoking = false;
 	more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
-	spin_unlock_irq_rcu_node(sdp);
+	raw_spin_unlock_irq_rcu_node(sdp);
 	/* An SRCU barrier or callbacks from previous nesting work pending */
 	if (more)
 		srcu_schedule_cbs_sdp(sdp, 0);
@@ -1965,7 +1929,7 @@ static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay)
 {
 	bool pushgp = true;
 
-	spin_lock_irq_rcu_node(ssp->srcu_sup);
+	raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
 	if (ULONG_CMP_GE(ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed)) {
 		if (!WARN_ON_ONCE(rcu_seq_state(ssp->srcu_sup->srcu_gp_seq))) {
 			/* All requests fulfilled, time to go idle. */
@@ -1975,7 +1939,7 @@ static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay)
 		/* Outstanding request and no GP.  Start one. */
 		srcu_gp_start(ssp);
 	}
-	spin_unlock_irq_rcu_node(ssp->srcu_sup);
+	raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
 
 	if (pushgp)
 		queue_delayed_work(rcu_gp_wq, &ssp->srcu_sup->work, delay);
@@ -1995,9 +1959,9 @@ static void process_srcu(struct work_struct *work)
 	ssp = sup->srcu_ssp;
 
 	srcu_advance_state(ssp);
-	spin_lock_irq_rcu_node(ssp->srcu_sup);
+	raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
 	curdelay = srcu_get_delay(ssp);
-	spin_unlock_irq_rcu_node(ssp->srcu_sup);
+	raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	if (curdelay) {
 		WRITE_ONCE(sup->reschedule_count, 0);
 	} else {
