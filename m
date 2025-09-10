Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9FE314A9A
	for <rcu@vger.kernel.org>; Wed, 10 Sep 2025 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491352; cv=none; b=KADRSICdwpWp788WjK1V/1lPSu43DqiDv3azEl7PYda+Ew6A9rKXQirqAeVYYkBqcYOFb3Y4Do66fIK02wfsiwBjAcKMdtuhmLkGuFSLWS+Gd2qkY+34Zn83Vk/azHs2CF5Ko+gEDJzy4LcPz3+i1BOeb0h7LCYJGKJYNHS4lm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491352; c=relaxed/simple;
	bh=77nfxFsavEoPWLw0m9ac6K7O3bLexl2j1nhMEeCW5DM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PHAhyDsvIWw1QEpwPHWs2T9chQpXg9dxeVsTZXn5BS7IE20hSuwzJiLX78AjINSeA/N6x1qNor0qKQ202XAq7XQPpK1ATix7IBGQnE4oWaJ4H8S/TWoR0aWrgkJtVEcbrw15JCGC+mDKkFcs0nmYLvjW6AMSBRyQv0pszNsyi7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QAwn/o0h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2VvFl8/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QAwn/o0h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2VvFl8/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QAwn/o0h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2VvFl8/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QAwn/o0h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2VvFl8/"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B83E35CC1E;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBs29MGarWPPgfpNi/IH3TvKAOWJMh4Zi3GI/cxY2Sw=;
	b=QAwn/o0hQcy3b0jhfKJ5rtaMkm65Q8ExQ8JQMpeYcwN68k1Sp4WdAYXg6sZHeaVJE4VAfY
	+9p1R1DBduVlM5S1LZO549DDZto6jHWa5DXUYgyADQUjM/l6dLgrAzp5poGUW8hF5zraVf
	S6WBfzUUEpbM9u8JIIqlqOmV6P3WGCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBs29MGarWPPgfpNi/IH3TvKAOWJMh4Zi3GI/cxY2Sw=;
	b=B2VvFl8/JpnCy5aMxPz4vU4D0g9UTbSLnV/oaY9FdpZusIYBkxwJddeUb53zKiUd0VNkAZ
	j6/0eYHhIq0Iu0Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBs29MGarWPPgfpNi/IH3TvKAOWJMh4Zi3GI/cxY2Sw=;
	b=QAwn/o0hQcy3b0jhfKJ5rtaMkm65Q8ExQ8JQMpeYcwN68k1Sp4WdAYXg6sZHeaVJE4VAfY
	+9p1R1DBduVlM5S1LZO549DDZto6jHWa5DXUYgyADQUjM/l6dLgrAzp5poGUW8hF5zraVf
	S6WBfzUUEpbM9u8JIIqlqOmV6P3WGCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBs29MGarWPPgfpNi/IH3TvKAOWJMh4Zi3GI/cxY2Sw=;
	b=B2VvFl8/JpnCy5aMxPz4vU4D0g9UTbSLnV/oaY9FdpZusIYBkxwJddeUb53zKiUd0VNkAZ
	j6/0eYHhIq0Iu0Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A12C613ABF;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0IQQJ0MwwWgGJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Sep 2025 08:01:07 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 10 Sep 2025 10:01:25 +0200
Subject: [PATCH v8 23/23] maple_tree: Convert forking to use the sheaf
 interface
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-slub-percpu-caches-v8-23-ca3099d8352c@suse.cz>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz, 
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to(RL941jgdop1fyjkq8h4),to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,Oracle.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -8.30

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the generic interface which should result in less bulk allocations
during a forking.

A part of this is to abstract the freeing of the sheaf or maple state
allocations into its own function so mas_destroy() and the tree
duplication code can use the same functionality to return any unused
resources.

