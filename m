Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CDA24395E
	for <rcu@vger.kernel.org>; Mon, 17 Mar 2025 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222033; cv=none; b=RO8yhzDhqWSW9+OLs7dJ+R1Sw/MAUtTv04nsKKhj5IUepOUol2SLYhntfDtrUDSU5vPM2ZkM1jgciZqkHQB+jIyBYR6UIoMS1JTMl5OV991piFEr2IgEfk6lBye2dOz+5Bdk7oAnq52nEay+nMMY4vUs25DzjxLKyIE6PrxpBTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222033; c=relaxed/simple;
	bh=eBBSauznRRwuIyyiSa0prbKNbaoIsTDlGXxCILqythY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=czoJBAXTlARLaUmVeeUmkUbXnvNg/XJwQLUy3AiSHIKQiUMtOht5Mu51LPhPElv/TwOAG0kc8oyIcc1OjS9r1/zYLdHZYHbWXWVvvzIfDbdhjOtmwxwmOwhd+Speyhbqx4Ab4sB1VRTkb5ofU1iz2KRoITF+bjuK0UyQ8UPoCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NAaRuNDJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tSjPo9Qr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NAaRuNDJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tSjPo9Qr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NAaRuNDJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tSjPo9Qr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NAaRuNDJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tSjPo9Qr"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 019231F810;
	Mon, 17 Mar 2025 14:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742222014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wn9aKNpkhSMth08ochZAlsCMdZibViuHXaQHyLqEwc8=;
	b=NAaRuNDJkQWAoSM+YuAl9APkKS/YJ49HjW72D56t5K5/ytpeHa4FRuqL0iKLzpHRxI3Rm1
	krFK3Z3SjwRnp3HidFCy7LB/K7ixC17drB2XheHeL5m4kZijuaHsXveWyNZ/Gwm/1F8A5t
	O9RU6Ze2XCRx7b5/dHmBK+oZjk+twlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742222014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wn9aKNpkhSMth08ochZAlsCMdZibViuHXaQHyLqEwc8=;
	b=tSjPo9QrOt0P6i/dK50bI1yjSXmKPsLm4ridxxIvFIEmAIFKaL4GXl6r1Vtep+bFxNbKsO
	28ISaj35nBGzhKBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742222014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wn9aKNpkhSMth08ochZAlsCMdZibViuHXaQHyLqEwc8=;
	b=NAaRuNDJkQWAoSM+YuAl9APkKS/YJ49HjW72D56t5K5/ytpeHa4FRuqL0iKLzpHRxI3Rm1
	krFK3Z3SjwRnp3HidFCy7LB/K7ixC17drB2XheHeL5m4kZijuaHsXveWyNZ/Gwm/1F8A5t
	O9RU6Ze2XCRx7b5/dHmBK+oZjk+twlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742222014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wn9aKNpkhSMth08ochZAlsCMdZibViuHXaQHyLqEwc8=;
	b=tSjPo9QrOt0P6i/dK50bI1yjSXmKPsLm4ridxxIvFIEmAIFKaL4GXl6r1Vtep+bFxNbKsO
	28ISaj35nBGzhKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE4D8139D2;
	Mon, 17 Mar 2025 14:33:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0F37Nb0y2GcycQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 17 Mar 2025 14:33:33 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 17 Mar 2025 15:33:05 +0100
Subject: [PATCH RFC v3 4/8] slab: sheaf prefilling for guaranteed
 allocations
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-slub-percpu-caches-v3-4-9d9884d8b643@suse.cz>
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
In-Reply-To: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz
X-Mailer: b4 0.14.2
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLsunix6otu811wnbhxcn9byqb)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Add functions for efficient guaranteed allocations e.g. in a critical
section that cannot sleep, when the exact number of allocations is not
known beforehand, but an upper limit can be calculated.

kmem_cache_prefill_sheaf() returns a sheaf containing at least given
number of objects.

kmem_cache_alloc_from_sheaf() will allocate an object from the sheaf
and is guaranteed not to fail until depleted.

kmem_cache_return_sheaf() is for giving the sheaf back to the slab
allocator after the critical section. This will also attempt to refill
it to cache's sheaf capacity for better efficiency of sheaves handling,
but it's not stricly necessary to succeed.

kmem_cache_refill_sheaf() can be used to refill a previously obtained
sheaf to requested size. If the current size is sufficient, it does
nothing. If the requested size exceeds cache's sheaf_capacity and the
sheaf's current capacity, the sheaf will be replaced with a new one,
hence the indirect pointer parameter.

kmem_cache_sheaf_size() can be used to query the current size.

