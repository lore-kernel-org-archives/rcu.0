Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ECA360;
	Sun, 30 Mar 2025 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743372662; cv=none; b=JXR7nXoDTN6HqKqcaWoWmvTxr6Mduf+uqaWSOsUWz+8nUsxhjrEOkny4V0b5hSacEdnR1fs4UaVLwsWSjlMWXU6+gGWP02oqXXY8UgbGyWJVyyhkB94enRRKSb5NymEPkGj5KE8ExgMifAtpdsBV5ZP+6cfK9wICxTBVCM3cIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743372662; c=relaxed/simple;
	bh=a3GEEyor9irMs8gac907eILMz78C90l/ixp99SJ1ybE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrM/v7t+vu4qB/WZwUy1+YQ5sS3g1ZO5sEDQAEb9ioHzuU57jG9eOlD8/XeVFm0CKUAlUmcAWB/kjaSJrw7omiYN1VepaQMNDBpYIym5C4vxKoXCd876gOJNaqM6Bkyoi6zb8TvpiomCRppIcVOEb1qXESC3yi5hjnLLN4w4WXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8G/Bdjr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8G/Bdjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88102C4CEDD;
	Sun, 30 Mar 2025 22:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743372662;
	bh=a3GEEyor9irMs8gac907eILMz78C90l/ixp99SJ1ybE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8G/BdjrGZLk8C2NHya3kPqvcdTiKH3qShDLbbFhSfhUh4YahS4OE/qiDkC4o0Ee2
	 xAqCPWrXioMovkYB/JyZaPiPXuZJOwj1fibGmJep/O6ehjI/Gz8U7DKX6WW7hW1P57
	 ZpRlFh+WUSfHR0d8h7ah6eyrmAEbh5V1XuxzrrkKt+ffoY2euS/c4BUcaPKhAfdu5p
	 vrNh2B/CgJnZAPVBrqaRxTfMCSQzsZgh8Cai5+qmP6+mWfsVxYKWxOc9ACE9dZ6oL6
	 FmNxnwNNVVj6ArNZGcnl/oKLdhncwwZm9+tbF2uMcVg7/BChInInaMtg3GLsQCc987
	 k6oavt4Kn1xHQ==
Date: Mon, 31 Mar 2025 00:10:58 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/3] rcu: Replace magic number with meaningful constant
 in rcu_seq_done_exact()
Message-ID: <Z-nBcg9FJqu5RzME@pavilion.home>
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
 <20250324170156.469763-2-joelagnelf@nvidia.com>
 <eeda52c2-5397-4aad-ad01-ca04e5b0b80f@paulmck-laptop>
 <DDDD275D-1017-4189-9A8A-578021A33B4A@nvidia.com>
 <e47e5611-36de-4d12-9c07-57aa2a885299@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e47e5611-36de-4d12-9c07-57aa2a885299@paulmck-laptop>

