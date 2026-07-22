Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45A3128D9;
	Wed, 22 Jul 2026 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757051; cv=none; b=JH6EOyA4AIF4w+Z+MC6Q6cywNg4eZJC0vQbQoMTLc5s7T+brVE8ataWqwa7vVllCfywWlZ3fCcOQZ5HDcLPHdkAvT4buS3+jn2EZ5mm/lnU1mxtlziQeNtELFlfSRoBR21w4PvtnbbM8ENQXZJI11MhbluQn2iBXRz6lCLPC4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757051; c=relaxed/simple;
	bh=X9z5jIcVh2xYJtzQAxIAX0uVAgpduatEV3qAMrYAiJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/KObIMjmD68c03xRN6+z8jFYJ52qtX2O/V4mRVNoAH78RXrVFf59t2eySx5yeNFLTE2bhqnMHPttBhsNSaZRaOHF4o2P3+NN/z+jvv6Y+iTVCE4pxYaXCoQtNXeIcyMPSePjkuaLUfedRro1gI288u5q2eyG3A5SeN2Crn+5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUOavaUh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUOavaUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F471F000E9;
	Wed, 22 Jul 2026 21:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784757049;
	bh=vWyeqR5EJevSny2LNjkMl6biR5eqQBYBu/dG5yw/Yz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bUOavaUh5bWItvPAQ6sPacdt1bOiF0iyXIE9IRX6rRC9OMDHlHdBPQuiJW1Mi+l39
	 HOSsZ2UDRI28OIqoa0BrxX6hf2F9LCtQmXkzJW9yEtCTgsCoFUEp1oyLsPNFGAexOH
	 iOX41FMZxpjl9GjUGQKv7nq6TDD8RHbwGUoxNj3fP1/1fBncw85kLxHKT8xuKoiixF
	 7sEnD7UEti185QpkO24p/r6TgzyH1y5/QuW35gjyxz7TKM9YGD2L5apbpyn68BnsRN
	 UgJdde9jw7pq4w94xy2l6cx4NWTRobdKG4/VgQMKy2NzKXWj0X3P8Z+MpIu4aG09qM
	 tMUg/hWHlAZpQ==
Date: Wed, 22 Jul 2026 23:50:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
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
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v1 10/11] rcu: Advance callbacks for expedited GP
 completion in rcu_core()
Message-ID: <amE7NrJRm0YDYroX@pavilion.home>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-11-puranjay@kernel.org>
 <al-DopVEIe2FvLnv@localhost.localdomain>
 <CANk7y0hado1yb9Gaeg0FVX45E96E3U_8d6gJTF0=s-pjwcQEpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0hado1yb9Gaeg0FVX45E96E3U_8d6gJTF0=s-pjwcQEpQ@mail.gmail.com>

Le Tue, Jul 21, 2026 at 04:06:24PM +0100, Puranjay Mohan a écrit :
> On Tue, Jul 21, 2026 at 3:35 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > Le Wed, Jun 24, 2026 at 06:23:52AM -0700, Puranjay Mohan a écrit :
> > > Even when rcu_pending() triggers rcu_core(), the normal callback
> > > advancement path through note_gp_changes() -> __note_gp_changes() bails
> > > out when rdp->gp_seq == rnp->gp_seq (no normal GP change). Since
> > > expedited GPs do not update rnp->gp_seq, rcu_advance_cbs() is never
> > > called and callbacks remain stuck in RCU_WAIT_TAIL.
> > >
> > > Add a direct callback advancement block in rcu_core() that checks for GP
> > > completion via rcu_segcblist_nextgp() combined with
> > > poll_state_synchronize_rcu_full(). When detected, trylock rnp and call
> > > rcu_advance_cbs() to move completed callbacks to RCU_DONE_TAIL. Wake the
> > > GP kthread if rcu_advance_cbs() requests a new grace period.
> > >
> > > Uses trylock to avoid adding contention on rnp->lock. If the lock is
> > > contended, callbacks will be advanced on the next tick.
> > >
> > > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > > ---
> > >  kernel/rcu/tree.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index b01d7bf6b57b1..f42e01ef479c4 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2891,6 +2891,23 @@ static __latent_entropy void rcu_core(void)
> > >       /* Update RCU state based on any recent quiescent states. */
> > >       rcu_check_quiescent_state(rdp);
> > >
> > > +     /* Advance callbacks if an expedited GP has completed. */
> > > +     if (!rcu_rdp_is_offloaded(rdp) && rcu_segcblist_is_enabled(&rdp->cblist)) {
> > > +             struct rcu_gp_seq gp_state;
> > > +
> > > +             if (rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
> > > +                 poll_state_synchronize_rcu_full(&gp_state)) {
> > > +                     guard(irqsave)();
> > > +                     if (raw_spin_trylock_rcu_node(rnp)) {
> > > +                             bool needwake = rcu_advance_cbs(rnp, rdp);
> > > +
> > > +                             raw_spin_unlock_rcu_node(rnp);
> > > +                             if (needwake)
> > > +                                     rcu_gp_kthread_wake();
> > > +                     }
> > > +             }
> > > +     }
> >
> > Should that go as an improvement to note_gp_changes() instead?
> 
> note_gp_changes() only reconciles rdp->gp_seq against rnp->gp_seq, and
> the expedited path never advances rnp->gp_seq. So the gap this closes
> is exactly rdp->gp_seq == rnp->gp_seq, where note_gp_changes() and
> __note_gp_changes() both short-circuit, the expedited completion isn't
> visible there at all. It's detected from the cblist's stored gp_seq
> (rcu_segcblist_nextgp()) confirmed with
> poll_state_synchronize_rcu_full(), so hosting it in note_gp_changes()
> would mean running that in the lockless preamble for every caller,
> including the off-tick call_rcu_core() path. In rcu_core() it's
> already gated by rcu_pending(), which does the barrier-free detection.

