Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F0249CF46;
	Mon,  7 Sep 2026 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788774; cv=none; b=h7Q8gTumIe8awRuFOKSjo/OsJRODeiLYyIzltTOjq3jRlwJ0oLLtIps8+aEuu/Ty+B6hG8tzf58ZvRIujBIJMVBSkr9hkyyngA5evISHIiEpHqXnvrWZFiRwkzVfky+p8iZZEab5FdkB0Gx5+9TfV7lxpI/0voBa8/FkoJTYUAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788774; c=relaxed/simple;
	bh=kQVmnG4p8ASuj9AWowB3SodeEn7Wzfn5T7pFIWEz+40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ju5UdevytiT8p2z8B0ix6sWyLKK9HQ4LyLXuZGtxZACs4Ggs+bnhD4hU4iuf8cfJRZooQF6x9bO+3w7Frw9DAa+toxSwbmQQu2YMxKh78cdV+kuXOJpODMFT3hxxgJnZOu5Bm4wK3uJHfNWAMOOveZ4XmuacW4/xWT05O0P41ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQQYHKkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQQYHKkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D061F00A3D;
	Mon,  7 Sep 2026 13:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788788767;
	bh=Y1EEmDTza+6RSNh6lch4Dbs2JEPqsq9P8uv4zj9Smvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BQQYHKkNtkaduONhULBcvG+5r4UY9WobkVak/FGDxtJQ6Ivhd0fqnyEE8lUEDdEnn
	 C7KUM7kxHt/Hefi6UWKy5nQRcPDB3bqKR9s8U25aR8HZJSPGQUGKTITueoIz1Kg5QQ
	 aGd2Syo4bDyGTjTzCLXKRs/9aR/LT3Xt+HkUrtFEGAFA1emx8sK0nd1DKrjQcvO+tB
	 f79T+i0y2RCPL/gngrbystxZ2jjfqtzYsoBsO0uJWcj5q7p/ZqPfWk64xBkfiU5G1E
	 ZgXnFg8cIy1Xb5f72T6bJL1Rriufwv7nQ3Ap5tuBtaN5Q5JP/KO7VlBM5yl9/amqSA
	 6ygOIF2NV5eEA==
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
Subject: [PATCH bpf-next 2/4] selftests/bpf: Add tests for bpf_call_rcu()
Date: Mon,  7 Sep 2026 06:45:49 -0700
Message-ID: <20260907134552.1772405-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907134552.1772405-1-puranjay@kernel.org>
References: <20260907134552.1772405-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover the callback running after a grace period with the right map, key
and value, -EBUSY on a second arm, reuse of the head once disarmed, a
callback arming itself again, and teardown with a callback queued.

struct bpf_rcu_head is not the first member of the map value, so the
callback's recovery of the value from the head is exercised.  arm()
wraps both arms in an RCU read section, otherwise a grace period may
elapse between them and the second one legitimately succeeds.

Negative tests: a hash map created with the same BTF, the map used as an
inner map, and an iterator attach, all checked for -EOPNOTSUPP; plus
verifier rejection of a mismatched map, a map with no bpf_rcu_head, a
head at the wrong offset, a head on the stack, and a sleepable callback.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/call_rcu.c       | 187 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/call_rcu.c  |  72 +++++++
 .../selftests/bpf/progs/call_rcu_fail.c       | 114 +++++++++++
 3 files changed, 373 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_rcu.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_rcu.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_rcu_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/call_rcu.c b/tools/testing/selftests/bpf/prog_tests/call_rcu.c
