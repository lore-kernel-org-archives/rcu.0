Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A01C2D0E4
	for <rcu@archiver.kernel.org>; Sat, 21 Nov 2020 00:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2D324101
	for <rcu@archiver.kernel.org>; Sat, 21 Nov 2020 00:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/HPaav5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgKUAQE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:16:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbgKUAQD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 19:16:03 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B077323A65;
        Sat, 21 Nov 2020 00:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605917762;
        bh=Ph+nirMBRPFi1/13F86NjBTFLhghHai7VGbL9o+UDmA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a/HPaav5oPfuqb3K7kKlrbkvjhKExrICRKQA4MGt4d2SfWQj7zDaegBmqtXyt2dvo
         lAshbCQOVtWnVi6K6oZpH96O87Pw36xdwwC8KEEhby+M3KprlnpfN8SXISkaODkrSY
         5bpBv0Vyc23dkYwN//6uWfco2WVjUjX1uaOzpGXQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6A9E83522A6E; Fri, 20 Nov 2020 16:16:02 -0800 (PST)
Date:   Fri, 20 Nov 2020 16:16:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 5/5] srcu: Provide polling interfaces
 for Tree SRCU grace periods
Message-ID: <20201121001602.GO1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201117004017.GA7444@paulmck-ThinkPad-P72>
 <20201117004052.14758-5-paulmck@kernel.org>
 <dca110ff-81d1-17b6-06d9-0fdd61363465@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dca110ff-81d1-17b6-06d9-0fdd61363465@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 20, 2020 at 05:31:43PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 11/17/2020 6:10 AM, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > There is a need for a polling interface for SRCU grace
> > periods, so this commit supplies get_state_synchronize_srcu(),
> > start_poll_synchronize_srcu(), and poll_state_synchronize_srcu() for this
> > purpose.  The first can be used if future grace periods are inevitable
> > (perhaps due to a later call_srcu() invocation), the second if future
> > grace periods might not otherwise happen, and the third to check if a
> > grace period has elapsed since the corresponding call to either of the
> > first two.
> > 
> > As with get_state_synchronize_rcu() and cond_synchronize_rcu(),
> > the return value from either get_state_synchronize_srcu() or
> > start_poll_synchronize_srcu() must be passed in to a later call to
> > poll_state_synchronize_srcu().
> > 
> > Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
> > Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
> > [ paulmck: Add EXPORT_SYMBOL_GPL() per kernel test robot feedback. ]
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >   kernel/rcu/srcutree.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 60 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index d930ece..015d80e 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -810,7 +810,8 @@ static void srcu_leak_callback(struct rcu_head *rhp)
> >   /*
> >    * Start an SRCU grace period, and also queue the callback if non-NULL.
> >    */
> > -static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rhp, bool do_norm)
> > +static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> > +					     struct rcu_head *rhp, bool do_norm)
> >   {
> >   	unsigned long flags;
> >   	int idx;
> > @@ -822,7 +823,8 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
> >   	idx = srcu_read_lock(ssp);
> >   	sdp = raw_cpu_ptr(ssp->sda);
> >   	spin_lock_irqsave_rcu_node(sdp, flags);
> > -	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
> > +	if (rhp)
> > +		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
> >   	rcu_segcblist_advance(&sdp->srcu_cblist,
> >   			      rcu_seq_current(&ssp->srcu_gp_seq));
> >   	s = rcu_seq_snap(&ssp->srcu_gp_seq);
> > @@ -841,6 +843,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
> >   	else if (needexp)
> >   		srcu_funnel_exp_start(ssp, sdp->mynode, s);
> >   	srcu_read_unlock(ssp, idx);
> > +	return s;
> >   }
> >   /*
> > @@ -882,7 +885,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> >   		return;
> >   	}
> >   	rhp->func = func;
> > -	srcu_gp_start_if_needed(ssp, rhp, do_norm);
> > +	(void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
> >   }
> >   /**
> > @@ -1011,6 +1014,60 @@ void synchronize_srcu(struct srcu_struct *ssp)
> >   }
> >   EXPORT_SYMBOL_GPL(synchronize_srcu);
> > +/**
> > + * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
> > + * @ssp: srcu_struct to provide cookie for.
> > + *
> > + * This function returns a cookie that can be passed to
> > + * poll_state_synchronize_srcu(), which will return true if a full grace
> > + * period has elapsed in the meantime.  It is the caller's responsibility
> > + * to make sure that grace period happens, for example, by invoking
> > + * call_srcu() after return from get_state_synchronize_srcu().
> > + */
> > +unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)
> > +{
> > +	// Any prior manipulation of SRCU-protected data must happen
> > +        // before the load from ->srcu_gp_seq.
> > +	smp_mb();
> > +	return rcu_seq_snap(&ssp->srcu_gp_seq);
> > +}
> > +EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
> > +
> > +/**
> > + * start_poll_synchronize_srcu - Provide cookie and start grace period
> > + * @ssp: srcu_struct to provide cookie for.
> > + *
> > + * This function returns a cookie that can be passed to
> > + * poll_state_synchronize_srcu(), which will return true if a full grace
> > + * period has elapsed in the meantime.  Unlike get_state_synchronize_srcu(),
> > + * this function also ensures that any needed SRCU grace period will be
> > + * started.  This convenience does come at a cost in terms of CPU overhead.
> > + */
> > +unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
> > +{
> > +	return srcu_gp_start_if_needed(ssp, NULL, true);
> > +}
> > +EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
> > +
> > +/**
> > + * poll_state_synchronize_srcu - Has cookie's grace period ended?
> > + * @ssp: srcu_struct to provide cookie for.
> > + * @cookie: Return value from get_state_synchronize_srcu() or start_poll_synchronize_srcu().
> > + *
> > + * This function takes the cookie that was returned from either
> > + * get_state_synchronize_srcu() or start_poll_synchronize_srcu(), and
> > + * returns @true if an SRCU grace period elapsed since the time that the
> > + * cookie was created.
> > + */
> > +bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
> > +{
> > +	if (!rcu_seq_done(&ssp->srcu_gp_seq, cookie))
> > +		return false;
> > +	smp_mb(); // ^^^
> 
> Minor: Should this comment be more descriptive?

You have to read between the lines?  ;-)

How about like this?

							Thanx, Paul

------------------------------------------------------------------------

bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
{
	if (!rcu_seq_done(&ssp->srcu_gp_seq, cookie))
		return false;
	// Ensure that the end of the SRCU grace period happens before
	// any subsequent code that the caller might execute.
	smp_mb(); // ^^^
	return true;
}
