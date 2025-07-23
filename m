Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85732EACEE
	for <rcu@vger.kernel.org>; Wed, 23 Jul 2025 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277750; cv=none; b=hK2LbrpwHXQOC3Gca4TAbQYUoYqrYyCZ89MORalzJqVnwzA6Hgk+URle6ix9q46AJ1GgBi7tXt441c4tC39j5K4esZklEH/Hcm7ShcYIlphcCkCy1MQFvdTLbmi3V4NTeCSijjSLmB7yy0rsHj7zDOdYSMllkAGdme/PAy9tx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277750; c=relaxed/simple;
	bh=LQ98cXhb7xgZMnKJWRtMPbJYul6dO0G4nK4P5P/gNG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cWLf0t5xAB7NkxMkI93u7KUMiVzmXFHoWwWaYa3QM8fDWgZdsBso5ZAQYRO4OEhsH1pCiC5UP5YGqtEcdRjUKK5bnefteCOE2kh4JrDHTboG8RaV5NRXAZbMhiZrr9VRfw4nK+X0B9MRWzo5Xpnm3piuCTEC7fqP8dZvMjnjGEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ac//nzqZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uIY0+D3R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ac//nzqZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uIY0+D3R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ac//nzqZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uIY0+D3R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ac//nzqZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uIY0+D3R"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FFEC1F793;
	Wed, 23 Jul 2025 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xx1ef+51dA8FUNwEKzJAep3O9/h2Ns+stsV3pscdNoI=;
	b=ac//nzqZhn5GVqCvO6Wl9B+zJ3xm92fWBlCmqfGlFAX6d4dQnif4NgHOySxICkO/ZuMGLB
	xt4nEVAPg47fzE1xnq2u1bYu5eZWB7wqQ5BQjqjSNl4Beg0RY3iu4fjjjW2RNKIjnVkmUx
	WnFMxzzVxzhn39bXqr/dtiotEGIZqjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xx1ef+51dA8FUNwEKzJAep3O9/h2Ns+stsV3pscdNoI=;
	b=uIY0+D3RMIzg9fp1EL0Jg+kkqIX+hqQi29BGGg8gk1rjf0FrzMua/5Xnko2j1n1bjgCMMK
	h7l1g0MyEiyHCiDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xx1ef+51dA8FUNwEKzJAep3O9/h2Ns+stsV3pscdNoI=;
	b=ac//nzqZhn5GVqCvO6Wl9B+zJ3xm92fWBlCmqfGlFAX6d4dQnif4NgHOySxICkO/ZuMGLB
	xt4nEVAPg47fzE1xnq2u1bYu5eZWB7wqQ5BQjqjSNl4Beg0RY3iu4fjjjW2RNKIjnVkmUx
	WnFMxzzVxzhn39bXqr/dtiotEGIZqjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xx1ef+51dA8FUNwEKzJAep3O9/h2Ns+stsV3pscdNoI=;
	b=uIY0+D3RMIzg9fp1EL0Jg+kkqIX+hqQi29BGGg8gk1rjf0FrzMua/5Xnko2j1n1bjgCMMK
	h7l1g0MyEiyHCiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7872E13AFA;
	Wed, 23 Jul 2025 13:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wNwiHQjlgGh0IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Jul 2025 13:35:04 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 23 Jul 2025 15:34:42 +0200
Subject: [PATCH v5 09/14] mm, slub: skip percpu sheaves for remote object
 freeing
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-slub-percpu-caches-v5-9-b792cd830f5d@suse.cz>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
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
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Since we don't control the NUMA locality of objects in percpu sheaves,
allocations with node restrictions bypass them. Allocations without
restrictions may however still expect to get local objects with high
probability, and the introduction of sheaves can decrease it due to
freed object from a remote node ending up in percpu sheaves.

The fraction of such remote frees seems low (5% on an 8-node machine)
but it can be expected that some cache or workload specific corner cases
exist. We can either conclude that this is not a problem due to the low
fraction, or we can make remote frees bypass percpu sheaves and go
directly to their slabs. This will make the remote frees more expensive,
but if if's only a small fraction, most frees will still benefit from
the lower overhead of percpu sheaves.

