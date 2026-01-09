Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D71B4223;
	Fri,  9 Jan 2026 01:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767923551; cv=none; b=oU2bVxPuMfdLL2xvo2UHqtKGbpC91lZHzDRuQqHIsLxliBNDDWzTp8EHplzc+i7Tm+OEOzviraEgXWWuKDv0xgyvg5vQpjpEcOC7aFeo1Fp43WFsAGppL/h7/+q60FHfIOVRkTee6uPsVttBfTYbJVG78WplfbHGN5jng140kM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767923551; c=relaxed/simple;
	bh=jptyz8Z4ZD52vuiGgjq7IqwbJ3HDwRfF6JN2oeBy1Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACn0PRFFhs2WBKR/yJ7RRkAua85wm0HuPkUQR8yH/bFbiyRYGYHMdw7eqETq7EC5f5o0MmMHAECWQBDyQql49rWiCzzlUoDXk5nRkyyoMJwyJBk8JitjRHmUH6EWGBxwC4N0ecNbDn7ObLH0F0j5dwHC42hhpgj6qlkSVjm1jck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpXGRgho; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpXGRgho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30A9C116C6;
	Fri,  9 Jan 2026 01:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767923551;
	bh=jptyz8Z4ZD52vuiGgjq7IqwbJ3HDwRfF6JN2oeBy1Po=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KpXGRghoFNZW4SZr4lGPF3aDYD/X/WIfEQxUlM4iNuAAMZCErnJH66LEseegR+gAM
	 lvaaXXQw4OHEzcTeQtTKrmLdVGPg6VGH8DPTUXBuEk12bsqZRSf2ajZubMVv6OawIV
	 qgGm3NDpFVY6Gbj9pQp6b9ev5nxq9p4TNmpMdODBc/CZ3o2za+rSlN5DTmoy/nywon
	 Lqxc/FeS3956/wZORrsuybcewsoM4lO0yuDp8WYogljzQAcJaWkoogt2wcs6hRJjH5
	 W9sb//2V4mvViZDZwiYN97H40h2axKGa/klgzoEC1dqpFJRiFTy811esa22j2km1IS
	 KUVEu4jm/B8jQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 505D2CE1690; Thu,  8 Jan 2026 17:52:30 -0800 (PST)
Date: Thu, 8 Jan 2026 17:52:30 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org
Subject: Re: [PATCH RFC 00/14] rcu: Reduce rnp->lock contention with per-CPU
 blocked task lists
Message-ID: <90da4d88-e429-4b3b-bcb4-a8512daf3599@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
 <658b114e-b362-47e1-9dc8-9271cbcf2c4d@paulmck-laptop>
 <f679698b-3fc3-4bcc-834a-97c670e6ffe1@joelfernandes.org>
 <9a6016f5-3051-4055-9fd2-05a01c0c9171@paulmck-laptop>
 <9acfe215-5a14-428f-a398-e6a0b3dc18b4@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9acfe215-5a14-428f-a398-e6a0b3dc18b4@joelfernandes.org>

On Tue, Jan 06, 2026 at 03:40:04PM -0500, Joel Fernandes wrote:
> On 1/6/2026 2:17 PM, Paul E. McKenney wrote:
> > On Mon, Jan 05, 2026 at 07:55:18PM -0500, Joel Fernandes wrote:
> [..]
> >>>> The optimized version maintains stable performance with essentially close to
> >>>> zero rnp->lock overhead.
> >>>>
> >>>> rcutorture Testing
> >>>> ------------------
> >>>> TREE03 Testing with rcutorture without RCU or hotplug errors. More testing is
> >>>> in progress.
> >>>>
> >>>> Note: I have added a CONFIG_RCU_PER_CPU_BLOCKED_LISTS to guard the feature but
> >>>> the plan is to eventually turn this on all the time.
> >>>
> >>> Yes, Aravinda, Gopinath, and I did publish that paper back in the day
> >>> (with Aravinda having done almost all the work), but it was an artificial
> >>> workload.  Which is OK given that it was an academic effort.  It has also
> >>> provided some entertainment, for example, an audience member asking me
> >>> if I was aware of this work in a linguistic-kill-shot manner.  ;-)
> >>>
> >>> So are we finally seeing this effect in the wild?
> >>
> >> This patch set is also targeting a synthetic test I wrote to see if I could
> >> reproduce a preemption problem. I know several instances over the years where my
> >> teams (mainly at Google) were trying to resolve spin lock preemption inside
> >> virtual machines by boosting vCPU threads. In the spirit of RCU performance and
> >> VMs, we should probably optimize node locking IMO, but I do see your point of
> >> view about optimizing real-world use cases as well.
> > 
> > Also taking care of all spinlocks instead of doing large numbers of
> > per-spinlock workarounds would be good.  There are a *lot* of spinlocks
> > in the Linux kernel!
> 
> I wouldn't call it a workaround yet. Avoiding lock contention by using per CPU
> list is an optimization we have done before right? (Example the synthetic RCU
> callback-flooding use case where we used a per-cpu list). We can call it
> defensive programming, if you will. ;-) Especially in the scheduler hot path
> where we are blocking/preempting. Again, I'm not saying we should do it for this
> case since we are still studying the issue, but just on the fact that we are
> optimizing a spin lock we acquire *a lot* shouldn't be categorized as a
> workaround in my opinion.
> 
> This blocking is even more likely on preempt RT in read-side critical sections.
> Again, I'm not saying that we should do this optimization, but I don't think we
> can ignore it. At least not based on the data I have so far.

