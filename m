Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19121FF1D8
	for <rcu@vger.kernel.org>; Mon,  3 Feb 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574972; cv=none; b=oag+G81qNaWJHezwW7mIzFtvmk53+trMx2Xc0HmbZMPf/KnTfFfOCe8AMS1lQWnCNNuZGoOaCHURGnrR+6kWPSeJ8LwqnjKt0SZRihGcwr08rQCRoWwnJZyh2Ejkewhges2cCm95VLkzq4cCCqE/gh9dPQOmcNgMT7zsMhHgERw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574972; c=relaxed/simple;
	bh=BJtZmUqsaLJnrxLUhKoXDbIgkbxiu8qWYv9Zv4R1LEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZyymrHCYaN/uVNfvkN1dLb1r4nLloubJp6mX0VD+QQhFAvSzXMMlYr+e6UkeFsCdCO/zKjlSP0qjrHzWzL1Z59BUpK968tKw4cZOjsyimlVms9eZe1KX+HLaFHcAitYzp6qR38ZNGZF88oMnEILbedluQaZIyT1pLL5OmrycDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Qxyruqu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mpHr8Utj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Qxyruqu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mpHr8Utj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Qxyruqu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mpHr8Utj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Qxyruqu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mpHr8Utj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AEF321F381;
	Mon,  3 Feb 2025 09:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738574968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0EAiV0EQ0UZEjL4mUXNSvL6nqq3icXpaRdqmV/qKRdM=;
	b=0Qxyruqu06l41TSkvtmP7rXzERFZbhb89hIZTGSuoVH94HG5UYmQ8ntLjtkYKDxAvW/NJ+
	xD6OHEa9E9TNVLWm+f4DqxI707Kd9xN4fgpMcYdmT0/hkMqC/RYAQzW1whoIUlr5BOs+vK
	wNaDLpf4+uAnoUAp1pRhXx1Wq1NhcwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738574968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0EAiV0EQ0UZEjL4mUXNSvL6nqq3icXpaRdqmV/qKRdM=;
	b=mpHr8Utj3tzbk8Isy/GcXAvB4aFtM3pfE2N1pgSKK+FihsiFNUYJgfRgbY46QhTV4LspCb
	ZoxxFIqBM4d4LYBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738574968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0EAiV0EQ0UZEjL4mUXNSvL6nqq3icXpaRdqmV/qKRdM=;
	b=0Qxyruqu06l41TSkvtmP7rXzERFZbhb89hIZTGSuoVH94HG5UYmQ8ntLjtkYKDxAvW/NJ+
	xD6OHEa9E9TNVLWm+f4DqxI707Kd9xN4fgpMcYdmT0/hkMqC/RYAQzW1whoIUlr5BOs+vK
	wNaDLpf4+uAnoUAp1pRhXx1Wq1NhcwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738574968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0EAiV0EQ0UZEjL4mUXNSvL6nqq3icXpaRdqmV/qKRdM=;
	b=mpHr8Utj3tzbk8Isy/GcXAvB4aFtM3pfE2N1pgSKK+FihsiFNUYJgfRgbY46QhTV4LspCb
	ZoxxFIqBM4d4LYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 916EA13AE2;
	Mon,  3 Feb 2025 09:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UEs8I3iMoGfwYAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Feb 2025 09:29:28 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 03 Feb 2025 10:28:49 +0100
Subject: [PATCH 3/4] rcu, slab: use a regular callback function for
 kvfree_rcu
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-slub-tiny-kfree_rcu-v1-3-d4428bf9a8a1@suse.cz>
References: <20250203-slub-tiny-kfree_rcu-v1-0-d4428bf9a8a1@suse.cz>
In-Reply-To: <20250203-slub-tiny-kfree_rcu-v1-0-d4428bf9a8a1@suse.cz>
To: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Joel Fernandes <joel@joelfernandes.org>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
 rcu@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[linux.com,google.com,kernel.org,joelfernandes.org,joshtriplett.org,gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,gmail.com,kvack.org,goodmis.org,efficios.com,vger.kernel.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLtsk3gtac773whqka7ht6mdi4)];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Score: -6.80
