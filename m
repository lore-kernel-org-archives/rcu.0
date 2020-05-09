Return-Path: <SRS0=NLNW=6X=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2866AC54E49
	for <rcu@archiver.kernel.org>; Sat,  9 May 2020 08:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0348F2184D
	for <rcu@archiver.kernel.org>; Sat,  9 May 2020 08:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="qzFnnjAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgEIIyy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 9 May 2020 04:54:54 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:47388 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgEIIyy (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sat, 9 May 2020 04:54:54 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 9AE142E12E7;
        Sat,  9 May 2020 11:54:45 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id DRfZSkNAPa-sfXScfoP;
        Sat, 09 May 2020 11:54:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1589014485; bh=j5yt9IbslNfllYMGw1hHKx4MZ9XKOjo0SaNQnANY+nk=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=qzFnnjALGi13sfYBiI6Uz+RN3NEMrq0ei+8y1mlpF8sjGAev7rP7crPVOUNqZObyj
         s33njrdZ05aUH8Dl2zQdYYE0XSBxJGQ1MdNWLjOlN35KC5O+ho0QT0LvSucx5jlHB0
         K+K01mVJUeeetc7ZA74K0JShRSoaLfues33Y56bI=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7214::1:5])
        by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 0AVjzYkcx6-seW4U4Ta;
        Sat, 09 May 2020 11:54:41 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC tip/core/rcu] Add shrinker to shift to
 fast/inefficient GP mode
To:     paulmck@kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, viro@zeniv.linux.org.uk,
        Dave Chinner <david@fromorbit.com>
References: <20200507004240.GA9156@paulmck-ThinkPad-P72>
 <20200506175535.d4986a4d497071a410b69765@linux-foundation.org>
 <20200507170006.GA155220@cmpxchg.org>
 <20200507170903.GR2869@paulmck-ThinkPad-P72>
 <20200507183102.GB155220@cmpxchg.org>
 <20200507190905.GX2869@paulmck-ThinkPad-P72>
 <6d93affb-6505-1bf3-58a0-c67c34a18a9e@yandex-team.ru>
 <20200508144638.GF2869@paulmck-ThinkPad-P72>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <8671cc58-11e0-b9f0-74b1-264fea58b23c@yandex-team.ru>
