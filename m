Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB8CC1B0D9
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 00:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23B922D73
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 00:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgLEAll (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Dec 2020 19:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgLEAll (ORCPT <rfc822;rcu@vger.kernel.org>);
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
Subject: [PATCH sl-b 2/6] mm: Add kmem_last_alloc_errstring() to provide more kmem_last_alloc() info
Date:   Fri,  4 Dec 2020 16:40:53 -0800
Message-Id: <20201205004057.32199-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201205004022.GA31166@paulmck-ThinkPad-P72>
References: <20201205004022.GA31166@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

NULL pointers can be useful, but the NULL pointers from kmem_last_alloc()
might be caused by any number of things: A not-to-a-slab pointer,
failure to enable all the needed debugging, and bogus slob block-address
computations.  This commit therefore introduces error codes to the
kmem_last_alloc() function using the ERR_PTR() facility, and also
introduces kmem_last_alloc_errstring(), which translates the error codes
into strings.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/slab.h | 10 ++++++++++
 mm/slab.c            |  2 +-
 mm/slab_common.c     | 28 ++++++++++++++++++++++++++--
 mm/slob.c            |  2 +-
 mm/slub.c            |  4 ++--
 5 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 06dd56b..031e630 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -133,6 +133,15 @@
 #define ZERO_OR_NULL_PTR(x) ((unsigned long)(x) <= \
 				(unsigned long)ZERO_SIZE_PTR)
 
+/*
+ * kmem_last_alloc error codes.
+ */
+#define KMEM_LA_NO_PAGE		1  /* No page structure for pointer. */
+#define KMEM_LA_NO_SLAB		2  /* Pointer not from slab allocator. */
+#define KMEM_LA_SLOB		3  /* No debugging info for slob. */
+#define KMEM_LA_NO_DEBUG	4  /* Debugging not enabled for slab/slub. */
+#define KMEM_LA_INCONSISTENT	5  /* Bogus block within slub page. */
+
 #include <linux/kasan.h>
 
 struct mem_cgroup;
@@ -188,6 +197,7 @@ size_t __ksize(const void *);
 size_t ksize(const void *);
 void *kmem_cache_last_alloc(struct kmem_cache *s, void *object);
 void *kmem_last_alloc(void *object);
+const char *kmem_last_alloc_errstring(void *lastalloc);
 
 #ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
 void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
diff --git a/mm/slab.c b/mm/slab.c
index 2ab93b8..1f3b263 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3610,7 +3610,7 @@ void *kmem_cache_last_alloc(struct kmem_cache *cachep, void *object)
 	struct page *page;
 
 	if (!(cachep->flags & SLAB_STORE_USER))
-		return NULL;
+		return ERR_PTR(-KMEM_LA_NO_DEBUG);
 	objp = object - obj_offset(cachep);
 	page = virt_to_head_page(objp);
 	objnr = obj_to_index(cachep, page, objp);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 3f647982..8430a14 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -537,6 +537,30 @@ bool slab_is_available(void)
 }
 
 /*
+ * If the pointer corresponds to a kmem_last_alloc() error, return
+ * a pointer to the corresponding string, otherwise NULL.
+ */
+const char *kmem_last_alloc_errstring(void *lastalloc)
+{
+	long klaerrno;
+	static const char * const es[] = {
+		"local memory",			/* KMEM_LA_NO_PAGE - 1 */
+		"non-slab memory",		/* KMEM_LA_NO_SLAB - 1 */
+		"slob doesn't do debug",	/* KMEM_LA_SLOB - 1 */
+		"debugging disabled",		/* KMEM_LA_NO_DEBUG - 1 */
+		"bogus slub block",		/* KMEM_LA_INCONSISTENT - 1 */
+	};
+
+	if (!IS_ERR(lastalloc))
+		return NULL;
+	klaerrno = -PTR_ERR(lastalloc) - 1;
+	if (WARN_ON_ONCE(klaerrno >= ARRAY_SIZE(es)))
+		return "kmem_last_alloc error out of range";
+	return es[klaerrno];
+}
+EXPORT_SYMBOL_GPL(kmem_last_alloc_errstring);
+
+/*
  * If the pointer references a slab-allocated object and if sufficient
  * debugging is enabled, return the returrn address for the corresponding
  * allocation.  Otherwise, return NULL.  Note that passing random pointers
@@ -548,10 +572,10 @@ void *kmem_last_alloc(void *object)
 	struct page *page;
 
 	if (!virt_addr_valid(object))
-		return NULL;
+		return ERR_PTR(-KMEM_LA_NO_PAGE);
 	page = virt_to_head_page(object);
 	if (!PageSlab(page))
-		return NULL;
+		return ERR_PTR(-KMEM_LA_NO_SLAB);
 	return kmem_cache_last_alloc(page->slab_cache, object);
 }
 EXPORT_SYMBOL_GPL(kmem_last_alloc);
diff --git a/mm/slob.c b/mm/slob.c
index c1f8ed7..e7d6b90 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -463,7 +463,7 @@ static void slob_free(void *block, int size)
 
 void *kmem_cache_last_alloc(struct kmem_cache *s, void *object)
 {
-	return NULL;
+	return ERR_PTR(-KMEM_LA_SLOB);
 }
 
 /*
diff --git a/mm/slub.c b/mm/slub.c
index 8ed3ba2..3ddf16a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3928,7 +3928,7 @@ void *kmem_cache_last_alloc(struct kmem_cache *s, void *object)
 	struct track *trackp;
 
 	if (!(s->flags & SLAB_STORE_USER))
-		return NULL;
+		return ERR_PTR(-KMEM_LA_NO_DEBUG);
 	page = virt_to_head_page(object);
 	base = page_address(page);
 	objp = kasan_reset_tag(object);
@@ -3936,7 +3936,7 @@ void *kmem_cache_last_alloc(struct kmem_cache *s, void *object)
 	objnr = obj_to_index(s, page, objp);
 	objp = base + s->size * objnr;
 	if (objp < base || objp >= base + page->objects * s->size || (objp - base) % s->size)
-		return NULL;
+		return ERR_PTR(-KMEM_LA_INCONSISTENT);
 	trackp = get_track(s, objp, TRACK_ALLOC);
 	return (void *)trackp->addr;
 #else
-- 
2.9.5

