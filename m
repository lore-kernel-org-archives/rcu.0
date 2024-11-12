Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DED205ABA;
	Tue, 12 Nov 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429592; cv=none; b=PB+Tsrq8dN73ZTQa7Q5m16zVorlgevh5CIRMnJeYVq2e5aGvkinGCMEFspZaP1nmS2jVxGgGzNKU7ukSGACI42Xojv9Ku6r8s1xhXWchXHYjnXYoED38G7ZRWUzUyR+gkLmPI0gUPmsUdBFjaaCBJr5ODqRT/qoUErwIyxrXY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429592; c=relaxed/simple;
	bh=DciTSGOm+arLIHt7zsMGKBEGrzIdhA9xzgbvN+05rTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJFYYrCp7DpdDqA63jNRaDQnaSA4aLQISEiP0LNwU0/SI2Q4gfJHHVi5ttzLpgurE47WRIxFmKGEbvD7/iQrOUxtx8zSYKjRZZjLIxHlgtsx11WhQyk7q4cqN1oAStJzMmHS6UgV4LaWu3pWKsV4DJWoYuV+3QQgOyBbsqYc7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A0TDNiTg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=keaat68Y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A0TDNiTg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=keaat68Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A0TDNiTg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="keaat68Y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A0TDNiTg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="keaat68Y"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 497541F385;
	Tue, 12 Nov 2024 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731429587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y22XbXJR2P9++1hguT48F7Lgc4EuibMWLg9xauV5uYM=;
	b=A0TDNiTgqn22pqszrdw4zns1Vgk/+p5cm7cJAunlvcOgTObjODwNC/7OjkHOXYfmobDy5Q
	rUXFBtp1x+ZVWfaDwMMGZvhD+Ge9LT675PEkLRLPdlTDXwBFvp3kpgScUcl58YqZcIhtuw
	o60+7pJImZocXqXibkQEcQmJCovi4Ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731429587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y22XbXJR2P9++1hguT48F7Lgc4EuibMWLg9xauV5uYM=;
	b=keaat68YbyurhBJWAh+InAMX50kUCNsE51iSn4LXmqWCuVax1pMxR2ZWPjrWpxfGFxgur0
	KHPk/ShAg+TwTjDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731429587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y22XbXJR2P9++1hguT48F7Lgc4EuibMWLg9xauV5uYM=;
	b=A0TDNiTgqn22pqszrdw4zns1Vgk/+p5cm7cJAunlvcOgTObjODwNC/7OjkHOXYfmobDy5Q
	rUXFBtp1x+ZVWfaDwMMGZvhD+Ge9LT675PEkLRLPdlTDXwBFvp3kpgScUcl58YqZcIhtuw
	o60+7pJImZocXqXibkQEcQmJCovi4Ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731429587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y22XbXJR2P9++1hguT48F7Lgc4EuibMWLg9xauV5uYM=;
	b=keaat68YbyurhBJWAh+InAMX50kUCNsE51iSn4LXmqWCuVax1pMxR2ZWPjrWpxfGFxgur0
	KHPk/ShAg+TwTjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27E6613A8C;
	Tue, 12 Nov 2024 16:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0BduCdOEM2e6IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 12 Nov 2024 16:39:47 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 12 Nov 2024 17:38:45 +0100
Subject: [PATCH RFC 1/6] mm/slub: add opt-in caching layer of percpu
 sheaves
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-slub-percpu-caches-v1-1-ddc0bdc27e05@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=39055; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=DciTSGOm+arLIHt7zsMGKBEGrzIdhA9xzgbvN+05rTk=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBnM4TDORLCFsIksAOm72brgBdgUpJot1qH8Afyw
 fpcwjJaek+JATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZzOEwwAKCRC74LB10kWI
 mu+DCACArvmGlEL0lGM9pwP/QRogUAIj8PQkPgl3q7cmiRWIZ0gXN7avxZWcnSBDCgQxBx/pwbk
 sddm5oHiTXhplh/D805Tjq92oAicFNCM76/6D8WGliCIkQz5CrS+Qm63LnZr5RKP6ESmGVVa8c4
 W1Afk7mmuExS2cJd7qGZYz+49qoDtxKY4Cqyt3PDi9FZytPocgNaXcCqOGZYedl6qXHPY29oyEJ
 dyVA4GULHto3sJgnXruAOd5+xF2L/MzCT+lqrZqO3Lcd9TQMf1DcHuJyHuXrtjv7fa4shcYOQtD
 Ht0gua/nSlIZRf0e+P1k+Bl+Bm3yyLCsqK1vgvULHwEiwaYl
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,oracle.com,infradead.org,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLtz7ce9b89hw8xzamye9qeynd)]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Specifying a non-zero value for a new struct kmem_cache_args field
sheaf_capacity will setup a caching layer of percpu arrays called
sheaves of given capacity for the created cache.

Allocations from the cache will allocate via the percpu sheaves (main or
spare) as long as they have no NUMA node preference. Frees will also
refill the the sheaves.

When both percpu sheaves are found empty during an allocation, an empty
sheaf may be replaced with a full one from the per-node barn. If none
are available and the allocation is allowed to block, an empty sheaf is
refilled from slab(s) by an internal bulk alloc operation. When both
percpu sheaves are full during freeing, the barn can replace a full one
with an empty one, unless over a full sheaves limit. In that case a
sheaf is flushed to slab(s) by an internal bulk free operation. Flushing
sheaves and barns is also wired to the existing cpu flushing and cache
shrinking operations.

The sheaves do not distinguish NUMA locality of the cached objects. If
an allocation is requested with kmem_cache_alloc_node() with a specific
node (not NUMA_NO_NODE), sheaves are bypassed.

The bulk operations exposed to slab users also try to utilize the
sheaves as long as the necessary (full or empty) sheaves are available
on the cpu or in the barn. Once depleted, they will fallback to bulk
alloc/free to slabs directly to avoid double copying.

