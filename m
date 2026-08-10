Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529973D7A18;
	Mon, 10 Aug 2026 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364919; cv=none; b=Vj1O569Hm3jIJMS6uai3pEOV9XAykevz+JuRwsz6pOorFU0IWf6ZIhp54Jmead3asrBq3S4pYTti1EudkQRYkut9o64m6Kg6VJPjnobEzbbkHhFFSI0eEUNcrGEl+K7D9SRKeskN9TNNE9sjhFc4wekJjZ0pWc/Isa5dLTxuPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364919; c=relaxed/simple;
	bh=YBqj1Odqlr5vJhp8U6pwcvWqvXBL4GqH9aoBir/rry8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dc/9WRD0O5gyiPRr7OLKbZf1zFo9tQgplP1KWhEsx6R928UkTy57tLQnt+5xOPtyQwiKu3OwuAkucPvwvU2twBRmJ3G7QVvqNt43LDvSmlcy4b88zBYIz+F1htz93zRi01uF1/F8cCHRVH5kTrSjtA9dIUIEqFYSiLGeSckOxVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ew+IznzZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ew+IznzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A033C1F000E9;
	Mon, 10 Aug 2026 12:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786364917;
	bh=iEwmQpckeIO3ur7ByQuHq0/2DDHm8BL4KuY4DhULyRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ew+IznzZhDjEDaEVeztJWpzfJ3zFSWUACyqgd831U+jl0xnKiSCoLMuDu0XMKhzRJ
	 JS3kcsk67D5lqb965hqFmJ4ZqhTISJhLy7W1JFBK+6Z7S4H1IrccRFkyITdfuJaUlK
	 PtXGl1rA1SPd2vAtbWDBK2NMn47//3aLZgmIbvqXslHtBSIVyIY2m33UkiVQ0YpMwE
	 /u6F/EQnzzuunqtWIe1uTCwR1vBr0I+hZHd3txboz0rAQeRD4LNROklEYdd2Rhrts+
	 V0SqM/sAMmgbzDCX6dlcNNCs8bnymhKrGlIui/6bBHb0yUzZgiT/D2sQel9wBmLHuJ
	 Vzo7hhrjpdNAg==
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
Subject: [PATCH v4 6/6] selftests/bpf: Add a call_srcu() re-entry reproducer
Date: Mon, 10 Aug 2026 05:27:55 -0700
Message-ID: <20260810122758.183765-7-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810122758.183765-1-puranjay@kernel.org>
References: <20260810122758.183765-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-enter call_srcu() from a BPF program to exercise its any-context
safety, via call_rcu_tasks_trace(), which is call_srcu() on
rcu_tasks_trace_srcu_struct.

An fentry program on rcu_segcblist_enqueue() fires mid-enqueue: that
function is reached from srcu_gp_start_if_needed() with the srcu_data
->lock held.  The program does a task-storage delete, whose only deferred
work is call_rcu_tasks_trace(), re-entering the enqueue on the same CPU.
The handler matches on TID and fires once; pinning the thread removes the
migration window between picking the srcu_data and taking its lock.

Without the fix the nested call re-takes the same sdp lock and
self-deadlocks; with it the nested __call_srcu() sees interrupts disabled
and defers via irq_work, so the delete returns and the test passes.

The test skips where it does not apply: Tiny RCU has no
rcu_segcblist_enqueue() to attach to, and a UP+PREEMPT kernel pairs Tree
RCU with Tiny SRCU, so the attach succeeds but call_srcu() never reaches
the enqueue.  Tiny SRCU is told apart by srcu_expedite_current(), which it
stubs out, so on Tree SRCU a zero hit count fails rather than skips and the
reproducer cannot quietly stop reproducing.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/rcu_reentry.c    | 93 +++++++++++++++++++
 .../testing/selftests/bpf/progs/rcu_reentry.c | 51 ++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_reentry.c

diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c b/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
new file mode 100644
index 0000000000000..de23a14b3d408
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Exercise re-entry into call_srcu() from BPF; see progs/rcu_reentry.c. */
+#define _GNU_SOURCE
+#include <sched.h>
+#include <test_progs.h>
+#include "task_local_storage_helpers.h"
+#include "trace_helpers.h"
+#include "rcu_reentry.skel.h"
+
+/* Tiny RCU has no rcu_segcblist_enqueue() to attach to. */
+static bool have_attach_target(void)
+{
+	unsigned long long addr;
+
+	return kallsyms_find("rcu_segcblist_enqueue", &addr) == 0;
+}
+
+/* Tiny SRCU stubs out srcu_expedite_current(); Tree SRCU exports it. */
+static bool have_tree_srcu(void)
+{
+	unsigned long long addr;
+
+	return kallsyms_find("srcu_expedite_current", &addr) == 0;
+}
+
+void test_rcu_reentry(void)
+{
+	struct rcu_reentry *skel;
+	int err, pidfd = -1, map_fd;
+	cpu_set_t set, old_set;
+	bool affinity_saved;
+	__u64 val = 1;
+	int cpu;
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
+	/* Keep the re-entry on a single CPU; a cpuset may exclude CPU 0. */
+	affinity_saved = !sched_getaffinity(0, sizeof(old_set), &old_set);
+	cpu = sched_getcpu();
+	if (!ASSERT_GE(cpu, 0, "getcpu"))
+		goto out;
+	CPU_ZERO(&set);
+	CPU_SET(cpu, &set);
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
+	/*
+	 * Only Tree SRCU reaches rcu_segcblist_enqueue() from call_srcu(); a
+	 * UP+PREEMPT kernel pairs Tree RCU with Tiny SRCU, so the attach
+	 * succeeds but nothing fires.  On Tree SRCU it must fire.
+	 */
+	if (!skel->bss->hits) {
+		if (have_tree_srcu())
+			ASSERT_GT(skel->bss->hits, 0, "prog_fired");
+		else
+			test__skip();
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

