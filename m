Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535E3128A2
	for <rcu@vger.kernel.org>; Wed, 10 Sep 2025 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491318; cv=none; b=ibXsdnYrQmIUN/BCIwC1tTU8RFezuB0fFtOUbyRdVpj/rjufv0SZO1Gx7x6mMEIW7A7esZ8y0rcfqhZItDuAAZFZggRe0cxW/m7P7mYODQnd4Uvs4YEw0pCLmJMPmTPLsbljiimmdKV5vGITELj9ghkPKMSXsGoaO5W3SwYbSbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491318; c=relaxed/simple;
	bh=tc0my3fQoLwAWw0ndzrIL04sHQNvGTBVTn1a3Ysr0DI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S98oFJxUpVDxra5tUSsumLZj5wC2rqcxiR2wQJ2tYBo/lT3ufRnz8gIsLfyW9fy4qGGA1StlOPdFDMyxNyoZ+cf89uOzYmbdsXXJ7VawnPDJJHSpWFhKtn/OgENBO48oh5QNooXerMqrICev2wxzxazE1/z1Ht5drZgvt4Fv0ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ERgfoKTg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hozs6Owg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ERgfoKTg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hozs6Owg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ERgfoKTg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hozs6Owg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ERgfoKTg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hozs6Owg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E91B5CAE9;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzg1TCVobED1/AQhFq++VLVyKBPlbLMYE7LGG7XCRZ0=;
	b=ERgfoKTgRTLkYNlVw80V9Xg3zPFjP5v5ZJXJWl/GCxHJkIctN0GlQ+AhibmOwcW8GTYPyt
	KMs6m7EklV8NutCDKoIS3yARG8haYw7l/9erBzjOu6pzQFScB6ntrjGPwcflVZxtwvS2c5
	UNXkhATnMzJ/IG60X9wTA0KUr9Qu6Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzg1TCVobED1/AQhFq++VLVyKBPlbLMYE7LGG7XCRZ0=;
	b=hozs6Owg3FUSclY4koxhH7cFPwh4S9FDMp0Cu1baao81SUBfCyAii0DRWzIZFPcwq89/r9
	1Yt5dsf5SaN6kXDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ERgfoKTg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hozs6Owg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzg1TCVobED1/AQhFq++VLVyKBPlbLMYE7LGG7XCRZ0=;
	b=ERgfoKTgRTLkYNlVw80V9Xg3zPFjP5v5ZJXJWl/GCxHJkIctN0GlQ+AhibmOwcW8GTYPyt
	KMs6m7EklV8NutCDKoIS3yARG8haYw7l/9erBzjOu6pzQFScB6ntrjGPwcflVZxtwvS2c5
	UNXkhATnMzJ/IG60X9wTA0KUr9Qu6Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzg1TCVobED1/AQhFq++VLVyKBPlbLMYE7LGG7XCRZ0=;
	b=hozs6Owg3FUSclY4koxhH7cFPwh4S9FDMp0Cu1baao81SUBfCyAii0DRWzIZFPcwq89/r9
	1Yt5dsf5SaN6kXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ED8013AFF;
	Wed, 10 Sep 2025 08:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WByuHkIwwWgGJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Sep 2025 08:01:06 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 10 Sep 2025 10:01:12 +0200
Subject: [PATCH v8 10/23] tools/testing/vma: clean up stubs in
 vma_internal.h
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-slub-percpu-caches-v8-10-ca3099d8352c@suse.cz>
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
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 WangYuli <wangyuli@uniontech.com>, Jann Horn <jannh@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2E91B5CAE9
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
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,uniontech.com,google.com,linux-foundation.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Spam-Score: -4.51

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

We do not need to references arguments just to avoid compiler warnings,
the warning in question does not arise here, so remove all of the
instances of '(void)xxx' introduced purely to avoid this warning.

As reported by WagYuli in the referenced mail, GCC 8.3 and before will
have issues compiling this file if parameter names are not provided, so
ensure these are always provided.

Finally, perform a trivial fix up of kmem_cache_alloc() which technically
has parameters in the incorrect order (as reported by Vlastimil Babka
off-list).

Link: https://lkml.kernel.org/r/20250826102824.22730-1-lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: WangYuli <wangyuli@uniontech.com>
Closes: https://lore.kernel.org/linux-mm/EFCEBE7E301589DE+20250729084700.208767-1-wangyuli@uniontech.com/
Reported-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Jann Horn <jannh@google.com>
Cc: WangYuli <wangyuli@uniontech.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/testing/vma/vma_internal.h | 167 +++++++++++++--------------------------
 1 file changed, 57 insertions(+), 110 deletions(-)

diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 3639aa8dd2b06ebe5b9cfcfe6669994fd38c482d..f8cf5b184d5b51dd627ff440943a7af3c549f482 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -676,9 +676,7 @@ static inline struct kmem_cache *__kmem_cache_create(const char *name,
 
 static inline void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
 {
-	(void)gfpflags;
-
-	return calloc(s->object_size, 1);
+	return calloc(1, s->object_size);
 }
 
 static inline void kmem_cache_free(struct kmem_cache *s, void *x)
@@ -842,11 +840,11 @@ static inline unsigned long vma_pages(struct vm_area_struct *vma)
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
 
-static inline void fput(struct file *)
+static inline void fput(struct file *file)
 {
 }
 
-static inline void mpol_put(struct mempolicy *)
+static inline void mpol_put(struct mempolicy *pol)
 {
 }
 
@@ -854,15 +852,15 @@ static inline void lru_add_drain(void)
 {
 }
 
-static inline void tlb_gather_mmu(struct mmu_gather *, struct mm_struct *)
+static inline void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm)
 {
 }
 
-static inline void update_hiwater_rss(struct mm_struct *)
+static inline void update_hiwater_rss(struct mm_struct *mm)
 {
 }
 
-static inline void update_hiwater_vm(struct mm_struct *)
+static inline void update_hiwater_vm(struct mm_struct *mm)
 {
 }
 
@@ -871,36 +869,23 @@ static inline void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
 		      unsigned long end_addr, unsigned long tree_end,
 		      bool mm_wr_locked)
 {
-	(void)tlb;
-	(void)mas;
-	(void)vma;
-	(void)start_addr;
-	(void)end_addr;
-	(void)tree_end;
-	(void)mm_wr_locked;
 }
 
 static inline void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked)
 {
-	(void)tlb;
-	(void)mas;
-	(void)vma;
-	(void)floor;
-	(void)ceiling;
-	(void)mm_wr_locked;
 }
 
-static inline void mapping_unmap_writable(struct address_space *)
+static inline void mapping_unmap_writable(struct address_space *mapping)
 {
 }
 
-static inline void flush_dcache_mmap_lock(struct address_space *)
+static inline void flush_dcache_mmap_lock(struct address_space *mapping)
 {
 }
 
-static inline void tlb_finish_mmu(struct mmu_gather *)
+static inline void tlb_finish_mmu(struct mmu_gather *tlb)
 {
 }
 
@@ -909,7 +894,7 @@ static inline struct file *get_file(struct file *f)
 	return f;
 }
 
-static inline int vma_dup_policy(struct vm_area_struct *, struct vm_area_struct *)
+static inline int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
 {
 	return 0;
 }
@@ -936,10 +921,6 @@ static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
 					 unsigned long end,
 					 struct vm_area_struct *next)
 {
-	(void)vma;
-	(void)start;
-	(void)end;
-	(void)next;
 }
 
 static inline void hugetlb_split(struct vm_area_struct *, unsigned long) {}
@@ -959,51 +940,48 @@ static inline void vm_acct_memory(long pages)
 {
 }
 
-static inline void vma_interval_tree_insert(struct vm_area_struct *,
-					    struct rb_root_cached *)
+static inline void vma_interval_tree_insert(struct vm_area_struct *vma,
+					    struct rb_root_cached *rb)
 {
 }
 
-static inline void vma_interval_tree_remove(struct vm_area_struct *,
-					    struct rb_root_cached *)
+static inline void vma_interval_tree_remove(struct vm_area_struct *vma,
+					    struct rb_root_cached *rb)
 {
 }
 
-static inline void flush_dcache_mmap_unlock(struct address_space *)
+static inline void flush_dcache_mmap_unlock(struct address_space *mapping)
 {
 }
 
-static inline void anon_vma_interval_tree_insert(struct anon_vma_chain*,
-						 struct rb_root_cached *)
+static inline void anon_vma_interval_tree_insert(struct anon_vma_chain *avc,
+						 struct rb_root_cached *rb)
 {
 }
 
-static inline void anon_vma_interval_tree_remove(struct anon_vma_chain*,
-						 struct rb_root_cached *)
+static inline void anon_vma_interval_tree_remove(struct anon_vma_chain *avc,
+						 struct rb_root_cached *rb)
 {
 }
 
