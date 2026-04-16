Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA238BF87
	for <rcu@vger.kernel.org>; Thu, 16 Apr 2026 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330648; cv=none; b=oshvmPvdJ8ghmUch+RyeC7SNpkrMLLXlH16DE2A0Hh6Ahv/k5L/UfXG0o8wwVi2FUH6ssTjGxkIaJmBmHOjcde2wULHj/C9ZTcceITEhANqFNSiSvxFAfBNWKTuxmBM/d3mOuxGN6jGLhwx8b1HaTUx/063fjkWhhy/lgEPc/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330648; c=relaxed/simple;
	bh=Hjzd7B0o3iqh0WNfRjndAmyC/o1A3INTsnmLGnK+eIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHTsIlfuWJz90i+yRQ1dJNj6mjTWH2Sy97fwIXCvr5sF5oHbpEUfl6axQj4j0sTIMKexdjnkVrywqxk5BFihMXM6wA5pcOEdnBQnbjRxFzgEwbmdVmT55uH/HrpqDgpcHn3BYmWwnPUuPC6svoitna18jWqn/lewt3U074gGr/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLplVIIz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLplVIIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD79EC2BCAF;
	Thu, 16 Apr 2026 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776330647;
	bh=Hjzd7B0o3iqh0WNfRjndAmyC/o1A3INTsnmLGnK+eIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLplVIIzNsLn5/KRRbA4VwwJZV/dGQFli2DuKGpYOCnn3guWYtGn+v1CK4Rk7/xn4
	 XdgNKgCywiR9cj7scHP1VEDjxNKl6ZnkoBxnXUil/LH1SN7pQ2NVU0CnXGbjEJcBmp
	 UGLJHSV9xcfVXkaoSUkSWp8xYdDMQb0cQOsMG5gSW6pAbaIyJu03u8Oe13JtqoeK9N
	 QPJzv88IhwHc9FRETYx2/NqAl0I0CqKMIjlxyn03ZFNnmvZcqna8UsEcC4p+hVJakH
	 cyMLYxpoMD60eGWB45FqEFU1au0co5KLzQaNT3DKDHEfGVUkHH/SeHDnlQYSafYRBZ
	 WxFMpPUg1NNoQ==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	rcu@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/8] mm/slab: wrap rcu sheaf handling with ifdef
Date: Thu, 16 Apr 2026 18:10:20 +0900
Message-ID: <20260416091022.36823-7-harry@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091022.36823-1-harry@kernel.org>
References: <20260416091022.36823-1-harry@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Freeing objects via rcu sheaves is only done with
CONFIG_KVFREE_RCU_BATCHED. Wrap the related functions and struct
fields with ifdef to make this dependency explicit.

Also remove a TODO about implementing __kvfree_rcu_barrier_on_cache()
for a specific slab cache, as there doesn't seem to be a simple and
effective way to do so.

Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 mm/slab.h        |  3 +++
 mm/slab_common.c |  4 ----
 mm/slub.c        | 27 +++++++++++++++++++++++++--
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index d7fd7626e9fe..bdad5f389490 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -409,9 +409,12 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
 	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
 }
 
+#ifdef CONFIG_KVFREE_RCU_BATCHED
 bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin);
 void flush_all_rcu_sheaves(void);
 void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
+#endif
+
 void defer_kvfree_rcu_barrier(void);
 
 #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 46a2bee1662b..347e52f1538c 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -2289,10 +2289,6 @@ void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
 		rcu_barrier();
 	}
 
-	/*
-	 * TODO: Introduce a version of __kvfree_rcu_barrier() that works
-	 * on a specific slab cache.
-	 */
 	__kvfree_rcu_barrier();
 }
 EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
