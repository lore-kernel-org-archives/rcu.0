Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D8F515996;
	Mon, 21 Sep 2026 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018072; cv=none; b=ZnMZyFdbqa98A1Ndr8a9Cos9pwB5ADcXYaQVoHOt2G2+obPLhOyeeGCVKrRbkRVa40FEzu8gWsbOwtvw5au0rjfXH+S3qV21sIaHOlggScFieHjwCLp0GMvAaw0AZgjvPR7GgHch8Iglz4hIrVZiX3vHKDCbtJtky9QjlQceafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018072; c=relaxed/simple;
	bh=IkRmsfdBExIBxtjiu+lZsYMQUZlnD2yWZt+z8yrb94E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPFzXF0xFCwSZuk15eXSxwITqNufmj8QWCaByYdhu1PtoIQbWFIsPI9gAM1+NA3WfIlsqotb/WYYPH2dNOaHC6NItFwaVLEk2ZUrI4BuXfqctiVdjwW6Nb0py7KKJVuUJoOogugpH4MCtcoRBBMwo1rQuYxSMizNaKJFFt4Z6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/NIH0qJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/NIH0qJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7664B1F0089D;
	Mon, 21 Sep 2026 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018068;
	bh=4iYgu5wBk9/4O0EeidaMtW8II61oeJpmIhGsFzKZKOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N/NIH0qJNvjCBM57ywQGHD1pPxy68mrYekjZxad3xSGjwOmvKgmTUWGxsFMGKzQ6F
	 6UE36+MlY7NPDr8BHealWjhECNDwTzm7I2ctj5AVs/tblVX0WRjU6cRDgSVd2VujPW
	 rRMh2d8FQDSWsLqlTGnTOSZGBAVMtgxzGW9Pbogob6twAsqro2AJI/hu1ipVtdpoUF
	 WcZ+DxnDZSxuW9+38eXS0Dc9nDsSNjmrVo4qs5FpO6jeKKPBai5BZlb8ljEaDyQX04
	 NtQk2m02mb0RihtHAPsRs5cz5UreD2uNdkedVNhPk0g4VLkTwbVhM10UJ6MRTCqL6c
	 H67LvWpTLSk6g==
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
Subject: [PATCH bpf-next v5 4/4] selftests/bpf: Add a test for bpf_call_rcu_tasks_trace()
Date: Mon, 21 Sep 2026 12:14:05 -0700
Message-ID: <20260921191407.1742386-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921191407.1742386-1-puranjay@kernel.org>
References: <20260921191407.1742386-1-puranjay@kernel.org>
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

