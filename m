Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E734BC0044D
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 19:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A842620738
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 19:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="a321yIZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbgCPTr6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:47:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34410 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732366AbgCPTr6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 15:47:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id 10so2231084qtp.1
        for <rcu@vger.kernel.org>; Mon, 16 Mar 2020 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9at46gZVGRmfo97kGLXCVY992jesaxTvYo4eKqTd6FA=;
        b=a321yIZ+clDsY41c9h0HbtzYN1tZnrw7f6NTr1cAV7wXPX2/dFXECqHypR5Kxw7WkW
         N1jw+h0X2auJTqkuVN3WORjxEBHwNeY2sAEMeo21DOns0wWsaX9dV8/ou9MYy2HFIsco
         mhvVMad10W+pjQEtavQSZ9Dv0otNihtbOUu/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9at46gZVGRmfo97kGLXCVY992jesaxTvYo4eKqTd6FA=;
        b=Fhtdb7tCQIziGjn0tjPFNBrwBrUejb3gZZxEv+T8nUr5ptSUsatBDG1WrTYu64WWZY
         et8O++JvifkLQpn5I1HkX/DYgufYmcrDXYjHhsi3jQ1cHO9YB3qwdCNoQ2IOH6Hnpw+M
         XMXjgO0VIKhCiORPhpJzUjQyNp7F/RPFuwbE8rmEtriiIa3+SSI5I/Xur1iLv3iF/k9B
         3sKruJZvuCzQYDhpHG2tKUwXxO5uCWpZ+sQ/TqYGN9f5kUeSuu23XTI/JGriu8RyY9Nn
         hzfc570nofkCR7t/tNqQeSGIjeBQJY2v1MfOQ+GY9SsPKyX/FVevViGYXDTZZfOqs4nw
         pl1A==
X-Gm-Message-State: ANhLgQ2Le/ODEawiNh0dUo3hlJnIAFS9h5oZSNyyLVK02y8iJixvBOES
        GMBh4rhRkuZIzvijLNDVGvgSQA==
X-Google-Smtp-Source: ADFU+vsmPPLATxBvZU3v2EvXbYV/FvEQlJE1xFA+xr0v7kSWjBpOblBoDbSj/C8pxzG9wL5RFUcVVw==
X-Received: by 2002:ac8:7511:: with SMTP id u17mr1751667qtq.316.1584388075704;
        Mon, 16 Mar 2020 12:47:55 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r4sm431401qkm.98.2020.03.16.12.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 12:47:55 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:47:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 09/16] rcu-tasks: Add an RCU-tasks rude
 variant
Message-ID: <20200316194754.GA172196@google.com>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
 <20200312181702.8443-9-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312181702.8443-9-paulmck@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 12, 2020 at 11:16:55AM -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit adds a "rude" variant of RCU-tasks that has as quiescent
> states schedule(), cond_resched_tasks_rcu_qs(), userspace execution,
> and (in theory, anyway) cond_resched().  Updates make use of IPIs and
> force an IPI and a context switch on each online CPU.  This variant
> is useful in some situations in tracing.

Would it be possible to better clarify that the "rude version" works only
from preempt-disabled regions? Is that also true for the "non-rude" version?

Also it would be good to clarify better in cover letter, how these new
flavors relate to the existing Tasks-RCU implementation.

In the existing one, a quiescent state is a task updating its context switch
counters such that it went to sleep at least once, implying there is no
chance it is on an about to be destroyed trampoline.

However, here we are trying to determine if a task state is no longer on an
RQ (which I gleaned from the first patch). Sounds very similar, would the
context switch counters not help in that determination as well? If it is Ok,
it would be good to describe in cover letter about what is exactly is a
quiescent state and what exactly is a reader section in the cover letter, for
both non-rude and rude version. Thanks!

thanks,

 - Joel



> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  include/linux/rcupdate.h |  3 ++
>  kernel/rcu/Kconfig       | 12 +++++-
>  kernel/rcu/tasks.h       | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 5523145..2be97a8 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -37,6 +37,7 @@
>  /* Exported common interfaces */
>  void call_rcu(struct rcu_head *head, rcu_callback_t func);
>  void rcu_barrier_tasks(void);
> +void rcu_barrier_tasks_rude(void);
>  void synchronize_rcu(void);
>  
>  #ifdef CONFIG_PREEMPT_RCU
> @@ -138,6 +139,8 @@ static inline void rcu_init_nohz(void) { }
>  #define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t)
>  void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
>  void synchronize_rcu_tasks(void);
> +void call_rcu_tasks_rude(struct rcu_head *head, rcu_callback_t func);
> +void synchronize_rcu_tasks_rude(void);
>  void exit_tasks_rcu_start(void);
>  void exit_tasks_rcu_finish(void);
>  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 38475d0..0d43ec1 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -71,7 +71,7 @@ config TREE_SRCU
>  	  This option selects the full-fledged version of SRCU.
>  
>  config TASKS_RCU_GENERIC
> -	def_bool TASKS_RCU
> +	def_bool TASKS_RCU || TASKS_RUDE_RCU
>  	select SRCU
>  	help
>  	  This option enables generic infrastructure code supporting
> @@ -84,6 +84,16 @@ config TASKS_RCU
>  	  only voluntary context switch (not preemption!), idle, and
>  	  user-mode execution as quiescent states.  Not for manual selection.
>  
> +config TASKS_RUDE_RCU
> +	def_bool 0
> +	default n
> +	help
> +	  This option enables a task-based RCU implementation that uses
> +	  only context switch (including preemption) and user-mode
> +	  execution as quiescent states.  It forces IPIs and context
> +	  switches on all online CPUs, including idle ones, so use
> +	  with caution.  Not for manual selection.
> +
>  config RCU_STALL_COMMON
>  	def_bool TREE_RCU
>  	help
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index d77921e..1d25c50 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -180,6 +180,9 @@ static void __init rcu_tasks_bootup_oddness(void)
>  	else
>  		pr_info("\tTasks RCU enabled.\n");
>  #endif /* #ifdef CONFIG_TASKS_RCU */
> +#ifdef CONFIG_TASKS_RUDE_RCU
> +	pr_info("\tRude variant of Tasks RCU enabled.\n");
> +#endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
>  }
>  
>  #endif /* #ifndef CONFIG_TINY_RCU */
> @@ -410,3 +413,99 @@ static int __init rcu_spawn_tasks_kthread(void)
>  core_initcall(rcu_spawn_tasks_kthread);
>  
>  #endif /* #ifdef CONFIG_TASKS_RCU */
> +
> +#ifdef CONFIG_TASKS_RUDE_RCU
> +
> +////////////////////////////////////////////////////////////////////////
> +//
> +// "Rude" variant of Tasks RCU, inspired by Steve Rostedt's trick of
> +// passing an empty function to schedule_on_each_cpu().  This approach
> +// provides an asynchronous call_rcu_rude() API and batching of concurrent
> +// calls to the synchronous synchronize_rcu_rude() API.  This sends IPIs
> +// far and wide and induces otherwise unnecessary context switches on all
> +// online CPUs, whether online or not.
> +
> +// Empty function to allow workqueues to force a context switch.
> +static void rcu_tasks_be_rude(struct work_struct *work)
> +{
> +}
> +
> +// Wait for one rude RCU-tasks grace period.
> +static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> +{
> +	schedule_on_each_cpu(rcu_tasks_be_rude);
> +}
> +EXPORT_SYMBOL_GPL(rcu_tasks_rude_wait_gp);
> +
> +void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
> +DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude);
> +
> +/**
> + * call_rcu_tasks_rude() - Queue a callback rude task-based grace period
> + * @rhp: structure to be used for queueing the RCU updates.
> + * @func: actual callback function to be invoked after the grace period
> + *
> + * The callback function will be invoked some time after a full grace
> + * period elapses, in other words after all currently executing RCU
> + * read-side critical sections have completed. call_rcu_tasks_rude()
> + * assumes that the read-side critical sections end at context switch,
> + * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
> + * there are no read-side primitives analogous to rcu_read_lock() and
> + * rcu_read_unlock() because this primitive is intended to determine
> + * that all tasks have passed through a safe state, not so much for
> + * data-strcuture synchronization.
> + *
> + * See the description of call_rcu() for more detailed information on
> + * memory ordering guarantees.
> + */
> +void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func)
> +{
> +	call_rcu_tasks_generic(rhp, func, &rcu_tasks_rude);
> +}
> +EXPORT_SYMBOL_GPL(call_rcu_tasks_rude);
> +
> +/**
> + * synchronize_rcu_tasks_rude - wait for a rude rcu-tasks grace period
> + *
> + * Control will return to the caller some time after a rude rcu-tasks
> + * grace period has elapsed, in other words after all currently
> + * executing rcu-tasks read-side critical sections have elapsed.  These
> + * read-side critical sections are delimited by calls to schedule(),
> + * cond_resched_tasks_rcu_qs(), userspace execution, and (in theory,
> + * anyway) cond_resched().
> + *
> + * This is a very specialized primitive, intended only for a few uses in
> + * tracing and other situations requiring manipulation of function preambles
> + * and profiling hooks.  The synchronize_rcu_tasks_rude() function is not
> + * (yet) intended for heavy use from multiple CPUs.
> + *
> + * See the description of synchronize_rcu() for more detailed information
> + * on memory ordering guarantees.
> + */
> +void synchronize_rcu_tasks_rude(void)
> +{
> +	synchronize_rcu_tasks_generic(&rcu_tasks_rude);
> +}
> +EXPORT_SYMBOL_GPL(synchronize_rcu_tasks_rude);
> +
> +/**
> + * rcu_barrier_tasks_rude - Wait for in-flight call_rcu_tasks_rude() callbacks.
> + *
> + * Although the current implementation is guaranteed to wait, it is not
> + * obligated to, for example, if there are no pending callbacks.
> + */
> +void rcu_barrier_tasks_rude(void)
> +{
> +	/* There is only one callback queue, so this is easy.  ;-) */
> +	synchronize_rcu_tasks_rude();
> +}
> +EXPORT_SYMBOL_GPL(rcu_barrier_tasks_rude);
> +
> +static int __init rcu_spawn_tasks_rude_kthread(void)
> +{
> +	rcu_spawn_tasks_kthread_generic(&rcu_tasks_rude);
> +	return 0;
> +}
> +core_initcall(rcu_spawn_tasks_rude_kthread);
> +
> +#endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
> -- 
> 2.9.5
> 
