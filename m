Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0A3C3447;
	Tue, 15 Sep 2026 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483022; cv=none; b=VkiX3q/JWUGY+M5TZhbwhixSN3Itcl04kuezT/ffxoQkdPDkUJe1w/L7Im07TNDB7HRbWq8I6MEbUUCOfh+mEi4Au2iiTIJbKJdE2h/j3zJ4cpHYaLb6qYEmg2kWSAPehciZkHCRumt5wyNbKe95ySdc7xc1SQKGN15Us75htcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483022; c=relaxed/simple;
	bh=GKtncJEVAlzjqdT9kKth5Wp6aMZzue09z6ciU460JJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ce3INuNjGR2Zpn/S8ScR2Hxg57uU+C2nDnqhLOmqn0cYtSWhuYsunm9HzodqVlApaNB/id5h0nJ1QN84nkNQmV2AjrJOGgwdLGyLG+O3WHPY+L/KMFMs8UM4Epr2SeAvC85G2vzvHH29wpyd/D88owhxR1g4OZ2VfYGiFHJXKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2PsFLAB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2PsFLAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD011F000FF;
	Tue, 15 Sep 2026 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789483020;
	bh=xKXTyG4jQO0rZtuaKIisgskB/be7QnWcJcg6/xU2smU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B2PsFLAB5VRSILBuhLmfWAK7BThlwhhwtBvMHMZICzizRg/atF7XozcT5dqt1Bly9
	 avhGvnk2vDT5cGnuDHYAq/tBsHQiYuLTqFfvT5vZyH2r67ZJmKPMmIQNVmKi1ExvAV
	 0m6attZ6/1BOP1roa5SexKK9G5Ory4KBAKAFhak58cVLRYnZCGjHVIs4AOmCiE7b56
	 FUAE0PU3MNXfeLyH1lHBr8RF6SnVZd4ywu/w1qWSGmFAb2+T+eJhhNdsrQv1uGQZe1
	 LcInnUYZmqbQkpCYZAnY/bsc4r+YPNM9AI8EJjUH6fM5MfRgtf7Iq/ccpsrH9MX1Nw
	 p/HsmJ9iQdbuw==
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
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Add a test for bpf_call_rcu_tasks_trace()
Date: Tue, 15 Sep 2026 07:36:38 -0700
Message-ID: <20260915143640.36292-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915143640.36292-1-puranjay@kernel.org>
References: <20260915143640.36292-1-puranjay@kernel.org>
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
index c2d266aee8eac..7c8fde3c4d249 100644
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
index aa5d2b0fa36e4..2324d05f3de3a 100644
--- a/tools/testing/selftests/bpf/progs/call_rcu.c
+++ b/tools/testing/selftests/bpf/progs/call_rcu.c
@@ -85,6 +85,23 @@ int arm_both(void *ctx)
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

