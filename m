Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121D221C9EA;
	Mon, 31 Mar 2025 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743455654; cv=none; b=fJWpGyPNf2PlRIrtGbpwe3oEcaXSziuTVd4ub+Z0RPdWtFftjozQebE/65vGyC/kM0KJtV2DZqoLsbfnVBgq/QDLKSAXJRk5JRt0fWQVeEp/1Z25VbnwPEDkkXVtDTur2763lDmCkMDk+KJe5OEDVquRREVxcxisCa9vpFFO2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743455654; c=relaxed/simple;
	bh=CLlhmTXlnNx2k1IYm/46xAYUPC/4ykPPJnHTtwDfly0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLd509zwBMnp/L8JVoAMKsNr1hfEwKDCbFjTM+ux3VAI8bzSDXn3L7In8/s7bLVw+ikCJ4lVsSM6CrVa1UJ8tRgOXeblXrOaNfxyyJBEozVZIis6f56sSkXjVZxrzg0NeiPS0zgN/UOBKwjqGH7lm9VxSYf7mcuBKQzhR1Z9kZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehD1nHpY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehD1nHpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377D1C4CEE5;
	Mon, 31 Mar 2025 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743455653;
	bh=CLlhmTXlnNx2k1IYm/46xAYUPC/4ykPPJnHTtwDfly0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehD1nHpYU6pHs/cJMc1SnCeBhZ907BtSrszfWiC2/n0+wLDd4iCfFmg2sL2uNyPDO
	 sjTQmnsWVlP2Z8FnecbGw0f28CZSie9nuJIJyOsJjPna+pP3kNTkMY4KyDv4+DZW3D
	 acr0ONCeocbQDnHDvxS+EZYTFih1vCcv0UJJ9Yhx84xy3vK/ecttRmv7wQ3rg+fzNT
	 108KPg9n/zJTK5qIWAYgziiLxyO4G37gpijJ61IkVWJ7Q+3nrBfeg5DG4FdCjARiw+
	 GOl5r+ET2armxpIsdVvet7LXzwjaKrMREX3uWwhV0VGHu7Jvxgc0RXXyfmjj8X6W8X
	 7sIVvBacejZaw==
Date: Mon, 31 Mar 2025 23:14:10 +0200
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
Message-ID: <Z-sFonl2NrppdGQS@pavilion.home>
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
 <20250324170156.469763-2-joelagnelf@nvidia.com>
 <eeda52c2-5397-4aad-ad01-ca04e5b0b80f@paulmck-laptop>
 <DDDD275D-1017-4189-9A8A-578021A33B4A@nvidia.com>
 <e47e5611-36de-4d12-9c07-57aa2a885299@paulmck-laptop>
 <Z-nBcg9FJqu5RzME@pavilion.home>
 <71fc9642-5fc7-45ec-8196-8fc89ed8e765@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71fc9642-5fc7-45ec-8196-8fc89ed8e765@paulmck-laptop>

Le Mon, Mar 31, 2025 at 11:28:47AM -0700, Paul E. McKenney a écrit :
> > So I'm unfortunately asking again if it wouldn't be a good idea to have a single
> > global state counter that lives in the root node so that we don't have it
> > duplicated in rcu_state.gp_seq.
> > 
> > This involves some special care:
> > 
> > 1) As you pointed out, the root can also be the unique leaf. So care must
> >    be taken that no QS is reported before new online CPUs have been handled
> >    and QS masks initialized. In order for __note_gp_changes() to handle
> >    it gracefully we must have two seq states: one to tell the
> >    grace period has started (before checking new online CPUs): RCU_STATE_STARTED
> >    and one to tell that grace period is ready to receive quiescent states:
> >    RCU_STATE_WAIT_QS. Although not strictly required, __note_gp_changes() can
> >    ignore simple state changes to RCU_STATE_STARTED in order to spare useless
> >    work and rnp locking. No QS will be reported before ->qsmask are initialized
> >    in any case.
> 
> We have available up to three stages of grace-period processing, which
> can be expanded relatively easily.  My concern is that we will be
> replacing "which ->gp_seq to use" confusion with "which gp_seq state
> to pay attention to" confusion.

True, this comes at the cost of a bit more complex state space.

> 
> > 2) rcu_gp_cleanup() currently ends the grace period top-down through the rnp tree
> >    and only then on rcu_state. With this change it's simply top-down. I have audited
> >    rcu_seq_snap() and rcu_start_this_gp() uses and I haven't found an obvious
> >    issue with that.
> 
> That would result in the root rcu_node structure's ->gp_seq declaring the
> grace period over before the rest of the rcu_node structures were aware
> of it having ended.  I guess that the last leaf rcu_node structure's
> ->gp_seq field would be what you would look at if you were looking for
> the actual grace period end.
> 
> Of course, you could argue that the grace period isn't fully over
> until all the CPUs are aware of it, but that can take a very long time,
> especially if there are CPUs staying idle for seconds (let alone minutes)
> at at time.