If the main motivation is vCPU preemption, I consider this to be a
workaround for the lack of awareness of guest-OS locks by the host OS.
If there is some other reasonable way of generating contention on
this lock, then per-CPU locking is one specific way of addressing that
contention.  As is reducing the value of CONFIG_RCU_FANOUT_LEAF and who
knows what all else.

> >> What bothers me about the current state of affairs is that even without any
> >> grace period in progress, any task blocking in an RCU Read Side critical section
> >> will take a (almost-)global lock that is shared by other CPUs who might also be
> >> preempting/blocking RCU readers. Further, if this happens to be a vCPU that was
> >> preempted while holding the node lock, then every other vCPU thread that blocks
> >> in an RCU critical section will also block and end up slowing preemption down in
> >> the vCPU. My preference would be to keep the readers fast while moving the
> >> overhead to the slow path (the overhead being promoting tasks at the right time
> >> that were blocked). In fact, in these patches, I'm directly going to the node
> >> list if there is a grace period in progress.
> > 
> > Not "(almost-)global"!
> > 
> > That lock replicates itself automatically with increasing numbers of CPUs.
> > That 16 used to be the full (at the time) 32-bit cpumask, but we decreased
> > it to 16 based on performance feedback from Andi Kleen back in the day.
> > If we are seeing real-world contention on that lock in real-world
> > workloads on real-world systems, further adjustments could be made,
> > either reducing CONFIG_RCU_FANOUT_LEAF further or offloading the lock,
> > where your series is one example of the latter.
> 
> I meant it is global or almost global depending on the number of CPUs. So for
> example on an 8 CPU system with the default fanout, it is a global lock, correct?

Yes, but only assuming the default CONFIG_RCU_FANOUT_LEAF value of
16, or some other value of 8 or larger.  But in that case, there are
only 8 CPUs contending for that lock, so is there really a problem?
(In the absence of vCPU contention, that is.)  And the default value
can be changed if needed.

> > I could easily believe that the vCPU preemption problem needs to be
> > addressed, but doing so on a per-spinlock basis would lead to greatly
> > increased complexity throughout the kernel, not just RCU.
> 
> I agree with this. I was not intending to solve this for the entire kernel, at
> first at least.

If addressing vCPU contention is the goal, how many locks are individually
adjusted before solving it for the whole kernel becomes easier and
less complex?

> >> About the deferred-preemption, I believe Steven Rostedt at one point was looking
> >> at that for VMs, but that effort stalled as Peter is concerned about doing that
> >> would mess up the scheduler. The idea (AFAIU) is to use the rseq page to
> >> communicate locking information between vCPU threads and the host and then let
> >> the host avoid vCPU preemption - but the scheduler needs to do something with
> >> that information. Otherwise, it's no use.
> > 
> > Has deferred preemption for userspace locking also stalled?  If not,
> > then the scheduler's support for userspace should apply directly to
> > guest OSes, right?
> 
> I don't think there have been any user space locking optimizations for
> preemption that has made it upstream (AFAIK). I know there were efforts, but I
> could be out of date there. I think the devil is in the details as well because
> user space optimizations cannot always be applied to guests in my experience.
> The VM exit path and the syscall entry/exit paths are quite different, including
> the API boundary.

