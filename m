Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C37378D9E
	for <rcu@vger.kernel.org>; Thu, 16 Apr 2026 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330651; cv=none; b=TLI0YTfZ+3VYfozjsjIX+Iknhhjkut1M5pjMyCOVK0DK16NdMwW7RQqEqLLkrsqrw+jZNUjsibqJVQRrRSZR7a0t21i9xUHa51VqpfvmniOMts71nLvtWkki1MCPAOXtSc2ohpoaf3ktBRuXXHa94yDmFIz3SIASTzfYrQeHNQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330651; c=relaxed/simple;
	bh=KVtcHV6ZDZO1rs/63QPo3Nc9xkoqRGLE5wgjSTGCkzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gi4q5hQ99ThBIsd5LaV1xAqD5wrn/JJ5CL7iKHGFtVjBz4JiSLgLzQNhLF0SIv/5uezHz65wpe2q9mxjpr/wJVaAqefiRyxG9kGAuKbwpdrRCpb3bs98rl1SpRXbrbdp4CsOSlCcxXFegJ3X6Co60hFoyNg36V3EeBo0FlxVugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3vUv6PN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3vUv6PN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26590C2BCB6;
	Thu, 16 Apr 2026 09:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776330651;
	bh=KVtcHV6ZDZO1rs/63QPo3Nc9xkoqRGLE5wgjSTGCkzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3vUv6PNEGqBNMbFhjMIOq/G7s+LtiA0lrMsvWv8GNiaqEbyUD1Fd1NmdozSixtAs
	 y8xG2GmF+RePfAnvoGy2hxAouu/b6nKgtTbbZ2eIp1hmJsez9gtEp5K14DhY/MOZ7W
	 QybgOBYVgkfFIXSj3aAlRHKfFMehWHRomQYy5iMBQTZ+eyrRkKDHfxz94+LZKHMlti
	 /p7zExWnGfEOBU8I51QtIbfcncoqXDl4FibuAoBF/TDGt4pdL5hknrHxiyKoutdxz0
	 8+B/iVMKlcjX9yEjg5+ULWTP6CsH+p94YUzD4ateQ8E9+eRRjgoob2shhLyA1dxR23
	 8BWWUpPBT8SvA==
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
Subject: [PATCH 7/8] mm/slab: introduce deferred submission of rcu sheaves
Date: Thu, 16 Apr 2026 18:10:21 +0900
Message-ID: <20260416091022.36823-8-harry@kernel.org>
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

Instead of falling back when the rcu sheaf becomes full, implement
deferred submission of rcu sheaves. If kfree_rcu_sheaf() is invoked
by kfree_rcu_nolock() (!allow_spin) and IRQs are disabled, the CPU might
be in the middle of call_rcu() and thus defer call_rcu() with irq_work.

Submit all deferred RCU sheaves to call_rcu() before calling
rcu_barrier() to ensure the promise of kvfree_rcu_barrier().

An alternative approach could be to implement this in the RCU subsystem,
tracking if it's safe to call call_rcu() and allowing falling back to
deferred call_rcu() at the cost of more expensive rcu_barrier() calls.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 mm/slab.h        |  2 ++
 mm/slab_common.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++--
 mm/slub.c        | 12 ++++--------
 3 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index bdad5f389490..9ba3aad1eeb2 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -411,6 +411,8 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
 
 #ifdef CONFIG_KVFREE_RCU_BATCHED
 bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin);
+void rcu_free_sheaf(struct rcu_head *head);
+void submit_rcu_sheaf(struct rcu_head *head, bool allow_spin);
 void flush_all_rcu_sheaves(void);
 void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
 #endif
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 347e52f1538c..226009b10c4a 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1314,8 +1314,11 @@ struct kfree_rcu_cpu {
 	// Objects queued on a lockless linked list, used to free objects
 	// in unknown contexts when trylock fails.
 	struct llist_head defer_head;
-
 	struct irq_work defer_free;
+
+	struct llist_head defer_call_rcu_head;
+	struct irq_work defer_call_rcu;
+
 	struct irq_work sched_delayed_monitor;
 	struct irq_work run_page_cache_worker;
 
@@ -1345,11 +1348,14 @@ struct kfree_rcu_cpu {
 static void defer_kfree_rcu_irq_work_fn(struct irq_work *work);
 static void sched_delayed_monitor_irq_work_fn(struct irq_work *work);
 static void run_page_cache_worker_irq_work_fn(struct irq_work *work);
+static void defer_call_rcu_irq_work_fn(struct irq_work *work);
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
 	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
 	.defer_head = LLIST_HEAD_INIT(defer_head),
 	.defer_free = IRQ_WORK_INIT(defer_kfree_rcu_irq_work_fn),
+	.defer_call_rcu_head = LLIST_HEAD_INIT(defer_call_rcu_head),
+	.defer_call_rcu = IRQ_WORK_INIT(defer_call_rcu_irq_work_fn),
 	.sched_delayed_monitor =
 		IRQ_WORK_INIT_LAZY(sched_delayed_monitor_irq_work_fn),
 	.run_page_cache_worker =
@@ -1374,8 +1380,12 @@ void defer_kvfree_rcu_barrier(void)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		irq_work_sync(&per_cpu_ptr(&krc, cpu)->defer_free);
+#ifdef CONFIG_KVFREE_RCU_BATCHED
+		irq_work_sync(&per_cpu_ptr(&krc, cpu)->defer_call_rcu);
+#endif
+	}
 }
 
 static void *object_start_addr(void *ptr)
