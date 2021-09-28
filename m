Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F48C433EF
	for <rcu@archiver.kernel.org>; Tue, 28 Sep 2021 04:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76E461213
	for <rcu@archiver.kernel.org>; Tue, 28 Sep 2021 04:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhI1ED1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Sep 2021 00:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhI1ED0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Sep 2021 00:03:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 455E0611F2;
        Tue, 28 Sep 2021 04:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632801707;
        bh=q7xWsTrK0vp0w7GhzcFN7km+Io0YbjjW5npTh4wY3Lg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZgsyZVivF9Wqkagscr1Zqn0EnAN/VeNOwNhbW3lB0q4hMGe2yM4nCjhabcpBkbzBI
         VHp/81WreAwbMW5yWfcO+oMuIzV53LqbVygwPN8iK9DaVn77IWlIIYvm8kzkBZAyub
         VOtexQP2ytu+plHPDd6ORXnJx3lTW9eKfBjwUhb+io+S8EVbAz3PqfgzcWR0M3qEG9
         /YURjuAVvOypU38Dg7rpcjUm1rWvhKTj1jXOHJSrGNFw/o/2YMiGZfga8Edb4LCQGg
         ChNrM8wIURws4kv5uTIZR3U1gXhPN7MS1ahcZlCtF8b75u/R2d8iN780tc7Vnrz53j
         vMl13KOAQF5Cg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1AE0F5C0926; Mon, 27 Sep 2021 21:01:47 -0700 (PDT)
Date:   Mon, 27 Sep 2021 21:01:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     rcu@vger.kernel.org
Subject: Re: Making races happen more often
Message-ID: <20210928040147.GA880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210926035103.GA1953486@paulmck-ThinkPad-P17-Gen-1>
 <20210926044127.GA11326@1wt.eu>
 <20210927032517.GR880162@paulmck-ThinkPad-P17-Gen-1>
 <20210927064915.GA20117@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927064915.GA20117@1wt.eu>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 27, 2021 at 08:49:15AM +0200, Willy Tarreau wrote:
> Hi Paul,
> 
> On Sun, Sep 26, 2021 at 08:25:17PM -0700, Paul E. McKenney wrote:
> > > I wrote a program to measure inter-CPU atomic latencies and success/failure
> > > rates to perform a CAS depending on each thread combination. Even on a
> > > Ryzen 2700X (8 cores in 2*4 blocks) I've measured up to ~4k consecutive
> > > failures. When trying to modify my code to try enforce some fairness, I
> > > managed to go down to less than 4 failures. I was happy until I discovered
> > > that there was a bug in my program making it not do anything except check
> > > the shared variable that I'm using to enforce the fairness. So it seems
> > > that interleaving multiple indenpendent accesses might sometimes help
> > > provide some fairness in all of this, which is what I'm going to work on
> > > today.
> > 
> > The textbook approach is to partition the algorithm, for example, with
> > a combining tree or similar.
> 
> That's what I'm working on for the long term. For the short term I'm
> trying to measure the average time spent trying and failing, and setting
> a threshold above which other threads do not start to work and let others
> finish first. This gives very good results, with peak CAS failures going
> down from ~300 to ~16 in my tests, and average time being even lower than
> before. However it's a bit addictive, and playing a bit too much with
> tuning tends to favor some archs at the expense of others. My experiments
> are here for the curious, though probably not very interesting at the moment:
> 
>    https://github.com/wtarreau/atomic-tests  

I took only a quick glance, but the results below do look interesting.

> > Otherwise, you are quite right, there are
> > all sorts of hardware-specific things that can happen at high levels of
> > memory contention.
> 
> There's not just memory contention, I found some severe contention inside
> L3 caches themselves. For example, AMD Ryzen CPUs have their caches arranged
> as "core complexes" of 4 cores connected to a same block of L3 cache, itself
> connected to the other "core complexes". Look at the measured inter-CPU
> latency (in nanoseconds) for a compare-and-swap between each of them:
> 
>          0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
>      0   -   8  24  24  25  24  26  26  69  68  68  69  69  69  69  69
>      1   8   -  24  24  24  24  26  26  69  69  69  69  69  69  69  69
>      2  24  24   -   8  23  23  24  24  69  69  68  68  69  69  68  69
>      3  24  24   8   -  23  23  24  24  69  68  68  69  69  69  68  71
>      4  25  25  23  23   -   8  25  25  69  69  69  69  70  70  69  70
>      5  25  24  23  23   8   -  25  25  69  69  70  69  70  69  70  69
>      6  26  26  24  24  25  25   -   8  69  69  69  69  69  69  69  69
>      7  26  26  24  24  25  25   8   -  68  69  69  70  70  70  70  69
>      8  69  69  68  68  69  69  69  69   -   8  24  24  25  25  26  26
>      9  69  69  68  68  69  69  69  69   8   -  24  24  25  25  26  26
>     10  69  69  69  69  69  70  69  68  24  24   -   8  23  23  24  24
>     11  69  69  69  67  68  69  68  68  24  24   8   -  23  23  24  24
>     12  69  69  69  68  70  70  69  69  25  25  23  23   -   8  25  25
>     13  69  69  69  68  70  70  69  69  25  24  23  23   8   -  25  25
>     14  69  69  68  69  70  69  69  69  26  26  24  24  25  25   -   8
>     15  69  69  68  68  70  70  69  69  26  26  24  24  25  25   8   -

