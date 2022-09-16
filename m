Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24538ECAAD8
	for <rcu@archiver.kernel.org>; Fri, 16 Sep 2022 14:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiIPOYH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Sep 2022 10:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiIPOYF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Sep 2022 10:24:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AD6B2848
        for <rcu@vger.kernel.org>; Fri, 16 Sep 2022 07:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D0CAB8275A
        for <rcu@vger.kernel.org>; Fri, 16 Sep 2022 14:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39740C433D6;
        Fri, 16 Sep 2022 14:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663338241;
        bh=8sQ1hdgU9VW6d7qpJCYJuZ5xHcpBneHZkNJccf2nijM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pSB/O4nX8xulZwcmf9BioiiYjRxlQ4+IhCMwAGOCBStu2waJFKpcXStjEbnb6a/gP
         GLcQrFhu/mPuPmgd/PAPUXI1YmwrXm9/mJ4EgPKLhytb73rtrIna+tB5pKuyGFvGw3
         09cTf970IivbBZoZNilNJXlY8tRV9ZO2IoGvOQiO22nxXL7wOjse1L/dNZvcr3uYpW
         nQw+5puNXnC6NU/qTRWhddL9b495YSk7HiP8EmeG5e6BNcDblKQkZdVZxHI+sh7LP3
         YXvkkfCzFeV7qTAaxhzj9CTRYgL2FhG9+QSXYa0x1RLh3vFVHaoJaVv/9dh4amM+3I
         cuyFmkRvcgcJQ==
Date:   Fri, 16 Sep 2022 16:23:58 +0200
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
Message-ID: <20220916142358.GA27246@lothringen>
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

I would suggest to make this a separate change, for bisectability and
readability.

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
> +	 * So resort to cpu_dying_mask, whose changes has already been visible.
> +	 */
> +	if (outgoingcpu != -1)
> +		cpumask_andnot(cm, cm, cpu_dying_mask);

I'm not sure how the infrastructure changes in your concurrent down patchset
but can the cpu_dying_mask concurrently change at this stage?

Thanks.

>  	if (cpumask_empty(cm))
>  		cpumask_copy(cm, housekeeping_cpumask(HK_TYPE_RCU));
>  	set_cpus_allowed_ptr(t, cm);
> -- 
> 2.31.1
> 