X-Spam-Flag: NO

RCU has been special-casing callback function pointers that are integers
lower than 4096 as offsets of rcu_head for kvfree() instead. The tree
RCU implementation no longer does that as the batched kvfree_rcu() is
not a simple call_rcu(). The tiny RCU still does, and the plan is also
to make tree RCU use call_rcu() for SLUB_TINY configurations.

Instead of teaching tree RCU again to special case the offsets, let's
remove the special casing completely. Since there's no SLOB anymore, it
is possible to create a callback function that can take a pointer to a
middle of slab object with unknown offset and determine the object's
pointer before freeing it, so implement that as kvfree_rcu_cb().

Large kmalloc and vmalloc allocations are handled simply by aligning
down to page size. For that we retain the requirement that the offset is
smaller than 4096. But we can remove __is_kvfree_rcu_offset() completely
and instead just opencode the condition in the BUILD_BUG_ON() check.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/rcupdate.h | 28 +++++++++++++---------------
 kernel/rcu/tiny.c        | 14 --------------
 mm/slab.h                |  2 ++
 mm/slab_common.c         |  5 ++---
 mm/slub.c                | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 3f70d1c8144426f40553c8c589f07097ece8a706..23bcf71ffb06ecf60d42690803ffc5adb7d1aedd 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1025,12 +1025,6 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 #define RCU_POINTER_INITIALIZER(p, v) \
 		.p = RCU_INITIALIZER(v)
 
-/*
- * Does the specified offset indicate that the corresponding rcu_head
- * structure can be handled by kvfree_rcu()?
- */
-#define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
-
 /**
  * kfree_rcu() - kfree an object after a grace period.
  * @ptr: pointer to kfree for double-argument invocations.
@@ -1041,11 +1035,11 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * when they are used in a kernel module, that module must invoke the
  * high-latency rcu_barrier() function at module-unload time.
  *
- * The kfree_rcu() function handles this issue.  Rather than encoding a
- * function address in the embedded rcu_head structure, kfree_rcu() instead
- * encodes the offset of the rcu_head structure within the base structure.
- * Because the functions are not allowed in the low-order 4096 bytes of
- * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
+ * The kfree_rcu() function handles this issue. In order to have a universal
+ * callback function handling different offsets of rcu_head, the callback needs
+ * to determine the starting address of the freed object, which can be a large
+ * kmalloc or vmalloc allocation. To allow simply aligning the pointer down to
+ * page boundary for those, only offsets up to 4095 bytes can be accommodated.
  * If the offset is larger than 4095 bytes, a compile-time error will
  * be generated in kvfree_rcu_arg_2(). If this error is triggered, you can
  * either fall back to use of call_rcu() or rearrange the structure to
@@ -1087,14 +1081,18 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  */
 void kvfree_call_rcu(struct rcu_head *head, void *ptr);
 
