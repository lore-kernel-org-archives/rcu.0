Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28482206972;
	Tue, 12 Nov 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429591; cv=none; b=miPmTl7hYZm1GiEn4+UQ1QH8nXEGRY5tpwjgdIh0RhYlEwJ5Z5C7XaaV8PfjJCEhK4fONvmN0PPcU96OuWq99uk65fNybnHZ+64K3hjTITDV06LCuE3cTrglfCdbN5/lM9dmBLC5iDfJVR25VpL3Cr195mwQs0D2sfqT70iFctE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429591; c=relaxed/simple;
	bh=B6/AZU7kSSC1Q0Ie5KGFcBQPZBd2OBt3E8M0Qc17hxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ixcizcuyapzDuDlEYZ436rqN/2UerKIxDMqs4RbkcJXBJ6R3wnqjgjqOnsuVcmepLrbrL/nfMnFgv+mqIMzMEpzhNZLZOaQZP20sCHQmf3OD1SYc/Mr41Eg/QleiQcuDTLHBqVa009aE0a9nUXU8AMcdVHR4GeXNk+nCEA+M9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63FDE1F451;
	Tue, 12 Nov 2024 16:39:47 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42AC613AA1;
	Tue, 12 Nov 2024 16:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iM3+D9OEM2e6IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 12 Nov 2024 16:39:47 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 12 Nov 2024 17:38:46 +0100
Subject: [PATCH RFC 2/6] mm/slub: add sheaf support for batching
 kfree_rcu() operations
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-slub-percpu-caches-v1-2-ddc0bdc27e05@suse.cz>
References: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz>
In-Reply-To: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Matthew Wilcox <willy@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13257; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=B6/AZU7kSSC1Q0Ie5KGFcBQPZBd2OBt3E8M0Qc17hxM=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBnM4TFzJ97eeWCva+fkUseyqTp5tbDzppOh8Xm9
 1MipIYG9RuJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZzOExQAKCRC74LB10kWI
 mrxfB/96uJraz/HqUAoR9bhmEZ/EDkDbjSClZuGtTdvfeUcOtvmTu1gwkjWpSwYCFTRhe7WSp7+
 YEzBWskff2pK/QQbYJ2jWwEpGWYZ9/P9UpxDW5zcuoohVmeiFlYxDoS0swDbF1ginUD3H4gjBFt
 UoQglO3o5+GDx7GKMY+Wu4M6h+dSsPC4HoN0HYdJtEtoz1Oim+oaJuCHOkffBVVO17MHYKRY0sT
 R71yWXFmNCND91+1b9c+mNznMuuxqXX6vALlCFMR8gQNEeMlE56krR0L/oHYGgI+6dRLXUfv7aF
 qQLI2CdZyLy5ZxNpUyN0gXbpQzSBzW0bV/dYkYohWDe7grdO
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 63FDE1F451
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
For caches where sheafs are initialized, on each cpu maintain a rcu_free
sheaf in addition to main and spare sheaves.

kfree_rcu() operations will try to put objects on this sheaf. Once full,
the sheaf is detached and submitted to call_rcu() with a handler that
will try to put in on the barn, or flush to slab pages using bulk free,
when the barn is full. Then a new empty sheaf must be obtained to put
more objects there.

It's possible that no free sheafs are available to use for a new
rcu_free sheaf, and the allocation in kfree_rcu() context can only use
GFP_NOWAIT and thus may fail. In that case, fall back to the existing
kfree_rcu() machinery.

Because some intended users will need to perform additonal cleanups
after the grace period and thus have custom rcu_call() callbacks today,
add the possibility to specify a kfree_rcu() specific destructor.
Because of the fall back possibility, the destructor now needs be
invoked also from within RCU, so add __kvfree_rcu() that RCU can use
instead of kvfree().

Expected advantages:
- batching the kfree_rcu() operations, that could eventually replace the
  batching done in RCU itself
- sheafs can be reused via barn instead of being flushed to slabs, which
  is more effective
  - this includes cases where only some cpus are allowed to process rcu
    callbacks (Android)

Possible disadvantage:
- objects might be waiting for more than their grace period (it is
  determined by the last object freed into the sheaf), increasing memory
  usage - but that might be true for the batching done by RCU as well?

