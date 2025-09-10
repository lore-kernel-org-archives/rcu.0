Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E031158A
	for <rcu@vger.kernel.org>; Wed, 10 Sep 2025 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491302; cv=none; b=ra2Zm85ov6O4c5LHJQ1iP2ql1q4ibd3ZP43JAk4pZuzeIuypw89j/ETX+Jy+FsifMAvSvrCE2YPcY2D50Zn9QvfrzeyPibdISpr+byfMbsYpGZF9j+Db3LoiyRt0ykwZnC5x77hHDNiu1naQzmMiiQQtEdZSCGmKsarmE89+axk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491302; c=relaxed/simple;
	bh=g9cbuUAWUkFUAyf/4k3/s7/bNyOkiitIzQ05JCCKOuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYFkmLWlyj0AXBODQtXc+K6L1fQCiRTznlZbmcTxOdurVsUTN9fZl96HZs4PzizczP+l0HvDToZbeKq1/OMDDDVTfZ8VYcG2viF+RIZQp3CghGFjQAVEt+RAkbUGTLk2S5jYah2pEik32S9SL+VlQAjli0sIUm1B2yD5bW2ZI4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eu1749Ij; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J3j1WwYY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eu1749Ij; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J3j1WwYY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eu1749Ij";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J3j1WwYY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eu1749Ij";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J3j1WwYY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42A5C34C3D;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTAufz5l+Vwi1MYujf4i5OOI04SHSqMr5qvqknMVzaY=;
	b=Eu1749IjuQ3nDFCZbxxBwSyUbpOaR3IvEXYMV309JnAIXH/J+2N/R1WOZxOH8xMgSbMEXP
	3Xl2K2LsF5fHS0MFnmdO4bDx3o0Z0cX59UwNY2Lx/WzFxtMTX8iAJu7275KTO1K5wXj2Fr
	Tzgp3LzEw8o1GS1vu8d1mpc1fT/Qe9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTAufz5l+Vwi1MYujf4i5OOI04SHSqMr5qvqknMVzaY=;
	b=J3j1WwYYsK2o+YK+R5guQ7k613W2ZX/QcuM27yXm5TwQ0wzR9P0vmyRkAlgfnwtfMdQYmW
	uhncGsLDOy3AhvCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Eu1749Ij;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=J3j1WwYY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTAufz5l+Vwi1MYujf4i5OOI04SHSqMr5qvqknMVzaY=;
	b=Eu1749IjuQ3nDFCZbxxBwSyUbpOaR3IvEXYMV309JnAIXH/J+2N/R1WOZxOH8xMgSbMEXP
	3Xl2K2LsF5fHS0MFnmdO4bDx3o0Z0cX59UwNY2Lx/WzFxtMTX8iAJu7275KTO1K5wXj2Fr
	Tzgp3LzEw8o1GS1vu8d1mpc1fT/Qe9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTAufz5l+Vwi1MYujf4i5OOI04SHSqMr5qvqknMVzaY=;
	b=J3j1WwYYsK2o+YK+R5guQ7k613W2ZX/QcuM27yXm5TwQ0wzR9P0vmyRkAlgfnwtfMdQYmW
	uhncGsLDOy3AhvCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 993F113B01;
	Wed, 10 Sep 2025 08:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ANYiJUIwwWgGJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Sep 2025 08:01:06 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 10 Sep 2025 10:01:13 +0200
Subject: [PATCH v8 11/23] maple_tree: Drop bulk insert support
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-slub-percpu-caches-v8-11-ca3099d8352c@suse.cz>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
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
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 42A5C34C3D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Bulk insert mode was added to facilitate forking faster, but forking now
uses __mt_dup() to duplicate the tree.

The addition of sheaves has made the bulk allocations difficult to
maintain - since the expected entries would preallocate into the maple
state.  A big part of the maple state node allocation was the ability to
push nodes back onto the state for later use, which was essential to the
bulk insert algorithm.

