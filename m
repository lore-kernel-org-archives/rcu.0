Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BC3009F0
	for <rcu@vger.kernel.org>; Wed,  3 Sep 2025 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904434; cv=none; b=H7Nf+TlTdcvw0CraCsbEq47wG1465juil2ReGER43LORzAizU34z+cTsQmEw0KJmnxKgmaIfcaNUEzSkCJ6RBXLmo3xgfgIOVMg0k0Vk7pFup1ovCU1Gmq6LiXNOKSGZdyhwqeC+d+G8OUCOMgFthOVccsATaehOxxIB3psSFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904434; c=relaxed/simple;
	bh=L7pepXxJCLwzgLMMIP7/yy4noBBnWbhzfBQn6BpgavY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iZ/mx7VRNBR3H34hhed+YzRwZ9uEvRJR3FYMcbsU55V/b+veiDz/oKQTZvgsrpxEyRgXoKYcaC7e4LDj9sFwC4J2g/tpjqEEQJYKFwko6WW6w2PpIMoE3aD97VGNuZpeU6RXEA+8cimDmwCotElmpyOig0NGaTTBxx/Iv92lXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d815Ru4u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q4+GHUrg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d815Ru4u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q4+GHUrg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d815Ru4u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q4+GHUrg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d815Ru4u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q4+GHUrg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DF6C21228;
	Wed,  3 Sep 2025 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0oWCjHlWJr99JqLNVmSxndIbZ+8rS7a9vseEqgaq/bM=;
	b=d815Ru4uv7FMVwbMjJB4RuhsWaLaTIIsXS/Enetu1ehbGaUOZHzOEk5zOBUWdiHqESNPAi
	IshDv4hWYz+IXGtkMQmmUFmy32avX5EjUoim4CR+byOlCeRa1Em2yAWaM3pUCcw84d1g6J
	igpy1jGPjXru50OKpo2wnapy3YyjZ5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0oWCjHlWJr99JqLNVmSxndIbZ+8rS7a9vseEqgaq/bM=;
	b=Q4+GHUrgEiS5Zd6Q5xYp5H5wgz+ryOTaUM26qiCw7XbrlIXvK97mQmHS7/ulCABCLSR1Bj
	ijrJ8InGr+ML3NCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=d815Ru4u;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Q4+GHUrg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0oWCjHlWJr99JqLNVmSxndIbZ+8rS7a9vseEqgaq/bM=;
	b=d815Ru4uv7FMVwbMjJB4RuhsWaLaTIIsXS/Enetu1ehbGaUOZHzOEk5zOBUWdiHqESNPAi
	IshDv4hWYz+IXGtkMQmmUFmy32avX5EjUoim4CR+byOlCeRa1Em2yAWaM3pUCcw84d1g6J
	igpy1jGPjXru50OKpo2wnapy3YyjZ5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0oWCjHlWJr99JqLNVmSxndIbZ+8rS7a9vseEqgaq/bM=;
	b=Q4+GHUrgEiS5Zd6Q5xYp5H5wgz+ryOTaUM26qiCw7XbrlIXvK97mQmHS7/ulCABCLSR1Bj
	ijrJ8InGr+ML3NCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2EDC13B01;
	Wed,  3 Sep 2025 13:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4KBiK9k7uGitOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Sep 2025 13:00:09 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 03 Sep 2025 14:59:50 +0200
Subject: [PATCH v7 08/21] slab: allow NUMA restricted allocations to use
 percpu sheaves
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-slub-percpu-caches-v7-8-71c114cdefef@suse.cz>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,oracle.com:email,suse.cz:mid,suse.cz:dkim,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 7DF6C21228
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

Currently allocations asking for a specific node explicitly or via
mempolicy in strict_numa node bypass percpu sheaves. Since sheaves
contain mostly local objects, we can try allocating from them if the
local node happens to be the requested node or allowed by the mempolicy.
If we find the object from percpu sheaves is not from the expected node,
we skip the sheaves - this should be rare.

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8e34d6afccf41efad0c6620126e09f874bdcb663..d3d054579a8af710a0cbf68fe9688565c84d3609 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4816,18 +4816,43 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 }
 
 static __fastpath_inline
-void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
+void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
 {
 	struct slub_percpu_sheaves *pcs;
+	bool node_requested;
 	void *object;
 
 #ifdef CONFIG_NUMA
-	if (static_branch_unlikely(&strict_numa)) {
-		if (current->mempolicy)
-			return NULL;
+	if (static_branch_unlikely(&strict_numa) &&
+			 node == NUMA_NO_NODE) {
+
+		struct mempolicy *mpol = current->mempolicy;
+
+		if (mpol) {
+			/*
+			 * Special BIND rule support. If the local node
+			 * is in permitted set then do not redirect
+			 * to a particular node.
+			 * Otherwise we apply the memory policy to get
+			 * the node we need to allocate on.
+			 */
+			if (mpol->mode != MPOL_BIND ||
+					!node_isset(numa_mem_id(), mpol->nodes))
+
+				node = mempolicy_slab_node();
+		}
 	}
 #endif
 
+	node_requested = IS_ENABLED(CONFIG_NUMA) && node != NUMA_NO_NODE;
+
+	/*
+	 * We assume the percpu sheaves contain only local objects although it's
+	 * not completely guaranteed, so we verify later.
+	 */
+	if (unlikely(node_requested && node != numa_mem_id()))
+		return NULL;
+
 	if (!local_trylock(&s->cpu_sheaves->lock))
 		return NULL;
 
@@ -4839,7 +4864,21 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
 			return NULL;
 	}
 
-	object = pcs->main->objects[--pcs->main->size];
+	object = pcs->main->objects[pcs->main->size - 1];
+
+	if (unlikely(node_requested)) {
+		/*
+		 * Verify that the object was from the node we want. This could
+		 * be false because of cpu migration during an unlocked part of
+		 * the current allocation or previous freeing process.
+		 */
+		if (folio_nid(virt_to_folio(object)) != node) {
+			local_unlock(&s->cpu_sheaves->lock);
+			return NULL;
+		}
+	}
+
+	pcs->main->size--;
 
 	local_unlock(&s->cpu_sheaves->lock);
 
@@ -4939,8 +4978,8 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	if (unlikely(object))
 		goto out;
 
-	if (s->cpu_sheaves && node == NUMA_NO_NODE)
-		object = alloc_from_pcs(s, gfpflags);
+	if (s->cpu_sheaves)
+		object = alloc_from_pcs(s, gfpflags, node);
 
 	if (!object)
 		object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);

-- 
2.51.0