+/*
+ * The BUILD_BUG_ON() makes sure the rcu_head offset can be handled. See the
+ * comment of kfree_rcu() for details.
+ */
 #define kvfree_rcu_arg_2(ptr, rhf)					\
 do {									\
 	typeof (ptr) ___p = (ptr);					\
 									\
-	if (___p) {									\
-		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offsetof(typeof(*(ptr)), rhf)));	\
-		kvfree_call_rcu(&((___p)->rhf), (void *) (___p));			\
-	}										\
+	if (___p) {							\
+		BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >= 4096);	\
+		kvfree_call_rcu(&((___p)->rhf), (void *) (___p));	\
+	}								\
 } while (0)
 
 #define kvfree_rcu_arg_1(ptr)					\
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 0ec27093d0e14a4b1060ea08932c4ac13f9b0f26..7a34a99d4664f3fc050ec22378782fe26e8d1e95 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -85,15 +85,8 @@ void rcu_sched_clock_irq(int user)
 static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 {
 	rcu_callback_t f;
-	unsigned long offset = (unsigned long)head->func;
 
 	rcu_lock_acquire(&rcu_callback_map);
-	if (__is_kvfree_rcu_offset(offset)) {
-		trace_rcu_invoke_kvfree_callback("", head, offset);
-		kvfree((void *)head - offset);
-		rcu_lock_release(&rcu_callback_map);
-		return true;
-	}
 
 	trace_rcu_invoke_callback("", head);
 	f = head->func;
@@ -159,10 +152,6 @@ void synchronize_rcu(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 
-static void tiny_rcu_leak_callback(struct rcu_head *rhp)
-{
-}
-
 /*
  * Post an RCU callback to be invoked after the end of an RCU grace
  * period.  But since we have but one CPU, that would be after any
@@ -178,9 +167,6 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
 			mem_dump_obj(head);
 		}
-
-		if (!__is_kvfree_rcu_offset((unsigned long)head->func))
-			WRITE_ONCE(head->func, tiny_rcu_leak_callback);
 		return;
 	}
 
diff --git a/mm/slab.h b/mm/slab.h
index e9fd9bf0bfa65b343a4ae0ecd5b4c2a325b04883..2f01c7317988ce036f0b22807403226a59f0f708 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -604,6 +604,8 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 			    void **p, int objects, struct slabobj_ext *obj_exts);
 #endif
 
+void kvfree_rcu_cb(struct rcu_head *head);
+
 size_t __ksize(const void *objp);
 
 static inline size_t slab_ksize(const struct kmem_cache *s)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 81a0ce77b11c2ef8db9164cdca5853069402f161..6438a38aa5dc2ede0b5afa04bc3fbff5a4697d87 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1290,7 +1290,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 {
 	if (head) {
 		kasan_record_aux_stack(ptr);
-		call_rcu(head, (rcu_callback_t) ((void *) head - ptr));
+		call_rcu(head, kvfree_rcu_cb);
 		return;
 	}
 
@@ -1551,8 +1551,7 @@ kvfree_rcu_list(struct rcu_head *head)
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kvfree_callback("slab", head, offset);
 
-		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
-			kvfree(ptr);
+		kvfree(ptr);
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
diff --git a/mm/slub.c b/mm/slub.c
index 1f50129dcfb3cd1fc76ac9398fa7718cedb42385..e8273f28656936c05d015c53923f8fe69cd161b2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -19,6 +19,7 @@
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include "slab.h"
+#include <linux/vmalloc.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/kasan.h>
@@ -4728,6 +4729,51 @@ static void free_large_kmalloc(struct folio *folio, void *object)
 	folio_put(folio);
 }
 
+/*
+ * Given an rcu_head embedded within an object obtained from kvmalloc at an
+ * offset < 4k, free the object in question.
+ */
+void kvfree_rcu_cb(struct rcu_head *head)
+{
+	void *obj = head;
+	struct folio *folio;
+	struct slab *slab;
+	struct kmem_cache *s;
+	void *slab_addr;
+
+	if (is_vmalloc_addr(obj)) {
+		obj = (void *) PAGE_ALIGN_DOWN((unsigned long)obj);
+		vfree(obj);
+		return;
+	}
+
+	folio = virt_to_folio(obj);
+	if (!folio_test_slab(folio)) {
+		/*
+		 * rcu_head offset can be only less than page size so no need to
+		 * consider folio order
+		 */
+		obj = (void *) PAGE_ALIGN_DOWN((unsigned long)obj);
+		free_large_kmalloc(folio, obj);
+		return;
+	}
+
+	slab = folio_slab(folio);
+	s = slab->slab_cache;
+	slab_addr = folio_address(folio);
+
+	if (is_kfence_address(obj)) {
+		obj = kfence_object_start(obj);
+	} else {
+		unsigned int idx = __obj_to_index(s, slab_addr, obj);
+
+		obj = slab_addr + s->size * idx;
+		obj = fixup_red_left(s, obj);
+	}
+
+	slab_free(s, slab, obj, _RET_IP_);
+}
+
 /**
  * kfree - free previously allocated memory
  * @object: pointer returned by kmalloc() or kmem_cache_alloc()

-- 
2.48.1