-static inline void uprobe_mmap(struct vm_area_struct *)
+static inline void uprobe_mmap(struct vm_area_struct *vma)
 {
 }
 
 static inline void uprobe_munmap(struct vm_area_struct *vma,
 				 unsigned long start, unsigned long end)
 {
-	(void)vma;
-	(void)start;
-	(void)end;
 }
 
-static inline void i_mmap_lock_write(struct address_space *)
+static inline void i_mmap_lock_write(struct address_space *mapping)
 {
 }
 
-static inline void anon_vma_lock_write(struct anon_vma *)
+static inline void anon_vma_lock_write(struct anon_vma *anon_vma)
 {
 }
 
-static inline void vma_assert_write_locked(struct vm_area_struct *)
+static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
 }
 
@@ -1013,16 +991,16 @@ static inline void unlink_anon_vmas(struct vm_area_struct *vma)
 	vma->anon_vma->was_unlinked = true;
 }
 
-static inline void anon_vma_unlock_write(struct anon_vma *)
+static inline void anon_vma_unlock_write(struct anon_vma *anon_vma)
 {
 }
 
-static inline void i_mmap_unlock_write(struct address_space *)
+static inline void i_mmap_unlock_write(struct address_space *mapping)
 {
 }
 
-static inline void anon_vma_merge(struct vm_area_struct *,
-				  struct vm_area_struct *)
+static inline void anon_vma_merge(struct vm_area_struct *vma,
+				  struct vm_area_struct *next)
 {
 }
 
@@ -1031,27 +1009,22 @@ static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
 					 unsigned long end,
 					 struct list_head *unmaps)
 {
-	(void)vma;
-	(void)start;
-	(void)end;
-	(void)unmaps;
-
 	return 0;
 }
 
-static inline void mmap_write_downgrade(struct mm_struct *)
+static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
 }
 
-static inline void mmap_read_unlock(struct mm_struct *)
+static inline void mmap_read_unlock(struct mm_struct *mm)
 {
 }
 
-static inline void mmap_write_unlock(struct mm_struct *)
+static inline void mmap_write_unlock(struct mm_struct *mm)
 {
 }
 
-static inline int mmap_write_lock_killable(struct mm_struct *)
+static inline int mmap_write_lock_killable(struct mm_struct *mm)
 {
 	return 0;
 }
@@ -1060,10 +1033,6 @@ static inline bool can_modify_mm(struct mm_struct *mm,
 				 unsigned long start,
 				 unsigned long end)
 {
-	(void)mm;
-	(void)start;
-	(void)end;
-
 	return true;
 }
 
@@ -1071,16 +1040,13 @@ static inline void arch_unmap(struct mm_struct *mm,
 				 unsigned long start,
 				 unsigned long end)
 {
-	(void)mm;
-	(void)start;
-	(void)end;
 }
 
-static inline void mmap_assert_locked(struct mm_struct *)
+static inline void mmap_assert_locked(struct mm_struct *mm)
 {
 }
 
-static inline bool mpol_equal(struct mempolicy *, struct mempolicy *)
+static inline bool mpol_equal(struct mempolicy *a, struct mempolicy *b)
 {
 	return true;
 }
@@ -1088,63 +1054,62 @@ static inline bool mpol_equal(struct mempolicy *, struct mempolicy *)
 static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  vm_flags_t vm_flags)
 {
-	(void)vma;
-	(void)vm_flags;
 }
 
-static inline bool mapping_can_writeback(struct address_space *)
+static inline bool mapping_can_writeback(struct address_space *mapping)
 {
 	return true;
 }
 
-static inline bool is_vm_hugetlb_page(struct vm_area_struct *)
+static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline bool vma_soft_dirty_enabled(struct vm_area_struct *)
+static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline bool userfaultfd_wp(struct vm_area_struct *)
+static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline void mmap_assert_write_locked(struct mm_struct *)
+static inline void mmap_assert_write_locked(struct mm_struct *mm)
 {
 }
 
-static inline void mutex_lock(struct mutex *)
+static inline void mutex_lock(struct mutex *lock)
 {
 }
 
-static inline void mutex_unlock(struct mutex *)
+static inline void mutex_unlock(struct mutex *lock)
 {
 }
 
