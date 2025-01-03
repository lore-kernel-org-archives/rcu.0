Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40171D2FB;
	Fri,  3 Jan 2025 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735863383; cv=none; b=XLMFXaxX17e+2GZV2fTOB8H22shZ5SRlnIglfVoKoyT9I+hlr/vVQoNrtlKFrEZeY5NRVAcFwyz33H4vcMbk3O4HAMQvEd3gECFFrwehPyKjYnUg4rrS0QdXgxh3g49xC35bq2aG1FwQTPxCjBxCH0xee4H1/lUbjD+OBNiMy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735863383; c=relaxed/simple;
	bh=cQzUIuy6bM8be0r30x2ZNLECGddRmxEHR0bRek3Uvys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+6JSoKkoZNCl/3Y8kpzsIbOUhoF77QepPhgxWYw2lTE77FgJ+P8LegRIpTqOm8LR5ulyw9/acIpVqH78TwMhrD1ld5YObTD6EPQcBMO0Z8SvNCxL32yig3rqI+kSOVeVaTCDjU/BM9TMmEB5kRxfRDTMq/i4GWR/CiT6Q6TH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn5nR/u9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn5nR/u9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D55FC4CED0;
	Fri,  3 Jan 2025 00:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735863382;
	bh=cQzUIuy6bM8be0r30x2ZNLECGddRmxEHR0bRek3Uvys=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Rn5nR/u9wW7w7pifFBB5GHSGSSWNlS1S3bWK+lDSkAzSLTuq0ALm2O0N9PhQNXMpv
	 RaKMiH+ZiyAX/4atvnRbshl/dTn+S1kxuP89pdldeSqyeQQRsFGBB59i1ov7zF4PaZ
	 gb4J86zR9NZf6U52tXYoBcZzyPgVGCWFfS8UP3E+EKOEkFDRA9SG7NlmV3ikcCd63j
	 osKTOLmAJfp48hlzGDm5715uRLStKXBk3K6kvnQb+3hahY7/ZyBcP1/TCwGK6BHMsm
	 eW2SBolZxtvGNImcocbsb8Pi638M8cLX7x82LtlzFgCPSHZ67fRe5xPFpxONpO5pPb
	 EJlE2O/HPewZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 21F8CCE0E3F; Thu,  2 Jan 2025 16:16:22 -0800 (PST)
Date: Thu, 2 Jan 2025 16:16:22 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: watchdog: BUG: soft lockup in note_gp_changes in
 kernel/rcu/tree.c
Message-ID: <67fafa6f-57e2-48b9-a181-98e5ac37cbe5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7238787A-B616-4E0C-85DF-DB17012FA1C0@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7238787A-B616-4E0C-85DF-DB17012FA1C0@m.fudan.edu.cn>

On Thu, Jan 02, 2025 at 10:59:27AM +0800, Kun Hu wrote:
> Hello,
> 
> When using our customed fuzzer tool to fuzz the latest Linux kernel, the following crash
> was triggered.
> 
> HEAD commit: dbfac60febfa806abb2d384cb6441e77335d2799
> git tree: upstream
> Console output: https://drive.google.com/file/d/1D3EDxDxPi0t7m_Z4Uc4FuL26DnHs7yTa/view?usp=sharing
> Kernel config: https://drive.google.com/file/d/1m1mk_YusR-tyusNHFuRbzdj8KUzhkeHC/view?usp=sharing
> C reproducer: /
> Syzlang reproducer: /
> 
> We observed a crash at line 1333 in note_gp_changes, likely caused by a race condition involving rcu_gp_kthread_wake and note_gp_changes. The issue appears to involve insufficient or incorrect synchronization, as indicated by the involvement of _raw_spin_unlock_irqrestore in spinlock.c. Specifically, this may lead to invalid accesses to rcu_state.gp_kthread or related flags (e.g., gp_flags), potentially resulting in unexpected behavior in swake_up_one_online.
> 
> Could you please help check if this needs to be addressed?

