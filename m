Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626EB10E5
	for <rcu@vger.kernel.org>; Fri, 19 Jul 2024 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721348758; cv=none; b=LUcKcPczrBlamPN71/GQF/NyaXqLsqha2N1lmiDEI9VvDtfmtB8MKSOnZenx5rFpbqpTqLBrOrgt7JXDctn5g72M9QoXeDG7O6WF9pO01UHJY9RXE8dKWLxDzGmkYp0T5Y59bFSw/4U4hukTjCF8OdgCUVRBFXRnMyV97+UPrnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721348758; c=relaxed/simple;
	bh=lJy9B1nonrmJVG65IYJ6oKQ7YdpWh3mrkk1EsvveLJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uBaZBsBNjgA3ZoQwialmq6IMFFjDOG+7XTCjZ/BqxH76w6D04W0JPpVayAiLo1BzvwQhQ5D+5iZplKNFMUXybKrH9xhcfOQnh0TqEbQkcGyfhdx/k+syfBExAtqNP3ViIMQ3Q1EeCqnK+fYoP2n54D12kxaJXv95Us8sDG/S6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xzKJuLTb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xzKJuLTb"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc312a36f9so76015ad.0
        for <rcu@vger.kernel.org>; Thu, 18 Jul 2024 17:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721348755; x=1721953555; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gojok+SvOUVoqIjWgG8xsTF5fZD2yKtYq2ZZ6niyvds=;
        b=xzKJuLTbAjLFKnRluer/oGftzElZRmeOPzidUgF2nagDtaHtpfjF9FoCAKEh8b8s6J
         1I40Q82kAB/jWf0CBaUy1siWoREk4G5daqEfHfYN11KvVZpnr2HVHdJAIpvA0KpEuEBE
         OCBptcFK67GzGu0p0dfUSeQA39MbfhIeRLuH/EAek138HMwkUMpBbG1GZrMjBoknqGWk
         ku8fKZvZz8qKWakQAtsVx/wmS7qWoIiEFWc1E6foNTLuV5oNscHI5Vav0PEOV9R8ROVi
         8j6qcZ2ACVPepLtajC4xA/DwhvAK8QyHpGNCJhe1Sf3n7Atkuvu2hK0SsO+OMKuIh7In
         wQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721348755; x=1721953555;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gojok+SvOUVoqIjWgG8xsTF5fZD2yKtYq2ZZ6niyvds=;
        b=ihyqCjUmOZqTSmixxhnoApOnzAw/zd1CWm9vcT59t4ZjhiNUX/j9CuikFn3VmG5gTb
         pur8SCeNGRKqH7dv+F2KeVdIBrd3fU11/ST4umvFqEi0/Ae7tGktZ+spOtfGWhs7BYnw
         4ogEHK+oD7zLmbXZoN08HVh82ZTHPDXkUfdIvJ2BKsmTAxkciCcID4JxGS55I4BOky9b
         S0pusgsN+9EFxo5WJvgzwphsCiH5N+veJ0osjvefC8DgLKnE1Wua57DS5QaZjUT8VhIu
         F/2gQbaE2sKBOn+OjBceGGJGyU9BYaT3o4L1Ph+pVtX9aXsPt1IQD8hGCZ7U3a9m2qZ1
         bUjA==
X-Forwarded-Encrypted: i=1; AJvYcCXzbPwiGvejNtX8RFYHnoP+TIyq04Mf5zitJlBSnpDFwI7JlSmcnEit8dFGKvQnCIT8IBok0wLr+wgdrSVdirs6amNF
X-Gm-Message-State: AOJu0YzzOE+pIaXOTxjjlea6VTZrysaoMarorO5qkiN4Q29OgWNa7quE
	l0DQxYkNWpmF7aMpDxpXuTg8R8dFxH9NMF5ZQQCSoYaTsrtKo4ycH9jSrlBeMQ==
