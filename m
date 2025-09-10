Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C1830FF34
	for <rcu@vger.kernel.org>; Wed, 10 Sep 2025 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491311; cv=none; b=u//W36Etx1LY8kI6A3ks0C8yhMVSMlrpYFb3ZYlkl/SQBt0yRONq2PgorPWqo4Xd/tLe79yOmhhsS74SksSXDiwTNaNVxQ9ocytXNnxdQ0OSHBdS+CFFV2poGqkXlwz/skWd7a1PbT2GjbxEaTI3KftBEbq2+HtDRt9gjitnJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491311; c=relaxed/simple;
	bh=zXygsHQ8M75ldUrzHX4v4b361hHPjjuRMUX5R7ROHQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZYeloAR7azHiktamww4O16lCRBOTcx4VUEDR+78l/hZQcf5EjcV9ae3pVxXWVlpC14hcAieUgHjLdKYoEODruftB7feMXZdIl8waGmAXePgsfYXcGIOZLv0Pd48+fGDe4LDwvkHxDFBFjTChNjQDU+sm2o7NR+DZCGRiE8wqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kRgXuUVH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v0Gmqs4y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kRgXuUVH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v0Gmqs4y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kRgXuUVH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v0Gmqs4y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kRgXuUVH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v0Gmqs4y"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B9CB5CB08;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkJLUdth35DaRyhM3TWCLrM77sXSdG1lPON3otYkBww=;
	b=kRgXuUVHckP5nGYOk9us7XwUxag1poVZHhieSiHTDGmQaabS697+H203GEA0HCiV/CqcM6
	gC5KI1Uih9wclAxbHLuiecmQX8sDy9gHY1rHD4e0RYvjELbSZNgEV0vpjF1XGsRs0uy0Gn
	MG4yepVyOww0/i8ykq9Dd1Lfg9vjyl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkJLUdth35DaRyhM3TWCLrM77sXSdG1lPON3otYkBww=;
	b=v0Gmqs4yLSYMHbcmi4X2wd9y1mMcEnhGcOr6ySAvGAsX+qKc8Ycf4MarNwM+rsOxbtin7i
	XaZ95nBcMlXyNUAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kRgXuUVH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=v0Gmqs4y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkJLUdth35DaRyhM3TWCLrM77sXSdG1lPON3otYkBww=;
	b=kRgXuUVHckP5nGYOk9us7XwUxag1poVZHhieSiHTDGmQaabS697+H203GEA0HCiV/CqcM6
	gC5KI1Uih9wclAxbHLuiecmQX8sDy9gHY1rHD4e0RYvjELbSZNgEV0vpjF1XGsRs0uy0Gn
	MG4yepVyOww0/i8ykq9Dd1Lfg9vjyl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkJLUdth35DaRyhM3TWCLrM77sXSdG1lPON3otYkBww=;
	b=v0Gmqs4yLSYMHbcmi4X2wd9y1mMcEnhGcOr6ySAvGAsX+qKc8Ycf4MarNwM+rsOxbtin7i
	XaZ95nBcMlXyNUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB2BD13B04;
	Wed, 10 Sep 2025 08:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uAU6NUIwwWgGJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Sep 2025 08:01:06 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 10 Sep 2025 10:01:16 +0200
Subject: [PATCH v8 14/23] mm, vma: use percpu sheaves for vm_area_struct
 cache
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-slub-percpu-caches-v8-14-ca3099d8352c@suse.cz>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4B9CB5CB08
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Spam-Score: -4.51

Create the vm_area_struct cache with percpu sheaves of size 32 to
improve its performance.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/vma_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vma_init.c b/mm/vma_init.c
index 8e53c7943561e7324e7992946b4065dec1149b82..52c6b55fac4519e0da39ca75ad018e14449d1d95 100644
--- a/mm/vma_init.c
+++ b/mm/vma_init.c
@@ -16,6 +16,7 @@ void __init vma_state_init(void)
 	struct kmem_cache_args args = {
 		.use_freeptr_offset = true,
 		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
+		.sheaf_capacity = 32,
 	};
 
 	vm_area_cachep = kmem_cache_create("vm_area_struct",

-- 
2.51.0

