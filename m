Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCC9C433FE
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 19:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133F022E00
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 19:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393371AbgLJT5w (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Dec 2020 14:57:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390146AbgLJT5n (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Dec 2020 14:57:43 -0500
Date:   Thu, 10 Dec 2020 11:56:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607630219;
        bh=7YiuW/XD2F8+axLnYxfd/GhmODra1Xbd7PzzWXxBB+k=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Pv9i69yA/yZ5f3zqOE7xzZ97OXL87KIeMaEZq99EUA4hfxGrHOlDheGv4Hjmv13LW
         k8pxmrwmA7jm5ob2ZR9WWqU2FhsjNICuHJqfYhNiUlx2JaB2wVgEvzGb3LJG55kTxG
         bTV9U38fSa5WbNbV6ndxzC7eotFebx60G7oY8ysdaYoY14Dt+5M98wtUhpIikU4V2S
         TRtGk4Zz7gA7SRumFE0pdINS9TawlFAZf4LLz4MwPxSkWUD6dTOkbsFI7oPk+gGS7F
         +RPq1kCFYVAcO9ujFKJDY+t3PUzIftCuyg7Xqe/Am1GegJOYWuIzVIuBK9PPsFoNe5
         fWzE5LLPRNdDw==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        iamjoonsoo.kim@lge.com, andrii@kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2 sl-b 1/5] mm: Add mem_dump_obj() to print source of
 memory block
Message-ID: <20201210195659.GY2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-1-paulmck@kernel.org>
 <8ea31887-8cc3-24cc-82e8-779290c61c2c@suse.cz>
 <20201209230442.GH2657@paulmck-ThinkPad-P72>
 <211cc2a9-5d94-cb0f-91bf-3415510b7dae@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <211cc2a9-5d94-cb0f-91bf-3415510b7dae@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Dec 10, 2020 at 11:48:26AM +0100, Vlastimil Babka wrote:
> On 12/10/20 12:04 AM, Paul E. McKenney wrote:
> >> > +/**
> >> > + * kmem_valid_obj - does the pointer reference a valid slab object?
> >> > + * @object: pointer to query.
> >> > + *
> >> > + * Return: %true if the pointer is to a not-yet-freed object from
> >> > + * kmalloc() or kmem_cache_alloc(), either %true or %false if the pointer
> >> > + * is to an already-freed object, and %false otherwise.
> >> > + */
> >> 
> >> It should be possible to find out more about object being free or not, than you
> >> currently do. At least to find out if it's definitely free. When it appears
> >> allocated, it can be actually still free in some kind of e.g. per-cpu or
> >> per-node cache that would be infeasible to check. But that improvement to the
> >> output can be also added later. Also SLUB stores the freeing stacktrace, which
> >> might be useful...
> > 
> > I can see how this could help debugging a use-after-free situation,
> > at least as long as the poor sap that subsequently allocated it doesn't
> > free it.
> > 
> > I can easily add more fields to the kmem_provenance structure.  Maybe
> > it would make sense to have another exported API that you provide a
> > kmem_provenance structure to, and it fills it in.
> > 
> > One caution though...  I rely on the object being allocated.
> > If it officially might already be freed, complex and high-overhead
> > synchronization seems to be required to safely access the various data
> > structures.
> 
> Good point! It's easy to forget that when being used to similar digging in a
> crash dump, where nothing changes.

Maybe a similar addition to the crash-analysis tools would be helpful?

> > So any use on an already-freed object is on a "you break it you get to
> > keep the pieces" basis.  On the other hand, if you are dealing with a
> > use-after-free situation, life is hard anyway.
> 
> Yeah, even now I think it's potentially dangerous, as you can get
> kmem_valid_obj() as true because PageSlab(page) is true. But the object might be
> already free, so as soon as another CPU frees another object from the same slab
> page, the page gets also freed... or it was already freed and then allocated by
> another slab so it's PageSlab() again.
> I guess at least some safety could be achieved by pinning the page with
> get_page_unless_zero. But maybe your current implementation is already safe,
> need to check in detail.

The code on the various free paths looks to me to make the same
assumptions that I am making.  So if this is unsafe, we have other
problems.

> > Or am I missing your point?
> > 
> >> > +bool kmem_valid_obj(void *object)
> >> > +{
> >> > +	struct page *page;
> >> > +
> >> > +	if (!virt_addr_valid(object))
> >> > +		return false;
> >> > +	page = virt_to_head_page(object);
> >> > +	return PageSlab(page);
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(kmem_valid_obj);
> >> > +
> >> > +/**
> >> > + * kmem_dump_obj - Print available slab provenance information
> >> > + * @object: slab object for which to find provenance information.
> >> > + *
> >> > + * This function uses pr_cont(), so that the caller is expected to have
> >> > + * printed out whatever preamble is appropriate.  The provenance information
> >> > + * depends on the type of object and on how much debugging is enabled.
> >> > + * For a slab-cache object, the fact that it is a slab object is printed,
> >> > + * and, if available, the slab name, return address, and stack trace from
> >> > + * the allocation of that object.
> >> > + *
> >> > + * This function will splat if passed a pointer to a non-slab object.
> >> > + * If you are not sure what type of object you have, you should instead
> >> > + * use mem_dump_obj().
> >> > + */
> >> > +void kmem_dump_obj(void *object)
> >> > +{
> >> > +	int i;
> >> > +	struct page *page;
> >> > +	struct kmem_provenance kp;
> >> > +
> >> > +	if (WARN_ON_ONCE(!virt_addr_valid(object)))
> >> > +		return;
> >> > +	page = virt_to_head_page(object);
> >> > +	if (WARN_ON_ONCE(!PageSlab(page))) {
> >> > +		pr_cont(" non-slab memory.\n");
> >> > +		return;
> >> > +	}
> >> > +	kp.kp_ptr = object;
> >> > +	kp.kp_page = page;
> >> > +	kp.kp_nstack = KS_ADDRS_COUNT;
> >> > +	kmem_provenance(&kp);
> >> 
> >> You don't seem to be printing kp.kp_objp anywhere? (unless in later patch, but
> >> would make sense in this patch already).
> > 
> > Good point!
> > 
> > However, please note that the various debugging options that reserve
> > space at the beginning.  This can make the meaning of kp.kp_objp a bit
> > different than one might expect.
> 
> Yeah, I think the best would be to match the address that
> kmalloc/kmem_cache_alloc() would return, thus the beginning of the object
> itself, so you can calculate the offset within it, etc.

My thought is to do both.  Show the start address, the data offset (if
nonzero), and the pointer offset within the data.  My guess is that in
the absence of things like slub_debug=U, the pointer offset within the
data is the best way to figure out which structure is involved.

Or do you use other tricks to work this sort of thing out?

> >> > --- a/mm/util.c
> >> > +++ b/mm/util.c
> >> 
> >> I think mm/debug.c is a better fit as it already has dump_page() of a similar
> >> nature. Also you can call that from from mem_dump_obj() at least in case when
> >> the more specific handlers fail. It will even include page_owner info if enabled! :)
> > 
> > I will count this as one vote for mm/debug.c.
> > 
> > Two things to consider, though...  First, Joonsoo suggests that the fact
> > that this produces useful information without any debugging information
> > enabled makes it not be debugging as such.
> 
> Well there's already dump_page() which also produces information without special
> configs.
> We're not the best subsystem in this kind of consistency...
> 
> > Second, mm/debug.c does
> > not include either slab.h or vmalloc.h.  The second might not be a
> > showstopper, but I was interpreting this to mean that its role was
> > less central.
> 
> I think it can include whatever becomes needed there :)

