Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B516D22615
	for <rcu@vger.kernel.org>; Fri, 25 Apr 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569676; cv=none; b=bkzKBfq7NSUEZfdr2K4X0D6HSOAOyM3i5EXrAGnBkw1syhNjaa9XZyKKlyH06M3wmpViDBJ4NHNV7Ym41PKIXfoG6O0tnQ3E6MC8zUueoeC2DMZD/UfLA+C4Q0Q47/WIA4R7ygBsMR9FeCowrVGb1QlotEvX2nBVAwyVXqGBeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569676; c=relaxed/simple;
	bh=M3ffs8KMEipTT6biUJ+CzfIFeKlxlgZv2vbAdiKjHkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UUauE1ySJ4vn615Yqvvq28urQ1P8MeR7RgoVtVaPHB8HzudRnPo5cyHuYm34G6gAbWsxSsxacTn8vf+5YlBKQDkp7a4PXZWQnq7qtAbr20fSvp2d+aiqS0+MfrNBSHuCKbyvHRMQEOg28JXFI5uiRqhCa492O7JA6xjIqjS1WyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF94E1F38C;
	Fri, 25 Apr 2025 08:27:52 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA98013A9E;
	Fri, 25 Apr 2025 08:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EBFDLYhHC2htfwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Apr 2025 08:27:52 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 25 Apr 2025 10:27:22 +0200
Subject: [PATCH v4 2/9] slab: add sheaf support for batching kfree_rcu()
 operations
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-slub-percpu-caches-v4-2-8a636982b4a4@suse.cz>
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
In-Reply-To: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz
X-Mailer: b4 0.14.2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: DF94E1F38C
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
For caches with sheaves, on each cpu maintain a rcu_free sheaf in
addition to main and spare sheaves.

kfree_rcu() operations will try to put objects on this sheaf. Once full,
the sheaf is detached and submitted to call_rcu() with a handler that
will try to put it in the barn, or flush to slab pages using bulk free,
when the barn is full. Then a new empty sheaf must be obtained to put
more objects there.

It's possible that no free sheaves are available to use for a new
rcu_free sheaf, and the allocation in kfree_rcu() context can only use
GFP_NOWAIT and thus may fail. In that case, fall back to the existing
kfree_rcu() implementation.

Expected advantages:
- batching the kfree_rcu() operations, that could eventually replace the
  existing batching
- sheaves can be reused for allocations via barn instead of being
  flushed to slabs, which is more efficient
  - this includes cases where only some cpus are allowed to process rcu
    callbacks (Android)

Possible disadvantage:
- objects might be waiting for more than their grace period (it is
  determined by the last object freed into the sheaf), increasing memory
  usage - but the existing batching does that too.

Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
implementation favors smaller memory footprint over performance.

Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fail to
count how many kfree_rcu() used the rcu_free sheaf successfully and how
many had to fall back to the existing implementation.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h        |   3 +
 mm/slab_common.c |  24 ++++++++
 mm/slub.c        | 183 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 208 insertions(+), 2 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 1980330c2fcb4a4613a7e4f7efc78b349993fd89..ddf1e4bcba734dccbf67e83bdbab3ca7272f540e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -459,6 +459,9 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
 	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
 }
 
+bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
+
+/* Legal flag mask for kmem_cache_create(), for various configurations */
 #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
 			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 4f295bdd2d42355af6311a799955301005f8a532..6c3b90f03cb79b57f426824450f576a977d85c53 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1608,6 +1608,27 @@ static void kfree_rcu_work(struct work_struct *work)
 		kvfree_rcu_list(head);
 }
 
