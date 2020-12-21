Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15092C433E6
	for <rcu@archiver.kernel.org>; Mon, 21 Dec 2020 19:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D1F22CA1
	for <rcu@archiver.kernel.org>; Mon, 21 Dec 2020 19:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgLUTtd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUTtd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Dec 2020 14:49:33 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E453BC0613D6;
        Mon, 21 Dec 2020 11:48:52 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 23so26442535lfg.10;
        Mon, 21 Dec 2020 11:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VxKqYC0qX+AWYqwpjKMzO3aIuYfpEz9R//qvdpbDZj4=;
        b=OeQxlAfo2cvecPUv3lw/UrSqz6z73bkj5r4OaSQgdCSHj2v/OhFWd73qke0kcFVmjE
         InwN27TP3LejZKgzwATiBbRU0oKDa4vkTeujm5LdytAhDp8ldd8cLcnra5sTgfg0OL6b
         kge4M9W3ndh/vEXqSPNxYH0DCYs2VJTbkKMR3tKjwgX+BvnwZngt6icMwGfyhrz1j7do
         gz7BZTUUUUxzWu3B4WL4PHzsKgGSaIj94Gr6gW540YO4taJHRR4XXRSX5HdgMriqqU+4
         BmqNm3NiBVZoDY2mrA1mFxr59yr2crZc1plCc253Xxf4PUhQ1WGFLVQohksUAFjP6diE
         2p5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VxKqYC0qX+AWYqwpjKMzO3aIuYfpEz9R//qvdpbDZj4=;
        b=VhALeAfSrc0bOfpbhKavWJLlnYV/Z8p9xOLIQ1cM86BUcLUNVxb70UESDXIaXVUQjR
         pfg5y+1X9+twZrVsVGwiQEesEOmW/n6LjFACth6pUgKjJEVBwAUsO7kbI5+uMGiBIGVJ
         3WamEGgm7NDHcMpkdx8yNiYkAaOBF+ptKPqlDDVWE5Emh8oW9K27TRav9UtbvrP1rye7
         7zW2HfGj2MdTxdMj/Z3gDuBPLjhg1LpkAG5PUHa1nMSU/1Csg8QdJBNxNNWEqN0FXfX/
         kOqcHE5QZVgczodz3nsHIQ6jfVH14AW71eh2YSCjGy6bV/LwQX5wT9Sp5dPa9LugLT9V
         cSMw==
X-Gm-Message-State: AOAM5324o3+XfA+X9rnGbmNWof5BOhrKKi4zqUCfYCZwvXi4gMwUgiDp
        bEtnBxHNSSiuF4A7XMm80HP8nHFjYnzwBw==
X-Google-Smtp-Source: ABdhPJwhGx+6KvoTaJbN4iNDp8yqSE/f7etlBRYxW5jOnyj3Kthy+m5XYjIgTOlEfghbOz8Li4DTBQ==
X-Received: by 2002:a05:651c:114:: with SMTP id a20mr7698060ljb.392.1608580131385;
        Mon, 21 Dec 2020 11:48:51 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id 187sm2194024lfo.16.2020.12.21.11.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 11:48:50 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 21 Dec 2020 20:48:48 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
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
Message-ID: <20201221194848.GA2558@pc638.lan>
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201209202732.5896-2-urezki@gmail.com>
 <20201216154959.GA2408@pc638.lan>
 <20201216232955.GO2657@paulmck-ThinkPad-P72>
 <20201221153809.GA24756@pc638.lan>
 <20201221171805.GW2657@paulmck-ThinkPad-P72>
 <20201221184539.GA24895@pc638.lan>
 <20201221192906.GX2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221192906.GX2657@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Dec 21, 2020 at 11:29:06AM -0800, Paul E. McKenney wrote:
