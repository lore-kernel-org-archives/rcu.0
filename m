Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADE13E3145;
	Mon, 15 Jun 2026 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521635; cv=none; b=EufNlIbjGYbAWE3PGJ5pKa333d6UdRS4Slk6Kxtb9nk6aq0qePBs9U0GwIIYylD1QjghwW1ds4ELJa8HiQGElhqHrvD0YHGxTJzxFWroMNtJAuyyK4axPaYXhLDsQ9a4XXD6rjud1DCoxz2ogYrALGNyAoVrd6C1OBodJM5fM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521635; c=relaxed/simple;
	bh=9DOKAiQATr35Njs5sByf/gw5hDzRvE8kcjPu7wpVWN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bRvEBVKpxPJJIgbIw0aIZ7xluXcKcl3OiaOdTYh3kjfE3sre1z3YjKAMvK+ajwPyK9rDOdUJH0FSySlg/a4Px7oQTZXk6QQxoJWkHhFt9cKC8l0UvGJKPTiBb/z7C99R1T7L62a0mTq7Csn5uYFOuztzbwqmBnvhCMH8Owrj5BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GITsWOW5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GITsWOW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CDA1F000E9;
	Mon, 15 Jun 2026 11:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781521633;
	bh=o/ijfUoogm2b+cM5xgTnmLzdDUHT22OxJy5j6X1e9RQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GITsWOW5Z+GUrJ29hd5mnyWVcwRgNpK0cKXHhfvpn+jS1rdcIBwgkVI40th8X1OT1
	 Pmlef5x0adbs9WTIBlC0zm6kmZC2nR0GKy5+AeGij5ceNSQz+ElKxuR0246cDNjorO
	 yRArBG3Ajo/Ez18if/6kdRxPilq6HffXPvxak4BEzgR6dPkYvewkcB08T+dNKXHs+2
	 Ymw29lVDR61ttwh4nO/SbZ7WzHAASXbRG/k5TyLgMYRJaeBle/bSNjO2uKTZnYZ/0/
	 mvOW+pJgFZ4zHH1a8E0WiPn1uzho/hecZq9PY+754qLcDBpYsclPbQbR25Dze4ceZW
	 xvtxReIX6elsg==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Mon, 15 Jun 2026 20:06:02 +0900
Subject: [PATCH for-next v3 8/9] mm/slab: introduce struct kfree_rcu_head
 and use in kfree_rcu_nolock()
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-kfree_rcu_nolock-v3-8-70a54f3775bb@kernel.org>
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
In-Reply-To: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
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
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
X-Mailer: b4 0.14.3

struct rcu_head is overkill for kfree_rcu() because the callback
function is always kfree() and thus there is no need for a function
pointer.

It is enough to implement a linked list using a single pointer.
Introduce a new struct called kfree_rcu_head (the name was suggested
by Vlastimil Babka), which is similar to struct rcu_head but is only
a single pointer. Use it only in kfree_rcu_nolock() for now.

It is intended that in most cases, kfree_rcu_nolock() goes through
sheaves path and the field is not used at all. However, in the worst
case where trylock fails or no empty sheaves are available, maintain
a global list of objects that will later be freed after
synchronize_rcu() in a workqueue. Since the fallback is intended to be
the last resort, it focuses on minimizing complexity and memory usage.

To avoid crashing the kernel in a theoretical case where fallback path
is taken before kmem_cache_init_late(), do not queue the work until
the workqueue is actually allocated.

Factor out the logic that calculates object start address into
object_start_address() from kvfree_rcu_cb() to avoid duplicating it.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 include/linux/rcupdate.h |  2 +-
 include/linux/types.h    |  4 +++
 mm/slab.h                |  2 +-
 mm/slab_common.c         |  2 +-
 mm/slub.c                | 92 ++++++++++++++++++++++++++++++++----------------
 5 files changed, 69 insertions(+), 33 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 3025249bfcb5..83e66585001f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1099,7 +1099,7 @@ static inline void rcu_read_unlock_migrate(void)
  * In mm/slab_common.c, no suitable header to include here.
  */
 void kvfree_call_rcu(struct rcu_head *head, void *ptr);
