Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B8429DB77;
	Sun,  6 Jul 2025 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751822765; cv=none; b=rmqsRMVY34JonCg9CK0VgS2SeY5ZHn9OgL8+q0RkAsfqGmLMgfpZuK0V8MsNEQdpp6BKPsvByhCj6/PlR2lPC/GBpzk/A0r+gAbb6ap1RsBbFHNA85j9xsImtV1+oxXeovkz0VHtS9d71CPBFiVIvf8oD6oATi40ULPV2Fy4IvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751822765; c=relaxed/simple;
	bh=9iVdiU83qRtrDB3LDwq6Fw8EJR1yn1hAuo8zDfcisqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+YJErWlf9z8N0QJzO3E6XzPZPIuRLqzclKotqN1pIs+6w49gQFPZynW9F1ErPrfQ8pSRJJfM3pBx829XdmGpUTX84z5TSiyXQMsJB2W35ZzbpJGrkc9ll3Ygn+bjOkVdy52rqOKu6km6BdsD88oBKuQZtFIVBxng9qibLNrrdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/KdFDrR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/KdFDrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41775C4CEED;
	Sun,  6 Jul 2025 17:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751822765;
	bh=9iVdiU83qRtrDB3LDwq6Fw8EJR1yn1hAuo8zDfcisqw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=U/KdFDrRT6a7deX0RRQ4kKbTYRT3c798PQp72plJesuxAjwDhFG4+XpQ8x7fgx/xU
	 pDIJcOyrhvjFO9sKBc54pkUJsWImyqR30ZjsWSvt4E8Jy/p+uLZS5s7wiYejCucdSr
	 eX3n+Q/iHxiwRiBaJW30uKKS27Uh38u9lEot4C3bc6PKCPuxODzdDraVAUzdJ+A6ZZ
	 apMBLpAfRk+LjnqhLd+nBpQULgDQUQSduLlCAP2jh5cXmE28TTmaKraZTAkzOWCXI8
	 uH5iuEVCpi3uM7zVqQ9JS2rFlNdYoCIKtvciY9fgKEdHYnvN6GsSiFfhwQLnUG1xe3
	 TU7nmKqBHiJWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DCD0BCE09E9; Sun,  6 Jul 2025 10:26:04 -0700 (PDT)
Date: Sun, 6 Jul 2025 10:26:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] rcu: Fix rcu_read_unlock() deadloop due to IRQ
 work
Message-ID: <89ac8409-fe62-486b-a10d-35494095b6a2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250705203918.4149863-1-joelagnelf@nvidia.com>
 <960035c6-c5f3-4c31-bd0f-f57d79b040f4@paulmck-laptop>
 <40f98744-2289-4695-aa6a-4019913920d3@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f98744-2289-4695-aa6a-4019913920d3@nvidia.com>

