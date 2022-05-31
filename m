Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34BDC433F5
	for <rcu@archiver.kernel.org>; Tue, 31 May 2022 16:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346212AbiEaQpk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 May 2022 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbiEaQpj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 May 2022 12:45:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBC47B9E0
        for <rcu@vger.kernel.org>; Tue, 31 May 2022 09:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51E48B810E8
        for <rcu@vger.kernel.org>; Tue, 31 May 2022 16:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B88C385A9;
        Tue, 31 May 2022 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654015535;
        bh=NdFDKN6tLLtpoqCTHZs9ynTanVEwnQSNwTpfRrighTg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ieq3lcoKs4eqhtRR4dGwgeBumLGxXQe3dPmVoEuHTDLy2860xk7HyV9tjJGNkeft2
         gX97gkLrkWYSRF1K/YpEYlXFDB1ICOtegyHElooJv9S323iVaig86+/ODZr7+rAdkh
         Tui/sRjSYiC93b4uooErKmcoJSJg+trO4qnFwB5X0DAQ470/+5SlzpIHbXfVpfr5lR
         3gpRDYkqNNAFcY+4hNb042NXeiGamRfUsLZnVo+UYT7gcNJpheUjV94a7VZkfESjhA
         htadVLLstETYMUldxso9YSE46cEBS67FadKqMvLSV1GWcZ9yr0P4ktmDbzIVsoY11J
         hefgf8GX681aA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 906425C02A9; Tue, 31 May 2022 09:45:34 -0700 (PDT)
Date:   Tue, 31 May 2022 09:45:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
Message-ID: <20220531164534.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512235603.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yn/F8V5kYR8fybPV@google.com>
 <20220514163421.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <YpFawyhgLCj1+X1A@google.com>
 <20220528175735.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <a945a7d1-fc4f-2ca5-8820-c08579f564e4@joelfernandes.org>
 <20220530164203.GB1790663@paulmck-ThinkPad-P17-Gen-1>
 <0da0d321-7007-2c19-7f85-11d6ef8fed1f@joelfernandes.org>
 <20220531042624.GF1790663@paulmck-ThinkPad-P17-Gen-1>
 <6def6fce-13e2-7b80-467f-56a33124d67f@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6def6fce-13e2-7b80-467f-56a33124d67f@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, May 31, 2022 at 12:11:00PM -0400, Joel Fernandes wrote:
> On 5/31/22 00:26, Paul E. McKenney wrote:
> [...]
> >>>>> Which means that
> >>>>> 	apples to apples evaluation is also required.  But this is the
> >>>>> 	information I currently have at hand, and it is probably no more
> >>>>> 	than a factor of two off of what would be seen on ChromeOS.
> >>>>>
> >>>>> 	Or is there some ChromeOS data that tells a different story?
> >>>>> 	After all, for all I know, Android might still be expediting
> >>>>> 	all normal grace periods.
> >>>>>
> >>>>> At which point, the question becomes "how to make up that 7%?" After all,
> >>>>> it is not likely that anyone is going to leave that much battery lifetime
> >>>>> on the table.  Here are the possibilities that I currently see:
> >>>>>
> >>>>> o	Slow down grace periods, and also bite the bullet and make
> >>>>> 	userspace changes to speed up the RCU grace periods during
> >>>>> 	critical operations.
> >>>>
> >>>> We tried this, and tracing suffers quiet a lot. The system also felt
> >>>> "sluggish" which I suspect is because of synchronize_rcu() slow downs in
> >>>> other paths.
> >>>
> >>> In what way does tracing suffer?  Removing tracepoints?
> >>
> >> Yes. Start and stopping function tracer goes from 5 seconds to like 30
> >> seconds or so.
> >>
> >>> And yes, this approach absolutely requires finding code paths with
> >>> user-visible grace periods.  Which sounds like you tried the "Slow down
> >>> grace periods" part but not the "bit the bullet" part.  ;-)
> >>
> >> True, I got so scared looking at the performance that I just decided to
> >> play it safe and do selective call_rcu() lazifying, than making the
> >> everything lazy.
> > 
> > For what definition of "safe", exactly?  ;-)
> 
> I mean the usual, like somebody complaining performance issues crept up
> in their workload :)

