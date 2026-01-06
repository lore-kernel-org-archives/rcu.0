Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7C92D8763;
	Tue,  6 Jan 2026 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767727040; cv=none; b=uAYlT1GBIMJqJvxPp1l5NZT9QdfWFWmA8Uw4rSSj1g2jBodqF1toNX6kJk+6C73YjdF/9mjo62gZUzVtIkSODOtKqcUQmjr4rK95BJVnUSPtPn88boJgMPHwitWgMnZ9OguVdrTqMsf1vM8JBCdFbujiqbNbrb29t2viivCujJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767727040; c=relaxed/simple;
	bh=6cjRPMfAuj8yfoX7s5RmbV0D96UTtiF1zgJF0zxnhCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nArh+nYdIH/vpBqZaRZb6+sP/9SUIzzPD0Qos49XNIo2ISPojkoDLPdgA1Yv8w4OZPhc8mMWppGZzLuLj9aZyCSs624GL6LnTL4yWfJ7KIHc4ZBQsgyszpzGfAltWX0ob3l+8e2VTnJNPXGuCVO30zid55MKJdsgDmcUZPiu7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isMO8z03; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isMO8z03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD09EC116C6;
	Tue,  6 Jan 2026 19:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767727039;
	bh=6cjRPMfAuj8yfoX7s5RmbV0D96UTtiF1zgJF0zxnhCE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=isMO8z03UXCaGpeGUrYE63rgbFVZUVo9KA10gfqcOKUiJDSI1/wiXK3HV8SJkydPB
	 u8/HstAdjuESFwiAn6QAJ7B6pe9NWinEOJ4bHUxkfEVA8zZfOlypQUwvvj5819GkL0
	 4s+TsRdDiKc+gg/e7ZOje7J7bZp1ykBS+98xMQOxj6i0BVlH/V4pi8SzBo5ONBYeo6
	 t5lmStU5ssBlP9axatfXFZrRi/c8o1Ibm3YFacDaWmRjsxFdM+5ekMlaf/C9Dw6HQ+
	 H1gScDi7bxAvOiHQ7KDX7IrN3ae63ZEVMWT5eqsqsI59T+VLcngPSjQAka9SZlmZpG
	 FraeBCBmXZg/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7B89DCE0B06; Tue,  6 Jan 2026 11:17:19 -0800 (PST)
Date: Tue, 6 Jan 2026 11:17:19 -0800
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
Message-ID: <9a6016f5-3051-4055-9fd2-05a01c0c9171@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
 <658b114e-b362-47e1-9dc8-9271cbcf2c4d@paulmck-laptop>
 <f679698b-3fc3-4bcc-834a-97c670e6ffe1@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f679698b-3fc3-4bcc-834a-97c670e6ffe1@joelfernandes.org>