Le Thu, Mar 27, 2025 at 10:09:48AM -0700, Paul E. McKenney a écrit :
> On Wed, Mar 26, 2025 at 10:42:52PM +0000, Joel Fernandes wrote:
> > 
> > 
> > > On Mar 26, 2025, at 6:33 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > ﻿On Mon, Mar 24, 2025 at 01:01:53PM -0400, Joel Fernandes wrote:
> > >> The rcu_seq_done_exact() function checks if a grace period has completed by
> > >> comparing sequence numbers. It includes a guard band to handle sequence number
> > >> wraparound, which was previously expressed using the magic number calculation
> > >> '3 * RCU_SEQ_STATE_MASK + 1'.
> > >> 
> > >> This magic number is not immediately obvious in terms of what it represents.
> > >> 
> > >> Instead, the reason we need this tiny guardband is because of the lag between
> > >> the setting of rcu_state.gp_seq_polled and root rnp's gp_seq in rcu_gp_init().
> > >> 
> > >> This guardband needs to be at least 2 GPs worth of counts, to avoid recognizing
> > >> the newly started GP as completed immediately, due to the following sequence
> > >> which arises due to the delay between update of rcu_state.gp_seq_polled and
> > >> root rnp's gp_seq:
> > >> 
> > >> rnp->gp_seq = rcu_state.gp_seq = 0
> > >> 
> > >>    CPU 0                                           CPU 1
> > >>    -----                                           -----
> > >>    // rcu_state.gp_seq = 1
> > >>    rcu_seq_start(&rcu_state.gp_seq)
> > >>                                                    // snap = 8
> > >>                                                    snap = rcu_seq_snap(&rcu_state.gp_seq)
> > >>                                                    // Two full GP differences
> > >>                                                    rcu_seq_done_exact(&rnp->gp_seq, snap)
> > >>    // rnp->gp_seq = 1
> > >>    WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
> > >> 
> > >> This can happen due to get_state_synchronize_rcu_full() sampling
> > >> rcu_state.gp_seq_polled, however the poll_state_synchronize_rcu_full()
> > >> sampling the root rnp's gp_seq. The delay between the update of the 2
> > >> counters occurs in rcu_gp_init() during which the counters briefly go
> > >> out of sync.
> > >> 
> > >> Make the guardband explictly 2 GPs. This improves code readability and
> > >> maintainability by making the intent clearer as well.
> > >> 
> > >> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> > >> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > 
> > > One concern is that a small error anywhere in the code could cause this
> > > minimal guard band to be too small.  This is not a problem for some
> > > use cases (rcu_barrier() just does an extra operation, and normal grace
> > > periods are protected from forever-idle CPUs by ->gpwrap), but could be
> > > an issue on 32-bit systems for user of polled RCU grace periods.
> > 
> > Could you provide more details of the usecase (sequence of steps) causing an issue for 32 bit polled RCU users? I am not able to see how this patch can affect them.
> > 
> > > 
> > > In contrast, making the guard band a bit longer than it needs to be
> > > has little or no downside.
> > 
> > Making it 3 GP instead of 2 should be ok with me as long as we document it but at least it will not be a magic number based on an equation. I feel we should not put random magic numbers which is more dangerous since it is hard to explain (and hence debug — just my 2 cents).
> 
> Apologies, I was getting ahead of us on this one.
> 
> That third (and maybe also a fourth) grace period becomes important if
> we start getting memory contention on rcu_state.gp_seq, in which case
> we would want the polled grace periods to look at the leaf rcu_node
> structure's gp_seq, which would introduce extra slop.
> 
> For now, for this patch, assuming you guys promise to remember this
> should such memory contention prove problematic:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Taking again a step back on this. This all happens because we have two different
global gp sequence counter, and the two are used on different occasions, even mixed
up together since 85aad7cc4178 ("rcu: Fix get_state_synchronize_rcu_full()
GP-start detection") even though they have different constraints and
reliability.

This can be error prone and confusing.

So I'm unfortunately asking again if it wouldn't be a good idea to have a single
global state counter that lives in the root node so that we don't have it
duplicated in rcu_state.gp_seq.

This involves some special care:

1) As you pointed out, the root can also be the unique leaf. So care must
   be taken that no QS is reported before new online CPUs have been handled
   and QS masks initialized. In order for __note_gp_changes() to handle
   it gracefully we must have two seq states: one to tell the
   grace period has started (before checking new online CPUs): RCU_STATE_STARTED
   and one to tell that grace period is ready to receive quiescent states:
   RCU_STATE_WAIT_QS. Although not strictly required, __note_gp_changes() can
   ignore simple state changes to RCU_STATE_STARTED in order to spare useless
   work and rnp locking. No QS will be reported before ->qsmask are initialized
   in any case.

2) rcu_gp_cleanup() currently ends the grace period top-down through the rnp tree
   and only then on rcu_state. With this change it's simply top-down. I have audited
   rcu_seq_snap() and rcu_start_this_gp() uses and I haven't found an obvious
   issue with that.

The draft below holds 30 minutes of TREE01:

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index feb3ac1dc5d5..c4bb3eb92a58 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -19,6 +19,12 @@
  * The two least significant bits contain the control flags.
  * The most significant bits contain the grace-period sequence counter.
  *
+ * RCU_STATE_STARTED		:	The gp has started but QS are not
+ *					requested yet.
+ *
+ * RCU_STATE_WAIT_QS		:	The gp has started and waits for
+ *					QS to be reported.
+ *
  * When both control flags are zero, no grace period is in progress.
  * When either bit is non-zero, a grace period has started and is in
  * progress. When the grace period completes, the control flags are reset
