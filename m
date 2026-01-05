Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA23336ECF;
	Mon,  5 Jan 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631563; cv=none; b=uv4sSfnfiwMVjGn69ztf4UqJEHe7vtDIiUhR3HQgt8TiaOwI9ieJOklwvbNoiecVRC/z5sXO2zEpsNRNArPpfkBTkx1NZLXEpnLVNZNYBOJpSuvYpHyiZh8IVGWmpiCpIChkRSVCVEc3CIViXwmFcf5HZyJKUiGnsxmyHpBT7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631563; c=relaxed/simple;
	bh=hzhsizzjmWzYkrLXPFZnfU1g9eBSgSOeYGmZucLpAMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tED6H3L++twc7bGRfi5ZQRh1yyaK1zvQJZtaTbTQSwC8sHaN93EN7OR3bS7/Q//fg9KlVd+IRl4BdWTxBtdPKZ4gvT467mijsIiT6rFHb6N9PYcnJh81jO7yx/KxajDhYin5tmKIJE/76okChX2XbRJdTqFpb0TS3rEXfIvOK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieDYuLuc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieDYuLuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5DFC116D0;
	Mon,  5 Jan 2026 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767631562;
	bh=hzhsizzjmWzYkrLXPFZnfU1g9eBSgSOeYGmZucLpAMo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ieDYuLucekQwaPxr6i8mRuumBdB4GiLrAqwFWrqYJHbOqGyVzQ90B2zMRp+okYBF2
	 k68tRl7uyf9VdJyxc3DHRXQP8ltFsYVNeumefUs+969wzSmQGAgtk+pI+oAaEpzL/z
	 CS7GJeK6miNbkG+PCuEwjg8BvUkh6hlaz7Q31xjikJBJpjwgaLp7JjE0mul+nrgTWq
	 mZQZPGUtQNVzae0B0xpnDhakZhyR/RMgTl/ou1UK+RLg1zC8VlLJSN1gDU8ZCDyE5a
	 FrfGA9gZZo8+bCX1rQ+i/1TnOuejGWFGe5zRSHA3AwgORGfrv0bFTGuqaQ0wIC//du
	 jh6DUFY6VefQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 217B3CE0BB3; Mon,  5 Jan 2026 08:46:02 -0800 (PST)
Date: Mon, 5 Jan 2026 08:46:02 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Uladzislau Rezki <urezki@gmail.com>,
	joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 00/14] rcu: Reduce rnp->lock contention with per-CPU
 blocked task lists
Message-ID: <658b114e-b362-47e1-9dc8-9271cbcf2c4d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>

On Fri, Jan 02, 2026 at 07:23:29PM -0500, Joel Fernandes wrote:
> When a task is preempted while holding an RCU read-side lock, the kernel
> must track it on the rcu_node's blocked task list. This requires acquiring
> rnp->lock shared by all CPUs in that node's subtree.
> 
> Posting this as RFC for early feedback. There could be bugs lurking,
> especially related to expedited GPs which I have not yet taken a close
> look at. Several TODOs are added. It passed light TREE03 rcutorture
> testing.
> 
> On systems with 16 or fewer CPUs, the RCU hierarchy often has just a single
> rcu_node, making rnp->lock effectively a global lock for all blocked task
> operations. Every context switch where a task holds an RCU read-side lock
> contends on this single lock.
> 
> Enter Virtualization
> --------------------
> In virtualized environments, the problem becomes dramatically worse due to vCPU
> preemption. Research from USENIX ATC'17 ("The RCU-Reader Preemption Problem in
> VMs" by Gopinath and Paul McKenney) [1] explores the issue that RCU
> reader preemption in VMs causes multi-second latency spikes and huge increases
> in grace period duration.
> 
> When a vCPU is preempted by the hypervisor while holding rnp->lock, other
> vCPUs spin waiting for a lock holder that isn't even running. In testing
> with host RT preemptors to inject vCPU preemption, lock hold times extended
> from ~4us to over 4000us - a 1000x increase.
> 
> The Solution
> ------------
> This series introduces per-CPU lists for tracking blocked RCU readers. The
> key insight is that when no grace period is active, blocked tasks complete
> their critical sections before really requiring any rnp locking.
> 
> 1. Fast path: At context switch, Add the task only to the
>    per-CPU list - no rnp->lock needed.
> 
> 2. Promotion on demand: When a grace period starts, promote tasks from
>    per-CPU lists to the rcu_node list.
> 
> 3. Normal path: If a grace period is already waiting, tasks go directly
>    to the rcu_node list as before.
> 
> Results
> -------
> Testing with 64 reader threads under vCPU preemption from 32 host SCHED_FIFO
> preemptors), 100 runs each. Throughput measured of read lock/unlock iterations
> per second.
> 
>                         Baseline        Optimized
> Mean throughput         66,980 iter/s   97,719 iter/s   (+46%)
> Lock hold time (mean)   1,069 us        ~0 us

