Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB812D9484
	for <rcu@vger.kernel.org>; Sat, 11 Jul 2026 05:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783746580; cv=none; b=jk/79zoIqayEJ6ktRi4c6LOktpiYiJg2N9EkL+IZvMMoimMuF5KmN+mfArUkJRz477MwInDZXQc8CgoLLFvO/OAHYTUVoMJuwJT/8c0fdg9oi61WVoBb740cBEbq+/tfS7lQTYRQifYsKJ0qU+xcqwURuLtOYxJxfld/qi/VygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783746580; c=relaxed/simple;
	bh=0y708bEdLHDmxF07blL0HGhakoCRORIq1Kk6OAYMfBg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Mr6EYIaXWzQVythxOlAkdApfWsU0kaIpkbzJJDGHtlGOGncqne1kRCq3F1An5TkFur3ZNzeicqh+e4Z74RrWNjcyO7QzrTSTk/RSwP71o+wGSsAU92oA1xp/+DX5GuXnceihe4Qry8K1ycdfB5e4YTCz1FHlLULyQ3s5qmFLW+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o04S0Vnr; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o04S0Vnr"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783746566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPkHD/sj/mX1fAJ2xEqTJs031sDWuo5ShW1u8DnZKf0=;
	b=o04S0Vnr1ZeWq9kwSAldcDW+Pvy9yD2BmAoOsM5/xQXzLQ8DqGPS6geGUq6yJdbcATedIo
	whPM19mw8J49gqRG9V+q32Jenmn5KBDwReHedAb6zeU3twZPAv483VH+QF2Eu/c70r7Ae7
	6MaI+sygy85mCMgjFNuWiTlRc4l7I8A=
Date: Sat, 11 Jul 2026 05:09:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <36f4935251cb18eb06884288e724ab17f4da09e6@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcu-tasks: Remove smp_mb() in 
 rcu_spawn_tasks_kthread_generic()
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <37aa565d-d03e-48d1-9522-0bca99f829d2@paulmck-laptop>
References: <20260710115028.30303-1-qiang.zhang@linux.dev>
 <8e1b325f-f26a-4c2b-b36f-c13a0335d95a@paulmck-laptop>
 <78d89fd4ddfa030bf77a225c16ad8038bc71c6d0@linux.dev>
 <37aa565d-d03e-48d1-9522-0bca99f829d2@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Fri, Jul 10, 2026 at 11:18:05PM +0000, Zqiang wrote:
>=20
>=20>=20
>=20> On Fri, Jul 10, 2026 at 07:50:28PM +0800, Zqiang wrote:
> >=20=20
>=20>  >=20
>=20>  > The smp_mb() after kthread_run() in rcu_spawn_tasks_kthread_gene=
ric()
> >  > from early 'commit eacd6f04a133 ("rcu-tasks: Move Tasks RCU to its
> >  > own file")' and 'commit 84a8f446ffd7 ("rcu: Defer rcu_tasks_kthrea=
d()
> >  > creation till first call_rcu_tasks()")', the pairing as follows:
> >  >=20
>=20>  > rcu_spawn_tasks_kthread()
> >  > ->t =3D kthread_run(rcu_tasks_kthread, ...);
> >  > ->smp_mb(); /* Ensure others see full kthread. */
> >  > ->WRITE_ONCE(rcu_tasks_kthread_ptr, t);
> >  >=20
>=20>  > call_rcu_tasks()
> >  > ->if (READ_ONCE(rcu_tasks_kthread_ptr))
> >  > ->wake_up(&rcu_tasks_cbs_wq)
> >  > ->try_to_wake_up()
> >  > lock pi_lock
> >  > ->smp_mb__after_spinlock()
> >  > //see full kthread
> >  >=20
>=20>  > Currently, the 'commit d119357d0743 ("rcu-tasks: Treat only sync=
hronous
> >  > grace periods urgently")' moved kthread_ptr assignment into the
> >  > rcu_tasks_kthread(), the following pairings are sufficient:
> >  >=20
>=20>  > The rq->lock/unlock from wake_up_process() in kthread_run() and
> >  > __schedule() provides a memory barrier when the kthread is first
> >  > scheduled, this ensures the kthread itself observes all of the
> >  > kthread's initialization.
> >  >=20
>=20>  > The kthread's smp_store_release(&rtp->kthread_ptr, ...) in
> >  > rcu_tasks_kthread() and smp_load_acquire(&rtp->kthread_ptr) in
> >  > call_rcu_tasks_generic() compose release/acquire pairing, the
> >  > cumulativity of smp_store_release() propagates visibility of the
> >  > kthread's initialization through the scheduler chain.
> >  >=20
>=20>  > This commit therefore remove smp_mb() in rcu_spawn_tasks_kthread=
_generic().
> >  >=20
>=20>  > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >  >=20
>=20>  Very good, a removal of an smp_mb() that also simplifies analysis!
> >=20=20
>=20>  One question...
> >=20=20
>=20>  >=20
>=20>  > ---
> >  > kernel/rcu/tasks.h | 2 --
> >  > 1 file changed, 2 deletions(-)
> >  >=20
>=20>  > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >  > index 5a8db89135eb..18ab335665e3 100644
> >  > --- a/kernel/rcu/tasks.h
> >  > +++ b/kernel/rcu/tasks.h
> >  > @@ -395,7 +395,6 @@ static void call_rcu_tasks_generic(struct rcu_=
head *rhp, rcu_callback_t func,
> >  > raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> >  > }
> >  > rcu_read_unlock();
> >  > - /* We can't create the thread unless interrupts are enabled. */
> >  >=20
>=20>  Why remove this comment? People reading this code might wonder why=
 we
