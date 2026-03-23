Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94412517AF
	for <rcu@vger.kernel.org>; Mon, 23 Mar 2026 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279037; cv=none; b=lYvGBA5JZVhUFr6oK6LiOYJQVskco6SJuPIEWTWbUOEjfkZ9LV8fAJ+ofWkSn8x6Cyjw6xIaHdJXT6q/OdyuHsNOUxYE8wOK5GJZma0wlMad/826/g9i2dWf9iEiE3ujpsx28akJkagdfRVgkIzfrVFeGWWWzNubdGxZtP/L0mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279037; c=relaxed/simple;
	bh=RTqk01LdlqaOR6mFUfqyz5FAgC/MGiNByQyB0szsxH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvMcQDdnwVD7v9F7aLSOzTJWp1Yvb2571f0W5S89oza2O7ugS4fxFPy/Kh5GpGLoNL1YDfPJRygIJB1k7O9gTc6KdNzdTaigT09fjwXNY3yHGi4ANRQaowneG8seu3n5DL5SfIk4XFhGM6lTTICihUj38qGbmtDwntZPnwH1n4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtrPDj08; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtrPDj08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392A0C2BC9E;
	Mon, 23 Mar 2026 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774279037;
	bh=RTqk01LdlqaOR6mFUfqyz5FAgC/MGiNByQyB0szsxH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtrPDj08n5+18nXNSAeYVnqZvsuCBndBPvIUEzPG4ycUovu4dQ7pOdtCrr/2BOWbA
	 aW0wLZkcBH/64LJj9WKTvyaKDKKbgFEeinKDxpv90vm61qYYUU9smRBU8LLtH+JiJM
	 8BqhSmsuJRz83F1UDDu9kF7mEdqXiD4C7GJArGTwZ+A/5kYuPqBTTNTcUq/bVAwFZh
	 DJuuc+GPWgAcKEZM/BuDMi0GoCdxiNqhOc3zUhTp5kd16Mwhu+OzpmlvvpXviSjGda
	 vj93Upf5qLsWYl2AQWMpfoErW9KN0+dc/cqgTE6rsefYTGJz1dKlULlPfKUxZMsib+
	 dl84UWGWhTV5Q==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4FDFAF40074;
	Mon, 23 Mar 2026 11:17:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 23 Mar 2026 11:17:16 -0400
X-ME-Sender: <xms:fFnBaYGcuFgjT9GgX9TpZELDBpOsJQeVNha687FyTRiR7l8Dfpj05Q>
    <xme:fFnBaavUiJk6-7wqtyuIjCYeTW1oUsCoWoPQRS0ZtPS8jPftqgqppF0KTGXvlMSj3
    _1aIkC0bU0yL16hbJ1h90K5QVumrjmR2ysOc1xB34m8pFG2aInyCoY>
X-ME-Received: <xmr:fFnBaaps93WnrpYIUXJI74psubn3TbfqrLDbulu1Kqt94-b6O_A5wPRBGPLuw8tu2Nbzi7-5-1--4OrqN1wNhzL2Qkz8ursi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fhveeuvdfggfefuedtgeefvedtteekveeitefffffgfefhvddvhfeijedvudeggeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeejkeehheehvd
    dqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpdhnsggprhgt
    phhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhovghlrghgnh
    gvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmvghmgihorhesghhmrghilhdrtghomhdprhgtphhtth
    hopegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepfhhrvggu
    vghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdrihhithhrud
    dtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fFnBaZl-6lofMcOCoiTxFGalW4aPjGfoWS72VRPLeCPVGgFhY9kqrg>
    <xmx:fFnBafhiTqVfKiIiKTlioDFamEwSpHbb-DzMZoKSyZkjZ49gAa2n_Q>
    <xmx:fFnBaYW9bMmGNG6eGVIXEMb6vKMkuKccOBm844HXzGnUhjgRvcSitg>
    <xmx:fFnBaQvSIzyQ69PlcSIqpjpkvaP5eLr0gfkz0-rTiv2NYN8lb68fXA>
    <xmx:fFnBaZYPXz8oEtlvAQ_r-5l4JRguqDSC-MH7vC2YOLoIsZ-j1-0J-NNK>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:17:15 -0400 (EDT)
Date: Mon, 23 Mar 2026 08:17:14 -0700
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Song Liu <song@kernel.org>, stable@kernel.org
Subject: Re: [RFC PATCH] rcu-tasks: Avoid using mod_timer() in
 call_rcu_tasks_generic()
Message-ID: <acFZem9MNHRXin2h@tardis.local>
References: <2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop>
 <20260321170321.32257-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321170321.32257-1-boqun@kernel.org>

