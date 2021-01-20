Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF3FC433DB
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 20:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB24221FC
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 20:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbhATUGS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Jan 2021 15:06:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42276 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbhATT66 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Jan 2021 14:58:58 -0500
Date:   Wed, 20 Jan 2021 20:57:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611172677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ArQgUZu3uJpF8dcmWtPBA9d/I3lB0qIBjOwmrqwR5Vo=;
        b=No/hfMoMHm4M3ghg4zS1rFFixxxnD4I/bc8r41okD/e+pj/yVbYmA4FgOGERqWnpxvxFLO
        AifHxdA1M9fd5mIK98lrjlfeIEyq3Z4ACbZXD9rH3dKymCu9lhdvFlHItXiLwzQg9rp+A/
        2+ybjEIdN6eJlQ4A4nW0hzDuq5aiButQs3hAzt8H2kHe5/66Rk9WAez064ilkxeUF8K1SH
        ddCQZAvDw6R6+R5HanfihWidioz//kQIWQXOZcwt4hcihsVEE9v0MFGyOQYoanthlioHUl
        4l2rhbqudcij+a4ViXrXC4TuN1362IB/ByZ/qz6r8uld0sqQec7nvHMKEIAnDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611172677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ArQgUZu3uJpF8dcmWtPBA9d/I3lB0qIBjOwmrqwR5Vo=;
        b=qgx7JoDP8ZdaT8CCIupbzqABOd9h0l0MWsQkpxPKp51haq/jOiU3PIed5SeKGMHSUUyAeU
        033wzGxg9ti2twDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] kvfree_rcu: Allocate a page for a single argument
Message-ID: <20210120195757.3lgjrpvmzjvb2nce@linutronix.de>
References: <20210120162148.1973-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120162148.1973-1-urezki@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2021-01-20 17:21:46 [+0100], Uladzislau Rezki (Sony) wrote:
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

The whole RCU department is getting swamped by the // comments. Can't we
have proper kernel doc and /* */ style comments like the remaining part
of the kernel?

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

There is no need for this cast.

> +				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> +			*krcp = krc_this_cpu_lock(flags);

so if bnode is NULL you could retry get_cached_bnode() since it might
have been filled (given preemption or CPU migration changed something).
Judging from patch #3 you think that a CPU migration is a bad thing. But
why?

Sebastian
