Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B12C2360;
	Wed,  8 Jul 2026 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532656; cv=none; b=FMPcq20Upeb1FnSlYsAGkvZicLJ42kQe+aVK2ew+pkz8Z55mNluvPsJYbXXRNiqQRf1DuLnsRmaI479jCzW5F9OOUm447xGqa1r6OP4oiwy5hhcRu40oZOqRB89mBlJw4hrtwnKKoMj7C2j0z4XAOAdvAfWpD8Jt/HzleMh0AX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532656; c=relaxed/simple;
	bh=CN8O5bAgAZLJ4ohTFnmZLjKPA1oVWromYxibg/WJFRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chmz8eMdiUgOtOFX7kXpoNq41PokEZiB7vMuisPKR61deSnobqr+McFHAl4o5lNIrJEy96G2c2a/EeRfTxvwP9DuFhKtSaEj336pWm72y6B+6LKkgvYE4vbvpRgZLTTVWcQsN/CQ8+AMUv+MOOso3T7/hSuaXU3RT9pHIYd2/ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzEZsVow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzEZsVow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800371F000E9;
	Wed,  8 Jul 2026 17:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783532654;
	bh=1UfXovoVRPgBYyyVA6ZCh/ECFhi74BDYFahcAuHhkto=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=gzEZsVowNzoDwPJMkWwccLS41zQqdQRoZIVJl5oe4Sqpl+Rf6UwFmEO0jDEkEO/P9
	 tAtBrVe0iSu7SsxfzMCqbmtzd0kQDcN6CxdQDSnVftgYoBAml5ywf0pAeCfuG7jcro
	 dGR4GYkk4uGNcQAormxVqAl4joglIUJC1JSecS4aGm4WlBGvykSaON5vc+vwBoKa9q
	 /7/FVt9Ywckd9+0tZWQAT7JjD9P7dfnoMgMd5fA0uHH7C2ca08ZRFLkDQ712wK/1tc
	 D7+tuyTriKQmEKXRnYCoYxbnR4L2xQRoyLAaDNt7yRG69kzsYaOUaVvCVwE8PJcI7u
	 urmOpMWo7zIdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 54C83CE074A; Wed,  8 Jul 2026 10:44:14 -0700 (PDT)
Date: Wed, 8 Jul 2026 10:44:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Remove unused struct
 rcu_tasks's->n_ipis_fails variables
Message-ID: <dd2f3c67-915c-426b-905d-d457f4245530@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260706100310.19735-1-qiang.zhang@linux.dev>
 <cb922347-ff9c-407e-a774-054e0117ac52@paulmck-laptop>
 <7b56bf2752621d6b845fb0d3086300e057e95aa2@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b56bf2752621d6b845fb0d3086300e057e95aa2@linux.dev>

On Tue, Jul 07, 2026 at 01:09:21PM +0000, Zqiang wrote:
> > 
> > On Mon, Jul 06, 2026 at 06:03:09PM +0800, Zqiang wrote:
> > 
> > > 
> > > The RCU tasks trace has been reimplemented by 'commit c27cea4416a3
> > >  ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")', the
> > >  rcu_tasks structure's->n_ipis_fails is no longer used, this commit
> > >  therefore remove it.
> > >  
> > >  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> > > 
> > I have queued both for review and testing, thank you!
> > 
> > This patch produced the expected result in my initial tests. However,
> > for the second patch, I used this command to force a stall:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 15 --configs "TASKS01 TASKS02 TASKS03 RUDE01" --bootargs "rcutorture.stall_cpu=660" --trust-make
> > 
> > Except I got vanilla RCU CPU stall warnings, but not RCU Tasks nor
> > RCU Tasks Rude stall warnings. And not even the "grace period number"
> > pre-stall message. Probably because I am forgetting something. But what
> > did you do to test your change?
> 
> Hello, Paul
> 
> The rcutorture module use module_init() to load, however the
> rcu_tasks_initiate_self_tests() is called in core_initcall(), 
> the core_initcall() have a higher priority than module_init().
> 
> This is possible, the RCU tasks test may have already completed, 
> but the rcutorture may have only just started.
> 
> so I use the following modifications to verify:
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index d9e1e53f4ccf..7e5ff5108cdd 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1489,7 +1489,6 @@ static void rcu_tasks_initiate_self_tests(void)
>         pr_info("Running RCU Tasks wait API self tests\n");
>         tests[0].runstart = jiffies;
>         synchronize_rcu_tasks();
> -       call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
>  #endif
>  
>  #ifdef CONFIG_TASKS_RUDE_RCU
> @@ -1555,6 +1554,7 @@ static void rcu_tasks_verify_work_fn(struct work_struct *work __maybe_unused)
>  static int rcu_tasks_verify_schedule_work(void)
>  {
>         INIT_DELAYED_WORK(&rcu_tasks_verify_work, rcu_tasks_verify_work_fn);
> +       call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
>         rcu_tasks_verify_work_fn(NULL);
>         return 0;
>  }

Or I can just comment out the call_rcu_tasks() entirely, correct?

> Run qemu with bootparams="rcutorture.torture_type=srcu 
> rcutorture.stall_cpu=800 rcutorture.stall_cpu_block=1 
> rcutorture.stall_no_softlockup=1 rcupdate.rcu_tasks_lazy_ms=120000"

OK, one of my problems was that I was forgetting stall_cpu_block=1,
which was causing all sorts of other stalls to confuse things.  So thank
you for that!