Nice results!

I have been following the hardware-architecture approach, so that
the "memory" in "memory contention" includes the caches.

> And if you perform a load before the CAS (like for example when computing
> a max or updating a pointer), it gets better for same-core-complex and
> much worse for others:
> 
>          0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
>      0   -  18  21  21  23  24  22  22 124 124 123 122 125 125 124 124
>      1  18   -  22  22  24  24  22  22 124 124 122 122 124 124 124 123
>      2  21  22   -  18  23  23  21  56 122 122 122 122 125 125 122 124
>      3  21  21  18   -  23  23  21  20 123 123 122 122 124 124 122 122
>      4  24  23  24  23   -  18  24  23 124 124 123 124 126 126 124 124
>      5  24  24  23  23  18   -  23  23 124 124 124 123 126 126 125 126
>      6  22  22  21  20  23  23   -  18 124 124 124 123 125 124 124 124
>      7  22  22  20  21  23  24  18   - 125 124 122 122 126 124 125 125
>      8 123 123 122 122 124 124 122 122   -  18  20  20  24  23  21  21
>      9 124 124 123 123 125 125 124 124  18   -  20  21  24  24  58  21
>     10 123 123 122 122 124 122 122 122  21  21   -  18  22  23  20  20
>     11 123 122 122 122 123 124 124 123  20  20  18   -  23  23  23  20
>     12 125 124 124 123 126 126 125 124  23  23  23  23   -  18  24  23
>     13 126 125 124 123 126 126 124 124  23  23  24  22  18   -  23  23
>     14 124 124 123 122 124 124 124 124  20  20  20  21  23  25   -  18
>     15 124 124 123 123 125 124 124 124  22  21  20  56  24  24  18   -
> 
> See ? There's basically a factor of 6 in latency depending on the cores
> that are supposed to be connected to the same L3. And looking closer you
> even observe that within a same core-complex, things are not uniform at
> all either:
>   - core 1 always experiences fastest communication with other cores
>   - core 2 always experiences slowest communication with other cores
>   - discrepancies between pairs vay by up to 50%

So what rcutorture would want to do here is to assign the first four-CPU
guest OS to CPUs 0, 1, 8, and 9, right?  It would actually do that if
the /sys files indicate that CPUs 0-7 are on one node and CPUs 8-15
on another.

> However when it comes to success/failures of a CAS, it's the opposite:
>   - after a load, core 2 almost always succeeds a CAS (~50 tries)
>   - after a load, core 1 almost always fails a CAS (~500 tries)
>   - after a load, cores 0 and 3 are average (~100 tries)
> 
> This indicates to me that there's probably some arbitration cost to the
> cores that access the cache, and that cache lines assigned to one core
> or the other tend to take more time for some cores than others to be
> reclaimed, and that cores experiencing the highest latencies are also
> the ones keeping the lines longer and observing the highest success
> rate on CAS.

Cute!

> In your case it could mean that certain races will never happen on certain
> cores but could on others ones, or at least above certain frequencies,
> because if the cache line sticks long enough in an L2 to perform a series
> of operations undisturbed, whatever you'll do on other cores might have no
> effect.

In the cases exposed by my differential-latency testing, the issue was
pretty clearly the added delay.  This is because the issue involved
normal memory references for the RCU Tasks Trace bugs, read-side access
to seqlock-protected memory for the 2,199.0-second RCU CPU stall warning
(normal memory accesses plus memory barriers), and a lockdep false
positive in the Tiny SRCU case (though in lockdep's defense, this was
at best an accident waiting to happen).

But I completely agree that cmpxchg operations on highly contended
memory locations can expose all sorts of other issues.

