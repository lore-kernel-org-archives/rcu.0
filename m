Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25979DE;
	Mon, 24 Jun 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233665; cv=none; b=gj91177YciIUyzN4N6UY7Pkfwd89fWAh3r3Qq0Lm5BIttYU18WomQh7dNrq83DyQjD4zGc7Eu0Uu32xVItaRpfNYe+7EauHjvYyQyFpD9CtMjGMRDb+ndOWMqmoFJuWW3zRRYhDlZnW/B7H/FgwvkDqEBpDmfa3Y1b2laTd7IHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233665; c=relaxed/simple;
	bh=3qQAHrGBnig7NzaC1u5io5M607UF4707N9XvAM1apmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koE7+dquRysEFyQOF1zjuRStpFmMNpORy5cynzeeS4/qdCwKOMvVMvlSN7WJ3hNAa6WvpVARoMC2Ec9bjqy3oTioScOsn61MB9TMp4DEEJ1OQ7wbeAOjVT8bs1B8ArE512FucwIKiVIO6w36P1xeYJ5QqBEapCrE+gDxz1dv+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4VHZeda; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4VHZeda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCBBC2BBFC;
	Mon, 24 Jun 2024 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719233664;
	bh=3qQAHrGBnig7NzaC1u5io5M607UF4707N9XvAM1apmw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=W4VHZedabTZjSEMuGq/CWfhqDO0coR4NhUria8yOdSKuJUfMNVnLN4HUfxZAvUllA
	 hnimFIvOXbAMJSS6MxRHhvIsQzu3viXshc280+Inna/panHO9/TMzeEQlawm/3cpI4
	 gFt/YJowbBiUp+Ckz89Q2zC2Jl7ghmfBwrFI9/o/RAA334TN9m+xPEAw+xnNPq+Irf
	 uiUgzCrDSG8UgTvex4hNjeDsXy1XmoHZ1TzrF1Bxkp0HqCjDRfUNZOcNf5Q3Y74nVM
	 +KjbWkS6f3xNXE8/RSHfhqAp0T7f5Ygxjl03IKE3uzu3qpABBVAdomsWwtKIaJCCqH
	 yzQ96Ik4myQSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AC85CCE09E1; Mon, 24 Jun 2024 05:54:23 -0700 (PDT)
Date: Mon, 24 Jun 2024 05:54:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org
Subject: Re: [linux-next:master] [rcutorture]  7a1fcbb52e:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
Message-ID: <29b7f19e-5407-44eb-9765-cdb3924c3764@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202406241652.e44865a0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406241652.e44865a0-lkp@intel.com>

On Mon, Jun 24, 2024 at 04:44:01PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> the config for this test is a randconfig. by this commit, the config has below
> diff between parent and this commit.
> 
> --- /pkg/linux/i386-randconfig-r022-20221003/gcc-13/d65635ebba92ee02e8284acfabbaf6b59ec0b5b6/.config    2024-06-23 23:24:45.203220229 +0800
> +++ /pkg/linux/i386-randconfig-r022-20221003/gcc-13/7a1fcbb52e611c49331bd66dd2da1efa4c0afef7/.config    2024-06-23 23:59:34.976722738 +0800
> @@ -133,7 +133,7 @@ CONFIG_IRQ_TIME_ACCOUNTING=y
>  CONFIG_TREE_RCU=y
>  CONFIG_PREEMPT_RCU=y
>  CONFIG_RCU_EXPERT=y
> -CONFIG_TREE_SRCU=y
> +CONFIG_TINY_SRCU=y
>  CONFIG_TASKS_RCU_GENERIC=y
>  CONFIG_FORCE_TASKS_RCU=y
>  CONFIG_NEED_TASKS_RCU=y
> 
> 
> we don't have enough knowledge how this diff impacts rcutorture test results,
> just FYI what we observed in our tests.
> 
> 
> kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]" on:
> 
> commit: 7a1fcbb52e611c49331bd66dd2da1efa4c0afef7 ("rcutorture: Add SRCU-V scenario for preemptible Tiny SRCU")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master f76698bd9a8ca01d3581236082d786e9a6b72bb7]
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: default
> 	torture_type: busted_srcud
> 
> 
> 
> compiler: gcc-13
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +-------------------------------------------------------------------------+------------+------------+
> |                                                                         | d65635ebba | 7a1fcbb52e |
> +-------------------------------------------------------------------------+------------+------------+
> | WARNING:suspicious_RCU_usage                                            | 6          | 6          |
> | kernel/rcu/rcutorture.c:#suspicious_rcu_dereference_check()usage        | 6          | 6          |
> | WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture] | 0          | 6          |
> | EIP:rcu_torture_stats_print                                             | 0          | 6          |
> +-------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202406241652.e44865a0-lkp@intel.com
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240624/202406241652.e44865a0-lkp@intel.com
> 
> 
> [   96.952168][  T436] busted_srcud-torture: !!! 

