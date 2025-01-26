Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8A425A621;
	Sun, 26 Jan 2025 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917591; cv=none; b=aJL644YIL2vTQwqz0sVVtqz2Gp1sov7hQCthUMNzeD1O9WJVIV94hUTvX6xG5FxMOdneWatCmE45BHG46mJRYv1JYUw4DKBH+I7hZYfHqlj9QJcXFmme5EQgGOiZHpNDspIJLOyhLPk1N0Xa85azzN7I7s1vZJKFa7E1EGc7J4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917591; c=relaxed/simple;
	bh=V+GT8XzKog/vnQaxxK0bz7bk4OCjlPXqACVPw+mtgUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQaDArDJ9FU/DAp5qqGHzjUY2M726AVZ5nPPYHjgInnJPXZasTJH4lHyJ9Po0wT/yRZFwjeDeIxOa2GUwq10mQMau3t/it07+qnKZixLSMRlaq8NDoHqJG0I52DDW2tgwq6Cr38SWnkxtYtjMvJ/O7pI0SeKASAmxCGuam2TLyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP3ShDBg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP3ShDBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D055EC4CED3;
	Sun, 26 Jan 2025 18:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737917590;
	bh=V+GT8XzKog/vnQaxxK0bz7bk4OCjlPXqACVPw+mtgUM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cP3ShDBgrASGYrCKVPnjYyozpwsXm7SEpt8V/YrY2na3uexzf1TK51l1rniLQ49Y0
	 Lf04uQs+M4GJFOPl2OEtvh4030W3DS+v6y7YOfU2ey9q4Uxp5pB26Fxi6V49j8XBKU
	 1iFA6JI0Q3Hym7V9CiP1ewXTjN5q/R7JZHc85MEaAALCQqKZK3D/Llo8YsyGAwzRgu
	 pMU55joTeHyNdkgenVu01zXBdBzZ0Ag8c/DIa4F1nH90U+TpVFBOyuhCnvJ4Upzp6y
	 YoRgwXAhXeoGSb/tMPtJodyhEVvP9b0IgPwnfIC0AT759JKQnI5nykKXB0yL0JhPsX
	 4ivp8T/uDJ0/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6FC71CE0E40; Sun, 26 Jan 2025 10:53:10 -0800 (PST)
Date: Sun, 26 Jan 2025 10:53:10 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	boqun.feng@gmail.com
Subject: Re: [linus:master]  ec9d6356bf:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <c3c78483-f91f-45a1-b5c5-30df58b281bb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202501261429.c1f117d8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501261429.c1f117d8-lkp@intel.com>

On Sun, Jan 26, 2025 at 02:52:48PM +0800, kernel test robot wrote:
> 
> hi, Paul,
> 
> 
> when we reported
> "[paulmckrcu:dev.2024.12.11a] [rcutorture] 774c4d7adb: WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]"
> in
> https://lore.kernel.org/all/202412241458.150d082b-lkp@intel.com/
> 
> you mentioned the issue was fixed by an upate commit. you also mentioned
> you will change the new config to bool rather than tristate.
> 
> however, for this mainline commit, we still found same issue, and:
> 
> --- /pkg/linux/x86_64-randconfig-008-20250124/gcc-12/16338e7cb7450574ae3a210db6f35280fc44e50e/.config   2025-01-25 16:53:49.253595284 +0800
> +++ /pkg/linux/x86_64-randconfig-008-20250124/gcc-12/ec9d6356bfda69abe5f4767dd56c964127913233/.config   2025-01-25 16:13:38.156027983 +0800
> @@ -6713,6 +6713,7 @@ CONFIG_PROVE_RCU=y
>  CONFIG_TORTURE_TEST=m
>  CONFIG_RCU_SCALE_TEST=m
>  CONFIG_RCU_TORTURE_TEST=m
> +CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE=m
>  CONFIG_RCU_TORTURE_TEST_LOG_CPU=m
>  CONFIG_RCU_REF_SCALE_TEST=m
>  CONFIG_RCU_TRACE=y
> 
> 
> if the fix is already in some branches, could you let us know? thanks a lot!

