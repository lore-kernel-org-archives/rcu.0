Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229D335BA7
	for <rcu@vger.kernel.org>; Wed, 27 Aug 2025 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756283198; cv=none; b=jSQRYInE8eZhzpGRTNuEugEy9iRMX7YqV0WKUHw4ul/qIVh6LrMenYoI6iPRJfTjzEd1j/iFEIAclPPNiT2YHyqOZylZElMa7jM7mdYW/0clWe5mAHBDMOGPo9JjHiseka2qBr/UnS4UYoxiyimwkz4jI7SWPPh30CKWLo7LDOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756283198; c=relaxed/simple;
	bh=DO+/b1fm8eiQbtTkvGgyjEpChZcHLnwFFBNSKp6Po4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTDutD7S8KTyd2SEeBBWJwX3ANC6vi0jZH/SriLyiWM9kcGtJZP8tjnOiJbYsRxOaRpYuiEp9c9uB5gD5bSgyu/zJ1WJ/o7Y+rz23x0aAt14uC2FpSonhF+opSrL/2G0PtDPkePtUPh9kTWZGTigugC/bWmQg/ECdls8t8tNZr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fWZ3VKM3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CE9USv0j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fWZ3VKM3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CE9USv0j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fWZ3VKM3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CE9USv0j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fWZ3VKM3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CE9USv0j"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 289D521F9E;
	Wed, 27 Aug 2025 08:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756283195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCAb571qgZEf5w34vVc+FdxmgCSPpBunGHGMPiUvzjc=;
	b=fWZ3VKM3efiPGsd1PSyEMGOcyKwZKIyDvSvJ/e+klC7PTeclT2hHi7wbwMHeDuYO2D3Xzk
	731YNld4vwkApqJz9w2RKOhTD4AocxRQTND9pcyS/LqUX7jWMNzYQ0dh7jxw0eJEgZyETP
	75+0hhVlAWCAOzHxm6HvvlNjHGetoHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756283195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCAb571qgZEf5w34vVc+FdxmgCSPpBunGHGMPiUvzjc=;
	b=CE9USv0jQGth3V9w8477Htow3GLkk6lXsEXd/4X1MlGUXqtzVYeNBRoE27twQxqq47dfgX
	WFC2Lm65fK3C1CCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756283195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCAb571qgZEf5w34vVc+FdxmgCSPpBunGHGMPiUvzjc=;
	b=fWZ3VKM3efiPGsd1PSyEMGOcyKwZKIyDvSvJ/e+klC7PTeclT2hHi7wbwMHeDuYO2D3Xzk
	731YNld4vwkApqJz9w2RKOhTD4AocxRQTND9pcyS/LqUX7jWMNzYQ0dh7jxw0eJEgZyETP
	75+0hhVlAWCAOzHxm6HvvlNjHGetoHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756283195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCAb571qgZEf5w34vVc+FdxmgCSPpBunGHGMPiUvzjc=;
	b=CE9USv0jQGth3V9w8477Htow3GLkk6lXsEXd/4X1MlGUXqtzVYeNBRoE27twQxqq47dfgX
	WFC2Lm65fK3C1CCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C85D13A31;
	Wed, 27 Aug 2025 08:26:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sKnGAjvBrmhNfgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 27 Aug 2025 08:26:35 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 27 Aug 2025 10:26:33 +0200
Subject: [PATCH v6 01/10] slab: simplify init_kmem_cache_nodes() error
 handling
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-slub-percpu-caches-v6-1-f0f775a3f73f@suse.cz>
References: <20250827-slub-percpu-caches-v6-0-f0f775a3f73f@suse.cz>
In-Reply-To: <20250827-slub-percpu-caches-v6-0-f0f775a3f73f@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -8.30

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

