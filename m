Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03533C2D0A3
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 15:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46DC22280
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 15:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="abm0hmkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgKCPr0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgKCPr0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 10:47:26 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F251C0617A6
        for <rcu@vger.kernel.org>; Tue,  3 Nov 2020 07:47:26 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id r7so15070071qkf.3
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2020 07:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FxIdEvKslGYou6uHwb3y47uEgNWUxE32h5p7W2Jkl6o=;
        b=abm0hmkt6aEh9QZIwFkoNC1HZ+ku03wlEFRPlovuAO3DmMdYQu54Efo23IL0rYtSID
         gjvRUisPz9Qlr3baLP1hHSd2YbAGoq7N7QwqYBoznVbxkBwgBYWEjXKoFh6SyPLMkl5g
         WntDvMVIg6F/x6FxFd6GpscZik1H/tBMDMRks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FxIdEvKslGYou6uHwb3y47uEgNWUxE32h5p7W2Jkl6o=;
        b=swi1q8YqncGU21Ii7/1M3WmK1GR2826GoK5swqDsFYC4aODR7zm19khQ68MCRkW0+N
         o5ZsN0jAC2hNqXY7ydgUk5T8UwyYvxLVjF/xytLlP33tMzgetCkkhEHQ+3k+eqa1dxqD
         tsq9DURRJ9uVZk+5XyA5TemS1VoR7xAch0BkxKvPVj01N+aZ4gCsZRTh6ggT05DrdjGh
         rxvRSxsQCK4tziugPDUuFkgNSNt5xNYFbNibiKKqpN8erEpgC3HnK5Xee3Vn/QKBdUTA
         cpMtktiJlBQxHMkZytGNJI/jnFhYm/U1G8mV1+gxEzM2jbE23Wwf0CgXHAaxP1djwvo8
         OThg==
X-Gm-Message-State: AOAM5338QAMmQiAfakpYRJudwkc25Q/g8FGYZltsrfL5NTUG2mXveuT9
        U04gVkY1/zKQt75Sr6ammnghGQ==
X-Google-Smtp-Source: ABdhPJyW75mNHsMz8wYn6g3Du4ySSK3+aWX/U8M/uITZCDlr1QQl9Hm5KVE5JLeJthDIal9YTnROzw==
X-Received: by 2002:a37:849:: with SMTP id 70mr20751283qki.332.1604418445075;
        Tue, 03 Nov 2020 07:47:25 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id a3sm10464581qtp.63.2020.11.03.07.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:47:24 -0800 (PST)
Date:   Tue, 3 Nov 2020 10:47:23 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        willy@infradead.org
Subject: Re: [PATCH 01/16] rcu/tree: Add a work to allocate pages from
 regular context
Message-ID: <20201103154723.GA1310511@google.com>
References: <20201029165019.14218-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029165019.14218-1-urezki@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 29, 2020 at 05:50:04PM +0100, Uladzislau Rezki (Sony) wrote:
> The current memmory-allocation interface presents to following
> difficulties that this patch is designed to overcome:
> 
> a) If built with CONFIG_PROVE_RAW_LOCK_NESTING, the lockdep will
>    complain about violation("BUG: Invalid wait context") of the
>    nesting rules. It does the raw_spinlock vs. spinlock nesting
>    checks, i.e. it is not legal to acquire a spinlock_t while
>    holding a raw_spinlock_t.
> 
>    Internally the kfree_rcu() uses raw_spinlock_t whereas the
>    "page allocator" internally deals with spinlock_t to access
>    to its zones. The code also can be broken from higher level
>    of view:
>    <snip>
>        raw_spin_lock(&some_lock);
>        kfree_rcu(some_pointer, some_field_offset);
>    <snip>
> 
> b) If built with CONFIG_PREEMPT_RT. Please note, in that case spinlock_t
>    is converted into sleepable variant. Invoking the page allocator from
>    atomic contexts leads to "BUG: scheduling while atomic".
> 
> c) call_rcu() is invoked from raw atomic context and kfree_rcu()
>    and kvfree_rcu() are expected to be called from atomic raw context
>    as well.
> 
> Move out a page allocation from contexts which trigger kvfree_rcu()
> function to the separate worker. When a k[v]free_rcu() per-cpu page
> cache is empty a fallback mechanism is used and a special job is
> scheduled to refill the per-cpu cache.