On Mon, Jan 05, 2026 at 07:55:18PM -0500, Joel Fernandes wrote:
> Hi Paul,
> 
> On 1/5/2026 11:46 AM, Paul E. McKenney wrote:
> > On Fri, Jan 02, 2026 at 07:23:29PM -0500, Joel Fernandes wrote:
> >> When a task is preempted while holding an RCU read-side lock, the kernel
> >> must track it on the rcu_node's blocked task list. This requires acquiring
> >> rnp->lock shared by all CPUs in that node's subtree.
> >>
> >> Posting this as RFC for early feedback. There could be bugs lurking,
> >> especially related to expedited GPs which I have not yet taken a close
> >> look at. Several TODOs are added. It passed light TREE03 rcutorture
> >> testing.
> >>
> >> On systems with 16 or fewer CPUs, the RCU hierarchy often has just a single
> >> rcu_node, making rnp->lock effectively a global lock for all blocked task
> >> operations. Every context switch where a task holds an RCU read-side lock
> >> contends on this single lock.
> >>
> >> Enter Virtualization
> >> --------------------
> >> In virtualized environments, the problem becomes dramatically worse due to vCPU
> >> preemption. Research from USENIX ATC'17 ("The RCU-Reader Preemption Problem in
> >> VMs" by Gopinath and Paul McKenney) [1] explores the issue that RCU
> >> reader preemption in VMs causes multi-second latency spikes and huge increases
> >> in grace period duration.
> >>
> >> When a vCPU is preempted by the hypervisor while holding rnp->lock, other
> >> vCPUs spin waiting for a lock holder that isn't even running. In testing
> >> with host RT preemptors to inject vCPU preemption, lock hold times extended
> >> from ~4us to over 4000us - a 1000x increase.
> >>
> >> The Solution
> >> ------------
> >> This series introduces per-CPU lists for tracking blocked RCU readers. The
> >> key insight is that when no grace period is active, blocked tasks complete
> >> their critical sections before really requiring any rnp locking.
> >>
> >> 1. Fast path: At context switch, Add the task only to the
> >>    per-CPU list - no rnp->lock needed.
> >>
> >> 2. Promotion on demand: When a grace period starts, promote tasks from
> >>    per-CPU lists to the rcu_node list.
> >>
> >> 3. Normal path: If a grace period is already waiting, tasks go directly
> >>    to the rcu_node list as before.
> >>
> >> Results
> >> -------
> >> Testing with 64 reader threads under vCPU preemption from 32 host SCHED_FIFO
> >> preemptors), 100 runs each. Throughput measured of read lock/unlock iterations
> >> per second.
> >>
> >>                         Baseline        Optimized
> >> Mean throughput         66,980 iter/s   97,719 iter/s   (+46%)
> >> Lock hold time (mean)   1,069 us        ~0 us
> > 
> > Excellent performance improvement!
> 
> Thanks. :)
> > It would be good to simplify the management of the blocked-tasks lists,
> > and to make it more exact, as in never unnecessarily priority-boost
> > a task.  But it is not like people have been complaining, at least not
> > to me.  And earlier attempts in that direction added more mess than
> > simplification.  :-(
> 
> Interesting. I might look into the boosting logic to see whether we can avoid
> boosting certain tasks depending on whether they help the grace period complete
> or not. Thank you for the suggestion.

Just so you know, all of my simplification efforts thus far have instead
made it more complex, but who knows what I might have been missing?

> >> The optimized version maintains stable performance with essentially close to
> >> zero rnp->lock overhead.
> >>
> >> rcutorture Testing
> >> ------------------
> >> TREE03 Testing with rcutorture without RCU or hotplug errors. More testing is
> >> in progress.
> >>
> >> Note: I have added a CONFIG_RCU_PER_CPU_BLOCKED_LISTS to guard the feature but
> >> the plan is to eventually turn this on all the time.
> > 
> > Yes, Aravinda, Gopinath, and I did publish that paper back in the day
> > (with Aravinda having done almost all the work), but it was an artificial
> > workload.  Which is OK given that it was an academic effort.  It has also
> > provided some entertainment, for example, an audience member asking me
> > if I was aware of this work in a linguistic-kill-shot manner.  ;-)
> > 
> > So are we finally seeing this effect in the wild?
> 
> This patch set is also targeting a synthetic test I wrote to see if I could
> reproduce a preemption problem. I know several instances over the years where my
> teams (mainly at Google) were trying to resolve spin lock preemption inside
> virtual machines by boosting vCPU threads. In the spirit of RCU performance and
> VMs, we should probably optimize node locking IMO, but I do see your point of
> view about optimizing real-world use cases as well.

Also taking care of all spinlocks instead of doing large numbers of
per-spinlock workarounds would be good.  There are a *lot* of spinlocks
in the Linux kernel!

> What bothers me about the current state of affairs is that even without any
> grace period in progress, any task blocking in an RCU Read Side critical section
> will take a (almost-)global lock that is shared by other CPUs who might also be
> preempting/blocking RCU readers. Further, if this happens to be a vCPU that was
> preempted while holding the node lock, then every other vCPU thread that blocks
> in an RCU critical section will also block and end up slowing preemption down in
> the vCPU. My preference would be to keep the readers fast while moving the
> overhead to the slow path (the overhead being promoting tasks at the right time
> that were blocked). In fact, in these patches, I'm directly going to the node
> list if there is a grace period in progress.

Not "(almost-)global"!

That lock replicates itself automatically with increasing numbers of CPUs.
That 16 used to be the full (at the time) 32-bit cpumask, but we decreased
it to 16 based on performance feedback from Andi Kleen back in the day.
If we are seeing real-world contention on that lock in real-world
workloads on real-world systems, further adjustments could be made,
either reducing CONFIG_RCU_FANOUT_LEAF further or offloading the lock,
where your series is one example of the latter.

