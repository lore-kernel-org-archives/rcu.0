Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E7322B8A;
	Sat, 21 Mar 2026 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114910; cv=none; b=VZ8D1qR9lW9QNa1/j3B/oGVenUuetW2RypwBo7uSj4sJB7ePeW9oiRyrtHfdBjU6KYc3yDvbeBD5MaGNND+rPVlAHKeVFrotEgz1vHogL8omT7kOFrDi0KmjJSjGRkIyHrFvT/TxJudKVDjWtZ+9c4cbx+uCdDrJ0JjybjFdhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114910; c=relaxed/simple;
	bh=SaWq1b9CX6DJpnbhlhcSDMdQKCCCV6kM0cNPFh8EvG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAvz1/2iFsSvnV8710YpDDGJUq0lejlvPtjHR+WsEgp9LiuzR8I7PTkWuTsdrv5yJq9l5NPCjgMGxOcKCe+Y87nD+DttjLm5cOGyZg3eo2hfUVJpWi+4bXCctU0ss8HiR6P/3ovLS9n1m+zxAagd7Ji9cVwVXHQnLySSnYhu7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZp8iVud; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZp8iVud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71394C19421;
	Sat, 21 Mar 2026 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774114909;
	bh=SaWq1b9CX6DJpnbhlhcSDMdQKCCCV6kM0cNPFh8EvG8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KZp8iVudj53Dox/lnCaqW8imLaWyzReriTd2hNKEAwOztREg3qNxxAsz5aKxsTdHK
	 /IpN9K3hTE7i/hp/cxFG+7bvc5Fq/EyA/lBgguAWCnKnotkxfrYYs73yBYb39g5Fy9
	 HdE+cVxYnqzMEYiVHp7JWpf72tkazlzduEBRXRPWKwdxJjsL3YWFct+jDpFomdfMlO
	 qf3gyj2vidEnbWtmOl944NuzEo4M3H1X6y2Wbdhu714fZfuUHHaPyhV1lR8hEWJEfg
	 /vHN58ev1H3OfT/WzLalsgXrQ0Kyie6ciNPhO7/H8BM3RnDRWpRdt/3F3tzF+fe/n6
	 UCxQuCI54b84Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 578A4CE0B66; Sat, 21 Mar 2026 10:41:47 -0700 (PDT)
Date: Sat, 21 Mar 2026 10:41:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrea Righi <arighi@nvidia.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] rcu: Use an intermediate irq_work to start process_srcu()
Message-ID: <492ba226-79c7-4345-b691-eb775082b799@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
 <b4857e4f-5a8d-4ccc-9e8b-df57718e4aee@paulmck-laptop>
 <ab7SQ3L1F-ap7mNl@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7SQ3L1F-ap7mNl@tardis.local>

