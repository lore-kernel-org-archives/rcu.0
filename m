Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45D40DFA7
	for <rcu@vger.kernel.org>; Thu,  9 Jul 2026 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598668; cv=none; b=Rqi0YB11mBNQKBm5Edn27XoLtrLYji1WmMXUDg4UwVE8ZS2BWrSvvRGG/RUwQ5U6aRyjhjE8Lpp58yvKwkvzB/gDqBmF079ssOAJ0jB1nmAX3U88KYW7lg29HYc3rF5ROagGGRaJ7/HtYnu3BwdqbGEBvJtrq/2PKUAcWww8REU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598668; c=relaxed/simple;
	bh=ozMwn1/QovQAm6UAqF0MUHgQ/TzeJhVU8h9nuStoo1Y=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=TJD3c3se/xmYuWqUDLfSweOJcvo+GhMtN/Wi+rZwB8XqASfisAp1oL/V04lzfWczzaAaF27EdYli4zntyGtD9Wk2QTXSoplOCN+SO6FFsNKeqTUFguNON6b36RgwDPrYgyg1Ceb8tNBBL7JsU6o1+i6STH/d/EFwJCXs5bSWDVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YZIE9iRB; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YZIE9iRB"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783598652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVSbM1xafdBMfyaZTezv/Hjg8dhdUiwYcMGMaDAPdVw=;
	b=YZIE9iRB11sVeO0PzQhMTR6UABIeR/A4p363exjEOCxKynrx3N7b8s0qKLRougRMgDNacR
	V1Q5+8JGGqa5Jp1KbmoePyLVb9epOVVD6/pXGkrp03eSx+RAskspEbWJM8JmLqIBJjNLyS
	yTowBpsg2dRf03d8ZR5YtiBcKBo4h68=
Date: Thu, 09 Jul 2026 12:04:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <fb82b46f08cb59000db994fcc2f05d1ad531c342@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcu-tasks: Remove unused struct
 rcu_tasks's->n_ipis_fails variables
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <dd2f3c67-915c-426b-905d-d457f4245530@paulmck-laptop>
References: <20260706100310.19735-1-qiang.zhang@linux.dev>
 <cb922347-ff9c-407e-a774-054e0117ac52@paulmck-laptop>
 <7b56bf2752621d6b845fb0d3086300e057e95aa2@linux.dev>
 <dd2f3c67-915c-426b-905d-d457f4245530@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Tue, Jul 07, 2026 at 01:09:21PM +0000, Zqiang wrote:
>=20
>=20>=20
>=20> On Mon, Jul 06, 2026 at 06:03:09PM +0800, Zqiang wrote:
> >=20=20
>=20>  >=20
>=20>  > The RCU tasks trace has been reimplemented by 'commit c27cea4416=
a3
> >  > ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")', the
> >  > rcu_tasks structure's->n_ipis_fails is no longer used, this commit
> >  > therefore remove it.
> >  >=20
>=20>  > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >  >=20
>=20>  I have queued both for review and testing, thank you!
> >=20=20
>=20>  This patch produced the expected result in my initial tests. Howev=
er,
> >  for the second patch, I used this command to force a stall:
> >=20=20
>=20>  tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration=
 15 --configs "TASKS01 TASKS02 TASKS03 RUDE01" --bootargs "rcutorture.sta=
