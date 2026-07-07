Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3313F88BA
	for <rcu@vger.kernel.org>; Tue,  7 Jul 2026 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429770; cv=none; b=N4vVra76mVWHgmzPK53qRSUQ6mIh7yKFcadbFOri2o9N1FwJX2rcQuuAzSVAZVwmvhKnFtIX3hqP2ebYhhllCFWkZKcYDj/3hNDpFMGlcCEEJM9Wf5/SV4wBtLwhEOctDFpNI4359kkkROQZMhWMC/gNckhznoMQtoFLNX3g+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429770; c=relaxed/simple;
	bh=0Zep3N1l98Pty0QpJ6A0nKaJqotR86JHcbrMu0p4HN0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=NfFn+Kz7h5UazWf83+CMuxUB7cUMSzw2CIcGSmKtus78ypyEH0PdWIxm2KnWAYqrdPKPYQbSydprvQcHYvJbvFQvyZD/hm75gmF7JJPCtTLzR8azAde/wMCQ3xc0znhI0KC7xDR0YO8h1mcYbfOHru44CldgRvqxO+bT+OJUoBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S+i6Wyb5; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S+i6Wyb5"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783429765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kVAHr4FItfBo57hhdnJWi5nZ0ihNrBagdKIid3NblMA=;
	b=S+i6Wyb50XObWfeeYw5R5iSZyV3vT2fHU0AVZQ2g8GH8niX7uK6negwLNUAJcYsnBRi4n5
	Ziv7QfHI4E9LT2uil/P5qNXbJCz2OzimJoyjeSxoi3tet9MWkAGuLbKvGE9qmGkGJLZDDY
	m03011TjysK75ZiXqLqevnYdEKOlksw=
Date: Tue, 07 Jul 2026 13:09:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <7b56bf2752621d6b845fb0d3086300e057e95aa2@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcu-tasks: Remove unused struct
 rcu_tasks's->n_ipis_fails variables
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <cb922347-ff9c-407e-a774-054e0117ac52@paulmck-laptop>
References: <20260706100310.19735-1-qiang.zhang@linux.dev>
 <cb922347-ff9c-407e-a774-054e0117ac52@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Mon, Jul 06, 2026 at 06:03:09PM +0800, Zqiang wrote:
>=20
>=20>=20
>=20> The RCU tasks trace has been reimplemented by 'commit c27cea4416a3
> >  ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")', the
> >  rcu_tasks structure's->n_ipis_fails is no longer used, this commit
> >  therefore remove it.
> >=20=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >=20
>=20I have queued both for review and testing, thank you!
>=20
>=20This patch produced the expected result in my initial tests. However,
> for the second patch, I used this command to force a stall:
>=20
>=20tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 15=
 --configs "TASKS01 TASKS02 TASKS03 RUDE01" --bootargs "rcutorture.stall_=
cpu=3D660" --trust-make
>=20
>=20Except I got vanilla RCU CPU stall warnings, but not RCU Tasks nor
> RCU Tasks Rude stall warnings. And not even the "grace period number"
> pre-stall message. Probably because I am forgetting something. But what
> did you do to test your change?

Hello, Paul

The rcutorture module use module_init() to load, however the
rcu_tasks_initiate_self_tests() is called in core_initcall(),=20
the=20core_initcall() have a higher priority than module_init().

This is possible, the RCU tasks test may have already completed,=20
but=20the rcutorture may have only just started.

so I use the following modifications to verify:

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d9e1e53f4ccf..7e5ff5108cdd 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1489,7 +1489,6 @@ static void rcu_tasks_initiate_self_tests(void)
        pr_info("Running RCU Tasks wait API self tests\n");
        tests[0].runstart =3D jiffies;
        synchronize_rcu_tasks();
-       call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
 #endif
=20
=20#ifdef CONFIG_TASKS_RUDE_RCU
@@ -1555,6 +1554,7 @@ static void rcu_tasks_verify_work_fn(struct work_st=
ruct *work __maybe_unused)
 static int rcu_tasks_verify_schedule_work(void)
 {
        INIT_DELAYED_WORK(&rcu_tasks_verify_work, rcu_tasks_verify_work_f=
n);
+       call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
        rcu_tasks_verify_work_fn(NULL);
        return 0;
 }



Run qemu with bootparams=3D"rcutorture.torture_type=3Dsrcu=20
rcutorture.stall_cpu=3D800 rcutorture.stall_cpu_block=3D1=20
rcutorture.stall_no_softlockup=3D1 rcupdate.rcu_tasks_lazy_ms=3D120000"

