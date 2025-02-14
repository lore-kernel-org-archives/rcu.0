Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722381E04AC
	for <rcu@vger.kernel.org>; Fri, 14 Feb 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550472; cv=none; b=N/1tvw8e2uPzYnQ2+f1hLzhU431b8SgiBKJ+CPvdIxqiARcfdQ105ryJ+hE/eV/qK+a7d6fY1IXrqxPFwMsIYEyzEDtdVmPGOsvZgNIVVDAHbSi0FoncaT6qJt0InMuotTuR4Alyebw5QvtKd09Uam9hJuIK3M7mte/S7plAsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550472; c=relaxed/simple;
	bh=mRPFid06NgIdjdVbiBZAXkBK2kT2FnvoPAgernzWSi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=na7CL7s/1+lh+qFnOuFSRGLtVonimChkvTEnThTCl62tNZ++CSI+OYOxMu3yf3HxciV5BcZ1YewdPRvf5bvhaRabMSaY9jbagf6HRlVXjogA/HbMESjcaSC6xUVPsCteSr7I1ckwpSygE8Nd/9jKzYeydMuEnXnb4Q56eRi6Uvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0C8B1F391;
	Fri, 14 Feb 2025 16:27:42 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7FB813AF0;
	Fri, 14 Feb 2025 16:27:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +NqlLP5ur2eHSAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Feb 2025 16:27:42 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 14 Feb 2025 17:27:41 +0100
Subject: [PATCH RFC v2 05/10] slab: switch percpu sheaves locking to
 localtry_lock
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-slub-percpu-caches-v2-5-88592ee0966a@suse.cz>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
In-Reply-To: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: D0C8B1F391
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Instead of local_lock_irqsave(), use localtry_trylock() when potential
callers include irq context, and localtry_lock() otherwise (such as when
we already know the gfp flags allow blocking).

This should reduce the locking (due to irq disabling/enabling) overhead.
Failing to use percpu sheaves in an irq due to preempting an already
locked user of sheaves should be rare so it's a favorable tradeoff.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 122 ++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 76 insertions(+), 46 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 40175747212fefb27137309b27571abe8d0966e2..3d7345e7e938d53950ed0d6abe8eb0e93cf8f5b1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -450,7 +450,7 @@ struct slab_sheaf {
 };
 
 struct slub_percpu_sheaves {
-	local_lock_t lock;
+	localtry_lock_t lock;
 	struct slab_sheaf *main; /* never NULL when unlocked */
 	struct slab_sheaf *spare; /* empty or full, may be NULL */
 	struct slab_sheaf *rcu_free;
@@ -2529,16 +2529,19 @@ static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
 
 static void __kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p);
 
-static void sheaf_flush_main(struct kmem_cache *s)
+/* returns true if at least partially flushed */
+static bool sheaf_flush_main(struct kmem_cache *s)
 {
 	struct slub_percpu_sheaves *pcs;
 	unsigned int batch, remaining;
 	void *objects[PCS_BATCH_MAX];
 	struct slab_sheaf *sheaf;
-	unsigned long flags;
+	bool ret = false;
 
 next_batch:
-	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+	if (!localtry_trylock(&s->cpu_sheaves->lock))
+		return ret;
+
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 	sheaf = pcs->main;
 
@@ -2549,14 +2552,18 @@ static void sheaf_flush_main(struct kmem_cache *s)
 
 	remaining = sheaf->size;
 
-	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+	localtry_unlock(&s->cpu_sheaves->lock);
 
 	__kmem_cache_free_bulk(s, batch, &objects[0]);
 
 	stat_add(s, SHEAF_FLUSH_MAIN, batch);
 
+	ret = true;
+
 	if (remaining)
 		goto next_batch;
+
+	return ret;
 }
 
 static void sheaf_flush(struct kmem_cache *s, struct slab_sheaf *sheaf)
@@ -2593,6 +2600,8 @@ static void rcu_free_sheaf_nobarn(struct rcu_head *head)
  * Caller needs to make sure migration is disabled in order to fully flush
  * single cpu's sheaves
  *
