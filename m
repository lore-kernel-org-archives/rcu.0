Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA59EC433FE
	for <rcu@archiver.kernel.org>; Fri, 11 Dec 2020 01:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 739DE23DE3
	for <rcu@archiver.kernel.org>; Fri, 11 Dec 2020 01:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394740AbgLKBV3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Dec 2020 20:21:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404741AbgLKBUr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Dec 2020 20:20:47 -0500
From:   paulmck@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, iamjoonsoo.kim@lge.com,
        andrii@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: [PATCH v3 sl-b 1/6] mm: Add mem_dump_obj() to print source of memory block
Date:   Thu, 10 Dec 2020 17:19:58 -0800
Message-Id: <20201211012003.16473-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201211011907.GA16110@paulmck-ThinkPad-P72>
References: <20201211011907.GA16110@paulmck-ThinkPad-P72>
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

This commit therefore exposes a mem_dump_obj() function that takes
a pointer to memory (which must still be allocated if it has been
dynamically allocated) and prints available information on where that
memory came from.  This pointer can reference the middle of the block as
well as the beginning of the block, as needed by things like RCU callback
functions and timer handlers that might not know where the beginning of
the memory block is.  These functions and handlers can use mem_dump_obj()
to print out better hints as to where the problem might lie.

The information printed can depend on kernel configuration.  For example,
the allocation return address can be printed only for slab and slub,
and even then only when the necessary debug has been enabled.  For slab,
build with CONFIG_DEBUG_SLAB=y, and either use sizes with ample space
to the next power of two or use the SLAB_STORE_USER when creating the
kmem_cache structure.  For slub, build with CONFIG_SLUB_DEBUG=y and
boot with slub_debug=U, or pass SLAB_STORE_USER to kmem_cache_create()
if more focused use is desired.  Also for slub, use CONFIG_STACKTRACE
to enable printing of the allocation-time stack trace.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
[ paulmck: Convert to printing and change names per Joonsoo Kim. ]
[ paulmck: Move slab definition per Stephen Rothwell and kbuild test robot. ]
[ paulmck: Handle CONFIG_MMU=n case where vmalloc() is kmalloc(). ]
[ paulmck: Apply Vlastimil Babka feedback on slab.c kmem_provenance(). ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/mm.h   |  2 ++
 include/linux/slab.h |  2 ++
 mm/slab.c            | 20 ++++++++++++++
 mm/slab.h            | 12 +++++++++
 mm/slab_common.c     | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/slob.c            |  6 +++++
 mm/slub.c            | 36 +++++++++++++++++++++++++
 mm/util.c            | 24 +++++++++++++++++
 8 files changed, 176 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360fe..1eea266 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3153,5 +3153,7 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
 
 extern int sysctl_nr_trim_pages;
 
+void mem_dump_obj(void *object);
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/slab.h b/include/linux/slab.h
index dd6897f..169b511 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -186,6 +186,8 @@ void kfree(const void *);
 void kfree_sensitive(const void *);
 size_t __ksize(const void *);
 size_t ksize(const void *);
+bool kmem_valid_obj(void *object);
+void kmem_dump_obj(void *object);
 
 #ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
 void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
diff --git a/mm/slab.c b/mm/slab.c
index b111356..66f00ad 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3633,6 +3633,26 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
 #endif /* CONFIG_NUMA */
 
+void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
+{
+	struct kmem_cache *cachep;
+	unsigned int objnr;
+	void *objp;
+
+	kpp->kp_ptr = object;
+	kpp->kp_page = page;
+	cachep = page->slab_cache;
+	kpp->kp_slab_cache = cachep;
+	objp = object - obj_offset(cachep);
+	kpp->kp_data_offset = obj_offset(cachep);
+	page = virt_to_head_page(objp);
+	objnr = obj_to_index(cachep, page, objp);
+	objp = index_to_obj(cachep, page, objnr);
+	kpp->kp_objp = objp;
+	if (DEBUG && cachep->flags & SLAB_STORE_USER)
+		kpp->kp_ret = *dbg_userword(cachep, objp);
+}
+
 /**
  * __do_kmalloc - allocate memory
  * @size: how many bytes of memory are required.
diff --git a/mm/slab.h b/mm/slab.h
index 6d7c6a5..0dc705b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -630,4 +630,16 @@ static inline bool slab_want_init_on_free(struct kmem_cache *c)
 	return false;
 }
 
+#define KS_ADDRS_COUNT 16
+struct kmem_obj_info {
+	void *kp_ptr;
+	struct page *kp_page;
+	void *kp_objp;
+	unsigned long kp_data_offset;
+	struct kmem_cache *kp_slab_cache;
+	void *kp_ret;
+	void *kp_stack[KS_ADDRS_COUNT];
+};
+void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page);
+
 #endif /* MM_SLAB_H */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f9ccd5d..df2e203 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -536,6 +536,80 @@ bool slab_is_available(void)
 	return slab_state >= UP;
 }
 
