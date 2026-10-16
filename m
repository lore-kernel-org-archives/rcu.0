Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F132222A9
	for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146532; cv=none; b=QpUfCxcctxQpHm0ySiFTRBoPt0M0hmW/2DesQYeG5JkYD6+k7YMnjbjNw6DM3Uh+SU5tD2bMgtA1Sj8sYyeZV8ywPlhVtD8ikY2xR7CaOyRvhbXCQJD/WPEwh8fzV6e6Huo2XCoF4uZU3Jc1pmHxBLLpr1qjUm7pWkGtf/f0Lcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146532; c=relaxed/simple;
	bh=fmhxYAHDdsznlI30jNngKl7DR2Mhe7/8P8f9bX9UWHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Szfj82k+C/0SAcDF7SaqaFCrMdEHbBg6EneEMjNFPLaHfuj8s4YVXuC0VW6xRyIfK144pIZEJM2bVTghGDCRAJ3uKtne9O3y1WQ99eRAvJBKozcA/jg3LoAtMEjH0Gjvi+ri0vtNpHVuDmtg217b89MdBEYlLOYI6EpEBRjMT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRJcbcbs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRJcbcbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7C41F000C4;
	Fri, 16 Oct 2026 10:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146530;
	bh=4c/Nv1K6hHXQkVKq0sxJg8+uhRrZVTBDqjcqgBmz0gY=;
	h=From:To:Cc:Subject:Date;
	b=PRJcbcbs57N/78rGzUYS9dvruy9lFWta2v/uwOLdf4eOwgG7Zk6EPTBJdNNb8wZqa
	 hTsSCu5NC/cduSdrV+inNOEhtCERm/30YCU0pLrwLOTOQqAK0UhVLbj7iIYaI8ShxR
	 xpdJJvLwbavT7XoitTiw2jlF0Pd93VtXZk6640Sld3JselhEHDts0KL302xhpY6xc4
	 iDCTcoLXNg7FRhJ3S6F4+j3K0bRj2v38aWH5z83zkTiiDZtvSupxCwQgEJE+FS3zX6
	 z7vMqO+GDdSNwvgXRsn395UtGM2Bk4s+j/Gac1/OdmDZMGCEMYLf+g8947gNQVgjkc
	 8lfT4KDeybl1w==
From: Puranjay Mohan <puranjay@kernel.org>
To: rcu@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] rcu: Move expedited-GP callback advancement into __note_gp_changes()
Date: Fri, 16 Oct 2026 03:28:42 -0700
Message-ID: <20261016102843.2782262-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ec5ee5417b002 ("rcu: Advance callbacks for expedited GP
completion in rcu_core()") advances callbacks whose grace period was an
expedited one from a dedicated block in rcu_core().  That block is
needed because __note_gp_changes() returns early when
rdp->gp_seq == rnp->gp_seq, and expedited grace periods do not change
rnp->gp_seq.

The advancement depends only on the grace-period state kept in the
callback list, which covers both normal and expedited grace periods, so
it can be done in __note_gp_changes() instead.  Move it there.  This is
mostly a relocation, with the following differences:

- rcu_cbs_gp_done() combines rcu_segcblist_nextgp() with
  poll_state_synchronize_rcu_full_unordered(), and returns false for
  offloaded CPUs, as the removed block did.  need_note_gp_changes() uses
  it so that the lockless check in note_gp_changes() takes the leaf
  rcu_node lock for such a completion, and rcu_pending() now calls
  need_note_gp_changes() instead of open-coding the same tests.

- The removed block gated on poll_state_synchronize_rcu_full(), which
  executes smp_mb() on every rcu_core() with pending callbacks.  The
  gate is now the unordered variant from fde2b18817e4f.  Which callbacks
  become ready is still decided by rcu_segcblist_advance(), which uses
  the ordered poll.

- note_gp_changes() has one other caller, the qhimark path of
  call_rcu_core(), which now also advances callbacks on an expedited
  completion.  __note_gp_changes() is also called by rcu_gp_init(),
  where an expedited completion now takes rcu_advance_cbs() instead of
  rcu_accelerate_cbs(), which it ends with anyway.  In rcu_gp_cleanup(),
  the leaf rcu_node's ->gp_seq has just advanced, so the existing
  completed-grace-period path is taken as before.

- An expedited-only completion (rdp->gp_seq == rnp->gp_seq and ->gpwrap
  clear) returns before touching core_needs_qs, cpu_no_qs, rdp->gp_seq
  or gp_seq_needed.

One behavior change is not related to expedited grace periods.  With
->gpwrap set and rdp->gp_seq == rnp->gp_seq, the early return skipped
the code that clears ->gpwrap and recomputes core_needs_qs from
rnp->qsmask.  That case is now processed.  It exists at boot:
rcu_data is statically initialized with .gpwrap = true, and
rcutree_prepare_cpu() sets rdp->gp_seq from rnp->gp_seq without
clearing it.  Until the first grace period starts, ->gpwrap therefore
stays set and the ->gpwrap test in rcu_pending() reports work pending.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/tree.c | 105 ++++++++++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 41 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aea3aef7397ec..c224a8bc8aa6b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -163,6 +163,7 @@ static void rcu_report_exp_rdp(struct rcu_data *rdp);
 static void rcu_report_qs_rdp(struct rcu_data *rdp);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
+static bool poll_state_synchronize_rcu_full_unordered(struct rcu_gp_seq *gsp);
 static bool rcu_rdp_cpu_online(struct rcu_data *rdp);
 static bool rcu_init_invoked(void);
 static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf);
