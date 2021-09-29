Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F24C433EF
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 19:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC7261555
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 19:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344518AbhI2UA6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Sep 2021 16:00:58 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:43466 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245133AbhI2UAz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Sep 2021 16:00:55 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 18TJx8sx009753;
        Wed, 29 Sep 2021 21:59:08 +0200
Date:   Wed, 29 Sep 2021 21:59:08 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org
Subject: Re: Making races happen more often
Message-ID: <20210929195908.GA9405@1wt.eu>
References: <20210926035103.GA1953486@paulmck-ThinkPad-P17-Gen-1>
 <20210926044127.GA11326@1wt.eu>
 <20210927032517.GR880162@paulmck-ThinkPad-P17-Gen-1>
 <20210927064915.GA20117@1wt.eu>
 <20210928040147.GA880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928040147.GA880162@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 27, 2021 at 09:01:47PM -0700, Paul E. McKenney wrote:
> > And if you perform a load before the CAS (like for example when computing
> > a max or updating a pointer), it gets better for same-core-complex and
> > much worse for others:
> > 
> >          0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
> >      0   -  18  21  21  23  24  22  22 124 124 123 122 125 125 124 124
> >      1  18   -  22  22  24  24  22  22 124 124 122 122 124 124 124 123
> >      2  21  22   -  18  23  23  21  56 122 122 122 122 125 125 122 124
> >      3  21  21  18   -  23  23  21  20 123 123 122 122 124 124 122 122
> >      4  24  23  24  23   -  18  24  23 124 124 123 124 126 126 124 124
> >      5  24  24  23  23  18   -  23  23 124 124 124 123 126 126 125 126
> >      6  22  22  21  20  23  23   -  18 124 124 124 123 125 124 124 124
> >      7  22  22  20  21  23  24  18   - 125 124 122 122 126 124 125 125
> >      8 123 123 122 122 124 124 122 122   -  18  20  20  24  23  21  21
> >      9 124 124 123 123 125 125 124 124  18   -  20  21  24  24  58  21
> >     10 123 123 122 122 124 122 122 122  21  21   -  18  22  23  20  20
> >     11 123 122 122 122 123 124 124 123  20  20  18   -  23  23  23  20
> >     12 125 124 124 123 126 126 125 124  23  23  23  23   -  18  24  23
> >     13 126 125 124 123 126 126 124 124  23  23  24  22  18   -  23  23
> >     14 124 124 123 122 124 124 124 124  20  20  20  21  23  25   -  18
> >     15 124 124 123 123 125 124 124 124  22  21  20  56  24  24  18   -
> > 
> > See ? There's basically a factor of 6 in latency depending on the cores
> > that are supposed to be connected to the same L3. And looking closer you
> > even observe that within a same core-complex, things are not uniform at
> > all either:
> >   - core 1 always experiences fastest communication with other cores
> >   - core 2 always experiences slowest communication with other cores
> >   - discrepancies between pairs vay by up to 50%
> 
> So what rcutorture would want to do here is to assign the first four-CPU
> guest OS to CPUs 0, 1, 8, and 9, right?

Interesting idea, I didn't think about that. I would then do even better
if you use 4 CPUs. Here, as can be seen in the low latency numbers between
adjacent CPUs of the same pair, they're both threads of the same core. So
0,1 are core 0 of die 0, and 8,9 are core 0 of die 1. Thus I would assign
two threads from the same core on an average core (either core 0 or 3 of
one die), and one thread of a fast core and one thread of a slow core of
the other die. That would give for example CPUs 0,1,10,12. This is how I
can imagine the highest unfairness between threads for your use case. A
variant could be to use CPU 2 instead of 10 (the low latency core).

> It would actually do that if
> the /sys files indicate that CPUs 0-7 are on one node and CPUs 8-15
> on another.

Yep. Also, please note that my tests on a Xeon W2145 (8 cores 16 threads
as well, just organized differently) didn't show any single difference
between the cache access patterns of any core. Thus at best you could
hope for sharing two threads of a core and two other cores, but that's
all. I haven't tested on an EPYC yet but I'd be interested in seeing if
recent AMDs exhibit similar imbalance between their cores as their
ancestors.

> > In your case it could mean that certain races will never happen on certain
> > cores but could on others ones, or at least above certain frequencies,
> > because if the cache line sticks long enough in an L2 to perform a series
> > of operations undisturbed, whatever you'll do on other cores might have no
> > effect.
> 
> In the cases exposed by my differential-latency testing, the issue was
> pretty clearly the added delay.  This is because the issue involved
> normal memory references for the RCU Tasks Trace bugs, read-side access
> to seqlock-protected memory for the 2,199.0-second RCU CPU stall warning
> (normal memory accesses plus memory barriers), and a lockdep false
> positive in the Tiny SRCU case (though in lockdep's defense, this was
> at best an accident waiting to happen).

