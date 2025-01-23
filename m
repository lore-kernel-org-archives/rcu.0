Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7F920D4F4
	for <rcu@vger.kernel.org>; Thu, 23 Jan 2025 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628681; cv=none; b=mJKdAo2twHxSH9HH0msOYuSh1Yr1DPGIrUn5JjEx7QICZnZPrrwmh8b4pCeHj2y3l05MfVfwilXBg/Mehge91g4kEdW/P6qY/zPFvo/bJgecuMWc3zHKFUTIZ1LBk+QwpMynJ0+/jpF2VQo5i3SJgwQhKgFyl0tAomrQriG8ey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628681; c=relaxed/simple;
	bh=2rhWfguSgm3rCjGx5bIjjhtFSjU4v/3Sg/+BOOfL7Eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XvV06KsXmemB2du+L0OL5l65hGgOdOYcKBYJBy7K7Wm0eQI6ECLJnt3aT0hpESPDeLMKHMEcZBpDf/6sWFO1WWbHvIdz11oxj3y6R1hz8dWiTKWhumARqJsTYiZQSdcmnEpjZOKTB50KCAcZKUplnaWikLhyDWpnGsMuSlydBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E1421F38C;
	Thu, 23 Jan 2025 10:37:56 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66BEE136A1;
	Thu, 23 Jan 2025 10:37:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cBjSGAQckmdrAQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Jan 2025 10:37:56 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 23 Jan 2025 11:37:21 +0100
Subject: [PATCH RFC 4/4] slab: don't batch kvfree_rcu() with SLUB_TINY
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-slub-tiny-kfree_rcu-v1-4-0e386ef1541a@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3787; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=2rhWfguSgm3rCjGx5bIjjhtFSjU4v/3Sg/+BOOfL7Eo=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBnkhwBZZrvN3xrjWEE5R0q5c5uyHyaO6141n+Pt
 VpRWGoQd/qJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZ5IcAQAKCRC74LB10kWI
 mimFB/9iIoogv+10l0+P5335y9cW2V1fDBnT4BAFsftyWIlYMy6+BAK2pDqBePJdg5UOgEmSC3u
 dpsuw6cicMFvMLdmuNNgIB7jD0rX2vjQI9Q6TFpwDJW8MFgr85+c3/jesi40ihe8suwsv0uedHQ
 GOmLBikFf/xFxleq5oXTj6GhmdV82aobIrz+gMXc5aDP7+HjmIzjDJCUtJWb4MVVLrCNB8lfrNr
 3bU8tPhGbyLjYuQv2jzKjdnM26rGPFlLPoFinwjayQ1IJSVA+wePpQGlnkrNZSOEf1lQ/JzYM1d
 /x27eZhMmwYu4rbKBHVaU+QfAz+KUiKGsRok7XaPXclI1R4O
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 8E1421F38C
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

kvfree_rcu() is batched for better performance except on TINY_RCU, which
is a simple implementation for small UP systems. Similarly SLUB_TINY is
an option intended for small systems, whether or not used together with
TINY_RCU. In case SLUB_TINY is used with !TINY_RCU, it makes arguably
sense to not do the batching and limit the memory footprint. It's also
suboptimal to have RCU-specific #ifdefs in slab code.

With that, add CONFIG_KFREE_RCU_BATCHED to determine whether batching
kvfree_rcu() implementation is used. It is not set by a user prompt, but
enabled by default and disabled in case TINY_RCU or SLUB_TINY are
enabled.

Use the new config for #ifdef's in slab code and extend their scope to
cover all code used by the batched kvfree_rcu(). For example there's no
need to perform kvfree_rcu_init() if the batching is disabled.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h |  2 +-
 mm/Kconfig           |  4 ++++
 mm/slab_common.c     | 45 +++++++++++++++++++++++++--------------------
 3 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index bcc62e5656c35c6a3f4caf26fb33d7447dead39a..9faf33734a8eee2425b90e679c0457ab459422a3 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1083,7 +1083,7 @@ extern void kvfree_sensitive(const void *addr, size_t len);
 
 unsigned int kmem_cache_size(struct kmem_cache *s);
 
-#ifdef CONFIG_TINY_RCU
+#ifndef CONFIG_KFREE_RCU_BATCHED
 static inline void kvfree_rcu_barrier(void)
 {
 	rcu_barrier();
diff --git a/mm/Kconfig b/mm/Kconfig
index 84000b01680869801a10f56f06d0c43d6521a8d2..e513308a4aed640ee556ecb5793c7f3f195bbcae 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -242,6 +242,10 @@ menu "Slab allocator options"
 config SLUB
 	def_bool y
 
+config KFREE_RCU_BATCHED
+	def_bool y
+	depends on !SLUB_TINY && !TINY_RCU
+
 config SLUB_TINY
 	bool "Configure for minimal memory footprint"
 	depends on EXPERT
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f13d2c901daf1419993620459fbd5845eecb85f1..9f6d66313afc6684bdc0f32908fe01c83c60f283 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1284,6 +1284,28 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
 EXPORT_TRACEPOINT_SYMBOL(kfree);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
 
+#ifndef CONFIG_KFREE_RCU_BATCHED
+
+void kvfree_call_rcu(struct rcu_head *head, void *ptr)
+{
+	if (head) {
+		kasan_record_aux_stack_noalloc(ptr);
+		call_rcu(head, kvfree_rcu_cb);
+		return;
+	}
+
+	// kvfree_rcu(one_arg) call.
+	might_sleep();
+	synchronize_rcu();
+	kvfree(ptr);
+}
+
+void __init kvfree_rcu_init(void)
+{
+}
+
+#else /* CONFIG_KFREE_RCU_BATCHED */
+
 /*
  * This rcu parameter is runtime-read-only. It reflects
  * a minimum allowed number of objects which can be cached
@@ -1858,24 +1880,6 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 	return true;
 }
 
-#ifdef CONFIG_TINY_RCU
-
-void kvfree_call_rcu(struct rcu_head *head, void *ptr)
-{
-	if (head) {
-		kasan_record_aux_stack_noalloc(ptr);
-		call_rcu(head, kvfree_rcu_cb);
-		return;
-	}
-
-	// kvfree_rcu(one_arg) call.
-	might_sleep();
-	synchronize_rcu();
-	kvfree(ptr);
-}
-
-#else /* !CONFIG_TINY_RCU */
-
 static enum hrtimer_restart
 schedule_page_work_fn(struct hrtimer *t)
 {
@@ -2084,8 +2088,6 @@ void kvfree_rcu_barrier(void)
 }
 EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
 
-#endif /* !CONFIG_TINY_RCU */
-
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -2175,3 +2177,6 @@ void __init kvfree_rcu_init(void)
 
 	shrinker_register(kfree_rcu_shrinker);
 }
+
+#endif /* CONFIG_KFREE_RCU_BATCHED */
+

-- 
2.48.1

