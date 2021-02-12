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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAE6C433DB
	for <rcu@archiver.kernel.org>; Fri, 12 Feb 2021 21:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D086C64DA1
	for <rcu@archiver.kernel.org>; Fri, 12 Feb 2021 21:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhBLVMy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Feb 2021 16:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhBLVMw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Feb 2021 16:12:52 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EBBC061574;
        Fri, 12 Feb 2021 13:12:12 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id q14so691141ljp.4;
        Fri, 12 Feb 2021 13:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SS2KGzlfjLWSOo4Rl+0SlDA0DNdaHfog9YBOFxDk0j0=;
        b=ux6zsDF3Nb15pW7IuLzOiLjSa0tKh6CoCstGIBj+fZZc+eyQe1XahpLewgPHlQ2bOv
         tW31+KKmhrtu99jQP3/sYZp3H3pLBOOgKi9vde/Ae8UwM1/suD0vFjraUKLj+1Bu4BNQ
         yqc9QtN0p9PpP1bicfnpTrElZP+TPdU+pHlVdjd4gmpAzXPQf/Y09B26D135Zp9qUlMz
         zuG7kL8KYzvG4RwjSXfItm5CtkQkJWotCc2EZ0hWnvDqxwzXtUcDyubCUIyxtMSbzeDS
         bojauVV9aiHMixXnW6c5YuTy4f4A/P3hP4JQGprNO9M1hqv8r5A3Zn+gK1fKQbzgmmUo
         KQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SS2KGzlfjLWSOo4Rl+0SlDA0DNdaHfog9YBOFxDk0j0=;
        b=HaMaDWpvEWsVMFFrtFdve9VtFNBo3LA/FKcRJuZVeOE3zaRckU1YGMtJcZEj5nXxqi
         yoTKXLfk73WI7xfI9V3u7KsEEwwCxDbYFMCJjpJBGcEoy2cin9Qjogj5zZ7XbaqJFI7L
         Sn1spBaYanmnUFEYSPvsxOjF0F7xOnnxBcrdenecuqQLX41MHnCRiPczm5ZCJhF7EhM4
         IuxqIIjPGY0V/poUIW772acEkT/fOyhYhkLBlJF3eAJj38tLGIzvEgSxuJVS9vtTVX+8
         MQ568Jy7Zwh8JrRrAJ7iY6sRsseyqojPxYz3S+mDARFE6wZEQWSxumtycwRm2uXrJgiE
         ayjA==
X-Gm-Message-State: AOAM532lN+HUL3gVYeOYV7mpDcP2y7/2Jqj0zeXkvJd7JjQBEypaXSA1
        2nkZTTAk/K8r2jj3xIct84E=
X-Google-Smtp-Source: ABdhPJzj0ixu8+ZiZkByG5Hd0+iUPqtddx7ZwKYg4OYtrFpJ85SICzds6iEvKZ3NM+3xiSmK+JSn/w==
X-Received: by 2002:a2e:88d4:: with SMTP id a20mr2589022ljk.303.1613164330443;
        Fri, 12 Feb 2021 13:12:10 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id a23sm794577lfl.6.2021.02.12.13.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 13:12:09 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 12 Feb 2021 22:12:07 +0100
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 2/2] rcu-tasks: add RCU-tasks self tests
Message-ID: <20210212211207.GA2046@pc638.lan>
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201209202732.5896-2-urezki@gmail.com>
 <20210212192059.wytqwdf4qm4rnq3d@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212192059.wytqwdf4qm4rnq3d@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 12, 2021 at 08:20:59PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-12-09 21:27:32 [+0100], Uladzislau Rezki (Sony) wrote:
> > Add self tests for checking of RCU-tasks API functionality.
> > It covers:
> >     - wait API functions;
> >     - invoking/completion call_rcu_tasks*().
> > 
> > Self-tests are run when CONFIG_PROVE_RCU kernel parameter is set.
> 
> I just bisected to this commit. By booting with `threadirqs' I end up
> with:
> [    0.176533] Running RCU-tasks wait API self tests
> 
> No stall warning or so.
> It boots again with:
> 
> diff --git a/init/main.c b/init/main.c
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1489,6 +1489,7 @@ void __init console_on_rootfs(void)
>  	fput(file);
>  }
>  
> +void rcu_tasks_initiate_self_tests(void);
>  static noinline void __init kernel_init_freeable(void)
>  {
>  	/*
> @@ -1514,6 +1515,7 @@ static noinline void __init kernel_init_freeable(void)
>  
>  	rcu_init_tasks_generic();
>  	do_pre_smp_initcalls();
> +	rcu_tasks_initiate_self_tests();
>  	lockup_detector_init();
>  
>  	smp_init();
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1266,7 +1266,7 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
>  	rttd->notrun = true;
>  }
>  
> -static void rcu_tasks_initiate_self_tests(void)
> +void rcu_tasks_initiate_self_tests(void)
>  {
>  	pr_info("Running RCU-tasks wait API self tests\n");
>  #ifdef CONFIG_TASKS_RCU
> @@ -1322,7 +1322,6 @@ void __init rcu_init_tasks_generic(void)
>  #endif
>  
>  	// Run the self-tests.
> -	rcu_tasks_initiate_self_tests();
>  }
>  
>  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Sebastian
>
We should be able to use call_rcu_tasks() in the *initcall() callbacks.
The problem is that, ksoftirqd threads are not spawned by the time when
an rcu_init_tasks_generic() is invoked:

diff --git a/init/main.c b/init/main.c
index c68d784376ca..e6106bb12b2d 100644
--- a/init/main.c
+++ b/init/main.c
@@ -954,7 +954,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	rcu_init_nohz();
 	init_timers();
 	hrtimers_init();
-	softirq_init();
 	timekeeping_init();
 
 	/*
@@ -1512,6 +1511,7 @@ static noinline void __init kernel_init_freeable(void)
 
 	init_mm_internals();
 
+	softirq_init();
 	rcu_init_tasks_generic();
 	do_pre_smp_initcalls();
 	lockup_detector_init();
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9d71046ea247..cafa55c496d0 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -630,6 +630,7 @@ void __init softirq_init(void)
 			&per_cpu(tasklet_hi_vec, cpu).head;
 	}
 
+	spawn_ksoftirqd();
 	open_softirq(TASKLET_SOFTIRQ, tasklet_action);
 	open_softirq(HI_SOFTIRQ, tasklet_hi_action);
 }
@@ -732,7 +733,6 @@ static __init int spawn_ksoftirqd(void)
 
 	return 0;
 }
-early_initcall(spawn_ksoftirqd);
 
 /*
  * [ These __weak aliases are kept in a separate compilation unit, so that

Any thoughts?

--
Vlad Rezki
