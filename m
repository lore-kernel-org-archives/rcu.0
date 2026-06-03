Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1515B33DEC2;
	Wed,  3 Jun 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495660; cv=none; b=kUV7uqGV7vleHBdxFjmOn/LAc2FnVq6q+SdZNA1HGsKifM/uYjdmQ41yBGgjQ/IjxzAME6f+TG+lPRNj8F7AQSrNHshdXbH83hNQ5A21j3T180blvvh1a4p7eGnyNbuSfComWmKKR8cIPrj21eQ2GjqCJGhPeXGxFmefkDfL158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495660; c=relaxed/simple;
	bh=TuvxhvQ6qT8PZk9QcqTmdR8hy9Bp8XJxh5W+vu3dD2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqNRHBn6OGpWl5h8t3yiEj1ednV+z5EJmJwELK6ZOrUQ8iRxAYkMLD3NYbvhKzK+lxOjCHkWKf7Xw/f1Q5QmoPmgVUx8fub6o+Uo2DYP2ZatKMCgLpe6m188AVYP4XrIgIuaaVaUqFa9KBNQ3zTqpfl/M89Y9IcNrDDFRV+xIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djZwibFV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djZwibFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2441D1F00893;
	Wed,  3 Jun 2026 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780495658;
	bh=Bo8gGARXDcaXuvyFyJX2aoEG+OLJ83vcodSStzsml1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=djZwibFVvtIxl3SSi3faxEeEoBGJRSguvvVJbrxuEvfdOcPCf7lhIX9KgugRuXL4g
	 L4GJNrqhU1P+NCnldbLUtIuGvAIcMqZu8O+6xONTY4AdFrLA+/EkADj3suau9wmeoE
	 T/ZOkXGT0uqCtlgHSJwEfJxxV+SmqtQvzNyV2W1nhi/tLl1ptYagUjR9fc4dCXJffi
	 XiflzghimEheCIRgZ/G69yNWs0Gj5S58tVtLHJwBB7Fieon+rF9AwF6Ft6ySQmagLf
	 lbuzT511qUwS0JAXCQGCTe+Q1UlRGK30h6bCxI1CUZY9A69YxF76xWAajGRErZvBpO
	 OSNp6jKuiKFpA==
Date: Wed, 3 Jun 2026 16:07:35 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC PATCH 07/10] rcu: Wake NOCB rcuog kthreads on expedited
 grace period completion
Message-ID: <aiA1JwbwCI1Z4GG9@localhost.localdomain>
References: <20260417231203.785172-1-puranjay@kernel.org>
 <20260417231203.785172-8-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417231203.785172-8-puranjay@kernel.org>

Le Fri, Apr 17, 2026 at 04:11:55PM -0700, Puranjay Mohan a écrit :
> When an expedited grace period completes, rcu_exp_wait_wake() wakes
> waiters on rnp->exp_wq[] but does not notify NOCB rcuog kthreads.  These
> kthreads may be sleeping waiting for a grace period to complete.
> Without this wakeup, callbacks on offloaded CPUs that could benefit from
> the expedited GP must wait until the rcuog kthread wakes for some other
> reason (e.g., next normal GP completion or a timer).
> 
> Add rcu_exp_wake_nocb() which wakes rcuog kthreads for leaf-node CPUs,
> deduplicating via rdp->nocb_gp_rdp since multiple CPUs share one rcuog
> kthread.  Uses for_each_leaf_node_possible_cpu() because offline CPUs
> can have pending callbacks. The function is defined in tree_nocb.h with
> an empty stub for CONFIG_RCU_NOCB_CPU=n builds.
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/rcu/tree.h      |  1 +
>  kernel/rcu/tree_exp.h  |  1 +
>  kernel/rcu/tree_nocb.h | 29 +++++++++++++++++++++++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 7dfc57e9adb1..40f778453591 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -500,6 +500,7 @@ static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
>  static void rcu_init_one_nocb(struct rcu_node *rnp);
>  static bool wake_nocb_gp(struct rcu_data *rdp);
> +static void rcu_exp_wake_nocb(struct rcu_node *rnp);
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  				  unsigned long j, bool lazy);
>  static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 82cada459e5d..0df1009c6e97 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -708,6 +708,7 @@ static void rcu_exp_wait_wake(unsigned long s)
>  		}
>  		smp_mb(); /* All above changes before wakeup. */
>  		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(s) & 0x3]);
> +		rcu_exp_wake_nocb(rnp);
>  	}
>  	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
>  	mutex_unlock(&rcu_state.exp_wake_mutex);
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 7462cd5e2507..f37ee56d62a9 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -190,6 +190,31 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
>  	init_swait_queue_head(&rnp->nocb_gp_wq[1]);
>  }
>  
> +/*
> + * Wake NOCB rcuog kthreads for leaf-node CPUs so that they can advance
> + * callbacks that were waiting for the just-completed expedited GP.
> + * Deduplicate via nocb_gp_rdp since multiple CPUs share one rcuog
> + * kthread.  Use for_each_leaf_node_possible_cpu() because offline CPUs
> + * may have pending callbacks.
> + */
> +static void rcu_exp_wake_nocb(struct rcu_node *rnp)

