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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35533C433DB
	for <rcu@archiver.kernel.org>; Sat, 13 Feb 2021 11:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2EE064DD8
	for <rcu@archiver.kernel.org>; Sat, 13 Feb 2021 11:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhBMLbS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 13 Feb 2021 06:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhBMLbQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 13 Feb 2021 06:31:16 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C6FC061574;
        Sat, 13 Feb 2021 03:30:34 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id g11so2098070ljj.7;
        Sat, 13 Feb 2021 03:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9oAZW716hQ/1mpAEJYUUf+KvXvyl3W8Is2uKh2B/XAU=;
        b=tL4VAEubVETws/utebEowgKb8dHI6UElhhWe+gei86zSRmVvpL24NtubVhFYdAXiYQ
         ix7O/xTBErNKhWeOjIhDl5/pSgYIWP3bFPNSFmCHgdBBS9EZPwLUuQ5faoq/vVYfZ/4i
         cDWUMlRUfg0LEoxmvP2NUsA9WjJdBXRvZXA1QAlClPWEJurT3KLKv5K6rrKq2FPh8x6l
         V8ftGGhn4qkUOF/WS+1n7zwQb+iRiRaJ1xLUDzVYtFxdzOh0Vj7tCL7GYizmAXjeGIe7
         KDQVtnh+IoFkKYpHfeJSsRF3KR/1OuE7XJ2VpLWm4MPGJcTm/NkVUPIE67ovSVGepfms
         9deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9oAZW716hQ/1mpAEJYUUf+KvXvyl3W8Is2uKh2B/XAU=;
        b=s/b7PUdRKREMCWDqr/H/94DSrne1tNmfCzgeACThSrjJtfQe/ZKGQF/reS3iRwO34y
         D6elPMIZoed7xT4/6400NkaNi47KP8XIUgksS6OX6wsUZlaG7AefS1PfV+D/an91WhZz
         /zwFOdE8gz7vyTk+n87kqtVbGtr9nhNy8n5b2il/SJjotdDJdpx765bFFNdhJt9KsR7O
         ArAC+/PEYkp09OjS48l6q3XCsUkd120kPo6h3pJenN8hj73gT2jez65t+PZAR14k5GmK
         KBYfK30k6NHvleFQK5tbFUudqDGCDsgtW6fzIzcbidkrN2Kq4d9k8emLxFajaDO7uAS4
         lDhw==
X-Gm-Message-State: AOAM531XDUlR/T43n9MjnbZHb/uUajNYVBHbqcb5yNgdAMo7b5dTuQ8m
        twciChvSnsrE/waRXHBvPko=
X-Google-Smtp-Source: ABdhPJzHTkUJ2Ykc8VUotUS0U81KnZevnbH0cyVrYbgyvMnp709V/CYjApwPbEvDWXDCxsEsM/H+Dg==
X-Received: by 2002:a2e:9b8b:: with SMTP id z11mr667682lji.331.1613215833163;
        Sat, 13 Feb 2021 03:30:33 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n15sm1815043lfi.146.2021.02.13.03.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 03:30:32 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sat, 13 Feb 2021 12:30:30 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 2/2] rcu-tasks: add RCU-tasks self tests
Message-ID: <20210213113030.GA1878@pc638.lan>
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201209202732.5896-2-urezki@gmail.com>
 <20210212192059.wytqwdf4qm4rnq3d@linutronix.de>
 <20210212211207.GA2046@pc638.lan>
 <20210212234851.GP2743@paulmck-ThinkPad-P72>
 <20210213003709.GA27846@paulmck-ThinkPad-P72>
 <20210213004328.GB27846@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210213004328.GB27846@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 12, 2021 at 04:43:28PM -0800, Paul E. McKenney wrote:
