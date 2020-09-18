Return-Path: <SRS0=xZUe=C3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145BAC43466
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 19:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C204E22208
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 19:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4s7af/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIRTsm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 18 Sep 2020 15:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgIRTsm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 18 Sep 2020 15:48:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84026C0613CE;
        Fri, 18 Sep 2020 12:48:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s205so6015539lja.7;
        Fri, 18 Sep 2020 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zrPxS3Yj7n4laF6P6tQ8nRH7VU6J9VkZ5PhqpQE5VKI=;
        b=r4s7af/BiH0jC1Zl3uYz3dXaJ6vZCPnYwIoZO+3Dc1VZ1w35Hbsa9IpCC/TqiN2a+Z
         y1esQ4R0zrFr3zITC1AqpJg+92lbz43G67jtwV7cgoK4fj0vdsnJTfTmsoHSWZ0P7nZH
         eYJ4SXZXaLNjb2V3e0L+4czSC/V1tfYcLEnT9sERhxnhBQi5YzawKNcpZCFFqOn+AnS/
         8WVoSyXYDg2/NMEtKWDY4/oMGWcs3qDi+8N7xoUoJpu/HT/VjRYeL1ncBcTJw50qOxXA
         NE8djn0DGgYnzRYwT0PryBdrF79sGTonY1TymaopAXICF+0ZctGmiBJqgIgeYuGlRI2n
         8ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zrPxS3Yj7n4laF6P6tQ8nRH7VU6J9VkZ5PhqpQE5VKI=;
        b=mwD73Emsorf7pA+P2UKa5421hEGYDklk3IPtv5gjJqUu4XbShwSFFt2yf5WsxC4w4z
         CwRkJS659aqBobwbXQGj8qtLiaMz/oxbIfaJq8oUfBnYpQImDEy81XLR/MTbCoXUpjTD
         ahjjK1pNZJlA98BQRMKuON+OqDrD3/5zMxTA96GUPMsB+MdDLdjVFBD7RdZHYvVWzaYx
         VTheaUQNlou2uPpuErQo3HnLtFsx1XmVDyPdHd1TPLtd206hFzuzyqNA4hcW+exfS7ht
         JpWy3EhNe6GbepIxZf7OzQYV30u6X95XrWWDEN0drRd7bslxNF5JDPJ1nLapKuW+RL3E
         3aAA==
X-Gm-Message-State: AOAM5320hzvobA3c+PyFmJS7joGnBpGzrM1xWcTFZc5QGxedMUv2G7DC
        tu5BoxF2rUT3Bg+5Fow4DIKUhLcQveX1KruV
X-Google-Smtp-Source: ABdhPJyes5DFJT/9sMzPrZXdk8smFzu2cuLjtVwCBHs/vCZGg1St5rvfEC4t0PRdT0/ANLk5eIUQHQ==
X-Received: by 2002:a2e:a0d3:: with SMTP id f19mr12804809ljm.325.1600458519346;
        Fri, 18 Sep 2020 12:48:39 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a17sm766769lfd.148.2020.09.18.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 12:48:38 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Date:   Fri, 18 Sep 2020 21:48:15 +0200
Message-Id: <20200918194817.48921-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200918194817.48921-1-urezki@gmail.com>
References: <20200918194817.48921-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Some background and kfree_rcu()
===============================
The pointers to be freed are stored in the per-cpu array to improve
performance, to enable an easier-to-use API, to accommodate vmalloc
memmory and to support a single argument of the kfree_rcu() when only
a pointer is passed. More details are below.

In order to maintain such per-CPU arrays there is a need in dynamic
allocation when a current array is fully populated and a new block is
required. See below the example:

 0 1 2 3      0 1 2 3
|p|p|p|p| -> |p|p|p|p| -> NULL

there are two pointer-blocks, each one can store 4 addresses
which will be freed after a grace period is passed. In reality
we store PAGE_SIZE / sizeof(void *). So to maintain such blocks
a single page is obtain via the page allocator:

    bnode = (struct kvfree_rcu_bulk_data *)
        __get_free_page(GFP_NOWAIT | __GFP_NOWARN);

after that it is attached to the "head" and its "next" pointer is
set to previous "head", so the list of blocks can be maintained and
grow dynamically until it gets drained by the reclaiming thread.

Please note. There is always a fallback if an allocation fails. In the
single argument, this is a call to synchronize_rcu() and for the two
arguments case this is to use rcu_head structure embedded in the object
being free, and then paying cache-miss penalty, also invoke the kfree()
per object instead of kfree_bulk() for groups of objects.

Why we maintain arrays/blocks instead of linking objects by the regular
"struct rcu_head" technique. See below a few but main reasons:

a) A memory can be reclaimed by invoking of the kfree_bulk()
   interface that requires passing an array and number of
   entries in it. That reduces the per-object overhead caused
   by calling kfree() per-object. This reduces the reclamation
   time.

b) Improves locality and reduces the number of cache-misses, due to
   "pointer chasing" between objects, which can be far spread between
   each other.

c) Support a "single argument" in the kvfree_rcu()
   void *ptr = kvmalloc(some_bytes, GFP_KERNEL);
   if (ptr)
        kvfree_rcu(ptr);

   We need it when an "rcu_head" is not embed into a stucture but an
   object must be freed after a grace period. Therefore for the single
   argument, such objects cannot be queued on a linked list.

   So nowadays, since we do not have a single argument but we see the
   demand in it, to workaround it people just do a simple not efficient
   sequence:
   <snip>
       synchronize_rcu(); /* Can be long and blocks a current context */
       kfree(p);
   <snip>

   More details is here: https://lkml.org/lkml/2020/4/28/1626

