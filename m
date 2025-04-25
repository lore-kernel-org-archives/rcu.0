Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB72367A1
	for <rcu@vger.kernel.org>; Fri, 25 Apr 2025 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569693; cv=none; b=SCoXrNEKqdGZSMTnDyS/mR8e5/u/PEuk/+otAECt+wYX5y785X5HXtEFOYxFRvB9NFaH2VCj8F4MzcWfzrnzAz8a2u3NOB5bIB7eLmWpChfguiEYkK61Z6OkJQ+7MPvIATg0oVwvZDl6jFaO3DpRbsEioeULwdd+eEYIWa6lBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569693; c=relaxed/simple;
	bh=yB5Qsupcz0fxdbNv9H/qgpIBrDab5OU/fAKXs0hQRfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cjKJOaoxW/lcCssPqXX+YgDayGbdi/mo7Z4W1fVJeZg66Qn5MgAOQby/FFkioa8zt8o+NaNa2YyMEFBzAKnPW40yVBrsDHaXIgWV6SG8NEaJ9YDrjJUopTm7p7sY6C8n1hdqjlS9LF0uN7Sq225yrVeOT8Nhe/irK7eMV8fRALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A6CC21168;
	Fri, 25 Apr 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 034EC13A8B;
	Fri, 25 Apr 2025 08:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SMqDAIlHC2htfwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Apr 2025 08:27:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 25 Apr 2025 10:27:25 +0200
Subject: [PATCH v4 5/9] tools: Add testing support for changes to rcu and
 slab for sheaves
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-slub-percpu-caches-v4-5-8a636982b4a4@suse.cz>
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
In-Reply-To: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz, 
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>
X-Mailer: b4 0.14.2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 1A6CC21168
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Make testing work for the slab and rcu changes that have come in with
the sheaves work.

This only works with one kmem_cache, and only the first one used.
Subsequent setting of kmem_cache will not update the active kmem_cache
and will be silently dropped because there are other tests which happen
after the kmem_cache of interest is set.

The saved active kmem_cache is used in the rcu callback, which passes
the object to be freed.

The rcu call takes the rcu_head, which is passed in as the field in the
struct (in this case rcu in the maple tree node), which is calculated by
pointer math.  The offset of which is saved (in a global variable) for
restoring the node pointer on the callback after the rcu grace period
expires.

Don't use any of this outside of testing, please.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/include/linux/slab.h            | 41 ++++++++++++++++++++++++++++++++---
 tools/testing/shared/linux.c          | 24 ++++++++++++++++----
 tools/testing/shared/linux/rcupdate.h | 22 +++++++++++++++++++
 3 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index c87051e2b26f5a7fee0362697fae067076b8e84d..d1444e79f2685edb828adbce8b3fbb500c0f8844 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -23,6 +23,12 @@ enum slab_state {
 	FULL
 };
 
+struct kmem_cache_args {
+	unsigned int align;
+	unsigned int sheaf_capacity;
+	void (*ctor)(void *);
+};
+
 static inline void *kzalloc(size_t size, gfp_t gfp)
 {
 	return kmalloc(size, gfp | __GFP_ZERO);
@@ -37,9 +43,38 @@ static inline void *kmem_cache_alloc(struct kmem_cache *cachep, int flags)
 }
 void kmem_cache_free(struct kmem_cache *cachep, void *objp);
 
-struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
-			unsigned int align, unsigned int flags,
-			void (*ctor)(void *));
+
+struct kmem_cache *
+__kmem_cache_create_args(const char *name, unsigned int size,
+		struct kmem_cache_args *args, unsigned int flags);
+
+/* If NULL is passed for @args, use this variant with default arguments. */
+static inline struct kmem_cache *
+__kmem_cache_default_args(const char *name, unsigned int size,
+		struct kmem_cache_args *args, unsigned int flags)
+{
+	struct kmem_cache_args kmem_default_args = {};
+
+	return __kmem_cache_create_args(name, size, &kmem_default_args, flags);
+}
+
+static inline struct kmem_cache *
+__kmem_cache_create(const char *name, unsigned int size, unsigned int align,
+		unsigned int flags, void (*ctor)(void *))
+{
+	struct kmem_cache_args kmem_args = {
+		.align	= align,
+		.ctor	= ctor,
+	};
+
+	return __kmem_cache_create_args(name, size, &kmem_args, flags);
+}
+
+#define kmem_cache_create(__name, __object_size, __args, ...)           \
+	_Generic((__args),                                              \
+		struct kmem_cache_args *: __kmem_cache_create_args,	\
+		void *: __kmem_cache_default_args,			\
+		default: __kmem_cache_create)(__name, __object_size, __args, __VA_ARGS__)
 
 void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list);
 int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
