Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3756E8472;
	Mon, 31 Mar 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743456593; cv=none; b=P0lMQJX2bRWeAzh4tRFKl1x8KsMDrQOFUaeKkuHJelffCBsJnhjDdNOrzjcC7BTmAepHe/UbV8+i9RdaJ6zpITqIEN1shTMO3WKVSktEh+hJuouvxseE5MEAKv73eEK0zPhVKyeBnjiN/uZsIdSeCP3peATwBsJoXmrdtY5JTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743456593; c=relaxed/simple;
	bh=GrffwXCP7JFBv8rfG6BMjEPVH7avRK0zsxrUQE3Qs0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6EOEg+Y6ancR2uhWLzJpivMTTEweUx6+6urJ2bVHxCm0HKkUVtqBnDg4M8uVcDG+qnJp8WnZ1AcSYBZV8buAJ9EqsFySLi1kT3DOXVgdJPPWI2nWKjIAiRdGNojyHIQhODACep/zTXxSpfJu8JBL72BR1GWTVFmpLWtFGEJi3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjFf/DDI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjFf/DDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F215C4CEE3;
	Mon, 31 Mar 2025 21:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743456592;
	bh=GrffwXCP7JFBv8rfG6BMjEPVH7avRK0zsxrUQE3Qs0I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cjFf/DDIzY0O/NCyY5Zc6TL52FDtPz7yLdhsA++8BneJPlYxrxMwlK57zuygsRtJB
	 EILkqdSNrMvCQwuKYgWFSRNoLdmZW226Dw4wS6U4ZvaT/UZOMhWzS8s7r+PmmvIuJO
	 pekA0xZVu5aHz/+JgpAqn4JerY+B94pT/ECZT040NkOkFJ77osiMnhj7NQSScwSDrp
	 31hq4TnlahLx8TqlmbcVQzgERwn9FmbuWqF3n5+6MxjxNioBmVI/B7BfD5eKce4PTL
	 dCIp1CGqjSYfuEzbO50iq2DT6QJ9k1IMSm5INcOA1jGLUvK7WEJdHaUFmV4a83mphb
	 ytHYfoVGMcniA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 36254CE0869; Mon, 31 Mar 2025 14:29:52 -0700 (PDT)
Date: Mon, 31 Mar 2025 14:29:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <bc4d930e-60c2-4ff8-8995-d463b6365b00@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
 <20250324170156.469763-2-joelagnelf@nvidia.com>
 <eeda52c2-5397-4aad-ad01-ca04e5b0b80f@paulmck-laptop>
 <DDDD275D-1017-4189-9A8A-578021A33B4A@nvidia.com>
 <e47e5611-36de-4d12-9c07-57aa2a885299@paulmck-laptop>
 <Z-nBcg9FJqu5RzME@pavilion.home>
 <71fc9642-5fc7-45ec-8196-8fc89ed8e765@paulmck-laptop>
 <Z-sFonl2NrppdGQS@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-sFonl2NrppdGQS@pavilion.home>

On Mon, Mar 31, 2025 at 11:14:10PM +0200, Frederic Weisbecker wrote:
> Le Mon, Mar 31, 2025 at 11:28:47AM -0700, Paul E. McKenney a écrit :
> > > So I'm unfortunately asking again if it wouldn't be a good idea to have a single
> > > global state counter that lives in the root node so that we don't have it
> > > duplicated in rcu_state.gp_seq.
> > > 
> > > This involves some special care:
> > > 
> > > 1) As you pointed out, the root can also be the unique leaf. So care must
> > >    be taken that no QS is reported before new online CPUs have been handled
> > >    and QS masks initialized. In order for __note_gp_changes() to handle
> > >    it gracefully we must have two seq states: one to tell the
> > >    grace period has started (before checking new online CPUs): RCU_STATE_STARTED
> > >    and one to tell that grace period is ready to receive quiescent states:
> > >    RCU_STATE_WAIT_QS. Although not strictly required, __note_gp_changes() can
> > >    ignore simple state changes to RCU_STATE_STARTED in order to spare useless
> > >    work and rnp locking. No QS will be reported before ->qsmask are initialized
> > >    in any case.
> > 
> > We have available up to three stages of grace-period processing, which
> > can be expanded relatively easily.  My concern is that we will be
> > replacing "which ->gp_seq to use" confusion with "which gp_seq state
> > to pay attention to" confusion.
> 
> True, this comes at the cost of a bit more complex state space.

