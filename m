Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A60C433FE
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 11:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D951D23D57
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 11:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgLJLnD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Dec 2020 06:43:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:34284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbgLJLnD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Dec 2020 06:43:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 177E4AE4A;
        Thu, 10 Dec 2020 11:42:19 +0000 (UTC)
To:     paulmck@kernel.org
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
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-1-paulmck@kernel.org>
 <8ea31887-8cc3-24cc-82e8-779290c61c2c@suse.cz>
 <20201209230442.GH2657@paulmck-ThinkPad-P72>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 sl-b 1/5] mm: Add mem_dump_obj() to print source of
 memory block
Message-ID: <211cc2a9-5d94-cb0f-91bf-3415510b7dae@suse.cz>
Date:   Thu, 10 Dec 2020 11:48:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209230442.GH2657@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 12/10/20 12:04 AM, Paul E. McKenney wrote:
>> > +/**
>> > + * kmem_valid_obj - does the pointer reference a valid slab object?
>> > + * @object: pointer to query.
>> > + *
>> > + * Return: %true if the pointer is to a not-yet-freed object from
>> > + * kmalloc() or kmem_cache_alloc(), either %true or %false if the pointer
>> > + * is to an already-freed object, and %false otherwise.
>> > + */
>> 
>> It should be possible to find out more about object being free or not, than you
>> currently do. At least to find out if it's definitely free. When it appears
>> allocated, it can be actually still free in some kind of e.g. per-cpu or
>> per-node cache that would be infeasible to check. But that improvement to the
>> output can be also added later. Also SLUB stores the freeing stacktrace, which
>> might be useful...
> 
> I can see how this could help debugging a use-after-free situation,
> at least as long as the poor sap that subsequently allocated it doesn't
> free it.
> 
> I can easily add more fields to the kmem_provenance structure.  Maybe
> it would make sense to have another exported API that you provide a
> kmem_provenance structure to, and it fills it in.
> 
> One caution though...  I rely on the object being allocated.
> If it officially might already be freed, complex and high-overhead
> synchronization seems to be required to safely access the various data
> structures.

Good point! It's easy to forget that when being used to similar digging in a
crash dump, where nothing changes.

> So any use on an already-freed object is on a "you break it you get to
> keep the pieces" basis.  On the other hand, if you are dealing with a
> use-after-free situation, life is hard anyway.

Yeah, even now I think it's potentially dangerous, as you can get
kmem_valid_obj() as true because PageSlab(page) is true. But the object might be
already free, so as soon as another CPU frees another object from the same slab
page, the page gets also freed... or it was already freed and then allocated by
another slab so it's PageSlab() again.
I guess at least some safety could be achieved by pinning the page with
get_page_unless_zero. But maybe your current implementation is already safe,
need to check in detail.

> Or am I missing your point?
> 
>> > +bool kmem_valid_obj(void *object)
>> > +{
>> > +	struct page *page;
>> > +
>> > +	if (!virt_addr_valid(object))
>> > +		return false;
>> > +	page = virt_to_head_page(object);
>> > +	return PageSlab(page);
>> > +}
>> > +EXPORT_SYMBOL_GPL(kmem_valid_obj);
>> > +
>> > +/**
>> > + * kmem_dump_obj - Print available slab provenance information
>> > + * @object: slab object for which to find provenance information.
>> > + *
>> > + * This function uses pr_cont(), so that the caller is expected to have
>> > + * printed out whatever preamble is appropriate.  The provenance information
>> > + * depends on the type of object and on how much debugging is enabled.
>> > + * For a slab-cache object, the fact that it is a slab object is printed,
>> > + * and, if available, the slab name, return address, and stack trace from
>> > + * the allocation of that object.
>> > + *
>> > + * This function will splat if passed a pointer to a non-slab object.
>> > + * If you are not sure what type of object you have, you should instead
>> > + * use mem_dump_obj().
>> > + */
>> > +void kmem_dump_obj(void *object)
>> > +{
>> > +	int i;
>> > +	struct page *page;
>> > +	struct kmem_provenance kp;
>> > +
>> > +	if (WARN_ON_ONCE(!virt_addr_valid(object)))
>> > +		return;
>> > +	page = virt_to_head_page(object);
>> > +	if (WARN_ON_ONCE(!PageSlab(page))) {
>> > +		pr_cont(" non-slab memory.\n");
>> > +		return;
>> > +	}
>> > +	kp.kp_ptr = object;
>> > +	kp.kp_page = page;
>> > +	kp.kp_nstack = KS_ADDRS_COUNT;
>> > +	kmem_provenance(&kp);
>> 
>> You don't seem to be printing kp.kp_objp anywhere? (unless in later patch, but
>> would make sense in this patch already).
> 
> Good point!
> 
> However, please note that the various debugging options that reserve
> space at the beginning.  This can make the meaning of kp.kp_objp a bit
> different than one might expect.

Yeah, I think the best would be to match the address that
kmalloc/kmem_cache_alloc() would return, thus the beginning of the object
itself, so you can calculate the offset within it, etc.

>> > --- a/mm/util.c
>> > +++ b/mm/util.c
>> 
>> I think mm/debug.c is a better fit as it already has dump_page() of a similar
>> nature. Also you can call that from from mem_dump_obj() at least in case when
>> the more specific handlers fail. It will even include page_owner info if enabled! :)
> 
> I will count this as one vote for mm/debug.c.
> 
> Two things to consider, though...  First, Joonsoo suggests that the fact
> that this produces useful information without any debugging information
> enabled makes it not be debugging as such.

Well there's already dump_page() which also produces information without special
configs.
We're not the best subsystem in this kind of consistency...

> Second, mm/debug.c does
> not include either slab.h or vmalloc.h.  The second might not be a
> showstopper, but I was interpreting this to mean that its role was
> less central.

I think it can include whatever becomes needed there :)

> 							Thanx, Paul
> 
>> Thanks,
>> Vlastimil
>> 
>> > @@ -970,3 +970,28 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
>> >  	kunmap_atomic(addr1);
>> >  	return ret;
>> >  }
>> > +
>> > +/**
>> > + * mem_dump_obj - Print available provenance information
>> > + * @object: object for which to find provenance information.
>> > + *
>> > + * This function uses pr_cont(), so that the caller is expected to have
>> > + * printed out whatever preamble is appropriate.  The provenance information
>> > + * depends on the type of object and on how much debugging is enabled.
>> > + * For example, for a slab-cache object, the slab name is printed, and,
>> > + * if available, the return address and stack trace from the allocation
>> > + * of that object.
>> > + */
>> > +void mem_dump_obj(void *object)
>> > +{
>> > +	if (!virt_addr_valid(object)) {
>> > +		pr_cont(" non-paged (local) memory.\n");
>> > +		return;
>> > +	}
>> > +	if (kmem_valid_obj(object)) {
>> > +		kmem_dump_obj(object);
>> > +		return;
>> > +	}
>> > +	pr_cont(" non-slab memory.\n");
>> > +}
>> > +EXPORT_SYMBOL_GPL(mem_dump_obj);
>> > 
>> 
> 

