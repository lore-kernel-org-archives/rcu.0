Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFEEC433F5
	for <rcu@archiver.kernel.org>; Mon, 30 May 2022 15:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbiE3Pm4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 May 2022 11:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238800AbiE3PlP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 May 2022 11:41:15 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAA220C6D5
        for <rcu@vger.kernel.org>; Mon, 30 May 2022 07:48:31 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 190so11360792qkj.8
        for <rcu@vger.kernel.org>; Mon, 30 May 2022 07:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p5lVTMvegc9l2JN4oKsXYyC8btfIo7LXglQqxgdtrvc=;
        b=HSp+V3rqzsSVnghB96T0mT6JEQTIvqDzC668/syd0bKtIUkTjFanaEgMFzymYwT1z1
         gK/86Q9+BAq6dyUtT341KmgLl7mE15Bzs6v1fB74KSeOBP74XhkDberGV/6UrI7TeZN/
         a0WHXtdjW2FOkdYX4U8DHzOBYWF58AL9WvJsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p5lVTMvegc9l2JN4oKsXYyC8btfIo7LXglQqxgdtrvc=;
        b=3zf3xvGrB9qgZFDdG69oAfIzkoE4rM4R86cjk0OddxE/7/2yx/3HT4znMTdXq5NzmS
         OxyjPrwMyJaRl/2d3a+thdwNfXNXQ7aqD4nSu4vEVHTvrCXqdYk1MYnIHdKu3Nf7cpM4
         fY4r6+WuRA81UxWx+pQYpfFg/WX/XWolSmTH/PiOqjGh2SX2pBL433gDaVd/dBrGNGJr
         mgcdY0oDNAyBT5vo6iAiooY+4UR9i1m+mUCZTEqddWkXtn0GANOFhcT/R0Q0eiSLSa21
         2w64KIYlNSZ31DYziObkdw2hA1X0qsdbd/HJx7V31AiYVPzR9ZcZZAoVemFJ4OI7Fl94
         a8ow==
X-Gm-Message-State: AOAM531N84cJuJdhEz6+H862qDbhHkKHTJb81zKJ8gaQFDWpJtw0TKR8
        Otf+GoQ9XhK4fuV2tvY++alROw==
X-Google-Smtp-Source: ABdhPJwik8yDT9gjAobitAyb1WnFdQ1mr2C4rKjOjL/8yeu2Gw+zxA2rskXiGYkMiwMInKF+2vfkSQ==
X-Received: by 2002:a05:620a:13d9:b0:6a6:15a8:9f01 with SMTP id g25-20020a05620a13d900b006a615a89f01mr6007447qkl.491.1653922107751;
        Mon, 30 May 2022 07:48:27 -0700 (PDT)
Received: from [10.0.0.27] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id g9-20020a05620a218900b006a3296726e2sm7662633qka.43.2022.05.30.07.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 07:48:27 -0700 (PDT)
Message-ID: <a945a7d1-fc4f-2ca5-8820-c08579f564e4@joelfernandes.org>
Date:   Mon, 30 May 2022 10:48:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-2-joel@joelfernandes.org>
 <20220512235603.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yn/F8V5kYR8fybPV@google.com>
 <20220514163421.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <YpFawyhgLCj1+X1A@google.com>
 <20220528175735.GV1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220528175735.GV1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

I just setup thunderbird on an old machine just to reply to LKML.
Apologies if the formatting is weird. Replies below:

