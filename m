Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D525A333;
	Sun, 31 Aug 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756658445; cv=none; b=iQGfeRldYNvVbLz2bBbPh8snOjBLUxCNn6Mf1VmUXxhlEU56jJ9caL62a8pIYIXAdQJ8jAiSotxTywFacIg/FqQfdOvJipd8GYeJUVXHg0BE+uyx2+NDOCxVajgvaGv2g+LIZOTFE6rFE6ZFH5i0qHsPWHqS5UUfr4TYObJjFPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756658445; c=relaxed/simple;
	bh=HuzusiPD0/AwotrTzqZxwCSVSAg0xXQvyfDPId+W9p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KD457A1rjW9BufQnnq7bZPJ2eNt7x98QORUT01tycsuwivwFtQbRdkmZ2zg2ymDuQbd5KR4T46AdjAeJaKJQqkBllBCa5IAMQd0o4Q4+f8uTa9jziUO+eQRMWK6AJUP/LlvsJk+GUYw3b8Oq7vV7iqrJFye3gpfBBn3aghDNfC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfYZ+JL1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfYZ+JL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A41AC4CEED;
	Sun, 31 Aug 2025 16:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756658445;
	bh=HuzusiPD0/AwotrTzqZxwCSVSAg0xXQvyfDPId+W9p4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LfYZ+JL1j/JKyyAv9fANjnNJQcj2q3dLZLDPOJh8/e+708wdPUgArsIxAOGQXHxoz
	 4hzQBkFgVuy8AlCswkJPn7c5JfkjlABBKmP713+0dpIiBAklX+gsmOOqewFR6DSxZB
	 kWgSG3yFdZpsLFfPNcmLqW65VaNGSsqnT4mszvc7H7FQ1nHIYdZiZF56yzz6BqtjLN
	 HAG4Y0suZK3QbX9GlZLwapOSX+fvubGGPwCU0OI7ocNDpRmEFoaczFitc9OVMzfhrZ
	 GiaajmT5UtA9TIF9ksvC2iF5xSvGkRh2nGs2QYUY0nivtYANiDHPEdqHQOTvKa1zKh
	 Lbmx/riZqgLAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CDC0CCE0C15; Sun, 31 Aug 2025 09:40:44 -0700 (PDT)
Date: Sun, 31 Aug 2025 09:40:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2025.08.21a] [rcu] 8bd9383727:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <8f43f958-e3e6-44d5-9600-9e096c3a06b7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202508261642.b15eefbb-lkp@intel.com>
 <2853a174-76e4-440b-bfc1-71ea30694822@paulmck-laptop>
 <eb1e5ab00253fdae5ba5aa4c97d60a79d357dbfd@linux.dev>
 <f58f7c75-46be-4ddd-be70-ee4f6a3370a9@paulmck-laptop>
 <aefc893f1b7c17049c2e6eb2256a97739a5e328d@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aefc893f1b7c17049c2e6eb2256a97739a5e328d@linux.dev>

