Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375C2C433E0
	for <rcu@archiver.kernel.org>; Fri,  8 Jan 2021 19:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D922D23A82
	for <rcu@archiver.kernel.org>; Fri,  8 Jan 2021 19:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbhAHTCY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbhAHTCY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Jan 2021 14:02:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEF5323A81;
        Fri,  8 Jan 2021 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610132503;
        bh=pWUEBRh7sYof8Q1tl+Bw+4t8KiDrI5wdHCQznPOWUNo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=A2w67v/mXJaBIxwfyRo/UNskDjHqFUPkTx0omKoT50JT71cP/1zBeUmGgx3aYiwiu
         UcmF7m1yP9E79GRUtBoCRjWwYYwGGumHuGbKjWGujFn1Izewu/WHP/lfyHRMFEN583
         jxrpOmEomBWOtHKLIlZHD30E3yZA+3+C/cVLq7T/HkG/yMlKFhTIk74e954zLz6/Wn
         BGwAAMJh6mrDP5VVyM+81H3VKNv9aus+S0aQftlCJ6Iih8WokPkPZzFLUme5XcKbeS
         v6g9dNx3EE3vOVkE9Gbba/V/sS2vjBNgSHs1eAfA7FtfAdoMqdLwomvFdlOfAjqBxL
         1nWyfB83vDHPQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B4C3135226D5; Fri,  8 Jan 2021 11:01:42 -0800 (PST)
Date:   Fri, 8 Jan 2021 11:01:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, ming.lei@redhat.com, axboe@kernel.dk,
        kernel-team@fb.com
Subject: Re: [PATCH mm,percpu_ref,rcu 1/6] mm: Add mem_dump_obj() to print
 source of memory block
Message-ID: <20210108190142.GU2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106011603.GA13180@paulmck-ThinkPad-P72>
 <20210106011750.13709-1-paulmck@kernel.org>
 <39e1bbd5-2766-d709-d932-bf66d11e244f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39e1bbd5-2766-d709-d932-bf66d11e244f@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 08, 2021 at 02:50:35PM +0100, Vlastimil Babka wrote:
> On 1/6/21 2:17 AM, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > There are kernel facilities such as per-CPU reference counts that give
> > error messages in generic handlers or callbacks, whose messages are
> > unenlightening.  In the case of per-CPU reference-count underflow, this
> > is not a problem when creating a new use of this facility because in that
> > case the bug is almost certainly in the code implementing that new use.
> > However, trouble arises when deploying across many systems, which might
> > exercise corner cases that were not seen during development and testing.
> > Here, it would be really nice to get some kind of hint as to which of
> > several uses the underflow was caused by.
> > 
> > This commit therefore exposes a mem_dump_obj() function that takes
> > a pointer to memory (which must still be allocated if it has been
> > dynamically allocated) and prints available information on where that
> > memory came from.  This pointer can reference the middle of the block as
> > well as the beginning of the block, as needed by things like RCU callback
> > functions and timer handlers that might not know where the beginning of
> > the memory block is.  These functions and handlers can use mem_dump_obj()
> > to print out better hints as to where the problem might lie.
> > 
> > The information printed can depend on kernel configuration.  For example,
> > the allocation return address can be printed only for slab and slub,
> > and even then only when the necessary debug has been enabled.  For slab,
> > build with CONFIG_DEBUG_SLAB=y, and either use sizes with ample space
> > to the next power of two or use the SLAB_STORE_USER when creating the
> > kmem_cache structure.  For slub, build with CONFIG_SLUB_DEBUG=y and
> > boot with slub_debug=U, or pass SLAB_STORE_USER to kmem_cache_create()
> > if more focused use is desired.  Also for slub, use CONFIG_STACKTRACE
> > to enable printing of the allocation-time stack trace.
> > 
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: <linux-mm@kvack.org>
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > [ paulmck: Convert to printing and change names per Joonsoo Kim. ]
> > [ paulmck: Move slab definition per Stephen Rothwell and kbuild test robot. ]
> > [ paulmck: Handle CONFIG_MMU=n case where vmalloc() is kmalloc(). ]
> > [ paulmck: Apply Vlastimil Babka feedback on slab.c kmem_provenance(). ]
> > [ paulmck: Extract more info from !SLUB_DEBUG per Joonsoo Kim. ]
> > Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thank you for the review and comments!

> Some nits below:

