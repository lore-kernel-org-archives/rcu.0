Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FACC433EF
	for <rcu@archiver.kernel.org>; Sun, 26 Sep 2021 04:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B41604E9
	for <rcu@archiver.kernel.org>; Sun, 26 Sep 2021 04:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhIZEnI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 26 Sep 2021 00:43:08 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42867 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230378AbhIZEnI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 26 Sep 2021 00:43:08 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 18Q4fRie011483;
        Sun, 26 Sep 2021 06:41:27 +0200
Date:   Sun, 26 Sep 2021 06:41:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org
Subject: Re: Making races happen more often
Message-ID: <20210926044127.GA11326@1wt.eu>
References: <20210926035103.GA1953486@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926035103.GA1953486@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Sat, Sep 25, 2021 at 08:51:03PM -0700, Paul E. McKenney wrote:
> Hello, Willy!
> 
> Continuing from linkedin:
> 
> > Maybe this doesn't work as well as expected because of the common L3 cache
> > that runs at a single frequency and that imposes discrete timings. Also,
> > I noticed that on modern CPUs, cache lines tend to "stick" at least a few
> > cycles once they're in a cache, which helps the corresponding CPU chain
> > a few atomic ops undisturbed. For example on a 8-core Ryzen I'm seeing a
> > minimum of 8ns between two threads of the same core (L1 probably split in
> > two halves), 25ns between two L2 and 60ns between the two halves (CCX)
> > of the L3. This certainly makes it much harder to trigger concurrency
> > issues. Well let's continue by e-mail, it's a real pain to type in this
> > awful interface.
> 
> Indeed, I get best (worst?) results from memory latency on multi-socket
> systems.  And these results were not subtle:
> 
> 	https://paulmck.livejournal.com/62071.html

Interesting. I've been working for a few months on trying to efficiently
break compare-and-swap loops that tend to favor local nodes and to stall
other ones. A bit of background first: in haproxy we have a 2-second
watchdog that kills the process if a thread is stuck that long (that's
an eternity on an event-driven program). We've recently got reports of
the watchdog triggering on EPYC systems with blocks of 16 consecutive
threads not being able to make any progress. It turns out that such 16
consecutive threads seem to always be in the same core-complex, i.e.
same L3, so it seems that sometimes it's hard to reclaim a line that's
stressed by other nodes.

I wrote a program to measure inter-CPU atomic latencies and success/failure
rates to perform a CAS depending on each thread combination. Even on a
Ryzen 2700X (8 cores in 2*4 blocks) I've measured up to ~4k consecutive
failures. When trying to modify my code to try enforce some fairness, I
managed to go down to less than 4 failures. I was happy until I discovered
that there was a bug in my program making it not do anything except check
the shared variable that I'm using to enforce the fairness. So it seems
that interleaving multiple indenpendent accesses might sometimes help
provide some fairness in all of this, which is what I'm going to work on
today.

> All that aside, any advice on portably and usefully getting 2-3x clock
> frequency differences into testing would be quite welcome.

I think that playing with scaling_max_freq and randomly setting it
to either cpuinfo_min_freq or cpuinfo_max_freq could be a good start.
However it will likely not work inside KVM, but for bare-metal tests
it should work where cpufreq is supported.

Something like the untested below could be a good start, and maybe it
could even be periodically changed while the test is running:

   for p in /sys/devices/system/cpu/cpufreq/policy*; do
      min=$(cat $p/cpuinfo_min_freq)
      max=$(cat $p/cpuinfo_max_freq)
      if ((RANDOM & 1)); then
        echo $max > $p/scaling_max_freq
      else
        echo $min > $p/scaling_max_freq
      fi
   done

Then you can undo it like this:

   for p in /sys/devices/system/cpu/cpufreq/policy*; do
      cat $p/cpuinfo_max_freq > $p/scaling_max_freq
   done

On my i7-8650U laptop, the min/max freqs are 400/4200 MHz. On the previous
one (i5-3320M) it's 1200/3300. On a Ryzen 2700X it's 4000/2200. I'm seeing
800/5000 on a core i9-9900K. So I guess that it could be a good start. If
you need the ratios to be kept tighter, we could probably improve the
script above to try intermediate values.

Willy