Right. And it seems not all parts of RCU agree on a common definition of
a complete grace period. Polling seem to be fine with just the root rnp
to reflect rcu_seq_end() (which happens before the leaves do). Snapshot takers
though rely on the whole tree to reflect the GP end...

As far as I audited the code, mostly rcu_seq_snap() callers, rcu_start_this_gp()
and __note_gp_changes(), it looks fine to consider the GP is ended as soon
as the root reflects it. I may have missed something of course...

> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index feb3ac1dc5d5..c4bb3eb92a58 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -19,6 +19,12 @@
> >   * The two least significant bits contain the control flags.
> >   * The most significant bits contain the grace-period sequence counter.
> >   *
> > + * RCU_STATE_STARTED		:	The gp has started but QS are not
> > + *					requested yet.
> > + *
> > + * RCU_STATE_WAIT_QS		:	The gp has started and waits for
> > + *					QS to be reported.
> 
> Do we want RCU_STATE_IDLE, by analogy with SRCU?

Makes sense.

> 
> >   * When both control flags are zero, no grace period is in progress.
> >   * When either bit is non-zero, a grace period has started and is in
> >   * progress. When the grace period completes, the control flags are reset
> > @@ -54,6 +60,9 @@
> >   *					grace-period sequence number.
> >   */
> >  
> > +#define RCU_STATE_STARTED	0x1
> > +#define RCU_STATE_WAIT_QS	0x2
> > +
> >  /* Low-order bit definition for polled grace-period APIs. */
> >  #define RCU_GET_STATE_COMPLETED	0x1
> >  
> > @@ -92,7 +101,13 @@ static inline void rcu_seq_start(unsigned long *sp)
> >  {
> >  	WRITE_ONCE(*sp, *sp + 1);
> >  	smp_mb(); /* Ensure update-side operation after counter increment. */
> > -	WARN_ON_ONCE(rcu_seq_state(*sp) != 1);
> > +	WARN_ON_ONCE(rcu_seq_state(*sp) != RCU_STATE_STARTED);
> > +}
> > +
> > +static inline void rcu_seq_wait_qs(unsigned long *sp)
> > +{
> > +	WRITE_ONCE(*sp, *sp + 1);
> > +	WARN_ON_ONCE(rcu_seq_state(*sp) != RCU_STATE_WAIT_QS);
> 
> Or we could have the WARN_ON_ONCE() first, and use rcu_seq_set_state().

Right!

> > @@ -192,6 +192,21 @@ int rcu_get_gp_kthreads_prio(void)
> >  }
> >  EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
> >  
> > +/*
> > + * Return the root node of the rcu_state structure.
> > + */
> > +static struct rcu_node *rcu_get_root(void)
> > +{
> > +	return &rcu_state.node[0];
> > +}
> 
> OK, just code movement.

Right, if I proceed with this, a series will (try to) split more gently
for review.

> 
> > +static unsigned long *rcu_root_seq(void)
> > +{
> > +	struct rcu_node *root = rcu_get_root();
> > +
> > +	return &root->gp_seq;
> > +}
> 
> Adding this function might be useful in any case, even if we keep the
> current rcu_state.gp_seq counter.  A single place to add comments that
> address the chosen type of confusion, if nothing else.  ;-)

;-))

> 
> 13 calls want the pointer and 13 want the value.  An even split!

The split is but 13 itself is not even! And I know people who strongly
want it to stay that way!

> Not sure what lesson to draw from this, though indirecting a function call will
> likely cause some confusion.  Some might argue for two access functions,
> one for the pointer and the other for the value.  Me, I am just glad that
> I included the word "might" in the first sentence of the prior paragraph.

Right, I'm not proud of the *rcu_root_seq() things.
I thought about adding rcu_root_seq_current() but I'm not entirely comfortable
with having all readers under READ_ONCE(). I like when our assumptions of non
concurrent plain accesses are defeatedly reported by KCSAN.

> > @@ -1249,7 +1256,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
> >  
> >  	raw_lockdep_assert_held_rcu_node(rnp);
> >  
> > -	if (rdp->gp_seq == rnp->gp_seq)
> > +	if (!rcu_seq_changed(rdp->gp_seq, rnp->gp_seq))
> 
> The old code would detect a bunch of elapsed grace periods, starting
> and ending in the same state.  The new code does not.  Does the new code
> correctly handle CPUs that go idle for many grace periods?