These really don't look like easy patterns to reproduce!

> But I completely agree that cmpxchg operations on highly contended
> memory locations can expose all sorts of other issues.

Yep, they're "interesting" because the operation in itself is fundamentally
flawed and is used as the most inefficient building block for plenty of
other ones that emphasize bad patterns, starting with the opposite of
cmpxchg which would only replace a value if it's greater or lower for
example, or only replace it if not NULL. Due to the way it works,
slowdowns spiral down into a complete stall very quickly, and exponential
backoff that one might want to rely on usually further degrades the
situation since it requires to re-read before retrying.

> > I suspect that working at much lower frequencies could at some point allow
> > to release a cache line between two operations. I don't seem to be observing
> > this on the AMD for now though, as the differences increase when lowering
> > the frequency from 4.0 to 2.2G for a single CAS:
> > 
> >          0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
> >      0   -  19  55  55  48  48  62  62 103 103 105 105 103 103 103 103
> >      1  19   -  55  55  48  48  62  62 103 103 105 105 103 103 103 103
> >      2  55  55   -  19  40  40  55  55 104 104 106 106 107 107 104 103
> >      3  55  55  19   -  40  40  55  55 104 104 105 106 107 107 104 104
> >      4  48  48  40  40   -  19  47  47 109 109 107 106 105 105 112 111
> >      5  48  48  40  40  19   -  47  47 109 109 107 106 105 105 111 111
> >      6  62  62  55  55  47  47   -  19 103 103 105 105 103 103 103 103
> >      7  62  62  55  55  47  47  19   - 103 103 105 105 103 103 103 103
> >      8 103 103 104 104 110 109 103 103   -  19  55  55  48  48  62  62
> >      9 103 103 104 104 110 110 103 103  19   -  55  55  48  48  62  62
> >     10 105 105 105 106 106 106 105 105  55  55   -  19  40  40  55  55
> >     11 105 105 105 106 107 107 105 105  55  55  19   -  40  40  55  55
> >     12 103 103 108 107 105 105 103 103  48  48  40  40   -  19  47  47
> >     13 103 103 107 107 105 105 103 103  48  48  40  40  19   -  47  47
> >     14 103 103 105 104 110 111 103 103  62  62  55  55  47  47   -  19
> >     15 103 103 104 104 111 111 103 103  62  62  55  55  47  47  19   -
> > 
> > Where a same core-complex would see variations from 22 to 26ns now we're
> > seeing 40 to 62!
> 
> Huh.  Are the fast CPUs seeing higher latencies due to delays from the
> slower CPUs?  Or is the clock-frequency difference causing increased
> delays in and of itself?  (Crossing clock-frequency domains can be much
> harder than it might seem to us software folks.)

Note, they're all running at the same frequency here (2.2 GHzin this
test). I do think that all of this can be caused by non-integral
frequency ratios between the cores and the caches that would miss the
end of a cycle and have to wait for yet another one. But I could be
completely wrong. It could also be that the caches hold a line at least
X of their cycles in order to optimize for such test-and-set operations,
and that below a certain core frequency the cache doesn't hold the line
long enough for the operation to complete, causing repeated failures
due to contention with other cores. Note, for the measures above, I'm
running only with two threads for each measure, and each thread waits
for the other one's value in the shared counter to replace it (i.e. one
replaces odd values with even ones and the other one replaces even
values with odd ones).

> So adjacent pairs of CPUs are electrically close as well?  I am looking
> at the 18s and 19s along the diagonal above.

These ones are sibling threads of the same core. I didn't notice that
their time didn't change with the frequency, it's still 18-19 ns for
both 2.2 and 4.0 GHz! So this makes me think that the L1 is not shared
at all and exchanges between them pass via the L2 which runs at a
constant frequency and not at the core frequency.

> There appears to be
> additional structure above the CPU-pair level within an 8-CPU group.
> A linear arrangement of four pairs of CPUs?

Yes that's exactly what I meant with the core complexes. My understanding
is that they're connected like this:

      CPU    CPU    CPU    CPU        CPU    CPU    CPU    CPU
      0,1    2,3    4,5    6,7        8,9   10,11  12,13  14,15
    +----+ +----+ +----+ +----+     +----+ +----+ +----+ +----+
    |core| |core| |core| |core|     |core| |core| |core| |core|
    |  0 | |  1 | |  2 | |  3 |     |  4 | |  5 | |  6 | |  7 |
    +----+ +----+ +----+ +----+     +----+ +----+ +----+ +----+
       |      |      |      |          |      |      |      |
     +--+   +--+   +--+   +--+       +--+   +--+   +--+   +--+
     |L2|   |L2|   |L2|   |L2|       |L2|   |L2|   |L2|   |L2|
     +--+   +--+   +--+   +--+       +--+   +--+   +--+   +--+
       |      |      |      |          |      |      |      |
    +--------------------------+   +---------------------------+
  #=|          L3 1/2          |===|           L3 2/2          |=#
  # +--------------------------+   +---------------------------+ #
  #                                                              #
  #==============================================================#

