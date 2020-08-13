Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D2CC433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 07:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA90820716
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 07:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHMHua (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:50:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:36444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgHMHua (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 03:50:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38EBAAF82;
        Thu, 13 Aug 2020 07:50:50 +0000 (UTC)
Date:   Thu, 13 Aug 2020 09:50:27 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813075027.GD9477@dhcp22.suse.cz>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kp87mca.fsf@nanos.tec.linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed 12-08-20 02:13:25, Thomas Gleixner wrote:
[...]
> I can understand your rationale and what you are trying to solve. So, if
> we can actually have a distinct GFP variant:
> 
>   GFP_I_ABSOLUTELY_HAVE_TO_DO_THAT_AND_I_KNOW_IT_CAN_FAIL_EARLY

Even if we cannot make the zone->lock raw I would prefer to not
introduce a new gfp flag. Well we can do an alias for easier grepping
#define GFP_RT_SAFE	0

that would imply nowait semantic and would exclude waking up kswapd as
well. If we can make wake up safe under RT then the alias would reflect
that without any code changes.

The second, and the more important part, would be to bail out anytime
the page allocator is to take a lock which is not allowed in the current
RT context. Something like 
	
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 67a0774e080b..3ef3ac82d110 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -237,6 +237,9 @@ struct vm_area_struct;
  * that subsystems start with one of these combinations and then set/clear
  * %__GFP_FOO flags as necessary.
  *
+ * %GFP_RT_SAFE users can not sleep and they are running under RT atomic context
+ * e.g. under raw_spin_lock. Failure of an allocation is to be expected.
+ *
  * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
  * watermark is applied to allow access to "atomic reserves"
  *
@@ -293,6 +296,7 @@ struct vm_area_struct;
  * version does not attempt reclaim/compaction at all and is by default used
  * in page fault path, while the non-light is used by khugepaged.
  */
+#define GFP_RT_SAFE	0
 #define GFP_ATOMIC	(__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
 #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
 #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e028b87ce294..268ae872cc2a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2824,6 +2824,13 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 {
 	int i, alloced = 0;
 
+	/*
+	 * Hard atomic contexts are not supported by the allocator for
+	 * anything but pcp requests
+	 */
+	if (!preemtable())
+		return 0;
+
 	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
@@ -3371,6 +3378,13 @@ struct page *rmqueue(struct zone *preferred_zone,
 		goto out;
 	}
 
+	/*
+	 * Hard atomic contexts are not supported by the allocator for high
+	 * order requests
+	 */
+	if (WARN_ON_ONCE(!preemtable()))
+		reurn NULL;
+
 	/*
 	 * We most definitely don't want callers attempting to
 	 * allocate greater than order-1 page units with __GFP_NOFAIL.
@@ -4523,6 +4537,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
 		gfp_mask &= ~__GFP_ATOMIC;
 
+	/* Hard atomic contexts support is very limited to the fast path */
+	if (!preemtable()) {
+		WARN_ON_ONCE(gfp_mask != GFP_RT_SAFE);
+		return NULL;
+	}
+
 retry_cpuset:
 	compaction_retries = 0;
 	no_progress_loops = 0;

What do you think?
 
> which is easy to grep for then having the page allocator go down to the
> point where zone lock gets involved is not the end of the world for
> RT in theory - unless that damned reality tells otherwise. :)
> 
> The page allocator allocations should also have a limit on the number of
> pages and eventually also page order (need to stare at the code or let
> Michal educate me that the order does not matter).

In practice anything but order 0 is out of question because we need
zone->lock for that currently. Maybe we can introduce pcp lists for
higher orders in the future - I have a vague recollection Mel was
playing with that some time ago.

> To make it consistent the same GFP_ variant should allow the slab
> allocator go to the point where the slab cache is exhausted.
> 
> Having a distinct and clearly defined GFP_ variant is really key to
> chase down offenders and to make reviewers double check upfront why this
> is absolutely required.

Having a high level and recognizable gfp mask is OK but I would really
like not to introduce a dedicated flag. The page allocator should be
able to recognize the context which cannot be handled. 
-- 
Michal Hocko
SUSE Labs
