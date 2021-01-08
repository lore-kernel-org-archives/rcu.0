Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4092C433E6
	for <rcu@archiver.kernel.org>; Fri,  8 Jan 2021 13:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6B8239ED
	for <rcu@archiver.kernel.org>; Fri,  8 Jan 2021 13:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbhAHNvX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Jan 2021 08:51:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:40742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbhAHNvW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Jan 2021 08:51:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A9C8ACAF;
        Fri,  8 Jan 2021 13:50:39 +0000 (UTC)
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        ming.lei@redhat.com, axboe@kernel.dk, kernel-team@fb.com
References: <20210106011603.GA13180@paulmck-ThinkPad-P72>
 <20210106011750.13709-1-paulmck@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH mm,percpu_ref,rcu 1/6] mm: Add mem_dump_obj() to print
 source of memory block
Message-ID: <39e1bbd5-2766-d709-d932-bf66d11e244f@suse.cz>
Date:   Fri, 8 Jan 2021 14:50:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210106011750.13709-1-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 1/6/21 2:17 AM, paulmck@kernel.org wrote:
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
> 
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
> [ paulmck: Handle CONFIG_MMU=n case where vmalloc() is kmalloc(). ]
> [ paulmck: Apply Vlastimil Babka feedback on slab.c kmem_provenance(). ]
> [ paulmck: Extract more info from !SLUB_DEBUG per Joonsoo Kim. ]
> Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Some nits below:

> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3635,6 +3635,26 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
>  EXPORT_SYMBOL(__kmalloc_node_track_caller);
>  #endif /* CONFIG_NUMA */
>  
> +void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
> +{
> +	struct kmem_cache *cachep;
> +	unsigned int objnr;
> +	void *objp;
> +
> +	kpp->kp_ptr = object;
> +	kpp->kp_page = page;
> +	cachep = page->slab_cache;
> +	kpp->kp_slab_cache = cachep;
> +	objp = object - obj_offset(cachep);
> +	kpp->kp_data_offset = obj_offset(cachep);
> +	page = virt_to_head_page(objp);

Hm when can this page be different from the "page" we got as function parameter?
I guess only if "object" was so close to the beginning of page that "object -
obj_offset(cachep)" underflowed it. So either "object" pointed to the
padding/redzone, or even below page->s_mem. Both situations sounds like we
should handle them differently than continuing with an unrelated page that's
below our slab page?

> +	objnr = obj_to_index(cachep, page, objp);

Related, this will return bogus value for objp below page->s_mem.
And if our "object" pointer pointed beyond last valid object, this will give us
too large index.


> +	objp = index_to_obj(cachep, page, objnr);

Too large index can cause dbg_userword to be beyond our page.
In SLUB version you have the WARN_ON_ONCE that catches such invalid pointers
(before first valid object or after last valid object) and skips getting the
backtrace for those, so analogical thing should probably be done here?

> +	kpp->kp_objp = objp;
> +	if (DEBUG && cachep->flags & SLAB_STORE_USER)
> +		kpp->kp_ret = *dbg_userword(cachep, objp);
> +}
> +
> diff --git a/mm/slub.c b/mm/slub.c
> index 0c8b43a..3c1a843 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3919,6 +3919,46 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>  	return 0;
>  }
>  
> +void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
> +{
> +	void *base;
> +	int __maybe_unused i;
> +	unsigned int objnr;
> +	void *objp;
> +	void *objp0;
> +	struct kmem_cache *s = page->slab_cache;
> +	struct track __maybe_unused *trackp;
> +
> +	kpp->kp_ptr = object;
> +	kpp->kp_page = page;
> +	kpp->kp_slab_cache = s;
> +	base = page_address(page);
> +	objp0 = kasan_reset_tag(object);
> +#ifdef CONFIG_SLUB_DEBUG
> +	objp = restore_red_left(s, objp0);
> +#else
> +	objp = objp0;
> +#endif
> +	objnr = obj_to_index(s, page, objp);

It would be safer to use objp0 instead of objp here I think. In case "object"
was pointer to the first object's left red zone, then we would not have "objp"
underflow "base" and get a bogus objnr. The WARN_ON_ONCE below could then be
less paranoid? Basically just the "objp >= base + page->objects * s->size"
should be possible if "object" points beyond the last valid object. But
otherwise we should get valid index and thus valid "objp = base + s->size *
objnr;" below, and "objp < base" and "(objp - base) % s->size)" should be
impossible?

Hmm but since it would then be possible to get a negative pointer offset (into
the left padding/redzone), kmem_dump_obj() should calculate and print it as signed?
But it's not obvious if a pointer to left red zone is a pointer that was an
overflow of object N-1 or underflow of object N, and which one to report (unless
it's the very first object). AFAICS your current code will report all as
overflows of object N-1, which is problematic with N=0 (as described above) so
changing it to report underflows of object N would make more sense?

Thanks,
Vlastimil