Choices, choices!  ;-)

> > > 2) rcu_gp_cleanup() currently ends the grace period top-down through the rnp tree
> > >    and only then on rcu_state. With this change it's simply top-down. I have audited
> > >    rcu_seq_snap() and rcu_start_this_gp() uses and I haven't found an obvious
> > >    issue with that.
> > 
> > That would result in the root rcu_node structure's ->gp_seq declaring the
> > grace period over before the rest of the rcu_node structures were aware
> > of it having ended.  I guess that the last leaf rcu_node structure's
> > ->gp_seq field would be what you would look at if you were looking for
> > the actual grace period end.
> > 
> > Of course, you could argue that the grace period isn't fully over
> > until all the CPUs are aware of it, but that can take a very long time,
> > especially if there are CPUs staying idle for seconds (let alone minutes)
> > at at time.
> 
> Right. And it seems not all parts of RCU agree on a common definition of
> a complete grace period. Polling seem to be fine with just the root rnp
> to reflect rcu_seq_end() (which happens before the leaves do). Snapshot takers
> though rely on the whole tree to reflect the GP end...
> 
> As far as I audited the code, mostly rcu_seq_snap() callers, rcu_start_this_gp()
> and __note_gp_changes(), it looks fine to consider the GP is ended as soon
> as the root reflects it. I may have missed something of course...

The disagreement is a feature, at least up to a point.  That feature
allows CPUs to go idle for long periods without RCU having to bother
them or to mess with their per-CPU data (give or take ->gpwrap).  It also
allows per-rcu_node-leaf locking, which is important on large systems.

Trying to make precisely globally agreed-on beginnings and ends of
RCU grace periods will not end well from performance, scalability,
or real-time-response viewpoints.  ;-)

But simplifications that don't hurt performance, scalability, and
real-time-response are of course welcome.

> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > index feb3ac1dc5d5..c4bb3eb92a58 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -19,6 +19,12 @@
> > >   * The two least significant bits contain the control flags.
> > >   * The most significant bits contain the grace-period sequence counter.
> > >   *
> > > + * RCU_STATE_STARTED		:	The gp has started but QS are not
> > > + *					requested yet.
> > > + *
> > > + * RCU_STATE_WAIT_QS		:	The gp has started and waits for
> > > + *					QS to be reported.
> > 
> > Do we want RCU_STATE_IDLE, by analogy with SRCU?
> 
> Makes sense.
> 
> > 
> > >   * When both control flags are zero, no grace period is in progress.
> > >   * When either bit is non-zero, a grace period has started and is in
> > >   * progress. When the grace period completes, the control flags are reset
> > > @@ -54,6 +60,9 @@
> > >   *					grace-period sequence number.
> > >   */
> > >  
> > > +#define RCU_STATE_STARTED	0x1
> > > +#define RCU_STATE_WAIT_QS	0x2
> > > +
> > >  /* Low-order bit definition for polled grace-period APIs. */
> > >  #define RCU_GET_STATE_COMPLETED	0x1
> > >  
> > > @@ -92,7 +101,13 @@ static inline void rcu_seq_start(unsigned long *sp)
> > >  {
> > >  	WRITE_ONCE(*sp, *sp + 1);
> > >  	smp_mb(); /* Ensure update-side operation after counter increment. */
> > > -	WARN_ON_ONCE(rcu_seq_state(*sp) != 1);
> > > +	WARN_ON_ONCE(rcu_seq_state(*sp) != RCU_STATE_STARTED);
> > > +}
> > > +
> > > +static inline void rcu_seq_wait_qs(unsigned long *sp)
> > > +{
> > > +	WRITE_ONCE(*sp, *sp + 1);
> > > +	WARN_ON_ONCE(rcu_seq_state(*sp) != RCU_STATE_WAIT_QS);
> > 
> > Or we could have the WARN_ON_ONCE() first, and use rcu_seq_set_state().
> 
> Right!
> 
> > > @@ -192,6 +192,21 @@ int rcu_get_gp_kthreads_prio(void)
> > >  }
> > >  EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
> > >  
> > > +/*
> > > + * Return the root node of the rcu_state structure.
> > > + */
> > > +static struct rcu_node *rcu_get_root(void)
> > > +{
> > > +	return &rcu_state.node[0];
> > > +}
> > 
> > OK, just code movement.
> 
> Right, if I proceed with this, a series will (try to) split more gently
> for review.

