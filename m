Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C609C433F5
	for <rcu@archiver.kernel.org>; Wed,  2 Mar 2022 05:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbiCBFnH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Mar 2022 00:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiCBFnG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Mar 2022 00:43:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8699CA41AA
        for <rcu@vger.kernel.org>; Tue,  1 Mar 2022 21:42:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9706CE20DA
        for <rcu@vger.kernel.org>; Wed,  2 Mar 2022 05:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F924C004E1;
        Wed,  2 Mar 2022 05:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646199738;
        bh=cp817fzZmlpkC5gGn3u18aygFw4UOuDMAck4ieJnd78=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QoeKE39UI5N1NdtrEwSsCAsGxffPwrT1pEtcKGVwx+RtJCtgzvW9F2qH/AOU7nk+Z
         42aoNQdazWKmGu7XU8MtG2bJ11iiWsPdTV9QEBlGxqLvSAQjmw0FuNbI7c92Wnn6Tu
         MBD3QiLmtEPETxpdzWs2DRuRmn22HAjg6OMzIa/Q/kmGA5aRwLsi3bj0/N8CwoUX2j
         CT/ZVrK6DGzKb1dEqbJ+AfKLHBkbBfAiHx+fjQf2IDYoVSLGBxNoFDeOGfOhlAo/8z
         WTi/SzA2aXxvRL4XpS6rNZWkIbq+m0lYneW9M2FsF1CB3X3opeW1CG6edGrSMYv5ZH
         RQg7kiKjdvF2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CDDE25C01C9; Tue,  1 Mar 2022 21:42:17 -0800 (PST)
Date:   Tue, 1 Mar 2022 21:42:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu: Delay the RCU-selftests during boot.
Message-ID: <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yh5bJZmAXXGtgTIl@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 01, 2022 at 06:43:01PM +0100, Sebastian Andrzej Siewior wrote:
> The RCU-sefltest expects tthe timer_list timer to be working. This isn't
> the case on PREEMPT_RT at this point because it requires that ksoftirqd
> is up and running.
> There is no known requirement that synchronize_rcu() works at this
> point.
> 
> Delay RCU-selftests until ksoftirqd is up and running.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> Paul, I don't mean to be rude or anything by saying that "There is no
> requirement…". If my memory serves me well here (and there is no
> guarantee for that) then synchronize_rcu() was required that early by
> kprobes or jump labels and this requirement was lifted by the time we
> discussed this. I have no idea how this discussion back then ended but
> as of v5.17-rc6 that timer is still required to function in order for
> the system to make progress at boot time.

No offense taken.

There have been several different things requiring various pieces of RCU
to be running quite early, and I need to do a bit of code archaeology to
check this out.  One of these is what forced me to move to expedited grace
periods once the scheduler started.  And the expedited grace periods do
require the timers be working, at least in their current form.

I vaguely recall tracing requiring call_rcu() extremely early (as
in before rcu_init() is called), but that was not a problem because
there was no requirement that the callback be invoked before the first
couple of sets of initcalls had completed.  The only challenge in this
case was to avoid stomping on the callback lists at rcu_init() time,
no timers required.

One straightforward approach would be to choose the call site of the
rcu_tasks_initiate_self_tests() function based on whether or not the
kernel was built with CONFIG_PREEMPT_RT.

The other thought that comes to mind is that you may need the old-style
softirq until ksoftirqd is spawned.  I doubt that real-time response is
a big deal that early in boot.  ;-)

							Thanx, Paul

>  include/linux/rcupdate.h |  6 ++++++
>  init/main.c              |  1 +
>  kernel/rcu/tasks.h       | 10 +++-------
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 88b42eb464068..2fb1a48ca9272 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -95,6 +95,12 @@ void rcu_init_tasks_generic(void);
>  static inline void rcu_init_tasks_generic(void) { }
>  #endif
>  
> +#if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TASKS_RCU_GENERIC)
> +void rcu_tasks_initiate_self_tests(void);
> +#else
> +static inline void rcu_tasks_initiate_self_tests(void) {}
> +#endif
> +
>  #ifdef CONFIG_RCU_STALL_COMMON
>  void rcu_sysrq_start(void);
>  void rcu_sysrq_end(void);
> diff --git a/init/main.c b/init/main.c
> index 65fa2e41a9c09..cfc45e47b9ca4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1600,6 +1600,7 @@ static noinline void __init kernel_init_freeable(void)
>  
>  	rcu_init_tasks_generic();
>  	do_pre_smp_initcalls();
> +	rcu_tasks_initiate_self_tests();
>  	lockup_detector_init();
>  
>  	smp_init();
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index d64f0b1d8cd3b..215c2c0f6c184 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1659,9 +1659,10 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
>  	pr_info("Callback from %s invoked.\n", rttd->name);
>  
>  	rttd->notrun = true;
> +	WARN_ON(1);
>  }
>  
> -static void rcu_tasks_initiate_self_tests(void)
> +void rcu_tasks_initiate_self_tests(void)
>  {
>  	pr_info("Running RCU-tasks wait API self tests\n");
>  #ifdef CONFIG_TASKS_RCU
> @@ -1698,9 +1699,7 @@ static int rcu_tasks_verify_self_tests(void)
>  	return ret;
>  }
>  late_initcall(rcu_tasks_verify_self_tests);
> -#else /* #ifdef CONFIG_PROVE_RCU */
> -static void rcu_tasks_initiate_self_tests(void) { }
> -#endif /* #else #ifdef CONFIG_PROVE_RCU */
> +#endif /* #ifdef CONFIG_PROVE_RCU */
>  
>  void __init rcu_init_tasks_generic(void)
>  {
> @@ -1715,9 +1714,6 @@ void __init rcu_init_tasks_generic(void)
>  #ifdef CONFIG_TASKS_TRACE_RCU
>  	rcu_spawn_tasks_trace_kthread();
>  #endif
> -
> -	// Run the self-tests.
> -	rcu_tasks_initiate_self_tests();
>  }
>  
>  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> -- 
> 2.35.1
> 
