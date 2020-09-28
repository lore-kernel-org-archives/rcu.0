Return-Path: <SRS0=f31y=DF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E668C4727C
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C125A2076A
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="g3UHy52p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgI1XSm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgI1XSm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Sep 2020 19:18:42 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF55C0613B6
        for <rcu@vger.kernel.org>; Mon, 28 Sep 2020 15:43:19 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cr8so1346787qvb.10
        for <rcu@vger.kernel.org>; Mon, 28 Sep 2020 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vfXGidpgXKx1s2YVf1uVRaonvKWXG3GBSc8n1cT0/+E=;
        b=g3UHy52pfWCRXZ94EoiK+BN3YdRKfghlKl9buhE/uYYes0XiaJkYcYwca7ex3ziPiq
         LSo6hlBiZUY4mT5g9mxR4be3BDdLNN6CAOuazaRrsZ2luoGxY78HbGUrDxELTylxHDJZ
         MU41EE2YAht/nN9QAapmLl/BP1eLG7YBm8BIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vfXGidpgXKx1s2YVf1uVRaonvKWXG3GBSc8n1cT0/+E=;
        b=QfM7Bu2jAsDbZM7G5FMGjeEk25KneFSHR3or1S25EF1YpjngdZbX6wRhguNk9EEfvo
         rgVlrsGwFs6lLeT2rcd3RG93MFHGqfn+cyqQ3Hzaj5WqurWK7eZUtHxktZu3Z5cy1o5Q
         Sjqz7i+K/UibKp7NRwvOS0heHhnwzTksgrgkGLLV9FwWNOzZyw2N7uy8pKTRkMm7FB4X
         jAb1FW7A9ewDC1K/vkIzZiDtV1PDt6Zh8RuUZ146GCEpRkMGLT0hox96XR2dUW+m5ClO
         uqwpUGPJOd78gScXHHSwULMxkPAzpTDP68HkKGt0kycW1Ssj/4WNZFL9eBraAJ9lt/sw
         gdzw==
X-Gm-Message-State: AOAM533qZnTE3BSnOE9g5vJot2E+VJvqiZqF0wMNMFXVvT054mRNbD6l
        hKiFRD41z+JmXjqO80j+2x+vQg==
X-Google-Smtp-Source: ABdhPJw6AEf89l09FXlWzGbZKPYmGscpMVfLWn8XSCjEvM4H18rUrYeFkJkbD0Ll3fqP5ptctcVetg==
X-Received: by 2002:a05:6214:1852:: with SMTP id d18mr1922123qvy.32.1601332999028;
        Mon, 28 Sep 2020 15:43:19 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l11sm2490024qkk.35.2020.09.28.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 15:43:18 -0700 (PDT)
Date:   Mon, 28 Sep 2020 18:43:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Correctly handle single cpu check in
 rcu_blocking_is_gp
Message-ID: <20200928224318.GC2641213@google.com>
References: <1600717557-19880-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600717557-19880-1-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 22, 2020 at 01:15:57AM +0530, Neeraj Upadhyay wrote:
> Currently, for non-preempt kernels (with CONFIG_PREEMPTION=n),
> rcu_blocking_is_gp() checks (with preemption disabled), whether
> there is only one cpu online. It uses num_online_cpus() to
> decide whether only one cpu is online. If there is only single
> cpu online, synchronize_rcu() is optimized to return without
> doing all the work to wait for grace period. However, there are
> few issues with the num_online_cpus() check used:
> 
> 1. num_online_cpus() does a atomic_read(&__num_online_cpus). As
>    hotplug locks are not held, this does not ensure that
>    new incoming cpus update of the count is visible. This can
>    result in read side section on new incoming cpu, observe
>    updates which should not be visible beyond the grace period
>    corresponding to synchronize_rcu().
> 
>    For e.g. below litmus test, where P0 process corresponds to
>    synchronize_rcu() and P1 corresponds to new online cpu,  has
>    positive witnesses; confirming the possibility of read side
>    section to extend before and after the grace period, thereby
>    breaking guarantees provided by synchronize_rcu().
> 
>    {
>      int x = 0;
>      atomic_t numonline = ATOMIC_INIT(1);
>    }
> 
>    P0(int *x, atomic_t *numonline)
>    {
>      int r0;
>      WRITE_ONCE(*x, 1);
>      r0 = atomic_read(numonline);
>      if (r0 == 1) {
>        smp_mb();
>      } else {
>        synchronize_rcu();
>      }
>      WRITE_ONCE(*x, 2);
>    }
> 
>    P1(int *x, atomic_t *numonline)
>    {
>      int r0; int r1;
> 
>      atomic_inc(numonline);
>      smp_mb();
>      rcu_read_lock();
>      r0 = READ_ONCE(*x);
>      smp_rmb();
>      r1 = READ_ONCE(*x);
>      rcu_read_unlock();
>    }
> 
>    locations [x;numonline;]
> 
>    exists (1:r0=0 /\ 1:r1=2)

