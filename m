Return-Path: <SRS0=7B7l=BU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFBDC433DF
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FAD20829
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 16:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597076387;
	bh=C5xPdoAXxesnpbnTV8Zpz2YdhWKRPi1Lhje/dmEX9B4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=k9WeraBWcOGv9eRTJVGMMDACRz9CMLMfdyB/2EGVTYUyqlTv9/ysLBEpJnwVB/5jc
	 cDGXzDZ61nVLBvh7oqL8/8yrV7vfl9uKSQLZbeNVK7lt42QavgSJ2WSbYzfVMMostD
	 1j34MKW2MH2qmNM1RnPaDvIyGVJFuOUYSzrMX9NM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgHJQTr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgHJQTr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Aug 2020 12:19:47 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E23820838;
        Mon, 10 Aug 2020 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597076386;
        bh=C5xPdoAXxesnpbnTV8Zpz2YdhWKRPi1Lhje/dmEX9B4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=z2Igdq+F6c9kQlRjKKlpR8L4i4Ksdko75kbSvTJWBafSPEyNEQP1u+eXfaOYtm/xs
         xVc07ifgGTa+f4hyXoWNYtt6taYOupEQmMy/0ln/CEpGqlTyywEAkxyg5i5tgzR/a/
         9AXzAarDWFYMs/c6sCE0Z+7C9WAWyreYyiyKUhtI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EF00635228C7; Mon, 10 Aug 2020 09:19:45 -0700 (PDT)
Date:   Mon, 10 Aug 2020 09:19:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        neeraju@codeaurora.org, peterz@infradead.org,
        Randy Dunlap <rdunlap@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        vineethrp@gmail.com
Subject: Re: [PATCH v4 4/5] rcutorture: Force synchronizing of RCU flavor
 from hotplug notifier
Message-ID: <20200810161945.GK4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200807170722.2897328-1-joel@joelfernandes.org>
 <20200807170722.2897328-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807170722.2897328-5-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 07, 2020 at 01:07:21PM -0400, Joel Fernandes (Google) wrote:
