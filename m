Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E643C7CB;
	Wed, 29 Jul 2026 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313275; cv=none; b=b1emzY1LoGmf1xY03KSvauqgR+Dj6L1lh2eqP1Wf82iqKOZ6M1p47L8Co460u1ZQea48GAtvC0oprMtrDTMMyjV2IkN/4Jqu+ffOzuSeulmE+i6GlDLfnKodbF8eHr/oHc4QegPsLxBzwCG1SFaTBFnGnlHQYWUXDxCcstbmrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313275; c=relaxed/simple;
	bh=lOt5umOXkArUgC/qaTOiLslk63AI7xbzG+dwfV4d+yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTLay3MGFNOzvad5FQmoc2oOwrHVbLmnmg6LnrWhW+B8WrVL2gaeyrC9buFgVn8sd/n6QXJJYqH+lgKXov9esD8LRf3X7iC0g07rHlxyzunu4ocak/TMawgkQ6VJbTGi/+VuEY9Dor/IsUxBbuh25OubbK15UtGZnwcyIqHPnQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMnK9Ivp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMnK9Ivp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659DA1F00A3A;
	Wed, 29 Jul 2026 08:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785313263;
	bh=VFSRdx4VR4AvdkOAoQOMpC+N39DKHBrUpDK98mPZCUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kMnK9Ivp6mBrw8pG6TGk8Ypr26SD3KAQistfH6ePze8HfrYfXYetLAqtkh9Fp0ny8
	 fPuU4vZwsxB00ibaFhEaagvZ8GdsCwfxcA40s6XDiq9m7bCwL0VXVawxghLDUqDzKJ
	 ZoP878T1L6qKyu+TW1DJmzLheelntpOeW6TzFxBOe29q55ii9W1uTCWd6PmJakFIe9
	 HBdO6OdFl/V0+V/NeZ42+Aw4ky8+07kuiZr5UKh48pVhOFFQHBrDtk/RRkqG0AOVgT
	 7vqUER7geUK8cGxyfPSV2fHcyx6rcBX6jqsaCWC9vbi1FAOvc627vihJ2Y3b1xXk4t
	 mFciSGtF0FfVg==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Wed, 29 Jul 2026 17:20:09 +0900
Subject: [PATCH v5 1/8] mm/slab, slub_kunit: register kprobe to trigger
 _nolock APIs
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-kfree_rcu_nolock-v5-1-a28cdcda9673@kernel.org>
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

Since kmalloc_nolock() always fails in NMI and hardirq contexts on
PREEMPT_RT, slub_kunit cannot properly test _nolock() APIs.

Register a kprobe pre-handler to invoke kmalloc_nolock() and
kfree_nolock() in the middle of the slab allocator. However, do not
register the handler on UP kernels because that use case is not
well supported [1] in the kernel.

To attach the pre-handler while s->cpu_sheaves->lock or n->list_lock
is held, add a wrapper function for lockdep_assert_held() that calls
a no-op function slab_attach_kprobe_locked() on debug builds. The
function is optimized away when neither CONFIG_PROVE_LOCKING nor
CONFIG_DEBUG_VM is selected and register_kprobe() fails.

The function calls barrier() to prevent the compiler from optimizing
away its callsites. Otherwise, the compiler may consider the function
does not have any side effect and remove callsites.

Compared to using plain kprobe, this has two advantages: 1) it avoids
hardcoding function names in the test, and 2) it can trigger those APIs
in the middle of a function, where the lock is expected to be held as
annotated with lockdep.

While it was proposed [2] to use kunit function redirection to test
this, it is currently infeasible as some lock helpers don't have
symbols.

Factor out the nested loop that calls kmalloc and friends to
test_kmalloc_kfree(), and call them in
test_kmalloc_kfree_nolock_{perf,kprobe}(), each being an independent
test case. During the refactoring, drop alloc_fail handling as it
doesn't provide much benefits.

Link: https://lore.kernel.org/linux-mm/20260427-nolock-api-fix-v2-0-a6b83a92d9a4@kernel.org [1]
Link: https://lore.kernel.org/linux-mm/6edebc2b-5f5a-4b9c-9a4c-564310acee1b@kernel.org  [2]
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Shengming Hu <hu.shengming@zte.com.cn>
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 lib/tests/slub_kunit.c | 167 +++++++++++++++++++++++++++++++++++--------------
 mm/slub.c              |  36 ++++++++---
 2 files changed, 148 insertions(+), 55 deletions(-)

diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index fa6d31dbca16..8c2b9911471e 100644
--- a/lib/tests/slub_kunit.c
+++ b/lib/tests/slub_kunit.c
@@ -8,6 +8,7 @@
 #include <linux/rcupdate.h>
 #include <linux/delay.h>
 #include <linux/perf_event.h>
+#include <linux/kprobes.h>
 #include "../mm/slab.h"
 
 static struct kunit_resource resource;
@@ -292,7 +293,7 @@ static void test_krealloc_redzone_zeroing(struct kunit *test)
 	kmem_cache_destroy(s);
 }
 
-#ifdef CONFIG_PERF_EVENTS
+#if defined(CONFIG_PERF_EVENTS) || (defined(CONFIG_KPROBES) && defined(CONFIG_SMP))
 #define NR_ITERATIONS 1000
 #define NR_OBJECTS 1000
 static void *objects[NR_OBJECTS];
@@ -302,26 +303,40 @@ struct test_nolock_context {
 	int callback_count;
 	int alloc_ok;
 	int alloc_fail;
+#ifdef CONFIG_PERF_EVENTS
 	struct perf_event *event;
+#endif
+#if defined(CONFIG_KPROBES) && defined(CONFIG_SMP)
+	struct kprobe kprobe;
+#endif
 };
 
-static struct perf_event_attr hw_attr = {
-	.type = PERF_TYPE_HARDWARE,
-	.config = PERF_COUNT_HW_CPU_CYCLES,
-	.size = sizeof(struct perf_event_attr),
-	.pinned = 1,
-	.disabled = 1,
-	.freq = 1,
-	.sample_freq = 100000,
-};
+static void test_kmalloc_kfree(void)
+{
+	int i, j;
+
+	for (i = 0; i < NR_ITERATIONS; i++) {
+		for (j = 0; j < NR_OBJECTS; j++) {
+			gfp_t gfp = (i % 2) ? GFP_KERNEL : GFP_KERNEL_ACCOUNT;
+
+			objects[j] = kmalloc(64, gfp);
+			if (!objects[j]) {
+				j--;
+				while (j >= 0)
+					kfree(objects[j--]);
+				return;
+			}
+		}
+
+		for (j = 0; j < NR_OBJECTS; j++)
+			kfree(objects[j]);
+	}
+}
 
