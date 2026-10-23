Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782763;
	b=bVykjIuFtQzraDwNiqtZrHRZyyO7GigtdDyi2Xh8IZFiOnGoWeL/7mbBPoTXkL923vz0
	 kN3oIi5zJSftI8kEl3xic/cc9nusRxdOPae6gWu4JA7Yiq2C/iGWh1rMaPanCIwnfOU2y
	 CFpP47dZ8nVbw0i2COpkvOZ+qaDy+/3aNJ26BBeRziXP0z3yr5ZfEPwLQZahRMQxzp/oj
	 xTV81rpXWiokZTNchBElOr6HtRuFQxYcyFhatuw5XTT1SokLjfkPazkPe97LZsP6x97wh
	 rjfU3VOYeaJTk89UVqA4t4Hol/qZd89/hWWm+g6KLhAG6bsrYnfzwVGOYu4ZiM1TVYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782763;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=R+O0C5mjGdG0AQwwj6ob0LZQduOFfCaBHIQQN9NwpAM=;
	b=jRcIdEWlvdFcG91TjzEzkcgwPe+ZumD/MODdUTDQelECn+EjeSVPaqQ4rzFDw5Qh6jy7
	 zk/YOt1o5zgXZHLzb9SoYj89iFLfirsHZGfnFMH43M7ekO3Hc/xICAg7gOvRAO1FVnsGy
	 mLkEifhmVxiwVWQVzA+XOT/sslRoQBa/4rTNJIVpPfD0COzyk5ItBFcMgtRtc04/3+oEk
	 4qcwUddanoleHZu++ENy5C4TO0QaNWZvJRrIYoojrFB3JoBT4i1O6L1pmrOk6q+p37zL1
	 mNW9do3FU69jMG73kabcpBQoYRol8ZfFmNozFZ2YrFqXJKuphYwp0FnBNP+5PR0+/hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgsLM8FO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB4606A31A;
	Fri, 23 Oct 2026 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgsLM8FO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219721F01825;
	Fri, 23 Oct 2026 19:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792782762;
	bh=R+O0C5mjGdG0AQwwj6ob0LZQduOFfCaBHIQQN9NwpAM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=hgsLM8FOSA//nsu1y5WUCXIIRuWlGHZEtUufqZ2XFcVasvf6HCBu8Ai68nbLDO8bR
	 zbD46Fp8OsIkE5inp9oEuVyJVmdD0kdrCeA+UypG3L4AAeyAGL5Xdiz2q6SVaiYKJE
	 XZWQ8hcbjEfgavQOt3hoiGMvPehYAbz7QgHHXu/zcKotrMa0CuWfrckqOY7xoCAAfY
	 DwMhWND/Jed0UynW1OPhFc2qlM2UUt0Q4i/jddAlxKfQFnVk7IaSdIsrkPizAuuEP4
	 DcnEuTzzriDUfQTjCNzSfWPH4NgJTcaAcw5TJXBHGqRv3lyykGnN+l8tYwhqyNKSM1
	 Eo1WtuMpfBDHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DB672CE0540; Fri, 23 Oct 2026 12:12:41 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:12:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Make tasks-tracing support duplicate call
 testing
Message-ID: <3d92a635-7005-4f46-8cf3-091575ce0567@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261023094039.29696-1-qiang.zhang@linux.dev>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023094039.29696-1-qiang.zhang@linux.dev>