This one is in my -rcu tree here:

1a457b5de837 ("rcutorture: Move RCU_TORTURE_TEST_{CHK_RDR_STATE,LOG_CPU} to bool")

It should arrive in -next shortly after the merge window closes.

							Thanx, Paul

> Hello,
> 
> kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]" on:
> 
> commit: ec9d6356bfda69abe5f4767dd56c964127913233 ("rcutorture: Make rcutorture_one_extend() check reader state")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      b46c89c08f4146e7987fc355941a93b12e2c03ef]
> [test failed on linux-next/master 5ffa57f6eecefababb8cbe327222ef171943b183]
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
> config: x86_64-randconfig-101-20250124
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +-----------------------------------------------------------------------------+------------+------------+
> |                                                                             | 16338e7cb7 | ec9d6356bf |
> +-----------------------------------------------------------------------------+------------+------------+
> | WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture] | 0          | 6          |
> | RIP:rcutorture_one_extend_check[rcutorture]                                 | 0          | 6          |
> +-----------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202501261429.c1f117d8-lkp@intel.com
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250126/202501261429.c1f117d8-lkp@intel.com
> 
> 
> [   40.293943][  T446] ------------[ cut here ]------------
> [   40.294385][  T446] rcutorture_one_extend_check during change: Current 0x10  To add 0x10  To remove 0x0
> [   40.294877][  T446] WARNING: CPU: 1 PID: 446 at kernel/rcu/rcutorture.c:1894 rcutorture_one_extend_check+0x3a7/0x400 [rcutorture]
> [   40.295434][  T446] Modules linked in: rcutorture torture ppdev parport_pc psmouse parport qemu_fw_cfg tiny_power_button fuse
> [   40.295991][  T446] CPU: 1 UID: 0 PID: 446 Comm: rcu_torture_rea Not tainted 6.13.0-rc2-00011-gec9d6356bfda #1 abb71fe25d0aa7643c018e6d943fff3236ed9aa5
> [   40.296634][  T446] RIP: 0010:rcutorture_one_extend_check+0x3a7/0x400 [rcutorture]
> [   40.296999][  T446] Code: fd ff ff 44 8b 45 cc 48 8b 55 d0 45 89 f9 89 d9 48 c7 c6 40 39 2a a0 48 c7 c7 00 e8 29 a0 c6 05 8b bf 1e 00 01 e8 99 a9 1b e1 <0f> 0b e9 a1 fd ff ff e8 cd 16 89 e1 e9 29 fd ff ff 48 89 45 c0 e8
> [   40.297896][  T446] RSP: 0018:ffff888135f4fa30 EFLAGS: 00210282
> [   40.298184][  T446] RAX: dffffc0000000000 RBX: 0000000000000010 RCX: 0000000000000027
> [   40.298555][  T446] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff8883aede8608
> [   40.298927][  T446] RBP: ffff888135f4fa70 R08: 0000000000000001 R09: ffffed1075dbd0c1
> [   40.299298][  T446] R10: ffff8883aede860b R11: 0000000000000001 R12: ffffffffa02765c0
> [   40.299669][  T446] R13: 0000000000000010 R14: 0000000000000000 R15: 0000000000000000
> [   40.300038][  T446] FS:  0000000000000000(0000) GS:ffff8883aec00000(0000) knlGS:0000000000000000
> [   40.300458][  T446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   40.300768][  T446] CR2: 000000005badf000 CR3: 0000000144a4d000 CR4: 00000000000406b0
> [   40.301141][  T446] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   40.301514][  T446] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   40.301885][  T446] Call Trace:
> [   40.302045][  T446]  <TASK>
> [   40.302188][  T446]  ? show_regs+0x5e/0x80
> [   40.302405][  T446]  ? __warn+0xd7/0x1c0
> [   40.302602][  T446]  ? find_bug+0x21c/0x340
> [   40.302810][  T446]  ? rcutorture_one_extend_check+0x3a7/0x400 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.303310][  T446]  ? report_bug+0x283/0x300
> [   40.303535][  T446]  ? handle_bug+0x57/0xc0
> [   40.303743][  T446]  ? exc_invalid_op+0x25/0x80
> [   40.304012][  T446]  ? asm_exc_invalid_op+0x1f/0x40
> [   40.304425][  T446]  ? rcutorture_one_extend_check+0x3a7/0x400 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.305544][  T446]  rcutorture_one_extend+0x1db/0x900 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.306488][  T446]  ? rcutorture_one_extend+0x449/0x900 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.307662][  T446]  rcu_torture_one_read+0x115/0xdc0 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.308683][  T446]  ? rcu_torture_writer+0x1ec0/0x1ec0 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.309705][  T446]  ? __lock_release+0x3c9/0xa40
> [   40.310313][  T446]  ? __kasan_check_read+0x15/0x40
> [   40.310824][  T446]  rcu_torture_reader+0x1ee/0x580 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.311540][  T446]  ? rcu_torture_read_exit_child+0x80/0x80 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.312334][  T446]  ? rcu_torture_one_read+0xdc0/0xdc0 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.315285][  T446]  ? __kthread_parkme+0xd4/0x200
> [   40.316172][  T446]  ? schedule+0x103/0x240
> [   40.316736][  T446]  ? rcu_torture_read_exit_child+0x80/0x80 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.318152][  T446]  kthread+0x2e8/0x400
> [   40.318839][  T446]  ? kthread_insert_work_sanity_check+0x100/0x100
> [   40.319716][  T446]  ret_from_fork+0x47/0x80
> [   40.320497][  T446]  ? kthread_insert_work_sanity_check+0x100/0x100
> [   40.321402][  T446]  ret_from_fork_asm+0x11/0x40
> [   40.322101][  T446]  </TASK>
> [   40.322645][  T446] irq event stamp: 529
> [   40.323346][  T446] hardirqs last  enabled at (537): [<ffffffff814218a0>] __up_console_sem+0x60/0xc0
> [   40.324776][  T446] hardirqs last disabled at (546): [<ffffffff81421885>] __up_console_sem+0x45/0xc0
> [   40.326112][  T446] softirqs last  enabled at (454): [<ffffffff8126e8c2>] handle_softirqs+0x382/0x680
> [   40.327504][  T446] softirqs last disabled at (427): [<ffffffff8126ee65>] __irq_exit_rcu+0x225/0x300
> [   40.328894][  T446] ---[ end trace 0000000000000000 ]---
> [   40.329677][  T446] ------------[ cut here ]------------
> [   40.330463][  T446] rcutorture_one_extend_check during change: Current 0x21  To add 0x20  To remove 0x1
> [   40.331868][  T446] WARNING: CPU: 1 PID: 446 at kernel/rcu/rcutorture.c:1891 rcutorture_one_extend_check+0x2e5/0x400 [rcutorture]
> [   40.333494][  T446] Modules linked in: rcutorture torture ppdev parport_pc psmouse parport qemu_fw_cfg tiny_power_button fuse
> [   40.335162][  T446] CPU: 1 UID: 0 PID: 446 Comm: rcu_torture_rea Tainted: G        W          6.13.0-rc2-00011-gec9d6356bfda #1 abb71fe25d0aa7643c018e6d943fff3236ed9aa5
> [   40.337033][  T446] Tainted: [W]=WARN
> [   40.337379][  T446] RIP: 0010:rcutorture_one_extend_check+0x2e5/0x400 [rcutorture]
> [   40.338233][  T446] Code: fe ff ff 44 8b 45 cc 48 8b 55 d0 45 89 f9 89 d9 48 c7 c6 40 39 2a a0 48 c7 c7 00 e8 29 a0 c6 05 4e c0 1e 00 01 e8 5b aa 1b e1 <0f> 0b 4c 8b 25 d2 cd 1e 00 e9 16 fe ff ff 65 8b 0d 0e 20 16 60 80
> [   40.340181][  T446] RSP: 0018:ffff888135f4fa30 EFLAGS: 00210202
> [   40.340801][  T446] RAX: dffffc0000000000 RBX: 0000000000000021 RCX: 0000000000000027
> [   40.341593][  T446] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff8883aede8608
> [   40.342450][  T446] RBP: ffff888135f4fa70 R08: 0000000000000001 R09: ffffed1075dbd0c1
> [   40.343224][  T446] R10: ffff8883aede860b R11: 0000000000000001 R12: ffffffffa02765c0
> [   40.344194][  T446] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
> [   40.344957][  T446] FS:  0000000000000000(0000) GS:ffff8883aec00000(0000) knlGS:0000000000000000
> [   40.345882][  T446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   40.346613][  T446] CR2: 000000005badf000 CR3: 0000000144a4d000 CR4: 00000000000406b0
> [   40.347361][  T446] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   40.348310][  T446] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   40.349123][  T446] Call Trace:
> [   40.349494][  T446]  <TASK>
> [   40.349737][  T446]  ? show_regs+0x5e/0x80
> [   40.350219][  T446]  ? __warn+0xd7/0x1c0
> [   40.350595][  T446]  ? find_bug+0x21c/0x340
> [   40.351102][  T446]  ? rcutorture_one_extend_check+0x2e5/0x400 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.352185][  T446]  ? report_bug+0x283/0x300
> [   40.352703][  T446]  ? handle_bug+0x57/0xc0
> [   40.353146][  T446]  ? exc_invalid_op+0x25/0x80
> [   40.353636][  T446]  ? asm_exc_invalid_op+0x1f/0x40
> [   40.354206][  T446]  ? rcutorture_one_extend_check+0x2e5/0x400 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.355352][  T446]  rcutorture_one_extend+0x1db/0x900 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.356304][  T446]  ? rcu_torture_reader_do_mbchk+0xb2/0x700 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.357502][  T446]  rcu_torture_one_read+0x35c/0xdc0 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.358505][  T446]  ? rcu_torture_writer+0x1ec0/0x1ec0 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.359614][  T446]  ? __lock_release+0x3c9/0xa40
> [   40.360167][  T446]  ? __kasan_check_read+0x15/0x40
> [   40.360697][  T446]  rcu_torture_reader+0x1ee/0x580 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.361667][  T446]  ? rcu_torture_read_exit_child+0x80/0x80 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.362774][  T446]  ? rcu_torture_one_read+0xdc0/0xdc0 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.363814][  T446]  ? __kthread_parkme+0xd4/0x200
> [   40.364352][  T446]  ? schedule+0x103/0x240
> [   40.364810][  T446]  ? rcu_torture_read_exit_child+0x80/0x80 [rcutorture c508f5fe1e6971aed175eb31b7e0d0b5c084573e]
> [   40.365951][  T446]  kthread+0x2e8/0x400
> [   40.366377][  T446]  ? kthread_insert_work_sanity_check+0x100/0x100
> [   40.367037][  T446]  ret_from_fork+0x47/0x80
> [   40.367473][  T446]  ? kthread_insert_work_sanity_check+0x100/0x100
> [   40.368198][  T446]  ret_from_fork_asm+0x11/0x40
> [   40.368737][  T446]  </TASK>
> [   40.369055][  T446] irq event stamp: 1040
> [   40.369505][  T446] hardirqs last  enabled at (1048): [<ffffffff814218a0>] __up_console_sem+0x60/0xc0
> [   40.370496][  T446] hardirqs last disabled at (1055): [<ffffffff81421885>] __up_console_sem+0x45/0xc0
> [   40.371445][  T446] softirqs last  enabled at (454): [<ffffffff8126e8c2>] handle_softirqs+0x382/0x680
> [   40.372543][  T446] softirqs last disabled at (581): [<ffffffffa00a01d5>] rcutorture_one_extend+0x515/0x900 [rcutorture]
> [   40.373688][  T446] ---[ end trace 0000000000000000 ]---
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
