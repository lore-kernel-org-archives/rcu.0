Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD702054EE;
	Tue,  4 Feb 2025 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738700431; cv=none; b=F05m7FViIrytX6fdIOyu1tD9d+4lbjWj/9Wd8GY/+bB4GXJof4jKLQ7qmYNwFv4VDiElcr9mCSYUnIxzK/Hc5Of3rMaQkESGML1xdXlkgOYKYo/+ZPAF8ld0ecMPct6h+RJmukz+tTdGDIlmJlGgKYpt2VFc6gmuJvihW1gvnyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738700431; c=relaxed/simple;
	bh=SXzagQPOwAXIvgDxbOPKOIk2428Aq9F66TKqXwMDPBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4U4rqK/2xeJWZAAKxjENITJqcjriOTeQvuzRAnrC8b9OVuu2kF2UtwdKxLFOqlvPcG8tWYSefIXYeknzIl5uJAtXQAL+1YgSZ4l/PWOG5G+O8J+E5sG0k5+5JK9QEuOWHU6lOHdDlahEKXR5DF0GdlQ3ThRkjKAy0TymPM+h40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVWXrUHj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVWXrUHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E302AC4CEDF;
	Tue,  4 Feb 2025 20:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738700431;
	bh=SXzagQPOwAXIvgDxbOPKOIk2428Aq9F66TKqXwMDPBM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eVWXrUHj4hZkVG2qFVMAF1q4fabzSRnFSl80ZKOA1AXV+OzUBMkYx3JsedAuupriE
	 GaPn9ipdIQBQ3GLqvKs5I+FlIz+Njjw13/KAMXZGzC1dxDaQwykI5mwAEwmjXySpdz
	 AZ6kiMLdsN3nMpn5pfYju4Su2wKF8QwNvqPbB/tNj5z24SfZ7HloZhFyAixR3HjmH2
	 btJeevmOjRwYbVYghXk6eZ3RGlae728AxhNxQruKJ1GT9e+dWeEAu0gnRkNqQuLnNB
	 1p5NQc1gh2FgzrDTpLtkOvexSf/DeMumGzNVmgGnm/PIeE5bMZVoiQv72afckT94/V
	 gHgz3ma9VFHwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7BD23CE028A; Tue,  4 Feb 2025 12:20:30 -0800 (PST)
Date: Tue, 4 Feb 2025 12:20:30 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
Message-ID: <9ed4e0fd-75c4-400a-9a0b-74c68286bad3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
 <20250130185320.1651910-4-paulmck@kernel.org>
 <20250204102611.OVuHn9rS@linutronix.de>
 <ff2ed5ba-52f4-4e82-ac0c-6e6a7013d86e@paulmck-laptop>
 <20250204163409.ueObHFje@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204163409.ueObHFje@linutronix.de>

On Tue, Feb 04, 2025 at 05:34:09PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-04 03:51:48 [-0800], Paul E. McKenney wrote:
> > On Tue, Feb 04, 2025 at 11:26:11AM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2025-01-30 10:53:19 [-0800], Paul E. McKenney wrote:
> > > > The timer and hrtimer softirq processing has moved to dedicated threads
> > > > for kernels built with CONFIG_IRQ_FORCED_THREADING=y.  This results in
> > > > timers not expiring until later in early boot, which in turn causes the
> > > > RCU Tasks self-tests to hang in kernels built with CONFIG_PROVE_RCU=y,
> > > > which further causes the entire kernel to hang.  One fix would be to
> > > > make timers work during this time, but there are no known users of RCU
> > > > Tasks grace periods during that time, so no justification for the added
> > > > complexity.  Not yet, anyway.
> > > > 
> > > > This commit therefore moves the call to rcu_init_tasks_generic() from
> > > > kernel_init_freeable() to a core_initcall().  This works because the
> > > > timer and hrtimer kthreads are created at early_initcall() time.
> > > 
> > > Fixes: 49a17639508c3 ("softirq: Use a dedicated thread for timer wakeups on PREEMPT_RT.")
> > > ?
> > 
> > Quite possibly...  I freely confess that I was more focused on the fix
> > than on the bug's origin.  Would you be willing to try this commit and
> > its predecessor?
> 
> Yes. Just verified.
> Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Boqun, could you please apply Sebastian's tags, including the Fixes
tag above?

