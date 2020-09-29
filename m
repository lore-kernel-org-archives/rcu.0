Return-Path: <SRS0=CVHC=DG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440A4C4727D
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 22:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0E42083B
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 22:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRRUhIoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgI2WHs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 29 Sep 2020 18:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgI2WHr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 29 Sep 2020 18:07:47 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B659C061755;
        Tue, 29 Sep 2020 15:07:47 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b22so7346454lfs.13;
        Tue, 29 Sep 2020 15:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hn6SYuogvOYugBSSRBBeLSaREsfixTCGGz8LC233vrU=;
        b=XRRUhIoZQcIbTHcdQ9wz2fR6v0v5O8t1FskQd5kUOJcBxw9FNwgI/ZvQmC5irIIS1k
         gfKDpwl8IyHXceE8qsO9M3bJu5mheqr61MWzUgPUGFXX09UdIN4TIeV7alV6OtULJ85G
         8gGzj3rGgM2pEDCEB9IVZtGYFO8eQM/38l5IM4H1j6HKIFajFsGZSPNK+DF/TbbldJRQ
         35Ebj70bH5tWHRg47z++b2UudEto7lq0aIh3EV7hpx7BvGT5VCZNijQCcTcaX9uFitXg
         frtyQ3yC7sW7gWKKj1gKtc+wB16vrsKzmHjF1FuEctW8cl46dk8aquhdQhhMBZ7C8cdD
         20hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hn6SYuogvOYugBSSRBBeLSaREsfixTCGGz8LC233vrU=;
        b=Q0JGsa5c53v7btNWeq3g+gdDmQP2elknR5sqTXb7ZSQf4Cd/+agwgptYrk361MVSvu
         OHR6P5cXpydNdT5YX9zs8T+Wn8b9qNG43oiYb0I6Yjna3Tupcy/50+CQWIWAkAf37pYx
         86/EBhLJ4selxw+/KBR9fchcFI0zNy6q8TtFnz50iMR1UzOJDH7M6r4ZAO7qGHBcho3y
         7PegtLOFxsQ9UOdL4FKqoYPMIQoyxLQAygRc4HYl0NF6mBybEAtKF7J6/Ko9rhq75WJO
         e3SeocUYbOi++sCQCZ8K49yojJAIR+NxlX6wx4y/Sx/CRvKPu03GvddDQuLqxvH9XQoT
         /GFg==
X-Gm-Message-State: AOAM533BueVcvq/Tr1O8Qiv4+3X+wdEU2xxFEZsm+qM5v4pxMmjJ/WKu
        Ovi16HwepPEH8pm6Va1+5ro=
