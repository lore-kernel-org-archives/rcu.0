Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44E23002B3
	for <rcu@vger.kernel.org>; Wed,  3 Sep 2025 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904461; cv=none; b=Ae9rjeeYu5efMDdDmmWjAx3TUkCVCBUcCk4M81J8/wPTbN/Tl5k0RoNqpWaZ9VlnbtQv7uBwqvr2E9AtlDOOKj4BxGSQt0AluJtbBKfYxv1uK9yfE4Tj5lvxewphIuFNWX7wjYiBqgKBnyZRNVcSFlmaC2L4VZEPfmis5euZ4Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904461; c=relaxed/simple;
	bh=Qu3DbhBy7EGA38ZWL9IrWLSmnmbsvsArSbBndE1ffPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGzplvVf1BsaSJilvJkdYoPohdapPSUUxjkQlb1zM5UqxDB+SGpPg9S5OepHE5D1qSCJIe0JCb6qMeWN4jqRN8VV2sJ50rRRK8msUIyNbQ0UB/1MGeBjbysZEOeXS9Xa4cgpwZRMC1Dfrl7DiY2FZeFks+kXfQAwYnPTAmuXl6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eZN9GeJP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iAV3Bxo3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A1v4I9i6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YMDwB/Kt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eZN9GeJP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iAV3Bxo3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A1v4I9i6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YMDwB/Kt"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B3DE21225;
	Wed,  3 Sep 2025 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHNZEYi9bvdu6nDqIqDNg2B6UR4wge7RdUooBFAPhWo=;
	b=eZN9GeJPhRRPdRpmi1n0tbVJR0iTRmAv6QHL6zBSDNYz4ruAgOCIpoZpeedgRnVUU0bINv
	mZPE41l2pNjwDPO47u4pMtvc7+RzPHFIqWQPwJDvmnqX0u+4ar4UUvoqXhBZ9hJ+h65hfy
	YhQxuU1nE//R15R+uyDzDoWnu+f5CJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHNZEYi9bvdu6nDqIqDNg2B6UR4wge7RdUooBFAPhWo=;
	b=iAV3Bxo3pliTFUWFDM5jZea+ATJqVIzU9QilYsofcOjt5WoahEt/zEMMOvMF79o5eCZbz+
	KqOsJ04LQkRMqPAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=A1v4I9i6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="YMDwB/Kt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHNZEYi9bvdu6nDqIqDNg2B6UR4wge7RdUooBFAPhWo=;
	b=A1v4I9i6ducf211y79IWDB7D1LUKJv0UisWd/0vIZJFIJSgnwIb2MfInaLoTEGKISK0I/m
	v1PT73NixhMPxDwR7WHi6JjthxYksM7eXpUc7WPPf/3YpooIdQ8Fyc0epX2e4fnmvey/Yj
	VN2e9uK9rk8XV6n5QYIhkQ7UkJo/zog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHNZEYi9bvdu6nDqIqDNg2B6UR4wge7RdUooBFAPhWo=;
	b=YMDwB/KtKJx5/4nORybCyIAoTVQXoy8DVDKWH7FVnqZOYJCJ3A6gkJ4eI1/kmy21uab90w
	ZSQptfzrqiVA2uCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61D8113AF8;
	Wed,  3 Sep 2025 13:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uAObF9k7uGitOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Sep 2025 13:00:09 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 03 Sep 2025 14:59:46 +0200
Subject: [PATCH v7 04/21] slab: add sheaf support for batching kfree_rcu()
 operations
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-slub-percpu-caches-v7-4-71c114cdefef@suse.cz>
References: <20250903-slub-percpu-caches-v7-0-71c114cdefef@suse.cz>
In-Reply-To: <20250903-slub-percpu-caches-v7-0-71c114cdefef@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 7B3DE21225
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

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

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h        |   2 +
 mm/slab_common.c |  24 +++++++
 mm/slub.c        | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 216 insertions(+), 2 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 206987ce44a4d053ebe3b5e50784d2dd23822cd1..f1866f2d9b211bb0d7f24644b80ef4b50a7c3d24 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -435,6 +435,8 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
 	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
 }
 
+bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
+
 #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
 			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e2b197e47866c30acdbd1fee4159f262a751c5a7..2d806e02568532a1000fd3912db6978e945dcfa8 100644
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
index 42cb5848f1cecb17174967ff8b102b20a50110e3..6a64478befdebdb44cd7896d673bd20a7a6e2889 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -367,6 +367,8 @@ enum stat_item {
 	ALLOC_FASTPATH,		/* Allocation from cpu slab */
 	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
 	FREE_PCS,		/* Free to percpu sheaf */
+	FREE_RCU_SHEAF,		/* Free to rcu_free sheaf */
+	FREE_RCU_SHEAF_FAIL,	/* Failed to free to a rcu_free sheaf */
 	FREE_FASTPATH,		/* Free to cpu slab */
 	FREE_SLOWPATH,		/* Freeing not to cpu slab */
 	FREE_FROZEN,		/* Freeing to frozen slab */
@@ -461,6 +463,7 @@ struct slab_sheaf {
 		struct rcu_head rcu_head;
 		struct list_head barn_list;
 	};
+	struct kmem_cache *cache;
 	unsigned int size;
 	void *objects[];
 };
