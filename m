Return-Path: <SRS0=FT7R=6V=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0F8C38A2A
	for <rcu@archiver.kernel.org>; Thu,  7 May 2020 15:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912A32082E
	for <rcu@archiver.kernel.org>; Thu,  7 May 2020 15:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588866551;
	bh=MJDm3l6QbZdH1hJdtfog8c1MYaTiz8HNDScul7E/cA4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=evZPsLCVIv29O4xKyYPNNXeFHSBtv4bMtAhe1FFKGFTNa0RzSG8XKKrPJ48XkUahR
	 HIIxZkyFsXi8DXuYF8wURKhQofrwMZHYt5+FQFR8CuyFU+98PhjliVTroeI1BCBFJB
	 Tq7E0Ha3c0LyzANdQjBW2UqV0XIe5y2noLzfbD/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgEGPtL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 May 2020 11:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgEGPtL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 May 2020 11:49:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6088420659;
        Thu,  7 May 2020 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588866550;
        bh=MJDm3l6QbZdH1hJdtfog8c1MYaTiz8HNDScul7E/cA4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WW5lrwo75vJsViDkpPtbP7OH4n/PckZizuYNo/yVJgvOun0hEFarqCp0p9B8U/8Xi
         1SAPDBZN7DJSivGt1QTO1puJcbyZyEr3LR3RrHOOx5QLrkMeF7EAR+j2q/2ZHoFVpK
         HMIFEcCszdSaI/27MUkAebytH9oMmCxuCEQ5R96g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 43B6C35231A1; Thu,  7 May 2020 08:49:10 -0700 (PDT)
Date:   Thu, 7 May 2020 08:49:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH RFC tip/core/rcu] Add shrinker to shift to
 fast/inefficient GP mode
Message-ID: <20200507154910.GO2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200507004240.GA9156@paulmck-ThinkPad-P72>
 <20200507093647.11932-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507093647.11932-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 07, 2020 at 05:36:47PM +0800, Hillf Danton wrote:
> 
> Hello Paul
> 
> On Wed, 6 May 2020 17:42:40 Paul E. McKenney wrote:
> > 
> > This commit adds a shrinker so as to inform RCU when memory is scarce.
> 
> A simpler hook is added in the logic of kswapd for subscribing the info
> that memory pressure is high, and then on top of it make rcu a subscriber
> by copying your code for the shrinker, wishing it makes a sense to you.
> 
> What's not yet included is to make the hook per node to help make every
> reviewer convinced that memory is becoming tight. Of course without the
> cost of making subscribers node aware.
> 
> Hillf

I must defer to the MM folks on the MM portion of this patch, but early
warning of impending memory pressure would be extremely good.  A few
RCU-related notes inline below, though.

							Thanx, Paul

> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -49,6 +49,16 @@ static inline void set_max_mapnr(unsigne
>  static inline void set_max_mapnr(unsigned long limit) { }
>  #endif
>  
> +/* subscriber of kswapd's memory_pressure_high signal */
> +struct mph_subscriber {
> +	struct list_head node;
> +	void (*info) (void *data);
> +	void *data;
> +};
> +
> +int mph_subscribe(struct mph_subscriber *ms);
> +void mph_unsubscribe(struct mph_subscriber *ms);
> +
>  extern atomic_long_t _totalram_pages;
>  static inline unsigned long totalram_pages(void)
>  {
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3536,6 +3536,40 @@ static bool kswapd_shrink_node(pg_data_t
>  }
>  
>  /*
> + * subscribers of kswapd's signal that memory pressure is high
> + */
> +static LIST_HEAD(mph_subs);
> +static DEFINE_MUTEX(mph_lock);
> +
> +int mph_subscribe(struct mph_subscriber *ms)
> +{
> +	if (!ms->info)
> +		return -EAGAIN;
> +
> +	mutex_lock(&mph_lock);
> +	list_add_tail(&ms->node, &mph_subs);
> +	mutex_unlock(&mph_lock);
> +	return 0;
> +}
> +
> +void mph_unsubscribe(struct mph_subscriber *ms)
> +{
> +	mutex_lock(&mph_lock);
> +	list_del(&ms->node);
> +	mutex_unlock(&mph_lock);
> +}
> +
> +static void kswapd_bbc_mph(void)
> +{
> +	struct mph_subscriber *ms;
> +
> +	mutex_lock(&mph_lock);
> +	list_for_each_entry(ms, &mph_subs, node)
> +		ms->info(ms->data);
> +	mutex_unlock(&mph_lock);
> +}
> +
> +/*
>   * For kswapd, balance_pgdat() will reclaim pages across a node from zones
>   * that are eligible for use by the caller until at least one zone is
>   * balanced.
> @@ -3663,8 +3697,11 @@ restart:
>  		 * If we're getting trouble reclaiming, start doing writepage
>  		 * even in laptop mode.
>  		 */
> -		if (sc.priority < DEF_PRIORITY - 2)
> +		if (sc.priority < DEF_PRIORITY - 2) {
>  			sc.may_writepage = 1;
> +			if (sc.priority == DEF_PRIORITY - 3)
> +				kswapd_bbc_mph();
> +		}
>  
>  		/* Call soft limit reclaim before calling shrink_node. */
>  		sc.nr_scanned = 0;
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -325,6 +325,8 @@ struct rcu_state {
>  	int ncpus_snap;				/* # CPUs seen last time. */
>  	u8 cbovld;				/* Callback overload now? */
>  	u8 cbovldnext;				/* ^        ^  next time? */
> +	u8 mph;					/* mm pressure high signal from kswapd */
> +	unsigned long mph_end;			/* time stamp in jiffies */
>  
>  	unsigned long jiffies_force_qs;		/* Time at which to invoke */
>  						/*  force_quiescent_state(). */
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -52,6 +52,7 @@
>  #include <linux/kprobes.h>
>  #include <linux/gfp.h>
>  #include <linux/oom.h>
> +#include <linux/mm.h>
>  #include <linux/smpboot.h>
>  #include <linux/jiffies.h>
>  #include <linux/slab.h>
> @@ -2314,8 +2315,15 @@ static void force_qs_rnp(int (*f)(struct
>  	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
>  
> -	rcu_state.cbovld = rcu_state.cbovldnext;
> +	rcu_state.cbovld = smp_load_acquire(&rcu_state.mph) ||
> +					rcu_state.cbovldnext;
>  	rcu_state.cbovldnext = false;
> +
> +	if (READ_ONCE(rcu_state.mph) &&
> +	    time_after(jiffies, READ_ONCE(rcu_state.mph_end))) {
> +		WRITE_ONCE(rcu_state.mph, false);
> +		pr_info("%s: Ending OOM-mode grace periods.\n", __func__);
> +	}
>  	rcu_for_each_leaf_node(rnp) {
>  		cond_resched_tasks_rcu_qs();
>  		mask = 0;
> @@ -2643,6 +2651,20 @@ static void check_cb_ovld(struct rcu_dat
>  	raw_spin_unlock_rcu_node(rnp);
>  }
>  
> +static void rcu_mph_info(void *data)

This pointer will always be &rcu_state, so why not ignore the pointer
and use "rcu_state" below?

RCU grace periods are inherently global, so I don't know of any way
for RCU to focus on a given NUMA node.  All or nothing.  But on the
other hand, speeding up RCU grace periods will also help specific
NUMA nodes, so I believe that it is all good.

> +{
> +	struct rcu_state *state = data;
> +
> +	WRITE_ONCE(state->mph_end, jiffies + HZ / 10);
> +	smp_store_release(&state->mph, true);
> +	rcu_force_quiescent_state();
> +}
> +
> +static struct mph_subscriber rcu_mph_subscriber = {
> +	.info = rcu_mph_info,
> +	.data = &rcu_state,

Then this ".data" entry can be omitted, correct?

> +};
> +
>  /* Helper function for call_rcu() and friends.  */
>  static void
>  __call_rcu(struct rcu_head *head, rcu_callback_t func)
> @@ -4036,6 +4058,8 @@ void __init rcu_init(void)
>  		qovld_calc = DEFAULT_RCU_QOVLD_MULT * qhimark;
>  	else
>  		qovld_calc = qovld;
> +
> +	mph_subscribe(&rcu_mph_subscriber);
>  }
>  
>  #include "tree_stall.h"
> 
