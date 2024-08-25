Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7942AAF;
	Sun, 25 Aug 2024 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724599575; cv=none; b=upm00ESFvl4FAuV7GCWctxfFsVl7ow5jjSW6TfZ2hbJWKolEb/mof9p7iO75z2Xk40rYE3GbMamhbwzfBV+Qp13SUFOXOs2I9pOUpcbA0WPZe1uknVlkVE9eAnYItW+4egck1HC18QLJ+9zBeB5iY2vOzBI/bRDfCNcBV2oT0Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724599575; c=relaxed/simple;
	bh=bpdqsN5Snv5qMzYPRU9n2lN5PpYWqYE5YI8Y07rdr/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJEhWaFBYLEfZVEGKjtD4pZNe/Xk8cHtdtQwFaDXTPlSSTNSdOJ+8nmBrXyvD6kV4tFWGEb1+Re53goLiMF9Pay9UZ6Gk/d5ybaBkH00nul6OYkVzYLbvHMIIJEPhxQSXs784ToShVfMsYVPkTL6ZeIctkzwv1aAp5sT10TvGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZKyX7V9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZKyX7V9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B1EC32782;
	Sun, 25 Aug 2024 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724599575;
	bh=bpdqsN5Snv5qMzYPRU9n2lN5PpYWqYE5YI8Y07rdr/g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nZKyX7V9paYE0+FlIHLkMpaNdSxOVhVcmBv19/+4iTFPaPQmxubWTTUBf2yKljz4t
	 mJfccIAPwbdiY8nxXbxG8Wz8AnIProUSfRtrEbgT5fJ8YHfFjf5UY/teRLFlaOUKy3
	 u5y2AniMrXuDeRBnlf0/aSc/F38l8fRPsYq/nzxEQFn65bOtosd5OebXpmjBwkrDBD
	 U2L/2TcxNs1bW0a+BMX6szvTZdyUcg9BQPy6Jr9ON5aEQDrId4aytyx4WFpc5BQNK8
	 Rg/IqL2leNAn7gOEx25r80Q2M71VKUibU2SoDmOmdLvp4/sZSiMZkpONLlNaxG+Rv4
	 amdA8tEVT6tpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C1319CE0BC7; Sun, 25 Aug 2024 08:26:14 -0700 (PDT)
Date: Sun, 25 Aug 2024 08:26:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Xingyu Li <xli399@ucr.edu>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	"qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: WARNING in rcu_core
Message-ID: <92758b9c-6934-4796-9822-28c78bee2ccc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CALAgD-7hbfOzovnPqVqo6bqb1nHZ2WciUOTsz0Dtwsgr+yx04w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-7hbfOzovnPqVqo6bqb1nHZ2WciUOTsz0Dtwsgr+yx04w@mail.gmail.com>

On Sat, Aug 24, 2024 at 10:30:23PM -0700, Xingyu Li wrote:
> Hi,
> 
> We found a bug in Linux 6.10. It is probably a use-after-free bug.
> Its error message "ODEBUG: active_state not available (active state
> 0)" indicates that the object in question (rcu_head) is in an
> unexpected state. The expected states are typically something like
> STATE_RCU_HEAD_QUEUED or STATE_RCU_HEAD_READY, but the object is
> instead in state 0, which generally means it has either not been
> initialized correctly or has been freed and is being accessed again.
> 
> The bug report and syzkaller reproducer are as follows.

One way to track this is to trace call_rcu(), for example, using the
rcu_callback() trace event.  The resulting trace messages would likely
need to be fished out of a kernel core dump.

Someone more familiar with tracing and core dumps might be able to give
more specific advice.

							Thanx, Paul

