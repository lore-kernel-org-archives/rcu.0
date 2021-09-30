Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130A0C433EF
	for <rcu@archiver.kernel.org>; Thu, 30 Sep 2021 21:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13EE6124D
	for <rcu@archiver.kernel.org>; Thu, 30 Sep 2021 21:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348668AbhI3VOG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Sep 2021 17:14:06 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:43686 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348834AbhI3VOG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Sep 2021 17:14:06 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 18ULCI0U019105;
        Thu, 30 Sep 2021 23:12:18 +0200
Date:   Thu, 30 Sep 2021 23:12:18 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org
Subject: Re: Making races happen more often
Message-ID: <20210930211218.GA18669@1wt.eu>
References: <20210926035103.GA1953486@paulmck-ThinkPad-P17-Gen-1>
 <20210926044127.GA11326@1wt.eu>
 <20210927032517.GR880162@paulmck-ThinkPad-P17-Gen-1>
 <20210927064915.GA20117@1wt.eu>
 <20210928040147.GA880162@paulmck-ThinkPad-P17-Gen-1>
 <20210929195908.GA9405@1wt.eu>
 <20210930184623.GI880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930184623.GI880162@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 30, 2021 at 11:46:23AM -0700, Paul E. McKenney wrote:
> > > So what rcutorture would want to do here is to assign the first four-CPU
> > > guest OS to CPUs 0, 1, 8, and 9, right?
> > 
> > Interesting idea, I didn't think about that. I would then do even better
> > if you use 4 CPUs. Here, as can be seen in the low latency numbers between
> > adjacent CPUs of the same pair, they're both threads of the same core. So
> > 0,1 are core 0 of die 0, and 8,9 are core 0 of die 1. Thus I would assign
> > two threads from the same core on an average core (either core 0 or 3 of
> > one die), and one thread of a fast core and one thread of a slow core of
> > the other die. That would give for example CPUs 0,1,10,12. This is how I
> > can imagine the highest unfairness between threads for your use case. A
> > variant could be to use CPU 2 instead of 10 (the low latency core).
> 
> Do CPUs 1-7 and 8-15 show up in different nodes in sysfs?  If so, this
> case is already covered within rcutorture.  ;-)

No, they don't:

# lscpu -e
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ    MINMHZ
  0    0      0    0 0:0:0:0          yes 4000.0000 2200.0000
  1    0      0    0 0:0:0:0          yes 4000.0000 2200.0000
  2    0      0    1 1:1:1:0          yes 4000.0000 2200.0000
  3    0      0    1 1:1:1:0          yes 4000.0000 2200.0000
  4    0      0    2 2:2:2:0          yes 4000.0000 2200.0000
  5    0      0    2 2:2:2:0          yes 4000.0000 2200.0000
  6    0      0    3 3:3:3:0          yes 4000.0000 2200.0000
  7    0      0    3 3:3:3:0          yes 4000.0000 2200.0000
  8    0      0    4 4:4:4:1          yes 4000.0000 2200.0000
  9    0      0    4 4:4:4:1          yes 4000.0000 2200.0000
 10    0      0    5 5:5:5:1          yes 4000.0000 2200.0000
 11    0      0    5 5:5:5:1          yes 4000.0000 2200.0000
 12    0      0    6 6:6:6:1          yes 4000.0000 2200.0000
 13    0      0    6 6:6:6:1          yes 4000.0000 2200.0000
 14    0      0    7 7:7:7:1          yes 4000.0000 2200.0000
 15    0      0    7 7:7:7:1          yes 4000.0000 2200.0000

The only difference you can see is the L3 appearing as different. Maybe
you could modify rcutorture to consider node+l3 as a distinct node ?

> > > It would actually do that if
> > > the /sys files indicate that CPUs 0-7 are on one node and CPUs 8-15
> > > on another.
> > 
> > Yep. Also, please note that my tests on a Xeon W2145 (8 cores 16 threads
> > as well, just organized differently) didn't show any single difference
> > between the cache access patterns of any core. Thus at best you could
> > hope for sharing two threads of a core and two other cores, but that's
> > all. I haven't tested on an EPYC yet but I'd be interested in seeing if
> > recent AMDs exhibit similar imbalance between their cores as their
> > ancestors.
> 
> I would expect quite a bit of variety.

We should get one in a few days-weeks so I expect to discover more stuff
and hopefully more bugs in my code.

> > > But I completely agree that cmpxchg operations on highly contended
> > > memory locations can expose all sorts of other issues.
> > 
> > Yep, they're "interesting" because the operation in itself is fundamentally
> > flawed and is used as the most inefficient building block for plenty of
> > other ones that emphasize bad patterns, starting with the opposite of
> > cmpxchg which would only replace a value if it's greater or lower for
> > example, or only replace it if not NULL. Due to the way it works,
> > slowdowns spiral down into a complete stall very quickly, and exponential
> > backoff that one might want to rely on usually further degrades the
> > situation since it requires to re-read before retrying.
> 
> Indeed!  That line of reasoning led to the Itanium ld.bias instruction
> being my fault.  ;-)

I didn't know this feature. I suspect you could achieve the same using
cmpxchg(ptr,x,x), which will perform a write only if the area contains
magic value "x" to replace it with itself (thus put an unlikely one),
while other values will only perform the bus first cycle and will return
the value in x. On x86 (at least) it's documented that the load phase of
cmpxchg uses a bus write cycle, and arguably it's understandable that
nobody wants to start a cmpxchg without having exclusive ownership of
the cache line. So that should achieve your ld.bias on modern CPUs in
case you miss it, with a single bus cycle vs two for an atomic add :-)