@@ -1260,30 +1261,63 @@ static void rcu_strict_gp_check_qs(void)
 	}
 }
 
+/*
+ * Has a grace period (normal or expedited) that this CPU's pending callbacks
+ * are waiting on completed?  Offloaded CPUs are handled by their rcuog
+ * kthreads, so always say "no" for them.  This is a racy, memory-ordering-free
+ * hint: the ordered check is done by rcu_segcblist_advance() when the
+ * callbacks are actually advanced.  The hint can also be true for callbacks
+ * that have not yet been assigned a grace period, because the stale
+ * ->gp_seq[RCU_WAIT_TAIL] then looks completed.  That is harmless, as the
+ * resulting rcu_advance_cbs() assigns them one.
+ */
+static bool rcu_cbs_gp_done(struct rcu_data *rdp)
+{
+	struct rcu_gp_seq gp_state;
+
+	return !rcu_rdp_is_offloaded(rdp) &&
+	       rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
+	       poll_state_synchronize_rcu_full_unordered(&gp_state);
+}
+
 /*
  * Update CPU-local rcu_data state to record the beginnings and ends of
  * grace periods.  The caller must hold the ->lock of the leaf rcu_node
  * structure corresponding to the current CPU, and must have irqs disabled.
- * Returns true if the grace-period kthread needs to be awakened.
+ * Also advances callbacks whose grace period was an expedited one, which
+ * does not change ->gp_seq.  Returns true if the grace-period kthread
+ * needs to be awakened.
  */
 static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	bool ret = false;
 	bool need_qs;
+	bool cbs_done;
 	const bool offloaded = rcu_rdp_is_offloaded(rdp);
+	// ->gpwrap means ->gp_seq cannot be trusted, even if it now equals ours.
+	const bool gp_changed = rdp->gp_seq != rnp->gp_seq || unlikely(rdp->gpwrap);
+	const bool completed = rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
+			       unlikely(rdp->gpwrap);
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
-	if (rdp->gp_seq == rnp->gp_seq)
+	/*
+	 * Expedited grace periods do not change ->gp_seq, but they can still
+	 * make callbacks ready to invoke.  The callback list tracks both
+	 * normal and expedited grace periods, so use it to detect that case.
+	 */
+	cbs_done = !completed && rcu_cbs_gp_done(rdp);
+	if (!gp_changed && !cbs_done)
 		return false; /* Nothing to do. */
 
 	/* Handle the ends of any preceding grace periods first. */
-	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
-	    unlikely(rdp->gpwrap)) {
+	if (completed || cbs_done) {
 		if (!offloaded)
 			ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
-		rdp->core_needs_qs = false;
-		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuend"));
+		if (completed) {
+			rdp->core_needs_qs = false;
+			trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuend"));
+		}
 	} else {
 		if (!offloaded)
 			ret = rcu_accelerate_cbs(rnp, rdp); /* Recent CBs. */
@@ -1291,6 +1325,10 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 			rdp->core_needs_qs = !!(rnp->qsmask & rdp->grpmask);
 	}
 
+	/* Expedited-only completion: no new grace-period state to record. */
+	if (!gp_changed)
+		return ret;
+
 	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
 	if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
 	    unlikely(rdp->gpwrap)) {
@@ -1315,6 +1353,18 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	return ret;
 }
 