+ * must not be called from an irq
+ *
  * flushing operations are rare so let's keep it simple and flush to slabs
  * directly, skipping the barn
  */
@@ -2600,9 +2609,8 @@ static void pcs_flush_all(struct kmem_cache *s)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *spare, *rcu_free;
-	unsigned long flags;
 
-	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+	localtry_lock(&s->cpu_sheaves->lock);
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
 	spare = pcs->spare;
@@ -2611,7 +2619,7 @@ static void pcs_flush_all(struct kmem_cache *s)
 	rcu_free = pcs->rcu_free;
 	pcs->rcu_free = NULL;
 
-	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+	localtry_unlock(&s->cpu_sheaves->lock);
 
 	if (spare) {
 		sheaf_flush(s, spare);
@@ -4554,10 +4562,11 @@ static __fastpath_inline
 void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
 {
 	struct slub_percpu_sheaves *pcs;
-	unsigned long flags;
 	void *object;
 
-	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+	if (!localtry_trylock(&s->cpu_sheaves->lock))
+		return NULL;
+
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
 	if (unlikely(pcs->main->size == 0)) {
@@ -4590,7 +4599,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
 			}
 		}
 
-		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+		localtry_unlock(&s->cpu_sheaves->lock);
 
 		if (!can_alloc)
 			return NULL;
@@ -4612,7 +4621,11 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
 		if (!full)
 			return NULL;
 
-		local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+		/*
+		 * we can reach here only when gfpflags_allow_blocking
+		 * so this must not be an irq
+		 */
+		localtry_lock(&s->cpu_sheaves->lock);
 		pcs = this_cpu_ptr(s->cpu_sheaves);
 
 		/*
@@ -4646,7 +4659,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
 do_alloc:
 	object = pcs->main->objects[--pcs->main->size];
 
-	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+	localtry_unlock(&s->cpu_sheaves->lock);
 
 	stat(s, ALLOC_PCS);
 
@@ -4658,12 +4671,13 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *main;
-	unsigned long flags;
 	unsigned int allocated = 0;
 	unsigned int batch;
 
 next_batch:
-	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+	if (!localtry_trylock(&s->cpu_sheaves->lock))
+		return allocated;
+
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
 	if (unlikely(pcs->main->size == 0)) {
@@ -4683,7 +4697,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 			goto do_alloc;
 		}
 
-		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+		localtry_unlock(&s->cpu_sheaves->lock);
 
 		/*
 		 * Once full sheaves in barn are depleted, let the bulk
@@ -4701,7 +4715,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	main->size -= batch;
 	memcpy(p, main->objects + main->size, batch * sizeof(void *));
 
-	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+	localtry_unlock(&s->cpu_sheaves->lock);
 
 	stat_add(s, ALLOC_PCS, batch);
 
@@ -5121,13 +5135,14 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
  * The object is expected to have passed slab_free_hook() already.
  */
 static __fastpath_inline
-void free_to_pcs(struct kmem_cache *s, void *object)
+bool free_to_pcs(struct kmem_cache *s, void *object)
 {
 	struct slub_percpu_sheaves *pcs;
-	unsigned long flags;
 
 restart:
-	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+	if (!localtry_trylock(&s->cpu_sheaves->lock))
+		return false;
+
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
 	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
@@ -5162,7 +5177,7 @@ void free_to_pcs(struct kmem_cache *s, void *object)
 			struct slab_sheaf *to_flush = pcs->spare;
 
 			pcs->spare = NULL;
-			local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+			localtry_unlock(&s->cpu_sheaves->lock);
 
 			sheaf_flush(s, to_flush);
 			empty = to_flush;
@@ -5170,17 +5185,27 @@ void free_to_pcs(struct kmem_cache *s, void *object)
 		}
 
 alloc_empty:
-		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+		localtry_unlock(&s->cpu_sheaves->lock);
 
 		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
 
 		if (!empty) {
-			sheaf_flush_main(s);
-			goto restart;
+			if (sheaf_flush_main(s))
+				goto restart;
+			else
+				return false;
 		}
 
 got_empty:
-		local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+		if (!localtry_trylock(&s->cpu_sheaves->lock)) {
+			struct node_barn *barn;
+
+			barn = get_node(s, numa_mem_id())->barn;
+
+			barn_put_empty_sheaf(barn, empty, true);
+			return false;
+		}
+
 		pcs = this_cpu_ptr(s->cpu_sheaves);
 
 		/*
@@ -5209,9 +5234,11 @@ void free_to_pcs(struct kmem_cache *s, void *object)
 do_free:
 	pcs->main->objects[pcs->main->size++] = object;
 
-	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+	localtry_unlock(&s->cpu_sheaves->lock);
 
 	stat(s, FREE_PCS);
+
+	return true;
 }
 
 static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
@@ -5270,9 +5297,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *rcu_sheaf;
-	unsigned long flags;
 
-	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+	if (!localtry_trylock(&s->cpu_sheaves->lock))
+		goto fail;
+
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
 	if (unlikely(!pcs->rcu_free)) {
@@ -5286,16 +5314,16 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 			goto do_free;
 		}
 
-		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+		localtry_unlock(&s->cpu_sheaves->lock);
 
 		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
 
-		if (!empty) {
-			stat(s, FREE_RCU_SHEAF_FAIL);
-			return false;
-		}
+		if (!empty)
+			goto fail;
+
+		if (!localtry_trylock(&s->cpu_sheaves->lock))
+			goto fail;
 
-		local_lock_irqsave(&s->cpu_sheaves->lock, flags);
 		pcs = this_cpu_ptr(s->cpu_sheaves);
 
 		if (unlikely(pcs->rcu_free))
@@ -5311,19 +5339,22 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 	rcu_sheaf->objects[rcu_sheaf->size++] = obj;
 
 	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
-		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+		localtry_unlock(&s->cpu_sheaves->lock);
 		stat(s, FREE_RCU_SHEAF);
 		return true;
 	}
 
 	pcs->rcu_free = NULL;
-	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+	localtry_unlock(&s->cpu_sheaves->lock);
 
 	call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
 
 	stat(s, FREE_RCU_SHEAF);
-
 	return true;
+
+fail:
+	stat(s, FREE_RCU_SHEAF_FAIL);
+	return false;
 }
 
 /*
@@ -5335,7 +5366,6 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *main;
-	unsigned long flags;
 	unsigned int batch, i = 0;
 	bool init;
 
@@ -5358,7 +5388,9 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	}
 
 next_batch:
-	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
+	if (!localtry_trylock(&s->cpu_sheaves->lock))
+		goto fallback;
+
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
 	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
@@ -5389,13 +5421,13 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 		}
 
 no_empty:
-		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+		localtry_unlock(&s->cpu_sheaves->lock);
 
 		/*
 		 * if we depleted all empty sheaves in the barn or there are too
 		 * many full sheaves, free the rest to slab pages
 		 */
-
+fallback:
 		__kmem_cache_free_bulk(s, size, p);
 		return;
 	}
@@ -5407,7 +5439,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	memcpy(main->objects + main->size, p, batch * sizeof(void *));
 	main->size += batch;
 
-	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+	localtry_unlock(&s->cpu_sheaves->lock);
 
 	stat_add(s, FREE_PCS, batch);
 
@@ -5507,9 +5539,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
 		return;
 
-	if (s->cpu_sheaves)
-		free_to_pcs(s, object);
-	else
+	if (!s->cpu_sheaves || !free_to_pcs(s, object))
 		do_slab_free(s, slab, object, object, 1, addr);
 }
 
@@ -6288,7 +6318,7 @@ static int init_percpu_sheaves(struct kmem_cache *s)
 
 		pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
 
-		local_lock_init(&pcs->lock);
+		localtry_lock_init(&pcs->lock);
 
 		nid = cpu_to_mem(cpu);
 

-- 
2.48.1