On Sat, Mar 21, 2026 at 10:15:47AM -0700, Boqun Feng wrote:
> On Sat, Mar 21, 2026 at 03:10:05AM -0700, Paul E. McKenney wrote:
> > On Fri, Mar 20, 2026 at 11:14:00AM -0700, Boqun Feng wrote:
> > > Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> > > of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> > > happen basically everywhere (including where a scheduler lock is held),
> > > call_srcu() now needs to avoid acquiring scheduler lock because
> > > otherwise it could cause deadlock [1]. Fix this by following what the
> > > previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> > > the work to start process_srcu().
> > > 
> > > [boqun: Apply Joel's feedback]
> > > 
> > > Reported-by: Andrea Righi <arighi@nvidia.com>
> > > Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> > > Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> > > Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> > > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > 
> > First, thank you all for putting this together!
> > 
> > If I enable both early boot RCU testing and lockdep, for example,
> > by running the RUDE01 rcutorture scenario, I get the following splat,
> > which suggests that the raw_spin_unlock_irq_rcu_node() in srcu_irq_work()
> > might need help (see inline below):
> 
> Yes, Andrea reported a similar issue:
> 
> 	https://lore.kernel.org/rcu/ab2yd35rm6OgZUmb@gpd4/
> 
> > [    0.872594] ------------[ cut here ]------------
> > [    0.873550] DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
> > [    0.873550] WARNING: kernel/locking/lockdep.c:4404 at lockdep_hardirqs_on_prepare+0x150/0x190, CPU#0: swapper/0/1
> > [    0.873550] Modules linked in:
> > [    0.873550] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc3-00039-g35d354b6cd0f-dirty #8217 PREEMPT(full) 
> > [    0.873550] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [    0.873550] RIP: 0010:lockdep_hardirqs_on_prepare+0x157/0x190
> > [    0.873550] Code: 01 90 e8 ec c7 54 00 85 c0 74 0a 8b 35 12 c4 e0 01 85 f6 74 31 90 5d c3 cc cc cc cc 48 8d 3d 20 cf e1 01 48 c7 c6 ec c1 87 9f <67> 48 0f b9 3a eb ac 48 8d 3d 1b cf e1 01 48 c7 c6 87 be 87 9f 67
> > [    0.873550] RSP: 0000:ffff9ff3c0003f50 EFLAGS: 00010046
> > [    0.873550] RAX: 0000000000000001 RBX: ffffffff9fb608f8 RCX: 0000000000000001
> > [    0.873550] RDX: 0000000000000000 RSI: ffffffff9f87c1ec RDI: ffffffff9fd44120
> > [    0.873550] RBP: ffffffff9f00bae3 R08: 0000000000000001 R09: 0000000000000000
> > [    0.873550] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> > [    0.873550] R13: ffff9e1bc11e4bc0 R14: 0000000000000000 R15: 0000000000000000
> > [    0.873550] FS:  0000000000000000(0000) GS:ffff9e1c3ed9b000(0000) knlGS:0000000000000000
> > [    0.873550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.873550] CR2: ffff9e1bcf3d8000 CR3: 000000000dc4e000 CR4: 00000000000006f0
> > [    0.873550] Call Trace:
> > [    0.873550]  <IRQ>
> > [    0.873550]  ? _raw_spin_unlock_irq+0x23/0x40
> > [    0.873550]  trace_hardirqs_on+0x16/0xe0
> > [    0.873550]  _raw_spin_unlock_irq+0x23/0x40
> > [    0.873550]  srcu_irq_work+0x5e/0x90
> > [    0.873550]  irq_work_single+0x42/0x90
> > [    0.873550]  irq_work_run_list+0x26/0x40
> > [    0.873550]  irq_work_run+0x18/0x30
> > [    0.873550]  __sysvec_irq_work+0x30/0x180
> > [    0.873550]  sysvec_irq_work+0x6a/0x80
> > [    0.873550]  </IRQ>
> > [    0.873550]  <TASK>
> > [    0.873550]  asm_sysvec_irq_work+0x1a/0x20
> > [    0.873550] RIP: 0010:_raw_spin_unlock_irqrestore+0x34/0x50
> > [    0.873550] Code: c7 18 53 48 89 f3 48 8b 74 24 10 e8 06 d4 f1 fe 48 89 ef e8 2e 0c f2 fe 80 e7 02 74 06 e8 74 86 01 ff fb 65 ff 0d ec d4 66 01 <74> 07 5b 5d e9 53 1b 00 00 e8 5e 94 df fe 5b 5d e9 47 1b 00 00 0f
> > [    0.873550] RSP: 0000:ffff9ff3c0013d50 EFLAGS: 00000286
> > [    0.873550] RAX: 0000000000001417 RBX: 0000000000000297 RCX: 0000000000000000
> > [    0.873550] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9f00bb3c
> > [    0.873550] RBP: ffffffff9fb60630 R08: 0000000000000001 R09: 0000000000000000
> > [    0.873550] R10: 0000000000000001 R11: 0000000000000001 R12: fffffffffffffe74
> > [    0.873550] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
> > [    0.873550]  ? _raw_spin_unlock_irqrestore+0x2c/0x50
> > [    0.873550]  srcu_gp_start_if_needed+0x354/0x530
> > [    0.873550]  __synchronize_srcu+0xd1/0x180
> > [    0.873550]  ? __pfx_wakeme_after_rcu+0x10/0x10
> > [    0.873550]  ? synchronize_srcu+0x3f/0x170
> > [    0.873550]  ? __pfx_rcu_init_tasks_generic+0x10/0x10
> > [    0.873550]  rcu_init_tasks_generic+0x10c/0x130
> > [    0.873550]  do_one_initcall+0x59/0x2e0
> > [    0.873550]  ? _printk+0x56/0x70
> > [    0.873550]  kernel_init_freeable+0x227/0x440
> > [    0.873550]  ? __pfx_kernel_init+0x10/0x10
> > [    0.873550]  kernel_init+0x15/0x1c0
> > [    0.873550]  ret_from_fork+0x2ac/0x330
> > [    0.873550]  ? __pfx_kernel_init+0x10/0x10
> > [    0.873550]  ret_from_fork_asm+0x1a/0x30
> > [    0.873550]  </TASK>
> > [    0.873550] irq event stamp: 5144
> > [    0.873550] hardirqs last  enabled at (5143): [<ffffffff9f00bb3c>] _raw_spin_unlock_irqrestore+0x2c/0x50
> > [    0.873550] hardirqs last disabled at (5144): [<ffffffff9eff7c9f>] sysvec_irq_work+0xf/0x80
> > [    0.873550] softirqs last  enabled at (5132): [<ffffffff9dea2501>] __irq_exit_rcu+0xa1/0xc0
> > [    0.873550] softirqs last disabled at (5127): [<ffffffff9dea2501>] __irq_exit_rcu+0xa1/0xc0
> > [    0.873550] ---[ end trace 0000000000000000 ]---
> > [    0.873574] ------------[ cut here ]------------
> > 
> > > ---
> > > @Zqiang, I put your name as Suggested-by because you proposed the same
> > > idea, let me know if you rather not have it.
> > > 
> > > @Joel, I did two updates (including your test feedback, other one is
> > > call irq_work_sync() when we clean the srcu_struct), please give it a
> > > try.
> > > 
> > >  include/linux/srcutree.h |  1 +
> > >  kernel/rcu/srcutree.c    | 29 +++++++++++++++++++++++++++--
> > >  2 files changed, 28 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > index dfb31d11ff05..be76fa4fc170 100644
> > > --- a/include/linux/srcutree.h
> > > +++ b/include/linux/srcutree.h
> > > @@ -95,6 +95,7 @@ struct srcu_usage {
> > >  	unsigned long reschedule_jiffies;
> > >  	unsigned long reschedule_count;
> > >  	struct delayed_work work;
> > > +	struct irq_work irq_work;
> > >  	struct srcu_struct *srcu_ssp;
> > >  };
> > >  
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 2328827f8775..73aef361a524 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -19,6 +19,7 @@
> > >  #include <linux/mutex.h>
> > >  #include <linux/percpu.h>
> > >  #include <linux/preempt.h>
> > > +#include <linux/irq_work.h>
> > >  #include <linux/rcupdate_wait.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/smp.h>
> > > @@ -75,6 +76,7 @@ static bool __read_mostly srcu_init_done;
> > >  static void srcu_invoke_callbacks(struct work_struct *work);
> > >  static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
> > >  static void process_srcu(struct work_struct *work);
> > > +static void srcu_irq_work(struct irq_work *work);
> > >  static void srcu_delay_timer(struct timer_list *t);
> > >  
> > >  /*
> > > @@ -216,6 +218,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> > >  	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
> > >  	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
> > >  	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
> > > +	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
> > >  	ssp->srcu_sup->sda_is_static = is_static;
> > >  	if (!is_static) {
> > >  		ssp->sda = alloc_percpu(struct srcu_data);
> > > @@ -713,6 +716,8 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
> > >  		return; /* Just leak it! */
> > >  	if (WARN_ON(srcu_readers_active(ssp)))
> > >  		return; /* Just leak it! */
> > > +	/* Wait for irq_work to finish first as it may queue a new work. */
> > > +	irq_work_sync(&sup->irq_work);
> > >  	flush_delayed_work(&sup->work);
> > >  	for_each_possible_cpu(cpu) {
> > >  		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> > > @@ -1118,9 +1123,13 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > >  		// it isn't.  And it does not have to be.  After all, it
> > >  		// can only be executed during early boot when there is only
> > >  		// the one boot CPU running with interrupts still disabled.
> > > +		//
> > > +		// Use an irq_work here to avoid acquiring runqueue lock with
> > > +		// srcu rcu_node::lock held. BPF instrument could introduce the
> > > +		// opposite dependency, hence we need to break the possible
> > > +		// locking dependency here.
> > >  		if (likely(srcu_init_done))
> > > -			queue_delayed_work(rcu_gp_wq, &sup->work,
> > > -					   !!srcu_get_delay(ssp));
> > > +			irq_work_queue(&sup->irq_work);
> > >  		else if (list_empty(&sup->work.work.entry))
> > >  			list_add(&sup->work.work.entry, &srcu_boot_list);
> > >  	}
> > > @@ -1979,6 +1988,22 @@ static void process_srcu(struct work_struct *work)
> > >  	srcu_reschedule(ssp, curdelay);
> > >  }
> > >  
> > > +static void srcu_irq_work(struct irq_work *work)
> > > +{
> > > +	struct srcu_struct *ssp;
> > > +	struct srcu_usage *sup;
> > > +	unsigned long delay;
> > > +
> > > +	sup = container_of(work, struct srcu_usage, irq_work);
> > > +	ssp = sup->srcu_ssp;
> > > +
> > > +	raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
> > > +	delay = srcu_get_delay(ssp);
> > > +	raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
> > 
> > Removing the "_irq" from both avoids the lockdep splat in my test setup,
> > which makes sense given that interrupts are disabled in irq_work handlers.
> > Or at least it looks to me that they are.  ;-)
> > 
> > Like this:
> > 
> > +	raw_spin_lock_rcu_node(ssp->srcu_sup);
> > +	delay = srcu_get_delay(ssp);
> > +	raw_spin_unlock_rcu_node(ssp->srcu_sup);
> > 
> 
> It was fixed differently in v2:
> 
> 	https://lore.kernel.org/rcu/20260320222916.19987-1-boqun@kernel.org/
> 
> I used _irqsave/_irqrestore just in case. Given it's an urgent fix,
> overly careful code is probably fine ;-)
> 
> Thanks for the testing and feedback.

OK, I will try that one, thank you!

FYI, with my change on your earlier version, SRCU-T got deadlocks between
the pi-lock and the workqueue pool lock.  Which might or might not be
particularly urgent.

							Thanx, Paul

> Regards,
> Boqun
> 
> > 							Thanx, Paul
> > 
> > > +
> > > +	queue_delayed_work(rcu_gp_wq, &sup->work, !!delay);
> > > +}
> > > +
> > >  void srcutorture_get_gp_data(struct srcu_struct *ssp, int *flags,
> > >  			     unsigned long *gp_seq)
> > >  {
> > > -- 
> > > 2.50.1 (Apple Git-155)
> > > 
