Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B7DC433DB
	for <rcu@archiver.kernel.org>; Tue, 16 Mar 2021 16:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E8C65107
	for <rcu@archiver.kernel.org>; Tue, 16 Mar 2021 16:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhCPQbo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233000AbhCPQbS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Mar 2021 12:31:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B3CA650AD;
        Tue, 16 Mar 2021 16:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615912278;
        bh=ArwLhFGNRtoZoDInVsKUoHhbuCP09SA/wa//ULR0++g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GvzBm3JkyuMSCl3Oa4qgBW+8umKNRy1KIgcjb34q3DP6Ot6yQfBMuxMBQDFoY/SJz
         0CTFep3u+Oek/uKp4T0f9L2zdDdgrm0xzqCVyzyV5myi42a0LzOINw9h6Yh87up3YI
         lixgSmO/28mDs5Vg93bt8PC8fsuqiR8mYo45pmHxMNRXFDKzEoCVTSytlmieXt5WsM
         8BoGtArpwIi0P28bORztcAYhiFdxO+uWZc2maRkgVeLQROS4rc2kAnKosoQeAbBgfN
         tQyzZKxDO7y8APkc85M4eYY6Qee3GZAQVrsw3ISthsgfUjtbijjkeMKNy+Hm48NCBT
         jrTgxQHq3gZnw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BF644352262D; Tue, 16 Mar 2021 09:31:17 -0700 (PDT)
Date:   Tue, 16 Mar 2021 09:31:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Zhang Qiang <qiang.zhang@windriver.com>
Subject: Re: [PATCH v2 1/1] kvfree_rcu: Release a page cache under memory
 pressure
Message-ID: <20210316163117.GU2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210310200757.32331-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310200757.32331-1-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 10, 2021 at 09:07:57PM +0100, Uladzislau Rezki (Sony) wrote:
> From: Zhang Qiang <qiang.zhang@windriver.com>
> 
> Add a drain_page_cache() function to drain a per-cpu page cache.
> The reason behind of it is a system can run into a low memory
> condition, in that case a page shrinker can ask for its users
> to free their caches in order to get extra memory available for
> other needs in a system.
> 
> When a system hits such condition, a page cache is drained for
> all CPUs in a system. Apart of that a page cache work is delayed
> with 5 seconds interval until a memory pressure disappears.

Does this capture it?

------------------------------------------------------------------------

Add a drain_page_cache() function that drains the specified per-cpu
page cache.  This function is invoked on each CPU when the system
enters a low-memory state, that is, when the shrinker invokes
kfree_rcu_shrink_scan().  Thus, when the system is low on memory,
kvfree_rcu() starts taking its slow paths.

In addition, the first subsequent attempt to refill the caches is
delayed for five seconds.

------------------------------------------------------------------------

A few questions below.

							Thanx, Paul