Do you think there could be some value in using this after a backoff
to reread an old value before retrying a CAS ? I'm just thinking that
if a cache controller holds the line a bit longer when it has exclusive
access there might be a chance of greater success, but I never tested
because I never thought about this. Now I feel like I'll have something
to play with this week-end.

> And that is exactly why good concurrent algorithms maintain low
> contention.  And I agree that this is more of an issue with cmpxchg than
> (say) xchg, xadd, and so on.  Assuming competent hardware, anyway.  :-/

That's exactly why I designed my upgradable locks around xadd a few years
ago! A single operation changes an unknown state to a known set of possible
states and returns the previous one. You can even rely on the wrapping
overflow to drop certain bits if needed.

> > My understanding is that they're connected like this:
> > 
> >       CPU    CPU    CPU    CPU        CPU    CPU    CPU    CPU
> >       0,1    2,3    4,5    6,7        8,9   10,11  12,13  14,15
> >     +----+ +----+ +----+ +----+     +----+ +----+ +----+ +----+
> >     |core| |core| |core| |core|     |core| |core| |core| |core|
> >     |  0 | |  1 | |  2 | |  3 |     |  4 | |  5 | |  6 | |  7 |
> >     +----+ +----+ +----+ +----+     +----+ +----+ +----+ +----+
> >        |      |      |      |          |      |      |      |
> >      +--+   +--+   +--+   +--+       +--+   +--+   +--+   +--+
> >      |L2|   |L2|   |L2|   |L2|       |L2|   |L2|   |L2|   |L2|
> >      +--+   +--+   +--+   +--+       +--+   +--+   +--+   +--+
> >        |      |      |      |          |      |      |      |
> >     +--------------------------+   +---------------------------+
> >   #=|          L3 1/2          |===|           L3 2/2          |=#
> >   # +--------------------------+   +---------------------------+ #
> >   #                                                              #
> >   #==============================================================#
> 
> Aha!  You cannot completely hide your hardware structure because your
> latencies will tell on you!  ;-)

:-)  That reminds me that when I was a kid I used to distinguish
serial port controller brands by monitoring their status bits during
a soft reset, and I noticed they would not all come up in the exact
same sequence depending on the manufacturer so I could proudly tell
my friends without opening their PC "that's intel or NS or Winbond"
(they wouldn't open to verify anyway). Fun times.

> > It's then easy to imagine an extra latency for cores 1 and 2 there,
> > with 2 being more impacted by two slots before it.
> 
> Indeed, beyond a certain point, it is necessary to talk to someone
> who actually knows the hardware structure.

Sure that can help but by the time you get your info, your CPU is
obsolete and you need to focus on another one. What matters to me
are two goals:
  - identify such awful patterns to make sure my code's performance
    will not degrade too much when running on these, or at least
    architect some options to work around them (e.g. thread groups)

  - easily detect where they exist so that I can use those machines
    to try to reproduce issues instead of using too slick machines
    that will never trigger issues (very similar to what you're
    trying to do in fact)

> > Another thing I discovered while preparing a machine for a test was that
> > there was an option in the BIOS proposing to automatically prefetch the
> > next cache line when reading one. I wasn't aware that some CPUs had this
> > option but this scared me, thinking that I'm trying to align some critical
> > structures on 64 bytes to avoid false sharing and that some machines
> > might be capable of still suffering from sharing between adjacent lines!
> 
> I have no idea whether to suggest turning off that option on the one
> hand or aligning to 128 bytes on the other...

That was my first idea when I read that option. Then I reread and noticed
this word "NEXT cache line", which is different from "prefetch cache line
PAIRS" or "adjacent cachelines" etc. I suspect it's used to optimise
memcpy() and it doesn't care about parity, so even if you align on 128,
if you hit the second cache line first you're sure to provoke the load
of the one that follows :-/  I have not tried to play with that yet and
the machines are currently in use so I won't know if these have any
impact for a while.

> > I'm wondering if you couldn't just try to prefetch
> > random lines from a very large memory location in the disturbing
> > threads. You might manage to waste a lot of memory bandwidth and to
> > cause high latencies. Maybe using AVX and friends to perform large
> > batches of writes could help further increase latency by filling
> > write buffers.
> 
> If I knew what data was involved in the bug, then yes, the occasional
> atomic add of zero to that data might be quite useful.

I meant doing it at random places in large batches to flush massive
amounts of cache lines and force irregular latencies that might disturb
communications between some cores.

> > > > I've been wondering if it's possible to change the tick rate inside KVM,
> > > > or even program a dummy device to deliver very fast IRQs but I haven't
> > > > found such a thing for now. I've been thinking about NMIs as well. The
> > > > idea would be that there could be a higher chance of interrupting
> > > > processing at any random place using fast interrupts (>100k/s) than by
> > > > using context switching caused by scheduler slots being depleted. Maybe
> > > > one only needs to hack an existing device emulator to flood an IRQ :-/
> > > 
> > > Or have a bug in the timekeeping code!  ;-)
> > 
> > Not sure how to achieve that, but maybe :-)
> 
> Given that the 2,199.0-second stall came as quite a surprise to the
> timekeeping folks, you are not the only one unsure as to how to achieve
> that.  In their defense, it took me quite some time to accept what was
> happening.

I guess you already noticed, but just in case you didn't I dare to
mention it anyway, that 2199.0 seconds is almost exactly 2^31 * 1024 ns
(or 2^41 ns). That sounds incredibly suspicious for a discrete value
when it can remind an integer overflow somewhere. Just saying, as I
don't know the code involved :-)

Willy