Andrew pushed this to an upstream maintainer, but I have not seen these
patches appear anywhere.  So if that upstream maintainer was Linus, I can
send a follow-up patch once we converge.  If the upstream maintainer was
in fact me, I can of course update the commit directly.  If the upstream
maintainer was someone else, please let me know who it is.  ;-)

(Linus does not appear to have pushed anything out since before Andrew's
email, hence my uncertainty.)

> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -3635,6 +3635,26 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
> >  EXPORT_SYMBOL(__kmalloc_node_track_caller);
> >  #endif /* CONFIG_NUMA */
> >  
> > +void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
> > +{
> > +	struct kmem_cache *cachep;
> > +	unsigned int objnr;
> > +	void *objp;
> > +
> > +	kpp->kp_ptr = object;
> > +	kpp->kp_page = page;
> > +	cachep = page->slab_cache;
> > +	kpp->kp_slab_cache = cachep;
> > +	objp = object - obj_offset(cachep);
> > +	kpp->kp_data_offset = obj_offset(cachep);
> > +	page = virt_to_head_page(objp);
> 
> Hm when can this page be different from the "page" we got as function parameter?
> I guess only if "object" was so close to the beginning of page that "object -
> obj_offset(cachep)" underflowed it. So either "object" pointed to the
> padding/redzone, or even below page->s_mem. Both situations sounds like we
> should handle them differently than continuing with an unrelated page that's
> below our slab page?

I examined other code to obtain this.  I have been assuming that the
point was to be able to handle multipage slabs, but I freely confess to
having no idea.  But I am reluctant to change this sequence unless the
other code translating from pointer to in-slab object is also changed.

> > +	objnr = obj_to_index(cachep, page, objp);
> 
> Related, this will return bogus value for objp below page->s_mem.
> And if our "object" pointer pointed beyond last valid object, this will give us
> too large index.
> 
> 
> > +	objp = index_to_obj(cachep, page, objnr);
> 
> Too large index can cause dbg_userword to be beyond our page.
> In SLUB version you have the WARN_ON_ONCE that catches such invalid pointers
> (before first valid object or after last valid object) and skips getting the
> backtrace for those, so analogical thing should probably be done here?

Like this, just before the "objp =" statement?

	WARN_ON_ONCE(objnr >= cachep->num);

> > +	kpp->kp_objp = objp;
> > +	if (DEBUG && cachep->flags & SLAB_STORE_USER)
> > +		kpp->kp_ret = *dbg_userword(cachep, objp);
> > +}
> > +
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 0c8b43a..3c1a843 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3919,6 +3919,46 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
> >  	return 0;
> >  }
> >  
> > +void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
> > +{
> > +	void *base;
> > +	int __maybe_unused i;
> > +	unsigned int objnr;
> > +	void *objp;
> > +	void *objp0;
> > +	struct kmem_cache *s = page->slab_cache;
> > +	struct track __maybe_unused *trackp;
> > +
> > +	kpp->kp_ptr = object;
> > +	kpp->kp_page = page;
> > +	kpp->kp_slab_cache = s;
> > +	base = page_address(page);
> > +	objp0 = kasan_reset_tag(object);
> > +#ifdef CONFIG_SLUB_DEBUG
> > +	objp = restore_red_left(s, objp0);
> > +#else
> > +	objp = objp0;
> > +#endif
> > +	objnr = obj_to_index(s, page, objp);
> 
> It would be safer to use objp0 instead of objp here I think. In case "object"
> was pointer to the first object's left red zone, then we would not have "objp"
> underflow "base" and get a bogus objnr. The WARN_ON_ONCE below could then be
> less paranoid? Basically just the "objp >= base + page->objects * s->size"
> should be possible if "object" points beyond the last valid object. But
> otherwise we should get valid index and thus valid "objp = base + s->size *
> objnr;" below, and "objp < base" and "(objp - base) % s->size)" should be
> impossible?
> 
> Hmm but since it would then be possible to get a negative pointer offset (into
> the left padding/redzone), kmem_dump_obj() should calculate and print it as signed?
> But it's not obvious if a pointer to left red zone is a pointer that was an
> overflow of object N-1 or underflow of object N, and which one to report (unless
> it's the very first object). AFAICS your current code will report all as
> overflows of object N-1, which is problematic with N=0 (as described above) so
> changing it to report underflows of object N would make more sense?

Doesn't the "WARN_ON_ONCE(objp < base" further down report underflows?
Or am I missing something subtle here?

							Thanx, Paul
