Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C594A257AC1
	for <rcu@vger.kernel.org>; Sat, 30 Aug 2025 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756521524; cv=none; b=TN5x0CwdgUgOTZhiiJWBoCOrqKElunnutCCdVM79cFndbwtdDEHHzqyHsWjQE4BvJCxl890RdJVv7drDzdWJU+tuQtf4OokIAO9ACuSm7L6aTsJLru/4qRozmXzjkUhn9wy2s4ivKLVp970tEKP0288ShLhu6Z7C2D36rM/Gg5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756521524; c=relaxed/simple;
	bh=ZrxY/T497WViSyYcPBN0k3b1BX8glBWIGhEoJI8l4Y0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Dq4HQeuE6Hj1mVcXRimJ59e8InMvWJIwQI8dZkhCljAUZpWtZ7FXWLikFurRYhAqbynjzT5Myn4uZ73H6f6VLslSovzZNlOreHRX1uPj3VF8MRzzlDIPHfwgecJHQNKjeNxLGFXbjkBRdcALt/6O9e3PG8/B3kMWyx9aftmAKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NxKX7b2g; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NxKX7b2g"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756521519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3HlS0q3aWTQp3Y5wA/UhCdM2MmBWqeMaQpbJgbPjOU=;
	b=NxKX7b2g8sJmCf4+mizfE2WT4qIaYqc+757W0gK0Msc3emK+Tpr1WqiqI3jL/aiaLgTEfO
	ngoVT3EBVDmngGjT54Dnas/QsCdLsys7YWlcMgLc7/GjkM7aHYmCDkOzTVGHz5LzmEhL3S
	nM8oB5u7N/EzlZCKzIEL2aZGD0+80gQ=
Date: Sat, 30 Aug 2025 02:38:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <eb1e5ab00253fdae5ba5aa4c97d60a79d357dbfd@linux.dev>
TLS-Required: No
Subject: Re: [paulmckrcu:dev.2025.08.21a] [rcu] 8bd9383727:
 WARNING:possible_circular_locking_dependency_detected
To: paulmck@kernel.org, "kernel test robot" <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, "Andrii Nakryiko"
 <andrii@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <2853a174-76e4-440b-bfc1-71ea30694822@paulmck-laptop>
References: <202508261642.b15eefbb-lkp@intel.com>
 <2853a174-76e4-440b-bfc1-71ea30694822@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Tue, Aug 26, 2025 at 04:47:22PM +0800, kernel test robot wrote:
