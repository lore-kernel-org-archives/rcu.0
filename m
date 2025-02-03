Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563721FF1D5
	for <rcu@vger.kernel.org>; Mon,  3 Feb 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574972; cv=none; b=O0MlM8LUZboVOB7rBe7ZVzSbNRZmsVY7p21EYbG/04+teBo1M0EKDHttMP/UDI10d4l2+O4iBEI6HVqEQgw9dfj3zLdJoCsn3tQ3GIc+onCaog/vv/lkMs2MEzxd9dGFEun9YPLUV/bv1aI1oN3a1YkShE5LkiY/U02mCY6Mgok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574972; c=relaxed/simple;
	bh=hxb1NOW5fUpcMflh1MGv+mZ4s/LbhUEszyZlaQ7uTfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IWyPHh2onA4vW/O30cxw5BMIC6snmhXejnJtJRp89p9A5O2qr1wAm0kUyCljjAdcbRCP7MiuXd6U36BomJcs4pN4EleW4bw38WSKvmewpSeFTeF8vmhvgtjfpRn6uk/zEcLqQo2p484SD3J4wgc9wczhnYr0vh7RMDVVjuHY3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MzMfL4uI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pHThM6s8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MzMfL4uI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pHThM6s8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MzMfL4uI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pHThM6s8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MzMfL4uI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pHThM6s8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F68A1F37C;
	Mon,  3 Feb 2025 09:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738574968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXDMn7CNaiwzg65IjzvDMWn1fcydgyKYjKgaCniNb+k=;
	b=MzMfL4uIU/3QqymoYS4v8PqmFnz21cfP5NEngfEhatZvlZy29ntpMjAXQPS6OQJ6vX8hyv
	O0j4fvLPgufOeXnqmK3USltq91hjeYfjnZtWfIbxuNdn4CQiYWQcIWqea3EtYJnE1bakWh
	dO3fRmW5KHEEIRFJyaylIU20ealDzvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738574968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXDMn7CNaiwzg65IjzvDMWn1fcydgyKYjKgaCniNb+k=;
	b=pHThM6s80q1IJrVjq+VNKki1sk+L4MdY/g+oiJkl/2/bmeSm9OVi81mXJdio0H3xjcHyJK
	JCcFBEhg7qHi7PCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MzMfL4uI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pHThM6s8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738574968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXDMn7CNaiwzg65IjzvDMWn1fcydgyKYjKgaCniNb+k=;
	b=MzMfL4uIU/3QqymoYS4v8PqmFnz21cfP5NEngfEhatZvlZy29ntpMjAXQPS6OQJ6vX8hyv
	O0j4fvLPgufOeXnqmK3USltq91hjeYfjnZtWfIbxuNdn4CQiYWQcIWqea3EtYJnE1bakWh
	dO3fRmW5KHEEIRFJyaylIU20ealDzvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738574968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXDMn7CNaiwzg65IjzvDMWn1fcydgyKYjKgaCniNb+k=;
	b=pHThM6s80q1IJrVjq+VNKki1sk+L4MdY/g+oiJkl/2/bmeSm9OVi81mXJdio0H3xjcHyJK
	JCcFBEhg7qHi7PCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EF1313A7F;
	Mon,  3 Feb 2025 09:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KJXgFniMoGfwYAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Feb 2025 09:29:28 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 03 Feb 2025 10:28:47 +0100
Subject: [PATCH 1/4] slab, rcu: move TINY_RCU variant of kvfree_rcu() to
 SLAB
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-slub-tiny-kfree_rcu-v1-1-d4428bf9a8a1@suse.cz>
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
X-Rspamd-Queue-Id: 7F68A1F37C
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[linux.com,google.com,kernel.org,joelfernandes.org,joshtriplett.org,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,gmail.com,kvack.org,goodmis.org,efficios.com,vger.kernel.org,suse.cz];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Following the move of TREE_RCU implementation, let's move also the
TINY_RCU one for consistency and subsequent refactoring.

For simplicity, remove the separate inline __kvfree_call_rcu() as
TINY_RCU is not meant for high-performance hardware anyway.

Declare kvfree_call_rcu() in rcupdate.h to avoid header dependency
issues.

Also move the kvfree_rcu_barrier() declaration to slab.h

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/rcupdate.h |  5 +++++
 include/linux/rcutiny.h  | 36 ------------------------------------
 include/linux/rcutree.h  |  3 ---
 include/linux/slab.h     | 14 ++++++++++++++
 kernel/rcu/tiny.c        | 11 -----------
 mm/slab_common.c         | 19 +++++++++++++++++++
 6 files changed, 38 insertions(+), 50 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 48e5c03df1dd83c246a61d0fcc8aa638adcd7654..3f70d1c8144426f40553c8c589f07097ece8a706 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1082,6 +1082,11 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 #define kfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
 #define kvfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
 
