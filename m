Return-Path: <SRS0=RTr5=BT=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C7AC433E3
	for <rcu@archiver.kernel.org>; Sun,  9 Aug 2020 20:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C8F206D8
	for <rcu@archiver.kernel.org>; Sun,  9 Aug 2020 20:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAE2+Df0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHIUoJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgHIUoH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 9 Aug 2020 16:44:07 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419E7C061756;
        Sun,  9 Aug 2020 13:44:07 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x24so3646705lfe.11;
        Sun, 09 Aug 2020 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdFb3yTk8VezuNLtMJbTJ6je149Jso+TLVwr4gYTmZw=;
        b=QAE2+Df0NGuJhMW10rBMlRh3YZnhNfnvXScwsMEnH2ZctoDrYDnq9dLzvfm0l1mGBU
         jXbpYqGcTZLW5/Yq80NkLF2CScvK8Cv4FX49ISCjVpjRxXa9QSSlRpKP8+sR1IixgD6S
         B0uNXaOvTroAjhNeUXWVrlieOEuVlAX4iXRLc5xaihDWqhn61tx9qqkYWG0ej+fFX9Bs
         7e2a8FRHKgW+PCFqEM9iKmAmHoQGr70KX+uN9FfWK8P9EH7+s+RuxDbs8RjVbcLyYJ8C
         fSKn2BO3tMlpHUIbvmV94lA2B0TUT/IHazqd85tRXp5FwGvgSCfUMKrotQdVGYVtc6is
         Qkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdFb3yTk8VezuNLtMJbTJ6je149Jso+TLVwr4gYTmZw=;
        b=Bt2yWp5i6abWl53MDqM9zvBAH30/F3H62tXJNDZNXPubZ19psBeztL2kYAbmJT2EeR
         ggFQi9nVCAFv4Y3AmZtEGuE1R/wCM/9TuD/ZQ5/3nN+8J8COj2QCHGR/hf85Ee1WiDn9
         CgwtVU3wwzGgMMg/T4knmfSNaFJsx9iUj5LgzgjSseCJItv/iqz9g+WYOxlLqhst1BNh
         NYzte2brgDbAOgj8WhQeVepAzPtLjAZsYviFeNGw+ErfEewCjIEcEY/p4BlDt2ItU/RD
         lrP6mNFfOWkHmuJ/AE7pRfP3Azk+vaP0J/xeEcALxLeiJKpEufVr7Z6B6GxRqxZ3TpUx
         CdWg==
X-Gm-Message-State: AOAM533TaQuaqcolCW8pIncgzlypC4ITr8c1Q4LBSTFhyKg8JVtfX4sB
        hSRb9SbAB3wAwy/tej8H1L+SGLpfW2g=
X-Google-Smtp-Source: ABdhPJxV0xcojitn7HTgaWaUyWTJaiK03XGhLzKsPODPAqItS4ba69Blwq1FsEmIHjeTokFV/OpN9w==
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr11378403lfz.157.1597005844947;
        Sun, 09 Aug 2020 13:44:04 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id c17sm9529603lfr.23.2020.08.09.13.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 13:44:04 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Date:   Sun,  9 Aug 2020 22:43:53 +0200
Message-Id: <20200809204354.20137-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200809204354.20137-1-urezki@gmail.com>
References: <20200809204354.20137-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
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

Also, please have a look here: https://lkml.org/lkml/2020/7/30/1166

Limitations and concerns (Main part)
====================================
The current memmory-allocation interface presents to following
difficulties that this patch is designed to overcome:

a) If built with CONFIG_PROVE_RAW_LOCK_NESTING, the lockdep will
   complain about violation("BUG: Invalid wait context") of the
   nesting rules. It does the raw_spinlock vs. spinlock nesting
   checks, i.e. it is not legal to acquire a spinlock_t while
   holding a raw_spinlock_t.

   Internally the kfree_rcu() uses raw_spinlock_t(in rcu-dev branch)
   whereas the "page allocator" internally deals with spinlock_t to
   access to its zones. The code also can be broken from higher level
   of view:
   <snip>
       raw_spin_lock(&some_lock);
       kfree_rcu(some_pointer, some_field_offset);
   <snip>

b) If built with CONFIG_PREEMPT_RT. Please note, in that case spinlock_t
   is converted into sleepable variant. Invoking the page allocator from
   atomic contexts leads to "BUG: scheduling while atomic".

Proposal
========
1) Make GFP_* that ensures that the allocator returns NULL rather
than acquire its own spinlock_t. Having such flag will address a and b
limitations described above. It will also make the kfree_rcu() code
common for RT and regular kernel, more clean, less handling corner
cases and reduce the code size.

Description:
The page allocator has two phases, fast path and slow one. We are interested
in fast path and order-0 allocations. In its turn it is divided also into two
phases: lock-less and not:

a) As a first step the page allocator tries to obtain a page from the
   per-cpu-list, so each CPU has its own one. That is why this step is
   lock-less and fast. Basically it disables irqs on current CPU in order
   to access to per-cpu data and remove a first element from the pcp-list.
   An element/page is returned to an user.

b) If there is no any available page in per-cpu-list, the second step is
   involved. It removes a specified number of elements from the buddy allocator
   transferring them to the "supplied-list/per-cpu-list" described in [1].

A number of pre-fetched elements can be controlled via sysfs attribute.
Please see the /proc/sys/vm/percpu_pagelist_fraction. This step is not
lock-less. It uses spinlock_t for accessing to the buddy zone. This
step is fully covered by the rmqueue_bulk() function.

