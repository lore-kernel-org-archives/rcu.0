Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609043AA9;
	Fri, 12 Jul 2024 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720806205; cv=none; b=iiP1d0R50ZRfKOxGbCujRzOBuLNEu+O5tFKL3e0EKLiHVGu4dVH4AsjncOIzEdEfpT+lKg8v9IEpPyxY/gi3Xmiq3Ex6JEp5thXX1kJwpj7CnHmngEN4wdGDXof0HFxZM+xNTavvZAMm/gsdYuoN0IPOv5w81wnB4ys9d5fnKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720806205; c=relaxed/simple;
	bh=qqDxsW8JKNo4pUvPxIdtXjmqmRm9U7qlNWm3bk3xRVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsHTatK0cAU33ZKZ1ezQlLVeQnQkMe3senGDwIen4K173/kfilxLAHE1K+xKK1izusaYs7Dr1lQAbbfJ9X0wmtmCgghARdU5jlty2rUCO+sbo89pd7J3r7E2E9Q5t5WC85nUyls9pu0wYAyqXLOz/0xTsKrnTvIi7IQpZ8dD5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=epiI7NKn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="epiI7NKn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BaNbiP+w4TmaIHZFkKIxIGkit2bo/A0i+pALN4QBZkI=; b=epiI7NKnu3BMCNcQ1ZGCpK4wNO
	oGOBbczEzsofAerhLjb+5E9D5xUZZv6sSvh0ZOr4JpEH7aIxNNb2lskWvheFGtnOlVYMvNJXRZKN4
	e7XbYBhGixpAevHHnasnaBx2CtueoVwgnrCoFIeTl3jh69wR/td8oq9SZcPc9TYWwaNlfhDVYNSdQ
	pzltnW/EoXIKLStkdD2r7oDKZ4dgSZlSDt8u+gp+byhdpLXok1zl6/TlT+2sriz9fw8ULPp3g6XTe
	59cl7/TT9i42qnKhMp7cIzBSvrxZqJy0i4IAKAYLPB93htn+ydqZLmatZj0SQyP+aBUxPMuM4+w2V
	uhplDG6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSKIb-0000000Cjju-2X8w;
	Fri, 12 Jul 2024 17:43:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1E93D30050D; Fri, 12 Jul 2024 19:43:13 +0200 (CEST)
Date: Fri, 12 Jul 2024 19:43:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Phil Auld <pauld@redhat.com>, Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH v3 10/10] sched/fair: Throttle CFS tasks on return to
 userspace
Message-ID: <20240712174313.GW27299@noisy.programming.kicks-ass.net>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-11-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711130004.2157737-11-vschneid@redhat.com>

On Thu, Jul 11, 2024 at 03:00:04PM +0200, Valentin Schneider wrote:

> +static void throttle_one_task(struct cfs_rq *cfs_rq, struct task_struct *p)
>  {
> +	long task_delta, idle_task_delta;
> +	struct sched_entity *se = &p->se;
> +
> +	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
>  
> +	task_delta = 1;
> +	idle_task_delta = cfs_rq_is_idle(cfs_rq) ? 1 : 0;
> +
> +	for_each_sched_entity(se) {
> +		cfs_rq = cfs_rq_of(se);
> +
> +		if (!se->on_rq)
> +			return;
> +
> +		dequeue_entity(cfs_rq, se, DEQUEUE_SLEEP);
> +		cfs_rq->h_nr_running -= task_delta;
> +		cfs_rq->idle_h_nr_running -= idle_task_delta;
> +
> +		if (cfs_rq->load.weight) {
> +			/* Avoid re-evaluating load for this entity: */
> +			se = parent_entity(se);
> +			break;
> +		}
> +	}
> +
> +	for_each_sched_entity(se) {
> +		cfs_rq = cfs_rq_of(se);
> +		/* throttled entity or throttle-on-deactivate */
> +		if (!se->on_rq)
> +			goto throttle_done;
> +
> +		update_load_avg(cfs_rq, se, 0);
> +		se_update_runnable(se);
> +		cfs_rq->h_nr_running -= task_delta;
> +		cfs_rq->h_nr_running -= idle_task_delta;
> +	}
> +
> +throttle_done:
> +	/* At this point se is NULL and we are at root level*/
> +	sub_nr_running(rq_of(cfs_rq), 1);
>  }

I know you're just moving code around, but we should look if we can
share code between this and dequeue_task_fair().

I have patches around this in that eevdf series I should send out again,
I'll try and have a stab.

> -static void task_throttle_cancel_irq_work_fn(struct irq_work *work)
> +static void throttle_cfs_rq_work(struct callback_head *work)
>  {
> -       /* Write me */
> +	struct task_struct *p = container_of(work, struct task_struct, sched_throttle_work);
> +	struct sched_entity *se;
> +	struct rq *rq;
> +	struct cfs_rq *cfs_rq;
> +
> +	WARN_ON_ONCE(p != current);
> +	p->sched_throttle_work.next = &p->sched_throttle_work;
> +	/*
> +	 * If task is exiting, then there won't be a return to userspace, so we
> +	 * don't have to bother with any of this.
> +	 */
> +	if ((p->flags & PF_EXITING))
> +		return;
> +
> +	CLASS(task_rq_lock, rq_guard)(p);
> +	rq = rq_guard.rq;

The other way to write this is:

	scoped_guard (task_rq_lock, p) {
		struct rq *rq = scope.rq;

> +	se = &p->se;
> +	cfs_rq = cfs_rq_of(se);
> +
> +	/*
> +	 * If not in limbo, then either replenish has happened or this task got
> +	 * migrated out of the throttled cfs_rq, move along
> +	 */
> +	if (!cfs_rq->throttle_count)
> +		return;
> +
> +	update_rq_clock(rq);
> +
> +	throttle_one_task(cfs_rq, p);
> +
> +	resched_curr(rq);

	}

>  }
