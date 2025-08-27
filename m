Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9647E33A021
	for <rcu@vger.kernel.org>; Wed, 27 Aug 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756283233; cv=none; b=QCdjXQuKmE4J8KPNUEcNEuj+OUIrZK4Se1Q2NS3ioIZahuGA0dIYMJP9fz3C8KDtdLl4Qow78mcUjqJd9HgGAz/+jyV6ieb8XZypjSNAdeyWH7qD+vrUgN/JGAoM/k8W7pBuQjcwqGP1OD3tmkaEoJzm9aANqX0QAEvvUGGeuZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756283233; c=relaxed/simple;
	bh=w0FwJcPgX1e36DmPBz/2cYjO8qP6xKfM6E0UW0U0XDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MwFus4jkDPh657aErUE3OibK+R9Vjk8e0HmIubCYd5rlnTIxKpw+dWEDN9f4Jw+phlL4nFGpQ3DP/mtrQcOvS5ZoL1CHNiJZ0wpJc8xxz+EGQnY2JAl/odHtvHaVGMb7l+NORVyYQ5iuhs0cNBtVZjFp22lWyWEtqIjpPBQO3UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C45CC1FF24;
	Wed, 27 Aug 2025 08:26:35 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A552F13310;
	Wed, 27 Aug 2025 08:26:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KPkQKDvBrmhNfgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 27 Aug 2025 08:26:35 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 27 Aug 2025 10:26:41 +0200
Subject: [PATCH v6 09/10] tools/testing: Add testing support for slab
 caches with sheaves
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-slub-percpu-caches-v6-9-f0f775a3f73f@suse.cz>
References: <20250827-slub-percpu-caches-v6-0-f0f775a3f73f@suse.cz>
In-Reply-To: <20250827-slub-percpu-caches-v6-0-f0f775a3f73f@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz, 
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>
X-Mailer: b4 0.14.2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C45CC1FF24
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Make testing work for the slab changes that have come in with the
sheaves work. That means support kmem_cache_args with sheaf_capacity.

[vbabka@suse.cz: remove kfree_rcu() support, to be added later]
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/include/linux/slab.h   | 41 ++++++++++++++++++++++++++++++++++++++---
 tools/testing/shared/linux.c | 12 ++++++++----
 2 files changed, 46 insertions(+), 7 deletions(-)

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
index 0f97fb0d19e19c327aa4843a35b45cc086f4f366..04730abe4dffbd6849b848373ec110b87c81bf33 100644
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
@@ -234,23 +235,26 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
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
+
 	return ret;
 }
 

-- 
2.51.0