On Sat, Mar 21, 2026 at 10:03:21AM -0700, Boqun Feng wrote:
> The following deadlock is possible:
> 
> __mod_timer()
>   lock_timer_base()
>     raw_spin_lock_irqsave(&base->lock)   <- base->lock ACQUIRED
>   trace_timer_start()                    <- tp_btf/timer_start fires here
>     [probe_timer_start BPF program]
>       bpf_task_storage_delete()
>         bpf_selem_unlink(selem, false)   <- reuse_now=false
>           bpf_selem_free(false)
>             call_rcu_tasks_trace()
>               call_rcu_tasks_generic()
>                 raw_spin_trylock(rtpcp)  <- succeeds (different lock)
>                 mod_timer(lazy_timer)    <- lazy_timer is on this CPU's base
>                   lock_timer_base()
>                     raw_spin_lock_irqsave(&base->lock) <- SAME LOCK -> DEADLOCK
> 
> because BPF can instrument a place while the timer base lock is held.
> Fix it by using an intermediate irq_work.
> 
> Further, because a "timer base->lock" to a "rtpcp lock" lock dependency
> can be establish in this way, we cannot mod_timer() with a rtpcp lock
> held. Fix that as well.
> 
> Fixes: d119357d0743 ("rcu-tasks: Treat only synchronous grace periods urgently")
> Cc: stable@kernel.org
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> ---
> This is a follow-up of [1], and yes we can trigger a whole system
> deadlock freeze easily with (even non-recursively) tracing the
> timer_start tracepoint. I have a reproduce at:
> 
> 	https://github.com/fbq/rcu_tasks_deadlock
> 
> Be very careful, since it'll freeze your system when run it.
> 
> I've tested it on 6.17 and 6.19 and can confirm the deadlock could be
> triggered. So this is an old bug if it's a bug.
> 
> It's up to BPF whether this is a bug or not, because it has existed for
> a while and nobody seems to get hurt(?).
> 

Ping BPF ;-) I know this was sent in a Saturday and only 2 days have
passed, but we are at the decision point about how hard/urgent we should
fix these "BPF deadlocks": As this patch shows, the deadlocks existed
before v7.0 (i.e. before SRCU switches). And yes, ideally we should fix
all of them, but given we are close to v7.0 release, I would like to
focus the new issue that SRCU introduces, because that one would likely
affect SCHED_EXT. Thoughts?

Regards,
Boqun

> [1]: https://lore.kernel.org/rcu/2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop/
> 
>  kernel/rcu/tasks.h | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 2b55e6acf3c1..d9d5b7d5944e 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -46,6 +46,7 @@ struct rcu_tasks_percpu {
>  	unsigned int urgent_gp;
>  	struct work_struct rtp_work;
>  	struct irq_work rtp_irq_work;
> +	struct irq_work timer_irq_work;
>  	struct rcu_head barrier_q_head;
>  	struct list_head rtp_blkd_tasks;
>  	struct list_head rtp_exit_list;
> @@ -134,6 +135,7 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
>  static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
>  	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),		\
>  	.rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),			\
> +	.timer_irq_work = IRQ_WORK_INIT(call_rcu_tasks_mod_timer_lazy),			\
>  };											\
>  static struct rcu_tasks rt_name =							\
>  {											\
> @@ -321,11 +323,19 @@ static void call_rcu_tasks_generic_timer(struct timer_list *tlp)
>  		if (!rtpcp->urgent_gp)
>  			rtpcp->urgent_gp = 1;
>  		needwake = true;
> -		mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
> +		/*
> +		 * We cannot mod_timer() here because "timer base lock ->
> +		 * rcu_node lock" lock dependencies can be establish by having
> +		 * a BPF instrument at timer_start(), and that means deadlock
> +		 * if we mod_timer() here. So delay the mod_timer() when we are
> +		 * out of the lock critical section.
> +		 */
>  	}
>  	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> -	if (needwake)
> +	if (needwake) {
> +		mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
>  		rcuwait_wake_up(&rtp->cbs_wait);
> +	}
>  }
>  
>  // IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
> @@ -338,6 +348,16 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
>  	rcuwait_wake_up(&rtp->cbs_wait);
>  }
>  
> +static void call_rcu_tasks_mod_timer_lazy(struct irq_work *iwp)
> +{
> +	struct rcu_tasks *rtp;
> +	struct rcu_tasks_percpu *rtpcp = container_of(iwp, struct rcu_tasks_percpu, timer_irq_work);
> +	rtp = rtpcp->rtpp;
> +
> +	if (!timer_pending(&rtpcp->lazy_timer))
> +		mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
> +}
> +
>  // Enqueue a callback for the specified flavor of Tasks RCU.
>  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  				   struct rcu_tasks *rtp)
> @@ -377,7 +397,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  		   (rcu_segcblist_n_cbs(&rtpcp->cblist) == rcu_task_lazy_lim);
>  	if (havekthread && !needwake && !timer_pending(&rtpcp->lazy_timer)) {
>  		if (rtp->lazy_jiffies)
> -			mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
> +			irq_work_queue(&rtpcp->timer_irq_work);
>  		else
>  			needwake = rcu_segcblist_empty(&rtpcp->cblist);
>  	}
> -- 
> 2.50.1 (Apple Git-155)
> 