> Bug report:
> 
> ODEBUG: active_state not available (active state 0) object:
> ffffea0000a3f710 object type: rcu_head hint: 0x0
> WARNING: CPU: 0 PID: 0 at lib/debugobjects.c:517 debug_print_object
> lib/debugobjects.c:514 [inline]
> WARNING: CPU: 0 PID: 0 at lib/debugobjects.c:517
> debug_object_active_state+0x2b0/0x360 lib/debugobjects.c:954
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0 #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:debug_print_object lib/debugobjects.c:514 [inline]
> RIP: 0010:debug_object_active_state+0x2b0/0x360 lib/debugobjects.c:954
> Code: d7 95 fd 4d 8b 0c 24 48 c7 c7 a0 61 a9 8b 48 c7 c6 60 5e a9 8b
> 48 89 ea 8b 4c 24 04 49 89 d8 41 57 e8 24 1b f7 fc 48 83 c4 08 <0f> 0b
> ff 05 88 0c c6 0a 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d
> RSP: 0018:ffffc90000007ba0 EFLAGS: 00010296
> RAX: de43a67fd8b9f500 RBX: ffffea0000a3f710 RCX: ffffffff8d893bc0
> RDX: 0000000000000101 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffffff8ba96360 R08: ffffffff8155a25a R09: 1ffff1100c74519a
> R10: dffffc0000000000 R11: ffffed100c74519b R12: ffffffff8b4de5c0
> R13: 0000000000000005 R14: dffffc0000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055555e016868 CR3: 000000000d932000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  debug_rcu_head_unqueue kernel/rcu/rcu.h:236 [inline]
>  rcu_do_batch kernel/rcu/tree.c:2527 [inline]
>  rcu_core+0xa5c/0x17f0 kernel/rcu/tree.c:2809
>  handle_softirqs+0x272/0x750 kernel/softirq.c:554
>  __do_softirq kernel/softirq.c:588 [inline]
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu+0xf0/0x1b0 kernel/softirq.c:637
>  irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
>  sysvec_apic_timer_interrupt+0xa0/0xc0 arch/x86/kernel/apic/apic.c:1043
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
> RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
> RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:743
> Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29
> c2 e9 72 ff ff ff cc cc cc cc 66 90 0f 00 2d c7 a4 4e 00 fb f4 <fa> c3
> 0f 1f 00 e9 eb ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 65
> RSP: 0018:ffffffff8d807d68 EFLAGS: 000002c2
> RAX: de43a67fd8b9f500 RBX: ffffffff816928eb RCX: 0000000000022a19
> RDX: 0000000000000001 RSI: ffffffff8b4c89c0 RDI: ffffffff8ba956e0
> RBP: ffffffff8d807eb8 R08: ffff888063a37d0b R09: 1ffff1100c746fa1
> R10: dffffc0000000000 R11: ffffed100c746fa2 R12: 1ffffffff1b00fc6
> R13: 1ffffffff1b12778 R14: 0000000000000000 R15: dffffc0000000000
>  default_idle_call+0x6e/0xa0 kernel/sched/idle.c:117
>  cpuidle_idle_call kernel/sched/idle.c:191 [inline]
>  do_idle+0x22b/0x5c0 kernel/sched/idle.c:332
>  cpu_startup_entry+0x3d/0x60 kernel/sched/idle.c:430
>  rest_init+0x2db/0x300 init/main.c:747
>  start_kernel+0x486/0x500 init/main.c:1103
>  x86_64_start_reservations+0x26/0x30 arch/x86/kernel/head64.c:507
>  x86_64_start_kernel+0x5c/0x60 arch/x86/kernel/head64.c:488
>  common_startup_64+0x13e/0x147
>  </TASK>
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>    0: 76 e7                 jbe    0xffffffe9
>    2: 48 89 07             mov    %rax,(%rdi)
>    5: 49 c7 c0 08 00 00 00 mov    $0x8,%r8
>    c: 4d 29 c8             sub    %r9,%r8
>    f: 4c 01 c7             add    %r8,%rdi
>   12: 4c 29 c2             sub    %r8,%rdx
>   15: e9 72 ff ff ff       jmp    0xffffff8c
>   1a: cc                   int3
>   1b: cc                   int3
>   1c: cc                   int3
>   1d: cc                   int3
>   1e: 66 90                 xchg   %ax,%ax
>   20: 0f 00 2d c7 a4 4e 00 verw   0x4ea4c7(%rip)        # 0x4ea4ee
>   27: fb                   sti
>   28: f4                   hlt
> * 29: fa                   cli <-- trapping instruction
>   2a: c3                   ret
>   2b: 0f 1f 00             nopl   (%rax)
>   2e: e9 eb ff ff ff       jmp    0x1e
>   33: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
>   3a: 00 00 00
>   3d: 90                   nop
>   3e: 65                   gs
> 
> 
> Syzkaller reproducer:
> # {Threaded:true Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
> Sandbox:none SandboxArg:0 Leak:false NetInjection:true NetDevices:true
> NetReset:true Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:false
> DevlinkPCI:false NicVF:false USB:true VhciInjection:false Wifi:false
> IEEE802154:true Sysctl:false Swap:false UseTmpDir:true HandleSegv:true
> Trace:false LegacyOptions:{Collide:false Fault:false FaultCall:0
> FaultNth:0}}
> openat$ptmx(0xffffffffffffff9c, &(0x7f0000000340), 0x183401, 0x0)
> ioctl$TCSETSF(0xffffffffffffffff, 0x5404, 0x0)
> syz_open_dev$evdev(&(0x7f0000000000), 0x8000207, 0x20c40)
> ioctl$TCSETSF2(0xffffffffffffffff, 0x402c542d,
> &(0x7f0000000080)={0xffffffff, 0x6, 0x200009, 0x5, 0x1,
> "4e0040029e35bca140d58427392b336889f0cc", 0x2, 0x101})
> r0 = syz_open_dev$sg(&(0x7f0000000200), 0x140000000000, 0x8000)
> ioctl$syz_spec_1724254976_2866(r0, 0x1, &(0x7f0000000080)={0x0, 0x2,
> [0x85, 0x8, 0x15, 0xd]})
> ioctl$syz_spec_18446744073163555329_24(0xffffffffffffffff, 0xc0104320, 0x0)
> ioctl$syz_spec_18446744072138818634_137(0xffffffffffffffff, 0x402c542d, 0x0)
> 
> -- 
> Yours sincerely,
> Xingyu
> 