The "busted" in "busted_srcud" indicates that failure is expected.
So any torture_type containing "busted" is a test of rcutorture's ability
to find bugs.

							Thanx, Paul

> [   96.952253][  T436] ------------[ cut here ]------------
> [   96.954867][  T436] WARNING: CPU: 0 PID: 436 at kernel/rcu/rcutorture.c:2268 rcu_torture_stats_print+0x253/0x496 [rcutorture]
> [   96.956537][  T436] Modules linked in: rcutorture torture ppdev i6300esb rapl ipmi_devintf parport_pc bochs drm_vram_helper parport drm_ttm_helper ttm drm_kms_helper i2c_piix4 tiny_power_button ata_generic button fuse drm drm_panel_orientation_quirks i2c_core configfs
> [   96.959483][  T436] CPU: 0 PID: 436 Comm: rcu_torture_sta Not tainted 6.10.0-rc1-00067-g7a1fcbb52e61 #1
> [   96.960380][  T436] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   96.961355][  T436] EIP: rcu_torture_stats_print+0x253/0x496 [rcutorture]
> [   96.962139][  T436] Code: 85 c0 74 02 0f 0b 83 3d e4 17 59 ef 00 74 02 0f 0b 83 3d e0 17 59 ef 00 74 02 0f 0b 83 3d dc 17 59 ef 00 74 02 0f 0b 4b 7e 02 <0f> 0b 68 31 76 59 ef 31 db e8 40 11 54 de 5f 83 fb 0b 72 0c 89 da
> [   96.963988][  T436] EAX: 00000000 EBX: 00000003 ECX: ef597627 EDX: ef59762c
> [   96.964651][  T436] ESI: ef591994 EDI: 0000453c EBP: c6567f6c ESP: c6567eec
> [   96.965187][  T436] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010206
> [   96.965660][  T436] CR0: 80050033 CR2: b6b5f000 CR3: 04f71000 CR4: 00040690
> [   96.966172][  T436] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   96.966624][  T436] DR6: fffe0ff0 DR7: 00000400
> [   96.966924][  T436] Call Trace:
> [   96.967138][  T436]  ? show_regs+0x45/0x4b
> [   96.967415][  T436]  ? rcu_torture_stats_print+0x253/0x496 [rcutorture]
> [   96.967849][  T436]  ? __warn+0x7c/0x113
> [   96.968117][  T436]  ? report_bug+0xb3/0x111
> [   96.968406][  T436]  ? rcu_torture_stats_print+0x253/0x496 [rcutorture]
> [   96.968880][  T436]  ? exc_overflow+0x37/0x37
> [   96.969174][  T436]  ? handle_bug+0x2b/0x47
> [   96.969452][  T436]  ? exc_invalid_op+0x17/0x53
> [   96.969755][  T436]  ? handle_exception+0x100/0x100
> [   96.970141][  T436]  ? exc_overflow+0x37/0x37
> [   96.970434][  T436]  ? rcu_torture_stats_print+0x253/0x496 [rcutorture]
> [   96.970871][  T436]  ? exc_overflow+0x37/0x37
> [   96.971162][  T436]  ? rcu_torture_stats_print+0x253/0x496 [rcutorture]
> [   96.971599][  T436]  ? __timer_delete_sync+0x82/0x92
> [   96.971938][  T436]  rcu_torture_stats+0x3d/0x5e [rcutorture]
> [   96.972322][  T436]  kthread+0xdc/0xe1
> [   96.972575][  T436]  ? rcu_torture_stats_print+0x496/0x496 [rcutorture]
> [   96.973010][  T436]  ? kthread_park+0x62/0x62
> [   96.973302][  T436]  ret_from_fork+0x1c/0x2f
> [   96.973589][  T436]  ? kthread_park+0x62/0x62
> [   96.973879][  T436]  ret_from_fork_asm+0x12/0x18
> [   96.974230][  T436]  entry_INT80_32+0xef/0xef
> [   96.974519][  T436] irq event stamp: 535
> [   96.974777][  T436] hardirqs last  enabled at (543): [<cda8b4e9>] console_unlock+0x80/0xd4
> [   96.975183][  T436] hardirqs last disabled at (550): [<cda8b4cc>] console_unlock+0x63/0xd4
> [   96.975588][  T436] softirqs last  enabled at (104): [<cda4d6de>] handle_softirqs+0x2cf/0x2f9
> [   96.976007][  T436] softirqs last disabled at (97): [<ce313fce>] __do_softirq+0xa/0xc
> [   96.976392][  T436] ---[ end trace 0000000000000000 ]---
> [   96.999461][  T436] Reader Pipe:  1738294 6779 1992 57 1 0 0 0 0 0 0
> [   96.999803][  T436] busted_srcud-torture: Reader Batch:  1747123 0 0 0 0 0 0 0 0 0 0
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