index 0f97fb0d19e19c327aa4843a35b45cc086f4f366..f998555a1b2af4a899a468a652b04622df459ed3 100644
--- a/tools/testing/shared/linux.c
+++ b/tools/testing/shared/linux.c
@@ -20,6 +20,7 @@ struct kmem_cache {
 	pthread_mutex_t lock;
 	unsigned int size;
 	unsigned int align;
+	unsigned int sheaf_capacity;
 	int nr_objs;
 	void *objs;
 	void (*ctor)(void *);
@@ -31,6 +32,8 @@ struct kmem_cache {
 	void *private;
 };
 
+static struct kmem_cache *kmem_active = NULL;
+
 void kmem_cache_set_callback(struct kmem_cache *cachep, void (*callback)(void *))
 {
 	cachep->callback = callback;
@@ -147,6 +150,14 @@ void kmem_cache_free(struct kmem_cache *cachep, void *objp)
 	pthread_mutex_unlock(&cachep->lock);
 }
 
+void kmem_cache_free_active(void *objp)
+{
+	if (!kmem_active)
+		printf("WARNING: No active kmem_cache\n");
+
+	kmem_cache_free(kmem_active, objp);
+}
+
 void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list)
 {
 	if (kmalloc_verbose)
@@ -234,23 +245,28 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 }
 
 struct kmem_cache *
-kmem_cache_create(const char *name, unsigned int size, unsigned int align,
-		unsigned int flags, void (*ctor)(void *))
+__kmem_cache_create_args(const char *name, unsigned int size,
+			  struct kmem_cache_args *args,
+			  unsigned int flags)
 {
 	struct kmem_cache *ret = malloc(sizeof(*ret));
 
 	pthread_mutex_init(&ret->lock, NULL);
 	ret->size = size;
-	ret->align = align;
+	ret->align = args->align;
+	ret->sheaf_capacity = args->sheaf_capacity;
 	ret->nr_objs = 0;
 	ret->nr_allocated = 0;
 	ret->nr_tallocated = 0;
 	ret->objs = NULL;
-	ret->ctor = ctor;
+	ret->ctor = args->ctor;
 	ret->non_kernel = 0;
 	ret->exec_callback = false;
 	ret->callback = NULL;
 	ret->private = NULL;
+	if (!kmem_active)
+		kmem_active = ret;
+
 	return ret;
 }
 
diff --git a/tools/testing/shared/linux/rcupdate.h b/tools/testing/shared/linux/rcupdate.h
index fed468fb0c78db6f33fb1900c7110ab5f3c19c65..c95e2f0bbd93798e544d7d34e0823ed68414f924 100644
--- a/tools/testing/shared/linux/rcupdate.h
+++ b/tools/testing/shared/linux/rcupdate.h
@@ -9,4 +9,26 @@
 #define rcu_dereference_check(p, cond) rcu_dereference(p)
 #define RCU_INIT_POINTER(p, v)	do { (p) = (v); } while (0)
 
+void kmem_cache_free_active(void *objp);
+static unsigned long kfree_cb_offset = 0;
+
+static inline void kfree_rcu_cb(struct rcu_head *head)
+{
+	void *objp = (void *) ((unsigned long)head - kfree_cb_offset);
+
+	kmem_cache_free_active(objp);
+}
+
+#ifndef offsetof
+#define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
+#endif
+
+#define kfree_rcu(ptr, rhv)						\
+do {									\
+	if (!kfree_cb_offset)						\
+		kfree_cb_offset = offsetof(typeof(*(ptr)), rhv);	\
+									\
+	call_rcu(&ptr->rhv, kfree_rcu_cb);				\
+} while (0)
+
 #endif

-- 
2.49.0

