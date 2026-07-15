Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174AE2E6116;
	Wed, 15 Jul 2026 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151306; cv=none; b=cdIiowe5BNQkVaa2bj5PyE1zk2Ntgqw89m6esy/RM4O+BBjwA2gwcPBbR5rDP9/ezlCEV9nzUYoyoVReKap9x+zvfBaa3xCbxaVJrQEIBztcq0eQTKGvp6zKh2Q1zjjtcLBwu1TNy4EciueFEjFTfa3tCc3TDVTZLc5ooSxAbA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151306; c=relaxed/simple;
	bh=gGaenV6Ua7VW/puFV+3vf8eIHgijH3BS2UjhuwtHH9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FN/5Nl7FfW/lipZnqhaKAHOJQcYELARenoqwcuBvZSX+utZWy7KmeyeY98UVyYtlpCSOqbIBWnsI7tuPzFScY/wUHZv9Sz4P5A/oBEb0Dy00amNze64pz6lxDIiBUjtT18BKb7ABeqI7YgAMGczM5IssBJGt11A2oxDNdp8yW6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxVqChVh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxVqChVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4C81F000E9;
	Wed, 15 Jul 2026 21:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784151304;
	bh=Ll0hdRc4FCOG4Ss7Ha6tNktkg6flAbUVd7Uu5pHMz3U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=jxVqChVhfU+ixm1MfSuDaxXfkm3VblA97mUqWpJlqOI72Lk6XaAChKB4i/3lHFhva
	 vrKBdZgq7H2X3I6LhUDLdIMInLtQjkReYHRCkSVc7QAOHoBsRxajNNCosoYzmuZjzO
	 LCwnjGZPOuqE4NrVjPzdv9Om0LN7GkASMSl/GgrPDd3FBs3BnhOl24QjMeXPjuM4ir
	 6uowVUNHq3uDZ9afmjcNS7l4AOninBuZl3/13HcBf9SSNvMejXBrnFE3bgd48O/G7X
	 FEGAJyfRjOY42Tn6BIZtdiUj5tCP8jr4eu6HNm9bLz6uBOyyosIPZI9DocL5QwIFuh
	 E8KUx3r3vtdbA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 66799CE0AD3; Wed, 15 Jul 2026 14:35:04 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:35:04 -0700
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
Subject: Re: [PATCH v4 8/8] rcu: add per-CPU rescue hrtimer for deferred-QS
 reporting
Message-ID: <57ec870f-e08d-415b-824f-ddefef94417c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-9-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626004301.1632168-9-joelagnelf@nvidia.com>

On Thu, Jun 25, 2026 at 08:43:01PM -0400, Joel Fernandes wrote:
> The compound branch of rcu_read_unlock_special() arms one of the
> scheduler, RCU_SOFTIRQ (raise_softirq_irqoff()) or irq_work_queue_on()
> in order to report a deferred quiescent state at a later time.
> 
> However, that is not enough in scenarios where an interrupts-disabled
> section spans the preempt_enable() of a preempt-disabled section:
> 
>  rcu_read_lock();
>  // receive IPI for expedited GP
>  preempt_disable();
>  rcu_read_unlock();    // sets the need-resched flag
>  local_irq_disable();
>  preempt_enable();     // cannot reschedule: IRQs are off
>  local_irq_enable();
>  // now outside the compound RCU read-side critical section, but the
>  // expedited GP is still held up
> 
> Introduce a per-CPU bounded-delay rescue hrtimer, armed from the compound
> branch when an expedited GP needs this CPU's quiescent state, that reports
> the deferred QS via rcu_preempt_deferred_qs_try_report() once a clean
> (non-reader, non-compound) context is reached.
> 
> To keep the rescue from firing once one of the normal mechanisms has
> already reported the quiescent state, cancel it from
> rcu_preempt_deferred_qs_irqrestore() -- the common path through which the
> deferred QS is reported.  Without this the timer keeps firing (and
> re-arming) only to find the work already done; cancelling on the natural
> report path avoids the great majority of those fires (observed as a ~90%
> reduction in rescue-timer fires under rcutorture TREE03 with
> rcutorture.gp_exp=1).

Can this replace some of the complexity in the deferred-quiescent-state
code paths, for example, the irq-work handler?  (Yes, we will need an
irq-work handler for immediate deboosting, but that is a separate issue.)

Please see below for another question.

> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree.c        |  1 +
>  kernel/rcu/tree.h        |  1 +
>  kernel/rcu/tree_plugin.h | 70 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c4352d0c3876..0cacbe642235 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -27,6 +27,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
>  #include <linux/nmi.h>
> +#include <linux/hrtimer.h>
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
>  #include <linux/export.h>
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index dc03231b2d46..58b120bf0b7b 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -218,6 +218,7 @@ struct rcu_data {
>  					/*  during and after the last grace */
>  					/* period it is aware of. */
>  	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
> +	struct hrtimer defer_qs_iw_rescue;/* Rescue timer for deferred-QS. */
>  	int defer_qs_pending;		/* irqwork or softirq pending? */
>  	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
>  
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 6f5d31e3f1a3..324d08c7a91a 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -592,6 +592,18 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  		local_irq_restore(flags);
>  		return;
>  	}
> +
> +	/*
> +	 * A natural report path reached the deferred quiescent state before
> +	 * the bounded-delay rescue hrtimer fired.  Cancel any pending rescue
> +	 * on this CPU so it does not fire only to find the quiescent state
> +	 * already reported.  Use hrtimer_try_to_cancel() rather than
> +	 * hrtimer_cancel(): interrupts are disabled here and the timer is
> +	 * HARD/PINNED, so a callback that is already running must not be
> +	 * waited on (in that case this is a harmless no-op).
> +	 */
> +	hrtimer_try_to_cancel(&rdp->defer_qs_iw_rescue);
> +
>  	t->rcu_read_unlock_special.s = 0;
>  	if (special.b.need_qs) {
>  		if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)) {
> @@ -772,6 +784,54 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>  		rcu_defer_qs_clear(rdp);
>  }
>  
> +/*
> + * Bounded-delay rescue timeout for the deferred-QS reporting.
> + *
> + * The compound branch of rcu_read_unlock_special() arms either the
> + * scheduler, RCU_SOFTIRQ (raise_softirq_irqoff) or irq_work_queue_on() in order
> + * to report a deferred QS at a later time.
> + *
> + * However, that is not enough as in scenarios where local_irq_disable()d
> + * sections span the preempt_enable() call of a preempt-disabled section:
> + *
> + *  rcu_read_lock();
> + *  // receive IPI for exp GP
> + *  preempt_disable();
> + *  rcu_read_unlock();    // Set the "need reschedule" flag.
> + *  local_irq_disable();
> + *  preempt_enable();     // Cannot reschedule as IRQs are off.
> + *  local_irq_enable();
> + *  // Now outside the compound RCU read-side critical section
> + *  // however, the expedited GP is still held up.
> + *
> + * Introduce a rescue timer, firing every 50 micro seconds after the last
> + * rcu_read_unlock() call, to fix this.
> + */
> +static int defer_qs_rescue_delay_us = 50;
> +module_param(defer_qs_rescue_delay_us, int, 0644);
> +MODULE_PARM_DESC(defer_qs_rescue_delay_us,
> +		 "Microseconds before the rescue timer fires a deferred-QS report.");
> +
> +static enum hrtimer_restart
> +rcu_preempt_deferred_qs_rescue(struct hrtimer *hrtp)
> +{
> +	lockdep_assert_irqs_disabled();
> +
> +	/*
> +	 * Still inside a reader / compound section: deboosting is unsafe, so
> +	 * rearm and retry after a bounded delay.  Once clean,
> +	 * rcu_preempt_deferred_qs_try_report() reports the deferred QS and
> +	 * releases any boost in the current task's context (or is a no-op if
> +	 * natural recovery already landed).
> +	 */
> +	if (!rcu_preempt_deferred_qs_try_report(current)) {
> +		hrtimer_forward_now(hrtp,
> +				    us_to_ktime(defer_qs_rescue_delay_us));

One way we get here is if we are in an rcu_read_lock()-style RCU read-side
critical section.  But in that case, we have an rcu_read_unlock() in
our future, so do we really need to arm the timer now?

And before I forget again, thank you very much for digging into this!!!

This is not a simple situation.  ;-)

							Thanx, Paul

> +		return HRTIMER_RESTART;
> +	}
> +	return HRTIMER_NORESTART;
> +}
> +
>  /*
>   * Check if expedited grace period processing during unlock is needed.
>   *
> @@ -892,6 +952,13 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>  			}
>  		}
> +		// Bounded-delay rescue: arm whenever the compound branch
> +		// entered with a pending deferred-QS / deboost obligation,
> +		// regardless of which mechanism above was chosen.
> +		if (needs_exp && cpu_online(rdp->cpu))
> +			hrtimer_start(&rdp->defer_qs_iw_rescue,
> +				      us_to_ktime(defer_qs_rescue_delay_us),
> +				      HRTIMER_MODE_REL_PINNED_HARD);
>  		local_irq_restore(flags);
>  		return;
>  	}
> @@ -1033,6 +1100,9 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
>  static void rcu_preempt_deferred_qs_init(struct rcu_data *rdp)
>  {
>  	rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
> +	hrtimer_setup(&rdp->defer_qs_iw_rescue,
> +		      rcu_preempt_deferred_qs_rescue,
> +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
>  }
>  #else /* #ifdef CONFIG_PREEMPT_RCU */
>  
> -- 
> 2.34.1
> 