On Sun, Aug 31, 2025 at 02:22:56AM +0000, Zqiang wrote:
> > 
> > On Sat, Aug 30, 2025 at 02:38:35AM +0000, Zqiang wrote:
> > 
> > > 
> > > On Tue, Aug 26, 2025 at 04:47:22PM +0800, kernel test robot wrote:
> > >  
> > >  > 
> > >  > hi, Paul,
> > >  > 
> > >  > the similar issue still exists on this dev.2025.08.21a branch.
> > >  > again, if the issue is already fixed on later branches, please just ignore.
> > >  > thanks
> > >  > 
> > >  > 
> > >  > Hello,
> > >  > 
> > >  > kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:
> > >  > 
> > >  > commit: 8bd9383727068a5a18acfecefbdfa44a7d6bd838 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> > >  > https://github.com/paulmckrcu/linux dev.2025.08.21a
> > >  > 
> > >  > in testcase: rcutorture
> > >  > version: 
> > >  > with following parameters:
> > >  > 
> > >  > runtime: 300s
> > >  > test: default
> > >  > torture_type: tasks-tracing
> > >  > 
> > >  > 
> > >  > 
> > >  > config: x86_64-randconfig-003-20250824
> > >  > compiler: clang-20
> > >  > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > >  > 
> > >  > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > >  > 
> > >  Again, apologies for being slow, and thank you for your testing efforts.
> > >  
> > >  Idiot here forgot about Tiny SRCU, so please see the end of this email
> > >  for an alleged fix. Does it do the trick for you?
> > >  
> > >  Thanx, Paul
> > >  
> > >  > 
> > >  > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > >  > the same patch/commit), kindly add following tags
> > >  > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > >  > | Closes: https://lore.kernel.org/oe-lkp/202508261642.b15eefbb-lkp@intel.com
> > >  > 
> > >  > 
> > >  > [ 42.365933][ T393] WARNING: possible circular locking dependency detected
> > >  > [ 42.366428][ T393] 6.17.0-rc1-00035-g8bd938372706 #1 Tainted: G T
> > >  > [ 42.366985][ T393] ------------------------------------------------------
> > >  > [ 42.367490][ T393] rcu_torture_rea/393 is trying to acquire lock:
> > >  > [ 42.367952][ T393] ffffffffad41dc88 (rcu_tasks_trace_srcu_struct.srcu_wq.lock){....}-{2:2}, at: swake_up_one (kernel/sched/swait.c:52 (discriminator 1)) 
> > >  > [ 42.368775][ T393]
> > >  > [ 42.368775][ T393] but task is already holding lock:
> > >  > [ 42.369278][ T393] ffff88813d1ff2e8 (&p->pi_lock){-.-.}-{2:2}, at: rcutorture_one_extend (kernel/rcu/rcutorture.c:?) rcutorture 
> > >  > [ 42.370043][ T393]
> > >  > [ 42.370043][ T393] which lock already depends on the new lock.
> > >  > [ 42.370043][ T393]
> > >  > [ 42.370755][ T393]
> > >  > [ 42.370755][ T393] the existing dependency chain (in reverse order) is:
> > >  > [ 42.371388][ T393]
> > >  > [ 42.371388][ T393] -> #1 (&p->pi_lock){-.-.}-{2:2}:
> > >  > [ 42.371903][ T393] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
> > >  > [ 42.372309][ T393] try_to_wake_up (include/linux/spinlock.h:557 (discriminator 1) kernel/sched/core.c:4216 (discriminator 1)) 
> > >  > [ 42.372669][ T393] swake_up_locked (include/linux/list.h:111) 
> > >  > [ 42.373029][ T393] swake_up_one (kernel/sched/swait.c:54 (discriminator 1)) 
> > >  > [ 42.373380][ T393] tasks_tracing_torture_read_unlock (include/linux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (discriminator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutorture 
> > >  > [ 42.373952][ T393] rcutorture_one_extend (kernel/rcu/rcutorture.c:2141) rcutorture 
> > >  > [ 42.374452][ T393] rcu_torture_one_read_end (kernel/rcu/rcutorture.c:2357) rcutorture 
> > >  > [ 42.374976][ T393] rcu_torture_one_read (kernel/rcu/rcutorture.c:?) rcutorture 
> > >  > [ 42.375460][ T393] rcu_torture_reader (kernel/rcu/rcutorture.c:2443) rcutorture 
> > >  > [ 42.375920][ T393] kthread (kernel/kthread.c:465) 
> > >  > [ 42.376241][ T393] ret_from_fork (arch/x86/kernel/process.c:154) 
> > >  > [ 42.376603][ T393] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
> > >  > [ 42.376973][ T393]
> > >  > [ 42.376973][ T393] -> #0 (rcu_tasks_trace_srcu_struct.srcu_wq.lock){....}-{2:2}:
> > >  > [ 42.377657][ T393] __lock_acquire (kernel/locking/lockdep.c:3166) 
> > >  > [ 42.378031][ T393] lock_acquire (kernel/locking/lockdep.c:5868) 
> > >  > [ 42.378378][ T393] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
> > >  > [ 42.378794][ T393] swake_up_one (kernel/sched/swait.c:52 (discriminator 1)) 
> > >  > [ 42.379152][ T393] tasks_tracing_torture_read_unlock (include/linux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (discriminator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutorture 
> > >  > [ 42.379714][ T393] rcutorture_one_extend (kernel/rcu/rcutorture.c:2141) rcutorture 
> > >  > [ 42.380217][ T393] rcu_torture_one_read_end (kernel/rcu/rcutorture.c:2357) rcutorture 
> > >  > [ 42.380731][ T393] rcu_torture_one_read (kernel/rcu/rcutorture.c:?) rcutorture 
> > >  > [ 42.381220][ T393] rcu_torture_reader (kernel/rcu/rcutorture.c:2443) rcutorture 
> > >  > [ 42.381714][ T393] kthread (kernel/kthread.c:465) 
> > >  > [ 42.382060][ T393] ret_from_fork (arch/x86/kernel/process.c:154) 
> > >  > [ 42.382420][ T393] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
> > >  > [ 42.382796][ T393]
> > >  > [ 42.382796][ T393] other info that might help us debug this:
> > >  > [ 42.382796][ T393]
> > >  > [ 42.383515][ T393] Possible unsafe locking scenario:
> > >  > [ 42.383515][ T393]
> > >  > [ 42.384052][ T393] CPU0 CPU1
> > >  > [ 42.384428][ T393] ---- ----
> > >  > [ 42.384799][ T393] lock(&p->pi_lock);
> > >  > [ 42.385083][ T393] lock(rcu_tasks_trace_srcu_struct.srcu_wq.lock);
> > >  > [ 42.385707][ T393] lock(&p->pi_lock);
> > >  > [ 42.386180][ T393] lock(rcu_tasks_trace_srcu_struct.srcu_wq.lock);
> > >  > [ 42.386663][ T393]
> > >  > [ 42.386663][ T393] *** DEADLOCK ***
> > >  > [ 42.386663][ T393]
> > >  > [ 42.387236][ T393] 1 lock held by rcu_torture_rea/393:
> > >  > [ 42.387626][ T393] #0: ffff88813d1ff2e8 (&p->pi_lock){-.-.}-{2:2}, at: rcutorture_one_extend (kernel/rcu/rcutorture.c:?) rcutorture 
> > >  > [ 42.388419][ T393]
> > >  > [ 42.388419][ T393] stack backtrace:
> > >  > [ 42.388852][ T393] CPU: 0 UID: 0 PID: 393 Comm: rcu_torture_rea Tainted: G T 6.17.0-rc1-00035-g8bd938372706 #1 PREEMPT(full)
> > >  > [ 42.389758][ T393] Tainted: [T]=RANDSTRUCT
> > >  > [ 42.390057][ T393] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > >  > [ 42.390786][ T393] Call Trace:
> > >  > [ 42.391020][ T393] <TASK>
> > >  > [ 42.391225][ T393] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 2)) 
> > >  > [ 42.391544][ T393] print_circular_bug (kernel/locking/lockdep.c:2045) 
> > >  > [ 42.391898][ T393] check_noncircular (kernel/locking/lockdep.c:?) 
> > >  > [ 42.392242][ T393] __lock_acquire (kernel/locking/lockdep.c:3166) 
> > >  > [ 42.392594][ T393] ? __schedule (kernel/sched/sched.h:1531 (discriminator 1) kernel/sched/core.c:6969 (discriminator 1)) 
> > >  > [ 42.392930][ T393] ? lock_release (kernel/locking/lockdep.c:470 (discriminator 3)) 
> > >  > [ 42.393272][ T393] ? swake_up_one (kernel/sched/swait.c:52 (discriminator 1)) 
> > >  > [ 42.393610][ T393] lock_acquire (kernel/locking/lockdep.c:5868) 
> > >  > [ 42.393930][ T393] ? swake_up_one (kernel/sched/swait.c:52 (discriminator 1)) 
> > >  > [ 42.394264][ T393] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
> > >  > [ 42.394640][ T393] ? swake_up_one (kernel/sched/swait.c:52 (discriminator 1)) 
> > >  > [ 42.394969][ T393] swake_up_one (kernel/sched/swait.c:52 (discriminator 1)) 
> > >  > [ 42.395281][ T393] tasks_tracing_torture_read_unlock (include/linux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (discriminator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutorture 
> > >  > [ 42.395814][ T393] rcutorture_one_extend (kernel/rcu/rcutorture.c:2141) rcutorture 
> > >  > [ 42.396276][ T393] rcu_torture_one_read_end (kernel/rcu/rcutorture.c:2357) rcutorture 
> > >  > [ 42.396756][ T393] rcu_torture_one_read (kernel/rcu/rcutorture.c:?) rcutorture 
> > >  > [ 42.397219][ T393] ? __cfi_rcu_torture_reader (kernel/rcu/rcutorture.c:2426) rcutorture 
> > >  > [ 42.397690][ T393] rcu_torture_reader (kernel/rcu/rcutorture.c:2443) rcutorture 
> > >  > [ 42.398126][ T393] ? __cfi_rcu_torture_timer (kernel/rcu/rcutorture.c:2405) rcutorture 
> > >  > [ 42.398565][ T393] kthread (kernel/kthread.c:465) 
> > >  > [ 42.398857][ T393] ? __cfi_kthread (kernel/kthread.c:412) 
> > >  > [ 42.399169][ T393] ret_from_fork (arch/x86/kernel/process.c:154) 
> > >  > [ 42.399491][ T393] ? __cfi_kthread (kernel/kthread.c:412) 
> > >  > [ 42.399815][ T393] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
> > >  > [ 42.400151][ T393] </TASK>
> > >  > 
> > >  > 
> > >  > The kernel config and materials to reproduce are available at:
> > >  > https://download.01.org/0day-ci/archive/20250826/202508261642.b15eefbb-lkp@intel.com
> > >  > 
> > >  > 
> > >  > 
> > >  > -- 
> > >  > 0-DAY CI Kernel Test Service
> > >  > https://github.com/intel/lkp-tests/wiki
> > >  > 
> > >  ------------------------------------------------------------------------
> > >  
> > >  diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > >  index 6e9fe2ce1075d5..db63378f062051 100644
> > >  --- a/kernel/rcu/srcutiny.c
> > >  +++ b/kernel/rcu/srcutiny.c
> > >  @@ -106,7 +106,7 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
> > >  newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
> > >  WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
> > >  preempt_enable();
> > >  - if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task())
> > >  + if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task() && !irqs_disabled())
> > >  
> > >  
> > >  The fllowing case may exist:
> > >  
> > >  
> > >  CPU0
> > >  
> > >  task1:
> > >  __srcu_read_lock()
> > > 
> > For mainline kernels, here we must have blocked, correct?
> > 
> > In -rcu, there is of course:
> > 
> > 740cda2fe1a9 ("EXP srcu: Enable Tiny SRCU On all CONFIG_SMP=n kernels")
> > 
> > And this means that in -rcu kernels built with CONFIG_PREEMPT_NONE=y,
> > we could be preempted.
> > 
> > And maybe this is a reason to drop this commit. Or...
> > 
> 
> For tiny srcu, even if the preempt schedule not happend in
> srcu read ctrical section, we can still do voluntary
> scheduling in srcu_read ctrical section, this case is
> also still happend.
> 
> > > 
> > > ....
> > >  
> > >  
> > >  task2 preempt run:
> > >  
> > >  srcu_drive_gp()
> > >  ->swait_event_exclusive()
> > >  
> > >  
> > >  ....
> > >  task1 continue run:
> > >  ....
> > >  raw_spin_lock_irqsave
> > >  __srcu_read_unlock()
> > >  ->find all previours condition are met
> > >  but the irqs_disable() return true,
> > >  not invoke swake_up_one().
> > >  
> > >  task2 maybe always hung.
> > > 
> > The bug that kernel test robot reported existed for a long time.
> > The offending commit simply introduced the use case that exercised
> > this bug. So we do need a fix.
> > 
> > One approach would be to impose a rule like we used to have for RCU,
> > namely that if interrupts were disabled across srcu_read_unlock(),
> > then they must have been disabled since the matching srcu_read_lock().
> > Another would be to make the current swait_event_exclusive() in
> > srcu_drive_gp() instead be a loop around wait_event_timeout_exclusive()
> > that checks ssp->srcu_lock_nesting[].
> > 
> > But is there a better way?
> 
> I think the second approach is enough :) 

Hmmm...  OK, how about the incremental patch below?

							Thanx, Paul

------------------------------------------------------------------------

commit a543d73eeaa491021040a02bdf0e8a9148b5c186
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Sun Aug 31 09:38:44 2025 -0700

    squash! rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast
    
    [ paulmck: Apply Zqiang feedback. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index db63378f062051..b52ec45698e85b 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -113,8 +113,8 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
 /*
  * Workqueue handler to drive one grace period and invoke any callbacks
- * that become ready as a result.  Single-CPU and !PREEMPTION operation
- * means that we get away with murder on synchronization.  ;-)
+ * that become ready as a result.  Single-CPU operation and preemption
+ * disabling mean that we get away with murder on synchronization.  ;-)
  */
 void srcu_drive_gp(struct work_struct *wp)
 {
@@ -141,7 +141,12 @@ void srcu_drive_gp(struct work_struct *wp)
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
 	preempt_enable();
-	swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
+	do {
+		// Deadlock issues prevent __srcu_read_unlock() from
+		// doing an unconditional wakeup, so polling is required.
+		swait_event_timeout_exclusive(ssp->srcu_wq,
+					      !READ_ONCE(ssp->srcu_lock_nesting[idx]), HZ / 10);
+	} while (READ_ONCE(ssp->srcu_lock_nesting[idx]));
 	preempt_disable();  // Needed for PREEMPT_LAZY
 	WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
