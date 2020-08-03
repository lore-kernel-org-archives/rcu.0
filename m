Return-Path: <SRS0=fpio=BN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2384EC433DF
	for <rcu@archiver.kernel.org>; Mon,  3 Aug 2020 16:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99EA20775
	for <rcu@archiver.kernel.org>; Mon,  3 Aug 2020 16:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaO6gNRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgHCQay (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHCQay (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 3 Aug 2020 12:30:54 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8386BC06174A;
        Mon,  3 Aug 2020 09:30:53 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so40322433ljg.13;
        Mon, 03 Aug 2020 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LX2ZzKNU6jkcmR29bK4t+yW3/VPBQyLrWkBfwHibAb0=;
        b=VaO6gNRbWWoT/GJfHPrVVQZtjdC3Wa1Xs1UA8viq7B7798xTMlHsn5P3CieHi1USiv
         qXaDTkLPzPc5rql7/H7C3SMPOnRzop1MhShA0fDuj4szfJOKWokBcjqv8VBSw+spbY45
         1kB/5FAJruCVxZAhV+dGSKMOB82fUjylcIY9x9EXDzRGqvgoFeOyVP8hbP09PAsvxehT
         Zcc6qjWOXs9mQeMm8um+Cx5JOAZrFoMxk1Fi2KpF1gDUsmyQlQ6epYBfl6LJdLVZ2LO8
         eDaSo4jfNdHOlOmcmKWKmPxOUidN+Cj5WeTGBVrbEtlji7nnKnoNA9cN5SSp5cg/056Y
         3NwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LX2ZzKNU6jkcmR29bK4t+yW3/VPBQyLrWkBfwHibAb0=;
        b=oYQ5+NuvfMotYL6Zc1tUOPYctcWgKUbGs7CU+rbr50iIJCNxurK3sYO0d5M+XVxAcT
         6eJbmc2lZWGWaYBVLarcU9vnODUrbWQ4lgqqvwpphHkVRtz7iHWsTcCq/RkGh16r+0Qi
         cloZLEK3bR00nzvorL4DdTca/Y1zBWDwlYVoEzVLlS+0XIcTeZsoOPqEiaq//OVml5CN
         /8TPu2lLSIzJTw5Aj0JXnSD8gf4mGN0tyX3WbkNPfwGEa6keG3M2wBXzobK1KBBKL1LT
         8wBlc89vbZwFWVNv8QjFtzxTJWRzs6MEPmnZf0QlIeLe1Ss02RBEMtkre/yciUheuveM
         vClg==
X-Gm-Message-State: AOAM533yqjgnm2vpUtdv745gH9w1Ic0Go8Zu4GNvJFxGuHwgckxsLvph
        +MswTHBuZL5cH/D/Jy+QkfydlMecZPk=
X-Google-Smtp-Source: ABdhPJxX2c1VYw//a2cLxUfkeBcllRfg7MvgmqhPl+cUl2yfdBUQCGtMIBTb5kU6XEnLiDlqKfbGNQ==
X-Received: by 2002:a2e:b0ca:: with SMTP id g10mr7003749ljl.230.1596472251007;
        Mon, 03 Aug 2020 09:30:51 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s4sm5024373lfc.56.2020.08.03.09.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:30:50 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [RFC-PROTOTYPE 1/1] mm: Add __GFP_FAST_TRY flag
Date:   Mon,  3 Aug 2020 18:30:29 +0200
Message-Id: <20200803163029.1997-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
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

Proposals
=========
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

A number of pre-fetched elements seems does not depend on amount of the
physical memory in a system. In my case it is 63 pages. This step is not
lock-less. It uses spinlock_t for accessing to the body's zone. This
step is fully covered in the rmqueue_bulk() function.

Summarizing. The __GFP_FAST_TRY covers only [1] and can not do step [2],
due to the fact that [2] acquires spinlock_t. It implies that it is super
fast, but a higher rate of fails is also expected.

Usage: __get_free_page(__GFP_FAST_TRY);

2) There was a proposal from Matthew Wilcox: https://lkml.org/lkml/2020/7/31/1015

<snip>
On non-RT, we could make that lock a raw spinlock.  On RT, we could
decline to take the lock.  We'd need to abstract the spin_lock() away
behind zone_lock(zone), but that should be OK.
<snip>

It would be great to use any existing flag, say GFP_NOWAIT. Suppose we
decline to take the lock across the page allocator for RT. But there is
at least one path that does it outside of the page allocator. GFP_NOWAIT
can wakeup the kswapd, whereas a "wake-up path" uses sleepable lock:

wakeup_kswapd() -> wake_up_interruptible(&pgdat->kswapd_wait).

Probably it can be fixed by the excluding of waking of the kswapd process
defining something like below:

what is equal to zero and i am not sure if __get_free_page(0) handles
all that correctly, though it allocates and seems working on my test
machine! Please note it is related to "if we can reuse existing flags".

In the meantime, please see below for a patch that adds a __GFP_FAST_TRY,
which can at least serve as a baseline against which other proposals can
be compared. The patch is based on the 5.8.0-rc3.

Please RFC.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/gfp.h            |  6 ++++--
 include/trace/events/mmflags.h |  1 +
 mm/page_alloc.c                | 31 +++++++++++++++++++++++++------
 mm/slab.c                      |  2 ++
 mm/slab.h                      |  2 ++
 mm/slob.c                      |  2 ++
 mm/slub.c                      |  1 +
 tools/perf/builtin-kmem.c      |  1 +
 8 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 67a0774e080b..2df8d1646102 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -39,8 +39,9 @@ struct vm_area_struct;
 #define ___GFP_HARDWALL		0x100000u
 #define ___GFP_THISNODE		0x200000u
 #define ___GFP_ACCOUNT		0x400000u
+#define ___GFP_FAST_TRY		0x800000u
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x800000u
+#define ___GFP_NOLOCKDEP	0x1000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -219,12 +220,13 @@ struct vm_area_struct;
 #define __GFP_NOWARN	((__force gfp_t)___GFP_NOWARN)
 #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
 #define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
+#define __GFP_FAST_TRY	((__force gfp_t)___GFP_FAST_TRY)
 
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (24 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 5fb752034386..0d2b5678029b 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -45,6 +45,7 @@
 	{(unsigned long)__GFP_RECLAIMABLE,	"__GFP_RECLAIMABLE"},	\
 	{(unsigned long)__GFP_MOVABLE,		"__GFP_MOVABLE"},	\
 	{(unsigned long)__GFP_ACCOUNT,		"__GFP_ACCOUNT"},	\
+	{(unsigned long)__GFP_FAST_TRY,		"__GFP_FAST_TRY"},	\
 	{(unsigned long)__GFP_WRITE,		"__GFP_WRITE"},		\
 	{(unsigned long)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
 	{(unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48eb0f1410d4..3733169384d2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3307,7 +3307,8 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
 }
 
 /* Remove page from the per-cpu list, caller must protect the list */
-static struct page *__rmqueue_pcplist(struct zone *zone, int migratetype,
+static struct page *__rmqueue_pcplist(struct zone *zone, gfp_t gfp_flags,
+			int migratetype,
 			unsigned int alloc_flags,
 			struct per_cpu_pages *pcp,
 			struct list_head *list)
@@ -3316,7 +3317,8 @@ static struct page *__rmqueue_pcplist(struct zone *zone, int migratetype,
 
 	do {
 		if (list_empty(list)) {
-			pcp->count += rmqueue_bulk(zone, 0,
+			if (!(gfp_flags & __GFP_FAST_TRY))
+				pcp->count += rmqueue_bulk(zone, 0,
 					pcp->batch, list,
 					migratetype, alloc_flags);
 			if (unlikely(list_empty(list)))
@@ -3340,11 +3342,23 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct list_head *list;
 	struct page *page;
 	unsigned long flags;
+	int i;
 
 	local_irq_save(flags);
 	pcp = &this_cpu_ptr(zone->pageset)->pcp;
-	list = &pcp->lists[migratetype];
-	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
+
+	if (!(gfp_flags & __GFP_FAST_TRY)) {
+		list = &pcp->lists[migratetype];
+		page = __rmqueue_pcplist(zone, gfp_flags, migratetype, alloc_flags, pcp, list);
+	} else {
+		for (i = migratetype; i < MIGRATE_PCPTYPES; i++) {
+			list = &pcp->lists[i];
+			page = __rmqueue_pcplist(zone, gfp_flags, i, alloc_flags, pcp, list);
+			if (page)
+				break;
+		}
+	}
+
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone);
@@ -3756,7 +3770,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * grow this zone if it contains deferred pages.
 			 */
 			if (static_branch_unlikely(&deferred_pages)) {
-				if (_deferred_grow_zone(zone, order))
+				if (!(gfp_mask & __GFP_FAST_TRY) &&
+						_deferred_grow_zone(zone, order))
 					goto try_this_zone;
 			}
 #endif
@@ -3801,7 +3816,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				reserve_highatomic_pageblock(page, zone, order);
 
 			return page;
-		} else {
+		} else if (!(gfp_mask & __GFP_FAST_TRY)) {
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/* Try again if zone has deferred pages */
 			if (static_branch_unlikely(&deferred_pages)) {
@@ -4845,6 +4860,10 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	if (likely(page))
 		goto out;
 
+	/* Bypass slow path if __GFP_FAST_TRY. */
+	if ((gfp_mask & __GFP_FAST_TRY))
+		goto out;
+
 	/*
 	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
 	 * resp. GFP_NOIO which has to be inherited for all allocation requests
diff --git a/mm/slab.c b/mm/slab.c
index 9350062ffc1a..f65570b28fdd 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3224,6 +3224,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid,
 	int slab_node = numa_mem_id();
 
 	flags &= gfp_allowed_mask;
+	/* flags &= (gfp_allowed_mask & ~__GFP_FAST_TRY); */
 	cachep = slab_pre_alloc_hook(cachep, flags);
 	if (unlikely(!cachep))
 		return NULL;
@@ -3303,6 +3304,7 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, unsigned long caller)
 	void *objp;
 
 	flags &= gfp_allowed_mask;
+	/* flags &= (gfp_allowed_mask & ~__GFP_FAST_TRY); */
 	cachep = slab_pre_alloc_hook(cachep, flags);
 	if (unlikely(!cachep))
 		return NULL;
diff --git a/mm/slab.h b/mm/slab.h
index 74f7e09a7cfd..56b84fc617e1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -560,6 +560,7 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 						     gfp_t flags)
 {
 	flags &= gfp_allowed_mask;
+	/* flags &= (gfp_allowed_mask & ~__GFP_FAST_TRY); */
 
 	fs_reclaim_acquire(flags);
 	fs_reclaim_release(flags);
@@ -582,6 +583,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
 	size_t i;
 
 	flags &= gfp_allowed_mask;
+	/* flags &= (gfp_allowed_mask & ~__GFP_FAST_TRY); */
 	for (i = 0; i < size; i++) {
 		p[i] = kasan_slab_alloc(s, p[i], flags);
 		/* As p[i] might get tagged, call kmemleak hook after KASAN. */
diff --git a/mm/slob.c b/mm/slob.c
index ac2aecfbc7a8..f322c6f8c7a6 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -473,6 +473,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 	void *ret;
 
 	gfp &= gfp_allowed_mask;
+	/* gfp &= (gfp_allowed_mask & ~__GFP_FAST_TRY); */
 
 	fs_reclaim_acquire(gfp);
 	fs_reclaim_release(gfp);
@@ -596,6 +597,7 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 	void *b;
 
 	flags &= gfp_allowed_mask;
+	/* flags &= (gfp_allowed_mask & ~__GFP_FAST_TRY); */
 
 	fs_reclaim_acquire(flags);
 	fs_reclaim_release(flags);
diff --git a/mm/slub.c b/mm/slub.c
index ef303070d175..9712a91533a4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1673,6 +1673,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	bool shuffle;
 
 	flags &= gfp_allowed_mask;
+	/* flags &= (gfp_allowed_mask & ~__GFP_FAST_TRY); */
 
 	if (gfpflags_allow_blocking(flags))
 		local_irq_enable();
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 38a5ab683ebc..71df51f0a90f 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -656,6 +656,7 @@ static const struct {
 	{ "__GFP_RECLAIMABLE",		"RC" },
 	{ "__GFP_MOVABLE",		"M" },
 	{ "__GFP_ACCOUNT",		"AC" },
+	{ "__GFP_FAST_TRY",		"FT" },
 	{ "__GFP_WRITE",		"WR" },
 	{ "__GFP_RECLAIM",		"R" },
 	{ "__GFP_DIRECT_RECLAIM",	"DR" },
-- 
2.20.1

