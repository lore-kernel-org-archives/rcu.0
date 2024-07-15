Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056B13AD05;
	Mon, 15 Jul 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075383; cv=none; b=jljFzPJJnqdHcAyakdfoVJ6V5oRqCJH+EGgMBJip5yNyqFJsunwjkJNNh1TNVzK1/zxRwZTrzRAHIyCIVPiVXphz/3WgLdw0E55WaVec9Tu9Fvmw65nb9gbobBGch2QCZvGoPOxFHsq9tup6KC2WRtFvmk11927AT6cCzJiNmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075383; c=relaxed/simple;
	bh=P4cRW+V8KEu1xtPeEzW27Bl2ZFgYCGfSZwxSULCAcRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/oenoJoMipaFBU1qFiNTyiWQfNJHeQooKVZ2zb0qjNw1FLzAK8UMYfLcUGsi6EJd3pTlcK9yrHsvdIeLaOCWQrNN0xp1CIXWYyUQ6AVh0QpbudFFuq609jnsBwaQQXoNpJv0CC0HYvrfIYdnPU5sU0ogGDClAc0S5zzVD44LnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pbG0llnr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=97BjocNX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pbG0llnr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=97BjocNX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pbG0llnr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="97BjocNX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pbG0llnr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="97BjocNX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 350E221BCF;
	Mon, 15 Jul 2024 20:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721075379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5NdmWuv3Hvepg9STEhFTiZ7iZ+qzw7pFNvQWY9q/Os=;
	b=pbG0llnr/a+hFS/aFYyY7iQhUo9J3Wd8lOWvT1qWA9/XkF+qfpvwM//mHrWFKSTPxhXVEe
	zbwxz4zS8s/7SSuWKiw2wR23oMVa/QOGGzCmFoCeaXeLcrBVQrCw9TeP3gyEjSiP6Xax+a
	oBM6hahMKNsMzEDYtO0hstWCtbwQ084=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721075379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5NdmWuv3Hvepg9STEhFTiZ7iZ+qzw7pFNvQWY9q/Os=;
	b=97BjocNXuZryya7AfWUdPflgXoUPJtywDuTsx6AhZ3hrUWAHocxKNhe1/FtxgkiAol+Mmj
	mG/gcI85urtW8DBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721075379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5NdmWuv3Hvepg9STEhFTiZ7iZ+qzw7pFNvQWY9q/Os=;
	b=pbG0llnr/a+hFS/aFYyY7iQhUo9J3Wd8lOWvT1qWA9/XkF+qfpvwM//mHrWFKSTPxhXVEe
	zbwxz4zS8s/7SSuWKiw2wR23oMVa/QOGGzCmFoCeaXeLcrBVQrCw9TeP3gyEjSiP6Xax+a
	oBM6hahMKNsMzEDYtO0hstWCtbwQ084=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721075379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5NdmWuv3Hvepg9STEhFTiZ7iZ+qzw7pFNvQWY9q/Os=;
	b=97BjocNXuZryya7AfWUdPflgXoUPJtywDuTsx6AhZ3hrUWAHocxKNhe1/FtxgkiAol+Mmj
	mG/gcI85urtW8DBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13E72137EB;
	Mon, 15 Jul 2024 20:29:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YBKJBLOGlWbvUwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Jul 2024 20:29:39 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 15 Jul 2024 22:29:31 +0200
Subject: [PATCH RFC 5/6] mm, slab: asynchronously destroy caches with
 outstanding objects
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-slab-kfree_rcu-destroy-v1-5-46b2984c2205@suse.cz>
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
	RCPT_COUNT_TWELVE(0.00)[21];
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

We would like to replace call_rcu() users with kfree_rcu() where the
existing callback is just a kmem_cache_free(). However this causes
issues when the cache can be destroyed (such as due to module unload).

Currently such modules should be issuing rcu_barrier() before
kmem_cache_destroy() to have their call_rcu() callbacks processed first.
This barrier is however not sufficient for kfree_rcu() in flight due
to the batching introduced by a35d16905efc ("rcu: Add basic support for
kfree_rcu() batching").

This is not a problem for kmalloc caches which are never destroyed, but
since removing SLOB, kfree_rcu() is allowed also for any other cache,
that might be destroyed.

In order not to complicate the API, put the responsibility for handling
outstanding kfree_rcu() in kmem_cache_destroy() itself. Use the result
of __kmem_cache_shutdown() to determine if there are still allocated
objects in the cache, and if there are, assume it's due to kfree_rcu().
In that case schedule a work item that will use the appropriate barrier
and then attempt __kmem_cache_shutdown() again. Only if that fails as
well, produce the usual warning about non-freed objects.

Sysfs and debugs directories are removed immediately, so the cache can
be recreated with the same name without issues, while the previous
instance is still pending removal.

Users of call_rcu() with arbitrary callbacks should still perform their
own synchronous barrier before destroying the cache and unloading the
module, as the callbacks may be invoking module code or perform other
actions that are necessary for a successful unload.

Note that another non-bug reason why there might be objects outstanding
is the kasan quarantine. In that case the cleanup also becomes
asynchronous, and flushing the quarantine by kasan_cache_shutdown(s) is
only done in the workfn.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h        |  4 +++-
 mm/slab_common.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++----
 mm/slub.c        |  9 +++++----
 3 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index ece18ef5dd04..390a4e265f03 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -279,6 +279,8 @@ struct kmem_cache {
 	unsigned int red_left_pad;	/* Left redzone padding size */
 	const char *name;		/* Name (only for display!) */
 	struct list_head list;		/* List of slab caches */
+	struct work_struct async_destroy_work;
+
 #ifdef CONFIG_SYSFS
 	struct kobject kobj;		/* For sysfs */
 #endif
@@ -478,7 +480,7 @@ static inline bool is_kmalloc_cache(struct kmem_cache *s)
 			      SLAB_NO_USER_FLAGS)
 
 bool __kmem_cache_empty(struct kmem_cache *);
-int __kmem_cache_shutdown(struct kmem_cache *);
+int __kmem_cache_shutdown(struct kmem_cache *, bool);
 void __kmem_cache_release(struct kmem_cache *);
 int __kmem_cache_shrink(struct kmem_cache *);
 void slab_kmem_cache_release(struct kmem_cache *);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 57962e1a5a86..3e15525819b6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -44,6 +44,8 @@ static LIST_HEAD(slab_caches_to_rcu_destroy);
 static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work);
 static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
 		    slab_caches_to_rcu_destroy_workfn);