On Sun, Jul 06, 2025 at 01:13:31PM -0400, Joel Fernandes wrote:
> On 7/6/2025 1:08 PM, Paul E. McKenney wrote:
> > On Sat, Jul 05, 2025 at 04:39:15PM -0400, Joel Fernandes wrote:
> >> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > Definitely headed in the right direction, though it does need just a
> > little bit more detail in the commit log.  ;-)
> > 
> > Also a few comments and questions interspersed below.
> > 
> > 							Thanx, Paul
> > 
> >> ---
> >>  kernel/rcu/tree.h        | 11 ++++++++++-
> >>  kernel/rcu/tree_plugin.h | 29 ++++++++++++++++++++++-------
> >>  2 files changed, 32 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> >> index 3830c19cf2f6..f8f612269e6e 100644
> >> --- a/kernel/rcu/tree.h
> >> +++ b/kernel/rcu/tree.h
> >> @@ -174,6 +174,15 @@ struct rcu_snap_record {
> >>  	unsigned long   jiffies;	/* Track jiffies value */
> >>  };
> >>  
> >> +/*
> >> + * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's attention.
> >> + * It can be in one of the following states:
> >> + * - DEFER_QS_IDLE: An IRQ work was never scheduled.
> >> + * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.
> >> + */
> >> +#define DEFER_QS_IDLE		0
> >> +#define DEFER_QS_PENDING	1
> > 
> > Having names for the states is good!
> > 
> >> +
> >>  /* Per-CPU data for read-copy update. */
> >>  struct rcu_data {
> >>  	/* 1) quiescent-state and grace-period handling : */
> >> @@ -192,7 +201,7 @@ struct rcu_data {
> >>  					/*  during and after the last grace */
> >>  					/* period it is aware of. */
> >>  	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
> >> -	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
> >> +	int defer_qs_iw_pending;	/* Scheduler attention pending? */
> >>  	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
> >>  
> >>  	/* 2) batch handling */
> >> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> >> index dd1c156c1759..baf57745b42f 100644
> >> --- a/kernel/rcu/tree_plugin.h
> >> +++ b/kernel/rcu/tree_plugin.h
> >> @@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
> >>  	struct rcu_node *rnp;
> >>  	union rcu_special special;
> >>  
> >> +	rdp = this_cpu_ptr(&rcu_data);
> >> +	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
> >> +		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
> > 
> > Good, this is where the request actually gets serviced.
> > 
> >> +
> >>  	/*
> >>  	 * If RCU core is waiting for this CPU to exit its critical section,
> >>  	 * report the fact that it has exited.  Because irqs are disabled,
> >>  	 * t->rcu_read_unlock_special cannot change.
> >>  	 */
> >>  	special = t->rcu_read_unlock_special;
> >> -	rdp = this_cpu_ptr(&rcu_data);
> >>  	if (!special.s && !rdp->cpu_no_qs.b.exp) {
> >>  		local_irq_restore(flags);
> >>  		return;
> >> @@ -623,12 +626,24 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
> >>   */
> >>  static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
> >>  {
> >> -	unsigned long flags;
> >> -	struct rcu_data *rdp;
> >> +	volatile unsigned long flags;
> > 
> > I don't understand why this wants to be volatile.
> > 
> > Unless maybe you want to make sure that gdb can see it, in
> > which case, is there an existing Kconfig option for that?  Maybe
> > CONFIG_DEBUG_INFO_NONE=n?
> 
> This does not need to be volatile, sorry it was an older remnant (back when the
> handler was a NOOP in the v1, and I was afraid of compiler optimizations ;-)).
> But its no longer needed so I shall drop it (the volatile) :)

Whew!  ;-)

> >> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >>  
> >> -	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
> >>  	local_irq_save(flags);
> >> -	rdp->defer_qs_iw_pending = false;
> >> +
> >> +	/*
> >> +	 * Requeue the IRQ work on next unlock in following situation:
> >> +	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
> >> +	 * 2. CPU enters new rcu_read_lock()
> >> +	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
> >> +	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
> >> +	 * 5. Deferred QS reporting does not happen.
> >> +	 */
> >> +	if (rcu_preempt_depth() > 0) {
> >> +		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
> > 
> > Shouldn't we have just this WRITE_ONCE() in this then-clause?
> 
> No, because if we let the IRQ work handler do that before we can execute
> rcu_preempt_deferred_qs_handler(), then it will cause infinite recursion,
> because an RCU read-side critical section can again try to queue the IRQ work
> (before entering the scheduler). Also testing shows doing that will reproduce
> the hang we're fixing.
> 
> I think we should rename defer_qs_iw_pending to defer_qs_pending to better
> clarify that we are tracking the "Deferred QS" reporting than if the IRQ work
> actually ran?

Here is the patch:

+	if (rcu_preempt_depth() > 0) {
+		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
+		local_irq_restore(flags);
+		return;
+	}
 	local_irq_restore(flags);
 }

After the WRITE_ONCE, you restore interrupts and return.  Which is also
what would happen if there was only the WRITE_ONCE() in the then-clause,
correct?

Or am I missing something subtle here?

							Thanx, Paul
