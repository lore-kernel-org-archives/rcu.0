Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AD6286405
	for <rcu@vger.kernel.org>; Tue,  6 May 2025 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746554621; cv=none; b=cqW3LGveli0pJnIl8iWcpb+DJ/BSnlPJ2vt7KHsUVXUhfQOYrB7pGyEQ+TyBoIm2BRUfAY03MH+PDXCAcR7hSOLz3ImOmHstRHkBWlpuyXQNqL+Wto0+YOD9PpTlgcW+tftZY8jkLwrGqW/H4/KjZC2vs1k5m0WdEOJ7Of6mlFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746554621; c=relaxed/simple;
	bh=d+GvAcwhXzKs5ktEdsRqhswXJmUeVqg3i5KuAsIC3Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoJAZQZr55475RENBg6M45wLriB1qfHb7u3gMDXQd3YvOr/dlKbcvgeLH+tPC6tFJWTdnTo154FNNkQp7NJZRRr0060JimsfEYwP6IwKW+wI2qTUrVkTMk+0gJ32AyrEvvzTRDnBCJAu1MkKujsy4UFO3r2GapJFhbkON8ntkrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWoq8eug; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWoq8eug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE9BC4CEEB;
	Tue,  6 May 2025 18:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746554621;
	bh=d+GvAcwhXzKs5ktEdsRqhswXJmUeVqg3i5KuAsIC3Yc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eWoq8eug8+78IRO5s42D+oLAKJG2KpMhRldPDGARp2sRpuFQ2lZcq7gp03sg3imI0
	 xhQ8DK9Jz78FD5KvH1i3bFubBEqZbT3eQeqxyFnPHZ1nIKxh6+8UpA07B5dGvzPQKu
	 lZitSOfOPcA+FBnSh235tSAN+FO/n4k414y/YN406LXX08+KDJ5rt+HCM9IVN2Oh4l
	 a8XyIj6gZrBw5uMs2cVDLqdhwmPaQQYjahpr0xdiYzT3ZEv2rFz6hi6A9xzrXOfacz
	 y4w/P6Z3Enah2URJHJi+of2FDqT5B8SmgJ+OmjpcIB2CxRoK6Q996tA+wntsDKkl91
	 FVqDbIskqzzTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D975CCE1FCA; Tue,  6 May 2025 11:03:40 -0700 (PDT)
Date: Tue, 6 May 2025 11:03:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org
Subject: Re: [BUG] RCU CPU stall warnings on TREE01 on arm64
Message-ID: <7e2361ae-becf-47f9-b3dc-a86a53497416@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0250d0c7-381d-46df-bddb-729130559ba1@paulmck-laptop>
 <ecb7a3d7-9ddb-49b2-8072-97b933e3e181@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb7a3d7-9ddb-49b2-8072-97b933e3e181@nvidia.com>

