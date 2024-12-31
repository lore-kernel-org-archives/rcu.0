Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E243234;
	Tue, 31 Dec 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735661985; cv=none; b=UkBy+NUT+cuPfmubqtoR2U36CR0llTZpsbbOrTVFNpAIQ+sey+9/NwNL/2OhtcC8RhdJHSyQVGZ5pF7f0OaZ7+EzjHGuNOMTeEO01FiJd6vqupwFjCiYWIOL1CoGn5XM8cUdlCElgeAyslnPcTtOu5o54eRuhkhxrguczX3nNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735661985; c=relaxed/simple;
	bh=DcnVKYZDJYJXtYFI6lMkR7Bq9V5EKhywS6N8FbwD6MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JN+43Y0GqsQ5XojPqPBacTOogyo0AsXJNQReCJ1bHc+xPT32535do/5347u/SQmInusxhoF9ko5QGxtHkPtrITqY+KWW3qllC7llkXcu79wWS7tcjb6v0JmbKcwsM0MQQ7eEzJ7brWNqetUUfKMZlSLdhvmQF4ojeMenA2T22Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fC+f33CN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fC+f33CN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D99C4CED2;
	Tue, 31 Dec 2024 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735661984;
	bh=DcnVKYZDJYJXtYFI6lMkR7Bq9V5EKhywS6N8FbwD6MI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fC+f33CN7QyOQg1sS9dyk0sJTyJz4s3viMHTDV4bXLv75MAJQYVfkl3FbUv5dcjot
	 rXAzOiqq4G29pwWXthUESa4tQEcyguslVA1zAeg3uP8y59UAU+FIIsgHU6sU2vD2JH
	 JqDBhFJx3w4/3LPBGd0vj73UmNSFvcTMkQABt57e8cKW8N5VN4IAeQcjpKGggNUEGZ
	 aAln4lIlMxW5PgTdbwZYneG7SseNmrszlxyQwWtKlK7cVUW0Zku022j6bsUkNiBZUH
	 /myS0/qifGAQVMDz3i8vBxiW/kipwpp9d51FLblebLLRW2kl2R/fZbpR4+XotpdTAW
	 GvCROVSd4IbMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3AF40CE0DEB; Tue, 31 Dec 2024 08:19:44 -0800 (PST)
Date: Tue, 31 Dec 2024 08:19:44 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, rcu@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2024.12.24a] [srcu] 9216c28c6a:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <949f6251-d411-45ef-9f85-d5d069b90b0e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202412311203.ca7bddba-lkp@intel.com>
 <CALm+0cWOxUm_hrNe4UP4Z-vyr4RCOw+dc=kCBTgsyjHFHiHDsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cWOxUm_hrNe4UP4Z-vyr4RCOw+dc=kCBTgsyjHFHiHDsg@mail.gmail.com>

On Tue, Dec 31, 2024 at 03:16:25PM +0800, Z qiang wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:
> >
> > commit: 9216c28c6a927fd20f116feed55bba025f18f401 ("srcu: Make SRCU readers use ->srcu_ctrs for counter selection")
> > https://github.com/paulmckrcu/linux dev.2024.12.24a
> >
> > in testcase: rcutorture
> > version:
> > with following parameters:
> >
> >         runtime: 300s
> >         test: default
> >         torture_type: srcu
> >
> >
> >
> > config: i386-randconfig-005-20241230
> > compiler: gcc-12
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > +------------------------------------------------+------------+------------+
> > |                                                | 2add2e88ea | 9216c28c6a |
> > +------------------------------------------------+------------+------------+
> > | BUG:unable_to_handle_page_fault_for_address    | 0          | 6          |
> > | Oops                                           | 0          | 6          |
> > | EIP:__srcu_read_lock                           | 0          | 6          |
> > | Kernel_panic-not_syncing:Fatal_exception       | 0          | 6          |
> > +------------------------------------------------+------------+------------+
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202412311203.ca7bddba-lkp@intel.com
> >
> 
> Please try the following modifications:
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index e85db7d5b364..7c7304dee645 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1999,6 +1999,7 @@ static int srcu_module_coming(struct module *mod)
>         for (i = 0; i < mod->num_srcu_structs; i++) {
>                 ssp = *(sspp++);
>                 ssp->sda = alloc_percpu(struct srcu_data);
> +               ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];

