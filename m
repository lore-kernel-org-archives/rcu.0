Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAFA129E70;
	Wed,  8 May 2024 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715184865; cv=none; b=dXsuMhSjjSeozgtLcQz74YiwffcUECwUXqRU8KJ920Kv8sZ4N2Ar0RI5cgK7VXEjSAyKTtS4LkJMSvID+2YJ8L5G42RSeEi1dD2ApDilxlJBFH1FG/mFDKLMp/pM0GQdzTYHFRjjnnJpgwxcq572A6haeRAunqjEdYUNh/6mXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715184865; c=relaxed/simple;
	bh=GicZfDMvAMacxnAAqU7f7Vgy/xZdxbVPIXZAlMBpEik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQL8XT1DJp0fSh25OaBHScgOYjGwXhfZSjGMcJ1oa2mZfGig0mFI2xqSqw+LgiWTlBXhsn6sAs7Jn/CGBDszxQIAunhrWR7cw4q9OTHd1KEnU9RL4LFuPECuF1FYkVJNN2s60RahNOfy830qvmPlPfi0xrzUt5i280L4/W4rceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnvUgJph; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnvUgJph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27911C113CC;
	Wed,  8 May 2024 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715184864;
	bh=GicZfDMvAMacxnAAqU7f7Vgy/xZdxbVPIXZAlMBpEik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnvUgJphJ0MLrjRBRpZsUJGSdBsT9pPbFUqP/6D6rmf9XNg3R4Z0VvHnu3MUNmYvZ
	 3/rn3gJxjzgk0u66WZFYd/rTSDTSUDIEQoSbK1rOYmzGCGrYWSO+vc8+z30onc6+UF
	 uG9gsJT/JLe+I1KCTb2XUb40qf0N2sJ/psD2nxvKdbNsQUKyda1KlMOeBjT5h/WeD5
	 CXmy6rvFN/IaxmnXgI+98EsfJp+On5XGaS+F1oCbwAqcuICqHOwqVqUrBOsUQHWCel
	 N19I802Fv5qI/9zthMJCY6aLoA5EOXQLPcIhq401l907SUgJaJCF17T2YyppGWt73q
	 m7rq13S/GRFIQ==
Date: Wed, 8 May 2024 18:14:21 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: Re: [linux-next:master] [rcu/nocb] 4c66bc7cac:
 BUG:using_smp_processor_id()in_preemptible
Message-ID: <Zjuk3UWYHEaD_vZC@localhost.localdomain>
References: <202405072252.959dadc4-lkp@intel.com>
 <CALm+0cViRh07e88uMrRp=5K0TgBVFwmwLiLnejc7puEMXrmFsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALm+0cViRh07e88uMrRp=5K0TgBVFwmwLiLnejc7puEMXrmFsA@mail.gmail.com>