ll_cpu=3D660" --trust-make
> >=20=20
>=20>  Except I got vanilla RCU CPU stall warnings, but not RCU Tasks nor
> >  RCU Tasks Rude stall warnings. And not even the "grace period number=
"
> >  pre-stall message. Probably because I am forgetting something. But w=
hat
> >  did you do to test your change?
> >=20=20
>=20>  Hello, Paul
> >=20=20
>=20>  The rcutorture module use module_init() to load, however the
> >  rcu_tasks_initiate_self_tests() is called in core_initcall(),=20
>=20>  the core_initcall() have a higher priority than module_init().
> >=20=20
>=20>  This is possible, the RCU tasks test may have already completed,=
=20
>=20>  but the rcutorture may have only just started.
> >=20=20
>=20>  so I use the following modifications to verify:
> >=20=20
>=20>  diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >  index d9e1e53f4ccf..7e5ff5108cdd 100644
> >  --- a/kernel/rcu/tasks.h
> >  +++ b/kernel/rcu/tasks.h
> >  @@ -1489,7 +1489,6 @@ static void rcu_tasks_initiate_self_tests(void=
)
> >  pr_info("Running RCU Tasks wait API self tests\n");
> >  tests[0].runstart =3D jiffies;
> >  synchronize_rcu_tasks();
> >  - call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
> >  #endif
> >=20=20
>=20>  #ifdef CONFIG_TASKS_RUDE_RCU
> >  @@ -1555,6 +1554,7 @@ static void rcu_tasks_verify_work_fn(struct wo=
rk_struct *work __maybe_unused)
> >  static int rcu_tasks_verify_schedule_work(void)
> >  {
> >  INIT_DELAYED_WORK(&rcu_tasks_verify_work, rcu_tasks_verify_work_fn);
> >  + call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
> >  rcu_tasks_verify_work_fn(NULL);
> >  return 0;
> >  }
> >=20
>=20Or I can just comment out the call_rcu_tasks() entirely, correct
>=20
>=20>=20
>=20> Run qemu with bootparams=3D"rcutorture.torture_type=3Dsrcu=20
>=20>  rcutorture.stall_cpu=3D800 rcutorture.stall_cpu_block=3D1=20
>=20>  rcutorture.stall_no_softlockup=3D1 rcupdate.rcu_tasks_lazy_ms=3D12=
0000"
> >=20
>=20OK, one of my problems was that I was forgetting stall_cpu_block=3D1,
> which was causing all sorts of other stalls to confuse things. So thank
> you for that!
>=20
>=20>=20
>=20> [ 30.826022] call_rcu_tasks() has failed boot-time tests.
> >  [ 30.826790] rcu_tasks: RTGS_WAIT_CBS(11) since 7596 g:4 i:0 kCuU l:=
30000=20
>=20>  [ 30.827424] ------------[ cut here ]------------
> >  [ 30.827862] WARNING: kernel/rcu/tasks.h:1533 at rcu_tasks_verify_se=
lf_tests+0xa7/0xc0, CPU#1: kworker/1:1/79
> >  [ 30.828717] Modules linked in:
> >  [ 30.829144] CPU: 1 UID: 0 PID: 79 Comm: kworker/1:1 Tainted: G W 7.=
1.0-rc4+ #25 PREEMPT(lazy) e641c8af833b714510f82b4c2bc5dbbb1ef1e911
> >  [ 30.830176] Tainted: [W]=3DWARN=20
>=20>  [ 30.830468] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), B=
IOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> >  [ 30.831326] Workqueue: events rcu_tasks_verify_work_fn
> >  ....
> >  [ 722.218096] INFO: rcu_tasks detected stalls on tasks:
> >  [ 722.218689] 0000000095041800: .. nvcsw: 2/2 holdout: 1 idle_cpu: -=
1/7
> >  [ 722.219308] task:rcu_torture_sta state:R running task stack:0 pid:=
122 tgid:122 ppid:2 task_flags:0x208040 flags:0x00080000
> >  [ 722.220442] Call Trace:
> >  [ 722.220744] <TASK>
> >  [ 722.221035] __schedule+0x2e9/0x1460
> >  [ 722.221449] ? preempt_schedule+0x30/0x40
> >  [ 722.221895] preempt_schedule_common+0x24/0x90
> >  [ 722.222432] preempt_schedule+0x30/0x40
> >  [ 722.222842] rcu_torture_stall+0x266/0x430
> >  [ 722.223286] ? __kthread_parkme+0x8f/0xe0
> >  [ 722.223735] ? __pfx_rcu_torture_stall+0x10/0x10
> >  [ 722.224226] kthread+0x13d/0x180
> >  [ 722.224600] ? __pfx_kthread+0x10/0x10
> >  [ 722.224996] ret_from_fork+0x29d/0x3b0
> >  [ 722.225669] ? __pfx_kthread+0x10/0x10
> >  [ 722.226131] ret_from_fork_asm+0x1a/0x30
> >  [ 722.226668] </TASK>
> >=20
>=20But if I comment out that call_rcu_tasks() entirely, then I don't nee=
d
> rcutorture to explictly generate a stall. Which means that this:

