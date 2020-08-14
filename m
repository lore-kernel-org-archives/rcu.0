Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26C9C433DF
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 23:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C5120774
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 23:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597447665;
	bh=GPjCjOBy4/MES/6xwTtupSAhE2pRWrieYpnW2v2mWIY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=q/Bcvi1EuYL5WihWbXUSwHgsVuD5KoMsgOIW/SfX/WqIBY3PkZ1UjD1pfgwOHcFm0
	 8OWzeCQiaa+ww9FJREvyXxd44pr8wtgEYxip2UiuTmAEtQ0jV/Upz3tEOFyVw63XwJ
	 7sBnsf93aUaPoaIaautgzMojzCfo1UAhVlUmByBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHNX1p (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 19:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbgHNX1p (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 19:27:45 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EFC820768;
        Fri, 14 Aug 2020 23:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597447664;
        bh=GPjCjOBy4/MES/6xwTtupSAhE2pRWrieYpnW2v2mWIY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HvU9bzcZLYnzdJR10tU7jmktoTLxECTfl1592MQ0btRmVKPDyYxeX+5c/Cau6KbMf
         +7RSeUurYeeS5/b1PkHxL7kD90k3yUvHMgn5ZBiyLKgXWuhT+m7qkl9DcJh3CVaQnW
         R/fOqJkGx/heLGwwJuNemyzyo/fzO0U7xo9S0Ej8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2CD063522B27; Fri, 14 Aug 2020 16:27:44 -0700 (PDT)
Date:   Fri, 14 Aug 2020 16:27:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200814232744.GU4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200813220619.GA2674@hirez.programming.kicks-ass.net>
 <875z9m3xo7.fsf@nanos.tec.linutronix.de>
 <20200814083037.GD3982@worktop.programming.kicks-ass.net>
 <20200814141425.GM4295@paulmck-ThinkPad-P72>
 <20200814161106.GA13853@paulmck-ThinkPad-P72>
 <20200814174924.GI3982@worktop.programming.kicks-ass.net>
 <20200814180224.GQ4295@paulmck-ThinkPad-P72>
 <875z9lkoo4.fsf@nanos.tec.linutronix.de>
 <20200814204140.GT4295@paulmck-ThinkPad-P72>
 <20200814215206.GL3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814215206.GL3982@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14, 2020 at 11:52:06PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 14, 2020 at 01:41:40PM -0700, Paul E. McKenney wrote:
> > > And that enforces the GFP_NOLOCK allocation mode or some other solution
> > > unless you make a new rule that calling call_rcu() is forbidden while
> > > holding zone lock or any other lock which might be nested inside the
> > > GFP_NOWAIT zone::lock held region.
> > 
> > Again, you are correct.  Maybe the forecasted weekend heat will cause
> > my brain to hallucinate a better solution, but in the meantime, the
> > GFP_NOLOCK approach looks good from this end.
> 
> So I hate __GFP_NO_LOCKS for a whole number of reasons:
> 
>  - it should be called __GFP_LOCKLESS if anything
>  - it sprinkles a bunch of ugly branches around the allocator fast path
>  - it only works for order==0
> 
> Combined I really odn't think this should be a GFP flag. How about a
> special purpose allocation function, something like so..

This looks entirely reasonable to me!

							Thanx, Paul

> ---
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 901a21f61d68..cdec9c99fba7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4875,6 +4875,47 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  }
>  EXPORT_SYMBOL(__alloc_pages_nodemask);
>  
> +struct page *__rmqueue_lockless(struct zone *zone, struct per_cpu_pages *pcp)
> +{
> +	struct list_head *list;
> +	struct page *page;
> +	int migratetype;
> +
> +	for (migratetype = 0; migratetype < MIGRATE_PCPTYPES; migratetype++) {
> +		list = &pcp->list[migratetype];
> +		page = list_first_entry_or_null(list, struct page, lru);
> +		if (page && check_new_pcp(page)) {
> +			list_del(&page->lru);
> +			pcp->count--;
> +			return page;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +struct page *__alloc_page_lockless(void)
> +{
> +	struct zonelist *zonelist = node_zonelist(numa_node_id(), GFP_KERNEL);
> +	struct per_cpu_pages *pcp;
> +	struct page *page = NULL;
> +	unsigned long flags;
> +	struct zoneref *z;
> +	struct zone *zone;
> +
> +	for_each_zone_zonelist(zone, z, zonelist, ZONE_NORMAL) {
> +		local_irq_save(flags);
> +		pcp = &this_cpu_ptr(zone->pageset)->pcp;
> +		page = __rmqueue_lockless(zone, pcp);
> +		local_irq_restore(flags);
> +
> +		if (page)
> +			break;
> +	}
> +
> +	return page;
> +}
> +
>  /*
>   * Common helper functions. Never use with __GFP_HIGHMEM because the returned
>   * address cannot represent highmem pages. Use alloc_pages and then kmap if
