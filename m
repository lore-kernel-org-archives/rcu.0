Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6F267F7E
	for <rcu@vger.kernel.org>; Fri, 14 Feb 2025 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550497; cv=none; b=fJKJfvohf6jXANt2PCLWN1gGxUe3TCmZ4zLodtf+jsaMkeF0fLWryAQ+6uD/At8Ji89j4a5nzGLvV9k+fOSJgVFvSTTVOU9LRPccd+wzy8EtCgHGjjTD3+bypPl/GKQMWGKxuRK9GsoTEThJRkWZjd0ASiyiRUZs61YIX7LDamA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550497; c=relaxed/simple;
	bh=kX0RPsDQr1DQPxpGHapv61/xxQrllj5pXyMCIzkw1G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzIAsbDgNK3/mAR3GhJf6W4veqDQEuq+rA53DSi0q4+ziVW9Jq4MOy9AZQYXJI78RNb1HOMuyYZRtTgjRzJChMsH4sbJaQgjRWzC2Sgx9XS8NVTKPrBfRMr4PT3FPf6+ICIgehKjzbHIQ70O0zVDBobxsLcVsqPy5hkGVK5OhOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u8jqOZ8I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0qa1KWSV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u8jqOZ8I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0qa1KWSV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u8jqOZ8I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0qa1KWSV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u8jqOZ8I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0qa1KWSV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1060721181;
	Fri, 14 Feb 2025 16:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739550463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLtEQ/q9lO1Z0OFCXgBkkhN+q6XZ6NGPEru6gyzhnws=;
	b=u8jqOZ8I83tYUP2QKPEWC8KiQEnlRgtDT8KaFa8nU1mFZO2ZOQNPO5cz1KrcEsvZ9IoVdd
	6BIKrHuXaBDHLGMBM3NzrdF1jtgvHr6Mg7ave+rF2evhrGtVtuB3gh8ZG0W3yvc3nH3dG1
	fw1yxlK9Crhx07OsvaS3eUMyX/j9iA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739550463;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLtEQ/q9lO1Z0OFCXgBkkhN+q6XZ6NGPEru6gyzhnws=;
	b=0qa1KWSVi4cqBGYpYfsLyobPouXCrxLgFIk0jemoeuQ9nH/qplkae8T9y1ScxKDhKkCX/V
	9nZh3P+ap91ZDgAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739550463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLtEQ/q9lO1Z0OFCXgBkkhN+q6XZ6NGPEru6gyzhnws=;
	b=u8jqOZ8I83tYUP2QKPEWC8KiQEnlRgtDT8KaFa8nU1mFZO2ZOQNPO5cz1KrcEsvZ9IoVdd
	6BIKrHuXaBDHLGMBM3NzrdF1jtgvHr6Mg7ave+rF2evhrGtVtuB3gh8ZG0W3yvc3nH3dG1
	fw1yxlK9Crhx07OsvaS3eUMyX/j9iA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739550463;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLtEQ/q9lO1Z0OFCXgBkkhN+q6XZ6NGPEru6gyzhnws=;
	b=0qa1KWSVi4cqBGYpYfsLyobPouXCrxLgFIk0jemoeuQ9nH/qplkae8T9y1ScxKDhKkCX/V
	9nZh3P+ap91ZDgAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFC7B13AF0;
	Fri, 14 Feb 2025 16:27:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kM5IOv5ur2eHSAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Feb 2025 16:27:42 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 14 Feb 2025 17:27:44 +0100
Subject: [PATCH RFC v2 08/10] tools: Add testing support for changes to rcu
 and slab for sheaves
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-slub-percpu-caches-v2-8-88592ee0966a@suse.cz>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
In-Reply-To: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, "Liam R. Howlett" <Liam.Howlett@Oracle.com>
X-Mailer: b4 0.14.2
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,Oracle.com];
	R_RATELIMIT(0.00)[to_ip_from(RLtz7ce9b89hw8xzamye9qeynd)];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Make testing work for the slab and rcu changes that have come in with
the sheaves work.

This only works with one kmem_cache, and only the first one used.
Subsequent setting of keme_cache will not update the active kmem_cache
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
index 51b25e9c4ec7b66bdf4c68cc1353c6faf1ca7bb8..a475364cfd9fcdb10db252aab18ea3a620326b6b 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -22,6 +22,12 @@ enum slab_state {
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
@@ -36,9 +42,38 @@ static inline void *kmem_cache_alloc(struct kmem_cache *cachep, int flags)
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
index 66dbb362385f3c3d923233448cc591adfe6dc9e7..9f5fd722f27f1d3877be8927be30409cd74ab3c3 100644
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
2.48.1