This does look quite promising, so thank you for digging into this!!!

Looking forward to seeing if it fixes the problem.  ;-)

							Thanx, Paul

>                 if (WARN_ON_ONCE(!ssp->sda))
>                         return -ENOMEM;
>         }
> 
> 
> 
> Thanks
> Zqiang
> 
> >
> > [  168.973150][  T628] BUG: unable to handle page fault for address: 2367a000
> > [  168.973700][  T628] #PF: supervisor write access in kernel mode
> > [  168.974809][  T628] #PF: error_code(0x0002) - not-present page
> > [  168.975761][  T628] *pde = 00000000
> > [  168.976236][  T628] Oops: Oops: 0002 [#1] PREEMPT SMP
> > [  168.977052][  T628] CPU: 0 UID: 0 PID: 628 Comm: rcu_torture_wri Tainted: G                T  6.13.0-rc2-00067-g9216c28c6a92 #1
> > [  168.978867][  T628] Tainted: [T]=RANDSTRUCT
> > [  168.979429][  T628] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [ 168.980862][ T628] EIP: __srcu_read_lock (kernel/rcu/srcutree.c:749)
> > [ 168.981213][ T628] Code: 85 ff 74 0c e8 45 59 00 00 83 3b 00 74 02 0f 0b 5b 5e 5f 5d c3 8b 00 f0 83 44 24 fc 00 83 c0 07 83 e0 fc c3 55 89 e5 8b 50 04 <64> ff 02 f0 83 44 24 fc 00 2b 50 08 5d 89 d0 c1 f8 03 c3 55 89 e5
> > All code
> > ========
> >    0:   85 ff                   test   %edi,%edi
> >    2:   74 0c                   je     0x10
> >    4:   e8 45 59 00 00          call   0x594e
> >    9:   83 3b 00                cmpl   $0x0,(%rbx)
> >    c:   74 02                   je     0x10
> >    e:   0f 0b                   ud2
> >   10:   5b                      pop    %rbx
> >   11:   5e                      pop    %rsi
> >   12:   5f                      pop    %rdi
> >   13:   5d                      pop    %rbp
> >   14:   c3                      ret
> >   15:   8b 00                   mov    (%rax),%eax
> >   17:   f0 83 44 24 fc 00       lock addl $0x0,-0x4(%rsp)
> >   1d:   83 c0 07                add    $0x7,%eax
> >   20:   83 e0 fc                and    $0xfffffffc,%eax
> >   23:   c3                      ret
> >   24:   55                      push   %rbp
> >   25:   89 e5                   mov    %esp,%ebp
> >   27:   8b 50 04                mov    0x4(%rax),%edx
> >   2a:*  64 ff 02                incl   %fs:(%rdx)               <-- trapping instruction
> >   2d:   f0 83 44 24 fc 00       lock addl $0x0,-0x4(%rsp)
> >   33:   2b 50 08                sub    0x8(%rax),%edx
> >   36:   5d                      pop    %rbp
> >   37:   89 d0                   mov    %edx,%eax
> >   39:   c1 f8 03                sar    $0x3,%eax
> >   3c:   c3                      ret
> >   3d:   55                      push   %rbp
> >   3e:   89 e5                   mov    %esp,%ebp
> >
> > Code starting with the faulting instruction
> > ===========================================
> >    0:   64 ff 02                incl   %fs:(%rdx)
> >    3:   f0 83 44 24 fc 00       lock addl $0x0,-0x4(%rsp)
> >    9:   2b 50 08                sub    0x8(%rax),%edx
> >    c:   5d                      pop    %rbp
> >    d:   89 d0                   mov    %edx,%eax
> >    f:   c1 f8 03                sar    $0x3,%eax
> >   12:   c3                      ret
> >   13:   55                      push   %rbp
> >   14:   89 e5                   mov    %esp,%ebp
> > [  168.982540][  T628] EAX: ef0c8420 EBX: ef0c8420 ECX: e5e1e840 EDX: 00000000
> > [  168.983022][  T628] ESI: ef0c919c EDI: 00000000 EBP: c75e9ee8 ESP: c75e9ee8
> > [  168.983503][  T628] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
> > [  168.984024][  T628] CR0: 80050033 CR2: 2367a000 CR3: 075f5000 CR4: 00040690
> > [  168.984518][  T628] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [  168.985008][  T628] DR6: fffe0ff0 DR7: 00000400
> > [  168.985329][  T628] Call Trace:
> > [ 168.985571][ T628] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465)
> > [ 168.985877][ T628] ? __die_body (arch/x86/kernel/dumpstack.c:421)
> > [ 168.986185][ T628] ? __die (arch/x86/kernel/dumpstack.c:435)
> > [ 168.986466][ T628] ? page_fault_oops (arch/x86/mm/fault.c:715)
> > [ 168.986811][ T628] ? kernelmode_fixup_or_oops+0x50/0x58
> > [ 168.987273][ T628] ? __bad_area_nosemaphore+0x37/0x1d5
> > [ 168.987726][ T628] ? validate_chain (kernel/locking/lockdep.c:3819 kernel/locking/lockdep.c:3872)
> > [ 168.988058][ T628] ? bad_area_nosemaphore (arch/x86/mm/fault.c:835)
> > [ 168.988406][ T628] ? do_user_addr_fault (arch/x86/mm/fault.c:1280 (discriminator 1))
> > [ 168.988763][ T628] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
> > [ 168.989110][ T628] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494)
> > [ 168.989472][ T628] ? handle_exception (arch/x86/entry/entry_32.S:1048)
> > [ 168.989800][ T628] ? siphash_4u64 (lib/siphash.c:203)
> > [ 168.990123][ T628] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494)
> > [ 168.990539][ T628] ? __srcu_read_lock (kernel/rcu/srcutree.c:749)
> > [ 168.990858][ T628] ? rcu_torture_barrier_init (kernel/rcu/rcutorture.c:3381) rcutorture
> > [ 168.991319][ T628] ? siphash_4u64 (lib/siphash.c:203)
> > [ 168.991618][ T628] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494)
> > [ 168.992021][ T628] ? __srcu_read_lock (kernel/rcu/srcutree.c:749)
> > [ 168.992340][ T628] srcu_read_lock (include/linux/srcu.h:165 include/linux/srcu.h:257) rcutorture
> > [ 168.992735][ T628] srcu_torture_read_lock (kernel/rcu/rcutorture.c:693) rcutorture
> > [ 168.993184][ T628] rcu_torture_writer (kernel/rcu/rcutorture.c:1528) rcutorture
> > [ 168.993615][ T628] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
> > [ 168.994020][ T628] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:80 (discriminator 13))
> > [ 168.994369][ T628] kthread (kernel/kthread.c:391)
> > [ 168.994647][ T628] ? rcu_torture_pipe_update (kernel/rcu/rcutorture.c:1447) rcutorture
> > [ 168.995108][ T628] ? list_del_init (include/linux/lockdep.h:248)
> > [ 168.995428][ T628] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 168.995735][ T628] ? list_del_init (include/linux/lockdep.h:248)
> > [ 168.996053][ T628] ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
> > [ 168.996380][ T628] entry_INT80_32 (arch/x86/entry/entry_32.S:942)
> > [  168.996692][  T628] Modules linked in: rcutorture(+) torture intel_rapl_msr intel_rapl_common iosf_mbi crc32c_intel aesni_intel input_leds led_class fuse
> > [  168.997654][  T628] CR2: 000000002367a000
> > [  168.997945][  T628] ---[ end trace 0000000000000000 ]---
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20241231/202412311203.ca7bddba-lkp@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
> >
