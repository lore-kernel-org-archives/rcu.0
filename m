Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351720697D;
	Tue, 12 Nov 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429591; cv=none; b=I7LPe9sFltQA5TVnWQQ5OnRbABMhNaP/wYOBaTNcasCZ4qlUhzK62G0X8kxutIkvUbr/HjgL9XJAAtLOtm5IW8XlVAnynrvIXiQDQMtsdokUCMkR83MLFKRao57aUapdPnEIzx8MhddLoMZele9/BKD3H0B3uXHub+FF/XM0Wq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429591; c=relaxed/simple;
	bh=PRBm6yTHnI9o2EriRwSuA2+7nFOSW6qnz/vcAISTClE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V/qadGfFAJJhNxpNpexMhdNvFKWvuhCjiOt2cJcBLEDXx/z5TGy5jR2y46cfkno436ZO/T7V7cGq6Jf/aNEXZkn1dJvP7Bn068Lk/x4InsZ0/P1CKBTd1F/HOTYi9TLSVE8hpC87DNUOdXQE6vYQA0OBPKwKVbKxunmPWSvEtpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q6qWV7hI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LJNvl0h5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q6qWV7hI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LJNvl0h5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q6qWV7hI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LJNvl0h5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q6qWV7hI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LJNvl0h5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B54C51F45F;
	Tue, 12 Nov 2024 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731429587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uriiopleY9LF99nzRKEM/QRONRLZG7kJq5gEkIUEooo=;
	b=q6qWV7hIXDcF1jRtbTKkeJrrdrrA1UIIBsXB0uGZRGVaLHDOtWSKX140ESvd3T3gxs7Vfr
	Qx4fvsPgMjOBaIOCGKX9O8wEiINoFnn7S/J20O9WVU71zdBN/xFzXvhg1mXxsrmqqkykG/
	nixdIhn7iHqmMkBspOuOekE8iQvaB30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731429587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uriiopleY9LF99nzRKEM/QRONRLZG7kJq5gEkIUEooo=;
	b=LJNvl0h5HG3PLxcKUneuUDBpOlvSXv6Fqb0klJ2JjgdNa3FsxvKhVquDJ8Wgbp6AyIpv4T
	vcfhwMLV7h8T/7Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731429587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uriiopleY9LF99nzRKEM/QRONRLZG7kJq5gEkIUEooo=;
	b=q6qWV7hIXDcF1jRtbTKkeJrrdrrA1UIIBsXB0uGZRGVaLHDOtWSKX140ESvd3T3gxs7Vfr
	Qx4fvsPgMjOBaIOCGKX9O8wEiINoFnn7S/J20O9WVU71zdBN/xFzXvhg1mXxsrmqqkykG/
	nixdIhn7iHqmMkBspOuOekE8iQvaB30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731429587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uriiopleY9LF99nzRKEM/QRONRLZG7kJq5gEkIUEooo=;
	b=LJNvl0h5HG3PLxcKUneuUDBpOlvSXv6Fqb0klJ2JjgdNa3FsxvKhVquDJ8Wgbp6AyIpv4T
	vcfhwMLV7h8T/7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 939E413A8C;
	Tue, 12 Nov 2024 16:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aB6rI9OEM2e6IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 12 Nov 2024 16:39:47 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 12 Nov 2024 17:38:49 +0100