+static void kmem_cache_kfree_rcu_destroy_workfn(struct work_struct *work);
+
 
 /*
  * Set of flags that will prevent slab merging
@@ -235,6 +237,7 @@ static struct kmem_cache *create_cache(const char *name,
 
 	s->refcount = 1;
 	list_add(&s->list, &slab_caches);
+	INIT_WORK(&s->async_destroy_work, kmem_cache_kfree_rcu_destroy_workfn);
 	return s;
 
 out_free_cache:
@@ -535,6 +538,47 @@ void slab_kmem_cache_release(struct kmem_cache *s)
 	kmem_cache_free(kmem_cache, s);
 }
 
+static void kmem_cache_kfree_rcu_destroy_workfn(struct work_struct *work)
+{
+	struct kmem_cache *s;
+	bool rcu_set;
+	int err;
+
+	s = container_of(work, struct kmem_cache, async_destroy_work);
+
+	// XXX use the real kmem_cache_free_barrier() or similar thing here
+	rcu_barrier();
+
+	cpus_read_lock();
+	mutex_lock(&slab_mutex);
+
+	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
+
+	/* free asan quarantined objects */
+	kasan_cache_shutdown(s);
+
+	err = __kmem_cache_shutdown(s, true);
+	WARN(err, "kmem_cache_destroy %s: Slab cache still has objects",
+	     s->name);
+
+	if (err)
+		goto out_unlock;
+
+	list_del(&s->list);
+
+	if (rcu_set) {
+		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
+		schedule_work(&slab_caches_to_rcu_destroy_work);
+	}
+
+out_unlock:
+	mutex_unlock(&slab_mutex);
+	cpus_read_unlock();
+
+	if (!err && !rcu_set)
+		kmem_cache_release(s);
+}
+
 void kmem_cache_destroy(struct kmem_cache *s)
 {
 	bool rcu_set;
@@ -558,9 +602,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	/* free asan quarantined objects */
 	kasan_cache_shutdown(s);
 
-	err = __kmem_cache_shutdown(s);
-	WARN(err, "%s %s: Slab cache still has objects when called from %pS",
-	     __func__, s->name, (void *)_RET_IP_);
+	err = __kmem_cache_shutdown(s, false);
 
 	if (!err)
 		list_del(&s->list);
@@ -573,8 +615,10 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	}
 	debugfs_slab_release(s);
 
-	if (err)
+	if (err) {
+		schedule_work(&s->async_destroy_work);
 		return;
+	}
 
 	if (rcu_set) {
 		mutex_lock(&slab_mutex);
diff --git a/mm/slub.c b/mm/slub.c
index aa4d80109c49..c1222467c346 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5352,7 +5352,8 @@ static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
  * This is called from __kmem_cache_shutdown(). We must take list_lock
  * because sysfs file might still access partial list after the shutdowning.
  */
-static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
+static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n,
+			 bool warn_inuse)
 {
 	LIST_HEAD(discard);
 	struct slab *slab, *h;
@@ -5363,7 +5364,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 		if (!slab->inuse) {
 			remove_partial(n, slab);
 			list_add(&slab->slab_list, &discard);
-		} else {
+		} else if (warn_inuse) {
 			list_slab_objects(s, slab,
 			  "Objects remaining in %s on __kmem_cache_shutdown()");
 		}
@@ -5388,7 +5389,7 @@ bool __kmem_cache_empty(struct kmem_cache *s)
 /*
  * Release all resources used by a slab cache.
  */
-int __kmem_cache_shutdown(struct kmem_cache *s)
+int __kmem_cache_shutdown(struct kmem_cache *s, bool warn_inuse)
 {
 	int node;
 	struct kmem_cache_node *n;
@@ -5396,7 +5397,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	flush_all_cpus_locked(s);
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
-		free_partial(s, n);
+		free_partial(s, n, warn_inuse);
 		if (n->nr_partial || node_nr_slabs(n))
 			return 1;
 	}

-- 
2.45.2