[andriy.shevchenko@linux.intel.com: remove unused mt_alloc_bulk()]
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/maple_tree.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a912e6a1d4378e72b967027b60f8f564476ad14e..bb51424053a5c4ceece7604877dfa3cd3780944a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -172,11 +172,6 @@ static inline struct maple_node *mt_alloc_one(gfp_t gfp)
 	return kmem_cache_alloc(maple_node_cache, gfp);
 }
 
-static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
-{
-	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
-}
-
 static inline void mt_free_bulk(size_t size, void __rcu **nodes)
 {
 	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
@@ -1150,6 +1145,19 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 	mas_set_err(mas, -ENOMEM);
 }
 
+static inline void mas_empty_nodes(struct ma_state *mas)
+{
+	mas->node_request = 0;
+	if (mas->sheaf) {
+		mt_return_sheaf(mas->sheaf);
+		mas->sheaf = NULL;
+	}
+
+	if (mas->alloc) {
+		kfree(mas->alloc);
+		mas->alloc = NULL;
+	}
+}
 
 /*
  * mas_free() - Free an encoded maple node
@@ -5208,15 +5216,7 @@ EXPORT_SYMBOL_GPL(mas_preallocate);
 void mas_destroy(struct ma_state *mas)
 {
 	mas->mas_flags &= ~MA_STATE_PREALLOC;
-
-	mas->node_request = 0;
-	if (mas->sheaf)
-		mt_return_sheaf(mas->sheaf);
-	mas->sheaf = NULL;
-
-	if (mas->alloc)
-		kfree(mas->alloc);
-	mas->alloc = NULL;
+	mas_empty_nodes(mas);
 }
 EXPORT_SYMBOL_GPL(mas_destroy);
 
@@ -6241,7 +6241,7 @@ static inline void mas_dup_alloc(struct ma_state *mas, struct ma_state *new_mas,
 	struct maple_node *node = mte_to_node(mas->node);
 	struct maple_node *new_node = mte_to_node(new_mas->node);
 	enum maple_type type;
-	unsigned char request, count, i;
+	unsigned char count, i;
 	void __rcu **slots;
 	void __rcu **new_slots;
 	unsigned long val;
@@ -6249,20 +6249,17 @@ static inline void mas_dup_alloc(struct ma_state *mas, struct ma_state *new_mas,
 	/* Allocate memory for child nodes. */
 	type = mte_node_type(mas->node);
 	new_slots = ma_slots(new_node, type);
-	request = mas_data_end(mas) + 1;
-	count = mt_alloc_bulk(gfp, request, (void **)new_slots);
-	if (unlikely(count < request)) {
-		memset(new_slots, 0, request * sizeof(void *));
-		mas_set_err(mas, -ENOMEM);
+	count = mas->node_request = mas_data_end(mas) + 1;
+	mas_alloc_nodes(mas, gfp);
+	if (unlikely(mas_is_err(mas)))
 		return;
-	}
 
-	/* Restore node type information in slots. */
 	slots = ma_slots(node, type);
 	for (i = 0; i < count; i++) {
 		val = (unsigned long)mt_slot_locked(mas->tree, slots, i);
 		val &= MAPLE_NODE_MASK;
-		((unsigned long *)new_slots)[i] |= val;
+		new_slots[i] = ma_mnode_ptr((unsigned long)mas_pop_node(mas) |
+					    val);
 	}
 }
 
@@ -6316,7 +6313,7 @@ static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
 			/* Only allocate child nodes for non-leaf nodes. */
 			mas_dup_alloc(mas, new_mas, gfp);
 			if (unlikely(mas_is_err(mas)))
-				return;
+				goto empty_mas;
 		} else {
 			/*
 			 * This is the last leaf node and duplication is
@@ -6349,6 +6346,8 @@ static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
 	/* Make them the same height */
 	new_mas->tree->ma_flags = mas->tree->ma_flags;
 	rcu_assign_pointer(new_mas->tree->ma_root, root);
+empty_mas:
+	mas_empty_nodes(mas);
 }
 
 /**

-- 
2.51.0

