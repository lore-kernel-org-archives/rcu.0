Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F48AC433DF
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 21:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA4A20716
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 21:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eo3QUy5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHNVwY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 17:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgHNVwY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 17:52:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D39CC061385;
        Fri, 14 Aug 2020 14:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8RAn4n98mFtGVK2OIEQsn7uMJF3Cb5kh3+aalm6qQ9k=; b=Eo3QUy5elerxdUN1Ii06U0MG70
        PCNKVj4Sc+ZHXDEYCArudzG9ORAKzsYDUt/xO9Netct9+k3ndHcKXD2WGYNGscHNSX3ygqKqqy/61
        kgFAnQHXRYznL1u5pPNRJoZMYg66STwtIGqGdoFENesogysoD5MYKFbBz5Pt8oA+cQVNvXi72Gw3f
        rzX7i66ynoGlODBGq8zwpaWjbe9LLPGRTeZ6wP5eHDw7E25eZ6UefVMWultyTuCA+2wxSjuaXi5Bs
        TyXymcXwI33eEVqz67Eb/TaRrAGeL5OJkIm6usbN7fZEgSgN81an0b8SkuAratqvPwDVO2Kn6lbmj
        vxNkUbYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6hcP-0007ky-GF; Fri, 14 Aug 2020 21:52:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36A19980C9E; Fri, 14 Aug 2020 23:52:06 +0200 (CEST)
Date:   Fri, 14 Aug 2020 23:52:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20200814215206.GL3982@worktop.programming.kicks-ass.net>
References: <20200813185257.GF4295@paulmck-ThinkPad-P72>
 <20200813220619.GA2674@hirez.programming.kicks-ass.net>
 <875z9m3xo7.fsf@nanos.tec.linutronix.de>
 <20200814083037.GD3982@worktop.programming.kicks-ass.net>
 <20200814141425.GM4295@paulmck-ThinkPad-P72>
 <20200814161106.GA13853@paulmck-ThinkPad-P72>
 <20200814174924.GI3982@worktop.programming.kicks-ass.net>
 <20200814180224.GQ4295@paulmck-ThinkPad-P72>
 <875z9lkoo4.fsf@nanos.tec.linutronix.de>
 <20200814204140.GT4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814204140.GT4295@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14, 2020 at 01:41:40PM -0700, Paul E. McKenney wrote:
> > And that enforces the GFP_NOLOCK allocation mode or some other solution
> > unless you make a new rule that calling call_rcu() is forbidden while
> > holding zone lock or any other lock which might be nested inside the
> > GFP_NOWAIT zone::lock held region.
> 
> Again, you are correct.  Maybe the forecasted weekend heat will cause
> my brain to hallucinate a better solution, but in the meantime, the
> GFP_NOLOCK approach looks good from this end.

So I hate __GFP_NO_LOCKS for a whole number of reasons:

 - it should be called __GFP_LOCKLESS if anything
 - it sprinkles a bunch of ugly branches around the allocator fast path
 - it only works for order==0

Combined I really odn't think this should be a GFP flag. How about a
special purpose allocation function, something like so..

---
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 901a21f61d68..cdec9c99fba7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4875,6 +4875,47 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 }
 EXPORT_SYMBOL(__alloc_pages_nodemask);
 
+struct page *__rmqueue_lockless(struct zone *zone, struct per_cpu_pages *pcp)
+{
+	struct list_head *list;
+	struct page *page;
+	int migratetype;
+
+	for (migratetype = 0; migratetype < MIGRATE_PCPTYPES; migratetype++) {
+		list = &pcp->list[migratetype];
+		page = list_first_entry_or_null(list, struct page, lru);
+		if (page && check_new_pcp(page)) {
+			list_del(&page->lru);
+			pcp->count--;
+			return page;
+		}
+	}
+
+	return NULL;
+}
+
+struct page *__alloc_page_lockless(void)
+{
+	struct zonelist *zonelist = node_zonelist(numa_node_id(), GFP_KERNEL);
+	struct per_cpu_pages *pcp;
+	struct page *page = NULL;
+	unsigned long flags;
+	struct zoneref *z;
+	struct zone *zone;
+
+	for_each_zone_zonelist(zone, z, zonelist, ZONE_NORMAL) {
+		local_irq_save(flags);
+		pcp = &this_cpu_ptr(zone->pageset)->pcp;
+		page = __rmqueue_lockless(zone, pcp);
+		local_irq_restore(flags);
+
+		if (page)
+			break;
+	}
+
+	return page;
+}
+
 /*
  * Common helper functions. Never use with __GFP_HIGHMEM because the returned
  * address cannot represent highmem pages. Use alloc_pages and then kmap if
