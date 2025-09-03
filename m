Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FBB301482
	for <rcu@vger.kernel.org>; Wed,  3 Sep 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904497; cv=none; b=h0b8EeaBt+Y0qF7+O/VDIvXwKe+isVoQQlEhg4ZdnGNDHAkUF487pu3Ogx5jh+C6bP6nD95rhVhwCW39Yw+NfJIBphy1BLKUc5fTZJ0yl0wJwGRX+ephla4riU5LPnafpcLn/khNlDLoD3Kj7+Vz7vk2U3gRVA/jrn0J9Gnvd+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904497; c=relaxed/simple;
	bh=NEnPKJoh4PSRWp8CZDKpOmH3tB/16GPOtmyVTP2ZnoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZoWTqF4Z94FT6PKbV9IeHPS0RSIK0zUQWh9eO/Pq0TWy/mvXo8+yaAGUsrPGh2E9lH+RSAbZlYntMCMeeUlZR4pSblh+udek3eeXwOy16HpSIUCFfAoW57LqlGL/3kkuPsStHIoSg57bu//HRQcFLh/8skDu7Lyu3WaNHPfcNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JpX1EFHl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=boqME7eI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JpX1EFHl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=boqME7eI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JpX1EFHl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="boqME7eI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JpX1EFHl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="boqME7eI"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D808D1F749;
	Wed,  3 Sep 2025 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DoczhIJm/QIxVWZ7D37eQBiOD25npSD9wVr63TFoHc=;
	b=JpX1EFHlgY9lv/Jg9Np6YcccAcWwOH5vSSehOAl2iCisgztVji8k/m4iZWWDfF9G4MrMdT
	1no34TX1PZX+TkQBLMAwYVtWVMaHPFyVU8Lzoa22w0y5YHWzIoAyZhPf0NVON8mUbSGOtp
	KivRwn6uQo+9Em2sG9jItp9gTXDpBSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DoczhIJm/QIxVWZ7D37eQBiOD25npSD9wVr63TFoHc=;
	b=boqME7eIeY8AGMTBsm7dwQZietZj8zprg+GhYZE9cE6XJPyNxjngG+iIitHglC+a4CF/48
	pkAYS3zSHpyz4yDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DoczhIJm/QIxVWZ7D37eQBiOD25npSD9wVr63TFoHc=;
	b=JpX1EFHlgY9lv/Jg9Np6YcccAcWwOH5vSSehOAl2iCisgztVji8k/m4iZWWDfF9G4MrMdT
	1no34TX1PZX+TkQBLMAwYVtWVMaHPFyVU8Lzoa22w0y5YHWzIoAyZhPf0NVON8mUbSGOtp
	KivRwn6uQo+9Em2sG9jItp9gTXDpBSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DoczhIJm/QIxVWZ7D37eQBiOD25npSD9wVr63TFoHc=;
	b=boqME7eIeY8AGMTBsm7dwQZietZj8zprg+GhYZE9cE6XJPyNxjngG+iIitHglC+a4CF/48
	pkAYS3zSHpyz4yDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 675B913B08;
	Wed,  3 Sep 2025 13:00:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sDzmGNo7uGitOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Sep 2025 13:00:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 03 Sep 2025 14:59:58 +0200
Subject: [PATCH v7 16/21] maple_tree: Use kfree_rcu in ma_free_rcu
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-slub-percpu-caches-v7-16-71c114cdefef@suse.cz>
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
 Pedro Falcato <pfalcato@suse.de>
X-Mailer: b4 0.14.2
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
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,suse.de];
	R_RATELIMIT(0.00)[to(RL941jgdop1fyjkq8h4),to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

From: Pedro Falcato <pfalcato@suse.de>

kfree_rcu is an optimized version of call_rcu + kfree. It used to not be
possible to call it on non-kmalloc objects, but this restriction was
lifted ever since SLOB was dropped from the kernel, and since commit
6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()").

Thus, replace call_rcu + mt_free_rcu with kfree_rcu.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/maple_tree.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a0db6bdc63793b8bbd544e246391d99e880dede3..d77e82362f03905040ac61630f92fe9af1e59f98 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -191,13 +191,6 @@ static inline void mt_free_bulk(size_t size, void __rcu **nodes)
 	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
 }
 
-static void mt_free_rcu(struct rcu_head *head)
-{
-	struct maple_node *node = container_of(head, struct maple_node, rcu);
-
-	kmem_cache_free(maple_node_cache, node);
-}
-
 /*
  * ma_free_rcu() - Use rcu callback to free a maple node
  * @node: The node to free
@@ -208,7 +201,7 @@ static void mt_free_rcu(struct rcu_head *head)
 static void ma_free_rcu(struct maple_node *node)
 {
 	WARN_ON(node->parent != ma_parent_ptr(node));
-	call_rcu(&node->rcu, mt_free_rcu);
+	kfree_rcu(node, rcu);
 }
 
 static void mt_set_height(struct maple_tree *mt, unsigned char height)
@@ -5281,7 +5274,7 @@ static void mt_free_walk(struct rcu_head *head)
 	mt_free_bulk(node->slot_len, slots);
 
 free_leaf:
-	mt_free_rcu(&node->rcu);
+	mt_free_one(node);
 }
 
 static inline void __rcu **mte_destroy_descend(struct maple_enode **enode,
@@ -5365,7 +5358,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 
 free_leaf:
 	if (free)
-		mt_free_rcu(&node->rcu);
+		mt_free_one(node);
 	else
 		mt_clear_meta(mt, node, node->type);
 }

-- 
2.51.0

