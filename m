Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD806C433EF
	for <rcu@archiver.kernel.org>; Thu,  7 Oct 2021 18:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B5E61040
	for <rcu@archiver.kernel.org>; Thu,  7 Oct 2021 18:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhJGSah (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Oct 2021 14:30:37 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44072 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238013AbhJGSag (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Oct 2021 14:30:36 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 197Hr36I012988;
        Thu, 7 Oct 2021 19:53:03 +0200
Date:   Thu, 7 Oct 2021 19:53:03 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org
Subject: Re: Making races happen more often
Message-ID: <20211007175303.GA12754@1wt.eu>
References: <20210926035103.GA1953486@paulmck-ThinkPad-P17-Gen-1>
 <20210926044127.GA11326@1wt.eu>
 <20210927032517.GR880162@paulmck-ThinkPad-P17-Gen-1>
 <20210927064915.GA20117@1wt.eu>
 <20210928040147.GA880162@paulmck-ThinkPad-P17-Gen-1>
 <20210929195908.GA9405@1wt.eu>
 <20210930184623.GI880162@paulmck-ThinkPad-P17-Gen-1>
 <20210930211218.GA18669@1wt.eu>
 <20211007004437.GG880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007004437.GG880162@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul!

On Wed, Oct 06, 2021 at 05:44:37PM -0700, Paul E. McKenney wrote:
> On Thu, Sep 30, 2021 at 11:12:18PM +0200, Willy Tarreau wrote:
> 
> Apologies for the delay!

No problem, that lets me think and analyse between exchanges :-)

>  I was involved in a bit of a time sink:
> https://paulmck.livejournal.com/62436.html

Very interesting and detailed. I'm far from having read it all yet
but that will certainly be useful whatever the outcome of rust in
kernel is.

> > > Do CPUs 1-7 and 8-15 show up in different nodes in sysfs?  If so, this
> > > case is already covered within rcutorture.  ;-)
> > 
> > No, they don't:
> > 
> > # lscpu -e
> > CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ    MINMHZ
> >   0    0      0    0 0:0:0:0          yes 4000.0000 2200.0000
> >   1    0      0    0 0:0:0:0          yes 4000.0000 2200.0000
> >   2    0      0    1 1:1:1:0          yes 4000.0000 2200.0000
> >   3    0      0    1 1:1:1:0          yes 4000.0000 2200.0000
> >   4    0      0    2 2:2:2:0          yes 4000.0000 2200.0000
> >   5    0      0    2 2:2:2:0          yes 4000.0000 2200.0000
> >   6    0      0    3 3:3:3:0          yes 4000.0000 2200.0000
> >   7    0      0    3 3:3:3:0          yes 4000.0000 2200.0000
> >   8    0      0    4 4:4:4:1          yes 4000.0000 2200.0000
> >   9    0      0    4 4:4:4:1          yes 4000.0000 2200.0000
> >  10    0      0    5 5:5:5:1          yes 4000.0000 2200.0000
> >  11    0      0    5 5:5:5:1          yes 4000.0000 2200.0000
> >  12    0      0    6 6:6:6:1          yes 4000.0000 2200.0000
> >  13    0      0    6 6:6:6:1          yes 4000.0000 2200.0000
> >  14    0      0    7 7:7:7:1          yes 4000.0000 2200.0000
> >  15    0      0    7 7:7:7:1          yes 4000.0000 2200.0000
> > 
> > The only difference you can see is the L3 appearing as different. Maybe
> > you could modify rcutorture to consider node+l3 as a distinct node ?
> 
> You know, it might be easier to parse "lscpu -e" output than doing
> it the way I currently do.  It should not be all that hard to take
> the first of NODE, SOCKET, and L3 that is non-constant.

I'm not that sure, because the output format will depend on the
machine it's run on and the entries found in /sys. For example
on an ARMv8 (S922X, 4*A73+2*A53) :

  $ lscpu -e
  CPU SOCKET CORE ONLINE    MAXMHZ   MINMHZ
    0      0    0    yes 2016.0000 500.0000
    1      0    1    yes 2016.0000 500.0000
    2      1    2    yes 2400.0000 500.0000
    3      1    3    yes 2400.0000 500.0000
    4      1    4    yes 2400.0000 500.0000
    5      1    5    yes 2400.0000 500.0000

  $ grep '' /sys/devices/system/cpu/cpu0/topology/*
  /sys/devices/system/cpu/cpu0/topology/core_id:0
  /sys/devices/system/cpu/cpu0/topology/core_siblings:03
  /sys/devices/system/cpu/cpu0/topology/core_siblings_list:0-1
  /sys/devices/system/cpu/cpu0/topology/physical_package_id:0
  /sys/devices/system/cpu/cpu0/topology/thread_siblings:01
  /sys/devices/system/cpu/cpu0/topology/thread_siblings_list:0

Here there's no cpu*/cache subdir.