On Fri, Oct 23, 2026 at 05:40:39PM +0800, Zqiang wrote:
> Currently, Tasks-tracing has been reimplemented by SRCU-fast, it supports
> the detection of duplicate calls with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y.
> This commit therefore set tasks_tracing_ops.debug_objects to 1, enabling
> rcutorture's duplicate-call test for the tasks-tracing flavor.
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> 
> Simple output from rcutorture:
> 
> [    4.120772][    T1] call_srcu(): Leaked duplicate callback
> [    4.120776][    T1] WARNING: kernel/rcu/srcutree.c:1516 at __call_srcu+0x463/0x580, CPU#7: swapper/0/1
> [    4.122665][    T1] Modules linked in:
> [    4.123026][    T1] CPU: 7 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           7.3.0-rc1+ #110 PREEMPT(full)  8fac67ca5e4b530c23977b2e660a83979ea107db
> [    4.124328][    T1] Tainted: [W]=WARN
> [    4.124687][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> [    4.125583][    T1] RIP: 0010:__call_srcu+0x463/0x580
> [    4.126056][    T1] Code: 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d e9 16 99 9f 03 80 3c 02 00 0f 85 e8 00 00 00 49 c7 46 08 70 cf 4e b4 48 8d 3d ad da d5 06 <67> 48 0f b9 3a eb a6 48 8d 3d af da d5 06 67 48 0f b9 3a eb 98 0f
> [    4.127823][    T1] RSP: 0000:ffff888100e87a78 EFLAGS: 00010246
> [    4.128389][    T1] RAX: dffffc0000000000 RBX: 1ffff110201d0f54 RCX: 0000000000000001
> [    4.129111][    T1] RDX: 1ffff110201d0f8f RSI: ffffffffb8ae6d60 RDI: ffffffffbb255590
> [    4.129842][    T1] RBP: ffff888100e87b28 R08: ffff888100e87c70 R09: ffffffffb818a820
> [    4.130572][    T1] R10: fffffbfff76449ac R11: ffffffffbb224d67 R12: 0000000000000001
> [    4.131296][    T1] R13: 00000000ffffffea R14: ffff888100e87c70 R15: ffffffffba4c4220
> [    4.132061][    T1] FS:  0000000000000000(0000) GS:ffff888239af2000(0000) knlGS:0000000000000000
> [    4.132903][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.133536][    T1] CR2: 0000000000000000 CR3: 000000008a8ea000 CR4: 00000000000026f0
> [    4.134283][    T1] Call Trace:
> [    4.134607][    T1]  <TASK>
> [    4.134898][    T1]  ? __pfx_rcu_torture_err_cb+0x10/0x10
> [    4.135425][    T1]  ? __pfx___call_srcu+0x10/0x10
> [    4.135870][    T1]  ? __pfx__printk+0x10/0x10
> [    4.136301][    T1]  call_srcu+0x17/0x20
> [    4.136685][    T1]  call_rcu_tasks_trace+0x1a/0x20
> [    4.137143][    T1]  rcu_torture_init+0x3033/0x3800
> [    4.137617][    T1]  ? __kvm_handle_async_pf+0x21/0xb0
> [    4.138094][    T1]  ? __pfx_native_sched_clock+0x1/0x10
> [    4.138608][    T1]  ? __pfx_rcu_torture_init+0x10/0x10
> [    4.139109][    T1]  ? add_device_randomness+0xcb/0x110
> [    4.139637][    T1]  ? __this_cpu_preempt_check+0x17/0x20
> [    4.140160][    T1]  ? lockdep_hardirqs_on+0xde/0x160
> [    4.140653][    T1]  ? _raw_spin_unlock_irqrestore+0x6e/0x80
> [    4.141211][    T1]  ? _raw_spin_unlock_irqrestore+0x53/0x80
> [    4.141772][    T1]  ? __pfx_rcu_torture_leak_cb+0x10/0x10
> [    4.142291][    T1]  ? add_device_randomness+0xcb/0x110
> [    4.142828][    T1]  ? __pfx_add_device_randomness+0x10/0x10
> [    4.143397][    T1]  ? __pfx_srcu_leak_callback+0x10/0x10
> [    4.143937][    T1]  ? __pfx_rcu_torture_init+0x10/0x10
> [    4.144440][    T1]  do_one_initcall+0xd9/0x620
> [    4.144878][    T1]  ? __pfx_do_one_initcall+0x10/0x10
> [    4.145390][    T1]  ? __kasan_kmalloc+0x86/0xa0
> [    4.145963][    T1]  ? __kmalloc_noprof+0x2c9/0x610
> [    4.146576][    T1]  kernel_init_freeable+0xb00/0x11a0
> [    4.147214][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    4.147804][    T1]  kernel_init+0x28/0x170
> [    4.148308][    T1]  ret_from_fork+0x7be/0xaf0
> [    4.148880][    T1]  ? __pfx_ret_from_fork+0x10/0x10
> [    4.149512][    T1]  ? __kasan_check_read+0x15/0x20
> [    4.150111][    T1]  ? __switch_to+0x1b0/0xeb0
> [    4.150778][    T1]  ? __switch_to_asm+0x39/0x70
> [    4.151324][    T1]  ? __pfx_kernel_init+0x10/0x10
> [    4.151910][    T1]  ret_from_fork_asm+0x1a/0x30
>  
>  kernel/rcu/rcutorture.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 1bbf8192786a..c0c8fbdb5508 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1313,6 +1313,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
>  	.irq_capable	= 1,
>  	.slow_gps	= 1,
>  	.nmi_capable	= 1,
> +	.debug_objects	= 1,
>  	.name		= "tasks-tracing"
>  };
>  
> -- 
> 2.17.1
> 