-void kfree_call_rcu_nolock(struct rcu_head *head, void *ptr);
+void kfree_call_rcu_nolock(struct kfree_rcu_head *head, void *ptr);
 
 /*
  * The BUILD_BUG_ON() makes sure the rcu_head offset can be handled. See the
diff --git a/include/linux/types.h b/include/linux/types.h
index 93166b0b0617..695f2a71411e 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -255,6 +255,10 @@ struct callback_head {
 } __attribute__((aligned(sizeof(void *))));
 #define rcu_head callback_head
 
+struct kfree_rcu_head {
+	struct kfree_rcu_head *next;
+};
+
 typedef void (*rcu_callback_t)(struct rcu_head *head);
 typedef void (*call_rcu_func_t)(struct rcu_head *head, rcu_callback_t func);
 
diff --git a/mm/slab.h b/mm/slab.h
index a493c5201e96..19a2a819fd13 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -745,7 +745,7 @@ void __check_heap_object(const void *ptr, unsigned long n,
 			 const struct slab *slab, bool to_user);
 
 void deferred_work_barrier(void);
-void defer_kfree_rcu(struct rcu_head *head);
+void defer_kfree_rcu(struct kfree_rcu_head *head);
 
 static inline bool slub_debug_orig_size(struct kmem_cache *s)
 {
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 5a39e6225160..6b80b516c93f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1263,7 +1263,7 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
 EXPORT_TRACEPOINT_SYMBOL(kfree);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
 
-void kfree_call_rcu_nolock(struct rcu_head *head, void *ptr)
+void kfree_call_rcu_nolock(struct kfree_rcu_head *head, void *ptr)
 {
 	struct slab *slab;
 	struct kmem_cache *s;
diff --git a/mm/slub.c b/mm/slub.c
index 19018a979445..853430c7fbe0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4075,20 +4075,25 @@ static void flush_all(struct kmem_cache *s)
 
 struct deferred_percpu_work {
 	struct llist_head objects;
-	struct llist_head objects_by_rcu;
 	struct llist_head rcu_sheaves;
 	struct irq_work work;
 };
 
 static void deferred_percpu_work_fn(struct irq_work *work);
+static void deferred_irq_work_fn(struct irq_work *work);
+static void deferred_work_fn(struct work_struct *w);
 
 static DEFINE_PER_CPU(struct deferred_percpu_work, deferred_percpu_work) = {
 	.objects = LLIST_HEAD_INIT(objects),
-	.objects_by_rcu = LLIST_HEAD_INIT(objects_by_rcu),
 	.rcu_sheaves = LLIST_HEAD_INIT(rcu_sheaves),
 	.work = IRQ_WORK_INIT(deferred_percpu_work_fn),
 };
 
+static LLIST_HEAD(deferred_free_by_rcu);
+static struct workqueue_struct *deferred_wq;
+static DEFINE_IRQ_WORK(deferred_irq_work, deferred_irq_work_fn);
+static DECLARE_WORK(deferred_work, deferred_work_fn);
+
 static void flush_rcu_sheaf(struct work_struct *w)
 {
 	struct slub_percpu_sheaves *pcs;
@@ -6394,13 +6399,12 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 static void deferred_percpu_work_fn(struct irq_work *work)
 {
 	struct deferred_percpu_work *dpw;
-	struct llist_head *objs, *objs_by_rcu, *rcu_sheaves;
+	struct llist_head *objs, *rcu_sheaves;
 	struct llist_node *llnode, *pos, *t;
 
 	dpw = container_of(work, struct deferred_percpu_work, work);
 	rcu_sheaves = &dpw->rcu_sheaves;
 	objs = &dpw->objects;
-	objs_by_rcu = &dpw->objects_by_rcu;
 
 	llnode = llist_del_all(objs);
 	llist_for_each_safe(pos, t, llnode) {
@@ -6431,12 +6435,50 @@ static void deferred_percpu_work_fn(struct irq_work *work)
 
 		call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
 	}
+}
+
+static void deferred_irq_work_fn(struct irq_work *work)
+{
+	if (!deferred_wq)
+		return;
+
+	queue_work(deferred_wq, &deferred_work);
+}
+
+static inline void *object_start_address(void *ptr)
+{
+	void *obj;
+	struct slab *slab = virt_to_slab(ptr);
+	struct kmem_cache *s = slab->slab_cache;
+
+	VM_WARN_ON_ONCE(is_vmalloc_addr(ptr) || !slab);
+
+	if (is_kfence_address(ptr)) {
+		obj = kfence_object_start(ptr);
+	} else {
+		unsigned int idx = __obj_to_index(s, slab_address(slab), ptr);
+
+		obj = slab_address(slab) + s->size * idx;
+		obj = fixup_red_left(s, obj);
+	}
+
+	return obj;
+}
+
+static void deferred_work_fn(struct work_struct *w)
+{
+	struct llist_node *llnode, *pos, *t;
+
+	llnode = llist_del_all(&deferred_free_by_rcu);
+	if (!llnode)
+		return;
+
+	synchronize_rcu();
 
-	llnode = llist_del_all(objs_by_rcu);
 	llist_for_each_safe(pos, t, llnode) {
-		struct rcu_head *head = (struct rcu_head *)pos;
+		void *obj = object_start_address(pos);
 
-		call_rcu(head, kvfree_rcu_cb);
+		kfree(obj);
 	}
 }
 
@@ -6453,15 +6495,10 @@ static void defer_free(struct kmem_cache *s, void *head)
 		irq_work_queue(&dpw->work);
 }
 
-void defer_kfree_rcu(struct rcu_head *head)
+void defer_kfree_rcu(struct kfree_rcu_head *head)
 {
-	struct deferred_percpu_work *dpw;
-
-	guard(preempt)();
-
-	dpw = this_cpu_ptr(&deferred_percpu_work);
-	if (llist_add((struct llist_node *)head, &dpw->objects_by_rcu))
-		irq_work_queue(&dpw->work);
+	if (llist_add((struct llist_node *)head, &deferred_free_by_rcu))
+		irq_work_queue(&deferred_irq_work);
 }
 
 void deferred_work_barrier(void)
@@ -6470,6 +6507,9 @@ void deferred_work_barrier(void)
 
 	for_each_possible_cpu(cpu)
 		irq_work_sync(&per_cpu_ptr(&deferred_percpu_work, cpu)->work);
+
+	irq_work_sync(&deferred_irq_work);
+	flush_work(&deferred_work);
 }
 
 static __fastpath_inline
@@ -6731,8 +6771,6 @@ void kvfree_rcu_cb(struct rcu_head *head)
 	void *obj = head;
 	struct page *page;
 	struct slab *slab;
-	struct kmem_cache *s;
-	void *slab_addr;
 
 	if (is_vmalloc_addr(obj)) {
 		obj = (void *) PAGE_ALIGN_DOWN((unsigned long)obj);
@@ -6752,19 +6790,8 @@ void kvfree_rcu_cb(struct rcu_head *head)
 		return;
 	}
 
-	s = slab->slab_cache;
-	slab_addr = slab_address(slab);
-
-	if (is_kfence_address(obj)) {
-		obj = kfence_object_start(obj);
-	} else {
-		unsigned int idx = __obj_to_index(s, slab_addr, obj);
-
-		obj = slab_addr + s->size * idx;
-		obj = fixup_red_left(s, obj);
-	}
-
-	slab_free(s, slab, obj, _RET_IP_);
+	obj = object_start_address(obj);
+	slab_free(slab->slab_cache, slab, obj, _RET_IP_);
 }
 
 /**
@@ -8698,6 +8725,11 @@ void __init kmem_cache_init_late(void)
 	flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM | WQ_PERCPU,
 				  0);
 	WARN_ON(!flushwq);
+
+	deferred_wq = alloc_workqueue("slab_deferred_wq",
+				      WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+	WARN_ON(!deferred_wq);
+	queue_work(deferred_wq, &deferred_work);
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 	prandom_init_once(&slab_rnd_state);
 #endif

-- 
2.53.0

