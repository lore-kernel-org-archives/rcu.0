Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060D20697E;
	Tue, 12 Nov 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429591; cv=none; b=CBAZo9CqeYRdg6y4nhxIVUvN1LAGo+UFFJOav9le3gqcMgT+nOuaA2uZ5tP0vBHIdKY56Wz/BQIWn+3sosADkwXhjv0ZBBTOOpV3Un6C5U3jaiBnBx60SUrhxI4P5otW5zSe1y7uTSqhzJidlWyxEqT2nDWF2XrhKZ5av+QCMbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429591; c=relaxed/simple;
	bh=6nE4JXhtpPa9Ksw5Gnb4/9dN7CeJDc1XrhY/1U7BLXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIWvln2AK91bGTtEGYC8HpNn6LcojR903L2la8XBAY6eBs/O6GA8pOJog1c9+7YhYIV4fwajWrYBjibw1SJ4jGc2rfCqhwpqawbCL6C/AsUiD+xBBB0wShMUlPY3XFc2BKDP5EaZuvysqdzMyBV2i2Zm5F2U2YfVcJDrFxyDOqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF7711F749;
	Tue, 12 Nov 2024 16:39:47 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0F5F13AA1;
	Tue, 12 Nov 2024 16:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4KDlKtOEM2e6IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 12 Nov 2024 16:39:47 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 12 Nov 2024 17:38:50 +0100
Subject: [PATCH RFC 6/6] mm, slub: sheaf prefilling for guaranteed
 allocations
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-slub-percpu-caches-v1-6-ddc0bdc27e05@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6843; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=6nE4JXhtpPa9Ksw5Gnb4/9dN7CeJDc1XrhY/1U7BLXM=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBnM4TQAMvaemFosL6x4yQCCpE61LymMdBMw/tef
 FneZ10kYRyJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZzOE0AAKCRC74LB10kWI
 mrqtB/0Y1K6PeRzfOZSmJ81PnW9hb1dhLtFTaI0qEdXsbvIsyomX+bah7XtYhtN10o0/VWvsMbS
 yqlNe52NVyvhVgMqoEgwxFHryXf7Cl21sh60HUFKowamWJpYrXo1TuIBiUTr/GOfnl1kRzdoOyo
 8Fx4blrdqQ9op2CBxEqosOGC5CnKk/SKwycaQPXDFaQPJuBpjVMLNzrc091SMUbXb6947+Z7rZp
 FbibQPWnvNxH/v1n4AfVDEg5LWv/ob64p2hPCESPfN6GA76ownzMxl7vUZz481tSR1Y2XfYMaOf
 MwBsFdMwq0p9wbn14cfAbl3RYZq4yAGwWqGGe0WFs+eH7zhO
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CF7711F749
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Add three functions for efficient guaranteed allocations in a critical
section (that cannot sleep) when the exact number of allocations is not
known beforehand, but an upper limit can be calculated.

kmem_cache_prefill_sheaf() returns a sheaf containing at least given
number of objects.

kmem_cache_alloc_from_sheaf() will allocate an object from the sheaf
and is guaranteed not to fail until depleted.

kmem_cache_return_sheaf() is for giving the sheaf back to the slab
allocator after the critical section. This will also attempt to refill
it to cache's sheaf capacity for better efficiency of sheaves handling,
but it's not stricly necessary to succeed.

TODO: the current implementation is limited to cache's sheaf_capacity

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h |  11 ++++
 mm/slub.c            | 149 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 23904321992ad2eeb9389d0883cf4d5d5d71d896..a87dc3c6392fe235de2eabe1792df86d40c3bbf9 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -820,6 +820,17 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags,
 				   int node) __assume_slab_alignment __malloc;
 #define kmem_cache_alloc_node(...)	alloc_hooks(kmem_cache_alloc_node_noprof(__VA_ARGS__))
 
