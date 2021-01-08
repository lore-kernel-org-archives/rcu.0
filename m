Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D231C433E0
	for <rcu@archiver.kernel.org>; Fri,  8 Jan 2021 19:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9B923A79
	for <rcu@archiver.kernel.org>; Fri,  8 Jan 2021 19:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbhAHTmf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:42:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:34282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbhAHTmf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Jan 2021 14:42:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF86CADA2;
        Fri,  8 Jan 2021 19:41:52 +0000 (UTC)
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, ming.lei@redhat.com, axboe@kernel.dk,
        kernel-team@fb.com
References: <20210106011603.GA13180@paulmck-ThinkPad-P72>
 <20210106011750.13709-1-paulmck@kernel.org>
 <39e1bbd5-2766-d709-d932-bf66d11e244f@suse.cz>
 <20210108190142.GU2743@paulmck-ThinkPad-P72>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH mm,percpu_ref,rcu 1/6] mm: Add mem_dump_obj() to print
 source of memory block
Message-ID: <15bbf8db-069b-50f7-051c-449a541ffbe5@suse.cz>
Date:   Fri, 8 Jan 2021 20:41:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210108190142.GU2743@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 1/8/21 8:01 PM, Paul E. McKenney wrote:
> 
> Andrew pushed this to an upstream maintainer, but I have not seen these
> patches appear anywhere.  So if that upstream maintainer was Linus, I can
> send a follow-up patch once we converge.  If the upstream maintainer was
> in fact me, I can of course update the commit directly.  If the upstream
> maintainer was someone else, please let me know who it is.  ;-)
> 
> (Linus does not appear to have pushed anything out since before Andrew's
> email, hence my uncertainty.)

I've wondered about the mm-commits messages too, and concluded that the most probable explanation is that Andrew tried to add your series to mmotm and then tried mmotm merge to linux-next and found out the series is already there via your rcu tree :)
 
