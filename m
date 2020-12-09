Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F485C433FE
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 17:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2187E23CD1
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 17:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgLIR3e (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 12:29:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:37150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbgLIR3e (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 12:29:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4027ACF5;
        Wed,  9 Dec 2020 17:28:51 +0000 (UTC)
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, iamjoonsoo.kim@lge.com,
        andrii@kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-1-paulmck@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 sl-b 1/5] mm: Add mem_dump_obj() to print source of
 memory block
Message-ID: <8ea31887-8cc3-24cc-82e8-779290c61c2c@suse.cz>
Date:   Wed, 9 Dec 2020 18:28:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209011303.32737-1-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 12/9/20 2:12 AM, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> There are kernel facilities such as per-CPU reference counts that give
> error messages in generic handlers or callbacks, whose messages are
> unenlightening.  In the case of per-CPU reference-count underflow, this
> is not a problem when creating a new use of this facility because in that
> case the bug is almost certainly in the code implementing that new use.
> However, trouble arises when deploying across many systems, which might
> exercise corner cases that were not seen during development and testing.
> Here, it would be really nice to get some kind of hint as to which of
> several uses the underflow was caused by.
> 
> This commit therefore exposes a mem_dump_obj() function that takes
> a pointer to memory (which must still be allocated if it has been
> dynamically allocated) and prints available information on where that
> memory came from.  This pointer can reference the middle of the block as
> well as the beginning of the block, as needed by things like RCU callback
> functions and timer handlers that might not know where the beginning of
> the memory block is.  These functions and handlers can use mem_dump_obj()
> to print out better hints as to where the problem might lie.

Sounds useful, yeah. It occured to me at least once that we don't have a nice
generic way to print this kind of info. I usually dig it from a crash dump...

> The information printed can depend on kernel configuration.  For example,
> the allocation return address can be printed only for slab and slub,
> and even then only when the necessary debug has been enabled.  For slab,
> build with CONFIG_DEBUG_SLAB=y, and either use sizes with ample space
> to the next power of two or use the SLAB_STORE_USER when creating the
> kmem_cache structure.  For slub, build with CONFIG_SLUB_DEBUG=y and
> boot with slub_debug=U, or pass SLAB_STORE_USER to kmem_cache_create()
> if more focused use is desired.  Also for slub, use CONFIG_STACKTRACE
> to enable printing of the allocation-time stack trace.
> 
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: <linux-mm@kvack.org>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> [ paulmck: Convert to printing and change names per Joonsoo Kim. ]
> [ paulmck: Move slab definition per Stephen Rothwell and kbuild test robot. ]
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

...

> +/**
> + * kmem_valid_obj - does the pointer reference a valid slab object?
> + * @object: pointer to query.
> + *
> + * Return: %true if the pointer is to a not-yet-freed object from
> + * kmalloc() or kmem_cache_alloc(), either %true or %false if the pointer
> + * is to an already-freed object, and %false otherwise.
> + */

It should be possible to find out more about object being free or not, than you
currently do. At least to find out if it's definitely free. When it appears
allocated, it can be actually still free in some kind of e.g. per-cpu or
per-node cache that would be infeasible to check. But that improvement to the
output can be also added later. Also SLUB stores the freeing stacktrace, which
might be useful...

> +bool kmem_valid_obj(void *object)
> +{
> +	struct page *page;
> +
> +	if (!virt_addr_valid(object))
> +		return false;
> +	page = virt_to_head_page(object);
> +	return PageSlab(page);
> +}
> +EXPORT_SYMBOL_GPL(kmem_valid_obj);
> +
> +/**
> + * kmem_dump_obj - Print available slab provenance information
> + * @object: slab object for which to find provenance information.
> + *
> + * This function uses pr_cont(), so that the caller is expected to have
> + * printed out whatever preamble is appropriate.  The provenance information
> + * depends on the type of object and on how much debugging is enabled.
> + * For a slab-cache object, the fact that it is a slab object is printed,
> + * and, if available, the slab name, return address, and stack trace from
> + * the allocation of that object.
> + *
> + * This function will splat if passed a pointer to a non-slab object.
> + * If you are not sure what type of object you have, you should instead
> + * use mem_dump_obj().
> + */
> +void kmem_dump_obj(void *object)
> +{
> +	int i;
> +	struct page *page;
> +	struct kmem_provenance kp;
> +
> +	if (WARN_ON_ONCE(!virt_addr_valid(object)))
> +		return;
> +	page = virt_to_head_page(object);
> +	if (WARN_ON_ONCE(!PageSlab(page))) {
> +		pr_cont(" non-slab memory.\n");
> +		return;
> +	}
> +	kp.kp_ptr = object;
> +	kp.kp_page = page;
> +	kp.kp_nstack = KS_ADDRS_COUNT;
> +	kmem_provenance(&kp);

You don't seem to be printing kp.kp_objp anywhere? (unless in later patch, but
would make sense in this patch already).

> +	if (page->slab_cache)
> +		pr_cont(" slab %s", page->slab_cache->name);
> +	else
> +		pr_cont(" slab ");
> +	if (kp.kp_ret)
> +		pr_cont(" allocated at %pS\n", kp.kp_ret);
> +	else
> +		pr_cont("\n");
> +	if (kp.kp_stack[0]) {
> +		for (i = 0; i < ARRAY_SIZE(kp.kp_stack); i++) {
> +			if (!kp.kp_stack[i])
> +				break;
> +			pr_info("    %pS\n", kp.kp_stack[i]);
> +		}
> +	}
> +}