> >  are not just invoking rcu_spawn_tasks_kthread_generic() to create th=
e
> >  task here.
> >=20=20
>=20>  Now, if you say that the current comment is confusing because if t=
hat
> >  kthread already exists, we also defer the wakeup, fair enough. But i=
n
> >  that case, could you please propose a replacement comment, perhaps a=
s
> >  a separate patch?
> >=20=20
>=20>  How about the following comment:
> >=20=20
>=20>  /* Use irq_work do deferred wakeup to avoid potential lockdep spla=
t */
> >=20=20
>=20>  If directly use rcuwait_wake_up() to wakup, the lockdep will possi=
ble spalt=EF=BC=8C
> >  (for example we hook trace_sched_wakeup() tracepoint, and in our hoo=
k
> >  func inovke call_rcu_tasks())
> >=20
>=20Fair enough. But the reason for the READ_ONCE(rtp->kthread_ptr) part =
of
> the condition of that "if" statement is that we cannot create a kthread
> with interrupts disabled, either because it is too early in boot or
> because one of the scheduler locks might be held.
>=20
>=20Maybe that is obvious? But we did add that comment at some point.
>=20
>=20Thoughts?

Ok, I find that:

c63eb17ff06 ("rcu: Create call_rcu_tasks() kthread at boot time")
4929c913bda ("rcu: Make call_rcu_tasks() tolerate first call with irqs di=
sabled")

As a separate patch send,  the update comments are as follows:

"We can't create the kthread with interrupts disabled,=20
or=20a sinlock might be held, create the kthread moved
at core_initcall() time, at the same time, use the irq_work
does deferred wakeup to avoid potential lockdep splat"

Thanks
Zqiang

>=20
>=20 Thanx, Paul
>=20
>=20>=20
>=20> Thanks
> >  Zqiang
> >=20=20
>=20>=20=20
>=20>=20=20
>=20>  Thanx, Paul
> >=20=20
>=20>  >=20
>=20>  > if (needwake && READ_ONCE(rtp->kthread_ptr))
> >  > irq_work_queue(&rtpcp->rtp_irq_work);
> >  > }
> >  > @@ -681,7 +680,6 @@ static void __init rcu_spawn_tasks_kthread_gen=
eric(struct rcu_tasks *rtp)
> >  > t =3D kthread_run(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname=
);
> >  > if (WARN_ONCE(IS_ERR(t), "%s: Could not start %s grace-period kthr=
ead, OOM is now expected behavior\n", __func__, rtp->name))
> >  > return;
> >  > - smp_mb(); /* Ensure others see full kthread. */
> >  > }
> >  >=20
>=20>  > #ifndef CONFIG_TINY_RCU
> >  > --=20
>=20>  > 2.17.1
> >  >
> >
>
