Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA9930F54C
	for <rcu@vger.kernel.org>; Wed, 10 Sep 2025 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491276; cv=none; b=O+K64Ef/imM6ohFLUnLEj3DtMOakgtdZgQsM7VheEnkezezZfMg7utICq0dcyS398ZAN8wIo8UIXDJDY6KcCkI+v8XLxAfPcg7Uwkl51fzSxnDaiSX8wreY3O7nWs2oZAWc03HO9p+KJkKrhPUilwMWNJmoguE5lzoNb6bcIWXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491276; c=relaxed/simple;
	bh=JDLcaRwdE+9JwFAkFxMDxq9vb8nXXtMSxj8CNH+wY5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WOBeyo0bpo/Ek6ubIEv/uriHo+tph8r05iitC5fAhehYc5iHtifySljIZientRTH9r7D81LtDn0GYMTk5E7s8n+QaGWVI0eVXNVoq/bgEzJvtE13BDQkc/Cjji6QGopvztdalTu3RZq/98h8w1gWl/pUm+ooAQEpChLmriY0B8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k6P7YCNl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7L+CBN32; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d/9eUt6t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0VKnQ2OG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k6P7YCNl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7L+CBN32";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d/9eUt6t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0VKnQ2OG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DFB2F34BFD;
	Wed, 10 Sep 2025 08:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAwVYE4NG8inGvdEGs4C6XcT1t0ZcCQnS4gQbGvqQfk=;
	b=k6P7YCNldxNO9tGL0KHyGYqkJ0vwzAF74+VcWsT3RFofiTxwZzTBUpAkMGmtH1z4FctPnL
	vyUnai1vRS3PQwiZZg1y1WilRUassffb0dcKtMSnBXDt+Ie1WXqSohGfryHOvuZvmx1jJS
	TThTk+kLrxzKfdAfA3W48Q3KaExlp8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAwVYE4NG8inGvdEGs4C6XcT1t0ZcCQnS4gQbGvqQfk=;
	b=7L+CBN32sCDv4omTTYmqZmhK1iT/Qog6f/sov3U64S3HvAVSsNP5tKfiYxW0d1fhUXBdok
	StqLHqGqzZHZIIBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="d/9eUt6t";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0VKnQ2OG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAwVYE4NG8inGvdEGs4C6XcT1t0ZcCQnS4gQbGvqQfk=;
	b=d/9eUt6t0sNGla2HbrdNRg8+vqxixCr1e+tbj5lyL1L/HBY+icNr3yQjVJW61hmZTA1NdR
	8KdTKaEeCBg9Q+5i04Qh5HPwpNOK5CZIquEFgPwQq0E9j47eMeSxwYfZDwX3EiMHLmQHeL
	4BBofwFAR3xV6JN4QLCfeZRTL/FDdYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAwVYE4NG8inGvdEGs4C6XcT1t0ZcCQnS4gQbGvqQfk=;
	b=0VKnQ2OGFAbX/IBUZB2pe+bZpGugEIX1G2uBwV5cQtkrlSQuvQdyxK/ofC19sjQ8Wyn2+X
	kb30+uZYO/GxtEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9DC413ABD;
	Wed, 10 Sep 2025 08:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id INX8MEEwwWgGJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Sep 2025 08:01:05 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 10 Sep 2025 10:01:04 +0200
Subject: [PATCH v8 02/23] slab: simplify init_kmem_cache_nodes() error
 handling
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-slub-percpu-caches-v8-2-ca3099d8352c@suse.cz>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: DFB2F34BFD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

We don't need to call free_kmem_cache_nodes() immediately when failing
to allocate a kmem_cache_node, because when we return 0,
do_kmem_cache_create() calls __kmem_cache_release() which also performs
free_kmem_cache_nodes().

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
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