@@ -1524,6 +1534,21 @@ static void sched_delayed_monitor_irq_work_fn(struct irq_work *work)
 	schedule_delayed_monitor_work(krcp);
 }
 
+static void defer_call_rcu_irq_work_fn(struct irq_work *work)
+{
+	struct kfree_rcu_cpu *krcp;
+	struct llist_node *llnode, *pos, *t;
+
+	krcp = container_of(work, struct kfree_rcu_cpu, defer_call_rcu);
+
+	if (llist_empty(&krcp->defer_call_rcu_head))
+		return;
+
+	llnode = llist_del_all(&krcp->defer_call_rcu_head);
+	llist_for_each_safe(pos, t, llnode)
+		call_rcu((struct rcu_head *)pos, rcu_free_sheaf);
+}
+
 static __always_inline void
 debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
 {
@@ -2187,6 +2212,26 @@ void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr, bool allow_spin)
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu_ptr);
 
+static inline void defer_call_rcu(struct rcu_head *head)
+{
+	struct kfree_rcu_cpu *krcp;
+
+	VM_WARN_ON_ONCE(!irqs_disabled());
+
+	krcp = this_cpu_ptr(&krc);
+	if (llist_add((struct llist_node *)head, &krcp->defer_call_rcu_head))
+		irq_work_queue(&krcp->defer_call_rcu);
+}
+
+void submit_rcu_sheaf(struct rcu_head *head, bool allow_spin)
+{
+	/* Might be in the middle of call_rcu(), defer it */
+	if (unlikely(!allow_spin && irqs_disabled()))
+		defer_call_rcu(head);
+	else
+		call_rcu(head, rcu_free_sheaf);
+}
+
 static inline void __kvfree_rcu_barrier(void)
 {
 	struct kfree_rcu_cpu_work *krwp;
diff --git a/mm/slub.c b/mm/slub.c
index 91b8827d65da..1c3451166498 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4152,6 +4152,8 @@ static int slub_cpu_dead(unsigned int cpu)
 			__pcs_flush_all_cpu(s, cpu);
 	}
 	mutex_unlock(&slab_mutex);
+
+	/* pending IRQ work should have been flushed before going offline */
 	return 0;
 }
 
@@ -5847,7 +5849,7 @@ bool free_to_pcs(struct kmem_cache *s, void *object, bool allow_spin)
 }
 
 #ifdef CONFIG_KVFREE_RCU_BATCHED
-static void rcu_free_sheaf(struct rcu_head *head)
+void rcu_free_sheaf(struct rcu_head *head)
 {
 	struct slab_sheaf *sheaf;
 	struct node_barn *barn = NULL;
@@ -5999,12 +6001,6 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
 	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
 		rcu_sheaf = NULL;
 	} else {
-		if (unlikely(!allow_spin)) {
-			/* call_rcu() cannot be called in an unknown context */
-			rcu_sheaf->size--;
-			local_unlock(&s->cpu_sheaves->lock);
-			goto fail;
-		}
 		pcs->rcu_free = NULL;
 		rcu_sheaf->node = numa_node_id();
 	}
@@ -6014,7 +6010,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
 	 * flush_all_rcu_sheaves() doesn't miss this sheaf
 	 */
 	if (rcu_sheaf)
-		call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
+		submit_rcu_sheaf(&rcu_sheaf->rcu_head, allow_spin);
 
 	local_unlock(&s->cpu_sheaves->lock);
 
-- 
2.43.0

