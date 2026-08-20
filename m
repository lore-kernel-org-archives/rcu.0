Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2561442FDF;
	Thu, 20 Aug 2026 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229662; cv=none; b=Qpm0AkcTOS/qLdWsMAgFQcJ/2ospHXV4/7VKFcLv0r+ToH/O1VYoccUzURUcaz75MKQXpLU5+1PdmehD8ey7aVcGY5vobDsyQe3uOUun6DucUaSpnVPH7Da9HvLHHYLyicI5hhV++eqo9TZ55ZtCeWN5VNEaRimBDkuyQjti008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229662; c=relaxed/simple;
	bh=VAZZ2Y1LWKap9E/i226F+nn95N/7GO9GkSjL+CjzNic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFA3aVp7ozUh3P3Aga0TI925dGUeCII1G3NVhPm3cLuis5uStCLGHwzdAcCIAt7Dek65SH+cWgF2PVC7QsJtxp3eXK7L9PB9bQWDx1u2bmbmae99h2fycaMV66CN8dPOymqXFSRNlYC52A58Tqk2i7NgqeO2a7Eru7gNX13JQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h36AqGgI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h36AqGgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F001F000E9;
	Thu, 20 Aug 2026 12:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787229660;
	bh=T+QhJbr+jTjBvneIP1Jsy5gWlCd3OxO8jUFRHo3MHXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h36AqGgIewqgS/ZhTput6kUvAbtmjI4JPKGxoifwm5XzdkxGliRSSM/ulurc48HTZ
	 sZBKrObpevXcegFgE/trkBhZNHHdiypSumapETlBC3s+w7AVvkmmogqhRHm1S1skpJ
	 iF3a4OhHaZfMlMHzHYUmwvLl3YOzV0whoKqB5u+PABxPsN++Z3ZQy231WIbIU7gWhO
	 zM188/l5Y7dzl2teWh1bZRk03XC7cMoNXMgKcOrClqbGuTLxWo0a/AY486btgZOGi6
	 JiQ2FfFDARCybL6ghiP1NxtLrcoDF3YW9+561g0S0mc+c0L0blfZ1qn4pD/0iGgpHV
	 a5p+Sb2PW8ofQ==
Date: Thu, 20 Aug 2026 14:40:57 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rcu@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH] rcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work
Message-ID: <aob12RahomSmpUQY@localhost.localdomain>
References: <20260820110008.v2Tlr0_H@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820110008.v2Tlr0_H@linutronix.de>

Le Thu, Aug 20, 2026 at 01:00:08PM +0200, Sebastian Andrzej Siewior a écrit :
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
> ---
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 7c2f7cc131f7a..b703233d4a63f 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -218,7 +218,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
>  	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
>  	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
> -	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
> +	ssp->srcu_sup->irq_work = IRQ_WORK_INIT_HARD(srcu_irq_work);

It may need a comment to not lose that.

>  	ssp->srcu_sup->sda_is_static = is_static;
>  	if (!is_static) {
>  		ssp->sda = alloc_percpu(struct srcu_data);
> -- 
> 2.55.0
> 
>

Perhaps all irq works queued before the relevant kthread is started should
temporarily be queued as hard?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