On 5/28/22 13:57, Paul E. McKenney wrote:
[..]
>>>>>> +	preempt_enable();
>>>>>> +
>>>>>> +	if (debug_rcu_head_queue((void *)head)) {
>>>>>> +		// Probable double call_rcu(), just leak.
>>>>>> +		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
>>>>>> +				__func__, head);
>>>>>> +
>>>>>> +		// Mark as success and leave.
>>>>>> +		return;
>>>>>> +	}
>>>>>> +
>>>>>> +	// Queue to per-cpu llist
>>>>>> +	head->func = func;
>>>>>> +	llist_add(&head->llist_node, &rlp->head);
>>>>>
>>>>> Suppose that there are a bunch of preemptions between the preempt_enable()
>>>>> above and this point, so that the current CPU's list has lots of
>>>>> callbacks, but zero ->count.  Can that cause a problem?
>>>>>
>>>>> In the past, this sort of thing has been an issue for rcu_barrier()
>>>>> and friends.
>>>>
>>>> Thanks, I think I dropped the ball on this. You have given me something to
>>>> think about. I am thinking on first thought that setting the count in advance
>>>> of populating the list should do the trick. I will look more on it.
>>>
>>> That can work, but don't forget the need for proper memory ordering.
>>>
>>> Another approach would be to what the current bypass list does, namely
>>> count the callback in the ->cblist structure.
>>
>> I have been thinking about this, and I also arrived at the same conclusion
>> that it is easier to make it a segcblist structure which has the functions do
>> the memory ordering. Then we can make rcu_barrier() locklessly sample the
>> ->len of the new per-cpu structure, I *think* it might work.
>>
>> However, I was actually considering another situation outside of rcu_barrier,
>> where the preemptions you mentioned would cause the list to appear to be
>> empty if one were to rely on count, but actually have a lot of stuff queued.
>> This causes shrinkers to not know that there is a lot of memory available to
>> free. I don't think its that big an issue, if we can assume the caller's
>> process context to have sufficient priority. Obviously using a raw spinlock
>> makes the process context to be highest priority briefly but without the
>> lock, we don't get that. But yeah that can be sorted by just updating the
>> count proactively, and then doing the queuing operations.
>>
>> Another advantage of using the segcblist structure, is, we can also record
>> the grace period numbers in it, and avoid triggering RCU from the timer if gp
>> already elapsed (similar to the rcu-poll family of functions).
>>
>> WDYT?
> 
> What you are seeing is that the design space for call_rcu_lazy() is huge,
> and the tradeoffs between energy efficiency and complexity are not well
> understood.  It is therefore necessary to quickly evaluate alternatives.
> Yes, you could simply implement all of them and test them, but that
> might you take longer than you would like.  Plus you likely need to
> put in place more testing than rcutorture currently provides.
> 
> Given what we have seen thus far, I think that the first step has to
> be to evaluate what can be obtained with this approach compared with
> what can be obtained with other approaches.  What we have right now,
> more or less, is this:
> 
> o	Offloading buys about 15%.
> 
> o	Slowing grace periods buys about another 7%, but requires
> 	userspace changes to prevent degrading user-visible performance.

Agreed.

> 
> o	The initial call_rcu_lazy() prototype buys about 1%.


Well, that depends on the usecase. A busy system saves you less because
it is busy anyway, so RCU being quiet does not help much.

From my cover letter, you can see the idle power savings is a whopping
29% with this patch series. Check the PC10 state residencies and the
package wattage.

When ChromeOS screen is off and user is not doing anything on the
Before:
Pk%pc10 = 72.13
PkgWatt = 0.58

After:
Pk%pc10 = 81.28
PkgWatt = 0.41

> 
> 	True, this is not apples to apples because the first two were
> 	measured on ChromeOS and this one on Android.

Yes agreed. I think Vlad is not seeing any jaw dropping savings, because
he's testing ARM. But on Intel we see a lot. Though, I asked Vlad to
also check if rcu callbacks are indeed not being quued / quiet after
applying the patch, and if not then there may still be some call_rcu()s
that need conversion to lazy, on his setup. For example, he might have a
driver on his ARM platform that's queing RCU CBs constantly.

I was thinking that perhaps a debug patch can help quickly nail down
such RCU noise, in the way of a warning. Of course, debug CONFIG should
never be enabled in production, so it would be something along the lines
of how lockdep is used for debugging.

>Which means that
> 	apples to apples evaluation is also required.  But this is the
> 	information I currently have at hand, and it is probably no more
> 	than a factor of two off of what would be seen on ChromeOS.
> 
> 	Or is there some ChromeOS data that tells a different story?
> 	After all, for all I know, Android might still be expediting
> 	all normal grace periods.
> 
> At which point, the question becomes "how to make up that 7%?" After all,
> it is not likely that anyone is going to leave that much battery lifetime
> on the table.  Here are the possibilities that I currently see:
> 
> o	Slow down grace periods, and also bite the bullet and make
> 	userspace changes to speed up the RCU grace periods during
> 	critical operations.

We tried this, and tracing suffers quiet a lot. The system also felt
"sluggish" which I suspect is because of synchronize_rcu() slow downs in
other paths.

> 
> o	Slow down grace periods, but leverage in-kernel changes for
> 	some of those operations.  For example, RCU uses pm_notifier()
> 	to cause grace periods to be expedited during suspend and

Nice! Did not know this.

> 	hibernation.  The requests for expediting are atomically counted,
> 	so there can be other similar setups.