Subject: [PATCH RFC 5/6] mm, slub: cheaper locking for percpu sheaves
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-slub-percpu-caches-v1-5-ddc0bdc27e05@suse.cz>
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
 maple-tree@lists.infradead.org, Mateusz Guzik <mjguzik@gmail.com>, 
 Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15892; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=PRBm6yTHnI9o2EriRwSuA2+7nFOSW6qnz/vcAISTClE=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBnM4TNjQnearUwkpXTNV2rFVjJOdqdyuEsdUtqA
 SwzRmisRSiJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZzOEzQAKCRC74LB10kWI
 mlzRB/9eK4hOsHKJNy1cTTIQoMZwmlN0OGFTjcOONeLpT3Qbc5Ph6VUS6gGgFP26sGiNOl24Xn7
 9RaOHWOHYk2roLmYVIWzwYMM0eiW4EizQao2zxV2yF1FjLr1g6oaqMsGWavvUWW2C2V/egaC5St
 iPEwnCRdF2k6fAYTfj1Ih9R/Rwi5oR/euViKELRG7GUQq9siENtFfmmXe1dTpj8OlCEu+4XQMm3
 dyfQbMTAtKv44n9HPUoB1/3MjZWuNU0V+C2NuhgV//vY3JfOjZUpYxteWwKNtc9r0csLqFuMkHk
 MrP96yPZkfuTuj/DLDb6D+qR7VtQg29QKtSvLxfYiDwuOAVg
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Score: -6.80
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
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,oracle.com,infradead.org,kvack.org,vger.kernel.org,lists.infradead.org,google.com,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLtz7ce9b89hw8xzamye9qeynd)]
X-Spam-Flag: NO
X-Spam-Level: 

Instead of local_lock_irqsave(), use just get_cpu_ptr() (which only
disables preemption) and then set an active flag. If potential callers
include irq handler, the operation must use a trylock variant that bails
out if the flag is already set to active because we interrupted another
operation in progress.

Changing the flag doesn't need to be atomic as the irq is one the same
cpu. This should make using percpu sheaves cheaper, with the downside of
some unlucky operations in irq handlers have to fallback to non-sheave
variants. That should be rare so there should be a net benefit.

On PREEMPT_RT we can use simply local_lock() as that does the right
thing without the need to disable irqs.

Thanks to Mateusz Guzik and Jann Horn for suggesting this kind of
locking scheme in online conversations. Initially attempted to fully
copy the page allocator's pcplist locking, but its reliance on
spin_trylock() made it much more costly.

Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 230 +++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 174 insertions(+), 56 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6811d766c0470cd7066c2574ad86e00405c916bb..1900afa6153ca6d88f9df7db3ce84d98629489e7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -450,14 +450,111 @@ struct slab_sheaf {
 	void *objects[];
 };
 
+struct local_tryirq_lock {
+#ifndef CONFIG_PREEMPT_RT
+	int active;
+#else
+	local_lock_t llock;
+#endif
+};
+
 struct slub_percpu_sheaves {
-	local_lock_t lock;
+	struct local_tryirq_lock lock;
 	struct slab_sheaf *main; /* never NULL when unlocked */
 	struct slab_sheaf *spare; /* empty or full, may be NULL */
 	struct slab_sheaf *rcu_free;
 	struct node_barn *barn;
 };
 