> On Fri, Feb 12, 2021 at 04:37:09PM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 12, 2021 at 03:48:51PM -0800, Paul E. McKenney wrote:
> > > On Fri, Feb 12, 2021 at 10:12:07PM +0100, Uladzislau Rezki wrote:
> > > > On Fri, Feb 12, 2021 at 08:20:59PM +0100, Sebastian Andrzej Siewior wrote:
> > > > > On 2020-12-09 21:27:32 [+0100], Uladzislau Rezki (Sony) wrote:
> > > > > > Add self tests for checking of RCU-tasks API functionality.
> > > > > > It covers:
> > > > > >     - wait API functions;
> > > > > >     - invoking/completion call_rcu_tasks*().
> > > > > > 
> > > > > > Self-tests are run when CONFIG_PROVE_RCU kernel parameter is set.
> > > > > 
> > > > > I just bisected to this commit. By booting with `threadirqs' I end up
> > > > > with:
> > > > > [    0.176533] Running RCU-tasks wait API self tests
> > > > > 
> > > > > No stall warning or so.
> > > > > It boots again with:
> > > > > 
> > > > > diff --git a/init/main.c b/init/main.c
> > > > > --- a/init/main.c
> > > > > +++ b/init/main.c
> > > > > @@ -1489,6 +1489,7 @@ void __init console_on_rootfs(void)
> > > > >  	fput(file);
> > > > >  }
> > > > >  
> > > > > +void rcu_tasks_initiate_self_tests(void);
> > > > >  static noinline void __init kernel_init_freeable(void)
> > > > >  {
> > > > >  	/*
> > > > > @@ -1514,6 +1515,7 @@ static noinline void __init kernel_init_freeable(void)
> > > > >  
> > > > >  	rcu_init_tasks_generic();
> > > > >  	do_pre_smp_initcalls();
> > > > > +	rcu_tasks_initiate_self_tests();
> > > > >  	lockup_detector_init();
> > > > >  
> > > > >  	smp_init();
> > > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > > --- a/kernel/rcu/tasks.h
> > > > > +++ b/kernel/rcu/tasks.h
> > > > > @@ -1266,7 +1266,7 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
> > > > >  	rttd->notrun = true;
> > > > >  }
> > > > >  
> > > > > -static void rcu_tasks_initiate_self_tests(void)
> > > > > +void rcu_tasks_initiate_self_tests(void)
> > > > >  {
> > > > >  	pr_info("Running RCU-tasks wait API self tests\n");
> > > > >  #ifdef CONFIG_TASKS_RCU
> > > > > @@ -1322,7 +1322,6 @@ void __init rcu_init_tasks_generic(void)
> > > > >  #endif
> > > > >  
> > > > >  	// Run the self-tests.
> > > > > -	rcu_tasks_initiate_self_tests();
> > > > >  }
> > > > >  
> > > > >  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> > > > > 
> > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > 
> > > Apologies for the hassle!  My testing clearly missed this combination
> > > of CONFIG_PROVE_RCU=y and threadirqs=1.  :-(
> > > 
> > > But at least I can easily reproduce this hang as follows:
> > > 
> > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --bootargs "threadirqs=1" --trust-make
> > > 
> > > Sadly, I cannot take your patch because that simply papers over the
> > > fact that early boot use of synchronize_rcu_tasks() is broken in this
> > > particular configuration, which will likely eventually bite others now
> > > that init_kprobes() has been moved earlier in boot:
> > > 
> > > 1b04fa990026 ("rcu-tasks: Move RCU-tasks initialization to before early_initcall()")
> > > Link: https://lore.kernel.org/rcu/87eekfh80a.fsf@dja-thinkpad.axtens.net/
> > > Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
> > > 
> > > > > Sebastian
> > > > >
> > > > We should be able to use call_rcu_tasks() in the *initcall() callbacks.
> > > > The problem is that, ksoftirqd threads are not spawned by the time when
> > > > an rcu_init_tasks_generic() is invoked:
> > > > 
> > > > diff --git a/init/main.c b/init/main.c
> > > > index c68d784376ca..e6106bb12b2d 100644
> > > > --- a/init/main.c
> > > > +++ b/init/main.c
> > > > @@ -954,7 +954,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
> > > >  	rcu_init_nohz();
> > > >  	init_timers();
> > > >  	hrtimers_init();
> > > > -	softirq_init();
> > > >  	timekeeping_init();
> > > >  
> > > >  	/*
> > > > @@ -1512,6 +1511,7 @@ static noinline void __init kernel_init_freeable(void)
> > > >  
> > > >  	init_mm_internals();
> > > >  
> > > > +	softirq_init();
> > > >  	rcu_init_tasks_generic();
> > > >  	do_pre_smp_initcalls();
> > > >  	lockup_detector_init();
> > > > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > > > index 9d71046ea247..cafa55c496d0 100644
> > > > --- a/kernel/softirq.c
> > > > +++ b/kernel/softirq.c
> > > > @@ -630,6 +630,7 @@ void __init softirq_init(void)
> > > >  			&per_cpu(tasklet_hi_vec, cpu).head;
> > > >  	}
> > > >  
> > > > +	spawn_ksoftirqd();
> > > 
> > > We need a forward reference to allow this to build, but with that added,
> > > my test case passes.  Good show!
> > > 
> > > >  	open_softirq(TASKLET_SOFTIRQ, tasklet_action);
> > > >  	open_softirq(HI_SOFTIRQ, tasklet_hi_action);
> > > >  }
> > > > @@ -732,7 +733,6 @@ static __init int spawn_ksoftirqd(void)
> > > >  
> > > >  	return 0;
> > > >  }
> > > > -early_initcall(spawn_ksoftirqd);
> > > >  
> > > >  /*
> > > >   * [ These __weak aliases are kept in a separate compilation unit, so that
> > > > 
> > > > Any thoughts?
> > > 
> > > One likely problem is that there are almost certainly parts of the kernel
> > > that need softirq_init() to stay roughly where it is.  So, is it possible
> > > to leave softirq_init() where it is, and to arrange for spawn_ksoftirqd()
> > > to be invoked just before rcu_init_tasks_generic() is called?
> > 
> > This still seems worth trying (and doing so is next on my list), but just
> 
> And the patch below takes this approach, which also causes the tests to
> pass.
> 
> Thoughts?
> 
> 								Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit f4cd768e341486655c8c196e1f2b48a4463541f3
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Feb 12 16:41:05 2021 -0800
> 
>     softirq: Don't try waking ksoftirqd before it has been spawned
>     
>     If there is heavy softirq activity, the softirq system will attempt
>     to awaken ksoftirqd and will stop the traditional back-of-interrupt
>     softirq processing.  This is all well and good, but only if the
>     ksoftirqd kthreads already exist, which is not the case during early
>     boot, in which case the system hangs.
>     
>     One reproducer is as follows:
>     
>     tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --bootargs "threadirqs=1" --trust-make
>     
>     This commit therefore moves the spawning of the ksoftirqd kthreads
>     earlier in boot.  With this change, the above test passes.
>     
>     Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     Reported-by: Uladzislau Rezki <urezki@gmail.com>
>     Inspired-by: Uladzislau Rezki <urezki@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index bb8ff90..283a02d 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -592,6 +592,8 @@ static inline struct task_struct *this_cpu_ksoftirqd(void)
>  	return this_cpu_read(ksoftirqd);
>  }
>  
> +int spawn_ksoftirqd(void);
> +
>  /* Tasklets --- multithreaded analogue of BHs.
>  
>     This API is deprecated. Please consider using threaded IRQs instead:
> diff --git a/init/main.c b/init/main.c
> index c68d784..99835bb 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1512,6 +1512,7 @@ static noinline void __init kernel_init_freeable(void)
>  
>  	init_mm_internals();
>  
> +	spawn_ksoftirqd();
>  	rcu_init_tasks_generic();
>  	do_pre_smp_initcalls();
>  	lockup_detector_init();
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 9d71046..45d50d4 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -724,7 +724,7 @@ static struct smp_hotplug_thread softirq_threads = {
>  	.thread_comm		= "ksoftirqd/%u",
>  };
>  
> -static __init int spawn_ksoftirqd(void)
> +__init int spawn_ksoftirqd(void)
>  {
>  	cpuhp_setup_state_nocalls(CPUHP_SOFTIRQ_DEAD, "softirq:dead", NULL,
>  				  takeover_tasklets);
> @@ -732,7 +732,6 @@ static __init int spawn_ksoftirqd(void)
>  
>  	return 0;
>  }
> -early_initcall(spawn_ksoftirqd);
>  
>  /*
>   * [ These __weak aliases are kept in a separate compilation unit, so that
>
I thought about this approach as a first step how to fix it, but then came up with 
moving the spawn_ksoftirqd(void); into the softirq_init() to make it consolidated
at one place and not spread.

Then moving the softirq_init() down may cause other drawbacks, like you mentioned
if somebody needs it earlier.

I agree with your approach. Invoking the spawn_ksoftirqd() before the rcu_init_tasks_generic()
makes it safe. At least it prevents other parts to be broken comparing with touching
and moving softirq_init().

--
Vlad Rezki
