Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A108F1DD391;
	Wed,  7 Aug 2024 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026704; cv=none; b=cV6x2+gDJVP1AmhR2YFao+NYg+lJwuNOCt68IWyZx3CclwzKcpTz0IzkK/7Y0WiVAYt5G+bGrowQyHRbE6yjHG5CsA/b72SWk34tTe8NHnRHAf294MGE+1LuhjRpQBdBtXCneVprct6QpFvYltcy72hFusV/OG1Q29b0kOrNehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026704; c=relaxed/simple;
	bh=SXToQPwiarLAnhHwZ8FG3NHd6oGUZrTgfGJR3Xw2jdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=td6d2AuBRxOF5eiUlLnEJ3GM3hUAaIlxJLRFI2JJn0zhJ9Sm2zPqO2U2uw0E6zLMUxn4loWAPHr5aPn+PKWMZR3NhGfv0jkEE6xAiPWeoRbVX8t7OOQzzfi46omrsGHq7Ojxshlk1NhAcfot0fziw/CjSWtRm+9DG+ZtaazCDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sXT1azEr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hd64V33C; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sXT1azEr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hd64V33C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sXT1azEr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hd64V33C";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sXT1azEr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hd64V33C"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4316B21CF3;
	Wed,  7 Aug 2024 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1qL27IVdY8UFaeKEjvymEDe/A+3RtrkI79ewzI2zdg=;
	b=sXT1azErC5SItYAr7d2Iuk/s5nav7pHXgOhxwwfhZpF9uISaP+xjVtcjuKPwr5m81SNCO2
	Z3/lsR4fIfLGYKPUFliujQZjaxSIk1BjhT/VIsyrovU8hwbOOAzt8ufqKbTQzbS/LU+n4W
	wGYJeSleY7ZJi4sQL0CMZq9JNxNL9Yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1qL27IVdY8UFaeKEjvymEDe/A+3RtrkI79ewzI2zdg=;
	b=hd64V33CKjwjSliPi0q8xdy7QfWL/ZqIaEGlov4D0Oi4o/JMxrydeuwFKww5/WHL3vuic3
	wshtwX3dxGS1QuBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1qL27IVdY8UFaeKEjvymEDe/A+3RtrkI79ewzI2zdg=;
	b=sXT1azErC5SItYAr7d2Iuk/s5nav7pHXgOhxwwfhZpF9uISaP+xjVtcjuKPwr5m81SNCO2
	Z3/lsR4fIfLGYKPUFliujQZjaxSIk1BjhT/VIsyrovU8hwbOOAzt8ufqKbTQzbS/LU+n4W
	wGYJeSleY7ZJi4sQL0CMZq9JNxNL9Yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1qL27IVdY8UFaeKEjvymEDe/A+3RtrkI79ewzI2zdg=;
	b=hd64V33CKjwjSliPi0q8xdy7QfWL/ZqIaEGlov4D0Oi4o/JMxrydeuwFKww5/WHL3vuic3
	wshtwX3dxGS1QuBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1631513B06;
	Wed,  7 Aug 2024 10:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uH8iBQZNs2YsHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 Aug 2024 10:31:34 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 07 Aug 2024 12:31:17 +0200
Subject: [PATCH v2 4/7] mm, slab: reintroduce rcu_barrier() into
 kmem_cache_destroy()
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-b4-slab-kfree_rcu-destroy-v2-4-ea79102f428c@suse.cz>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Joel Fernandes <joel@joelfernandes.org>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
 Jann Horn <jannh@google.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.1
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_TO(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,efficios.com,gmail.com,inria.fr,kernel.org,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,google.com,googlegroups.com,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLtsk3gtac773whqka7ht6mdi4)]
X-Spam-Flag: NO
X-Spam-Score: -2.80

There used to be a rcu_barrier() for SLAB_TYPESAFE_BY_RCU caches in
kmem_cache_destroy() until commit 657dc2f97220 ("slab: remove
synchronous rcu_barrier() call in memcg cache release path") moved it to
an asynchronous work that finishes the destroying of such caches.

The motivation for that commit was the MEMCG_KMEM integration that at
the time created and removed clones of the global slab caches together
with their cgroups, and blocking cgroups removal was unwelcome. The
implementation later changed to per-object memcg tracking using a single
cache, so there should be no more need for a fast non-blocking
kmem_cache_destroy(), which is typically only done when a module is
unloaded etc.

Going back to synchronous barrier has the following advantages:

- simpler implementation
- it's easier to test the result of kmem_cache_destroy() in a kunit test

Thus effectively revert commit 657dc2f97220. It is not a 1:1 revert as
the code has changed since. The main part is that kmem_cache_release(s)
is always called from kmem_cache_destroy(), but for SLAB_TYPESAFE_BY_RCU
caches there's a rcu_barrier() first.

Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 47 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index a079b8540334..c40227d5fa07 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -40,11 +40,6 @@ LIST_HEAD(slab_caches);
 DEFINE_MUTEX(slab_mutex);
 struct kmem_cache *kmem_cache;
 
-static LIST_HEAD(slab_caches_to_rcu_destroy);
-static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work);
-static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
-		    slab_caches_to_rcu_destroy_workfn);
-
 /*
  * Set of flags that will prevent slab merging
  */
@@ -499,33 +494,6 @@ static void kmem_cache_release(struct kmem_cache *s)
 		slab_kmem_cache_release(s);
 }
 
-static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
-{
-	LIST_HEAD(to_destroy);
-	struct kmem_cache *s, *s2;
-
-	/*
-	 * On destruction, SLAB_TYPESAFE_BY_RCU kmem_caches are put on the
-	 * @slab_caches_to_rcu_destroy list.  The slab pages are freed
-	 * through RCU and the associated kmem_cache are dereferenced
-	 * while freeing the pages, so the kmem_caches should be freed only
-	 * after the pending RCU operations are finished.  As rcu_barrier()
-	 * is a pretty slow operation, we batch all pending destructions
-	 * asynchronously.
-	 */
-	mutex_lock(&slab_mutex);
-	list_splice_init(&slab_caches_to_rcu_destroy, &to_destroy);
-	mutex_unlock(&slab_mutex);
-
-	if (list_empty(&to_destroy))
-		return;
-
-	rcu_barrier();
-
-	list_for_each_entry_safe(s, s2, &to_destroy, list)
-		kmem_cache_release(s);
-}
-
 void slab_kmem_cache_release(struct kmem_cache *s)
 {
 	__kmem_cache_release(s);
@@ -535,7 +503,6 @@ void slab_kmem_cache_release(struct kmem_cache *s)
 
 void kmem_cache_destroy(struct kmem_cache *s)
 {
-	bool rcu_set;
 	int err;
 
 	if (unlikely(!s) || !kasan_check_byte(s))
@@ -551,8 +518,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
 		return;
 	}
 
-	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
-
 	/* free asan quarantined objects */
 	kasan_cache_shutdown(s);
 
@@ -572,14 +537,10 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (err)
 		return;
 
-	if (rcu_set) {
-		mutex_lock(&slab_mutex);
-		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
-		schedule_work(&slab_caches_to_rcu_destroy_work);
-		mutex_unlock(&slab_mutex);
-	} else {
-		kmem_cache_release(s);
-	}
+	if (s->flags & SLAB_TYPESAFE_BY_RCU)
+		rcu_barrier();
+
+	kmem_cache_release(s);
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
 

-- 
2.46.0