Sysfs stat counters alloc_cpu_sheaf and free_cpu_sheaf count objects
allocated or freed using the sheaves. Counters sheaf_refill,
sheaf_flush_main and sheaf_flush_other count objects filled or flushed
from or to slab pages, and can be used to assess how effective the
caching is. The refill and flush operations will also count towards the
usual alloc_fastpath/slowpath, free_fastpath/slowpath and other
counters.

Access to the percpu sheaves is protected by local_lock_irqsave()
operations, each per-NUMA-node barns has a spin_lock.

A current limitation is that when slub_debug is enabled for a cache with
percpu sheaves, the objects in the array are considered as allocated from
the slub_debug perspective, and the alloc/free debugging hooks occur
when moving the objects between the array and slab pages. This means
that e.g. an use-after-free that occurs for an object cached in the
array is undetected. Collected alloc/free stacktraces might also be less
useful. This limitation could be changed in the future.

On the other hand, KASAN, kmemcg and other hooks are executed on actual
allocations and frees by kmem_cache users even if those use the array,
so their debugging or accounting accuracy should be unaffected.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h |  34 ++
 mm/slab.h            |   2 +
 mm/slab_common.c     |   5 +-
 mm/slub.c            | 982 ++++++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 973 insertions(+), 50 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b35e2db7eb0ecc4933126f56b2c3dbf369cbb44b..b13fb1c1f03c14a5b45bc6a64a2096883aef9f83 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -309,6 +309,40 @@ struct kmem_cache_args {
 	 * %NULL means no constructor.
 	 */
 	void (*ctor)(void *);
+	/**
+	 * @sheaf_capacity: Enable sheaves of given capacity for the cache.
+	 *
+	 * With a non-zero value, allocations from the cache go through caching
+	 * arrays called sheaves. Each cpu has a main sheaf that's always
+	 * present, and a spare sheaf thay may be not present. When both become
+	 * empty, there's an attempt to replace an empty sheaf with a full sheaf
+	 * from the per-node barn.
+	 *
+	 * When no full sheaf is available, and gfp flags allow blocking, a
+	 * sheaf is allocated and filled from slab(s) using bulk allocation.
+	 * Otherwise the allocation falls back to the normal operation
+	 * allocating a single object from a slab.
+	 *
+	 * Analogically when freeing and both percpu sheaves are full, the barn
+	 * may replace it with an empty sheaf, unless it's over capacity. In
+	 * that case a sheaf is bulk freed to slab pages.
+	 *
+	 * The sheaves does not distinguish NUMA placement of objects, so
+	 * allocations via kmem_cache_alloc_node() with a node specified other
+	 * than NUMA_NO_NODE will bypass them.
+	 *
+	 * Bulk allocation and free operations also try to use the cpu sheaves
+	 * and barn, but fallback to using slab pages directly.
+	 *
+	 * Limitations: when slub_debug is enabled for the cache, all relevant
+	 * actions (i.e. poisoning, obtaining stacktraces) and checks happen
+	 * when objects move between sheaves and slab pages, which may result in
+	 * e.g. not detecting a use-after-free while the object is in the array
+	 * cache, and the stacktraces may be less useful.
+	 *
+	 * %0 means no sheaves will be created
+	 */
+	unsigned int sheaf_capacity;
 };
 
 struct kmem_cache *__kmem_cache_create_args(const char *name,
diff --git a/mm/slab.h b/mm/slab.h
index 6c6fe6d630ce3d919c29bafd15b401324618da1a..001e0d55467bb4803b5dff718ba8e0c775f42b3f 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -254,6 +254,7 @@ struct kmem_cache {
 #ifndef CONFIG_SLUB_TINY
 	struct kmem_cache_cpu __percpu *cpu_slab;
 #endif
+	struct slub_percpu_sheaves __percpu *cpu_sheaves;
 	/* Used for retrieving partial slabs, etc. */
 	slab_flags_t flags;
 	unsigned long min_partial;
@@ -267,6 +268,7 @@ struct kmem_cache {
 	/* Number of per cpu partial slabs to keep around */
 	unsigned int cpu_partial_slabs;
 #endif
+	unsigned int sheaf_capacity;
 	struct kmem_cache_order_objects oo;
 
 	/* Allocation and freeing of slabs */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 893d320599151845973b4eee9c7accc0d807aa72..7939f3f017740e0ac49ffa971c45409d0fbe2f23 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -161,6 +161,9 @@ int slab_unmergeable(struct kmem_cache *s)
 		return 1;
 #endif
 
+	if (s->cpu_sheaves)
+		return 1;
+
 	/*
 	 * We may have set a slab to be unmergeable during bootstrap.
 	 */
@@ -317,7 +320,7 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 		    object_size - args->usersize < args->useroffset))
 		args->usersize = args->useroffset = 0;
 
-	if (!args->usersize)
+	if (!args->usersize && !args->sheaf_capacity)
 		s = __kmem_cache_alias(name, object_size, args->align, flags,
 				       args->ctor);
 	if (s)
diff --git a/mm/slub.c b/mm/slub.c
index 5b832512044e3ead8ccde2c02308bd8954246db5..7da08112213b203993b5159eb35a1ea640d706fe 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -347,8 +347,10 @@ static inline void debugfs_slab_add(struct kmem_cache *s) { }
 #endif
 
 enum stat_item {
+	ALLOC_PCS,		/* Allocation from percpu sheaf */
 	ALLOC_FASTPATH,		/* Allocation from cpu slab */
 	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
+	FREE_PCS,		/* Free to percpu sheaf */
 	FREE_FASTPATH,		/* Free to cpu slab */
 	FREE_SLOWPATH,		/* Freeing not to cpu slab */
 	FREE_FROZEN,		/* Freeing to frozen slab */
@@ -373,6 +375,12 @@ enum stat_item {
 	CPU_PARTIAL_FREE,	/* Refill cpu partial on free */
 	CPU_PARTIAL_NODE,	/* Refill cpu partial from node partial */
 	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
+	SHEAF_FLUSH_MAIN,	/* Objects flushed from main percpu sheaf */
+	SHEAF_FLUSH_OTHER,	/* Objects flushed from other sheaves */
+	SHEAF_REFILL,		/* Objects refilled to a sheaf */
+	SHEAF_SWAP,		/* Swapping main and spare sheaf */
+	SHEAF_ALLOC,		/* Allocation of an empty sheaf */
+	SHEAF_FREE,		/* Freeing of an empty sheaf */
 	NR_SLUB_STAT_ITEMS
 };
 
@@ -419,6 +427,35 @@ void stat_add(const struct kmem_cache *s, enum stat_item si, int v)
 #endif
 }
 
+#define MAX_FULL_SHEAVES	10
+#define MAX_EMPTY_SHEAVES	10
+
+struct node_barn {
+	spinlock_t lock;
+	struct list_head sheaves_full;
+	struct list_head sheaves_empty;
+	unsigned int nr_full;
+	unsigned int nr_empty;
+};
+
+struct slab_sheaf {
+	union {
+		struct rcu_head rcu_head;
+		struct list_head barn_list;
+	};
+	struct kmem_cache *cache;
+	unsigned int size;
+	void *objects[];
+};
+
+struct slub_percpu_sheaves {
+	local_lock_t lock;
+	struct slab_sheaf *main; /* never NULL when unlocked */
+	struct slab_sheaf *spare; /* empty or full, may be NULL */
+	struct slab_sheaf *rcu_free;
+	struct node_barn *barn;
+};
+
 /*
  * The slab lists for all objects.
  */
@@ -431,6 +468,7 @@ struct kmem_cache_node {
 	atomic_long_t total_objects;
 	struct list_head full;
 #endif
+	struct node_barn *barn;
 };
 
 static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
@@ -454,12 +492,19 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
  */
 static nodemask_t slab_nodes;
 
-#ifndef CONFIG_SLUB_TINY
 /*
  * Workqueue used for flush_cpu_slab().
  */
 static struct workqueue_struct *flushwq;
-#endif
+
+struct slub_flush_work {
+	struct work_struct work;
+	struct kmem_cache *s;
+	bool skip;
+};
+
+static DEFINE_MUTEX(flush_lock);
+static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
 
 /********************************************************************
  * 			Core slab cache functions
@@ -2398,6 +2443,349 @@ static void *setup_object(struct kmem_cache *s, void *object)
 	return object;
 }
 
+static struct slab_sheaf *alloc_empty_sheaf(struct kmem_cache *s, gfp_t gfp)
+{
+	struct slab_sheaf *sheaf = kzalloc(struct_size(sheaf, objects,
+					s->sheaf_capacity), gfp);
+
+	if (unlikely(!sheaf))
+		return NULL;
+
+	sheaf->cache = s;
+
+	stat(s, SHEAF_ALLOC);
+
+	return sheaf;
+}
+
+static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
+{
+	kfree(sheaf);
+
+	stat(s, SHEAF_FREE);
+}
+
+static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
+				   size_t size, void **p);
+
+
+static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
+			 gfp_t gfp)
+{
+	int to_fill = s->sheaf_capacity - sheaf->size;
+	int filled;
+
+	if (!to_fill)
+		return 0;
+
+	filled = __kmem_cache_alloc_bulk(s, gfp, to_fill,
+					 &sheaf->objects[sheaf->size]);
+
+	if (!filled)
+		return -ENOMEM;
+
+	sheaf->size = s->sheaf_capacity;
+
+	stat_add(s, SHEAF_REFILL, filled);
+
+	return 0;
+}
+
+
+static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
+{
+	struct slab_sheaf *sheaf = alloc_empty_sheaf(s, gfp);
+
+	if (!sheaf)
+		return NULL;
+
+	if (refill_sheaf(s, sheaf, gfp)) {
+		free_empty_sheaf(s, sheaf);
+		return NULL;
+	}
+
+	return sheaf;
+}
+
+/*
+ * Maximum number of objects freed during a single flush of main pcs sheaf.
+ * Translates directly to an on-stack array size.
+ */
+#define PCS_BATCH_MAX	32U
+
+static void __kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p);
+
+static void sheaf_flush_main(struct kmem_cache *s)
+{
+	struct slub_percpu_sheaves *pcs;
+	unsigned int batch, remaining;
+	void *objects[PCS_BATCH_MAX];
+	struct slab_sheaf *sheaf;
+	unsigned long flags;
+
+next_batch:
+	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+	sheaf = pcs->main;
+
+	batch = min(PCS_BATCH_MAX, sheaf->size);
+
+	sheaf->size -= batch;
+	memcpy(objects, sheaf->objects + sheaf->size, batch * sizeof(void *));
+
+	remaining = sheaf->size;
+
+	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+
+	__kmem_cache_free_bulk(s, batch, &objects[0]);
+
+	stat_add(s, SHEAF_FLUSH_MAIN, batch);
+
+	if (remaining)
+		goto next_batch;
+}
+
+static void sheaf_flush(struct kmem_cache *s, struct slab_sheaf *sheaf)
+{
+	if (!sheaf->size)
+		return;
+
+	stat_add(s, SHEAF_FLUSH_OTHER, sheaf->size);
+
+	__kmem_cache_free_bulk(s, sheaf->size, &sheaf->objects[0]);
+
+	sheaf->size = 0;
+}
+
+/*
+ * Caller needs to make sure migration is disabled in order to fully flush
+ * single cpu's sheaves
+ *
+ * flushing operations are rare so let's keep it simple and flush to slabs
+ * directly, skipping the barn
+ */
+static void pcs_flush_all(struct kmem_cache *s)
+{
+	struct slub_percpu_sheaves *pcs;
+	struct slab_sheaf *spare, *rcu_free;
+	unsigned long flags;
+
+	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	spare = pcs->spare;
+	pcs->spare = NULL;
+
+	rcu_free = pcs->rcu_free;
+	pcs->rcu_free = NULL;
+
+	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+
+	if (spare) {
+		sheaf_flush(s, spare);
+		free_empty_sheaf(s, spare);
+	}
+
+	// TODO: handle rcu_free
+	BUG_ON(rcu_free);
+
+	sheaf_flush_main(s);
+}
+
+static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
+{
+	struct slub_percpu_sheaves *pcs;
+
+	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
+
+	if (pcs->spare) {
+		sheaf_flush(s, pcs->spare);
+		free_empty_sheaf(s, pcs->spare);
+		pcs->spare = NULL;
+	}
+
+	// TODO: handle rcu_free
+	BUG_ON(pcs->rcu_free);
+
+	sheaf_flush_main(s);
+}
+
+static void pcs_destroy(struct kmem_cache *s)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct slub_percpu_sheaves *pcs;
+
+		pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
+
+		/* can happen when unwinding failed create */
+		if (!pcs->main)
+			continue;
+
+		WARN_ON(pcs->spare);
+		WARN_ON(pcs->rcu_free);
+
+		if (!WARN_ON(pcs->main->size)) {
+			free_empty_sheaf(s, pcs->main);
+			pcs->main = NULL;
+		}
+	}
+
+	free_percpu(s->cpu_sheaves);
+	s->cpu_sheaves = NULL;
+}
+
+static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
+{
+	struct slab_sheaf *empty = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	if (barn->nr_empty) {
+		empty = list_first_entry(&barn->sheaves_empty,
+					 struct slab_sheaf, barn_list);
+		list_del(&empty->barn_list);
+		barn->nr_empty--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return empty;
+}
+
+static int barn_put_empty_sheaf(struct node_barn *barn,
+				struct slab_sheaf *sheaf, bool ignore_limit)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	if (!ignore_limit && barn->nr_empty >= MAX_EMPTY_SHEAVES) {
+		ret = -E2BIG;
+	} else {
+		list_add(&sheaf->barn_list, &barn->sheaves_empty);
+		barn->nr_empty++;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+	return ret;
+}
+
+static int barn_put_full_sheaf(struct node_barn *barn, struct slab_sheaf *sheaf,
+			       bool ignore_limit)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	if (!ignore_limit && barn->nr_full >= MAX_FULL_SHEAVES) {
+		ret = -E2BIG;
+	} else {
+		list_add(&sheaf->barn_list, &barn->sheaves_full);
+		barn->nr_full++;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+	return ret;
+}
+
+/*
+ * If a full sheaf is available, return it and put the supplied empty one to
+ * barn. We ignore the limit on empty sheaves as the number of sheaves doesn't
+ * change.
+ */
+static struct slab_sheaf *
+barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	if (barn->nr_full) {
+		full = list_first_entry(&barn->sheaves_full, struct slab_sheaf,
+					barn_list);
+		list_del(&full->barn_list);
+		list_add(&empty->barn_list, &barn->sheaves_empty);
+		barn->nr_full--;
+		barn->nr_empty++;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+/*
+ * If a empty sheaf is available, return it and put the supplied full one to
+ * barn. But if there are too many full sheaves, reject this with -E2BIG.
+ */
+static struct slab_sheaf *
+barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
+{
+	struct slab_sheaf *empty;
+	unsigned long flags;
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	if (barn->nr_full >= MAX_FULL_SHEAVES) {
+		empty = ERR_PTR(-E2BIG);
+	} else if (!barn->nr_empty) {
+		empty = ERR_PTR(-ENOMEM);
+	} else {
+		empty = list_first_entry(&barn->sheaves_empty, struct slab_sheaf,
+					 barn_list);
+		list_del(&empty->barn_list);
+		list_add(&full->barn_list, &barn->sheaves_full);
+		barn->nr_empty--;
+		barn->nr_full++;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return empty;
+}
+
+static void barn_init(struct node_barn *barn)
+{
+	spin_lock_init(&barn->lock);
+	INIT_LIST_HEAD(&barn->sheaves_full);
+	INIT_LIST_HEAD(&barn->sheaves_empty);
+	barn->nr_full = 0;
+	barn->nr_empty = 0;
+}
+
+static void barn_shrink(struct kmem_cache *s, struct node_barn *barn)
+{
+	struct list_head empty_list;
+	struct list_head full_list;
+	struct slab_sheaf *sheaf, *sheaf2;
+	unsigned long flags;
+
+	INIT_LIST_HEAD(&empty_list);
+	INIT_LIST_HEAD(&full_list);
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	list_splice_init(&barn->sheaves_full, &full_list);
+	barn->nr_full = 0;
+	list_splice_init(&barn->sheaves_empty, &empty_list);
+	barn->nr_empty = 0;
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	list_for_each_entry_safe(sheaf, sheaf2, &full_list, barn_list) {
+		sheaf_flush(s, sheaf);
+		list_move(&sheaf->barn_list, &empty_list);
+	}
+
+	list_for_each_entry_safe(sheaf, sheaf2, &empty_list, barn_list)
+		free_empty_sheaf(s, sheaf);
+}
+
 /*
  * Slab allocation and freeing
  */
@@ -3271,11 +3659,42 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 	put_partials_cpu(s, c);
 }
 
-struct slub_flush_work {
-	struct work_struct work;
-	struct kmem_cache *s;
-	bool skip;
-};
+static inline void flush_this_cpu_slab(struct kmem_cache *s)
+{
+	struct kmem_cache_cpu *c = this_cpu_ptr(s->cpu_slab);
+
+	if (c->slab)
+		flush_slab(s, c);
+
+	put_partials(s);
+}
+
+static bool has_cpu_slab(int cpu, struct kmem_cache *s)
+{
+	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
+
+	return c->slab || slub_percpu_partial(c);
+}
+
+#else /* CONFIG_SLUB_TINY */
+static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu) { }
+static inline bool has_cpu_slab(int cpu, struct kmem_cache *s) { return false; }
+static inline void flush_this_cpu_slab(struct kmem_cache *s) { }
+#endif /* CONFIG_SLUB_TINY */
+
+static bool has_pcs_used(int cpu, struct kmem_cache *s)
+{
+	struct slub_percpu_sheaves *pcs;
+
+	if (!s->cpu_sheaves)
+		return false;
+
+	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
+
+	return (pcs->spare || pcs->rcu_free || pcs->main->size);
+}
+
+static void pcs_flush_all(struct kmem_cache *s);
 
 /*
  * Flush cpu slab.
@@ -3285,30 +3704,18 @@ struct slub_flush_work {
 static void flush_cpu_slab(struct work_struct *w)
 {
 	struct kmem_cache *s;
-	struct kmem_cache_cpu *c;
 	struct slub_flush_work *sfw;
 
 	sfw = container_of(w, struct slub_flush_work, work);
 
 	s = sfw->s;
-	c = this_cpu_ptr(s->cpu_slab);
 
-	if (c->slab)
-		flush_slab(s, c);
-
-	put_partials(s);
-}
-
-static bool has_cpu_slab(int cpu, struct kmem_cache *s)
-{
-	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
+	if (s->cpu_sheaves)
+		pcs_flush_all(s);
 
-	return c->slab || slub_percpu_partial(c);
+	flush_this_cpu_slab(s);
 }
 
-static DEFINE_MUTEX(flush_lock);
-static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
-
 static void flush_all_cpus_locked(struct kmem_cache *s)
 {
 	struct slub_flush_work *sfw;
@@ -3319,7 +3726,7 @@ static void flush_all_cpus_locked(struct kmem_cache *s)
 
 	for_each_online_cpu(cpu) {
 		sfw = &per_cpu(slub_flush, cpu);
-		if (!has_cpu_slab(cpu, s)) {
+		if (!has_cpu_slab(cpu, s) && !has_pcs_used(cpu, s)) {
 			sfw->skip = true;
 			continue;
 		}
@@ -3355,19 +3762,14 @@ static int slub_cpu_dead(unsigned int cpu)
 	struct kmem_cache *s;
 
 	mutex_lock(&slab_mutex);
-	list_for_each_entry(s, &slab_caches, list)
+	list_for_each_entry(s, &slab_caches, list) {
 		__flush_cpu_slab(s, cpu);
+		__pcs_flush_all_cpu(s, cpu);
+	}
 	mutex_unlock(&slab_mutex);
 	return 0;
 }
 
-#else /* CONFIG_SLUB_TINY */
-static inline void flush_all_cpus_locked(struct kmem_cache *s) { }
-static inline void flush_all(struct kmem_cache *s) { }
-static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu) { }
-static inline int slub_cpu_dead(unsigned int cpu) { return 0; }
-#endif /* CONFIG_SLUB_TINY */
-
 /*
  * Check if the objects in a per cpu structure fit numa
  * locality expectations.
@@ -4095,6 +4497,173 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	return memcg_slab_post_alloc_hook(s, lru, flags, size, p);
 }
 
+static __fastpath_inline
+void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
+{
+	struct slub_percpu_sheaves *pcs;
+	unsigned long flags;
+	void *object;
+
+	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	if (unlikely(pcs->main->size == 0)) {
+
+		struct slab_sheaf *empty = NULL;
+		struct slab_sheaf *full;
+		bool can_alloc;
+
+		if (pcs->spare && pcs->spare->size > 0) {
+			stat(s, SHEAF_SWAP);
+			swap(pcs->main, pcs->spare);
+			goto do_alloc;
+		}
+
+		full = barn_replace_empty_sheaf(pcs->barn, pcs->main);
+
+		if (full) {
+			pcs->main = full;
+			goto do_alloc;
+		}
+
+		can_alloc = gfpflags_allow_blocking(gfp);
+
+		if (can_alloc) {
+			if (pcs->spare) {
+				empty = pcs->spare;
+				pcs->spare = NULL;
+			} else {
+				empty = barn_get_empty_sheaf(pcs->barn);
+			}
+		}
+
+		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+
+		if (!can_alloc)
+			return NULL;
+
+		if (empty) {
+			if (!refill_sheaf(s, empty, gfp)) {
+				full = empty;
+			} else {
+				/*
+				 * we must be very low on memory so don't bother
+				 * with the barn
+				 */
+				free_empty_sheaf(s, empty);
+			}
+		} else {
+			full = alloc_full_sheaf(s, gfp);
+		}
+
+		if (!full)
+			return NULL;
+
+		local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+		pcs = this_cpu_ptr(s->cpu_sheaves);
+
+		/*
+		 * If we are returning empty sheaf, we either got it from the
+		 * barn or had to allocate one. If we are returning a full
+		 * sheaf, it's due to racing or being migrated to a different
+		 * cpu. Breaching the barn's sheaf limits should be thus rare
+		 * enough so just ignore them to simplify the recovery.
+		 */
+
+		if (pcs->main->size == 0) {
+			barn_put_empty_sheaf(pcs->barn, pcs->main, true);
+			pcs->main = full;
+			goto do_alloc;
+		}
+
+		if (!pcs->spare) {
+			pcs->spare = full;
+			goto do_alloc;
+		}
+
+		if (pcs->spare->size == 0) {
+			barn_put_empty_sheaf(pcs->barn, pcs->spare, true);
+			pcs->spare = full;
+			goto do_alloc;
+		}
+
+		barn_put_full_sheaf(pcs->barn, full, true);
+	}
+
+do_alloc:
+	object = pcs->main->objects[--pcs->main->size];
+
+	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+
+	stat(s, ALLOC_PCS);
+
+	return object;
+}
+
+static __fastpath_inline
+unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
+{
+	struct slub_percpu_sheaves *pcs;
+	struct slab_sheaf *main;
+	unsigned long flags;
+	unsigned int allocated = 0;
+	unsigned int batch;
+
+next_batch:
+	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	if (unlikely(pcs->main->size == 0)) {
+
+		struct slab_sheaf *full;
+
+		if (pcs->spare && pcs->spare->size > 0) {
+			stat(s, SHEAF_SWAP);
+			swap(pcs->main, pcs->spare);
+			goto do_alloc;
+		}
+
+		full = barn_replace_empty_sheaf(pcs->barn, pcs->main);
+
+		if (full) {
+			pcs->main = full;
+			goto do_alloc;
+		}
+
+		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+
+		/*
+		 * Once full sheaves in barn are depleted, let the bulk
+		 * allocation continue from slab pages, otherwise we would just
+		 * be copying arrays of pointers twice.
+		 */
+		return allocated;
+	}
+
+do_alloc:
+
+	main = pcs->main;
+	batch = min(size, main->size);
+
+	main->size -= batch;
+	memcpy(p, main->objects + main->size, batch * sizeof(void *));
+
+	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+
+	stat_add(s, ALLOC_PCS, batch);
+
+	allocated += batch;
+
+	if (batch < size) {
+		p += batch;
+		size -= batch;
+		goto next_batch;
+	}
+
+	return allocated;
+}
+
+
 /*
  * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_alloc)
  * have the fastpath folded into their functions. So no function call
@@ -4119,7 +4688,11 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	if (unlikely(object))
 		goto out;
 
-	object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
+	if (s->cpu_sheaves && (node == NUMA_NO_NODE))
+		object = alloc_from_pcs(s, gfpflags);
+
+	if (!object)
+		object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
 
 	maybe_wipe_obj_freeptr(s, object);
 	init = slab_want_init_on_alloc(gfpflags, s);
@@ -4490,6 +5063,196 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	discard_slab(s, slab);
 }
 
+/*
+ * Free an object to the percpu sheaves.
+ * The object is expected to have passed slab_free_hook() already.
+ */
+static __fastpath_inline
+void free_to_pcs(struct kmem_cache *s, void *object)
+{
+	struct slub_percpu_sheaves *pcs;
+	unsigned long flags;
+
+restart:
+	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
+
+		struct slab_sheaf *empty;
+
+		if (!pcs->spare) {
+			empty = barn_get_empty_sheaf(pcs->barn);
+			if (empty) {
+				pcs->spare = pcs->main;
+				pcs->main = empty;
+				goto do_free;
+			}
+			goto alloc_empty;
+		}
+
+		if (pcs->spare->size < s->sheaf_capacity) {
+			stat(s, SHEAF_SWAP);
+			swap(pcs->main, pcs->spare);
+			goto do_free;
+		}
+
+		empty = barn_replace_full_sheaf(pcs->barn, pcs->main);
+
+		if (!IS_ERR(empty)) {
+			pcs->main = empty;
+			goto do_free;
+		}
+
+		if (PTR_ERR(empty) == -E2BIG) {
+			/* Since we got here, spare exists and is full */
+			struct slab_sheaf *to_flush = pcs->spare;
+
+			pcs->spare = NULL;
+			local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+
+			sheaf_flush(s, to_flush);
+			empty = to_flush;
+			goto got_empty;
+		}
+
+alloc_empty:
+		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+
+		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
+
+		if (!empty) {
+			sheaf_flush_main(s);
+			goto restart;
+		}
+
+got_empty:
+		local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+		pcs = this_cpu_ptr(s->cpu_sheaves);
+
+		/*
+		 * if we put any sheaf to barn here, it's because we raced or
+		 * have been migrated to a different cpu, which should be rare
+		 * enough so just ignore the barn's limits to simplify
+		 */
+		if (unlikely(pcs->main->size < s->sheaf_capacity)) {
+			if (!pcs->spare)
+				pcs->spare = empty;
+			else
+				barn_put_empty_sheaf(pcs->barn, empty, true);
+			goto do_free;
+		}
+
+		if (!pcs->spare) {
+			pcs->spare = pcs->main;
+			pcs->main = empty;
+			goto do_free;
+		}
+
+		barn_put_full_sheaf(pcs->barn, pcs->main, true);
+		pcs->main = empty;
+	}
+
+do_free:
+	pcs->main->objects[pcs->main->size++] = object;
+
+	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+
+	stat(s, FREE_PCS);
+}
+
+/*
+ * Bulk free objects to the percpu sheaves.
+ * Unlike free_to_pcs() this includes the calls to all necessary hooks
+ * and the fallback to freeing to slab pages.
+ */
+static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
+{
+	struct slub_percpu_sheaves *pcs;
+	struct slab_sheaf *main;
+	unsigned long flags;
+	unsigned int batch, i = 0;
+	bool init;
+
+	init = slab_want_init_on_free(s);
+
+	while (i < size) {
+		struct slab *slab = virt_to_slab(p[i]);
+
+		memcg_slab_free_hook(s, slab, p + i, 1);
+		alloc_tagging_slab_free_hook(s, slab, p + i, 1);
+
+		if (unlikely(!slab_free_hook(s, p[i], init, false))) {
+			p[i] = p[--size];
+			if (!size)
+				return;
+			continue;
+		}
+
+		i++;
+	}
+
+next_batch:
+	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
+
+		struct slab_sheaf *empty;
+
+		if (!pcs->spare) {
+			empty = barn_get_empty_sheaf(pcs->barn);
+			if (empty) {
+				pcs->spare = pcs->main;
+				pcs->main = empty;
+				goto do_free;
+			}
+			goto no_empty;
+		}
+
+		if (pcs->spare->size < s->sheaf_capacity) {
+			stat(s, SHEAF_SWAP);
+			swap(pcs->main, pcs->spare);
+			goto do_free;
+		}
+
+		empty = barn_replace_full_sheaf(pcs->barn, pcs->main);
+
+		if (!IS_ERR(empty)) {
+			pcs->main = empty;
+			goto do_free;
+		}
+
+no_empty:
+		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+
+		/*
+		 * if we depleted all empty sheaves in the barn or there are too
+		 * many full sheaves, free the rest to slab pages
+		 */
+
+		__kmem_cache_free_bulk(s, size, p);
+		return;
+	}
+
+do_free:
+	main = pcs->main;
+	batch = min(size, s->sheaf_capacity - main->size);
+
+	memcpy(main->objects + main->size, p, batch * sizeof(void *));
+	main->size += batch;
+
+	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+
+	stat_add(s, FREE_PCS, batch);
+
+	if (batch < size) {
+		p += batch;
+		size -= batch;
+		goto next_batch;
+	}
+}
+
 #ifndef CONFIG_SLUB_TINY
 /*
  * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
@@ -4576,7 +5339,12 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	memcg_slab_free_hook(s, slab, &object, 1);
 	alloc_tagging_slab_free_hook(s, slab, &object, 1);
 
-	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), false)))
+	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
+		return;
+
+	if (s->cpu_sheaves)
+		free_to_pcs(s, object);
+	else
 		do_slab_free(s, slab, object, object, 1, addr);
 }
 
@@ -4837,6 +5605,15 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 	if (!size)
 		return;
 
+	/*
+	 * freeing to sheaves is so incompatible with the detached freelist so
+	 * once we go that way, we have to do everything differently
+	 */
+	if (s && s->cpu_sheaves) {
+		free_to_pcs_bulk(s, size, p);
+		return;
+	}
+
 	do {
 		struct detached_freelist df;
 
@@ -4955,7 +5732,7 @@ static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
 				 void **p)
 {
-	int i;
+	unsigned int i = 0;
 
 	if (!size)
 		return 0;
@@ -4964,9 +5741,21 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
 	if (unlikely(!s))
 		return 0;
 
-	i = __kmem_cache_alloc_bulk(s, flags, size, p);
-	if (unlikely(i == 0))
-		return 0;
+	if (s->cpu_sheaves)
+		i = alloc_from_pcs_bulk(s, size, p);
+
+	if (i < size) {
+		unsigned int j = __kmem_cache_alloc_bulk(s, flags, size - i, p + i);
+		/*
+		 * If we ran out of memory, don't bother with freeing back to
+		 * the percpu sheaves, we have bigger problems.
+		 */
+		if (unlikely(j == 0)) {
+			if (i > 0)
+				__kmem_cache_free_bulk(s, i, p);
+			return 0;
+		}
+	}
 
 	/*
 	 * memcg and kmem_cache debug support and memory initialization.
@@ -4976,11 +5765,11 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
 		    slab_want_init_on_alloc(flags, s), s->object_size))) {
 		return 0;
 	}
-	return i;
+
+	return size;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk_noprof);
 
-
 /*
  * Object placement in a slab is made very easy because we always start at
  * offset 0. If we tune the size of the object to the alignment then we can
@@ -5113,8 +5902,8 @@ static inline int calculate_order(unsigned int size)
 	return -ENOSYS;
 }
 
-static void
-init_kmem_cache_node(struct kmem_cache_node *n)
+static bool
+init_kmem_cache_node(struct kmem_cache_node *n, struct node_barn *barn)
 {
 	n->nr_partial = 0;
 	spin_lock_init(&n->list_lock);
@@ -5124,6 +5913,11 @@ init_kmem_cache_node(struct kmem_cache_node *n)
 	atomic_long_set(&n->total_objects, 0);
 	INIT_LIST_HEAD(&n->full);
 #endif
+	n->barn = barn;
+	if (barn)
+		barn_init(barn);
+
+	return true;
 }
 
 #ifndef CONFIG_SLUB_TINY
@@ -5154,6 +5948,30 @@ static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
 }
 #endif /* CONFIG_SLUB_TINY */
 
+static int init_percpu_sheaves(struct kmem_cache *s)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct slub_percpu_sheaves *pcs;
+		int nid;
+
+		pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
+
+		local_lock_init(&pcs->lock);
+
+		nid = cpu_to_mem(cpu);
+
+		pcs->barn = get_node(s, nid)->barn;
+		pcs->main = alloc_empty_sheaf(s, GFP_KERNEL);
+
+		if (!pcs->main)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static struct kmem_cache *kmem_cache_node;
 
 /*
@@ -5189,7 +6007,7 @@ static void early_kmem_cache_node_alloc(int node)
 	slab->freelist = get_freepointer(kmem_cache_node, n);
 	slab->inuse = 1;
 	kmem_cache_node->node[node] = n;
-	init_kmem_cache_node(n);
+	init_kmem_cache_node(n, NULL);
 	inc_slabs_node(kmem_cache_node, node, slab->objects);
 
 	/*
@@ -5205,6 +6023,13 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)
 	struct kmem_cache_node *n;
 
 	for_each_kmem_cache_node(s, node, n) {
+		if (n->barn) {
+			WARN_ON(n->barn->nr_full);
+			WARN_ON(n->barn->nr_empty);
+			kfree(n->barn);
+			n->barn = NULL;
+		}
+
 		s->node[node] = NULL;
 		kmem_cache_free(kmem_cache_node, n);
 	}
@@ -5213,6 +6038,8 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)
 void __kmem_cache_release(struct kmem_cache *s)
 {
 	cache_random_seq_destroy(s);
+	if (s->cpu_sheaves)
+		pcs_destroy(s);
 #ifndef CONFIG_SLUB_TINY
 	free_percpu(s->cpu_slab);
 #endif
@@ -5225,20 +6052,27 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 
 	for_each_node_mask(node, slab_nodes) {
 		struct kmem_cache_node *n;
+		struct node_barn *barn = NULL;
 
 		if (slab_state == DOWN) {
 			early_kmem_cache_node_alloc(node);
 			continue;
 		}
+
+		if (s->cpu_sheaves) {
+			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, node);
+
+			if (!barn)
+				return 0;
+		}
+
 		n = kmem_cache_alloc_node(kmem_cache_node,
 						GFP_KERNEL, node);
-
-		if (!n) {
-			free_kmem_cache_nodes(s);
+		if (!n)
 			return 0;
-		}
 
-		init_kmem_cache_node(n);
+		init_kmem_cache_node(n, barn);
+
 		s->node[node] = n;
 	}
 	return 1;
@@ -5494,6 +6328,8 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	flush_all_cpus_locked(s);
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
+		if (n->barn)
+			barn_shrink(s, n->barn);
 		free_partial(s, n);
 		if (n->nr_partial || node_nr_slabs(n))
 			return 1;
@@ -5680,6 +6516,9 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 		for (i = 0; i < SHRINK_PROMOTE_MAX; i++)
 			INIT_LIST_HEAD(promote + i);
 
+		if (n->barn)
+			barn_shrink(s, n->barn);
+
 		spin_lock_irqsave(&n->list_lock, flags);
 
 		/*
@@ -5792,12 +6631,24 @@ static int slab_mem_going_online_callback(void *arg)
 	 */
 	mutex_lock(&slab_mutex);
 	list_for_each_entry(s, &slab_caches, list) {
+		struct node_barn *barn = NULL;
+
 		/*
 		 * The structure may already exist if the node was previously
 		 * onlined and offlined.
 		 */
 		if (get_node(s, nid))
 			continue;
+
+		if (s->cpu_sheaves) {
+			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, nid);
+
+			if (!barn) {
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+
 		/*
 		 * XXX: kmem_cache_alloc_node will fallback to other nodes
 		 *      since memory is not yet available from the node that
@@ -5808,7 +6659,9 @@ static int slab_mem_going_online_callback(void *arg)
 			ret = -ENOMEM;
 			goto out;
 		}
-		init_kmem_cache_node(n);
+
+		init_kmem_cache_node(n, barn);
+
 		s->node[nid] = n;
 	}
 	/*
@@ -6026,6 +6879,16 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 
 	set_cpu_partial(s);
 
+	if (args->sheaf_capacity) {
+		s->cpu_sheaves = alloc_percpu(struct slub_percpu_sheaves);
+		if (!s->cpu_sheaves) {
+			err = -ENOMEM;
+			goto out;
+		}
+		// TODO: increase capacity to grow slab_sheaf up to next kmalloc size?
+		s->sheaf_capacity = args->sheaf_capacity;
+	}
+
 #ifdef CONFIG_NUMA
 	s->remote_node_defrag_ratio = 1000;
 #endif
@@ -6042,6 +6905,12 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 	if (!alloc_kmem_cache_cpus(s))
 		goto out;
 
+	if (s->cpu_sheaves) {
+		err = init_percpu_sheaves(s);
+		if (err)
+			goto out;
+	}
+
 	/* Mutex is not taken during early boot */
 	if (slab_state <= UP) {
 		err = 0;
@@ -6060,7 +6929,6 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 		__kmem_cache_release(s);
 	return err;
 }
-
 #ifdef SLAB_SUPPORTS_SYSFS
 static int count_inuse(struct slab *slab)
 {
@@ -6838,8 +7706,10 @@ static ssize_t text##_store(struct kmem_cache *s,		\
 }								\
 SLAB_ATTR(text);						\
 
+STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
 STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
 STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
+STAT_ATTR(FREE_PCS, free_cpu_sheaf);
 STAT_ATTR(FREE_FASTPATH, free_fastpath);
 STAT_ATTR(FREE_SLOWPATH, free_slowpath);
 STAT_ATTR(FREE_FROZEN, free_frozen);
@@ -6864,6 +7734,12 @@ STAT_ATTR(CPU_PARTIAL_ALLOC, cpu_partial_alloc);
 STAT_ATTR(CPU_PARTIAL_FREE, cpu_partial_free);
 STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
 STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
+STAT_ATTR(SHEAF_FLUSH_MAIN, sheaf_flush_main);
+STAT_ATTR(SHEAF_FLUSH_OTHER, sheaf_flush_other);
+STAT_ATTR(SHEAF_REFILL, sheaf_refill);
+STAT_ATTR(SHEAF_SWAP, sheaf_swap);
+STAT_ATTR(SHEAF_ALLOC, sheaf_alloc);
+STAT_ATTR(SHEAF_FREE, sheaf_free);
 #endif	/* CONFIG_SLUB_STATS */
 
 #ifdef CONFIG_KFENCE
@@ -6925,8 +7801,10 @@ static struct attribute *slab_attrs[] = {
 	&remote_node_defrag_ratio_attr.attr,
 #endif
 #ifdef CONFIG_SLUB_STATS
+	&alloc_cpu_sheaf_attr.attr,
 	&alloc_fastpath_attr.attr,
 	&alloc_slowpath_attr.attr,
+	&free_cpu_sheaf_attr.attr,
 	&free_fastpath_attr.attr,
 	&free_slowpath_attr.attr,
 	&free_frozen_attr.attr,
@@ -6951,6 +7829,12 @@ static struct attribute *slab_attrs[] = {
 	&cpu_partial_free_attr.attr,
 	&cpu_partial_node_attr.attr,
 	&cpu_partial_drain_attr.attr,
+	&sheaf_flush_main_attr.attr,
+	&sheaf_flush_other_attr.attr,
+	&sheaf_refill_attr.attr,
+	&sheaf_swap_attr.attr,
+	&sheaf_alloc_attr.attr,
+	&sheaf_free_attr.attr,
 #endif
 #ifdef CONFIG_FAILSLAB
 	&failslab_attr.attr,

-- 
2.47.0