> I suspect that working at much lower frequencies could at some point allow
> to release a cache line between two operations. I don't seem to be observing
> this on the AMD for now though, as the differences increase when lowering
> the frequency from 4.0 to 2.2G for a single CAS:
> 
>          0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
>      0   -  19  55  55  48  48  62  62 103 103 105 105 103 103 103 103
>      1  19   -  55  55  48  48  62  62 103 103 105 105 103 103 103 103
>      2  55  55   -  19  40  40  55  55 104 104 106 106 107 107 104 103
>      3  55  55  19   -  40  40  55  55 104 104 105 106 107 107 104 104
>      4  48  48  40  40   -  19  47  47 109 109 107 106 105 105 112 111
>      5  48  48  40  40  19   -  47  47 109 109 107 106 105 105 111 111
>      6  62  62  55  55  47  47   -  19 103 103 105 105 103 103 103 103
>      7  62  62  55  55  47  47  19   - 103 103 105 105 103 103 103 103
>      8 103 103 104 104 110 109 103 103   -  19  55  55  48  48  62  62
>      9 103 103 104 104 110 110 103 103  19   -  55  55  48  48  62  62
>     10 105 105 105 106 106 106 105 105  55  55   -  19  40  40  55  55
>     11 105 105 105 106 107 107 105 105  55  55  19   -  40  40  55  55
>     12 103 103 108 107 105 105 103 103  48  48  40  40   -  19  47  47
>     13 103 103 107 107 105 105 103 103  48  48  40  40  19   -  47  47
>     14 103 103 105 104 110 111 103 103  62  62  55  55  47  47   -  19
>     15 103 103 104 104 111 111 103 103  62  62  55  55  47  47  19   -
> 
> Where a same core-complex would see variations from 22 to 26ns now we're
> seeing 40 to 62!

Huh.  Are the fast CPUs seeing higher latencies due to delays from the
slower CPUs?  Or is the clock-frequency difference causing increased
delays in and of itself?  (Crossing clock-frequency domains can be much
harder than it might seem to us software folks.)

So adjacent pairs of CPUs are electrically close as well?  I am looking
at the 18s and 19s along the diagonal above.  There appears to be
additional structure above the CPU-pair level within an 8-CPU group.
A linear arrangement of four pairs of CPUs?

> > Other than that, there are a lot of heuristics involving per-node counters
> > so that if a given node has had more than N consecutive shots and some
> > other node wants in, it holds off until the other node gets in. Complex
> > and tricky, so partitioning is better where it can be done.
> 
> I tried a bit with this but it didn't yield that interesting results
> for now, I think the reason is that I'm focusing on max latency and that
> with this, the max latency experienced by any CPU becomes the number of
> CPUs times the max granted to a single CPU. Playing with roughly averaged
> wait times instead tends to favor threads waiting too long first. The only
> thing is that I try to avoid updating this when the wait time is low
> enough, in order to avoid writes to a shared area. One of the side effects
> of writing to such a shared areas is that some operations may be delayed
> due to write ordering. I.e. writing that you're waiting for the access,
> then performing a CAS will first require that the line containing that
> "waiting" flag be flushed before trying the CAS, which may increase the
> risk that another CPU in the mean time updates it and causes the CAS to
> fail. And if the "waiting" flag is shared with the area being touched by
> the CAS, then touching it to say "I'm here" is enough to slow down the
> other ones. Thus I prefer to watch a shared entry that is not supposed to
> be updated often, except when CPUs are fed up with waiting. Under normal
> operation it should perform better.

All points in favor of your long-term plan of reducing contention of
the variable being cmpxchg()ed.

> Another point I'm quite interested in is trying to group operations from
> close neighbors. In the example above on the Ryzen CPU, I would love to
> see CPUs from the same core complex try their luck together. One could
> think about using a CPU number to distribute accesses so that they're
> grouped, but it's less convenient from userland (or even from a VM). One
> element however knows better than the software, it's the cache controller.
> That's why I'm trying to keep *some* contention, so that once a core gets
> its access to the cache, the other ones on the same side of the L3 have a
> better chance to access it immediately after. And I think that's how I've
> reached an average of 45ns per operation (stats included) in my last test
> across all CPUs despite inter-CPU times ranging from 18 to 125ns. But that
> is quite unstable for now.

And very very dependent on the exact hardware.  I have seen hardware
where prefetching the line passed to cmpxchg doubled the overhead,
and some where it made no measurable difference.

> > > > All that aside, any advice on portably and usefully getting 2-3x clock
> > > > frequency differences into testing would be quite welcome.
> > > 
> > > I think that playing with scaling_max_freq and randomly setting it
> > > to either cpuinfo_min_freq or cpuinfo_max_freq could be a good start.
> > > However it will likely not work inside KVM, but for bare-metal tests
> > > it should work where cpufreq is supported.
> > 
> > OK, that explains at least some of my difficulties.  I almost always
> > run under qemu/KVM.
> 
> But you could disturb the real machine with changing its frequency.

Fair point, and that should fit into the memory-latency disturbing
that I am currently doing.

> I've been wondering if it's possible to change the tick rate inside KVM,
> or even program a dummy device to deliver very fast IRQs but I haven't
> found such a thing for now. I've been thinking about NMIs as well. The
> idea would be that there could be a higher chance of interrupting
> processing at any random place using fast interrupts (>100k/s) than by
> using context switching caused by scheduler slots being depleted. Maybe
> one only needs to hack an existing device emulator to flood an IRQ :-/

Or have a bug in the timekeeping code!  ;-)

							Thanx, Paul
