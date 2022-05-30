Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56763C433F5
	for <rcu@archiver.kernel.org>; Mon, 30 May 2022 16:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiE3QmH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 May 2022 12:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiE3QmG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 May 2022 12:42:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D72E522D5
        for <rcu@vger.kernel.org>; Mon, 30 May 2022 09:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32D2461194
        for <rcu@vger.kernel.org>; Mon, 30 May 2022 16:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCD3C385B8;
        Mon, 30 May 2022 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653928923;
        bh=KpiJasDtPp+Hs4ZrguLzByCnmClKv0zJfB0C83/+6zY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XKfc3DDPZ4g/iPfgslEHVQzujYqM5S1lBCFH2ZIHy2ONwVpbtnRkq5MfM9Gc4Te/p
         0Ir3Ko2/uM0fI7vfTT4v8FsWBAcHHF2O0mOK1iOB2SyXP7AiPJ7nf8En7AG3BE5E4c
         iGv5HLxV+ntDOna1fPmclgJp1mHSwTbfPZ80usbKgsmBFcHaKLp7C1QusWhRgQHINY
         ipz3o357x4QnhEsIZiU9ESwTfvxD1yGrFql9rgONS0iZemIfJtRzfIPvIeSrZuaXFs
         Rr19X/mePl0evss9b3YF+gXeFIO+e+cMUV+NQdXnrw+YSkWpXCzEHgsn3D0PZBdFFf
         SN1nxXTB6N8yA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 197035C034D; Mon, 30 May 2022 09:42:03 -0700 (PDT)
Date:   Mon, 30 May 2022 09:42:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
Message-ID: <20220530164203.GB1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-2-joel@joelfernandes.org>
 <20220512235603.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yn/F8V5kYR8fybPV@google.com>
 <20220514163421.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <YpFawyhgLCj1+X1A@google.com>
 <20220528175735.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <a945a7d1-fc4f-2ca5-8820-c08579f564e4@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a945a7d1-fc4f-2ca5-8820-c08579f564e4@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 30, 2022 at 10:48:26AM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> I just setup thunderbird on an old machine just to reply to LKML.
> Apologies if the formatting is weird. Replies below:

Looks fine at first glance.  ;-)

> On 5/28/22 13:57, Paul E. McKenney wrote:
> [..]
> >>>>>> +	preempt_enable();
> >>>>>> +
> >>>>>> +	if (debug_rcu_head_queue((void *)head)) {
> >>>>>> +		// Probable double call_rcu(), just leak.
> >>>>>> +		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> >>>>>> +				__func__, head);
> >>>>>> +
> >>>>>> +		// Mark as success and leave.
> >>>>>> +		return;
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	// Queue to per-cpu llist
> >>>>>> +	head->func = func;
> >>>>>> +	llist_add(&head->llist_node, &rlp->head);
> >>>>>
> >>>>> Suppose that there are a bunch of preemptions between the preempt_enable()
> >>>>> above and this point, so that the current CPU's list has lots of
> >>>>> callbacks, but zero ->count.  Can that cause a problem?
> >>>>>
> >>>>> In the past, this sort of thing has been an issue for rcu_barrier()
> >>>>> and friends.
> >>>>
> >>>> Thanks, I think I dropped the ball on this. You have given me something to
> >>>> think about. I am thinking on first thought that setting the count in advance
> >>>> of populating the list should do the trick. I will look more on it.
> >>>
> >>> That can work, but don't forget the need for proper memory ordering.
> >>>
> >>> Another approach would be to what the current bypass list does, namely
> >>> count the callback in the ->cblist structure.
> >>
> >> I have been thinking about this, and I also arrived at the same conclusion
> >> that it is easier to make it a segcblist structure which has the functions do
> >> the memory ordering. Then we can make rcu_barrier() locklessly sample the
> >> ->len of the new per-cpu structure, I *think* it might work.
> >>
> >> However, I was actually considering another situation outside of rcu_barrier,
> >> where the preemptions you mentioned would cause the list to appear to be
> >> empty if one were to rely on count, but actually have a lot of stuff queued.
> >> This causes shrinkers to not know that there is a lot of memory available to
> >> free. I don't think its that big an issue, if we can assume the caller's
> >> process context to have sufficient priority. Obviously using a raw spinlock
> >> makes the process context to be highest priority briefly but without the
> >> lock, we don't get that. But yeah that can be sorted by just updating the
> >> count proactively, and then doing the queuing operations.
> >>
> >> Another advantage of using the segcblist structure, is, we can also record
> >> the grace period numbers in it, and avoid triggering RCU from the timer if gp
> >> already elapsed (similar to the rcu-poll family of functions).
> >>
> >> WDYT?
> > 
> > What you are seeing is that the design space for call_rcu_lazy() is huge,
> > and the tradeoffs between energy efficiency and complexity are not well
> > understood.  It is therefore necessary to quickly evaluate alternatives.
> > Yes, you could simply implement all of them and test them, but that
> > might you take longer than you would like.  Plus you likely need to
> > put in place more testing than rcutorture currently provides.
> > 
> > Given what we have seen thus far, I think that the first step has to
> > be to evaluate what can be obtained with this approach compared with
> > what can be obtained with other approaches.  What we have right now,
> > more or less, is this:
> > 
> > o	Offloading buys about 15%.
> > 
> > o	Slowing grace periods buys about another 7%, but requires
> > 	userspace changes to prevent degrading user-visible performance.
> 
> Agreed.
> 
> > 
> > o	The initial call_rcu_lazy() prototype buys about 1%.
> 
> Well, that depends on the usecase. A busy system saves you less because
> it is busy anyway, so RCU being quiet does not help much.
> 
> >From my cover letter, you can see the idle power savings is a whopping
> 29% with this patch series. Check the PC10 state residencies and the
> package wattage.
> 
> When ChromeOS screen is off and user is not doing anything on the
> Before:
> Pk%pc10 = 72.13
> PkgWatt = 0.58
> 
> After:
> Pk%pc10 = 81.28
> PkgWatt = 0.41

