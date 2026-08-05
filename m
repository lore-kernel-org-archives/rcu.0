Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC84657FD;
	Wed,  5 Aug 2026 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932662; cv=none; b=BcFOrVJb+BEJDRrI3Zz6WFCXvSoSBDMn4D1kNlH2+fQTlVjPQBItfErZhfB5NzcUMnKFVNgEnEE263pBHAJldYPgG1rHKCkfLwMTog2RBiQW8naYjj3pxLSak9sSjHPo2vYH/t0QFPf53PIHVRABp780EZ3R5BcnTJWKCVZaHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932662; c=relaxed/simple;
	bh=u43ECnkxfmdGYW8Bf4pwUp69IBSkp9X0YymN34IHNp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrr1/zAkbOlB67ao68y7x8wYWtPvRULfsdrVkGMgrjKxp3FdFcxWheRrbm/xIbe6oseC/uNjy1Ronuse8CspQQ2hCGa5FhaXSvWAV/yWJM7d1QqlZM74keDfIvtQ2QziQuQ/PFT/Lo/vAG7GJKHqa+pALAWmwAy7M/skdXUAfek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSSC+WFQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSSC+WFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFAD1F000E9;
	Wed,  5 Aug 2026 12:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785932661;
	bh=wZC1Z+3adPrHkC8Qv8oyMha0PitI7krXLmp3Adhm/jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dSSC+WFQ00umcfx+tqieACzSJnSWVkJCWdn9wqPvWedAh/OxhGwB+Manb2VPnhQsz
	 WCmuPJtBVldoxTSbpDiXLrYwhRZcqI/C4I/WABG2yIsGxBSEfa6fBP7TuiSCCKUdf9
	 2TEmjqFSlQs7G8SH9HiM+unVa6sqciokFlbYml7Z16f4ToVSHv/oR84Zuq+m0/Qk2x
	 TLxMZOzxvAA4CH6h+g/3jAyYyaascOhSdMHjw7C6nLjlWwUY3zJ11pg8FgikNTLhB8
	 2si6lGIhhsAMwvcQvfWYs84TCvzVj3NHhQAiqyiJY8JTtgTqf3KkG8kgUx9ux9okgd
	 HdTQ4mmwsUERg==
From: Puranjay Mohan <puranjay@kernel.org>
To: "Lai Jiangshan" <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Josh Triplett" <josh@joshtriplett.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	"Frederic Weisbecker" <frederic@kernel.org>,
	"Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
	"Joel Fernandes" <joelagnelf@nvidia.com>,
	"Boqun Feng" <boqun@kernel.org>,
	"Uladzislau Rezki" <urezki@gmail.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v3 6/6] selftests/bpf: Add a call_srcu() re-entry reproducer
Date: Wed,  5 Aug 2026 05:23:43 -0700
Message-ID: <20260805122346.269445-7-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805122346.269445-1-puranjay@kernel.org>
References: <20260805122346.269445-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-enter call_srcu() from a BPF program to exercise its any-context
safety (and thus call_rcu_tasks_trace(), which is call_srcu() on
rcu_tasks_trace_srcu_struct).

An fentry program on rcu_segcblist_enqueue() fires mid-enqueue: that
function is reached from srcu_gp_start_if_needed() with the srcu_data
->lock held.  The program does a task-storage delete, whose only deferred
work is call_rcu_tasks_trace(), re-entering the enqueue on the same CPU.
The triggering thread is pinned to one CPU and matched by TID, so the
program fires only for the test's own delete.

Without the fix the nested call re-takes the same sdp lock and
self-deadlocks; with it the nested __call_srcu() sees interrupts disabled
and defers via irq_work, so the delete returns and the test passes.  Since
it can hang an unfixed kernel, run it only against a kernel carrying the
fix.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/rcu_reentry.c    | 95 +++++++++++++++++++
 .../testing/selftests/bpf/progs/rcu_reentry.c | 51 ++++++++++
 2 files changed, 146 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_reentry.c

diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c b/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
new file mode 100644
index 0000000000000..fa813d1d492b6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Exercise re-entry into call_srcu() from BPF; see progs/rcu_reentry.c.
+ *
+ * On a kernel without the call_srcu() any-context fix the nested call
+ * self-deadlocks on the srcu_data lock, so this hangs rather than fails.
+ */
+#define _GNU_SOURCE
+#include <sched.h>
+#include <sys/syscall.h>
+#include <test_progs.h>
+#include "rcu_reentry.skel.h"
+
+static int sys_pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, flags);
+}
+
+/* Tiny RCU builds have no rcu_segcblist_enqueue() to attach to. */
+static bool have_attach_target(void)
+{
+	char buf[256];
+	bool found = false;
+	FILE *f;
+
+	f = fopen("/proc/kallsyms", "r");
+	if (!f)
+		return true;	/* cannot tell; let the attach decide */
+	while (fgets(buf, sizeof(buf), f)) {
+		if (strstr(buf, " rcu_segcblist_enqueue\n")) {
+			found = true;
+			break;
+		}
+	}
+	fclose(f);
+	return found;
+}
+
+void test_rcu_reentry(void)
+{
+	struct rcu_reentry *skel;
+	int err, pidfd = -1, map_fd;
+	cpu_set_t set, old_set;
+	bool affinity_saved;
+	__u64 val = 1;
+
+	if (!have_attach_target()) {
+		test__skip();
+		return;
+	}
+
+	skel = rcu_reentry__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	err = rcu_reentry__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	/* Keep the re-entry on a single CPU. */
+	affinity_saved = !sched_getaffinity(0, sizeof(old_set), &old_set);
+	CPU_ZERO(&set);
+	CPU_SET(0, &set);
+	if (!ASSERT_OK(sched_setaffinity(0, sizeof(set), &set), "setaffinity"))
+		goto out;
+
+	pidfd = sys_pidfd_open(getpid(), 0);
+	if (!ASSERT_GE(pidfd, 0, "pidfd_open"))
+		goto restore;
+	map_fd = bpf_map__fd(skel->maps.task_stg);
+	err = bpf_map_update_elem(map_fd, &pidfd, &val, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "boot_create"))
+		goto restore;
+
+	/* Arm the handler for this thread, then trigger call_rcu_tasks_trace(). */
+	skel->bss->target_pid = syscall(__NR_gettid);
+	err = bpf_map_delete_elem(map_fd, &pidfd);
+	if (!ASSERT_OK(err, "boot_delete"))
+		goto restore;
+
+	/* Only Tree SRCU enqueues via rcu_segcblist_enqueue(); skip elsewhere. */
+	if (!skel->bss->hits) {
+		test__skip();
+		goto restore;
+	}
+	ASSERT_EQ(skel->bss->get_errs, 0, "nested_storage_get");
+	ASSERT_EQ(skel->bss->del_errs, 0, "nested_storage_delete");
+restore:
+	if (affinity_saved)
+		sched_setaffinity(0, sizeof(old_set), &old_set);
+out:
+	if (pidfd >= 0)
+		close(pidfd);
+	rcu_reentry__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/rcu_reentry.c b/tools/testing/selftests/bpf/progs/rcu_reentry.c
new file mode 100644
index 0000000000000..47a36f704cf3e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rcu_reentry.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Re-enter call_srcu() from a BPF program.  fentry on rcu_segcblist_enqueue()
+ * fires inside call_srcu()'s enqueue (reached from srcu_gp_start_if_needed()
+ * with the srcu_data ->lock held); the handler then calls call_rcu_tasks_trace()
+ * -- itself call_srcu() on rcu_tasks_trace_srcu_struct -- re-entering the same
+ * srcu_data on the same CPU.
+ */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, __u64);
+} task_stg SEC(".maps");
+
+int target_pid;
+int hits;
+int get_errs;
+int del_errs;
+int done;
+
+SEC("fentry/rcu_segcblist_enqueue")
+int BPF_PROG(reenter)
+{
+	struct task_struct *cur;
+
+	if (done || !target_pid)
+		return 0;
+
+	cur = bpf_get_current_task_btf();
+	if (cur->pid != target_pid)
+		return 0;
+
+	/* Issue the nested call exactly once, so the test is deterministic. */
+	done = 1;
+	__sync_fetch_and_add(&hits, 1);
+
+	/* Re-enter via a task-storage delete, which calls call_rcu_tasks_trace(). */
+	if (!bpf_task_storage_get(&task_stg, cur, 0, BPF_LOCAL_STORAGE_GET_F_CREATE))
+		__sync_fetch_and_add(&get_errs, 1);
+	else if (bpf_task_storage_delete(&task_stg, cur))
+		__sync_fetch_and_add(&del_errs, 1);
+
+	return 0;
+}
-- 
2.53.0-Meta

