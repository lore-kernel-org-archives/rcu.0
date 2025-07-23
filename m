Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02A2E7198
	for <rcu@vger.kernel.org>; Wed, 23 Jul 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277737; cv=none; b=qaKIjaorReqVF5+7QjdbM8unD+UwIzyiNHbgsUDBKyq+TM2bqrqIp0qWXsTmWVTVCQBtDI7VnL4no9TyDFWwpI2V0WctVqXLQg/NH5G6gbT0KsFbggnSMmIL8vw9yCjGYKizybFxSJSY5rqz/768m8XIDzOnrXCsDWG3/AHHemE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277737; c=relaxed/simple;
	bh=yM12N+qjBdV+wJ+IvfCWEywD8wX8OcWtZRR11EzaA+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NLHbT2ViSrjyMP+Ae9tTMhR1GWtSC34qny+a46f3czU+Z5UptnyCJ5c+qJlzM4AM4zXC3xvM7op2sK1rBCpSfqcrAMvDVvcf546SC4ylR9j0lCcpejHlXtZxf1azu5kXvRXVYLVl9b0d2PkTpBmj7dhi5m1BoTJ4KsS0HSQFjyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KxrbcoQK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5VH7Cvn5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KxrbcoQK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5VH7Cvn5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KxrbcoQK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5VH7Cvn5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KxrbcoQK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5VH7Cvn5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 447311F791;
	Wed, 23 Jul 2025 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl2sdnU3Na/QjO19ynlaiFzijVMgFDAZeg0f3e42QKM=;
	b=KxrbcoQKJ5Zfh0d43utMQ996V/KuOHaz6QEYI7AgHy8WjqkcVQXXy527a0GvSIEIX5CuIm
	kX6sxUWQegF3+JIEGkUor41DcDTaGhM1mbpxq8bLum1o3JAA3BtoWZiZIUW9MdKS1ymbay
	8lEda69OpP83eNKooq6uFbn09O+5cVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl2sdnU3Na/QjO19ynlaiFzijVMgFDAZeg0f3e42QKM=;
	b=5VH7Cvn50oCDXW33Smu9Pmz6TOm7KOYfInWQRUWwsYQRJm35g1CbxZiVux8KjZZ2CGGDZB
	XXH7aUnC+4hDV8AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl2sdnU3Na/QjO19ynlaiFzijVMgFDAZeg0f3e42QKM=;
	b=KxrbcoQKJ5Zfh0d43utMQ996V/KuOHaz6QEYI7AgHy8WjqkcVQXXy527a0GvSIEIX5CuIm
	kX6sxUWQegF3+JIEGkUor41DcDTaGhM1mbpxq8bLum1o3JAA3BtoWZiZIUW9MdKS1ymbay
	8lEda69OpP83eNKooq6uFbn09O+5cVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl2sdnU3Na/QjO19ynlaiFzijVMgFDAZeg0f3e42QKM=;
	b=5VH7Cvn50oCDXW33Smu9Pmz6TOm7KOYfInWQRUWwsYQRJm35g1CbxZiVux8KjZZ2CGGDZB
	XXH7aUnC+4hDV8AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B13E13ADD;
	Wed, 23 Jul 2025 13:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wIc6CgjlgGh0IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Jul 2025 13:35:04 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 23 Jul 2025 15:34:38 +0200
Subject: [PATCH v5 05/14] tools: Add testing support for changes to rcu and
 slab for sheaves
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-slub-percpu-caches-v5-5-b792cd830f5d@suse.cz>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz, 
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,Oracle.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

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
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
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
2.50.1

