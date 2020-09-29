Return-Path: <SRS0=CVHC=DG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D44C4727F
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 12:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91FFB206CD
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 12:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QSXmlLlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgI2MIC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 29 Sep 2020 08:08:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:32784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731232AbgI2MH7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 29 Sep 2020 08:07:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601381277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+E7e9BmznoLWTangQs3/fCDuObjLg3n9HsSYF5tPCY=;
        b=QSXmlLlHtFGfkDHnRvNJNA0fh8V8syNjnREqhSyW7+GYbGyFZm6fRhvPYhMfheHwqWxA6P
        mejsVWf1rFvsfaUy414sZfMmuy7E33fv1PCFQ+MpEHP9sQy+D3DXGiHVCHH+ap5MJ2oa/b
        xD8TCfYdiQ2Y+ma9MnoQ9+Dr8kcElfM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84435ADC5;
        Tue, 29 Sep 2020 12:07:57 +0000 (UTC)
Date:   Tue, 29 Sep 2020 14:07:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 14/15] rcu/tree: Allocate a page when caller
 is preemptible
Message-ID: <20200929120756.GC2277@dhcp22.suse.cz>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
 <20200928233102.24265-14-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928233102.24265-14-paulmck@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon 28-09-20 16:31:01, paulmck@kernel.org wrote:
[...]
> This commit therefore uses preemptible() to determine whether allocation
> is possible at all for double-argument kvfree_rcu().

This deserves a comment. Because GFP_ATOMIC is possible for many
!preemptible() contexts. It is the raw_spin_lock, NMIs and likely few
others that are a problem. You are taking a conservative approach which
is fine but it would be good to articulate that explicitly.

> If !preemptible(),
> then allocation is not possible, and kvfree_rcu() falls back to using
> the less cache-friendly rcu_head approach.  Even when preemptible(),
> the caller might be involved in reclaim, so the GFP_ flags used by
> double-argument kvfree_rcu() must avoid invoking reclaim processing.

Could you be more specific? Is this about being called directly in the
reclaim context and you want to prevent a recursion? If that is the
case, do you really need to special case this in any way? Any memory
reclaim will set PF_MEMALLOC so allocations called from that context
will not perform reclaim. So if you are called from the reclaim directly
then you might want to do GFP_KERNEL | __GFP_NOMEMALLOC | __GFP_NOWARN.
That should handle both from-the-recalim and outside of reclaim contexts
just fine (assuming you don't allocated from !preemptible()) context.

> Note that single-argument kvfree_rcu() must be invoked in sleepable
> contexts, and that its fallback is the relatively high latency
> synchronize_rcu().  Single-argument kvfree_rcu() therefore uses
> GFP_KERNEL|__GFP_RETRY_MAYFAIL to allow limited sleeping within the
> memory allocator.
[...]
>  static inline bool
> -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> +add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> +	unsigned long *flags, void *ptr, bool can_sleep)
>  {
>  	struct kvfree_rcu_bulk_data *bnode;
> +	bool can_alloc_page = preemptible();
> +	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL : GFP_ATOMIC) | __GFP_NOWARN;

This is quite confusing IMHO. At least without a further explanation.
can_sleep is not as much about sleeping as it is about the reclaim
recursion AFAIU your changelog, right?

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
> +	if (!(*krcp)->bkvhead[idx] ||
> +			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> +		bnode = get_cached_bnode(*krcp);
> +		if (!bnode && can_alloc_page) {
> +			krc_this_cpu_unlock(*krcp, *flags);
> +			bnode = kmalloc(PAGE_SIZE, gfp);

What is the point of calling kmalloc  for a PAGE_SIZE object? Wouldn't
using the page allocator directly be better?
-- 
Michal Hocko
SUSE Labs