This is a new one on me.

This is running in a guest OS.  Might the underlying hypervisor be
overloaded?  That could result in vCPU preemption and thus in this sort
of soft lockup.

Also, when I check out the above commit (which is v6.13-rc4), I find that
line 1333 is the close curly brace of note_gp_changes().  Of course, it is
possible that the address-to-symbol translation failed (please check!),
but in the absence of such failure, there is no way that I know of that
incorrect synchronization could cause a soft lockup at that location.

Other things besides vCPU preemption that could cause a soft lockup at
that location include corrupted kernel text, corrupted kernel stack,
and incessant interrupts.

Other thoughts?

							Thanx, Paul

> If you fix this issue, please add the following tag to the commit:
> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
> 
> ------------------------------------------
> watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [syz.0.745:6431]
> Modules linked in:
> irq event stamp: 312081
> hardirqs last  enabled at (312080): [<ffffffff8aed07eb>] irqentry_exit+0x3b/0x90 kernel/entry/common.c:357
> hardirqs last disabled at (312081): [<ffffffff8aecedbf>] sysvec_apic_timer_interrupt+0xf/0xb0 arch/x86/kernel/apic/apic.c:1049
> softirqs last  enabled at (312032): [<ffffffff82f0f514>] softirq_handle_end kernel/softirq.c:407 [inline]
> softirqs last  enabled at (312032): [<ffffffff82f0f514>] handle_softirqs+0x544/0x870 kernel/softirq.c:589
> softirqs last disabled at (312035): [<ffffffff82f111ce>] __do_softirq kernel/softirq.c:595 [inline]
> softirqs last disabled at (312035): [<ffffffff82f111ce>] invoke_softirq kernel/softirq.c:435 [inline]
> softirqs last disabled at (312035): [<ffffffff82f111ce>] __irq_exit_rcu kernel/softirq.c:662 [inline]
> softirqs last disabled at (312035): [<ffffffff82f111ce>] irq_exit_rcu+0xee/0x140 kernel/softirq.c:678
> CPU: 1 UID: 0 PID: 6431 Comm: syz.0.745 Not tainted 6.13.0-rc4 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:note_gp_changes+0xd8/0x1d0 kernel/rcu/tree.c:1333
> Code: c0 0f 85 d4 00 00 00 0f b6 45 14 84 c0 75 27 48 85 db 0f 85 a5 00 00 00 9c 58 f6 c4 02 0f 85 ae 00 00 00 48 85 db 74 01 fb 5b <5d> 41 5c 41 5d 41 5e e9 47 59 ff 07 4c 89 e7 e8 04 bb de 07 85 c0
> RSP: 0018:ffa00000001e8e38 EFLAGS: 00000206
> RAX: 0000000000000002 RBX: ff1100006a2bd240 RCX: 1ffffffff1eb7361
> RDX: 0000000000000000 RSI: 0000000000000101 RDI: 0000000000000000
> RBP: ff1100006a2bd240 R08: 0000000000000001 R09: 0000000000000001
> R10: fffffbfff1eb7aaa R11: ffffffff8f5bd557 R12: ffffffff8d726380
> R13: 0000000000000202 R14: 00000000000296e9 R15: ff11000018c80000
> FS:  0000000000000000(0000) GS:ff1100006a280000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f69243b2260 CR3: 00000000336f0002 CR4: 0000000000771ef0
> PKRU: 80000000
> Call Trace:
>  <IRQ>
>  rcu_check_quiescent_state kernel/rcu/tree.c:2451 [inline]
>  rcu_core+0x18c/0x16c0 kernel/rcu/tree.c:2807
>  handle_softirqs+0x1ad/0x870 kernel/softirq.c:561
>  __do_softirq kernel/softirq.c:595 [inline]
>  invoke_softirq kernel/softirq.c:435 [inline]
>  __irq_exit_rcu kernel/softirq.c:662 [inline]
>  irq_exit_rcu+0xee/0x140 kernel/softirq.c:678
>  instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
>  sysvec_irq_work+0xca/0xf0 arch/x86/kernel/irq_work.c:17
>  </IRQ>
>  <TASK>
>  asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
> RIP: 0010:_raw_spin_unlock_irqrestore+0x3c/0x70 kernel/locking/spinlock.c:194
> Code: 74 24 10 e8 16 b5 17 f8 48 89 ef e8 9e 35 18 f8 81 e3 00 02 00 00 75 29 9c 58 f6 c4 02 75 35 48 85 db 74 01 fb bf 01 00 00 00 <e8> 8f 53 0c f8 65 8b 05 50 0c 14 75 85 c0 74 0e 5b 5d e9 c8 9b 20
> RSP: 0018:ffa0000003e07938 EFLAGS: 00000206
> RAX: 0000000000000006 RBX: 0000000000000200 RCX: 1ffffffff1eb7361
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
> RBP: ffffffff99031638 R08: 0000000000000001 R09: 0000000000000001
> R10: fffffbfff1eb7aaa R11: ffffffff8f5bd557 R12: 1ff40000007c0f2e
> R13: ff1100001f201c80 R14: 0000000000000001 R15: 0000000000000000
>  debug_object_active_state+0x2e7/0x3d0 lib/debugobjects.c:1055
>  debug_rcu_head_queue kernel/rcu/rcu.h:225 [inline]
>  __call_rcu_common.constprop.0+0x44/0x790 kernel/rcu/tree.c:3071
>  file_free fs/file_table.c:76 [inline]
>  __fput+0x6ed/0xc70 fs/file_table.c:463
>  task_work_run+0x173/0x280 kernel/task_work.c:239
>  exit_task_work include/linux/task_work.h:43 [inline]
>  do_exit+0xa63/0x2fe0 kernel/exit.c:938
>  do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
>  get_signal+0x267a/0x2790 kernel/signal.c:3017
>  arch_do_signal_or_restart+0x81/0x870 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x1dc/0x270 kernel/entry/common.c:218
>  do_syscall_64+0xd0/0x1d0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8bfb79171d
> Code: Unable to access opcode bytes at 0x7f8bfb7916f3.
> RSP: 002b:00007f8bfa3e4ba8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> RAX: 000000000000007b RBX: 00007f8bfb953f80 RCX: 00007f8bfb79171d
> RDX: ffffffffffffffff RSI: 0000000000000000 RDI: 00000000200003c0
> RBP: 00007f8bfb806425 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f8bfb953f8c R14: 00007f8bfb954018 R15: 00007f8bfa3e4d40
>  </TASK>
> Sending NMI from CPU 1 to CPUs 0,2-3:
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.13.0-rc4 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> RIP: 0010:_raw_spin_unlock_irqrestore+0x28/0x70 kernel/locking/spinlock.c:194
> Code: 90 90 f3 0f 1e fa 55 48 89 fd 48 83 c7 18 53 48 89 f3 48 8b 74 24 10 e8 16 b5 17 f8 48 89 ef e8 9e 35 18 f8 81 e3 00 02 00 00 <75> 29 9c 58 f6 c4 02 75 35 48 85 db 74 01 fb bf 01 00 00 00 e8 8f
> RSP: 0018:ffa0000000007e00 EFLAGS: 00000046
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8307db03
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ff1100006a22ce40
> RBP: ff1100006a22ce40 R08: 0000000000000001 R09: ffe21c000d4459c9
> R10: ffe21c000d4459c8 R11: ff1100006a22ce43 R12: 000000000003b18c
> R13: ff1100006a22ced0 R14: 0000000000000000 R15: ff1100006a22ce40
> FS:  0000000000000000(0000) GS:ff1100006a200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc14ae82000 CR3: 00000000089e0002 CR4: 0000000000771ef0
> PKRU: 55555554
> Call Trace:
>  <NMI>
>  </NMI>
>  <IRQ>
>  __run_hrtimer kernel/time/hrtimer.c:1735 [inline]
>  __hrtimer_run_queues+0x531/0xca0 kernel/time/hrtimer.c:1803
>  hrtimer_interrupt+0x39a/0x880 kernel/time/hrtimer.c:1865
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
>  __sysvec_apic_timer_interrupt+0x114/0x400 arch/x86/kernel/apic/apic.c:1055
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
>  sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1049
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
> RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:92 [inline]
> RIP: 0010:default_idle+0x1e/0x30 arch/x86/kernel/process.c:743
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 eb 0c 0f 1f 44 00 00 0f 00 2d b9 76 35 00 0f 1f 44 00 00 fb f4 <fa> e9 37 1e 23 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
> RSP: 0018:ffffffff8d407e00 EFLAGS: 00000202
> RAX: 00000000000d6ff1 RBX: 0000000000000000 RCX: ffffffff8aed0d81
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: 0000000000000001 R09: ffe21c000d446cc3
> R10: ffe21c000d446cc2 R11: ff1100006a236613 R12: 0000000000000000
> R13: ffffffff8f5bd550 R14: 0000000000000000 R15: 0000000000000000
>  default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
>  cpuidle_idle_call kernel/sched/idle.c:185 [inline]
>  do_idle+0x31d/0x3d0 kernel/sched/idle.c:325
>  cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:423
>  rest_init+0x1a9/0x2f0 init/main.c:747
>  start_kernel+0x412/0x510 init/main.c:1102
>  x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
>  x86_64_start_kernel+0xba/0x110 arch/x86/kernel/head64.c:488
>  common_startup_64+0x12c/0x138
>  </TASK>
> NMI backtrace for cpu 3
> CPU: 3 UID: 0 PID: 2541 Comm: systemd-udevd Not tainted 6.13.0-rc4 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:rcu_read_lock_held+0x23/0xb0 kernel/rcu/update.c:346
> Code: 90 90 90 90 90 90 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 53 48 83 ec 60 48 89 e3 48 8d 7c 24 20 48 c7 04 24 b3 8a b5 41 <48> c7 44 24 08 86 7f f8 8c 48 c1 eb 03 48 c7 44 24 10 20 ed 0e 83
> RSP: 0018:ffa0000000298c20 EFLAGS: 00000082
> RAX: dffffc0000000000 RBX: ffa0000000298c20 RCX: ffffffff82f73725
> RDX: 0000000000000001 RSI: ff1100002697c680 RDI: ffa0000000298c40
> RBP: ff11000001656400 R08: 0000000000000000 R09: fffffbfff23cc7a9
> R10: fffffbfff23cc7a8 R11: ffffffff91e63d47 R12: ff11000001079000
> R13: 0000000000000001 R14: ff1100006a3a9440 R15: 0000000000000040
> FS:  00007fc4050e48c0(0000) GS:ff1100006a380000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffc871bcff8 CR3: 00000000541d6003 CR4: 0000000000771ef0
> PKRU: 55555554
> Call Trace:
>  <NMI>
>  </NMI>
>  <IRQ>
>  __queue_work+0x5be/0x1220 kernel/workqueue.c:2269
>  call_timer_fn+0x1be/0x690 kernel/time/timer.c:1793
>  expire_timers kernel/time/timer.c:1839 [inline]
>  __run_timers+0x4fc/0xb50 kernel/time/timer.c:2418
>  __run_timer_base kernel/time/timer.c:2430 [inline]
>  __run_timer_base kernel/time/timer.c:2422 [inline]
>  run_timer_base+0xc5/0x120 kernel/time/timer.c:2439
>  run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2449
>  handle_softirqs+0x1ad/0x870 kernel/softirq.c:561
>  __do_softirq kernel/softirq.c:595 [inline]
>  invoke_softirq kernel/softirq.c:435 [inline]
>  __irq_exit_rcu kernel/softirq.c:662 [inline]
>  irq_exit_rcu+0xee/0x140 kernel/softirq.c:678
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
>  sysvec_apic_timer_interrupt+0x94/0xb0 arch/x86/kernel/apic/apic.c:1049
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
> RIP: 0010:_raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
> Code: 90 f3 0f 1e fa 55 48 8b 74 24 08 48 89 fd 48 83 c7 18 e8 7a b5 17 f8 48 89 ef e8 02 36 18 f8 e8 ed 0f 42 f8 fb bf 01 00 00 00 <e8> 02 54 0c f8 65 8b 05 c3 0c 14 75 85 c0 74 06 5d e9 3c 9c 20 00
> RSP: 0018:ffa0000003a57ce0 EFLAGS: 00000202
> RAX: 0000000000ffe279 RBX: 0000000000000000 RCX: 1ffffffff1eb7361
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
> RBP: ff1100003fc49280 R08: 0000000000000001 R09: 0000000000000001
> R10: fffffbfff1eb7aaa R11: ffffffff8f5bd557 R12: 0000000000000000
> R13: dffffc0000000000 R14: 0000000000000000 R15: ff1100002697c680
>  spin_unlock_irq include/linux/spinlock.h:401 [inline]
>  get_signal+0x1f24/0x2790 kernel/signal.c:3020
>  arch_do_signal_or_restart+0x81/0x870 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x1dc/0x270 kernel/entry/common.c:218
>  do_syscall_64+0xd0/0x1d0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc40568b04e
> Code: 0f 1f 40 00 48 8b 15 79 af 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb ba 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
> RSP: 002b:00007ffe5fb12788 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: fffffffffffffdff RBX: 0000000000001001 RCX: 00007fc40568b04e
> RDX: 0000000000001001 RSI: 0000559aeb0bbd00 RDI: 0000000000000012
> RBP: 0000000000000012 R08: 0000559aeb0bbd00 R09: 00007fc405673be0
> R10: 000000000000006f R11: 0000000000000246 R12: 0000559aeb0bbd00
> R13: 0000000000001000 R14: 0000000000000000 R15: 00007ffe5fb127b0
>  </TASK>
> NMI backtrace for cpu 2
> CPU: 2 UID: 0 PID: 2540 Comm: systemd-udevd Not tainted 6.13.0-rc4 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:pfn_valid include/linux/mmzone.h:2045 [inline]
> RIP: 0010:__virt_addr_valid+0x11d/0x610 arch/x86/mm/physaddr.c:65
> Code: 00 bb 19 00 00 00 e8 92 f8 48 00 49 89 ec 89 d9 31 ff 49 c1 ec 1b 4c 89 e0 48 d3 e8 48 89 c3 48 89 c6 e8 d6 fa 48 00 48 85 db <74> 1d 45 31 e4 e8 69 f8 48 00 44 89 e0 5b 5d 41 5c 41 5d e9 76 99
> RSP: 0018:ffa0000000240bf8 EFLAGS: 00000046
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82e0a77a
> RDX: 0000000000000000 RSI: ff110000153f2340 RDI: 0000000000000003
> RBP: 000000006a329440 R08: 0000000000000000 R09: fffffbfff3206eaa
> R10: fffffbfff3206ea9 R11: ffffffff9903754b R12: 000000000000000d
> R13: ff11000001656000 R14: 0000000000000000 R15: ff11000001e00000
> FS:  00007fc4050e48c0(0000) GS:ff1100006a300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055558e69e9b0 CR3: 00000000401b4005 CR4: 0000000000771ef0
> PKRU: 55555554
> Call Trace:
>  <NMI>
>  </NMI>
>  <IRQ>
>  kasan_addr_to_slab+0xd/0x80 mm/kasan/common.c:37
>  __kasan_record_aux_stack+0xe/0xc0 mm/kasan/generic.c:529
>  insert_work+0x36/0x240 kernel/workqueue.c:2183
>  __queue_work+0x868/0x1220 kernel/workqueue.c:2339
>  call_timer_fn+0x1be/0x690 kernel/time/timer.c:1793
>  expire_timers kernel/time/timer.c:1839 [inline]
>  __run_timers+0x4fc/0xb50 kernel/time/timer.c:2418
>  __run_timer_base kernel/time/timer.c:2430 [inline]
>  __run_timer_base kernel/time/timer.c:2422 [inline]
>  run_timer_base+0xc5/0x120 kernel/time/timer.c:2439
>  run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2449
>  handle_softirqs+0x1ad/0x870 kernel/softirq.c:561
>  __do_softirq kernel/softirq.c:595 [inline]
>  invoke_softirq kernel/softirq.c:435 [inline]
>  __irq_exit_rcu kernel/softirq.c:662 [inline]
>  irq_exit_rcu+0xee/0x140 kernel/softirq.c:678
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
>  sysvec_apic_timer_interrupt+0x94/0xb0 arch/x86/kernel/apic/apic.c:1049
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:check_preemption_disabled+0x3e/0x170 lib/smp_processor_id.c:56
> Code: 44 8b 25 21 9e 16 75 65 8b 1d 16 9e 16 75 81 e3 ff ff ff 7f 31 ff 89 de 0f 1f 44 00 00 85 db 74 15 0f 1f 44 00 00 44 89 e0 5b <5d> 41 5c 41 5d 41 5e e9 71 2d 23 00 0f 1f 44 00 00 9c 5b 81 e3 00
> RSP: 0018:ffa0000003617878 EFLAGS: 00000202
> RAX: 0000000000000002 RBX: 0000000000000008 RCX: 0000000000000000
> RDX: 1ffffffff1ac20bc RSI: 0000000000000002 RDI: 0000000000000000
> RBP: ffffffff8b82c2a0 R08: ffffffff8b33c540 R09: 0000000000000001
> R10: 000000000003b18c R11: ffffffff8f5bd557 R12: 0000000000000002
> R13: ffffffff8b82c260 R14: 00c0ffff95a10cf8 R15: ffa0000003617960
>  do_perf_trace_lock_acquire include/trace/events/lock.h:24 [inline]
>  perf_trace_lock_acquire+0x111/0x670 include/trace/events/lock.h:24
>  trace_lock_acquire include/trace/events/lock.h:24 [inline]
>  lock_acquire+0x2fd/0x580 kernel/locking/lockdep.c:5820
>  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>  __mutex_lock+0x16f/0x1eb0 kernel/locking/mutex.c:735
>  seq_read_iter+0xe1/0x1260 fs/seq_file.c:182
>  kernfs_fop_read_iter+0x415/0x5a0 fs/kernfs/file.c:279
>  new_sync_read fs/read_write.c:484 [inline]
>  vfs_read fs/read_write.c:565 [inline]
>  vfs_read+0x870/0xbf0 fs/read_write.c:545
>  ksys_read+0x122/0x240 fs/read_write.c:708
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc40568b04e
> Code: 0f 1f 40 00 48 8b 15 79 af 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb ba 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
> RSP: 002b:00007ffe5fb12788 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000001001 RCX: 00007fc40568b04e
> RDX: 0000000000001001 RSI: 0000559aeb0bbd40 RDI: 0000000000000012
> RBP: 0000000000000012 R08: 0000559aeb0bbd40 R09: 00007fc405673be0
> R10: 000000000000006f R11: 0000000000000246 R12: 0000559aeb0bbd40
> R13: 0000000000001000 R14: 0000000000000000 R15: 00007ffe5fb127b0
>  </TASK>
> 
> 
> 
> ---------------
> thanks,
> Kun Hu