Please consolidate the naming to match rcu_nocb_gp_cleanup().

> +{
> +	struct rcu_data *last_rdp_gp = NULL;
> +	int cpu;
> +
> +	if (!rcu_is_leaf_node(rnp))
> +		return;
> +
> +	for_each_leaf_node_possible_cpu(rnp, cpu) {
> +		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> +
> +		if (rdp->nocb_gp_rdp == last_rdp_gp)
> +			continue;
> +		last_rdp_gp = rdp->nocb_gp_rdp;
> +		wake_nocb_gp(rdp);
> +	}

There are two waitqueues for rcuog wake-ups:

1) rdp->rdp_gp->nocb_gp_wq: to wait for callbacks on the queue
2) rnp->nocb_gp_wq: to wait for grace periods

So you're waking up the wrong one.

Something like the below? (untested)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0e43866dc4cd..436e12e313c2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2193,8 +2193,13 @@ static noinline void rcu_gp_cleanup(void)
 			dump_blkd_tasks(rnp, 10);
 		WARN_ON_ONCE(rnp->qsmask);
 		WRITE_ONCE(rnp->gp_seq, new_gp_seq);
-		if (!rnp->parent)
-			smp_mb(); // Order against failing poll_state_synchronize_rcu_full().
+		if (!rnp->parent) {
+			/*
+			 * Order against failing poll_state_synchronize_rcu_full().
+			 * and also rcu_nocb_cleanup_wake() -> swait_active()
+			 */
+			smp_mb();
+		}
 		rdp = this_cpu_ptr(&rcu_data);
 		if (rnp == rdp->mynode)
 			needgp = __note_gp_changes(rnp, rdp) || needgp;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 40f778453591..8f272cb4e4f3 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -253,7 +253,7 @@ struct rcu_data {
 	u8 nocb_gp_sleep;		/* Is the nocb GP thread asleep? */
 	u8 nocb_gp_bypass;		/* Found a bypass on last scan? */
 	u8 nocb_gp_gp;			/* GP to wait for on last scan? */
-	unsigned long nocb_gp_seq;	/*  If so, ->gp_seq to wait for. */
+	struct rcu_gp_oldstate nocb_gp_seq; /*  If so, ->gp_seq to wait for. */
 	unsigned long nocb_gp_loops;	/* # passes through wait code. */
 	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
 	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
@@ -498,9 +498,9 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
 static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
+static void rcu_nocb_exp_cleanup(struct rcu_node *rnp);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
 static bool wake_nocb_gp(struct rcu_data *rdp);
-static void rcu_exp_wake_nocb(struct rcu_node *rnp);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, bool lazy);
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 0df1009c6e97..43c167a8a145 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -708,7 +708,8 @@ static void rcu_exp_wait_wake(unsigned long s)
 		}
 		smp_mb(); /* All above changes before wakeup. */
 		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(s) & 0x3]);
-		rcu_exp_wake_nocb(rnp);
+		if (rcu_is_leaf_node(rnp))
+			rcu_nocb_exp_cleanup(rnp);
 	}
 	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
 	mutex_unlock(&rcu_state.exp_wake_mutex);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f37ee56d62a9..60d4182b9509 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -170,13 +170,59 @@ static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
 		lockdep_assert_held(&rdp->nocb_lock);
 }
 