> On Mon, Dec 21, 2020 at 07:45:39PM +0100, Uladzislau Rezki wrote:
> > On Mon, Dec 21, 2020 at 09:18:05AM -0800, Paul E. McKenney wrote:
> > > On Mon, Dec 21, 2020 at 04:38:09PM +0100, Uladzislau Rezki wrote:
> > > > On Wed, Dec 16, 2020 at 03:29:55PM -0800, Paul E. McKenney wrote:
> > > > > On Wed, Dec 16, 2020 at 04:49:59PM +0100, Uladzislau Rezki wrote:
> > > 
> > > [ . . . ]
> > > 
> > > > > > 2.20.1
> > > > > 
> > > > > Again, much improved!
> > > > > 
> > > > See below the v3 version. I hope i fixed all comments :)
> > > > 
> > > > >From 06f7adfd84cbb1994d0e2693ee9dcdfd272a9bd0 Mon Sep 17 00:00:00 2001
> > > > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > > > Date: Wed, 9 Dec 2020 21:27:32 +0100
> > > > Subject: [PATCH v3 1/1] rcu-tasks: Add RCU-tasks self tests
> > > > 
> > > > This commit adds self tests for early-boot use of RCU-tasks grace periods.
> > > > It tests all three variants (Rude, Tasks, and Tasks Trace) and covers
> > > > both synchronous (e.g., synchronize_rcu_tasks()) and asynchronous (e.g.,
> > > > call_rcu_tasks()) grace-period APIs.
> > > > 
> > > > Self-tests are run only in kernels built with CONFIG_PROVE_RCU=y.
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > 
> > > Much better!
> > > 
> > > I pulled this in, but made one small additional change.  Please let me
> > > know if this is problematic.
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > commit 93372198b5c9efdfd288aa3b3ee41c1f90866886
> > > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Date:   Wed Dec 9 21:27:32 2020 +0100
> > > 
> > >     rcu-tasks: Add RCU-tasks self tests
> > >     
> > >     This commit adds self tests for early-boot use of RCU-tasks grace periods.
> > >     It tests all three variants (Rude, Tasks, and Tasks Trace) and covers
> > >     both synchronous (e.g., synchronize_rcu_tasks()) and asynchronous (e.g.,
> > >     call_rcu_tasks()) grace-period APIs.
> > >     
> > >     Self-tests are run only in kernels built with CONFIG_PROVE_RCU=y.
> > >     
> > >     Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > 
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index 3660755..35a2cd5 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -1224,6 +1224,40 @@ void show_rcu_tasks_gp_kthreads(void)
> > >  }
> > >  #endif /* #ifndef CONFIG_TINY_RCU */
> > >  
> > > +struct rcu_tasks_test_desc {
> > > +	struct rcu_head rh;
> > > +	const char *name;
> > > +	bool notrun;
> > > +};
> > > +
> > > +static struct rcu_tasks_test_desc tests[] = {
> > > +	{
> > > +		.name = "call_rcu_tasks()",
> > > +		/* If not defined, the test is skipped. */
> > > +		.notrun = !IS_ENABLED(CONFIG_TASKS_RCU),
> > > +	},
> > > +	{
> > > +		.name = "call_rcu_tasks_rude()",
> > > +		/* If not defined, the test is skipped. */
> > > +		.notrun = !IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
> > > +	},
> > > +	{
> > > +		.name = "call_rcu_tasks_trace()",
> > > +		/* If not defined, the test is skipped. */
> > > +		.notrun = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
> > > +	}
> > > +};
> > > +
> > > +static void test_rcu_tasks_callback(struct rcu_head *rhp)
> > > +{
> > > +	struct rcu_tasks_test_desc *rttd =
> > > +		container_of(rhp, struct rcu_tasks_test_desc, rh);
> > > +
> > > +	pr_info("Callback from %s invoked.\n", rttd->name);
> > That is fine! We can output the name instead of executed counter.
> > Doing so makes it completely clear who triggers the callback.
> 
> And we also need to make it not trigger when CONFIG_PROVE_RCU=n.
> While in the area, we might as well leave anything that is needed only
> by CONFIG_PROVE_RCU=y undefined when CONFIG_PROVE_RCU=n.
> 
> How about the following?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit f7a1ac0d3504e0518745da7f98573c1b13587f3e
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Wed Dec 9 21:27:32 2020 +0100
> 
>     rcu-tasks: Add RCU-tasks self tests
>     
>     This commit adds self tests for early-boot use of RCU-tasks grace periods.
>     It tests all three variants (Rude, Tasks, and Tasks Trace) and covers
>     both synchronous (e.g., synchronize_rcu_tasks()) and asynchronous (e.g.,
>     call_rcu_tasks()) grace-period APIs.
>     
>     Self-tests are run only in kernels built with CONFIG_PROVE_RCU=y.
>     
>     Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>     [ paulmck: Handle CONFIG_PROVE_RCU=n and identify test cases' callbacks. ]
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 3660755..af7c194 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1224,6 +1224,82 @@ void show_rcu_tasks_gp_kthreads(void)
>  }
>  #endif /* #ifndef CONFIG_TINY_RCU */
>  
> +#ifdef CONFIG_PROVE_RCU
> +struct rcu_tasks_test_desc {
> +	struct rcu_head rh;
> +	const char *name;
> +	bool notrun;
> +};
> +
> +static struct rcu_tasks_test_desc tests[] = {
> +	{
> +		.name = "call_rcu_tasks()",
> +		/* If not defined, the test is skipped. */
> +		.notrun = !IS_ENABLED(CONFIG_TASKS_RCU),
> +	},
> +	{
> +		.name = "call_rcu_tasks_rude()",
> +		/* If not defined, the test is skipped. */
> +		.notrun = !IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
> +	},
> +	{
> +		.name = "call_rcu_tasks_trace()",
> +		/* If not defined, the test is skipped. */
> +		.notrun = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
> +	}
> +};
> +
> +static void test_rcu_tasks_callback(struct rcu_head *rhp)
> +{
> +	struct rcu_tasks_test_desc *rttd =
> +		container_of(rhp, struct rcu_tasks_test_desc, rh);
> +
> +	pr_info("Callback from %s invoked.\n", rttd->name);
> +
> +	rttd->notrun = true;
> +}
> +
> +static void rcu_tasks_initiate_self_tests(void)
> +{
> +	pr_info("Running RCU-tasks wait API self tests\n");
> +#ifdef CONFIG_TASKS_RCU
> +	synchronize_rcu_tasks();
> +	call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
> +#endif
> +
> +#ifdef CONFIG_TASKS_RUDE_RCU
> +	synchronize_rcu_tasks_rude();
> +	call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
> +#endif
> +
> +#ifdef CONFIG_TASKS_TRACE_RCU
> +	synchronize_rcu_tasks_trace();
> +	call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
> +#endif
> +}
> +
> +static int rcu_tasks_verify_self_tests(void)
> +{
> +	int ret = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> +		if (!tests[i].notrun) {		// still hanging.
> +			pr_err("%s has been failed.\n", tests[i].name);
> +			ret = -1;
> +		}
> +	}
> +
> +	if (ret)
> +		WARN_ON(1);
> +
> +	return ret;
> +}
> +late_initcall(rcu_tasks_verify_self_tests);
> +#else /* #ifdef CONFIG_PROVE_RCU */
> +static void rcu_tasks_initiate_self_tests(void) { }
> +#endif /* #else #ifdef CONFIG_PROVE_RCU */
> +
>  void __init rcu_init_tasks_generic(void)
>  {
>  #ifdef CONFIG_TASKS_RCU
> @@ -1237,6 +1313,9 @@ void __init rcu_init_tasks_generic(void)
>  #ifdef CONFIG_TASKS_TRACE_RCU
>  	rcu_spawn_tasks_trace_kthread();
>  #endif
> +
> +	// Run the self-tests.
> +	rcu_tasks_initiate_self_tests();
>  }
>  
>  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
That makes sense to me. I missed that point. There is no
reason in wasting of extra cycles which affect a boot up
time if built without CONFIG_PROVE_RCU.

--
Vlad Rezki