+/*
+ * Lockless check of whether __note_gp_changes() has anything to do: a normal
+ * grace period started or ended, ->gp_seq wrapped, or an expedited grace
+ * period completed that this CPU's callbacks were waiting on.
+ */
+static bool need_note_gp_changes(struct rcu_data *rdp)
+{
+	return rdp->gp_seq != rcu_seq_current(&rdp->mynode->gp_seq) ||
+	       unlikely(READ_ONCE(rdp->gpwrap)) ||
+	       rcu_cbs_gp_done(rdp);
+}
+
 static void note_gp_changes(struct rcu_data *rdp)
 {
 	unsigned long flags;
@@ -1323,8 +1373,7 @@ static void note_gp_changes(struct rcu_data *rdp)
 
 	local_irq_save(flags);
 	rnp = rdp->mynode;
-	if ((rdp->gp_seq == rcu_seq_current(&rnp->gp_seq) &&
-	     !unlikely(READ_ONCE(rdp->gpwrap))) || /* w/out lock. */
+	if (!need_note_gp_changes(rdp) || /* w/out lock. */
 	    !raw_spin_trylock_rcu_node(rnp)) { /* irqs already off, so later. */
 		local_irq_restore(flags);
 		return;
@@ -2886,23 +2935,6 @@ static __latent_entropy void rcu_core(void)
 	/* Update RCU state based on any recent quiescent states. */
 	rcu_check_quiescent_state(rdp);
 
-	/* Advance callbacks if an expedited GP has completed. */
-	if (!rcu_rdp_is_offloaded(rdp) && rcu_segcblist_is_enabled(&rdp->cblist)) {
-		struct rcu_gp_seq gp_state;
-
-		if (rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
-		    poll_state_synchronize_rcu_full(&gp_state)) {
-			guard(irqsave)();
-			if (raw_spin_trylock_rcu_node(rnp)) {
-				bool needwake = rcu_advance_cbs(rnp, rdp);
-
-				raw_spin_unlock_rcu_node(rnp);
-				if (needwake)
-					rcu_gp_kthread_wake();
-			}
-		}
-	}
-
 	/* No grace period and unregistered callbacks? */
 	if (!rcu_gp_in_progress() &&
 	    rcu_segcblist_is_enabled(&rdp->cblist) && !rcu_rdp_is_offloaded(rdp)) {
@@ -3828,9 +3860,7 @@ EXPORT_SYMBOL_GPL(cond_synchronize_rcu_full);
 static int rcu_pending(int user)
 {
 	bool gp_in_progress;
-	struct rcu_gp_seq gp_state;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	struct rcu_node *rnp = rdp->mynode;
 
 	lockdep_assert_irqs_disabled();
 
@@ -3859,26 +3889,19 @@ static int rcu_pending(int user)
 	    rcu_segcblist_ready_cbs(&rdp->cblist))
 		return 1;
 
-	/*
-	 * Has a GP (normal or expedited) completed for pending callbacks?
-	 * This is only a racy hint to decide whether to run rcu_core(); the
-	 * ordered re-check and callback advancement happen there, so the
-	 * unordered test avoids paying for memory barriers on every tick.
-	 */
-	if (!rcu_rdp_is_offloaded(rdp) &&
-	    rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
-	    poll_state_synchronize_rcu_full_unordered(&gp_state))
-		return 1;
-
 	/* Has RCU gone idle with this CPU needing another grace period? */
 	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
 	    !rcu_rdp_is_offloaded(rdp) &&
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 		return 1;
 
-	/* Have RCU grace period completed or started?  */
-	if (rcu_seq_current(&rnp->gp_seq) != rdp->gp_seq ||
-	    unlikely(READ_ONCE(rdp->gpwrap))) /* outside lock */
+	/*
+	 * Has a grace period completed or started, or have this CPU's
+	 * callbacks' normal or expedited grace period completed?  This is
+	 * only a racy hint to run rcu_core(), where note_gp_changes()
+	 * rechecks it under the lock.
+	 */
+	if (need_note_gp_changes(rdp)) /* outside lock */
 		return 1;
 
 	/* nothing to do */

base-commit: 940793b926aa94bf65ec404043050888e3053188
-- 
2.53.0-Meta