This patch thus makes remote object freeing bypass percpu sheaves,
including bulk freeing, and kfree_rcu() via the rcu_free sheaf. However
it's not intended to be 100% guarantee that percpu sheaves will only
contain local objects. The refill from slabs does not provide that
guarantee in the first place, and there might be cpu migrations
happening when we need to unlock the local_lock. Avoiding all that could
be possible but complicated so we can leave it for later investigation
whether it would be worth it. It can be expected that the more selective
freeing will itself prevent accumulation of remote objects in percpu
sheaves so any such violations would have only short-term effects.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c |  7 +++++--
 mm/slub.c        | 42 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2d806e02568532a1000fd3912db6978e945dcfa8..f466f68a5bd82030a987baf849a98154cd48ef23 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1623,8 +1623,11 @@ static bool kfree_rcu_sheaf(void *obj)
 
 	slab = folio_slab(folio);
 	s = slab->slab_cache;
-	if (s->cpu_sheaves)
-		return __kfree_rcu_sheaf(s, obj);
+	if (s->cpu_sheaves) {
+		if (likely(!IS_ENABLED(CONFIG_NUMA) ||
+			   slab_nid(slab) == numa_node_id()))
+			return __kfree_rcu_sheaf(s, obj);
+	}
 
 	return false;
 }
diff --git a/mm/slub.c b/mm/slub.c
index 339d91c6ea29be99a14a8914117fab0e3e6ed26b..50fc35b8fc9b3101821c338e9469c134677ded51 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -455,6 +455,7 @@ struct slab_sheaf {
 	};
 	struct kmem_cache *cache;
 	unsigned int size;
+	int node; /* only used for rcu_sheaf */
 	void *objects[];
 };
 
@@ -5682,7 +5683,7 @@ static void rcu_free_sheaf(struct rcu_head *head)
 	 */
 	__rcu_free_sheaf_prepare(s, sheaf);
 
-	barn = get_node(s, numa_mem_id())->barn;
+	barn = get_node(s, sheaf->node)->barn;
 
 	/* due to slab_free_hook() */
 	if (unlikely(sheaf->size == 0))
@@ -5765,10 +5766,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 
 	rcu_sheaf->objects[rcu_sheaf->size++] = obj;
 
-	if (likely(rcu_sheaf->size < s->sheaf_capacity))
+	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
 		rcu_sheaf = NULL;
-	else
+	} else {
 		pcs->rcu_free = NULL;
+		rcu_sheaf->node = numa_mem_id();
+	}
 
 	local_unlock(&s->cpu_sheaves->lock);
 
@@ -5794,7 +5797,11 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	struct slab_sheaf *main, *empty;
 	bool init = slab_want_init_on_free(s);
 	unsigned int batch, i = 0;
+	void *remote_objects[PCS_BATCH_MAX];
+	unsigned int remote_nr = 0;
+	int node = numa_mem_id();
 
+next_remote_batch:
 	while (i < size) {
 		struct slab *slab = virt_to_slab(p[i]);
 
@@ -5804,7 +5811,15 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 		if (unlikely(!slab_free_hook(s, p[i], init, false))) {
 			p[i] = p[--size];
 			if (!size)
-				return;
+				goto flush_remote;
+			continue;
+		}
+
+		if (unlikely(IS_ENABLED(CONFIG_NUMA) && slab_nid(slab) != node)) {
+			remote_objects[remote_nr] = p[i];
+			p[i] = p[--size];
+			if (++remote_nr >= PCS_BATCH_MAX)
+				goto flush_remote;
 			continue;
 		}
 
@@ -5872,6 +5887,15 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	 */
 fallback:
 	__kmem_cache_free_bulk(s, size, p);
+
+flush_remote:
+	if (remote_nr) {
+		__kmem_cache_free_bulk(s, remote_nr, &remote_objects[0]);
+		if (i < size) {
+			remote_nr = 0;
+			goto next_remote_batch;
+		}
+	}
 }
 
 #ifndef CONFIG_SLUB_TINY
@@ -5963,8 +5987,14 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
 		return;
 
-	if (!s->cpu_sheaves || !free_to_pcs(s, object))
-		do_slab_free(s, slab, object, object, 1, addr);
+	if (s->cpu_sheaves && likely(!IS_ENABLED(CONFIG_NUMA) ||
+				     slab_nid(slab) == numa_mem_id())) {
+		if (likely(free_to_pcs(s, object))) {
+			return;
+		}
+	}
+
+	do_slab_free(s, slab, object, object, 1, addr);
 }
 
 #ifdef CONFIG_MEMCG

-- 
2.50.1

