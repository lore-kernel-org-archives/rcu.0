Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B65C433EF
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 00:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0376121E
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 00:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhIOAeA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 Sep 2021 20:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhIOAeA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 14 Sep 2021 20:34:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFE1C061574;
        Tue, 14 Sep 2021 17:32:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id f65so995592pfb.10;
        Tue, 14 Sep 2021 17:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B98iyobon7XpmlutJ6lSaSzrCVaOurbEs607Eq+jSgA=;
        b=C15+5pC2tmh9jliJOROUrQwWJP0/jrz2+X0YaWyjm+ftvbfKvC++n/OWEP0EPwfTki
         7TEGLxLu7FpkqQktxaAgoLlpKW6SbjKpWdoO6pEA+7tqozikqnToldw+i8DmAtfGqYh8
         RucgGbxxwws9Fd8nJP0pm3YfUV5AcA5wU7U7E+QtdAjq4uI1jtjYfOhcNPcxj0PZKi9u
         Rmy1KYL2pr/5v2tU3PIrqmZrF6vmuGfLCSrmEza84cdprOQfbHQdqzKNh1eBgsJH+fSi
         vaS3VA1UORF9+Zhll57vM/ckSUXTyp2OMLfGm32VYpvUOP3tr9GzDdu3ijKJWpLlqZ3Z
         a0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B98iyobon7XpmlutJ6lSaSzrCVaOurbEs607Eq+jSgA=;
        b=eqdvxKfnU39ASffUMVrIh5hhNyM7C8b7lcBwDim5mO23vvqPYH6Jw/RHYtGrlYNSTK
         WSPSfQXZNTWHCSLCQ44DSYHeO4VXs0nCwmSyCDEQVg+23bLyKjY3GwMTYjkCh6nUH0hU
         +b8JSY7dtHkG/lNDIToaGNEv6T8lyp6I1Zu+b6VF9a2tI8efJ2k+HhjXz3Ax38O63W8m
         p8bzVjfv7iEVSu91idFxecX1P+LanVLkMytmTsmmBEuKmzRmQ6IVfYOiRqWjvHPqinLI
         h9lOCjhzXhalSZgdnI987vy00jvl4HLsqr0PnZSvBYDJ6F+1JDM6E4SwgZh3ev5fJZds
         0yMw==
X-Gm-Message-State: AOAM5334Ph+mlD1ACJI0bE4bfIHM8sHOpT3D/T/LE48DZ7hc2rugMFxw
        aq3dBJhMMz+ur1fUlsgQP8EIdo7kIgvgeQ==
X-Google-Smtp-Source: ABdhPJyl7tj/4AHRBTENNJQN3RJeKAm8En43Pkt+moEgzUoj9cGejFp/O6mrw1ZZAtDmPhRWKPgFNA==
X-Received: by 2002:a05:6a00:140e:b029:38b:c129:9f2f with SMTP id l14-20020a056a00140eb029038bc1299f2fmr7505401pfu.75.1631665961804;
        Tue, 14 Sep 2021 17:32:41 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id j16sm11869541pfi.165.2021.09.14.17.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 17:32:41 -0700 (PDT)
Date:   Wed, 15 Sep 2021 08:32:32 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] kernel: in_irq() cleanup
Message-ID: <20210915003232.nvarqpjnvyutc46o@mail.google.com>
References: <20210813145101.85782-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813145101.85782-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi, could anyone pick up this cleanup?