-static inline bool mutex_is_locked(struct mutex *)
+static inline bool mutex_is_locked(struct mutex *lock)
 {
 	return true;
 }
 
-static inline bool signal_pending(void *)
+static inline bool signal_pending(void *p)
 {
 	return false;
 }
 
-static inline bool is_file_hugepages(struct file *)
+static inline bool is_file_hugepages(struct file *file)
 {
 	return false;
 }
 
-static inline int security_vm_enough_memory_mm(struct mm_struct *, long)
+static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
 	return 0;
 }
 
-static inline bool may_expand_vm(struct mm_struct *, vm_flags_t, unsigned long)
+static inline bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags,
+				 unsigned long npages)
 {
 	return true;
 }
@@ -1169,7 +1134,7 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
 	vma->__vm_flags &= ~flags;
 }
 
-static inline int shmem_zero_setup(struct vm_area_struct *)
+static inline int shmem_zero_setup(struct vm_area_struct *vma)
 {
 	return 0;
 }
@@ -1179,20 +1144,20 @@ static inline void vma_set_anonymous(struct vm_area_struct *vma)
 	vma->vm_ops = NULL;
 }
 
-static inline void ksm_add_vma(struct vm_area_struct *)
+static inline void ksm_add_vma(struct vm_area_struct *vma)
 {
 }
 
-static inline void perf_event_mmap(struct vm_area_struct *)
+static inline void perf_event_mmap(struct vm_area_struct *vma)
 {
 }
 
-static inline bool vma_is_dax(struct vm_area_struct *)
+static inline bool vma_is_dax(struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline struct vm_area_struct *get_gate_vma(struct mm_struct *)
+static inline struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
 {
 	return NULL;
 }
@@ -1217,16 +1182,16 @@ static inline void vma_set_page_prot(struct vm_area_struct *vma)
 	WRITE_ONCE(vma->vm_page_prot, vm_page_prot);
 }
 
-static inline bool arch_validate_flags(vm_flags_t)
+static inline bool arch_validate_flags(vm_flags_t flags)
 {
 	return true;
 }
 
-static inline void vma_close(struct vm_area_struct *)
+static inline void vma_close(struct vm_area_struct *vma)
 {
 }
 
-static inline int mmap_file(struct file *, struct vm_area_struct *)
+static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
 {
 	return 0;
 }
@@ -1388,8 +1353,6 @@ static inline int mapping_map_writable(struct address_space *mapping)
 
 static inline unsigned long move_page_tables(struct pagetable_move_control *pmc)
 {
-	(void)pmc;
-
 	return 0;
 }
 
@@ -1397,51 +1360,36 @@ static inline void free_pgd_range(struct mmu_gather *tlb,
 			unsigned long addr, unsigned long end,
 			unsigned long floor, unsigned long ceiling)
 {
-	(void)tlb;
-	(void)addr;
-	(void)end;
-	(void)floor;
-	(void)ceiling;
 }
 
 static inline int ksm_execve(struct mm_struct *mm)
 {
-	(void)mm;
-
 	return 0;
 }
 
 static inline void ksm_exit(struct mm_struct *mm)
 {
-	(void)mm;
 }
 
 static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 {
-	(void)vma;
-	(void)reset_refcnt;
 }
 
 static inline void vma_numab_state_init(struct vm_area_struct *vma)
 {
-	(void)vma;
 }
 
 static inline void vma_numab_state_free(struct vm_area_struct *vma)
 {
-	(void)vma;
 }
 
 static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
 				     struct vm_area_struct *new_vma)
 {
-	(void)orig_vma;
-	(void)new_vma;
 }
 
 static inline void free_anon_vma_name(struct vm_area_struct *vma)
 {
-	(void)vma;
 }
 
 /* Declared in vma.h. */
@@ -1495,7 +1443,6 @@ static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
 
 static inline void fixup_hugetlb_reservations(struct vm_area_struct *vma)
 {
-	(void)vma;
 }
 
 static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
@@ -1506,13 +1453,13 @@ static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
 	fput(file);
 }
 
-static inline bool shmem_file(struct file *)
+static inline bool shmem_file(struct file *file)
 {
 	return false;
 }
 
-static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct file *,
-			 vm_flags_t vm_flags)
+static inline vm_flags_t ksm_vma_flags(const struct mm_struct *mm,
+		const struct file *file, vm_flags_t vm_flags)
 {
 	return vm_flags;
 }

-- 
2.51.0

