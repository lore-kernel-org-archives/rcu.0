Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F077E0ED
	for <rcu@vger.kernel.org>; Fri, 14 Feb 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550503; cv=none; b=WT3iBMfrkdrDSr30BKri5mXLTqSUx6ew88f+xAx82nNPJ6jJRTtJx7RR2bXP07X080jOp/PSexSffBSGXyrJ1F6jIRJHcF4c0KWxPuR/4UI79YpYjMVWlIIPLl0lPplKWFtKIf9Lw4XD1snNl130GaKlKNwC04qqWLwu+KVP+Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550503; c=relaxed/simple;
	bh=YcbkGnbxdXtg5xN4k/T//6Yv9x3ZDzyhgM6e4NRlNGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=anYL2ehQNSj9jCVIQJYPcyFIPJrTAN8osLdP6YJWm+a3MhrUQRX+NUezxg1WsMgGvLvhy6eI6aMFDFlY0w27YcOiL5iIFsXDkDjTngKJbt56BXPNdY6h45HUcn9T+extsmcZG3QpFxJzRlaLqQu8d8/AJAZkwFR/dsTpI5xlKBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RpkB5Uve; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D6XOFrAu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RpkB5Uve; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D6XOFrAu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RpkB5Uve";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D6XOFrAu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RpkB5Uve";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D6XOFrAu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 224D821182;
	Fri, 14 Feb 2025 16:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739550463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjFVlcsr+qf6NE7vGqH0rVwP/2BNHmoTxp+iBx2dj3o=;
	b=RpkB5UvecXy4Ua+2FL04BYhw8d9UY3RMcc6XMyHNgP9SRds35S0Hnf2XzB/k8+96swccWP
	WRBv0chQmw2cYz7EtmaVqslic/UDrdMXrLMRtXpfQg1g/QAr4UqpGSAdd7hnUbtz8ljiRD
	FXIUEYbx1B4Vx+3NmIRR8oVPdq51ivU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739550463;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjFVlcsr+qf6NE7vGqH0rVwP/2BNHmoTxp+iBx2dj3o=;
	b=D6XOFrAuPAhH4kRBbF+xAHLxarL2LQ4Y/N9zhKF+KqFbNnAM+Zt6qY2S0fc1rb8buisBCd
	dvO2JhlgCaSm/hDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739550463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjFVlcsr+qf6NE7vGqH0rVwP/2BNHmoTxp+iBx2dj3o=;
	b=RpkB5UvecXy4Ua+2FL04BYhw8d9UY3RMcc6XMyHNgP9SRds35S0Hnf2XzB/k8+96swccWP
	WRBv0chQmw2cYz7EtmaVqslic/UDrdMXrLMRtXpfQg1g/QAr4UqpGSAdd7hnUbtz8ljiRD
	FXIUEYbx1B4Vx+3NmIRR8oVPdq51ivU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739550463;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjFVlcsr+qf6NE7vGqH0rVwP/2BNHmoTxp+iBx2dj3o=;
	b=D6XOFrAuPAhH4kRBbF+xAHLxarL2LQ4Y/N9zhKF+KqFbNnAM+Zt6qY2S0fc1rb8buisBCd
	dvO2JhlgCaSm/hDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E61713285;
	Fri, 14 Feb 2025 16:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IM1BA/9ur2eHSAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Feb 2025 16:27:43 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 14 Feb 2025 17:27:45 +0100
Subject: [PATCH RFC v2 09/10] tools: Add sheafs support to testing
 infrastructure
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-slub-percpu-caches-v2-9-88592ee0966a@suse.cz>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
In-Reply-To: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, "Liam R. Howlett" <Liam.Howlett@Oracle.com>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,Oracle.com];
	R_RATELIMIT(0.00)[to_ip_from(RLtz7ce9b89hw8xzamye9qeynd)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

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