<self rambling>
Right so basically:
    P1(int *x, atomic_t *numonline)
    {
      int r0; int r1;
 
      atomic_inc(numonline);
      smp_mb();
      rcu_read_lock();
      r0 = READ_ONCE(*x);

Happened before:
    P0(int *x, atomic_t *numonline)
    {
      int r0;
      WRITE_ONCE(*x, 1);
      r0 = atomic_read(numonline);
      if (r0 == 1) {
	smp_mb();
	...
      }

However, P0 did not see P1's update of numonline because the atomic_read()
does not provide any ordering.
</self rambling>

Btw, its cool how Paul/you removed the need for memory-barriers for the
single-CPU case at all, by making the update to num_online_cpus in rcu_state,
from the CPU doing the onlining and offlining.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
(For the version in -rcu :)).

thanks,

 - Joel


> 2. Second problem is, the same early exit, from synchronize_rcu()
>    does not provide full ordering, memory barrier, w.r.t. memory
>    accesses after synchronize_rcu() call.
> 
> 3. Third, more important issue is related to outgoing cpu. Checking
>    only for __num_online_cpus with preemotion disabled isn't sufficient
>    for RCU, as, on completion of CPUHP_TEARDOWN_CPU stop machine (which
>    clears outgoing cpu from __num_online_cpus, the CPU switches to idle
>    task. So, checking only for __num_online_cpus does not consider
>    RCU read side sections in scheduler code (before switching to idle
>    task) and any potential read side sections in idle task, before final
>    RCU-quiesce entry into cpuhp_report_idle_dead() -> rcu_report_dead().
> 
> To handle these issues, add a new rcu_state member n_online_cpus, to
> keep account of the current number of online cpus. The atomic updates
> to this counter from rcu_report_dead() and rcu_cpu_starting() and
> the added read/write memory ordering semantics ensure that
> synchronize_rcu() fast path waits for all read side sections, where
> incoming/outgoing cpus are considered online, for RCU i.e. after
> rcu_cpu_starting() and before rcu_report_dead().
>
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
> 
> Below is the reproducer for issue described in point 3; this snippet
> is based on klitmus generated test, which is modified to sample reads
> from idle thread:
> 
> static void code0(int* x) {
> WRITE_ONCE(*x, 1);
>   idle_ctr = 0;
>   smp_mb();
>   mdelay(10);
>   WRITE_ONCE(*x, 1);
>   idle_ctr = 1;
>   synchronize_rcu();
>   WRITE_ONCE(*x, 2);
>   idle_ctr = 2;
> 
> }
> 
> static int thread0(void *_p) {
>   int _j, _i;
>   ctx_t *_a = (ctx_t *)_p;
> 
>   smp_mb();
>   for (_j = 0 ; _j < stride ; _j++) {
>     for (_i = _j ; _i < size ; _i += stride) {
>       while (idle_wait1) {
>           cpu_relax();
>           cond_resched();
>         }
>       code0(&_a->x[_i]);
>       smp_mb();
>       get_online_cpus();
>       idle_wait1 = true;
>       put_online_cpus();
>     }
>   }
>   atomic_inc(&done);
>   smp_mb();
>   wake_up(wq);
>   smp_mb();
>   do_exit(0);
> }
> 
> 
> static void code1(int* x,int* out_1_r1,int* out_1_r0) {
> 
>   int r0; int r1;
> 
>   r0 = READ_ONCE(idle_ctr_snap1);
>   r1 = READ_ONCE(idle_ctr_snap2);
> 
>   *out_1_r1 = (int)r1;
>   *out_1_r0 = (int)r0;
> }
> 
> static int thread1(void *_p) {
>   ctx_t *_a = (ctx_t *)_p;
>   int _j, _i;
> 
>   smp_mb();
>   for (_j = 0 ; _j < stride ; _j++) {
>     for (_i = _j ; _i < size ; _i += stride) {
>       while (idle_wait2) {
>           cpu_relax();
>           cond_resched();
>       }
>       get_online_cpus();
>       code1(&_a->x[_i],&_a->out_1_r1[_i],&_a->out_1_r0[_i]);
>       smp_mb();
>       idle_wait2 = true;
>       put_online_cpus();
>     }
>   }
>   atomic_inc(&done);
>   smp_mb();
>   wake_up(wq);
>   smp_mb();
>   do_exit(0);
> }
> 
> Idle thread snippet:
> 
> if (cpu_is_offline(cpu)) {
>         smp_mb();
>         idle_wait1 = false;
>         mdelay(8);
>         smp_mb();
>         rcu_read_lock();
>         idle_ctr_snap1 = idle_ctr;
>         mdelay(40);
>         smp_rmb();
>         idle_ctr_snap2 = idle_ctr;
>         rcu_read_unlock();
>         smp_mb();
>         idle_wait2 = false;
>         tick_nohz_idle_stop_tick();
>         cpuhp_report_idle_dead();
>         arch_cpu_idle_dead();
> 
>  kernel/rcu/tree.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/rcu/tree.h |  1 +
>  2 files changed, 66 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 2424e2a..33493f0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3609,9 +3609,59 @@ static int rcu_blocking_is_gp(void)
>  	if (IS_ENABLED(CONFIG_PREEMPTION))
>  		return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
>  	might_sleep();  /* Check for RCU read-side critical section. */
> +	/*
> +	 * a = p
> +	 * a = NULL
> +	 * synchronize_rcu()
> +	 *   rcu_blocking_is_gp()
> +	 *     num_online_cpus()
> +	 *       atomic_read(&__num_online_cpus)
> +	 * kfree(p);
> +	 *
> +	 *      - VS -
> +	 *
> +	 *              __cpu_up()
> +	 *                set_cpu_online(cpu)
> +	 *                  atomic_inc(&__num_online_cpus)
> +	 *              rcu_read_lock()
> +	 *              rcu_dereference(a) (a == p)
> +	 *              rcu_read_unlock()
> +	 *
> +	 * rcu_blocking_is_gp() must observe atomic_inc(&__num_online_cpus),
> +	 * in order to ensure that, RCU read side critical section on new
> +	 * online cpu, either start after synchronize_rcu()'s GP starts or
> +	 * it completes before synchronize_rcu() returns.
> +	 *
> +	 * However, atomic_read(&__num_online_cpus) does not ensure that.
> +	 *
> +	 * Essentially, below condition exist:
> +	 *
> +	 * {
> +	 *   int x = 0;
> +	 *   atomic_t numonline = ATOMIC_INIT(1);
> +	 * }
> +	 *
> +	 * P0(int *x, atomic_t *numonline)     P1(int *x, atomic_t *numonline)
> +	 * {                                   {
> +	 *   int r0;                             int r0; int r1;
> +	 *   WRITE_ONCE(*x, 1);                  atomic_inc(numonline);
> +	 *   r0 = atomic_read(numonline);        rcu_read_lock();
> +	 *   if (r0 == 2) {                      r0 = READ_ONCE(*x);
> +	 *     synchronize_rcu();                smp_rmb();
> +	 *   }                                   r1 = READ_ONCE(*x);
> +	 *   WRITE_ONCE(*x, 2);                  rcu_read_unlock();
> +	 * }                                   }
> +	 *
> +	 * exists (1:r0=0 /\ 1:r1=2)
> +	 *
> +	 * atomic_add_return(0, &rcu_state.n_online_cpus) and corresponding
> +	 * atomic_inc(&rcu_state.n_online_cpus) in rcu_cpu_starting() corrects
> +	 * this ordering issue.
> +	 */
>  	preempt_disable();
>  	ret = num_online_cpus() <= 1;
>  	preempt_enable();
> +	ret = ret && (atomic_add_return(0, &rcu_state.n_online_cpus) <= 1);
>  	return ret;
>  }
>  
> @@ -3655,6 +3705,11 @@ void synchronize_rcu(void)
>  			 lock_is_held(&rcu_sched_lock_map),
>  			 "Illegal synchronize_rcu() in RCU read-side critical section");
>  	if (rcu_blocking_is_gp())
> +		/*
> +		 * atomic_add_return() in rcu_blocking_is_gp () provides
> +		 * full memory barrier ordering with any rcu section after
> +		 * synchronize_rcu() call.
> +		 */
>  		return;
>  	if (rcu_gp_is_expedited())
>  		synchronize_rcu_expedited();
> @@ -4086,6 +4141,10 @@ void rcu_cpu_starting(unsigned int cpu)
>  	mask = rdp->grpmask;
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
> +	/* Order with access of n_online_cpus in rcu_blocking_is_gp */
> +	atomic_inc(&rcu_state.n_online_cpus);
> +	/* Order with rcu-side usages after this */
> +	smp_mb__after_atomic();
>  	newcpu = !(rnp->expmaskinitnext & mask);
>  	rnp->expmaskinitnext |= mask;
>  	/* Allow lockless access for expedited grace periods. */
> @@ -4138,6 +4197,12 @@ void rcu_report_dead(unsigned int cpu)
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  	}
>  	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
> +	/*
> +	 * Order with access of n_online_cpus in rcu_blocking_is_gp().
> +	 * Release semantics ensures that RCU read sections before it
> +	 * are observed by rcu_blocking_is_gp().
> +	 */
> +	atomic_dec_return_release(&rcu_state.n_online_cpus);
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	raw_spin_unlock(&rcu_state.ofl_lock);
>  
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index e4f66b8..4d9a9c0 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -298,6 +298,7 @@ struct rcu_state {
>  						/* Hierarchy levels (+1 to */
>  						/*  shut bogus gcc warning) */
>  	int ncpus;				/* # CPUs seen so far. */
> +	atomic_t n_online_cpus;			/* # CPUs online for RCU. */
