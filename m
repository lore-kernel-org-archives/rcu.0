Return-Path: <SRS0=yzHE=6P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D12AC35280
	for <rcu@archiver.kernel.org>; Fri,  1 May 2020 21:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FAEE2166E
	for <rcu@archiver.kernel.org>; Fri,  1 May 2020 21:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588367825;
	bh=gcWqVApgJs+BB978Fby692FvXoFwUlGeY+pFd8nhOMY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=jsDzq+2SUM+qycUPD9FWHCGzpFTpp1dVg/7uS9gE55jt4C2X/9JOicmCJdzS/KrLP
	 yFcAFZEz7j9RfThwmMoigFGYxvoytK9WpQHrd8965p/dAtSzgolZEwObmN9HFnf4GL
	 xayp0ywy1nar5ixeGEwEvz4WsNlJJveWqQIKgEfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgEAVRE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 1 May 2020 17:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAVRE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 1 May 2020 17:17:04 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF8A22073E;
        Fri,  1 May 2020 21:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588367823;
        bh=gcWqVApgJs+BB978Fby692FvXoFwUlGeY+pFd8nhOMY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bH738pactjRZOPIK/6+Eo1lOB7GMdmeQ8itFo5KMUOx6C55Y4n5/hvcRJRpZEhOcy
         oKilnMUoRczmYFwKycghRDoRcQ6yI/ww+82eqziDVZunSRhtiOLvtld0N/34+o9YHA
         l0CK/CfLUvzXsZwSMYH+jOpcKiTG6d74tOAX8VlA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 94DA63522B72; Fri,  1 May 2020 14:17:03 -0700 (PDT)
Date:   Fri, 1 May 2020 14:17:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 08/24] rcu/tree: Use static initializer for krc.lock
Message-ID: <20200501211703.GC7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-9-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428205903.61704-9-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Apr 28, 2020 at 10:58:47PM +0200, Uladzislau Rezki (Sony) wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> The per-CPU variable is initialized at runtime in
> kfree_rcu_batch_init(). This function is invoked before
> 'rcu_scheduler_active' is set to 'RCU_SCHEDULER_RUNNING'.
> After the initialisation, '->initialized' is to true.
> 
> The raw_spin_lock is only acquired if '->initialized' is
> set to true. The worqueue item is only used if 'rcu_scheduler_active'
> set to RCU_SCHEDULER_RUNNING which happens after initialisation.
> 
> Use a static initializer for krc.lock and remove the runtime
> initialisation of the lock. Since the lock can now be always
> acquired, remove the '->initialized' check.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index bc6c2bc8fa32..89e9ca3f4e3e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2892,7 +2892,7 @@ struct kfree_rcu_cpu_work {
>   * @lock: Synchronize access to this structure
>   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
>   * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
> - * @initialized: The @lock and @rcu_work fields have been initialized
> + * @initialized: The @rcu_work fields have been initialized
>   *
>   * This is a per-CPU structure.  The reason that it is not included in
>   * the rcu_data structure is to permit this code to be extracted from
> @@ -2912,7 +2912,9 @@ struct kfree_rcu_cpu {
>  	int count;
>  };
>  
> -static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
> +static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> +	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
> +};
>  
>  static __always_inline void
>  debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
> @@ -2930,10 +2932,9 @@ krc_this_cpu_lock(unsigned long *flags)
>  {
>  	struct kfree_rcu_cpu *krcp;
>  
> -	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
> +	local_irq_save(*flags);	/* For safely calling this_cpu_ptr(). */

And here as well.  ;-)

							Thanx, Paul

>  	krcp = this_cpu_ptr(&krc);
> -	if (likely(krcp->initialized))
> -		raw_spin_lock(&krcp->lock);
> +	raw_spin_lock(&krcp->lock);
>  
>  	return krcp;
>  }
> @@ -2941,8 +2942,7 @@ krc_this_cpu_lock(unsigned long *flags)
>  static inline void
>  krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
>  {
> -	if (likely(krcp->initialized))
> -		raw_spin_unlock(&krcp->lock);
> +	raw_spin_unlock(&krcp->lock);
>  	local_irq_restore(flags);
>  }
>  
> @@ -4168,7 +4168,6 @@ static void __init kfree_rcu_batch_init(void)
>  	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
> -		raw_spin_lock_init(&krcp->lock);
>  		for (i = 0; i < KFREE_N_BATCHES; i++) {
>  			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
>  			krcp->krw_arr[i].krcp = krcp;
> -- 
> 2.20.1
> 
