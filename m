Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DB320CCF2
	for <rcu@vger.kernel.org>; Thu, 23 Jan 2025 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628680; cv=none; b=HEgVvf/Rq5BGVHkkHQDFNOpcDdca9LZaRzQ7G0WHb41RZwrwcm7SqUcyae/tNyKhaLuccqGJtfhYbOaxzLudlayBVYy678eJgweTQnrZbqI8oESywB8P2HtzFCTvY+Um3l19NsWDvV/fbfA+8nsVu9sCsxHZf8yNswNdGehy8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628680; c=relaxed/simple;
	bh=WKAvcWMavpHcTSt989mw1tvjqHP9LL5fcBho8SiSQTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aaRJn3YEaOhg0RWTWrvTxOFv40U0c8uF4NSvgzTbVNqKcxIatMtvcaisc77v85T5WX5KTKbzrUutGiXQCng2zZIia1GlAb15TmOkG/KUA0HbEVFwIvXur3fUFeEM1cQrivwh0MhGHQ+ZngtScIMj1saG3I5fkAM7SWa7+gZI6bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 691061F38E;
	Thu, 23 Jan 2025 10:37:56 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E17913AEB;
	Thu, 23 Jan 2025 10:37:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0J/IEgQckmdrAQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Jan 2025 10:37:56 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 23 Jan 2025 11:37:20 +0100
Subject: [PATCH RFC 3/4] rcu, slab: use a regular callback function for
 kvfree_rcu
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-slub-tiny-kfree_rcu-v1-3-0e386ef1541a@suse.cz>
References: <20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz>
In-Reply-To: <20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7919; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=WKAvcWMavpHcTSt989mw1tvjqHP9LL5fcBho8SiSQTA=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBnkhv+Bcof+4VLA8ZCmcNF8uGQ+HPFDOAc3ycvb
 OlK4KbXIoGJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZ5Ib/gAKCRC74LB10kWI
 mjj9B/wLJAtKN4UJIhpxj+DobUk7Ek5tOmZzstc+dAZsuRqyn198EWVLIS8Uhc0dWq63TqWdQWn
 /UVNlKV69e0eP38w+/gU5B+BTgFzQ1kkJmxQtUpfao/K0COlP5oIriK+j2W645dlUaK/ztsuTWi
 Obv0B/MI2gi72hTbQx6gvkzvsRG2utl7kcHKbJqkowShnxyuHhamYklwDT7hk6OLm3agO2tIyRi
 3z+cx3ya23EMKYEKGJjHMvhcAGq5pMRUM8jwTvs5ZozAQnw57YEqC3F6FoyxpONhF4yKFNHriGo
 zanwGQGLGDP/OTdWk4WhZ34dM18Hgr19k/vrwKa6VvcpRYLk
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 691061F38E
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

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

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/rcupdate.h | 24 +++++++++---------------
 kernel/rcu/tiny.c        | 13 -------------
 mm/slab.h                |  2 ++
 mm/slab_common.c         |  5 +----
 mm/slub.c                | 42 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 3f70d1c8144426f40553c8c589f07097ece8a706..7ff16a70ca1c0fb1012c4118388f60687c5e5b3f 100644
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
+ * kmalloc of vmalloc allocation. To allow simply aligning the pointer down to
+ * page boundary for those, only offsets up to 4095 bytes can be accommodated.
  * If the offset is larger than 4095 bytes, a compile-time error will
  * be generated in kvfree_rcu_arg_2(). If this error is triggered, you can
  * either fall back to use of call_rcu() or rearrange the structure to
@@ -1091,10 +1085,10 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr);
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
index 0ec27093d0e14a4b1060ea08932c4ac13f9b0f26..77e0db0221364376a99ebeb17485650879385a6e 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -88,12 +88,6 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 	unsigned long offset = (unsigned long)head->func;
 
 	rcu_lock_acquire(&rcu_callback_map);
-	if (__is_kvfree_rcu_offset(offset)) {
-		trace_rcu_invoke_kvfree_callback("", head, offset);
-		kvfree((void *)head - offset);
-		rcu_lock_release(&rcu_callback_map);
-		return true;
-	}
 
 	trace_rcu_invoke_callback("", head);
 	f = head->func;
@@ -159,10 +153,6 @@ void synchronize_rcu(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 
-static void tiny_rcu_leak_callback(struct rcu_head *rhp)
-{
-}
-
 /*
  * Post an RCU callback to be invoked after the end of an RCU grace
  * period.  But since we have but one CPU, that would be after any
@@ -178,9 +168,6 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
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
index 330cdd8ebc5380090ee784c58e8ca1d1a52b3758..f13d2c901daf1419993620459fbd5845eecb85f1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1532,9 +1532,6 @@ kvfree_rcu_list(struct rcu_head *head)
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kvfree_callback("slab", head, offset);
 
-		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
-			kvfree(ptr);
-
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
 	}
@@ -1867,7 +1864,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 {
 	if (head) {
 		kasan_record_aux_stack_noalloc(ptr);
-		call_rcu(head, (rcu_callback_t) ((void *) head - ptr));
+		call_rcu(head, kvfree_rcu_cb);
 		return;
 	}
 
diff --git a/mm/slub.c b/mm/slub.c
index c2151c9fee228d121a9cbcc220c3ae054769dacf..651381bf05566e88de8493e0550f121d23b757a1 100644
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
@@ -4732,6 +4733,47 @@ static void free_large_kmalloc(struct folio *folio, void *object)
 	folio_put(folio);
 }
 
+void kvfree_rcu_cb(struct rcu_head *head)
+{
+	void *obj = head;
+	struct folio *folio;
+	struct slab *slab;
+	struct kmem_cache *s;
+	void *slab_addr;
+
+	if (unlikely(is_vmalloc_addr(obj))) {
+		obj = (void *) PAGE_ALIGN_DOWN((unsigned long)obj);
+		vfree(obj);
+		return;
+	}
+
+	folio = virt_to_folio(obj);
+	if (unlikely(!folio_test_slab(folio))) {
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