[   30.826022] call_rcu_tasks() has failed boot-time tests.
[   30.826790] rcu_tasks: RTGS_WAIT_CBS(11) since 7596 g:4 i:0 kCuU l:300=
00=20
[=20  30.827424] ------------[ cut here ]------------
[   30.827862] WARNING: kernel/rcu/tasks.h:1533 at rcu_tasks_verify_self_=
tests+0xa7/0xc0, CPU#1: kworker/1:1/79
[   30.828717] Modules linked in:
[   30.829144] CPU: 1 UID: 0 PID: 79 Comm: kworker/1:1 Tainted: G        =
W           7.1.0-rc4+ #25 PREEMPT(lazy)  e641c8af833b714510f82b4c2bc5dbb=
b1ef1e911
[   30.830176] Tainted: [W]=3DWARN=20
[=20  30.830468] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   30.831326] Workqueue: events rcu_tasks_verify_work_fn
....
[  722.218096] INFO: rcu_tasks detected stalls on tasks:
[  722.218689] 0000000095041800: .. nvcsw: 2/2 holdout: 1 idle_cpu: -1/7
[  722.219308] task:rcu_torture_sta state:R  running task     stack:0    =
 pid:122   tgid:122   ppid:2      task_flags:0x208040 flags:0x00080000
[  722.220442] Call Trace:
[  722.220744]  <TASK>
[  722.221035]  __schedule+0x2e9/0x1460
[  722.221449]  ? preempt_schedule+0x30/0x40
[  722.221895]  preempt_schedule_common+0x24/0x90
[  722.222432]  preempt_schedule+0x30/0x40
[  722.222842]  rcu_torture_stall+0x266/0x430
[  722.223286]  ? __kthread_parkme+0x8f/0xe0
[  722.223735]  ? __pfx_rcu_torture_stall+0x10/0x10
[  722.224226]  kthread+0x13d/0x180
[  722.224600]  ? __pfx_kthread+0x10/0x10
[  722.224996]  ret_from_fork+0x29d/0x3b0
[  722.225669]  ? __pfx_kthread+0x10/0x10
[  722.226131]  ret_from_fork_asm+0x1a/0x30
[  722.226668]  </TASK>


Thanks
Zqiang


>=20
>=20 Thanx, Paul
>=20
>=20>=20
>=20> ---
> >  kernel/rcu/tasks.h | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >=20=20
>=20>  diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >  index f4da5fad70f5..7f7d1e636217 100644
> >  --- a/kernel/rcu/tasks.h
> >  +++ b/kernel/rcu/tasks.h
> >  @@ -67,7 +67,6 @@ struct rcu_tasks_percpu {
> >  * @gp_start: Most recent grace-period start in jiffies.
> >  * @tasks_gp_seq: Number of grace periods completed since boot in upp=
er bits.
> >  * @n_ipis: Number of IPIs sent to encourage grace periods to end.
> >  - * @n_ipis_fails: Number of IPI-send failures.
> >  * @kthread_ptr: This flavor's grace-period/callback-invocation kthre=
ad.
> >  * @lazy_jiffies: Number of jiffies to allow callbacks to be lazy.
> >  * @pregp_func: This flavor's pre-grace-period function (optional).
> >  @@ -102,7 +101,6 @@ struct rcu_tasks {
> >  unsigned long gp_start;
> >  unsigned long tasks_gp_seq;
> >  unsigned long n_ipis;
> >  - unsigned long n_ipis_fails;
> >  struct task_struct *kthread_ptr;
> >  unsigned long lazy_jiffies;
> >  rcu_tasks_gp_func_t gp_func;
> >  @@ -735,12 +733,12 @@ static void show_rcu_tasks_generic_gp_kthread(=
struct rcu_tasks *rtp, char *s)
> >  if (havecbs && haveurgent && haveurgentcbs)
> >  break;
> >  }
> >  - pr_info("%s: %s(%d) since %lu g:%lu i:%lu/%lu %c%c%c%c l:%lu %s\n"=
,
> >  + pr_info("%s: %s(%d) since %lu g:%lu i:%lu %c%c%c%c l:%lu %s\n",
> >  rtp->kname,
> >  tasks_gp_state_getname(rtp), data_race(rtp->gp_state),
> >  jiffies - data_race(rtp->gp_jiffies),
> >  data_race(rcu_seq_current(&rtp->tasks_gp_seq)),
> >  - data_race(rtp->n_ipis_fails), data_race(rtp->n_ipis),
> >  + data_race(rtp->n_ipis),
> >  ".k"[!!data_race(rtp->kthread_ptr)],
> >  ".C"[havecbs],
> >  ".u"[haveurgent],
> >  --=20
>=20>  2.17.1
> >
>
