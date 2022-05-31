Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3FBC433F5
	for <rcu@archiver.kernel.org>; Tue, 31 May 2022 04:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243813AbiEaE0c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 May 2022 00:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbiEaE0b (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 May 2022 00:26:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1432179811
        for <rcu@vger.kernel.org>; Mon, 30 May 2022 21:26:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F2E60CE129A
        for <rcu@vger.kernel.org>; Tue, 31 May 2022 04:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E47C385A9;
        Tue, 31 May 2022 04:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653971185;
        bh=GXQzmzUnSjO+uYQeLRSc29QUIK7KEWdx+/zz9Cr7Q+E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ugsz0+nMBmMLxE7WnPWQLiJe41XN5fzuq7s/MyDC2RKHa+Ppq+XcRqC31HgW/xdbB
         rUdHJSQJZyOBEuUFbDa74NsvOK7K4sL5N6WtNiaG4Lfdw8mfI/KqZ86DjkjbEXxmNj
         6+BP80EiXoMZWPMQK6l3FlXlKGStU4XrJLKFiYqFlTBIP1qgrnvI1YwpKWHKQSBrm0
         Yhm9trDmfHGTDBtBiYSftqHfIR3/duIn4glW0GckHiwlAOPrzWrl5A8iHriS8Jgmur
         fVIyhpLWREvx9qKFCBCWBWCKtnd4kBuOtXH9Uq8JDRePVVPup3LsL1hIhR6BKU5+r3
         qsD/K7iG7iy8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CD72F5C0510; Mon, 30 May 2022 21:26:24 -0700 (PDT)
Date:   Mon, 30 May 2022 21:26:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
Message-ID: <20220531042624.GF1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-2-joel@joelfernandes.org>
 <20220512235603.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yn/F8V5kYR8fybPV@google.com>
 <20220514163421.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <YpFawyhgLCj1+X1A@google.com>
 <20220528175735.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <a945a7d1-fc4f-2ca5-8820-c08579f564e4@joelfernandes.org>
 <20220530164203.GB1790663@paulmck-ThinkPad-P17-Gen-1>
 <0da0d321-7007-2c19-7f85-11d6ef8fed1f@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da0d321-7007-2c19-7f85-11d6ef8fed1f@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 30, 2022 at 10:12:05PM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> I am sending in one more reply before I sleep ;-)

Likewise.  ;-)