> > > I played with it and I can reproduce the issue with !RT + threadirqs but
> > > not with RT (which implies threadirqs).
> > > Is there anything in RT that avoids the problem?
> > 
> > Not that I know of, but then again I did not try it.  To your point,
> 
> The change looks fine.
> 
> > I do need to make a -rt rcutorture scenario.  TREE03 has been intended to
> > approximate this, and it uses the following Kconfig options:
> > 
> > ------------------------------------------------------------------------
> > 
> > CONFIG_SMP=y
> > CONFIG_NR_CPUS=16
> > CONFIG_PREEMPT_NONE=n
> > CONFIG_PREEMPT_VOLUNTARY=n
> > CONFIG_PREEMPT=y
> > #CHECK#CONFIG_PREEMPT_RCU=y
> > CONFIG_HZ_PERIODIC=y
> > CONFIG_NO_HZ_IDLE=n
> > CONFIG_NO_HZ_FULL=n
> > CONFIG_RCU_TRACE=y
> > CONFIG_HOTPLUG_CPU=y
> > CONFIG_RCU_FANOUT=2
> > CONFIG_RCU_FANOUT_LEAF=2
> > CONFIG_RCU_NOCB_CPU=n
> > CONFIG_DEBUG_LOCK_ALLOC=n
> > CONFIG_RCU_BOOST=y
> > CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> > CONFIG_RCU_EXPERT=y
> 
> You could enable CONFIG_PREEMPT_RT ;)
> CONFIG_PREEMPT_LAZY is probably also set a lot.
> 
> That should be it.
> 
> > ------------------------------------------------------------------------
> > 
> > And the following kernel-boot parameters:
> > 
> > ------------------------------------------------------------------------
> > 
> > rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30
> > rcutree.gp_preinit_delay=12
> > rcutree.gp_init_delay=3
> > rcutree.gp_cleanup_delay=3
> > rcutree.kthread_prio=2
> > threadirqs
> > rcutree.use_softirq=0
> > rcutorture.preempt_duration=10
> > 
> > ------------------------------------------------------------------------
> > 
> > Some of these are for RCU's benefit, but what should I change to more
> > closely approximate a typical real-time deployment?
> 
> See above.

Which got me this diff:

------------------------------------------------------------------------

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE03 b/tools/testing/selftests/rcutorture/configs/rcu/TREE03
index 2dc31b16e506..6158f5002497 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE03
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE03
@@ -2,7 +2,9 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=16
 CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
-CONFIG_PREEMPT=y
+CONFIG_PREEMPT=n
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_RT=y
 #CHECK#CONFIG_PREEMPT_RCU=y
 CONFIG_HZ_PERIODIC=y
 CONFIG_NO_HZ_IDLE=n
@@ -15,4 +17,5 @@ CONFIG_RCU_NOCB_CPU=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_RCU_BOOST=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_EXPERT=y
 CONFIG_RCU_EXPERT=y

------------------------------------------------------------------------

But a 10-minute run got me the splat shown below, and in addition a
shutdown-time hang.

This is caused by RCU falling behind a callback-flooding kthread that
invokes call_rcu() in a semi-tight loop.  Setting rcutree.kthread_prio=40
avoids the splat, but still gets the shutdown-time hang.  Retrying with
the default rcutree.kthread_prio=2 failed to reproduce the splat, but
it did reproduce the shutdown-time hang.

OK, maybe printk buffers are not being flushed?  A 100-millisecond sleep
at the end of of rcu_torture_cleanup() got all of rcutorture's output
flushed, but lost the subsequent shutdown-time console traffic.  The
pr_flush(HZ/10,1) seems more sensible, but this is private to printk().

I would like to log the shutdown-time console traffic because RCU can
sometimes break things on that path.

Thoughts?

							Thanx, Paul

PS:  I will do longer runs in case that splat was not a one-off.
     My concern is that I might need to adjust something more in order
     to get a reliable callback-flooding test.

