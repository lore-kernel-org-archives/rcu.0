Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40F8C433EF
	for <rcu@archiver.kernel.org>; Mon, 27 Sep 2021 03:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 850FF60F94
	for <rcu@archiver.kernel.org>; Mon, 27 Sep 2021 03:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhI0D0z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 26 Sep 2021 23:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhI0D0z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 26 Sep 2021 23:26:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA0F5610A2;
        Mon, 27 Sep 2021 03:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632713117;
        bh=fHtFZvkbv1GxiEqHpfH2tmV+SqN/v7gUTDElMBT+tM8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SRwo4qkjv6q037+HVlBjE2D4lE+S9QsrDYFgxuIXKPN9h3Pryyx7NalIsYz7TDKRe
         u+we3RPlrkGOwcj5ZiXmhqeSTIeVyyhAyE6hfvTBNTRE9zRQJ4LT+zgFEJNOVHqrHR
         vu6hULsznptmbxUkLmr3GC1V6+yv9HRD6BvPRPHCpP6+Ceykekks0kqeSLeFPPGdZ7
         9Vh0wVmWbtc52ExgeDtvGx/+xjUNWiuksVWq9iEZSSCAY+uuXyRJ0sFj/42t3T7Fd3
         JVVLt0wZBrhJsFqu859a1tXn0BCyYgPpUwXULckbJpbMKlC1/oJrICIJsXF2pyYlMr
         X6aQxjrOnfD4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B52485C04B4; Sun, 26 Sep 2021 20:25:17 -0700 (PDT)
Date:   Sun, 26 Sep 2021 20:25:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     rcu@vger.kernel.org
Subject: Re: Making races happen more often
Message-ID: <20210927032517.GR880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210926035103.GA1953486@paulmck-ThinkPad-P17-Gen-1>
 <20210926044127.GA11326@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926044127.GA11326@1wt.eu>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Sep 26, 2021 at 06:41:27AM +0200, Willy Tarreau wrote:
> Hi Paul,
> 
> On Sat, Sep 25, 2021 at 08:51:03PM -0700, Paul E. McKenney wrote:
> > Hello, Willy!
> > 
> > Continuing from linkedin:
> > 
> > > Maybe this doesn't work as well as expected because of the common L3 cache
> > > that runs at a single frequency and that imposes discrete timings. Also,
> > > I noticed that on modern CPUs, cache lines tend to "stick" at least a few
> > > cycles once they're in a cache, which helps the corresponding CPU chain
> > > a few atomic ops undisturbed. For example on a 8-core Ryzen I'm seeing a
> > > minimum of 8ns between two threads of the same core (L1 probably split in
> > > two halves), 25ns between two L2 and 60ns between the two halves (CCX)
> > > of the L3. This certainly makes it much harder to trigger concurrency
> > > issues. Well let's continue by e-mail, it's a real pain to type in this
> > > awful interface.
> > 
> > Indeed, I get best (worst?) results from memory latency on multi-socket
> > systems.  And these results were not subtle:
> > 
> > 	https://paulmck.livejournal.com/62071.html
> 
> Interesting. I've been working for a few months on trying to efficiently
> break compare-and-swap loops that tend to favor local nodes and to stall
> other ones. A bit of background first: in haproxy we have a 2-second
> watchdog that kills the process if a thread is stuck that long (that's
> an eternity on an event-driven program). We've recently got reports of
> the watchdog triggering on EPYC systems with blocks of 16 consecutive
> threads not being able to make any progress. It turns out that such 16
> consecutive threads seem to always be in the same core-complex, i.e.
> same L3, so it seems that sometimes it's hard to reclaim a line that's
> stressed by other nodes.
> 
> I wrote a program to measure inter-CPU atomic latencies and success/failure
> rates to perform a CAS depending on each thread combination. Even on a
> Ryzen 2700X (8 cores in 2*4 blocks) I've measured up to ~4k consecutive
> failures. When trying to modify my code to try enforce some fairness, I
> managed to go down to less than 4 failures. I was happy until I discovered
> that there was a bug in my program making it not do anything except check
> the shared variable that I'm using to enforce the fairness. So it seems
> that interleaving multiple indenpendent accesses might sometimes help
> provide some fairness in all of this, which is what I'm going to work on
> today.

The textbook approach is to partition the algorithm, for example, with
a combining tree or similar.  Otherwise, you are quite right, there are
all sorts of hardware-specific things that can happen at high levels of
memory contention.

Other than that, there are a lot of heuristics involving per-node counters
so that if a given node has had more than N consecutive shots and some
other node wants in, it holds off until the other node gets in.  Complex
and tricky, so partitioning is better where it can be done.

> > All that aside, any advice on portably and usefully getting 2-3x clock
> > frequency differences into testing would be quite welcome.
> 
> I think that playing with scaling_max_freq and randomly setting it
> to either cpuinfo_min_freq or cpuinfo_max_freq could be a good start.
> However it will likely not work inside KVM, but for bare-metal tests
> it should work where cpufreq is supported.

OK, that explains at least some of my difficulties.  I almost always
run under qemu/KVM.

> Something like the untested below could be a good start, and maybe it
> could even be periodically changed while the test is running:
> 
>    for p in /sys/devices/system/cpu/cpufreq/policy*; do
>       min=$(cat $p/cpuinfo_min_freq)
>       max=$(cat $p/cpuinfo_max_freq)
>       if ((RANDOM & 1)); then
>         echo $max > $p/scaling_max_freq
>       else
>         echo $min > $p/scaling_max_freq
>       fi
>    done
> 
> Then you can undo it like this:
> 
>    for p in /sys/devices/system/cpu/cpufreq/policy*; do
>       cat $p/cpuinfo_max_freq > $p/scaling_max_freq
>    done
> 
> On my i7-8650U laptop, the min/max freqs are 400/4200 MHz. On the previous
> one (i5-3320M) it's 1200/3300. On a Ryzen 2700X it's 4000/2200. I'm seeing
> 800/5000 on a core i9-9900K. So I guess that it could be a good start. If
> you need the ratios to be kept tighter, we could probably improve the
> script above to try intermediate values.

But yes, on bare-metal setups, those ratios should be able to do some
useful damage.  ;-)

Thank you!

							Thanx, Paul