The implementation supports requesting sizes that exceed cache's
sheaf_capacity, but it is not efficient - such sheaves are allocated
fresh in kmem_cache_prefill_sheaf() and flushed and freed immediately by
kmem_cache_return_sheaf(). kmem_cache_refill_sheaf() might be especially
ineffective when replacing a sheaf with a new one of a larger capacity.
It is therefore better to size cache's sheaf_capacity accordingly.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/slab.h |  16 ++++
 mm/slub.c            | 228 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 244 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0e1b25228c77140d05b5b4433c9d7923de36ec05..dd01b67982e856b1b02f4f0e6fc557726e7f02a8 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -829,6 +829,22 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags,
 				   int node) __assume_slab_alignment __malloc;
 #define kmem_cache_alloc_node(...)	alloc_hooks(kmem_cache_alloc_node_noprof(__VA_ARGS__))
 
+struct slab_sheaf *
+kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size);
+
+int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
+		struct slab_sheaf **sheafp, unsigned int size);
+
+void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
+				       struct slab_sheaf *sheaf);
+
+void *kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *cachep, gfp_t gfp,
+			struct slab_sheaf *sheaf) __assume_slab_alignment __malloc;
+#define kmem_cache_alloc_from_sheaf(...)	\
+			alloc_hooks(kmem_cache_alloc_from_sheaf_noprof(__VA_ARGS__))
+
+unsigned int kmem_cache_sheaf_size(struct slab_sheaf *sheaf);
+
 /*
  * These macros allow declaring a kmem_buckets * parameter alongside size, which
  * can be compiled out with CONFIG_SLAB_BUCKETS=n so that a large number of call
diff --git a/mm/slub.c b/mm/slub.c
index 83f4395267dccfbc144920baa7d0a85a27fbb1b4..ab3532d5f41045d8268b12ad774541dcd066c4c4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -443,6 +443,8 @@ struct slab_sheaf {
 	union {
 		struct rcu_head rcu_head;
 		struct list_head barn_list;
+		/* only used for prefilled sheafs */
+		unsigned int capacity;
 	};
 	struct kmem_cache *cache;
 	unsigned int size;
@@ -2748,6 +2750,30 @@ static int barn_put_full_sheaf(struct node_barn *barn, struct slab_sheaf *sheaf,
 	return ret;
 }
 