These numbers do make a better case for this.  On the other hand, that
patch series was missing things like rcu_barrier() support and might also
be converting more call_rcu() invocations to call_rcu_lazy() invocations.
It is therefore necessary to take these numbers with a grain of salt,
much though I hope that they turn out to be realistic.

> > 
> > 	True, this is not apples to apples because the first two were
> > 	measured on ChromeOS and this one on Android.
> 
> Yes agreed. I think Vlad is not seeing any jaw dropping savings, because
> he's testing ARM. But on Intel we see a lot. Though, I asked Vlad to
> also check if rcu callbacks are indeed not being quued / quiet after
> applying the patch, and if not then there may still be some call_rcu()s
> that need conversion to lazy, on his setup. For example, he might have a
> driver on his ARM platform that's queing RCU CBs constantly.
> 
> I was thinking that perhaps a debug patch can help quickly nail down
> such RCU noise, in the way of a warning. Of course, debug CONFIG should
> never be enabled in production, so it would be something along the lines
> of how lockdep is used for debugging.

The trick would be figuring out which of the callbacks are noise.
I suspect that userspace help would be required.  Or maybe just leverage
the existing event traces and let userspace sort it out.

> >Which means that
> > 	apples to apples evaluation is also required.  But this is the
> > 	information I currently have at hand, and it is probably no more
> > 	than a factor of two off of what would be seen on ChromeOS.
> > 
> > 	Or is there some ChromeOS data that tells a different story?
> > 	After all, for all I know, Android might still be expediting
> > 	all normal grace periods.
> > 
> > At which point, the question becomes "how to make up that 7%?" After all,
> > it is not likely that anyone is going to leave that much battery lifetime
> > on the table.  Here are the possibilities that I currently see:
> > 
> > o	Slow down grace periods, and also bite the bullet and make
> > 	userspace changes to speed up the RCU grace periods during
> > 	critical operations.
> 
> We tried this, and tracing suffers quiet a lot. The system also felt
> "sluggish" which I suspect is because of synchronize_rcu() slow downs in
> other paths.

In what way does tracing suffer?  Removing tracepoints?

And yes, this approach absolutely requires finding code paths with
user-visible grace periods.  Which sounds like you tried the "Slow down
grace periods" part but not the "bit the bullet" part.  ;-)