diff --git a/mm/slub.c b/mm/slub.c
index d0db8d070570..91b8827d65da 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -421,7 +421,9 @@ struct slub_percpu_sheaves {
 	local_trylock_t lock;
 	struct slab_sheaf *main; /* never NULL when unlocked */
 	struct slab_sheaf *spare; /* empty or full, may be NULL */
+#ifdef CONFIG_KVFREE_RCU_BATCHED
 	struct slab_sheaf *rcu_free; /* for batching kfree_rcu() */
+#endif
 };
 
 /*
@@ -2923,6 +2925,7 @@ static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf)
 	sheaf->size = 0;
 }
 
+#ifdef CONFIG_KVFREE_RCU_BATCHED
 static bool __rcu_free_sheaf_prepare(struct kmem_cache *s,
 				     struct slab_sheaf *sheaf)
 {
@@ -2965,6 +2968,7 @@ static void rcu_free_sheaf_nobarn(struct rcu_head *head)
 
 	free_empty_sheaf(s, sheaf);
 }
+#endif
 
 /*
  * Caller needs to make sure migration is disabled in order to fully flush
@@ -2978,7 +2982,10 @@ static void rcu_free_sheaf_nobarn(struct rcu_head *head)
 static void pcs_flush_all(struct kmem_cache *s)
 {
 	struct slub_percpu_sheaves *pcs;
-	struct slab_sheaf *spare, *rcu_free;
+	struct slab_sheaf *spare;
+#ifdef CONFIG_KVFREE_RCU_BATCHED
+	struct slab_sheaf *rcu_free;
+#endif
 
 	local_lock(&s->cpu_sheaves->lock);
 	pcs = this_cpu_ptr(s->cpu_sheaves);
@@ -2986,8 +2993,10 @@ static void pcs_flush_all(struct kmem_cache *s)
 	spare = pcs->spare;
 	pcs->spare = NULL;
 
+#ifdef CONFIG_KVFREE_RCU_BATCHED
 	rcu_free = pcs->rcu_free;
 	pcs->rcu_free = NULL;
+#endif
 
 	local_unlock(&s->cpu_sheaves->lock);
 
@@ -2996,8 +3005,10 @@ static void pcs_flush_all(struct kmem_cache *s)
 		free_empty_sheaf(s, spare);
 	}
 
+#ifdef CONFIG_KVFREE_RCU_BATCHED
 	if (rcu_free)
 		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
+#endif
 
 	sheaf_flush_main(s);
 }
@@ -3016,10 +3027,12 @@ static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
 		pcs->spare = NULL;
 	}
 
+#ifdef CONFIG_KVFREE_RCU_BATCHED
 	if (pcs->rcu_free) {
 		call_rcu(&pcs->rcu_free->rcu_head, rcu_free_sheaf_nobarn);
 		pcs->rcu_free = NULL;
 	}
+#endif
 }
 
 static void pcs_destroy(struct kmem_cache *s)
@@ -3056,7 +3069,9 @@ static void pcs_destroy(struct kmem_cache *s)
 		 */
 
 		WARN_ON(pcs->spare);
+#ifdef CONFIG_KVFREE_RCU_BATCHED
 		WARN_ON(pcs->rcu_free);
+#endif
 
 		if (!WARN_ON(pcs->main->size)) {
 			free_empty_sheaf(s, pcs->main);
@@ -3937,7 +3952,11 @@ static bool has_pcs_used(int cpu, struct kmem_cache *s)
 
 	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
 
-	return (pcs->spare || pcs->rcu_free || pcs->main->size);
+#ifdef CONFIG_KVFREE_RCU_BATCHED
+	if (pcs->rcu_free)
+		return true;
+#endif
+	return (pcs->spare || pcs->main->size);
 }
 
 /*
@@ -3995,6 +4014,7 @@ static void flush_all(struct kmem_cache *s)
 	cpus_read_unlock();
 }
 
+#ifdef CONFIG_KVFREE_RCU_BATCHED
 static void flush_rcu_sheaf(struct work_struct *w)
 {
 	struct slub_percpu_sheaves *pcs;
@@ -4071,6 +4091,7 @@ void flush_all_rcu_sheaves(void)
 
 	rcu_barrier();
 }
+#endif /* CONFIG_KVFREE_RCU_BATCHED */
 
 static int slub_cpu_setup(unsigned int cpu)
 {
@@ -5825,6 +5846,7 @@ bool free_to_pcs(struct kmem_cache *s, void *object, bool allow_spin)
 	return true;
 }
 
+#ifdef CONFIG_KVFREE_RCU_BATCHED
 static void rcu_free_sheaf(struct rcu_head *head)
 {
 	struct slab_sheaf *sheaf;
@@ -6005,6 +6027,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
 	lock_map_release(&kfree_rcu_sheaf_map);
 	return false;
 }
+#endif /* CONFIG_KVFREE_RCU_BATCHED */
 
 static __always_inline bool can_free_to_pcs(struct slab *slab)
 {
-- 
2.43.0

