Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA1718C33B;
	Thu,  8 Aug 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126055; cv=none; b=cLfGe/+2DfeHrZr67V14Q2rvl8B0F1Gkrz1ze+ZpOMEhS0YvpcLyPGuoCOjnXsbmU5qcsIA2qw3HM7A12F+X/Z5y4C4IHvUHWObIvdXoq/xQS2wD+AcSRXMq1Ll8BQXJ+RIma0/JXFR8Q3I0hrOcSmftdJbuc5nWGEXAcfVxFXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126055; c=relaxed/simple;
	bh=nHLeEGMTKPUULbOj7z70kEjUifzFIy59v4V+bWV68bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBd7sL0XkzwpwTDZDb7ZvTyy/wqLoDbUD4wpL7KAmo2E69Hx1WQl7s7YzNydDs+9rgxtbHSWrYEsHgslyxRLfSj6Y8QMrzAdG3q9T6qHfVjlRcTENgnh3FsdCbh5dj5Fht/JoiNtZzAz5Jz0BrLys+CtX0KmmFUFS2j4WJz52pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FN8IOsJW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FN8IOsJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80748C4AF0C;
	Thu,  8 Aug 2024 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723126054;
	bh=nHLeEGMTKPUULbOj7z70kEjUifzFIy59v4V+bWV68bg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FN8IOsJWxMfyBN6vl5OQF64L5eKBekkMIKAp7N8+Dh7HWGYEKKXqGZkbq4D6BYRCu
	 ogml985Wg3ID/odXFz9Xo4HDrLVOhp8I8Jd3pYIZRJPZdnF/aV4Ie1IRiVDFNnmVNY
	 3X2GorzH9MrFiju1lQa+3P9njdKOwnHwZElcTmzmFp8jboG76hoimL54BLgEbI9Bmw
	 B4Rf5gkekOsqLC0zIoydzMOc/r7FHp2C072E90HTjrpMnR4rjXsGS5vXGCKJqS2zCD
	 WOvQ6523Rkzdbi4A8GjT19X9J2dBrkhAIYYGXAryMWyqzDrHmBuwY4bOASiV3nEkPF
	 GZKyeyvfDhKsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2461ACE0A01; Thu,  8 Aug 2024 07:07:34 -0700 (PDT)
Date: Thu, 8 Aug 2024 07:07:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, rcu@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2024.07.18b] [srcu]  8a4c716cfc:
 WARNING:at_kernel/rcu/rcutorture.c:#do_rtws_sync[rcutorture]
Message-ID: <7b4990b7-62d6-43a0-8bdc-612e8c0c2655@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202408081016.9d43eb89-lkp@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408081016.9d43eb89-lkp@intel.com>

On Thu, Aug 08, 2024 at 01:18:48PM +0800, kernel test robot wrote:
> 
> hi, JP Kobryn and Paul E. McKenney,
> 
> we don't see commit with same title in later dev.2024.07*** or dev.2024.08***
> branches in https://github.com/paulmckrcu/linux, so not sure if this report is
> still useful.
> 
> another thing is the issue is random. just FYI.

This commit is bad, and the later commit is a fix:

316a003bd5a4 ("srcu: faster gp seq wrap-around")

The 9% failure rate is not atypical, and in fact is a rather higher rate
of reproduction than we saw in our testing.  ;-)

Thank you for your testing efforts!

							Thanx, Paul

> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/torture_type:
>   vm-snb/rcutorture/debian-12-x86_64-20240206.cgz/x86_64-randconfig-003-20240730/clang-18/300s/cpuhotplug/srcu
> 
> commit:
>   1815b92627178 ("workqueue: Add check for clocks going backwards to wq_worker_tick()")
>   8a4c716cfcb96 ("srcu: Make SRCU GP sequence number wrap")
> 
> 1815b926271780c9 8a4c716cfcb9602e0baedfced5f
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :100          9%           9:100   dmesg.RIP:do_rtws_sync[rcutorture]
>            :100          9%           9:100   dmesg.WARNING:at_kernel/rcu/rcutorture.c:#do_rtws_sync[rcutorture]
> 
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#do_rtws_sync[rcutorture]" on:
> 
> commit: 8a4c716cfcb9602e0baedfced5fa6d2c9169f421 ("srcu: Make SRCU GP sequence number wrap")
> https://github.com/paulmckrcu/linux dev.2024.07.18b
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: cpuhotplug
> 	torture_type: srcu
> 
> 
> 
> compiler: clang-18
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408081016.9d43eb89-lkp@intel.com
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240808/202408081016.9d43eb89-lkp@intel.com
> 
> 
> [   27.636859][  T515] ------------[ cut here ]------------
> [   27.636869][  T515] do_rtws_sync: Cookie check 3 failed srcu_torture_synchronize_expedited+0x0/0x20 [rcutorture]() online 0-1.
> [   27.636964][  T515] WARNING: CPU: 0 PID: 515 at kernel/rcu/rcutorture.c:1348 do_rtws_sync+0x1fc/0x240 [rcutorture]
> [   27.636983][  T515] Modules linked in: rcutorture(+) torture ip_tables x_tables
> [   27.636999][  T515] CPU: 0 PID: 515 Comm: rcu_torture_wri Tainted: G                T  6.10.0-rc5-00120-g8a4c716cfcb9 #1
> [   27.637005][  T515] RIP: 0010:do_rtws_sync+0x1fc/0x240 [rcutorture]
> [   27.637021][  T515] Code: ae c0 00 00 01 90 8b 0d 5a a1 d3 e3 48 c7 c7 ab 48 04 a0 48 c7 c6 74 29 04 a0 48 89 da 49 c7 c0 68 80 d6 83 e8 35 a3 04 e1 90 <0f> 0b 90 90 45 84 e4 0f 85 7b ff ff ff eb ac c6 05 74 c0 00 00 01
> [   27.637026][  T515] RSP: 0000:ffffc9000170bde0 EFLAGS: 00010286
> [   27.637031][  T515] RAX: 000000000000006a RBX: ffffffffa002d860 RCX: 0000000000000027
> [   27.637035][  T515] RDX: 0000000000000007 RSI: ffff888143590680 RDI: ffff88842fbd6cc8
> [   27.637039][  T515] RBP: ffffc9000170be18 R08: ffff888143590680 R09: 0000000000000001
> [   27.637042][  T515] R10: 0000000000000009 R11: 0000000000000000 R12: 0000000000000000
> [   27.637046][  T515] R13: 0000000000000001 R14: 0000000000000004 R15: 0000000000000001
> [   27.637049][  T515] FS:  0000000000000000(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
> [   27.637054][  T515] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   27.637058][  T515] CR2: 00007f1846cf4000 CR3: 00000001440fc000 CR4: 00000000000406b0
> [   27.637065][  T515] Call Trace:
> [   27.637068][  T515]  <TASK>
> [   27.637073][  T515]  ? show_regs+0x5e/0x70
> [   27.637108][  T515]  ? __warn+0xcb/0x220
> [   27.637116][  T515]  ? do_rtws_sync+0x1fc/0x240 [rcutorture]
> [   27.637135][  T515]  ? report_bug+0xc6/0x160
> [   27.637977][  T515]  ? handle_bug+0x42/0x80
> [   27.637985][  T515]  ? exc_invalid_op+0x1b/0x50
> [   27.637993][  T515]  ? asm_exc_invalid_op+0x1b/0x20
> [   27.638004][  T515]  ? __cfi_srcu_torture_synchronize_expedited+0x10/0x10 [rcutorture]
> [   27.638030][  T515]  ? do_rtws_sync+0x1fc/0x240 [rcutorture]
> [   27.638055][  T515]  rcu_torture_writer+0x8c3/0x1040 [rcutorture]
> [   27.638071][  T515]  ? local_clock+0x15/0x20
> [   27.638081][  T515]  ? lock_release+0x120/0x4b0
> [   27.638087][  T515]  ? kthread+0x128/0x190
> [   27.638102][  T515]  ? kthread+0xad/0x190
> [   27.638108][  T515]  kthread+0x179/0x190
> [   27.638112][  T515]  ? __cfi_rcu_torture_writer+0x10/0x10 [rcutorture]
> [   27.638131][  T515]  ? __cfi_kthread+0x10/0x10
> [   27.638137][  T515]  ret_from_fork+0x4a/0x60
> [   27.638143][  T515]  ? __cfi_kthread+0x10/0x10
> [   27.638150][  T515]  ret_from_fork_asm+0x11/0x20
> [   27.638174][  T515]  </TASK>
> [   27.638177][  T515] irq event stamp: 333
> [   27.638180][  T515] hardirqs last  enabled at (339): [<ffffffff8110c3bf>] vprintk_emit+0x21f/0x2c0
> [   27.638188][  T515] hardirqs last disabled at (344): [<ffffffff8110c2b3>] vprintk_emit+0x113/0x2c0
> [   27.638195][  T515] softirqs last  enabled at (40): [<ffffffffa002af04>] rcu_torture_writer+0x264/0x1040 [rcutorture]
> [   27.638212][  T515] softirqs last disabled at (38): [<ffffffffa002aeba>] rcu_torture_writer+0x21a/0x1040 [rcutorture]
> [   27.638228][  T515] ---[ end trace 0000000000000000 ]---
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