> On 5/30/22 12:42, Paul E. McKenney wrote:
> > On Mon, May 30, 2022 at 10:48:26AM -0400, Joel Fernandes wrote:
> >> Hi Paul,
> >>
> >> I just setup thunderbird on an old machine just to reply to LKML.
> >> Apologies if the formatting is weird. Replies below:
> > 
> > Looks fine at first glance.  ;-)
> > 
> >> On 5/28/22 13:57, Paul E. McKenney wrote:
> >> [..]
> >>>>>>>> +	preempt_enable();
> >>>>>>>> +
> >>>>>>>> +	if (debug_rcu_head_queue((void *)head)) {
> >>>>>>>> +		// Probable double call_rcu(), just leak.
> >>>>>>>> +		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> >>>>>>>> +				__func__, head);
> >>>>>>>> +
> >>>>>>>> +		// Mark as success and leave.
> >>>>>>>> +		return;
> >>>>>>>> +	}
> >>>>>>>> +
> >>>>>>>> +	// Queue to per-cpu llist
> >>>>>>>> +	head->func = func;
> >>>>>>>> +	llist_add(&head->llist_node, &rlp->head);
> >>>>>>>
> >>>>>>> Suppose that there are a bunch of preemptions between the preempt_enable()
> >>>>>>> above and this point, so that the current CPU's list has lots of
> >>>>>>> callbacks, but zero ->count.  Can that cause a problem?
> >>>>>>>
> >>>>>>> In the past, this sort of thing has been an issue for rcu_barrier()
> >>>>>>> and friends.
> >>>>>>
> >>>>>> Thanks, I think I dropped the ball on this. You have given me something to
> >>>>>> think about. I am thinking on first thought that setting the count in advance
> >>>>>> of populating the list should do the trick. I will look more on it.
> >>>>>
> >>>>> That can work, but don't forget the need for proper memory ordering.
> >>>>>
> >>>>> Another approach would be to what the current bypass list does, namely
> >>>>> count the callback in the ->cblist structure.
> >>>>
> >>>> I have been thinking about this, and I also arrived at the same conclusion
> >>>> that it is easier to make it a segcblist structure which has the functions do
> >>>> the memory ordering. Then we can make rcu_barrier() locklessly sample the
> >>>> ->len of the new per-cpu structure, I *think* it might work.
> >>>>
> >>>> However, I was actually considering another situation outside of rcu_barrier,
> >>>> where the preemptions you mentioned would cause the list to appear to be
> >>>> empty if one were to rely on count, but actually have a lot of stuff queued.
> >>>> This causes shrinkers to not know that there is a lot of memory available to
> >>>> free. I don't think its that big an issue, if we can assume the caller's
> >>>> process context to have sufficient priority. Obviously using a raw spinlock
> >>>> makes the process context to be highest priority briefly but without the
> >>>> lock, we don't get that. But yeah that can be sorted by just updating the
> >>>> count proactively, and then doing the queuing operations.
> >>>>
> >>>> Another advantage of using the segcblist structure, is, we can also record
> >>>> the grace period numbers in it, and avoid triggering RCU from the timer if gp
> >>>> already elapsed (similar to the rcu-poll family of functions).
> >>>>
> >>>> WDYT?
> >>>
> >>> What you are seeing is that the design space for call_rcu_lazy() is huge,
> >>> and the tradeoffs between energy efficiency and complexity are not well
> >>> understood.  It is therefore necessary to quickly evaluate alternatives.
> >>> Yes, you could simply implement all of them and test them, but that
> >>> might you take longer than you would like.  Plus you likely need to
> >>> put in place more testing than rcutorture currently provides.
> >>>
> >>> Given what we have seen thus far, I think that the first step has to
> >>> be to evaluate what can be obtained with this approach compared with
> >>> what can be obtained with other approaches.  What we have right now,
> >>> more or less, is this:
> >>>
> >>> o	Offloading buys about 15%.
> >>>
> >>> o	Slowing grace periods buys about another 7%, but requires
> >>> 	userspace changes to prevent degrading user-visible performance.
> >>
> >> Agreed.
> >>
> >>>
> >>> o	The initial call_rcu_lazy() prototype buys about 1%.
> >>
> >> Well, that depends on the usecase. A busy system saves you less because
> >> it is busy anyway, so RCU being quiet does not help much.
> >>
> >> >From my cover letter, you can see the idle power savings is a whopping
> >> 29% with this patch series. Check the PC10 state residencies and the
> >> package wattage.
> >>
> >> When ChromeOS screen is off and user is not doing anything on the
> >> Before:
> >> Pk%pc10 = 72.13
> >> PkgWatt = 0.58
> >>
> >> After:
> >> Pk%pc10 = 81.28
> >> PkgWatt = 0.41
> > 
> > These numbers do make a better case for this.  On the other hand, that
> > patch series was missing things like rcu_barrier() support and might also
> > be converting more call_rcu() invocations to call_rcu_lazy() invocations.
> > It is therefore necessary to take these numbers with a grain of salt,
> > much though I hope that they turn out to be realistic.
> 
> Makes sense, thank you. Actually the promising savings showed up when
> also doing jiffies_till_first_fqs increases, so that's why I did the
> prototype of call_rcu_lazy to prove that we can achieve same thing
> instead of slowing GP for everything. I believe the savings comes from
> just not kicking the RCU GP machinery at all.

Agreed on reducing the number of grace periods.  After all, that is the
entire purpose of the earlier boot-parameter changes that slowed down
the grace periods.

