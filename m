Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0841D11E;
	Mon,  3 Aug 2026 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765246; cv=none; b=SYF6ztfDvpoJ8ghGHGuP5AQVXcOd7xQ6RUySaRc/nOOFXYnkfNulSnFVMUGmQBwTDd630Wn2CfKNGiL7BX+YNSBpfpmw/Lk51pmw3qqLsK3HszIpxaznynwP6pBpCg924a95uAvWrTl2MODpF0NKxqc30+S2TGuVjCcvWbdGW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765246; c=relaxed/simple;
	bh=wp013QQZyotJrLjBrIasqIfJoCCnycwD9Rfdk91JbKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stw0bKfRkbdBwhLE7bpO1NVgSNC9I0vnaZyElfKLrWziqpUxiTu9D4laSWuCPP+GGoA6jg1QHL8ttA49lYzVv8flBvZVYBddX/b/mDDaNPEzxdq29KmCrByoirvKIuvn4Ctd0e9gSl8AWrUvtaiQ2pUVHbuq0fzcwjpt68AkPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxocRJ7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxocRJ7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5741F000E9;
	Mon,  3 Aug 2026 13:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785765245;
	bh=qeYRh45l20SmIGanD5yoc+u5gkMxwHBGK5QfYK5yQdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HxocRJ7AMEVpGOfIuBEa4Y61N0xsjHcLE1kmTy6GW40/nz4fBMYxYrDyeVUMhEfxr
	 JDDWidJBVHH2zB3nCRWx8JazDCj19bW044m/cqjKTRZV1MhR6j/al9vLwBNhetyJfh
	 0BMcUIDDs2tIN8zbvCBy3+ZWPROM+VAcHZcli0enwHIuSTfRAaCWS5zh0iPAQXQzxF
	 uom5jAWj56WhnWG8t584YuNCswpT13AskTNlrS32UhAUVeZhBTo7uskvkIJUUV27Af
	 fWlnyQWMgwzr6fFnguNI3UV8tZxxjz4g6SjJRTuw9pZ0/nAKRci94yGvwmkHXuzx4+
	 p3phlcimf6Jbg==
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
Subject: [PATCH v2 6/6] selftests/bpf: Add a call_srcu() re-entry reproducer
Date: Mon,  3 Aug 2026 06:53:29 -0700
Message-ID: <20260803135329.2327280-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803134839.2103051-1-puranjay@kernel.org>
References: <20260803134839.2103051-1-puranjay@kernel.org>
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
 .../selftests/bpf/prog_tests/rcu_reentry.c    | 58 +++++++++++++++++++
 .../testing/selftests/bpf/progs/rcu_reentry.c | 45 ++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_reentry.c

diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c b/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
new file mode 100644
index 0000000000000..f6ecd93be30f4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Exercise re-entry into call_srcu() from BPF; see progs/rcu_reentry.c. */
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
+void test_rcu_reentry(void)
+{
+	struct rcu_reentry *skel;
+	int err, pidfd = -1, map_fd;
+	__u64 val = 1;
+	cpu_set_t set;
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
+	CPU_ZERO(&set);
+	CPU_SET(0, &set);
+	if (sched_setaffinity(0, sizeof(set), &set))
+		perror("sched_setaffinity");
+
+	pidfd = sys_pidfd_open(getpid(), 0);
+	if (!ASSERT_GE(pidfd, 0, "pidfd_open"))
+		goto out;
+	map_fd = bpf_map__fd(skel->maps.task_stg);
+	err = bpf_map_update_elem(map_fd, &pidfd, &val, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "boot_create"))
+		goto out;
+
+	/* Arm the handler for this thread, then trigger call_rcu_tasks_trace(). */
+	skel->bss->target_pid = syscall(__NR_gettid);
+	err = bpf_map_delete_elem(map_fd, &pidfd);
+	ASSERT_OK(err, "boot_delete");
+
+	/* Only Tree SRCU enqueues via rcu_segcblist_enqueue(); skip elsewhere. */
+	if (!skel->bss->hits) {
+		test__skip();
+		goto out;
+	}
+	ASSERT_EQ(skel->bss->reentered, 1, "reentry_deferred");
+out:
+	if (pidfd >= 0)
+		close(pidfd);
+	rcu_reentry__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/rcu_reentry.c b/tools/testing/selftests/bpf/progs/rcu_reentry.c
new file mode 100644
index 0000000000000..d92a927ff51c0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rcu_reentry.c
@@ -0,0 +1,45 @@
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
+int reentered;
+
+SEC("fentry/rcu_segcblist_enqueue")
+int BPF_PROG(reenter)
+{
+	struct task_struct *cur;
+
+	if (reentered || !target_pid)
+		return 0;
+
+	cur = bpf_get_current_task_btf();
+	if (!cur || cur->pid != target_pid)
+		return 0;
+
+	/* Re-enter via a task-storage delete, which calls call_rcu_tasks_trace(). */
+	__sync_fetch_and_add(&hits, 1);
+	bpf_task_storage_get(&task_stg, cur, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	bpf_task_storage_delete(&task_stg, cur);
+
+	reentered = 1;
+	return 0;
+}
-- 
2.53.0-Meta