> > o	Slow down grace periods, but leverage in-kernel changes for
> > 	some of those operations.  For example, RCU uses pm_notifier()
> > 	to cause grace periods to be expedited during suspend and
> 
> Nice! Did not know this.
> 
> > 	hibernation.  The requests for expediting are atomically counted,
> > 	so there can be other similar setups.
> 
> I do like slowing down grace periods globally, because its easy, but I
> think it can have quite a few ripple effects if in the future a user of
> call_rcu() does not expect lazy behavior :( but still gets it. Same like
> how synchronize_rcu_mult() suffered back in its day.

No matter what the approach, there are going to be ripple effects.

> > o	Choose a more moderate slowing down of the grace period so as to
> > 	minimize (or maybe even eliminate) the need for the aforementioned
> > 	userspace changes.  This also leaves battery lifetime on the
> > 	table, but considerably less of it.
> > 
> > o	Implement more selective slowdowns, such as call_rcu_lazy().
> > 
> > 	Other selective slowdowns include in-RCU heuristics such as
> > 	forcing the current grace period to end once the entire
> > 	system has gone idle.  (There is prior work detecting
> > 	full-system idleness for NO_HZ_FULL, but smaller systems
> > 	could use more aggressive techniques.)
> > 
> > I am sure that there are additional possibilities.  Note that it is
> > possible to do more than one of these, if that proves helpful.
> 
> Sure!
> > But given this, one question is "What is the most you can possibly
> > obtain from call_rcu_lazy()?"  If you have a platform with enough
> > memory, one way to obtain an upper bound is to make call_rcu_lazy()
> > simply leak the memory.  If that amount of savings does not meet the
> > need, then other higher-level approaches will be needed, whether
> > as alternatives or as additions to the call_rcu_lazy() approach.
> > 
> > Should call_rcu_lazy() prove to be part of the mix, here are a (very)
> > few of the tradeoffs:
> > 
> > o	Put lazy callbacks on their own list or not?
> > 
> > 	o	If not, use the bypass list?  If so, is it the
> > 		case that call_rcu_lazy() is just call_rcu() on
> > 		non-rcu_nocbs CPUs?
> > 
> > 		Or add the complexity required to use the bypass
> > 		list on rcu_nocbs CPUs but to use ->cblist otherwise?
> 
> For bypass list, I am kind of reluctant because the "flush time" of the
> bypass list may not match the laziness we seek? For example, I want to
> allow user to configure to flush the CBs only after 15 seconds or so, if
> the CB list does not grow too big. That might hurt folks using the
> bypass list, but requiring a quicker response.
> 
> Also, does doing so not prevent usage of lazy CBs on systems without
> NOCB? So if we want to future-proof this, I guess that might not be a
> good decision.

True enough, but would this future actually arrive?  After all, if
someone cared enough about energy efficiency to use call_rcu_lazy(),
why wouldn't they also offload callbacks?

On the flush-time mismatch, if there are any non-lazy callbacks in the
list, it costs you nothing to let the lazy callbacks tag along through
the grace period.  So one approach would be to use the current flush
time if there are non-lazy callbacks, but use the longer flush time if
all of the callbacks in the list are lazy callbacks.

> > 	o	If so:
> > 
> > 		o	Use segmented list with marked grace periods?
> > 			Keep in mind that such a list can track only
> > 			two grace periods.
> > 
> > 		o	Use a plain list and have grace-period start
> > 			simply drain the list?
> 
> I want to use the segmented list, regardless of whether we use the
> bypass list or not, because we get those memory barriers and
> rcu_barrier() lockless sampling of ->len, for free :).

The bypass list also gets you the needed memory barriers and lockless
sampling of ->len.  As does any other type of list as long as the
->cblist.len field accounts for the lazy callbacks.

So the main difference is the tracking of grace periods, and even then,
only those grace periods for which this CPU has no non-lazy callbacks.
Or, in the previously discussed case where a single rcuoc kthread serves
multiple CPUs, only those grace periods for which this group of CPUs
has no non-lazy callbacks.

And on devices with few CPUs, wouldn't you make do with one rcuoc kthread
for the system, at least in the common case where there is no callback
flooding?

> > o	Does call_rcu_lazy() do anything to ensure that additional grace
> > 	periods that exist only for the benefit of lazy callbacks are
> > 	maximally shared among all CPUs' lazy callbacks?  If so, what?
> > 	(Keeping in mind that failing to share such grace periods
> > 	burns battery lifetime.)
> 
> I could be missing your point, can you give example of how you want the
> behavior to be?

CPU 0 has 55 lazy callbacks and one non-lazy callback.  So the system
does a grace-period computation and CPU 0 wakes up its rcuoc kthread.
Given that the full price is begin paid anyway, why not also invoke
those 55 lazy callbacks?