Fair enough!

> > > +static unsigned long *rcu_root_seq(void)
> > > +{
> > > +	struct rcu_node *root = rcu_get_root();
> > > +
> > > +	return &root->gp_seq;
> > > +}
> > 
> > Adding this function might be useful in any case, even if we keep the
> > current rcu_state.gp_seq counter.  A single place to add comments that
> > address the chosen type of confusion, if nothing else.  ;-)
> 
> ;-))
> 
> > 
> > 13 calls want the pointer and 13 want the value.  An even split!
> 
> The split is but 13 itself is not even! And I know people who strongly
> want it to stay that way!

Bad regex morning, apparently...

> > Not sure what lesson to draw from this, though indirecting a function call will
> > likely cause some confusion.  Some might argue for two access functions,
> > one for the pointer and the other for the value.  Me, I am just glad that
> > I included the word "might" in the first sentence of the prior paragraph.
> 
> Right, I'm not proud of the *rcu_root_seq() things.
> I thought about adding rcu_root_seq_current() but I'm not entirely comfortable
> with having all readers under READ_ONCE(). I like when our assumptions of non
> concurrent plain accesses are defeatedly reported by KCSAN.

Good point.  I believe that ASSERT_EXCLUSIVE_WRITER() can be used to
make this work, but plain accesses are admittedly much less typing.

And the small number of uses makes three different access functions less
than fully attractive.

> > > @@ -1249,7 +1256,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
> > >  
> > >  	raw_lockdep_assert_held_rcu_node(rnp);
> > >  
> > > -	if (rdp->gp_seq == rnp->gp_seq)
> > > +	if (!rcu_seq_changed(rdp->gp_seq, rnp->gp_seq))
> > 
> > The old code would detect a bunch of elapsed grace periods, starting
> > and ending in the same state.  The new code does not.  Does the new code
> > correctly handle CPUs that go idle for many grace periods?
> 
> I'm not sure I understand what you mean. rcu_seq_changed() is a comparison
> that simply clears RCU_SEQ_STARTED on both sides such that:
> 
> * Different GP numbers with or without RCU_SEQ_STARTED/RCU_SEQ_WAIT_QS
>   are always considered a change.
> 
> * Same GP numbers but rnp has RCU_SEQ_WAIT_QS while rdp hasn't is considered a
>   change
> 
> but:
> 
> * Same GP numbers but rnp has RCU_SEQ_STARTED while rdp hasn't is _NOT_
>   considered a change. This is not for correctness but rather to spare
>   rnp locking and useless work. The ->qsmask are 0 anyway so no QS can
>   be reported too early.

Idiot here missed the pair of tildes ("~") in that function.

I clearly need to revisit this code with that in mind...