RFC LIMITATIONS: - only tree rcu is converted, not tiny
- the rcu fallback might resort to kfree_bulk(), not kvfree(). Instead
  of adding a variant of kfree_bulk() with destructors, is there an easy
  way to disable the kfree_bulk() path in the fallback case?

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h |  15 +++++
 kernel/rcu/tree.c    |   8 ++-
 mm/slab.h            |  25 +++++++
 mm/slab_common.c     |   3 +
 mm/slub.c            | 182 +++++++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 227 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b13fb1c1f03c14a5b45bc6a64a2096883aef9f83..23904321992ad2eeb9389d0883cf4d5d5d71d896 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -343,6 +343,21 @@ struct kmem_cache_args {
 	 * %0 means no sheaves will be created
 	 */
 	unsigned int sheaf_capacity;
+	/**
+	 * @sheaf_rcu_dtor: A destructor for objects freed by kfree_rcu()
+	 *
+	 * Only valid when non-zero @sheaf_capacity is specified. When freeing
+	 * objects by kfree_rcu() in a cache with sheaves, the objects are put
+	 * to a special percpu sheaf. When that sheaf is full, it's passed to
+	 * call_rcu() and after a grace period the sheaf can be reused for new
+	 * allocations. In case a cleanup is necessary after the grace period
+	 * and before reusal, a pointer to such function can be given as
+	 * @sheaf_rcu_dtor and will be called on each object in the rcu sheaf
+	 * after the grace period passes and before the sheaf's reuse.
+	 *
+	 * %NULL means no destructor is called.
+	 */
+	void (*sheaf_rcu_dtor)(void *obj);
 };
 
 struct kmem_cache *__kmem_cache_create_args(const char *name,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b1f883fcd9185a5e22c10102d1024c40688f57fb..42c994fdf9960bfed8d8bd697de90af72c1f4f58 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -65,6 +65,7 @@
 #include <linux/kasan.h>
 #include <linux/context_tracking.h>
 #include "../time/tick-internal.h"
+#include "../../mm/slab.h"
 
 #include "tree.h"
 #include "rcu.h"
@@ -3420,7 +3421,7 @@ kvfree_rcu_list(struct rcu_head *head)
 		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
-			kvfree(ptr);
+			__kvfree_rcu(ptr);
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -3797,6 +3798,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	if (!head)
 		might_sleep();
 
+	if (kfree_rcu_sheaf(ptr))
+		return;
+
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
@@ -3849,7 +3853,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	if (!success) {
 		debug_rcu_head_unqueue((struct rcu_head *) ptr);
 		synchronize_rcu();
-		kvfree(ptr);
+		__kvfree_rcu(ptr);
 	}
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
diff --git a/mm/slab.h b/mm/slab.h
index 001e0d55467bb4803b5dff718ba8e0c775f42b3f..4dc145c14dfd97677c74a767c22f5dd22f5d6451 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -276,6 +276,9 @@ struct kmem_cache {
 	gfp_t allocflags;		/* gfp flags to use on each alloc */
 	int refcount;			/* Refcount for slab cache destroy */
 	void (*ctor)(void *object);	/* Object constructor */
+	void (*rcu_dtor)(void *object);	/* Object destructor to execute after
+					 * kfree_rcu grace period
+					 */
 	unsigned int inuse;		/* Offset to metadata */
 	unsigned int align;		/* Alignment */
 	unsigned int red_left_pad;	/* Left redzone padding size */
@@ -454,6 +457,28 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
 	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
 }
 
+void __kvfree_rcu(void *obj);
+
+bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
+
+static inline bool kfree_rcu_sheaf(void *obj)
+{
+	struct kmem_cache *s;
+	struct folio *folio;
+	struct slab *slab;
+
+	folio = virt_to_folio(obj);
+	if (unlikely(!folio_test_slab(folio)))
+		return false;
+
+	slab = folio_slab(folio);
+	s = slab->slab_cache;
+	if (s->cpu_sheaves)
+		return __kfree_rcu_sheaf(s, obj);
+
+	return false;
+}
+
 /* Legal flag mask for kmem_cache_create(), for various configurations */
 #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7939f3f017740e0ac49ffa971c45409d0fbe2f23..d69ed1e7ea34f9657cb9514fb98a48647f01381b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -236,6 +236,9 @@ static struct kmem_cache *create_cache(const char *name,
 	     !IS_ALIGNED(args->freeptr_offset, sizeof(freeptr_t))))
 		goto out;
 