It is not that difficult.  Just do something like this:

	# run a statistically significant set of tracer tests
	echo 1 >  /sys/kernel/rcu_expedited
	# run a statistically significant set of tracer tests

It is quite possible that you will decide that you want grace periods
to be expedited during tracing operations even on non-battery-powered
systems.

> >>> On the flush-time mismatch, if there are any non-lazy callbacks in the
> >>> list, it costs you nothing to let the lazy callbacks tag along through
> >>> the grace period.  So one approach would be to use the current flush
> >>> time if there are non-lazy callbacks, but use the longer flush time if
> >>> all of the callbacks in the list are lazy callbacks.
> >>
> >> Cool!
> >>
> >>>>> 	o	If so:
> >>>>>
> >>>>> 		o	Use segmented list with marked grace periods?
> >>>>> 			Keep in mind that such a list can track only
> >>>>> 			two grace periods.
> >>>>>
> >>>>> 		o	Use a plain list and have grace-period start
> >>>>> 			simply drain the list?
> >>>>
> >>>> I want to use the segmented list, regardless of whether we use the
> >>>> bypass list or not, because we get those memory barriers and
> >>>> rcu_barrier() lockless sampling of ->len, for free :).
> >>>
> >>> The bypass list also gets you the needed memory barriers and lockless
> >>> sampling of ->len.  As does any other type of list as long as the
> >>> ->cblist.len field accounts for the lazy callbacks.
> >>>
> >>> So the main difference is the tracking of grace periods, and even then,
> >>> only those grace periods for which this CPU has no non-lazy callbacks.
> >>> Or, in the previously discussed case where a single rcuoc kthread serves
> >>> multiple CPUs, only those grace periods for which this group of CPUs
> >>> has no non-lazy callbacks.
> >>
> >> Unless we assume that everything in the bypass list is lazy, can we
> >> really use it to track both lazy and non lazy CBs, and grace periods?
> > 
> > Why not just count the number of lazy callbacks in the bypass list?
> > There
> > is already a count of the total number of callbacks in ->nocb_bypass.len.
> > This list is protected by a lock, so protect the count of lazy callbacks
> > with that same lock.  
> 
> That's a good idea, I can try that.
> 
> Then just compare the number of lazy callbacks to
> > rcu_cblist_n_cbs(&rdp->nocb_bypass).  If they are equal, all callbacks
> > are lazy.
> > 
> > What am I missing here?
> 
> There could be more issues that are incompatible with bypass lists, but
> nothing that I feel cannot be worked around.

Good!

> Example:
> 1. Say 5 lazy CBs queued onto bypass list (while the regular cblist is
> empty).
> 2. Now say 10000 non-lazy CBs are queued. As per the comments, these
> have to go to the bypass list to keep rcu_barrier() from breaking.
> 3. Because this causes the bypass list to overflow, all the lazy +
> non-lazy CBs have to flushed to the main -cblist.
> 
> If only the non-lazy CBs are flushed, rcu_barrier() might break. If all
> are flushed, then the lazy ones lose their laziness property as RCU will
> be immediately kicked off to process GPs on their behalf.

Exactly why is this loss of laziness a problem?  You are doing that
grace period for the 10,000 non-lazy callbacks anyway, so what difference
could the five non-lazy callbacks possibly make?

> This can fixed by making rcu_barrier() queue both a lazy and non-lazy
> CB, and only flushing the non-lazy CBs on a bypass list overflow, to the
> ->cblist, I think.

I don't see anything that needs fixing.  If you are doing a grace period
anyway, just process the lazy callbacks along with the non-lazy callbacks.
After all, you are paying for that grace period anyway.  And handling
the lazy callbacks with that grace period means that you don't need a
later grace period for those five lazy callbacks.  So running the lazy
callbacks into the grace period required by the non-lazy callbacks is
a pure win, right?

