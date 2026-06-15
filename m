Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246153E2AD7;
	Mon, 15 Jun 2026 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521641; cv=none; b=G8/5lRUC3pF4SXLbCY5TCii14coQ5+mnltuIpUtkZ2lgUbDyhlWt3HiT/LwJ0LYXkzkayuOUAUZx7HucExO9W44zz7fipJszgtc0gIAACY6uO4Pv/uU4LQo5XR6zByeyhrJFgpfB0pNCroz8n/NDSvTfxxhXjWrEDIj7yn6pTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521641; c=relaxed/simple;
	bh=GifuJKxZKKiWFUKhUOsAMHxsL8DhwCicXNljkVI8ExQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQYp9ycgO6k8mIul5kgbzXYXOjKCTFwmoHLPmlMMpSKre9ehq4afWZju60qp4eDVOLdRsiDU/Sf1Y6r4Gba92AU7KXkTsT9k2U9/SfzhuvtE6kja6zJm8w5FzglUQSLGIuRQ3JY3rLeYatR3clsbwddoVC3jfa/cJ/u9ZiYiBHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok05IY9h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok05IY9h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E811F00A3A;
	Mon, 15 Jun 2026 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781521639;
	bh=alw5HkCTiTdHCndsz3LKMMxy51B8ZMiiU4H9kP+lPXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ok05IY9hDxqFSvOMGbiJhAqKJrAvhilMe/yiZa/x/NCFYVEgFIgWqE3p95bLknrRc
	 U4fKogysbNvoJiIg8J2l3ZpscbhAS+tfD1/xqyGSSQBpvLEQy224NpcUVDheeaHsDj
	 heHwLnTiGf/e70zkq43DWD5YIxoYCNwcmt3FzDgmGy4aGaNCT9hJKL7T2zUP3/Nzsr
	 uNqRWaN3ZVjjmFut8Xzh2qOlp9WzqSwIANUqdWLd8rxKQi59Tgv1IrR1uuuB30m/y3
	 zn2wu/LLHf/xG8OdnpoYEDsXvIA4FXbZhbB6xDHLesBpcv6EHloGjd8+soJiTHTxZM
	 kca4UZ4Ve702Q==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Mon, 15 Jun 2026 20:06:03 +0900
Subject: [PATCH for-next v3 9/9] slub_kunit: extend the test for
 kfree_rcu_nolock()
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-kfree_rcu_nolock-v3-9-70a54f3775bb@kernel.org>
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

When slub_kunit is not built-in, call kfree_rcu() and kfree_rcu_nolock()
to test kfree_rcu_nolock() in slub_kunit.

Rename the test case as the test covers more _nolock() APIs.

Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 lib/tests/slub_kunit.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index 01d808cb77fa..6ed4de88bf0b 100644
--- a/lib/tests/slub_kunit.c
+++ b/lib/tests/slub_kunit.c
@@ -162,7 +162,10 @@ static void test_kmalloc_redzone_access(struct kunit *test)
 }
 
 struct test_kfree_rcu_struct {
-	struct rcu_head rcu;
+	union {
+		struct rcu_head rcu;
+		struct kfree_rcu_head krcu;
+	};
 };
 
 static void test_kfree_rcu(struct kunit *test)
@@ -294,10 +297,10 @@ static void test_krealloc_redzone_zeroing(struct kunit *test)
 }
 
 #if defined(CONFIG_PERF_EVENTS) || (defined(CONFIG_KPROBES) && defined(CONFIG_SMP))
-#define SLUB_KUNIT_TEST_KMALLOC_KFREE_NOLOCK
+#define SLUB_KUNIT_TEST_KMALLOC_NOLOCK_AND_FRIENDS
 #define NR_ITERATIONS 1000
 #define NR_OBJECTS 1000
-static void *objects[NR_OBJECTS];
+static struct test_kfree_rcu_struct *objects[NR_OBJECTS];
 
 struct test_nolock_context {
 	struct kunit *test;
@@ -336,19 +339,24 @@ static struct perf_event_attr sw_attr = {
 
 static void test_nolock(struct test_nolock_context *ctx)
 {
-	void *objp;
+	struct test_kfree_rcu_struct *objp;
 	gfp_t gfp;
+	bool can_use_kfree_rcu = !IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST);
 
 	/* __GFP_ACCOUNT to test kmalloc_nolock() in alloc_slab_obj_exts() */
 	gfp = (ctx->callback_count % 2) ? 0 : __GFP_ACCOUNT;
-	objp = kmalloc_nolock(64, gfp, NUMA_NO_NODE);
+	objp = kmalloc_nolock(sizeof(*objp), gfp, NUMA_NO_NODE);
 
 	if (objp)
 		ctx->alloc_ok++;
 	else
 		ctx->alloc_fail++;
 
-	kfree_nolock(objp);
+	if (can_use_kfree_rcu && (ctx->callback_count % 2))
+		kfree_rcu_nolock(objp, krcu);
+	else
+		kfree_nolock(objp);
+
 	ctx->callback_count++;
 }
 
@@ -432,12 +440,13 @@ static bool register_slab_kprobes(struct test_nolock_context *ctx) { return fals
 static void unregister_slab_kprobes(struct test_nolock_context *ctx) { }
 #endif
 
-static void test_kmalloc_kfree_nolock(struct kunit *test)
+static void test_kmalloc_nolock_and_friends(struct kunit *test)
 {
 	int i, j;
 	struct test_nolock_context perf_ctx = { .test = test };
 	struct test_nolock_context kprobe_ctx = { .test = test };
 	bool alloc_fail = false;
+	bool can_use_kfree_rcu = !IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST);
 	bool perf_events_enabled;
 	bool slab_kprobes_enabled;
 
@@ -455,7 +464,7 @@ static void test_kmalloc_kfree_nolock(struct kunit *test)
 		for (j = 0; j < NR_OBJECTS; j++) {
 			gfp_t gfp = (i % 2) ? GFP_KERNEL : GFP_KERNEL_ACCOUNT;
 
-			objects[j] = kmalloc(64, gfp);
+			objects[j] = kmalloc_obj(*objects[j], gfp);
 			if (!objects[j]) {
 				j--;
 				while (j >= 0)
@@ -464,8 +473,13 @@ static void test_kmalloc_kfree_nolock(struct kunit *test)
 				goto cleanup;
 			}
 		}
-		for (j = 0; j < NR_OBJECTS; j++)
-			kfree(objects[j]);
+
+		for (j = 0; j < NR_OBJECTS; j++) {
+			if (can_use_kfree_rcu && (i % 2))
+				kfree_rcu(objects[j], rcu);
+			else
+				kfree(objects[j]);
+		}
 	}
 
 cleanup:
@@ -504,8 +518,8 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_kfree_rcu_wq_destroy),
 	KUNIT_CASE(test_leak_destroy),
 	KUNIT_CASE(test_krealloc_redzone_zeroing),
-#ifdef SLUB_KUNIT_TEST_KMALLOC_KFREE_NOLOCK
-	KUNIT_CASE_SLOW(test_kmalloc_kfree_nolock),
+#ifdef SLUB_KUNIT_TEST_KMALLOC_NOLOCK_AND_FRIENDS
+	KUNIT_CASE_SLOW(test_kmalloc_nolock_and_friends),
 #endif
 	{}
 };

-- 
2.53.0

