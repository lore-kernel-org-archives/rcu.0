Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9063C433E6
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CA164EA4
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbhCDBA4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1447111AbhCDATs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:19:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A30BA60C41;
        Thu,  4 Mar 2021 00:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817050;
        bh=xQF3jbUVJzTvqN2ewanRJ7VLz9igs0WiyMN6VkplOyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6A05ax+e/K5u4UJcULFK5HKhD5RqQJ4geVHx+c4aCS5z7XMWgcrARCeTOk5F1NTq
         kclHnt8s7peVNCQv6pHpO21GARUp9xJXqnQygX8sxrewYNUd3xPJNjXMPciFLXLMsk
         h0MY/36Fa7JLP1uRwq61w0WQ/XuBzsg+nHKVP+WObDu/zDSECzxCvoKYYeCS09BJf5
         KIjy5iL1RgleZfWWZaEzwi4jhk0FBDkESdffSsSu7dKkIaTwJdecTTmGCiIh0HpUQ8
         gYHnMASYedCceF46iqJd45clpMOlaALLgGC34E92DBcTVH2u6EOsEZXZCgQCDJCPv6
         NOcRrCpy5Iktg==
From:   paulmck@kernel.org
To:     linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        kernel-team@fb.com, mingo@kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/2] mm: Don't build mm_dump_obj() on CONFIG_PRINTK=n kernels
Date:   Wed,  3 Mar 2021 16:17:27 -0800
Message-Id: <20210304001728.23321-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304001623.GA23196@paulmck-ThinkPad-P72>
References: <20210304001623.GA23196@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The mem_dump_obj() functionality adds a few hundred bytes, which is a
small price to pay.  Except on kernels built with CONFIG_PRINTK=n, in
which mem_dump_obj() messages will be suppressed.  This commit therefore
makes mem_dump_obj() be a static inline empty function on kernels built
with CONFIG_PRINTK=n and excludes all of its support functions as well.
This avoids kernel bloat on systems that cannot use mem_dump_obj().

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: <linux-mm@kvack.org>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/mm.h      | 4 ++++
 include/linux/slab.h    | 2 ++
 include/linux/vmalloc.h | 2 +-
 mm/slab.c               | 2 ++
 mm/slab.h               | 2 ++
 mm/slab_common.c        | 2 ++
 mm/slob.c               | 2 ++
 mm/slub.c               | 2 ++
 mm/util.c               | 2 ++
 mm/vmalloc.c            | 2 ++
 10 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77e64e3..89fca44 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3135,7 +3135,11 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
 
 extern int sysctl_nr_trim_pages;
 
+#ifdef CONFIG_PRINTK
 void mem_dump_obj(void *object);
+#else
+static inline void mem_dump_obj(void *object) {}
+#endif
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7ae6040..0c97d78 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -186,8 +186,10 @@ void kfree(const void *);
 void kfree_sensitive(const void *);
 size_t __ksize(const void *);
 size_t ksize(const void *);
+#ifdef CONFIG_PRINTK
 bool kmem_valid_obj(void *object);
 void kmem_dump_obj(void *object);
+#endif
 
 #ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
 void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index df92211..3de7be6 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -241,7 +241,7 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 int register_vmap_purge_notifier(struct notifier_block *nb);
 int unregister_vmap_purge_notifier(struct notifier_block *nb);
 
-#ifdef CONFIG_MMU
+#if defined(CONFIG_MMU) && defined(CONFIG_PRINTK)
 bool vmalloc_dump_obj(void *object);
 #else
 static inline bool vmalloc_dump_obj(void *object) { return false; }
diff --git a/mm/slab.c b/mm/slab.c
index 51fd424..2e64efe 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3651,6 +3651,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_PRINTK
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 {
 	struct kmem_cache *cachep;
@@ -3670,6 +3671,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 	if (DEBUG && cachep->flags & SLAB_STORE_USER)
 		kpp->kp_ret = *dbg_userword(cachep, objp);
 }
+#endif
 
 /**
  * __do_kmalloc - allocate memory
diff --git a/mm/slab.h b/mm/slab.h
index 076582f..120b1d0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -619,6 +619,7 @@ static inline bool slab_want_init_on_free(struct kmem_cache *c)
 	return false;
 }
 
+#ifdef CONFIG_PRINTK
 #define KS_ADDRS_COUNT 16
 struct kmem_obj_info {
 	void *kp_ptr;
@@ -630,5 +631,6 @@ struct kmem_obj_info {
 	void *kp_stack[KS_ADDRS_COUNT];
 };
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page);
+#endif
 
 #endif /* MM_SLAB_H */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 88e8339..cec9536 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -526,6 +526,7 @@ bool slab_is_available(void)
 	return slab_state >= UP;
 }
 
+#ifdef CONFIG_PRINTK
 /**
  * kmem_valid_obj - does the pointer reference a valid slab object?
  * @object: pointer to query.
@@ -600,6 +601,7 @@ void kmem_dump_obj(void *object)
 		pr_info("    %pS\n", kp.kp_stack[i]);
 	}
 }
+#endif
 
 #ifndef CONFIG_SLOB
 /* Create a cache during boot when no slab services are available yet */
diff --git a/mm/slob.c b/mm/slob.c
index 0578429..74d3f6e 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -461,11 +461,13 @@ static void slob_free(void *block, int size)
 	spin_unlock_irqrestore(&slob_lock, flags);
 }
 
+#ifdef CONFIG_PRINTK
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 {
 	kpp->kp_ptr = object;
 	kpp->kp_page = page;
 }
+#endif
 
 /*
  * End of slob allocator proper. Begin kmem_cache_alloc and kmalloc frontend.
diff --git a/mm/slub.c b/mm/slub.c
index e26c274..077a019 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3963,6 +3963,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	return 0;
 }
 
+#ifdef CONFIG_PRINTK
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 {
 	void *base;
@@ -4002,6 +4003,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 #endif
 #endif
 }
+#endif
 
 /********************************************************************
  *		Kmalloc subsystem
diff --git a/mm/util.c b/mm/util.c
index 5487022..2d497fe 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -983,6 +983,7 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 	return ret;
 }
 
+#ifdef CONFIG_PRINTK
 /**
  * mem_dump_obj - Print available provenance information
  * @object: object for which to find provenance information.
@@ -1013,3 +1014,4 @@ void mem_dump_obj(void *object)
 	}
 	pr_cont(" non-slab/vmalloc memory.\n");
 }
+#endif
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4f5f8c9..d5f2a84 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3450,6 +3450,7 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 }
 #endif	/* CONFIG_SMP */
 
+#ifdef CONFIG_PRINTK
 bool vmalloc_dump_obj(void *object)
 {
 	struct vm_struct *vm;
@@ -3462,6 +3463,7 @@ bool vmalloc_dump_obj(void *object)
 		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
 	return true;
 }
+#endif
 
 #ifdef CONFIG_PROC_FS
 static void *s_start(struct seq_file *m, loff_t *pos)
-- 
2.9.5