On another one (S905D3 = 4xA55):

  $ lscpu -e
  CPU SOCKET CORE L1d:L1i:L2 ONLINE    MAXMHZ   MINMHZ
    0      0    0 0:0:0         yes 2208.0000 100.0000
    1      0    1 1:1:0         yes 2208.0000 100.0000
    2      0    2 2:2:0         yes 2208.0000 100.0000
    3      0    3 3:3:0         yes 2208.0000 100.0000

  $ grep '' /sys/devices/system/cpu/cpu0/topology/*
  /sys/devices/system/cpu/cpu0/topology/core_cpus:1
  /sys/devices/system/cpu/cpu0/topology/core_cpus_list:0
  /sys/devices/system/cpu/cpu0/topology/core_id:0
  /sys/devices/system/cpu/cpu0/topology/core_siblings:f
  /sys/devices/system/cpu/cpu0/topology/core_siblings_list:0-3
  /sys/devices/system/cpu/cpu0/topology/die_cpus:1
  /sys/devices/system/cpu/cpu0/topology/die_cpus_list:0
  /sys/devices/system/cpu/cpu0/topology/die_id:-1
  /sys/devices/system/cpu/cpu0/topology/package_cpus:f
  /sys/devices/system/cpu/cpu0/topology/package_cpus_list:0-3
  /sys/devices/system/cpu/cpu0/topology/physical_package_id:0
  /sys/devices/system/cpu/cpu0/topology/thread_siblings:1
  /sys/devices/system/cpu/cpu0/topology/thread_siblings_list:0

  $ grep '' /sys/devices/system/cpu/cpu0/cache/index*/*
  /sys/devices/system/cpu/cpu0/cache/index0/level:1
  /sys/devices/system/cpu/cpu0/cache/index0/shared_cpu_list:0
  /sys/devices/system/cpu/cpu0/cache/index0/shared_cpu_map:1
  /sys/devices/system/cpu/cpu0/cache/index0/type:Data
  /sys/devices/system/cpu/cpu0/cache/index1/level:1
  /sys/devices/system/cpu/cpu0/cache/index1/shared_cpu_list:0
  /sys/devices/system/cpu/cpu0/cache/index1/shared_cpu_map:1
  /sys/devices/system/cpu/cpu0/cache/index1/type:Instruction
  /sys/devices/system/cpu/cpu0/cache/index2/level:2
  /sys/devices/system/cpu/cpu0/cache/index2/shared_cpu_list:0-3
  /sys/devices/system/cpu/cpu0/cache/index2/shared_cpu_map:f
  /sys/devices/system/cpu/cpu0/cache/index2/type:Unified

Thus I think it can remain easier to directly deal with /sys,
especially if you've already done most of it.

> > > Indeed!  That line of reasoning led to the Itanium ld.bias instruction
> > > being my fault.  ;-)
> > 
> > I didn't know this feature. I suspect you could achieve the same using
> > cmpxchg(ptr,x,x), which will perform a write only if the area contains
> > magic value "x" to replace it with itself (thus put an unlikely one),
> > while other values will only perform the bus first cycle and will return
> > the value in x. On x86 (at least) it's documented that the load phase of
> > cmpxchg uses a bus write cycle, and arguably it's understandable that
> > nobody wants to start a cmpxchg without having exclusive ownership of
> > the cache line. So that should achieve your ld.bias on modern CPUs in
> > case you miss it, with a single bus cycle vs two for an atomic add :-)
> 
> Me, I prefer to work hard to reduce memory contention.  ;-)

For sure but I mean that if you *need* that, it's possible. By the
way I tested and I can confirm that cmpxchg is twice as fast as xadd
to perform a load from an exclusive line. It tends to significantly
reduce the amount of failed subsequent cmpxchg as I expected (I don't
have the numbers in mind anymore, something like 1/5 or so on avg and
peaks) but is quite slower as well on some machines (+30% on Ryzen vs
+50% for xadd, +10% on i7). It can provide a benefit but the failure
rate remains way higher than zero so it's not an awesome solution
either, I'll continue to work with my failure counters.

