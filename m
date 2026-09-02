Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D5377AB5;
	Wed,  2 Sep 2026 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337623; cv=none; b=aIvVaD7NEBZxoYlTJayBSKtTHcin/FRCWdb/857E1IZEyn3O3T3ann0hjiymhEFNKwvcl15Gm7OcG6197kzHK7WjLQZG6IynvWvfbZYMpo1zT2zmQ+06+EF1cvwgT1Ate3BLJBl1g91vLsUEM+JNnKUnns2x1eH/7ZJHxZMDwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337623; c=relaxed/simple;
	bh=PpSC7WmFvvGzbjKSzGjqBShR0Ro5S3tfapiRGnFI3a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgN95IwXZLSpFRwN1eSdcbLzlBBNXN8i2PibYrT7omsV5D8UuYManNSaMTJ0xbhW+BEHLdM+NKyyV1FBwm8c3ArDoHV+xlaa0dyzGDN+QztYREk0bgYL/0YB2rI+b5ymK97wiQ03/xH8P2VviCYM/NdLeUspfVQeLjAwzdWzjFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J6naH9Bn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C02zopcc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J6naH9Bn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C02zopcc"
Date: Wed, 2 Sep 2026 10:26:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788337619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEqnheI2tBlF7SO0sf64PUL6mHxiLqhvbl7GyJKIBTY=;
	b=J6naH9BnyWtg3g6o6dZR3V3d3c6FQRHNjFd0u84SpxI0O8rMGmDlqY4iG+YilAiOak98IO
	T8FSjW2LKmCwTWqOO6FyrU2PYRAEyozqaaG51Hf26UJtSJZZv8OwsC7+U6PMgLsPFdxbZV
	QbtHNaFwAxKXGhQidFsbWfTzTCYTtPUTki6F3tl/3wNYLSRJGA37ICKTvgaVnAowd5VF80
	Do2qZYfiRf+I7ZUmglU3kgGvACV+QKC0guIg0YfOl6oSGMO7eT/+RO9/ntOZz2JFpDSG9Y
	Zc/8//DaFQTxOwV6G2Mi65l9/FgnC40MNBkvIXnX3YiV9luUdwHOGsdsF+fnkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788337619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEqnheI2tBlF7SO0sf64PUL6mHxiLqhvbl7GyJKIBTY=;
	b=C02zopccWkmJeuIV6juBBLA119+kxyAA7lVz+XDark9PG2cIfTKJSVJjD3Dpil0qyVN9DM
	U/CR+XeCYZDbuICQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any context
Message-ID: <20260902082657.yPEhNFlo@linutronix.de>
References: <20260810122758.183765-1-puranjay@kernel.org>
 <20260810122758.183765-2-puranjay@kernel.org>
 <20260826144636.3IRUXeFV@linutronix.de>
 <CANk7y0hbwXL7nBDgjTgrneBejEgGrsZnc02RztG-aSBEEvAcwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANk7y0hbwXL7nBDgjTgrneBejEgGrsZnc02RztG-aSBEEvAcwQ@mail.gmail.com>

On 2026-09-01 14:53:56 [+0200], Puranjay Mohan wrote:
> On Wed, Aug 26, 2026 at 3:46=E2=80=AFPM Sebastian Andrzej Siewior
> > > +/*
> > > + * Defer whenever interrupts are disabled, since a callback-list ope=
ration may
> > > + * be in flight on this CPU.  Not before the scheduler is up: irq_wo=
rk is not
> > > + * usable that early, and rcu_init() itself calls call_rcu().
> > > + */
> > > +static inline bool should_rcu_defer(void)
> > > +{
> > > +     return IS_ENABLED(CONFIG_RCU_DEFER) && irqs_disabled() &&
> > > +            rcu_scheduler_active !=3D RCU_SCHEDULER_INACTIVE;
> > > +}
> >
> > Why does the description say that the defer part is for usage from NMI
> > and the test here has irqs_disabled() instead of in_nmi()?
>=20
> We defer for both irq disabled sections, hard irq, and in_nmi() and
> checking for irqs_disabled() covers all three.