Date:   Sat, 9 May 2020 11:54:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508144638.GF2869@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 08/05/2020 17.46, Paul E. McKenney wrote:
> On Fri, May 08, 2020 at 12:00:28PM +0300, Konstantin Khlebnikov wrote:
>> On 07/05/2020 22.09, Paul E. McKenney wrote:
>>> On Thu, May 07, 2020 at 02:31:02PM -0400, Johannes Weiner wrote:
>>>> On Thu, May 07, 2020 at 10:09:03AM -0700, Paul E. McKenney wrote:
>>>>> On Thu, May 07, 2020 at 01:00:06PM -0400, Johannes Weiner wrote:
>>>>>> On Wed, May 06, 2020 at 05:55:35PM -0700, Andrew Morton wrote:
>>>>>>> On Wed, 6 May 2020 17:42:40 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>>>>>>
>>>>>>>> This commit adds a shrinker so as to inform RCU when memory is scarce.
>>>>>>>> RCU responds by shifting into the same fast and inefficient mode that is
>>>>>>>> used in the presence of excessive numbers of RCU callbacks.  RCU remains
>>>>>>>> in this state for one-tenth of a second, though this time window can be
>>>>>>>> extended by another call to the shrinker.
>>>>>>
>>>>>> We may be able to use shrinkers here, but merely being invoked does
>>>>>> not carry a reliable distress signal.
>>>>>>
>>>>>> Shrinkers get invoked whenever vmscan runs. It's a useful indicator
>>>>>> for when to age an auxiliary LRU list - test references, clear and
>>>>>> rotate or reclaim stale entries. The urgency, and what can and cannot
>>>>>> be considered "stale", is encoded in the callback frequency and scan
>>>>>> counts, and meant to be relative to the VM's own rate of aging: "I've
>>>>>> tested X percent of mine for recent use, now you go and test the same
>>>>>> share of your pool." It doesn't translate well to other
>>>>>> interpretations of the callbacks, although people have tried.
>>>>>
>>>>> Would it make sense for RCU to interpret two invocations within (say)
>>>>> 100ms of each other as indicating urgency?  (Hey, I had to ask!)
>>>>
>>>> It's the perfect number for one combination of CPU, storage device,
>>>> and shrinker implementation :-)
>>>
>>> Woo-hoo!!!
>>>
>>> But is that one combination actually in use anywhere?  ;-)
>>>
>>>>>>>> If it proves feasible, a later commit might add a function call directly
>>>>>>>> indicating the end of the period of scarce memory.
>>>>>>>
>>>>>>> (Cc David Chinner, who often has opinions on shrinkers ;))
>>>>>>>
>>>>>>> It's a bit abusive of the intent of the slab shrinkers, but I don't
>>>>>>> immediately see a problem with it.  Always returning 0 from
>>>>>>> ->scan_objects might cause a problem in some situations(?).
>>>>>>>
>>>>>>> Perhaps we should have a formal "system getting low on memory, please
>>>>>>> do something" notification API.
>>>>>>
>>>>>> It's tricky to find a useful definition of what low on memory
>>>>>> means. In the past we've used sc->priority cutoffs, the vmpressure
>>>>>> interface (reclaimed/scanned - reclaim efficiency cutoffs), oom
>>>>>> notifiers (another reclaim efficiency cutoff). But none of these
>>>>>> reliably capture "distress", and they vary highly between different
>>>>>> hardware setups. It can be hard to trigger OOM itself on fast IO
>>>>>> devices, even when the machine is way past useful (where useful is
>>>>>> somewhat subjective to the user). Userspace OOM implementations that
>>>>>> consider userspace health (also subjective) are getting more common.
>>>>>>
>>>>>>> How significant is this?  How much memory can RCU consume?
>>>>>>
>>>>>> I think if rcu can end up consuming a significant share of memory, one
>>>>>> way that may work would be to do proper shrinker integration and track
>>>>>> the age of its objects relative to the age of other allocations in the
>>>>>> system. I.e. toss them all on a clock list with "new" bits and shrink
>>>>>> them at VM velocity. If the shrinker sees objects with new bit set,
>>>>>> clear and rotate. If it sees objects without them, we know rcu_heads
>>>>>> outlive cache pages etc. and should probably cycle faster too.
>>>>>
>>>>> It would be easy for RCU to pass back (or otherwise use) the age of the
>>>>> current grace period, if that would help.
>>>>>
>>>>> Tracking the age of individual callbacks is out of the question due to
>>>>> memory overhead, but RCU could approximate this via statistical sampling.
>>>>> Comparing this to grace-period durations could give information as to
>>>>> whether making grace periods go faster would be helpful.
>>>>
>>>> That makes sense.
>>>>
>>>> So RCU knows the time and the VM knows the amount of memory. Either
>>>> RCU needs to figure out its memory component to be able to translate
>>>> shrinker input to age, or the VM needs to learn about time to be able
>>>> to say: I'm currently scanning memory older than timestamp X.
>>>>
>>>> The latter would also require sampling in the VM. Nose goes. :-)
>>>
>>> Sounds about right.  ;-)
>>>
>>> Does reclaim have any notion of having continuously scanned for
>>> longer than some amount of time?  Or could RCU reasonably deduce this?
>>> For example, if RCU noticed that reclaim had been scanning for longer than
>>> (say) five grace periods, RCU might decide to speed things up.
>>>
>>> But on the other hand, with slow disks, reclaim might go on for tens of
>>> seconds even without much in the way of memory pressure, mightn't it?
>>>
>>> I suppose that another indicator would be recent NULL returns from
>>> allocators.  But that indicator flashes a bit later than one would like,
>>> doesn't it?  And has false positives when allocators are invoked from
>>> atomic contexts, no doubt.  And no doubt similar for sleeping more than
>>> a certain length of time in an allocator.
>>>
>>>> There actually is prior art for teaching reclaim about time:
>>>> https://lore.kernel.org/linux-mm/20130430110214.22179.26139.stgit@zurg/
>>>>
>>>> CCing Konstantin. I'm curious how widely this ended up being used and
>>>> how reliably it worked.
>>>
>>> Looking forward to hearing of any results!
>>
>> Well, that was some experiment about automatic steering memory pressure
>> between containers. LRU timings from milestones itself worked pretty well.
>> Remaining engine were more robust than mainline cgroups these days.
>> Memory becomes much cheaper - I hope nobody want's overcommit it that badly anymore.
>>
>> It seems modern MM has plenty signals about memory pressure.
>> Kswapsd should have enough knowledge to switch gears in RCU.
> 
> Easy for me to provide "start fast and inefficient mode" and "stop fast
> and inefficient mode" APIs for MM to call!
> 
> How about rcu_mempressure_start() and rcu_mempressure_end()?  I would
> expect them not to nest (as in if you need them to nest, please let
> me know).  I would not expect these to be invoked all that often (as in
> if you do need them to be fast and scalable, please let me know). >
> RCU would then be in fast/inefficient mode if either MM told it to be
> or if RCU had detected callback overload on at least one CPU.
> 
> Seem reasonable?

Not exactly nested calls, but kswapd threads are per numa node.
So, at some level nodes under pressure must be counted.

Also forcing rcu calls only for cpus in one numa node might be useful.


I wonder if direct-reclaim should at some stage simply wait for RCU QS.
I.e. call rcu_barrier() or similar somewhere before invoking OOM.

All GFP_NOFAIL users should allow direct-reclaim, thus this loop
in page_alloc shouldn't block RCU and doesn't need special care.

> 
> 							Thanx, Paul
> 
>>>>> But, yes, it would be better to have an elusive unambiguous indication
>>>>> of distress.  ;-)
>>>>
>>>> I agree. Preferably something more practical than a dialogue box
>>>> asking the user on how well things are going for them :-)
>>>
>>> Indeed, that dialog box should be especially useful for things like
>>> light bulbs running Linux.  ;-)
>>>
>>> 							Thanx, Paul
>>>
