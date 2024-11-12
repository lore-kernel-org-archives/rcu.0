Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CC120697A;
	Tue, 12 Nov 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429591; cv=none; b=dLsUB9+Lher4RP6lhrc6G7ZTxcNnJpVy0Byu71E08jogB/lvPAdE7MTa1PVFw/8l4GvtciWICF+/gy19BkYR8N0kCm9SDqI5vrf5N076LK3pcCBuAhNpF4+1OFl6FFsZPrRfoWrPhYi2jk8/nTEdEq5xMFF5s8C5FCXWrAr1ox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429591; c=relaxed/simple;
	bh=GNEwsdpTw+alaKMVcf/e8GCDO0WuhBFhaIiXyrGwzUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dlSjN52tDCiFSHa5ZOEXDCr43yNdiOga4fREXPi8LyrzBdhrBa70bBYkzZqc74KLS5H06xlpbclHA70tl52DnYNIylMKzd6PtCWicE9Xb64WVyg+Bx4TZ44lleLB8vkHqUw6P/22imOsI+YWdhqwqeAbmZkAND/yy9IveMM5Q6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oru17CWM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uFishl99; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oru17CWM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uFishl99; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oru17CWM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uFishl99";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oru17CWM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uFishl99"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79E022125C;
	Tue, 12 Nov 2024 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731429587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGD6k8ZGUV4h33x+p3T4Fo15crfC0RACbnBYnZB+C5Q=;
	b=Oru17CWMMNAoa2qCEd8Tw3rDbFwwS5FtalLfzWmc8sbRhSn12+yoGKX6OO+1ot0T+anpVe
	eOsDO92T2G7TpqrisjSaTDNVHKdUV4+5tPCrBJ39K/+uCywizJNtgSb2CQiT+5uk0TvWed
	zDFdDWLjBzNA7WjGEKq83Txx4bH1lIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731429587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGD6k8ZGUV4h33x+p3T4Fo15crfC0RACbnBYnZB+C5Q=;
	b=uFishl99Dqd2FDrHQvEUljWOvbDB7te1IrlUN+r6T+UrQ1awQa1NaSCMZVkVXcih1TyCe1
	k6+LarO+3dEkCzAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731429587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGD6k8ZGUV4h33x+p3T4Fo15crfC0RACbnBYnZB+C5Q=;
	b=Oru17CWMMNAoa2qCEd8Tw3rDbFwwS5FtalLfzWmc8sbRhSn12+yoGKX6OO+1ot0T+anpVe
	eOsDO92T2G7TpqrisjSaTDNVHKdUV4+5tPCrBJ39K/+uCywizJNtgSb2CQiT+5uk0TvWed
	zDFdDWLjBzNA7WjGEKq83Txx4bH1lIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731429587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGD6k8ZGUV4h33x+p3T4Fo15crfC0RACbnBYnZB+C5Q=;
	b=uFishl99Dqd2FDrHQvEUljWOvbDB7te1IrlUN+r6T+UrQ1awQa1NaSCMZVkVXcih1TyCe1
	k6+LarO+3dEkCzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D31F13AC3;
	Tue, 12 Nov 2024 16:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QMxuFtOEM2e6IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 12 Nov 2024 16:39:47 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 12 Nov 2024 17:38:47 +0100
Subject: [PATCH RFC 3/6] maple_tree: use percpu sheaves for
 maple_node_cache
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-slub-percpu-caches-v1-3-ddc0bdc27e05@suse.cz>
References: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz>
In-Reply-To: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Matthew Wilcox <willy@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=GNEwsdpTw+alaKMVcf/e8GCDO0WuhBFhaIiXyrGwzUU=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBnM4TI07ZzZ8MVpE6qqbUQruxLEDeCS+rtR9kUE
 8Eo0qeSMFKJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZzOEyAAKCRC74LB10kWI
 moliB/4ku9iAnntGedIvuMOTgOtHGpi71febt1h0Mg0DbTCsyHdWwtgl9EuIjYk1j0G/Yywp7/L
 TSVrVWBrY1fGHCtF3j2IugkLOrljU6a6uF0EoCBGr+oMRPwGRd3MIWRZ+zZ9na+2GnPqK2hbqMj
 rT7vQD4S9OMEOY1QHsi0FfQhAH0YzEWV1epnNHABBV1nnJAoerCAPCPirN8Ao/sGN+eVRY6y3Kd
 UtsszCx2c0yQmT8OdtzJYPeRnl2rWDZfsdVuC00GO8wPx0YLzfRWSidzrAfd0G8lW6MkMQm+kWh
 WrXADGJR5y8Cx+vF6VoOEsE6KlDfNnGz8pcUZg8dVOt+CPH9
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,oracle.com,infradead.org,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLtz7ce9b89hw8xzamye9qeynd)]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Setup the maple_node_cache with percpu sheaves of size 32 to hopefully
improve its performance. Change the single node rcu freeing in
ma_free_rcu() to use kfree_rcu() instead of the custom callback, which
allows the rcu_free sheaf batching to be used. Note there are other
users of mt_free_rcu() where larger parts of maple tree are submitted to
call_rcu() as a whole, and that cannot use the rcu_free sheaf, but it's
still possible for maple nodes freed this way to be reused via the barn,
even if only some cpus are allowed to process rcu callbacks.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/maple_tree.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3619301dda2ebeaaba8a73837389b6ee3c7e1a3f..c69365e17fcbfe963dcedd0de07335fc6bbdfb27 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -194,7 +194,7 @@ static void mt_free_rcu(struct rcu_head *head)
 static void ma_free_rcu(struct maple_node *node)
 {
 	WARN_ON(node->parent != ma_parent_ptr(node));
-	call_rcu(&node->rcu, mt_free_rcu);
+	kfree_rcu(node, rcu);
 }
 
 static void mas_set_height(struct ma_state *mas)
@@ -6299,9 +6299,14 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 
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
2.47.0