-static void overflow_handler_test_kmalloc_kfree_nolock(struct perf_event *event,
-						       struct perf_sample_data *data,
-						       struct pt_regs *regs)
+static void test_nolock(struct test_nolock_context *ctx)
 {
 	void *objp;
 	gfp_t gfp;
-	struct test_nolock_context *ctx = event->overflow_handler_context;
 
 	/* __GFP_ACCOUNT to test kmalloc_nolock() in alloc_slab_obj_exts() */
 	gfp = (ctx->callback_count % 2) ? 0 : __GFP_ACCOUNT;
@@ -335,47 +350,104 @@ static void overflow_handler_test_kmalloc_kfree_nolock(struct perf_event *event,
 	kfree_nolock(objp);
 	ctx->callback_count++;
 }
+#endif
+
+#ifdef CONFIG_PERF_EVENTS
+static struct perf_event_attr hw_attr = {
+	.type = PERF_TYPE_HARDWARE,
+	.config = PERF_COUNT_HW_CPU_CYCLES,
+	.size = sizeof(struct perf_event_attr),
+	.pinned = 1,
+	.disabled = 1,
+	.freq = 1,
+	.sample_freq = 100000,
+};
 
-static void test_kmalloc_kfree_nolock(struct kunit *test)
+static void overflow_handler_test_nolock(struct perf_event *event,
+					 struct perf_sample_data *data,
+					 struct pt_regs *regs)
+{
+	struct test_nolock_context *ctx = event->overflow_handler_context;
+
+	test_nolock(ctx);
+}
+
+static bool enable_perf_events(struct test_nolock_context *ctx)
 {
-	int i, j;
-	struct test_nolock_context ctx = { .test = test };
 	struct perf_event *event;
-	bool alloc_fail = false;
 
 	event = perf_event_create_kernel_counter(&hw_attr, -1, current,
-						 overflow_handler_test_kmalloc_kfree_nolock,
-						 &ctx);
+						 overflow_handler_test_nolock,
+						 ctx);
+
 	if (IS_ERR(event))
-		kunit_skip(test, "Failed to create perf event");
-	ctx.event = event;
-	perf_event_enable(ctx.event);
-	for (i = 0; i < NR_ITERATIONS; i++) {
-		for (j = 0; j < NR_OBJECTS; j++) {
-			gfp_t gfp = (i % 2) ? GFP_KERNEL : GFP_KERNEL_ACCOUNT;
+		return false;
 
-			objects[j] = kmalloc(64, gfp);
-			if (!objects[j]) {
-				j--;
-				while (j >= 0)
-					kfree(objects[j--]);
-				alloc_fail = true;
-				goto cleanup;
-			}
-		}
-		for (j = 0; j < NR_OBJECTS; j++)
-			kfree(objects[j]);
-	}
+	ctx->event = event;
+	perf_event_enable(ctx->event);
+	return true;
+}
+
+static void disable_perf_events(struct test_nolock_context *ctx)
+{
+	kunit_info(ctx->test, "HW perf events: callback_count: %d, alloc_ok: %d, alloc_fail: %d\n",
+		   ctx->callback_count, ctx->alloc_ok, ctx->alloc_fail);
+
+	perf_event_disable(ctx->event);
+	perf_event_release_kernel(ctx->event);
+}
+
+static void test_kmalloc_kfree_nolock_perf(struct kunit *test)
+{
+	struct test_nolock_context ctx = { .test = test };
+
+	if (!enable_perf_events(&ctx))
+		kunit_skip(test, "Failed to enable perf event, skipping");
+
+	test_kmalloc_kfree();
+
+	disable_perf_events(&ctx);
+	KUNIT_EXPECT_EQ(test, 0, slab_errors);
+}
+#endif
+
+#if defined(CONFIG_KPROBES) && defined(CONFIG_SMP)
+static int slab_kprobe_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct test_nolock_context *ctx;
+
+	ctx = container_of(p, struct test_nolock_context, kprobe);
+	test_nolock(ctx);
+	return 0;
+}
+
+static bool register_slab_kprobes(struct test_nolock_context *ctx)
+{
+	ctx->kprobe.symbol_name = "slab_attach_kprobe_locked";
+	ctx->kprobe.pre_handler = slab_kprobe_pre_handler;
+
+	if (register_kprobe(&ctx->kprobe))
+		return false;
+	return true;
+}
+
+static void unregister_slab_kprobes(struct test_nolock_context *ctx)
+{
+	kunit_info(ctx->test, "kprobes: callback_count: %d, alloc_ok: %d, alloc_fail: %d\n",
+		   ctx->callback_count, ctx->alloc_ok, ctx->alloc_fail);
+	unregister_kprobe(&ctx->kprobe);
+}
+
+static void test_kmalloc_kfree_nolock_kprobe(struct kunit *test)
+{
+	struct test_nolock_context ctx = { .test = test };
 
-cleanup:
-	perf_event_disable(ctx.event);
-	perf_event_release_kernel(ctx.event);
+	if (!register_slab_kprobes(&ctx))
+		kunit_skip(test, "Failed to register kprobe, skipping");
 
-	kunit_info(test, "callback_count: %d, alloc_ok: %d, alloc_fail: %d\n",
-		   ctx.callback_count, ctx.alloc_ok, ctx.alloc_fail);
+	test_kmalloc_kfree();
 
-	if (alloc_fail)
-		kunit_skip(test, "Allocation failed");
+	unregister_slab_kprobes(&ctx);
 	KUNIT_EXPECT_EQ(test, 0, slab_errors);
 }
 #endif
@@ -405,7 +477,10 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_leak_destroy),
 	KUNIT_CASE(test_krealloc_redzone_zeroing),
 #ifdef CONFIG_PERF_EVENTS