Le Wed, May 08, 2024 at 12:55:25PM +0800, Z qiang a écrit :
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:
> >
> > commit: 4c66bc7cacc08e8abcf5049d2b90bfd800904336 ("rcu/nocb: Use kthread parking instead of ad-hoc implementation")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > [test failed on linux-next/master 9221b2819b8a4196eecf5476d66201be60fbcf29]
> >
> > in testcase: boot
> >
> > compiler: gcc-13
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > +--------------------------------------------------------------+------------+------------+
> > |                                                              | 6deb20902f | 4c66bc7cac |
> > +--------------------------------------------------------------+------------+------------+
> > | BUG:using_smp_processor_id()in_preemptible                   | 0          | 12         |
> > +--------------------------------------------------------------+------------+------------+
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202405072252.959dadc4-lkp@intel.com
> >
> >
> > [    4.099901][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.101313][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.102493][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.104098][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.104398][   T18] Call Trace:
> > [    4.104398][   T18]  <TASK>
> > [ 4.104398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.104398][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.104398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.104398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.104398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.104398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> 
> 
> Please try the following modifications:
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 340bbefe5f65..b93e40206621 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -28,8 +28,8 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>                 !(lockdep_is_held(&rcu_state.barrier_mutex) ||
>                   (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
>                   rcu_lockdep_is_held_nocb(rdp) ||
> -                 (rdp == this_cpu_ptr(&rcu_data) &&
> -                  !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
> +                  (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
> +                   rdp == this_cpu_ptr(&rcu_data)) ||

Looks good, would you like to send a proper patch with changelog?

Thanks.

>                   rcu_current_is_nocb_kthread(rdp)),
>                 "Unsafe read of RCU_NOCB offloaded state"



>         );
> 
> Thanks
> Zqiang
> 
> 
> > [ 4.104398][ T18] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67)
> > [ 4.104398][ T18] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421 (discriminator 16))
> > [ 4.104398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.104398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.104398][ T18] kthread (kernel/kthread.c:388)
> > [ 4.104398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.104398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.104398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.104398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.104398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.104398][   T18]  </TASK>
> > [    4.106221][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.107796][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.108547][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.109667][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.111064][   T18] Call Trace:
> > [    4.111064][   T18]  <TASK>
> > [ 4.111064][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.111064][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.111064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.111064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.111064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.111064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.111064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.111064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.111064][ T18] kthread (kernel/kthread.c:388)
> > [ 4.111064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.111064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.111064][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.111064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.111064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.111064][   T18]  </TASK>
> > [    4.132677][    T1] NMI watchdog: Perf NMI watchdog permanently disabled
> > [    4.135331][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.137454][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.137849][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.139414][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.141064][   T18] Call Trace:
> > [    4.141064][   T18]  <TASK>
> > [ 4.141064][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.141064][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.141064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.141064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.141064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.141064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.141064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.141064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.141064][ T18] kthread (kernel/kthread.c:388)
> > [ 4.141064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.141064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.141064][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.141064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.141064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.141064][   T18]  </TASK>
> > [    4.141391][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.143427][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.144497][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.146055][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.147731][   T18] Call Trace:
> > [    4.147731][   T18]  <TASK>
> > [ 4.147731][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.147731][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.147731][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.147731][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.147731][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.147731][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.147731][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.147731][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.147731][ T18] kthread (kernel/kthread.c:388)
> > [ 4.147731][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.147731][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.147731][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.147731][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.147731][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.147731][   T18]  </TASK>
> > [    4.148538][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.150537][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.151144][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.152635][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.154398][   T18] Call Trace:
> > [    4.154398][   T18]  <TASK>
> > [ 4.154398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.154398][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.154398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.154398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.154398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.154398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.154398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.154398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.154398][ T18] kthread (kernel/kthread.c:388)
> > [ 4.154398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.154398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.154398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.154398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.154398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.154398][   T18]  </TASK>
> > [    4.156100][    T1] smp: Bringing up secondary CPUs ...
> > [    4.159421][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.161134][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.162569][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.164398][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.164398][   T18] Call Trace:
> > [    4.164398][   T18]  <TASK>
> > [ 4.164398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.164398][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.164398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.164398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.164398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.164398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.164398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.164398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.164398][ T18] kthread (kernel/kthread.c:388)
> > [ 4.164398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.164398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.164398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.164398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.164398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.164398][   T18]  </TASK>
> > [    4.168016][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.170139][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.171170][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.173242][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.174398][   T18] Call Trace:
> > [    4.174398][   T18]  <TASK>
> > [ 4.174398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.174398][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.174398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.174398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.174398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.174398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.174398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.174398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.174398][ T18] kthread (kernel/kthread.c:388)
> > [ 4.174398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.174398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.174398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.174398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.174398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.174398][   T18]  </TASK>
> > [    4.189949][    T1] smpboot: x86: Booting SMP configuration:
> > [    4.191158][    T1] .... node  #0, CPUs:      #1
> > [    1.668906][    T0] masked ExtINT on CPU#1
> > [    4.202955][   T29] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/1/29
> > [ 4.204471][ T29] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.205845][   T29] CPU: 0 PID: 29 Comm: rcuop/1 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.207731][   T29] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.207731][   T29] Call Trace:
> > [    4.207731][   T29]  <TASK>
> > [ 4.207731][ T29] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.207731][ T29] dump_stack (lib/dump_stack.c:124)
> > [ 4.207731][ T29] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.207731][ T29] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.207731][ T29] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.207731][ T29] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.207731][ T29] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67)
> > [ 4.207731][ T29] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421 (discriminator 16))
> > [ 4.207731][ T29] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.207731][ T29] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.207731][ T29] kthread (kernel/kthread.c:388)
> > [ 4.207731][ T29] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.207731][ T29] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.207731][ T29] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.207731][ T29] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.207731][ T29] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.207731][   T29]  </TASK>
> > [    4.207989][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.209997][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.211188][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.212898][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.214398][   T18] Call Trace:
> > [    4.214398][   T18]  <TASK>
> > [ 4.214398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.214398][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.214398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.214398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.214398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.214398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.214398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.214398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.214398][ T18] kthread (kernel/kthread.c:388)
> > [ 4.214398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.214398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.214398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.214398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.214398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.214398][   T18]  </TASK>
> > [    4.215399][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> > [ 4.217064][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [    4.217772][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> > [    4.219363][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    4.221064][   T18] Call Trace:
> > [    4.221064][   T18]  <TASK>
> > [ 4.221064][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> > [ 4.221064][ T18] dump_stack (lib/dump_stack.c:124)
> > [ 4.221064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> > [ 4.221064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> > [ 4.221064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> > [ 4.221064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> > [ 4.221064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> > [ 4.221064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> > [ 4.221064][ T18] kthread (kernel/kthread.c:388)
> > [ 4.221064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> > [ 4.221064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.221064][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 4.221064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> > [ 4.221064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> > [    4.221064][   T18]  </TASK>
> >
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240507/202405072252.959dadc4-lkp@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
> >