+	if (args->sheaf_rcu_dtor && !args->sheaf_capacity)
+		goto out;
+
 	err = -ENOMEM;
 	s = kmem_cache_zalloc(kmem_cache, GFP_KERNEL);
 	if (!s)
diff --git a/mm/slub.c b/mm/slub.c
index 7da08112213b203993b5159eb35a1ea640d706fe..6811d766c0470cd7066c2574ad86e00405c916bb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -351,6 +351,8 @@ enum stat_item {
 	ALLOC_FASTPATH,		/* Allocation from cpu slab */
 	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
 	FREE_PCS,		/* Free to percpu sheaf */
+	FREE_RCU_SHEAF,		/* Free to rcu_free sheaf */
+	FREE_RCU_SHEAF_FAIL,	/* Failed to free to a rcu_free sheaf */
 	FREE_FASTPATH,		/* Free to cpu slab */
 	FREE_SLOWPATH,		/* Freeing not to cpu slab */
 	FREE_FROZEN,		/* Freeing to frozen slab */
@@ -2557,6 +2559,24 @@ static void sheaf_flush(struct kmem_cache *s, struct slab_sheaf *sheaf)
 	sheaf->size = 0;
 }
 
+static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
+				     struct slab_sheaf *sheaf);
+
+static void rcu_free_sheaf_nobarn(struct rcu_head *head)
+{
+	struct slab_sheaf *sheaf;
+	struct kmem_cache *s;
+
+	sheaf = container_of(head, struct slab_sheaf, rcu_head);
+	s = sheaf->cache;
+
+	__rcu_free_sheaf_prepare(s, sheaf);
+
+	sheaf_flush(s, sheaf);
+
+	free_empty_sheaf(s, sheaf);
+}
+
 /*
  * Caller needs to make sure migration is disabled in order to fully flush
  * single cpu's sheaves
@@ -2586,8 +2606,8 @@ static void pcs_flush_all(struct kmem_cache *s)
 		free_empty_sheaf(s, spare);
 	}
 
-	// TODO: handle rcu_free
-	BUG_ON(rcu_free);
+	if (rcu_free)
+		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
 
 	sheaf_flush_main(s);
 }
@@ -2604,8 +2624,10 @@ static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
 		pcs->spare = NULL;
 	}
 
-	// TODO: handle rcu_free
-	BUG_ON(pcs->rcu_free);
+	if (pcs->rcu_free) {
+		call_rcu(&pcs->rcu_free->rcu_head, rcu_free_sheaf_nobarn);
+		pcs->rcu_free = NULL;
+	}
 
 	sheaf_flush_main(s);
 }
@@ -5161,6 +5183,121 @@ void free_to_pcs(struct kmem_cache *s, void *object)
 	stat(s, FREE_PCS);
 }
 
+static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
+				     struct slab_sheaf *sheaf)
+{
+	bool init = slab_want_init_on_free(s);
+	void **p = &sheaf->objects[0];
+	unsigned int i = 0;
+
+	while (i < sheaf->size) {
+		struct slab *slab = virt_to_slab(p[i]);
+
+		if (s->rcu_dtor)
+			s->rcu_dtor(p[i]);
+
+		memcg_slab_free_hook(s, slab, p + i, 1);
+		alloc_tagging_slab_free_hook(s, slab, p + i, 1);
+
+		if (unlikely(!slab_free_hook(s, p[i], init, false))) {
+			p[i] = p[--sheaf->size];
+			continue;
+		}
+
+		i++;
+	}
+}
+
+static void rcu_free_sheaf(struct rcu_head *head)
+{
+	struct slab_sheaf *sheaf;
+	struct node_barn *barn;
+	struct kmem_cache *s;
+
+	sheaf = container_of(head, struct slab_sheaf, rcu_head);
+
+	s = sheaf->cache;
+
+	__rcu_free_sheaf_prepare(s, sheaf);
+
+	barn = get_node(s, numa_mem_id())->barn;
+
+	/* due to slab_free_hook() */
+	if (unlikely(sheaf->size == 0))
+		goto empty;
+
+	if (!barn_put_full_sheaf(barn, sheaf, false))
+		return;
+
+	sheaf_flush(s, sheaf);
+
+empty:
+	if (!barn_put_empty_sheaf(barn, sheaf, false))
+		return;
+
+	free_empty_sheaf(s, sheaf);
+}
+
+bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
+{
+	struct slub_percpu_sheaves *pcs;
+	struct slab_sheaf *rcu_sheaf;
+	unsigned long flags;
+
+	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	if (unlikely(!pcs->rcu_free)) {
+
+		struct slab_sheaf *empty;
+
+		empty = barn_get_empty_sheaf(pcs->barn);
+
+		if (empty) {
+			pcs->rcu_free = empty;
+			goto do_free;
+		}
+
+		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+
+		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
+
+		if (!empty) {
+			stat(s, FREE_RCU_SHEAF_FAIL);
+			return false;
+		}
+
+		local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+		pcs = this_cpu_ptr(s->cpu_sheaves);
+
+		if (unlikely(pcs->rcu_free))
+			barn_put_empty_sheaf(pcs->barn, empty, true);
+		else
+			pcs->rcu_free = empty;
+	}
+
+do_free:
+
+	rcu_sheaf = pcs->rcu_free;
+
+	rcu_sheaf->objects[rcu_sheaf->size++] = obj;
+
+	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
+		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+		stat(s, FREE_RCU_SHEAF);
+		return true;
+	}
+
+	pcs->rcu_free = NULL;
+	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+
+	call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
+
+	stat(s, FREE_RCU_SHEAF);
+
+	return true;
+}
+
 /*
  * Bulk free objects to the percpu sheaves.
  * Unlike free_to_pcs() this includes the calls to all necessary hooks
@@ -5466,6 +5603,32 @@ static void free_large_kmalloc(struct folio *folio, void *object)
 	folio_put(folio);
 }
 
+void __kvfree_rcu(void *obj)
+{
+	struct folio *folio;
+	struct slab *slab;
+	struct kmem_cache *s;
+
+	if (is_vmalloc_addr(obj)) {
+		vfree(obj);
+		return;
+	}
+
+	folio = virt_to_folio(obj);
+	if (unlikely(!folio_test_slab(folio))) {
+		free_large_kmalloc(folio, obj);
+		return;
+	}
+
+	slab = folio_slab(folio);
+	s = slab->slab_cache;
+
+	if (s->rcu_dtor)
+		s->rcu_dtor(obj);
+
+	slab_free(s, slab, obj, _RET_IP_);
+}
+
 /**
  * kfree - free previously allocated memory
  * @object: pointer returned by kmalloc() or kmem_cache_alloc()
@@ -6326,6 +6489,11 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	struct kmem_cache_node *n;
 
 	flush_all_cpus_locked(s);
+
+	/* we might have rcu sheaves in flight */
+	if (s->cpu_sheaves)
+		rcu_barrier();
+
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
 		if (n->barn)
@@ -6887,6 +7055,8 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 		}
 		// TODO: increase capacity to grow slab_sheaf up to next kmalloc size?
 		s->sheaf_capacity = args->sheaf_capacity;
+
+		s->rcu_dtor = args->sheaf_rcu_dtor;
 	}
 
 #ifdef CONFIG_NUMA
@@ -7710,6 +7880,8 @@ STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
 STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
 STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
 STAT_ATTR(FREE_PCS, free_cpu_sheaf);
+STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
+STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
 STAT_ATTR(FREE_FASTPATH, free_fastpath);
 STAT_ATTR(FREE_SLOWPATH, free_slowpath);
 STAT_ATTR(FREE_FROZEN, free_frozen);
@@ -7805,6 +7977,8 @@ static struct attribute *slab_attrs[] = {
 	&alloc_fastpath_attr.attr,
 	&alloc_slowpath_attr.attr,
 	&free_cpu_sheaf_attr.attr,
+	&free_rcu_sheaf_attr.attr,
+	&free_rcu_sheaf_fail_attr.attr,
 	&free_fastpath_attr.attr,
 	&free_slowpath_attr.attr,
 	&free_frozen_attr.attr,

-- 
2.47.0

