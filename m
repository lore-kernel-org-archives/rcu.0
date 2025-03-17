Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D994224887E
	for <rcu@vger.kernel.org>; Mon, 17 Mar 2025 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222045; cv=none; b=CotxFzfDCZau3sDE63FVfzSzK2sdRKnsy4Ry6hmTlu7QsEJdkFDTW8La+CAPm4TYENdXHqjo3VCz+21hCTCw5n19OI/CfW2pKq5svFpItG72VPjYLQvIIWdcr6mC6xKyzwUYYJjePqnCHxM6l6zy11CfQxI6DNseG6zwlzJj7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222045; c=relaxed/simple;
	bh=YcbkGnbxdXtg5xN4k/T//6Yv9x3ZDzyhgM6e4NRlNGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sfn5qrqz7WN09TsjSHEyM2s8dNMfYXPPeCONX8OgNMyoAWjp8Cex8nGMczqi0f6zburWi5B7l5ELyIPmOK21EtWJGD3sWCKshlCVr8c+tKJ0bGS1Hdvo3pRUXlBVLPNifSvq/Fa8xdUERwv/S+offDO8mGDzsbEJ3EbgAsAxUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3980C1F834;
	Mon, 17 Mar 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21CA613A31;
	Mon, 17 Mar 2025 14:33:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GHf6B74y2GcycQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 17 Mar 2025 14:33:34 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 17 Mar 2025 15:33:08 +0100
Subject: [PATCH RFC v3 7/8] tools: Add sheafs support to testing
 infrastructure
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-slub-percpu-caches-v3-7-9d9884d8b643@suse.cz>
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
In-Reply-To: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz, 
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>
X-Mailer: b4 0.14.2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 3980C1F834
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Allocate a sheaf and fill it to the count amount.  Does not fill to the
sheaf limit to detect incorrect allocation requests.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/include/linux/slab.h   | 24 +++++++++++++
 tools/testing/shared/linux.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index a475364cfd9fcdb10db252aab18ea3a620326b6b..0b6b42c9921fc402b4f3d4f681a95c9067d128db 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -22,6 +22,13 @@ enum slab_state {
 	FULL
 };
 
+struct slab_sheaf {
+	struct kmem_cache *cache;
+	unsigned int size;
+	unsigned int capacity;
+	void *objects[];
+};
+
 struct kmem_cache_args {
 	unsigned int align;
 	unsigned int sheaf_capacity;
@@ -79,4 +86,21 @@ void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list);
 int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 			  void **list);
 
+struct slab_sheaf *
+kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size);
+
+void *
+kmem_cache_alloc_from_sheaf(struct kmem_cache *s, gfp_t gfp,
+		struct slab_sheaf *sheaf);
+
+void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
+		struct slab_sheaf *sheaf);
+int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
+		struct slab_sheaf **sheafp, unsigned int size);
+
+static inline unsigned int kmem_cache_sheaf_size(struct slab_sheaf *sheaf)
+{
+	return sheaf->size;
+}
+
 #endif		/* _TOOLS_SLAB_H */
diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
index 9f5fd722f27f1d3877be8927be30409cd74ab3c3..a61c755c3c87e80036a5173115e955bfe7d5a80c 100644
--- a/tools/testing/shared/linux.c
+++ b/tools/testing/shared/linux.c
@@ -181,6 +181,12 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 	if (kmalloc_verbose)
 		pr_debug("Bulk alloc %lu\n", size);
 
+	if (cachep->exec_callback) {
+		if (cachep->callback)
+			cachep->callback(cachep->private);
+		cachep->exec_callback = false;
+	}
+
 	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs >= size) {
 		struct radix_tree_node *node;
@@ -270,6 +276,84 @@ __kmem_cache_create_args(const char *name, unsigned int size,
 	return ret;
 }
 
+struct slab_sheaf *
+kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
+{
+	struct slab_sheaf *sheaf;
+	unsigned int capacity;
+
+	if (size > s->sheaf_capacity)
+		capacity = size;
+	else
+		capacity = s->sheaf_capacity;
+
+	sheaf = malloc(sizeof(*sheaf) + sizeof(void *) * s->sheaf_capacity * capacity);
+	if (!sheaf) {
+		return NULL;
+	}
+
+	memset(sheaf, 0, size);
+	sheaf->cache = s;
+	sheaf->capacity = capacity;
+	sheaf->size = kmem_cache_alloc_bulk(s, gfp, size, sheaf->objects);
+	if (!sheaf->size) {
+		free(sheaf);
+		return NULL;
+	}
+
+	return sheaf;
+}
+
+int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
+		 struct slab_sheaf **sheafp, unsigned int size)
+{
+	struct slab_sheaf *sheaf = *sheafp;
+	int refill;
+
+	if (sheaf->size >= size)
+		return 0;
+
+	if (size > sheaf->capacity) {
+		sheaf = kmem_cache_prefill_sheaf(s, gfp, size);
+		if (!sheaf)
+			return -ENOMEM;
+
+		kmem_cache_return_sheaf(s, gfp, *sheafp);
+		*sheafp = sheaf;
+		return 0;
+	}
+
+	refill = kmem_cache_alloc_bulk(s, gfp, size - sheaf->size,
+				       &sheaf->objects[sheaf->size]);
+	if (!refill)
+		return -ENOMEM;
+
+	sheaf->size += refill;
+	return 0;
+}
+
+void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
+		 struct slab_sheaf *sheaf)
+{
+	if (sheaf->size) {
+		//s->non_kernel += sheaf->size;
+		kmem_cache_free_bulk(s, sheaf->size, &sheaf->objects[0]);
+	}
+	free(sheaf);
+}
+
+void *
+kmem_cache_alloc_from_sheaf(struct kmem_cache *s, gfp_t gfp,
+		struct slab_sheaf *sheaf)
+{
+	if (sheaf->size == 0) {
+		printf("Nothing left in sheaf!\n");
+		return NULL;
+	}
+
+	return sheaf->objects[--sheaf->size];
+}
+
 /*
  * Test the test infrastructure for kem_cache_alloc/free and bulk counterparts.
  */

-- 
2.48.1