On Tue, May 06, 2025 at 10:09:54AM -0400, Joel Fernandes wrote:
> 
> 
> On 5/5/2025 3:03 PM, Paul E. McKenney wrote:
> > Hello!
> > 
> > Following up on off-list discussions and requests for more information.
> > 
> > These reproduce reasonably easily, and here is an example:
> > 
> > ------------------------------------------------------------------------
> > [  426.022056] rcu: NOCB: Cannot CB-offload online CPU 25
> > [  460.867350] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > [  460.867980] rcu:     0-...!: (1 GPs behind) idle=8fe4/1/0x4000000000000000 softirq=2124/2125 fqs=0
> > [  460.868726] rcu:     1-...!: (1 GPs behind) idle=e0ac/1/0x4000000000000000 softirq=3547/3547 fqs=0
> > [  460.869468] rcu:     5-...!: (1 GPs behind) idle=5c34/1/0x4000000000000000 softirq=2084/2084 fqs=0
> > [  460.870233] rcu:     8-...!: (1 GPs behind) idle=9fdc/1/0x4000000000000000 softirq=4301/4301 fqs=0
> > [  460.871007] rcu:     9-...!: (0 ticks this GP) idle=4a2c/1/0x4000000000000000 softirq=3873/3873 fqs=0
> > [  460.871772] rcu:     10-...!: (1 GPs behind) idle=4994/1/0x4000000000000000 softirq=4760/4760 fqs=0
> > [  460.872511] rcu:     12-...!: (1 GPs behind) idle=0bbc/1/0x4000000000000000 softirq=3545/3545 fqs=0
> > [  460.873300] rcu:     13-...!: (1 GPs behind) idle=a59c/1/0x4000000000000000 softirq=2097/2098 fqs=0
> > [  460.874084] rcu:     14-...!: (1 GPs behind) idle=22cc/1/0x4000000000000000 softirq=4424/4424 fqs=0
> > [  460.874864] rcu:     15-...!: (1 GPs behind) idle=0e5c/1/0x4000000000000000 softirq=5984/5984 fqs=0
> > [  460.875625] rcu:     16-...!: (1 GPs behind) idle=d5bc/1/0x4000000000000000 softirq=6313/6313 fqs=0
> > [  460.876374] rcu:     17-...!: (1 GPs behind) idle=848c/1/0x4000000000000000 softirq=4160/4160 fqs=0
> > [  460.877182] rcu:     18-...!: (1 GPs behind) idle=a1c4/1/0x4000000000000000 softirq=3217/3217 fqs=0
> > [  460.877930] rcu:     19-...!: (0 ticks this GP) idle=cbe4/1/0x4000000000000000 softirq=7886/7886 fqs=0
> > [  460.878772] rcu:     20-...!: (1 GPs behind) idle=3acc/1/0x4000000000000000 softirq=4315/4317 fqs=0
> > [  460.879514] rcu:     21-...!: (1 GPs behind) idle=eb7c/1/0x4000000000000000 softirq=4221/4221 fqs=0
> > [  460.880225] rcu:     22-...!: (1 GPs behind) idle=477c/1/0x4000000000000000 softirq=5049/5049 fqs=0
> > [  460.880990] rcu:     23-...!: (1 GPs behind) idle=8404/1/0x4000000000000000 softirq=5635/5636 fqs=0
> > [  460.881739] rcu:     24-...!: (0 ticks this GP) idle=11e4/1/0x4000000000000000 softirq=2031/2031 fqs=0
> > [  460.882497] rcu:     25-...!: (0 ticks this GP) idle=3434/1/0x4000000000000000 softirq=3495/3495 fqs=0
> > [  460.883296] rcu:     26-...!: (1 GPs behind) idle=f864/1/0x4000000000000000 softirq=3645/3645 fqs=0
> > [  460.884054] rcu:     27-...!: (0 ticks this GP) idle=3e74/1/0x4000000000000000 softirq=4168/4168 fqs=0
> > [  460.884805] rcu:     28-...!: (1 GPs behind) idle=71a4/1/0x4000000000000000 softirq=3596/3596 fqs=0
> > [  460.885570] rcu:     29-...!: (1 GPs behind) idle=9aa4/1/0x4000000000000000 softirq=3111/3112 fqs=0
> > [  460.886276] rcu:     30-...!: (1 GPs behind) idle=10dc/1/0x4000000000000000 softirq=3030/3030 fqs=0
> > [  460.887030] rcu:     31-...!: (0 ticks this GP) idle=0fb4/1/0x4000000000000000 softirq=3540/3540 fqs=0
> > [  460.887777] rcu:     32-...!: (1 GPs behind) idle=fad4/1/0x4000000000000000 softirq=2645/2645 fqs=0
> > [  460.888548] rcu:     33-...!: (0 ticks this GP) idle=37ac/1/0x4000000000000000 softirq=2201/2201 fqs=0
> > [  460.889336] rcu:     34-...!: (1 GPs behind) idle=85ac/1/0x4000000000000000 softirq=2336/2336 fqs=0
> > [  460.890081] rcu:     35-...!: (1 GPs behind) idle=756c/1/0x4000000000000000 softirq=1534/1536 fqs=0
> > [  460.890820] rcu:     36-...!: (0 ticks this GP) idle=b2ec/1/0x4000000000000000 softirq=4286/4286 fqs=0
> > [  460.891572] rcu:     37-...!: (1 GPs behind) idle=de1c/1/0x4000000000000000 softirq=2725/2725 fqs=0
> > [  460.892323] rcu:     38-...!: (1 GPs behind) idle=c62c/1/0x4000000000000000 softirq=2341/2342 fqs=0
> > [  460.893096] rcu:     39-...!: (1 GPs behind) idle=be2c/1/0x4000000000000000 softirq=2650/2651 fqs=0
> > [  460.893830] rcu:     40-...!: (1 GPs behind) idle=7ecc/1/0x4000000000000000 softirq=2119/2121 fqs=0
> > [  460.894621] rcu:     41-...!: (0 ticks this GP) idle=19dc/1/0x4000000000000000 softirq=3539/3539 fqs=0
> > [  460.895384] rcu:     42-...!: (0 ticks this GP) idle=a74c/1/0x4000000000000000 softirq=2259/2259 fqs=0
> > [  460.896148] rcu:     Tasks blocked on level-1 rcu_node (CPUs 30-42): P91/1:b..l
> > [  460.896778] rcu:     (detected by 11, t=7962 jiffies, g=15565, q=48 ncpus=39)
> > [  460.897395] Sending NMI from CPU 11 to CPUs 0:
> > [  461.047304] rcu-torture: rtc: 00000000fb6bc815 ver: 2137 tfle: 0 rta: 2137 rtaf: 0 rtf: 2128 rtmbe: 0 rtmbkf: 0/2042 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 148999 onoff: 32/32:36/37 7,348:36,3639 4096:26899 (HZ=250) barrier: 979/980:0 read-exits: 416 nocb-toggles: 1013:969 gpwraps: 0
> > [  461.047343] rcu-torture: Reader Pipe:  1919541609 11501 0 0 0 0 0 0 0 0 0
> > [  461.047383] rcu-torture: Reader Batch:  1919533823 19422 0 0 0 0 0 0 0 0 0
> > [  461.047401] rcu-torture: Free-Block Circulation:  2136 2136 2135 2134 2133 2132 2131 2130 2129 2128 0
> > [  462.777371] NMI backtrace for cpu 0
> > [  462.777547] CPU: 0 UID: 0 PID: 20 Comm: migration/0 Not tainted 6.15.0-rc1-00066-g612f2bb48fa2 #22 PREEMPT
> > [  462.777551] Hardware name: linux,dummy-virt (DT)
> > [  462.777552] Stopper: multi_cpu_stop+0x0/0x15c <- __stop_cpus.constprop.0+0x78/0xc4
> > [  462.777564] pstate: 43400005 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> > [  462.777566] pc : handle_softirqs+0xa0/0x248
> > [  462.777836] lr : handle_softirqs+0x7c/0x248
> > [  462.777838] sp : ffff800080003f50
> > [  462.777839] x29: ffff800080003f50 x28: ffff000003d9d780 x27: 0000000000000000
> > [  462.777842] x26: 0000000000000282 x25: 0000000000000000 x24: ffffafb5af9f4000
> > [  462.777843] x23: 0000000063400005 x22: ffffafb5adb9b8f0 x21: ffffafb5af9e93c8
> > [  462.778009] x20: ffffafb5b02970c0 x19: ffff000003d9d780 x18: 0000000000000001
> > [  462.778012] x17: ffff504a6d7bc000 x16: ffff800080000000 x15: ffff00001d5f4d00
> > [  462.778013] x14: 0000000000000156 x13: 0000000000000000 x12: 0000000000000000
> > [  462.778015] x11: ffff00001d1b0d80 x10: 00000000002ab980 x9 : 0000000000000000
> > [  462.778017] x8 : 000001d6146032ba x7 : ffff00000500b800 x6 : 0000000000000000
> > [  462.778019] x5 : 00000000002ab980 x4 : 0000000100009e3e x3 : ffff504a6d7bc000
> > [  462.778020] x2 : 0000006bbfae36c0 x1 : ffff504a6d7bc000 x0 : ffffafb5af9f4000
> > [  462.778232] Call trace:
> > [  462.778233]  handle_softirqs+0xa0/0x248 (P)
> > [  462.778296]  __do_softirq+0x14/0x20
> > [  462.778299]  ____do_softirq+0x10/0x1c
> > [  462.778389]  call_on_irq_stack+0x24/0x4c
> > [  462.778391]  do_softirq_own_stack+0x1c/0x2c
> > [  462.778393]  __irq_exit_rcu+0xd8/0x110
> > [  462.778395]  irq_exit_rcu+0x10/0x1c
> > [  462.778456]  el1_interrupt+0x38/0x68
> > [  462.778531]  el1h_64_irq_handler+0x18/0x24
> > [  462.778533]  el1h_64_irq+0x6c/0x70
> > [  462.778534]  multi_cpu_stop+0xf0/0x15c (P)
> > [  462.778536]  cpu_stopper_thread+0x8c/0x11c
> > [  462.778642]  smpboot_thread_fn+0x220/0x24c
> > [  462.778647]  kthread+0x134/0x208
> > [  462.778649]  ret_from_fork+0x10/0x20
> > [  463.888107] NMI backtrace for cpu 1
> > [  463.888117] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.15.0-rc1-00066-g612f2bb48fa2 #22 PREEMPT
> > [  463.888120] Hardware name: linux,dummy-virt (DT)
> > [  463.888121] pstate: 43400005 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> > [  463.888123] pc : handle_softirqs+0xa0/0x248
> > [  463.888135] lr : handle_softirqs+0x7c/0x248
> > [  463.888140] sp : ffff80008000bf50
> > [  463.888140] x29: ffff80008000bf50 x28: ffff000003d9e900 x27: 0000000000000000
> > [  463.888143] x26: 0000000000000282 x25: ffff000003d9e900 x24: ffffafb5af9f4000
> > [  463.888146] x23: 0000000063400005 x22: ffffafb5adad9114 x21: ffffafb5af9e93c8
> > [  463.888148] x20: ffffafb5b02970c0 x19: ffff000003d9e900 x18: 0000000000000000
> > [  463.888150] x17: ffff504a6d7d6000 x16: ffff800080008000 x15: ffff00001d1cad00
> > [  463.888152] x14: 0000000000000112 x13: 0000000000000000 x12: 0000000000000000
> > [  463.888158] x11: 0000000000000a95 x10: 0000000000000163 x9 : 0000000000000000
> > [  463.888160] x8 : 0000006bfc655500 x7 : 7fffffffffffffff x6 : 0000006bfc655500
> > [  463.888165] x5 : 0000006bfca25e00 x4 : 0000000100009ff5 x3 : ffff504a6d7d6000
> > [  463.888168] x2 : 0000006c01e2bea0 x1 : ffff504a6d7d6000 x0 : ffffafb5af9f4000
> > [  463.888171] Call trace:
> > [  463.888172]  handle_softirqs+0xa0/0x248 (P)
> > [  463.888175]  __do_softirq+0x14/0x20
> > [  463.888178]  ____do_softirq+0x10/0x1c
> > [  463.888183]  call_on_irq_stack+0x24/0x4c
> > [  463.888185]  do_softirq_own_stack+0x1c/0x2c
> > [  463.888187]  __irq_exit_rcu+0xd8/0x110
> > [  463.888192]  irq_exit_rcu+0x10/0x1c
> > [  463.888194]  el1_interrupt+0x38/0x68
> > [  463.888198]  el1h_64_irq_handler+0x18/0x24
> > [  463.888200]  el1h_64_irq+0x6c/0x70
> > [  463.888202]  finish_task_switch.isra.0+0x74/0x220 (P)
> > [  463.888207]  __schedule+0x2fc/0x998
> > [  463.888210]  schedule_idle+0x28/0x48
> > [  463.888212]  do_idle+0x170/0x268
> > [  463.888215]  cpu_startup_entry+0x34/0x3c
> > [  463.888217]  secondary_start_kernel+0x138/0x158
> > [  463.888224]  __secondary_switched+0xc0/0xc4
> > [  463.941174] NMI backtrace for cpu 8
> > [  463.941179] CPU: 8 UID: 0 PID: 19 Comm: rcu_exp_gp_kthr Not tainted 6.15.0-rc1-00066-g612f2bb48fa2 #22 PREEMPT
> > [  463.941220] Hardware name: linux,dummy-virt (DT)
> > [  463.941222] pstate: 23400005 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> > [  463.941223] pc : smp_call_function_single+0xe4/0x1b0
> > [  463.941292] lr : __sync_rcu_exp_select_node_cpus+0x224/0x3c8
> > [  463.941366] sp : ffff800080233cd0
> > [  463.941367] x29: ffff800080233d20 x28: 0000000000000002 x27: ffff000003d9c600
> > [  463.941370] x26: ffffafb5b032a880 x25: ffff00001d4d7ac0 x24: ffffafb5adb49e24
> > [  463.941372] x23: 0000000000001fff x22: ffffafb5af9f5ac0 x21: ffffafb5b029ea08
> > [  463.941374] x20: 0000000000000000 x19: ffff800080233ce0 x18: 0000000000000001
> > [  463.941376] x17: ffff504a6d88c000 x16: ffff800080040000 x15: 0000000000000000
> > [  463.941378] x14: 0000000000000115 x13: 0000000000000115 x12: 0000000000000000
> > [  463.941380] x11: ffffafb5af9f0408 x10: 0000000000000001 x9 : ffff000003d9c600
> > [  463.941462] x8 : 0000000000000040 x7 : ffffafb5b0322ab0 x6 : ffffafb5adb49e24
> > [  463.941464] x5 : 0000000000000000 x4 : ffff00001d281f08 x3 : 0000000000000001
> > [  463.941535] x2 : 0000000000000000 x1 : ffff00001d281f00 x0 : 000000000000001f
> > [  463.941537] Call trace:
> > [  463.941538]  smp_call_function_single+0xe4/0x1b0 (P)
> > [  463.941541]  __sync_rcu_exp_select_node_cpus+0x224/0x3c8
> > [  463.941619]  sync_rcu_exp_select_cpus+0x138/0x2a4
> > [  463.941622]  wait_rcu_exp_gp+0x18/0x30
> > [  463.941644]  kthread_worker_fn+0xcc/0x184
> > [  463.941708]  kthread+0x134/0x208
> > [  463.941709]  ret_from_fork+0x10/0x20
> 
> I wish the back trace also included which CPU the smp_call_function_single is
> waiting on. This is similar to what Boqun sees as well, where we are spinning on
> csd lock for a CPU that is wedged. In this case, the 'wedged' appears to be on
> level-1 rcu_node (CPUs 30-42) ? But we don't have those backtraces in the above
> to confirm which specific one.

