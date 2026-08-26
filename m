Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583E7445AC1;
	Wed, 26 Aug 2026 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755605; cv=none; b=s80RgSkrg8OCRdXbWXLalN13v/RdAfJnb8OucGugxzkl/VhnCFKBeddd2gUNz4hSXzvPEOYrpfzIXRKFwC7CM4L5xHMy0JS8+/qhN+NCad1aF4PYlEBPAE5yIChgLj5iChQ0YiVN9IdBQWYqvg8EhCx+qLVwZCgCPqziWBLN1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755605; c=relaxed/simple;
	bh=n/5mZkYkKK5GavBNGTNXlJp3qMnQh82rUrq1G8+x6Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PG7n8Qmnzrq6WMkF8nEXoErNdjk1XPJrXQCAvXOuPfUE6Teox7nPEO0FFl30Y905mX2hbkOwLnrJATFTtoIBt6wWRtnCwcItRVzclWUtGhuLEdHsDngGGoEMGkcIuvYV/ioWEJjkdSY2ocPh5k41OxbMUUcmceZ7DapZtBng4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LrU6HUGT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gozkSWv+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LrU6HUGT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gozkSWv+"
Date: Wed, 26 Aug 2026 16:46:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787755597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0Kkynge44FrWWoalc/XYt1t696+d537CJ47hQiSN5E=;
	b=LrU6HUGTkQ/HPzremJzckNm2cqpOlgdcnVt6mDteTHCiWw38x2TkLAPOkDqwYKiASklx/L
	16cJ8SSSTa7or4LPHRb9naKFyEoYjDUeC7RsEIQySnA5ZWHWjJpJZq6N+xS9FalE0OB3OB
	5V9TADPX2yz9EYITk0j2qBA0v2y9Df+m0oRzu7NNGth7jHhLBktHDad8Pihk2vvXfkTrQ+
	glUH2itooDT6gk79kYPFH7nSw6/HU13o8ew/kJO5j9u4RUvJhRViY/HhprQ2x5OK/bIzth
	bq0bvFl8/T0ixvO1FIui8ErYqQPhceCZ3BQH6abLN5pj9+WLUvBHxWuYjTljEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787755597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0Kkynge44FrWWoalc/XYt1t696+d537CJ47hQiSN5E=;
	b=gozkSWv+kjmm1LlGRIFiYIde5MxTEoTadSEOrNSFuVaThoY56VhcztspbhDoqkXFnMK/mz
	hyMu85VWKTOTPkBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Puranjay Mohan <puranjay@kernel.org>
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
Message-ID: <20260826144636.3IRUXeFV@linutronix.de>
References: <20260810122758.183765-1-puranjay@kernel.org>
 <20260810122758.183765-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260810122758.183765-2-puranjay@kernel.org>

On 2026-08-10 05:27:50 [-0700], Puranjay Mohan wrote:
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -572,6 +572,17 @@ static inline void tasks_cblist_init_generic(void) {=
 }
>  #define RCU_SCHEDULER_INIT	1
>  #define RCU_SCHEDULER_RUNNING	2
> =20
> +/*
> + * Defer whenever interrupts are disabled, since a callback-list operati=
on may
> + * be in flight on this CPU.  Not before the scheduler is up: irq_work i=
s not
> + * usable that early, and rcu_init() itself calls call_rcu().
> + */
> +static inline bool should_rcu_defer(void)
> +{
> +	return IS_ENABLED(CONFIG_RCU_DEFER) && irqs_disabled() &&
> +	       rcu_scheduler_active !=3D RCU_SCHEDULER_INACTIVE;
> +}

Why does the description say that the defer part is for usage from NMI
and the test here has irqs_disabled() instead of in_nmi()?

> +
>  enum rcutorture_type {
>  	RCU_FLAVOR,
>  	RCU_TASKS_FLAVOR,
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 21b6ce1dffb63..3bf3a250f9de8 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3206,6 +3204,103 @@ __call_rcu_common(struct rcu_head *head, rcu_call=
back_t func, bool lazy_in)
>  	local_irq_restore(flags);
>  }
> =20
> +/*
> + * Re-issue deferred callbacks straight to the enqueue so they cannot de=
fer
> + * again.  ->defer_lock serializes the drainers: this CPU's irq_work,
> + * rcu_defer_flush() and rcutree_migrate_callbacks().
> + */
> +static void __rcu_defer_drain(struct rcu_data *rdp)
> +{
> +	struct llist_node *node, *next;
> +	unsigned long flags;
> +
> +	if (!IS_ENABLED(CONFIG_RCU_DEFER))
> +		return;
> +
> +	raw_spin_lock_irqsave(&rdp->defer_lock, flags);
> +	llist_for_each_safe(node, next, llist_del_all(&rdp->defer_head)) {
> +		struct rcu_head *head =3D (struct rcu_head *)node;

Why do you need the lock. This is still not clear to me despite the
comment. You can do llist_del_all() towards another list and then feed
it into rcu_do_enqueue() one by one. And you use the LAZY part.

> +
> +		/* Bounds a node self-linked by a double call_rcu(). */
> +		head->next =3D NULL;
> +		rcu_do_enqueue(head, head->func, false);
> +	}
> +	raw_spin_unlock_irqrestore(&rdp->defer_lock, flags);
> +}
=E2=80=A6
> @@ -4231,6 +4330,9 @@ rcu_boot_init_percpu_data(int cpu)
>  	rdp->rcu_onl_gp_state =3D RCU_GP_CLEANED;
>  	rdp->last_sched_clock =3D jiffies;
>  	rdp->cpu =3D cpu;
> +	init_llist_head(&rdp->defer_head);
> +	raw_spin_lock_init(&rdp->defer_lock);
> +	rdp->defer_work =3D IRQ_WORK_INIT_HARD(rcu_defer_drain);

Why is this IRQ_WORK_INIT_HARD() instead, say, IRQ_WORK_INIT_LAZY()? Is
there a requirement that the RCU callback needs to complete asap and not
be delayed to the next tick? This would give kind of the LAZY part.

>  	rcu_boot_init_nocb_percpu_data(rdp);
>  }
> =20

Sebastian