Summarizing. The __GFP_NO_LOCKS covers only [1] and can not do step [2],
due to the fact that [2] acquires spinlock_t. It implies that it is super
fast, but a higher rate of fails is also expected. Having such flag will
address (a) and (b) limitations described above.

Usage: __get_free_page(__GFP_NO_LOCKS);

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/gfp.h            | 11 +++++++++--
 include/trace/events/mmflags.h |  1 +
 mm/page_alloc.c                | 31 +++++++++++++++++++++++++------
 tools/perf/builtin-kmem.c      |  1 +
 4 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 67a0774e080b..c6f11481c42a 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -39,8 +39,9 @@ struct vm_area_struct;
 #define ___GFP_HARDWALL		0x100000u
 #define ___GFP_THISNODE		0x200000u
 #define ___GFP_ACCOUNT		0x400000u
+#define ___GFP_NO_LOCKS		0x800000u
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x800000u
+#define ___GFP_NOLOCKDEP	0x1000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -215,16 +216,22 @@ struct vm_area_struct;
  * %__GFP_COMP address compound page metadata.
  *
  * %__GFP_ZERO returns a zeroed page on success.
+ *
+ * %__GFP_NO_LOCKS order-0 allocation without sleepable-locks.
+ * It obtains a page from the per-cpu-list and considered as
+ * lock-less. No other actions are performed, thus it returns
+ * NULL if per-cpu-list is empty.
  */
 #define __GFP_NOWARN	((__force gfp_t)___GFP_NOWARN)
 #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
 #define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
+#define __GFP_NO_LOCKS	((__force gfp_t)___GFP_NO_LOCKS)
 
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (24 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 939092dbcb8b..653c56c478ad 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -45,6 +45,7 @@
 	{(unsigned long)__GFP_RECLAIMABLE,	"__GFP_RECLAIMABLE"},	\
 	{(unsigned long)__GFP_MOVABLE,		"__GFP_MOVABLE"},	\
 	{(unsigned long)__GFP_ACCOUNT,		"__GFP_ACCOUNT"},	\
+	{(unsigned long)__GFP_NO_LOCKS,		"__GFP_NO_LOCKS"},	\
 	{(unsigned long)__GFP_WRITE,		"__GFP_WRITE"},		\
 	{(unsigned long)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
 	{(unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e4896e674594..8bf1e3a9a1c3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3305,7 +3305,8 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
 }
 
 /* Remove page from the per-cpu list, caller must protect the list */
-static struct page *__rmqueue_pcplist(struct zone *zone, int migratetype,
+static struct page *__rmqueue_pcplist(struct zone *zone, gfp_t gfp_flags,
+			int migratetype,
 			unsigned int alloc_flags,
 			struct per_cpu_pages *pcp,
 			struct list_head *list)
@@ -3314,7 +3315,8 @@ static struct page *__rmqueue_pcplist(struct zone *zone, int migratetype,
 
 	do {
 		if (list_empty(list)) {
-			pcp->count += rmqueue_bulk(zone, 0,
+			if (!(gfp_flags & __GFP_NO_LOCKS))
+				pcp->count += rmqueue_bulk(zone, 0,
 					pcp->batch, list,
 					migratetype, alloc_flags);
 			if (unlikely(list_empty(list)))
@@ -3341,8 +3343,20 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 
 	local_irq_save(flags);
 	pcp = &this_cpu_ptr(zone->pageset)->pcp;
-	list = &pcp->lists[migratetype];
-	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
+
+	if (!(gfp_flags & __GFP_NO_LOCKS)) {
+		list = &pcp->lists[migratetype];
+		page = __rmqueue_pcplist(zone, gfp_flags, migratetype, alloc_flags, pcp, list);
+	} else {
+		/* Iterate over all migrate types of the pcp-lists. */
+		for (migratetype = 0; migratetype < MIGRATE_PCPTYPES; migratetype++) {
+			list = &pcp->lists[migratetype];
+			page = __rmqueue_pcplist(zone, gfp_flags, migratetype, alloc_flags, pcp, list);
+			if (page)
+				break;
+		}
+	}
+
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone);
@@ -3790,7 +3804,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * grow this zone if it contains deferred pages.
 			 */
 			if (static_branch_unlikely(&deferred_pages)) {
-				if (_deferred_grow_zone(zone, order))
+				if (!(gfp_mask & __GFP_NO_LOCKS) &&
+						_deferred_grow_zone(zone, order))
 					goto try_this_zone;
 			}
 #endif
@@ -3835,7 +3850,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				reserve_highatomic_pageblock(page, zone, order);
 
 			return page;
-		} else {
+		} else if (!(gfp_mask & __GFP_NO_LOCKS)) {
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/* Try again if zone has deferred pages */
 			if (static_branch_unlikely(&deferred_pages)) {
@@ -4880,6 +4895,10 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	if (likely(page))
 		goto out;
 
+	/* Bypass slow path if __GFP_NO_LOCKS. */
+	if ((gfp_mask & __GFP_NO_LOCKS))
+		goto out;
+
 	/*
 	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
 	 * resp. GFP_NOIO which has to be inherited for all allocation requests
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 38a5ab683ebc..662e1d9a0e99 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -656,6 +656,7 @@ static const struct {
 	{ "__GFP_RECLAIMABLE",		"RC" },
 	{ "__GFP_MOVABLE",		"M" },
 	{ "__GFP_ACCOUNT",		"AC" },
+	{ "__GFP_NO_LOCKS",		"NL" },
 	{ "__GFP_WRITE",		"WR" },
 	{ "__GFP_RECLAIM",		"R" },
 	{ "__GFP_DIRECT_RECLAIM",	"DR" },
-- 
2.20.1

