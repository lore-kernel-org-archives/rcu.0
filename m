Return-Path: <SRS0=OxHY=4G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E4EC34044
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C515222B48
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 16:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582043646;
	bh=k6r7kW/VRYWSj/+4iFogeBzp0brmIrHpaYxLxUwi880=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=j8hKixl3XE1hq4dKotQY0uO3yDocj5Do9UKDK/nK+7cyJx6Jl/WwE7OaAWYnftlPi
	 oyBbgZlIjj05FikQ7UhR2lmCqB25zEUlHJNZnwrzYx9mDso4YSTUhifSdWHXznajE0
	 jeoLmz8p0tRBB8NU1+bpHJZEw18El+59lVJ4DrLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgBRQeG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:34:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgBRQeG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 11:34:06 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8238A2067D;
        Tue, 18 Feb 2020 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582043645;
        bh=k6r7kW/VRYWSj/+4iFogeBzp0brmIrHpaYxLxUwi880=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nSQoAZS9Bz6zOOsa52dFQooE6a4TYCI7Eh5tRmUKLuk9+aPKKgUxvFhCnaJZssR5t
         nbdi5lupCJ7tad1IcRPM7HK7VSAVsbgEV7SQqJ3WoXVA9lVEZPZa03sXk5CTnazrlA
         Jwug8B7g3LnL4h5ChKEoh+/Ve6ifcoj5q9vt90zs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 57E883520365; Tue, 18 Feb 2020 08:34:05 -0800 (PST)
Date:   Tue, 18 Feb 2020 08:34:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 4/4] srcu: Add READ_ONCE() to srcu_struct
 ->srcu_gp_seq load
Message-ID: <20200218163405.GF2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
 <20200215002932.15976-4-paulmck@kernel.org>
 <20200217124507.GT14914@hirez.programming.kicks-ass.net>
 <20200217183220.GS2935@paulmck-ThinkPad-P72>
 <20200218114334.GX14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218114334.GX14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 18, 2020 at 12:43:34PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 17, 2020 at 10:32:20AM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 17, 2020 at 01:45:07PM +0100, Peter Zijlstra wrote:
> > > On Fri, Feb 14, 2020 at 04:29:32PM -0800, paulmck@kernel.org wrote:
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > 
> > > > The load of the srcu_struct structure's ->srcu_gp_seq field in
> > > > srcu_funnel_gp_start() is lockless, so this commit adds the requisite
> > > > READ_ONCE().
> > > > 
> > > > This data race was reported by KCSAN.
> > > 
> > > But is there in actual fact a data-race? AFAICT this code was just fine.
> > 
> > Now that you mention it, the lock is held at that point, isn't it?  So if
> > that READ_ONCE() actually does anything, there is a bug somewhere else.
> > 
> > Good catch, I will drop this patch, thank you!
> 
> Well, I didn't get further than the Changelog fails to describe an
> actual problem and it looks like compare-against-a-constant.
> 
> (worse, it masks off everything but the 2 lowest bits, so even if there
> was a problem with load-tearing, it still wouldn't matter)

There is still the possibility of load fusing.  And the possibility
of defending against possible future changes as well as the current
snapshot of the code base.

> I'm not going to argue with you if you want to use READ_ONCE() vs
> data_race() and a comment to denote false-positive KCSAN warnings, but I
> do feel somewhat strongly that the Changelog should describe the actual
> problem -- if there is one -- or just flat out state that this is to
> make KCSAN shut up but the code is fine.

The problem is that "the code is fine" is highly subjective and varies
over time.  :-/

But in this case there was a real problem, just that I got confused
when analyzing.

> That is; every KCSAN report should be analysed, right? All I'm asking is
> for that analysis to end up in the Changelog.

Before responding further, I have to ask...

Are you intending your "every KCSAN report should be analyzed" to apply
globally or just when someone creates a patch based on such a report?

In any case, you have acked this patch's successor (thank you very
much!), so on this specific patch (or more accurately, its successor)
I presume that we are all good.

							Thanx, Paul

> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >  kernel/rcu/srcutree.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 119a373..90ab475 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -678,7 +678,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > > >  
> > > >  	/* If grace period not already done and none in progress, start it. */
> > > >  	if (!rcu_seq_done(&ssp->srcu_gp_seq, s) &&
> > > > -	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
> > > > +	    rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_IDLE) {
> > > >  		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
> > > >  		srcu_gp_start(ssp);
> > > >  		if (likely(srcu_init_done))
> > > > -- 
> > > > 2.9.5
> > > > 