@@ -54,6 +60,9 @@
  *					grace-period sequence number.
  */
 
+#define RCU_STATE_STARTED	0x1
+#define RCU_STATE_WAIT_QS	0x2
+
 /* Low-order bit definition for polled grace-period APIs. */
 #define RCU_GET_STATE_COMPLETED	0x1
 
@@ -92,7 +101,13 @@ static inline void rcu_seq_start(unsigned long *sp)
 {
 	WRITE_ONCE(*sp, *sp + 1);
 	smp_mb(); /* Ensure update-side operation after counter increment. */
-	WARN_ON_ONCE(rcu_seq_state(*sp) != 1);
+	WARN_ON_ONCE(rcu_seq_state(*sp) != RCU_STATE_STARTED);
+}
+
+static inline void rcu_seq_wait_qs(unsigned long *sp)
+{
+	WRITE_ONCE(*sp, *sp + 1);
+	WARN_ON_ONCE(rcu_seq_state(*sp) != RCU_STATE_WAIT_QS);
 }
 
 /* Compute the end-of-grace-period value for the specified sequence number. */
@@ -135,6 +150,11 @@ static inline unsigned long rcu_seq_current(unsigned long *sp)
 	return READ_ONCE(*sp);
 }
 
+static inline bool rcu_seq_changed(unsigned long old, unsigned long new)
+{
+	return (old & ~RCU_STATE_STARTED) != (new & ~RCU_STATE_STARTED);
+}
+
 /*
  * Given a snapshot from rcu_seq_snap(), determine whether or not the
  * corresponding update-side operation has started.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 475f31deed14..54480ee9599f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -81,9 +81,9 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.gpwrap = true,
 };
 static struct rcu_state rcu_state = {
+	.node[0].gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT,
 	.level = { &rcu_state.node[0] },
 	.gp_state = RCU_GP_IDLE,
-	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT,
 	.barrier_mutex = __MUTEX_INITIALIZER(rcu_state.barrier_mutex),
 	.barrier_lock = __RAW_SPIN_LOCK_UNLOCKED(rcu_state.barrier_lock),
 	.name = RCU_NAME,
@@ -192,6 +192,21 @@ int rcu_get_gp_kthreads_prio(void)
 }
 EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
 
+/*
+ * Return the root node of the rcu_state structure.
+ */
+static struct rcu_node *rcu_get_root(void)
+{
+	return &rcu_state.node[0];
+}
+
+static unsigned long *rcu_root_seq(void)
+{
+	struct rcu_node *root = rcu_get_root();
+
+	return &root->gp_seq;
+}
+
 /*
  * Number of grace periods between delays, normalized by the duration of
  * the delay.  The longer the delay, the more the grace periods between
@@ -210,7 +225,7 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
  */
 static int rcu_gp_in_progress(void)
 {
-	return rcu_seq_state(rcu_seq_current(&rcu_state.gp_seq));
+	return rcu_seq_state(rcu_seq_current(rcu_root_seq()));
 }
 
 /*
@@ -504,7 +519,7 @@ static int rcu_pending(int user);
  */
 unsigned long rcu_get_gp_seq(void)
 {
-	return READ_ONCE(rcu_state.gp_seq);
+	return READ_ONCE(*rcu_root_seq());
 }
 EXPORT_SYMBOL_GPL(rcu_get_gp_seq);
 
@@ -520,21 +535,13 @@ unsigned long rcu_exp_batches_completed(void)
 }
 EXPORT_SYMBOL_GPL(rcu_exp_batches_completed);
 
-/*
- * Return the root node of the rcu_state structure.
- */
-static struct rcu_node *rcu_get_root(void)
-{
-	return &rcu_state.node[0];
-}
-
 /*
  * Send along grace-period-related data for rcutorture diagnostics.
  */
 void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 {
 	*flags = READ_ONCE(rcu_state.gp_flags);
-	*gp_seq = rcu_seq_current(&rcu_state.gp_seq);
+	*gp_seq = rcu_seq_current(rcu_root_seq());
 }
 EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 
