Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B565917A31B;
	Mon,  7 Jul 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751897077; cv=none; b=hVJNTem/zaASlBMcgWYpx01Ps2m7bNPcKCW/UEKR/Vi8wfmP93Bm936OdhmaXyytI4Hz7vhHyEofpVc6lvYd0256c7vmes1cLFlOKq4I5qtCWWYRv9vkX7I7Oxb9gUU4gIIKxahZzyfRXgZd+07n4CFby6Fl2O6d6ldbBRFsPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751897077; c=relaxed/simple;
	bh=MQa548Ztf1FYwvxFWzkJD9yBZmqEZu0sVVT4QWPk8Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfPOSwWB4q8J0dtmQUg8wULgNJswslBBtG5odmRn77R2O+3SzBFw2fi/5GEyQp9KlLUKCduoNeMbTi8kjPiR+MZL1k5U9k6tiuMgRxS4c2q7yjQZoj9evGQyAl9WxrmgkUcIldsqbi/DCnM69wojoxzuDsoLu2ggLd6EgAzHdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHKs1zqy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHKs1zqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2298DC4CEE3;
	Mon,  7 Jul 2025 14:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751897075;
	bh=MQa548Ztf1FYwvxFWzkJD9yBZmqEZu0sVVT4QWPk8Yg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LHKs1zqyGKYg4HM+k7Q9UV1vjZZ5LH2qzvbq818/Z48XgQhX6v+5zsPSRb/HV+Kn4
	 t3PSQNfEiVFUN5ZVGrOvW822fM+Zbux0rxidRMG3ikANSBWCyid+t9FwltDsIW8LKY
	 DE3OiaL5aKjo1IifiyPxRvXVAkAp/SS1unBuCi4PlVI/TWEDa9FD1A3kViw/AA5QaW
	 lUznqLjmJN5fx7SXggZh2U1EwIZc+neJvyQpULlTIfRZcmNgF9l7XYFTZaPvtncUkk
	 la01o81WmFEnDGG39DSOKM3FuX9s/n7MLaYz/5g3oce1ggJM0kJLLu+AS7BGt5Z4rS
	 ArwCfhAMcFkqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B2739CE0889; Mon,  7 Jul 2025 07:04:34 -0700 (PDT)
Date: Mon, 7 Jul 2025 07:04:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: qiang.zhang@linux.dev
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] rcu: Fix rcu_read_unlock() deadloop due to IRQ
 work
Message-ID: <fcca6aa2-e4db-455c-be32-e80050c44c8d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250705203918.4149863-1-joelagnelf@nvidia.com>
 <527a257218a02fe85571746d339a4c24f5564d68@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527a257218a02fe85571746d339a4c24f5564d68@linux.dev>