+static bool kfree_rcu_sheaf(void *obj)
+{
+	struct kmem_cache *s;
+	struct folio *folio;
+	struct slab *slab;
+
+	if (is_vmalloc_addr(obj))
+		return false;
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
 static bool
 need_offload_krc(struct kfree_rcu_cpu *krcp)
 {
@@ -1952,6 +1973,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	if (!head)
 		might_sleep();
 
+	if (kfree_rcu_sheaf(ptr))
+		return;
+
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
diff --git a/mm/slub.c b/mm/slub.c
index ae3e80ad9926ca15601eef2f2aa016ca059498f8..6f31a27b5d47fa6621fa8af6d6842564077d4b60 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -350,6 +350,8 @@ enum stat_item {
 	ALLOC_FASTPATH,		/* Allocation from cpu slab */
 	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
 	FREE_PCS,		/* Free to percpu sheaf */
+	FREE_RCU_SHEAF,		/* Free to rcu_free sheaf */
+	FREE_RCU_SHEAF_FAIL,	/* Failed to free to a rcu_free sheaf */
 	FREE_FASTPATH,		/* Free to cpu slab */
 	FREE_SLOWPATH,		/* Freeing not to cpu slab */
 	FREE_FROZEN,		/* Freeing to frozen slab */
@@ -444,6 +446,7 @@ struct slab_sheaf {
 		struct rcu_head rcu_head;
 		struct list_head barn_list;
 	};
+	struct kmem_cache *cache;
 	unsigned int size;
 	void *objects[];
 };
@@ -452,6 +455,7 @@ struct slub_percpu_sheaves {
 	local_trylock_t lock;
 	struct slab_sheaf *main; /* never NULL when unlocked */
 	struct slab_sheaf *spare; /* empty or full, may be NULL */
+	struct slab_sheaf *rcu_free; /* for batching kfree_rcu() */
 	struct node_barn *barn;
 };
 
@@ -2507,6 +2511,8 @@ static struct slab_sheaf *alloc_empty_sheaf(struct kmem_cache *s, gfp_t gfp)
 	if (unlikely(!sheaf))
 		return NULL;
 
+	sheaf->cache = s;
+
 	stat(s, SHEAF_ALLOC);
 
 	return sheaf;
@@ -2631,6 +2637,24 @@ static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf)
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
+	sheaf_flush_unused(s, sheaf);
+
+	free_empty_sheaf(s, sheaf);
+}
+
 /*
  * Caller needs to make sure migration is disabled in order to fully flush
  * single cpu's sheaves
@@ -2643,7 +2667,7 @@ static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf)
 static void pcs_flush_all(struct kmem_cache *s)
 {
 	struct slub_percpu_sheaves *pcs;
-	struct slab_sheaf *spare;
+	struct slab_sheaf *spare, *rcu_free;
 
 	local_lock(&s->cpu_sheaves->lock);
 	pcs = this_cpu_ptr(s->cpu_sheaves);
@@ -2651,6 +2675,9 @@ static void pcs_flush_all(struct kmem_cache *s)
 	spare = pcs->spare;
 	pcs->spare = NULL;
 
+	rcu_free = pcs->rcu_free;
+	pcs->rcu_free = NULL;
+
 	local_unlock(&s->cpu_sheaves->lock);
 
 	if (spare) {
@@ -2658,6 +2685,9 @@ static void pcs_flush_all(struct kmem_cache *s)
 		free_empty_sheaf(s, spare);
 	}
 
+	if (rcu_free)
+		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
+
 	sheaf_flush_main(s);
 }
 
@@ -2674,6 +2704,11 @@ static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
 		free_empty_sheaf(s, pcs->spare);
 		pcs->spare = NULL;
 	}
+
+	if (pcs->rcu_free) {
+		call_rcu(&pcs->rcu_free->rcu_head, rcu_free_sheaf_nobarn);
+		pcs->rcu_free = NULL;
+	}
 }
 
 static void pcs_destroy(struct kmem_cache *s)
@@ -2699,6 +2734,7 @@ static void pcs_destroy(struct kmem_cache *s)
 		 */
 
 		WARN_ON(pcs->spare);
+		WARN_ON(pcs->rcu_free);
 
 		if (!WARN_ON(pcs->main->size)) {
 			free_empty_sheaf(s, pcs->main);
@@ -3755,7 +3791,7 @@ static bool has_pcs_used(int cpu, struct kmem_cache *s)
 
 	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
 
-	return (pcs->spare || pcs->main->size);
+	return (pcs->spare || pcs->rcu_free || pcs->main->size);
 }
 
 static void pcs_flush_all(struct kmem_cache *s);