+static void rcu_nocb_cleanup_wake(struct swait_queue_head *sq)
+{
+	if (swait_active(sq))
+		swake_up_all(sq);
+}
+
 /*
  * Wake up any no-CBs CPUs' kthreads that were waiting on the just-ended
  * grace period.
  */
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
 {
-	swake_up_all(sq);
+	/*
+	 * swait active() can be checked first because:
+	 *
+	 * rcu_gp_cleanup()                              nocb_gp_wait()
+	 * ---------------                               --------------
+	 * WRITE_ONCE(root->gp_seq, new_gp_seq);         swait_event_interruptible_exclusive(sq)
+	 * smp_mb()                                         prepare_to_swait()
+	 * if swait_active(sq)                                 list_add_tail(&wait->task_list, &q->task_list);
+	 *    swake_up_all(sq)                                 set_current_state()
+	 *                                                       smp_mb()
+	 *                                                  if (poll_state_synchronize_rcu_full())
+	 *                                                     if (rcu_seq_done_exact(&root->gp_seq, rgosp->rgos_norm))
+	 *                                                        ...
+	 */
+	rcu_nocb_cleanup_wake(sq);
+}
+
+/*
+ * Wake NOCB rcuog kthreads for leaf-node CPUs so that they can advance
+ * callbacks that were waiting for the just-completed expedited GP.
+ * Wake-up waitqueues for both even and odd GP numbers because exp and
+ * normal sequences don't match.
+ */
+static void rcu_nocb_exp_cleanup(struct rcu_node *rnp)
+{
+/*
+ * swait active() can be checked first because:
+ *
+ * rcu_exp_wait_wake()                           nocb_gp_wait()
+ * ---------------                               --------------
+ * rcu_seq_end(&rcu_state.expedited_sequence);   swait_event_interruptible_exclusive(sq)
+ * smp_mb()                                         prepare_to_swait()
+ * if swait_active(sq)                                 list_add_tail(&wait->task_list, &q->task_list);
+ *    swake_up_all(sq)                                 set_current_state()
+ *                                                        smp_mb()
+ *                                                  if (poll_state_synchronize_rcu_full())
+ *                                                     if (rcu_seq_done_exact(&rcu_state.expedited_sequence, rgosp->rgos_exp))
+ *                                                        ...
+ */
+	rcu_nocb_cleanup_wake(&rnp->nocb_gp_wq[0]);
+	rcu_nocb_cleanup_wake(&rnp->nocb_gp_wq[1]);
 }
 
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp)
@@ -190,31 +236,6 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 	init_swait_queue_head(&rnp->nocb_gp_wq[1]);
 }
 
-/*
- * Wake NOCB rcuog kthreads for leaf-node CPUs so that they can advance
- * callbacks that were waiting for the just-completed expedited GP.
- * Deduplicate via nocb_gp_rdp since multiple CPUs share one rcuog
- * kthread.  Use for_each_leaf_node_possible_cpu() because offline CPUs
- * may have pending callbacks.
- */
-static void rcu_exp_wake_nocb(struct rcu_node *rnp)
-{
-	struct rcu_data *last_rdp_gp = NULL;
-	int cpu;
-
-	if (!rcu_is_leaf_node(rnp))
-		return;
-
-	for_each_leaf_node_possible_cpu(rnp, cpu) {
-		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-
-		if (rdp->nocb_gp_rdp == last_rdp_gp)
-			continue;
-		last_rdp_gp = rdp->nocb_gp_rdp;
-		wake_nocb_gp(rdp);
-	}
-}
-
 /* Clear any pending deferred wakeup timer (nocb_gp_lock must be held). */
 static void nocb_defer_wakeup_cancel(struct rcu_data *rdp_gp)
 {
@@ -684,7 +705,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 {
 	bool bypass = false;
 	int __maybe_unused cpu = my_rdp->cpu;
-	struct rcu_gp_oldstate cur_gp_seq_full;
+	struct rcu_gp_oldstate wait_gp_seq = {0}; //remove uninitialized warning
 	unsigned long flags;
 	bool gotcbs = false;
 	unsigned long j = jiffies;
@@ -694,7 +715,6 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	bool needwake_gp;
 	struct rcu_data *rdp, *rdp_toggling = NULL;
 	struct rcu_node *rnp;
-	unsigned long wait_gp_seq = 0; // Suppress "use uninitialized" warning.
 	bool wasempty = false;
 
 	/*
@@ -718,6 +738,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 * won't be ignored for long.
 	 */
 	list_for_each_entry(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp) {
+		struct rcu_gp_oldstate cur_gp_seq;
 		long bypass_ncbs;
 		bool flush_bypass = false;
 		long lazy_ncbs;
@@ -755,8 +776,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		needwake_gp = false;
 		if (!rcu_segcblist_restempty(&rdp->cblist,
 					     RCU_NEXT_READY_TAIL) ||
-		    (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq_full) &&
-		     poll_state_synchronize_rcu_full(&cur_gp_seq_full))) {
+		    (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
+		     poll_state_synchronize_rcu_full(&cur_gp_seq))) {
 			raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
 			needwake_gp = rcu_advance_cbs(rnp, rdp);
 			wasempty = rcu_segcblist_restempty(&rdp->cblist,
@@ -777,11 +798,15 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		 * numbers from rcu_accelerate_cbs() inside
 		 * rcu_advance_cbs() and will be handled on the next pass.
 		 */
-		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq_full) &&
-		    !poll_state_synchronize_rcu_full(&cur_gp_seq_full)) {
+		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
+		    !poll_state_synchronize_rcu_full(&cur_gp_seq)) {
+			if (!needwait_gp ||
+			    ULONG_CMP_LT(cur_gp_seq.rgos_norm, wait_gp_seq.rgos_norm))
+				wait_gp_seq.rgos_norm = cur_gp_seq.rgos_norm;
 			if (!needwait_gp ||
-			    ULONG_CMP_LT(cur_gp_seq_full.rgos_norm, wait_gp_seq))
-				wait_gp_seq = cur_gp_seq_full.rgos_norm;
+			    ULONG_CMP_LT(cur_gp_seq.rgos_exp, wait_gp_seq.rgos_exp))
+				wait_gp_seq.rgos_exp = cur_gp_seq.rgos_exp;
+
 			needwait_gp = true;
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("NeedWaitGP"));
@@ -803,7 +828,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 
 	my_rdp->nocb_gp_bypass = bypass;
 	my_rdp->nocb_gp_gp = needwait_gp;
-	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
+	if (needwait_gp)
+		my_rdp->nocb_gp_seq = wait_gp_seq;
 
 	// At least one child with non-empty ->nocb_bypass, so set
 	// timer in order to avoid stranding its callbacks.
@@ -838,12 +864,12 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		nocb_gp_sleep(my_rdp, cpu);
 	} else {
 		rnp = my_rdp->mynode;
-		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWait"));
+		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq.rgos_norm, TPS("StartWait"));
 		swait_event_interruptible_exclusive(
-			rnp->nocb_gp_wq[rcu_seq_ctr(wait_gp_seq) & 0x1],
-			rcu_seq_done(&rnp->gp_seq, wait_gp_seq) ||
+			rnp->nocb_gp_wq[rcu_seq_ctr(wait_gp_seq.rgos_norm) & 0x1],
+			poll_state_synchronize_rcu_full(&wait_gp_seq) ||
 			!READ_ONCE(my_rdp->nocb_gp_sleep));
