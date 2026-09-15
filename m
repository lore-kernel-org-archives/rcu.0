Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9CB4A3F05;
	Tue, 15 Sep 2026 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472604; cv=none; b=MZpShexa9WR2a8m21VMCTPj3kLLIOY1WTzmOiHa44vikg8YzJCjtdHk7uXOLXhWjbgMYedRbiBR9EkWXmwPvUgPwr5FJUPMKgaUcA8AbUIrneF7v+jIvNTAvY9eYcim3Q1JqwYg5baLJnj1f8hr6tjabR5TxFNUc+WnRItk3GyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472604; c=relaxed/simple;
	bh=rLAq/x/+esDuzuHTdmKrk+QwJOM40c7GhAbhRT9q7Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4GjnboOz8tPXY98HWheEUYwrtgcGnmO4bmbbodtfrq7RJ7/4qlUiYR0tdH2QDPIH0g0wsNc06KNHOrcOjeYH5U5wZ9MFhh4ly0EedEejkQndwl6NdrxK31BObwN/0d1ADnVW8Qmg0JPZmSAZHWN2TZ4VlB5SjtU0aOJS4RsSmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF74CQHF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF74CQHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25071F000FF;
	Tue, 15 Sep 2026 11:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472602;
	bh=5Ryf2SDEOeoJbEOncSk+MqlMCvAIckmP18wmTWPjCTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mF74CQHFh8tchEQmzOmekJ1nVWAl8Xny8FVjZHevBPMmITQffgHcahYnvZn3MvfIb
	 aks+huViUEGUxN7TYNR8ARqEqoh4MTlbsceJMRyBqYtrMDO+8tO6d0oN1Msxqjsx5E
	 QIiuCjMFYcBlo0izeLwCqSei8YX5xs0Ne1XB6YoIGcFXpq4pfcAcqyRvjjOsEgD5up
	 zM51pYVR9yQVwmItgj03rMEVwK/e6pQx+DQn9OZd1qnJR/wCJBmscoWFJtMp9Vy/kF
	 UmcB6+Rk+TpGM6ehnuIJsAiW0idgq71/nMDOQkDsbct+OsnK9bBVjsd1MvPQp6r2oD
	 Dx4g7nb9nj65g==
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
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Add a test for bpf_call_rcu_tasks_trace()
Date: Tue, 15 Sep 2026 04:42:37 -0700
Message-ID: <20260915114240.3269184-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915114240.3269184-1-puranjay@kernel.org>
References: <20260915114240.3269184-1-puranjay@kernel.org>
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
index d21807d5d347c..7afbf79bda9a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/call_rcu.c
+++ b/tools/testing/selftests/bpf/prog_tests/call_rcu.c
@@ -24,9 +24,10 @@ static bool wait_for_callbacks(struct call_rcu *skel, int expected)
 	return false;
 }
 
-static void test_call_rcu_run(void)
+static void test_call_rcu_run(bool trace)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct bpf_program *prog;
 	struct call_rcu *skel;
 	struct elem elem;
 	__u32 key = 1;
@@ -36,7 +37,8 @@ static void test_call_rcu_run(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
 		return;
 
-	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm), &opts);
+	prog = trace ? skel->progs.arm_trace : skel->progs.arm;
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
 	if (!ASSERT_OK(err, "test_run") || !ASSERT_EQ(opts.retval, 0, "retval"))
 		goto out;
 
@@ -55,7 +57,7 @@ static void test_call_rcu_run(void)
 		ASSERT_EQ(elem.val, 0, "value_cleared");
 
 	/* The head is disarmed before the callback runs, so it can be reused. */
-	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm), &opts);
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
 	if (!ASSERT_OK(err, "test_run_again"))
 		goto out;
 	ASSERT_EQ(skel->bss->arm_err, 0, "rearm_err");
@@ -197,7 +199,9 @@ static void test_call_rcu_inner_map(void)
 void test_call_rcu(void)
 {
 	if (test__start_subtest("run"))
-		test_call_rcu_run();
+		test_call_rcu_run(false);
+	if (test__start_subtest("run_tasks_trace"))
+		test_call_rcu_run(true);
 	if (test__start_subtest("chain"))
 		test_call_rcu_chain();
 	if (test__start_subtest("teardown"))
diff --git a/tools/testing/selftests/bpf/progs/call_rcu.c b/tools/testing/selftests/bpf/progs/call_rcu.c
index 414be225979ec..6a7b316d9ef8b 100644
--- a/tools/testing/selftests/bpf/progs/call_rcu.c
+++ b/tools/testing/selftests/bpf/progs/call_rcu.c
@@ -65,6 +65,23 @@ int arm(void *ctx)
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

