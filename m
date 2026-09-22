Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E406949A3C0;
	Tue, 22 Sep 2026 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107370; cv=none; b=jT844s5802GqA1Q7kfXGXbLxOuYnPHXsVpiX2bQpuu+h6jYi3kMnPBOlUhYLoD3o1a1njnw3v962Q93sNVI8cNBl9mGICeNddYS+imfFNtAsSiIZz3nVxlvzrs55UC3YvCb1VrD4MawQXW/k+jNB+isOLq6IaFLtICenNmhk1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107370; c=relaxed/simple;
	bh=IkRmsfdBExIBxtjiu+lZsYMQUZlnD2yWZt+z8yrb94E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFygxP4jMTMHYWE4VCbiQ/KpCoYilbbRYY9Dtf3E3IvyDZP4BK8clnp+pLub4aM5pD7ARZMSGXlNCPJ5hsSUSJp4FVj6it03nAlly8CKrLUxNJ63cBtqIqoNeQnWLcIKJrhXzvZYc0fd8Ybz/NpP7QpJHXyIxh+h3OHeHZ7PSto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEH11SrZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEH11SrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E1B1F00898;
	Tue, 22 Sep 2026 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790107359;
	bh=4iYgu5wBk9/4O0EeidaMtW8II61oeJpmIhGsFzKZKOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QEH11SrZ4DbjcsL5xvJnHw/iRfBS5lxOA7zQeNMTOcToqR9Y68kiP3CccdHN6RM2b
	 pkH/EU5UnULNeK6xPGOgMOrne3o7MN17gpl2luCnUc4dsTLJFgbtdfzl1b+9tAa2ho
	 S7zAB2v8/kzFxjg1jYg/1sqnvhdi4odA9CopnHyHocxsGOeOU2K1qAkRJ2PnfRS0P4
	 ZREv/8rn16YJOyc5x9LPV60aPga1ZJ6c6JpkwaUyFCImIsEJx5KphUezrdk+D2ASxd
	 JWfcMDK8mqufTQNgXDnQZit3p6ycJT5KuDB3ZyuH34Mp9yTTh2JwfnZBoCeON2wUJj
	 AdSU0mVCWk2Ew==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH bpf-next v6 4/4] selftests/bpf: Add a test for bpf_call_rcu_tasks_trace()
Date: Tue, 22 Sep 2026 13:00:53 -0700
Message-ID: <20260922200208.3203834-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922200208.3203834-1-puranjay@kernel.org>
References: <20260922200208.3203834-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run the same functional test against the tasks trace flavour.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/call_rcu.c | 12 ++++++++----
 tools/testing/selftests/bpf/progs/call_rcu.c    | 17 +++++++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/call_rcu.c b/tools/testing/selftests/bpf/prog_tests/call_rcu.c
index bfa6512b9052a..e4d271d43d878 100644
--- a/tools/testing/selftests/bpf/prog_tests/call_rcu.c
+++ b/tools/testing/selftests/bpf/prog_tests/call_rcu.c
@@ -28,9 +28,10 @@ static bool wait_for_callbacks(struct call_rcu *skel, int expected)
 	return ASSERT_GE(got, expected, "callbacks");
 }
 
-static void test_call_rcu_run(void)
+static void test_call_rcu_run(bool trace)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct bpf_program *prog;
 	struct call_rcu *skel;
 	struct elem elem;
 	__u32 key = 1;
@@ -40,7 +41,8 @@ static void test_call_rcu_run(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
 		return;
 
-	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm), &opts);
+	prog = trace ? skel->progs.arm_trace : skel->progs.arm;
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
 	if (!ASSERT_OK(err, "test_run") || !ASSERT_EQ(opts.retval, 0, "retval"))
 		goto out;
 
@@ -59,7 +61,7 @@ static void test_call_rcu_run(void)
 		ASSERT_EQ(elem.val, 0, "value_cleared");
 
 	/* The head is disarmed before the callback runs, so it can be reused. */
-	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm), &opts);
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
 	if (!ASSERT_OK(err, "test_run_again"))
 		goto out;
 	ASSERT_EQ(skel->bss->arm_err, 0, "rearm_err");
@@ -254,7 +256,9 @@ static void test_call_rcu_two_heads(void)
 void test_call_rcu(void)
 {
 	if (test__start_subtest("run"))
-		test_call_rcu_run();
+		test_call_rcu_run(false);
+	if (test__start_subtest("run_tasks_trace"))
+		test_call_rcu_run(true);
 	if (test__start_subtest("chain"))
 		test_call_rcu_chain();
 	if (test__start_subtest("two_heads"))
diff --git a/tools/testing/selftests/bpf/progs/call_rcu.c b/tools/testing/selftests/bpf/progs/call_rcu.c
index 94d92cee88a70..505008647fd6f 100644
--- a/tools/testing/selftests/bpf/progs/call_rcu.c
+++ b/tools/testing/selftests/bpf/progs/call_rcu.c
@@ -86,6 +86,23 @@ int arm_both(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+int arm_trace(void *ctx)
+{
+	__u32 key = 1;
+	struct elem *e;
+
+	e = bpf_map_lookup_elem(&arr, &key);
+	if (!e)
+		return 1;
+
+	e->val = 0xdeadbeef;
+	/* No lock needed: the enclosing rcu_read_lock_trace() already blocks the grace period. */
+	arm_err = bpf_call_rcu_tasks_trace(&e->rh, &arr, reclaim);
+	busy_err = bpf_call_rcu_tasks_trace(&e->rh, &arr, reclaim);
+	return 0;
+}
+
 SEC("iter/bpf_map_elem")
 int dump(struct bpf_iter__bpf_map_elem *ctx)
 {
-- 
2.53.0-Meta

