Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627BB378D9E
	for <rcu@vger.kernel.org>; Thu, 16 Apr 2026 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330654; cv=none; b=U1AE34Zw0mTqN/VQ3zkvJJ07NWtOz6ULwr3rrqrgjJHYeDwO4dNpkGYR6u7BhfIALOByUaY1xXyVRahVYKrmWvsEtOUscKWa7TquELzjOtNto//xra3lsDIL7BIP2JstawjHXagUg0vaKB/TxmUCWXY7rEoIG/SWWAIDubuHhXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330654; c=relaxed/simple;
	bh=LATxRaCRQ+I6DOtBbEo4sXyXtR4wOYD3wcNo4oJIen8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVzPvujO3r8FRk3wi7eSS+dw9DxXDKmLyWsbUom8Xe6nRflJaoSZD8P/iBMwKscPWIRpZUzPBAtK0c0Doa9V4ApE/Xn1tWQa04ZpsJSTdkxIvKBGe4dxgrU6hXUF9D0jCOPjj5yXp5ZuCVmbBXN6ncnHpnj0myczH9Uq4e7ap5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxTiqn9W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxTiqn9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620A1C2BCAF;
	Thu, 16 Apr 2026 09:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776330654;
	bh=LATxRaCRQ+I6DOtBbEo4sXyXtR4wOYD3wcNo4oJIen8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxTiqn9WdOiYD8TTOctyYBTJnnfrMrkIeNLNCEcJUxewnXGOtMLXNR6lFgs0Ktc+q
	 eok+ngmcTckSQlufgwP6MTzr62gQDBmhMxcHJM1BrCXAf+NKX05bWz0fKIvtvH3cr2
	 h7J9ruuVqla1sjjCnOamlY3HpVfPvBsOLvqogelghkjecKWUdknjSFsE31BhrucK9n
	 WcRYB0+q7cGDsU3KU+ismnHqij89BchWGuXefNClV+Kg7D530uUo33F2DBEqXOFjQ5
	 nabrjLq8llo2lYf14wSCqMvQWGkqdik7Z6TPiaoaW39Hd+LXWZChWcStVyolkIzQNK
	 7rDdRACbh2U8g==
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
Subject: [PATCH 8/8] lib/tests/slub_kunit: add a test case for kfree_rcu_nolock()
Date: Thu, 16 Apr 2026 18:10:22 +0900
Message-ID: <20260416091022.36823-9-harry@kernel.org>
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

Similar to test_kmalloc_kfree_nolock, add a test that allocates objects
via kmalloc_nolock() and frees them via kfree_rcu_nolock() in a perf
overflow handler (NMI or hardirq depending on the arch), while the main
loop allocates and frees objects via kmalloc() and kfree_rcu().

Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 lib/tests/slub_kunit.c | 73 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index fa6d31dbca16..f8d979912246 100644
--- a/lib/tests/slub_kunit.c
+++ b/lib/tests/slub_kunit.c
@@ -367,6 +367,78 @@ static void test_kmalloc_kfree_nolock(struct kunit *test)
 			kfree(objects[j]);
 	}
 
+cleanup:
+	perf_event_disable(ctx.event);
+	perf_event_release_kernel(ctx.event);
+
+	kunit_info(test, "callback_count: %d, alloc_ok: %d, alloc_fail: %d\n",
+		   ctx.callback_count, ctx.alloc_ok, ctx.alloc_fail);
+
+	if (alloc_fail)
+		kunit_skip(test, "Allocation failed");
+	KUNIT_EXPECT_EQ(test, 0, slab_errors);
+}
+
+struct dummy_struct {
+	struct rcu_ptr rcu;
+};
+
+static void overflow_handler_test_kfree_rcu_nolock(struct perf_event *event,
+						   struct perf_sample_data *data,
+						   struct pt_regs *regs)
+{
+	struct dummy_struct *dummy;
+	gfp_t gfp;
+	struct test_nolock_context *ctx = event->overflow_handler_context;
+
+	/* __GFP_ACCOUNT to test kmalloc_nolock() in alloc_slab_obj_exts() */
+	gfp = (ctx->callback_count % 2) ? 0 : __GFP_ACCOUNT;
+	dummy = kmalloc_nolock(sizeof(*dummy), gfp, NUMA_NO_NODE);
+
+	if (dummy) {
+		ctx->alloc_ok++;
+		kfree_rcu_nolock(dummy, rcu);
+	} else {
+		ctx->alloc_fail++;
+	}
+	ctx->callback_count++;
+}
+
+static void test_kfree_rcu_nolock(struct kunit *test)
+{
+	int i, j;
+	struct test_nolock_context ctx = { .test = test };
+	struct perf_event *event;
+	bool alloc_fail = false;
+	struct dummy_struct *dummy;
+
+	if (IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST))
+		kunit_skip(test, "can't do kfree_rcu_nolock() when test is built-in");
+
+	event = perf_event_create_kernel_counter(&hw_attr, -1, current,
+						 overflow_handler_test_kfree_rcu_nolock,
+						 &ctx);
+	if (IS_ERR(event))
+		kunit_skip(test, "Failed to create perf event");
+	ctx.event = event;
+	perf_event_enable(ctx.event);
+	for (i = 0; i < NR_ITERATIONS; i++) {
+		for (j = 0; j < NR_OBJECTS; j++) {
+			gfp_t gfp = (i % 2) ? GFP_KERNEL : GFP_KERNEL_ACCOUNT;
+
+			objects[j] = kmalloc(sizeof(*dummy), gfp);
+			if (!objects[j]) {
+				j--;
+				while (j >= 0)
+					kfree(objects[j--]);
+				alloc_fail = true;
+				goto cleanup;
+			}
+		}
+		for (j = 0; j < NR_OBJECTS; j++)
+			kfree_rcu((struct dummy_struct *)objects[j], rcu);
+	}
+
 cleanup:
 	perf_event_disable(ctx.event);
 	perf_event_release_kernel(ctx.event);
@@ -406,6 +478,7 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_krealloc_redzone_zeroing),
 #ifdef CONFIG_PERF_EVENTS
 	KUNIT_CASE_SLOW(test_kmalloc_kfree_nolock),
+	KUNIT_CASE_SLOW(test_kfree_rcu_nolock),
 #endif
 	{}
 };
-- 
2.43.0