> RCU has had deadlocks in the past related to synchronizing in a hotplug
> notifier. Typically, this has occurred because timer callbacks did not get
> migrated before the CPU hotplug notifier requesting RCU's services is
> called. If RCU's grace period processing has a timer callback queued in
> the meanwhile, it may never get called causing RCU stalls.
> 
> These issues have been fixed by removing such dependencies from grace
> period processing, however there are no testing scenarios for such
> cases.
> 
> This commit therefore reuses rcutorture's existing hotplug notifier to
> invoke the flavor-specific synchronize callback. If anything locks up,
> we expect stall warnings and/or other splats.
> 
> Obviously, we need not test for rcu_barrier from a notifier, since those
> are not allowed from notifiers. This fact is already detailed in the
> documentation as well.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Given that rcutorture_booster_init() is invoked on the CPU in question
only after it is up and running, and that (if I remember correctly)
rcutorture_booster_cleanup() is invoked on the outgoing CPU before it
has really started going away, would this code really have caught that
timer/CPU-hotplug/RCU bug?

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 81 +++++++++++++++++++++--------------------
>  1 file changed, 42 insertions(+), 39 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 92cb79620939..083b65e4877d 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1645,12 +1645,37 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
>  		 read_exit_delay, read_exit_burst);
>  }
>  
> -static int rcutorture_booster_cleanup(unsigned int cpu)
> +static bool rcu_torture_can_boost(void)
> +{
> +	static int boost_warn_once;
> +	int prio;
> +
> +	if (!(test_boost == 1 && cur_ops->can_boost) && test_boost != 2)
> +		return false;
> +
> +	prio = rcu_get_gp_kthreads_prio();
> +	if (!prio)
> +		return false;
> +
> +	if (prio < 2) {
> +		if (boost_warn_once  == 1)
> +			return false;
> +
> +		pr_alert("%s: WARN: RCU kthread priority too low to test boosting.  Skipping RCU boost test. Try passing rcutree.kthread_prio > 1 on the kernel command line.\n", KBUILD_MODNAME);
> +		boost_warn_once = 1;
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int rcutorture_hp_cleanup(unsigned int cpu)
>  {
>  	struct task_struct *t;
>  
> -	if (boost_tasks[cpu] == NULL)
> +	if (!rcu_torture_can_boost() || boost_tasks[cpu] == NULL)
>  		return 0;
> +
>  	mutex_lock(&boost_mutex);
>  	t = boost_tasks[cpu];
>  	boost_tasks[cpu] = NULL;
> @@ -1662,11 +1687,14 @@ static int rcutorture_booster_cleanup(unsigned int cpu)
>  	return 0;
>  }
>  
> -static int rcutorture_booster_init(unsigned int cpu)
> +static int rcutorture_hp_init(unsigned int cpu)
>  {
>  	int retval;
>  
> -	if (boost_tasks[cpu] != NULL)
> +	/* Force synchronizing from hotplug notifier to ensure it is safe. */
> +	cur_ops->sync();
> +
> +	if (!rcu_torture_can_boost() || boost_tasks[cpu] != NULL)
>  		return 0;  /* Already created, nothing more to do. */
>  
>  	/* Don't allow time recalculation while creating a new task. */
> @@ -2336,30 +2364,6 @@ static void rcu_torture_barrier_cleanup(void)
>  	}
>  }
>  
> -static bool rcu_torture_can_boost(void)
> -{
> -	static int boost_warn_once;
> -	int prio;
> -
> -	if (!(test_boost == 1 && cur_ops->can_boost) && test_boost != 2)
> -		return false;
> -
> -	prio = rcu_get_gp_kthreads_prio();
> -	if (!prio)
> -		return false;
> -
> -	if (prio < 2) {
> -		if (boost_warn_once  == 1)
> -			return false;
> -
> -		pr_alert("%s: WARN: RCU kthread priority too low to test boosting.  Skipping RCU boost test. Try passing rcutree.kthread_prio > 1 on the kernel command line.\n", KBUILD_MODNAME);
> -		boost_warn_once = 1;
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
>  static bool read_exit_child_stop;
>  static bool read_exit_child_stopped;
>  static wait_queue_head_t read_exit_wq;
> @@ -2503,8 +2507,7 @@ rcu_torture_cleanup(void)
>  		 rcutorture_seq_diff(gp_seq, start_gp_seq));
>  	torture_stop_kthread(rcu_torture_stats, stats_task);
>  	torture_stop_kthread(rcu_torture_fqs, fqs_task);
> -	if (rcu_torture_can_boost())
> -		cpuhp_remove_state(rcutor_hp);
> +	cpuhp_remove_state(rcutor_hp);
>  
>  	/*
>  	 * Wait for all RCU callbacks to fire, then do torture-type-specific
> @@ -2773,21 +2776,21 @@ rcu_torture_init(void)
>  		if (firsterr)
>  			goto unwind;
>  	}
> +
> +	firsterr = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "RCU_TORTURE",
> +			rcutorture_hp_init,
> +			rcutorture_hp_cleanup);
> +	if (firsterr < 0)
> +		goto unwind;
> +	rcutor_hp = firsterr;
> +
>  	if (test_boost_interval < 1)
>  		test_boost_interval = 1;
>  	if (test_boost_duration < 2)
>  		test_boost_duration = 2;
> -	if (rcu_torture_can_boost()) {
> -
> +	if (rcu_torture_can_boost())
>  		boost_starttime = jiffies + test_boost_interval * HZ;
>  
> -		firsterr = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "RCU_TORTURE",
> -					     rcutorture_booster_init,
> -					     rcutorture_booster_cleanup);
> -		if (firsterr < 0)
> -			goto unwind;
> -		rcutor_hp = firsterr;
> -	}
>  	shutdown_jiffies = jiffies + shutdown_secs * HZ;
>  	firsterr = torture_shutdown_init(shutdown_secs, rcu_torture_cleanup);
>  	if (firsterr)
> -- 
> 2.28.0.236.gb10cc79966-goog
> 