new file mode 100644
index 0000000000000..ccbfa9965d511
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/call_rcu.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "call_rcu.skel.h"
+#include "call_rcu_fail.skel.h"
+
+struct elem {
+	__u64 pad;
+	struct bpf_rcu_head rh;
+	__u64 val;
+};
+
+/* call_rcu() is lazy on a CONFIG_RCU_LAZY kernel, so allow well over one grace period. */
+static bool wait_for_callbacks(struct call_rcu *skel, int expected)
+{
+	int i;
+
+	for (i = 0; i < 3000; i++) {
+		if (READ_ONCE(skel->bss->callbacks) >= expected)
+			return true;
+		usleep(10000);
+	}
+	fprintf(stderr, "callbacks: got %d want %d\n", READ_ONCE(skel->bss->callbacks), expected);
+	return false;
+}
+
+static void test_call_rcu_run(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct call_rcu *skel;
+	struct elem elem;
+	__u32 key = 1;
+	int err;
+
+	skel = call_rcu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm), &opts);
+	if (!ASSERT_OK(err, "test_run") || !ASSERT_EQ(opts.retval, 0, "retval"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->arm_err, 0, "arm_err");
+	ASSERT_EQ(skel->bss->busy_err, -EBUSY, "busy_err");
+
+	if (!ASSERT_TRUE(wait_for_callbacks(skel, 1), "callback_ran"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->cb_key, key, "cb_key");
+	ASSERT_EQ(skel->bss->cb_val, 0xdeadbeef, "cb_val");
+	ASSERT_EQ(skel->bss->cb_max_entries, bpf_map__max_entries(skel->maps.arr), "cb_map");
+
+	err = bpf_map__lookup_elem(skel->maps.arr, &key, sizeof(key), &elem, sizeof(elem), 0);
+	if (ASSERT_OK(err, "lookup"))
+		ASSERT_EQ(elem.val, 0, "value_cleared");
+
+	/* The head is disarmed before the callback runs, so it can be reused. */
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm), &opts);
+	if (!ASSERT_OK(err, "test_run_again"))
+		goto out;
+	ASSERT_EQ(skel->bss->arm_err, 0, "rearm_err");
+	ASSERT_TRUE(wait_for_callbacks(skel, 2), "callback_ran_again");
+out:
+	call_rcu__destroy(skel);
+}
+
+static void test_call_rcu_chain(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct call_rcu *skel;
+
+	skel = call_rcu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	skel->bss->chain = 1;
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm), &opts), "test_run"))
+		goto out;
+
+	ASSERT_TRUE(wait_for_callbacks(skel, 2), "chained_callback_ran");
+	ASSERT_EQ(skel->bss->chain_err, 0, "chain_err");
+out:
+	call_rcu__destroy(skel);
+}
+
+/* Tear down the map and the program while a callback is still queued. */
+static void test_call_rcu_teardown(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct call_rcu *skel;
+
+	skel = call_rcu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	/* The callback re-arms after the last user reference is gone; that must be refused. */
+	skel->bss->chain = 1;
+	ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm), &opts), "test_run");
+	call_rcu__destroy(skel);
+}
+
+static void test_call_rcu_bad_map(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	struct call_rcu *skel;
+	int fd;
+
+	skel = call_rcu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	opts.btf_fd = bpf_object__btf_fd(skel->obj);
+	opts.btf_key_type_id = bpf_map__btf_key_type_id(skel->maps.arr);
+	opts.btf_value_type_id = bpf_map__btf_value_type_id(skel->maps.arr);
+
+	fd = bpf_map_create(BPF_MAP_TYPE_HASH, "rcu_hash", sizeof(__u32),
+			    bpf_map__value_size(skel->maps.arr), 1, &opts);
+	if (ASSERT_LT(fd, 0, "hash_rejected"))
+		ASSERT_EQ(fd, -EOPNOTSUPP, "hash_errno");
+	else
+		close(fd);
+
+	call_rcu__destroy(skel);
+}
+
+/* Iterating would hand the program a writable pointer to the head. */
+static void test_call_rcu_iter(void)
+{
+	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo = {};
+	struct bpf_link *link;
+	struct call_rcu *skel;
+
+	skel = call_rcu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	linfo.map.map_fd = bpf_map__fd(skel->maps.arr);
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(skel->progs.dump, &opts);
+	if (!ASSERT_ERR_PTR(link, "iter_rejected"))
+		bpf_link__destroy(link);
+	else
+		ASSERT_EQ(libbpf_get_error(link), -EOPNOTSUPP, "iter_errno");
+
+	call_rcu__destroy(skel);
+}
+
+static void test_call_rcu_inner_map(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	struct call_rcu *skel;
+	int fd;
+
+	skel = call_rcu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	opts.inner_map_fd = bpf_map__fd(skel->maps.arr);
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS, "rcu_outer",
+			    sizeof(__u32), sizeof(__u32), 1, &opts);
+	if (ASSERT_LT(fd, 0, "inner_map_rejected"))
+		ASSERT_EQ(fd, -EOPNOTSUPP, "inner_map_errno");
+	else
+		close(fd);
+
+	call_rcu__destroy(skel);
+}
+
+void test_call_rcu(void)
+{
+	if (test__start_subtest("run"))
+		test_call_rcu_run();
+	if (test__start_subtest("chain"))
+		test_call_rcu_chain();
+	if (test__start_subtest("teardown"))
+		test_call_rcu_teardown();
+	if (test__start_subtest("hash_map"))
+		test_call_rcu_bad_map();
+	if (test__start_subtest("iter"))
+		test_call_rcu_iter();
+	if (test__start_subtest("inner_map"))
+		test_call_rcu_inner_map();
+	RUN_TESTS(call_rcu_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/call_rcu.c b/tools/testing/selftests/bpf/progs/call_rcu.c
new file mode 100644
index 0000000000000..50349b104d1a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/call_rcu.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+/* rh is not at offset 0, so the callback's value recovery is exercised. */
+struct elem {
+	__u64 pad;
+	struct bpf_rcu_head rh;
+	__u64 val;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__type(value, struct elem);
+} arr SEC(".maps");
+
+__u32 cb_key;
+__u64 cb_val;
+__u32 cb_max_entries;
+int callbacks;
+int arm_err;
+int busy_err;
+int chain;		/* set by userspace: re-arm once from the callback */
+int chain_err;
+
+static int reclaim(struct bpf_map *map, void *key, void *value)
+{
+	struct elem *e = value;
+
+	cb_key = *(__u32 *)key;
+	cb_val = e->val;
+	cb_max_entries = map->max_entries;
+	e->val = 0;
+	__sync_fetch_and_add(&callbacks, 1);
+
+	if (chain) {
+		chain = 0;
+		chain_err = bpf_call_rcu(&e->rh, &arr, reclaim);
+	}
+	return 0;
+}
+
+SEC("syscall")
+int arm(void *ctx)
+{
+	__u32 key = 1;
+	struct elem *e;
+
+	e = bpf_map_lookup_elem(&arr, &key);
+	if (!e)
+		return 1;
+
+	e->val = 0xdeadbeef;
+	/* Keep a grace period from elapsing between the two arms. */
+	bpf_rcu_read_lock();
+	arm_err = bpf_call_rcu(&e->rh, &arr, reclaim);
+	busy_err = bpf_call_rcu(&e->rh, &arr, reclaim);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("iter/bpf_map_elem")
+int dump(struct bpf_iter__bpf_map_elem *ctx)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/call_rcu_fail.c b/tools/testing/selftests/bpf/progs/call_rcu_fail.c
new file mode 100644
index 0000000000000..c6dc279712989
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/call_rcu_fail.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+const void *user_ptr = NULL;
+
+struct elem {
+	__u64 pad;
+	struct bpf_rcu_head rh;
+	__u64 val;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct elem);
+} arr SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct elem);
+} arr2 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} plain SEC(".maps");
+
+__u32 key = 0;
+
+static int reclaim(struct bpf_map *map, void *key, void *value)
+{
+	return 0;
+}
+
+static int sleepable_reclaim(struct bpf_map *map, void *key, void *value)
+{
+	struct elem *e = value;
+
+	bpf_copy_from_user(&e->val, sizeof(e->val), user_ptr);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("doesn't match map pointer in R2")
+int mismatch_map(void *ctx)
+{
+	struct elem *e;
+
+	e = bpf_map_lookup_elem(&arr, &key);
+	if (!e)
+		return 0;
+	bpf_call_rcu(&e->rh, &arr2, reclaim);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("map 'plain' has no valid bpf_rcu_head")
+int no_rcu_head(void *ctx)
+{
+	__u64 *val;
+
+	val = bpf_map_lookup_elem(&plain, &key);
+	if (!val)
+		return 0;
+	bpf_call_rcu((struct bpf_rcu_head *)val, &plain, reclaim);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("doesn't point to 'struct bpf_rcu_head' that is at 8")
+int wrong_offset(void *ctx)
+{
+	struct elem *e;
+
+	e = bpf_map_lookup_elem(&arr, &key);
+	if (!e)
+		return 0;
+	bpf_call_rcu((struct bpf_rcu_head *)&e->pad, &arr, reclaim);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("R1 doesn't point to a map value")
+int rcu_head_on_stack(void *ctx)
+{
+	struct bpf_rcu_head rh;
+
+	bpf_call_rcu(&rh, &arr, reclaim);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("sleepable helper bpf_copy_from_user") __msg("in non-sleepable prog")
+int sleepable_callback(void *ctx)
+{
+	struct elem *e;
+
+	e = bpf_map_lookup_elem(&arr, &key);
+	if (!e)
+		return 0;
+	bpf_call_rcu(&e->rh, &arr, sleepable_reclaim);
+	return 0;
+}
-- 
2.53.0-Meta