Excellent performance improvement!

It would be good to simplify the management of the blocked-tasks lists,
and to make it more exact, as in never unnecessarily priority-boost
a task.  But it is not like people have been complaining, at least not
to me.  And earlier attempts in that direction added more mess than
simplification.  :-(

> The optimized version maintains stable performance with essentially close to
> zero rnp->lock overhead.
> 
> rcutorture Testing
> ------------------
> TREE03 Testing with rcutorture without RCU or hotplug errors. More testing is
> in progress.
> 
> Note: I have added a CONFIG_RCU_PER_CPU_BLOCKED_LISTS to guard the feature but
> the plan is to eventually turn this on all the time.

Yes, Aravinda, Gopinath, and I did publish that paper back in the day
(with Aravinda having done almost all the work), but it was an artificial
workload.  Which is OK given that it was an academic effort.  It has also
provided some entertainment, for example, an audience member asking me
if I was aware of this work in a linguistic-kill-shot manner.  ;-)

So are we finally seeing this effect in the wild?

The main point of this patch series is to avoid lock contention due to
vCPU preemption, correct?  If so, will we need similar work on the other
locks in the Linux kernel, both within RCU and elsewhere?  I vaguely
recall your doing some work along those lines a few years back, and
maybe Thomas Gleixner's deferred-preemption work could help with this.
Or not, who knows?  Keeping the hypervisor informed of lock state is
not necessarily free.

Also if so, would the following rather simpler patch do the same trick,
if accompanied by CONFIG_RCU_FANOUT_LEAF=1?

------------------------------------------------------------------------

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 6a319e2926589..04dbee983b37d 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -198,9 +198,9 @@ config RCU_FANOUT
 
 config RCU_FANOUT_LEAF
 	int "Tree-based hierarchical RCU leaf-level fanout value"
-	range 2 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
-	range 2 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
-	range 2 3 if RCU_STRICT_GRACE_PERIOD
+	range 1 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
+	range 1 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
+	range 1 3 if RCU_STRICT_GRACE_PERIOD
 	depends on TREE_RCU && RCU_EXPERT
 	default 16 if !RCU_STRICT_GRACE_PERIOD
 	default 2 if RCU_STRICT_GRACE_PERIOD

------------------------------------------------------------------------

This passes a quick 20-minute rcutorture smoke test.  Does it provide
similar performance benefits?

							Thanx, Paul

> [1] https://www.usenix.org/conference/atc17/technical-sessions/presentation/prasad
> 
> Joel Fernandes (14):
>   rcu: Add WARN_ON_ONCE for blocked flag invariant in exit_rcu()
>   rcu: Add per-CPU blocked task lists for PREEMPT_RCU
>   rcu: Early return during unlock for tasks only on per-CPU blocked list
>   rcu: Promote blocked tasks from per-CPU to rnp lists
>   rcu: Promote blocked tasks for expedited GPs
>   rcu: Promote per-CPU blocked tasks before checking for blocked readers
>   rcu: Promote late-arriving blocked tasks before reporting QS
>   rcu: Promote blocked tasks before QS report in force_qs_rnp()
>   rcu: Promote blocked tasks before QS report in
>     rcutree_report_cpu_dead()
>   rcu: Promote blocked tasks before QS report in rcu_gp_init()
>   rcu: Add per-CPU blocked list check in exit_rcu()
>   rcu: Skip per-CPU list addition when GP already started
>   rcu: Skip rnp addition when no grace period waiting
>   rcu: Remove checking of per-cpu blocked list against the node list
> 
>  include/linux/sched.h    |   4 +
>  kernel/fork.c            |   4 +
>  kernel/rcu/Kconfig       |  12 +++
>  kernel/rcu/tree.c        |  60 +++++++++--
>  kernel/rcu/tree.h        |  11 +-
>  kernel/rcu/tree_exp.h    |   5 +
>  kernel/rcu/tree_plugin.h | 211 +++++++++++++++++++++++++++++++++++----
>  kernel/rcu/tree_stall.h  |   4 +-
>  8 files changed, 279 insertions(+), 32 deletions(-)
> 
> 
> base-commit: f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da
> --
> 2.34.1
> 