@@ -1010,7 +1017,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
-	trace_rcu_grace_period(rcu_state.name, data_race(rcu_state.gp_seq), TPS("newreq"));
+	trace_rcu_grace_period(rcu_state.name, data_race(*rcu_root_seq()), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
@@ -1095,7 +1102,7 @@ static void rcu_gp_kthread_wake(void)
 	    !READ_ONCE(rcu_state.gp_flags) || !t)
 		return;
 	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
-	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
+	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(*rcu_root_seq()));
 	swake_up_one_online(&rcu_state.gp_wq);
 }
 
@@ -1135,7 +1142,7 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * accelerating callback invocation to an earlier grace-period
 	 * number.
 	 */
-	gp_seq_req = rcu_seq_snap(&rcu_state.gp_seq);
+	gp_seq_req = rcu_seq_snap(rcu_root_seq());
 	if (rcu_segcblist_accelerate(&rdp->cblist, gp_seq_req))
 		ret = rcu_start_this_gp(rnp, rdp, gp_seq_req);
 
@@ -1164,7 +1171,7 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 	bool needwake;
 
 	rcu_lockdep_assert_cblist_protected(rdp);
-	c = rcu_seq_snap(&rcu_state.gp_seq);
+	c = rcu_seq_snap(rcu_root_seq());
 	if (!READ_ONCE(rdp->gpwrap) && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
 		/* Old request still live, so mark recent callbacks. */
 		(void)rcu_segcblist_accelerate(&rdp->cblist, c);
@@ -1249,7 +1256,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
-	if (rdp->gp_seq == rnp->gp_seq)
+	if (!rcu_seq_changed(rdp->gp_seq, rnp->gp_seq))
 		return false; /* Nothing to do. */
 
 	/* Handle the ends of any preceding grace periods first. */
@@ -1298,7 +1305,7 @@ static void note_gp_changes(struct rcu_data *rdp)
 
 	local_irq_save(flags);
 	rnp = rdp->mynode;
-	if ((rdp->gp_seq == rcu_seq_current(&rnp->gp_seq) &&
+	if ((!rcu_seq_changed(rdp->gp_seq, rcu_seq_current(&rnp->gp_seq)) &&
 	     !unlikely(READ_ONCE(rdp->gpwrap))) || /* w/out lock. */
 	    !raw_spin_trylock_rcu_node(rnp)) { /* irqs already off, so later. */
 		local_irq_restore(flags);
@@ -1341,7 +1348,7 @@ static bool rcu_gp_slow_is_suppressed(void)
 static void rcu_gp_slow(int delay)
 {
 	if (!rcu_gp_slow_is_suppressed() && delay > 0 &&
-	    !(rcu_seq_ctr(rcu_state.gp_seq) % (rcu_num_nodes * PER_RCU_NODE_PERIOD * delay)))
+	    !(rcu_seq_ctr(*rcu_root_seq()) % (rcu_num_nodes * PER_RCU_NODE_PERIOD * delay)))
 		schedule_timeout_idle(delay);
 }
 
@@ -1802,10 +1809,9 @@ static noinline_for_stack bool rcu_gp_init(void)
 	/* Advance to a new grace period and initialize state. */
 	record_gp_stall_check_time();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
-	rcu_seq_start(&rcu_state.gp_seq);
-	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
+	rcu_seq_start(rcu_root_seq());
 	start_new_poll = rcu_sr_normal_gp_init();
-	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
+	trace_rcu_grace_period(rcu_state.name, *rcu_root_seq(), TPS("start"));
 	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
 	raw_spin_unlock_irq_rcu_node(rnp);
 
@@ -1902,7 +1908,10 @@ static noinline_for_stack bool rcu_gp_init(void)
 		rdp = this_cpu_ptr(&rcu_data);
 		rcu_preempt_check_blocked_tasks(rnp);
 		rnp->qsmask = rnp->qsmaskinit;
-		WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
+		if (!rnp->parent)
+			rcu_seq_wait_qs(&rnp->gp_seq);
+		else
+			WRITE_ONCE(rnp->gp_seq, *rcu_root_seq());
 		if (rnp == rdp->mynode)
 			(void)__note_gp_changes(rnp, rdp);
 		rcu_preempt_boost_start_gp(rnp);
@@ -2018,7 +2027,7 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
 			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
 				   jiffies + (j ? 3 * j : 2));
 		}
-		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+		trace_rcu_grace_period(rcu_state.name, *rcu_root_seq(),
 				       TPS("fqswait"));
 		WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_FQS);
 		(void)swait_event_idle_timeout_exclusive(rcu_state.gp_wq,
@@ -2041,7 +2050,7 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
 		/* If time for quiescent-state forcing, do it. */
 		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
 		    (gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, *rcu_root_seq(),
 					       TPS("fqsstart"));
 			rcu_gp_fqs(first_gp_fqs);
 			gf = 0;
@@ -2049,7 +2058,7 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
 				first_gp_fqs = false;
 				gf = rcu_state.cbovld ? RCU_GP_FLAG_OVLD : 0;
 			}
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, *rcu_root_seq(),
 					       TPS("fqsend"));
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
@@ -2060,7 +2069,7 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
 			WARN_ON(signal_pending(current));
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, *rcu_root_seq(),
 					       TPS("fqswaitsig"));
 			ret = 1; /* Keep old FQS timing. */
 			j = jiffies;