I do like slowing down grace periods globally, because its easy, but I
think it can have quite a few ripple effects if in the future a user of
call_rcu() does not expect lazy behavior :( but still gets it. Same like
how synchronize_rcu_mult() suffered back in its day.

> o	Choose a more moderate slowing down of the grace period so as to
> 	minimize (or maybe even eliminate) the need for the aforementioned
> 	userspace changes.  This also leaves battery lifetime on the
> 	table, but considerably less of it.
> 
> o	Implement more selective slowdowns, such as call_rcu_lazy().
> 
> 	Other selective slowdowns include in-RCU heuristics such as
> 	forcing the current grace period to end once the entire
> 	system has gone idle.  (There is prior work detecting
> 	full-system idleness for NO_HZ_FULL, but smaller systems
> 	could use more aggressive techniques.)
> 
> I am sure that there are additional possibilities.  Note that it is
> possible to do more than one of these, if that proves helpful.

Sure!
> But given this, one question is "What is the most you can possibly
> obtain from call_rcu_lazy()?"  If you have a platform with enough
> memory, one way to obtain an upper bound is to make call_rcu_lazy()
> simply leak the memory.  If that amount of savings does not meet the
> need, then other higher-level approaches will be needed, whether
> as alternatives or as additions to the call_rcu_lazy() approach.
> 
> Should call_rcu_lazy() prove to be part of the mix, here are a (very)
> few of the tradeoffs:
> 
> o	Put lazy callbacks on their own list or not?
> 
> 	o	If not, use the bypass list?  If so, is it the
> 		case that call_rcu_lazy() is just call_rcu() on
> 		non-rcu_nocbs CPUs?
> 
> 		Or add the complexity required to use the bypass
> 		list on rcu_nocbs CPUs but to use ->cblist otherwise?

For bypass list, I am kind of reluctant because the "flush time" of the
bypass list may not match the laziness we seek? For example, I want to
allow user to configure to flush the CBs only after 15 seconds or so, if
the CB list does not grow too big. That might hurt folks using the
bypass list, but requiring a quicker response.

Also, does doing so not prevent usage of lazy CBs on systems without
NOCB? So if we want to future-proof this, I guess that might not be a
good decision.

> 
> 	o	If so:
> 
> 		o	Use segmented list with marked grace periods?
> 			Keep in mind that such a list can track only
> 			two grace periods.
> 
> 		o	Use a plain list and have grace-period start
> 			simply drain the list?

I want to use the segmented list, regardless of whether we use the
bypass list or not, because we get those memory barriers and
rcu_barrier() lockless sampling of ->len, for free :).

> 
> o	Does call_rcu_lazy() do anything to ensure that additional grace
> 	periods that exist only for the benefit of lazy callbacks are
> 	maximally shared among all CPUs' lazy callbacks?  If so, what?
> 	(Keeping in mind that failing to share such grace periods
> 	burns battery lifetime.)

I could be missing your point, can you give example of how you want the
behavior to be?

I am not thinking of creating separate GP cycles just for lazy CBs. The
GP cycle will be the same that non-lazy uses. A lazy CB will just record
what is the current or last GP, and then wait. Once the timer expires,
it will check what is the current or last GP. If a new GP was not
started, then it starts a new GP. If a new GP was started but not
completed, it can simply call_rcu(). If a new GP started and completed,
it does not start new GP and just executes CB, something like that.
Before the flush happens, if multiple lazy CBs were queued in the
meanwhile and the GP seq counters moved forward, then all those lazy CBs
will share the same GP (either not starting a new one, or calling
call_rcu() to share the ongoing on, something like that).

> o	When there is ample memory, how long are lazy callbacks allowed
> 	to sleep?  Forever?  If not forever, what feeds into computing
> 	the timeout?

Yeah, the timeout is fixed currently. I agree this is a good thing to
optimize.

> o	What is used to determine when memory is low, so that laziness
> 	has become a net negative?

The assumption I think we make is that the shrinkers will constantly
flush out lazy CBs if there is memory pressure.

> o	What other conditions, if any, should prompt motivating lazy
> 	callbacks?  (See above for the start of a grace period motivating
> 	lazy callbacks.)
> 
> In short, you need to cast your net pretty wide on this one.  It has
> not yet been very carefully explored, so there are likely to be surprises,
> maybe even good surprises.  ;-)

Cool that sounds like some good opportunity to work on something cool ;-)

Happy memorial day! Off for lunch with some friends and then back to
tinkering.

