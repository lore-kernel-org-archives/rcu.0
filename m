Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA01C6FA8B
	for <rcu@archiver.kernel.org>; Tue, 20 Sep 2022 09:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiITJjC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Sep 2022 05:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiITJjB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Sep 2022 05:39:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525EB66A70
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 02:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED88C626FD
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 09:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC11BC433C1;
        Tue, 20 Sep 2022 09:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663666739;
        bh=oApQbBQGIhFEx+iu94WGqi99S9HWhUHqazh3ihDF7Nk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AvcmWY2+c4iKC3vBORg95vIJ3tzmmms4+dsWhHQmhYzt/a3wc6CU6c514+ohd+uaV
         rm2alaDzcAiji8J9P8o7EZmbq9ml2n97Wrpz5Gdyu3tGdmLBe4oTa234R9ZLudEFAN
         hCV2YPRm/OKjbmgCNUpp2+DBxEjaUanwwIBUjwaKukwtzuzm3jH/O240mffks6AS+7
         dDNbCUyv2uhhNYDpZLHicOqWi4Vd/J7fH1i6D63CaOGicGi3CkQqA02hd5XqjtJg5c
         O6YcqfpnzKCW5rPfcY3fc6WY3Lg3rNLMNyr+eq8mEGvxoSvT/TSBv/2Nb1rPS3NzuY
         MaU/vvXXwdEZA==
Date:   Tue, 20 Sep 2022 11:38:56 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 2/3] rcu: Resort to cpu_dying_mask for affinity when
 offlining
Message-ID: <20220920093856.GF69891@lothringen>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-3-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915055825.21525-3-kernelfans@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 15, 2022 at 01:58:24PM +0800, Pingfan Liu wrote:
> During offlining, the concurrent rcutree_offline_cpu() can not be aware
> of each other through ->qsmaskinitnext.  But cpu_dying_mask carries such
> information at that point and can be utilized.
> 
> Besides, a trivial change which removes the redudant call to
> rcu_boost_kthread_setaffinity() in rcutree_dead_cpu() since
> rcutree_offline_cpu() can fully serve that purpose.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> To: rcu@vger.kernel.org
> ---
>  kernel/rcu/tree.c        | 2 --
>  kernel/rcu/tree_plugin.h | 6 ++++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 79aea7df4345..8a829b64f5b2 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2169,8 +2169,6 @@ int rcutree_dead_cpu(unsigned int cpu)
>  		return 0;
>  
>  	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> -	/* Adjust any no-longer-needed kthreads. */
> -	rcu_boost_kthread_setaffinity(rnp, -1);
>  	// Stop-machine done, so allow nohz_full to disable tick.
>  	tick_dep_clear(TICK_DEP_BIT_RCU);
>  	return 0;
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index ef6d3ae239b9..e5afc63bd97f 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1243,6 +1243,12 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>  		    cpu != outgoingcpu)
>  			cpumask_set_cpu(cpu, cm);
>  	cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
> +	/*
> +	 * For concurrent offlining, bit of qsmaskinitnext is not cleared yet.

For clarification, the comment could be:

           While concurrently offlining, rcu_report_dead() can race, making
           ->qsmaskinitnext unstable. So rely on cpu_dying_mask which is stable
           and already contains all the currently offlining CPUs.

Thanks!

> +	 * So resort to cpu_dying_mask, whose changes has already been visible.
> +	 */
> +	if (outgoingcpu != -1)
> +		cpumask_andnot(cm, cm, cpu_dying_mask);
>  	if (cpumask_empty(cm))
>  		cpumask_copy(cm, housekeeping_cpumask(HK_TYPE_RCU));
>  	set_cpus_allowed_ptr(t, cm);
> -- 
> 2.31.1
> 