I could easily believe that the vCPU preemption problem needs to be
addressed, but doing so on a per-spinlock basis would lead to greatly
increased complexity throughout the kernel, not just RCU.

> > The main point of this patch series is to avoid lock contention due to
> > vCPU preemption, correct?  If so, will we need similar work on the other
> > locks in the Linux kernel, both within RCU and elsewhere?  I vaguely
> > recall your doing some work along those lines a few years back, and
> > maybe Thomas Gleixner's deferred-preemption work could help with this.
> > Or not, who knows?  Keeping the hypervisor informed of lock state is
> > not necessarily free.
> 
> Yes, I did some work on this at Google, but it turned out to be a very
> fragmented effort in terms of where (which subsystem - KVM, scheduler etc)
> should we do the priority boosting of vCPU threads. In the end, we just ended up
> with an internal prototype that was not upstreamable but worked pretty well and
> only had time for production (a lesson I learned there is we should probably
> work on upstream solutions first, but life is not that easy sometimes).

Which is one reason deferred preemption would be attractive.

> About the deferred-preemption, I believe Steven Rostedt at one point was looking
> at that for VMs, but that effort stalled as Peter is concerned about doing that
> would mess up the scheduler. The idea (AFAIU) is to use the rseq page to
> communicate locking information between vCPU threads and the host and then let
> the host avoid vCPU preemption - but the scheduler needs to do something with
> that information. Otherwise, it's no use.

Has deferred preemption for userspace locking also stalled?  If not,
then the scheduler's support for userspace should apply directly to
guest OSes, right?

> > Also if so, would the following rather simpler patch do the same trick,
> > if accompanied by CONFIG_RCU_FANOUT_LEAF=1?
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index 6a319e2926589..04dbee983b37d 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -198,9 +198,9 @@ config RCU_FANOUT
> >  
> >  config RCU_FANOUT_LEAF
> >  	int "Tree-based hierarchical RCU leaf-level fanout value"
> > -	range 2 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
> > -	range 2 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
> > -	range 2 3 if RCU_STRICT_GRACE_PERIOD
> > +	range 1 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
> > +	range 1 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
> > +	range 1 3 if RCU_STRICT_GRACE_PERIOD
> >  	depends on TREE_RCU && RCU_EXPERT>  	default 16 if !RCU_STRICT_GRACE_PERIOD
> >  	default 2 if RCU_STRICT_GRACE_PERIOD
> > 
> > ------------------------------------------------------------------------
> > 
> > This passes a quick 20-minute rcutorture smoke test.  Does it provide
> > similar performance benefits?
> 
> I tried this out, and it also brings down the contention and solves the problem
> I saw (in testing so far).
> 
> Would this work also if the test had grace periods init/cleanup racing with
> preempted RCU read-side critical sections? I'm doing longer tests now to see how
> this performs under GP-stress, versus my solution. I am also seeing that with
> just the node lists, not per-cpu list, I see a dramatic throughput drop after
> some amount of time, but I can't explain it. And I do not see this with the
> per-cpu list solution (I'm currently testing if I see the same throughput drop
> with the fan-out solution you proposed).

Might the throughput drop be due to increased load on the host?
Another possibility is that tasks/vCPUs got shuffled so as to increase
the probability of preemption.

Also, doesn't your patch also cause the grace-period kthread to acquire
that per-CPU lock, thus also possibly resulting in contention, vCPU
preemption, and so on?

> I'm also wondering whether relying on the user to set FANOUT_LEAF to 1 is
> reasonable, considering this is not a default. Are you suggesting defaulting to
> this for small systems? If not, then I guess the optimization will not be
> enabled by default. Eventually, with this patch set, if we are moving forward
> with this approach, I will remove the config option for per-CPU block list
> altogether so that it is enabled by default. That's kind of my plan if we agreed
> on this, but it is just an RFC stage :).

Right now, we are experimenting, so the usability issue is less pressing.
Once we find out what is really going on for real-world systems, we
can make adjustments if and as appropriate, said adjustments including
usability.

							Thanx, Paul