+/*
+ * Generic helper to lookup a per-cpu variable with a lock that allows only
+ * trylock from irq handler context to avoid expensive irq disable or atomic
+ * operations and memory barriers - only compiler barriers are needed.
+ *
+ * On !PREEMPT_RT this is done by get_cpu_ptr(), which disables preemption, and
+ * checking that a variable is not already set to 1. If it is, it means we are
+ * in irq handler that has interrupted the locked operation, and must give up.
+ * Otherwise we set the variable to 1.
+ *
+ * On PREEMPT_RT we can simply use local_lock() as that does the right thing
+ * without actually disabling irqs. Thus the trylock can't actually fail.
+ *
+ */
+#ifndef CONFIG_PREEMPT_RT
+
+#define pcpu_local_tryirq_lock(type, member, ptr)                       \
+({                                                                      \
+	type *_ret;                                                     \
+	lockdep_assert(!irq_count());					\
+	_ret = get_cpu_ptr(ptr);                                        \
+	lockdep_assert(_ret->member.active == 0);			\
+	WRITE_ONCE(_ret->member.active, 1);				\
+	barrier();							\
+	_ret;                                                           \
+})
+
+#define pcpu_local_tryirq_trylock(type, member, ptr)                    \
+({                                                                      \
+	type *_ret;                                                     \
+	_ret = get_cpu_ptr(ptr);                                        \
+	if (unlikely(READ_ONCE(_ret->member.active) == 1)) {		\
+		put_cpu_ptr(ptr);					\
+		_ret = NULL;						\
+	} else {                                                        \
+		WRITE_ONCE(_ret->member.active, 1);			\
+		barrier();						\
+	}								\
+	_ret;                                                           \
+})
+
+#define pcpu_local_tryirq_unlock(member, ptr)                           \
+({                                                                      \
+	lockdep_assert(this_cpu_ptr(ptr)->member.active == 1);		\
+	barrier();							\
+	WRITE_ONCE(this_cpu_ptr(ptr)->member.active, 0);		\
+	put_cpu_ptr(ptr);						\
+})
+
+#define local_tryirq_lock_init(lock)					\
+({									\
+	(lock)->active = 0;						\
+})
+
+#else
+
+#define pcpu_local_tryirq_lock(type, member, ptr)                       \
+({                                                                      \
+	type *_ret;                                                     \
+	local_lock(&ptr->member.llock);					\
+	_ret = this_cpu_ptr(ptr);                                       \
+	_ret;                                                           \
+})
+
+#define pcpu_local_tryirq_trylock(type, member, ptr)                    \
+	pcpu_local_tryirq_lock(type, member, ptr)
+
+#define pcpu_local_tryirq_unlock(member, ptr)                           \
+({                                                                      \
+	local_unlock(&ptr->member.llock);				\
+})
+
+#define local_tryirq_lock_init(lock)					\
+({									\
+	local_lock_init(&(lock)->llock);				\
+})
+
+#endif
+
+/* struct slub_percpu_sheaves specific helpers. */
+#define cpu_sheaves_lock(ptr)                                           \
+	pcpu_local_tryirq_lock(struct slub_percpu_sheaves, lock, ptr)
+
+#define cpu_sheaves_trylock(ptr)                                        \
+	pcpu_local_tryirq_trylock(struct slub_percpu_sheaves, lock, ptr)
+
+#define cpu_sheaves_unlock(ptr)                                         \
+	pcpu_local_tryirq_unlock(lock, ptr)
+
 /*
  * The slab lists for all objects.
  */
@@ -2517,17 +2614,20 @@ static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
 
 static void __kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p);
 
-static void sheaf_flush_main(struct kmem_cache *s)
+/* returns true if at least partially flushed */
+static bool sheaf_flush_main(struct kmem_cache *s)
 {
 	struct slub_percpu_sheaves *pcs;
 	unsigned int batch, remaining;
 	void *objects[PCS_BATCH_MAX];
 	struct slab_sheaf *sheaf;
-	unsigned long flags;
+	bool ret = false;
 
 next_batch:
-	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
-	pcs = this_cpu_ptr(s->cpu_sheaves);
+	pcs = cpu_sheaves_trylock(s->cpu_sheaves);
+	if (!pcs)
+		return ret;
+
 	sheaf = pcs->main;
 
 	batch = min(PCS_BATCH_MAX, sheaf->size);
@@ -2537,14 +2637,18 @@ static void sheaf_flush_main(struct kmem_cache *s)
 
 	remaining = sheaf->size;
 
-	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+	cpu_sheaves_unlock(s->cpu_sheaves);
 
 	__kmem_cache_free_bulk(s, batch, &objects[0]);
 
 	stat_add(s, SHEAF_FLUSH_MAIN, batch);
 
+	ret = true;
+
 	if (remaining)
 		goto next_batch;
+
+	return ret;
 }
 
 static void sheaf_flush(struct kmem_cache *s, struct slab_sheaf *sheaf)
@@ -2581,6 +2685,8 @@ static void rcu_free_sheaf_nobarn(struct rcu_head *head)
  * Caller needs to make sure migration is disabled in order to fully flush
  * single cpu's sheaves
  *
+ * must not be called from an irq
+ *
  * flushing operations are rare so let's keep it simple and flush to slabs
  * directly, skipping the barn
  */
@@ -2588,10 +2694,8 @@ static void pcs_flush_all(struct kmem_cache *s)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *spare, *rcu_free;
-	unsigned long flags;
 
-	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
-	pcs = this_cpu_ptr(s->cpu_sheaves);
+	pcs = cpu_sheaves_lock(s->cpu_sheaves);
 
 	spare = pcs->spare;
 	pcs->spare = NULL;
@@ -2599,7 +2703,7 @@ static void pcs_flush_all(struct kmem_cache *s)
 	rcu_free = pcs->rcu_free;
 	pcs->rcu_free = NULL;
 
