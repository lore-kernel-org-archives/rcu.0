Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B4378D9E
	for <rcu@vger.kernel.org>; Thu, 16 Apr 2026 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330645; cv=none; b=T3CyE/itrRKQTLomLGMNfTjH3FQcGThrX9IcZZce01N8IdVkW7XLeWAipuV+dKkEHPpqB8gKzF1KyvbM/pr1kD43X1/srrOR7W1UG3DIEhSq62xE3/kKXkEQJ3AytRYG2Qlw/vYvY/zX7FjJBKSh3t6R8yvoovwQlat+FnksIzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330645; c=relaxed/simple;
	bh=b9Lg6+gdxq2yOwC2QG9xsnybmVAk9MArQJ5t2pzDwug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNIBF5nPHfumTO7rBJ1252oZ/CNqa7VoowO2w4Mnzj8fR7hDAhC2EtKMLd3ne0LfYZloHHQjrnvxMbZVSegrAdZnjnpkHUrx5pzdg6qboivoEevQADYJqBKJU9iHR9sCzvVfRb/M7cor2R0oS5S9sU1PW6PogG2pJMy75DsW1wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4XXm2SO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4XXm2SO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FEBC2BCB6;
	Thu, 16 Apr 2026 09:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776330644;
	bh=b9Lg6+gdxq2yOwC2QG9xsnybmVAk9MArQJ5t2pzDwug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I4XXm2SOm8tCAJZdc8cnqZau4KcBtMOyhZO3WR2iGbg05zVfsy29306JVaH/sdSNn
	 JpNu5O6d0rs6nih+5xTPjCDmy46Ii3NydgooZmNJI2mmampvPzPuAUIZ0c6YqCrZCj
	 5X7DkeiWOaWN9Kp5A3exH3O5NfXeqtOSdW/tMPrJRJ3LlQthomW9R4FRbSBqqjaUgc
	 6TG/+i6E9r30OY2jFZtxSPiGU8WGaKeEbYWcxW8BQl1m4u7D31h9Ng13w0HcnDbrf8
	 BhjE9BN7Giv2Kvqchf7AjjeRzPUq7sH2ljgploSXsHY8CklF1x0JK7apSUsdE5XAQM
	 8UQbDf5+XjvQg==
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
Subject: [PATCH 5/8] mm/slab: make kfree_rcu_nolock() work with sheaves
Date: Thu, 16 Apr 2026 18:10:19 +0900
Message-ID: <20260416091022.36823-6-harry@kernel.org>
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

Teach kfree_rcu_sheaf() how to handle the !allow_spin case. Similar to
__pcs_replace_full_main(), try to get an empty sheaf from pcs->spare or
the barn, but don't add !allow_spin support for alloc_empty_sheaf() and
fail early instead.

Since call_rcu() does not support NMI contexts, kfree_rcu_sheaf() fails
when the rcu sheaf becomes full.

Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 mm/slab.h        |  2 +-
 mm/slab_common.c |  7 +++----
 mm/slub.c        | 14 ++++++++++++--
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index ae2e990e8dc2..d7fd7626e9fe 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -409,7 +409,7 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
 	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
 }
 
-bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
+bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin);
 void flush_all_rcu_sheaves(void);
 void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
 void defer_kvfree_rcu_barrier(void);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e840956233dd..46a2bee1662b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1716,7 +1716,7 @@ static void kfree_rcu_work(struct work_struct *work)
 		kvfree_rcu_list(head);
 }
 
-static bool kfree_rcu_sheaf(void *obj)
+static bool kfree_rcu_sheaf(void *obj, bool allow_spin)
 {
 	struct kmem_cache *s;
 	struct slab *slab;
@@ -1730,7 +1730,7 @@ static bool kfree_rcu_sheaf(void *obj)
 
 	s = slab->slab_cache;
 	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id()))
-		return __kfree_rcu_sheaf(s, obj);
+		return __kfree_rcu_sheaf(s, obj, allow_spin);
 
 	return false;
 }
@@ -2111,8 +2111,7 @@ void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr, bool allow_spin)
 				IS_ENABLED(CONFIG_DEBUG_KMEMLEAK)))
 		goto defer_free;
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-			(allow_spin && kfree_rcu_sheaf(ptr)))
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr, allow_spin))
 		return;
 
 	// Queue the object but don't yet schedule the batch.
diff --git a/mm/slub.c b/mm/slub.c
index 6f658ec00751..d0db8d070570 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5895,7 +5895,7 @@ static void rcu_free_sheaf(struct rcu_head *head)
  */
 static DEFINE_WAIT_OVERRIDE_MAP(kfree_rcu_sheaf_map, LD_WAIT_CONFIG);
 
-bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
+bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *rcu_sheaf;
@@ -5933,7 +5933,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 			goto fail;
 		}
 
-		empty = barn_get_empty_sheaf(barn, true);
+		empty = barn_get_empty_sheaf(barn, allow_spin);
 
 		if (empty) {
 			pcs->rcu_free = empty;
@@ -5942,6 +5942,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 
 		local_unlock(&s->cpu_sheaves->lock);
 
+		/* It's easier to fall back than trying harder with !allow_spin */
+		if (!allow_spin)
+			goto fail;
+
 		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
 
 		if (!empty)
@@ -5973,6 +5977,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
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
2.43.0