Looks good, still reviewing here. BTW just for my education, I was wondering
about Thomas's email:
https://lkml.org/lkml/2020/8/11/939

If slab allocations in pure raw-atomic context on RT is not allowed or
recommended, should kfree_rcu() be allowed?
slab can have same issue right? If per-cpu cache is drained, it has to
allocate page from buddy allocator and there's no GFP flag to tell it about
context where alloc is happening from.

Or are we saying that we want to support kfree on RT from raw atomic atomic
context, even though kmalloc is not supported? I hate to bring up this
elephant in the room, but since I am a part of the people maintaining this
code, I believe I would rather set some rules than supporting unsupported
usages. :-\ (Once I know what is supported and what isn't that is). If indeed
raw atomic kfree_rcu() is a bogus use case because of -RT, then we ought to
put a giant warning than supporting it :-(.

But I don't stand in the way of this patch if all agree on it. thanks,

 - Joel


> Link: https://lore.kernel.org/lkml/20200630164543.4mdcf6zb4zfclhln@linutronix.de/
> Fixes: 3042f83f19be ("rcu: Support reclaim for head-less object")
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 109 ++++++++++++++++++++++++++++------------------
>  1 file changed, 66 insertions(+), 43 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 06895ef85d69..f2da2a1cc716 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -177,7 +177,7 @@ module_param(rcu_unlock_delay, int, 0444);
>   * per-CPU. Object size is equal to one page. This value
>   * can be changed at boot time.
>   */
> -static int rcu_min_cached_objs = 2;
> +static int rcu_min_cached_objs = 5;
>  module_param(rcu_min_cached_objs, int, 0444);
>  
>  /* Retrieve RCU kthreads priority for rcutorture */
> @@ -3084,6 +3084,9 @@ struct kfree_rcu_cpu_work {
>   *	In order to save some per-cpu space the list is singular.
>   *	Even though it is lockless an access has to be protected by the
>   *	per-cpu lock.
> + * @page_cache_work: A work to refill the cache when it is empty
> + * @work_in_progress: Indicates that page_cache_work is running
> + * @hrtimer: A hrtimer for scheduling a page_cache_work
>   * @nr_bkv_objs: number of allocated objects at @bkvcache.
>   *
>   * This is a per-CPU structure.  The reason that it is not included in
> @@ -3100,6 +3103,11 @@ struct kfree_rcu_cpu {
>  	bool monitor_todo;
>  	bool initialized;
>  	int count;
> +
> +	struct work_struct page_cache_work;
> +	atomic_t work_in_progress;
> +	struct hrtimer hrtimer;
> +
>  	struct llist_head bkvcache;
>  	int nr_bkv_objs;
>  };
> @@ -3217,10 +3225,10 @@ static void kfree_rcu_work(struct work_struct *work)
>  			}
>  			rcu_lock_release(&rcu_callback_map);
>  
> -			krcp = krc_this_cpu_lock(&flags);
> +			raw_spin_lock_irqsave(&krcp->lock, flags);
>  			if (put_cached_bnode(krcp, bkvhead[i]))
>  				bkvhead[i] = NULL;
> -			krc_this_cpu_unlock(krcp, flags);
> +			raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  
>  			if (bkvhead[i])
>  				free_page((unsigned long) bkvhead[i]);
> @@ -3347,6 +3355,57 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  		raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  }
>  
> +static enum hrtimer_restart
> +schedule_page_work_fn(struct hrtimer *t)
> +{
> +	struct kfree_rcu_cpu *krcp =
> +		container_of(t, struct kfree_rcu_cpu, hrtimer);
> +
> +	queue_work(system_highpri_wq, &krcp->page_cache_work);
> +	return HRTIMER_NORESTART;
> +}
> +
> +static void fill_page_cache_func(struct work_struct *work)
> +{
> +	struct kvfree_rcu_bulk_data *bnode;
> +	struct kfree_rcu_cpu *krcp =
> +		container_of(work, struct kfree_rcu_cpu,
> +			page_cache_work);
> +	unsigned long flags;
> +	bool pushed;
> +	int i;
> +
> +	for (i = 0; i < rcu_min_cached_objs; i++) {
> +		bnode = (struct kvfree_rcu_bulk_data *)
> +			__get_free_page(GFP_KERNEL | __GFP_NOWARN);
> +
> +		if (bnode) {
> +			raw_spin_lock_irqsave(&krcp->lock, flags);
> +			pushed = put_cached_bnode(krcp, bnode);
> +			raw_spin_unlock_irqrestore(&krcp->lock, flags);
> +
> +			if (!pushed) {
> +				free_page((unsigned long) bnode);
> +				break;
> +			}
> +		}
> +	}
> +
> +	atomic_set(&krcp->work_in_progress, 0);
> +}
> +
> +static void
> +run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> +{
> +	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> +			!atomic_xchg(&krcp->work_in_progress, 1)) {
> +		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
> +			HRTIMER_MODE_REL);
> +		krcp->hrtimer.function = schedule_page_work_fn;
> +		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> +	}
> +}
> +
>  static inline bool
>  kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
>  {
> @@ -3363,32 +3422,8 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
>  	if (!krcp->bkvhead[idx] ||
>  			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
>  		bnode = get_cached_bnode(krcp);
> -		if (!bnode) {
> -			/*
> -			 * To keep this path working on raw non-preemptible
> -			 * sections, prevent the optional entry into the
> -			 * allocator as it uses sleeping locks. In fact, even
> -			 * if the caller of kfree_rcu() is preemptible, this
> -			 * path still is not, as krcp->lock is a raw spinlock.
> -			 * With additional page pre-allocation in the works,
> -			 * hitting this return is going to be much less likely.
> -			 */
> -			if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -				return false;
> -
> -			/*
> -			 * NOTE: For one argument of kvfree_rcu() we can
> -			 * drop the lock and get the page in sleepable
> -			 * context. That would allow to maintain an array
> -			 * for the CONFIG_PREEMPT_RT as well if no cached
> -			 * pages are available.
> -			 */
> -			bnode = (struct kvfree_rcu_bulk_data *)
> -				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> -		}
> -
>  		/* Switch to emergency path. */
> -		if (unlikely(!bnode))
> +		if (!bnode)
>  			return false;
>  
>  		/* Initialize the new block. */
> @@ -3452,12 +3487,10 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		goto unlock_return;
>  	}
>  
> -	/*
> -	 * Under high memory pressure GFP_NOWAIT can fail,
> -	 * in that case the emergency path is maintained.
> -	 */
>  	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
>  	if (!success) {
> +		run_page_cache_worker(krcp);
> +
>  		if (head == NULL)
>  			// Inline if kvfree_rcu(one_arg) call.
>  			goto unlock_return;
> @@ -4449,24 +4482,14 @@ static void __init kfree_rcu_batch_init(void)
>  
>  	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> -		struct kvfree_rcu_bulk_data *bnode;
>  
>  		for (i = 0; i < KFREE_N_BATCHES; i++) {
>  			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
>  			krcp->krw_arr[i].krcp = krcp;
>  		}
>  
> -		for (i = 0; i < rcu_min_cached_objs; i++) {
> -			bnode = (struct kvfree_rcu_bulk_data *)
> -				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> -
> -			if (bnode)
> -				put_cached_bnode(krcp, bnode);
> -			else
> -				pr_err("Failed to preallocate for %d CPU!\n", cpu);
> -		}
> -
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> +		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
>  		krcp->initialized = true;
>  	}
>  	if (register_shrinker(&kfree_rcu_shrinker))
> -- 
> 2.20.1
> 
