Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F753C433DB
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 19:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9C223A1C
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 19:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbhAUTbA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Jan 2021 14:31:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbhAUTHU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Jan 2021 14:07:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8DE023A5A;
        Thu, 21 Jan 2021 18:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611255376;
        bh=2Xojm14IB9nPhE0F1jD09AO119Qz7ER3XWRWdlK1oac=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=h1jx/Bkol+Eqmn1yGDHDI3ryPseCSwR/jDuGEOJTqSimQRwD7QNED2RcnGRh1h6aK
         ZwwG7B/JJSWo8XEnhaLO+zRnQ1ag6jeA+s7a8oJu2vJar4zpnvDatQ8oi13rr9Vdnn
         3HUxjl1soOxfwyerFpRrWKY9pkFM5EVusQgtu8jQGHcnGNd4GL/lY60UMZnLwJTzr+
         814mM5jzrjzem9ku9yqhKQQD6ClbFyAdzkwJJiPE3beD406twslKvTCL/vdo7p0rvs
         wN6hpaXI9sZEXisjFk0Ls5vz1h4K2Jek8txVhsL+1DhPRSrVQ504AITKFJHoDxMVKW
         hlrXCE1N8WIkg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 992AA35214EB; Thu, 21 Jan 2021 10:56:15 -0800 (PST)
Date:   Thu, 21 Jan 2021 10:56:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     qiang.zhang@windriver.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH] rcu: Release per-cpu krcp page cache when CPU going
 offline
Message-ID: <20210121185615.GR2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210121064949.16164-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121064949.16164-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 21, 2021 at 02:49:49PM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> If CPUs go offline, the corresponding krcp's page cache can
> not be use util the CPU come back online, or maybe the CPU
> will never go online again, this commit therefore free krcp's
> page cache when CPUs go offline.
> 
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>

Adding Uladzislau on CC for his thoughts.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e04e336bee42..2eaf6f287483 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -158,6 +158,9 @@ static void sync_sched_exp_online_cleanup(int cpu);
>  static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
>  static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
>  
> +static void krc_offline(unsigned int cpu, bool off);
> +static void free_krc_page_cache(int cpu);
> +
>  /* rcuc/rcub kthread realtime priority */
>  static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
>  module_param(kthread_prio, int, 0444);
> @@ -2457,6 +2460,9 @@ int rcutree_dead_cpu(unsigned int cpu)
>  
>  	// Stop-machine done, so allow nohz_full to disable tick.
>  	tick_dep_clear(TICK_DEP_BIT_RCU);
> +
> +	krc_offline(cpu, true);
> +	free_krc_page_cache(cpu);
>  	return 0;
>  }
>  
> @@ -3169,6 +3175,7 @@ struct kfree_rcu_cpu {
>  
>  	struct llist_head bkvcache;
>  	int nr_bkv_objs;
> +	bool offline;
>  };
>  
>  static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> @@ -3220,6 +3227,8 @@ static inline bool
>  put_cached_bnode(struct kfree_rcu_cpu *krcp,
>  	struct kvfree_rcu_bulk_data *bnode)
>  {
> +	if (krcp->offline)
> +		return false;
>  	// Check the limit.
>  	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
>  		return false;
> @@ -3230,6 +3239,39 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
>  
>  }
>  
> +static void krc_offline(unsigned int cpu, bool off)
> +{
> +	unsigned long flags;
> +	struct kfree_rcu_cpu *krcp;
> +
> +	krcp = per_cpu_ptr(&krc, cpu);
> +	raw_spin_lock_irqsave(&krcp->lock, flags);
> +	if (off)
> +		krcp->offline = true;
> +	else
> +		krcp->offline = false;
> +	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> +}
> +
> +static void free_krc_page_cache(int cpu)
> +{
> +	unsigned long flags;
> +	struct kfree_rcu_cpu *krcp;
> +	int i;
> +	struct kvfree_rcu_bulk_data *bnode;
> +
> +	krcp = per_cpu_ptr(&krc, cpu);
> +
> +	for (i = 0; i < rcu_min_cached_objs; i++) {
> +		raw_spin_lock_irqsave(&krcp->lock, flags);
> +		bnode = get_cached_bnode(krcp);
> +		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> +		if (!bnode)
> +			break;
> +		free_page((unsigned long)bnode);
> +	}
> +}
> +
>  /*
>   * This function is invoked in workqueue context after a grace period.
>   * It frees all the objects queued on ->bhead_free or ->head_free.
> @@ -3549,7 +3591,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	kasan_record_aux_stack(ptr);
>  	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
>  	if (!success) {
> -		run_page_cache_worker(krcp);
> +		if (!krcp->offline)
> +			run_page_cache_worker(krcp);
>  
>  		if (head == NULL)
>  			// Inline if kvfree_rcu(one_arg) call.
> @@ -4086,6 +4129,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
>  	rcu_spawn_cpu_nocb_kthread(cpu);
>  	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus + 1);
>  
> +	krc_offline(cpu, false);
>  	return 0;
>  }
>  
> @@ -4591,6 +4635,7 @@ static void __init kfree_rcu_batch_init(void)
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
>  		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
>  		krcp->initialized = true;
> +		krcp->offline = true;
>  	}
>  	if (register_shrinker(&kfree_rcu_shrinker))
>  		pr_err("Failed to register kfree_rcu() shrinker!\n");
> -- 
> 2.29.2
> 