If it is not a pure win, please explain exactly what is being lost.

> Or, we flush both -lazy and non-lazy CBs to the ->cblist just to keep it
> simple. I think that should be OK since if there are a lot of CBs queued
> in a short time, I don't think there is much opportunity for power
> savings anyway IMHO.

I believe that it will be simpler, faster, and more energy efficient to
do it this way, flushing everything from the bypass list to ->cblist.
Again, leaving the lazy callbacks lying around means that there must be a
later battery-draining grace period that might not be required otherwise.

> >> Currently the struct looks like this:
> >>
> >> struct rcu_segcblist {
> >>         struct rcu_head *head;
> >>         struct rcu_head **tails[RCU_CBLIST_NSEGS];
> >>         unsigned long gp_seq[RCU_CBLIST_NSEGS];
> >> #ifdef CONFIG_RCU_NOCB_CPU
> >>         atomic_long_t len;
> >> #else
> >>         long len;
> >> #endif
> >>         long seglen[RCU_CBLIST_NSEGS];
> >>         u8 flags;
> >> };
> >>
> >> So now, it would need to be like this?
> >>
> >> struct rcu_segcblist {
> >>         struct rcu_head *head;
> >>         struct rcu_head **tails[RCU_CBLIST_NSEGS];
> >>         unsigned long gp_seq[RCU_CBLIST_NSEGS];
> >> #ifdef CONFIG_RCU_NOCB_CPU
> >>         struct rcu_head *lazy_head;
> >>         struct rcu_head **lazy_tails[RCU_CBLIST_NSEGS];
> >>         unsigned long lazy_gp_seq[RCU_CBLIST_NSEGS];
> >>         atomic_long_t lazy_len;
> >> #else
> >>         long len;
> >> #endif
> >>         long seglen[RCU_CBLIST_NSEGS];
> >>         u8 flags;
> >> };
> > 
> > I freely confess that I am not loving this arrangement.  Large increase
> > in state space, but little benefit that I can see.  Again, what am I
> > missing here?
> 
> I somehow thought tracking GPs separately for the lazy CBs requires
> duplication of the rcu_head pointers/double-points in this struct. As
> you pointed, just tracking the lazy len may be sufficient.

Here is hoping!

After all, if you thought that taking care of applications that need
expediting of grace periods is scary, well, now...