But the other side of this same coin is that if the grace-period machinery
is being kicked anyway by some non-lazy callback, then making the lazy
callbacks take advantage of that forced grace period might well save
an entire grace period later on.  Take advantage of the one that is
happening anyway to possibly avoid having to do a full grace period
solely for the benefit of lazy callbacks later on.

> Agreed on the grain of salt part. Only a test of a final design can tell
> us more accurately what the savings are.

With careful experiment design, we can get bounds earlier.

> >>>
> >>> 	True, this is not apples to apples because the first two were
> >>> 	measured on ChromeOS and this one on Android.
> >>
> >> Yes agreed. I think Vlad is not seeing any jaw dropping savings, because
> >> he's testing ARM. But on Intel we see a lot. Though, I asked Vlad to
> >> also check if rcu callbacks are indeed not being quued / quiet after
> >> applying the patch, and if not then there may still be some call_rcu()s
> >> that need conversion to lazy, on his setup. For example, he might have a
> >> driver on his ARM platform that's queing RCU CBs constantly.
> >>
> >> I was thinking that perhaps a debug patch can help quickly nail down
> >> such RCU noise, in the way of a warning. Of course, debug CONFIG should
> >> never be enabled in production, so it would be something along the lines
> >> of how lockdep is used for debugging.
> > 
> > The trick would be figuring out which of the callbacks are noise.
> > I suspect that userspace help would be required.  Or maybe just leverage
> > the existing event traces and let userspace sort it out.
> 
> Ok.
> 
> >>> Which means that
> >>> 	apples to apples evaluation is also required.  But this is the
> >>> 	information I currently have at hand, and it is probably no more
> >>> 	than a factor of two off of what would be seen on ChromeOS.
> >>>
> >>> 	Or is there some ChromeOS data that tells a different story?
> >>> 	After all, for all I know, Android might still be expediting
> >>> 	all normal grace periods.
> >>>
> >>> At which point, the question becomes "how to make up that 7%?" After all,
> >>> it is not likely that anyone is going to leave that much battery lifetime
> >>> on the table.  Here are the possibilities that I currently see:
> >>>
> >>> o	Slow down grace periods, and also bite the bullet and make
> >>> 	userspace changes to speed up the RCU grace periods during
> >>> 	critical operations.
> >>
> >> We tried this, and tracing suffers quiet a lot. The system also felt
> >> "sluggish" which I suspect is because of synchronize_rcu() slow downs in
> >> other paths.
> > 
> > In what way does tracing suffer?  Removing tracepoints?
> 
> Yes. Start and stopping function tracer goes from 5 seconds to like 30
> seconds or so.
> 
> > And yes, this approach absolutely requires finding code paths with
> > user-visible grace periods.  Which sounds like you tried the "Slow down
> > grace periods" part but not the "bit the bullet" part.  ;-)
> 
> True, I got so scared looking at the performance that I just decided to
> play it safe and do selective call_rcu() lazifying, than making the
> everything lazy.

For what definition of "safe", exactly?  ;-)

> >>> But given this, one question is "What is the most you can possibly
> >>> obtain from call_rcu_lazy()?"  If you have a platform with enough
> >>> memory, one way to obtain an upper bound is to make call_rcu_lazy()
> >>> simply leak the memory.  If that amount of savings does not meet the
> >>> need, then other higher-level approaches will be needed, whether
> >>> as alternatives or as additions to the call_rcu_lazy() approach.
> >>>
> >>> Should call_rcu_lazy() prove to be part of the mix, here are a (very)
> >>> few of the tradeoffs:
> >>>
> >>> o	Put lazy callbacks on their own list or not?
> >>>
> >>> 	o	If not, use the bypass list?  If so, is it the
> >>> 		case that call_rcu_lazy() is just call_rcu() on
> >>> 		non-rcu_nocbs CPUs?
> >>>
> >>> 		Or add the complexity required to use the bypass
> >>> 		list on rcu_nocbs CPUs but to use ->cblist otherwise?
> >>
> >> For bypass list, I am kind of reluctant because the "flush time" of the
> >> bypass list may not match the laziness we seek? For example, I want to
> >> allow user to configure to flush the CBs only after 15 seconds or so, if
> >> the CB list does not grow too big. That might hurt folks using the
> >> bypass list, but requiring a quicker response.
> >>
> >> Also, does doing so not prevent usage of lazy CBs on systems without
> >> NOCB? So if we want to future-proof this, I guess that might not be a
> >> good decision.
> > 
> > True enough, but would this future actually arrive?  After all, if
> > someone cared enough about energy efficiency to use call_rcu_lazy(),
> > why wouldn't they also offload callbacks?
> 
> I am not sure, but I also don't mind making it depend on NOCB for now
> (see below).