> [   30.826022] call_rcu_tasks() has failed boot-time tests.
> [   30.826790] rcu_tasks: RTGS_WAIT_CBS(11) since 7596 g:4 i:0 kCuU l:30000 
> [   30.827424] ------------[ cut here ]------------
> [   30.827862] WARNING: kernel/rcu/tasks.h:1533 at rcu_tasks_verify_self_tests+0xa7/0xc0, CPU#1: kworker/1:1/79
> [   30.828717] Modules linked in:
> [   30.829144] CPU: 1 UID: 0 PID: 79 Comm: kworker/1:1 Tainted: G        W           7.1.0-rc4+ #25 PREEMPT(lazy)  e641c8af833b714510f82b4c2bc5dbbb1ef1e911
> [   30.830176] Tainted: [W]=WARN 
> [   30.830468] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   30.831326] Workqueue: events rcu_tasks_verify_work_fn
> ....
> [  722.218096] INFO: rcu_tasks detected stalls on tasks:
> [  722.218689] 0000000095041800: .. nvcsw: 2/2 holdout: 1 idle_cpu: -1/7
> [  722.219308] task:rcu_torture_sta state:R  running task     stack:0     pid:122   tgid:122   ppid:2      task_flags:0x208040 flags:0x00080000
> [  722.220442] Call Trace:
> [  722.220744]  <TASK>
> [  722.221035]  __schedule+0x2e9/0x1460
> [  722.221449]  ? preempt_schedule+0x30/0x40
> [  722.221895]  preempt_schedule_common+0x24/0x90
> [  722.222432]  preempt_schedule+0x30/0x40
> [  722.222842]  rcu_torture_stall+0x266/0x430
> [  722.223286]  ? __kthread_parkme+0x8f/0xe0
> [  722.223735]  ? __pfx_rcu_torture_stall+0x10/0x10
> [  722.224226]  kthread+0x13d/0x180
> [  722.224600]  ? __pfx_kthread+0x10/0x10
> [  722.224996]  ret_from_fork+0x29d/0x3b0
> [  722.225669]  ? __pfx_kthread+0x10/0x10
> [  722.226131]  ret_from_fork_asm+0x1a/0x30
> [  722.226668]  </TASK>

But if I comment out that call_rcu_tasks() entirely, then I don't need
rcutorture to explictly generate a stall.  Which means that this:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --configs "TASKS01" --trust-make

Gets me this:

[   30.734277] call_rcu_tasks() has failed boot-time tests.
[   30.735048] rcu_tasks: RTGS_INVOKE_CBS(10) since 4 g:524 i:0 kCuU l:250 
[   30.736032] ------------[ cut here ]------------
[   30.736668] WARNING: kernel/rcu/tasks.h:1534 at rcu_tasks_verify_work_fn+0x86/0xc0, CPU#0: kworker/0:2/59
[   30.737929] Modules linked in:
[   30.738467] CPU: 0 UID: 0 PID: 59 Comm: kworker/0:2 Not tainted 7.1.0-rc4-00077-ge5ee2ea2d00a-dirty #1508 PREEMPT(full) 
[   30.739873] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[   30.740910] Workqueue: events rcu_tasks_verify_work_fn
[   30.741631] RIP: 0010:rcu_tasks_verify_work_fn+0x86/0xc0
[   30.742298] Code: 74 27 41 83 fc 01 75 25 48 8b 35 35 0a 9f 01 5b b9 e8 03 00 00 48 c7 c2 60 14 58 ae 5d bf 04 00 00 00 41 5c e9 2b 89 f6 ff 90 <0f> 0b 90 5b 5d 41 5c c3 cc cc cc cc 48 8b 73 10 48 c7 c7 e8 e9 9e
[   30.744382] RSP: 0018:ffffa0cf00207e28 EFLAGS: 00010246
[   30.744977] RAX: 000000000000003c RBX: ffffffffacf5f100 RCX: 3fffffffffffdfff
[   30.745816] RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000000000001
[   30.746657] RBP: 0000000000007530 R08: ffffffffacf5ccc8 R09: 3fffffffffffdfff
[   30.747494] R10: fffffffface7cce0 R11: 0000000000000784 R12: 00000000ffffffff
[   30.748238] R13: ffffffffae581460 R14: ffff980001055605 R15: ffff980001b30600
[   30.749058] FS:  0000000000000000(0000) GS:ffff98007198a000(0000) knlGS:0000000000000000
[   30.749955] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.750653] CR2: 0000000000402007 CR3: 00000000022fa000 CR4: 00000000000006f0
[   30.751483] Call Trace:
[   30.751777]  <TASK>
[   30.752032]  process_one_work+0x20d/0x6a0
[   30.752546]  ? lock_is_held_type+0x9e/0x120
[   30.753025]  worker_thread+0x195/0x350
[   30.753511]  ? __pfx_worker_thread+0x10/0x10
[   30.754003]  kthread+0xe8/0x120
[   30.754412]  ? __pfx_kthread+0x10/0x10
[   30.754865]  ret_from_fork+0x2a7/0x310
[   30.755306]  ? __pfx_kthread+0x10/0x10
[   30.755767]  ret_from_fork_asm+0x1a/0x30
[   30.756297]  </TASK>
[   30.756608] irq event stamp: 2747
[   30.756988] hardirqs last  enabled at (2755): [<ffffffffab13cfbd>] __up_console_sem+0x4d/0x60
[   30.757977] hardirqs last disabled at (2766): [<ffffffffab13cfa2>] __up_console_sem+0x32/0x60
[   30.758961] softirqs last  enabled at (2430): [<ffffffffab0c357d>] process_one_work+0x20d/0x6a0
[   30.759943] softirqs last disabled at (2426): [<ffffffffabdf6b2c>] neigh_periodic_work+0x2c/0x380
[   30.760970] ---[ end trace 0000000000000000 ]---

Which has the additional information from your patch.

Thank you for bearing with me!

							Thanx, Paul