@@ -5304,6 +5340,140 @@ bool free_to_pcs(struct kmem_cache *s, void *object)
 	return true;
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
+		memcg_slab_free_hook(s, slab, p + i, 1);
+		alloc_tagging_slab_free_hook(s, slab, p + i, 1);
+
+		if (unlikely(!slab_free_hook(s, p[i], init, true))) {
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
+	/*
+	 * This may reduce the number of objects that the sheaf is no longer
+	 * technically full, but it's easier to treat it that way (unless it's
+	 * competely empty), as the code handles it fine, there's just slightly
+	 * worse batching benefit. It only happens due to debugging, which
+	 * is a performance hit anyway.
+	 */
+	__rcu_free_sheaf_prepare(s, sheaf);
+
+	barn = get_node(s, numa_mem_id())->barn;
+
+	/* due to slab_free_hook() */
+	if (unlikely(sheaf->size == 0))
+		goto empty;
+
+	/*
+	 * Checking nr_full/nr_empty outside lock avoids contention in case the
+	 * barn is at the respective limit. Due to the race we might go over the
+	 * limit but that should be rare and harmless.
+	 */
+
+	if (data_race(barn->nr_full) < MAX_FULL_SHEAVES) {
+		stat(s, BARN_PUT);
+		barn_put_full_sheaf(barn, sheaf);
+		return;
+	}
+
+	stat(s, BARN_PUT_FAIL);
+	sheaf_flush_unused(s, sheaf);
+
+empty:
+	if (data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES) {
+		barn_put_empty_sheaf(barn, sheaf);
+		return;
+	}
+
+	free_empty_sheaf(s, sheaf);
+}
+
+bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
+{
+	struct slub_percpu_sheaves *pcs;
+	struct slab_sheaf *rcu_sheaf;
+
+	if (!local_trylock(&s->cpu_sheaves->lock))
+		goto fail;
+
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
+		local_unlock(&s->cpu_sheaves->lock);
+
+		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
+
+		if (!empty)
+			goto fail;
+
+		if (!local_trylock(&s->cpu_sheaves->lock))
+			goto fail;
+
+		pcs = this_cpu_ptr(s->cpu_sheaves);
+
+		if (unlikely(pcs->rcu_free))
+			barn_put_empty_sheaf(pcs->barn, empty);
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
+	if (likely(rcu_sheaf->size < s->sheaf_capacity))
+		rcu_sheaf = NULL;
+	else
+		pcs->rcu_free = NULL;
+
+	local_unlock(&s->cpu_sheaves->lock);
+
+	if (rcu_sheaf)
+		call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
+
+	stat(s, FREE_RCU_SHEAF);
+	return true;
+
+fail:
+	stat(s, FREE_RCU_SHEAF_FAIL);
+	return false;
+}
+
 /*
  * Bulk free objects to the percpu sheaves.
  * Unlike free_to_pcs() this includes the calls to all necessary hooks
@@ -6802,6 +6972,11 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
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
@@ -8214,6 +8389,8 @@ STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
 STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
 STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
 STAT_ATTR(FREE_PCS, free_cpu_sheaf);
+STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
+STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
 STAT_ATTR(FREE_FASTPATH, free_fastpath);
 STAT_ATTR(FREE_SLOWPATH, free_slowpath);
 STAT_ATTR(FREE_FROZEN, free_frozen);
@@ -8312,6 +8489,8 @@ static struct attribute *slab_attrs[] = {
 	&alloc_fastpath_attr.attr,
 	&alloc_slowpath_attr.attr,
 	&free_cpu_sheaf_attr.attr,
+	&free_rcu_sheaf_attr.attr,
+	&free_rcu_sheaf_fail_attr.attr,
 	&free_fastpath_attr.attr,
 	&free_slowpath_attr.attr,
 	&free_frozen_attr.attr,

-- 
2.49.0