-	KUNIT_CASE_SLOW(test_kmalloc_kfree_nolock),
+	KUNIT_CASE_SLOW(test_kmalloc_kfree_nolock_perf),
+#endif
+#if defined(CONFIG_KPROBES) && defined(CONFIG_SMP)
+	KUNIT_CASE_SLOW(test_kmalloc_kfree_nolock_kprobe),
 #endif
 	{}
 };
diff --git a/mm/slub.c b/mm/slub.c
index 691977e8c09d..d14226ad0982 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -905,6 +905,24 @@ static inline void slab_set_obj_exts_in_object(struct slab *slab)
 }
 #endif
 
+/*
+ * A no-op function used to attach kprobe handlers in slub_kunit tests.
+ * The barrier is needed to prevent the compiler from optimizing out callsites.
+ */
+#if defined(CONFIG_DEBUG_VM) || defined(CONFIG_PROVE_LOCKING)
+static noinline void slab_attach_kprobe_locked(void)
+{
+	barrier();
+}
+#else
+static inline void slab_attach_kprobe_locked(void) { }
+#endif
+
+#define slab_lockdep_assert_held(lock) do {	\
+	lockdep_assert_held(lock);		\
+	slab_attach_kprobe_locked();	\
+} while (0)
+
 #ifdef CONFIG_SLUB_DEBUG
 
 /*
@@ -1662,7 +1680,7 @@ static void add_full(struct kmem_cache *s,
 	if (!(s->flags & SLAB_STORE_USER))
 		return;
 
-	lockdep_assert_held(&n->list_lock);
+	slab_lockdep_assert_held(&n->list_lock);
 	list_add(&slab->slab_list, &n->full);
 }
 
@@ -1671,7 +1689,7 @@ static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct
 	if (!(s->flags & SLAB_STORE_USER))
 		return;
 
-	lockdep_assert_held(&n->list_lock);
+	slab_lockdep_assert_held(&n->list_lock);
 	list_del(&slab->slab_list);
 }
 
@@ -2884,7 +2902,7 @@ static unsigned int __sheaf_flush_main_batch(struct kmem_cache *s)
 	void *objects[PCS_BATCH_MAX];
 	struct slab_sheaf *sheaf;
 
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
+	slab_lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 	sheaf = pcs->main;
@@ -3568,7 +3586,7 @@ __add_partial(struct kmem_cache_node *n, struct slab *slab, enum add_mode mode)
 static inline void add_partial(struct kmem_cache_node *n,
 				struct slab *slab, enum add_mode mode)
 {
-	lockdep_assert_held(&n->list_lock);
+	slab_lockdep_assert_held(&n->list_lock);
 	__add_partial(n, slab, mode);
 }
 
@@ -3582,7 +3600,7 @@ static inline void clear_node_partial_state(struct kmem_cache_node *n,
 static inline void remove_partial(struct kmem_cache_node *n,
 					struct slab *slab)
 {
-	lockdep_assert_held(&n->list_lock);
+	slab_lockdep_assert_held(&n->list_lock);
 	list_del(&slab->slab_list);
 	clear_node_partial_state(n, slab);
 }
@@ -3598,7 +3616,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
 {
 	void *object;
 
-	lockdep_assert_held(&n->list_lock);
+	slab_lockdep_assert_held(&n->list_lock);
 
 #ifdef CONFIG_SLUB_DEBUG
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
@@ -4663,7 +4681,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct node_barn *barn;
 	bool allow_spin;
 
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
+	slab_lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
 	/* Bootstrap or debug cache, back off */
 	if (unlikely(!cache_has_sheaves(s))) {
@@ -5788,7 +5806,7 @@ static void __pcs_install_empty_sheaf(struct kmem_cache *s,
 		struct slub_percpu_sheaves *pcs, struct slab_sheaf *empty,
 		struct node_barn *barn)
 {
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
+	slab_lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
 	/* This is what we expect to find if nobody interrupted us. */
 	if (likely(!pcs->spare)) {
@@ -5839,7 +5857,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	bool put_fail;
 
 restart:
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
+	slab_lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
 	/* Bootstrap or debug cache, back off */
 	if (unlikely(!cache_has_sheaves(s))) {

-- 
2.53.0

