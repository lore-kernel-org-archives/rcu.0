Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5C5C433DB
	for <rcu@archiver.kernel.org>; Fri, 12 Feb 2021 23:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F5F64DCF
	for <rcu@archiver.kernel.org>; Fri, 12 Feb 2021 23:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhBLXto (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Feb 2021 18:49:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231759AbhBLXtf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Feb 2021 18:49:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF99F64DCF;
        Fri, 12 Feb 2021 23:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613173731;
        bh=LkICKmIiDChJQFRPY8bMTeEW0irTbDse7v0NyWyqZeo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SPyKoDwf/MdYvXNSbsD/WbrVOOBvkzzLSOzIL/rKAuCOdP9wuXGL3R05bdTq2otKW
         uBdGtRfPeNa2CO1Sd2q54qHNdOpppKmPNThiM+XFZWNX12iLgfIoBxfT5vU1YWHGOy
         pxYK4xSjuDWwQCzPv4qaKTFjy/VtE4lbyd7cYXnxAnnDNxaRhbSh6L3ImaZe8rzpTB
         s6igB0bOkYgyYkc9Dn06Wj3Oc6g/FfD5OXRu8H/0qPDvJ9rG+llesTTYirD3hvTHG5
         9bBZcoogTnkDpycaL09tupAHryIbe3mRH8A4gc81ISdqFbEzTY+JWB4iVK5MkrCj7Q
         X/8CwvLF7AyDw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A238C352393D; Fri, 12 Feb 2021 15:48:51 -0800 (PST)
Date:   Fri, 12 Feb 2021 15:48:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <20210212234851.GP2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201209202732.5896-2-urezki@gmail.com>
 <20210212192059.wytqwdf4qm4rnq3d@linutronix.de>
 <20210212211207.GA2046@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212211207.GA2046@pc638.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 12, 2021 at 10:12:07PM +0100, Uladzislau Rezki wrote:
> On Fri, Feb 12, 2021 at 08:20:59PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2020-12-09 21:27:32 [+0100], Uladzislau Rezki (Sony) wrote:
> > > Add self tests for checking of RCU-tasks API functionality.
> > > It covers:
> > >     - wait API functions;
> > >     - invoking/completion call_rcu_tasks*().
> > > 
> > > Self-tests are run when CONFIG_PROVE_RCU kernel parameter is set.
> > 
> > I just bisected to this commit. By booting with `threadirqs' I end up
> > with:
> > [    0.176533] Running RCU-tasks wait API self tests
> > 
> > No stall warning or so.
> > It boots again with:
> > 
> > diff --git a/init/main.c b/init/main.c
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1489,6 +1489,7 @@ void __init console_on_rootfs(void)
> >  	fput(file);
> >  }
> >  
> > +void rcu_tasks_initiate_self_tests(void);
> >  static noinline void __init kernel_init_freeable(void)
> >  {
> >  	/*
> > @@ -1514,6 +1515,7 @@ static noinline void __init kernel_init_freeable(void)
> >  
> >  	rcu_init_tasks_generic();
> >  	do_pre_smp_initcalls();
> > +	rcu_tasks_initiate_self_tests();
> >  	lockup_detector_init();
> >  
> >  	smp_init();
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1266,7 +1266,7 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
> >  	rttd->notrun = true;
> >  }
> >  
> > -static void rcu_tasks_initiate_self_tests(void)
> > +void rcu_tasks_initiate_self_tests(void)
> >  {
> >  	pr_info("Running RCU-tasks wait API self tests\n");
> >  #ifdef CONFIG_TASKS_RCU
> > @@ -1322,7 +1322,6 @@ void __init rcu_init_tasks_generic(void)
> >  #endif
> >  
> >  	// Run the self-tests.
> > -	rcu_tasks_initiate_self_tests();
> >  }
> >  
> >  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Apologies for the hassle!  My testing clearly missed this combination
of CONFIG_PROVE_RCU=y and threadirqs=1.  :-(

But at least I can easily reproduce this hang as follows:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --bootargs "threadirqs=1" --trust-make

Sadly, I cannot take your patch because that simply papers over the
fact that early boot use of synchronize_rcu_tasks() is broken in this
particular configuration, which will likely eventually bite others now
that init_kprobes() has been moved earlier in boot:

1b04fa990026 ("rcu-tasks: Move RCU-tasks initialization to before early_initcall()")
Link: https://lore.kernel.org/rcu/87eekfh80a.fsf@dja-thinkpad.axtens.net/
Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")

> > Sebastian
> >
> We should be able to use call_rcu_tasks() in the *initcall() callbacks.
> The problem is that, ksoftirqd threads are not spawned by the time when
> an rcu_init_tasks_generic() is invoked:
> 
> diff --git a/init/main.c b/init/main.c
> index c68d784376ca..e6106bb12b2d 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -954,7 +954,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  	rcu_init_nohz();
>  	init_timers();
>  	hrtimers_init();
> -	softirq_init();
>  	timekeeping_init();
>  
>  	/*
> @@ -1512,6 +1511,7 @@ static noinline void __init kernel_init_freeable(void)
>  
>  	init_mm_internals();
>  
> +	softirq_init();
>  	rcu_init_tasks_generic();
>  	do_pre_smp_initcalls();
>  	lockup_detector_init();
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 9d71046ea247..cafa55c496d0 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -630,6 +630,7 @@ void __init softirq_init(void)
>  			&per_cpu(tasklet_hi_vec, cpu).head;
>  	}
>  
> +	spawn_ksoftirqd();

We need a forward reference to allow this to build, but with that added,
my test case passes.  Good show!

>  	open_softirq(TASKLET_SOFTIRQ, tasklet_action);
>  	open_softirq(HI_SOFTIRQ, tasklet_hi_action);
>  }
> @@ -732,7 +733,6 @@ static __init int spawn_ksoftirqd(void)
>  
>  	return 0;
>  }
> -early_initcall(spawn_ksoftirqd);
>  
>  /*
>   * [ These __weak aliases are kept in a separate compilation unit, so that
> 
> Any thoughts?

One likely problem is that there are almost certainly parts of the kernel
that need softirq_init() to stay roughly where it is.  So, is it possible
to leave softirq_init() where it is, and to arrange for spawn_ksoftirqd()
to be invoked just before rcu_init_tasks_generic() is called?

For my part, I will look into what is required to make Tasks RCU do
without softirq during boot, for example, by looking carefully at where
in boot RCU grace periods are unconditionally expedited.  Just in case
adjusting softirq has unforeseen side effects.

							Thanx, Paul
