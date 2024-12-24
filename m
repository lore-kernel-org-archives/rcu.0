Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1552770C;
	Tue, 24 Dec 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735063040; cv=none; b=UbYbW3hif+NnjTw4/jSX2DQL7lyk6AMPT3wJJXN0jOWMSkbFdat8iQfyX1ojgLkMP4ttqxr7occRcLoD9qBQiaAiYNagNssUVXhJO5yiRVYy7uWCGiMnlmyvz4MPml4r21usWF87DElFkILYmev/cF3umygMe55eqXGcScCRxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735063040; c=relaxed/simple;
	bh=C4da4NxgxvpJu643OKJ2RKPv5EuhtZOStd/foumNWRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxrFGUV/1m4Ox72d6/j11QE/K5dFr6whyvpCdJ/Gr7bPO4ugrVJJNFUNe2cyWyZud6C1IfGujDMCJy7TCe7ybqBUQEWSgPDRFVYnQORdf/Y6yS9q39Q7GU1VAJcdAIGbShQLzbikANFrIDZa4rNVQY0dhV7GVYs02+r9p8ON34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrvOuwKV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrvOuwKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA94C4CED0;
	Tue, 24 Dec 2024 17:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735063036;
	bh=C4da4NxgxvpJu643OKJ2RKPv5EuhtZOStd/foumNWRI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=IrvOuwKVyFi51mUJqosFezU/Nw9dqz5v5zVAcIzuIZQA9q6Dr58+swuZ9mgoyE6AV
	 g3cnQtH0TJ3uHKSIAAKnA90Q2Xa3rqbbZYTStGJkEeZiBs1YlnN0R2RN3jKsn6Q4WO
	 Xsfo7JJIIOHvHDIPYXmruebmu/jWjMHQpPCDK48e0M9CtYHRqmfr1ld0PXgwdN72sO
	 HjkWQsX+sToliMeZKTBrN1uxBfjxbp51ABxpimlg6wqbvnaSFAOeKOPuTW2+Lk6AgP
	 WcQk9URdqZsdm64xIuf3kzZlywHPamrZn1gDIK1R/PFcEujzw/MhH6YwCczM3e6SQc
	 ngA+7sqN9evpg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 65C34CE0A32; Tue, 24 Dec 2024 09:57:16 -0800 (PST)
Date: Tue, 24 Dec 2024 09:57:16 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2024.12.11a] [rcutorture] 774c4d7adb:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <4062c4c8-50c0-4f49-b985-8b59331b8bb3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202412241458.150d082b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412241458.150d082b-lkp@intel.com>

On Tue, Dec 24, 2024 at 02:48:26PM +0800, kernel test robot wrote:
> 
> hi, Paul,
> 
> we noticed there is similar commit in newer branches:
>   dev.2024.12.11b
>   dev.2024.12.12a
>   dev.2024.12.13a
> 
> if this is out-of-date version, please just ignore.
> 
> the new config is enabled in our tests.
> ==================== PARENT FIRST_BAD KCONFIGS bb02a67f70d8d58c675403f1f716cf5885967918 ====================
> --- /pkg/linux/i386-randconfig-001-20241220/clang-19/bb02a67f70d8d58c675403f1f716cf5885967918/.config   2024-12-23 12:46:05.807021581 +0800
> +++ /pkg/linux/i386-randconfig-001-20241220/clang-19/774c4d7adb4f9134aa265c5fee4e8b07d98c53cb/.config   2024-12-23 14:26:59.938500419 +0800
> @@ -5864,6 +5864,7 @@ CONFIG_PROVE_RCU=y
>  CONFIG_TORTURE_TEST=m
>  CONFIG_RCU_SCALE_TEST=m
>  CONFIG_RCU_TORTURE_TEST=m
> +CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE=m
>  # CONFIG_RCU_TORTURE_TEST_LOG_CPU is not set
>  CONFIG_RCU_REF_SCALE_TEST=m
>  CONFIG_RCU_CPU_STALL_TIMEOUT=21
> 
> 
> and since the WARN added in this commit is hit, we just make below report FYI.

This one is a bug that has since been fixed.  The condition:

	cur_ops->readlock_nesting() > 0

Now reads:

	cur_ops->readlock_nesting() == 0

The updated commit is:

14f8cc687ce6 ("rcutorture: Make rcutorture_one_extend() check reader state")

However, your Kconfig above does in fact show a bug.  It is supposed
to be bool rather than tristate.  I will fix with your Reported-by.

							Thanx, Paul