That's not cool for their users (I imagine those running VMs with
automatic CPU allocations...) but when trying to emphasize horrible
patterns like you and me do, they're particularly interesting :-)

My suspicion is that the L3 blocks have in fact 6-7 total ports with
some rotary arbitration and that the cores are connected there in a
specific order, and that the ring connection to the other half just
uses extra ports that are located at certain places that favor more
or less certain cores. Maybe that it's even 7 ports (for the
diagonal in 16+ core CPUs) and that the 7th port is left unused
here, which could also explain the asymmetry between all threads.
For example it could look like this for each block with all 7 ports
being round-robinned:

                to L3 cores 4-7
                east port
                //
            +------+
            |      |
   core 0 ==|  L3  |== core 1
            |block |
            |cores |
   core 2 ==| 0-3  |== core 3
            |      |
            +------+
             //  \\
         unused   to L3 cores 4-7
                  west port

It's then easy to imagine an extra latency for cores 1 and 2 there,
with 2 being more impacted by two slots before it.

> All points in favor of your long-term plan of reducing contention of
> the variable being cmpxchg()ed.

Oh yes definitely! I know it's not the subject here but I'm currently
modifying the architecture to support thread groups to partition the
contention. It's way more complex than I imagined, and as usual the
devil is in the details.

> > Another point I'm quite interested in is trying to group operations from
> > close neighbors. In the example above on the Ryzen CPU, I would love to
> > see CPUs from the same core complex try their luck together. One could
> > think about using a CPU number to distribute accesses so that they're
> > grouped, but it's less convenient from userland (or even from a VM). One
> > element however knows better than the software, it's the cache controller.
> > That's why I'm trying to keep *some* contention, so that once a core gets
> > its access to the cache, the other ones on the same side of the L3 have a
> > better chance to access it immediately after. And I think that's how I've
> > reached an average of 45ns per operation (stats included) in my last test
> > across all CPUs despite inter-CPU times ranging from 18 to 125ns. But that
> > is quite unstable for now.
> 
> And very very dependent on the exact hardware.

Yep! For the record this one is an AMD Ryzen 2700X.

> I have seen hardware where prefetching the line passed to cmpxchg
> doubled the overhead, and some where it made no measurable difference.

I noticed exactly the same. Prefetching on the Xeon W2145 costs twice
as much :-(

Another thing I discovered while preparing a machine for a test was that
there was an option in the BIOS proposing to automatically prefetch the
next cache line when reading one. I wasn't aware that some CPUs had this
option but this scared me, thinking that I'm trying to align some critical
structures on 64 bytes to avoid false sharing and that some machines
might be capable of still suffering from sharing between adjacent lines!

> > > > > All that aside, any advice on portably and usefully getting 2-3x clock
> > > > > frequency differences into testing would be quite welcome.
> > > > 
> > > > I think that playing with scaling_max_freq and randomly setting it
> > > > to either cpuinfo_min_freq or cpuinfo_max_freq could be a good start.
> > > > However it will likely not work inside KVM, but for bare-metal tests
> > > > it should work where cpufreq is supported.
> > > 
> > > OK, that explains at least some of my difficulties.  I almost always
> > > run under qemu/KVM.
> > 
> > But you could disturb the real machine with changing its frequency.
> 
> Fair point, and that should fit into the memory-latency disturbing
> that I am currently doing.

Yes very likely. I'm wondering if you couldn't just try to prefetch
random lines from a very large memory location in the disturbing
threads. You might manage to waste a lot of memory bandwidth and to
cause high latencies. Maybe using AVX and friends to perform large
batches of writes could help further increase latency by filling
write buffers.

> > I've been wondering if it's possible to change the tick rate inside KVM,
> > or even program a dummy device to deliver very fast IRQs but I haven't
> > found such a thing for now. I've been thinking about NMIs as well. The
> > idea would be that there could be a higher chance of interrupting
> > processing at any random place using fast interrupts (>100k/s) than by
> > using context switching caused by scheduler slots being depleted. Maybe
> > one only needs to hack an existing device emulator to flood an IRQ :-/
> 
> Or have a bug in the timekeeping code!  ;-)

Not sure how to achieve that, but maybe :-)

Willy
