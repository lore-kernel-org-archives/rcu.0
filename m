Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790593081AE
	for <rcu@vger.kernel.org>; Wed,  3 Sep 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904497; cv=none; b=bgdtzQuofTa3fGAXARE9uj6Uk7IVCk6t0qeNLqbB6/qgGdRfslZS7ozrgxCvXk7oHDj3SPi5ZvQqGgA3IdXwHYtXnfBlkMUh8TDtOuLHM6giGGMV2TEzM2y0bZMAm6YMMdcs9YNNdlld/j/YcJElo1R6UlGO2s1VxiOl3PC8bJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904497; c=relaxed/simple;
	bh=sXKOtebAdp7OI7DhBdyiQlYqJN1iq1WqFWe2PLBTrdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ichXXNaiNWYVr9Q2xrGx7XFcek9sT+k3pCkqoL5RA/Yw9z/fNTF4GeRzj2ka3dESEaER5wwefnIe+IOKLCG5LUsLy+6nwNFFtnkjfTERZVh5JcF840DHUdCwrMf0OZCAJbWppO4XADKfLp0q4R2xcSavbY0521IA8Z6vAEIZaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pbjD0DBD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=spr1fns8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fpMwkQEp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+0CfIevh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pbjD0DBD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="spr1fns8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fpMwkQEp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+0CfIevh"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7EF82122F;
	Wed,  3 Sep 2025 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCcVGdp/KhsEZz39yl99PFemz0v+mJhBuOia0com5iU=;
	b=pbjD0DBDSP+X6y6paUUVdqmkZ5a/x6h4+HkbWuCEvuceCXV17FMqnuw+CrqYdLT8DlYZ7t
	pnRA1I/yBLqIe10G0C04ZxjSjyz9BLznFqlDeaL02MXVqGg/Uhbd5l7pXKwnO5I+3tb52W
	GBFgkB1ao0vNkTmb37ghR8xFB+u+mu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCcVGdp/KhsEZz39yl99PFemz0v+mJhBuOia0com5iU=;
	b=spr1fns8XDkY6mtDcaGBF4O2DIJ7W1U6L9nblQc757wCrYgwqQbDNWjIUCPKLAmf17YCK3
	e0fLSj/jKFuRftDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCcVGdp/KhsEZz39yl99PFemz0v+mJhBuOia0com5iU=;
	b=fpMwkQEp4Fd1CSGGBS/ziHHoTHOVVj3/g3fvb0Mo8AkwPXq3cDTAUwhJKDkOZS6a4FJI3s
	y7hlEpOb4JGbB2rkpRHMbgYeuTpKY4bRn+VLlfigoj0132hVOhhectjhD/dIsoBXu8hxUB
	4M+VF9DJHWETBNTFrRJZO98NUsdkphc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCcVGdp/KhsEZz39yl99PFemz0v+mJhBuOia0com5iU=;
	b=+0CfIevh4Oh3ByHQ4p+SULAyPIX5oVgNniHSh2O9xjQN5L0HW89rnkq1D8/lrWJuUUc9XY
	AyLDPdbVellDJiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D009213ACF;
	Wed,  3 Sep 2025 13:00:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uESAMto7uGitOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Sep 2025 13:00:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 03 Sep 2025 15:00:03 +0200
Subject: [PATCH v7 21/21] maple_tree: Convert forking to use the sheaf
 interface
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-slub-percpu-caches-v7-21-71c114cdefef@suse.cz>
References: <20250903-slub-percpu-caches-v7-0-71c114cdefef@suse.cz>
In-Reply-To: <20250903-slub-percpu-caches-v7-0-71c114cdefef@suse.cz>
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
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,Oracle.com];
	R_RATELIMIT(0.00)[to(RL941jgdop1fyjkq8h4),to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the generic interface which should result in less bulk allocations
during a forking.

A part of this is to abstract the freeing of the sheaf or maple state
allocations into its own function so mas_destroy() and the tree
duplication code can use the same functionality to return any unused
resources.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/maple_tree.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f2b81a8d840b219819dd10104cd25120ba913ec7..c185dbc90007a0046a37f194e73e261caa1848c0 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1172,6 +1172,19 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
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
@@ -5408,15 +5421,7 @@ void mas_destroy(struct ma_state *mas)
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
-		kfree(mas->alloc);
-	mas->alloc = NULL;
+	mas_empty_nodes(mas);
 }
 EXPORT_SYMBOL_GPL(mas_destroy);
 
@@ -6504,7 +6509,7 @@ static inline void mas_dup_alloc(struct ma_state *mas, struct ma_state *new_mas,
 	struct maple_node *node = mte_to_node(mas->node);
 	struct maple_node *new_node = mte_to_node(new_mas->node);
 	enum maple_type type;
-	unsigned char request, count, i;
+	unsigned char count, i;
 	void __rcu **slots;
 	void __rcu **new_slots;
 	unsigned long val;
@@ -6512,20 +6517,17 @@ static inline void mas_dup_alloc(struct ma_state *mas, struct ma_state *new_mas,
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
 
@@ -6579,7 +6581,7 @@ static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
 			/* Only allocate child nodes for non-leaf nodes. */
 			mas_dup_alloc(mas, new_mas, gfp);
 			if (unlikely(mas_is_err(mas)))
-				return;
+				goto empty_mas;
 		} else {
 			/*
 			 * This is the last leaf node and duplication is
@@ -6612,6 +6614,8 @@ static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
 	/* Make them the same height */
 	new_mas->tree->ma_flags = mas->tree->ma_flags;
 	rcu_assign_pointer(new_mas->tree->ma_root, root);
+empty_mas:
+	mas_empty_nodes(mas);
 }
 
 /**

-- 
2.51.0

