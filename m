Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106141737D;
	Mon, 20 Jul 2026 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551577; cv=none; b=Nbr4B2bukTQZxeB1S5t7RaHQSmdStufBp7dF1gBpWh10ZJxcY3TWv+lUnGEVcfzP4f73NMQX2uILSCKxMSapFT3W57SrzGKqfjm67/0hrI66x7V6B1nPTXuPxrdpZq9nYMLYlaqV4//sz97eILTztMzUg0PzeQaPEMoiqeu+p8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551577; c=relaxed/simple;
	bh=rTl/DxJagCa+9Hy+ONCJKy/uvlP3BJsWT2MiI42DyvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lNVqYu6haL+DqKKqXPyKJKSbo8XsS+IAYe84kL7pYATg2DmB7ncPxXap10p9XG+paCa1T5ZO1ipB8CLlYK3QVVB2p5qjAFmX4dv6fXTPeh60HSVfm+3pN6Ak0PDIkf/4lT6a87Bpsk7y+mj1I3c5HB0yHtA6Jtufd6y/l8CjSCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDvhW/pe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDvhW/pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BE51F00A3D;
	Mon, 20 Jul 2026 12:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784551576;
	bh=8Mf6ICl8QV0PyvQov1wiSUifOBTOQefLFAPMuDN3x10=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HDvhW/peMepVeAoQL2dW+MaaHo1MGlQYb4TFy3R2tW14fKkWa7VZuh/s7cn77dzVq
	 sSUYzoDD0SiPfWqY6iHqc1QPDZJF4mfo7RDsW0xED6Ocm1iSrM006ijnC32MukKMJg
	 +M4A9DHP5vFdtw8YzVwC+FgASQzKKZ/7g8LmG1g7O925c6BlyXO/vrp/UVfT2tnXnB
	 f88Yo0i+2f8bKWy6EHEkO8A/eC2WpRLdVtXDEkY4qe1PwbwR5P2G2Y25t+7v1ZHSRf
	 BgXSa4nahdSdUJJPlQDjNhmC9dsQ5Q1yMC0NEV9C+gyKdIxG/GsiVQFZ1uaKW0ckTc
	 vj+VGSJbrqYpA==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Mon, 20 Jul 2026 21:44:37 +0900
Subject: [PATCH slab/for-next v4 8/8] slub_kunit: extend the test for
 kfree_rcu_nolock()
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-kfree_rcu_nolock-v4-8-964e03c41a4e@kernel.org>
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
In-Reply-To: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
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

When slub_kunit is not built-in, call kfree_rcu() and kfree_rcu_nolock()
to test kfree_rcu_nolock() in slub_kunit.

Rename the test case as the test covers more _nolock() APIs.

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 lib/tests/slub_kunit.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index a391467c1aa6..e3b63f0338d5 100644
--- a/lib/tests/slub_kunit.c
+++ b/lib/tests/slub_kunit.c
@@ -162,7 +162,10 @@ static void test_kmalloc_redzone_access(struct kunit *test)
 }
 
 struct test_kfree_rcu_struct {
-	struct rcu_head rcu;
+	union {
+		struct rcu_head rcu;
+		struct kvfree_rcu_head kvrcu;
+	};
 };
 
 static void test_kfree_rcu(struct kunit *test)
@@ -296,7 +299,7 @@ static void test_krealloc_redzone_zeroing(struct kunit *test)
 #if defined(CONFIG_PERF_EVENTS) || (defined(CONFIG_KPROBES) && defined(CONFIG_SMP))
 #define NR_ITERATIONS 1000
 #define NR_OBJECTS 1000