The way to make that happen is via the CSD_LOCK_WAIT_DEBUG and the
CSD_LOCK_WAIT_DEBUG_DEFAULT Kconfig options.

> Al though, cpu 8 looks like it could itself be the one blocking the GP as a
> secondary effect of the smp_call IPI not coming through?

What caught my eye was this:  "Stopper: multi_cpu_stop+0x0/0x15c".

This puppy makes all the CPUs spin with interrupts disabled.  It looks
like it was running while something was blocking context switches on
at least some of the CPUs.  It is a most wonderful way to amplify any
delay on any CPUs to affect all CPUs.  ;-)

> Speaking of smp_call, may be it does make sense for EXP to not wait too long for
> csd lock thus to not make dire matters worse? After all, the GP may well
> complete eventually even without the IPI executing? Perhaps even sooner if the
> CPU doing the smp_call wait does some other useful work as well.

What does the RCU expedited grace period do instead of waiting?

I could imagine an smp_call_function_single() API that did exponential
backoff, spinning for a bit, sleeping, spinning for a bit, sleeping
for longer and so on.  Or did you have something else in mind?

> > At first glance, this looks like a stop_machine() request gone bad.
> > Please note that I am seeing this on most TREE01 runs and nowhere else.
> > So this might be a strange side effect of dynamic callback offloading,
> > but perhaps more likely due to TREE01 using more CPUs than it is allowing
> > for, that is, telling qemu "-smp 43", the kernel "maxcpus=8 nr_cpus=43",
> > but forcing the guest OS to run on only eight CPUs.  (Why???  Well,
> > back in the day, there was an RCU bug exposed by this.)
> > 
> > All that aside, this is one of the more spectacular RCU CPU stall warnings
> > I have ever seen, and that is with me leaving off the NMI stack traces
> > for most of the CPUs.  ;-)
> 
> IIRC, NMI stack tracing on ARM is unreliable due to raisins.