+struct slab_sheaf *
+kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int count);
+
+void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
+				       struct slab_sheaf *sheaf);
+
+void *kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *cachep, gfp_t gfp,
+			struct slab_sheaf *sheaf) __assume_slab_alignment __malloc;
+#define kmem_cache_alloc_from_sheaf(...)	\
+			alloc_hooks(kmem_cache_alloc_from_sheaf_noprof(__VA_ARGS__))
+
 /*
  * These macros allow declaring a kmem_buckets * parameter alongside size, which
  * can be compiled out with CONFIG_SLAB_BUCKETS=n so that a large number of call
diff --git a/mm/slub.c b/mm/slub.c
index 1900afa6153ca6d88f9df7db3ce84d98629489e7..a0e2cb7dfb5173f39f36bea1eb9760c3c1b99dd7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -444,6 +444,7 @@ struct slab_sheaf {
 	union {
 		struct rcu_head rcu_head;
 		struct list_head barn_list;
+		bool oversize;
 	};
 	struct kmem_cache *cache;
 	unsigned int size;
@@ -2819,6 +2820,30 @@ static int barn_put_full_sheaf(struct node_barn *barn, struct slab_sheaf *sheaf,
 	return ret;
 }
 
+static struct slab_sheaf *barn_get_full_or_empty_sheaf(struct node_barn *barn)
+{
+	struct slab_sheaf *sheaf = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	if (barn->nr_empty) {
+		sheaf = list_first_entry(&barn->sheaves_empty,
+					 struct slab_sheaf, barn_list);
+		list_del(&sheaf->barn_list);
+		barn->nr_empty--;
+	} else if (barn->nr_full) {
+		sheaf = list_first_entry(&barn->sheaves_full, struct slab_sheaf,
+					barn_list);
+		list_del(&sheaf->barn_list);
+		barn->nr_full--;
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
@@ -4893,6 +4918,130 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t gfpflags, int nod
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
 
+
+/*
+ * returns a sheaf that has least the given count of objects
+ * when prefilling is needed, do so with given gfp flags
+ *
+ * return NULL if prefilling failed, or when the requested count is
+ * above cache's sheaf_capacity (TODO: lift this limitation)
+ */
+struct slab_sheaf *
+kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int count)
+{
+	struct slub_percpu_sheaves *pcs;
+	struct slab_sheaf *sheaf = NULL;
+
+	//TODO: handle via oversize sheaf
+	if (count > s->sheaf_capacity)
+		return NULL;
+
+	pcs = cpu_sheaves_lock(s->cpu_sheaves);
+
+	if (pcs->spare && pcs->spare->size > 0) {
+		sheaf = pcs->spare;
+		pcs->spare = NULL;
+	}
+
+	if (!sheaf)
+		sheaf = barn_get_full_or_empty_sheaf(pcs->barn);
+
+	cpu_sheaves_unlock(s->cpu_sheaves);
+
+	if (!sheaf)
+		sheaf = alloc_empty_sheaf(s, gfp);
+
+	if (sheaf && sheaf->size < count) {
+		if (refill_sheaf(s, sheaf, gfp)) {
+			sheaf_flush(s, sheaf);
+			free_empty_sheaf(s, sheaf);
+			sheaf = NULL;
+		}
+	}
+
+	return sheaf;
+}
+
+/*
+ * Use this to return a sheaf obtained by kmem_cache_prefill_sheaf()
+ * It tries to refill the sheaf back to the cache's sheaf_capacity
+ * to avoid handling partially full sheaves.
+ *
+ * If the refill fails because gfp is e.g. GFP_NOWAIT, the sheaf is
+ * instead dissolved
+ */
+void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
+			     struct slab_sheaf *sheaf)
+{
+	struct slub_percpu_sheaves *pcs;
+	bool refill = false;
+	struct node_barn *barn;
+
+	//TODO: handle oversize sheaf
+
+	pcs = cpu_sheaves_lock(s->cpu_sheaves);
+
+	if (!pcs->spare) {
+		pcs->spare = sheaf;
+		sheaf = NULL;
+	}
+
+	/* racy check */
+	if (!sheaf && pcs->barn->nr_full >= MAX_FULL_SHEAVES) {
+		barn = pcs->barn;
+		refill = true;
+	}
+
+	cpu_sheaves_unlock(s->cpu_sheaves);
+
+	if (!sheaf)
+		return;
+
+	/*
+	 * if the barn is full of full sheaves or we fail to refill the sheaf,
+	 * simply flush and free it
+	 */
+	if (!refill || refill_sheaf(s, sheaf, gfp)) {
+		sheaf_flush(s, sheaf);
+		free_empty_sheaf(s, sheaf);
+		return;
+	}
+
+	/* we racily determined the sheaf would fit, so now force it */
+	barn_put_full_sheaf(barn, sheaf, true);
+}
+
+/*
+ * Allocate from a sheaf obtained by kmem_cache_prefill_sheaf()
+ *
+ * Guaranteed not to fail as many allocations as was the requested count.
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
 /*
  * To avoid unnecessary overhead, we pass through large allocation requests
  * directly to the page allocator. We use __GFP_COMP, because we will need to

-- 
2.47.0

