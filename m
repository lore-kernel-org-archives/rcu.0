Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04EB13A894;
	Mon, 15 Jul 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075382; cv=none; b=ITg3FvuC61GySBldZQAZgTdpioB9WwkehtWQsO86K8aOmjrH8eaX4YxaP44IdnltQH8122RJaVZIdzLaJguqJBguPrJKBQ3DJYglFKa7J7l/g2LlgkF8KDawbukD8KR286n9iO+for2zVPwjujkobCYCaM5lTD2snxv6k55SYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075382; c=relaxed/simple;
	bh=DaNAYpX5xu84JkV/5HzEJpjZPCw75MxTd+Du75FduB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoWP15i/CkU1MM3yxiOXjPpdSMijzIxocmVOYtw2Uct6W7ddZJpUIWbFdVr6zzO4QT8f4fURZjyclPIC89q75B10BHdNhjcQ1tgiTe9VURkSaD3nuFC//F09gN/bNGGq7PN/tpSXdgsp3Q9SHN0PwQx4kcaV2sK2e+HKynzzmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ANbEASdW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4eHOsmkR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ANbEASdW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4eHOsmkR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ANbEASdW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4eHOsmkR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ANbEASdW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4eHOsmkR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D58861F843;
	Mon, 15 Jul 2024 20:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721075378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyldqlnDVTk50xyhWcs4CPBsygxILHPWHa8A+BcY6BU=;
	b=ANbEASdWGMdwl5qIXdPygLN5quDOUggtjyZj/rdVEODhlm+iIA64uMIgVwJdDUCncYcZI/
	tNq53zYt3Ul/jLQpY+x02fL4MVwUY8mNk5iXoMQnwDUWRpXZfQyw2WHe5Tyltx22YZ/FyD
	08Qt9lzqZt5wXVKR6LmkjZKOBINn3gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721075378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyldqlnDVTk50xyhWcs4CPBsygxILHPWHa8A+BcY6BU=;
	b=4eHOsmkRnhgqg1SSKo/heKcjThC68ZpN46jp+qFZPiqyFx4W5r7bcXY6t1L+lrj+mOkH2t
	quc3a/glQGts+RAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721075378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyldqlnDVTk50xyhWcs4CPBsygxILHPWHa8A+BcY6BU=;
	b=ANbEASdWGMdwl5qIXdPygLN5quDOUggtjyZj/rdVEODhlm+iIA64uMIgVwJdDUCncYcZI/
	tNq53zYt3Ul/jLQpY+x02fL4MVwUY8mNk5iXoMQnwDUWRpXZfQyw2WHe5Tyltx22YZ/FyD
	08Qt9lzqZt5wXVKR6LmkjZKOBINn3gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721075378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyldqlnDVTk50xyhWcs4CPBsygxILHPWHa8A+BcY6BU=;
	b=4eHOsmkRnhgqg1SSKo/heKcjThC68ZpN46jp+qFZPiqyFx4W5r7bcXY6t1L+lrj+mOkH2t
	quc3a/glQGts+RAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B38921396E;
	Mon, 15 Jul 2024 20:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CBWUK7KGlWbvUwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Jul 2024 20:29:38 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 15 Jul 2024 22:29:28 +0200
Subject: [PATCH RFC 2/6] mm, slab: always maintain per-node slab and object
 count
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-slab-kfree_rcu-destroy-v1-2-46b2984c2205@suse.cz>
References: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz>
In-Reply-To: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz>
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
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.0
X-Spam-Flag: NO
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,efficios.com,gmail.com,inria.fr,kernel.org,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: *

Currently SLUB counts per-node slabs and total objects only with
CONFIG_SLUB_DEBUG, in order to minimize overhead. However, the detection
in __kmem_cache_shutdown() whether there are no outstanding object
relies on the per-node slab count (node_nr_slabs()) so it may be
unreliable without CONFIG_SLUB_DEBUG. Thus we might be failing to warn
about such situations, and instead destroy a cache while leaving its
slab(s) around (due to a buggy slab user creating such a scenario, not
in normal operation).

We will also need node_nr_slabs() to be reliable in the following work
to gracefully handle kmem_cache_destroy() with kfree_rcu() objects in
flight. Thus make the counting of per-node slabs and objects
unconditional.

Note that CONFIG_SLUB_DEBUG is the default anyway, and the counting is
done only when allocating or freeing a slab page, so even in
!CONFIG_SLUB_DEBUG configs the overhead should be negligible.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 49 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 829a1f08e8a2..aa4d80109c49 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -426,9 +426,9 @@ struct kmem_cache_node {
 	spinlock_t list_lock;
 	unsigned long nr_partial;
 	struct list_head partial;
-#ifdef CONFIG_SLUB_DEBUG
 	atomic_long_t nr_slabs;
 	atomic_long_t total_objects;
+#ifdef CONFIG_SLUB_DEBUG
 	struct list_head full;
 #endif
 };
@@ -438,6 +438,26 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
 	return s->node[node];
 }
 
+static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
+{
+	return atomic_long_read(&n->nr_slabs);
+}
+
+static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
+{
+	struct kmem_cache_node *n = get_node(s, node);
+
+	atomic_long_inc(&n->nr_slabs);
+	atomic_long_add(objects, &n->total_objects);
+}
+static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
+{
+	struct kmem_cache_node *n = get_node(s, node);
+
+	atomic_long_dec(&n->nr_slabs);
+	atomic_long_sub(objects, &n->total_objects);
+}
+
 /*
  * Iterator over all nodes. The body will be executed for each node that has
  * a kmem_cache_node structure allocated (which is true for all online nodes)
@@ -1511,26 +1531,6 @@ static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct
 	list_del(&slab->slab_list);
 }
 
-static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
-{
-	return atomic_long_read(&n->nr_slabs);
-}
-
-static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
-{
-	struct kmem_cache_node *n = get_node(s, node);
-
-	atomic_long_inc(&n->nr_slabs);
-	atomic_long_add(objects, &n->total_objects);
-}
-static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
-{
-	struct kmem_cache_node *n = get_node(s, node);
-
-	atomic_long_dec(&n->nr_slabs);
-	atomic_long_sub(objects, &n->total_objects);
-}
-
 /* Object debug checks for alloc/free paths */
 static void setup_object_debug(struct kmem_cache *s, void *object)
 {
@@ -1871,13 +1871,6 @@ slab_flags_t kmem_cache_flags(slab_flags_t flags, const char *name)
 
 #define disable_higher_order_debug 0
 
-static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
-							{ return 0; }
-static inline void inc_slabs_node(struct kmem_cache *s, int node,
-							int objects) {}
-static inline void dec_slabs_node(struct kmem_cache *s, int node,
-							int objects) {}
-
 #ifndef CONFIG_SLUB_TINY
 static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 			       void **freelist, void *nextfree)

-- 
2.45.2