> Co-developed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  kernel/rcu/tree.c | 59 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 2c9cf4df942c..46b8a98ca077 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3163,7 +3163,7 @@ struct kfree_rcu_cpu {
>  	bool initialized;
>  	int count;
>  
> -	struct work_struct page_cache_work;
> +	struct delayed_work page_cache_work;
>  	atomic_t work_in_progress;
>  	struct hrtimer hrtimer;
>  
> @@ -3175,6 +3175,17 @@ static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
>  	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
>  };
>  
> +// A page shrinker can ask for freeing extra pages
> +// to get them available for other needs in a system.
> +// Usually it happens under low memory condition, in
> +// that case hold on a bit with page cache filling.
> +static unsigned long backoff_page_cache_fill;
> +
> +// 5 seconds delay. That is long enough to reduce
> +// an interfering and racing with a shrinker where
> +// the cache is drained.
> +#define PAGE_CACHE_FILL_DELAY (5 * HZ)
> +
>  static __always_inline void
>  debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
>  {
> @@ -3229,6 +3240,26 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
>  
>  }
>  
> +static int
> +drain_page_cache(struct kfree_rcu_cpu *krcp)
> +{
> +	unsigned long flags;
> +	struct llist_node *page_list, *pos, *n;
> +	int freed = 0;
> +
> +	raw_spin_lock_irqsave(&krcp->lock, flags);
> +	page_list = llist_del_all(&krcp->bkvcache);
> +	krcp->nr_bkv_objs = 0;
> +	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> +
> +	llist_for_each_safe(pos, n, page_list) {
> +		free_page((unsigned long)pos);
> +		freed++;
> +	}
> +
> +	return freed;
> +}
> +
>  /*
>   * This function is invoked in workqueue context after a grace period.
>   * It frees all the objects queued on ->bhead_free or ->head_free.
> @@ -3419,7 +3450,7 @@ schedule_page_work_fn(struct hrtimer *t)
>  	struct kfree_rcu_cpu *krcp =
>  		container_of(t, struct kfree_rcu_cpu, hrtimer);
>  
> -	queue_work(system_highpri_wq, &krcp->page_cache_work);
> +	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
>  	return HRTIMER_NORESTART;
>  }
>  
> @@ -3428,7 +3459,7 @@ static void fill_page_cache_func(struct work_struct *work)
>  	struct kvfree_rcu_bulk_data *bnode;
>  	struct kfree_rcu_cpu *krcp =
>  		container_of(work, struct kfree_rcu_cpu,
> -			page_cache_work);
> +			page_cache_work.work);
>  	unsigned long flags;
>  	bool pushed;
>  	int i;
> @@ -3457,10 +3488,14 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  {
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>  			!atomic_xchg(&krcp->work_in_progress, 1)) {
> -		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
> -			HRTIMER_MODE_REL);
> -		krcp->hrtimer.function = schedule_page_work_fn;
> -		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> +		if (xchg(&backoff_page_cache_fill, 0UL)) {

How often can run_page_cache_worker() be invoked?  I am a bit
concerned about the possibility of heavy memory contention on the
backoff_page_cache_fill variable on large systems.  Unless there
is something that sharply bounds the frequency of calls to
run_page_cache_worker(), something like this would be more scalable:

		if (backoff_page_cache_fill &&
		    xchg(&backoff_page_cache_fill, 0UL)) {

It looks to me like all the CPUs could invoke run_page_cache_worker()
at the same time.  Or am I missing something that throttles calls to
run_page_cache_worker(), even on systems with hundreds of CPUs?

Also, if I am reading the code correctly, the unlucky first CPU to
attempt to refill cache after a shrinker invocation would be delayed
five seconds (thus invoking the slow path during that time), but other
CPUs would continue unimpeded.  Is this the intent?

If I understand correctly, the point is to avoid the situation where
memory needed elsewhere is drained and then immediately refilled.
But the code will do the immediate refill when the rest of the CPUs show
up, correct?

Might it be better to put a low cap on the per-CPU caches for some
period of time after the shrinker runs?  Maybe allow at most one page
to be cached for the five seconds following?

> +			queue_delayed_work(system_wq,
> +				&krcp->page_cache_work, PAGE_CACHE_FILL_DELAY);
> +		} else {
> +			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +			krcp->hrtimer.function = schedule_page_work_fn;
> +			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> +		}
>  	}
>  }
>  
> @@ -3612,14 +3647,20 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  {
>  	int cpu;
>  	unsigned long count = 0;
> +	unsigned long flags;
>  
>  	/* Snapshot count of all CPUs */
>  	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		count += READ_ONCE(krcp->count);
> +
> +		raw_spin_lock_irqsave(&krcp->lock, flags);
> +		count += krcp->nr_bkv_objs;
> +		raw_spin_unlock_irqrestore(&krcp->lock, flags);

Not a big deal given that this should not be invoked often, but couldn't
the read from ->nr_bkv_objs be READ_ONCE() without the lock?  (This would
require that updates use WRITE_ONCE() as well.)

>  	}
>  
> +	WRITE_ONCE(backoff_page_cache_fill, 1);
>  	return count;
>  }
>  
> @@ -3634,6 +3675,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		count = krcp->count;
> +		count += drain_page_cache(krcp);
> +
>  		raw_spin_lock_irqsave(&krcp->lock, flags);
>  		if (krcp->monitor_todo)
>  			kfree_rcu_drain_unlock(krcp, flags);
> @@ -4608,7 +4651,7 @@ static void __init kfree_rcu_batch_init(void)
>  		}
>  
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> -		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
> +		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
>  		krcp->initialized = true;
>  	}
>  	if (register_shrinker(&kfree_rcu_shrinker))
> -- 
> 2.20.1
> 
