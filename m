Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0311F602
	for <rcu@vger.kernel.org>; Sat,  7 Dec 2024 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733594440; cv=none; b=EmKh9sEInkMQTuKT1lmGWyRUXX4kTVxrgAXeJSV8Wg7hSRVo1SIeqcqd7mo0j0uO/U9sHAXvqmAQcn3OKxLavHJhs3dPYVS0z0Hl5jcxj9n0rRF30J3WLWi1z2ssywEriNdVQJZxiXTuGKjeGmPFxo4z7EkteUZC3eJUcO/pwt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733594440; c=relaxed/simple;
	bh=RO65r+djac6jU+rD5fiaC8GAD/CgHWAiMIDc3S+2G+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzEROGoeiQDjVz2CWTpGdfiqmpIDqDK6DmScHfO4NUoiQDTSBpDP8PH+DR+Eg9w1VG71OZbqOEsP0X+WiOSNOpMZgDYdn5jS4K3VLQNlirVQHpbL6zdDRd72ZY+dPNIiHfjXnghEQArAKn4yS78bm8BNDgmbaZPJoZB0yeHb5KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deawsGCp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deawsGCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACCCC4CECD;
	Sat,  7 Dec 2024 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733594439;
	bh=RO65r+djac6jU+rD5fiaC8GAD/CgHWAiMIDc3S+2G+k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=deawsGCp4g2QALgPAonrwl/VYtKJ052O/rPay2b5z4tH8Sf0ReGusxCnOU76UJA7a
	 4M8BsGjZB4xLmUiAikuMSqripaqoLNg7gTfYa8qfyM7U4+YLcVlnHP4wNchKU/qWlx
	 wXqPKjKPp0wjsX8oQhttI5OZO5AbWWZJBSHuOSqI4gdlYX4247C7u13mGRQN5GDMIW
	 EuNk6JTBqmD4zZOhySBvvJzQobRGS0td1uo00psDQhWfpHImqTAxRd3oUT1anGb0Do
	 5asR7jEf2156jkEnk3gztTEHYGf6d1dn1+aZctkf+rKaOJDbQOQlxHtXjHYLq2F+eE
	 hikdm6A1oq1PA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 36153CE09DB; Sat,  7 Dec 2024 10:00:39 -0800 (PST)
Date: Sat, 7 Dec 2024 10:00:39 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: MengEn Sun <mengensun88@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org
Subject: Re: Softlock up of rcu_sched has been detect
Message-ID: <c69c28bf-88a7-4ba8-a544-48dd361f9ead@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1733590109-12926-1-git-send-email-mengensun@tencent.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1733590109-12926-1-git-send-email-mengensun@tencent.com>

