Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE28C433FE
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 23:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F6323C8F
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 23:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgLJXmQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Dec 2020 18:42:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgLJXlt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Dec 2020 18:41:49 -0500
Date:   Thu, 10 Dec 2020 15:41:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607643667;
        bh=T74Q9jvs/sckmi9KqMrt+7jmmct3zNsYKVoFqXDZLY4=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uZMrbJs4RGwuDtw6procTQ6WhDExk3Sdt5vRjURT1D5vGzZV9sZbdoEeHj/ekZHjE
         O5P3e9zSh/YAImXtLDdOs7Sphrm85nC1hXups7ccqP5f9NnkmJ/21uHE1EciYVzZjB
         H7csK9jXifS7roFJUUjLja528Z+vHsNC5LYte2M/0d2n6JcoU/WPOAXEghimXPwFjJ
         JZ9hBpgi2u/i32t0j3OvmohzhOvHXldkiiYFjwUynFsQUY9SqsgTkRbv786cTSpVjA
         SJZtOAOUR/45w/Sa0o0X9dZ8A98VNIAWZW1b7j8PeJZNeHv4MF3nW9nVFK5MGrsXS/
         Ktpy9gGvOEW3w==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        andrii@kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2 sl-b 1/5] mm: Add mem_dump_obj() to print source of
 memory block
Message-ID: <20201210234107.GA6784@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-1-paulmck@kernel.org>
 <20201210120354.GA8705@js1304-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210120354.GA8705@js1304-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Dec 10, 2020 at 09:04:11PM +0900, Joonsoo Kim wrote:
> On Tue, Dec 08, 2020 at 05:12:59PM -0800, paulmck@kernel.org wrote:
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
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Introducing three functions, kmem_valid_obj(), kmem_provenance(),
> mem_dump_obj() looks better than patchset v1. Nice work. Few comments
> below.

Glad you like it!

> > ---
> >  include/linux/mm.h   |  2 ++
> >  include/linux/slab.h |  2 ++
> >  mm/slab.c            | 28 +++++++++++++++++++++
> >  mm/slab.h            | 11 +++++++++
> >  mm/slab_common.c     | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  mm/slob.c            |  7 ++++++
> >  mm/slub.c            | 40 ++++++++++++++++++++++++++++++
> >  mm/util.c            | 25 +++++++++++++++++++
> >  8 files changed, 184 insertions(+)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index ef360fe..1eea266 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3153,5 +3153,7 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
> >  
> >  extern int sysctl_nr_trim_pages;
> >  
> > +void mem_dump_obj(void *object);
> > +
> >  #endif /* __KERNEL__ */
> >  #endif /* _LINUX_MM_H */
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index dd6897f..169b511 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -186,6 +186,8 @@ void kfree(const void *);
> >  void kfree_sensitive(const void *);
> >  size_t __ksize(const void *);
> >  size_t ksize(const void *);
> > +bool kmem_valid_obj(void *object);
> > +void kmem_dump_obj(void *object);
> >  
> >  #ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
> >  void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
> > diff --git a/mm/slab.c b/mm/slab.c
> > index b111356..72b6743 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -3602,6 +3602,34 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
> >  EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
> >  #endif
> >  
> > +void kmem_provenance(struct kmem_provenance *kpp)
> 
> To open up the possibility of future enhancement, name, provenance,
> looks not good to me. This function could be used to extract various
> object information so such as kmem_obj_info() looks better to me. Any
> thought?

The name kmem_obj_info() works for me, updated.