On Mon, Jul 07, 2025 at 01:26:56PM +0000, qiang.zhang@linux.dev wrote:
> > 
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > ---
> > 
> >  kernel/rcu/tree.h | 11 ++++++++++-
> > 
> >  kernel/rcu/tree_plugin.h | 29 ++++++++++++++++++++++-------
> > 
> >  2 files changed, 32 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > 
> > index 3830c19cf2f6..f8f612269e6e 100644
> > 
> > --- a/kernel/rcu/tree.h
> > 
> > +++ b/kernel/rcu/tree.h
> > 
> > @@ -174,6 +174,15 @@ struct rcu_snap_record {
> > 
> >  unsigned long jiffies; /* Track jiffies value */
> > 
> >  };
> > 
> >  
> > 
> > +/*
> > 
> > + * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's attention.
> > 
> > + * It can be in one of the following states:
> > 
> > + * - DEFER_QS_IDLE: An IRQ work was never scheduled.
> > 
> > + * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.
> > 
> > + */
> > 
> > +#define DEFER_QS_IDLE 0
> > 
> > +#define DEFER_QS_PENDING 1
> > 
> > +
> > 
> >  /* Per-CPU data for read-copy update. */
> > 
> >  struct rcu_data {
> > 
> >  /* 1) quiescent-state and grace-period handling : */
> > 
> > @@ -192,7 +201,7 @@ struct rcu_data {
> > 
> >  /* during and after the last grace */
> > 
> >  /* period it is aware of. */
> > 
> >  struct irq_work defer_qs_iw; /* Obtain later scheduler attention. */
> > 
> > - bool defer_qs_iw_pending; /* Scheduler attention pending? */
> > 
> > + int defer_qs_iw_pending; /* Scheduler attention pending? */
> > 
> >  struct work_struct strict_work; /* Schedule readers for strict GPs. */
> > 
> >  
> > 
> >  /* 2) batch handling */
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > 
> > index dd1c156c1759..baf57745b42f 100644
> > 
> > --- a/kernel/rcu/tree_plugin.h
> > 
> > +++ b/kernel/rcu/tree_plugin.h
> > 
> > @@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
> > 
> >  struct rcu_node *rnp;
> > 
> >  union rcu_special special;
> > 
> >  
> > 
> > + rdp = this_cpu_ptr(&rcu_data);
> > 
> > + if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
> > 
> > + rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
> > 
> > +
> > 
> >  /*
> > 
> >  * If RCU core is waiting for this CPU to exit its critical section,
> > 
> >  * report the fact that it has exited. Because irqs are disabled,
> > 
> >  * t->rcu_read_unlock_special cannot change.
> > 
> >  */
> > 
> >  special = t->rcu_read_unlock_special;
> > 
> > - rdp = this_cpu_ptr(&rcu_data);
> > 
> >  if (!special.s && !rdp->cpu_no_qs.b.exp) {
> > 
> >  local_irq_restore(flags);
> > 
> >  return;
> > 
> > @@ -623,12 +626,24 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
> > 
> >  */
> > 
> >  static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
> > 
> >  {
> > 
> > - unsigned long flags;
> > 
> > - struct rcu_data *rdp;
> > 
> > + volatile unsigned long flags;
> > 
> > + struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > 
> >  
> > 
> > - rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
> > 
> >  local_irq_save(flags);
> > 
> > - rdp->defer_qs_iw_pending = false;
> > 
> > +
> > 
> > + /*
> > 
> > + * Requeue the IRQ work on next unlock in following situation:
> > 
> > + * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
> > 
> > + * 2. CPU enters new rcu_read_lock()
> > 
> > + * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
> > 
> > + * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
> > 
> > + * 5. Deferred QS reporting does not happen.
> > 
> > + */
> > 
> > + if (rcu_preempt_depth() > 0) {
> 
> 
> For Preempt-RT kernels, the rcu_preempt_deferred_qs_handler() be invoked
> in per-cpu irq_work kthreads, the return value of rcu_preempt_depth()
> may always be 0, should we use IRQ_WORK_INIT_HARD() to initialize defer_qs_iw?

It sure does look like we need "||" rather than "&&" here in
rcu_read_unlock_special():

	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
	    IS_ENABLED(CONFIG_PREEMPT_RT))
		rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(
					rcu_preempt_deferred_qs_handler);
	else
		init_irq_work(&rdp->defer_qs_iw,
			      rcu_preempt_deferred_qs_handler);

But it is early in the morning, so I might be missing something.

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> 
> > 
> > + WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
> > 
> > + local_irq_restore(flags);
> > 
> > + return;
> > 
> > + }
> > 
> >  local_irq_restore(flags);
> > 
> >  }
> > 
> >  
> > 
> > @@ -675,7 +690,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
> > 
> >  set_tsk_need_resched(current);
> > 
> >  set_preempt_need_resched();
> > 
> >  if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> > 
> > - expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
> > 
> > + expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING && cpu_online(rdp->cpu)) {
> > 
> >  // Get scheduler to re-evaluate and call hooks.
> > 
> >  // If !IRQ_WORK, FQS scan will eventually IPI.
> > 
> >  if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> > 
> > @@ -685,7 +700,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
> > 
> >  else
> > 
> >  init_irq_work(&rdp->defer_qs_iw,
> > 
> >  rcu_preempt_deferred_qs_handler);
> > 
> > - rdp->defer_qs_iw_pending = true;
> > 
> > + rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
> > 
> >  irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> > 
> >  }
> > 
> >  }
> > 
> > -- 
> > 
> > 2.43.0
> >
