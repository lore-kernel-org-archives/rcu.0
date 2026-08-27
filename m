Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6A841D64E;
	Thu, 27 Aug 2026 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851639; cv=none; b=nuWug349SQy/3wFMVrdwssf22I3kIS0h9Wv1xyL021E1mXqwyYjPuzvzR+Opq3t8mW+a9rhwsh6G12ThxKc0JF0EURLU4+cKWKldMxv9ckS5WNm1joMAUA8UjIP5hM4EOLM9dRn2lPy3EknirJO0KsV46OMod2pEJKS9jQc9zmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851639; c=relaxed/simple;
	bh=JcIA44QFQn7yq9+16zF2C/HfRNhySvLZOghbFAZcrsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGDU1D+Qr4vwYTYBDTbMEVucEqI9wGMrNigI746rDmuk78Ycqzrgnd3yfCE8Txq4jUBe2gklaLD90FyUK+gKAr2eXbLREVFjqC8cirrwQV7UntcTCI0qNeV8V7HirEocqyWYUI04Sga7S3cVL8upeNc5WrUDyfkxUL4Z7ZkHrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSpeYBwp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSpeYBwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E761F000E9;
	Thu, 27 Aug 2026 17:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787851638;
	bh=wb8/PaE9nlh/ttFtA9nVW7bKJvAZHzkzBtGOm4m5e98=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=iSpeYBwpuq5oexga8bQdYpswz+qOUjEdeE6bOc1r5n9+IWpVIwkcM2D8daLDOtq8E
	 T3KOwyij75C/wBFx5D+fKbDZGxzQCS+eSPhO9GgQyBYok5KB571ArHcc7Szt+D2KxU
	 9WoZYfoQjpaOLvMx0ZISTIW+0kpPy+TOFbQHfyykNn4e5Nkbgr+MFv8H+2zdakekv4
	 IO4VUof/M8DCIy6qpZT5ijL+RyXb0YCPvzlwekFQjsN72HD3NIQ1fMtjoErsz6OPnj
	 pM/BWXLvBvQpUGQEB8O3Nsf0LrANzbdR92glQPEHeK6MbW/uniPlUxtioDyY0Eeyno
	 WqF8ztUK0bU4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D33C2CE1496; Thu, 27 Aug 2026 10:27:17 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:27:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH v2] rcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work
Message-ID: <5fd51e21-6afa-448d-bd43-6f6a2ac45cc6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260821183809.-kRAXbZs@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821183809.-kRAXbZs@linutronix.de>

On Fri, Aug 21, 2026 at 08:38:09PM +0200, Sebastian Andrzej Siewior wrote:
> The irq_work in srcu is used to schedule a delayed work. The work item
> is not scheduled directly because it is not always possible wake a
> thread directly.
> 
> On PREEMPT_RT the default irq_work is initialized with IRQ_WORK_LAZY and
> is delayed to the irq_work thread. A system booted with the command line
> "trace_event=…" will freeze during boot because the irq_work thread is
> not yet deployed (and tracing uses synchronize_srcu() in
> tp_rcu_cond_sync()).
> 
> The irq_work performs just a wakeup a thread, there is nothing wrong
> with doing this from hardirq context on PREEMPT_RT.
> 
> Use IRQ_WORK_INIT_HARD for srcu's irq_work.
> 
> Fixes: 7c405fb3279b3 ("rcu: Use an intermediate irq_work to start process_srcu()")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Good catch, queued for further review and testing, thank you!

							Thanx, Paul

> ---
> v1…v2: https://lore.kernel.org/all/20260820110008.v2Tlr0_H@linutronix.de/
> - Add a comment as suggested by Steven.
> 
>  kernel/rcu/srcutree.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 7c2f7cc131f7a..af9fe0165a800 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -218,7 +218,12 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
>  	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
>  	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
> -	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
> +	/*
> +	 * trace events started on the command line require SRCU before
> +	 * the irq_work kthread starts. Since all it does is a simple
> +	 * wakeup, having it as a hard irq, even on PREEMPT_RT is fine.
> +	 */
> +	ssp->srcu_sup->irq_work = IRQ_WORK_INIT_HARD(srcu_irq_work);
>  	ssp->srcu_sup->sda_is_static = is_static;
>  	if (!is_static) {
>  		ssp->sda = alloc_percpu(struct srcu_data);
> -- 
> 2.55.0
> 