> Hello,
> 
> kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]" on:
> 
> commit: 774c4d7adb4f9134aa265c5fee4e8b07d98c53cb ("rcutorture: Make rcutorture_one_extend() check reader state")
> https://github.com/paulmckrcu/linux dev.2024.12.11a
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: cpuhotplug
> 	torture_type: rcu
> 
> 
> 
> config: i386-randconfig-001-20241220
> compiler: clang-19
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +-----------------------------------------------------------------------------+------------+------------+
> |                                                                             | bb02a67f70 | 774c4d7adb |
> +-----------------------------------------------------------------------------+------------+------------+
> | WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture] | 0          | 6          |
> | EIP:rcutorture_one_extend_check                                             | 0          | 6          |
> +-----------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202412241458.150d082b-lkp@intel.com
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241224/202412241458.150d082b-lkp@intel.com
> 
> 
> [  216.715283][  T904] ------------[ cut here ]------------
> [  216.715807][  T904] rcutorture_one_extend_check during change: Current 0x10  To add 0x10  To remove 0x0
> [  216.716750][  T904] WARNING: CPU: 0 PID: 904 at kernel/rcu/rcutorture.c:1907 rcutorture_one_extend_check+0x1da/0x2a0 [rcutorture]
> [  216.717867][  T904] Modules linked in: rcutorture(+) torture
> [  216.718418][  T904] CPU: 0 UID: 0 PID: 904 Comm: rcu_torture_rea Not tainted 6.13.0-rc1-00040-g774c4d7adb4f #1 af41ae9ed56f032bf259b1a5e19207f049febebf
> [  216.719655][  T904] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  216.720591][  T904] EIP: rcutorture_one_extend_check+0x1da/0x2a0 [rcutorture]
> [  216.721316][  T904] Code: 33 e9 88 f0 01 0f 85 19 ff ff ff c6 05 33 e9 88 f0 01 ff 75 0c 57 53 56 68 f0 70 90 f0 68 f8 7b 90 f0 e8 a9 ac 81 50 83 c4 18 <0f> 0b e9 f3 fe ff ff c6 05 2e e9 88 f0 01 ff 75 0c 57 53 56 68 f0
> [  216.723166][  T904] EAX: 00000000 EBX: 00000010 ECX: 00000000 EDX: 00000000
> [  216.723887][  T904] ESI: f090673c EDI: 00000010 EBP: bfba7d84 ESP: bfba7d70
> [  216.724539][  T904] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010292
> [  216.725236][  T904] CR0: 80050033 CR2: 37270010 CR3: 7a10e000 CR4: 000406d0
> [  216.725919][  T904] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  216.726581][  T904] DR6: fffe0ff0 DR7: 00000400
> [  216.727015][  T904] Call Trace:
> [  216.727325][  T904]  ? show_regs+0x5e/0x70
> [  216.727761][  T904]  ? rcutorture_one_extend_check+0x1da/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.728747][  T904]  ? __warn+0xbc/0x230
> [  216.729128][  T904]  ? rcutorture_one_extend_check+0x1da/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.730100][  T904]  ? rcutorture_one_extend_check+0x1da/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.731092][  T904]  ? report_bug+0xb8/0x170
> [  216.731558][  T904]  ? exc_overflow+0x40/0x40
> [  216.732002][  T904]  ? handle_bug+0x49/0x70
> [  216.732431][  T904]  ? exc_invalid_op+0x24/0x50
> [  216.732855][  T904]  ? handle_exception+0x14d/0x14d
> [  216.733294][  T904]  ? __pr_flush+0x4b/0x390
> [  216.733842][  T904]  ? exc_overflow+0x40/0x40
> [  216.734283][  T904]  ? rcutorture_one_extend_check+0x1da/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.735278][  T904]  ? exc_overflow+0x40/0x40
> [  216.735710][  T904]  ? rcutorture_one_extend_check+0x1da/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.736707][  T904]  rcutorture_one_extend+0x185/0x3d0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.737663][  T904]  rcu_torture_one_read+0xbc/0x7b0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.738651][  T904]  ? __mod_timer+0x27e/0x330
> [  216.746584][  T904]  rcu_torture_reader+0xd9/0x1a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.749179][  T904]  ? rcu_torture_boost_failed+0x200/0x200 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.751803][  T904]  ? __kthread_parkme+0x41/0x90
> [  216.752973][  T904]  kthread+0xda/0xf0
> [  216.753996][  T904]  ? rcu_torture_fakewriter+0x3f0/0x3f0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.756499][  T904]  ? kthreadd+0x120/0x120
> [  216.757734][  T904]  ? kthreadd+0x120/0x120
> [  216.758682][  T904]  ret_from_fork+0x2c/0x40
> [  216.759952][  T904]  ret_from_fork_asm+0x12/0x20
> [  216.761040][  T904]  entry_INT80_32+0x10d/0x10d
> [  216.762389][  T904] irq event stamp: 515
> [  216.763447][  T904] hardirqs last  enabled at (525): [<4111f4ef>] __console_unlock+0x5f/0x90
> [  216.767137][  T904] hardirqs last disabled at (542): [<4111f4d6>] __console_unlock+0x46/0x90
> [  216.769278][  T904] softirqs last  enabled at (538): [<429843ea>] __do_softirq+0xa/0xe
> [  216.771284][  T904] softirqs last disabled at (533): [<429843ea>] __do_softirq+0xa/0xe
> [  216.773548][  T904] ---[ end trace 0000000000000000 ]---
> [  216.774848][  T904] ------------[ cut here ]------------
> [  216.776416][  T904] rcutorture_one_extend_check after change: Current 0x20  To add 0x20  To remove 0x4
> [  216.778844][  T904] WARNING: CPU: 0 PID: 904 at kernel/rcu/rcutorture.c:1904 rcutorture_one_extend_check+0x286/0x2a0 [rcutorture]
> [  216.781764][  T904] Modules linked in: rcutorture(+) torture
> [  216.783330][  T904] CPU: 0 UID: 0 PID: 904 Comm: rcu_torture_rea Tainted: G        W          6.13.0-rc1-00040-g774c4d7adb4f #1 af41ae9ed56f032bf259b1a5e19207f049febebf
> [  216.787364][  T904] Tainted: [W]=WARN
> [  216.787735][  T904] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  216.788655][  T904] EIP: rcutorture_one_extend_check+0x286/0x2a0 [rcutorture]
> [  216.789311][  T904] Code: 0f 84 12 ff ff ff e9 29 ff ff ff c6 05 32 e9 88 f0 01 ff 75 0c 57 53 56 68 f0 70 90 f0 68 f8 7b 90 f0 e8 fd ab 81 50 83 c4 18 <0f> 0b a1 14 a4 88 f0 e9 fe fe ff ff 00 00 00 00 00 00 00 00 00 00
> [  216.791093][  T904] EAX: 00000000 EBX: 00000020 ECX: 00000000 EDX: 00000000
> [  216.791732][  T904] ESI: f0905abc EDI: 00000020 EBP: bfba7d84 ESP: bfba7d70
> [  216.792366][  T904] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010292
> [  216.793054][  T904] CR0: 80050033 CR2: 37270010 CR3: 7a10e000 CR4: 000406d0
> [  216.793757][  T904] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  216.794425][  T904] DR6: fffe0ff0 DR7: 00000400
> [  216.794908][  T904] Call Trace:
> [  216.795233][  T904]  ? show_regs+0x5e/0x70
> [  216.795648][  T904]  ? rcutorture_one_extend_check+0x286/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.796617][  T904]  ? __warn+0xbc/0x230
> [  216.796983][  T904]  ? rcutorture_one_extend_check+0x286/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.797941][  T904]  ? rcutorture_one_extend_check+0x286/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.798994][  T904]  ? report_bug+0xb8/0x170
> [  216.799451][  T904]  ? exc_overflow+0x40/0x40
> [  216.799891][  T904]  ? handle_bug+0x49/0x70
> [  216.800322][  T904]  ? exc_invalid_op+0x24/0x50
> [  216.800793][  T904]  ? handle_exception+0x14d/0x14d
> [  216.801272][  T904]  ? __pr_flush+0x4b/0x390
> [  216.801697][  T904]  ? exc_overflow+0x40/0x40
> [  216.802126][  T904]  ? rcutorture_one_extend_check+0x286/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.803118][  T904]  ? exc_overflow+0x40/0x40
> [  216.803584][  T904]  ? rcutorture_one_extend_check+0x286/0x2a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.804577][  T904]  rcutorture_one_extend+0x382/0x3d0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.805520][  T904]  rcu_torture_one_read+0x30d/0x7b0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.806431][  T904]  rcu_torture_reader+0xd9/0x1a0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.807392][  T904]  ? rcu_torture_boost_failed+0x200/0x200 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.808371][  T904]  ? __kthread_parkme+0x41/0x90
> [  216.808823][  T904]  kthread+0xda/0xf0
> [  216.809198][  T904]  ? rcu_torture_fakewriter+0x3f0/0x3f0 [rcutorture 87513a79026a2b3af3a53e104b445ea32d45b3a4]
> [  216.810157][  T904]  ? kthreadd+0x120/0x120
> [  216.810574][  T904]  ? kthreadd+0x120/0x120
> [  216.810983][  T904]  ret_from_fork+0x2c/0x40
> [  216.811391][  T904]  ret_from_fork_asm+0x12/0x20
> [  216.811834][  T904]  entry_INT80_32+0x10d/0x10d
> [  216.812322][  T904] irq event stamp: 1041
> [  216.812701][  T904] hardirqs last  enabled at (1051): [<4111f4ef>] __console_unlock+0x5f/0x90
> [  216.813568][  T904] hardirqs last disabled at (1072): [<4111f4d6>] __console_unlock+0x46/0x90
> [  216.814320][  T904] softirqs last  enabled at (1070): [<429843ea>] __do_softirq+0xa/0xe
> [  216.815071][  T904] softirqs last disabled at (1061): [<429843ea>] __do_softirq+0xa/0xe
> [  216.815802][  T904] ---[ end trace 0000000000000000 ]---
> [  216.817430][  T889] rcu-torture: Creating torture_shuffle task
> [  216.818829][  T889] rcu-torture: Creating torture_stutter task
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