> > > @@ -1802,10 +1809,9 @@ static noinline_for_stack bool rcu_gp_init(void)
> > >  	/* Advance to a new grace period and initialize state. */
> > >  	record_gp_stall_check_time();
> > >  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > > -	rcu_seq_start(&rcu_state.gp_seq);
> > > -	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > 
> > Why are we dropping the ASSERT_EXCLUSIVE_WRITER()?  As opposed to moving
> > it to the setting of the rcu_node structures' ->gp_seq updates?
> 
> I must confess I misunderstood that macro and thought it was to assert
> the variable has no other writer _at all_. But that seem to apply
> scopewise. So yes good point.
> 
> > > @@ -1902,7 +1908,10 @@ static noinline_for_stack bool rcu_gp_init(void)
> > >  		rdp = this_cpu_ptr(&rcu_data);
> > >  		rcu_preempt_check_blocked_tasks(rnp);
> > >  		rnp->qsmask = rnp->qsmaskinit;
> > > -		WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
> > > +		if (!rnp->parent)
> > > +			rcu_seq_wait_qs(&rnp->gp_seq);
> > > +		else
> > > +			WRITE_ONCE(rnp->gp_seq, *rcu_root_seq());
> > 
> > This asymmetry is necessary because if I understand correctly, the
> > non-root rcu_node structures still have zero state.  But this is one
> > argument for use of rcu_seq_set_state(), because then you could just do
> > rcu_seq_set_state(rnp->gp_seq, RCU_STATE_WAIT_QS) in both cases.
> > 
> > Or am I missing something that prevents this from working?
> 
> Indeed, the sequence counter (but not the state) is expected to be the same on
> all nodes, so we can just modify the state as you said. And we can then assert
> WARN_ON_ONCE(rnp->gp_seq != *rcu_root_seq())
> 
> > > @@ -2114,16 +2124,12 @@ static noinline void rcu_gp_cleanup(void)
> > >  	 * the rcu_node structures before the beginning of the next grace
> > >  	 * period is recorded in any of the rcu_node structures.
> > >  	 */
> > > -	new_gp_seq = rcu_state.gp_seq;
> > > -	rcu_seq_end(&new_gp_seq);
> > >  	rcu_for_each_node_breadth_first(rnp) {
> > >  		raw_spin_lock_irq_rcu_node(rnp);
> > >  		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
> > >  			dump_blkd_tasks(rnp, 10);
> > >  		WARN_ON_ONCE(rnp->qsmask);
> > > -		WRITE_ONCE(rnp->gp_seq, new_gp_seq);
> > > -		if (!rnp->parent)
> > > -			smp_mb(); // Order against failing poll_state_synchronize_rcu_full().
> > 
> > OK, this got moved up.
> > 
> > > +		WRITE_ONCE(rnp->gp_seq, *rcu_root_seq());
> > 
> > The idea being that the root rcu_node ->gp_seq is just overwritten
> > with itself, correct?
> 
> Right!
> 
> > 
> > >  		rdp = this_cpu_ptr(&rcu_data);
> > >  		if (rnp == rdp->mynode)
> > >  			needgp = __note_gp_changes(rnp, rdp) || needgp;
> > > @@ -2146,9 +2152,7 @@ static noinline void rcu_gp_cleanup(void)
> > >  	raw_spin_lock_irq_rcu_node(rnp); /* GP before ->gp_seq update. */
> > >  
> > >  	/* Declare grace period done, trace first to use old GP number. */
> > > -	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
> > > -	rcu_seq_end(&rcu_state.gp_seq);
> > > -	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > 
> > Same question on not moving ASSERT_EXCLUSIVE_WRITER() to the rcu_node
> > structures' ->gp_seq updates.
> 
> Indeed!
> 
> > > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > > index a9a811d9d7a3..9d811270b808 100644
> > > --- a/kernel/rcu/tree.h
> > > +++ b/kernel/rcu/tree.h
> > > @@ -347,7 +347,6 @@ struct rcu_state {
> > >  
> > >  	/* The following fields are guarded by the root rcu_node's lock. */
> > >  
> > > -	unsigned long gp_seq ____cacheline_internodealigned_in_smp;
> > >  						/* Grace-period sequence #. */
> > 
> > Heh!  Does the rcu_node structure's ->gp_seq need alignment?
> 
> Probably but then this will increase the size of all rnp's, right?

Indeed, this probably needs actual performance results showing that
it is needed.  My guess is that only systems with a single rcu_node
structure that is both leaf and root would have any chance of noticing.
And those tend to have few CPUs, so they might not care.

							Thanx, Paul