Very good.

> > On the flush-time mismatch, if there are any non-lazy callbacks in the
> > list, it costs you nothing to let the lazy callbacks tag along through
> > the grace period.  So one approach would be to use the current flush
> > time if there are non-lazy callbacks, but use the longer flush time if
> > all of the callbacks in the list are lazy callbacks.
> 
> Cool!
> 
> >>> 	o	If so:
> >>>
> >>> 		o	Use segmented list with marked grace periods?
> >>> 			Keep in mind that such a list can track only
> >>> 			two grace periods.
> >>>
> >>> 		o	Use a plain list and have grace-period start
> >>> 			simply drain the list?
> >>
> >> I want to use the segmented list, regardless of whether we use the
> >> bypass list or not, because we get those memory barriers and
> >> rcu_barrier() lockless sampling of ->len, for free :).
> > 
> > The bypass list also gets you the needed memory barriers and lockless
> > sampling of ->len.  As does any other type of list as long as the
> > ->cblist.len field accounts for the lazy callbacks.
> > 
> > So the main difference is the tracking of grace periods, and even then,
> > only those grace periods for which this CPU has no non-lazy callbacks.
> > Or, in the previously discussed case where a single rcuoc kthread serves
> > multiple CPUs, only those grace periods for which this group of CPUs
> > has no non-lazy callbacks.
> 
> Unless we assume that everything in the bypass list is lazy, can we
> really use it to track both lazy and non lazy CBs, and grace periods?

Why not just count the number of lazy callbacks in the bypass list?  There
is already a count of the total number of callbacks in ->nocb_bypass.len.
This list is protected by a lock, so protect the count of lazy callbacks
with that same lock.  Then just compare the number of lazy callbacks to
rcu_cblist_n_cbs(&rdp->nocb_bypass).  If they are equal, all callbacks
are lazy.

What am I missing here?

> Currently the struct looks like this:
> 
> struct rcu_segcblist {
>         struct rcu_head *head;
>         struct rcu_head **tails[RCU_CBLIST_NSEGS];
>         unsigned long gp_seq[RCU_CBLIST_NSEGS];
> #ifdef CONFIG_RCU_NOCB_CPU
>         atomic_long_t len;
> #else
>         long len;
> #endif
>         long seglen[RCU_CBLIST_NSEGS];
>         u8 flags;
> };
> 
> So now, it would need to be like this?
> 
> struct rcu_segcblist {
>         struct rcu_head *head;
>         struct rcu_head **tails[RCU_CBLIST_NSEGS];
>         unsigned long gp_seq[RCU_CBLIST_NSEGS];
> #ifdef CONFIG_RCU_NOCB_CPU
>         struct rcu_head *lazy_head;
>         struct rcu_head **lazy_tails[RCU_CBLIST_NSEGS];
>         unsigned long lazy_gp_seq[RCU_CBLIST_NSEGS];
>         atomic_long_t lazy_len;
> #else
>         long len;
> #endif
>         long seglen[RCU_CBLIST_NSEGS];
>         u8 flags;
> };

I freely confess that I am not loving this arrangement.  Large increase
in state space, but little benefit that I can see.  Again, what am I
missing here?