------------------------------------------------------------------------

[  133.107605] ------------[ cut here ]------------
[  133.107611] rcutorture_oom_notify invoked upon OOM during forward-progress testing.
[  133.107636] WARNING: CPU: 0 PID: 236 at kernel/rcu/rcutorture.c:3117 rcutorture_oom_notify+0x48/0x2e0
[  133.107651] Modules linked in:
[  133.107662] CPU: 0 UID: 0 PID: 236 Comm: rcu_torture_fwd Not tainted 6.13.0-rc2-00108-g56d12f072c66-dirty #1747
[  133.107667] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[  133.107669] RIP: 0010:rcutorture_oom_notify+0x48/0x2e0
[  133.107673] Code: e8 3d ca c3 00 48 8b 2d 5e 8e 17 02 48 85 ed 0f 84 82 02 00 00 90 48 c7 c6 a0 fc 20 a7 48 c7 c7 40 82 68 a7 e8 f9 38 f6 ff 90 <0f> 0b 90 90 8b 35 36 10 82 01 45 31 e4 85 f6 7e 3c 49 63 dc 41 83
[  133.107675] RSP: 0018:ffffa3b10081fab0 EFLAGS: 00010286
[  133.107679] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
[  133.107681] RDX: ffff8bf11f21c948 RSI: 0000000000000001 RDI: ffff8bf11f21c940
[  133.107682] RBP: ffff8bf101ff8000 R08: ffffffffa7b42608 R09: 00000000ffffdfff
[  133.107683] R10: ffffffffa7a62620 R11: ffffffffa7b12620 R12: 0000000000000000
[  133.107685] R13: ffffa3b10081fb60 R14: 00000000ffffffff R15: 0000000000000000
[  133.107688] FS:  0000000000000000(0000) GS:ffff8bf11f200000(0000) knlGS:0000000000000000
[  133.107690] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  133.107691] CR2: ffff8bf10fe01000 CR3: 0000000001f88000 CR4: 00000000000006f0
[  133.107693] Call Trace:
[  133.107709]  <TASK>
[  133.107713]  ? __warn+0x83/0x130
[  133.107716]  ? rcutorture_oom_notify+0x48/0x2e0
[  133.107720]  ? report_bug+0x18e/0x1a0
[  133.107723]  ? handle_bug+0x54/0x90
[  133.107727]  ? exc_invalid_op+0x18/0x70
[  133.107729]  ? asm_exc_invalid_op+0x1a/0x20
[  133.107733]  ? rcutorture_oom_notify+0x48/0x2e0
[  133.107736]  notifier_call_chain+0x59/0xc0
[  133.107744]  blocking_notifier_call_chain+0x3c/0x60
[  133.107746]  out_of_memory+0x1f3/0x710
[  133.107754]  __alloc_pages_noprof+0xf27/0x10b0
[  133.107764]  ? timerqueue_del+0x2e/0x50
[  133.107767]  alloc_pages_mpol_noprof+0x43/0xf0
[  133.107774]  new_slab+0x37d/0x440
[  133.107796]  ___slab_alloc+0x480/0x9a0
[  133.107801]  ? rcu_torture_fwd_prog+0x344/0x9e0
[  133.107803]  ? preempt_schedule_thunk+0x1a/0x30
[  133.107806]  ? rcu_torture_fwd_prog+0x344/0x9e0
[  133.107808]  __kmalloc_cache_noprof+0x74/0x1f0
[  133.107811]  rcu_torture_fwd_prog+0x344/0x9e0
[  133.107814]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
[  133.107816]  ? kthread+0xd1/0x100
[  133.107818]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
[  133.107819]  kthread+0xd1/0x100
[  133.107824]  ? __pfx_kthread+0x10/0x10
[  133.107826]  ret_from_fork+0x2f/0x50
[  133.107833]  ? __pfx_kthread+0x10/0x10
[  133.107835]  ret_from_fork_asm+0x1a/0x30
[  133.107842]  </TASK>
[  133.107843] ---[ end trace 0000000000000000 ]---