On Fri, Aug 13, 2021 at 10:51:01PM +0800, Changbin Du wrote:
> Replace the obsolete and ambiguos macro in_irq() with new
> macro in_hardirq().
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  include/linux/lockdep.h              |  2 +-
>  include/linux/rcutiny.h              |  2 +-
>  kernel/irq/irqdesc.c                 |  2 +-
>  kernel/rcu/tree.c                    |  2 +-
>  kernel/rcu/tree_plugin.h             |  2 +-
>  kernel/softirq.c                     | 10 +++++-----
>  kernel/time/timer.c                  |  4 ++--
>  kernel/trace/trace.h                 |  2 +-
>  kernel/trace/trace_functions_graph.c |  2 +-
>  lib/locking-selftest.c               |  4 ++--
>  lib/vsprintf.c                       |  2 +-
>  11 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 5cf387813754..e7aa0050bfd8 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -633,7 +633,7 @@ do {									\
>  #define lockdep_assert_in_softirq()					\
>  do {									\
>  	WARN_ON_ONCE(__lockdep_enabled			&&		\
> -		     (!in_softirq() || in_irq() || in_nmi()));		\
> +		     (!in_softirq() || in_hardirq() || in_nmi()));		\
>  } while (0)
>  
>  #else
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 953e70fafe38..7fedbd33d5d2 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -88,7 +88,7 @@ static inline void rcu_irq_enter_irqson(void) { }
>  static inline void rcu_irq_exit(void) { }
>  static inline void rcu_irq_exit_check_preempt(void) { }
>  #define rcu_is_idle_cpu(cpu) \
> -	(is_idle_task(current) && !in_nmi() && !in_irq() && !in_serving_softirq())
> +	(is_idle_task(current) && !in_nmi() && !in_hardirq() && !in_serving_softirq())
>  static inline void exit_rcu(void) { }
>  static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>  {
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index fadb93766020..0ffd6c19259f 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -640,7 +640,7 @@ int handle_irq_desc(struct irq_desc *desc)
>  		return -EINVAL;
>  
>  	data = irq_desc_get_irq_data(desc);
> -	if (WARN_ON_ONCE(!in_irq() && handle_enforce_irqctx(data)))
> +	if (WARN_ON_ONCE(!in_hardirq() && handle_enforce_irqctx(data)))
>  		return -EPERM;
>  
>  	generic_handle_irq_desc(desc);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 51f24ecd94b2..18f6658f0713 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1510,7 +1510,7 @@ static void rcu_gp_kthread_wake(void)
>  {
>  	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
>  
> -	if ((current == t && !in_irq() && !in_serving_softirq()) ||
> +	if ((current == t && !in_hardirq() && !in_serving_softirq()) ||
>  	    !READ_ONCE(rcu_state.gp_flags) || !t)
>  		return;
>  	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index de1dc3bb7f70..953171af6d0c 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -672,7 +672,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
>  			    t->rcu_blocked_node);
>  		// Need to defer quiescent state until everything is enabled.
> -		if (use_softirq && (in_irq() || (expboost && !irqs_were_disabled))) {
> +		if (use_softirq && (in_hardirq() || (expboost && !irqs_were_disabled))) {
>  			// Using softirq, safe to awaken, and either the
>  			// wakeup is free or there is either an expedited
>  			// GP in flight or a potential need to deboost.
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index f3a012179f47..e8c62c4b1e5d 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -222,7 +222,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>  	u32 pending;
>  	int curcnt;
>  
> -	WARN_ON_ONCE(in_irq());
> +	WARN_ON_ONCE(in_hardirq());
>  	lockdep_assert_irqs_enabled();
>  
>  	local_irq_save(flags);
> @@ -305,7 +305,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
>  {
>  	unsigned long flags;
>  
> -	WARN_ON_ONCE(in_irq());
> +	WARN_ON_ONCE(in_hardirq());
>  
>  	raw_local_irq_save(flags);
>  	/*
> @@ -352,14 +352,14 @@ static void __local_bh_enable(unsigned int cnt)
>   */
>  void _local_bh_enable(void)
>  {
> -	WARN_ON_ONCE(in_irq());
> +	WARN_ON_ONCE(in_hardirq());
>  	__local_bh_enable(SOFTIRQ_DISABLE_OFFSET);
>  }
>  EXPORT_SYMBOL(_local_bh_enable);
>  
>  void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>  {
> -	WARN_ON_ONCE(in_irq());
> +	WARN_ON_ONCE(in_hardirq());
>  	lockdep_assert_irqs_enabled();
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  	local_irq_disable();
> @@ -617,7 +617,7 @@ static inline void tick_irq_exit(void)
>  
>  	/* Make sure that timer wheel updates are propagated */
>  	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
> -		if (!in_irq())
> +		if (!in_hardirq())
>  			tick_nohz_irq_exit();
>  	}
>  #endif
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index e3d2c23c413d..dfdbb114a43d 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1369,7 +1369,7 @@ int del_timer_sync(struct timer_list *timer)
>  	 * don't use it in hardirq context, because it
>  	 * could lead to deadlock.
>  	 */
> -	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
> +	WARN_ON(in_hardirq() && !(timer->flags & TIMER_IRQSAFE));
>  
>  	/*
>  	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
> @@ -1784,7 +1784,7 @@ void update_process_times(int user_tick)
>  	run_local_timers();
>  	rcu_sched_clock_irq(user_tick);
>  #ifdef CONFIG_IRQ_WORK
> -	if (in_irq())
> +	if (in_hardirq())
>  		irq_work_tick();
>  #endif
>  	scheduler_tick();
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index a180abf76d4e..2ed5b77b60ca 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -876,7 +876,7 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
>  		 * is set, and called by an interrupt handler, we still
>  		 * want to trace it.
>  		 */
> -		if (in_irq())
> +		if (in_hardirq())
>  			trace_recursion_set(TRACE_IRQ_BIT);
>  		else
>  			trace_recursion_clear(TRACE_IRQ_BIT);
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 0de6837722da..b08d3923de98 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -120,7 +120,7 @@ static inline int ftrace_graph_ignore_irqs(void)
>  	if (!ftrace_graph_skip_irqs || trace_recursion_test(TRACE_IRQ_BIT))
>  		return 0;
>  
> -	return in_irq();
> +	return in_hardirq();
>  }
>  
>  int trace_graph_entry(struct ftrace_graph_ent *trace)
> diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
> index 161108e5d2fe..a4edff9ffc33 100644
> --- a/lib/locking-selftest.c
> +++ b/lib/locking-selftest.c
> @@ -196,7 +196,7 @@ static void init_shared_classes(void)
>  	local_irq_disable();			\
>  	__irq_enter();				\
>  	lockdep_hardirq_threaded();		\
> -	WARN_ON(!in_irq());
> +	WARN_ON(!in_hardirq());
>  
>  #define HARDIRQ_EXIT()				\
>  	__irq_exit();				\
> @@ -2456,7 +2456,7 @@ static void hardirq_exit(int *_)
>  	int notthreaded_hardirq_guard_##name __guard(hardirq_exit);	\
>  	local_irq_disable();						\
>  	__irq_enter();							\
> -	WARN_ON(!in_irq());
> +	WARN_ON(!in_hardirq());
>  
>  static void softirq_exit(int *_)
>  {
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 26c83943748a..2c5b4351330c 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -865,7 +865,7 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
>  		 * kptr_restrict==1 cannot be used in IRQ context
>  		 * because its test for CAP_SYSLOG would be meaningless.
>  		 */
> -		if (in_irq() || in_serving_softirq() || in_nmi()) {
> +		if (in_hardirq() || in_serving_softirq() || in_nmi()) {
>  			if (spec.field_width == -1)
>  				spec.field_width = 2 * sizeof(ptr);
>  			return error_string(buf, end, "pK-error", spec);
> -- 
> 2.30.2
> 

-- 
Cheers,
Changbin Du
