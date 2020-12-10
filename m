Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E50C433FE
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 03:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2C86206E5
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 03:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgLJD1E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 22:27:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729542AbgLJD0y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 22:26:54 -0500
Date:   Wed, 9 Dec 2020 19:26:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607570773;
        bh=GSag7vcBqRP+slnP9T4a82yz1+2EPhyx8X2XTIrjsyo=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eIKMTTyVy01m5WtEmcQmgMlDiLw1B/wkYZmBbKDgZcq+anhqUJEtmPib0vyDRfGnA
         DAqDcXNvCJy8zXJHIKJYpgTX1DjE2hlNkUk2Y/b7qehD0CapQ9eTxk5lYpXlSZ+kZz
         wdKyTXlAeBFvIrQpOBQIGGrvfuVQzWKHtrgAkJtMRxlM0MhoBZyigAfszXpaJemYj6
         6dskYadsaQRJAEQC2TUKdHv1i/82b3093p3GAMRMHHW18hrMwQT3nNtBFuHg3k8RXy
         3fGKRBWMAvEWhHv6xjbbtDzVeP3xOcwZLE59p84CeGXVOQjhjYcC9pP8vq23Gi9+B8
         gZAjaH7sGzfTQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/2] rcu-tasks: move RCU-tasks initialization out of
 core_initcall()
Message-ID: <20201210032613.GS2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201209202732.5896-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209202732.5896-1-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 09, 2020 at 09:27:31PM +0100, Uladzislau Rezki (Sony) wrote:
> Initialize the RCU-tasks earlier, before *_initcall() callbacks are
> invoked. Do it after the workqueue subsytem is up and running. That
> gives us a possibility to make use of synchronize_rcu_tasks*() wait
> API in early_initcall() callbacks.
> 
> Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thank you!  I have queued both with the usual editing, so please
check and let me know if I messed something up.

							Thanx, Paul

> ---
>  include/linux/rcupdate.h |  6 ++++++
>  init/main.c              |  1 +
>  kernel/rcu/tasks.h       | 26 ++++++++++++++++++++++----
>  3 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 3c3efa4d6ab5..340c7d5344a4 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -88,6 +88,12 @@ void rcu_sched_clock_irq(int user);
>  void rcu_report_dead(unsigned int cpu);
>  void rcutree_migrate_callbacks(int cpu);
>  
> +#ifdef CONFIG_TASKS_RCU_GENERIC
> +void rcu_init_tasks_generic(void);
> +#else
> +static inline void rcu_init_tasks_generic(void) { }
> +#endif
> +
>  #ifdef CONFIG_RCU_STALL_COMMON
>  void rcu_sysrq_start(void);
>  void rcu_sysrq_end(void);
> diff --git a/init/main.c b/init/main.c
> index 130376ec10ba..e253e87bdf58 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1502,6 +1502,7 @@ static noinline void __init kernel_init_freeable(void)
>  
>  	init_mm_internals();
>  
> +	rcu_init_tasks_generic();
>  	do_pre_smp_initcalls();
>  	lockup_detector_init();
>  
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 35bdcfd84d42..67a162949763 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -241,7 +241,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  	}
>  }
>  
> -/* Spawn RCU-tasks grace-period kthread, e.g., at core_initcall() time. */
> +/* Spawn RCU-tasks grace-period kthread. */
>  static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
>  {
>  	struct task_struct *t;
> @@ -564,7 +564,6 @@ static int __init rcu_spawn_tasks_kthread(void)
>  	rcu_spawn_tasks_kthread_generic(&rcu_tasks);
>  	return 0;
>  }
> -core_initcall(rcu_spawn_tasks_kthread);
>  
>  #if !defined(CONFIG_TINY_RCU)
>  void show_rcu_tasks_classic_gp_kthread(void)
> @@ -692,7 +691,6 @@ static int __init rcu_spawn_tasks_rude_kthread(void)
>  	rcu_spawn_tasks_kthread_generic(&rcu_tasks_rude);
>  	return 0;
>  }
> -core_initcall(rcu_spawn_tasks_rude_kthread);
>  
>  #if !defined(CONFIG_TINY_RCU)
>  void show_rcu_tasks_rude_gp_kthread(void)
> @@ -968,6 +966,12 @@ static void rcu_tasks_trace_pregp_step(void)
>  static void rcu_tasks_trace_pertask(struct task_struct *t,
>  				    struct list_head *hop)
>  {
> +	// During early boot when there is only one boot-CPU,
> +	// an idle_task is not set for other CPUs. In this case
> +	// just revert.
> +	if (unlikely(t == NULL))
> +		return;
> +
>  	WRITE_ONCE(t->trc_reader_special.b.need_qs, false);
>  	WRITE_ONCE(t->trc_reader_checked, false);
>  	t->trc_ipi_to_cpu = -1;
> @@ -1193,7 +1197,6 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
>  	rcu_spawn_tasks_kthread_generic(&rcu_tasks_trace);
>  	return 0;
>  }
> -core_initcall(rcu_spawn_tasks_trace_kthread);
>  
>  #if !defined(CONFIG_TINY_RCU)
>  void show_rcu_tasks_trace_gp_kthread(void)
> @@ -1222,6 +1225,21 @@ void show_rcu_tasks_gp_kthreads(void)
>  }
>  #endif /* #ifndef CONFIG_TINY_RCU */
>  
> +void __init rcu_init_tasks_generic(void)
> +{
> +#ifdef CONFIG_TASKS_RCU
> +	rcu_spawn_tasks_kthread();
> +#endif
> +
> +#ifdef CONFIG_TASKS_RUDE_RCU
> +	rcu_spawn_tasks_rude_kthread();
> +#endif
> +
> +#ifdef CONFIG_TASKS_TRACE_RCU
> +	rcu_spawn_tasks_trace_kthread();
> +#endif
> +}
> +
>  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
>  static inline void rcu_tasks_bootup_oddness(void) {}
>  void show_rcu_tasks_gp_kthreads(void) {}
> -- 
> 2.20.1
> 
