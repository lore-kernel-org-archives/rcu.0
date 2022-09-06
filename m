Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC04ECAAA1
	for <rcu@archiver.kernel.org>; Tue,  6 Sep 2022 17:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiIFRbb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Sep 2022 13:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiIFRat (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Sep 2022 13:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9B025C7D
        for <rcu@vger.kernel.org>; Tue,  6 Sep 2022 10:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40D47615EB
        for <rcu@vger.kernel.org>; Tue,  6 Sep 2022 17:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12239C433D6;
        Tue,  6 Sep 2022 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662485088;
        bh=ZrAFe3xE9PO2pfUl2Dt5wpvYSOPtobToO/tk65CCqb4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CU5MvHwlQb3m5J+end7fBn/dCEWVNqDxzHX65S2K8P6fNDU4nU4Cpbp/jSiaPf5VY
         g2vUvc42Np+c4JxVVdNadv71bHs6xnG3tir416Z+9uz6Hwg9EdmhczFUbj/0e9qWpK
         t33dSgxHETQRfmgYQSODgMBk7iDunSOl4k4Wsct5puoOvrEit4nGpFg4ImPfFaL/dF
         rib7b7SIXfhjPvx9+UTlJbOeg8nmD+m8dJaXxBarOocUWJxl9YNdWpLw1AHjjM1/Zt
         GTbWfAwK4IYCnfUFisBNsQT+DUJQPsi5GFRWfAnengHVPGM0YXADL01yWr+059zNKh
         QDQCZPbmnluVA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 08E5E5C0834; Tue,  6 Sep 2022 10:24:41 -0700 (PDT)
Date:   Tue, 6 Sep 2022 10:24:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 1/3] rcu: remove redundant cpu affinity setting during
 teardown
Message-ID: <20220906172441.GY4315@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220905033852.18988-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905033852.18988-1-kernelfans@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 05, 2022 at 11:38:50AM +0800, Pingfan Liu wrote:
> At present, during the cpu teardown, rcu_boost_kthread_setaffinity() is
> called twice. Firstly by rcutree_offline_cpu(), then by
> rcutree_dead_cpu() as the CPUHP_RCUTREE_PREP  cpuhp_step callback.
> 
> >From the scheduler's perspective, a bit in cpu_online_mask means that the cpu
> is visible to the scheduler. Furthermore, a bit in cpu_active_mask
> means that the cpu is suitable as a migration destination.
> 
> Now turning back to the case in rcu offlining. sched_cpu_deactivate()
> has disabled the dying cpu as the migration destination before
> rcutree_offline_cpu().  Furthermore, if the boost kthread is on the dying
> cpu, it will be migrated to another suitable online cpu by the scheduler.
> So the affinity setting by rcutree_offline_cpu() is redundant and can be
> eliminated.
> 
> Besides, this patch does an trival code rearrangement by unfolding
> rcutree_affinity_setting() into rcutree_online_cpu(), considering that
> the latter one is the only user of the former.
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
>  kernel/rcu/tree.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 79aea7df4345..b90f6487fd45 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3978,16 +3978,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> -/*
> - * Update RCU priority boot kthread affinity for CPU-hotplug changes.
> - */
> -static void rcutree_affinity_setting(unsigned int cpu, int outgoing)
> -{
> -	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> -
> -	rcu_boost_kthread_setaffinity(rdp->mynode, outgoing);
> -}

Good point, tiven how simple a wrapper this is and how little it is used,
getting rid of it does sound like a reasonable idea.

>  /*
>   * Near the end of the CPU-online process.  Pretty much all services
>   * enabled, and the CPU is now very much alive.
> @@ -4006,7 +3996,7 @@ int rcutree_online_cpu(unsigned int cpu)
>  	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
>  		return 0; /* Too early in boot for scheduler work. */
>  	sync_sched_exp_online_cleanup(cpu);
> -	rcutree_affinity_setting(cpu, -1);
> +	rcu_boost_kthread_setaffinity(rdp->mynode, -1);
>  
>  	// Stop-machine done, so allow nohz_full to disable tick.
>  	tick_dep_clear(TICK_DEP_BIT_RCU);
> @@ -4029,8 +4019,6 @@ int rcutree_offline_cpu(unsigned int cpu)
>  	rnp->ffmask &= ~rdp->grpmask;
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  
> -	rcutree_affinity_setting(cpu, cpu);

We do need to keep this one because the CPU is going away.

One the other hand, it might well be that we could get rid of the call
to rcutree_affinity_setting() in rcutree_dead_cpu().

Or am I missing something subtle here?

							Thanx, Paul

> -
>  	// nohz_full CPUs need the tick for stop-machine to work quickly
>  	tick_dep_set(TICK_DEP_BIT_RCU);
>  	return 0;
> -- 
> 2.31.1
> 