@@ -469,6 +472,7 @@ struct slub_percpu_sheaves {
 	local_trylock_t lock;
 	struct slab_sheaf *main; /* never NULL when unlocked */
 	struct slab_sheaf *spare; /* empty or full, may be NULL */
+	struct slab_sheaf *rcu_free; /* for batching kfree_rcu() */
 };
 
 /*
@@ -2531,6 +2535,8 @@ static struct slab_sheaf *alloc_empty_sheaf(struct kmem_cache *s, gfp_t gfp)
 	if (unlikely(!sheaf))
 		return NULL;
 
+	sheaf->cache = s;
+
 	stat(s, SHEAF_ALLOC);
 
 	return sheaf;
@@ -2655,6 +2661,43 @@ static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf)
 	sheaf->size = 0;
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
@@ -2667,7 +2710,7 @@ static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf)
 static void pcs_flush_all(struct kmem_cache *s)
 {
 	struct slub_percpu_sheaves *pcs;
-	struct slab_sheaf *spare;
+	struct slab_sheaf *spare, *rcu_free;
 
 	local_lock(&s->cpu_sheaves->lock);
 	pcs = this_cpu_ptr(s->cpu_sheaves);
@@ -2675,6 +2718,9 @@ static void pcs_flush_all(struct kmem_cache *s)
 	spare = pcs->spare;
 	pcs->spare = NULL;
 
+	rcu_free = pcs->rcu_free;
+	pcs->rcu_free = NULL;
+
 	local_unlock(&s->cpu_sheaves->lock);
 
 	if (spare) {
@@ -2682,6 +2728,9 @@ static void pcs_flush_all(struct kmem_cache *s)
 		free_empty_sheaf(s, spare);
 	}
 
+	if (rcu_free)
+		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
+
 	sheaf_flush_main(s);
 }
 
@@ -2698,6 +2747,11 @@ static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
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
@@ -2723,6 +2777,7 @@ static void pcs_destroy(struct kmem_cache *s)
 		 */
 
 		WARN_ON(pcs->spare);
+		WARN_ON(pcs->rcu_free);
 
 		if (!WARN_ON(pcs->main->size)) {
 			free_empty_sheaf(s, pcs->main);
@@ -3780,7 +3835,7 @@ static bool has_pcs_used(int cpu, struct kmem_cache *s)
 
 	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
 
-	return (pcs->spare || pcs->main->size);
+	return (pcs->spare || pcs->rcu_free || pcs->main->size);
 }
 
 static void pcs_flush_all(struct kmem_cache *s);
@@ -5415,6 +5470,130 @@ bool free_to_pcs(struct kmem_cache *s, void *object)
 	return true;
 }
 
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
+	 * This may remove some objects due to slab_free_hook() returning false,
+	 * so that the sheaf might no longer be completely full. But it's easier
+	 * to handle it as full (unless it became completely empty), as the code
+	 * handles it fine. The only downside is that sheaf will serve fewer
+	 * allocations when reused. It only happens due to debugging, which is a
+	 * performance hit anyway.
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
+		struct node_barn *barn;
+
+		if (pcs->spare && pcs->spare->size == 0) {
+			pcs->rcu_free = pcs->spare;
+			pcs->spare = NULL;
+			goto do_free;
+		}
+
+		barn = get_barn(s);
+
+		empty = barn_get_empty_sheaf(barn);
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
+		if (!local_trylock(&s->cpu_sheaves->lock)) {
+			barn_put_empty_sheaf(barn, empty);
+			goto fail;
+		}
+
+		pcs = this_cpu_ptr(s->cpu_sheaves);
+
+		if (unlikely(pcs->rcu_free))
+			barn_put_empty_sheaf(barn, empty);
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
@@ -6911,6 +7090,11 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
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
@@ -8286,6 +8470,8 @@ STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
 STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
 STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
 STAT_ATTR(FREE_PCS, free_cpu_sheaf);
+STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
+STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
 STAT_ATTR(FREE_FASTPATH, free_fastpath);
 STAT_ATTR(FREE_SLOWPATH, free_slowpath);
 STAT_ATTR(FREE_FROZEN, free_frozen);
@@ -8384,6 +8570,8 @@ static struct attribute *slab_attrs[] = {
 	&alloc_fastpath_attr.attr,
 	&alloc_slowpath_attr.attr,
 	&free_cpu_sheaf_attr.attr,
+	&free_rcu_sheaf_attr.attr,
+	&free_rcu_sheaf_fail_attr.attr,
 	&free_fastpath_attr.attr,
 	&free_slowpath_attr.attr,
 	&free_frozen_attr.attr,

-- 
2.51.0