I'm not sure I understand what you mean. rcu_seq_changed() is a comparison
that simply clears RCU_SEQ_STARTED on both sides such that:

* Different GP numbers with or without RCU_SEQ_STARTED/RCU_SEQ_WAIT_QS
  are always considered a change.

* Same GP numbers but rnp has RCU_SEQ_WAIT_QS while rdp hasn't is considered a
  change

but:

* Same GP numbers but rnp has RCU_SEQ_STARTED while rdp hasn't is _NOT_
  considered a change. This is not for correctness but rather to spare
  rnp locking and useless work. The ->qsmask are 0 anyway so no QS can
  be reported too early.

> > @@ -1802,10 +1809,9 @@ static noinline_for_stack bool rcu_gp_init(void)
> >  	/* Advance to a new grace period and initialize state. */
> >  	record_gp_stall_check_time();
> >  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > -	rcu_seq_start(&rcu_state.gp_seq);
> > -	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> 
> Why are we dropping the ASSERT_EXCLUSIVE_WRITER()?  As opposed to moving
> it to the setting of the rcu_node structures' ->gp_seq updates?

I must confess I misunderstood that macro and thought it was to assert
the variable has no other writer _at all_. But that seem to apply
scopewise. So yes good point.

> > @@ -1902,7 +1908,10 @@ static noinline_for_stack bool rcu_gp_init(void)
> >  		rdp = this_cpu_ptr(&rcu_data);
> >  		rcu_preempt_check_blocked_tasks(rnp);
> >  		rnp->qsmask = rnp->qsmaskinit;
> > -		WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
> > +		if (!rnp->parent)
> > +			rcu_seq_wait_qs(&rnp->gp_seq);
> > +		else
> > +			WRITE_ONCE(rnp->gp_seq, *rcu_root_seq());
> 
> This asymmetry is necessary because if I understand correctly, the
> non-root rcu_node structures still have zero state.  But this is one
> argument for use of rcu_seq_set_state(), because then you could just do
> rcu_seq_set_state(rnp->gp_seq, RCU_STATE_WAIT_QS) in both cases.
> 
> Or am I missing something that prevents this from working?

Indeed, the sequence counter (but not the state) is expected to be the same on
all nodes, so we can just modify the state as you said. And we can then assert
WARN_ON_ONCE(rnp->gp_seq != *rcu_root_seq())

> > @@ -2114,16 +2124,12 @@ static noinline void rcu_gp_cleanup(void)
> >  	 * the rcu_node structures before the beginning of the next grace
> >  	 * period is recorded in any of the rcu_node structures.
> >  	 */
> > -	new_gp_seq = rcu_state.gp_seq;
> > -	rcu_seq_end(&new_gp_seq);
> >  	rcu_for_each_node_breadth_first(rnp) {
> >  		raw_spin_lock_irq_rcu_node(rnp);
> >  		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
> >  			dump_blkd_tasks(rnp, 10);
> >  		WARN_ON_ONCE(rnp->qsmask);
> > -		WRITE_ONCE(rnp->gp_seq, new_gp_seq);
> > -		if (!rnp->parent)
> > -			smp_mb(); // Order against failing poll_state_synchronize_rcu_full().
> 
> OK, this got moved up.
> 
> > +		WRITE_ONCE(rnp->gp_seq, *rcu_root_seq());
> 
> The idea being that the root rcu_node ->gp_seq is just overwritten
> with itself, correct?

Right!

> 
> >  		rdp = this_cpu_ptr(&rcu_data);
> >  		if (rnp == rdp->mynode)
> >  			needgp = __note_gp_changes(rnp, rdp) || needgp;
> > @@ -2146,9 +2152,7 @@ static noinline void rcu_gp_cleanup(void)
> >  	raw_spin_lock_irq_rcu_node(rnp); /* GP before ->gp_seq update. */
> >  
> >  	/* Declare grace period done, trace first to use old GP number. */
> > -	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
> > -	rcu_seq_end(&rcu_state.gp_seq);
> > -	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> 
> Same question on not moving ASSERT_EXCLUSIVE_WRITER() to the rcu_node
> structures' ->gp_seq updates.

Indeed!

> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index a9a811d9d7a3..9d811270b808 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -347,7 +347,6 @@ struct rcu_state {
> >  
> >  	/* The following fields are guarded by the root rcu_node's lock. */
> >  
> > -	unsigned long gp_seq ____cacheline_internodealigned_in_smp;
> >  						/* Grace-period sequence #. */
> 
> Heh!  Does the rcu_node structure's ->gp_seq need alignment?

Probably but then this will increase the size of all rnp's, right?

Thanks!