-static void *objects[NR_OBJECTS];
+static struct test_kfree_rcu_struct *objects[NR_OBJECTS];
 
 struct test_nolock_context {
 	struct kunit *test;
@@ -311,13 +314,14 @@ struct test_nolock_context {
 #endif
 };
 
-static void test_kmalloc_kfree(void)
+static void test_kmalloc_and_friends(void)
 {
 	int i, j;
+	bool can_use_kfree_rcu = !IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST);
 
 	for (i = 0; i < NR_ITERATIONS; i++) {
 		for (j = 0; j < NR_OBJECTS; j++) {
-			gfp_t gfp = (i % 2) ? GFP_KERNEL : GFP_KERNEL_ACCOUNT;
+			gfp_t gfp = (i & 1) ? GFP_KERNEL : GFP_KERNEL_ACCOUNT;
 
 			objects[j] = kmalloc_obj(*objects[j], gfp);
 			if (!objects[j]) {
@@ -328,26 +332,35 @@ static void test_kmalloc_kfree(void)
 			}
 		}
 
-		for (j = 0; j < NR_OBJECTS; j++)
-			kfree(objects[j]);
+		for (j = 0; j < NR_OBJECTS; j++) {
+			if (can_use_kfree_rcu && (i & 2))
+				kfree_rcu(objects[j], rcu);
+			else
+				kfree(objects[j]);
+		}
 	}
 }
 
 static void test_nolock(struct test_nolock_context *ctx)
 {
-	void *objp;
+	struct test_kfree_rcu_struct *objp;
 	gfp_t gfp;
+	bool can_use_kfree_rcu = !IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST);
 
 	/* __GFP_ACCOUNT to test kmalloc_nolock() in alloc_slab_obj_exts() */
-	gfp = (ctx->callback_count % 2) ? 0 : __GFP_ACCOUNT;
-	objp = kmalloc_nolock(64, gfp, NUMA_NO_NODE);
+	gfp = (ctx->callback_count & 1) ? 0 : __GFP_ACCOUNT;
+	objp = kmalloc_nolock(sizeof(*objp), gfp, NUMA_NO_NODE);
 
 	if (objp)
 		ctx->alloc_ok++;
 	else
 		ctx->alloc_fail++;
 
-	kfree_nolock(objp);
+	if (can_use_kfree_rcu && (ctx->callback_count & 2))
+		kfree_rcu_nolock(objp, kvrcu);
+	else
+		kfree_nolock(objp);
+
 	ctx->callback_count++;
 }
 #endif
@@ -397,14 +410,14 @@ static void disable_perf_events(struct test_nolock_context *ctx)
 	perf_event_release_kernel(ctx->event);
 }
 
-static void test_kmalloc_kfree_nolock_perf(struct kunit *test)
+static void test_kmalloc_nolock_and_friends_perf(struct kunit *test)
 {
 	struct test_nolock_context ctx = { .test = test };
 
 	if (!enable_perf_events(&ctx))
 		kunit_skip(test, "Failed to enable perf event, skipping");
 
-	test_kmalloc_kfree();
+	test_kmalloc_and_friends();
 
 	disable_perf_events(&ctx);
 	KUNIT_EXPECT_EQ(test, 0, slab_errors);
@@ -438,14 +451,14 @@ static void unregister_slab_kprobes(struct test_nolock_context *ctx)
 	unregister_kprobe(&ctx->kprobe);
 }
 
-static void test_kmalloc_kfree_nolock_kprobe(struct kunit *test)
+static void test_kmalloc_nolock_and_friends_kprobe(struct kunit *test)
 {
 	struct test_nolock_context ctx = { .test = test };
 
 	if (!register_slab_kprobes(&ctx))
 		kunit_skip(test, "Failed to register kprobe, skipping");
 
-	test_kmalloc_kfree();
+	test_kmalloc_and_friends();
 
 	unregister_slab_kprobes(&ctx);
 	KUNIT_EXPECT_EQ(test, 0, slab_errors);
@@ -477,10 +490,10 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_leak_destroy),
 	KUNIT_CASE(test_krealloc_redzone_zeroing),
 #ifdef CONFIG_PERF_EVENTS
-	KUNIT_CASE_SLOW(test_kmalloc_kfree_nolock_perf),
+	KUNIT_CASE_SLOW(test_kmalloc_nolock_and_friends_perf),
 #endif
 #if defined(CONFIG_KPROBES) && defined(CONFIG_SMP)
-	KUNIT_CASE_SLOW(test_kmalloc_kfree_nolock_kprobe),
+	KUNIT_CASE_SLOW(test_kmalloc_nolock_and_friends_kprobe),
 #endif
 	{}
 };

-- 
2.53.0