But it is wrong to talk about NMI and do this for other reasons not
mentioning why this was needed/ made sense.
Can this be fixed?
Also what is the reasoning for doing it from any IRQ disabled region?

> >
> > > +
> > >  enum rcutorture_type {
> > >       RCU_FLAVOR,
> > >       RCU_TASKS_FLAVOR,
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 21b6ce1dffb63..3bf3a250f9de8 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3206,6 +3204,103 @@ __call_rcu_common(struct rcu_head *head, rcu_=
callback_t func, bool lazy_in)
> > >       local_irq_restore(flags);
> > >  }
> > >
> > > +/*
> > > + * Re-issue deferred callbacks straight to the enqueue so they canno=
t defer
> > > + * again.  ->defer_lock serializes the drainers: this CPU's irq_work,
> > > + * rcu_defer_flush() and rcutree_migrate_callbacks().
> > > + */
> > > +static void __rcu_defer_drain(struct rcu_data *rdp)
> > > +{
> > > +     struct llist_node *node, *next;
> > > +     unsigned long flags;
> > > +
> > > +     if (!IS_ENABLED(CONFIG_RCU_DEFER))
> > > +             return;
> > > +
> > > +     raw_spin_lock_irqsave(&rdp->defer_lock, flags);
> > > +     llist_for_each_safe(node, next, llist_del_all(&rdp->defer_head)=
) {
> > > +             struct rcu_head *head =3D (struct rcu_head *)node;
> >
> > Why do you need the lock. This is still not clear to me despite the
> > comment. You can do llist_del_all() towards another list and then feed
> > it into rcu_do_enqueue() one by one. And you use the LAZY part.
>=20
> Because rcu_barrier() can call this for each cpu and at the same time
> rcu_defer_drain() can call it too, so this would cause a race where
> the irq work can remove the callbacks (llist_del_all) and before it
> can enqueue them, rcu_barrier will see that the list is already empty
> and will not wait for these callbacks. We want the llist_del_all() and
> rcu_do_enqueue() to happen atomically so rcu_barrier() can work
> correctly.

So you collect a bunch of callbacks and spent time re-arranging
everything with irqs off.
What is wrong with keeping it in the llist and consuming it like the
regular rcu_segcblist?

> >
> > > +
> > > +             /* Bounds a node self-linked by a double call_rcu(). */
> > > +             head->next =3D NULL;
> > > +             rcu_do_enqueue(head, head->func, false);
> > > +     }
> > > +     raw_spin_unlock_irqrestore(&rdp->defer_lock, flags);
> > > +}
> > =E2=80=A6
> > > @@ -4231,6 +4330,9 @@ rcu_boot_init_percpu_data(int cpu)
> > >       rdp->rcu_onl_gp_state =3D RCU_GP_CLEANED;
> > >       rdp->last_sched_clock =3D jiffies;
> > >       rdp->cpu =3D cpu;
> > > +     init_llist_head(&rdp->defer_head);
> > > +     raw_spin_lock_init(&rdp->defer_lock);
> > > +     rdp->defer_work =3D IRQ_WORK_INIT_HARD(rcu_defer_drain);
> >
> > Why is this IRQ_WORK_INIT_HARD() instead, say, IRQ_WORK_INIT_LAZY()? Is
> > there a requirement that the RCU callback needs to complete asap and not
> > be delayed to the next tick? This would give kind of the LAZY part.
> >
>=20
> In discussions with Paul, we concluded that we need HARD because in
> low memory situations delaying rcu callbacks can be problematic. Given
> that we are already deferring the callbacks, it would be nice to have
> them enqueued asap. But if there are downsides to this we may change
> it later.

It does not look like you defer them for long at all. Every callback
enqueued in an IRQ-off region will be immediately re-enqueued to the
regular list the moment interrupts are enabled again.=20
Except on architectures which don't implement irq-work interrupts where
it will be delayed to the next HZ tick. And the next HZ tick does not
sound like a long time either.

> > >       rcu_boot_init_nocb_percpu_data(rdp);
> > >  }
> > >

Sebastian