>> > --- a/mm/slab.c
>> > +++ b/mm/slab.c
>> > @@ -3635,6 +3635,26 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
>> >  EXPORT_SYMBOL(__kmalloc_node_track_caller);
>> >  #endif /* CONFIG_NUMA */
>> >  
>> > +void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
>> > +{
>> > +	struct kmem_cache *cachep;
>> > +	unsigned int objnr;
>> > +	void *objp;
>> > +
>> > +	kpp->kp_ptr = object;
>> > +	kpp->kp_page = page;
>> > +	cachep = page->slab_cache;
>> > +	kpp->kp_slab_cache = cachep;
>> > +	objp = object - obj_offset(cachep);
>> > +	kpp->kp_data_offset = obj_offset(cachep);
>> > +	page = virt_to_head_page(objp);
>> 
>> Hm when can this page be different from the "page" we got as function parameter?
>> I guess only if "object" was so close to the beginning of page that "object -
>> obj_offset(cachep)" underflowed it. So either "object" pointed to the
>> padding/redzone, or even below page->s_mem. Both situations sounds like we
>> should handle them differently than continuing with an unrelated page that's
>> below our slab page?
> 
> I examined other code to obtain this.  I have been assuming that the
> point was to be able to handle multipage slabs, but I freely confess to
> having no idea.  But I am reluctant to change this sequence unless the
> other code translating from pointer to in-slab object is also changed.

OK, I will check the other code.

>> > +	objnr = obj_to_index(cachep, page, objp);
>> 
>> Related, this will return bogus value for objp below page->s_mem.
>> And if our "object" pointer pointed beyond last valid object, this will give us
>> too large index.
>> 
>> 
>> > +	objp = index_to_obj(cachep, page, objnr);
>> 
>> Too large index can cause dbg_userword to be beyond our page.
>> In SLUB version you have the WARN_ON_ONCE that catches such invalid pointers
>> (before first valid object or after last valid object) and skips getting the
>> backtrace for those, so analogical thing should probably be done here?
> 
> Like this, just before the "objp =" statement?
> 
> 	WARN_ON_ONCE(objnr >= cachep->num);

Yeah, that should do the trick to prevent accessing garbage dbg_userword.

But I wrote the comments about SLAB first and only in the SLUB part I realized
about the larger picture. So now I would consider something like below, which
should find the closest valid object index and resulting pointer offset in
kmem_dump_obj() might become negative. Pointers to padding, below page->s_mem or
beyond last object just become respectively large negative or positive pointer
offsets and we probably don't need to warn for them specially unless we warn
also for all other pointers that are not within the "data area" of the object.

void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
{
        struct kmem_cache *cachep;
        unsigned int objnr;
        void *objp;

        kpp->kp_ptr = object;
        kpp->kp_page = page;
        cachep = page->slab_cache;
        kpp->kp_slab_cache = cachep;
        kpp->kp_data_offset = obj_offset(cachep);
	if (object < page->s_mem)
		objnr = 0;
	else
        	objnr = obj_to_index(cachep, page, object);
	if (objnr >= cachep->num)
		objnr = cachep->num - 1;
        objp = index_to_obj(cachep, page, objnr);
        kpp->kp_objp = objp;
        if (DEBUG && cachep->flags & SLAB_STORE_USER)
                kpp->kp_ret = *dbg_userword(cachep, objp);
}

 
>> > +	kpp->kp_objp = objp;
>> > +	if (DEBUG && cachep->flags & SLAB_STORE_USER)
>> > +		kpp->kp_ret = *dbg_userword(cachep, objp);
>> > +}
>> > +
>> > diff --git a/mm/slub.c b/mm/slub.c
>> > index 0c8b43a..3c1a843 100644
>> > --- a/mm/slub.c
>> > +++ b/mm/slub.c
>> > @@ -3919,6 +3919,46 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>> >  	return 0;
>> >  }
>> >  
>> > +void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
>> > +{
>> > +	void *base;
>> > +	int __maybe_unused i;
>> > +	unsigned int objnr;
>> > +	void *objp;
>> > +	void *objp0;
>> > +	struct kmem_cache *s = page->slab_cache;
>> > +	struct track __maybe_unused *trackp;
>> > +
>> > +	kpp->kp_ptr = object;
>> > +	kpp->kp_page = page;
>> > +	kpp->kp_slab_cache = s;
>> > +	base = page_address(page);
>> > +	objp0 = kasan_reset_tag(object);
>> > +#ifdef CONFIG_SLUB_DEBUG
>> > +	objp = restore_red_left(s, objp0);
>> > +#else
>> > +	objp = objp0;
>> > +#endif
>> > +	objnr = obj_to_index(s, page, objp);
>> 
>> It would be safer to use objp0 instead of objp here I think. In case "object"
>> was pointer to the first object's left red zone, then we would not have "objp"
>> underflow "base" and get a bogus objnr. The WARN_ON_ONCE below could then be
>> less paranoid? Basically just the "objp >= base + page->objects * s->size"
>> should be possible if "object" points beyond the last valid object. But
>> otherwise we should get valid index and thus valid "objp = base + s->size *
>> objnr;" below, and "objp < base" and "(objp - base) % s->size)" should be
>> impossible?
>> 
>> Hmm but since it would then be possible to get a negative pointer offset (into
>> the left padding/redzone), kmem_dump_obj() should calculate and print it as signed?
>> But it's not obvious if a pointer to left red zone is a pointer that was an
>> overflow of object N-1 or underflow of object N, and which one to report (unless
>> it's the very first object). AFAICS your current code will report all as
>> overflows of object N-1, which is problematic with N=0 (as described above) so
>> changing it to report underflows of object N would make more sense?
> 
> Doesn't the "WARN_ON_ONCE(objp < base" further down report underflows?

I don't think it could be possible, could you describe the conditions?

> Or am I missing something subtle here?

A version analogical to the SLAB one above could AFAICS look like this:

...
        kpp->kp_ptr = object;
        kpp->kp_page = page;
        kpp->kp_slab_cache = s;
        base = page_address(page);
        objp0 = kasan_reset_tag(object);
#ifdef CONFIG_SLUB_DEBUG
        objp = restore_red_left(s, objp0);
#else
        objp = objp0;
#endif
        kpp->kp_data_offset = (unsigned long)((char *)objp0 - (char *)objp);
        objnr = obj_to_index(s, page, objp0); // unlike SLAB this can't underflow
	if (objnr >= page->objects)
		objnr = page->objects - 1;
        objp = base + s->size * objnr;
        kpp->kp_objp = objp;
	// no WARN_ON_ONCE() needed, objp has to be valid, we just might have negative
	// offset to it, or a larger than s->size positive offset
#ifdef CONFIG_SLUB_DEBUG
	// etc, no changes below
