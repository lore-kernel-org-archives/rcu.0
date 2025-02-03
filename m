Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C31FF1DF
	for <rcu@vger.kernel.org>; Mon,  3 Feb 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574972; cv=none; b=TCwsQzdCliq5tKHHxL8YNUtR7f3l0U0olYPzlIZTI302TJnU98G8KOTPnRzv/Hu3AIGfRjOlCmIQz5uzWj86BfxLG0xodNDue5jbAJds/R2ltav1cWdcGzDpfHRRjEAM9fTpUeGtgAapoiYGkQFZBf54lOnExGb7xJJegXc4rbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574972; c=relaxed/simple;
	bh=ZX6gtQrEt7cCZomod7TWjlHECMqElE+cMispmYMdqbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbzFk+lr7Deq7wfLEIdyrLk1LsSNgp1Gd4KG4JzB5jSnGmam868l/HwHcr3RiKLXKCjVZFvMMRBOWYLwMHhKY4jUr/EAbvdD+klZwvmkI4AuFxTuYxkOJzzYh57jGJdAnAJ9rCDDbQPLeCt9dBnWMTsomZTHJTttlhq1GAfQXoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q8duSatx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=75aIMP8z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q8duSatx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=75aIMP8z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q8duSatx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="75aIMP8z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q8duSatx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="75aIMP8z"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C63E41F390;
	Mon,  3 Feb 2025 09:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738574968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yfyz0ZAEn2QjhNmCRRI5FUDzK79CGjs9vV8RXmH1IWk=;
	b=Q8duSatxg/eMFbaw3usssjoF/R3s1LZQB2gmoszRjhIDJ0xARMDziQM6EfuTNx/z2V2F2a
	yux0ImQ7l9HmxiklfR+DfbDZYWpr682JUP0AYMmK5CFR3AV7hPA6F/J1auZ885y3NPLW84
	aNKHwczb5Ljd6rU0+x+XaTTKZB+R/Co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738574968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yfyz0ZAEn2QjhNmCRRI5FUDzK79CGjs9vV8RXmH1IWk=;
	b=75aIMP8zWhDXAHwXMvr1+OC5RtRrMyfuu4vczuQ6Hpy6WEe1NPPNkqSyyZDYVJSJ6LlFOH
	QWQmkFsb7Aky08Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738574968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yfyz0ZAEn2QjhNmCRRI5FUDzK79CGjs9vV8RXmH1IWk=;
	b=Q8duSatxg/eMFbaw3usssjoF/R3s1LZQB2gmoszRjhIDJ0xARMDziQM6EfuTNx/z2V2F2a
	yux0ImQ7l9HmxiklfR+DfbDZYWpr682JUP0AYMmK5CFR3AV7hPA6F/J1auZ885y3NPLW84
	aNKHwczb5Ljd6rU0+x+XaTTKZB+R/Co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738574968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yfyz0ZAEn2QjhNmCRRI5FUDzK79CGjs9vV8RXmH1IWk=;
	b=75aIMP8zWhDXAHwXMvr1+OC5RtRrMyfuu4vczuQ6Hpy6WEe1NPPNkqSyyZDYVJSJ6LlFOH
	QWQmkFsb7Aky08Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC0B513A78;
	Mon,  3 Feb 2025 09:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IOy6KXiMoGfwYAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Feb 2025 09:29:28 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 03 Feb 2025 10:28:50 +0100
Subject: [PATCH 4/4] slab: don't batch kvfree_rcu() with SLUB_TINY
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-slub-tiny-kfree_rcu-v1-4-d4428bf9a8a1@suse.cz>
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
X-Spam-Score: -6.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

kvfree_rcu() is batched for better performance except on TINY_RCU, which
is a simple implementation for small UP systems. Similarly SLUB_TINY is
an option intended for small systems, whether or not used together with
TINY_RCU. In case SLUB_TINY is used with !TINY_RCU, it makes arguably
sense to not do the batching and limit the memory footprint. It's also
suboptimal to have RCU-specific #ifdefs in slab code.

With that, add CONFIG_KVFREE_RCU_BATCHED to determine whether batching
kvfree_rcu() implementation is used. It is not set by a user prompt, but
enabled by default and disabled in case TINY_RCU or SLUB_TINY are
enabled.

Use the new config for #ifdef's in slab code and extend their scope to
cover all code used by the batched kvfree_rcu(). For example there's no
need to perform kvfree_rcu_init() if the batching is disabled.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h |  2 +-
 mm/Kconfig           |  4 ++++
 mm/slab_common.c     | 15 +++++++++------
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index bcc62e5656c35c6a3f4caf26fb33d7447dead39a..7686054dd494cc65def7f58748718e03eb78e481 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1083,7 +1083,7 @@ extern void kvfree_sensitive(const void *addr, size_t len);
 
 unsigned int kmem_cache_size(struct kmem_cache *s);
 
-#ifdef CONFIG_TINY_RCU
+#ifndef CONFIG_KVFREE_RCU_BATCHED
 static inline void kvfree_rcu_barrier(void)
 {
 	rcu_barrier();
diff --git a/mm/Kconfig b/mm/Kconfig
index 1b501db064172cf54f1b1259893dfba676473c56..0b7f4bb5cb801c110aaa484ceae3063aa7204d29 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -242,6 +242,10 @@ menu "Slab allocator options"
 config SLUB
 	def_bool y
 
+config KVFREE_RCU_BATCHED
+	def_bool y
+	depends on !SLUB_TINY && !TINY_RCU
+
 config SLUB_TINY
 	bool "Configure for minimal memory footprint"
 	depends on EXPERT
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6438a38aa5dc2ede0b5afa04bc3fbff5a4697d87..46d0a4cd33b5982fd79c307d572f231fdea9514a 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1284,7 +1284,7 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
 EXPORT_TRACEPOINT_SYMBOL(kfree);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
 
-#ifdef CONFIG_TINY_RCU
+#ifndef CONFIG_KVFREE_RCU_BATCHED
 
 void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 {
@@ -1301,7 +1301,11 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
-#endif
+void __init kvfree_rcu_init(void)
+{
+}
+
+#else /* CONFIG_KVFREE_RCU_BATCHED */
 
 /*
  * This rcu parameter is runtime-read-only. It reflects
@@ -1879,8 +1883,6 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 	return true;
 }
 
-#if !defined(CONFIG_TINY_RCU)
-
 static enum hrtimer_restart
 schedule_page_work_fn(struct hrtimer *t)
 {
@@ -2089,8 +2091,6 @@ void kvfree_rcu_barrier(void)
 }
 EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
 
-#endif /* #if !defined(CONFIG_TINY_RCU) */
-
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -2180,3 +2180,6 @@ void __init kvfree_rcu_init(void)
 
 	shrinker_register(kfree_rcu_shrinker);
 }
+
+#endif /* CONFIG_KVFREE_RCU_BATCHED */
+

-- 
2.48.1

