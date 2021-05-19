Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECABFC433B4
	for <rcu@archiver.kernel.org>; Wed, 19 May 2021 15:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0ACD611BF
	for <rcu@archiver.kernel.org>; Wed, 19 May 2021 15:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355045AbhESQA0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 19 May 2021 12:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347104AbhESQAZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 19 May 2021 12:00:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C66660FE6;
        Wed, 19 May 2021 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621439946;
        bh=5QAGP8Jnd/0oosn50Cd3duuJnlkzLqAaJbYaVmj9A/Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Cd9yGhgSKwxswN8HxyCUDIpI3jIoumJm/Ypfd385N/i+zUCUn2iwulDEqsQY9nqxj
         KtwMoq0ExEHT3h5qpECrSe5WEhhpqH6p9ls6e4dCBcTtOuv4Yta1h4wwdBsJk7pV2q
         qysyY3DbjOEnYG6XSFM3DG7WOOx4UzNHfd6uGOeGdokL9LYXLGCZzqauum+3VEz3dy
         Pj2Af9hQbzsVd/np977KCdAxYFbhjJAgDhEBruE3E+H1p9ioeEyxLKI2QPzSdmcviC
         sPsfVaC60t6ianOpWTJsBZwXc921SsLPHquBi1ifZeLWjsWDAM/WSVZ6CbqZ5FwDoW
         1Q5hcgOzPCpIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CC8ED5C00D9; Wed, 19 May 2021 08:59:05 -0700 (PDT)
Date:   Wed, 19 May 2021 08:59:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 2/3] rcu/nocb: Remove NOCB deferred wakeup from
 rcutree_dead_cpu()
Message-ID: <20210519155905.GY4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210519000930.15702-1-frederic@kernel.org>
 <20210519000930.15702-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519000930.15702-3-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 19, 2021 at 02:09:29AM +0200, Frederic Weisbecker wrote:
> At CPU offline time, we make sure to flush any pending wakeup for the
> nocb_gp kthread linked to the outgoing CPU.
> 
> Now we are making sure of that twice:
> 
> 1) From rcu_report_dead() when the outgoing CPU makes the very last
>    local cleanups by itself before switching offline.
> 
> 2) From rcutree_dead_cpu(). Here the offlining CPU has gone and is truly
>    now offline. Another CPU takes care of post-portem cleaning up and
>    check if the offline CPU had pending wakeup.
> 
> Both ways are fine but we have to choose one or the other because we
> don't need to repeat that action. Simply benefit from cache locality
> and keep only the first solution.

But between those two calls, the CPU takes a full pass through the
scheduler and heads into the idle loop.  What if there is a call_rcu()
along the way, and if this was the last online CPU in its rcuog kthread's
group of CPUs?  Wouldn't that callback be stranded until one of those
CPUs came back online?

							Thanx, Paul

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 28f1093027b9..a6b448e6e059 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2469,9 +2469,6 @@ int rcutree_dead_cpu(unsigned int cpu)
>  	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
>  	/* Adjust any no-longer-needed kthreads. */
>  	rcu_boost_kthread_setaffinity(rnp, -1);
> -	/* Do any needed no-CB deferred wakeups from this CPU. */
> -	do_nocb_deferred_wakeup(per_cpu_ptr(&rcu_data, cpu));
> -
>  	// Stop-machine done, so allow nohz_full to disable tick.
>  	tick_dep_clear(TICK_DEP_BIT_RCU);
>  	return 0;
> -- 
> 2.25.1
> 
