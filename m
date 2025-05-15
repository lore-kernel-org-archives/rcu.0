Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7F819F489;
	Thu, 15 May 2025 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317496; cv=none; b=urVWDLeytgbXXtJMEQMvOgwvZCLCirHyp9tgzoQ5wNPHprVYZFqs3J3B6wkJ5MCW3KA5jF7NkxSr0w63yuxmcgoDYxtpqa7oZvvV63gwMuEVvw4MS9uNaHYvKRrv8Zbexy0eHZ1kXz+bOd8cEj7SO1dm11IT77KeNhk2v0HyzxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317496; c=relaxed/simple;
	bh=iGC3A00abQtSmUSrSTcaYCDSY+aKfhFj4Vx6iBL0fag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmfEPS5MghXnSgE+Wd02ghhapTKC9RhzfDeJ29kIlidL99s34ULUBAeUUigq7eTLC3u4+myebB7e7lKb+e+gJzimv63fVRFO+jKlMGuhQo2smJs6hj6AwE1fojTirQLuQ4kvpMVG12ewEtrn1B1YRowG0KbY1+ErXC/VAm5GwYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6JJ6qBG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6JJ6qBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F2EC4CEE7;
	Thu, 15 May 2025 13:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747317496;
	bh=iGC3A00abQtSmUSrSTcaYCDSY+aKfhFj4Vx6iBL0fag=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=m6JJ6qBG38Mj3SQtzW1yXTIJjPVTucR+YJtoFOeAcoqczd/bB+1jR0f+sry+L6w/6
	 8ZtbIrZ5Wqq9NEJE1Pv6skWKL1Ul1hFtx1IRWfuEAievw4qoWj1ugi1wF8/nxhUbmN
	 FXaIsFuu0FGCVE+c92nW/CrmB6Y2l4X1PbepeW+jmo8hDgpHdvDM2fFdswKhNAnM51
	 KwooC6gmGbInzYSwcPTRhz+r5oAD2ZA7bh4m/F7FBBnK2UAsHNtSiqHiT7CKEhvzAh
	 rUn8eiM4jzCkK2u84CQG0CYGabBOfoOYcY48aNTPHVvk05Fv+l2s/FhIfSpKMmOnCB
	 lVZxYVh/pOGRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 56E44CE08FE; Thu, 15 May 2025 06:58:16 -0700 (PDT)
Date: Thu, 15 May 2025 06:58:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [linux-next:master] [rcutorture]  c27d0d38f2:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <0ceeb2a7-fe6e-47bc-9071-5ac7ef9a2792@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202505140917.8ee62cc6-lkp@intel.com>
 <5e4444fb-0c27-4f7c-acbe-e62367f5ed37@paulmck-laptop>
 <aCVRqvPSZLVaVwmR@xsang-OptiPlex-9020>
 <cd1ee5a5-73f8-450b-b5be-7f5498e02d78@paulmck-laptop>
 <aCWpr2vIdLxIk6vc@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCWpr2vIdLxIk6vc@xsang-OptiPlex-9020>

On Thu, May 15, 2025 at 04:45:35PM +0800, Oliver Sang wrote:
> hi, Paul,
> 
> On Wed, May 14, 2025 at 09:18:10PM -0700, Paul E. McKenney wrote:
> > On Thu, May 15, 2025 at 10:30:02AM +0800, Oliver Sang wrote:
> > > hi, Paul,
> > > 
> > > On Wed, May 14, 2025 at 11:26:34AM -0700, Paul E. McKenney wrote:
> > > > On Wed, May 14, 2025 at 10:47:30AM +0800, kernel test robot wrote:
> > > > > 
> > > > > hi, Paul,
> > > > > 
> > > > > for this commit we tested before, now we found it causes issues in linux-next
> > > > > master branch.
> > > > 
> > > > Good catch as always!!!  Yes, using HRTIMER_MODE_HARD means that this
> > > > ircutorture_one_extend_check() function must check for hardirq as well
> > > > as softirq.  Which, oddly enough, permits simplifying the code, though
> > > > a larger patch.
> > > > 
> > > > I could reproduce this, and the patch at the end of this email fixes it
> > > > for me.  Does it work for you as well?
> > > 
> > > thanks a lot for information!
> > > 
> > > what's the base of the patch? I tried to apply it upon c27d0d38f2 or lastest
> > > linux-next/master
> > > bdd609656ff55 (tag: next-20250514, linux-next/master) Add linux-next specific files for 20250514
> > > 
> > > both failed. thanks
> > 
> > Apologies, I just now pushed it out on my -rcu tree:
> > 
> > db950fccd45a ("rcutorture: Make rcutorture_one_extend_check() account for hardirq")
> 
> issue is cleaned on db950fccd45a. thanks!
> 
> Tested-by: kernel test robot <oliver.sang@intel.com>

