Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FB61A7253
	for <rcu@vger.kernel.org>; Sun, 31 Aug 2025 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756606992; cv=none; b=SS+XpLTPk6Med5CEdKJSgeNjjZGr0dyqOTYy9jbebGYORA8eWu0eJputpW2kzxWChQ2H7WMf7a1wPrIW+9/XOrdctQe6dTMrkpkrvogCVEqRqRHAKg9vL3wUJZgFrdomW/4jS9Vg99tS16LDdy4MZ5hhLjOtmbUO5U0sayAGzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756606992; c=relaxed/simple;
	bh=B1iHHWzuxbPFLEOHlpBal++39YyPgok9bAD18xgVKc0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=gjc5M6jHzS7EES2fM+6T7eORD3LOP3IqfI2hVT64Exf6UKfb7ea+c3mBW8jww8kz//kLMt4Y2BU3NTG3nklMzLJKmFG+Hyt/oG7d3OYrcw4RSKhT1Gdwu2c/xaHtsPvxMl2DXn7k9pHdnvSKW89ZOgrcU/HCWaNnmYn2A2TBdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O1NtuCfc; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O1NtuCfc"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756606977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sh7iIOS0yCtIXK27ggEWbI7wTjuMikl0yzjSB6hdsBM=;
	b=O1NtuCfcKR4QEgbGIOJrc864bDQDu0U0DvHduv8TfS8wu5kogvuSTib7McjiI4PmQ8a6qI
	GgnqMUpZ8KynBmyWX3xYsHzDajqMI9SSRiNxG/AIJLHtG8r1GcJHw5zK6Z9Fo8SsGI2GBR
	Z8bCECgbTlbKl4VcEVR61Mc0taJXwOc=
Date: Sun, 31 Aug 2025 02:22:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <aefc893f1b7c17049c2e6eb2256a97739a5e328d@linux.dev>
TLS-Required: No
Subject: Re: [paulmckrcu:dev.2025.08.21a] [rcu] 8bd9383727:
 WARNING:possible_circular_locking_dependency_detected
To: paulmck@kernel.org
Cc: "kernel test robot" <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, "Andrii Nakryiko" <andrii@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <f58f7c75-46be-4ddd-be70-ee4f6a3370a9@paulmck-laptop>
References: <202508261642.b15eefbb-lkp@intel.com>
 <2853a174-76e4-440b-bfc1-71ea30694822@paulmck-laptop>
 <eb1e5ab00253fdae5ba5aa4c97d60a79d357dbfd@linux.dev>
 <f58f7c75-46be-4ddd-be70-ee4f6a3370a9@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Sat, Aug 30, 2025 at 02:38:35AM +0000, Zqiang wrote:
