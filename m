Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3D9C47434
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 00:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D99122D71
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 00:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgLEAlm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Dec 2020 19:41:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgLEAll (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Dec 2020 19:41:41 -0500
From:   paulmck@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org
Subject: [PATCH sl-b 4/6] mm: Create kmem_last_alloc_stack() to provide stack trace in slub
Date:   Fri,  4 Dec 2020 16:40:55 -0800
Message-Id: <20201205004057.32199-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201205004022.GA31166@paulmck-ThinkPad-P72>
References: <20201205004022.GA31166@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In some cases, the allocator return address is in a common function,
so that more information is desired.  For example, a percpu_ref
reference-count underflow only has access to a data structure that is
allocated in percpu_ref_init().  In this case, the return address from
the allocator provides no additional information.

This commit therefore creates a kmem_cache_last_alloc() function that
can be passed stackp and nstackp parameters, allowing CONFIG_STACKTRACE=y
slub stack traces to be provided to the caller.

Please note that stack traces cannot be provided unless they are
collected.  Collecting stack traces requires that the kernel: (1) Use
the slub allocator, (2) Be built with CONFIG_STACKTRACE=y (which is the
case when ftrace is configured), and (3) Have slub debugging enabled
one way or another, for example, by booting with the "slub_debug=U"
kernel boot parameter.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
[ paulmck: Move slab definition per Stephen Rothwell and kbuild test robot. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/slab.h |  3 ++-
 mm/slab.c            | 40 +++++++++++++++++++++-------------------
 mm/slab_common.c     | 39 ++++++++++++++++++++++++++++++++-------
 mm/slob.c            |  4 +++-
 mm/slub.c            | 14 +++++++++++++-
 5 files changed, 71 insertions(+), 29 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 031e630..bdedefd 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -195,8 +195,9 @@ void kfree(const void *);
 void kfree_sensitive(const void *);
 size_t __ksize(const void *);
 size_t ksize(const void *);
-void *kmem_cache_last_alloc(struct kmem_cache *s, void *object);
+void *kmem_cache_last_alloc(struct kmem_cache *s, void *object, void **stackp, int nstackp);
 void *kmem_last_alloc(void *object);
+void *kmem_last_alloc_stack(void *object, void **stackp, int nstackp);
 const char *kmem_last_alloc_errstring(void *lastalloc);
 
 #ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
diff --git a/mm/slab.c b/mm/slab.c
index 1f3b263..ae1a74c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3602,25 +3602,6 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
 #endif
 
-void *kmem_cache_last_alloc(struct kmem_cache *cachep, void *object)
-{
-#ifdef DEBUG
-	unsigned int objnr;
-	void *objp;
-	struct page *page;
-
-	if (!(cachep->flags & SLAB_STORE_USER))
-		return ERR_PTR(-KMEM_LA_NO_DEBUG);
-	objp = object - obj_offset(cachep);
-	page = virt_to_head_page(objp);
-	objnr = obj_to_index(cachep, page, objp);
-	objp = index_to_obj(cachep, page, objnr);
-	return *dbg_userword(cachep, objp);
-#else
-	return NULL;
-#endif
-}
-
 static __always_inline void *
 __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
 {
@@ -3652,6 +3633,27 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
 #endif /* CONFIG_NUMA */
 
+void *kmem_cache_last_alloc(struct kmem_cache *cachep, void *object, void **stackp, int nstackp)
+{
+#ifdef DEBUG
+	unsigned int objnr;
+	void *objp;
+	struct page *page;
+
+	if (!(cachep->flags & SLAB_STORE_USER))
+		return ERR_PTR(-KMEM_LA_NO_DEBUG);
+	objp = object - obj_offset(cachep);
+	page = virt_to_head_page(objp);
+	objnr = obj_to_index(cachep, page, objp);
+	objp = index_to_obj(cachep, page, objnr);
+	if (stackp && nstackp)
+		stackp[0] = NULL;
+	return *dbg_userword(cachep, objp);
+#else
+	return NULL;
+#endif
+}
+
 /**
  * __do_kmalloc - allocate memory
  * @size: how many bytes of memory are required.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8430a14..b70f357 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -560,14 +560,22 @@ const char *kmem_last_alloc_errstring(void *lastalloc)
 }
 EXPORT_SYMBOL_GPL(kmem_last_alloc_errstring);
 
-/*
+/**
+ * kmem_last_alloc_stack - Get return address and stack for last allocation
+ * @object: object for which to find last-allocation return address.
+ * @stackp: %NULL or pointer to location to place return-address stack.
+ * @nstackp: maximum number of return addresses that may be stored.
+ *
  * If the pointer references a slab-allocated object and if sufficient
- * debugging is enabled, return the returrn address for the corresponding
- * allocation.  Otherwise, return NULL.  Note that passing random pointers
- * to this function (including addresses of on-stack variables) is likely
- * to result in panics.
+ * debugging is enabled, return the return address for the corresponding
+ * allocation.  If stackp is non-%NULL in %CONFIG_STACKTRACE kernels running
+ * the slub allocator, also copy the return-address stack into @stackp,
+ * limited by @nstackp.  Otherwise, return %NULL or an appropriate error
+ * code using %ERR_PTR().
+ *
+ * Return: return address from last allocation, %NULL or negative error code.
  */
-void *kmem_last_alloc(void *object)
+void *kmem_last_alloc_stack(void *object, void **stackp, int nstackp)
 {
 	struct page *page;
 
@@ -576,7 +584,24 @@ void *kmem_last_alloc(void *object)
 	page = virt_to_head_page(object);
 	if (!PageSlab(page))
 		return ERR_PTR(-KMEM_LA_NO_SLAB);
-	return kmem_cache_last_alloc(page->slab_cache, object);
+	return kmem_cache_last_alloc(page->slab_cache, object, stackp, nstackp);
+}
+EXPORT_SYMBOL_GPL(kmem_last_alloc_stack);
+
+/**
+ * kmem_last_alloc - Get return address for last allocation
+ * @object: object for which to find last-allocation return address.
+ *
+ * If the pointer references a slab-allocated object and if sufficient
+ * debugging is enabled, return the return address for the corresponding
+ * allocation.  Otherwise, return %NULL or an appropriate error code using
+ * %ERR_PTR().
+ *
+ * Return: return address from last allocation, %NULL or negative error code.
+ */
+void *kmem_last_alloc(void *object)
+{
+	return kmem_last_alloc_stack(object, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(kmem_last_alloc);
 
diff --git a/mm/slob.c b/mm/slob.c
index e7d6b90..dab7f3b 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -461,8 +461,10 @@ static void slob_free(void *block, int size)
 	spin_unlock_irqrestore(&slob_lock, flags);
 }
 
-void *kmem_cache_last_alloc(struct kmem_cache *s, void *object)
+void *kmem_cache_last_alloc(struct kmem_cache *s, void *object, void **stackp, int nstackp)
 {
+	if (stackp && nstackp)
+		stackp[0] = NULL;
 	return ERR_PTR(-KMEM_LA_SLOB);
 }
 
diff --git a/mm/slub.c b/mm/slub.c
index 3ddf16a..a918b1d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3918,10 +3918,11 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	return 0;
 }
 
-void *kmem_cache_last_alloc(struct kmem_cache *s, void *object)
+void *kmem_cache_last_alloc(struct kmem_cache *s, void *object, void **stackp, int nstackp)
 {
 #ifdef CONFIG_SLUB_DEBUG
 	void *base;
+	int i = 0;
 	unsigned int objnr;
 	void *objp;
 	struct page *page;
@@ -3938,6 +3939,17 @@ void *kmem_cache_last_alloc(struct kmem_cache *s, void *object)
 	if (objp < base || objp >= base + page->objects * s->size || (objp - base) % s->size)
 		return ERR_PTR(-KMEM_LA_INCONSISTENT);
 	trackp = get_track(s, objp, TRACK_ALLOC);
+#ifdef CONFIG_STACKTRACE
+	if (stackp) {
+		for (; i < nstackp && i < TRACK_ADDRS_COUNT; i++) {
+			stackp[i] = (void *)trackp->addrs[i];
+			if (!stackp[i])
+				break;
+		}
+	}
+#endif
+	if (stackp && i < nstackp)
+		stackp[i] = NULL;
 	return (void *)trackp->addr;
 #else
 	return NULL;
-- 
2.9.5

