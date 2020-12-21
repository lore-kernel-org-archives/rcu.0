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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F529C433DB
	for <rcu@archiver.kernel.org>; Mon, 21 Dec 2020 18:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC877229C4
	for <rcu@archiver.kernel.org>; Mon, 21 Dec 2020 18:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgLUSqY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgLUSqY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Dec 2020 13:46:24 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A8CC061285;
        Mon, 21 Dec 2020 10:45:43 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id a12so26098956lfl.6;
        Mon, 21 Dec 2020 10:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g44Rcpcy0F+31L1GeLQ4Ymlkx0QQ72ycL09ehmxxEds=;
        b=kxE0f3YfIhethMMfrl1Ma+KPxVMQ+KLduY23sSiucnRNuVtQ3JuswyOVXDgyt0xBQI
         dJY6SnIaiYhy9nG3mS4Moj9o+Kpkb2QSQoFb7M7Lx9PB+ukDi1gjS2jqJvV936Y2Ze3E
         AasNBvGZ1U9/GxR/fvITo/JPzpdU1fPU4DfkQkqn7skbcL5x20SIZkOVWYwpPnKWjM/k
         vXxLJ0zU4vWvsH6JhwufwVLdvdC7KtUBVCHPPTTJm65u6IMSkDM+B9riUcXPd9YGXtQu
         0/8bxDWlNXkp488WSvuKEB1KEHX1tkhyVTlfFzaegPgyCvl0PwdlM76SvbSzNjKO0cIb
         GzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g44Rcpcy0F+31L1GeLQ4Ymlkx0QQ72ycL09ehmxxEds=;
        b=n3173Z7FI8JRSE+m3hvGdwgvVVCjCAu7X+RFl6sYGPoOh5hMgQx1LvuTnXPx7XsRh6
         hVigim7s2TmVQ8kyg0qUAEylIGe1iuKa56G6G6CspyiKTx6WSMKOyHAhaFxRxNgJtUJ/
         6FwnsGc248FNbIffpDTRjVqtFdOo3KNe/5BiGnjVVOCZjLTi9pADSTNxz763svudyW0p
         CyoEQSU4cOHmlX9barc091IRi8z2c/ItnoPnGmeFePj9cfbV8zIICcTZR8WU1NYtNFR/
         uNg0P8kiuHyLPHSpHsTl87RAM1g7VxSb1dvUQBCydo+yDRJh2HOswHYT7+iJC0fr5Ct/
         /hVA==
X-Gm-Message-State: AOAM530Ydd5HydEP26tvO86QbA8bvfmjDVtVNXhYFt18oubl2gy4KGmA
        sNdGW3PKPx7LWZ3jcAwdL4I=
X-Google-Smtp-Source: ABdhPJzQIVZYN4L1TRrXs2Oc/sLJHmgM2DKgLaQvoyvIVJIl+FPjHSQ/aE1YJsoJZhBOXKUUEJ5GFw==
X-Received: by 2002:a2e:b5d6:: with SMTP id g22mr7708566ljn.488.1608576342101;
        Mon, 21 Dec 2020 10:45:42 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id i11sm2359178ljb.19.2020.12.21.10.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:45:41 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 21 Dec 2020 19:45:39 +0100
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
Message-ID: <20201221184539.GA24895@pc638.lan>
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201209202732.5896-2-urezki@gmail.com>
 <20201216154959.GA2408@pc638.lan>
 <20201216232955.GO2657@paulmck-ThinkPad-P72>
 <20201221153809.GA24756@pc638.lan>
 <20201221171805.GW2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221171805.GW2657@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Dec 21, 2020 at 09:18:05AM -0800, Paul E. McKenney wrote:
> On Mon, Dec 21, 2020 at 04:38:09PM +0100, Uladzislau Rezki wrote:
> > On Wed, Dec 16, 2020 at 03:29:55PM -0800, Paul E. McKenney wrote:
> > > On Wed, Dec 16, 2020 at 04:49:59PM +0100, Uladzislau Rezki wrote:
> 
> [ . . . ]
> 
> > > > 2.20.1
> > > 
> > > Again, much improved!
> > > 
> > See below the v3 version. I hope i fixed all comments :)
> > 
> > >From 06f7adfd84cbb1994d0e2693ee9dcdfd272a9bd0 Mon Sep 17 00:00:00 2001
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > Date: Wed, 9 Dec 2020 21:27:32 +0100
> > Subject: [PATCH v3 1/1] rcu-tasks: Add RCU-tasks self tests
> > 
> > This commit adds self tests for early-boot use of RCU-tasks grace periods.
> > It tests all three variants (Rude, Tasks, and Tasks Trace) and covers
> > both synchronous (e.g., synchronize_rcu_tasks()) and asynchronous (e.g.,
> > call_rcu_tasks()) grace-period APIs.
> > 
> > Self-tests are run only in kernels built with CONFIG_PROVE_RCU=y.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Much better!
> 
> I pulled this in, but made one small additional change.  Please let me
> know if this is problematic.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 93372198b5c9efdfd288aa3b3ee41c1f90866886
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
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 3660755..35a2cd5 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1224,6 +1224,40 @@ void show_rcu_tasks_gp_kthreads(void)
>  }
>  #endif /* #ifndef CONFIG_TINY_RCU */
>  
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
That is fine! We can output the name instead of executed counter.
Doing so makes it completely clear who triggers the callback.

--
Vlad Rezki
