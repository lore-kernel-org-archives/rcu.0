Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00B314A6D
	for <rcu@vger.kernel.org>; Wed, 10 Sep 2025 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491345; cv=none; b=QbdTrrd6H17kD5+5jBKXXR81lC0l9cy3NUjf/Li3UbNhE57m2i8PI7Yqf+3I1oHX2w4qlfWbd+5074TOVMe4aHwpGzGkF9KTYiRUPyLf4OkJjJ1Qlh++vKChM2xIziYD0Dtof4DJsgoKhsyM8owtQ43ACCfpPACrvfV5JQ+brtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491345; c=relaxed/simple;
	bh=th11ShjVAeX5+cSm0X+revws6o8w5NssszS+FOPUo4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tfsHCl5KmNHuCdCWCdhu30bdoA3ivPFX3jk1WB60mVOmfm3M1tDuf0nIy2asUDkJQKxisONwbhfuDdxXe6Q+EWpsSz4zl/7zdQ/ZrLKzZqe57RxK8YEWKL/uNnqENU8o8vqLGSp6cTXBE3CXcTsecDFBC87t/+Y8VqyFXHajVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XH1P/pCm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=96GHuDHG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XH1P/pCm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=96GHuDHG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XH1P/pCm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="96GHuDHG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XH1P/pCm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="96GHuDHG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65D705CB7F;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suObi2/GY4gIdOy8/pJdudh4YHfdoLo9Lt+1E266qUA=;
	b=XH1P/pCm7aIhdWR2K+hIhZNEHdMZ3IZbS3VhIImYaSvMZvBS+/fs5djvmdoTXkHjT78KPG
	KCtg3OkOWqkWN6Qut5anMLrs+F+LOsMsjQjHugmwQJikMbosqj/tBQTLL2ft0qZRI1ucjk
	eEAdqrh908w1crlBF+wFd9tGnM8Wwnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suObi2/GY4gIdOy8/pJdudh4YHfdoLo9Lt+1E266qUA=;
	b=96GHuDHGXNaNLLeyYvM8kaj/9vvyLDirzWizLmA/t8xdUUVXJF6oXmSnEj3YQkPpJT5iuk
	ZBzeuMMKVchYMCDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="XH1P/pCm";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=96GHuDHG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suObi2/GY4gIdOy8/pJdudh4YHfdoLo9Lt+1E266qUA=;
	b=XH1P/pCm7aIhdWR2K+hIhZNEHdMZ3IZbS3VhIImYaSvMZvBS+/fs5djvmdoTXkHjT78KPG
	KCtg3OkOWqkWN6Qut5anMLrs+F+LOsMsjQjHugmwQJikMbosqj/tBQTLL2ft0qZRI1ucjk
	eEAdqrh908w1crlBF+wFd9tGnM8Wwnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suObi2/GY4gIdOy8/pJdudh4YHfdoLo9Lt+1E266qUA=;
	b=96GHuDHGXNaNLLeyYvM8kaj/9vvyLDirzWizLmA/t8xdUUVXJF6oXmSnEj3YQkPpJT5iuk
	ZBzeuMMKVchYMCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EFFA13AD1;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UI7/EkMwwWgGJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Sep 2025 08:01:07 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 10 Sep 2025 10:01:21 +0200
Subject: [PATCH v8 19/23] maple_tree: Replace mt_free_one() with kfree()
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-slub-percpu-caches-v8-19-ca3099d8352c@suse.cz>
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
 Pedro Falcato <pfalcato@suse.de>
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
	RCPT_COUNT_TWELVE(0.00)[14];
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
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,suse.de];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 65D705CB7F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

From: Pedro Falcato <pfalcato@suse.de>

kfree() is a little shorter and works with kmem_cache_alloc'd pointers
too. Also lets us remove one more helper.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/maple_tree.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index c706e2e48f884fd156e25be2b17eb5e154774db7..0439aaacf6cb1f39d0d23af2e2a5af1d27ab32be 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -177,11 +177,6 @@ static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
 	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
 }
 
-static inline void mt_free_one(struct maple_node *node)
-{
-	kmem_cache_free(maple_node_cache, node);
-}
-
 static inline void mt_free_bulk(size_t size, void __rcu **nodes)
 {
 	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
@@ -5092,7 +5087,7 @@ static void mt_free_walk(struct rcu_head *head)
 	mt_free_bulk(node->slot_len, slots);
 
 free_leaf:
-	mt_free_one(node);
+	kfree(node);
 }
 
 static inline void __rcu **mte_destroy_descend(struct maple_enode **enode,
@@ -5176,7 +5171,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 
 free_leaf:
 	if (free)
-		mt_free_one(node);
+		kfree(node);
 	else
 		mt_clear_meta(mt, node, node->type);
 }
@@ -5385,7 +5380,7 @@ void mas_destroy(struct ma_state *mas)
 			mt_free_bulk(count, (void __rcu **)&node->slot[1]);
 			total -= count;
 		}
-		mt_free_one(ma_mnode_ptr(node));
+		kfree(ma_mnode_ptr(node));
 		total--;
 	}
 
@@ -6373,7 +6368,7 @@ static void mas_dup_free(struct ma_state *mas)
 	}
 
 	node = mte_to_node(mas->node);
-	mt_free_one(node);
+	kfree(node);
 }
 
 /*

-- 
2.51.0