> > And on devices with few CPUs, wouldn't you make do with one rcuoc kthread
> > for the system, at least in the common case where there is no callback
> > flooding?
> 
> When Rushikesh tried to reduce the number of callback threads, he did
> not see much improvement in power. I don't think the additional wake ups
> of extra rcuoc threads makes too much difference - the big power
> improvement comes from not even kicking rcu_preempt / rcuog threads...

I suspect that this might come into play later on.  It is often the case
that a given technique's effectiveness depends on the starting point.

> >>> o	Does call_rcu_lazy() do anything to ensure that additional grace
> >>> 	periods that exist only for the benefit of lazy callbacks are
> >>> 	maximally shared among all CPUs' lazy callbacks?  If so, what?
> >>> 	(Keeping in mind that failing to share such grace periods
> >>> 	burns battery lifetime.)
> >>
> >> I could be missing your point, can you give example of how you want the
> >> behavior to be?
> > 
> > CPU 0 has 55 lazy callbacks and one non-lazy callback.  So the system
> > does a grace-period computation and CPU 0 wakes up its rcuoc kthread.
> > Given that the full price is begin paid anyway, why not also invoke
> > those 55 lazy callbacks?
> > 
> > If the rcuoc kthread is shared between CPU 0 and CPU 1, and CPU 0 has 23
> > lazy callbacks and CPU 1 has 3 lazy callbacks and 2 non-lazy callbacks,
> > again the full price of grace-period computation and rcuoc wakeups is
> > being paid, so why not also invoke those 26 lazy callbacks?
> > 
> > On the other hand, if CPU 0 uses one rcuoc kthread and CPU 1 some other
> > rcuoc kthread, and with the same numbers of callbacks as in the previous
> > paragraph, you get to make a choice.  Do you do an extra wakeup for
> > CPU 0's rcuoc kthread?  Or do you potentially do an extra grace-period
> > computation some time in the future?
> > 
> > Suppose further that the CPU that would be awakened for CPU 0's rcuoc
> > kthread is already non-idle.  At that point, this wakeup is quite cheap.
> > Except that the wakeup-or-don't choice is made at the beginning of the
> > grace period, and that CPU's idleness at that point might not be all
> > that well correlated with its idleness at the time of the wakeup at the
> > end of that grace period.  Nevertheless, idleness statistics could
> > help trade off needless from-idle wakeups for needless grace periods.
> > 
> > Which sound like a good reason to consolidate rcuoc processing on
> > non-busy systems.
> > 
> > But more to the point...
> > 
> > Suppose that CPUs 0, 1, and 2 all have only lazy callbacks, and that
> > RCU is otherwise idle.  We really want one (not three!) grace periods
> > to eventually handle those lazy callbacks, right?
> 
> Yes. I think I understand you now, yes we do want to reduce the number
> of grace periods. But I think that is an optimization which is not
> strictly necessary to get the power savings this patch series
> demonstrates. To get the power savings shown here, we need all the RCU
> threads to be quiet as much as possible, and not start the rcu_preempt
> thread's state machine until when necessary.

I believe that it will be both an optimization and a simplification.
Again, if you have to start the grace-period machinery anyway, you might
as well take care of the lazy callbacks while you are at it.

> >> I am not thinking of creating separate GP cycles just for lazy CBs. The
> >> GP cycle will be the same that non-lazy uses. A lazy CB will just record
> >> what is the current or last GP, and then wait. Once the timer expires,
> >> it will check what is the current or last GP. If a new GP was not
> >> started, then it starts a new GP.
> > 
> > From my perspective, this new GP is in fact a separate GP just for lazy
> > callbacks.
> > 
> > What am I missing here?
> 
> I think my thought for power savings is slightly different from yours. I
> see lots of power savings when not even going to RCU when system is idle
> - that appears to be a lot like what the bypass list does - it avoids
> call_rcu() completely and does an early exit:
> 
>         if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
>                 return; // Enqueued onto ->nocb_bypass, so just leave.
> 
> I think amortizing cost of grace period computation across lazy CBs may
> give power savings, but that is secondary to the goal of not even poking
> RCU (which an early exit like the above does). So maybe we can just talk
> about that goal first?

