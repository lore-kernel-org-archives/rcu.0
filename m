Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79172F7F14;
	Wed, 29 Jul 2026 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313279; cv=none; b=FVB9EPo92lfm0rdZPjs4TY8Fj3UP7UyRX5pZ5+g+uoF3npIYYm8Dof+ANQWi0/GbuWOmFV6/oIWYTkYHKKG6kAJ8GjdsfoyEJrN+UEh+Pz28PHZOgdgiY2GHUB/auceLeu4gaj56KUule3np5mHqacEtlNCPs0KlLcKgi8cTQKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313279; c=relaxed/simple;
	bh=P8B/0Dd4chrz72rOS2DnmEuCMsO1dppWpySJUBexmws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tzeCbFZgm0Dp0w5BPcHDSYXyFodvAejAUbFHwxtZY2d5DqDaDnGc9RW8Hnqa7GmrbgqHCkQM+5v4PsQe1RaX09BoOMJ6/3S3ZPBCRBYg5G0Woews/wGRPMYc45aywVoat92HzrA/PG3JJqba/DIoc5lNSnfJkOVdDfPBbgF4SNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyAbcc3j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyAbcc3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F481F00A3E;
	Wed, 29 Jul 2026 08:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785313269;
	bh=HM1wrl+9RHTKM2wJk5hN+B7UZm4v6BaeKkHLrltGjOA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EyAbcc3jjLA0GxD5916aWovmwGKNzGCrJ+FUiQETxgZhoAoffGO5d8qZlh7ZGdvpy
	 7bRTkGMJ1rN+jgO2Wto1dvFjuZH7+XiWsJf/ZhMA4ywDLmXGSC72TX8JyOkJSQl0ti
	 uf6OFvQsTV0rfTcUTHcyaxYP+COx3G+LseZLTdLcVfzC3D3HfzcGiSCQYX7/aThvTx
	 uivmJVR90qoH9TW+UeNNcan4HAsdb/4uium6Yo8gFTGpgokAmoiF0PczhtQFXQ6xyn
	 +AurBi2V4o2bNcRXdHkIO0t8DZ79NoSPX93eAVCzu2YScvDUIg18Tr3BT4C8jDX9RN
	 V5JWBCh4rVLEg==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Wed, 29 Jul 2026 17:20:10 +0900
Subject: [PATCH v5 2/8] mm/slab: handle the !allow_spin case in
 kfree_rcu_sheaf()
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-kfree_rcu_nolock-v5-2-a28cdcda9673@kernel.org>
References: <20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org>
In-Reply-To: <20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Puranjay Mohan <puranjay@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>, 
 Shengming Hu <hu.shengming@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org, 
 "Harry Yoo (Oracle)" <harry@kernel.org>
X-Mailer: b4 0.14.3

Teach kfree_rcu_sheaf() how to handle the !allow_spin case. Try to get
an empty sheaf from pcs->spare or the barn even when spinning is not
allowed. Unlike __pcs_replace_full_main(), try harder to allocate
an empty sheaf because the fallback path will be more expensive than
kfree_nolock().

Now that slab has internal alloc_flags to describe context, introduce
free_flags analogously and convert free_flags to alloc_flags when
allocating memory in the free path.

When trylock fails or the kernel observes non-NULL pcs->rcu_free after
lock acquisition, free the sheaf instead of putting it to the barn.
This is rare and not worth complicating the code.

Since call_rcu() cannot be called in an unknown context,
kfree_rcu_sheaf() fails when the rcu sheaf becomes full.

Link: https://lore.kernel.org/linux-mm/872bd673-3d45-4111-8a41-31185db3ece5@kernel.org
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 mm/slab.h        | 18 +++++++++++++++++-
 mm/slab_common.c |  2 +-
 mm/slub.c        | 34 ++++++++++++++++++++++++++--------
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index aec0047ed943..7e7f986b49e9 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -24,11 +24,27 @@
 #define SLAB_ALLOC_NO_RECURSE	0x04 /* prevent kmalloc() recursion */
 #define SLAB_ALLOC_NO_OBJ_EXT	0x08 /* prevent obj_exts array allocation */
 
+#define SLAB_FREE_DEFAULT	0x00 /* no flags */
+#define SLAB_FREE_NOLOCK	0x01 /* spinning not allowed */
+
+static inline unsigned int to_alloc_flags(unsigned int free_flags)
+{
+	if (free_flags & SLAB_FREE_NOLOCK)
+		return SLAB_ALLOC_NOLOCK;
+	else
+		return SLAB_ALLOC_DEFAULT;
+}
+
 static inline bool alloc_flags_allow_spinning(const unsigned int alloc_flags)
 {
 	return !(alloc_flags & SLAB_ALLOC_NOLOCK);
 }
 