Thomas and Steve are having another go at the userspace portion of
this problem.  Should that make it in, the guest-OS portion might not
be that big an ask.

> >>> Also if so, would the following rather simpler patch do the same trick,
> >>> if accompanied by CONFIG_RCU_FANOUT_LEAF=1?
> >>>
> >>> ------------------------------------------------------------------------
> >>>
> >>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> >>> index 6a319e2926589..04dbee983b37d 100644
> >>> --- a/kernel/rcu/Kconfig
> >>> +++ b/kernel/rcu/Kconfig
> >>> @@ -198,9 +198,9 @@ config RCU_FANOUT
> >>>  
> >>>  config RCU_FANOUT_LEAF
> >>>  	int "Tree-based hierarchical RCU leaf-level fanout value"
> >>> -	range 2 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
> >>> -	range 2 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
> >>> -	range 2 3 if RCU_STRICT_GRACE_PERIOD
> >>> +	range 1 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
> >>> +	range 1 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
> >>> +	range 1 3 if RCU_STRICT_GRACE_PERIOD
> >>>  	depends on TREE_RCU && RCU_EXPERT>  	default 16 if !RCU_STRICT_GRACE_PERIOD
> >>>  	default 2 if RCU_STRICT_GRACE_PERIOD
> >>>
> >>> ------------------------------------------------------------------------
> >>>
> >>> This passes a quick 20-minute rcutorture smoke test.  Does it provide
> >>> similar performance benefits?
> >>
> >> I tried this out, and it also brings down the contention and solves the problem
> >> I saw (in testing so far).
> >>
> >> Would this work also if the test had grace periods init/cleanup racing with
> >> preempted RCU read-side critical sections? I'm doing longer tests now to see how
> >> this performs under GP-stress, versus my solution. I am also seeing that with
> >> just the node lists, not per-cpu list, I see a dramatic throughput drop after
> >> some amount of time, but I can't explain it. And I do not see this with the
> >> per-cpu list solution (I'm currently testing if I see the same throughput drop
> >> with the fan-out solution you proposed).
> > 
> > Might the throughput drop be due to increased load on the host?
> 
> The load is constant with the benchmark, and the data is repeatable and
> consistent. So random load on the host is unlikely.

So you have a system with the various background threads corralled or
disabled?

> > Another possibility is that tasks/vCPUs got shuffled so as to increase
> > the probability of preemption.
> > 
> > Also, doesn't your patch also cause the grace-period kthread to acquire
> > that per-CPU lock, thus also possibly resulting in contention, vCPU
> > preemption, and so on?
> 
> Yes, I'm tracing it more. Even with baseline (without these patches), I see this
> throughput drop so it is worth investigating. I think it's something possibly
> like a lock convoy forming, but the fact that if I don't use RNP locking, the
> lock convoy disappears, and the throughput is completely stable. That tells me
> that that has something to do with that or something related. I also measured
> the exact RNP lock time and counted the number of contentions, so I am not
> really guessing here. The RNP lock is contended consistently. I think it's a
> great idea for me to extend this lock contention measurement to the run queue
> locks as well, for me to measure how they are doing (or even extending it to all
> locks, as you mentioned) - at least for me to confirm the theory that the same
> test severely contends other locks as well.

Is the RNP lock contended under non-overload conditions?  If I remember
correctly, you were running 2x CPU overload.  Is the RNP lock contended
in bare-metal kernels?

							Thanx, Paul

> >> I'm also wondering whether relying on the user to set FANOUT_LEAF to 1 is
> >> reasonable, considering this is not a default. Are you suggesting defaulting to
> >> this for small systems? If not, then I guess the optimization will not be
> >> enabled by default. Eventually, with this patch set, if we are moving forward
> >> with this approach, I will remove the config option for per-CPU block list
> >> altogether so that it is enabled by default. That's kind of my plan if we agreed
> >> on this, but it is just an RFC stage :).
> > 
> > Right now, we are experimenting, so the usability issue is less pressing.
> > Once we find out what is really going on for real-world systems, we
> > can make adjustments if and as appropriate, said adjustments including
> > usability.
> 
> Sure, thanks.
> 
>  - Joel
> 
