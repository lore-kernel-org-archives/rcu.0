Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF443F08E;
	Wed, 15 Jul 2026 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151030; cv=none; b=QK8GK/5RbTBj7fbzj1AP4wuoiftG7N8W/auzCnD5yO4vyVhLL2bnUESC3SQFiW48D+RKgbLC3ZonHinuUMcQODFwIk86fu6u8tbOOq2/RMHT4nURWYVOFk/awlZnIr0dCT4Ih/EGb/eOQm46R3X0arCxnB4wEVGWCkz8ixu32OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151030; c=relaxed/simple;
	bh=JmsQePyNPUw5u3JeKanQx/xd76iNxU84H1xc5HkytWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CG+8QjRs3p8zE8EpYxL8aDX+F0znowrSIdBGyPRz9ENpMah/lgpDLtEqmisGBUTXx4Lb401Ep/0yUVJsgfr4Tz6zCgxFDikJ/nQl5gMvqztC0Xvm1V0fr7EeyTr9Ea/fsUuHpjBZS7J0QwIktqkejbexxjKTTTReHwbSlcXusHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJSgAKFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJSgAKFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A281F00A3A;
	Wed, 15 Jul 2026 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784151029;
	bh=NVQyTcqDCab4O1MUPYmEG5GilllWcodgGYmZEhpDK0M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=nJSgAKFErIiS93DZu+Pt8lv4D+BFPZBTusSUuM71mioBdAvPjOTWK+A+7CKpniS3Q
	 PES6Nuk/CzmZlbQBJ8YYHYUz5QYouCccdhWqLmVqPdRxNhg+rUUSvqjHRjd3tYtMCv
	 LKKNC/M6gRKwBLayM9s76pF8jl4uqJ7q6o5EPr48rwAF65ZdU5eMKLFct/+fkyhAgg
	 riMAb2bKLke40KXc44lZWtz/SLTSnXB1UsBhrxfM3otutei3TOxVn9LqTEXSciPU5q
	 ogFRX+HHfMSAxsM316GFL6d2Q+KUUvWflsGUJS5PjQxvlUbI5jJ3cCuL/mytwYEiu4
	 CzQ+GA3dVO8Nw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 16171CE0AD3; Wed, 15 Jul 2026 14:30:29 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:30:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org
Subject: Re: [PATCH v4 7/8] rcu: clear defer_qs_pending in deferred-QS bail
 when nesting > 0
Message-ID: <977751ab-b5e8-423e-84b9-8a51c0f2401b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-8-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626004301.1632168-8-joelagnelf@nvidia.com>

On Thu, Jun 25, 2026 at 08:43:00PM -0400, Joel Fernandes wrote:
> Paul McKenney noted that a softirq (or irq_work) handler arming for a
> deferred QS can fire and find rcu_preempt_depth() > 0 -- the task is
> still inside its outer reader, so rcu_preempt_need_deferred_qs() bails
> without reporting the QS.  At that point the queued mechanism has been
> consumed but ->defer_qs_pending stays in DEFER_QS_PENDING.
> 
> In the meantime, the only remaining path back to a quiescent state on
> this CPU may be a local_irq_disable()/_enable() pair that does not
> call preempt_check_resched() (it is just `sti`/`cli`).  patch 6's
> unconditional set_need_resched_current() makes need_resched true, but
> without an irq_work being raised the next outer rcu_read_unlock_special()
> hits the P-gate at the arming code:
> 
>     if (rdp->defer_qs_pending != DEFER_QS_PENDING) {
>         rdp->defer_qs_pending = DEFER_QS_PENDING;
>         irq_work_queue_on(...);                 // <-- skipped
>     }
> 
> so no irq_work is queued for the hardirq-exit preempt_schedule_irq()
> path either.  The deferred QS now waits until the next timer tick (or
> similar preempt-safe boundary), needlessly extending expedited grace
> period latency.
> 
> Clear ->defer_qs_pending in the bail-out path of rcu_preempt_deferred_qs()
> when rcu_preempt_depth() > 0.  The recursion guard semantics introduced
> by commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ
> work").
> 
> The clear is also safe against fresh recursion at this exact program
> point: rcu_preempt_depth() > 0 guarantees we are still inside an outer
> reader, so any inner rcu_read_unlock() from tracing infrastructure
> brings nesting back to outer (>0), never to 0.  The slow path of
> rcu_read_unlock_special() is structurally unreachable under that
> condition, so no recursive raise_softirq_irqoff()/irq_work_queue_on()
> can be triggered by the clear. Essentially, the mechanism will work to
> prevent the following recursion which Xiongfeng had previously reported:
> 
> irq_exit() -> __irq_exit_rcu()
>   -> tick_irq_exit() -> tick_nohz_irq_exit() -> tick_nohz_stop_sched_tick()
>     -> trace_tick_stop()                    // BPF prog hooked here
>       -> rcu_read_unlock_special()
>         -> irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu)   // self-IPI re-enters irq_exit
> 
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

I am a bit concerned about this one.  We are clearing ->defer_qs_pending,
but there might still be something that will attempt to complete the
deferred quiescent state.

I am nevertheless tentatively pulling it in for further review and
testing.

							Thanx, Paul

> ---
>  kernel/rcu/tree_plugin.h | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index f58ae29acdef..6f5d31e3f1a3 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -692,9 +692,35 @@ static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>  notrace void rcu_preempt_deferred_qs(struct task_struct *t)
>  {
>  	unsigned long flags;
> +	struct rcu_data *rdp;
>  
> -	if (!rcu_preempt_need_deferred_qs(t))
> +	if (!rcu_preempt_need_deferred_qs(t)) {
> +		/*
> +		 * If we got here from a softirq/irq_work that fired while
> +		 * rcu_preempt_depth() > 0, the deferred-QS mechanism has been
> +		 * consumed without doing any work: rcu_preempt_need_deferred_qs()
> +		 * just returned false because the task is still in a reader, so
> +		 * the actual QS report has to wait for the next
> +		 * rcu_read_unlock().
> +		 *
> +		 * Clear ->defer_qs_pending here so the next outer
> +		 * rcu_read_unlock_special() can re-arm a fresh mechanism (in
> +		 * particular the irq_work path, which the local_irq_enable()
> +		 * recovery boundary cannot itself reschedule from).
> +		 *
> +		 * Recursion safety: rcu_preempt_depth() > 0 means we are inside
> +		 * an outer reader, so any inner rcu_read_unlock() reached via
> +		 * tracing (bpf programs attached to trace points) brings
> +		 * nesting to outer (> 0), never to 0, so no recursive
> +		 * raise_softirq_irqoff()/irq_work_queue_on() can be triggered
> +		 * by this clear.
> +		 */
> +		if (rcu_preempt_depth() > 0) {
> +			rdp = this_cpu_ptr(&rcu_data);
> +			rcu_defer_qs_clear(rdp);
> +		}
>  		return;
> +	}
>  	local_irq_save(flags);
>  	rcu_preempt_deferred_qs_irqrestore(t, flags);
>  }
> -- 
> 2.34.1
> 
