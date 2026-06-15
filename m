Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755363E2ABC;
	Mon, 15 Jun 2026 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521615; cv=none; b=pUUrvUjAOWyEGbKIAURUSrwllLIBt9b1wC6SOumcIGdrtKZP1hVdjEm42RPKQvoFrroctRP3Zk8iBF/nRuj0EbMoMcmL3zR9eKhUdu0JTLpccveLn9EiyXxdcrGUh92B3A0FaTKLTlJtM2lLs/cGnZbzmE1zKbzspkGg4m4EufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521615; c=relaxed/simple;
	bh=rCtFzwDFtyrFgnyBmxefYpPOtpx4s+EdkHNTRGevRU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TcPMmYS8uPQrYklYmpTnl6jlaBSHW4ac2GaCLhmNH9FPL8GskTSLnnna5K1QnlS2D/vwOeaCPEgIIsRYwbRNpzomfoY5iQ7eDKYWQExtWZ4X6mhBVkydAjumiZdBavKU3Jwn0fr1ZFQBTgWN4m1DXPSacaggftZ5I9cj/BXo74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIqd52g6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIqd52g6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744731F00A3A;
	Mon, 15 Jun 2026 11:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781521614;
	bh=b71TkYSN8Xi1cenWcGDzcQgyqNM4qfbHhYT2BlJU6vk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kIqd52g6N9U5wiR1n3XLFD94/9+f7CeVgPVaNBf9/+SdfnEAbyyOqQ7kR/oW+Hwi+
	 n0KKvWUScg2t/UCdjykVkBvaE+Tbjb9+J8aiaICLfsT5fCZqW9H3oS8ai389Yn1NPZ
	 cvfH1o8+0wLU7O0myrfLfyXWXUIFgEZvnwnfNu5VVDgg18OviaXs7RjYa7kYpzu+vg
	 OFY0yUTk6SQjG1C32fbxxJlxrKl61YcoNzM3XyA36sLiG7kDGR9IpkqOnpVYA8URND
	 /FGQIZVMeqSCOHCvFLCglT9ugbAqVbNnL79iMoMJaTO33bOgXJx5cLmUEbjgYsMrpM
	 BUIPlyW01gbpg==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Mon, 15 Jun 2026 20:05:59 +0900
Subject: [PATCH for-next v3 5/9] mm/slab: extend deferred free mechanism to
 handle rcu sheaves
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-kfree_rcu_nolock-v3-5-70a54f3775bb@kernel.org>
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

__kfree_rcu_sheaf() cannot invoke call_rcu() when spinning is not
allowed and IRQs are disabled. To relax the limitation, extend the
deferred free fallback so that a full rcu sheaf can be submitted to
call_rcu() via the existing IRQ work.

Since the deferred mechanism does more than deferred free of objects,
rename the struct to deferred_percpu_work and adjust names accordingly.

When a sheaf is queued on an IRQ work, it is detached from
pcs->rcu_free but call_rcu() is not invoked until the irq_work runs.
To keep the kvfree_rcu barrier's promise, call irq_work_sync() on each
CPU before calling rcu_barrier().

In the meantime, remove the TODO item as apparently there is no simple
and effective way to achieve that.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 mm/slab.h        |  2 +-
 mm/slab_common.c |  7 ++---
 mm/slub.c        | 79 ++++++++++++++++++++++++++++++++++----------------------
 3 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index b1bd33a16544..961581e35ec8 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -744,7 +744,7 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 void __check_heap_object(const void *ptr, unsigned long n,
 			 const struct slab *slab, bool to_user);
 
-void defer_free_barrier(void);
+void deferred_work_barrier(void);
 
 static inline bool slub_debug_orig_size(struct kmem_cache *s)
 {
diff --git a/mm/slab_common.c b/mm/slab_common.c
index bc1a8ec938d9..55546b8385ff 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -551,7 +551,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	}
 
 	/* Wait for deferred work from kmalloc/kfree_nolock() */
-	defer_free_barrier();
+	deferred_work_barrier();
 
 	cpus_read_lock();
 	mutex_lock(&slab_mutex);
@@ -2113,13 +2113,10 @@ void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
 		cpus_read_lock();
 		flush_rcu_sheaves_on_cache(s);
 		cpus_read_unlock();
