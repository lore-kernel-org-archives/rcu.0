Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB1377A87;
	Tue, 14 Jul 2026 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054892; cv=none; b=Ljh9zWfqIMBZtaKOkNrKLJPtFdDqxkccl6GeuUapKZR3PWkVa9kGOyGZ/F0kB8j9HlYabcO+ir/jDDq3tgWOB3pi/egTYxVMQU/6AKECyLnmotz9UROei80oFZjZ/EfALEP42yVfxTeYLpTv7Ai0PD4WrlukZ7ItUeLbvmAobEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054892; c=relaxed/simple;
	bh=xDhs119hlLnnoxEE4QZfPhKZt5KWdCzoPFsF5Uh/ioI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SB8bvGjZi9ppiviQnYWBsj1qpcO9fj6qcPAt54fzoPJV8Geo4I4xk2Nt2FgNFjMiYK4V4UipLabzDMNmH1NAlsAdTBl6lR+ibtbXDwwT/TWt3/qWcGm6PuBlPJxT5uCkDpkXMsq4FU37gq6lhtHZOduDeLc11HQ62XIoKD4PPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/wh+mky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/wh+mky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199C81F000E9;
	Tue, 14 Jul 2026 18:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784054889;
	bh=tBsCPNGlQr1jC1VTu3jp5lAE6aN7pzmTG4Z7u9yzEMU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=C/wh+mkyki0B8lUmjuTm/J7mGLVLrsb4KIrLFD40/G2i2dVL53xmlYSKowWgNvGUd
	 P5kPm4lYYP7zdqSllE9W+/zlOk0nyqWbGwkC6Hnwp9F7TM9S1P73BkoTVhTgvD7r3S
	 ZiWLWIYviVR2efdapxe4ItB5ibBttzOaRSTAdsUoGJlHlF3elQnUbtHPoJUNW4PZx3
	 UII4MXvAonlxkmwIVIsl7edjPBmqsuSo7gg0PSm+YWSdmKd+CsGCCWy+sBXV6tiJUF
	 473GJkjOKncrsZyTTtXJw8Ix8byGaOgtOtCPiCQZlAbR7I515x/Ze7UCXKMcy6fy60
	 Qf4OITxUom9Kg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D5464CE054B; Tue, 14 Jul 2026 11:48:08 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:48:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v1 06/11] rcu: Enable RCU callbacks to benefit from
 expedited grace periods
Message-ID: <6c683413-8e8b-4888-ba01-9d79c3867432@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-7-puranjay@kernel.org>
 <alD6o01ukyliCS37@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alD6o01ukyliCS37@localhost.localdomain>

