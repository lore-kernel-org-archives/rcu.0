Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31122EA747
	for <rcu@vger.kernel.org>; Wed, 23 Jul 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277744; cv=none; b=Y1a5DyOmZppAOKKJtr53pt6KQPCyjkMKJ0aH4uVaJzaQ1Ndj4/+WKIeUtcg7GBtKftsBmJkuhps+MyGBVAO6uuX+LIZ/6BqxwDP1bWyoBqZ8pyzY7H4ZI86Lsv1WB/9bmojZjLZ0zsPKVV3vK9t4331psn9mpaW6YWcIX5uEi3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277744; c=relaxed/simple;
	bh=OZHsqf0BcRyIzzSAZ5/8wcfhkKpJVOslJysdS4Pnj44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TsqM4D+QWqgHtgOgVZAmpHsLPLG97mBZLRtrhSCKzSNooGpOtjrJtYvv7K2b3jkLhwIBxP/ThVwrbyDbWy34+yajpaUG1WOwS9jsPL5+W5wZU76XZ4FGMNQscr8vLRXDRLJk+4n8Z5mWqxjDRYDU3abyTmpBP7Ghe2wLIE8DAcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XHGdGzm6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G7h+Bn4B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XHGdGzm6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G7h+Bn4B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XHGdGzm6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G7h+Bn4B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XHGdGzm6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G7h+Bn4B"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 562FF1F792;
	Wed, 23 Jul 2025 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fn4jC0LbpW83Xy3GBIO/Fb5+psgfkoknW+IQl2hd0g=;
	b=XHGdGzm6NEY6gd28f42z9hE54zRf3WER4Ee6OsNibRJNSg1JKCmBGAiVHdQ8pyj3o8uMre
	0TycU1VNl5TxazwOmSBMAi0OG7xykllmaUjOO39kxOUMJqYfxgySAG7HuD2Sx8AO63HOFL
	ARRI/NOSv/avAcotFJ5D0d/a78XdV7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fn4jC0LbpW83Xy3GBIO/Fb5+psgfkoknW+IQl2hd0g=;
	b=G7h+Bn4BySgaHS/bv3XrlBjpXz1UUCb5XfINdztjNigaDxC5+MMDEv/iRV5C+y7+b+fkYb
	vHgHz+1gN2P9N6CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XHGdGzm6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=G7h+Bn4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fn4jC0LbpW83Xy3GBIO/Fb5+psgfkoknW+IQl2hd0g=;
	b=XHGdGzm6NEY6gd28f42z9hE54zRf3WER4Ee6OsNibRJNSg1JKCmBGAiVHdQ8pyj3o8uMre
	0TycU1VNl5TxazwOmSBMAi0OG7xykllmaUjOO39kxOUMJqYfxgySAG7HuD2Sx8AO63HOFL
	ARRI/NOSv/avAcotFJ5D0d/a78XdV7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fn4jC0LbpW83Xy3GBIO/Fb5+psgfkoknW+IQl2hd0g=;
	b=G7h+Bn4BySgaHS/bv3XrlBjpXz1UUCb5XfINdztjNigaDxC5+MMDEv/iRV5C+y7+b+fkYb
	vHgHz+1gN2P9N6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F59D13AFC;
	Wed, 23 Jul 2025 13:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eJgwDwjlgGh0IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Jul 2025 13:35:04 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 23 Jul 2025 15:34:39 +0200
Subject: [PATCH v5 06/14] tools: Add sheaves support to testing
 infrastructure
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-slub-percpu-caches-v5-6-b792cd830f5d@suse.cz>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz, 
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,Oracle.com];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 562FF1F792
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Allocate a sheaf and fill it to the count amount.  Does not fill to the
sheaf limit to detect incorrect allocation requests.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/include/linux/slab.h   | 24 +++++++++++++
 tools/testing/shared/linux.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index d1444e79f2685edb828adbce8b3fbb500c0f8844..1962d7f1abee154e1cda5dba28aef213088dd198 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -23,6 +23,13 @@ enum slab_state {
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
@@ -80,4 +87,21 @@ void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list);
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
index f998555a1b2af4a899a468a652b04622df459ed3..e0255f53159bd3a1325d49192283dd6790a5e3b8 100644
--- a/tools/testing/shared/linux.c
+++ b/tools/testing/shared/linux.c
@@ -181,6 +181,12 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 	if (kmalloc_verbose)
 		pr_debug("Bulk alloc %zu\n", size);
 
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
2.50.1