I figured that there was a significant probability that I would have to
move it, and I really don't have a basis for a preference, let alone
a preference.  But I would like to avoid moving it more than once, so
I also figured I should give anyone else having an educated preference
a chance to speak up.  ;-)

							Thanx, Paul

> >> Thanks,
> >> Vlastimil
> >> 
> >> > @@ -970,3 +970,28 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
> >> >  	kunmap_atomic(addr1);
> >> >  	return ret;
> >> >  }
> >> > +
> >> > +/**
> >> > + * mem_dump_obj - Print available provenance information
> >> > + * @object: object for which to find provenance information.
> >> > + *
> >> > + * This function uses pr_cont(), so that the caller is expected to have
> >> > + * printed out whatever preamble is appropriate.  The provenance information
> >> > + * depends on the type of object and on how much debugging is enabled.
> >> > + * For example, for a slab-cache object, the slab name is printed, and,
> >> > + * if available, the return address and stack trace from the allocation
> >> > + * of that object.
> >> > + */
> >> > +void mem_dump_obj(void *object)
> >> > +{
> >> > +	if (!virt_addr_valid(object)) {
> >> > +		pr_cont(" non-paged (local) memory.\n");
> >> > +		return;
> >> > +	}
> >> > +	if (kmem_valid_obj(object)) {
> >> > +		kmem_dump_obj(object);
> >> > +		return;
> >> > +	}
> >> > +	pr_cont(" non-slab memory.\n");
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(mem_dump_obj);
> >> > 
> >> 
> > 
> 