You completely lost me on this one.  My point is not to amortize the cost
of grace-period computation across the lazy CBs.  My point is instead
to completely avoid doing any extra grace-period computation for the
lazy CBs in cases where grace-period computations are happening anyway.
Of course, if there are no non-lazy callbacks, then there won't be
any happening-anyway grace periods, and then, yes, there will eventually
need to be a grace period specially for the benefit of the lazy
callbacks.

And taking this piecewise is unlikely to give good results, especially
given that workloads evolve over time, much though I understand your
desire for doing this one piece at a time.

> > Also, if your timer triggers the check, isn't that an additional potential
> > wakeup from idle?  Would it make sense to also minimize those wakeups?
> > (This is one motivation for grace periods to pick up lazy callbacks.)
> > 
> >>                                   If a new GP was started but not
> >> completed, it can simply call_rcu(). If a new GP started and completed,
> >> it does not start new GP and just executes CB, something like that.
> >> Before the flush happens, if multiple lazy CBs were queued in the
> >> meanwhile and the GP seq counters moved forward, then all those lazy CBs
> >> will share the same GP (either not starting a new one, or calling
> >> call_rcu() to share the ongoing on, something like that).
> > 
> > You could move the ready-to-invoke callbacks to the end of the DONE
> > segment of ->cblist, assuming that you also adjust rcu_barrier()
> > appropriately.  If rcu_barrier() is rare, you could simply flush whatever
> > lazy list before entraining the rcu_barrier() callback.
> 
> Got it.
> 
> >>> o	When there is ample memory, how long are lazy callbacks allowed
> >>> 	to sleep?  Forever?  If not forever, what feeds into computing
> >>> 	the timeout?
> >>
> >> Yeah, the timeout is fixed currently. I agree this is a good thing to
> >> optimize.
> > 
> > First see what the behavior is.  If the timeout is long enough that
> > there is almost never a lazy-only grace period, then maybe a fixed
> > timeout is good enough.
> 
> Ok.
> 
> >>> o	What is used to determine when memory is low, so that laziness
> >>> 	has become a net negative?
> >>
> >> The assumption I think we make is that the shrinkers will constantly
> >> flush out lazy CBs if there is memory pressure.
> > 
> > It might be worth looking at SPI.  That could help avoid a grace-period
> > wait when clearing out lazy callbacks.
> 
> You mean PSI?

Yes, pressure stall information.  Apologies for my confusion!

> >>> o	What other conditions, if any, should prompt motivating lazy
> >>> 	callbacks?  (See above for the start of a grace period motivating
> >>> 	lazy callbacks.)
> >>>
> >>> In short, you need to cast your net pretty wide on this one.  It has
> >>> not yet been very carefully explored, so there are likely to be surprises,
> >>> maybe even good surprises.  ;-)
> >>
> >> Cool that sounds like some good opportunity to work on something cool ;-)
> > 
> > Which comes back around to your point of needing evaluation of extra
> > RCU work.  Lots of tradeoffs between different wakeup sources and grace
> > periods.  Fine-grained views into the black box will be helpful.  ;-)
> 
> Thanks for the conversations. I very much like the idea of using bypass
> list, but I am not sure if the current segcblist structure will support
> both lazy and non-lazy CBs. Basically, if it contains both call_rcu()
> and call_rcu_lazy() CBs, that means either all of them are lazy or all
> of them are not right? Unless we are also talking about making
> additional changes to rcu_segcblist struct to accomodate both types of CBs.

Do you need to do anything different to lazy callbacks once they have
been associated with a grace period has been started?  Your current
patch treats them the same.  If that approach continues to work, then
why do you need to track laziness downstream?

> I don't mind admitting to my illiteracy about callback offloading and
> bypass lists, but using bypass lists for this problems might improve my
> literacy nonetheless so that does motivate me to use them if you can
> help me out with the above questions :D

More detail on the grace-period machinery will also be helpful to you.  ;-)

							Thanx, Paul