> > > > Another thing I discovered while preparing a machine for a test was that
> > > > there was an option in the BIOS proposing to automatically prefetch the
> > > > next cache line when reading one. I wasn't aware that some CPUs had this
> > > > option but this scared me, thinking that I'm trying to align some critical
> > > > structures on 64 bytes to avoid false sharing and that some machines
> > > > might be capable of still suffering from sharing between adjacent lines!
> > > 
> > > I have no idea whether to suggest turning off that option on the one
> > > hand or aligning to 128 bytes on the other...
> > 
> > That was my first idea when I read that option. Then I reread and noticed
> > this word "NEXT cache line", which is different from "prefetch cache line
> > PAIRS" or "adjacent cachelines" etc. I suspect it's used to optimise
> > memcpy() and it doesn't care about parity, so even if you align on 128,
> > if you hit the second cache line first you're sure to provoke the load
> > of the one that follows :-/  I have not tried to play with that yet and
> > the machines are currently in use so I won't know if these have any
> > impact for a while.
> 
> Ouch!

Yeah, that why I'm keeping that one on my mid-term todo list.

> > > > I'm wondering if you couldn't just try to prefetch
> > > > random lines from a very large memory location in the disturbing
> > > > threads. You might manage to waste a lot of memory bandwidth and to
> > > > cause high latencies. Maybe using AVX and friends to perform large
> > > > batches of writes could help further increase latency by filling
> > > > write buffers.
> > > 
> > > If I knew what data was involved in the bug, then yes, the occasional
> > > atomic add of zero to that data might be quite useful.
> > 
> > I meant doing it at random places in large batches to flush massive
> > amounts of cache lines and force irregular latencies that might disturb
> > communications between some cores.
> 
> That is worth some thought!

On that subject, I've been wondering about something that bothers me.

Please just keep in mind that I'm really incompetent on the various
memory models and quickly get lost in the terminology, but for having
designed write buffers for multi-core cpus a long time ago and having
seen diagrams of various models that look like what I know, I think I
have the background to understand the model at the hardware level.

My understanding of the x86-TSO model is that it guarantes that another
CPU will see the writes in the same order they were performed (or more
precisely will not see them reversed). But what if we modify a shared
variable (lock, counter, etc) inside a function call like this:

   int take_ref(int *ptr)
   {
	return xadd(ptr, 1);
   }

   int foo()
   {
        ...
        ref = take_ref(&counter);
   }

The calling function will push the return pointer onto the local stack,
thus perform a memory write to the L1 cache, but that's a memory write
nonetheless. Then it will atomically increment the shared counter, then
return.

If another processor competes with this one on the counter, requiring
an access to its cache line should cause the first processor's cache to
first flush the cache line that contains the part of the stack where the
return address was written, no ? If so that would mean that performing
certain operations on shared data inside non-inlined functions might
occasionally bring a big overhead consisting in flushing a totally
unrelated cache line at the same time. The same could be said for local
variables that the compiler spills into the stack when registers are
lacking by the way. Or are there any special attributes on the SS
segment to indicate that writes to the stack are totally relaxed ?

I'm a bit confused on this subject because I'm torn between "it's not
possible that it's that ugly, I must be missing something obvious" and
"except via a dedicated segment register how could that be implemented
given that there's no such a thing as a relaxed write on x86?". Any
hint or pointer to my mistake would be much appreciated.

> > I guess you already noticed, but just in case you didn't I dare to
> > mention it anyway, that 2199.0 seconds is almost exactly 2^31 * 1024 ns
> > (or 2^41 ns). That sounds incredibly suspicious for a discrete value
> > when it can remind an integer overflow somewhere. Just saying, as I
> > don't know the code involved :-)
> 
> Actually, I hadn't thought that through.  I knew that it had to be an
> overflow somewhere in timekeeping, and that once I pinned down the
> location of the failure, that I would be talking to someone in that
> area.  ;-)
> 
> But the stall times were all a bit over 2,199.02 seconds, so I do
> believe that you are quite correct!

Were the stalls really observed or could it be a measurement error,
that wrongly reports a stall based on the invalid calculation ? We're
talking about orders of magnitude where everything seems possible :-/

Willy