+/**
+ * kmem_valid_obj - does the pointer reference a valid slab object?
+ * @object: pointer to query.
+ *
+ * Return: %true if the pointer is to a not-yet-freed object from
+ * kmalloc() or kmem_cache_alloc(), either %true or %false if the pointer
+ * is to an already-freed object, and %false otherwise.
+ */
+bool kmem_valid_obj(void *object)
+{
+	struct page *page;
+
+	if (!virt_addr_valid(object))
+		return false;
+	page = virt_to_head_page(object);
+	return PageSlab(page);
+}
+
+/**
+ * kmem_dump_obj - Print available slab provenance information
+ * @object: slab object for which to find provenance information.
+ *
+ * This function uses pr_cont(), so that the caller is expected to have
+ * printed out whatever preamble is appropriate.  The provenance information
+ * depends on the type of object and on how much debugging is enabled.
+ * For a slab-cache object, the fact that it is a slab object is printed,
+ * and, if available, the slab name, return address, and stack trace from
+ * the allocation of that object.
+ *
+ * This function will splat if passed a pointer to a non-slab object.
+ * If you are not sure what type of object you have, you should instead
+ * use mem_dump_obj().
+ */
+void kmem_dump_obj(void *object)
+{
+	char *cp = IS_ENABLED(CONFIG_MMU) ? "" : "/vmalloc";
+	int i;
+	struct page *page;
+	unsigned long ptroffset;
+	struct kmem_obj_info kp = { };
+
+	if (WARN_ON_ONCE(!virt_addr_valid(object)))
+		return;
+	page = virt_to_head_page(object);
+	if (WARN_ON_ONCE(!PageSlab(page))) {
+		pr_cont(" non-slab memory.\n");
+		return;
+	}
+	kmem_obj_info(&kp, object, page);
+	if (kp.kp_slab_cache)
+		pr_cont(" slab%s %s", cp, kp.kp_slab_cache->name);
+	else
+		pr_cont(" slab%s", cp);
+	if (kp.kp_objp)
+		pr_cont(" start %px", kp.kp_objp);
+	if (kp.kp_data_offset)
+		pr_cont(" data offset %lu", kp.kp_data_offset);
+	if (kp.kp_objp) {
+		ptroffset = ((char *)object - (char *)kp.kp_objp) - kp.kp_data_offset;
+		pr_cont(" pointer offset %lu", ptroffset);
+	}
+	if (kp.kp_slab_cache && kp.kp_slab_cache->usersize)
+		pr_cont(" size %u", kp.kp_slab_cache->usersize);
+	if (kp.kp_ret)
+		pr_cont(" allocated at %pS\n", kp.kp_ret);
+	else
+		pr_cont("\n");
+	for (i = 0; i < ARRAY_SIZE(kp.kp_stack); i++) {
+		if (!kp.kp_stack[i])
+			break;
+		pr_info("    %pS\n", kp.kp_stack[i]);
+	}
+}
+
 #ifndef CONFIG_SLOB
 /* Create a cache during boot when no slab services are available yet */
 void __init create_boot_cache(struct kmem_cache *s, const char *name,
diff --git a/mm/slob.c b/mm/slob.c
index 7cc9805..2ed1de2 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -461,6 +461,12 @@ static void slob_free(void *block, int size)
 	spin_unlock_irqrestore(&slob_lock, flags);
 }
 
+void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
+{
+	kpp->kp_ptr = object;
+	kpp->kp_page = page;
+}
+
 /*
  * End of slob allocator proper. Begin kmem_cache_alloc and kmalloc frontend.
  */
diff --git a/mm/slub.c b/mm/slub.c
index b30be23..0459d2a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3918,6 +3918,42 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	return 0;
 }
 
+void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
+{
+#ifdef CONFIG_SLUB_DEBUG
+	void *base;
+	int i;
+	unsigned int objnr;
+	void *objp;
+	void *objp0;
+	struct kmem_cache *s = page->slab_cache;
+	struct track *trackp;
+
+	kpp->kp_ptr = object;
+	kpp->kp_page = page;
+	kpp->kp_slab_cache = s;
+	base = page_address(page);
+	objp0 = kasan_reset_tag(object);
+	objp = restore_red_left(s, objp0);
+	objnr = obj_to_index(s, page, objp);
+	kpp->kp_data_offset = (unsigned long)((char *)objp0 - (char *)objp);
+	objp = base + s->size * objnr;
+	kpp->kp_objp = objp;
+	if (WARN_ON_ONCE(objp < base || objp >= base + page->objects * s->size || (objp - base) % s->size) ||
+	    !(s->flags & SLAB_STORE_USER))
+		return;
+	trackp = get_track(s, objp, TRACK_ALLOC);
+	kpp->kp_ret = (void *)trackp->addr;
+#ifdef CONFIG_STACKTRACE
+	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
+		kpp->kp_stack[i] = (void *)trackp->addrs[i];
+		if (!kpp->kp_stack[i])
+			break;
+	}
+#endif
+#endif
+}
+
 /********************************************************************
  *		Kmalloc subsystem
  *******************************************************************/
diff --git a/mm/util.c b/mm/util.c
index 4ddb6e1..f2e0c4d9 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -970,3 +970,27 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 	kunmap_atomic(addr1);
 	return ret;
 }
+
+/**
+ * mem_dump_obj - Print available provenance information
+ * @object: object for which to find provenance information.
+ *
+ * This function uses pr_cont(), so that the caller is expected to have
+ * printed out whatever preamble is appropriate.  The provenance information
+ * depends on the type of object and on how much debugging is enabled.
+ * For example, for a slab-cache object, the slab name is printed, and,
+ * if available, the return address and stack trace from the allocation
+ * of that object.
+ */
+void mem_dump_obj(void *object)
+{
+	if (!virt_addr_valid(object)) {
+		pr_cont(" non-paged (local) memory.\n");
+		return;
+	}
+	if (kmem_valid_obj(object)) {
+		kmem_dump_obj(object);
+		return;
+	}
+	pr_cont(" non-slab memory.\n");
+}
-- 
2.9.5

