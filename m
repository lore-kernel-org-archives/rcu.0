Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F73002BE
	for <rcu@vger.kernel.org>; Wed,  3 Sep 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904413; cv=none; b=DpcezmM0f2xGL19uTw8eulq1EVLivvIbCVER5sEe9IT+B8FzeuPt0y74Y9ZuN2gBlB2P5WBUR7jFuTGc8ClUqG2lRRRMg11qbrqEKvGIIUxt4VdoA0zQtZshJCBD1MQ/CKLL5cpSusvJ4kWLvulcfh+XRezrBynRD7E1GjiGldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904413; c=relaxed/simple;
	bh=Cnm5+lV8JYbFrvis7+1UCE3xAhZydUfyraB/zSOvzNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tOeNcZ8PbILSSeaeMfOsW71tK1Gq9vb6VRjCkstdhqHyc/d/9DGe6g6Toi/bBqcvqG5SzWtes7HZI57eyXQaP2O5LBfMDqabjn63KNi0u+aLxJMV4I8L5Sx1Us1/wKI9AF4pYbKemFcSYblns+CeaejGnBjvlXpaN2HxUoV/bbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=arrlLRSN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dt+VVdAf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EFlow2CE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oiNOm3uq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="arrlLRSN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dt+VVdAf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EFlow2CE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oiNOm3uq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C4771F460;
	Wed,  3 Sep 2025 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04+J/P3cAQAe3/G2iQS1u1ZbTuFSibWkDWn/mbh0R6o=;
	b=arrlLRSNCRL6ztrX4z+FD1hSkyyR9ZqSZNGG9Ed+HwGctCLDYHwoF/xJXBgSnpXh8ZYbHa
	ImQWKKzYk+O3SFPxoA44W6RoOKd22MkH39Wa/SNLF1GLnCqBN3HKYxgVz+wQ3849+Kivo6
	QDOrNC8qkUlCSZbqJeGL9B+JCJHw2ZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04+J/P3cAQAe3/G2iQS1u1ZbTuFSibWkDWn/mbh0R6o=;
	b=Dt+VVdAf1kIxpkQBwHp5ohN73Uh9pPEAROl9LO8dyW7F8E9ilLpImzRQORnm9urOS2kZqA
	zEW7Pi2l0WmCC0AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EFlow2CE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oiNOm3uq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04+J/P3cAQAe3/G2iQS1u1ZbTuFSibWkDWn/mbh0R6o=;
	b=EFlow2CECEAnA7D8X1e5og3e94SIX/I73jq5GNahYqNxIwOTEctVEt8z4kzvQn0rNE7ywJ
	Nx8GvUXnF9YbrZ771Q62/SM6ZLBb7jW6aZNiaqvuYh5ylYB6PFUSU+HLNjTNWQc5n2Ho6+
	yESXtGfE/J7n1Z4NbG0RqzkObpqorXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04+J/P3cAQAe3/G2iQS1u1ZbTuFSibWkDWn/mbh0R6o=;
	b=oiNOm3uqjFRngvdN1r9enuok7DnUulcXMnJLb7Th9LxevZPfHOm3qhKwdrMH2qgHABx0pB
	qf+yX15kU2XL36CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2097613A94;
	Wed,  3 Sep 2025 13:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CJWwB9k7uGitOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Sep 2025 13:00:09 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 03 Sep 2025 14:59:43 +0200
Subject: [PATCH v7 01/21] locking/local_lock: Expose dep_map in
 local_trylock_t.
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-slub-percpu-caches-v7-1-71c114cdefef@suse.cz>
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
 Alexei Starovoitov <ast@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3C4771F460
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,kernel.org,linutronix.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.51

From: Alexei Starovoitov <ast@kernel.org>

lockdep_is_held() macro assumes that "struct lockdep_map dep_map;"
is a top level field of any lock that participates in LOCKDEP.
Make it so for local_trylock_t.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
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