On Fri, Jul 10, 2026 at 03:58:59PM +0200, Frederic Weisbecker wrote:
> Le Wed, Jun 24, 2026 at 06:23:48AM -0700, Puranjay Mohan a écrit :
> > Currently, RCU callbacks only track normal grace-period sequence
> > numbers.  This means callbacks must wait for normal grace periods to
> > complete even when expedited grace periods have already elapsed.
> > 
> > Use the full struct rcu_gp_seq (which tracks both the normal and
> > expedited grace-period sequences) throughout the callback
> > infrastructure.
> > 
> > rcu_segcblist_advance() now checks both normal and expedited GP
> > completion via poll_state_synchronize_rcu_full(), and becomes
> > parameterless since it reads the grace-period state internally.
> > rcu_segcblist_accelerate() stores the full state (both sequences)
> > instead of just the normal one.  rcu_accelerate_cbs() and
> > rcu_accelerate_cbs_unlocked() use get_state_synchronize_rcu_full() to
> > capture both sequences, and the NOCB advance checks use
> > poll_state_synchronize_rcu_full() instead of comparing only the normal
> > sequence.
> > 
> > srcu_segcblist_advance() becomes a standalone implementation because it
> > compares SRCU sequences directly and cannot use
> > poll_state_synchronize_rcu_full(), which reads RCU-specific globals.
> > srcu_segcblist_accelerate() sets the ->exp field to
> > RCU_GET_STATE_NOT_TRACKED so that poll_state_synchronize_rcu_full()
> > compares only ->norm and ignores ->exp.
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/rcu/rcu_segcblist.c | 30 +++++++++++++++++++++++-------
> >  kernel/rcu/rcu_segcblist.h |  2 +-
> >  kernel/rcu/tree.c          |  9 +++------
> >  kernel/rcu/tree_nocb.h     | 33 +++++++++++++++++++++++----------
> >  4 files changed, 50 insertions(+), 24 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index 4e3dfe42bc097..cf8951d33e767 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/types.h>
> >  
> > +#include "rcu.h"
> >  #include "rcu_segcblist.h"
> >  
> >  /* Initialize simple callback list. */
> > @@ -494,9 +495,9 @@ static void rcu_segcblist_advance_compact(struct rcu_segcblist *rsclp, int i)
> >  
> >  /*
> >   * Advance the callbacks in the specified rcu_segcblist structure based
> > - * on the current value passed in for the grace-period counter.
> > + * on the current value of the grace-period counter.
> >   */
> > -void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp)
> > +void rcu_segcblist_advance(struct rcu_segcblist *rsclp)
> >  {
> >  	int i;
> >  
> > @@ -509,7 +510,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp)
> >  	 * are ready to invoke, and put them into the RCU_DONE_TAIL segment.
> >  	 */
> >  	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
> > -		if (ULONG_CMP_LT(gsp->norm, rsclp->gp_seq[i].norm))
> > +		if (!poll_state_synchronize_rcu_full(&rsclp->gp_seq[i]))
> 
> So after more careful review, the smp_mb() at the end of a successful
> poll_state_synchronize_rcu_full() is necessary here because the current locking
> is not enough to make sure we synchronize against the end of the grace period.
> 
> But what about the smp_mb() at the beginning? Paul what is the point of this one
> already? It advertizes to pair with the smp_mb() on root cleanup but what
> exactly is to be ordered here? Why does gp cleanup need to synchronize with
> failing poll_state_synchronize_rcu_full() ? The smp_mb() before rcu_seq_snap()
> in get_state_synchronize_rcu_full() should already synchronize the accesses
> before that call against the beginning of the grace period.
> 
> If we keep all these barriers around and both RCU_WAIT_TAIL and RCU_NEXT_READY
> need to be advanced, that makes 4 smp_mb() calls.

Apologies for the delay, I missed this one.

You are right that if poll_state_synchronize_rcu_full() fails we don't
need ordering.  Especially given that poll_state_synchronize_rcu()
doesn't have this first memory barrier.

This fits in with get_state_synchronize_full() emulating a call to
synchronize_rcu() and poll_state_synchronize_rcu_full() emulating the
return from synchronize_rcu().  So get_state_synchronize_full() has
its smp_mb() at the beginning and poll_state_synchronize_rcu_full()
at the end.

The only rationale I can give for that initial smp_mb() is that in
the comment, but it makes no sense because the code prior to the call
to poll_state_synchronize_rcu_full() cannot know whether or not this
function will return false.

Puranjay, are you going to remove this smp_mb(), or would you prefer
that I do so?

> > @@ -637,14 +638,29 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
> >  
> >  void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
> >  {
> > -	struct rcu_gp_seq gs = { .norm = seq };
> > +	int i;
> > +
> > +	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
> > +	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
> > +		return;
> > +
> > +	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
> > +		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i].norm))
> > +			break;
> 
> Why not use the same API here and consolidate the code? ->exp is RCU_GET_STATE_NOT_TRACKED so it's
> harmless?
> 
> > @@ -1164,7 +1164,7 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
> >  	 * accelerating callback invocation to an earlier grace-period
> >  	 * number.
> >  	 */
> > -	gs.norm = rcu_seq_snap(&rcu_state.gp_seq);
> > +	get_state_synchronize_rcu_full(&gs);
> 
> I have similar concerns about the three smp_mb() in
> get_state_synchronize_rcu_full(). It could be just two (rcu_seq_snap()
> has a barrier that could be just one). Not sure if that matters but,
> just wanted to point that.

We need the one at the beginning of get_state_synchronize_rcu_full(),
but from what I can see, not the ones in the calls to rcu_seq_snap().
I blame laziness.  We could make an rcu_seq_snap_no_ordering() that
didn't have the smp_mb(), but I didn't believe that the overhead would
be visible at the system level.

							Thanx, Paul

> Thanks.
> 
> -- 
> Frederic Weisbecker
> SUSE Labs
