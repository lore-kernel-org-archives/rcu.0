Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FAF20127F
	for <rcu@vger.kernel.org>; Thu, 23 Jan 2025 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628680; cv=none; b=PbPG6awy6QS1dG3V8nncNHq+heAfEHgqOipiQVX6Xyemabhxb02PcmzeE7+BImC58LhCN8Zudu4p7z/uncdE+tH+0KPdkQjaS2lPlVSQymyx0MpjK1PxeyP22G2EVpYMqiBMNdJlwgEYCwW+R4wqz9uOlhGa2MFVQyx5ueZz8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628680; c=relaxed/simple;
	bh=V3CDNBQ65RoS8BNy/YQECuCfUSQlpxlHN6MkeKNjSZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iThVq1OuVKkDhrHfY+1N5dQTIOnjNFXO/Ce3wqdh4Rm/e4qljDYTym4jnUQClXlRrGNoTErqQnL/dwgOObzDw2kWeTwfPtvBWWuRt8puPXfYsAGUNSdW4HpBz9PzlQunnGoOqE+790H/hf7nRF1JEc0HerlsPd6IG1xvpdMUkE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hz8qowaP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yOpvhHOx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hz8qowaP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yOpvhHOx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hz8qowaP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yOpvhHOx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hz8qowaP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yOpvhHOx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 391CD2117D;
	Thu, 23 Jan 2025 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737628676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3re1HhaNJ7ult5EVdCJjMXAxd3DND62tEqbEIKH98g=;
	b=Hz8qowaPTUkggcfEOrGEszBiecjRHVJlrmCZNgrSyPprj+Zuiha7KX00JQvdMpeqxW+RMZ
	LV8NoOAG3sDGDylHf00TH1AQzw5Tcnqeqeh4ckhzI+/R+Yu85QlKye62CeJyqaw9W470Q+
	d+eOvrweI1PAERjSOZIrvxmsxaJl78w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737628676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3re1HhaNJ7ult5EVdCJjMXAxd3DND62tEqbEIKH98g=;
	b=yOpvhHOxTivTJkIIsCrFTvfOSaFb9/7Xab6dbAq6LINQzThBwm2xq9ORa34U1t/90zu3z1
	ULPHOVu9wJ8DoTCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737628676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3re1HhaNJ7ult5EVdCJjMXAxd3DND62tEqbEIKH98g=;
	b=Hz8qowaPTUkggcfEOrGEszBiecjRHVJlrmCZNgrSyPprj+Zuiha7KX00JQvdMpeqxW+RMZ
	LV8NoOAG3sDGDylHf00TH1AQzw5Tcnqeqeh4ckhzI+/R+Yu85QlKye62CeJyqaw9W470Q+
	d+eOvrweI1PAERjSOZIrvxmsxaJl78w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737628676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3re1HhaNJ7ult5EVdCJjMXAxd3DND62tEqbEIKH98g=;
	b=yOpvhHOxTivTJkIIsCrFTvfOSaFb9/7Xab6dbAq6LINQzThBwm2xq9ORa34U1t/90zu3z1
	ULPHOVu9wJ8DoTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19F5B13A51;
	Thu, 23 Jan 2025 10:37:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sHsPBgQckmdrAQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Jan 2025 10:37:56 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 23 Jan 2025 11:37:18 +0100
Subject: [PATCH RFC 1/4] slab, rcu: move TINY_RCU variant of kvfree_rcu()
 to SLAB
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-slub-tiny-kfree_rcu-v1-1-0e386ef1541a@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6322; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=V3CDNBQ65RoS8BNy/YQECuCfUSQlpxlHN6MkeKNjSZU=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBnkhv5HlHabD5/rYKLN4U4Y8eOLgNzVkyqBNRv/
 UW7L9RMLCWJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZ5Ib+QAKCRC74LB10kWI
 mmYXB/9NvbzObEFhfbeTeuiQh79OGIklwhK5mw1vivzIcgBKy/VoEuNPD2Q4EOY/2UDY8h8SOGb
 pk3ZUdjfO4GihAALiwwjpLYGwIDshktM3PYExu0souNPXsg6yi2q+bxJWA0um9+wL8K+ap1EYNJ
 oxEY74VfDKXszUz8vloXNiDa/N2KVxtMnOQQVEm5mie27HXlLtxhmy3RR3z+Rp6HYnKTtGNklX4
 tjn5h34+NQKbNv2NvkKTI/0Nvmhle3j51IjmFwYELB/fQCoy0O9CgofE6WHjLdBAOtaH14N2rJY
 +Cdm3tVWyQJrn6JStD8UT7XKepFvp/mV/e4dfJcoJGPewXJh
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Following the move of TREE_RCU implementation, let's move also the
TINY_RCU one for consistency and subsequent refactoring.

For simplicity, remove the separate inline __kvfree_call_rcu() as
TINY_RCU is not meant for high-performance hardware anyway.

Declare kvfree_call_rcu() in rcupdate.h to avoid header dependency
issues.

Also move the kvfree_rcu_barrier() declaration to slab.h

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/rcupdate.h |  5 +++++
 include/linux/rcutiny.h  | 36 ------------------------------------
 include/linux/rcutree.h  |  3 ---
 include/linux/slab.h     | 14 ++++++++++++++
 kernel/rcu/tiny.c        | 11 -----------
 mm/slab_common.c         | 20 ++++++++++++++++++--
 6 files changed, 37 insertions(+), 52 deletions(-)

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
index b3b3ce34df6310f7bddba40b2be1bdf6c9f00232..0ec27093d0e14a4b1060ea08932c4ac13f9b0f26 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -246,17 +246,6 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
 }
 EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
 
-#ifdef CONFIG_KASAN_GENERIC
-void kvfree_call_rcu(struct rcu_head *head, void *ptr)
-{
-	if (head)
-		kasan_record_aux_stack_noalloc(ptr);
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
index 69f2d19010dedaa3e5b303ab9803c8cdd40152fa..330cdd8ebc5380090ee784c58e8ca1d1a52b3758 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1861,7 +1861,23 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 	return true;
 }
 
-#if !defined(CONFIG_TINY_RCU)
+#ifdef CONFIG_TINY_RCU
+
+void kvfree_call_rcu(struct rcu_head *head, void *ptr)
+{
+	if (head) {
+		kasan_record_aux_stack_noalloc(ptr);
+		call_rcu(head, (rcu_callback_t) ((void *) head - ptr));
+		return;
+	}
+
+	// kvfree_rcu(one_arg) call.
+	might_sleep();
+	synchronize_rcu();
+	kvfree(ptr);
+}
+
+#else /* !CONFIG_TINY_RCU */
 
 static enum hrtimer_restart
 schedule_page_work_fn(struct hrtimer *t)
@@ -2071,7 +2087,7 @@ void kvfree_rcu_barrier(void)
 }
 EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
 
-#endif /* #if !defined(CONFIG_TINY_RCU) */
+#endif /* !CONFIG_TINY_RCU */
 
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)

-- 
2.48.1

