Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A726AAAB
	for <rcu@vger.kernel.org>; Wed, 10 Sep 2025 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491271; cv=none; b=geZom79C1sNwiCdf3e23g7zeZ5x2RGq+5lpxUSXNIlg0RziM5aSd1TcSgMbo/g1dRTy0rYS85WbJm58ZHcwZXKn5LIzHhSwwh8MXbYvhe+EVU9OeyMfC95pm4Xc2zYE4TymQpQbRp/ZhVl+BAZ8xQHJ+Hg/z6r7MwUTW0QeEyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491271; c=relaxed/simple;
	bh=pPdP8Mo5V6IeorHQaiXPjv3uDEg0QTTYTfcxvqG4XoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IIJ1dE0gfFze4vl08iGJxacBxloh25GJtszJQGi9bvPATxQBwXIqPhwc5lLAGWHqdW4y1uIc+q7bUgqPrLww6Dp/K59EU8Xk+RbBLL/9m9hNa/1pKX/giE8fbZN282VS/EMu/+YiqN+NG6TeYzBcVfFysG8nqzlo/DqsyXYtOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CQa9N9h4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=moQxoCb3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dG7K8GH3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/zfZsb78; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CQa9N9h4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="moQxoCb3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dG7K8GH3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/zfZsb78"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB47D5CA23;
	Wed, 10 Sep 2025 08:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3hjvzuOHMY42JWL8uS2aEHNxgCiX/TRsdBUhNeMoUs=;
	b=CQa9N9h4pDfX7nw/M+ubbl2raVQSIqyo9KLUKwBWyZ0tRfR5LSRwNV7ZlPozcAaF7IBRQv
	6Lb9YB2LVS7iw+NMa4nAUq69h1/MHapt4uTBe3U3v7fFNB2ulRRRdlY6QRmU4PulCkLpz4
	KuJWoio8RMV3lxDFAR/2zDIktVmkxC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3hjvzuOHMY42JWL8uS2aEHNxgCiX/TRsdBUhNeMoUs=;
	b=moQxoCb30JS8lAp5uRVMgaLiLhdUOFhJ1SFaUEBI7EZJXZeKpN/k1d6Z812kRPkPDzcv36
	gMkCRc2PyiVAWOCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dG7K8GH3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/zfZsb78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3hjvzuOHMY42JWL8uS2aEHNxgCiX/TRsdBUhNeMoUs=;
	b=dG7K8GH3wiohlmESb7yD9RKVBcv1OWZ40MD2XilJUpPWvEVpWuXtx/BgVJfDOLzzpGAeWa
	2JkUzKinBaQkv4fTqmgWLI1JvHAQcHQ/ajispnZRa8hZbAviiFlU62SDQ0je6of64eMot8
	JalcQjJhmEeqGVEDu0yHwu53aO1l2qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3hjvzuOHMY42JWL8uS2aEHNxgCiX/TRsdBUhNeMoUs=;
	b=/zfZsb78FvwKmW/C8Hqh2i72dMdU5YfyxbCqUY9iAjCg/h1+tbxNj3q6n4RJdg7vQEx9n2
	se7HWI2yCbgfzfAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B087013A54;
	Wed, 10 Sep 2025 08:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wNDQKkEwwWgGJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Sep 2025 08:01:05 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 10 Sep 2025 10:01:03 +0200
Subject: [PATCH v8 01/23] locking/local_lock: Expose dep_map in
 local_trylock_t.
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-slub-percpu-caches-v8-1-ca3099d8352c@suse.cz>
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
 Alexei Starovoitov <ast@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CB47D5CA23
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	RCPT_COUNT_TWELVE(0.00)[15];
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
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,kernel.org,linutronix.de];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Spam-Score: -4.51

From: Alexei Starovoitov <ast@kernel.org>

lockdep_is_held() macro assumes that "struct lockdep_map dep_map;"
is a top level field of any lock that participates in LOCKDEP.
Make it so for local_trylock_t.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/local_lock_internal.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index d80b5306a2c0ccf95a3405b6b947b5f1f9a3bd38..949de37700dbc10feafc06d0b52382cf2e00c694 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -17,7 +17,10 @@ typedef struct {
 
 /* local_trylock() and local_trylock_irqsave() only work with local_trylock_t */
 typedef struct {
-	local_lock_t	llock;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+	struct task_struct	*owner;
+#endif
 	u8		acquired;
 } local_trylock_t;
 
@@ -31,7 +34,7 @@ typedef struct {
 	.owner = NULL,
 
 # define LOCAL_TRYLOCK_DEBUG_INIT(lockname)		\
-	.llock = { LOCAL_LOCK_DEBUG_INIT((lockname).llock) },
+	LOCAL_LOCK_DEBUG_INIT(lockname)
 
 static inline void local_lock_acquire(local_lock_t *l)
 {
@@ -81,7 +84,7 @@ do {								\
 	local_lock_debug_init(lock);				\
 } while (0)
 
-#define __local_trylock_init(lock) __local_lock_init(lock.llock)
+#define __local_trylock_init(lock) __local_lock_init((local_lock_t *)lock)
 
 #define __spinlock_nested_bh_init(lock)				\
 do {								\

-- 
2.51.0