Remove mas_expected_entries() and mas_destroy_rebalance() functions as
well as the MA_STATE_BULK and MA_STATE_REBALANCE maple state flags since
there are no users anymore.  Drop the associated testing as well.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/maple_tree.c                 | 270 +--------------------------------------
 lib/test_maple_tree.c            | 137 --------------------
 tools/testing/radix-tree/maple.c |  36 ------
 3 files changed, 4 insertions(+), 439 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 38fb68c082915211c80f473d313159599fe97e2c..4f0e30b57b0cef9e5cf791f3f64f5898752db402 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -83,13 +83,9 @@
 
 /*
  * Maple state flags
- * * MA_STATE_BULK		- Bulk insert mode
- * * MA_STATE_REBALANCE		- Indicate a rebalance during bulk insert
  * * MA_STATE_PREALLOC		- Preallocated nodes, WARN_ON allocation
  */
-#define MA_STATE_BULK		1
-#define MA_STATE_REBALANCE	2
-#define MA_STATE_PREALLOC	4
+#define MA_STATE_PREALLOC	1
 
 #define ma_parent_ptr(x) ((struct maple_pnode *)(x))
 #define mas_tree_parent(x) ((unsigned long)(x->tree) | MA_ROOT_PARENT)
@@ -1031,24 +1027,6 @@ static inline void mas_descend(struct ma_state *mas)
 	mas->node = mas_slot(mas, slots, mas->offset);
 }
 
-/*
- * mte_set_gap() - Set a maple node gap.
- * @mn: The encoded maple node
- * @gap: The offset of the gap to set
- * @val: The gap value
- */
-static inline void mte_set_gap(const struct maple_enode *mn,
-				 unsigned char gap, unsigned long val)
-{
-	switch (mte_node_type(mn)) {
-	default:
-		break;
-	case maple_arange_64:
-		mte_to_node(mn)->ma64.gap[gap] = val;
-		break;
-	}
-}
-
 /*
  * mas_ascend() - Walk up a level of the tree.
  * @mas: The maple state
@@ -1878,21 +1856,7 @@ static inline int mab_calc_split(struct ma_state *mas,
 	 * end on a NULL entry, with the exception of the left-most leaf.  The
 	 * limitation means that the split of a node must be checked for this condition
 	 * and be able to put more data in one direction or the other.
-	 */
-	if (unlikely((mas->mas_flags & MA_STATE_BULK))) {
-		*mid_split = 0;
-		split = b_end - mt_min_slots[bn->type];
-
-		if (!ma_is_leaf(bn->type))
-			return split;
-
-		mas->mas_flags |= MA_STATE_REBALANCE;
-		if (!bn->slot[split])
-			split--;
-		return split;
-	}
-
-	/*
+	 *
 	 * Although extremely rare, it is possible to enter what is known as the 3-way
 	 * split scenario.  The 3-way split comes about by means of a store of a range
 	 * that overwrites the end and beginning of two full nodes.  The result is a set
@@ -2039,27 +2003,6 @@ static inline void mab_mas_cp(struct maple_big_node *b_node,
 	}
 }
 
-/*
- * mas_bulk_rebalance() - Rebalance the end of a tree after a bulk insert.
- * @mas: The maple state
- * @end: The maple node end
- * @mt: The maple node type
- */
-static inline void mas_bulk_rebalance(struct ma_state *mas, unsigned char end,
-				      enum maple_type mt)
-{
-	if (!(mas->mas_flags & MA_STATE_BULK))
-		return;
-
-	if (mte_is_root(mas->node))
-		return;
-
-	if (end > mt_min_slots[mt]) {
-		mas->mas_flags &= ~MA_STATE_REBALANCE;
-		return;
-	}
-}
-
 /*
  * mas_store_b_node() - Store an @entry into the b_node while also copying the
  * data from a maple encoded node.
@@ -2109,9 +2052,6 @@ static noinline_for_kasan void mas_store_b_node(struct ma_wr_state *wr_mas,
 	/* Handle new range ending before old range ends */
 	piv = mas_safe_pivot(mas, wr_mas->pivots, offset_end, wr_mas->type);
 	if (piv > mas->last) {
-		if (piv == ULONG_MAX)
-			mas_bulk_rebalance(mas, b_node->b_end, wr_mas->type);
-
 		if (offset_end != slot)
 			wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
 							  offset_end);
@@ -3011,126 +2951,6 @@ static inline void mas_rebalance(struct ma_state *mas,
 	return mas_spanning_rebalance(mas, &mast, empty_count);
 }
 
