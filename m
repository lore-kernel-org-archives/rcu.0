Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64342EB5A8
	for <rcu@vger.kernel.org>; Wed, 23 Jul 2025 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277756; cv=none; b=rbf2AoyAzu3SVkIppPEIuVW5Mg1eOCoyyDTYWfjUqZF/PR5Rdm8jBmhot9rHe4LLu0dq+x1eszLRI6tH5JmuuR63Jr/GWiqnGn2p6KNK/ticGLybGaGxaKirqC8vMJKXiNRJonk0F7aAltuzkdFdLz0ZLF5bsBUuk+w9+ur/RB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277756; c=relaxed/simple;
	bh=z5pUnyw8hUonIK9+AnJweN/AmTdJLkkwvhC18stu32w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QS+ldRaEZH+R9hVjLmzdo6QTGw4+fxIOxVwxo27KBdwTUUIGaZ8SbdHGPpMG0piWlRX5W+rBSgnrLeN0fhnrKFHLnvK/EcPLuQPAbwu/TmDRcSoO0qG8I0oM/GIN7O+mD2+eSBnT/y0AsSX8WUIHsQ5jVI6TwqwT5iigb39yfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sn6d6Wfc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3DXGttR4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sn6d6Wfc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3DXGttR4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sn6d6Wfc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3DXGttR4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sn6d6Wfc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3DXGttR4"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0AF611F794;
	Wed, 23 Jul 2025 13:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzLrbkIiOuwOvdyzKWDx4NnuEyUkSbgCzU8mbhcB3rk=;
	b=sn6d6WfcnZz0DB5GiAC6bKFdOor9xAUmtBOjzv7UyoUJi3Brgkx5qyprggCv0Jz+3zOEBw
	VAtyXImFe99kv+r3YDGZME13MuC05nGNUHzdZ4oneFTxPl9nqQx/Ouv962zpAgZk2qzTC4
	9imwhDfigzZKEOTRlrH+cY08NQ+0Uro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzLrbkIiOuwOvdyzKWDx4NnuEyUkSbgCzU8mbhcB3rk=;
	b=3DXGttR4IxzgIWDb2FW7GeODLV2hRB1+1SJUyMLWvyXK6xe4UaC+7BfWGz+b3dUeL4MiHq
	BeWT8hkanTBQ29CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sn6d6Wfc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3DXGttR4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzLrbkIiOuwOvdyzKWDx4NnuEyUkSbgCzU8mbhcB3rk=;
	b=sn6d6WfcnZz0DB5GiAC6bKFdOor9xAUmtBOjzv7UyoUJi3Brgkx5qyprggCv0Jz+3zOEBw
	VAtyXImFe99kv+r3YDGZME13MuC05nGNUHzdZ4oneFTxPl9nqQx/Ouv962zpAgZk2qzTC4
	9imwhDfigzZKEOTRlrH+cY08NQ+0Uro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzLrbkIiOuwOvdyzKWDx4NnuEyUkSbgCzU8mbhcB3rk=;
	b=3DXGttR4IxzgIWDb2FW7GeODLV2hRB1+1SJUyMLWvyXK6xe4UaC+7BfWGz+b3dUeL4MiHq
	BeWT8hkanTBQ29CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD4CB13ADD;
	Wed, 23 Jul 2025 13:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gCa6NQjlgGh0IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Jul 2025 13:35:04 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 23 Jul 2025 15:34:47 +0200
Subject: [PATCH v5 14/14] maple_tree: Convert forking to use the sheaf
 interface
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-slub-percpu-caches-v5-14-b792cd830f5d@suse.cz>
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
X-Rspamd-Queue-Id: 0AF611F794
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the generic interface which should result in less bulk allocations
during a forking.

A part of this is to abstract the freeing of the sheaf or maple state
allocations into its own function so mas_destroy() and the tree
duplication code can use the same functionality to return any unused
resources.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/maple_tree.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9aa782b1497f224e7366ebbd65f997523ee0c8ab..180d5e2ea49440248aaae04a066276406b2537ed 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1178,6 +1178,19 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
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
+		mt_free_one(mas->alloc);
+		mas->alloc = NULL;
+	}
+}
 
 /*
  * mas_free() - Free an encoded maple node
@@ -5414,15 +5427,7 @@ void mas_destroy(struct ma_state *mas)
 		mas->mas_flags &= ~MA_STATE_REBALANCE;
 	}
 	mas->mas_flags &= ~(MA_STATE_BULK|MA_STATE_PREALLOC);
-
-	mas->node_request = 0;
-	if (mas->sheaf)
-		mt_return_sheaf(mas->sheaf);
-	mas->sheaf = NULL;
-
-	if (mas->alloc)
-		mt_free_one(mas->alloc);
-	mas->alloc = NULL;
+	mas_empty_nodes(mas);
 }
 EXPORT_SYMBOL_GPL(mas_destroy);
 
@@ -6499,7 +6504,7 @@ static inline void mas_dup_alloc(struct ma_state *mas, struct ma_state *new_mas,
 	struct maple_node *node = mte_to_node(mas->node);
 	struct maple_node *new_node = mte_to_node(new_mas->node);
 	enum maple_type type;
-	unsigned char request, count, i;
+	unsigned char count, i;
 	void __rcu **slots;
 	void __rcu **new_slots;
 	unsigned long val;
@@ -6507,20 +6512,17 @@ static inline void mas_dup_alloc(struct ma_state *mas, struct ma_state *new_mas,
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
 
@@ -6574,7 +6576,7 @@ static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
 			/* Only allocate child nodes for non-leaf nodes. */
 			mas_dup_alloc(mas, new_mas, gfp);
 			if (unlikely(mas_is_err(mas)))
-				return;
+				goto empty_mas;
 		} else {
 			/*
 			 * This is the last leaf node and duplication is
@@ -6607,6 +6609,8 @@ static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
 	/* Make them the same height */
 	new_mas->tree->ma_flags = mas->tree->ma_flags;
 	rcu_assign_pointer(new_mas->tree->ma_root, root);
+empty_mas:
+	mas_empty_nodes(mas);
 }
 
 /**

-- 
2.50.1