@@ -2081,7 +2090,6 @@ static noinline void rcu_gp_cleanup(void)
 	int cpu;
 	bool needgp = false;
 	unsigned long gp_duration;
-	unsigned long new_gp_seq;
 	bool offloaded;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root();
@@ -2103,6 +2111,8 @@ static noinline void rcu_gp_cleanup(void)
 	 * period as completed in all of the rcu_node structures.
 	 */
 	rcu_poll_gp_seq_end(&rcu_state.gp_seq_polled_snap);
+	rcu_seq_end(rcu_root_seq());
+	smp_mb(); // Order against failing poll_state_synchronize_rcu_full().
 	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
@@ -2114,16 +2124,12 @@ static noinline void rcu_gp_cleanup(void)
 	 * the rcu_node structures before the beginning of the next grace
 	 * period is recorded in any of the rcu_node structures.
 	 */
-	new_gp_seq = rcu_state.gp_seq;
-	rcu_seq_end(&new_gp_seq);
 	rcu_for_each_node_breadth_first(rnp) {
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
 			dump_blkd_tasks(rnp, 10);
 		WARN_ON_ONCE(rnp->qsmask);
-		WRITE_ONCE(rnp->gp_seq, new_gp_seq);
-		if (!rnp->parent)
-			smp_mb(); // Order against failing poll_state_synchronize_rcu_full().
+		WRITE_ONCE(rnp->gp_seq, *rcu_root_seq());
 		rdp = this_cpu_ptr(&rcu_data);
 		if (rnp == rdp->mynode)
 			needgp = __note_gp_changes(rnp, rdp) || needgp;
@@ -2146,9 +2152,7 @@ static noinline void rcu_gp_cleanup(void)
 	raw_spin_lock_irq_rcu_node(rnp); /* GP before ->gp_seq update. */
 
 	/* Declare grace period done, trace first to use old GP number. */
-	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
-	rcu_seq_end(&rcu_state.gp_seq);
-	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
+	trace_rcu_grace_period(rcu_state.name, *rcu_root_seq(), TPS("end"));
 	WRITE_ONCE(rcu_state.gp_state, RCU_GP_IDLE);
 	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(&rcu_data);
@@ -2173,7 +2177,7 @@ static noinline void rcu_gp_cleanup(void)
 
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
 		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
-		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("newreq"));
+		trace_rcu_grace_period(rcu_state.name, *rcu_root_seq(), TPS("newreq"));
 	} else {
 
 		// We get here either if there is no need for an
@@ -2204,7 +2208,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
 
 		/* Handle grace-period start. */
 		for (;;) {
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, *rcu_root_seq(),
 					       TPS("reqwait"));
 			WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_GPS);
 			swait_event_idle_exclusive(rcu_state.gp_wq,
@@ -2218,7 +2222,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
 			WARN_ON(signal_pending(current));
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, *rcu_root_seq(),
 					       TPS("reqwaitsig"));
 		}
 