-/*
- * mas_destroy_rebalance() - Rebalance left-most node while destroying the maple
- * state.
- * @mas: The maple state
- * @end: The end of the left-most node.
- *
- * During a mass-insert event (such as forking), it may be necessary to
- * rebalance the left-most node when it is not sufficient.
- */
-static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end)
-{
-	enum maple_type mt = mte_node_type(mas->node);
-	struct maple_node reuse, *newnode, *parent, *new_left, *left, *node;
-	struct maple_enode *eparent, *old_eparent;
-	unsigned char offset, tmp, split = mt_slots[mt] / 2;
-	void __rcu **l_slots, **slots;
-	unsigned long *l_pivs, *pivs, gap;
-	bool in_rcu = mt_in_rcu(mas->tree);
-	unsigned char new_height = mas_mt_height(mas);
-
-	MA_STATE(l_mas, mas->tree, mas->index, mas->last);
-
-	l_mas = *mas;
-	mas_prev_sibling(&l_mas);
-
-	/* set up node. */
-	if (in_rcu) {
-		newnode = mas_pop_node(mas);
-	} else {
-		newnode = &reuse;
-	}
-
-	node = mas_mn(mas);
-	newnode->parent = node->parent;
-	slots = ma_slots(newnode, mt);
-	pivs = ma_pivots(newnode, mt);
-	left = mas_mn(&l_mas);
-	l_slots = ma_slots(left, mt);
-	l_pivs = ma_pivots(left, mt);
-	if (!l_slots[split])
-		split++;
-	tmp = mas_data_end(&l_mas) - split;
-
-	memcpy(slots, l_slots + split + 1, sizeof(void *) * tmp);
-	memcpy(pivs, l_pivs + split + 1, sizeof(unsigned long) * tmp);
-	pivs[tmp] = l_mas.max;
-	memcpy(slots + tmp, ma_slots(node, mt), sizeof(void *) * end);
-	memcpy(pivs + tmp, ma_pivots(node, mt), sizeof(unsigned long) * end);
-
-	l_mas.max = l_pivs[split];
-	mas->min = l_mas.max + 1;
-	old_eparent = mt_mk_node(mte_parent(l_mas.node),
-			     mas_parent_type(&l_mas, l_mas.node));
-	tmp += end;
-	if (!in_rcu) {
-		unsigned char max_p = mt_pivots[mt];
-		unsigned char max_s = mt_slots[mt];
-
-		if (tmp < max_p)
-			memset(pivs + tmp, 0,
-			       sizeof(unsigned long) * (max_p - tmp));
-
-		if (tmp < mt_slots[mt])
-			memset(slots + tmp, 0, sizeof(void *) * (max_s - tmp));
-
-		memcpy(node, newnode, sizeof(struct maple_node));
-		ma_set_meta(node, mt, 0, tmp - 1);
-		mte_set_pivot(old_eparent, mte_parent_slot(l_mas.node),
-			      l_pivs[split]);
-
-		/* Remove data from l_pivs. */
-		tmp = split + 1;
-		memset(l_pivs + tmp, 0, sizeof(unsigned long) * (max_p - tmp));
-		memset(l_slots + tmp, 0, sizeof(void *) * (max_s - tmp));
-		ma_set_meta(left, mt, 0, split);
-		eparent = old_eparent;
-
-		goto done;
-	}
-
-	/* RCU requires replacing both l_mas, mas, and parent. */
-	mas->node = mt_mk_node(newnode, mt);
-	ma_set_meta(newnode, mt, 0, tmp);
-
-	new_left = mas_pop_node(mas);
-	new_left->parent = left->parent;
-	mt = mte_node_type(l_mas.node);
-	slots = ma_slots(new_left, mt);
-	pivs = ma_pivots(new_left, mt);
-	memcpy(slots, l_slots, sizeof(void *) * split);
-	memcpy(pivs, l_pivs, sizeof(unsigned long) * split);
-	ma_set_meta(new_left, mt, 0, split);
-	l_mas.node = mt_mk_node(new_left, mt);
-
-	/* replace parent. */
-	offset = mte_parent_slot(mas->node);
-	mt = mas_parent_type(&l_mas, l_mas.node);
-	parent = mas_pop_node(mas);
-	slots = ma_slots(parent, mt);
-	pivs = ma_pivots(parent, mt);
-	memcpy(parent, mte_to_node(old_eparent), sizeof(struct maple_node));
-	rcu_assign_pointer(slots[offset], mas->node);
-	rcu_assign_pointer(slots[offset - 1], l_mas.node);
-	pivs[offset - 1] = l_mas.max;
-	eparent = mt_mk_node(parent, mt);
-done:
-	gap = mas_leaf_max_gap(mas);
-	mte_set_gap(eparent, mte_parent_slot(mas->node), gap);
-	gap = mas_leaf_max_gap(&l_mas);
-	mte_set_gap(eparent, mte_parent_slot(l_mas.node), gap);
-	mas_ascend(mas);
-
-	if (in_rcu) {
-		mas_replace_node(mas, old_eparent, new_height);
-		mas_adopt_children(mas, mas->node);
-	}
-
-	mas_update_gap(mas);
-}
-
 /*
  * mas_split_final_node() - Split the final node in a subtree operation.
  * @mast: the maple subtree state
@@ -3837,8 +3657,6 @@ static inline void mas_wr_node_store(struct ma_wr_state *wr_mas,
 
 	if (mas->last == wr_mas->end_piv)
 		offset_end++; /* don't copy this offset */
