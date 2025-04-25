Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171E2376F2
	for <rcu@vger.kernel.org>; Fri, 25 Apr 2025 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569699; cv=none; b=RfnimxizSHa3WK7rdZ/agyBwtc5u7a0Jfb1gHBTOzuDnOoYnA9Yyun7Sv1dhyEgm/MCf0KOqXtCV2i985eBVk8kSQ3psVGWviNudu4vcGzD9oetkLiwo1TnewjuFQbqFHbBAo11HICJGp2JdlMymRa9WGIEnChQWkxVLrQ3rz6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569699; c=relaxed/simple;
	bh=Kekh7jslp4ImKDCEgQIu+XUSrt79QDA7pvAIpB0JMYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kH1LToOKaU3NWySXBxFhqpZdeq19ClpltM0GvNp92BP9B1MhGzYdrl3mxbcwk1zZAyZCEM0HcP395/4rDnSn1wV9lqf2Ew+LJRwPCe5BEYko6qVyO+fII0XxSFk4WISSXUQ/+DJnizGKu0sxgfE7xRWRGAt0t6ZmCupxXZTwCiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46AC12116B;
	Fri, 25 Apr 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EA7813A8B;
	Fri, 25 Apr 2025 08:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mKEVC4lHC2htfwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Apr 2025 08:27:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 25 Apr 2025 10:27:27 +0200
Subject: [PATCH v4 7/9] maple_tree: use percpu sheaves for maple_node_cache
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-slub-percpu-caches-v4-7-8a636982b4a4@suse.cz>
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
In-Reply-To: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz
X-Mailer: b4 0.14.2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 46AC12116B
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

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
index d0bea23fa4bc9fdd0ca4803a108d3c943f6a0c73..812ba155f3577d1b6ecc779ce9e4e7ded3085d8b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -208,7 +208,7 @@ static void mt_free_rcu(struct rcu_head *head)
 static void ma_free_rcu(struct maple_node *node)
 {
 	WARN_ON(node->parent != ma_parent_ptr(node));
-	call_rcu(&node->rcu, mt_free_rcu);
+	kfree_rcu(node, rcu);
 }
 
 static void mas_set_height(struct ma_state *mas)
@@ -6254,9 +6254,14 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 
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
2.49.0