Thanks,

- Joel

> 
> 							Thanx, Paul
> 
>> thanks,
>>
>>  - Joel
>>
>>>>>> +	// Flush queue if too big
>>>>>
>>>>> You will also need to check for early boot use.
>>>>>
>>>>> I -think- it suffice to simply skip the following "if" statement when
>>>>> rcu_scheduler_active == RCU_SCHEDULER_INACTIVE suffices.  The reason being
>>>>> that you can queue timeouts at that point, even though CONFIG_PREEMPT_RT
>>>>> kernels won't expire them until the softirq kthreads have been spawned.
>>>>>
>>>>> Which is OK, as it just means that call_rcu_lazy() is a bit more
>>>>> lazy than expected that early.
>>>>>
>>>>> Except that call_rcu() can be invoked even before rcu_init() has been
>>>>> invoked, which is therefore also before rcu_init_lazy() has been invoked.
>>>>
>>>> In other words, you are concerned that too many lazy callbacks might be
>>>> pending before rcu_init() is called?
>>>
>>> In other words, I am concerned that bad things might happen if fields
>>> in a rcu_lazy_pcp structure are used before they are initialized.
>>>
>>> I am not worried about too many lazy callbacks before rcu_init() because
>>> the non-lazy callbacks (which these currently are) are allowed to pile
>>> up until RCU's grace-period kthreads have been spawned.  There might
>>> come a time when RCU callbacks need to be invoked earlier, but that will
>>> be a separate problem to solve when and if, but with the benefit of the
>>> additional information derived from seeing the problem actually happen.
>>>
>>>> I am going through the kfree_rcu() threads/patches involving
>>>> RCU_SCHEDULER_RUNNING check, but was the concern that queuing timers before
>>>> the scheduler is running causes a crash or warnings?
>>>
>>> There are a lot of different issues that arise in different phases
>>> of boot.  In this particular case, my primary concern is the
>>> use-before-initialized bug.
>>>
>>>>> I thefore suggest something like this at the very start of this function:
>>>>>
>>>>> 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
>>>>> 		call_rcu(head_rcu, func);
>>>>>
>>>>> The goal is that people can replace call_rcu() with call_rcu_lazy()
>>>>> without having to worry about invocation during early boot.
>>>>
>>>> Yes, this seems safer. I don't expect much power savings during system boot
>>>> process anyway ;-). I believe perhaps a static branch would work better to
>>>> take a branch out from what is likely a fast path.
>>>
>>> A static branch would be fine.  Maybe encapsulate it in a static inline
>>> function for all such comparisons, but most such comparisons are far from
>>> anything resembling a fastpath, so the main potential benefit would be
>>> added readability.  Which could be a compelling reason in and of itself.
>>>
>>> 							Thanx, Paul
>>>
>>>>> Huh.  "head_rcu"?  Why not "rhp"?  Or follow call_rcu() with "head",
>>>>> though "rhp" is more consistent with the RCU pointer initials approach.
>>>>
>>>> Fixed, thanks.
>>>>
>>>>>> +	if (atomic_inc_return(&rlp->count) >= MAX_LAZY_BATCH) {
>>>>>> +		lazy_rcu_flush_cpu(rlp);
>>>>>> +	} else {
>>>>>> +		if (!delayed_work_pending(&rlp->work)) {
>>>>>
>>>>> This check is racy because the work might run to completion right at
>>>>> this point.  Wouldn't it be better to rely on the internal check of
>>>>> WORK_STRUCT_PENDING_BIT within queue_delayed_work_on()?
>>>>
>>>> Oops, agreed. Will make it as you suggest.
>>>>
>>>> thanks,
>>>>
>>>>  - Joel
>>>>
>>>>>> +			schedule_delayed_work(&rlp->work, MAX_LAZY_JIFFIES);
>>>>>> +		}
>>>>>> +	}
>>>>>> +}
>>>>>> +
>>>>>> +static unsigned long
>>>>>> +lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>>>>>> +{
>>>>>> +	unsigned long count = 0;
>>>>>> +	int cpu;
>>>>>> +
>>>>>> +	/* Snapshot count of all CPUs */
>>>>>> +	for_each_possible_cpu(cpu) {
>>>>>> +		struct rcu_lazy_pcp *rlp = per_cpu_ptr(&rcu_lazy_pcp_ins, cpu);
>>>>>> +
>>>>>> +		count += atomic_read(&rlp->count);
>>>>>> +	}
>>>>>> +
>>>>>> +	return count;
>>>>>> +}
>>>>>> +
>>>>>> +static unsigned long
>>>>>> +lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>>>>>> +{
>>>>>> +	int cpu, freed = 0;
>>>>>> +
>>>>>> +	for_each_possible_cpu(cpu) {
>>>>>> +		struct rcu_lazy_pcp *rlp = per_cpu_ptr(&rcu_lazy_pcp_ins, cpu);
>>>>>> +		unsigned long count;
>>>>>> +
>>>>>> +		count = atomic_read(&rlp->count);
>>>>>> +		lazy_rcu_flush_cpu(rlp);
>>>>>> +		sc->nr_to_scan -= count;
>>>>>> +		freed += count;
>>>>>> +		if (sc->nr_to_scan <= 0)
>>>>>> +			break;
>>>>>> +	}
>>>>>> +
>>>>>> +	return freed == 0 ? SHRINK_STOP : freed;
>>>>>
>>>>> This is a bit surprising given the stated aim of SHRINK_STOP to indicate
>>>>> potential deadlocks.  But this pattern is common, including on the
>>>>> kvfree_rcu() path, so OK!  ;-)
>>>>>
>>>>> Plus do_shrink_slab() loops if you don't return SHRINK_STOP, so there is
>>>>> that as well.
>>>>>
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * This function is invoked after MAX_LAZY_JIFFIES timeout.
>>>>>> + */
>>>>>> +static void lazy_work(struct work_struct *work)
>>>>>> +{
>>>>>> +	struct rcu_lazy_pcp *rlp = container_of(work, struct rcu_lazy_pcp, work.work);
>>>>>> +
>>>>>> +	lazy_rcu_flush_cpu(rlp);
>>>>>> +}
>>>>>> +
>>>>>> +static struct shrinker lazy_rcu_shrinker = {
>>>>>> +	.count_objects = lazy_rcu_shrink_count,
>>>>>> +	.scan_objects = lazy_rcu_shrink_scan,
>>>>>> +	.batch = 0,
>>>>>> +	.seeks = DEFAULT_SEEKS,
>>>>>> +};
>>>>>> +
>>>>>> +void __init rcu_lazy_init(void)
>>>>>> +{
>>>>>> +	int cpu;
>>>>>> +
>>>>>> +	BUILD_BUG_ON(sizeof(struct lazy_rcu_head) != sizeof(struct rcu_head));
>>>>>> +
>>>>>> +	for_each_possible_cpu(cpu) {
>>>>>> +		struct rcu_lazy_pcp *rlp = per_cpu_ptr(&rcu_lazy_pcp_ins, cpu);
>>>>>> +		INIT_DELAYED_WORK(&rlp->work, lazy_work);
>>>>>> +	}
>>>>>> +
>>>>>> +	if (register_shrinker(&lazy_rcu_shrinker))
>>>>>> +		pr_err("Failed to register lazy_rcu shrinker!\n");
>>>>>> +}
>>>>>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>>>>>> index 24b5f2c2de87..a5f4b44f395f 100644
>>>>>> --- a/kernel/rcu/rcu.h
>>>>>> +++ b/kernel/rcu/rcu.h
>>>>>> @@ -561,4 +561,9 @@ void show_rcu_tasks_trace_gp_kthread(void);
>>>>>>  static inline void show_rcu_tasks_trace_gp_kthread(void) {}
>>>>>>  #endif
>>>>>>  
>>>>>> +#ifdef CONFIG_RCU_LAZY
>>>>>> +void rcu_lazy_init(void);
>>>>>> +#else
>>>>>> +static inline void rcu_lazy_init(void) {}
>>>>>> +#endif
>>>>>>  #endif /* __LINUX_RCU_H */
>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>>>> index a4c25a6283b0..ebdf6f7c9023 100644
>>>>>> --- a/kernel/rcu/tree.c
>>>>>> +++ b/kernel/rcu/tree.c
>>>>>> @@ -4775,6 +4775,8 @@ void __init rcu_init(void)
>>>>>>  		qovld_calc = DEFAULT_RCU_QOVLD_MULT * qhimark;
>>>>>>  	else
>>>>>>  		qovld_calc = qovld;
>>>>>> +
>>>>>> +	rcu_lazy_init();
>>>>>>  }
>>>>>>  
>>>>>>  #include "tree_stall.h"
>>>>>> -- 
>>>>>> 2.36.0.550.gb090851708-goog
>>>>>>