+static struct slab_sheaf *barn_get_full_or_empty_sheaf(struct node_barn *barn)
+{
+	struct slab_sheaf *sheaf = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	if (barn->nr_full) {
+		sheaf = list_first_entry(&barn->sheaves_full, struct slab_sheaf,
+					barn_list);
+		list_del(&sheaf->barn_list);
+		barn->nr_full--;
+	} else if (barn->nr_empty) {
+		sheaf = list_first_entry(&barn->sheaves_empty,
+					 struct slab_sheaf, barn_list);
+		list_del(&sheaf->barn_list);
+		barn->nr_empty--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return sheaf;
+}
+
 /*
  * If a full sheaf is available, return it and put the supplied empty one to
  * barn. We ignore the limit on empty sheaves as the number of sheaves doesn't
@@ -4844,6 +4870,208 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t gfpflags, int nod
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
 
+/*
+ * returns a sheaf that has least the requested size
+ * when prefilling is needed, do so with given gfp flags
+ *
+ * return NULL if sheaf allocation or prefilling failed
+ */
+struct slab_sheaf *
+kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
+{
+	struct slub_percpu_sheaves *pcs;
+	struct slab_sheaf *sheaf = NULL;
+
+	if (unlikely(size > s->sheaf_capacity)) {
+		sheaf = kzalloc(struct_size(sheaf, objects, size), gfp);
+		if (!sheaf)
+			return NULL;
+
+		sheaf->cache = s;
+		sheaf->capacity = size;
+
+		if (!__kmem_cache_alloc_bulk(s, gfp, size,
+					     &sheaf->objects[0])) {
+			kfree(sheaf);
+			return NULL;
+		}
+
+		sheaf->size = size;
+
+		return sheaf;
+	}
+
+	localtry_lock(&s->cpu_sheaves->lock);
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	if (pcs->spare) {
+		sheaf = pcs->spare;
+		pcs->spare = NULL;
+	}
+
+	if (!sheaf)
+		sheaf = barn_get_full_or_empty_sheaf(pcs->barn);
+
+	localtry_unlock(&s->cpu_sheaves->lock);
+
+	if (!sheaf)
+		sheaf = alloc_empty_sheaf(s, gfp);
+
+	if (sheaf && sheaf->size < size) {
+		if (refill_sheaf(s, sheaf, gfp)) {
+			sheaf_flush_unused(s, sheaf);
+			free_empty_sheaf(s, sheaf);
+			sheaf = NULL;
+		}
+	}
+
+	if (sheaf)
+		sheaf->capacity = s->sheaf_capacity;
+
+	return sheaf;
+}
+
+/*
+ * Use this to return a sheaf obtained by kmem_cache_prefill_sheaf()
+ *
+ * If the sheaf cannot simply become the percpu spare sheaf, but there's space
+ * for a full sheaf in the barn, we try to refill the sheaf back to the cache's
+ * sheaf_capacity to avoid handling partially full sheaves.
+ *
+ * If the refill fails because gfp is e.g. GFP_NOWAIT, or the barn is full, the
+ * sheaf is instead flushed and freed.
+ */
+void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
+			     struct slab_sheaf *sheaf)
+{
+	struct slub_percpu_sheaves *pcs;
+	bool refill = false;
+	struct node_barn *barn;
+
+	if (unlikely(sheaf->capacity != s->sheaf_capacity)) {
+		sheaf_flush_unused(s, sheaf);
+		kfree(sheaf);
+		return;
+	}
+
+	localtry_lock(&s->cpu_sheaves->lock);
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	if (!pcs->spare) {
+		pcs->spare = sheaf;
+		sheaf = NULL;
+	} else if (data_race(pcs->barn->nr_full) < MAX_FULL_SHEAVES) {
+		barn = pcs->barn;
+		refill = true;
+	}
+
+	localtry_unlock(&s->cpu_sheaves->lock);
+
+	if (!sheaf)
+		return;
+
+	/*
+	 * if the barn is full of full sheaves or we fail to refill the sheaf,
+	 * simply flush and free it
+	 */
+	if (!refill || refill_sheaf(s, sheaf, gfp)) {
+		sheaf_flush_unused(s, sheaf);
+		free_empty_sheaf(s, sheaf);
+		return;
+	}
+
+	/* we racily determined the sheaf would fit, so now force it */
+	barn_put_full_sheaf(barn, sheaf, true);
+}
+
+/*
+ * refill a sheaf previously returned by kmem_cache_prefill_sheaf to at least
+ * the given size
+ *
+ * the sheaf might be replaced by a new one when requesting more than
+ * s->sheaf_capacity objects if such replacement is necessary, but the refill
+ * fails (returning -ENOMEM), the existing sheaf is left intact
+ *
+ * In practice we always refill to full sheaf's capacity.
+ */
+int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
+			    struct slab_sheaf **sheafp, unsigned int size)
+{
+	struct slab_sheaf *sheaf;
+
+	/*
+	 * TODO: do we want to support *sheaf == NULL to be equivalent of
+	 * kmem_cache_prefill_sheaf() ?
+	 */
+	if (!sheafp || !(*sheafp))
+		return -EINVAL;
+
+	sheaf = *sheafp;
+	if (sheaf->size >= size)
+		return 0;
+
+	if (likely(sheaf->capacity >= size)) {
+		if (likely(sheaf->capacity == s->sheaf_capacity))
+			return refill_sheaf(s, sheaf, gfp);
+
+		if (!__kmem_cache_alloc_bulk(s, gfp, sheaf->capacity - sheaf->size,
+					     &sheaf->objects[sheaf->size])) {
+			return -ENOMEM;
+		}
+		sheaf->size = sheaf->capacity;
+
+		return 0;
+	}
+
+	/*
+	 * We had a regular sized sheaf and need an oversize one, or we had an
+	 * oversize one already but need a larger one now.
+	 * This should be a very rare path so let's not complicate it.
+	 */
+	sheaf = kmem_cache_prefill_sheaf(s, gfp, size);
+	if (!sheaf)
+		return -ENOMEM;
+
+	kmem_cache_return_sheaf(s, gfp, *sheafp);
+	*sheafp = sheaf;
+	return 0;
+}
+
+/*
+ * Allocate from a sheaf obtained by kmem_cache_prefill_sheaf()
+ *
+ * Guaranteed not to fail as many allocations as was the requested size.
+ * After the sheaf is emptied, it fails - no fallback to the slab cache itself.
+ *
+ * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACCOUNT
+ * memcg charging is forced over limit if necessary, to avoid failure.
+ */
+void *
+kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
+				   struct slab_sheaf *sheaf)
+{
+	void *ret = NULL;
+	bool init;
+
+	if (sheaf->size == 0)
+		goto out;
+
+	ret = sheaf->objects[--sheaf->size];
+
+	init = slab_want_init_on_alloc(gfp, s);
+
+	/* add __GFP_NOFAIL to force successful memcg charging */
+	slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, init, s->object_size);
+out:
+	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfp, NUMA_NO_NODE);
+
+	return ret;
+}
+
+unsigned int kmem_cache_sheaf_size(struct slab_sheaf *sheaf)
+{
+	return sheaf->size;
+}
 /*
  * To avoid unnecessary overhead, we pass through large allocation requests
  * directly to the page allocator. We use __GFP_COMP, because we will need to

-- 
2.48.1

