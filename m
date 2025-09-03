Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC8F3081D6
	for <rcu@vger.kernel.org>; Wed,  3 Sep 2025 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904488; cv=none; b=iNyYv/S1bEohUDU5Qn18xt2QaMu82Dva4alpO48ePpkZnyaqti/OeQb3JPzfeVYuGZiHxZiyT7MF46KIWc5qfAD5xI5Mi8YlLyFSoSBfqTZmpMoicHuPHDeu/hKFl5Dp0+wW1uJYEuR2ssNIM98zQhve6aNXg21heSTZKnhx6WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904488; c=relaxed/simple;
	bh=hL/uYA3U34m1+gJpgX8WkZHdiwJVs5hstD7odj5T4U0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q6jDUeTL5txB+7So297nKlabjbL+ITizwbdelul/KDjhuovzeu3rItAwMvuLmh5sKK3grnA48PWfSvjTnWA00+cQtdhOaqioCAkq7eKYjW56ahiJwpLDtyacX0CLvcVb1HROf0OPf8PpoPwibezIbcWaeCHIOIrLuSCMvjA/B0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lcgO7m+f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vhzc6qP5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lcgO7m+f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vhzc6qP5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lcgO7m+f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vhzc6qP5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lcgO7m+f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vhzc6qP5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8B421F74B;
	Wed,  3 Sep 2025 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqh/ojynYkYiIA62N7CbXckVi4xdirpy4Yia9XnPMB4=;
	b=lcgO7m+fb5soZLD6tTGdgqUf95yjYRNc7HcSIk2zwh9a7DMfyNwXiS/k0hc0jf4N/WsNer
	fk5yu6yq4BzKVp2UP6c2gbT6OWelwqx6iYGSXHL3RU1Y3cJbf8zormFeJYcw2qz9wgSyI6
	VyiK4b1IORWktlKlbe6Hl5lHsm0wtF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqh/ojynYkYiIA62N7CbXckVi4xdirpy4Yia9XnPMB4=;
	b=Vhzc6qP5e9IkNDjeKP79Np6thntUaimCqyf9G1z9LZHScmEe3LuL74PwzIM1tmCnVqqnn6
	iHdh3OliNB4T65Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqh/ojynYkYiIA62N7CbXckVi4xdirpy4Yia9XnPMB4=;
	b=lcgO7m+fb5soZLD6tTGdgqUf95yjYRNc7HcSIk2zwh9a7DMfyNwXiS/k0hc0jf4N/WsNer
	fk5yu6yq4BzKVp2UP6c2gbT6OWelwqx6iYGSXHL3RU1Y3cJbf8zormFeJYcw2qz9wgSyI6
	VyiK4b1IORWktlKlbe6Hl5lHsm0wtF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqh/ojynYkYiIA62N7CbXckVi4xdirpy4Yia9XnPMB4=;
	b=Vhzc6qP5e9IkNDjeKP79Np6thntUaimCqyf9G1z9LZHScmEe3LuL74PwzIM1tmCnVqqnn6
	iHdh3OliNB4T65Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 927DA13B09;
	Wed,  3 Sep 2025 13:00:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GI14I9o7uGitOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Sep 2025 13:00:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 03 Sep 2025 15:00:00 +0200
Subject: [PATCH v7 18/21] tools/testing: Add support for prefilled slab
 sheafs
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-slub-percpu-caches-v7-18-71c114cdefef@suse.cz>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Add the prefilled sheaf structs to the slab header and the associated
functions to the testing/shared/linux.c file.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/include/linux/slab.h   | 28 ++++++++++++++
 tools/testing/shared/linux.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index c5c5cc6db5668be2cc94c29065ccfa7ca7b4bb08..94937a699402bd1f31887dfb52b6fd0a3c986f43 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -123,6 +123,18 @@ struct kmem_cache_args {
 	void (*ctor)(void *);
 };
 
+struct slab_sheaf {
+	union {
+		struct list_head barn_list;
+		/* only used for prefilled sheafs */
+		unsigned int capacity;
+	};
+	struct kmem_cache *cache;
+	unsigned int size;
+	int node; /* only used for rcu_sheaf */
+	void *objects[];
+};
+
 static inline void *kzalloc(size_t size, gfp_t gfp)
 {
 	return kmalloc(size, gfp | __GFP_ZERO);
@@ -173,5 +185,21 @@ __kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list);
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
 
 #endif		/* _TOOLS_SLAB_H */
diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
index 97b8412ccbb6d222604c7b397c53c65618d8d51b..4ceff7969b78cf8e33cd1e021c68bc9f8a02a7a1 100644
--- a/tools/testing/shared/linux.c
+++ b/tools/testing/shared/linux.c
@@ -137,6 +137,12 @@ void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list)
 	if (kmalloc_verbose)
 		pr_debug("Bulk free %p[0-%zu]\n", list, size - 1);
 
+	if (cachep->exec_callback) {
+		if (cachep->callback)
+			cachep->callback(cachep->private);
+		cachep->exec_callback = false;
+	}
+
 	pthread_mutex_lock(&cachep->lock);
 	for (int i = 0; i < size; i++)
 		kmem_cache_free_locked(cachep, list[i]);
@@ -242,6 +248,89 @@ __kmem_cache_create_args(const char *name, unsigned int size,
 	return ret;
 }
 
+struct slab_sheaf *
+kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
+{
+	struct slab_sheaf *sheaf;
+	unsigned int capacity;
+
+	if (s->exec_callback) {
+		if (s->callback)
+			s->callback(s->private);
+		s->exec_callback = false;
+	}
+
+	capacity = max(size, s->sheaf_capacity);
+
+	sheaf = calloc(1, sizeof(*sheaf) + sizeof(void *) * capacity);
+	if (!sheaf)
+		return NULL;
+
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
+	if (sheaf->size)
+		kmem_cache_free_bulk(s, sheaf->size, &sheaf->objects[0]);
+
+	free(sheaf);
+}
+
+void *
+kmem_cache_alloc_from_sheaf(struct kmem_cache *s, gfp_t gfp,
+		struct slab_sheaf *sheaf)
+{
+	void *obj;
+
+	if (sheaf->size == 0) {
+		printf("Nothing left in sheaf!\n");
+		return NULL;
+	}
+
+	obj = sheaf->objects[--sheaf->size];
+	sheaf->objects[sheaf->size] = NULL;
+
+	return obj;
+}
+
 /*
  * Test the test infrastructure for kem_cache_alloc/free and bulk counterparts.
  */

-- 
2.51.0

