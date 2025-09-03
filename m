Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51492FF674
	for <rcu@vger.kernel.org>; Wed,  3 Sep 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904413; cv=none; b=av3dF+qQjyThC1Ty9nh+m3hvluWwZUaoJDC2ul8N1yyII8G6tovvc7KKZB1ppLOlO0HjyPfqp7rOP121ThFcLudIa5GzgFJo6w+dW1LoJJs0URTJYQkFF5PyJ9kCAP7w5ARD5ngI//StbPtI3cmTH4qe+DPaMMlmRKHCCciiwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904413; c=relaxed/simple;
	bh=DO+/b1fm8eiQbtTkvGgyjEpChZcHLnwFFBNSKp6Po4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ICR8YHp43J8+piETf0HMe+apfMAbj3+rOx/dObzIw1QwWD+3kitxFhCtmHZz1qoGN+BBreMluFQ1StZgT6ItJyZaMOrJtH2kbUis4l4JIFJoSGLMMHaejDQBxgpe813QuYqhRTVrJ3ZsxY62rYpZ4RIcM+QMrEWPiHiNHvnqGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BLRR/Z63; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yQsqdA6a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TIZH5ZxK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mRKI7iRi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BLRR/Z63";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yQsqdA6a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TIZH5ZxK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mRKI7iRi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 519DF21222;
	Wed,  3 Sep 2025 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCAb571qgZEf5w34vVc+FdxmgCSPpBunGHGMPiUvzjc=;
	b=BLRR/Z63uRSPDpSLnY/EA3qPOqyXZ1GSqrRQxV073ZyBznDRSTLUQu5P213sONgFw7kvzB
	bziFim3Yve/PXTTC5Jf/NprIdKOhJEs3V1TAfr3BNxMOOO4nXir4UNs6Wx6PokccHiiSu0
	ZYjrz+GljxForqFGTUsnlUARS9kt4no=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCAb571qgZEf5w34vVc+FdxmgCSPpBunGHGMPiUvzjc=;
	b=yQsqdA6aMMO7KGp1oGRL6HzLAVpQ9SHkNbckgJ11zmsSLSg+57PIfwmHZPC+qIqlFuK0O5
	3qSZ0u2XyJz20oDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCAb571qgZEf5w34vVc+FdxmgCSPpBunGHGMPiUvzjc=;
	b=TIZH5ZxK46TTdIt0YXWhyJN2yeTe3ZgTyXXWHsSCinGcLET4+HfQX8AIb5F8ozjKLQjaTm
	UtdUjg+FU/KCQeSsv/W5rVXnTC9QNBnkUzQKFjLXTCs/vrJZQ29y5LiW8ZJoVFtifwiYTJ
	4lN5DyblL4PhQC7n3MmU0D/jGS1+qsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCAb571qgZEf5w34vVc+FdxmgCSPpBunGHGMPiUvzjc=;
	b=mRKI7iRiIklOEZ/OJsa93w7/i1JjjJf0aPegWeyufpMB30i4CuN3mMTTR4poXDjnkwKGpV
	SN2jX912YUOEOsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 361EB13ACB;
	Wed,  3 Sep 2025 13:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gMTvDNk7uGitOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Sep 2025 13:00:09 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 03 Sep 2025 14:59:44 +0200
Subject: [PATCH v7 02/21] slab: simplify init_kmem_cache_nodes() error
 handling
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-slub-percpu-caches-v7-2-71c114cdefef@suse.cz>
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
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

We don't need to call free_kmem_cache_nodes() immediately when failing
to allocate a kmem_cache_node, because when we return 0,
do_kmem_cache_create() calls __kmem_cache_release() which also performs
free_kmem_cache_nodes().

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 30003763d224c2704a4b93082b8b47af12dcffc5..9f671ec76131c4b0b28d5d568aa45842b5efb6d4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5669,10 +5669,8 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 		n = kmem_cache_alloc_node(kmem_cache_node,
 						GFP_KERNEL, node);
 
-		if (!n) {
-			free_kmem_cache_nodes(s);
+		if (!n)
 			return 0;
-		}
 
 		init_kmem_cache_node(n);
 		s->node[node] = n;

-- 
2.51.0