+		deferred_work_barrier();
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
index 6a3552b70683..ba593c1c53d5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -418,6 +418,8 @@ struct slab_sheaf {
 	union {
 		struct rcu_head rcu_head;
 		struct list_head barn_list;
+		/* only used to defer call_rcu() in unknown context */
+		struct llist_node llnode;
 		/* only used for prefilled sheafs */
 		struct {
 			unsigned int capacity;
@@ -4071,6 +4073,20 @@ static void flush_all(struct kmem_cache *s)
 	cpus_read_unlock();
 }
 
+struct deferred_percpu_work {
+	struct llist_head objects;
+	struct llist_head rcu_sheaves;
+	struct irq_work work;
+};
+
+static void deferred_percpu_work_fn(struct irq_work *work);
+
+static DEFINE_PER_CPU(struct deferred_percpu_work, deferred_percpu_work) = {
+	.objects = LLIST_HEAD_INIT(objects),
+	.rcu_sheaves = LLIST_HEAD_INIT(rcu_sheaves),
+	.work = IRQ_WORK_INIT(deferred_percpu_work_fn),
+};
+
 static void flush_rcu_sheaf(struct work_struct *w)
 {
 	struct slub_percpu_sheaves *pcs;
@@ -4142,6 +4158,7 @@ void flush_all_rcu_sheaves(void)
 	mutex_unlock(&slab_mutex);
 	cpus_read_unlock();
 
+	deferred_work_barrier();
 	rcu_barrier();
 }
 
@@ -6158,12 +6175,6 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
 	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
 		rcu_sheaf = NULL;
 	} else {
-		/* call_rcu() disables IRQs to protect percpu data structures */
-		if (unlikely(!allow_spin && irqs_disabled())) {
-			rcu_sheaf->size--;
-			local_unlock(&s->cpu_sheaves->lock);
-			goto fail;
-		}
 		pcs->rcu_free = NULL;
 		rcu_sheaf->node = numa_node_id();
 	}
@@ -6172,8 +6183,18 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
 	 * we flush before local_unlock to make sure a racing
 	 * flush_all_rcu_sheaves() doesn't miss this sheaf
 	 */
-	if (rcu_sheaf)
-		call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
+	if (rcu_sheaf) {
+		/* call_rcu() disables IRQs to protect percpu data structures */
+		if (unlikely(!allow_spin && irqs_disabled())) {
+			struct deferred_percpu_work *dpw;
+
+			dpw = this_cpu_ptr(&deferred_percpu_work);
+			if (llist_add(&rcu_sheaf->llnode, &dpw->rcu_sheaves))
+				irq_work_queue(&dpw->work);
+		} else {
+			call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
+		}
+	}
 
 	local_unlock(&s->cpu_sheaves->lock);
 
@@ -6360,31 +6381,20 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	}
 }
 
-struct defer_free {
-	struct llist_head objects;
-	struct irq_work work;
-};
-
-static void free_deferred_objects(struct irq_work *work);
-
-static DEFINE_PER_CPU(struct defer_free, defer_free_objects) = {
-	.objects = LLIST_HEAD_INIT(objects),
-	.work = IRQ_WORK_INIT(free_deferred_objects),
-};
-
 /*
  * In PREEMPT_RT irq_work runs in per-cpu kthread, so it's safe
  * to take sleeping spin_locks from __slab_free().
  * In !PREEMPT_RT irq_work will run after local_unlock_irqrestore().
  */
-static void free_deferred_objects(struct irq_work *work)
+static void deferred_percpu_work_fn(struct irq_work *work)
 {
-	struct defer_free *df = container_of(work, struct defer_free, work);
-	struct llist_head *objs = &df->objects;
+	struct deferred_percpu_work *dpw;
+	struct llist_head *objs, *rcu_sheaves;
 	struct llist_node *llnode, *pos, *t;
 
-	if (llist_empty(objs))
-		return;
+	dpw = container_of(work, struct deferred_percpu_work, work);
+	rcu_sheaves = &dpw->rcu_sheaves;
+	objs = &dpw->objects;
 
 	llnode = llist_del_all(objs);
 	llist_for_each_safe(pos, t, llnode) {
@@ -6408,27 +6418,34 @@ static void free_deferred_objects(struct irq_work *work)
 		__slab_free(s, slab, x, x, 1, _THIS_IP_);
 		stat(s, FREE_SLOWPATH);
 	}
+
+	llnode = llist_del_all(rcu_sheaves);
+	llist_for_each_safe(pos, t, llnode) {
+		struct slab_sheaf *rcu_sheaf = llist_entry(pos, struct slab_sheaf, llnode);
+
+		call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
+	}
 }
 
 static void defer_free(struct kmem_cache *s, void *head)
 {
-	struct defer_free *df;
+	struct deferred_percpu_work *dpw;
 
 	guard(preempt)();
 
 	head = kasan_reset_tag(head);
 
-	df = this_cpu_ptr(&defer_free_objects);
-	if (llist_add(head + s->offset, &df->objects))
-		irq_work_queue(&df->work);
+	dpw = this_cpu_ptr(&deferred_percpu_work);
+	if (llist_add(head + s->offset, &dpw->objects))
+		irq_work_queue(&dpw->work);
 }
 
-void defer_free_barrier(void)
+void deferred_work_barrier(void)
 {
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		irq_work_sync(&per_cpu_ptr(&defer_free_objects, cpu)->work);
+		irq_work_sync(&per_cpu_ptr(&deferred_percpu_work, cpu)->work);
 }
 
 static __fastpath_inline

-- 
2.53.0