This is more simpler than my test :) .

>=20
>=20tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 =
--configs "TASKS01" --trust-make
>=20
>=20Gets me this:
>=20
>=20[ 30.734277] call_rcu_tasks() has failed boot-time tests.
> [ 30.735048] rcu_tasks: RTGS_INVOKE_CBS(10) since 4 g:524 i:0 kCuU l:25=
0=20
>=20[ 30.736032] ------------[ cut here ]------------
> [ 30.736668] WARNING: kernel/rcu/tasks.h:1534 at rcu_tasks_verify_work_=
fn+0x86/0xc0, CPU#0: kworker/0:2/59
> [ 30.737929] Modules linked in:
> [ 30.738467] CPU: 0 UID: 0 PID: 59 Comm: kworker/0:2 Not tainted 7.1.0-=
rc4-00077-ge5ee2ea2d00a-dirty #1508 PREEMPT(full)=20
>=20[ 30.739873] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.15.0-1 04/01/2014
> [ 30.740910] Workqueue: events rcu_tasks_verify_work_fn
> [ 30.741631] RIP: 0010:rcu_tasks_verify_work_fn+0x86/0xc0
> [ 30.742298] Code: 74 27 41 83 fc 01 75 25 48 8b 35 35 0a 9f 01 5b b9 e=
8 03 00 00 48 c7 c2 60 14 58 ae 5d bf 04 00 00 00 41 5c e9 2b 89 f6 ff 90=
 <0f> 0b 90 5b 5d 41 5c c3 cc cc cc cc 48 8b 73 10 48 c7 c7 e8 e9 9e
> [ 30.744382] RSP: 0018:ffffa0cf00207e28 EFLAGS: 00010246
> [ 30.744977] RAX: 000000000000003c RBX: ffffffffacf5f100 RCX: 3ffffffff=
fffdfff
> [ 30.745816] RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 000000000=
0000001
> [ 30.746657] RBP: 0000000000007530 R08: ffffffffacf5ccc8 R09: 3ffffffff=
fffdfff
> [ 30.747494] R10: fffffffface7cce0 R11: 0000000000000784 R12: 00000000f=
fffffff
> [ 30.748238] R13: ffffffffae581460 R14: ffff980001055605 R15: ffff98000=
1b30600
> [ 30.749058] FS: 0000000000000000(0000) GS:ffff98007198a000(0000) knlGS=
:0000000000000000
> [ 30.749955] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 30.750653] CR2: 0000000000402007 CR3: 00000000022fa000 CR4: 000000000=
00006f0
> [ 30.751483] Call Trace:
> [ 30.751777] <TASK>
> [ 30.752032] process_one_work+0x20d/0x6a0
> [ 30.752546] ? lock_is_held_type+0x9e/0x120
> [ 30.753025] worker_thread+0x195/0x350
> [ 30.753511] ? __pfx_worker_thread+0x10/0x10
> [ 30.754003] kthread+0xe8/0x120
> [ 30.754412] ? __pfx_kthread+0x10/0x10
> [ 30.754865] ret_from_fork+0x2a7/0x310
> [ 30.755306] ? __pfx_kthread+0x10/0x10
> [ 30.755767] ret_from_fork_asm+0x1a/0x30
> [ 30.756297] </TASK>
> [ 30.756608] irq event stamp: 2747
> [ 30.756988] hardirqs last enabled at (2755): [<ffffffffab13cfbd>] __up=
_console_sem+0x4d/0x60
> [ 30.757977] hardirqs last disabled at (2766): [<ffffffffab13cfa2>] __u=
p_console_sem+0x32/0x60
> [ 30.758961] softirqs last enabled at (2430): [<ffffffffab0c357d>] proc=
ess_one_work+0x20d/0x6a0
> [ 30.759943] softirqs last disabled at (2426): [<ffffffffabdf6b2c>] nei=
gh_periodic_work+0x2c/0x380
> [ 30.760970] ---[ end trace 0000000000000000 ]---
>=20
>=20Which has the additional information from your patch.
>=20
>=20Thank you for bearing with me!

Thanks you very much!

>=20
>=20 Thanx, Paul
>