-		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("EndWait"));
+		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq.rgos_norm, TPS("EndWait"));
 	}
 
 	if (!rcu_nocb_poll) {
@@ -877,7 +903,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		swake_up_one(&rdp_toggling->nocb_state_wq);
 	}
 
-	my_rdp->nocb_gp_seq = -1;
+	my_rdp->nocb_gp_seq.rgos_norm = -1;
+	my_rdp->nocb_gp_seq.rgos_exp = -1;
 	WARN_ON(signal_pending(current));
 }
 
@@ -1561,7 +1588,7 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 {
 	struct rcu_node *rnp = rdp->mynode;
 
-	pr_info("nocb GP %d %c%c%c%c%c %c[%c%c] %c%c:%ld rnp %d:%d %lu %c CPU %d%s\n",
+	pr_info("nocb GP %d %c%c%c%c%c %c[%c%c] %c%c:%ld/%ld rnp %d:%d %lu %c CPU %d%s\n",
 		rdp->cpu,
 		"kK"[!!rdp->nocb_gp_kthread],
 		"lL"[raw_spin_is_locked(&rdp->nocb_gp_lock)],
@@ -1573,7 +1600,8 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 		".W"[swait_active(&rnp->nocb_gp_wq[1])],
 		".B"[!!rdp->nocb_gp_bypass],
 		".G"[!!rdp->nocb_gp_gp],
-		(long)rdp->nocb_gp_seq,
+		(long)rdp->nocb_gp_seq.rgos_norm,
+		(long)rdp->nocb_gp_seq.rgos_exp,
 		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops),
 		rdp->nocb_gp_kthread ? task_state_to_char(rdp->nocb_gp_kthread) : '.',
 		rdp->nocb_gp_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
@@ -1684,16 +1712,16 @@ static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
 {
 }
 
-static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp)
+static void rcu_nocb_exp_cleanup(struct rcu_node *rnp)
 {
-	return NULL;
 }
 
-static void rcu_init_one_nocb(struct rcu_node *rnp)
+static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp)
 {
+	return NULL;
 }
 
-static void rcu_exp_wake_nocb(struct rcu_node *rnp)
+static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