> >>> And on devices with few CPUs, wouldn't you make do with one rcuoc kthread
> >>> for the system, at least in the common case where there is no callback
> >>> flooding?
> >>
> >> When Rushikesh tried to reduce the number of callback threads, he did
> >> not see much improvement in power. I don't think the additional wake ups
> >> of extra rcuoc threads makes too much difference - the big power
> >> improvement comes from not even kicking rcu_preempt / rcuog threads...
> > 
> > I suspect that this might come into play later on.  It is often the case
> > that a given technique's effectiveness depends on the starting point.
> > 
> >>>>> o	Does call_rcu_lazy() do anything to ensure that additional grace
> >>>>> 	periods that exist only for the benefit of lazy callbacks are
> >>>>> 	maximally shared among all CPUs' lazy callbacks?  If so, what?
> >>>>> 	(Keeping in mind that failing to share such grace periods
> >>>>> 	burns battery lifetime.)
> >>>>
> >>>> I could be missing your point, can you give example of how you want the
> >>>> behavior to be?
> >>>
> >>> CPU 0 has 55 lazy callbacks and one non-lazy callback.  So the system
> >>> does a grace-period computation and CPU 0 wakes up its rcuoc kthread.
> >>> Given that the full price is begin paid anyway, why not also invoke
> >>> those 55 lazy callbacks?
> >>>
> >>> If the rcuoc kthread is shared between CPU 0 and CPU 1, and CPU 0 has 23
> >>> lazy callbacks and CPU 1 has 3 lazy callbacks and 2 non-lazy callbacks,
> >>> again the full price of grace-period computation and rcuoc wakeups is
> >>> being paid, so why not also invoke those 26 lazy callbacks?
> >>>
> >>> On the other hand, if CPU 0 uses one rcuoc kthread and CPU 1 some other
> >>> rcuoc kthread, and with the same numbers of callbacks as in the previous
> >>> paragraph, you get to make a choice.  Do you do an extra wakeup for
> >>> CPU 0's rcuoc kthread?  Or do you potentially do an extra grace-period
> >>> computation some time in the future?
> >>>
> >>> Suppose further that the CPU that would be awakened for CPU 0's rcuoc
> >>> kthread is already non-idle.  At that point, this wakeup is quite cheap.
> >>> Except that the wakeup-or-don't choice is made at the beginning of the
> >>> grace period, and that CPU's idleness at that point might not be all
> >>> that well correlated with its idleness at the time of the wakeup at the
> >>> end of that grace period.  Nevertheless, idleness statistics could
> >>> help trade off needless from-idle wakeups for needless grace periods.
> >>>
> >>> Which sound like a good reason to consolidate rcuoc processing on
> >>> non-busy systems.
> >>>
> >>> But more to the point...
> >>>
> >>> Suppose that CPUs 0, 1, and 2 all have only lazy callbacks, and that
> >>> RCU is otherwise idle.  We really want one (not three!) grace periods
> >>> to eventually handle those lazy callbacks, right?
> >>
> >> Yes. I think I understand you now, yes we do want to reduce the number
> >> of grace periods. But I think that is an optimization which is not
> >> strictly necessary to get the power savings this patch series
> >> demonstrates. To get the power savings shown here, we need all the RCU
> >> threads to be quiet as much as possible, and not start the rcu_preempt
> >> thread's state machine until when necessary.
> > 
> > I believe that it will be both an optimization and a simplification.
> > Again, if you have to start the grace-period machinery anyway, you might
> > as well take care of the lazy callbacks while you are at it.
> 
> Sure, sounds good. I agree with sharing grace periods instead of
> starting a new one..

As you say, sounds good.  ;-)

> >>>> I am not thinking of creating separate GP cycles just for lazy CBs. The
> >>>> GP cycle will be the same that non-lazy uses. A lazy CB will just record
> >>>> what is the current or last GP, and then wait. Once the timer expires,
> >>>> it will check what is the current or last GP. If a new GP was not
> >>>> started, then it starts a new GP.
> >>>
> >>> From my perspective, this new GP is in fact a separate GP just for lazy
> >>> callbacks.
> >>>
> >>> What am I missing here?
> >>
> >> I think my thought for power savings is slightly different from yours. I
> >> see lots of power savings when not even going to RCU when system is idle
> >> - that appears to be a lot like what the bypass list does - it avoids
> >> call_rcu() completely and does an early exit:
> >>
> >>         if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> >>                 return; // Enqueued onto ->nocb_bypass, so just leave.
> >>
> >> I think amortizing cost of grace period computation across lazy CBs may
> >> give power savings, but that is secondary to the goal of not even poking
> >> RCU (which an early exit like the above does). So maybe we can just talk
> >> about that goal first?
> > 
> > You completely lost me on this one.  My point is not to amortize the cost
> > of grace-period computation across the lazy CBs.  My point is instead
> > to completely avoid doing any extra grace-period computation for the
> > lazy CBs in cases where grace-period computations are happening anyway.
> > Of course, if there are no non-lazy callbacks, then there won't be
> > any happening-anyway grace periods, and then, yes, there will eventually
> > need to be a grace period specially for the benefit of the lazy
> > callbacks.
> > 
> > And taking this piecewise is unlikely to give good results, especially
> > given that workloads evolve over time, much though I understand your
> > desire for doing this one piece at a time.
> 
> Sure ok, I agree with you on that.

Very good!