Ah, true, older ARM hardware lacks NMIs.

> > If there is interest, I could post a tarball of a few of the full
> > console logs.
> > 
> > Come to think of it, even if there isn't interest, here you go!  ;-)
> > 
> > https://drive.google.com/file/d/1JKmCYqK6kAwhlJZUJQeTle-o62aJXkUQ/view?usp=sharing
> 
> TREE01 in this trace seems to be a different splat I think:
> 
> [   71.612482] rcu: Offline CPU 1 blocking current GP.
> 
> Causing the stall I think. Something to do with hotplug? I wonder if without
> hotplug testing, it will trigger or not with the same CPU count settings. It may
> be worth adding the ARM folks as well.

I could try going back to the overload case and disabling CPU hotplug.
But the problem seems to be that ARM is taking the extra 35 CPUs much
more seriously than does x86, which could cause trouble given that the
rcutorture scripting is jamming all 43 of them onto eight real CPUs.
The strange thing if that they are online as far as the (de)offloading
tests are concerned, but they show no sign of ever having been brought
online.

No, I take it back, they were brought online, it is just that ARM's CPU
ID space is way different than I would expect: 0x1, 0x2, 0x3, ..., 0xe,
0xf, 0x100, 0x101, ...

With then change to TREE01, there are only ever eight of them.

Either way, the next step seems to be to remove the "CONFIG_NR_CPUS=8"
to see what happens.

Plus for TREE07, arm64 does not enable CONFIG_PREEMPT_LAZY, resulting
in rcutorture complaining about a .config error.  Not sure whether it
would be easier to enable CONFIG_PREEMPT_LAZY or to make rcutorture be
able to go either way.  ;-)

							Thanx, Paul