>=20
>=20>=20
>=20> On Tue, Aug 26, 2025 at 04:47:22PM +0800, kernel test robot wrote:
> >=20=20
>=20>  >=20
>=20>  > hi, Paul,
> >  >=20
>=20>  > the similar issue still exists on this dev.2025.08.21a branch.
> >  > again, if the issue is already fixed on later branches, please jus=
t ignore.
> >  > thanks
> >  >=20
>=20>  >=20
>=20>  > Hello,
> >  >=20
>=20>  > kernel test robot noticed "WARNING:possible_circular_locking_dep=
endency_detected" on:
> >  >=20
>=20>  > commit: 8bd9383727068a5a18acfecefbdfa44a7d6bd838 ("rcu: Re-imple=
ment RCU Tasks Trace in terms of SRCU-fast")
> >  > https://github.com/paulmckrcu/linux dev.2025.08.21a
> >  >=20
>=20>  > in testcase: rcutorture
> >  > version:=20
>=20>  > with following parameters:
> >  >=20
>=20>  > runtime: 300s
> >  > test: default
> >  > torture_type: tasks-tracing
> >  >=20
>=20>  >=20
>=20>  >=20
>=20>  > config: x86_64-randconfig-003-20250824
> >  > compiler: clang-20
> >  > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp=
 2 -m 16G
> >  >=20
>=20>  > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >  >=20
>=20>  Again, apologies for being slow, and thank you for your testing ef=
forts.
> >=20=20
>=20>  Idiot here forgot about Tiny SRCU, so please see the end of this e=
mail
> >  for an alleged fix. Does it do the trick for you?
> >=20=20
>=20>  Thanx, Paul
> >=20=20
>=20>  >=20
>=20>  > If you fix the issue in a separate patch/commit (i.e. not just a=
 new version of
> >  > the same patch/commit), kindly add following tags
> >  > | Reported-by: kernel test robot <oliver.sang@intel.com>
> >  > | Closes: https://lore.kernel.org/oe-lkp/202508261642.b15eefbb-lkp=
@intel.com
> >  >=20
>=20>  >=20
>=20>  > [ 42.365933][ T393] WARNING: possible circular locking dependenc=
y detected
> >  > [ 42.366428][ T393] 6.17.0-rc1-00035-g8bd938372706 #1 Tainted: G T
> >  > [ 42.366985][ T393] ----------------------------------------------=
--------
> >  > [ 42.367490][ T393] rcu_torture_rea/393 is trying to acquire lock:
> >  > [ 42.367952][ T393] ffffffffad41dc88 (rcu_tasks_trace_srcu_struct.=
srcu_wq.lock){....}-{2:2}, at: swake_up_one (kernel/sched/swait.c:52 (dis=
criminator 1))=20
>=20>  > [ 42.368775][ T393]
> >  > [ 42.368775][ T393] but task is already holding lock:
> >  > [ 42.369278][ T393] ffff88813d1ff2e8 (&p->pi_lock){-.-.}-{2:2}, at=
: rcutorture_one_extend (kernel/rcu/rcutorture.c:?) rcutorture=20
>=20>  > [ 42.370043][ T393]
> >  > [ 42.370043][ T393] which lock already depends on the new lock.
> >  > [ 42.370043][ T393]
> >  > [ 42.370755][ T393]
> >  > [ 42.370755][ T393] the existing dependency chain (in reverse orde=
r) is:
> >  > [ 42.371388][ T393]
> >  > [ 42.371388][ T393] -> #1 (&p->pi_lock){-.-.}-{2:2}:
> >  > [ 42.371903][ T393] _raw_spin_lock_irqsave (include/linux/spinlock=
_api_smp.h:110 kernel/locking/spinlock.c:162)=20
>=20>  > [ 42.372309][ T393] try_to_wake_up (include/linux/spinlock.h:557=
 (discriminator 1) kernel/sched/core.c:4216 (discriminator 1))=20
>=20>  > [ 42.372669][ T393] swake_up_locked (include/linux/list.h:111)=
=20
>=20>  > [ 42.373029][ T393] swake_up_one (kernel/sched/swait.c:54 (discr=
iminator 1))=20
>=20>  > [ 42.373380][ T393] tasks_tracing_torture_read_unlock (include/l=
inux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (disc=
riminator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutorture=
=20
>=20>  > [ 42.373952][ T393] rcutorture_one_extend (kernel/rcu/rcutorture=
.c:2141) rcutorture=20
>=20>  > [ 42.374452][ T393] rcu_torture_one_read_end (kernel/rcu/rcutort=
ure.c:2357) rcutorture=20
>=20>  > [ 42.374976][ T393] rcu_torture_one_read (kernel/rcu/rcutorture.=
c:?) rcutorture=20
>=20>  > [ 42.375460][ T393] rcu_torture_reader (kernel/rcu/rcutorture.c:=
2443) rcutorture=20
>=20>  > [ 42.375920][ T393] kthread (kernel/kthread.c:465)=20
>=20>  > [ 42.376241][ T393] ret_from_fork (arch/x86/kernel/process.c:154=
)=20
>=20>  > [ 42.376603][ T393] ret_from_fork_asm (arch/x86/entry/entry_64.S=
:255)=20
>=20>  > [ 42.376973][ T393]
> >  > [ 42.376973][ T393] -> #0 (rcu_tasks_trace_srcu_struct.srcu_wq.loc=
k){....}-{2:2}:
> >  > [ 42.377657][ T393] __lock_acquire (kernel/locking/lockdep.c:3166)=
=20
>=20>  > [ 42.378031][ T393] lock_acquire (kernel/locking/lockdep.c:5868)=
=20
>=20>  > [ 42.378378][ T393] _raw_spin_lock_irqsave (include/linux/spinlo=
ck_api_smp.h:110 kernel/locking/spinlock.c:162)=20
>=20>  > [ 42.378794][ T393] swake_up_one (kernel/sched/swait.c:52 (discr=
iminator 1))=20
>=20>  > [ 42.379152][ T393] tasks_tracing_torture_read_unlock (include/l=
inux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (disc=
riminator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutorture=
=20
>=20>  > [ 42.379714][ T393] rcutorture_one_extend (kernel/rcu/rcutorture=
.c:2141) rcutorture=20
>=20>  > [ 42.380217][ T393] rcu_torture_one_read_end (kernel/rcu/rcutort=
ure.c:2357) rcutorture=20
>=20>  > [ 42.380731][ T393] rcu_torture_one_read (kernel/rcu/rcutorture.=
c:?) rcutorture=20
>=20>  > [ 42.381220][ T393] rcu_torture_reader (kernel/rcu/rcutorture.c:=
2443) rcutorture=20
>=20>  > [ 42.381714][ T393] kthread (kernel/kthread.c:465)=20
>=20>  > [ 42.382060][ T393] ret_from_fork (arch/x86/kernel/process.c:154=
)=20
>=20>  > [ 42.382420][ T393] ret_from_fork_asm (arch/x86/entry/entry_64.S=
:255)=20
>=20>  > [ 42.382796][ T393]
> >  > [ 42.382796][ T393] other info that might help us debug this:
> >  > [ 42.382796][ T393]
> >  > [ 42.383515][ T393] Possible unsafe locking scenario:
> >  > [ 42.383515][ T393]
> >  > [ 42.384052][ T393] CPU0 CPU1
> >  > [ 42.384428][ T393] ---- ----
> >  > [ 42.384799][ T393] lock(&p->pi_lock);
> >  > [ 42.385083][ T393] lock(rcu_tasks_trace_srcu_struct.srcu_wq.lock)=
;
> >  > [ 42.385707][ T393] lock(&p->pi_lock);
> >  > [ 42.386180][ T393] lock(rcu_tasks_trace_srcu_struct.srcu_wq.lock)=
;
> >  > [ 42.386663][ T393]
> >  > [ 42.386663][ T393] *** DEADLOCK ***
> >  > [ 42.386663][ T393]
> >  > [ 42.387236][ T393] 1 lock held by rcu_torture_rea/393:
> >  > [ 42.387626][ T393] #0: ffff88813d1ff2e8 (&p->pi_lock){-.-.}-{2:2}=
, at: rcutorture_one_extend (kernel/rcu/rcutorture.c:?) rcutorture=20
>=20>  > [ 42.388419][ T393]
> >  > [ 42.388419][ T393] stack backtrace:
> >  > [ 42.388852][ T393] CPU: 0 UID: 0 PID: 393 Comm: rcu_torture_rea T=
ainted: G T 6.17.0-rc1-00035-g8bd938372706 #1 PREEMPT(full)
> >  > [ 42.389758][ T393] Tainted: [T]=3DRANDSTRUCT
> >  > [ 42.390057][ T393] Hardware name: QEMU Standard PC (i440FX + PIIX=
, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> >  > [ 42.390786][ T393] Call Trace:
> >  > [ 42.391020][ T393] <TASK>
> >  > [ 42.391225][ T393] dump_stack_lvl (lib/dump_stack.c:123 (discrimi=
nator 2))=20
>=20>  > [ 42.391544][ T393] print_circular_bug (kernel/locking/lockdep.c=
:2045)=20
>=20>  > [ 42.391898][ T393] check_noncircular (kernel/locking/lockdep.c:=
?)=20
>=20>  > [ 42.392242][ T393] __lock_acquire (kernel/locking/lockdep.c:316=
6)=20
>=20>  > [ 42.392594][ T393] ? __schedule (kernel/sched/sched.h:1531 (dis=
criminator 1) kernel/sched/core.c:6969 (discriminator 1))=20
>=20>  > [ 42.392930][ T393] ? lock_release (kernel/locking/lockdep.c:470=
 (discriminator 3))=20
>=20>  > [ 42.393272][ T393] ? swake_up_one (kernel/sched/swait.c:52 (dis=
criminator 1))=20
>=20>  > [ 42.393610][ T393] lock_acquire (kernel/locking/lockdep.c:5868)=
=20
>=20>  > [ 42.393930][ T393] ? swake_up_one (kernel/sched/swait.c:52 (dis=
criminator 1))=20
>=20>  > [ 42.394264][ T393] _raw_spin_lock_irqsave (include/linux/spinlo=
ck_api_smp.h:110 kernel/locking/spinlock.c:162)=20
>=20>  > [ 42.394640][ T393] ? swake_up_one (kernel/sched/swait.c:52 (dis=
criminator 1))=20
>=20>  > [ 42.394969][ T393] swake_up_one (kernel/sched/swait.c:52 (discr=
iminator 1))=20
>=20>  > [ 42.395281][ T393] tasks_tracing_torture_read_unlock (include/l=
inux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (disc=
riminator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutorture=
=20
>=20>  > [ 42.395814][ T393] rcutorture_one_extend (kernel/rcu/rcutorture=
.c:2141) rcutorture=20
>=20>  > [ 42.396276][ T393] rcu_torture_one_read_end (kernel/rcu/rcutort=
ure.c:2357) rcutorture=20
>=20>  > [ 42.396756][ T393] rcu_torture_one_read (kernel/rcu/rcutorture.=
c:?) rcutorture=20
>=20>  > [ 42.397219][ T393] ? __cfi_rcu_torture_reader (kernel/rcu/rcuto=
rture.c:2426) rcutorture=20
>=20>  > [ 42.397690][ T393] rcu_torture_reader (kernel/rcu/rcutorture.c:=
2443) rcutorture=20
>=20>  > [ 42.398126][ T393] ? __cfi_rcu_torture_timer (kernel/rcu/rcutor=
ture.c:2405) rcutorture=20
>=20>  > [ 42.398565][ T393] kthread (kernel/kthread.c:465)=20
>=20>  > [ 42.398857][ T393] ? __cfi_kthread (kernel/kthread.c:412)=20
>=20>  > [ 42.399169][ T393] ret_from_fork (arch/x86/kernel/process.c:154=
)=20
>=20>  > [ 42.399491][ T393] ? __cfi_kthread (kernel/kthread.c:412)=20
>=20>  > [ 42.399815][ T393] ret_from_fork_asm (arch/x86/entry/entry_64.S=
:255)=20
>=20>  > [ 42.400151][ T393] </TASK>
> >  >=20
>=20>  >=20
>=20>  > The kernel config and materials to reproduce are available at:
> >  > https://download.01.org/0day-ci/archive/20250826/202508261642.b15e=
efbb-lkp@intel.com
> >  >=20
>=20>  >=20
>=20>  >=20
>=20>  > --=20
>=20>  > 0-DAY CI Kernel Test Service
> >  > https://github.com/intel/lkp-tests/wiki
> >  >=20
>=20>  ------------------------------------------------------------------=
------
> >=20=20
>=20>  diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> >  index 6e9fe2ce1075d5..db63378f062051 100644
> >  --- a/kernel/rcu/srcutiny.c
> >  +++ b/kernel/rcu/srcutiny.c
> >  @@ -106,7 +106,7 @@ void __srcu_read_unlock(struct srcu_struct *ssp,=
 int idx)
> >  newval =3D READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
> >  WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
> >  preempt_enable();
> >  - if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task())
> >  + if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task() && !ir=
qs_disabled())
> >=20=20
>=20>=20=20
>=20>  The fllowing case may exist:
> >=20=20
>=20>=20=20
>=20>  CPU0
> >=20=20
>=20>  task1:
> >  __srcu_read_lock()
> >=20
>=20For mainline kernels, here we must have blocked, correct?
>=20
>=20In -rcu, there is of course:
>=20
>=20740cda2fe1a9 ("EXP srcu: Enable Tiny SRCU On all CONFIG_SMP=3Dn kerne=
ls")
>=20
>=20And this means that in -rcu kernels built with CONFIG_PREEMPT_NONE=3D=
y,
> we could be preempted.
>=20
>=20And maybe this is a reason to drop this commit. Or...
>=20

For=20tiny srcu, even if the preempt schedule not happend in
srcu read ctrical section, we can still do voluntary
scheduling in srcu_read ctrical section, this case is
also still happend.

> >=20
>=20> ....
> >=20=20
>=20>=20=20
>=20>  task2 preempt run:
> >=20=20
>=20>  srcu_drive_gp()
> >  ->swait_event_exclusive()
> >=20=20
>=20>=20=20
>=20>  ....
> >  task1 continue run:
> >  ....
> >  raw_spin_lock_irqsave
> >  __srcu_read_unlock()
> >  ->find all previours condition are met
> >  but the irqs_disable() return true,
> >  not invoke swake_up_one().
> >=20=20
>=20>  task2 maybe always hung.
> >=20
>=20The bug that kernel test robot reported existed for a long time.
> The offending commit simply introduced the use case that exercised
> this bug. So we do need a fix.
>=20
>=20One approach would be to impose a rule like we used to have for RCU,
> namely that if interrupts were disabled across srcu_read_unlock(),
> then they must have been disabled since the matching srcu_read_lock().
> Another would be to make the current swait_event_exclusive() in
> srcu_drive_gp() instead be a loop around wait_event_timeout_exclusive()
> that checks ssp->srcu_lock_nesting[].
>=20
>=20But is there a better way?

I think the second approach is enough :)=20

Thanks
Zqiang

>=20
> Either way, good catch! And thank you!!!
>=20
>=20 Thanx, Paul
>