If the rcuoc kthread is shared between CPU 0 and CPU 1, and CPU 0 has 23
lazy callbacks and CPU 1 has 3 lazy callbacks and 2 non-lazy callbacks,
again the full price of grace-period computation and rcuoc wakeups is
being paid, so why not also invoke those 26 lazy callbacks?

On the other hand, if CPU 0 uses one rcuoc kthread and CPU 1 some other
rcuoc kthread, and with the same numbers of callbacks as in the previous
paragraph, you get to make a choice.  Do you do an extra wakeup for
CPU 0's rcuoc kthread?  Or do you potentially do an extra grace-period
computation some time in the future?

Suppose further that the CPU that would be awakened for CPU 0's rcuoc
kthread is already non-idle.  At that point, this wakeup is quite cheap.
Except that the wakeup-or-don't choice is made at the beginning of the
grace period, and that CPU's idleness at that point might not be all
that well correlated with its idleness at the time of the wakeup at the
end of that grace period.  Nevertheless, idleness statistics could
help trade off needless from-idle wakeups for needless grace periods.

Which sound like a good reason to consolidate rcuoc processing on
non-busy systems.

But more to the point...

Suppose that CPUs 0, 1, and 2 all have only lazy callbacks, and that
RCU is otherwise idle.  We really want one (not three!) grace periods
to eventually handle those lazy callbacks, right?

> I am not thinking of creating separate GP cycles just for lazy CBs. The
> GP cycle will be the same that non-lazy uses. A lazy CB will just record
> what is the current or last GP, and then wait. Once the timer expires,
> it will check what is the current or last GP. If a new GP was not
> started, then it starts a new GP.

From my perspective, this new GP is in fact a separate GP just for lazy
callbacks.

What am I missing here?

Also, if your timer triggers the check, isn't that an additional potential
wakeup from idle?  Would it make sense to also minimize those wakeups?
(This is one motivation for grace periods to pick up lazy callbacks.)

>                                   If a new GP was started but not
> completed, it can simply call_rcu(). If a new GP started and completed,
> it does not start new GP and just executes CB, something like that.
> Before the flush happens, if multiple lazy CBs were queued in the
> meanwhile and the GP seq counters moved forward, then all those lazy CBs
> will share the same GP (either not starting a new one, or calling
> call_rcu() to share the ongoing on, something like that).

You could move the ready-to-invoke callbacks to the end of the DONE
segment of ->cblist, assuming that you also adjust rcu_barrier()
appropriately.  If rcu_barrier() is rare, you could simply flush whatever
lazy list before entraining the rcu_barrier() callback.

> > o	When there is ample memory, how long are lazy callbacks allowed
> > 	to sleep?  Forever?  If not forever, what feeds into computing
> > 	the timeout?
> 
> Yeah, the timeout is fixed currently. I agree this is a good thing to
> optimize.

First see what the behavior is.  If the timeout is long enough that
there is almost never a lazy-only grace period, then maybe a fixed
timeout is good enough.

> > o	What is used to determine when memory is low, so that laziness
> > 	has become a net negative?
> 
> The assumption I think we make is that the shrinkers will constantly
> flush out lazy CBs if there is memory pressure.

It might be worth looking at SPI.  That could help avoid a grace-period
wait when clearing out lazy callbacks.

> > o	What other conditions, if any, should prompt motivating lazy
> > 	callbacks?  (See above for the start of a grace period motivating
> > 	lazy callbacks.)
> > 
> > In short, you need to cast your net pretty wide on this one.  It has
> > not yet been very carefully explored, so there are likely to be surprises,
> > maybe even good surprises.  ;-)
> 
> Cool that sounds like some good opportunity to work on something cool ;-)

Which comes back around to your point of needing evaluation of extra
RCU work.  Lots of tradeoffs between different wakeup sources and grace
periods.  Fine-grained views into the black box will be helpful.  ;-)

> Happy memorial day! Off for lunch with some friends and then back to
> tinkering.

Have a good holiday!

							Thanx, Paul

