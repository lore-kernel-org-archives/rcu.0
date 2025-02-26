Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103672206A4;
	Wed, 26 Feb 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582269; cv=none; b=U62TNoTXr2cHAhyKRjRwob6DgjbAh6AIrREDxaJM8CkraRBljqWC1EOskOzatQ7IV4DrF0c9s4BxWe711syBlASrHiojaz7d4j6roghFAjEucgMWOe+MN0MH2GRmD0ifOwvTyw6mQBWKORGHmC8bpCe+Ms/TsSEZsfkLPnS0/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582269; c=relaxed/simple;
	bh=Kd2BF1a6VfS2P8GI8jSZHLKC/prjfy/cW+xW96oUPs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3SatLrXiQKYA29Zf3loLxOvVtLtHFJNHeavjpBwe8qgLP0h0WFHVxu4eK7klmKhvysUODS18apiVUeRQHIoF58JofzxlxHEMCmpjQQ51fqnZNEh8H5gYCg0mkaFf+DoVbDakvxwArzCtdIc02+V/3VlU1hqoY79D5YPVHCW9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5gj1+Nd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5gj1+Nd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73661C4CED6;
	Wed, 26 Feb 2025 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740582268;
	bh=Kd2BF1a6VfS2P8GI8jSZHLKC/prjfy/cW+xW96oUPs0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=j5gj1+NdHNNtjJ+PLc+5MU4pc/MW1xuzZ5iP0afNu7QWcW57kLslhnjSmPMpSOCFj
	 +0F08Wxpi1wt7gdJ9tE87GPGoq4/eFZ2ulbvjhtR5xIsGBlg71z/wIIhgaav/S7ZRy
	 7uM0RJU9evju4ilIY6mCW6Apky4z8vZoalle5EzALiTHr8Mw2cQArT2sIGVtevFTGb
	 xT9VyrfI2kxWZABSJKifYb+TZBIpI9Q4f+AfK6kaBUUVyjKUezWbYDDTdvimhFZ9pM
	 SpLl7iAtDE/Yaz37Tfn9gjXNhyXmLKsjIQX/pHTr2QWb0fszibFYpOooc8Pux+wcgB
	 FY7LDzH2btduw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 11D50CE04E3; Wed, 26 Feb 2025 07:04:28 -0800 (PST)
Date: Wed, 26 Feb 2025 07:04:28 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/3] rcu/exp: Remove confusing needless full barrier on
 task unblock
Message-ID: <63cbab19-a7d4-4daa-8b54-58665e159e23@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-3-frederic@kernel.org>
 <20250225215908.GA1812344@joelnvbox>
 <Z78OeeyarjDB63Dj@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z78OeeyarjDB63Dj@localhost.localdomain>

On Wed, Feb 26, 2025 at 01:52:09PM +0100, Frederic Weisbecker wrote:
> Le Tue, Feb 25, 2025 at 04:59:08PM -0500, Joel Fernandes a écrit :
> > On Fri, Feb 14, 2025 at 12:25:58AM +0100, Frederic Weisbecker wrote:
> > > A full memory barrier in the RCU-PREEMPT task unblock path advertizes
> > > to order the context switch (or rather the accesses prior to
> > > rcu_read_unlock()) with the expedited grace period fastpath.
> > > 
> > > However the grace period can not complete without the rnp calling into
> > > rcu_report_exp_rnp() with the node locked. This reports the quiescent
> > > state in a fully ordered fashion against updater's accesses thanks to:
> > > 
> > > 1) The READ-SIDE smp_mb__after_unlock_lock() barrier accross nodes
> > >    locking while propagating QS up to the root.
> > > 
> > > 2) The UPDATE-SIDE smp_mb__after_unlock_lock() barrier while holding the
> > >    the root rnp to wait/check for the GP completion.
> > > 
> > > 3) The (perhaps redundant given step 1) and 2)) smp_mb() in rcu_seq_end()
> > >    before the grace period completes.
> > > 
> > > This makes the explicit barrier in this place superflous. Therefore
> > > remove it as it is confusing.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > ---
> > >  kernel/rcu/tree_plugin.h | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 3c0bbbbb686f..d51cc7a5dfc7 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -534,7 +534,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
> > >  		WARN_ON_ONCE(rnp->completedqs == rnp->gp_seq &&
> > >  			     (!empty_norm || rnp->qsmask));
> > >  		empty_exp = sync_rcu_exp_done(rnp);
> > > -		smp_mb(); /* ensure expedited fastpath sees end of RCU c-s. */
> > 
> > I was wondering though, this is a slow path and the smp_mb() has been there
> > since 2009 or so. Not sure if it is super valuable to remove it at this
> > point. But we/I should definitely understand it.
> 
> The point is indeed not to improve performance because this is a slowpath
> (although...). The main goal is to maintain a clear picture of the ordering
> without needless barriers that leave a taste of doubt to reviewers.

Agreed!

> > I was wondering if you could also point to the fastpath that this is racing
> > with, it is not immediately clear (to me) what this smp_mb() is pairing with
> > :(
> 
> It is supposed to pair with the barrier in sync_exp_work_done() but then again
> this is already enforced by the smp_mb__after_unlock_lock() chained through
> rnp locking.

You could interpret that "Order GP completion with preceding accesses"
to include preceding readers, which to your point sounds plausible.
And in that case, again as you say, the raw_spin_lock_irqsave_rcu_node()
in rcu_report_exp_rnp() provides the needed ordering.

I think.  ;-)

							Thanx, Paul

> Thanks.
> 
> > 
> > thanks,
> > 
> >  - Joel
> > 
> > 
> > 
> > 
> > 
> > >  		np = rcu_next_node_entry(t, rnp);
> > >  		list_del_init(&t->rcu_node_entry);
> > >  		t->rcu_blocked_node = NULL;
> > > -- 
> > > 2.46.0
> > > 
