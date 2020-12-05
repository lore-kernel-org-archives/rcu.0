Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E308C2BB40
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 00:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14D922D71
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 00:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgLEAll (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Dec 2020 19:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgLEAlk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Dec 2020 19:41:40 -0500
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
Subject: [PATCH sl-b 1/6] mm: Add kmem_last_alloc() to return last allocation for memory block
Date:   Fri,  4 Dec 2020 16:40:52 -0800
Message-Id: <20201205004057.32199-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201205004022.GA31166@paulmck-ThinkPad-P72>
References: <20201205004022.GA31166@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

There are kernel facilities such as per-CPU reference counts that give
error messages in generic handlers or callbacks, whose messages are
unenlightening.  In the case of per-CPU reference-count underflow, this
is not a problem when creating a new use of this facility because in that
case the bug is almost certainly in the code implementing that new use.
However, trouble arises when deploying across many systems, which might
exercise corner cases that were not seen during development and testing.
Here, it would be really nice to get some kind of hint as to which of
several uses the underflow was caused by.

This commit therefore exposes a new kmem_last_alloc() function that
takes a pointer to dynamically allocated memory and returns the return
address of the call that allocated it.  This pointer can reference the
middle of the block as well as the beginning of the block, as needed
by things like RCU callback functions and timer handlers that might not
know where the beginning of the memory block is.  These functions and
handlers can use the return value from kmem_last_alloc() to give the
kernel hacker a better hint as to where the problem might lie.

This kmem_last_alloc() function returns NULL for slob and when the
necessary debug has not been enabled for slab and slub.  For slub,
build with CONFIG_SLUB_DEBUG=y and boot with slub_debug=U, or pass
SLAB_STORE_USER to kmem_cache_create() if more focused use is desired.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/slab.h |  2 ++
 mm/slab.c            | 19 +++++++++++++++++++
 mm/slab_common.c     | 20 ++++++++++++++++++++
 mm/slob.c            |  5 +++++
 mm/slub.c            | 26 ++++++++++++++++++++++++++
 5 files changed, 72 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index dd6897f..06dd56b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -186,6 +186,8 @@ void kfree(const void *);
 void kfree_sensitive(const void *);
 size_t __ksize(const void *);
 size_t ksize(const void *);
+void *kmem_cache_last_alloc(struct kmem_cache *s, void *object);
+void *kmem_last_alloc(void *object);
 
 #ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
 void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
diff --git a/mm/slab.c b/mm/slab.c
index b111356..2ab93b8 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3602,6 +3602,25 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
 #endif
 
+void *kmem_cache_last_alloc(struct kmem_cache *cachep, void *object)
+{
+#ifdef DEBUG
+	unsigned int objnr;
+	void *objp;
+	struct page *page;
+
+	if (!(cachep->flags & SLAB_STORE_USER))
+		return NULL;
+	objp = object - obj_offset(cachep);
+	page = virt_to_head_page(objp);
+	objnr = obj_to_index(cachep, page, objp);
+	objp = index_to_obj(cachep, page, objnr);
+	return *dbg_userword(cachep, objp);
+#else
+	return NULL;
+#endif
+}
+
 static __always_inline void *
 __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
 {
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f9ccd5d..3f647982 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -536,6 +536,26 @@ bool slab_is_available(void)
 	return slab_state >= UP;
 }
 
+/*
+ * If the pointer references a slab-allocated object and if sufficient
+ * debugging is enabled, return the returrn address for the corresponding
+ * allocation.  Otherwise, return NULL.  Note that passing random pointers
+ * to this function (including addresses of on-stack variables) is likely
+ * to result in panics.
+ */
+void *kmem_last_alloc(void *object)
+{
+	struct page *page;
+
+	if (!virt_addr_valid(object))
+		return NULL;
+	page = virt_to_head_page(object);
+	if (!PageSlab(page))
+		return NULL;
+	return kmem_cache_last_alloc(page->slab_cache, object);
+}
+EXPORT_SYMBOL_GPL(kmem_last_alloc);
+
 #ifndef CONFIG_SLOB
 /* Create a cache during boot when no slab services are available yet */
 void __init create_boot_cache(struct kmem_cache *s, const char *name,
diff --git a/mm/slob.c b/mm/slob.c
index 7cc9805..c1f8ed7 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -461,6 +461,11 @@ static void slob_free(void *block, int size)
 	spin_unlock_irqrestore(&slob_lock, flags);
 }
 
+void *kmem_cache_last_alloc(struct kmem_cache *s, void *object)
+{
+	return NULL;
+}
+
 /*
  * End of slob allocator proper. Begin kmem_cache_alloc and kmalloc frontend.
  */
diff --git a/mm/slub.c b/mm/slub.c
index b30be23..8ed3ba2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3918,6 +3918,32 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	return 0;
 }
 
+void *kmem_cache_last_alloc(struct kmem_cache *s, void *object)
+{
+#ifdef CONFIG_SLUB_DEBUG
+	void *base;
+	unsigned int objnr;
+	void *objp;
+	struct page *page;
+	struct track *trackp;
+
+	if (!(s->flags & SLAB_STORE_USER))
+		return NULL;
+	page = virt_to_head_page(object);
+	base = page_address(page);
+	objp = kasan_reset_tag(object);
+	objp = restore_red_left(s, objp);
+	objnr = obj_to_index(s, page, objp);
+	objp = base + s->size * objnr;
+	if (objp < base || objp >= base + page->objects * s->size || (objp - base) % s->size)
+		return NULL;
+	trackp = get_track(s, objp, TRACK_ALLOC);
+	return (void *)trackp->addr;
+#else
+	return NULL;
+#endif
+}
+
 /********************************************************************
  *		Kmalloc subsystem
  *******************************************************************/
-- 
2.9.5