-	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+	cpu_sheaves_unlock(s->cpu_sheaves);
 
 	if (spare) {
 		sheaf_flush(s, spare);
@@ -4523,11 +4627,11 @@ static __fastpath_inline
 void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
 {
 	struct slub_percpu_sheaves *pcs;
-	unsigned long flags;
 	void *object;
 
-	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
-	pcs = this_cpu_ptr(s->cpu_sheaves);
+	pcs = cpu_sheaves_trylock(s->cpu_sheaves);
+	if (!pcs)
+		return NULL;
 
 	if (unlikely(pcs->main->size == 0)) {
 
@@ -4559,7 +4663,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
 			}
 		}
 
-		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+		cpu_sheaves_unlock(s->cpu_sheaves);
 
 		if (!can_alloc)
 			return NULL;
@@ -4581,8 +4685,11 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
 		if (!full)
 			return NULL;
 
-		local_lock_irqsave(&s->cpu_sheaves->lock, flags);
-		pcs = this_cpu_ptr(s->cpu_sheaves);
+		/*
+		 * we can reach here only when gfpflags_allow_blocking
+		 * so this must not be an irq
+		 */
+		pcs = cpu_sheaves_lock(s->cpu_sheaves);
 
 		/*
 		 * If we are returning empty sheaf, we either got it from the
@@ -4615,7 +4722,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
 do_alloc:
 	object = pcs->main->objects[--pcs->main->size];
 
-	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+	cpu_sheaves_unlock(s->cpu_sheaves);
 
 	stat(s, ALLOC_PCS);
 
@@ -4627,13 +4734,13 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *main;
-	unsigned long flags;
 	unsigned int allocated = 0;
 	unsigned int batch;
 
 next_batch:
-	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
-	pcs = this_cpu_ptr(s->cpu_sheaves);
+	pcs = cpu_sheaves_trylock(s->cpu_sheaves);
+	if (!pcs)
+		return allocated;
 
 	if (unlikely(pcs->main->size == 0)) {
 
@@ -4652,7 +4759,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 			goto do_alloc;
 		}
 
-		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+		cpu_sheaves_unlock(s->cpu_sheaves);
 
 		/*
 		 * Once full sheaves in barn are depleted, let the bulk
@@ -4670,7 +4777,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	main->size -= batch;
 	memcpy(p, main->objects + main->size, batch * sizeof(void *));
 
-	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+	cpu_sheaves_unlock(s->cpu_sheaves);
 
 	stat_add(s, ALLOC_PCS, batch);
 
@@ -5090,14 +5197,14 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
  * The object is expected to have passed slab_free_hook() already.
  */
 static __fastpath_inline
-void free_to_pcs(struct kmem_cache *s, void *object)
+bool free_to_pcs(struct kmem_cache *s, void *object)
 {
 	struct slub_percpu_sheaves *pcs;
-	unsigned long flags;
 
 restart:
-	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
-	pcs = this_cpu_ptr(s->cpu_sheaves);
+	pcs = cpu_sheaves_trylock(s->cpu_sheaves);
+	if (!pcs)
+		return false;
 
 	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
 
@@ -5131,7 +5238,7 @@ void free_to_pcs(struct kmem_cache *s, void *object)
 			struct slab_sheaf *to_flush = pcs->spare;
 
 			pcs->spare = NULL;
-			local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+			cpu_sheaves_unlock(s->cpu_sheaves);
 
 			sheaf_flush(s, to_flush);
 			empty = to_flush;
@@ -5139,18 +5246,27 @@ void free_to_pcs(struct kmem_cache *s, void *object)
 		}
 
 alloc_empty:
-		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+		cpu_sheaves_unlock(s->cpu_sheaves);
 
 		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
 
 		if (!empty) {
-			sheaf_flush_main(s);
-			goto restart;
+			if (sheaf_flush_main(s))
+				goto restart;
+			else
+				return false;
 		}
 
 got_empty:
-		local_lock_irqsave(&s->cpu_sheaves->lock, flags);
-		pcs = this_cpu_ptr(s->cpu_sheaves);
+		pcs = cpu_sheaves_trylock(s->cpu_sheaves);
+		if (!pcs) {
+			struct node_barn *barn;
+
+			barn = get_node(s, numa_mem_id())->barn;
+
+			barn_put_empty_sheaf(barn, empty, true);
+			return false;
+		}
 
 		/*
 		 * if we put any sheaf to barn here, it's because we raced or
@@ -5178,9 +5294,11 @@ void free_to_pcs(struct kmem_cache *s, void *object)
 do_free:
 	pcs->main->objects[pcs->main->size++] = object;
 
-	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+	cpu_sheaves_unlock(s->cpu_sheaves);
 
 	stat(s, FREE_PCS);
+
+	return true;
 }
 
 static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
@@ -5242,10 +5360,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *rcu_sheaf;
-	unsigned long flags;
 
-	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
-	pcs = this_cpu_ptr(s->cpu_sheaves);
+	pcs = cpu_sheaves_trylock(s->cpu_sheaves);
+	if (!pcs)
+		goto fail;
 
 	if (unlikely(!pcs->rcu_free)) {
 
@@ -5258,17 +5376,16 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 			goto do_free;
 		}
 
-		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+		cpu_sheaves_unlock(s->cpu_sheaves);
 
 		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
 
-		if (!empty) {
-			stat(s, FREE_RCU_SHEAF_FAIL);
-			return false;
-		}
+		if (!empty)
+			goto fail;
 
-		local_lock_irqsave(&s->cpu_sheaves->lock, flags);
-		pcs = this_cpu_ptr(s->cpu_sheaves);
+		pcs = cpu_sheaves_trylock(s->cpu_sheaves);
+		if (!pcs)
+			goto fail;
 
 		if (unlikely(pcs->rcu_free))
 			barn_put_empty_sheaf(pcs->barn, empty, true);
@@ -5283,19 +5400,22 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 	rcu_sheaf->objects[rcu_sheaf->size++] = obj;
 
 	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
-		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+		cpu_sheaves_unlock(s->cpu_sheaves);
 		stat(s, FREE_RCU_SHEAF);
 		return true;
 	}
 
 	pcs->rcu_free = NULL;
-	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+	cpu_sheaves_unlock(s->cpu_sheaves);
 
 	call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
 
 	stat(s, FREE_RCU_SHEAF);
-
 	return true;
+
+fail:
+	stat(s, FREE_RCU_SHEAF_FAIL);
+	return false;
 }
 
 /*
@@ -5307,7 +5427,6 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *main;
-	unsigned long flags;
 	unsigned int batch, i = 0;
 	bool init;
 
@@ -5330,8 +5449,9 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	}
 
 next_batch:
-	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
-	pcs = this_cpu_ptr(s->cpu_sheaves);
+	pcs = cpu_sheaves_trylock(s->cpu_sheaves);
+	if (!pcs)
+		goto fallback;
 
 	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
 
@@ -5361,13 +5481,13 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 		}
 
 no_empty:
-		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+		cpu_sheaves_unlock(s->cpu_sheaves);
 
 		/*
 		 * if we depleted all empty sheaves in the barn or there are too
 		 * many full sheaves, free the rest to slab pages
 		 */
-
+fallback:
 		__kmem_cache_free_bulk(s, size, p);
 		return;
 	}
@@ -5379,7 +5499,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	memcpy(main->objects + main->size, p, batch * sizeof(void *));
 	main->size += batch;
 
-	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
+	cpu_sheaves_unlock(s->cpu_sheaves);
 
 	stat_add(s, FREE_PCS, batch);
 
@@ -5479,9 +5599,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
 		return;
 
-	if (s->cpu_sheaves)
-		free_to_pcs(s, object);
-	else
+	if (!s->cpu_sheaves || !free_to_pcs(s, object))
 		do_slab_free(s, slab, object, object, 1, addr);
 }
 
@@ -6121,7 +6239,7 @@ static int init_percpu_sheaves(struct kmem_cache *s)
 
 		pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
 
-		local_lock_init(&pcs->lock);
+		local_tryirq_lock_init(&pcs->lock);
 
 		nid = cpu_to_mem(cpu);
 

-- 
2.47.0