> >>> Also, if your timer triggers the check, isn't that an additional potential
> >>> wakeup from idle?  Would it make sense to also minimize those wakeups?
> >>> (This is one motivation for grace periods to pick up lazy callbacks.)
> >>>
> >>>>                                   If a new GP was started but not
> >>>> completed, it can simply call_rcu(). If a new GP started and completed,
> >>>> it does not start new GP and just executes CB, something like that.
> >>>> Before the flush happens, if multiple lazy CBs were queued in the
> >>>> meanwhile and the GP seq counters moved forward, then all those lazy CBs
> >>>> will share the same GP (either not starting a new one, or calling
> >>>> call_rcu() to share the ongoing on, something like that).
> >>>
> >>> You could move the ready-to-invoke callbacks to the end of the DONE
> >>> segment of ->cblist, assuming that you also adjust rcu_barrier()
> >>> appropriately.  If rcu_barrier() is rare, you could simply flush whatever
> >>> lazy list before entraining the rcu_barrier() callback.
> >>
> >> Got it.
> >>
> >>>>> o	When there is ample memory, how long are lazy callbacks allowed
> >>>>> 	to sleep?  Forever?  If not forever, what feeds into computing
> >>>>> 	the timeout?
> >>>>
> >>>> Yeah, the timeout is fixed currently. I agree this is a good thing to
> >>>> optimize.
> >>>
> >>> First see what the behavior is.  If the timeout is long enough that
> >>> there is almost never a lazy-only grace period, then maybe a fixed
> >>> timeout is good enough.
> >>
> >> Ok.
> >>
> >>>>> o	What is used to determine when memory is low, so that laziness
> >>>>> 	has become a net negative?
> >>>>
> >>>> The assumption I think we make is that the shrinkers will constantly
> >>>> flush out lazy CBs if there is memory pressure.
> >>>
> >>> It might be worth looking at SPI.  That could help avoid a grace-period
> >>> wait when clearing out lazy callbacks.
> >>
> >> You mean PSI?
> > 
> > Yes, pressure stall information.  Apologies for my confusion!
> 
> Ok, I will look into it, thanks.

And I bet that RCU should be using it elsewhere as well.

> >>>>> o	What other conditions, if any, should prompt motivating lazy
> >>>>> 	callbacks?  (See above for the start of a grace period motivating
> >>>>> 	lazy callbacks.)
> >>>>>
> >>>>> In short, you need to cast your net pretty wide on this one.  It has
> >>>>> not yet been very carefully explored, so there are likely to be surprises,
> >>>>> maybe even good surprises.  ;-)
> >>>>
> >>>> Cool that sounds like some good opportunity to work on something cool ;-)
> >>>
> >>> Which comes back around to your point of needing evaluation of extra
> >>> RCU work.  Lots of tradeoffs between different wakeup sources and grace
> >>> periods.  Fine-grained views into the black box will be helpful.  ;-)
> >>
> >> Thanks for the conversations. I very much like the idea of using bypass
> >> list, but I am not sure if the current segcblist structure will support
> >> both lazy and non-lazy CBs. Basically, if it contains both call_rcu()
> >> and call_rcu_lazy() CBs, that means either all of them are lazy or all
> >> of them are not right? Unless we are also talking about making
> >> additional changes to rcu_segcblist struct to accomodate both types of CBs.
> > 
> > Do you need to do anything different to lazy callbacks once they have
> > been associated with a grace period has been started?  Your current
> > patch treats them the same.  If that approach continues to work, then
> > why do you need to track laziness downstream?
> 
> Yes I am confused a lot on this part. You are saying just tracking the
> "lazy ength" is sufficient to not have to kick off RCU machinery, and
> knowing exactly which CBs are lazy and which are not, is not needed
> right? If I misunderstood that, could you clarify what you mean by
> "track laziness downstream" ?

Pretty much.  What I am saying is that the concept of laziness is helpful
primarily while the callbacks are waiting for a grace period to start.
Lazy callbacks are much less aggressive about starting new grace periods
than are non-lazy callbacks.

But once the grace period has started, why treat them differently?
From what you said earlier, your testing thus far shows that the biggest
energy savings is delaying/merging grace periods rather than the details
of callback processing within and after the grace period, right?

And even if differences in callback processing are warranted, there are
lots of ways to make that happen, many of which do not require propagation
of per-callback laziness into and through the grace-period machinery.

							Thanx, Paul