@@ -3299,9 +3303,10 @@ void synchronize_rcu(void)
 	// these counters.
 	local_irq_save(flags);
 	WARN_ON_ONCE(num_online_cpus() > 1);
-	rcu_state.gp_seq += (1 << RCU_SEQ_CTR_SHIFT);
+	rnp = rcu_get_root();
+	rnp->gp_seq += (1 << RCU_SEQ_CTR_SHIFT);
 	for (rnp = this_cpu_ptr(&rcu_data)->mynode; rnp; rnp = rnp->parent)
-		rnp->gp_seq_needed = rnp->gp_seq = rcu_state.gp_seq;
+		rnp->gp_seq_needed = rnp->gp_seq = *rcu_root_seq();
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
@@ -3390,7 +3395,7 @@ static void start_poll_synchronize_rcu_common(void)
 	// get a grace period that no one needed.  These accesses are ordered
 	// by smp_mb(), and we are accessing them in the opposite order
 	// from which they are updated at grace-period start, as required.
-	needwake = rcu_start_this_gp(rnp, rdp, rcu_seq_snap(&rcu_state.gp_seq));
+	needwake = rcu_start_this_gp(rnp, rdp, rcu_seq_snap(rcu_root_seq()));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	if (needwake)
 		rcu_gp_kthread_wake();