> > +{
> > +#ifdef DEBUG
> > +	struct kmem_cache *cachep;
> > +	void *object = kpp->kp_ptr;
> > +	unsigned int objnr;
> > +	void *objp;
> > +	struct page *page = kpp->kp_page;
> > +
> > +	cachep = page->slab_cache;
> > +	if (!(cachep->flags & SLAB_STORE_USER)) {
> > +		kpp->kp_ret = NULL;
> > +		goto nodebug;
> > +	}
> > +	objp = object - obj_offset(cachep);
> > +	page = virt_to_head_page(objp);
> > +	objnr = obj_to_index(cachep, page, objp);
> > +	objp = index_to_obj(cachep, page, objnr);
> > +	kpp->kp_objp = objp;
> > +	kpp->kp_ret = *dbg_userword(cachep, objp);
> > +nodebug:
> > +#else
> > +	kpp->kp_ret = NULL;
> > +#endif
> > +	if (kpp->kp_nstack)
> > +		kpp->kp_stack[0] = NULL;
> > +}
> > +
> >  static __always_inline void *
> >  __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
> >  {
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 6d7c6a5..28a41d5 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -630,4 +630,15 @@ static inline bool slab_want_init_on_free(struct kmem_cache *c)
> >  	return false;
> >  }
> >  
> > +#define KS_ADDRS_COUNT 16
> > +struct kmem_provenance {
> > +	void *kp_ptr;
> > +	struct page *kp_page;
> > +	void *kp_objp;
> > +	void *kp_ret;
> > +	void *kp_stack[KS_ADDRS_COUNT];
> > +	int kp_nstack;
> > +};
> > +void kmem_provenance(struct kmem_provenance *kpp);
> > +
> >  #endif /* MM_SLAB_H */
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index f9ccd5d..09f0cbc 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -536,6 +536,75 @@ bool slab_is_available(void)
> >  	return slab_state >= UP;
> >  }
> >  
> > +/**
> > + * kmem_valid_obj - does the pointer reference a valid slab object?
> > + * @object: pointer to query.
> > + *
> > + * Return: %true if the pointer is to a not-yet-freed object from
> > + * kmalloc() or kmem_cache_alloc(), either %true or %false if the pointer
> > + * is to an already-freed object, and %false otherwise.
> > + */
> > +bool kmem_valid_obj(void *object)
> > +{
> > +	struct page *page;
> > +
> > +	if (!virt_addr_valid(object))
> > +		return false;
> > +	page = virt_to_head_page(object);
> > +	return PageSlab(page);
> > +}
> > +EXPORT_SYMBOL_GPL(kmem_valid_obj);
> > +
> > +/**
> > + * kmem_dump_obj - Print available slab provenance information
> > + * @object: slab object for which to find provenance information.
> > + *
> > + * This function uses pr_cont(), so that the caller is expected to have
> > + * printed out whatever preamble is appropriate.  The provenance information
> > + * depends on the type of object and on how much debugging is enabled.
> > + * For a slab-cache object, the fact that it is a slab object is printed,
> > + * and, if available, the slab name, return address, and stack trace from
> > + * the allocation of that object.
> > + *
> > + * This function will splat if passed a pointer to a non-slab object.
> > + * If you are not sure what type of object you have, you should instead
> > + * use mem_dump_obj().
> > + */
> > +void kmem_dump_obj(void *object)
> > +{
> > +	int i;
> > +	struct page *page;
> > +	struct kmem_provenance kp;
> > +
> > +	if (WARN_ON_ONCE(!virt_addr_valid(object)))
> > +		return;
> > +	page = virt_to_head_page(object);
> > +	if (WARN_ON_ONCE(!PageSlab(page))) {
> > +		pr_cont(" non-slab memory.\n");
> > +		return;
> > +	}
> > +	kp.kp_ptr = object;
> > +	kp.kp_page = page;
> > +	kp.kp_nstack = KS_ADDRS_COUNT;
> 
> I hope that kmem_dump_obj() doesn't set any kp fields. It's the job
> reserved for kmem_provenance().

I assigned to kp.kp_ptr to avoid doing it in each of the three variants
of kmem_provenance(), but it is clearly not a big deal to do the three
assignments.  Ditto for kp.kp_page.

I can remove the kp.kp_nstack assignment entirely and have the variants
just use KS_ADDRS_COUNT directly.

And I will zero-initialize kp, thus getting rid of some of the
NULL/0 assignments in the various kmem_provenance() functions.
And a lot of goto statements.

> > +	kmem_provenance(&kp);
> > +	if (page->slab_cache)
> > +		pr_cont(" slab %s", page->slab_cache->name);
> 
> Rather than accessing page->slab_cache, it's better to introduce
> slab_cache field on kp and use it. Note that slob doesn't use
> page->slab_cache. In slob, that field on struct page would be NULL so
> it would not cause a problem. But using kp makes things clear.

Easy enough!

> > +	else
> > +		pr_cont(" slab ");
> > +	if (kp.kp_ret)
> > +		pr_cont(" allocated at %pS\n", kp.kp_ret);
> > +	else
> > +		pr_cont("\n");
> > +	if (kp.kp_stack[0]) {
> 
> This check would be useless since we check it on every iteration.

Good catch, removed.

							Thanx, Paul