-	else if (unlikely(wr_mas->r_max == ULONG_MAX))
-		mas_bulk_rebalance(mas, mas->end, wr_mas->type);
 
 	/* set up node. */
 	if (in_rcu) {
@@ -4255,7 +4073,7 @@ static inline enum store_type mas_wr_store_type(struct ma_wr_state *wr_mas)
 	new_end = mas_wr_new_end(wr_mas);
 	/* Potential spanning rebalance collapsing a node */
 	if (new_end < mt_min_slots[wr_mas->type]) {
-		if (!mte_is_root(mas->node) && !(mas->mas_flags & MA_STATE_BULK))
+		if (!mte_is_root(mas->node))
 			return  wr_rebalance;
 		return wr_node_store;
 	}
@@ -5562,25 +5380,7 @@ void mas_destroy(struct ma_state *mas)
 	struct maple_alloc *node;
 	unsigned long total;
 
-	/*
-	 * When using mas_for_each() to insert an expected number of elements,
-	 * it is possible that the number inserted is less than the expected
-	 * number.  To fix an invalid final node, a check is performed here to
-	 * rebalance the previous node with the final node.
-	 */
-	if (mas->mas_flags & MA_STATE_REBALANCE) {
-		unsigned char end;
-		if (mas_is_err(mas))
-			mas_reset(mas);
-		mas_start(mas);
-		mtree_range_walk(mas);
-		end = mas->end + 1;
-		if (end < mt_min_slot_count(mas->node) - 1)
-			mas_destroy_rebalance(mas, end);
-
-		mas->mas_flags &= ~MA_STATE_REBALANCE;
-	}
-	mas->mas_flags &= ~(MA_STATE_BULK|MA_STATE_PREALLOC);
+	mas->mas_flags &= ~MA_STATE_PREALLOC;
 
 	total = mas_allocated(mas);
 	while (total) {
@@ -5600,68 +5400,6 @@ void mas_destroy(struct ma_state *mas)
 }
 EXPORT_SYMBOL_GPL(mas_destroy);
 
-/*
- * mas_expected_entries() - Set the expected number of entries that will be inserted.
- * @mas: The maple state
- * @nr_entries: The number of expected entries.
- *
- * This will attempt to pre-allocate enough nodes to store the expected number
- * of entries.  The allocations will occur using the bulk allocator interface
- * for speed.  Please call mas_destroy() on the @mas after inserting the entries
- * to ensure any unused nodes are freed.
- *
- * Return: 0 on success, -ENOMEM if memory could not be allocated.
- */
-int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
-{
-	int nonleaf_cap = MAPLE_ARANGE64_SLOTS - 2;
-	struct maple_enode *enode = mas->node;
-	int nr_nodes;
-	int ret;
-
-	/*
-	 * Sometimes it is necessary to duplicate a tree to a new tree, such as
-	 * forking a process and duplicating the VMAs from one tree to a new
-	 * tree.  When such a situation arises, it is known that the new tree is
-	 * not going to be used until the entire tree is populated.  For
-	 * performance reasons, it is best to use a bulk load with RCU disabled.
-	 * This allows for optimistic splitting that favours the left and reuse
-	 * of nodes during the operation.
-	 */
-
-	/* Optimize splitting for bulk insert in-order */
-	mas->mas_flags |= MA_STATE_BULK;
-
-	/*
-	 * Avoid overflow, assume a gap between each entry and a trailing null.
-	 * If this is wrong, it just means allocation can happen during
-	 * insertion of entries.
-	 */
-	nr_nodes = max(nr_entries, nr_entries * 2 + 1);
-	if (!mt_is_alloc(mas->tree))
-		nonleaf_cap = MAPLE_RANGE64_SLOTS - 2;
-
-	/* Leaves; reduce slots to keep space for expansion */
-	nr_nodes = DIV_ROUND_UP(nr_nodes, MAPLE_RANGE64_SLOTS - 2);
-	/* Internal nodes */
-	nr_nodes += DIV_ROUND_UP(nr_nodes, nonleaf_cap);
-	/* Add working room for split (2 nodes) + new parents */
-	mas_node_count_gfp(mas, nr_nodes + 3, GFP_KERNEL);
-
-	/* Detect if allocations run out */
-	mas->mas_flags |= MA_STATE_PREALLOC;
-
-	if (!mas_is_err(mas))
-		return 0;
-
-	ret = xa_err(mas->node);
-	mas->node = enode;
-	mas_destroy(mas);
-	return ret;
-
-}
-EXPORT_SYMBOL_GPL(mas_expected_entries);
-
 static void mas_may_activate(struct ma_state *mas)
 {
 	if (!mas->node) {
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index cb3936595b0d56a9682ff100eba54693a1427829..14fbbee32046a13d54d60dcac2b45be2bd190ac4 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -2746,139 +2746,6 @@ static noinline void __init check_fuzzer(struct maple_tree *mt)
 	mtree_test_erase(mt, ULONG_MAX - 10);
 }
 
-/* duplicate the tree with a specific gap */
-static noinline void __init check_dup_gaps(struct maple_tree *mt,
-				    unsigned long nr_entries, bool zero_start,
-				    unsigned long gap)
-{
-	unsigned long i = 0;
-	struct maple_tree newmt;
-	int ret;
-	void *tmp;
-	MA_STATE(mas, mt, 0, 0);
-	MA_STATE(newmas, &newmt, 0, 0);
-	struct rw_semaphore newmt_lock;
-
-	init_rwsem(&newmt_lock);
-	mt_set_external_lock(&newmt, &newmt_lock);
-
-	if (!zero_start)
-		i = 1;
-
-	mt_zero_nr_tallocated();
-	for (; i <= nr_entries; i++)
-		mtree_store_range(mt, i*10, (i+1)*10 - gap,
-				  xa_mk_value(i), GFP_KERNEL);
-
-	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
-	mt_set_non_kernel(99999);
-	down_write(&newmt_lock);
-	ret = mas_expected_entries(&newmas, nr_entries);
-	mt_set_non_kernel(0);
-	MT_BUG_ON(mt, ret != 0);
-
-	rcu_read_lock();
-	mas_for_each(&mas, tmp, ULONG_MAX) {
-		newmas.index = mas.index;
-		newmas.last = mas.last;
-		mas_store(&newmas, tmp);
-	}
-	rcu_read_unlock();
-	mas_destroy(&newmas);
-
-	__mt_destroy(&newmt);
-	up_write(&newmt_lock);
-}
-
-/* Duplicate many sizes of trees.  Mainly to test expected entry values */
-static noinline void __init check_dup(struct maple_tree *mt)
-{
-	int i;
-	int big_start = 100010;
-
-	/* Check with a value at zero */
-	for (i = 10; i < 1000; i++) {
-		mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
-		check_dup_gaps(mt, i, true, 5);
-		mtree_destroy(mt);
-		rcu_barrier();
-	}
-
-	cond_resched();
-	mt_cache_shrink();
-	/* Check with a value at zero, no gap */
-	for (i = 1000; i < 2000; i++) {
-		mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
-		check_dup_gaps(mt, i, true, 0);
-		mtree_destroy(mt);
-		rcu_barrier();
-	}
-
-	cond_resched();
-	mt_cache_shrink();
-	/* Check with a value at zero and unreasonably large */
-	for (i = big_start; i < big_start + 10; i++) {
-		mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
-		check_dup_gaps(mt, i, true, 5);
-		mtree_destroy(mt);
-		rcu_barrier();
-	}
-
-	cond_resched();
-	mt_cache_shrink();
-	/* Small to medium size not starting at zero*/
-	for (i = 200; i < 1000; i++) {
-		mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
-		check_dup_gaps(mt, i, false, 5);
-		mtree_destroy(mt);
-		rcu_barrier();
-	}
-
-	cond_resched();
-	mt_cache_shrink();
-	/* Unreasonably large not starting at zero*/
-	for (i = big_start; i < big_start + 10; i++) {
-		mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
-		check_dup_gaps(mt, i, false, 5);
-		mtree_destroy(mt);
-		rcu_barrier();
-		cond_resched();
-		mt_cache_shrink();
-	}
-
-	/* Check non-allocation tree not starting at zero */
-	for (i = 1500; i < 3000; i++) {
-		mt_init_flags(mt, 0);
-		check_dup_gaps(mt, i, false, 5);
-		mtree_destroy(mt);
-		rcu_barrier();
-		cond_resched();
-		if (i % 2 == 0)
-			mt_cache_shrink();
-	}
-
-	mt_cache_shrink();
-	/* Check non-allocation tree starting at zero */
-	for (i = 200; i < 1000; i++) {
-		mt_init_flags(mt, 0);
-		check_dup_gaps(mt, i, true, 5);
-		mtree_destroy(mt);
-		rcu_barrier();
-		cond_resched();
-	}
-
-	mt_cache_shrink();
-	/* Unreasonably large */
-	for (i = big_start + 5; i < big_start + 10; i++) {
-		mt_init_flags(mt, 0);
-		check_dup_gaps(mt, i, true, 5);
-		mtree_destroy(mt);
-		rcu_barrier();
-		mt_cache_shrink();
-		cond_resched();
-	}
-}
-
 static noinline void __init check_bnode_min_spanning(struct maple_tree *mt)
 {
 	int i = 50;
@@ -4077,10 +3944,6 @@ static int __init maple_tree_seed(void)
 	check_fuzzer(&tree);
 	mtree_destroy(&tree);
 
-	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
-	check_dup(&tree);
-	mtree_destroy(&tree);
-
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_bnode_min_spanning(&tree);
 	mtree_destroy(&tree);
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 172700fb7784d29f9403003b4484a5ebd7aa316b..c0543060dae2510477963331fb0ccdffd78ea965 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35455,17 +35455,6 @@ static void check_dfs_preorder(struct maple_tree *mt)
 	MT_BUG_ON(mt, count != e);
 	mtree_destroy(mt);
 
-	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
-	mas_reset(&mas);
-	mt_zero_nr_tallocated();
-	mt_set_non_kernel(200);
-	mas_expected_entries(&mas, max);
-	for (count = 0; count <= max; count++) {
-		mas.index = mas.last = count;
-		mas_store(&mas, xa_mk_value(count));
-		MT_BUG_ON(mt, mas_is_err(&mas));
-	}
-	mas_destroy(&mas);
 	rcu_barrier();
 	/*
 	 * pr_info(" ->seq test of 0-%lu %luK in %d active (%d total)\n",
@@ -36454,27 +36443,6 @@ static inline int check_vma_modification(struct maple_tree *mt)
 	return 0;
 }
 
-/*
- * test to check that bulk stores do not use wr_rebalance as the store
- * type.
- */
-static inline void check_bulk_rebalance(struct maple_tree *mt)
-{
-	MA_STATE(mas, mt, ULONG_MAX, ULONG_MAX);
-	int max = 10;
-
-	build_full_tree(mt, 0, 2);
-
-	/* erase every entry in the tree */
-	do {
-		/* set up bulk store mode */
-		mas_expected_entries(&mas, max);
-		mas_erase(&mas);
-		MT_BUG_ON(mt, mas.store_type == wr_rebalance);
-	} while (mas_prev(&mas, 0) != NULL);
-
-	mas_destroy(&mas);
-}
 
 void farmer_tests(void)
 {
@@ -36487,10 +36455,6 @@ void farmer_tests(void)
 	check_vma_modification(&tree);
 	mtree_destroy(&tree);
 
-	mt_init(&tree);
-	check_bulk_rebalance(&tree);
-	mtree_destroy(&tree);
-
 	tree.ma_root = xa_mk_value(0);
 	mt_dump(&tree, mt_dump_dec);
 

-- 
2.51.0