> Thanks,
> 
> - Joel
> 
> > 
> > 							Thanx, Paul
> > 
> >> thanks,
> >>
> >>  - Joel
> >>
> >>>>>> +	// Flush queue if too big
> >>>>>
> >>>>> You will also need to check for early boot use.
> >>>>>
> >>>>> I -think- it suffice to simply skip the following "if" statement when
> >>>>> rcu_scheduler_active == RCU_SCHEDULER_INACTIVE suffices.  The reason being
> >>>>> that you can queue timeouts at that point, even though CONFIG_PREEMPT_RT
> >>>>> kernels won't expire them until the softirq kthreads have been spawned.
> >>>>>
> >>>>> Which is OK, as it just means that call_rcu_lazy() is a bit more
> >>>>> lazy than expected that early.
> >>>>>
> >>>>> Except that call_rcu() can be invoked even before rcu_init() has been
> >>>>> invoked, which is therefore also before rcu_init_lazy() has been invoked.
> >>>>
> >>>> In other words, you are concerned that too many lazy callbacks might be
> >>>> pending before rcu_init() is called?
> >>>
> >>> In other words, I am concerned that bad things might happen if fields
> >>> in a rcu_lazy_pcp structure are used before they are initialized.
> >>>
> >>> I am not worried about too many lazy callbacks before rcu_init() because
> >>> the non-lazy callbacks (which these currently are) are allowed to pile
> >>> up until RCU's grace-period kthreads have been spawned.  There might
> >>> come a time when RCU callbacks need to be invoked earlier, but that will
> >>> be a separate problem to solve when and if, but with the benefit of the
> >>> additional information derived from seeing the problem actually happen.
> >>>
> >>>> I am going through the kfree_rcu() threads/patches involving
> >>>> RCU_SCHEDULER_RUNNING check, but was the concern that queuing timers before
> >>>> the scheduler is running causes a crash or warnings?
> >>>
> >>> There are a lot of different issues that arise in different phases
> >>> of boot.  In this particular case, my primary concern is the
> >>> use-before-initialized bug.
> >>>
> >>>>> I thefore suggest something like this at the very start of this function:
> >>>>>
> >>>>> 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> >>>>> 		call_rcu(head_rcu, func);
> >>>>>
> >>>>> The goal is that people can replace call_rcu() with call_rcu_lazy()
> >>>>> without having to worry about invocation during early boot.
> >>>>
> >>>> Yes, this seems safer. I don't expect much power savings during system boot
> >>>> process anyway ;-). I believe perhaps a static branch would work better to
> >>>> take a branch out from what is likely a fast path.
> >>>
> >>> A static branch would be fine.  Maybe encapsulate it in a static inline
> >>> function for all such comparisons, but most such comparisons are far from
> >>> anything resembling a fastpath, so the main potential benefit would be
> >>> added readability.  Which could be a compelling reason in and of itself.
> >>>
> >>> 							Thanx, Paul
> >>>
> >>>>> Huh.  "head_rcu"?  Why not "rhp"?  Or follow call_rcu() with "head",
> >>>>> though "rhp" is more consistent with the RCU pointer initials approach.
> >>>>
> >>>> Fixed, thanks.
> >>>>
> >>>>>> +	if (atomic_inc_return(&rlp->count) >= MAX_LAZY_BATCH) {
> >>>>>> +		lazy_rcu_flush_cpu(rlp);
> >>>>>> +	} else {
> >>>>>> +		if (!delayed_work_pending(&rlp->work)) {
> >>>>>
> >>>>> This check is racy because the work might run to completion right at
> >>>>> this point.  Wouldn't it be better to rely on the internal check of
> >>>>> WORK_STRUCT_PENDING_BIT within queue_delayed_work_on()?
> >>>>
> >>>> Oops, agreed. Will make it as you suggest.
> >>>>
> >>>> thanks,
> >>>>
> >>>>  - Joel
> >>>>
> >>>>>> +			schedule_delayed_work(&rlp->work, MAX_LAZY_JIFFIES);
> >>>>>> +		}
> >>>>>> +	}
> >>>>>> +}
> >>>>>> +
> >>>>>> +static unsigned long
> >>>>>> +lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> >>>>>> +{
> >>>>>> +	unsigned long count = 0;
> >>>>>> +	int cpu;
> >>>>>> +
> >>>>>> +	/* Snapshot count of all CPUs */
> >>>>>> +	for_each_possible_cpu(cpu) {
> >>>>>> +		struct rcu_lazy_pcp *rlp = per_cpu_ptr(&rcu_lazy_pcp_ins, cpu);
> >>>>>> +
> >>>>>> +		count += atomic_read(&rlp->count);
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	return count;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static unsigned long
> >>>>>> +lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> >>>>>> +{
> >>>>>> +	int cpu, freed = 0;
> >>>>>> +
> >>>>>> +	for_each_possible_cpu(cpu) {
> >>>>>> +		struct rcu_lazy_pcp *rlp = per_cpu_ptr(&rcu_lazy_pcp_ins, cpu);
> >>>>>> +		unsigned long count;
> >>>>>> +
> >>>>>> +		count = atomic_read(&rlp->count);
> >>>>>> +		lazy_rcu_flush_cpu(rlp);
> >>>>>> +		sc->nr_to_scan -= count;
> >>>>>> +		freed += count;
> >>>>>> +		if (sc->nr_to_scan <= 0)
> >>>>>> +			break;
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	return freed == 0 ? SHRINK_STOP : freed;
> >>>>>
> >>>>> This is a bit surprising given the stated aim of SHRINK_STOP to indicate
> >>>>> potential deadlocks.  But this pattern is common, including on the
> >>>>> kvfree_rcu() path, so OK!  ;-)
> >>>>>
> >>>>> Plus do_shrink_slab() loops if you don't return SHRINK_STOP, so there is
> >>>>> that as well.
> >>>>>
> >>>>>> +}
> >>>>>> +
> >>>>>> +/*
> >>>>>> + * This function is invoked after MAX_LAZY_JIFFIES timeout.
> >>>>>> + */
> >>>>>> +static void lazy_work(struct work_struct *work)
> >>>>>> +{
> >>>>>> +	struct rcu_lazy_pcp *rlp = container_of(work, struct rcu_lazy_pcp, work.work);
> >>>>>> +
> >>>>>> +	lazy_rcu_flush_cpu(rlp);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static struct shrinker lazy_rcu_shrinker = {
> >>>>>> +	.count_objects = lazy_rcu_shrink_count,
> >>>>>> +	.scan_objects = lazy_rcu_shrink_scan,
> >>>>>> +	.batch = 0,
> >>>>>> +	.seeks = DEFAULT_SEEKS,
> >>>>>> +};
> >>>>>> +
> >>>>>> +void __init rcu_lazy_init(void)
> >>>>>> +{
> >>>>>> +	int cpu;
> >>>>>> +
> >>>>>> +	BUILD_BUG_ON(sizeof(struct lazy_rcu_head) != sizeof(struct rcu_head));
> >>>>>> +
> >>>>>> +	for_each_possible_cpu(cpu) {
> >>>>>> +		struct rcu_lazy_pcp *rlp = per_cpu_ptr(&rcu_lazy_pcp_ins, cpu);
> >>>>>> +		INIT_DELAYED_WORK(&rlp->work, lazy_work);
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	if (register_shrinker(&lazy_rcu_shrinker))
> >>>>>> +		pr_err("Failed to register lazy_rcu shrinker!\n");
> >>>>>> +}
> >>>>>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> >>>>>> index 24b5f2c2de87..a5f4b44f395f 100644
> >>>>>> --- a/kernel/rcu/rcu.h
> >>>>>> +++ b/kernel/rcu/rcu.h
> >>>>>> @@ -561,4 +561,9 @@ void show_rcu_tasks_trace_gp_kthread(void);
> >>>>>>  static inline void show_rcu_tasks_trace_gp_kthread(void) {}
> >>>>>>  #endif
> >>>>>>  
> >>>>>> +#ifdef CONFIG_RCU_LAZY
> >>>>>> +void rcu_lazy_init(void);
> >>>>>> +#else
> >>>>>> +static inline void rcu_lazy_init(void) {}
> >>>>>> +#endif
> >>>>>>  #endif /* __LINUX_RCU_H */
> >>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >>>>>> index a4c25a6283b0..ebdf6f7c9023 100644
> >>>>>> --- a/kernel/rcu/tree.c
> >>>>>> +++ b/kernel/rcu/tree.c
> >>>>>> @@ -4775,6 +4775,8 @@ void __init rcu_init(void)
> >>>>>>  		qovld_calc = DEFAULT_RCU_QOVLD_MULT * qhimark;
> >>>>>>  	else
> >>>>>>  		qovld_calc = qovld;
> >>>>>> +
> >>>>>> +	rcu_lazy_init();
> >>>>>>  }
> >>>>>>  
> >>>>>>  #include "tree_stall.h"
> >>>>>> -- 
> >>>>>> 2.36.0.550.gb090851708-goog
> >>>>>>
