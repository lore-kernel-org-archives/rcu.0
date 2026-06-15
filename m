Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BB7371D02;
	Mon, 15 Jun 2026 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521590; cv=none; b=FNsaASJp1RCRDCRIGqsQN2xxKJ/HNPZ1e2v4EXQ05+zA/lCA6+4BiS8hIcTc4Q+w530MvaCvSg/Xo7AFtCvqMaMswbfCCwBDohsI3odvFajheAFLC95itcErDxeOUw/bvMfk0bxuWpXKyihHSsSVnjwFSNQbwOEO5OjvuPWob7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521590; c=relaxed/simple;
	bh=96CG0nVCSuVj+oiUYYBdM+rVMjLaSP4tAkxaNsYutdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YC7mEiLHnHzxgOVg4nrpEAhA1SONe1dS0Z+Gk/SNm1NgWGwXkYCggZ95MlXtjmpgLnyb1byy5h5M1Z7y094ePVnxQmmjQKlDYTA5eWOwnY10aPuab27ILb31B8pPSh6A5tdX1SJS/xz2I73PdJFbSQMm8/4hwmDx1R2WyY00JIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5H9yP13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5H9yP13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74711F00A3A;
	Mon, 15 Jun 2026 11:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781521588;
	bh=E2F1Wu57D1KXCqh6uiw1Q3ldSnxREhsNBlfWv4bIRtA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D5H9yP13aY80Y2xhF3JVFFWrN4W6dVhuuI98KQ1YDvo9Oe+drurxdalTUrkaNxWan
	 MJ8PK7fLtFxF17cr1WLl59X4KWuqN30d8C3NIwxXzUoGelQI5yRBYCq7QJI2RQG2FK
	 7rI14rO8PhCEjL4SSIeMBmXZJaMYLz5kkUIssGlrNvJKDK7HxklEcDiz8eOHb9b87Y
	 oe8uN7kAHB5l1RMZi7UjMLExpg5IfJGOoYGvMuOR+aL6LfJY3b50n3W82P9mCBq4kS
	 /UKC0Jv0lfHdBb1M5fruzj5V0ORmMIYUltVzp2eYdYK9p8iJVsimFM6RP3TJjFo1zd
	 +ze5sN3apHUsQ==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Mon, 15 Jun 2026 20:05:55 +0900
Subject: [PATCH for-next v3 1/9] slub_kunit: fall back to SW perf events
 when HW PMU is not available
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-kfree_rcu_nolock-v3-1-70a54f3775bb@kernel.org>
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

slub_kunit uses hardware perf events to invoke _nolock() APIs from NMI
context. However, creating a HW perf event fails when there is no
hardware PMU, or when running in a virtualized environment without a
virtual PMU configured.

Since tests are often performed in virtualized environments, fall back
to a SW perf event so that the test can still run, even if it cannot
cover IRQ-disabled sections.

For the sheaves path, IRQs are not disabled until the barn is accessed.
So some coverage is still expected.

Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 lib/tests/slub_kunit.c | 70 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index fa6d31dbca16..11255fc8eb78 100644
--- a/lib/tests/slub_kunit.c
+++ b/lib/tests/slub_kunit.c
@@ -303,6 +303,7 @@ struct test_nolock_context {
 	int alloc_ok;
 	int alloc_fail;
 	struct perf_event *event;
+	bool is_perf_type_hw;
 };
 
 static struct perf_event_attr hw_attr = {
@@ -315,9 +316,19 @@ static struct perf_event_attr hw_attr = {
 	.sample_freq = 100000,
 };
 
-static void overflow_handler_test_kmalloc_kfree_nolock(struct perf_event *event,
-						       struct perf_sample_data *data,
-						       struct pt_regs *regs)
+/* Fallback when hardware perf event is not available */
+static struct perf_event_attr sw_attr = {
+	.type = PERF_TYPE_SOFTWARE,
+	.config = PERF_COUNT_SW_CPU_CLOCK,
+	.size = sizeof(struct perf_event_attr),
+	.disabled = 1,
+	.freq = 1,
+	.sample_freq = 100000,
+};
+
+static void overflow_handler_test_nolock(struct perf_event *event,
+					 struct perf_sample_data *data,
+					 struct pt_regs *regs)
 {
 	void *objp;
 	gfp_t gfp;
@@ -336,20 +347,53 @@ static void overflow_handler_test_kmalloc_kfree_nolock(struct perf_event *event,
 	ctx->callback_count++;
 }
 
+static bool enable_perf_events(struct test_nolock_context *ctx)
+{
+	struct perf_event *event;
+
+	ctx->is_perf_type_hw = true;
+	event = perf_event_create_kernel_counter(&hw_attr, -1, current,
+						 overflow_handler_test_nolock,
+						 ctx);
+
+	if (!IS_ERR(event))
+		goto out;
+
+	ctx->is_perf_type_hw = false;
+	event = perf_event_create_kernel_counter(&sw_attr, -1, current,
+						 overflow_handler_test_nolock,
+						 ctx);
+	if (!IS_ERR(event))
+		goto out;
+
+	return false;
+out:
+	ctx->event = event;
+	perf_event_enable(ctx->event);
+	return true;
+}
+
+static void disable_perf_events(struct test_nolock_context *ctx)
+{
+	kunit_info(ctx->test, "%s perf events: callback_count: %d, alloc_ok: %d, alloc_fail: %d\n",
+		   ctx->is_perf_type_hw ? "HW" : "SW",
+		   ctx->callback_count, ctx->alloc_ok, ctx->alloc_fail);
+
+	perf_event_disable(ctx->event);
+	perf_event_release_kernel(ctx->event);
+}
+
 static void test_kmalloc_kfree_nolock(struct kunit *test)
 {
 	int i, j;
 	struct test_nolock_context ctx = { .test = test };
-	struct perf_event *event;
 	bool alloc_fail = false;
+	bool perf_events_enabled;
 
-	event = perf_event_create_kernel_counter(&hw_attr, -1, current,
-						 overflow_handler_test_kmalloc_kfree_nolock,
-						 &ctx);
-	if (IS_ERR(event))
+	perf_events_enabled = enable_perf_events(&ctx);
+	if (!perf_events_enabled)
 		kunit_skip(test, "Failed to create perf event");
-	ctx.event = event;
-	perf_event_enable(ctx.event);
+
 	for (i = 0; i < NR_ITERATIONS; i++) {
 		for (j = 0; j < NR_OBJECTS; j++) {
 			gfp_t gfp = (i % 2) ? GFP_KERNEL : GFP_KERNEL_ACCOUNT;
@@ -368,11 +412,7 @@ static void test_kmalloc_kfree_nolock(struct kunit *test)
 	}
 
 cleanup:
-	perf_event_disable(ctx.event);
-	perf_event_release_kernel(ctx.event);
-
-	kunit_info(test, "callback_count: %d, alloc_ok: %d, alloc_fail: %d\n",
-		   ctx.callback_count, ctx.alloc_ok, ctx.alloc_fail);
+	disable_perf_events(&ctx);
 
 	if (alloc_fail)
 		kunit_skip(test, "Allocation failed");

-- 
2.53.0