+static inline bool free_flags_allow_spinning(const unsigned int free_flags)
+{
+	return !(free_flags & SLAB_FREE_NOLOCK);
+}
+
 void *__kmalloc_flags_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t flags,
 				  unsigned int alloc_flags, int node)
 				  __assume_kmalloc_alignment __alloc_size(1);
@@ -431,7 +447,7 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
 	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT|SLAB_NO_OBJ_EXT));
 }
 
-bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
+bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int free_flags);
 void flush_all_rcu_sheaves(void);
 void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1e1d3feec353..42db62f3e801 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1638,7 +1638,7 @@ static bool kfree_rcu_sheaf(void *obj)
 
 	s = slab->slab_cache;
 	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id()))
-		return __kfree_rcu_sheaf(s, obj);
+		return __kfree_rcu_sheaf(s, obj, SLAB_FREE_DEFAULT);
 
 	return false;
 }
diff --git a/mm/slub.c b/mm/slub.c
index d14226ad0982..2c5ba8c326e7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2833,7 +2833,8 @@ static inline struct slab_sheaf *alloc_empty_sheaf(struct kmem_cache *s,
 	return __alloc_empty_sheaf(s, gfp, alloc_flags, s->sheaf_capacity);
 }
 
-static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
+static void __free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
+			       unsigned int free_flags)
 {
 	/*
 	 * If the sheaf was created with SLAB_ALLOC_NO_RECURSE flag then its
@@ -2845,11 +2846,20 @@ static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
 		mark_obj_codetag_empty(sheaf);
 
 	VM_WARN_ON_ONCE(sheaf->size > 0);
-	kfree(sheaf);
+
+	if (unlikely(free_flags & SLAB_FREE_NOLOCK))
+		kfree_nolock(sheaf);
+	else
+		kfree(sheaf);
 
 	stat(s, SHEAF_FREE);
 }
 
+static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
+{
+	__free_empty_sheaf(s, sheaf, SLAB_FREE_DEFAULT);
+}
+
 static unsigned int
 refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
 	       unsigned int max);
@@ -6067,10 +6077,11 @@ static void rcu_free_sheaf(struct rcu_head *head)
  */
 static DEFINE_WAIT_OVERRIDE_MAP(kfree_rcu_sheaf_map, LD_WAIT_CONFIG);
 
-bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
+bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int free_flags)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *rcu_sheaf;
+	bool allow_spin = free_flags_allow_spinning(free_flags);
 
 	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
 		return false;
@@ -6083,9 +6094,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
 	if (unlikely(!pcs->rcu_free)) {
-
 		struct slab_sheaf *empty;
 		struct node_barn *barn;
+		unsigned int alloc_flags = to_alloc_flags(free_flags);
+		gfp_t gfp = allow_spin ? GFP_NOWAIT : __GFP_NOWARN;
 
 		/* Bootstrap or debug cache, fall back */
 		if (unlikely(!cache_has_sheaves(s))) {
@@ -6105,7 +6117,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 			goto fail;
 		}
 
-		empty = barn_get_empty_sheaf(barn, true);
+		empty = barn_get_empty_sheaf(barn, allow_spin);
 
 		if (empty) {
 			pcs->rcu_free = empty;
@@ -6114,20 +6126,20 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 
 		local_unlock(&s->cpu_sheaves->lock);
 
-		empty = alloc_empty_sheaf(s, GFP_NOWAIT, SLAB_ALLOC_DEFAULT);
+		empty = alloc_empty_sheaf(s, gfp, alloc_flags);
 
 		if (!empty)
 			goto fail;
 
 		if (!local_trylock(&s->cpu_sheaves->lock)) {
-			barn_put_empty_sheaf(barn, empty);
+			__free_empty_sheaf(s, empty, free_flags);
 			goto fail;
 		}
 
 		pcs = this_cpu_ptr(s->cpu_sheaves);
 
 		if (unlikely(pcs->rcu_free))
-			barn_put_empty_sheaf(barn, empty);
+			__free_empty_sheaf(s, empty, free_flags);
 		else
 			pcs->rcu_free = empty;
 	}
@@ -6145,6 +6157,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
 		rcu_sheaf = NULL;
 	} else {
+		if (unlikely(!allow_spin)) {
+			/* call_rcu() cannot be called in an unknown context */
+			rcu_sheaf->size--;
+			local_unlock(&s->cpu_sheaves->lock);
+			goto fail;
+		}
 		pcs->rcu_free = NULL;
 		rcu_sheaf->node = numa_node_id();
 	}

-- 
2.53.0