I will apply on my next rebase, and once again thank you for your testing!

							Thanx, Paul

> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
>   clang-20/i386-randconfig-141-20250508/debian-11.1-i386-20220923.cgz/300s/vm-snb/cpuhotplug/rcutorture/srcud
> 
> commit:
>   8454f1334b167 ("lib: Make the ratelimit test more reliable")
>   db950fccd45a8 ("rcutorture: Make rcutorture_one_extend_check() account for hardirq")
> 
> 8454f1334b167506 db950fccd45a8273d93ca861d84
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>           1:50          -2%            :50    dmesg.EIP:__x86_return_thunk
>           1:50          -2%            :50    dmesg.EIP:console_trylock_spinning
>          48:50         -96%            :50    dmesg.EIP:pv_native_safe_halt
>          50:50        -100%            :50    dmesg.EIP:rcutorture_one_extend_check
>          50:50        -100%            :50    dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
> 
> > 
> > I will need to rebase this to precede the updated version of the commit
> > that you tested, but one step at a time...
> > 
> > 							Thanx, Paul
> > 
> > > > > =========================================================================================
> > > > > tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/torture_type:
> > > > >   vm-snb/rcutorture/debian-11.1-i386-20220923.cgz/i386-randconfig-141-20250508/clang-20/300s/cpuhotplug/srcud
> > > > > 
> > > > > c795676b5c0a4ab7 c27d0d38f2cafb70a68ca42c410
> > > > > ---------------- ---------------------------
> > > > >        fail:runs  %reproduction    fail:runs
> > > > >            |             |             |
> > > > >            :50           2%           1:50    dmesg.EIP:__kernel_text_address
> > > > >            :50           4%           2:50    dmesg.EIP:__srcu_check_read_flavor
> > > > >            :50           2%           1:50    dmesg.EIP:_raw_spin_unlock_irq
> > > > >            :50          14%           7:50    dmesg.EIP:_raw_spin_unlock_irqrestore
> > > > >            :50          30%          15:50    dmesg.EIP:console_flush_all
> > > > >            :50           4%           2:50    dmesg.EIP:console_trylock_spinning
> > > > >            :50           2%           1:50    dmesg.EIP:delay_tsc
> > > > >            :50           2%           1:50    dmesg.EIP:finish_lock_switch
> > > > >            :50           2%           1:50    dmesg.EIP:kernel_text_address
> > > > >            :50           2%           1:50    dmesg.EIP:lock_acquire
> > > > >            :50          36%          18:50    dmesg.EIP:pv_native_safe_halt
> > > > >           1:50          -2%            :50    dmesg.EIP:rcu_torture_fwd_prog_cr
> > > > >           7:50         -14%            :50    dmesg.EIP:rcu_torture_writer
> > > > >            :50         100%          50:50    dmesg.EIP:rcutorture_one_extend_check
> > > > >          48:50           0%          48:50    dmesg.INFO:task_blocked_for_more_than#seconds
> > > > >          48:50           0%          48:50    dmesg.Kernel_panic-not_syncing:hung_task:blocked_tasks
> > > > >          50:50           0%          50:50    dmesg.UBSAN:negation-overflow_in_lib/sort.c
> > > > >           1:50          -2%            :50    dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog_cr[rcutorture]
> > > > >           7:50         -14%            :50    dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_writer[rcutorture]
> > > > >            :50         100%          50:50    dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]   <--- (1)
> > > > >           7:50         -14%            :50    dmesg.calltrace:__do_softirq
> > > > >           1:50          -2%            :50    dmesg.calltrace:rcu_torture_pipe_update
> > > > > 
> > > > > though both c27d0d38f2/parent have various issues, it seems (1) is persistent
> > > > > on c27d0d38f2 and clean on parent.
> > > > > 
> > > > > 
> > > > > Hello,
> > > > > 
> > > > > kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]" on:
> > > > > 
> > > > > commit: c27d0d38f2cafb70a68ca42c4105e170862aaf77 ("rcutorture: Complain if an ->up_read() is delayed more than 10 seconds")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > > 
> > > > > [test failed on linux-next/master f48887a98b78880b7711aca311fbbbcaad6c4e3b]
> > > > > 
> > > > > in testcase: rcutorture
> > > > > version: 
> > > > > with following parameters:
> > > > > 
> > > > > 	runtime: 300s
> > > > > 	test: cpuhotplug
> > > > > 	torture_type: srcud
> > > > > 
> > > > > 
> > > > > 
> > > > > config: i386-randconfig-141-20250508
> > > > > compiler: clang-20
> > > > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > > > 
> > > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > > > 
> > > > > 
> > > > > 
> > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > | Closes: https://lore.kernel.org/oe-lkp/202505140917.8ee62cc6-lkp@intel.com
> > > > > 
> > > > > 
> > > > > The kernel config and materials to reproduce are available at:
> > > > > https://download.01.org/0day-ci/archive/20250514/202505140917.8ee62cc6-lkp@intel.com
> > > > > 
> > > > > 
> > > > > [   76.027193][    C1] ------------[ cut here ]------------
> > > > > [   76.027652][  T661] srcud-torture: rcu_torture_stats task started
> > > > > [   76.027754][    C1] rcutorture_one_extend_check before change: Current 0x80  To add 0x0  To remove 0x80  preempt_count() 0x10001
> > > > > [   76.029893][    C1] WARNING: CPU: 1 PID: 2 at kernel/rcu/rcutorture.c:1976 rcutorture_one_extend_check+0x5b/0x300 [rcutorture]
> > > > > [   76.031093][    C1] Modules linked in: rcutorture(+) torture
> > > > > [   76.031736][    C1] CPU: 1 UID: 0 PID: 2 Comm: kthreadd Tainted: G                T   6.15.0-rc1-00008-gc27d0d38f2ca #1 PREEMPT(full)  4c3e2c742772c0895467dcaa42b0aab115cc2926
> > > > > [   76.033194][    C1] Tainted: [T]=RANDSTRUCT
> > > > > [   76.033728][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > > > [   76.034602][    C1] EIP: rcutorture_one_extend_check+0x5b/0x300 [rcutorture]
> > > > > [   76.035319][    C1] Code: 05 68 e2 69 f0 01 64 a1 0c f0 b4 c3 25 ff ff ff 7f 50 ff 75 0c 57 53 56 68 e3 c9 6a f0 68 19 b5 6a f0 e8 b8 c8 96 d0 83 c4 1c <0f> 0b f6 c3 09 75 1d eb 35 9c 8f 45 ec f7 45 ec 00 02 00 00 74 09
> > > > > [   76.037024][    C1] EAX: 0000006c EBX: 00000080 ECX: 00000027 EDX: 00000000
> > > > > [   76.037760][    C1] ESI: f06ad951 EDI: 00000000 EBP: c7f19da0 ESP: c7f19d8c
> > > > > [   76.038490][    C1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010082
> > > > > [   76.039252][    C1] CR0: 80050033 CR2: b7e17eb0 CR3: 08be7000 CR4: 00040690
> > > > > [   76.039989][    C1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > > > > [   76.040713][    C1] DR6: fffe0ff0 DR7: 00000400
> > > > > [   76.041313][    C1] Call Trace:
> > > > > [   76.041825][    C1]  rcutorture_one_extend+0x54/0x4b0 [rcutorture 4a4a34e515cdd0c53b2c18de8a71945278e82895]
> > > > > [   76.042705][    C1]  ? lock_acquire+0xa8/0x1c0
> > > > > [   76.043299][    C1]  rcu_torture_one_read_end+0x1b7/0x350 [rcutorture 4a4a34e515cdd0c53b2c18de8a71945278e82895]
> > > > > [   76.044196][    C1]  ? local_bh_enable+0x20/0x20 [rcutorture 4a4a34e515cdd0c53b2c18de8a71945278e82895]
> > > > > [   76.045049][    C1]  rcu_torture_updown_hrt+0x18/0x30 [rcutorture 4a4a34e515cdd0c53b2c18de8a71945278e82895]
> > > > > [   76.045935][    C1]  __hrtimer_run_queues+0x18a/0x3b0
> > > > > [   76.046555][    C1]  ? ktime_get_update_offsets_now+0x52/0x200
> > > > > [   76.047309][    C1]  hrtimer_run_queues+0xf7/0x130
> > > > > [   76.048063][    C1]  update_process_times+0x25/0xb0
> > > > > [   76.048680][    C1]  tick_periodic+0xc4/0xe0
> > > > > [   76.049272][    C1]  tick_handle_periodic+0x23/0x70
> > > > > [   76.049875][    C1]  __sysvec_apic_timer_interrupt+0x73/0x190
> > > > > [   76.050528][    C1]  ? sysvec_call_function_single+0x30/0x30
> > > > > [   76.051175][    C1]  sysvec_apic_timer_interrupt+0x1a/0x34
> > > > > [   76.051812][    C1]  handle_exception+0x150/0x150
> > > > > [   76.052405][    C1] EIP: lock_acquire+0xda/0x1c0
> > > > > [   76.052998][    C1] Code: 64 0f c1 05 8c 0e b5 c3 83 f8 01 0f 85 a5 00 00 00 9c 8f 45 d4 f7 45 d4 00 02 00 00 0f 85 a6 00 00 00 85 f6 74 01 fb 83 c4 20 <5e> 5f 5b 5d 2e e9 30 3d 3c 01 89 ce 89 55 f0 8b 55 f0 ff 75 14 ff
> > > > > [   76.054753][    C1] EAX: 00000001 EBX: c345d894 ECX: b4a771ac EDX: 00000000
> > > > > [   76.055499][    C1] ESI: 00000001 EDI: 00000000 EBP: c7f19f50 ESP: c7f19f44
> > > > > [   76.056248][    C1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000286
> > > > > [   76.057032][    C1]  ? try_to_wake_up+0x248/0x850
> > > > > [   76.057690][    C1]  ? sysvec_call_function_single+0x30/0x30
> > > > > [   76.058377][    C1]  ? try_to_wake_up+0x248/0x850
> > > > > [   76.059009][    C1]  ? sysvec_call_function_single+0x30/0x30
> > > > > [   76.059693][    C1]  ? lock_acquire+0xda/0x1c0
> > > > > [   76.060312][    C1]  _raw_spin_lock+0x2a/0x3c
> > > > > [   76.060927][    C1]  ? kthreadd+0xda/0x160
> > > > > [   76.061549][    C1]  kthreadd+0xda/0x160
> > > > > [   76.062126][    C1]  ? schedule_tail+0xd4/0x120
> > > > > [   76.062729][    C1]  ? kthread_stop_put+0x30/0x30
> > > > > [   76.063335][    C1]  ? kthread_stop_put+0x30/0x30
> > > > > [   76.063933][    C1]  ret_from_fork+0x35/0x40
> > > > > [   76.064505][    C1]  ret_from_fork_asm+0x12/0x1c
> > > > > [   76.065091][    C1]  entry_INT80_32+0x10d/0x10d
> > > > > [   76.065693][    C1] irq event stamp: 4386
> > > > > [   76.066236][    C1] hardirqs last  enabled at (4385): [<c10f858d>] finish_lock_switch+0x9d/0xe0
> > > > > [   76.067037][    C1] hardirqs last disabled at (4386): [<c24e7ab0>] sysvec_apic_timer_interrupt+0xc/0x34
> > > > > [   76.067873][    C1] softirqs last  enabled at (2260): [<c10bb5d2>] handle_softirqs+0x372/0x3b0
> > > > > [   76.068659][    C1] softirqs last disabled at (2255): [<c24f627f>] __do_softirq+0xf/0x16
> > > > > [   76.069635][    C1] ---[ end trace 0000000000000000 ]---
> > > > > [   76.099825][  T636] srcud-torture: Creating torture_stutter task
> > > > > [   76.099831][  T667] srcud-torture: torture_shuffle task started
> > > > > [   76.101418][  T636] srcud-torture: Creating torture_onoff task
> > > > > 
> > > > > 
> > > > > -- 
> > > > > 0-DAY CI Kernel Test Service
> > > > > https://github.com/intel/lkp-tests/wiki
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > > index 373c65a6e1031..0840153c90d18 100644
> > > > --- a/kernel/rcu/rcutorture.c
> > > > +++ b/kernel/rcu/rcutorture.c
> > > > @@ -1975,14 +1975,14 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
> > > >  
> > > >  // Verify the specified RCUTORTURE_RDR* state.
> > > >  #define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
> > > > -static void rcutorture_one_extend_check(char *s, int curstate, int new, int old, bool insoftirq)
> > > > +static void rcutorture_one_extend_check(char *s, int curstate, int new, int old)
> > > >  {
> > > >  	int mask;
> > > >  
> > > > -	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE))
> > > > +	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE) || in_nmi())
> > > >  		return;
> > > >  
> > > > -	WARN_ONCE(!(curstate & RCUTORTURE_RDR_IRQ) && irqs_disabled(), ROEC_ARGS);
> > > > +	WARN_ONCE(!(curstate & RCUTORTURE_RDR_IRQ) && irqs_disabled() && !in_hardirq(), ROEC_ARGS);
> > > >  	WARN_ONCE((curstate & RCUTORTURE_RDR_IRQ) && !irqs_disabled(), ROEC_ARGS);
> > > >  
> > > >  	// If CONFIG_PREEMPT_COUNT=n, further checks are unreliable.
> > > > @@ -1997,9 +1997,9 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
> > > >  		  (curstate & (RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2)) &&
> > > >  		  cur_ops->readlock_nesting() == 0, ROEC_ARGS);
> > > >  
> > > > -	// Timer handlers have all sorts of stuff disabled, so ignore
> > > > +	// Interrupt handlers have all sorts of stuff disabled, so ignore
> > > >  	// unintended disabling.
> > > > -	if (insoftirq)
> > > > +	if (in_serving_softirq() || in_hardirq())
> > > >  		return;
> > > >  
> > > >  	WARN_ONCE(cur_ops->extendables &&
> > > > @@ -2038,8 +2038,7 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
> > > >   * beginning or end of the critical section and if there was actually a
> > > >   * change, do a ->read_delay().
> > > >   */
> > > > -static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
> > > > -				  struct torture_random_state *trsp,
> > > > +static void rcutorture_one_extend(int *readstate, int newstate, struct torture_random_state *trsp,
> > > >  				  struct rt_read_seg *rtrsp)
> > > >  {
> > > >  	bool first;
> > > > @@ -2054,7 +2053,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
> > > >  	first = idxold1 == 0;
> > > >  	WARN_ON_ONCE(idxold2 < 0);
> > > >  	WARN_ON_ONCE(idxold2 & ~(RCUTORTURE_RDR_ALLBITS | RCUTORTURE_RDR_UPDOWN));
> > > > -	rcutorture_one_extend_check("before change", idxold1, statesnew, statesold, insoftirq);
> > > > +	rcutorture_one_extend_check("before change", idxold1, statesnew, statesold);
> > > >  	rtrsp->rt_readstate = newstate;
> > > >  
> > > >  	/* First, put new protection in place to avoid critical-section gap. */
> > > > @@ -2074,8 +2073,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
> > > >  		idxnew2 = (cur_ops->readlock() << RCUTORTURE_RDR_SHIFT_2) & RCUTORTURE_RDR_MASK_2;
> > > >  
> > > >  	// Complain unless both the old and the new protection is in place.
> > > > -	rcutorture_one_extend_check("during change",
> > > > -				    idxold1 | statesnew, statesnew, statesold, insoftirq);
> > > > +	rcutorture_one_extend_check("during change", idxold1 | statesnew, statesnew, statesold);
> > > >  
> > > >  	// Sample CPU under both sets of protections to reduce confusion.
> > > >  	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU)) {
> > > > @@ -2150,7 +2148,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
> > > >  	WARN_ON_ONCE(*readstate < 0);
> > > >  	if (WARN_ON_ONCE(*readstate & ~RCUTORTURE_RDR_ALLBITS))
> > > >  		pr_info("Unexpected readstate value of %#x\n", *readstate);
> > > > -	rcutorture_one_extend_check("after change", *readstate, statesnew, statesold, insoftirq);
> > > > +	rcutorture_one_extend_check("after change", *readstate, statesnew, statesold);
> > > >  }
> > > >  
> > > >  /* Return the biggest extendables mask given current RCU and boot parameters. */
> > > > @@ -2217,8 +2215,7 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
> > > >   * critical section.
> > > >   */
> > > >  static struct rt_read_seg *
> > > > -rcutorture_loop_extend(int *readstate, bool insoftirq, struct torture_random_state *trsp,
> > > > -		       struct rt_read_seg *rtrsp)
> > > > +rcutorture_loop_extend(int *readstate, struct torture_random_state *trsp, struct rt_read_seg *rtrsp)
> > > >  {
> > > >  	int i;
> > > >  	int j;
> > > > @@ -2233,7 +2230,7 @@ rcutorture_loop_extend(int *readstate, bool insoftirq, struct torture_random_sta
> > > >  	for (j = 0; j < i; j++) {
> > > >  		mask = rcutorture_extend_mask(*readstate, trsp);
> > > >  		WARN_ON_ONCE(mask & RCUTORTURE_RDR_UPDOWN);
> > > > -		rcutorture_one_extend(readstate, mask, insoftirq, trsp, &rtrsp[j]);
> > > > +		rcutorture_one_extend(readstate, mask, trsp, &rtrsp[j]);
> > > >  	}
> > > >  	return &rtrsp[j];
> > > >  }
> > > > @@ -2279,7 +2276,7 @@ static bool rcu_torture_one_read_start(struct rcu_torture_one_read_state *rtorsp
> > > >  					  (rtorsp->readstate & RCUTORTURE_RDR_UPDOWN));
> > > >  	if (rtorsp->p == NULL) {
> > > >  		/* Wait for rcu_torture_writer to get underway */
> > > > -		rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
> > > > +		rcutorture_one_extend(&rtorsp->readstate, 0, trsp, rtorsp->rtrsp);
> > > >  		return false;
> > > >  	}
> > > >  	if (rtorsp->p->rtort_mbtest == 0)
> > > > @@ -2293,7 +2290,7 @@ static bool rcu_torture_one_read_start(struct rcu_torture_one_read_state *rtorsp
> > > >   * critical sections and check for errors.
> > > >   */
> > > >  static void rcu_torture_one_read_end(struct rcu_torture_one_read_state *rtorsp,
> > > > -				     struct torture_random_state *trsp, long myid)
> > > > +				     struct torture_random_state *trsp)
> > > >  {
> > > >  	int i;
> > > >  	unsigned long completed;
> > > > @@ -2340,7 +2337,7 @@ static void rcu_torture_one_read_end(struct rcu_torture_one_read_state *rtorsp,
> > > >  	}
> > > >  	if (cur_ops->reader_blocked)
> > > >  		preempted = cur_ops->reader_blocked();
> > > > -	rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
> > > > +	rcutorture_one_extend(&rtorsp->readstate, 0, trsp, rtorsp->rtrsp);
> > > >  	WARN_ON_ONCE(rtorsp->readstate);
> > > >  	// This next splat is expected behavior if leakpointer, especially
> > > >  	// for CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels.
> > > > @@ -2370,13 +2367,13 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
> > > >  	init_rcu_torture_one_read_state(&rtors, trsp);
> > > >  	newstate = rcutorture_extend_mask(rtors.readstate, trsp);
> > > >  	WARN_ON_ONCE(newstate & RCUTORTURE_RDR_UPDOWN);
> > > > -	rcutorture_one_extend(&rtors.readstate, newstate, myid < 0, trsp, rtors.rtrsp++);
> > > > +	rcutorture_one_extend(&rtors.readstate, newstate, trsp, rtors.rtrsp++);
> > > >  	if (!rcu_torture_one_read_start(&rtors, trsp, myid)) {
> > > > -		rcutorture_one_extend(&rtors.readstate, 0, myid < 0, trsp, rtors.rtrsp);
> > > > +		rcutorture_one_extend(&rtors.readstate, 0, trsp, rtors.rtrsp);
> > > >  		return false;
> > > >  	}
> > > > -	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, myid < 0, trsp, rtors.rtrsp);
> > > > -	rcu_torture_one_read_end(&rtors, trsp, myid);
> > > > +	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, trsp, rtors.rtrsp);
> > > > +	rcu_torture_one_read_end(&rtors, trsp);
> > > >  	return true;
> > > >  }
> > > >  
> > > > @@ -2469,7 +2466,7 @@ static enum hrtimer_restart rcu_torture_updown_hrt(struct hrtimer *hrtp)
> > > >  	struct rcu_torture_one_read_state_updown *rtorsup;
> > > >  
> > > >  	rtorsup = container_of(hrtp, struct rcu_torture_one_read_state_updown, rtorsu_hrt);
> > > > -	rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
> > > > +	rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs);
> > > >  	WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
> > > >  	WRITE_ONCE(rtorsup->rtorsu_nups, rtorsup->rtorsu_nups + 1);
> > > >  	WRITE_ONCE(rtorsup->rtorsu_nmigrates,
> > > > @@ -2519,7 +2516,7 @@ static void rcu_torture_updown_cleanup(void)
> > > >  		if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
> > > >  			continue;
> > > >  		if (hrtimer_cancel(&rtorsup->rtorsu_hrt) || WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
> > > > -			rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
> > > > +			rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs);
> > > >  			WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
> > > >  			WRITE_ONCE(rtorsup->rtorsu_nups, rtorsup->rtorsu_nups + 1);
> > > >  			smp_store_release(&rtorsup->rtorsu_inuse, false);
