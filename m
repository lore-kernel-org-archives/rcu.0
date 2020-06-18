Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27301C433DF
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 22:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F39B2206F1
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 22:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592520060;
	bh=mSTGr0z1t50V+4PETgkloUEYdLRH7d9JFYjF022gv9c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=nxZVmf7njc3+0Cn6otEvwrKAdOoblGHDKuIVjU9Tf/r2cKi2cstgJfwpVEU0GheUf
	 9IqVGfAxn3NQobpPT3tpUrJrFTsraUE01cWQituRznuTyHjdWU6OyPtiXMusqfk7XC
	 cxKJuY2is7OHJOwM84KDZPdw2x1V2JZPjtmNiPLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgFRWk7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgFRWk7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 18:40:59 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BF7C206E2;
        Thu, 18 Jun 2020 22:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592520058;
        bh=mSTGr0z1t50V+4PETgkloUEYdLRH7d9JFYjF022gv9c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XK29KKgqdhmppO7VOvmr16E5m0h0Kc/cOA9G/gfzf0jRQVvvmoNhP664RVYenDmNC
         2KuGOE9ZMZyPDSiUdl8sqF9R1BoYSes4VAxk9Ss92yVCI8DuDuWEhcl/injAPw/PyP
         5fHWk9sK6Rum4ecg+o/x/XkvxbqUJTWOMzY67btQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 801DE352264E; Thu, 18 Jun 2020 15:40:58 -0700 (PDT)
Date:   Thu, 18 Jun 2020 15:40:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH 6/7] rcutorture: Add support to get the number of wakeups
 of main GP kthread
Message-ID: <20200618224058.GD2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200618202955.4024-1-joel@joelfernandes.org>
 <20200618202955.4024-6-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618202955.4024-6-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 04:29:54PM -0400, Joel Fernandes (Google) wrote:
> This is useful to check for any improvements or degradation related to
> number of GP kthread wakeups during testing.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

This was a good way to collect the data for your testing, but
we can expect rcutorture to only do so much.  ;-)

							Thanx, Paul

> ---
>  kernel/rcu/Kconfig.debug |  1 +
>  kernel/rcu/rcu.h         |  2 ++
>  kernel/rcu/rcutorture.c  | 23 ++++++++++++++++++++++-
>  kernel/rcu/tree.c        |  7 +++++++
>  4 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index 3cf6132a4bb9f..3323e3378af5a 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -50,6 +50,7 @@ config RCU_TORTURE_TEST
>  	select TASKS_RCU
>  	select TASKS_RUDE_RCU
>  	select TASKS_TRACE_RCU
> +	select SCHEDSTATS
>  	default n
>  	help
>  	  This option provides a kernel module that runs torture tests
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index cf66a3ccd7573..7e867e81d9738 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -511,6 +511,7 @@ srcu_batches_completed(struct srcu_struct *sp) { return 0; }
>  static inline void rcu_force_quiescent_state(void) { }
>  static inline void show_rcu_gp_kthreads(void) { }
>  static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
> +static inline struct task_struct *rcu_get_main_gp_kthread(void) { return 0; }
>  static inline void rcu_fwd_progress_check(unsigned long j) { }
>  #else /* #ifdef CONFIG_TINY_RCU */
>  bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
> @@ -519,6 +520,7 @@ unsigned long rcu_exp_batches_completed(void);
>  unsigned long srcu_batches_completed(struct srcu_struct *sp);
>  void show_rcu_gp_kthreads(void);
>  int rcu_get_gp_kthreads_prio(void);
> +struct task_struct *rcu_get_main_gp_kthread(void);
>  void rcu_fwd_progress_check(unsigned long j);
>  void rcu_force_quiescent_state(void);
>  extern struct workqueue_struct *rcu_gp_wq;
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index d0d265304d147..959a1f84d6904 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -23,6 +23,7 @@
>  #include <linux/rcupdate_wait.h>
>  #include <linux/interrupt.h>
>  #include <linux/sched/signal.h>
> +#include <linux/sched/stat.h>
>  #include <uapi/linux/sched/types.h>
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
> @@ -460,9 +461,29 @@ static void rcu_sync_torture_init(void)
>  	INIT_LIST_HEAD(&rcu_torture_removed);
>  }
>  
> +unsigned long rcu_gp_nr_wakeups;
> +
> +static void rcu_flavor_init(void)
> +{
> +	rcu_sync_torture_init();
> +
> +	/* Make sure schedstat is enabled for GP thread wakeup count. */
> +	force_schedstat_enabled();
> +	rcu_gp_nr_wakeups = rcu_get_main_gp_kthread()->se.statistics.nr_wakeups;
> +}
> +
> +static void rcu_flavor_cleanup(void)
> +{
> +	unsigned long now_nr = rcu_get_main_gp_kthread()->se.statistics.nr_wakeups;
> +
> +	pr_alert("End-test: Cleanup: Total GP-kthread wakeups: %lu\n",
> +		now_nr - rcu_gp_nr_wakeups);
> +}
> +
>  static struct rcu_torture_ops rcu_ops = {
>  	.ttype		= RCU_FLAVOR,
> -	.init		= rcu_sync_torture_init,
> +	.init		= rcu_flavor_init,
> +	.cleanup	= rcu_flavor_cleanup,
>  	.readlock	= rcu_torture_read_lock,
>  	.read_delay	= rcu_read_delay,
>  	.readunlock	= rcu_torture_read_unlock,
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c3bae7a83d792..a3a175feb310a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -175,6 +175,13 @@ int rcu_get_gp_kthreads_prio(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
>  
> +/* Retrieve RCU's main GP kthread task_struct */
> +struct task_struct *rcu_get_main_gp_kthread(void)
> +{
> +	return rcu_state.gp_kthread;
> +}
> +EXPORT_SYMBOL_GPL(rcu_get_main_gp_kthread);
> +
>  /*
>   * Number of grace periods between delays, normalized by the duration of
>   * the delay.  The longer the delay, the more the grace periods between
> -- 
> 2.27.0.111.gc72c7da667-goog
> 