...

> diff --git a/mm/slub.c b/mm/slub.c
> index b30be23..027fe0f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3918,6 +3918,46 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>  	return 0;
>  }
>  
> +void kmem_provenance(struct kmem_provenance *kpp)
> +{
> +#ifdef CONFIG_SLUB_DEBUG

I'd expect at least the very basic stuff (kp_obj) to be possible to determine
even under !CONFIG_SLUB_DEBUG?

> +	void *base;
> +	int i;
> +	void *object = kpp->kp_ptr;
> +	unsigned int objnr;
> +	void *objp;
> +	struct page *page = kpp->kp_page;
> +	struct kmem_cache *s = page->slab_cache;
> +	struct track *trackp;
> +
> +	base = page_address(page);
> +	objp = kasan_reset_tag(object);
> +	objp = restore_red_left(s, objp);
> +	objnr = obj_to_index(s, page, objp);
> +	objp = base + s->size * objnr;
> +	kpp->kp_objp = objp;
> +	if (WARN_ON_ONCE(objp < base || objp >= base + page->objects * s->size || (objp - base) % s->size) ||
> +	    !(s->flags & SLAB_STORE_USER))
> +		goto nodebug;
> +	trackp = get_track(s, objp, TRACK_ALLOC);
> +	kpp->kp_ret = (void *)trackp->addr;
> +#ifdef CONFIG_STACKTRACE
> +	for (i = 0; i < kpp->kp_nstack && i < TRACK_ADDRS_COUNT; i++) {
> +		kpp->kp_stack[i] = (void *)trackp->addrs[i];
> +		if (!kpp->kp_stack[i])
> +			break;
> +	}
> +#endif
> +	if (kpp->kp_stack && i < kpp->kp_nstack)
> +		kpp->kp_stack[i] = NULL;
> +	return;
> +nodebug:
> +#endif
> +	kpp->kp_ret = NULL;
> +	if (kpp->kp_nstack)
> +		kpp->kp_stack[0] = NULL;
> +}
> +
>  /********************************************************************
>   *		Kmalloc subsystem
>   *******************************************************************/
> diff --git a/mm/util.c b/mm/util.c
> index 4ddb6e1..d0e60d2 100644
> --- a/mm/util.c
> +++ b/mm/util.c

I think mm/debug.c is a better fit as it already has dump_page() of a similar
nature. Also you can call that from from mem_dump_obj() at least in case when
the more specific handlers fail. It will even include page_owner info if enabled! :)

Thanks,
Vlastimil

> @@ -970,3 +970,28 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
>  	kunmap_atomic(addr1);
>  	return ret;
>  }
> +
> +/**
> + * mem_dump_obj - Print available provenance information
> + * @object: object for which to find provenance information.
> + *
> + * This function uses pr_cont(), so that the caller is expected to have
> + * printed out whatever preamble is appropriate.  The provenance information
> + * depends on the type of object and on how much debugging is enabled.
> + * For example, for a slab-cache object, the slab name is printed, and,
> + * if available, the return address and stack trace from the allocation
> + * of that object.
> + */
> +void mem_dump_obj(void *object)
> +{
> +	if (!virt_addr_valid(object)) {
> +		pr_cont(" non-paged (local) memory.\n");
> +		return;
> +	}
> +	if (kmem_valid_obj(object)) {
> +		kmem_dump_obj(object);
> +		return;
> +	}
> +	pr_cont(" non-slab memory.\n");
> +}
> +EXPORT_SYMBOL_GPL(mem_dump_obj);
> 