X-Google-Smtp-Source: ABdhPJx2QA/yJvaWmB8FETulM7KFPS1EBXWCdOWAPkn1rl8WStsGnZ3cDaZ2JiCZSvuSCK8RRI6KtQ==
X-Received: by 2002:a19:754:: with SMTP id 81mr1844732lfh.272.1601417265526;
        Tue, 29 Sep 2020 15:07:45 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id x5sm3388397lff.280.2020.09.29.15.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 15:07:44 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 30 Sep 2020 00:07:42 +0200
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200929220742.GB8768@pc636>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 29, 2020 at 12:15:34PM +0200, Vlastimil Babka wrote:
> On 9/18/20 9:48 PM, Uladzislau Rezki (Sony) wrote:
> > Some background and kfree_rcu()
> > ===============================
> > The pointers to be freed are stored in the per-cpu array to improve
> > performance, to enable an easier-to-use API, to accommodate vmalloc
> > memmory and to support a single argument of the kfree_rcu() when only
> > a pointer is passed. More details are below.
> > 
> > In order to maintain such per-CPU arrays there is a need in dynamic
> > allocation when a current array is fully populated and a new block is
> > required. See below the example:
> > 
> >  0 1 2 3      0 1 2 3
> > |p|p|p|p| -> |p|p|p|p| -> NULL
> > 
> > there are two pointer-blocks, each one can store 4 addresses
> > which will be freed after a grace period is passed. In reality
> > we store PAGE_SIZE / sizeof(void *). So to maintain such blocks
> > a single page is obtain via the page allocator:
> > 
> >     bnode = (struct kvfree_rcu_bulk_data *)
> >         __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > 
> > after that it is attached to the "head" and its "next" pointer is
> > set to previous "head", so the list of blocks can be maintained and
> > grow dynamically until it gets drained by the reclaiming thread.
> > 
> > Please note. There is always a fallback if an allocation fails. In the
> > single argument, this is a call to synchronize_rcu() and for the two
> > arguments case this is to use rcu_head structure embedded in the object
> > being free, and then paying cache-miss penalty, also invoke the kfree()
> > per object instead of kfree_bulk() for groups of objects.
> > 
> > Why we maintain arrays/blocks instead of linking objects by the regular
> > "struct rcu_head" technique. See below a few but main reasons:
> > 
> > a) A memory can be reclaimed by invoking of the kfree_bulk()
> >    interface that requires passing an array and number of
> >    entries in it. That reduces the per-object overhead caused
> >    by calling kfree() per-object. This reduces the reclamation
> >    time.
> > 
> > b) Improves locality and reduces the number of cache-misses, due to
> >    "pointer chasing" between objects, which can be far spread between
> >    each other.
> > 
> > c) Support a "single argument" in the kvfree_rcu()
> >    void *ptr = kvmalloc(some_bytes, GFP_KERNEL);
> >    if (ptr)
> >         kvfree_rcu(ptr);
> > 
> >    We need it when an "rcu_head" is not embed into a stucture but an
> >    object must be freed after a grace period. Therefore for the single
> >    argument, such objects cannot be queued on a linked list.
> > 
> >    So nowadays, since we do not have a single argument but we see the
> >    demand in it, to workaround it people just do a simple not efficient
> >    sequence:
> >    <snip>
> >        synchronize_rcu(); /* Can be long and blocks a current context */
> >        kfree(p);
> >    <snip>
> > 
> >    More details is here: https://lkml.org/lkml/2020/4/28/1626
> > 
> > d) To distinguish vmalloc pointers between SLAB ones. It becomes possible
> >    to invoke the right freeing API for the right kind of pointer, kfree_bulk()
> >    or TBD: vmalloc_bulk().
> > 
> > e) Speeding up the post-grace-period freeing reduces the chance of a flood
> >    of callback's OOMing the system.
> > 
> > Also, please have a look here: https://lkml.org/lkml/2020/7/30/1166
> > 
> > Proposal
> > ========
> > Introduce a lock-free function that obtain a page from the per-cpu-lists
> > on current CPU. It returns NULL rather than acquiring any non-raw spinlock.
> > 
> > Description
> > ===========
> > The page allocator has two phases, fast path and slow one. We are interested
> > in fast path and order-0 allocations. In its turn it is divided also into two
> > phases: lock-less and not:
> > 
> > 1) As a first step the page allocator tries to obtain a page from the
> >    per-cpu-list, so each CPU has its own one. That is why this step is
> >    lock-less and fast. Basically it disables irqs on current CPU in order
> >    to access to per-cpu data and remove a first element from the pcp-list.
> >    An element/page is returned to an user.
> > 
> > 2) If there is no any available page in per-cpu-list, the second step is
> >    involved. It removes a specified number of elements from the buddy allocator
> >    transferring them to the "supplied-list/per-cpu-list" described in [1].
> > 
> > Summarizing. The __rcu_alloc_page_lockless() covers only [1] and can not
> > do step [2], due to the fact that [2] requires an access to zone->lock.
> > It implies that it is super fast, but a higher rate of fails is also
> > expected.
> > 
> > Usage: __rcu_alloc_page_lockless();
> > 
> > Link: https://lore.kernel.org/lkml/20200814215206.GL3982@worktop.programming.kicks-ass.net/
> > Not-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> After reading all the threads and mulling over this, I am going to deflect from
> Mel and Michal and not oppose the idea of lockless allocation. I would even
> prefer to do it via the gfp flag and not a completely separate path. Not using
> the exact code from v1, I think it could be done in a way that we don't actually
> look at the new flag until we find that pcplist is empty - which should not
> introduce overhead to the fast-fast path when pcpclist is not empty. It's more
> maintainable that adding new entry points, IMHO.
> 
Thanks for reading all that from the beginning! It must be tough due to the
fact there were lot of messages in the threads, so at least i was lost.

I agree that adding a new entry or separate lock-less function can be considered
as something that is hard to maintain. I have a question here. I mean about your
different look at it:

<snip>
bool is_pcp_cache_empty(gfp_t gfp)
{
    struct per_cpu_pages *pcp;
    struct zoneref *ref;
    unsigned long flags;
    bool empty;

    ref = first_zones_zonelist(node_zonelist(
            numa_node_id(), gfp), gfp_zone(gfp), NULL);
    if (!ref->zone)
            return true;

    local_irq_save(flags);
    pcp = &this_cpu_ptr(ref->zone->pageset)->pcp;
    empty = list_empty(&pcp->lists[gfp_migratetype(gfp)]);
    local_irq_restore(flags);

    return empty;
}

disable_irq();
if (!is_pcp_cache_empty(GFP_NOWAIT))
    __get_free_page(GFP_NOWAIT);
enable_irq();
<snip>

Do you mean to have something like above? I mean some extra API
function that returns true or false if fast-fast allocation can
either occur or not. Above code works just fine and never touches
main zone->lock.

i.e. Instead of introducing an extra GFP_LOCKLESS flag or any new
extra lock-less function. We could have something that checks a
pcp page cache list, thus it can guarantee that a request would
be accomplish using fast-fast path.

>
> But there's still the condition that it's sufficiently shown that the allocation
> is useful for RCU. In that case I prefer that the page allocator (or MM in
> general) can give its users what they need without having to work around it.
>
I see your point, if there is something that can be generic and not specif - makes
sense to me also. I do share your view.

>
> Seems like GFP_ATOMIC is insufficient today so if that means we need a new flag
> for the raw spinlock context, so be it. But if your usage of __GFP_NO_LOCKS
> depends on the result of preempt_count() or similar check whether this is a
> context that needs it, I'd prefer to keep this in the caller.
>
By having the preemptabele() thing, we can just workaround GFP_ATOMIC or GFP_NOWAIT
flag issues. Because both are insufficient. I mean when we see that a context is
atomic(can not sleep) we can bypass any usage of the page allocator because it will
hit BUG() with flags which are in question. And yes, the best is when we do not
think much about context, so there is something reliable from point of using the
page allocator.

Thanks Vlastimil!

--
Vlad Rezki
