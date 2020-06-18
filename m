Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617C5C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 23:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37FE520888
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 23:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592522876;
	bh=TBJKhAQEygMOseCYXtyikk8n84/CtmGw79BvX/Lk+xM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=PQH71E3iDHrC3JhO3U53H0+b5prY0hTpAPHl4CzWtlRCd8H621403FHMYYZNI+qoQ
	 1SLIRZTtLQai/0cjrYnr8rymcr0GRqRNLpFfD2kyap3nkDtlOB+IAKB6RzOm4BTY6o
	 znjrE2c1AVuE/ftVkjasbngWjtLyAQyHJMt058ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgFRX14 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbgFRX1z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 19:27:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E09CC2080D;
        Thu, 18 Jun 2020 23:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592522874;
        bh=TBJKhAQEygMOseCYXtyikk8n84/CtmGw79BvX/Lk+xM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yXjRZLxGpqnCxw5QHbJNRkJBC069TQ6JbdfNfCtvnRmcZiBvrSXT3libABsvY6KhV
         hDtTmskaZttzzajPB7cCBNED1pbyywhW3+sm5BChhHGHuwOyXjqnhr4YhNPQHTIhvj
         FojTJU4g7/sB0wtYkTB31gYaiHn4LNmNawbCAJls=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C3B7E352264E; Thu, 18 Jun 2020 16:27:54 -0700 (PDT)
Date:   Thu, 18 Jun 2020 16:27:54 -0700
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
Subject: Re: [PATCH 7/7] rcutorture: Add number of GP information to reports
Message-ID: <20200618232754.GE2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200618202955.4024-1-joel@joelfernandes.org>
 <20200618202955.4024-7-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618202955.4024-7-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 04:29:55PM -0400, Joel Fernandes (Google) wrote:
> Add 2 things to get visiblity around number of grace periods.
> 1. Add number of GPs to End-state print.
> 2. Just like End-state, add GP state to Start-state.
> 
> This helps determine how many GPs elapsed during a run of rcutorture and
> what the initial state was.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

And I queued this one with a reworked commit log, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 959a1f84d6904..c80725ddd9030 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -186,6 +186,7 @@ static long n_barrier_successes; /* did rcu_barrier test succeed? */
>  static unsigned long n_read_exits;
>  static struct list_head rcu_torture_removed;
>  static unsigned long shutdown_jiffies;
> +static unsigned long start_gp_seq;
>  
>  static int rcu_torture_writer_state;
>  #define RTWS_FIXED_DELAY	0
> @@ -2508,8 +2509,9 @@ rcu_torture_cleanup(void)
>  
>  	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
>  	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
> -	pr_alert("%s:  End-test grace-period state: g%lu f%#x\n",
> -		 cur_ops->name, gp_seq, flags);
> +	pr_alert("%s:  End-test grace-period state: g%ld f%#x total-gps=%ld\n",
> +		 cur_ops->name, (long)gp_seq, flags,
> +		 rcutorture_seq_diff(gp_seq, start_gp_seq));
>  	torture_stop_kthread(rcu_torture_stats, stats_task);
>  	torture_stop_kthread(rcu_torture_fqs, fqs_task);
>  	if (rcu_torture_can_boost())
> @@ -2633,6 +2635,8 @@ rcu_torture_init(void)
>  	long i;
>  	int cpu;
>  	int firsterr = 0;
> +	int flags = 0;
> +	unsigned long gp_seq = 0;
>  	static struct rcu_torture_ops *torture_ops[] = {
>  		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
>  		&busted_srcud_ops, &tasks_ops, &tasks_rude_ops,
> @@ -2675,6 +2679,11 @@ rcu_torture_init(void)
>  			nrealreaders = 1;
>  	}
>  	rcu_torture_print_module_parms(cur_ops, "Start of test");
> +	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> +	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
> +	start_gp_seq = gp_seq;
> +	pr_alert("%s:  Start-test grace-period state: g%ld f%#x\n",
> +		 cur_ops->name, (long)gp_seq, flags);
>  
>  	/* Set up the freelist. */
>  
> -- 
> 2.27.0.111.gc72c7da667-goog
> 