d) To distinguish vmalloc pointers between SLAB ones. It becomes possible
   to invoke the right freeing API for the right kind of pointer, kfree_bulk()
   or TBD: vmalloc_bulk().

e) Speeding up the post-grace-period freeing reduces the chance of a flood
   of callback's OOMing the system.

Also, please have a look here: https://lkml.org/lkml/2020/7/30/1166

Proposal
========
Introduce a lock-free function that obtain a page from the per-cpu-lists
on current CPU. It returns NULL rather than acquiring any non-raw spinlock.

Description
===========
The page allocator has two phases, fast path and slow one. We are interested
in fast path and order-0 allocations. In its turn it is divided also into two
phases: lock-less and not:

1) As a first step the page allocator tries to obtain a page from the
   per-cpu-list, so each CPU has its own one. That is why this step is
   lock-less and fast. Basically it disables irqs on current CPU in order
   to access to per-cpu data and remove a first element from the pcp-list.
   An element/page is returned to an user.

2) If there is no any available page in per-cpu-list, the second step is
   involved. It removes a specified number of elements from the buddy allocator
   transferring them to the "supplied-list/per-cpu-list" described in [1].

Summarizing. The __rcu_alloc_page_lockless() covers only [1] and can not
do step [2], due to the fact that [2] requires an access to zone->lock.
It implies that it is super fast, but a higher rate of fails is also
expected.

Usage: __rcu_alloc_page_lockless();

Link: https://lore.kernel.org/lkml/20200814215206.GL3982@worktop.programming.kicks-ass.net/
Not-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/gfp.h |  1 +
 mm/page_alloc.c     | 82 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 67a0774e080b..c065031b4403 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -565,6 +565,7 @@ extern struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
 
 extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
 extern unsigned long get_zeroed_page(gfp_t gfp_mask);
+extern unsigned long __rcu_alloc_page_lockless(void);
 
 void *alloc_pages_exact(size_t size, gfp_t gfp_mask);
 void free_pages_exact(void *virt, size_t size);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e2bab486fea..360c68ea3491 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4908,6 +4908,88 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 }
 EXPORT_SYMBOL(__alloc_pages_nodemask);
 
+static struct page *__rmqueue_lockless(struct zone *zone, struct per_cpu_pages *pcp)
+{
+	struct list_head *list;
+	struct page *page;
+	int migratetype;
+
+	for (migratetype = 0; migratetype < MIGRATE_PCPTYPES; migratetype++) {
+		list = &pcp->lists[migratetype];
+		page = list_first_entry_or_null(list, struct page, lru);
+		if (page && !check_new_pcp(page)) {
+			list_del(&page->lru);
+			pcp->count--;
+			return page;
+		}
+	}
+
+	return NULL;
+}
+
+/*
+ * Semantic of this function illustrates that a page
+ * is obtained in lock-free maneer. Instead of going
+ * deeper in the page allocator, it uses the pcplists
+ * only. Such way provides lock-less allocation method.
+ *
+ * Some notes are below:
+ * - intended to use for RCU code only;
+ * - it does not use any atomic reserves.
+ */
+unsigned long __rcu_alloc_page_lockless(void)
+{
+	struct zonelist *zonelist =
+		node_zonelist(numa_node_id(), GFP_KERNEL);
+	struct zoneref *z, *preferred_zoneref;
+	struct per_cpu_pages *pcp;
+	struct page *page;
+	unsigned long flags;
+	struct zone *zone;
+
+	/*
+	 * If DEBUG_PAGEALLOC is enabled, the post_alloc_hook()
+	 * in the prep_new_page() function also does some extra
+	 * page mappings via __kernel_map_pages(), what is arch
+	 * specific. It is for debug purpose only.
+	 *
+	 * For example, powerpc variant of __kernel_map_pages()
+	 * uses sleep-able locks. Thus a lock-less access can
+	 * not be provided if debug option is activated. In that
+	 * case it is fine to revert and return NULL, since RCU
+	 * code has a fallback mechanism. It is OK if it is used
+	 * for debug kernel.
+	 */
+	if (IS_ENABLED(CONFIG_DEBUG_PAGEALLOC))
+		return 0;
+
+	/*
+	 * Preferred zone is a first one in the zonelist.
+	 */
+	preferred_zoneref = NULL;
+
+	for_each_zone_zonelist(zone, z, zonelist, ZONE_NORMAL) {
+		if (!preferred_zoneref)
+			preferred_zoneref = z;
+
+		local_irq_save(flags);
+		pcp = &this_cpu_ptr(zone->pageset)->pcp;
+		page = __rmqueue_lockless(zone, pcp);
+		if (page) {
+			__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
+			zone_statistics(preferred_zoneref->zone, zone);
+		}
+		local_irq_restore(flags);
+
+		if (page) {
+			prep_new_page(page, 0, 0, 0);
+			return (unsigned long) page_address(page);
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Common helper functions. Never use with __GFP_HIGHMEM because the returned
  * address cannot represent highmem pages. Use alloc_pages and then kmap if
-- 
2.20.1

