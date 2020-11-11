Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF8AC388F9
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 19:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 058DE2087D
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 19:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjCILlM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgKKTbX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:31:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgKKTbX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 Nov 2020 14:31:23 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82EC020825;
        Wed, 11 Nov 2020 19:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605123081;
        bh=bzqhxZU8csP6wlBgs2IA7QHV8F89EtTCrR4SKb7y2zs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SjCILlM5YfP9eSC9wRIviK1+mZorNHrd4qq4CJq0rlnjwe8YOqKfQ1uXzCELe9Krt
         ZJza28vQw+LE9cWYBCYNgbvalwTizeaSS5JHoYmbrtUyFMrYbmECT4OI8logjQpM9B
         OFh62AdOmO0Gn6rvkSbG5PxwFgxSOpvPwlPRKiwk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 210FC35225D6; Wed, 11 Nov 2020 11:31:21 -0800 (PST)
Date:   Wed, 11 Nov 2020 11:31:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Check and report missed fqs timer wakeup on RCU
 stall
Message-ID: <20201111193121.GC3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1605103657-25815-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605103657-25815-1-git-send-email-neeraju@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 11, 2020 at 07:37:37PM +0530, Neeraj Upadhyay wrote:
> For a new grace period request, RCU GP kthread transitions
> through following states:
> 
> a. [RCU_GP_WAIT_GPS] -> [RCU_GP_DONE_GPS]
> 
> Initial state, where GP kthread waits for a new GP start
> request is RCU_GP_WAIT_GPS. On new GP request (started by
> callers, for any new callbacks, by setting RCU_GP_FLAG_INIT
> gp_state flag and waking up the GP kthread) GP kthread
> enters RCU_GP_DONE_GPS.
> 
> b. [RCU_GP_DONE_GPS] -> [RCU_GP_ONOFF]
> 
> Grace period initialization starts in rcu_gp_init(), which
> records the start of new GP in rcu_state.gp_seq and enters
> into RCU_GP_ONOFF state.
> 
> c. [RCU_GP_ONOFF] -> [RCU_GP_INIT]
> 
> In RCU_GP_ONOFF state, for each leaf rnp node, GP kthread
> applies the buffered online/offline information of its cpus,
> from ->qsmaskinitnext to ->qsmaskinit, which is basically
> the mask of cpus, which need to report quiescent state, for
> the new GP to complete.
> 
> Also, in this state, an outgoing rnp's (for which all cpus
> are now offline and there are no tasks blocked inside
> RCU read section) or an incoming rnp's (for which first cpu
> comes online) participation in the new and subsequent GP is
> advertised, by propagating its qsmaskinit information up the
> tree.
> 
> d. [RCU_GP_INIT] -> [RCU_GP_WAIT_FQS]
> 
> In RCU_GP_INIT state, current GPs qs mask information and new
> GP seq is propagated down the tree, into all rnp nodes,
> in breadth first order.
> 
> On GP initialization completion, GP kthread enters a fqs loop,
> which does following things, to get quiescent state reported
> for cpus, which aren't quiesce in ->qsmask:
> 
>   i. For CPUs, which have entered idle since the first iteration,
>      report quiescent state up the tree.
> 
>   ii. Based on how long the current grace period has been running
>       for, either, set the appropriate flags, so that sched clock
>       interrupt on that cpu, does qs reporting or do a resched
>       on that cpu.
> 
> On each iteration, it transitions through following states. The fqs
> loop is terminated on GP completion, when all CPUs report their
> quiescent state and all RCU readers, blocking current grace period
> have completed the RCU read section.
> 
> e. [RCU_GP_WAIT_FQS] -> [RCU_GP_DOING_FQS]
> 
> GP kthread uses a timed wait (jiffies_till_first_fqs for first
> iteration and jiffies_till_next_fqs for subsequent iterations),
> before doing all the work, to force quiescent state on
> all cpus. It wakes up from this state, either on timeout, or
> when (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD) flags are set, either
> on callback overload conditions or when last cpu reports its
> quiescent state and all RCU readers blocking current GP, have
> left the RCU read section.
> 
> f. [RCU_GP_CLEANUP] -> [RCU_GP_CLEANED]
> 
> Mark end of grace period, in ->gp_seq, on all rnp nodes, in breadth
> first order and finally in rcu_state.
> 
> For cases where timers are not served (due to issues in timer
> configuration, in timer framework or due to softirqs not getting
> handled, when there is a storm of interrupts) on the CPU,
> where GP kthread queued a timer (for timed wait, which is done
> in RCU_GP_WAIT_FQS) its possible that RCU kthread never wakes up.
> Report the same from stall warnings, if GP thread is in RCU_GP_WAIT_FQS
> state, and the timeout has elapsed and the kthread is not woken.
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
>  kernel/rcu/tree.c       | 25 +++++++++++++++----------
>  kernel/rcu/tree_stall.h | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 413831b..804e543 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1767,7 +1767,7 @@ static bool rcu_gp_init(void)
>  	 * go offline later.  Please also refer to "Hotplug CPU" section
>  	 * of RCU's Requirements documentation.
>  	 */
> -	rcu_state.gp_state = RCU_GP_ONOFF;
> +	WRITE_ONCE(rcu_state.gp_state, RCU_GP_ONOFF);
>  	rcu_for_each_leaf_node(rnp) {
>  		smp_mb(); // Pair with barriers used when updating ->ofl_seq to odd values.
>  		firstseq = READ_ONCE(rnp->ofl_seq);
> @@ -1833,7 +1833,7 @@ static bool rcu_gp_init(void)
>  	 * The grace period cannot complete until the initialization
>  	 * process finishes, because this kthread handles both.
>  	 */
> -	rcu_state.gp_state = RCU_GP_INIT;
> +	WRITE_ONCE(rcu_state.gp_state, RCU_GP_INIT);
>  	rcu_for_each_node_breadth_first(rnp) {
>  		rcu_gp_slow(gp_init_delay);
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> @@ -1932,17 +1932,22 @@ static void rcu_gp_fqs_loop(void)
>  	ret = 0;
>  	for (;;) {
>  		if (!ret) {
> -			rcu_state.jiffies_force_qs = jiffies + j;
> +			WRITE_ONCE(rcu_state.jiffies_force_qs, jiffies + j);
> +			/*
> +			 * jiffies_force_qs before RCU_GP_WAIT_FQS state
> +			 * update; required for stall checks.
> +			 */
> +			smp_wmb();
>  			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
>  				   jiffies + (j ? 3 * j : 2));
>  		}
>  		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
>  				       TPS("fqswait"));
> -		rcu_state.gp_state = RCU_GP_WAIT_FQS;
> +		WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_FQS);
>  		ret = swait_event_idle_timeout_exclusive(
>  				rcu_state.gp_wq, rcu_gp_fqs_check_wake(&gf), j);
>  		rcu_gp_torture_wait();
> -		rcu_state.gp_state = RCU_GP_DOING_FQS;
> +		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
>  		/* Locking provides needed memory barriers. */
>  		/* If grace period done, leave loop. */
>  		if (!READ_ONCE(rnp->qsmask) &&
> @@ -2056,7 +2061,7 @@ static void rcu_gp_cleanup(void)
>  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
>  	rcu_seq_end(&rcu_state.gp_seq);
>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> -	rcu_state.gp_state = RCU_GP_IDLE;
> +	WRITE_ONCE(rcu_state.gp_state, RCU_GP_IDLE);
>  	/* Check for GP requests since above loop. */
>  	rdp = this_cpu_ptr(&rcu_data);
>  	if (!needgp && ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
> @@ -2095,12 +2100,12 @@ static int __noreturn rcu_gp_kthread(void *unused)
>  		for (;;) {
>  			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
>  					       TPS("reqwait"));
> -			rcu_state.gp_state = RCU_GP_WAIT_GPS;
> +			WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_GPS);
>  			swait_event_idle_exclusive(rcu_state.gp_wq,
>  					 READ_ONCE(rcu_state.gp_flags) &
>  					 RCU_GP_FLAG_INIT);
>  			rcu_gp_torture_wait();
> -			rcu_state.gp_state = RCU_GP_DONE_GPS;
> +			WRITE_ONCE(rcu_state.gp_state, RCU_GP_DONE_GPS);
>  			/* Locking provides needed memory barrier. */
>  			if (rcu_gp_init())
>  				break;
> @@ -2115,9 +2120,9 @@ static int __noreturn rcu_gp_kthread(void *unused)
>  		rcu_gp_fqs_loop();
>  
>  		/* Handle grace-period end. */
> -		rcu_state.gp_state = RCU_GP_CLEANUP;
> +		WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANUP);
>  		rcu_gp_cleanup();
> -		rcu_state.gp_state = RCU_GP_CLEANED;
> +		WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANED);
>  	}
>  }
>  
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 70d48c5..4ff7990 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -468,6 +468,37 @@ static void rcu_check_gp_kthread_starvation(void)
>  	}
>  }
>  
> +/* Complain about missing wakeups from expired fqs wait timer */
> +static void rcu_check_gp_kthread_expired_fqs_timer(void)
> +{
> +	struct task_struct *gpk = rcu_state.gp_kthread;
> +	short gp_state;
> +	unsigned long jiffies_fqs;
> +	int cpu;
> +
> +	gp_state = READ_ONCE(rcu_state.gp_state);
> +	/*
> +	 * Order reads of .gp_state and .jiffies_force_qs.
> +	 * Matching smp_wmb() is present in rcu_gp_fqs_loop().
> +	 */
> +	smp_rmb();
> +	jiffies_fqs = READ_ONCE(rcu_state.jiffies_force_qs);

Or you could use smp_load_acquire() instead of the smp_rmb()/READ_ONCE()
combination.  (Other parts of the stall-warning code might also be able
to do this, given that they predate smp_load_acquire().)

> +
> +	if (gp_state == RCU_GP_WAIT_FQS &&
> +	    time_before(jiffies + RCU_STALL_MIGHT_MIN, jiffies_fqs) &&
> +	    gpk && !READ_ONCE(gpk->on_rq)) {
> +		cpu = task_cpu(gpk);
> +		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx\n",
> +		       rcu_state.name, (jiffies - jiffies_fqs),
> +		       (long)rcu_seq_current(&rcu_state.gp_seq),
> +		       data_race(rcu_state.gp_flags),
> +		       gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
> +		       gpk->state);
> +		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%u\n",
> +		       cpu, kstat_softirqs_cpu(TIMER_SOFTIRQ, cpu));
> +	}

Otherwise looks plausible.

> +}
> +
>  static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  {
>  	int cpu;
> @@ -530,6 +561,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
>  
>  	rcu_check_gp_kthread_starvation();
> +	rcu_check_gp_kthread_expired_fqs_timer();
>  
>  	panic_on_rcu_stall();
>  
> @@ -565,6 +597,7 @@ static void print_cpu_stall(unsigned long gps)
>  		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
>  
>  	rcu_check_gp_kthread_starvation();
> +	rcu_check_gp_kthread_expired_fqs_timer();

I don't have an opinion about the ordering of this output within the
RCU CPU stall warning message, but I do encourage you to try out a
few different options.

Here is one possible way to test this code:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs TREE09 --bootargs "rcutorture.stall_cpu=25 rcutorture.stall_cpu_irqsoff=1" --trust-make

As an alternative to the above "--bootargs" parameter, the
rcutorture.stall_gp_kthread module parameter should also be interesting.
If I remember correctly, it should result in a stall without causing
your timer code above to print anything.

See recent paulmck.livejournal.com posts for additional information
on rcutorture and running it.

							Thanx, Paul
