Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A9820697B;
	Tue, 12 Nov 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429592; cv=none; b=RwfJS4mNDRKENH5GSpNXVTaWp7vAImRGArfb4x0Br+hkmrKZuurnb9z+20EnIfc0NaZiTvh0HeXC/Ww4PUQDPrDNF8gkLsHw4eZrsIUmHIBVxffCbDVYfh0tFH4v0/9auggTba4m41+pf4SYYnSt6WsWoyS3z/QGVB3SQH6yLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429592; c=relaxed/simple;
	bh=dcUmI/Co/tcz1EOGwJFhsClJvt8T9OCwC5fGPuq0Ncw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CW6snhCN4vtz20jIQgqvTITGEp3j7ECTrQ3g82Pexd6oMsIdbXTN6gyUHiApK9QDBKukWbJo6VU9kmnhvj9N9/okYz5YVV2Dy2mFjg/SrTx/miMtNedBriuJ6M2wIZvwGQ4nzSW2iG+2alLC563NPYuXKwqvuNkBtAgIodzXdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kvkqbo5c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GSk0LM88; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kvkqbo5c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GSk0LM88; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kvkqbo5c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GSk0LM88";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kvkqbo5c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GSk0LM88"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 949F12125D;
	Tue, 12 Nov 2024 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731429587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpHz+sHwXWPoDofFQG0LgmUZpXU7k9OQyeDihc++kFA=;
	b=kvkqbo5cMpaS3GfGvzzfDZeh+huJRJkRuyNTVHynFI3Wo3g/2JgvdqVxLB4rHPUH9bGXmc
	LGj99fzR2/M42vpnh18UZX5tpMRXeQ8PseNL0T8Tzgm5XW+SBq3u7hOMQhop7yq/9hxmkB
	mElK9vvBzv4eqNzo5RbP85Th6L4sHr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731429587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpHz+sHwXWPoDofFQG0LgmUZpXU7k9OQyeDihc++kFA=;
	b=GSk0LM88ofSjfpcfJlljrgmXshtZbauPYbiegzNpaRcSfQUrivxtQ8Pwup+l5w6xVlXNsX
	8FBJqKCoLAxDG4CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731429587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpHz+sHwXWPoDofFQG0LgmUZpXU7k9OQyeDihc++kFA=;
	b=kvkqbo5cMpaS3GfGvzzfDZeh+huJRJkRuyNTVHynFI3Wo3g/2JgvdqVxLB4rHPUH9bGXmc
	LGj99fzR2/M42vpnh18UZX5tpMRXeQ8PseNL0T8Tzgm5XW+SBq3u7hOMQhop7yq/9hxmkB
	mElK9vvBzv4eqNzo5RbP85Th6L4sHr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731429587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpHz+sHwXWPoDofFQG0LgmUZpXU7k9OQyeDihc++kFA=;
	b=GSk0LM88ofSjfpcfJlljrgmXshtZbauPYbiegzNpaRcSfQUrivxtQ8Pwup+l5w6xVlXNsX
	8FBJqKCoLAxDG4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77C1113301;
	Tue, 12 Nov 2024 16:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sOHxHNOEM2e6IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 12 Nov 2024 16:39:47 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 12 Nov 2024 17:38:48 +0100
Subject: [PATCH RFC 4/6] mm, vma: use sheaves for vm_area_struct cache
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-slub-percpu-caches-v1-4-ddc0bdc27e05@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3057; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=dcUmI/Co/tcz1EOGwJFhsClJvt8T9OCwC5fGPuq0Ncw=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBnM4TLe/L4WzzKctMjTmceg/hAmTUewfV1I8r17
 2hD6G0cBk2JATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZzOEywAKCRC74LB10kWI
 mqaxB/9mPs/2SlMtyHeKo4Yp33+gLG5rO3/xEXoM4p8PzNzwd9kDkeGh9LvjpkeZFOfiK9ajRln
 YHzQzS+l2oB3kBbQP6QQIXITaLRl1Y3m00P1hvonUOrwvhq6IShaqFtYIDX4ZF7sxqHgYW9bwN5
 BDkfyktC03/RrtuSROT7ImNG9Fw9ZVaWv1EftiuQa8wf7pYnW/1trRWsCZHTkzU9CYR7gbDiFiq
 ppE7t4i37j6h9RR5VTjBmtfSDosFmUrtVeLQffEUtbBj+V6hibYXUrXZHkUehovaRTRu44a0apX
 A8dlvsDgf0w/EcVXcpR2gEqQyrSv5vK8QIXpJckNd7qpLeYs
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

Create the vm_area_struct cache with percpu sheaves of size 32 to
hopefully improve its performance. For CONFIG_PER_VMA_LOCK, change the
vma freeing from custom call_rcu() callback to kfree_rcu() which
will perform rcu_free sheaf batching. Since there may be additional
structures attached and they are freed only after the grace period,
create a __vma_area_rcu_free_dtor() to do that.

Note I have not investigated whether vma_numab_state_free() or
free_anon_vma_name() must really need to wait for the grace period. For
vma_lock_free() ideally we wouldn't free it at all when freeing the vma
to the sheaf (or even slab page), but that would require using also a
ctor for vmas to allocate the vma lock, and reintroducing dtor support
for deallocating the lock when freeing slab pages containing the vmas.

The plan is to move vma_lock into vma itself anyway, so if the rest can
be freed immediately, the whole destructor support won't be needed
anymore.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/fork.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 22f43721d031d48fd5be2606e86642334be9735f..9b1ae5aaf6a58fded6c9ac378809296825eba9fa 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -516,22 +516,24 @@ void __vm_area_free(struct vm_area_struct *vma)
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
-#ifdef CONFIG_PER_VMA_LOCK
-static void vm_area_free_rcu_cb(struct rcu_head *head)
+static void __vma_area_rcu_free_dtor(void *ptr)
 {
-	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
-						  vm_rcu);
+	struct vm_area_struct *vma = ptr;
 
 	/* The vma should not be locked while being destroyed. */
+#ifdef CONFIG_PER_VMA_LOCK
 	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock), vma);
-	__vm_area_free(vma);
-}
 #endif
 
+	vma_numab_state_free(vma);
+	free_anon_vma_name(vma);
+	vma_lock_free(vma);
+}
+
 void vm_area_free(struct vm_area_struct *vma)
 {
 #ifdef CONFIG_PER_VMA_LOCK
-	call_rcu(&vma->vm_rcu, vm_area_free_rcu_cb);
+	kfree_rcu(vma, vm_rcu);
 #else
 	__vm_area_free(vma);
 #endif
@@ -3155,6 +3157,12 @@ void __init mm_cache_init(void)
 
 void __init proc_caches_init(void)
 {
+	struct kmem_cache_args vm_args = {
+		.align = __alignof__(struct vm_area_struct),
+		.sheaf_capacity = 32,
+		.sheaf_rcu_dtor = __vma_area_rcu_free_dtor,
+	};
+
 	sighand_cachep = kmem_cache_create("sighand_cache",
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
@@ -3172,7 +3180,10 @@ void __init proc_caches_init(void)
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
 
-	vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT);
+	vm_area_cachep = kmem_cache_create("vm_area_struct",
+				sizeof(struct vm_area_struct), &vm_args,
+				SLAB_PANIC|SLAB_ACCOUNT);
+
 #ifdef CONFIG_PER_VMA_LOCK
 	vma_lock_cachep = KMEM_CACHE(vma_lock, SLAB_PANIC|SLAB_ACCOUNT);
 #endif

-- 
2.47.0