X-Google-Smtp-Source: AGHT+IHE8poRWm/M4KPwtC+tV+ik5Q/QroHl5aL/KXhsrhWrxhXMpGeNRWwUSAofrUddrZLaQi1aCQ==
X-Received: by 2002:a17:902:ec84:b0:1fb:2f12:9edf with SMTP id d9443c01a7336-1fd6444eb45mr659725ad.27.1721348754115;
        Thu, 18 Jul 2024 17:25:54 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd64d0a1d3sm1704415ad.169.2024.07.18.17.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 17:25:53 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,  rcu@vger.kernel.org,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Juri Lelli
 <juri.lelli@redhat.com>,  Vincent Guittot <vincent.guittot@linaro.org>,
  Dietmar Eggemann <dietmar.eggemann@arm.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Mel Gorman <mgorman@suse.de>,  Phil Auld
 <pauld@redhat.com>,  Clark Williams <williams@redhat.com>,  Tomas Glozar
 <tglozar@redhat.com>,  "Paul E. McKenney" <paulmck@kernel.org>,  Frederic
 Weisbecker <frederic@kernel.org>,  Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>,  Joel Fernandes <joel@joelfernandes.org>,
  Josh Triplett <josh@joshtriplett.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Lai Jiangshan <jiangshanlai@gmail.com>,
  Zqiang <qiang.zhang1211@gmail.com>,  Alexander Gordeev
 <agordeev@linux.ibm.com>,  Catalin Marinas <catalin.marinas@arm.com>,
  Arnd Bergmann <arnd@arndb.de>,  Guo Ren <guoren@kernel.org>,  Palmer
 Dabbelt <palmer@rivosinc.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Oleg Nesterov <oleg@redhat.com>,  Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH v3 10/10] sched/fair: Throttle CFS tasks on return
 to userspace
