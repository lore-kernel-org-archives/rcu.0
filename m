Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB3D2E5B2F
	for <rcu@vger.kernel.org>; Wed, 23 Jul 2025 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277707; cv=none; b=GllAmxVOSV3EsHlz1FYbFKH8g1f2WMsFv+eoQ8LxCoQv/L+WgE9zExVLs/lyY3RGvRNOuBbGK2ZwmU71tRhunqFtL1p4iRd8JgWyLaRC2YkWZjxUMTKKgzswCRF1ktGAa4Jxjn4eJQNDtpQHPhos0R9T87Tm3NjCDVgaPwYlrio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277707; c=relaxed/simple;
	bh=UH5wz0l1feCpdvBKuKCYlukK0WqKo6g8vIdbOQZxl+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PUR6lowL44UQbyayoMltj8DCGU6xUcQy9FzndCrM8IcY4e9YHuTzghMaTjeEquuGRbH6xAy7J4szvziT7Nwdx+FCkdzw31LQDezFbT9BqJt2eYmkADHRNshNkYskzyWbaRKM2pUapx6hGfnqyN9aV1LMquVj38SySzZwbxgKQHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jLuWcep7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TuOmiLe9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jLuWcep7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TuOmiLe9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jLuWcep7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TuOmiLe9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jLuWcep7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TuOmiLe9"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 684A921748;
	Wed, 23 Jul 2025 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n76T5/oLzAKLG/4h3bNpBYSlkM7GH6lXo34OEj/xIig=;
	b=jLuWcep7wvOrM9VfLFU5V7n3h8HO8EdEtMwkILNwBO9fDXDmtD3gUZmxaQDHXaRr0gHOTN
	NoCSvbIy5xzO1RB8xzGSgoKOx0Ic0DgCOYUvQAA3wmqekIAVPV8FtEkxD5usGoxpj+cswT
	JZhwSs9Rp+QZ3U5zQEj4Z9exJh8AXrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n76T5/oLzAKLG/4h3bNpBYSlkM7GH6lXo34OEj/xIig=;
	b=TuOmiLe99Wx9WUds4G4PNGnxwGj5KiApUUhPYuk3GLSl+bKCYO0kBewqM5VVUfyH9XWHhi
	wMuhr1lKd6hTWWCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n76T5/oLzAKLG/4h3bNpBYSlkM7GH6lXo34OEj/xIig=;
	b=jLuWcep7wvOrM9VfLFU5V7n3h8HO8EdEtMwkILNwBO9fDXDmtD3gUZmxaQDHXaRr0gHOTN
	NoCSvbIy5xzO1RB8xzGSgoKOx0Ic0DgCOYUvQAA3wmqekIAVPV8FtEkxD5usGoxpj+cswT
	JZhwSs9Rp+QZ3U5zQEj4Z9exJh8AXrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n76T5/oLzAKLG/4h3bNpBYSlkM7GH6lXo34OEj/xIig=;
	b=TuOmiLe99Wx9WUds4G4PNGnxwGj5KiApUUhPYuk3GLSl+bKCYO0kBewqM5VVUfyH9XWHhi
	wMuhr1lKd6hTWWCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5369E13AF2;
	Wed, 23 Jul 2025 13:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QK0XFAjlgGh0IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Jul 2025 13:35:04 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 23 Jul 2025 15:34:40 +0200
Subject: [PATCH v5 07/14] maple_tree: use percpu sheaves for
 maple_node_cache
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-slub-percpu-caches-v5-7-b792cd830f5d@suse.cz>
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
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Setup the maple_node_cache with percpu sheaves of size 32 to hopefully
improve its performance. Change the single node rcu freeing in
ma_free_rcu() to use kfree_rcu() instead of the custom callback, which
allows the rcu_free sheaf batching to be used. Note there are other
users of mt_free_rcu() where larger parts of maple tree are submitted to
call_rcu() as a whole, and that cannot use the rcu_free sheaf. But it's
still possible for maple nodes freed this way to be reused via the barn,
even if only some cpus are allowed to process rcu callbacks.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/maple_tree.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index affe979bd14d30b96f8e012ff03dfd2fda6eec0b..82f39fe29a462aa3c779789a28efdd6cdef64c79 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -208,7 +208,7 @@ static void mt_free_rcu(struct rcu_head *head)
 static void ma_free_rcu(struct maple_node *node)
 {
 	WARN_ON(node->parent != ma_parent_ptr(node));
-	call_rcu(&node->rcu, mt_free_rcu);
+	kfree_rcu(node, rcu);
 }
 
 static void mt_set_height(struct maple_tree *mt, unsigned char height)
@@ -6285,9 +6285,14 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 
 void __init maple_tree_init(void)
 {
+	struct kmem_cache_args args = {
+		.align  = sizeof(struct maple_node),
+		.sheaf_capacity = 32,
+	};
+
 	maple_node_cache = kmem_cache_create("maple_node",
-			sizeof(struct maple_node), sizeof(struct maple_node),
-			SLAB_PANIC, NULL);
+			sizeof(struct maple_node), &args,
+			SLAB_PANIC);
 }
 
 /**

-- 
2.50.1

