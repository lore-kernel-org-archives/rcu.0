Return-Path: <SRS0=CVHC=DG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CEDC4346E
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 10:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0054A2075E
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 10:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgI2KPh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 29 Sep 2020 06:15:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:56814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgI2KPh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 29 Sep 2020 06:15:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B78E0AD12;
        Tue, 29 Sep 2020 10:15:34 +0000 (UTC)
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
Date:   Tue, 29 Sep 2020 12:15:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918194817.48921-3-urezki@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 9/18/20 9:48 PM, Uladzislau Rezki (Sony) wrote:
> Some background and kfree_rcu()
> ===============================
> The pointers to be freed are stored in the per-cpu array to improve
> performance, to enable an easier-to-use API, to accommodate vmalloc
> memmory and to support a single argument of the kfree_rcu() when only
> a pointer is passed. More details are below.
> 
> In order to maintain such per-CPU arrays there is a need in dynamic
> allocation when a current array is fully populated and a new block is
> required. See below the example:
> 
>  0 1 2 3      0 1 2 3
> |p|p|p|p| -> |p|p|p|p| -> NULL
> 
> there are two pointer-blocks, each one can store 4 addresses
> which will be freed after a grace period is passed. In reality
> we store PAGE_SIZE / sizeof(void *). So to maintain such blocks
> a single page is obtain via the page allocator:
> 
>     bnode = (struct kvfree_rcu_bulk_data *)
>         __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> 
> after that it is attached to the "head" and its "next" pointer is
> set to previous "head", so the list of blocks can be maintained and
> grow dynamically until it gets drained by the reclaiming thread.
> 
> Please note. There is always a fallback if an allocation fails. In the
> single argument, this is a call to synchronize_rcu() and for the two
> arguments case this is to use rcu_head structure embedded in the object
> being free, and then paying cache-miss penalty, also invoke the kfree()
> per object instead of kfree_bulk() for groups of objects.
> 
> Why we maintain arrays/blocks instead of linking objects by the regular
> "struct rcu_head" technique. See below a few but main reasons:
> 
> a) A memory can be reclaimed by invoking of the kfree_bulk()
>    interface that requires passing an array and number of
>    entries in it. That reduces the per-object overhead caused
>    by calling kfree() per-object. This reduces the reclamation
>    time.
> 
> b) Improves locality and reduces the number of cache-misses, due to
>    "pointer chasing" between objects, which can be far spread between
>    each other.
> 
> c) Support a "single argument" in the kvfree_rcu()
>    void *ptr = kvmalloc(some_bytes, GFP_KERNEL);
>    if (ptr)
>         kvfree_rcu(ptr);
> 
>    We need it when an "rcu_head" is not embed into a stucture but an
>    object must be freed after a grace period. Therefore for the single
>    argument, such objects cannot be queued on a linked list.
> 
>    So nowadays, since we do not have a single argument but we see the
>    demand in it, to workaround it people just do a simple not efficient
>    sequence:
>    <snip>
>        synchronize_rcu(); /* Can be long and blocks a current context */
>        kfree(p);
>    <snip>
> 
>    More details is here: https://lkml.org/lkml/2020/4/28/1626
> 
> d) To distinguish vmalloc pointers between SLAB ones. It becomes possible
>    to invoke the right freeing API for the right kind of pointer, kfree_bulk()
>    or TBD: vmalloc_bulk().
> 
> e) Speeding up the post-grace-period freeing reduces the chance of a flood
>    of callback's OOMing the system.
> 
> Also, please have a look here: https://lkml.org/lkml/2020/7/30/1166
> 
> Proposal
> ========
> Introduce a lock-free function that obtain a page from the per-cpu-lists
> on current CPU. It returns NULL rather than acquiring any non-raw spinlock.
> 
> Description
> ===========
> The page allocator has two phases, fast path and slow one. We are interested
> in fast path and order-0 allocations. In its turn it is divided also into two
> phases: lock-less and not:
> 
> 1) As a first step the page allocator tries to obtain a page from the
>    per-cpu-list, so each CPU has its own one. That is why this step is
>    lock-less and fast. Basically it disables irqs on current CPU in order
>    to access to per-cpu data and remove a first element from the pcp-list.
>    An element/page is returned to an user.
> 
> 2) If there is no any available page in per-cpu-list, the second step is
>    involved. It removes a specified number of elements from the buddy allocator
>    transferring them to the "supplied-list/per-cpu-list" described in [1].
> 
> Summarizing. The __rcu_alloc_page_lockless() covers only [1] and can not
> do step [2], due to the fact that [2] requires an access to zone->lock.
> It implies that it is super fast, but a higher rate of fails is also
> expected.
> 
> Usage: __rcu_alloc_page_lockless();
> 
> Link: https://lore.kernel.org/lkml/20200814215206.GL3982@worktop.programming.kicks-ass.net/
> Not-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

After reading all the threads and mulling over this, I am going to deflect from
Mel and Michal and not oppose the idea of lockless allocation. I would even
prefer to do it via the gfp flag and not a completely separate path. Not using
the exact code from v1, I think it could be done in a way that we don't actually
look at the new flag until we find that pcplist is empty - which should not
introduce overhead to the fast-fast path when pcpclist is not empty. It's more
maintainable that adding new entry points, IMHO.

But there's still the condition that it's sufficiently shown that the allocation
is useful for RCU. In that case I prefer that the page allocator (or MM in
general) can give its users what they need without having to work around it.
Seems like GFP_ATOMIC is insufficient today so if that means we need a new flag
for the raw spinlock context, so be it. But if your usage of __GFP_NO_LOCKS
depends on the result of preempt_count() or similar check whether this is a
context that needs it, I'd prefer to keep this in the caller.
