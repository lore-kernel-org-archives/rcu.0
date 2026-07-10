Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7EB3B0AD7
	for <rcu@vger.kernel.org>; Fri, 10 Jul 2026 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783725502; cv=none; b=b/ZBNuOjFclhdo89b9UzZRhWfPoND1g58TmPR4PiGsQGruoV/WAf2g2gMx1JcmPcpGWwa/wtySMHoSIwMoA6SakUl92RIqJJ91ZL6pi+Mk6flvNwJTzqU/OLTH3CQOInn+qi3xPS0b+YxqI3NV2YZDGKLQmIxaaKHKYoVluBQrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783725502; c=relaxed/simple;
	bh=6vH8CrfomPSWquiIfnA2PbyqFKsAv8JDFq0RPckw7Ck=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=c0TCbb5czhDgDmHsbb90yL2piuGvazTqv2gJMyGZmApBFsqQpmhmDy6HlG2EpNgdL8ZhWgjBEWr6fiVHfbmlAoRdcyXTR9e0o8pc2T6slTDt3thHeqf7NGhHDfd2u7atdRL5cG11SW+CWkUmZWoRn4E5aOInllXCjCYZyyxUu/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iUL+I3i0; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iUL+I3i0"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783725487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2RI/eMMPRUq5+L8Ra0l3525HaTMhSPQ0UXqBlNQ4FI=;
	b=iUL+I3i0g9RRTGAeMDHr3Bd7Rpl2ruKUHaWp87U6StzSyHd+z48bvkRB6Bv4G7fo/+59ja
	5UB9eN4wakPs6zIa6zgnl3rz2Je6+sF5Sz01syREtMrxuv9xx/sMJU44J32KXGXvr0PGAJ
	x6lvElWNxDyx0BMhOtoS6P1PMkQ6M1U=
Date: Fri, 10 Jul 2026 23:18:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <78d89fd4ddfa030bf77a225c16ad8038bc71c6d0@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcu-tasks: Remove smp_mb() in
 rcu_spawn_tasks_kthread_generic()
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <8e1b325f-f26a-4c2b-b36f-c13a0335d95a@paulmck-laptop>
References: <20260710115028.30303-1-qiang.zhang@linux.dev>
 <8e1b325f-f26a-4c2b-b36f-c13a0335d95a@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Fri, Jul 10, 2026 at 07:50:28PM +0800, Zqiang wrote:
>=20
>=20>=20
>=20> The smp_mb() after kthread_run() in rcu_spawn_tasks_kthread_generic=
()
> >  from early 'commit eacd6f04a133 ("rcu-tasks: Move Tasks RCU to its
> >  own file")' and 'commit 84a8f446ffd7 ("rcu: Defer rcu_tasks_kthread(=
)
> >  creation till first call_rcu_tasks()")', the pairing as follows:
> >=20=20
>=20>  rcu_spawn_tasks_kthread()
> >  ->t =3D kthread_run(rcu_tasks_kthread, ...);
> >  ->smp_mb(); /* Ensure others see full kthread. */
> >  ->WRITE_ONCE(rcu_tasks_kthread_ptr, t);
> >=20=20
>=20>  call_rcu_tasks()
> >  ->if (READ_ONCE(rcu_tasks_kthread_ptr))
> >  ->wake_up(&rcu_tasks_cbs_wq)
> >  ->try_to_wake_up()
> >  lock pi_lock
> >  ->smp_mb__after_spinlock()
> >  //see full kthread
> >=20=20
>=20>  Currently, the 'commit d119357d0743 ("rcu-tasks: Treat only synchr=
onous
> >  grace periods urgently")' moved kthread_ptr assignment into the
> >  rcu_tasks_kthread(), the following pairings are sufficient:
> >=20=20
>=20>  The rq->lock/unlock from wake_up_process() in kthread_run() and
> >  __schedule() provides a memory barrier when the kthread is first
> >  scheduled, this ensures the kthread itself observes all of the
> >  kthread's initialization.
> >=20=20
>=20>  The kthread's smp_store_release(&rtp->kthread_ptr, ...) in
> >  rcu_tasks_kthread() and smp_load_acquire(&rtp->kthread_ptr) in
> >  call_rcu_tasks_generic() compose release/acquire pairing, the
> >  cumulativity of smp_store_release() propagates visibility of the
> >  kthread's initialization through the scheduler chain.
> >=20=20
>=20>  This commit therefore remove smp_mb() in rcu_spawn_tasks_kthread_g=
eneric().
> >=20=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >=20
>=20Very good, a removal of an smp_mb() that also simplifies analysis!
>=20
>=20One question...
>=20
>=20>=20
>=20> ---
> >  kernel/rcu/tasks.h | 2 --
> >  1 file changed, 2 deletions(-)
> >=20=20
>=20>  diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >  index 5a8db89135eb..18ab335665e3 100644
> >  --- a/kernel/rcu/tasks.h
> >  +++ b/kernel/rcu/tasks.h
> >  @@ -395,7 +395,6 @@ static void call_rcu_tasks_generic(struct rcu_he=
ad *rhp, rcu_callback_t func,
> >  raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> >  }
> >  rcu_read_unlock();
> >  - /* We can't create the thread unless interrupts are enabled. */
> >=20
>=20Why remove this comment? People reading this code might wonder why we
> are not just invoking rcu_spawn_tasks_kthread_generic() to create the
> task here.
>=20
>=20Now, if you say that the current comment is confusing because if that
> kthread already exists, we also defer the wakeup, fair enough. But in
> that case, could you please propose a replacement comment, perhaps as
> a separate patch?

How about the following comment:

/* Use irq_work do deferred wakeup to avoid potential lockdep splat */

If directly use rcuwait_wake_up() to wakup, the lockdep will possible spa=
lt=EF=BC=8C
(for example we hook trace_sched_wakeup() tracepoint, and in our hook
func inovke call_rcu_tasks())

Thanks
Zqiang


>=20
>=20 Thanx, Paul
>=20
>=20>=20
>=20> if (needwake && READ_ONCE(rtp->kthread_ptr))
> >  irq_work_queue(&rtpcp->rtp_irq_work);
> >  }
> >  @@ -681,7 +680,6 @@ static void __init rcu_spawn_tasks_kthread_gener=
ic(struct rcu_tasks *rtp)
> >  t =3D kthread_run(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname);
> >  if (WARN_ONCE(IS_ERR(t), "%s: Could not start %s grace-period kthrea=
d, OOM is now expected behavior\n", __func__, rtp->name))
> >  return;
> >  - smp_mb(); /* Ensure others see full kthread. */
> >  }
> >=20=20
>=20>  #ifndef CONFIG_TINY_RCU
> >  --=20
>=20>  2.17.1
> >
>
