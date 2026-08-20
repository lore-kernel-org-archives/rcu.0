Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD54233031C
	for <rcu@vger.kernel.org>; Thu, 20 Aug 2026 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234107; cv=none; b=sDu1T31lYNsNcMeSo7hO7Wvn0Mbjg6eW3lVarGIQpnc4/BatYCTw49y6fqVidNOY5VgRhehMCRejNU0LF/SCEElq15/fbY6WOYd3Bm2TG2qDDse5Yfp9hpH5nWjrNCRnRFEDaHwQp7Qb5wk6+8KEVIXp9XH/6VBBGj4ujCgBrc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234107; c=relaxed/simple;
	bh=JKPP1FlG3MxrWBsRlc0JH0lOKhM5ebR/bXIJx6zVqIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF5KJtsFw+OPS89xVyy49IuCUn7PAGkIVo/mf36Iy96wQkaassNmdmWtBQ4PqwVU0Dq8/EabvUcQ79fpFeQXCYCmI7+yJIU2EAchmjgJyjxWV1O2rodWaFu6444r92I5oO9tG+OdR5RVR+Yx/m8C7vqq7MkZeEKJk589TRjN0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D9zxHabE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5bAtGdF8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D9zxHabE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5bAtGdF8"
Date: Thu, 20 Aug 2026 15:55:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787234102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLcCib3Eai8UauKzvfms4hmZPHPIKBqHHMiUSPnuNZw=;
	b=D9zxHabEbSdAZAQDrxdUEcgzYSKihCfPDg7BQDQ75MTz8EXlBddNLpyPZO6tLKl+EafBPY
	JSVTIGpSon4ldpkdT7SVKipIzgWAN8pbGAORViu/zAkC4HwOSgVH60ULsxQG+MKYmFXmTg
	DH6/O6zoWxnzcIYhOo3xMyR82X3dgcUJ2LR3JS2Ey5Eg9WaK0R+8XNYUhMGjsQwwk5xYGp
	RxMxR1zXErPslcqpZmrWx99SBMggO58NParK90PEpojwpO9GB9+282tW0FrRPzbp7Q1Y4B
	zpJFBH9ZAJlWVnkkb/kD1bY6c+J3j2Y8fkpKK+wpAifp7gEuSHLZJOoGGCHI+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787234102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLcCib3Eai8UauKzvfms4hmZPHPIKBqHHMiUSPnuNZw=;
	b=5bAtGdF8pRTXM4Otzzo0XqP50zeDITLdiBNE3OqTn6SntIparek//CGwwGgAIQNxU25UM8
	lSDJ+NTqQE8OIFDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH] rcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work
Message-ID: <20260820135500.hXUAsbHR@linutronix.de>
References: <20260820110008.v2Tlr0_H@linutronix.de>
 <aob12RahomSmpUQY@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aob12RahomSmpUQY@localhost.localdomain>

On 2026-08-20 14:40:57 [+0200], Frederic Weisbecker wrote:
> Le Thu, Aug 20, 2026 at 01:00:08PM +0200, Sebastian Andrzej Siewior a =C3=
=A9crit :
> > The irq_work in srcu is used to schedule a delayed work. The work item
> > is not scheduled directly because it is not always possible wake a
> > thread directly.
> >=20
> > On PREEMPT_RT the default irq_work is initialized with IRQ_WORK_LAZY and
> > is delayed to the irq_work thread. A system booted with the command line
> > "trace_event=3D=E2=80=A6" will freeze during boot because the irq_work =
thread is
> > not yet deployed (and tracing uses synchronize_srcu() in
> > tp_rcu_cond_sync()).
> >=20
> > The irq_work performs just a wakeup a thread, there is nothing wrong
> > with doing this from hardirq context on PREEMPT_RT.
> >=20
> > Use IRQ_WORK_INIT_HARD for srcu's irq_work.
> >=20
> > Fixes: 7c405fb3279b3 ("rcu: Use an intermediate irq_work to start proce=
ss_srcu()")
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  kernel/rcu/srcutree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 7c2f7cc131f7a..b703233d4a63f 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -218,7 +218,7 @@ static int init_srcu_struct_fields(struct srcu_stru=
ct *ssp, bool is_static)
> >  	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
> >  	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
> >  	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
> > -	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
> > +	ssp->srcu_sup->irq_work =3D IRQ_WORK_INIT_HARD(srcu_irq_work);
>=20
> It may need a comment to not lose that.

We could also make irq_work.o earlier in the Makefile, right at the top
so it comes before tracing. This was one of the first ideas and makes
the issue also go away. But given that it is just a wake we avoid waking
the irq_work/ thread just to schedule a timer/ wake workqueue.

> >  	ssp->srcu_sup->sda_is_static =3D is_static;
> >  	if (!is_static) {
> >  		ssp->sda =3D alloc_percpu(struct srcu_data);
> > --=20
> > 2.55.0
> >=20
> >
>=20
> Perhaps all irq works queued before the relevant kthread is started should
> temporarily be queued as hard?

Urgh. irq_work shouldn't become a widespread user ;)
If the scheduler is up but irq_work thread is not yet created and the
irq_work uses sleeping locks then it would create warnings.
In testing right now I see just wake_up_klogd_work_func() which is
always LAZY but would qualify otherwise for a warning. We wouldn't
trigger anything yet but you get the idea.

> Thanks.

Sebastian
