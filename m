Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703BEC4361B
	for <rcu@archiver.kernel.org>; Wed, 16 Dec 2020 23:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B5323718
	for <rcu@archiver.kernel.org>; Wed, 16 Dec 2020 23:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgLPXah (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Dec 2020 18:30:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgLPXag (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Dec 2020 18:30:36 -0500
Date:   Wed, 16 Dec 2020 15:29:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608161395;
        bh=dijIe56HIJQuNec3PZVCHVQQqCbV/T1Tw4BLIPhSFU8=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NgAKWbSpOZ/1iJte1TCdW7UDeucCJI/LyI4EPTCiMmUCy7yZvCy1U+mH3NoTmZTbk
         bB7oJ65S/hBhD1bBxdcmhsUhWpbrzDQVPeKSvtuol9YP3XjqNibHsy58W9gJvpy3cK
         FaMXoc+RY4I9VkbDuHuId+qSeGV85RvUqkL/ancqwbja0wpk5zuB+cH39WN9v57XcZ
         JYF1yLHwvcluXXuTBOrPBU0tDY1uPGuIk61TjONV043zftVved6CS78V5HqeEX1DdC
         Hw7+LrPpDQoXXovF6rw01/bJvnYtfKXqXQha+Ze4PgLd2UGslb76KKRjZtYWx2J5LB
         am85POIthAQgw==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
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
Subject: Re: [PATCH 2/2] rcu-tasks: add RCU-tasks self tests
Message-ID: <20201216232955.GO2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201209202732.5896-2-urezki@gmail.com>
 <20201216154959.GA2408@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216154959.GA2408@pc638.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 16, 2020 at 04:49:59PM +0100, Uladzislau Rezki wrote:
> > Add self tests for checking of RCU-tasks API functionality.
> > It covers:
> >     - wait API functions;
> >     - invoking/completion call_rcu_tasks*().
> > 
> > Self-tests are run when CONFIG_PROVE_RCU kernel parameter is set.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/tasks.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 67a162949763..9407772780c1 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1225,6 +1225,16 @@ void show_rcu_tasks_gp_kthreads(void)
> >  }
> >  #endif /* #ifndef CONFIG_TINY_RCU */
> >  
> > +static struct rcu_head rhp;
> > +static int rcu_execurted_test_counter;
> > +static int rcu_run_test_counter;
> > +
> > +static void test_rcu_tasks_callback(struct rcu_head *r)
> > +{
> > +	pr_info("RCU-tasks test callback executed %d\n",
> > +		++rcu_execurted_test_counter);
> > +}
> > +
> >  void __init rcu_init_tasks_generic(void)
> >  {
> >  #ifdef CONFIG_TASKS_RCU
> > @@ -1238,7 +1248,41 @@ void __init rcu_init_tasks_generic(void)
> >  #ifdef CONFIG_TASKS_TRACE_RCU
> >  	rcu_spawn_tasks_trace_kthread();
> >  #endif
> > +
> > +	if (IS_ENABLED(CONFIG_PROVE_RCU)) {
> > +		pr_info("Running RCU-tasks wait API self tests\n");
> > +#ifdef CONFIG_TASKS_RCU
> > +		rcu_run_test_counter++;
> > +		call_rcu_tasks(&rhp, test_rcu_tasks_callback);
> > +		synchronize_rcu_tasks();
> > +#endif
> > +
> > +#ifdef CONFIG_TASKS_RUDE_RCU
> > +		rcu_run_test_counter++;
> > +		call_rcu_tasks_trace(&rhp, test_rcu_tasks_callback);
> > +		synchronize_rcu_tasks_rude();
> > +#endif
> > +
> > +#ifdef CONFIG_TASKS_TRACE_RCU
> > +		rcu_run_test_counter++;
> > +		call_rcu_tasks_trace(&rhp, test_rcu_tasks_callback);
> > +		synchronize_rcu_tasks_trace();
> > +#endif
> > +	}
> > +}
> > +
> > +static int rcu_tasks_verify_self_tests(void)
> > +{
> > +	int ret = 0;
> > +
> > +	if (rcu_run_test_counter != rcu_execurted_test_counter) {
> > +		WARN_ON(1);
> > +		ret = -1;
> > +	}
> > +
> > +	return ret;
> >  }
> > +late_initcall(rcu_tasks_verify_self_tests);
> >  
> >  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> >  static inline void rcu_tasks_bootup_oddness(void) {}
> Please find a v2 of the patch that is in question. First version
> uses the same rhp for all RCU flavors what is wrong. Initially
> i had three different one per one flavor. But for some reason
> end up with only one.
> 
> 
> >From e7c6096af5a7916f29c0b4b05e1644b3b3a6c589 Mon Sep 17 00:00:00 2001
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Date: Wed, 9 Dec 2020 21:27:32 +0100
> Subject: [PATCH v2 1/1] rcu-tasks: Add RCU-tasks self tests
> 
> This commit adds self tests for early-boot use of RCU-tasks grace periods.
> It tests all three variants (Rude, Tasks, and Tasks Trace) and covers
> both synchronous (e.g., synchronize_rcu_tasks()) and asynchronous (e.g.,
> call_rcu_tasks()) grace-period APIs.
> 
> Self-tests are run only in kernels built with CONFIG_PROVE_RCU=y.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Much improved, thank you!  A few more comments below.

> ---
>  kernel/rcu/tasks.h | 69 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 36607551f966..7478d912734a 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1224,6 +1224,35 @@ void show_rcu_tasks_gp_kthreads(void)
>  }
>  #endif /* #ifndef CONFIG_TINY_RCU */
> 
> +struct test_desc {

Please use something like "struct rcu_tasks_test_desc" to help the poor
people who might need to grep for this.  Feel free to shorten it, but
please make it descriptive and thus more likely to stay unique.

> +       struct rcu_head rh;
> +       const char *name;
> +       bool run;

If you make this "bool notrun" you don't need to initialize.

> +};
> +
> +static struct test_desc tests[] = {
> +       { .name = "call_rcu_tasks()" },
> +       { .name = "call_rcu_rude()"  },
> +       { .name = "call_rcu_trace()" },
> +};
> +
> +static int rcu_executed_test_counter;
> +
> +static void test_rcu_tasks_callback(struct rcu_head *rhp)
> +{

	struct rcu_tasks_test_desc *rttdp;

> +       int i;
> +
> +       pr_info("RCU-tasks test callback executed %d\n",
> +               ++rcu_executed_test_counter);

	rttdp = container_of(rhp, rh, struct rcu_tasks_test_desc);
	rttdp->notrun = true;

Or I suppose:

	container_of(rhp, rh, struct rcu_tasks_test_desc)->notrun = true;

Then the loop below can go away.

> +
> +       for (i = 0; i < ARRAY_SIZE(tests); i++) {
> +               if (rhp == &tests[i].rh) {
> +                       tests[i].run = false;
> +                       break;
> +               }
> +       }
> +}
> +
>  void __init rcu_init_tasks_generic(void)
>  {
>  #ifdef CONFIG_TASKS_RCU
> @@ -1237,7 +1266,47 @@ void __init rcu_init_tasks_generic(void)
>  #ifdef CONFIG_TASKS_TRACE_RCU
>         rcu_spawn_tasks_trace_kthread();
>  #endif
> +
> +       // Run the self-tests.
> +       if (IS_ENABLED(CONFIG_PROVE_RCU)) {
> +               pr_info("Running RCU-tasks wait API self tests\n");
> +#ifdef CONFIG_TASKS_RCU
> +               tests[0].run = true;

The s/run/notrun/ allows the three initializations of .run to go away.

> +               call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
> +               synchronize_rcu_tasks();

Why not reverse the order of these two statements?  That would test
call_rcu_tasks*()'s ability to do a grace period on their own, without
help from the corresponding synchronize_rcu_tasks*().

> +#endif
> +
> +#ifdef CONFIG_TASKS_RUDE_RCU
> +               tests[1].run = true;
> +               call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
> +               synchronize_rcu_tasks_rude();
> +#endif
> +
> +#ifdef CONFIG_TASKS_TRACE_RCU
> +               tests[2].run = true;
> +               call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
> +               synchronize_rcu_tasks_trace();
> +#endif
> +       }
> +}
> +
> +static int rcu_tasks_verify_self_tests(void)
> +{
> +       int ret, i;

Why not initialize "ret" in the declaration?

> +
> +       for (i = 0, ret = 0; i < ARRAY_SIZE(tests); i++) {
> +               if (tests[i].run) {             // still hanging.
> +                       pr_err("%s has been failed.\n", tests[i].name);
> +                       ret = -1;
> +               }
> +       }
> +
> +       if (ret)
> +               WARN_ON(1);
> +
> +       return ret;
>  }
> +late_initcall(rcu_tasks_verify_self_tests);
> 
>  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
>  static inline void rcu_tasks_bootup_oddness(void) {}
> -- 
> 2.20.1

Again, much improved!

							Thanx, Paul
