Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3148DC433E0
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 18:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD085206FA
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 18:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388270AbhATSpL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388578AbhATSl1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Jan 2021 13:41:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57C70233FA;
        Wed, 20 Jan 2021 18:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611168046;
        bh=So2hXsCPM/a1uUQ14gqh3XEUn2Ub67sRlYHmUx5ZBnU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PPGYkJ0O494qAN1VVylHGRuFEgw78KxA6AEpV+jVdxD1iP7SRb8OW3FUwWYE2+kxp
         +P+M98lH66kU0nErafFjuARB+RXT5jS0St/UILGmC0TZ59t6CarVkJeoBoPTw5sWhr
         bglU+5//FcGJm3ZGi3yve2Mo8M+VdEvgk8jP0DLwElsph9xmgUK9O0FECNDpuWc3Xp
         /XWHL2fVMj8y8zqRmHerPhcFqAb1u6onlJYWpRIgrJkTO3Hj6iazIww7T01SNWmgQw
         00/pQpVo0KXxl97SAImC+mtFWMd7Tswp1tlBLFhxU3maLoiiNocuoh0KuszqfaeHZA
         9bDg3jXWwTEzA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 267883522B82; Wed, 20 Jan 2021 10:40:46 -0800 (PST)
Date:   Wed, 20 Jan 2021 10:40:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] kvfree_rcu: Allocate a page for a single argument
Message-ID: <20210120184046.GE2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210120162148.1973-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120162148.1973-1-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 20, 2021 at 05:21:46PM +0100, Uladzislau Rezki (Sony) wrote:
> For a single argument we can directly request a page from a caller
> context when a "carry page block" is run out of free spots. Instead
> of hitting a slow path we can request an extra page by demand and
> proceed with a fast path.
> 
> A single-argument kvfree_rcu() must be invoked in sleepable contexts,
> and that its fallback is the relatively high latency synchronize_rcu().
> Single-argument kvfree_rcu() therefore uses GFP_KERNEL|__GFP_RETRY_MAYFAIL
> to allow limited sleeping within the memory allocator.
> 
> [ paulmck: Add add_ptr_to_bulk_krc_lock header comment per Michal Hocko. ]
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Queued all three for review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 42 ++++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e04e336bee42..2014fb22644d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3465,37 +3465,50 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  	}
>  }
>  
> +// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
> +// state specified by flags.  If can_alloc is true, the caller must
> +// be schedulable and not be holding any locks or mutexes that might be
> +// acquired by the memory allocator or anything that it might invoke.
> +// Returns true if ptr was successfully recorded, else the caller must
> +// use a fallback.
>  static inline bool
> -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> +add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> +	unsigned long *flags, void *ptr, bool can_alloc)
>  {
>  	struct kvfree_rcu_bulk_data *bnode;
>  	int idx;
>  
> -	if (unlikely(!krcp->initialized))
> +	*krcp = krc_this_cpu_lock(flags);
> +	if (unlikely(!(*krcp)->initialized))
>  		return false;
>  
> -	lockdep_assert_held(&krcp->lock);
>  	idx = !!is_vmalloc_addr(ptr);
>  
>  	/* Check if a new block is required. */
> -	if (!krcp->bkvhead[idx] ||
> -			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> -		bnode = get_cached_bnode(krcp);
> -		/* Switch to emergency path. */
> +	if (!(*krcp)->bkvhead[idx] ||
> +			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> +		bnode = get_cached_bnode(*krcp);
> +		if (!bnode && can_alloc) {
> +			krc_this_cpu_unlock(*krcp, *flags);
> +			bnode = (struct kvfree_rcu_bulk_data *)
> +				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> +			*krcp = krc_this_cpu_lock(flags);
> +		}
> +
>  		if (!bnode)
>  			return false;
>  
>  		/* Initialize the new block. */
>  		bnode->nr_records = 0;
> -		bnode->next = krcp->bkvhead[idx];
> +		bnode->next = (*krcp)->bkvhead[idx];
>  
>  		/* Attach it to the head. */
> -		krcp->bkvhead[idx] = bnode;
> +		(*krcp)->bkvhead[idx] = bnode;
>  	}
>  
>  	/* Finally insert. */
> -	krcp->bkvhead[idx]->records
> -		[krcp->bkvhead[idx]->nr_records++] = ptr;
> +	(*krcp)->bkvhead[idx]->records
> +		[(*krcp)->bkvhead[idx]->nr_records++] = ptr;
>  
>  	return true;
>  }
> @@ -3533,8 +3546,6 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		ptr = (unsigned long *) func;
>  	}
>  
> -	krcp = krc_this_cpu_lock(&flags);
> -
>  	// Queue the object but don't yet schedule the batch.
>  	if (debug_rcu_head_queue(ptr)) {
>  		// Probable double kfree_rcu(), just leak.
> @@ -3542,12 +3553,11 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  			  __func__, head);
>  
>  		// Mark as success and leave.
> -		success = true;
> -		goto unlock_return;
> +		return;
>  	}
>  
>  	kasan_record_aux_stack(ptr);
> -	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> +	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
>  	if (!success) {
>  		run_page_cache_worker(krcp);
>  
> -- 
> 2.20.1
> 