In-Reply-To: <20240711130004.2157737-11-vschneid@redhat.com> (Valentin
	Schneider's message of "Thu, 11 Jul 2024 15:00:04 +0200")
References: <20240711130004.2157737-1-vschneid@redhat.com>
	<20240711130004.2157737-11-vschneid@redhat.com>
Date: Thu, 18 Jul 2024 17:25:51 -0700
Message-ID: <xm26y15yz0q8.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Valentin Schneider <vschneid@redhat.com> writes:

> As reported in [1], CFS bandwidth throttling is a source of headaches in
> PREEMPT_RT - generally speaking, a throttled CFS task can hold locks that
> prevent ksoftirqd from running, which prevents replenishing & unthrottling
> the cfs_rq of said CFS task.
>
> Peter mentioned that there have been discussions on changing /when/ the
> throttling happens: rather than have it be done immediately upon updating
> the runtime statistics and realizing the cfs_rq has depleted its quota, we wait
> for the task to be about to return to userspace.

Sorry for taking a while to get to replying ot this.

> Clocks
> ======
>
> Correctly handling the different cfs_rq->throttled_clock* is tricky, as
> unlike the current upstream approach where all tasks of a cfs_rq are
> throttled at the exact same time, here they each get throttled at a
> per-task, not-known-beforehand time.
>
> For instance, for the ->throttled_clock_pelt, ideally we would need a
> per-task snapshot of when the task gets really throttled in
> exit_to_user_mode(), rather than a single snapshot of when the cfs_rq runs
> out of runtime. This isn't implemented here. The ->throttled_clock_pelt is
> set when the cfs_rq runs out of runtime, which means the "grace period"
> given to the cfs_rq's tasks on their way to exit_to_user_mode() isn't
> accounted.

And I haven't checked it yet because I never remember how the whole
throttled clock thing works. :P

>
> Notable behaviour changes
> =========================
>
> Once a cfs_rq is ->throttled, its tasks can continue running until they hit
> exit_to_user_mode(). This means they can keep draining further runtime
> from their cfs_rq, which can end up draining more than one period's worth
> of runtime.
>
> I've tested a 10ms runtime / 100ms period cgroup with an always running
> task: upstream gets a "clean" periodic pattern of 10ms runtime every 100ms,
> whereas this gets something more like 40ms runtime every 400ms.

Hmm, this seems a little odd since TWA_RESUME does a kick_process.

> +static inline void task_throttle_setup_work(struct task_struct *p)
> +{
> +	/*
> +	 * Kthreads and exiting tasks don't return to userspace, so adding the
> +	 * work is pointless
> +	 */
> +	if (!(p->flags & (PF_EXITING | PF_KTHREAD)))
> +		task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
> +}
> +
> +static void throttle_cfs_rq_work(struct callback_head *work);
> +static inline void task_throttle_do_cancel_work(struct task_struct *p)
> +{
> +	/*
> +	 * If this returns NULL, it means the work got run, which per
> +	 * this being called is a bug: the task_work throttled the
> +	 * task when it didn't need to be.
> +	 */
> +	WARN_ON_ONCE(!task_work_cancel_locked(p, throttle_cfs_rq_work));
> +	p->sched_throttle_work.next = &p->sched_throttle_work;
> +}
> +
> +static inline void task_throttle_cancel_work(struct task_struct *p, int dst_cpu)
> +{
> +       /*
> +	* The calling context may be holding p->pi_lock, which is also acquired
> +	* by task_work_cancel_match().
> +	*
> +	* Lock recursion is prevented by punting the work cancellation to the
> +	* next IRQ enable. This is sent to the destination CPU rather than
> +	* >this< CPU to prevent the task from resuming execution and getting
> +	* throttled in its return to userspace.
> +	*/
> +       irq_work_queue_on(&p->unthrottle_irq_work, dst_cpu);
> +}
> +
> +static void task_throttle_cancel_irq_work_fn(struct irq_work *work)
> +{
> +	struct task_struct *p = container_of(work, struct task_struct, unthrottle_irq_work);
> +	int cpu = raw_smp_processor_id();
> +
> +	CLASS(task_rq_lock, rq_guard)(p);
> +	WARN_ON_ONCE(task_cpu(p) != cpu);
> +
> +	if (task_has_throttle_work(p) && !task_needs_throttling(p))
> +		task_throttle_do_cancel_work(p);
> +}

I think you can wind up triggering this WARN and in general have some
weird state, whether or not it matters, basically any time that you
__task_throttle_cancel(p, a_remote_cpu).

It queues an irq_work and sends an IPI, but doesn't wait for it. If
handling that IPI is delayed, then we can wind up doing more
migration/class switch/etc (on this cpu or some third cpu) before that
irq_work runs.

I think this may be ok and it's just the WARN that's wrong, but I'm not
sure.



> @@ -5722,35 +5825,107 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
>  {
>  	struct rq *rq = data;
>  	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> +	struct sched_entity *se = tg->se[cpu_of(rq)];
> +	struct cfs_rq *pcfs_rq = cfs_rq_of(se);
> +	long task_delta = 0, idle_task_delta = 0;
> +	struct task_struct *p, *tmp;
>  
>  	cfs_rq->throttle_count--;
> -	if (!cfs_rq->throttle_count) {
> -		cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
> -					     cfs_rq->throttled_clock_pelt;
> +	if (cfs_rq->throttle_count)
> +		return 0;
>  
> -		/* Add cfs_rq with load or one or more already running entities to the list */
> -		if (!cfs_rq_is_decayed(cfs_rq))
> -			list_add_leaf_cfs_rq(cfs_rq);
> +	cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
> +		cfs_rq->throttled_clock_pelt;
> +
> +	/* Add cfs_rq with load or one or more already running entities to the list */
> +	if (!cfs_rq_is_decayed(cfs_rq))
> +		list_add_leaf_cfs_rq(cfs_rq);
>  
> -		if (cfs_rq->throttled_clock_self) {
> -			u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;
> +	if (cfs_rq->throttled_clock_self) {
> +		u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;
>  
> -			cfs_rq->throttled_clock_self = 0;
> +		cfs_rq->throttled_clock_self = 0;
>  
> -			if (SCHED_WARN_ON((s64)delta < 0))
> -				delta = 0;
> +		if (SCHED_WARN_ON((s64)delta < 0))
> +			delta = 0;
>  
> -			cfs_rq->throttled_clock_self_time += delta;
> -		}
> +		cfs_rq->throttled_clock_self_time += delta;
> +	}
> +
> +	/*
> +	 * Re-enqueue the tasks that have been throttled at this level.
> +	 *
> +	 * The task count is up-propagated via ->unthrottled_*h_nr_running,
> +	 * as we can't purely rely on h_nr_running post-enqueue: the unthrottle
> +	 * might happen when a cfs_rq still has some tasks enqueued, either still
> +	 * making their way to userspace, or freshly migrated to it.
> +	 */
> +	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
> +		struct sched_entity *pse = &p->se;
> +
> +		list_del_init(&p->throttle_node);
> +
> +		enqueue_entity(cfs_rq, pse, ENQUEUE_WAKEUP);
> +		task_delta++;
> +		idle_task_delta += task_has_idle_policy(p);
> +	}

You know, on our too-large machines with too-many cgroups, we're already
running into these walk_tg_trees being worrying slow for holding a spinlock :P

> +
> +	/*
> +	 * Account tasks woken up in children; by this point all direct children
> +	 * have been visited.
> +	 */
> +	task_delta += cfs_rq->unthrottled_h_nr_running;
> +	idle_task_delta += cfs_rq->unthrottled_idle_h_nr_running;
> +
> +	cfs_rq->h_nr_running += task_delta;
> +	cfs_rq->idle_h_nr_running += idle_task_delta;
> +
> +	/*
> +	 * unthrottle_cfs_rq() needs a value to up-propagate above the
> +	 * freshly unthrottled cfs_rq.
> +	 */
> +	cfs_rq->unthrottled_h_nr_running = task_delta;
> +	cfs_rq->unthrottled_idle_h_nr_running = idle_task_delta;

I think this should have no effect, right?

> +
> +	/* Accumulate the delta in the parent's stash. Once all its children
> +	 * (i.e. all of this cfs_rq's siblings) have been visited, this value
> +	 * will be stable and used for its own count update.
> +	 */
> +	pcfs_rq->unthrottled_h_nr_running += task_delta;
> +	pcfs_rq->unthrottled_idle_h_nr_running += idle_task_delta;
> +
> +	/*
> +	 * If the cfs_rq became empty during throttling, then we dequeued
> +	 * it. It needs to be put back in the hierarchy if it or any of
> +	 * its children have now-unthrottled tasks.
> +	 */
> +	if (!se->on_rq && (cfs_rq->h_nr_running || cfs_rq->idle_h_nr_running)) {
> +		enqueue_entity(pcfs_rq, se, ENQUEUE_WAKEUP);
> +	} else {
> +		update_load_avg(pcfs_rq, se, UPDATE_TG);
> +		se_update_runnable(se);
>  	}

So I think this is trying to combine the all updates, and it's logically
just the same as if the loop was enqueue_task_fair, like you mentioned
in a followup for the throttle_one_task and dequeue_task_fair?

>  void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> @@ -5922,25 +6152,17 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  		goto unthrottle_throttle;
>  	}
>  
> -	task_delta = cfs_rq->h_nr_running;
> -	idle_task_delta = cfs_rq->idle_h_nr_running;
> -	for_each_sched_entity(se) {
> -		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
> -
> -		if (se->on_rq)
> -			break;
> -		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
> -
> -		if (cfs_rq_is_idle(group_cfs_rq(se)))
> -			idle_task_delta = cfs_rq->h_nr_running;
> +	if (cfs_rq->throttle_count)
> +		return;
>  
> -		qcfs_rq->h_nr_running += task_delta;
> -		qcfs_rq->idle_h_nr_running += idle_task_delta;
> +	/*
> +	 * cfs_rq's below us may not have been fully emptied out, so we can't rely
> +	 * directly on ->h_nr_running. Use the stash instead.
> +	 */
> +	task_delta = cfs_rq->unthrottled_h_nr_running;
> +	idle_task_delta = cfs_rq->unthrottled_idle_h_nr_running;
>  
> -		/* end evaluation on encountering a throttled cfs_rq */
> -		if (cfs_rq_throttled(qcfs_rq))
> -			goto unthrottle_throttle;
> -	}
> +	walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_clear_up, (void *)rq);
>  
>  	for_each_sched_entity(se) {
>  		struct cfs_rq *qcfs_rq = cfs_rq_of(se);

I think this would be simpler by making the first/original
walk_tg_tree_from be 

walk_tg_tree_from(cfs_rq->tg, tg_unthrottle_clear_down, tg_unthrottle_up, (void *)rq);

(With the clear function being the same, just renamed)

We never have any unthrottled* saved between calls to unthrottle_cfs_rq,
because if throttled_count is set for us, it's set for all of our
descendants too, so we're doing nothing but throttle_count stuff in that
case. Sadly that doesn't let us remove the cfs_rq fields, that would
need a walk_tg_tree_by_level.
