Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD3839C006;
	Wed, 29 Jul 2026 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313316; cv=none; b=De6L3cPfQ8AyoZb8EkStcwbZwnqX5jRNsdB9slFukvn4JLCj6/U2UQrzumoo2asbvZk96ydVi7rCcWjmLedetTGZDYxHYb9CTgkkDk2VKLwymnl9/nWlA3fASou5SuZw0sK8G7WQDvdVLiMOKaUqOtpg+TPxKGI/NjoiV65G6J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313316; c=relaxed/simple;
	bh=pEit+LBwxHmHFgVdifKiVdt1Lat/ZS4nleuXr7OMXQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KnjtMYk7JS8sOoD28HcAu1dnooi3GHDZvQYZJq45O055a1FayQWQ2tDwAgWSiEueg7q6npkQ64IrXRIivL4wjo+DbVRNbCFyySp3NZWR4XwvkeiypWOETShJBZGPGInDRXKvoDew77WAXfKnA3qkhRcdRNsz53sK/khJeiifgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG3Ggfgb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG3Ggfgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057B01F00A3D;
	Wed, 29 Jul 2026 08:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785313306;
	bh=bQgXQ3LLqCfSQ6+KzSoXpszX0uTxmBCepjeRS5yTims=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XG3GgfgbwN5JSIG+Ed5Pb4FlPiIFQ826L07JPsO6aBK/Sg+x/F3TWY9hbXHJ41/ru
	 Pbk6jkGViyZpKlf7aZ4NQMKjfkK3l3++D2P9BIyUN6xgIFIIigs1iZz76vS5/lHsnt
	 5knwB9IeIWZHAldZlXGazvhy9furSjIxQDxQ+fYw41UtVnnEJBCsEaL1KvLSEi64p6
	 Znj/ZhHdpncq0IViJyq9wv5j9xCk7vJlI32tcu8ofOVsw5ID4ATjidUs09loM9ERLW
	 u00VSO0zQe+1R+qBjYbF0rDQylGtYItM/nNBwYUPcICmSX0/Js0ErTLOTU6L4D39Lh
	 rhpNnEkcmfIXA==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Wed, 29 Jul 2026 17:20:16 +0900
Subject: [PATCH v5 8/8] slub_kunit: extend the test for kfree_rcu_nolock()
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-kfree_rcu_nolock-v5-8-a28cdcda9673@kernel.org>
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

When slub_kunit is not built-in, call kfree_rcu() and kfree_rcu_nolock()
to test kfree_rcu_nolock() in slub_kunit.

Rename the test case as the test covers more _nolock() APIs.

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 lib/tests/slub_kunit.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index 8c2b9911471e..e3b63f0338d5 100644
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
@@ -311,15 +314,16 @@ struct test_nolock_context {
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
 
-			objects[j] = kmalloc(64, gfp);
+			objects[j] = kmalloc_obj(*objects[j], gfp);
 			if (!objects[j]) {
 				j--;
 				while (j >= 0)
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