>=20
>=20>=20
>=20> hi, Paul,
> >=20=20
>=20>  the similar issue still exists on this dev.2025.08.21a branch.
> >  again, if the issue is already fixed on later branches, please just =
ignore.
> >  thanks
> >=20=20
>=20>=20=20
>=20>  Hello,
> >=20=20
>=20>  kernel test robot noticed "WARNING:possible_circular_locking_depen=
dency_detected" on:
> >=20=20
>=20>  commit: 8bd9383727068a5a18acfecefbdfa44a7d6bd838 ("rcu: Re-impleme=
nt RCU Tasks Trace in terms of SRCU-fast")
> >  https://github.com/paulmckrcu/linux dev.2025.08.21a
> >=20=20
>=20>  in testcase: rcutorture
> >  version:=20
>=20>  with following parameters:
> >=20=20
>=20>  runtime: 300s
> >  test: default
> >  torture_type: tasks-tracing
> >=20=20
>=20>=20=20
>=20>=20=20
>=20>  config: x86_64-randconfig-003-20250824
> >  compiler: clang-20
> >  test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2=
 -m 16G
> >=20=20
>=20>  (please refer to attached dmesg/kmsg for entire log/backtrace)
> >=20
>=20Again, apologies for being slow, and thank you for your testing effor=
ts.
>=20
>=20Idiot here forgot about Tiny SRCU, so please see the end of this emai=
l
> for an alleged fix. Does it do the trick for you?
>=20
>=20 Thanx, Paul
>=20
>=20>=20
>=20> If you fix the issue in a separate patch/commit (i.e. not just a ne=
w version of
> >  the same patch/commit), kindly add following tags
> >  | Reported-by: kernel test robot <oliver.sang@intel.com>
> >  | Closes: https://lore.kernel.org/oe-lkp/202508261642.b15eefbb-lkp@i=
ntel.com
> >=20=20
>=20>=20=20
>=20>  [ 42.365933][ T393] WARNING: possible circular locking dependency =
detected
> >  [ 42.366428][ T393] 6.17.0-rc1-00035-g8bd938372706 #1 Tainted: G T
> >  [ 42.366985][ T393] ------------------------------------------------=
------
> >  [ 42.367490][ T393] rcu_torture_rea/393 is trying to acquire lock:
> >  [ 42.367952][ T393] ffffffffad41dc88 (rcu_tasks_trace_srcu_struct.sr=
cu_wq.lock){....}-{2:2}, at: swake_up_one (kernel/sched/swait.c:52 (discr=
iminator 1))=20
>=20>  [ 42.368775][ T393]
> >  [ 42.368775][ T393] but task is already holding lock:
> >  [ 42.369278][ T393] ffff88813d1ff2e8 (&p->pi_lock){-.-.}-{2:2}, at: =
rcutorture_one_extend (kernel/rcu/rcutorture.c:?) rcutorture=20
>=20>  [ 42.370043][ T393]
> >  [ 42.370043][ T393] which lock already depends on the new lock.
> >  [ 42.370043][ T393]
> >  [ 42.370755][ T393]
> >  [ 42.370755][ T393] the existing dependency chain (in reverse order)=
 is:
> >  [ 42.371388][ T393]
> >  [ 42.371388][ T393] -> #1 (&p->pi_lock){-.-.}-{2:2}:
> >  [ 42.371903][ T393] _raw_spin_lock_irqsave (include/linux/spinlock_a=
pi_smp.h:110 kernel/locking/spinlock.c:162)=20
>=20>  [ 42.372309][ T393] try_to_wake_up (include/linux/spinlock.h:557 (=
discriminator 1) kernel/sched/core.c:4216 (discriminator 1))=20
>=20>  [ 42.372669][ T393] swake_up_locked (include/linux/list.h:111)=20
>=20>  [ 42.373029][ T393] swake_up_one (kernel/sched/swait.c:54 (discrim=
inator 1))=20
>=20>  [ 42.373380][ T393] tasks_tracing_torture_read_unlock (include/lin=
ux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (discri=
minator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutorture=20
>=20>  [ 42.373952][ T393] rcutorture_one_extend (kernel/rcu/rcutorture.c=
:2141) rcutorture=20
>=20>  [ 42.374452][ T393] rcu_torture_one_read_end (kernel/rcu/rcutortur=
e.c:2357) rcutorture=20
>=20>  [ 42.374976][ T393] rcu_torture_one_read (kernel/rcu/rcutorture.c:=
?) rcutorture=20
>=20>  [ 42.375460][ T393] rcu_torture_reader (kernel/rcu/rcutorture.c:24=
43) rcutorture=20
>=20>  [ 42.375920][ T393] kthread (kernel/kthread.c:465)=20
>=20>  [ 42.376241][ T393] ret_from_fork (arch/x86/kernel/process.c:154)=
=20
>=20>  [ 42.376603][ T393] ret_from_fork_asm (arch/x86/entry/entry_64.S:2=
55)=20
>=20>  [ 42.376973][ T393]
> >  [ 42.376973][ T393] -> #0 (rcu_tasks_trace_srcu_struct.srcu_wq.lock)=
{....}-{2:2}:
> >  [ 42.377657][ T393] __lock_acquire (kernel/locking/lockdep.c:3166)=
=20
>=20>  [ 42.378031][ T393] lock_acquire (kernel/locking/lockdep.c:5868)=
=20
>=20>  [ 42.378378][ T393] _raw_spin_lock_irqsave (include/linux/spinlock=
_api_smp.h:110 kernel/locking/spinlock.c:162)=20
>=20>  [ 42.378794][ T393] swake_up_one (kernel/sched/swait.c:52 (discrim=
inator 1))=20
>=20>  [ 42.379152][ T393] tasks_tracing_torture_read_unlock (include/lin=
ux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (discri=
minator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutorture=20
>=20>  [ 42.379714][ T393] rcutorture_one_extend (kernel/rcu/rcutorture.c=
:2141) rcutorture=20
>=20>  [ 42.380217][ T393] rcu_torture_one_read_end (kernel/rcu/rcutortur=
e.c:2357) rcutorture=20
>=20>  [ 42.380731][ T393] rcu_torture_one_read (kernel/rcu/rcutorture.c:=
?) rcutorture=20
>=20>  [ 42.381220][ T393] rcu_torture_reader (kernel/rcu/rcutorture.c:24=
43) rcutorture=20
>=20>  [ 42.381714][ T393] kthread (kernel/kthread.c:465)=20
>=20>  [ 42.382060][ T393] ret_from_fork (arch/x86/kernel/process.c:154)=
=20
>=20>  [ 42.382420][ T393] ret_from_fork_asm (arch/x86/entry/entry_64.S:2=
55)=20
>=20>  [ 42.382796][ T393]
> >  [ 42.382796][ T393] other info that might help us debug this:
> >  [ 42.382796][ T393]
> >  [ 42.383515][ T393] Possible unsafe locking scenario:
> >  [ 42.383515][ T393]
> >  [ 42.384052][ T393] CPU0 CPU1
> >  [ 42.384428][ T393] ---- ----
> >  [ 42.384799][ T393] lock(&p->pi_lock);
> >  [ 42.385083][ T393] lock(rcu_tasks_trace_srcu_struct.srcu_wq.lock);
> >  [ 42.385707][ T393] lock(&p->pi_lock);
> >  [ 42.386180][ T393] lock(rcu_tasks_trace_srcu_struct.srcu_wq.lock);
> >  [ 42.386663][ T393]
> >  [ 42.386663][ T393] *** DEADLOCK ***
> >  [ 42.386663][ T393]
> >  [ 42.387236][ T393] 1 lock held by rcu_torture_rea/393:
> >  [ 42.387626][ T393] #0: ffff88813d1ff2e8 (&p->pi_lock){-.-.}-{2:2}, =
at: rcutorture_one_extend (kernel/rcu/rcutorture.c:?) rcutorture=20
>=20>  [ 42.388419][ T393]
> >  [ 42.388419][ T393] stack backtrace:
> >  [ 42.388852][ T393] CPU: 0 UID: 0 PID: 393 Comm: rcu_torture_rea Tai=
nted: G T 6.17.0-rc1-00035-g8bd938372706 #1 PREEMPT(full)
> >  [ 42.389758][ T393] Tainted: [T]=3DRANDSTRUCT
> >  [ 42.390057][ T393] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> >  [ 42.390786][ T393] Call Trace:
> >  [ 42.391020][ T393] <TASK>
> >  [ 42.391225][ T393] dump_stack_lvl (lib/dump_stack.c:123 (discrimina=
tor 2))=20
>=20>  [ 42.391544][ T393] print_circular_bug (kernel/locking/lockdep.c:2=
045)=20
>=20>  [ 42.391898][ T393] check_noncircular (kernel/locking/lockdep.c:?)=
=20
>=20>  [ 42.392242][ T393] __lock_acquire (kernel/locking/lockdep.c:3166)=
=20
>=20>  [ 42.392594][ T393] ? __schedule (kernel/sched/sched.h:1531 (discr=
iminator 1) kernel/sched/core.c:6969 (discriminator 1))=20
>=20>  [ 42.392930][ T393] ? lock_release (kernel/locking/lockdep.c:470 (=
discriminator 3))=20
>=20>  [ 42.393272][ T393] ? swake_up_one (kernel/sched/swait.c:52 (discr=
iminator 1))=20
>=20>  [ 42.393610][ T393] lock_acquire (kernel/locking/lockdep.c:5868)=
=20
>=20>  [ 42.393930][ T393] ? swake_up_one (kernel/sched/swait.c:52 (discr=
iminator 1))=20
>=20>  [ 42.394264][ T393] _raw_spin_lock_irqsave (include/linux/spinlock=
_api_smp.h:110 kernel/locking/spinlock.c:162)=20
>=20>  [ 42.394640][ T393] ? swake_up_one (kernel/sched/swait.c:52 (discr=
iminator 1))=20
>=20>  [ 42.394969][ T393] swake_up_one (kernel/sched/swait.c:52 (discrim=
inator 1))=20
>=20>  [ 42.395281][ T393] tasks_tracing_torture_read_unlock (include/lin=
ux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (discri=
minator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutorture=20
>=20>  [ 42.395814][ T393] rcutorture_one_extend (kernel/rcu/rcutorture.c=
:2141) rcutorture=20
>=20>  [ 42.396276][ T393] rcu_torture_one_read_end (kernel/rcu/rcutortur=
e.c:2357) rcutorture=20
>=20>  [ 42.396756][ T393] rcu_torture_one_read (kernel/rcu/rcutorture.c:=
?) rcutorture=20
>=20>  [ 42.397219][ T393] ? __cfi_rcu_torture_reader (kernel/rcu/rcutort=
ure.c:2426) rcutorture=20
>=20>  [ 42.397690][ T393] rcu_torture_reader (kernel/rcu/rcutorture.c:24=
43) rcutorture=20
>=20>  [ 42.398126][ T393] ? __cfi_rcu_torture_timer (kernel/rcu/rcutortu=
re.c:2405) rcutorture=20
>=20>  [ 42.398565][ T393] kthread (kernel/kthread.c:465)=20
>=20>  [ 42.398857][ T393] ? __cfi_kthread (kernel/kthread.c:412)=20
>=20>  [=2042.399169][ T393] ret_from_fork (arch/x86/kernel/process.c:154=
)=20
>=20>  [ 42.399491][ T393] ? __cfi_kthread (kernel/kthread.c:412)=20
>=20>  [ 42.399815][ T393] ret_from_fork_asm (arch/x86/entry/entry_64.S:2=
55)=20
>=20>  [ 42.400151][ T393] </TASK>
> >=20=20
>=20>=20=20
>=20>  The kernel config and materials to reproduce are available at:
> >  https://download.01.org/0day-ci/archive/20250826/202508261642.b15eef=
bb-lkp@intel.com
> >=20=20
>=20>=20=20
>=20>=20=20
>=20>  --=20
>=20>  0-DAY CI Kernel Test Service
> >  https://github.com/intel/lkp-tests/wiki
> >=20
>=20---------------------------------------------------------------------=
---
>=20
>=20diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 6e9fe2ce1075d5..db63378f062051 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -106,7 +106,7 @@ void __srcu_read_unlock(struct srcu_struct *ssp, in=
t idx)
>  newval =3D READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
>  WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
>  preempt_enable();
> - if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task())
> + if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task() && !irqs_=
disabled())


The fllowing case may exist:


CPU0

task1:
__srcu_read_lock()
....


task2 preempt run:

 srcu_drive_gp()
 ->swait_event_exclusive()


....
task1 continue run:
....
raw_spin_lock_irqsave
__srcu_read_unlock()
->find all previours condition are met
  but the irqs_disable() return true,
  not invoke swake_up_one().



task2 maybe always hung.

Thanks
Zqiang





>  swake_up_one(&ssp->srcu_wq);
>  }
>  EXPORT_SYMBOL_GPL(__srcu_read_unlock);
>