Let's take a step back. note_gp_changes() is for the CPU to ackowledge
a grace period change, either start or completion, and react upon with:

_ Making the callback progress through the state machine if a grace period
  has changed.

_ Starting to chase quiescent states.

And now callback advancing/acceleration don't even refer anymore to the
leaf node state but to the global one. So why not proceed with that
logic?

Also other callers of note_gp_changes() may want to benefit from expedited
grace periods as well.

Would the following (untested) work?

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ff6601411a89..96bf7fe03be8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1271,27 +1271,29 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	bool ret = false;
 	bool need_qs;
+	struct rcu_gp_seq gp_state;
 	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
-	if (rdp->gp_seq == rnp->gp_seq)
-		return false; /* Nothing to do. */
-
 	/* Handle the ends of any preceding grace periods first. */
-	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
+	if ((rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
+	    poll_state_synchronize_rcu_full_unordered(&gp_state)) ||
 	    unlikely(rdp->gpwrap)) {
 		if (!offloaded)
 			ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
 		rdp->core_needs_qs = false;
 		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuend"));
-	} else {
+	} else if (rdp->gp_seq != rnp->gp_seq) {
 		if (!offloaded)
 			ret = rcu_accelerate_cbs(rnp, rdp); /* Recent CBs. */
 		if (rdp->core_needs_qs)
 			rdp->core_needs_qs = !!(rnp->qsmask & rdp->grpmask);
 	}
 
+	if (rdp->gp_seq == rnp->gp_seq)
+		return ret; /* Nothing else to do. */
+
 	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
 	if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
 	    unlikely(rdp->gpwrap)) {
@@ -1316,6 +1318,27 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	return ret;
 }
 
+static bool need_note_gp_changes(struct rcu_data *rdp)
+{
+	struct rcu_gp_seq gp_state;
+	struct rcu_node *rnp = rdp->mynode;
+
+	/* Need to chase QS or accelerate? */
+	if (rdp->gp_seq != rcu_seq_current(&rnp->gp_seq))
+		return true;
+
+	/* Waited upon GP has ended, need to advance CBs ? */
+	if (rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
+	    poll_state_synchronize_rcu_full_unordered(&gp_state))
+		return true;
+
+	/* Wrapped? */
+	if (unlikely(READ_ONCE(rdp->gpwrap)))
+		return true;
+
+	return false;
+}
+
 static void note_gp_changes(struct rcu_data *rdp)
 {
 	unsigned long flags;
@@ -1324,8 +1347,7 @@ static void note_gp_changes(struct rcu_data *rdp)
 
 	local_irq_save(flags);
 	rnp = rdp->mynode;
-	if ((rdp->gp_seq == rcu_seq_current(&rnp->gp_seq) &&
-	     !unlikely(READ_ONCE(rdp->gpwrap))) || /* w/out lock. */
+	if (!need_note_gp_changes(rdp) || /* w/out lock. */
 	    !raw_spin_trylock_rcu_node(rnp)) { /* irqs already off, so later. */
 		local_irq_restore(flags);
 		return;
@@ -2888,23 +2910,6 @@ static __latent_entropy void rcu_core(void)
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
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 01a1b2985abd..6b9b058d138e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -517,6 +517,7 @@ static void rcu_nocb_unlock(struct rcu_data *rdp);
 static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 				       unsigned long flags);
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
+static bool poll_state_synchronize_rcu_full_unordered(struct rcu_gp_seq *gsp);
 #ifdef CONFIG_RCU_NOCB_CPU
 static void __init rcu_organize_nocb_kthreads(void);
 
 