@@ -3512,11 +3517,9 @@ EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
  */
 bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
 {
-	struct rcu_node *rnp = rcu_get_root();
-
 	smp_mb(); // Order against root rcu_node structure grace-period cleanup.
 	if (rgosp->rgos_norm == RCU_GET_STATE_COMPLETED ||
-	    rcu_seq_done_exact(&rnp->gp_seq, rgosp->rgos_norm) ||
+	    rcu_seq_done_exact(rcu_root_seq(), rgosp->rgos_norm) ||
 	    rgosp->rgos_exp == RCU_GET_STATE_COMPLETED ||
 	    rcu_seq_done_exact(&rcu_state.expedited_sequence, rgosp->rgos_exp)) {
 		smp_mb(); /* Ensure GP ends before subsequent accesses. */
@@ -4062,9 +4065,9 @@ rcu_boot_init_percpu_data(int cpu)
 	WARN_ON_ONCE(ct->nesting != 1);
 	WARN_ON_ONCE(rcu_watching_snap_in_eqs(ct_rcu_watching_cpu(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
-	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
+	rdp->rcu_ofl_gp_seq = *rcu_root_seq();
 	rdp->rcu_ofl_gp_state = RCU_GP_CLEANED;
-	rdp->rcu_onl_gp_seq = rcu_state.gp_seq;
+	rdp->rcu_onl_gp_seq = *rcu_root_seq();
 	rdp->rcu_onl_gp_state = RCU_GP_CLEANED;
 	rdp->last_sched_clock = jiffies;
 	rdp->cpu = cpu;
@@ -4271,7 +4274,7 @@ void rcutree_report_cpu_starting(unsigned int cpu)
 	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + newcpu); /* ^^^ */
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
-	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
+	rdp->rcu_onl_gp_seq = READ_ONCE(*rcu_root_seq());
 	rdp->rcu_onl_gp_state = READ_ONCE(rcu_state.gp_state);
 
 	/* An incoming CPU should never be blocking a grace period. */
@@ -4322,7 +4325,7 @@ void rcutree_report_cpu_dead(void)
 	mask = rdp->grpmask;
 	arch_spin_lock(&rcu_state.ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
-	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
+	rdp->rcu_ofl_gp_seq = READ_ONCE(*rcu_root_seq());
 	rdp->rcu_ofl_gp_state = READ_ONCE(rcu_state.gp_state);
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
 		/* Report quiescent state -before- changing ->qsmaskinitnext! */
@@ -4534,7 +4537,7 @@ void rcu_scheduler_starting(void)
 	// Fix up the ->gp_seq counters.
 	local_irq_save(flags);
 	rcu_for_each_node_breadth_first(rnp)
-		rnp->gp_seq_needed = rnp->gp_seq = rcu_state.gp_seq;
+		rnp->gp_seq_needed = rnp->gp_seq = *rcu_root_seq();
 	local_irq_restore(flags);
 
 	// Switch out of early boot mode.
@@ -4583,9 +4586,9 @@ static void __init rcu_init_one(void)
 			raw_spin_lock_init(&rnp->fqslock);
 			lockdep_set_class_and_name(&rnp->fqslock,
 						   &rcu_fqs_class[i], fqs[i]);
-			rnp->gp_seq = rcu_state.gp_seq;
-			rnp->gp_seq_needed = rcu_state.gp_seq;
-			rnp->completedqs = rcu_state.gp_seq;
+			rnp->gp_seq = *rcu_root_seq();
+			rnp->gp_seq_needed = *rcu_root_seq();
+			rnp->completedqs = *rcu_root_seq();
 			rnp->qsmask = 0;
 			rnp->qsmaskinit = 0;
 			rnp->grplo = j * cpustride;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a9a811d9d7a3..9d811270b808 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -347,7 +347,6 @@ struct rcu_state {
 
 	/* The following fields are guarded by the root rcu_node's lock. */
 
-	unsigned long gp_seq ____cacheline_internodealigned_in_smp;
 						/* Grace-period sequence #. */
 	unsigned long gp_max;			/* Maximum GP duration in */
 						/*  jiffies. */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 925fcdad5dea..367adb062a6d 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -344,7 +344,7 @@ static void rcu_dump_cpu_stacks(unsigned long gp_seq)
 	rcu_for_each_leaf_node(rnp) {
 		printk_deferred_enter();
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
-			if (gp_seq != data_race(rcu_state.gp_seq)) {
+			if (gp_seq != data_race(*rcu_root_seq())) {
 				printk_deferred_exit();
 				pr_err("INFO: Stall ended during stack backtracing.\n");
 				return;
@@ -474,7 +474,7 @@ static void print_cpu_stall_info(int cpu)
 	 */
 	touch_nmi_watchdog();
 
-	ticks_value = rcu_seq_ctr(rcu_state.gp_seq - rdp->gp_seq);
+	ticks_value = rcu_seq_ctr(*rcu_root_seq() - rdp->gp_seq);
 	if (ticks_value) {
 		ticks_title = "GPs behind";
 	} else {
@@ -518,7 +518,7 @@ static void rcu_check_gp_kthread_starvation(void)
 		cpu = gpk ? task_cpu(gpk) : -1;
 		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#x ->cpu=%d\n",
 		       rcu_state.name, j,
-		       (long)rcu_seq_current(&rcu_state.gp_seq),
+		       (long)rcu_seq_current(rcu_root_seq()),
 		       data_race(READ_ONCE(rcu_state.gp_flags)),
 		       gp_state_getname(rcu_state.gp_state),
 		       data_race(READ_ONCE(rcu_state.gp_state)),
@@ -561,7 +561,7 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 		cpu = task_cpu(gpk);
 		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%#x\n",
 		       rcu_state.name, (jiffies - jiffies_fqs),
-		       (long)rcu_seq_current(&rcu_state.gp_seq),
+		       (long)rcu_seq_current(rcu_root_seq()),
 		       data_race(READ_ONCE(rcu_state.gp_flags)), // Diagnostic read
 		       gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
 		       data_race(READ_ONCE(gpk->__state)));
@@ -613,7 +613,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
 	pr_err("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu ncpus=%d)\n",
 	       smp_processor_id(), (long)(jiffies - gps),
-	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen,
+	       (long)rcu_seq_current(rcu_root_seq()), totqlen,
 	       data_race(rcu_state.n_online_cpus)); // Diagnostic read
 	if (ndetected) {
 		rcu_dump_cpu_stacks(gp_seq);
@@ -622,7 +622,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 		rcu_for_each_leaf_node(rnp)
 			rcu_print_detail_task_stall_rnp(rnp);
 	} else {
-		if (rcu_seq_current(&rcu_state.gp_seq) != gp_seq) {
+		if (rcu_seq_current(rcu_root_seq()) != gp_seq) {
 			pr_err("INFO: Stall ended before state dump start\n");
 		} else {
 			j = jiffies;
@@ -679,7 +679,7 @@ static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
 	pr_err("\t(t=%lu jiffies g=%ld q=%lu ncpus=%d)\n",
 		jiffies - gps,
-		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen,
+		(long)rcu_seq_current(rcu_root_seq()), totqlen,
 		data_race(rcu_state.n_online_cpus)); // Diagnostic read
 
 	rcu_check_gp_kthread_expired_fqs_timer();
@@ -743,28 +743,28 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	/*
 	 * Lots of memory barriers to reject false positives.
 	 *
-	 * The idea is to pick up rcu_state.gp_seq, then
+	 * The idea is to pick up rcu_root_seq(), then
 	 * rcu_state.jiffies_stall, then rcu_state.gp_start, and finally
-	 * another copy of rcu_state.gp_seq.  These values are updated in
+	 * another copy of rcu_root_seq().  These values are updated in
 	 * the opposite order with memory barriers (or equivalent) during
 	 * grace-period initialization and cleanup.  Now, a false positive
 	 * can occur if we get an new value of rcu_state.gp_start and a old
 	 * value of rcu_state.jiffies_stall.  But given the memory barriers,
 	 * the only way that this can happen is if one grace period ends
 	 * and another starts between these two fetches.  This is detected
-	 * by comparing the second fetch of rcu_state.gp_seq with the
-	 * previous fetch from rcu_state.gp_seq.
+	 * by comparing the second fetch of rcu_root_seq() with the
+	 * previous fetch from rcu_root_seq().
 	 *
 	 * Given this check, comparisons of jiffies, rcu_state.jiffies_stall,
 	 * and rcu_state.gp_start suffice to forestall false positives.
 	 */
-	gs1 = READ_ONCE(rcu_state.gp_seq);
+	gs1 = READ_ONCE(*rcu_root_seq());
 	smp_rmb(); /* Pick up ->gp_seq first... */
 	js = READ_ONCE(rcu_state.jiffies_stall);
 	smp_rmb(); /* ...then ->jiffies_stall before the rest... */
 	gps = READ_ONCE(rcu_state.gp_start);
 	smp_rmb(); /* ...and finally ->gp_start before ->gp_seq again. */
-	gs2 = READ_ONCE(rcu_state.gp_seq);
+	gs2 = READ_ONCE(*rcu_root_seq());
 	if (gs1 != gs2 ||
 	    ULONG_CMP_LT(j, js) ||
 	    ULONG_CMP_GE(gps, js) ||
@@ -893,12 +893,12 @@ void show_rcu_gp_kthreads(void)
 		data_race(READ_ONCE(rcu_state.gp_state)),
 		t ? data_race(READ_ONCE(t->__state)) : 0x1ffff, t ? t->rt_priority : 0xffU,
 		js, ja, jr, jw, (long)data_race(READ_ONCE(rcu_state.gp_wake_seq)),
-		(long)data_race(READ_ONCE(rcu_state.gp_seq)),
+		(long)data_race(READ_ONCE(*rcu_root_seq())),
 		(long)data_race(READ_ONCE(rcu_get_root()->gp_seq_needed)),
 		data_race(READ_ONCE(rcu_state.gp_max)),
 		data_race(READ_ONCE(rcu_state.gp_flags)));
 	rcu_for_each_node_breadth_first(rnp) {
-		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq), READ_ONCE(rnp->gp_seq_needed)) &&
+		if (ULONG_CMP_GE(READ_ONCE(*rcu_root_seq()), READ_ONCE(rnp->gp_seq_needed)) &&
 		    !data_race(READ_ONCE(rnp->qsmask)) && !data_race(READ_ONCE(rnp->boost_tasks)) &&
 		    !data_race(READ_ONCE(rnp->exp_tasks)) && !data_race(READ_ONCE(rnp->gp_tasks)))
 			continue;
@@ -917,7 +917,7 @@ void show_rcu_gp_kthreads(void)
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
 			rdp = per_cpu_ptr(&rcu_data, cpu);
 			if (READ_ONCE(rdp->gpwrap) ||
-			    ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
+			    ULONG_CMP_GE(READ_ONCE(*rcu_root_seq()),
 					 READ_ONCE(rdp->gp_seq_needed)))
 				continue;
 			pr_info("\tcpu %d ->gp_seq_needed %ld\n",