+/*
+ * In mm/slab_common.c, no suitable header to include here.
+ */
+void kvfree_call_rcu(struct rcu_head *head, void *ptr);
+
 #define kvfree_rcu_arg_2(ptr, rhf)					\
 do {									\
 	typeof (ptr) ___p = (ptr);					\
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index fe42315f667fc5be7f2ed8eae6ea0c7193030846..f519cd6802286710bdd56588b5ff3d07bcd30b92 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -90,41 +90,6 @@ static inline void synchronize_rcu_expedited(void)
 	synchronize_rcu();
 }
 
-/*
- * Add one more declaration of kvfree() here. It is
- * not so straight forward to just include <linux/mm.h>
- * where it is defined due to getting many compile
- * errors caused by that include.
- */
-extern void kvfree(const void *addr);
-
-static inline void __kvfree_call_rcu(struct rcu_head *head, void *ptr)
-{
-	if (head) {
-		call_rcu(head, (rcu_callback_t) ((void *) head - ptr));
-		return;
-	}
-
-	// kvfree_rcu(one_arg) call.
-	might_sleep();
-	synchronize_rcu();
-	kvfree(ptr);
-}
-
-static inline void kvfree_rcu_barrier(void)
-{
-	rcu_barrier();
-}
-
-#ifdef CONFIG_KASAN_GENERIC
-void kvfree_call_rcu(struct rcu_head *head, void *ptr);
-#else
-static inline void kvfree_call_rcu(struct rcu_head *head, void *ptr)
-{
-	__kvfree_call_rcu(head, ptr);
-}
-#endif
-
 void rcu_qs(void);
 
 static inline void rcu_softirq_qs(void)
@@ -164,7 +129,6 @@ static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
 static inline void rcu_momentary_eqs(void) { }
-static inline void kfree_rcu_scheduler_running(void) { }
 
 /* Avoid RCU read-side critical sections leaking across. */
 static inline void rcu_all_qs(void) { barrier(); }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 27d86d9127817e50f8d4dd79e1990d70a02435bb..dbe77b5fe06ec89a393b5444d6c479ced346a37b 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -34,12 +34,9 @@ static inline void rcu_virt_note_context_switch(void)
 }
 
 void synchronize_rcu_expedited(void);
-void kvfree_call_rcu(struct rcu_head *head, void *ptr);
-void kvfree_rcu_barrier(void);
 
 void rcu_barrier(void);
 void rcu_momentary_eqs(void);
-void kfree_rcu_scheduler_running(void);
 
 struct rcu_gp_oldstate {
 	unsigned long rgos_norm;
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 09eedaecf1205672bb2e7c8cd57ae8fccebc2737..bcc62e5656c35c6a3f4caf26fb33d7447dead39a 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -16,6 +16,7 @@
 #include <linux/gfp.h>
 #include <linux/overflow.h>
 #include <linux/types.h>
+#include <linux/rcupdate.h>
 #include <linux/workqueue.h>
 #include <linux/percpu-refcount.h>
 #include <linux/cleanup.h>
@@ -1082,6 +1083,19 @@ extern void kvfree_sensitive(const void *addr, size_t len);
 
 unsigned int kmem_cache_size(struct kmem_cache *s);
 
+#ifdef CONFIG_TINY_RCU
+static inline void kvfree_rcu_barrier(void)
+{
+	rcu_barrier();
+}
+
+static inline void kfree_rcu_scheduler_running(void) { }
+#else
+void kvfree_rcu_barrier(void);
+
+void kfree_rcu_scheduler_running(void);
+#endif
+
 /**
  * kmalloc_size_roundup - Report allocation bucket size for the given size
  *
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 4b3f319114650d372d490919669a2a9e248e731d..0ec27093d0e14a4b1060ea08932c4ac13f9b0f26 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -246,17 +246,6 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
 }
 EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
 
-#ifdef CONFIG_KASAN_GENERIC
-void kvfree_call_rcu(struct rcu_head *head, void *ptr)
-{
-	if (head)
-		kasan_record_aux_stack(ptr);
-
-	__kvfree_call_rcu(head, ptr);
-}
-EXPORT_SYMBOL_GPL(kvfree_call_rcu);
-#endif
-
 void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 4030907b6b7d89adcf62c70e82e95c8deb41adba..81a0ce77b11c2ef8db9164cdca5853069402f161 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1284,6 +1284,25 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
 EXPORT_TRACEPOINT_SYMBOL(kfree);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
 
+#ifdef CONFIG_TINY_RCU
+
+void kvfree_call_rcu(struct rcu_head *head, void *ptr)
+{
+	if (head) {
+		kasan_record_aux_stack(ptr);
+		call_rcu(head, (rcu_callback_t) ((void *) head - ptr));
+		return;
+	}
+
+	// kvfree_rcu(one_arg) call.
+	might_sleep();
+	synchronize_rcu();
+	kvfree(ptr);
+}
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
+
+#endif
+
 /*
  * This rcu parameter is runtime-read-only. It reflects
  * a minimum allowed number of objects which can be cached

-- 
2.48.1