On Sun, Dec 08, 2024 at 12:48:29AM +0800, MengEn Sun wrote:
> Hi,
> 
> The kernel version that we are using is 5.4.241. Recently, we
> encountered a case of rcu_sched thread soft lock. The kernel stack
> is as follows:
> 
> crash> bt
> PID: 10     TASK: ffff8a83cc610000  CPU: 14  COMMAND: "rcu_sched"
>  #0 [ffffc90000a64d50] machine_kexec at ffffffff8105714c 
>  #1 [ffffc90000a64da0] __crash_kexec at ffffffff8112c9bd 
>  #2 [ffffc90000a64e68] panic at ffffffff819e29d8 
>  #3 [ffffc90000a64ee8] watchdog_timer_fn.cold.9 at ffffffff819e9a3f 
>  #4 [ffffc90000a64f18] __hrtimer_run_queues at ffffffff8110b5d0 
>  #5 [ffffc90000a64f78] hrtimer_interrupt at ffffffff8110bdf0 
>  #6 [ffffc90000a64fd8] smp_apic_timer_interrupt at ffffffff81c0268a 
>  #7 [ffffc90000a64ff0] apic_timer_interrupt at ffffffff81c01c0f 
> --- <IRQ stack> ---
>  #8 [ffffc9000006bdd8] apic_timer_interrupt at ffffffff81c01c0f 
>     [exception RIP: _raw_spin_unlock_irqrestore+14]
>  #9 [ffffc9000006be80] force_qs_rnp at ffffffff810fa0b0 
> #10 [ffffc9000006beb8] rcu_gp_kthread at ffffffff810fd9b6 
> #11 [ffffc9000006bf10] kthread at ffffffff8109e40c 
> #12 [ffffc9000006bf50] ret_from_fork at ffffffff81c00255 
> 
> It seems that it is because a CPU did not report its QS in time.
> I see from vmcore that the 141 cpu did not report its QS
> 
> 
> The current process on the 141 CPU is as follows, it looks like 141
> has detected the rcu stall and the print serial port log
> 
> crash> bt -c 141
> PID: 594039  TASK: ffff8a699dab8000  CPU: 141  COMMAND: "stress-ng-zombi"
>  #0 [fffffe0001f70e40] crash_nmi_callback at ffffffff8104b54f 
>  #1 [fffffe0001f70e60] nmi_handle at ffffffff8101cf92 
>  #2 [fffffe0001f70eb8] default_do_nmi at ffffffff8101d16e 
>  #3 [fffffe0001f70ed8] do_nmi at ffffffff8101d351 
>  #4 [fffffe0001f70ef0] end_repeat_nmi at ffffffff81c015f3 
>     [exception RIP: vprintk_emit+492]
> --- <NMI exception stack> ---
>  #5 [ffffc90002038db0] vprintk_emit at ffffffff810eb19c 
>  #6 [ffffc90002038e00] printk at ffffffff819e6544 
>  #7 [ffffc90002038e60] rcu_check_gp_kthread_starvation at ffffffff819e78bd 
>  #8 [ffffc90002038e88] rcu_sched_clock_irq.cold.84 at ffffffff819e8021 
>  #9 [ffffc90002038ed0] update_process_times at ffffffff8110a8e4 
> #10 [ffffc90002038ee0] tick_sched_handle at ffffffff8111be22 
> #11 [ffffc90002038ef8] tick_sched_timer at ffffffff8111c147 
> #12 [ffffc90002038f18] __hrtimer_run_queues at ffffffff8110b5d0 
> #13 [ffffc90002038f78] hrtimer_interrupt at ffffffff8110bdf0 
> #14 [ffffc90002038fd8] smp_apic_timer_interrupt at ffffffff81c0268a 
> #15 [ffffc90002038ff0] apic_timer_interrupt at ffffffff81c01c0f 
> --- <IRQ stack> ---
> #16 [ffffc90004227c98] apic_timer_interrupt at ffffffff81c01c0f 
>     [exception RIP: __rb_erase_color+34]
> #17 [ffffc90004227d78] unlink_file_vma at ffffffff81241e0b 
> #18 [ffffc90004227da0] free_pgtables at ffffffff8123708e 
> #19 [ffffc90004227dd8] exit_mmap at ffffffff81243ea1 
> #20 [ffffc90004227e78] mmput at ffffffff81074fd4 
> #21 [ffffc90004227e90] do_exit at ffffffff8107d50c 
> #22 [ffffc90004227f08] do_group_exit at ffffffff8107de6a 
> #23 [ffffc90004227f30] __x64_sys_exit_group at ffffffff8107dee4 
> #24 [ffffc90004227f38] do_syscall_64 at ffffffff81002535 
> #25 [ffffc90004227f50] entry_SYSCALL_64_after_hwframe at ffffffff81c000a4 
> 
> I think the reasons are as follows:
> - The rcu_sched needs to lock the rcu node where the 141 cpu is located
>   to force the QS operations.
> - However 141 detects rcu stall and locks rcu node to print some serial
>   logs.
> - The 141 cpu does touch nmi considering that printing port logs may
>   cause system soft or hard locks.
> - However, The 141 cpu does not take into account other cpu, such as
>   cpu 14, which may be blocked because it holds the lock of rcu node.
> 
> I think printing serial port log is a more expensive operation, can
> we only let the 141 cpu in the critical section of the rcu node lock,
> collect the information it needs to print, and print the log it
> collected after it released the rcu node lock?

Mainline uses printk_deferred_enter() and printk_deferred_exit() to get
this effect.  Please see this commit in mainline:

1ecd9d68eb44 ("rcu: Defer printing stall-warning backtrace when holding rcu_node lock")

And these might also be helpful:

cbe644aa6fe1 ("rcu: Stop stall warning from dumping stacks if grace period ends")
9650edd9bf1d ("rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()")

> I'm not sure if there is a better way to solve this problem?

There might well be.  For example, should printk_deferred_enter() and
printk_deferred_exit() prove problematic, it has been suggested that
printk_cpu_sync_get_irqsave() and printk_cpu_sync_put_irqrestore() be
used instead.  However, the header comments for these two macros clearly
state that they are very strong medicine with serious side effects.

So: (1) There needs to be a very real problem with the current approach
of printk_deferred_enter() and printk_deferred_exit(), and (2) Careful
analysis, review, and testing would be required.

And there might well be some even better approach.  I would of course
welcome additional eyes on this problem, and a good place to start is to
review the commits to this code.

							Thanx, Paul
