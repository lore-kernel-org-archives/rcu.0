Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA314A3D46;
	Tue, 15 Sep 2026 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472597; cv=none; b=qViZRYiUYfxLlom2jZ9tA7zO22TRVxipu3JkbsSSgU0SXvTI+s5SSRQ1Tb6tBbI5NsYdEzo47bRekbBUr5OB1Z++HhafE1CjkAGEjQVRc48hgfkwuxKxL2nUe6U8ZYO9lZCy0ADrgV9u0BuGMlQUUuwDeHLpof4lOGTs3SgnjUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472597; c=relaxed/simple;
	bh=Uc49Q588To0/y+e/DIL6rebRSuapHWszltEcb4BpgJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShQVOGn1naRD9ge6xQDI6UFqaTpSf2Oyuopi1rJ4j6Jp+YfbpNNx8YhljYoYbLDHpe5VX0jaH/Zd8FgxMydsIEMHYqo3+CRRPoLFVg24JTU32u+qBwXLgXS7kHBjMiH547B3s0/swBk1g0t1LIkCaqgXXG2EdzNb4nnuOvj/U8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSP43/p4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSP43/p4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A427F1F000FF;
	Tue, 15 Sep 2026 11:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472595;
	bh=ep8qCOEAaxlBsZN7eoDWjF8aFerOwSoQkQxC/zF6ef0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eSP43/p42azdwqJ3MY3VS8PJkQmt4yTV6wAZYgPVrv0dEU2YPold8n9FeMUJHzQnu
	 zveZORODEsNa3AkhIC7fiLJWtjZXPOrLZYslhLPWHO6kk9vBpA8SAggywCYs4IuA3V
	 m0gz3+p2xs3ZzLH9txn8atpji6mSY86ZB1BEZ8VR8MNIFI3r0DoRzqSMccLJ8NuVne
	 XVERWdTYYh8VdcrINJRI8V7ejzRwDahRWjIOuC66n8DOLDXx+So0yw1le+D+A6k6Dw
	 kk9uJ5LKUFpch31NUEYj3NZw63jtKgpQhuaZ2S3cJspgcVZKM2HOibDIhuXTt0bObb
	 3iZ3GMRkBFu9Q==
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
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Add tests for bpf_call_rcu()
Date: Tue, 15 Sep 2026 04:42:35 -0700
Message-ID: <20260915114240.3269184-3-puranjay@kernel.org>
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
 .../selftests/bpf/prog_tests/call_rcu.c       | 212 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/call_rcu.c  |  72 ++++++
 .../selftests/bpf/progs/call_rcu_fail.c       | 114 ++++++++++
 3 files changed, 398 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_rcu.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_rcu.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_rcu_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/call_rcu.c b/tools/testing/selftests/bpf/prog_tests/call_rcu.c
new file mode 100644
index 0000000000000..d21807d5d347c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/call_rcu.c
@@ -0,0 +1,212 @@
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
+/*
+ * A callback that keeps re-arming must stop once the map loses its last user
+ * reference, otherwise it holds a program reference for good.  Watch the
+ * program id disappear to prove the chain ended.
+ */
+static void test_call_rcu_teardown(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct bpf_prog_info info = {};
+	__u32 len = sizeof(info);
+	struct call_rcu *skel;
+	int i, err, fd = 0;
+	__u32 prog_id;
+
+	skel = call_rcu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	if (!ASSERT_OK(bpf_prog_get_info_by_fd(bpf_program__fd(skel->progs.arm), &info, &len),
+		       "prog_info")) {
+		call_rcu__destroy(skel);
+		return;
+	}
+	prog_id = info.id;
+
+	skel->bss->chain = INT_MAX;
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm), &opts);
+	call_rcu__destroy(skel);
+	if (!ASSERT_OK(err, "test_run"))
+		return;
+
+	for (i = 0; i < 3000; i++) {
+		fd = bpf_prog_get_fd_by_id(prog_id);
+		if (fd < 0)
+			break;
+		close(fd);
+		usleep(10000);
+	}
+	ASSERT_EQ(fd, -ENOENT, "prog_freed");
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
index 0000000000000..414be225979ec
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
+int chain;		/* set by userspace: number of times to re-arm from the callback */
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
+	if (chain > 0) {
+		chain--;
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
index 0000000000000..d5b029342e884
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
+__failure __msg("R1 type=fp expected=map_value")
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

