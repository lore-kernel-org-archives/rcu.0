Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782374;
	b=CYuTg/NxGX5ci6IbAci1hChar4v9i0gkamCXozRTQOUzYTlPkcjoXR6b0fFFtE74d60J
	 YqpVjP46qR/viaPYE7xBX3XQ22LfYzZuwklp39NIZOFKpXvU0K9qd3Sbr41cjrrrWQxPs
	 GKznk/3vNAqH/YQUv3Mc+jgTZTfFuRFJUBQLWl2XeyTosoENBlh5Tz4oW6ZonNSQqgzAD
	 fk1BhzoXlxvZ7lwWI9LmuM+G+fFZxK6ET2mUVqPDCE/cmizuI4qj77o2ceUCeGARY7TbA
	 9kUNNGLzyFXW8ekT9AjpbhwkEt5fTzTU0jh6QMwnhAsFgQe7F3/0cylVscwSqVa5Dyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=rjt0PRk9Gb+Q21fYjCUgCYIjBgmlKQGD4ruQG+lZyRA=;
	b=iR+8j3uPVSDP8KF0nD3IMGDxAjTqWhrom2kHmgt+GuP7XUI885Tx8lLXeYfpoBR+5YJl
	 2GvNVJGO3ksqDNII7e69IIM0jvnn+Fto/R+sBg2ZhX6fYk1G9MgzxEm70UoSKxlaJEDBm
	 ORbTstqDfdmAt4NarzPgLdYpmTABWkvJ7CMAIt8eezDydQQzYBnFBHO11bDI251zL+gEa
	 g05mQx0hBxVpEZ8SijpkIk5jVClgJzdjrA2JGBZAJz9n9u/F47lVdEO0IprGbDvVLVL3x
	 OrXGt3Ep46po9dbOFGLgShQTR0WS3IBEdYgdhs83yg4L2ssFIU1KlPVLMrETi0wJmxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="siQm4nd/";
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF55606A31D
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 19:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFF55606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=siQm4nd/
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so3057245eec.1
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 12:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792782373; x=1793387173; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rjt0PRk9Gb+Q21fYjCUgCYIjBgmlKQGD4ruQG+lZyRA=;
        b=siQm4nd/mC38QdJWvKFL3NwoEHE1jAJ346WbCIPhN7AC3yT/3xjPBVcDLIi90uu1eI
         jrb1sfRnZAJ8pNHp9YKyKFR9w6Dqj7WyN1nXMz/WnkY8O5tj0jR2Bxy4XolrsmAxmev5
         QgjQt+yjez4sTT6T1CeGiETFH9KOhtj6zdzX+3z/i9DpYqWdKNleBROQsRjAYFtx5NqG
         Xg0Xi+NaHG/ZfaNsdCl0jP254Tn90096fmVlzZbv8Mmi4GqpwDN2NVkfMpPhEwMbdadL
         ilRUsi3Rf4ZzN7xf1iD1axdMjca5XtZ333gB/Uoc0xSu6urwwN9meJYlkzjwodLlVKwd
         CNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782373; x=1793387173;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rjt0PRk9Gb+Q21fYjCUgCYIjBgmlKQGD4ruQG+lZyRA=;
        b=blu1Y3+3sy/UAIsCKZxOW46NMYxtCgF1jIVZPFlO2k4+LbbsOJxMigw8CYI6mvUGDG
         Josi/vEifxKP/zLGV1pqpy20PXjfCD59CDIPJNLV5QvZ1D0NUvBzIkAc/2V5UCP9qafC
         VArSgw5aOaLefts3XER/neOUsmznoitc4NIisUu4imkn6c/SXt52VU/WqxBkz9DqjTMh
         cPgz3jFJyGXqx16cYSQeK9lezgMSnQr0HEQ4DKbaUgAU2WFsW0gI/0WpWLSqJq3gkBzg
         /ZoQyfj5iYbVECQkvXld8KpeA/y/ruJz8AU4FWQaCluDkoualaf5aMC/7uIdVPRaBKIM
         C5yA==
X-Forwarded-Encrypted: i=1; AKwUvByZ7ZaHYf9oYIfBt4ftYysDGfDJH91mpbqAosDVvuXDfzS8mBtELg0QjHWYo2pNF72PDeQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtpeJZEvtQs4E3f0yXlMkD6IF4VaJzzjVA2Sx4Kl0HKFQJSvA+
	8w6q4mO/yqFBd9youZpEo1bR4Lci5QzR/hgNSDrfENA97Gs+ewsmJHxPIiiOgM9+q8f9jvUokUl
	B7PSXVoaQHQ==
X-Received: from dybmj3.prod.google.com ([2002:a05:7301:e03:b0:35a:f5b8:c8c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:514a:b0:35e:6eae:c01a
 with SMTP id 5a478bee46e88-369e84bd11dmr278145eec.19.1792782372308; Fri, 23
 Oct 2026 12:06:12 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:05:52 -0700
In-Reply-To: <20261023190558.3050796-1-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022203003.1779152-1-irogers@google.com> <20261023190558.3050796-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023190558.3050796-6-irogers@google.com>
Subject: [PATCH v7 05/11] perf bpf-filter: Add lock_held() sample filter for
 global mutexes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add BPF sample filter predicates lock_held(<lock>),
lock_held_read(<lock>) / lock_held_shared(<lock>), and
lock_held_write(<lock>) / lock_held_exclusive(<lock>) (as well as ':R'
and ':W' suffixes on <lock>) to allow recording perf event samples only
when a specified kernel lock is held (or not held with '!').

In this initial step, support global/static kernel mutex symbols (e.g.
lock_held(cgroup_mutex)) resolved via /proc/kallsyms. On sample
overflow, perf_sample_filter and perf_tp_sample_filter inspect the
mutex's owner field directly in kernel memory via get_lock_owner()
without attaching any BPF fentry/fexit hooks.

Lock symbols are classified by classify_lock_sym(). As kallsyms gives a
symbol address but not its type, this uses BTF where possible: a
__percpu_rwsem_rc_<name> per-CPU variable (always present in BTF)
identifies percpu-rwsems, and the BTF_KIND_VAR type of the symbol (e.g.
struct mutex) is used when vmlinux BTF has global variables (pahole
--btf_features=global_var, which scripts/Makefile.btf doesn't enable by
default). Otherwise the symbol name suffix (e.g. '_mutex') is used. A
misclassification is benign: the owner field is only read with
bpf_probe_read_kernel() at a kernel data/bss symbol address (functions
are rejected), so at worst the filter won't match.

Subsequent commits extend lock_held() to other kernel lock types,
per-process and semi-global locks, slab cache locks, and RCU/SRCU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt     |  16 +-
 tools/perf/util/bpf-filter.c                 | 516 ++++++++++++++++++-
 tools/perf/util/bpf-filter.h                 |  13 +
 tools/perf/util/bpf-filter.l                 |  31 +-
 tools/perf/util/bpf-filter.y                 |  47 +-
 tools/perf/util/bpf_skel/sample-filter.h     |  36 ++
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  54 ++
 tools/perf/util/parse-events.c               |   2 +
 8 files changed, 695 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6646e16633ef..34dd9b1a5365 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -215,7 +215,21 @@ OPTIONS
 	  ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
 	  code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
 	  p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
-	  mem_dtlb, mem_blk, mem_hops, uid, gid
+	  mem_dtlb, mem_blk, mem_hops, uid, gid, cgroup, lock_held(<lock>),
+	  lock_held_read(<lock>), lock_held_shared(<lock>),
+	  lock_held_write(<lock>), lock_held_exclusive(<lock>)
+
+	The 'lock_held(<lock>)' predicate (or '!lock_held(<lock>)') filters
+	samples based on whether the specified kernel lock is currently held
+	by the kernel thread.  To differentiate between shared/read holding
+	and exclusive/write holding, use 'lock_held_read(<lock>)' (alias
+	'lock_held_shared(<lock>)') or 'lock_held_write(<lock>)' (alias
+	'lock_held_exclusive(<lock>)'), or append ':R' or ':W' to <lock>.
+	<lock> can be a kernel mutex symbol name (e.g.
+	'lock_held(cgroup_mutex)').  When filtering on a mutex symbol
+	('*_mutex'), 'perf_sample_filter' inspects the lock's 'owner' field
+	directly in kernel memory on each sample without attaching any BPF
+	fentry/fexit hooks.
 
 	The <operator> can be one of:
 	  ==, !=, >, >=, <, <=, &
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 0d3c700d3dcd..5d8f60649c5d 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -43,21 +43,30 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <string.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 
 #include <bpf/bpf.h>
+#include <bpf/btf.h>
 #include <linux/err.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
 #include <api/fs/fs.h>
 #include <internal/xyarray.h>
 #include <perf/threadmap.h>
+#include <symbol/kallsyms.h>
 
 #include "util/cap.h"
 #include "util/debug.h"
 #include "util/evsel.h"
+#include "util/symbol_conf.h"
 #include "util/target.h"
 #include "util/thread_map.h"
 #include "util/bpf-utils.h"
@@ -126,7 +135,8 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 {
 	const struct perf_sample_info *info;
 
-	if (expr->term == PBF_TERM_UID || expr->term == PBF_TERM_GID) {
+	if (expr->term == PBF_TERM_UID || expr->term == PBF_TERM_GID ||
+	    expr->term == PBF_TERM_LOCK_HELD) {
 		/* Not dependent on the sample_type as computed from a BPF helper. */
 		return 0;
 	}
@@ -169,9 +179,422 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 	return -1;
 }
 
-static int get_filter_entries(struct evsel *evsel, struct perf_bpf_filter_entry *entry)
+static int split_lock_name_mode(const char *name, int expr_part,
+				char *base_buf, size_t buf_sz,
+				bool *has_amp, unsigned int *mode_out)
 {
-	int i = 0;
+	const char *bare;
+	size_t len;
+	unsigned int expr_mode = expr_part & PBF_LOCK_MODE_MASK;
+	unsigned int suffix_mode = 0;
+
+	if (!name || !*name)
+		return -EINVAL;
+
+	*has_amp = (name[0] == '&');
+	bare = *has_amp ? name + 1 : name;
+	len = strlen(bare);
+	if (len == 0)
+		return -EINVAL;
+
+	if (len > 2 && !strcmp(bare + len - 2, ":R")) {
+		suffix_mode = PBF_LOCK_MODE_READ;
+		len -= 2;
+	} else if (len > 2 && !strcmp(bare + len - 2, ":W")) {
+		suffix_mode = PBF_LOCK_MODE_WRITE;
+		len -= 2;
+	}
+
+	if (len == 0 || len >= buf_sz)
+		return -EINVAL;
+
+	if (expr_mode && expr_mode != PBF_LOCK_MODE_ANY &&
+	    suffix_mode && expr_mode != suffix_mode)
+		return -EINVAL;
+
+	memcpy(base_buf, bare, len);
+	base_buf[len] = '\0';
+
+	if (suffix_mode)
+		*mode_out = suffix_mode;
+	else if (expr_mode)
+		*mode_out = expr_mode;
+	else
+		*mode_out = PBF_LOCK_MODE_ANY;
+
+	return 0;
+}
+
+struct lock_sym_cb_args {
+	const char *name;
+	u64 addr;
+	bool in_text;
+	bool in_data;
+	bool found;
+};
+
+/*
+ * Module symbols in /proc/kallsyms have a "\t[<module>]" suffix that
+ * kallsyms__parse() includes in the name, so also match the name followed by
+ * a tab.
+ */
+static bool kallsyms_name_match(const char *kname, const char *name)
+{
+	size_t n = strlen(name);
+
+	return !strncmp(kname, name, n) && (kname[n] == '\0' || kname[n] == '\t');
+}
+
+static int find_lock_sym_cb(void *arg, const char *name, char type, u64 start)
+{
+	struct lock_sym_cb_args *args = arg;
+
+	if (!strcmp(name, "_text") || !strcmp(name, "_stext") ||
+	    !strcmp(name, "_sinittext")) {
+		args->in_text = true;
+		return 0;
+	}
+	if (!strcmp(name, "_etext") || !strcmp(name, "_einittext")) {
+		args->in_text = false;
+		return 0;
+	}
+	if (!strcmp(name, "_sdata") || !strcmp(name, "__bss_start")) {
+		args->in_text = false;
+		args->in_data = true;
+		return 0;
+	}
+	if (!strcmp(name, "_edata") || !strcmp(name, "__bss_stop")) {
+		args->in_data = false;
+		return 0;
+	}
+
+	/*
+	 * Ignore kernel text functions, module text functions, and
+	 * absolute/undefined symbols. On CONFIG_LTO_CLANG kernels, vmlinux
+	 * .data symbols between _sdata and _edata may have kallsyms type
+	 * 'T'/'t', so allow 'T'/'t' within vmlinux data/bss (args->in_data),
+	 * that is between _sdata.._edata and __bss_start..__bss_stop.
+	 */
+	if (args->in_text || type == 'A' || type == 'a' ||
+	    type == 'U' || type == 'u' ||
+	    (!args->in_data && kallsyms__is_function(type)))
+		return 0;
+
+	if (kallsyms_name_match(name, args->name)) {
+		args->found = true;
+		args->addr = start;
+		if (start != 0)
+			return 1;
+	}
+	return 0;
+}
+
+static int find_kernel_lock_sym(const char *name, u64 *addr)
+{
+	struct lock_sym_cb_args args = {
+		.name = name,
+	};
+	const char *kallsyms_filename = "/proc/kallsyms";
+
+	if (symbol_conf.kallsyms_name != NULL)
+		kallsyms_filename = symbol_conf.kallsyms_name;
+
+	if (kallsyms__parse(kallsyms_filename, &args, find_lock_sym_cb) < 0)
+		return -ENOENT;
+
+	if (!args.found)
+		return -ENOENT;
+
+	if (args.addr == 0) {
+		pr_err("Error: Kernel symbol '%s' address is 0 (check permissions / kptr_restrict)\n",
+		       name);
+		return -EACCES;
+	}
+
+	*addr = args.addr;
+	return 0;
+}
+
+static bool btf_has_func(struct btf *btf, const char *name)
+{
+	return btf && name && btf__find_by_name_kind(btf, name, BTF_KIND_FUNC) > 0;
+}
+
+/* Kind of lock a global/static kernel lock symbol refers to. */
+enum lock_sym_class {
+	LOCK_SYM_UNKNOWN,
+	LOCK_SYM_MUTEX,
+	LOCK_SYM_RTMUTEX,
+	LOCK_SYM_RWSEM,
+	LOCK_SYM_PERCPU_RWSEM,
+	LOCK_SYM_SEM,
+	/* A "*sem" symbol that may be a struct semaphore or struct rw_semaphore. */
+	LOCK_SYM_SEM_OR_RWSEM,
+	LOCK_SYM_SPIN,
+	LOCK_SYM_RWLOCK,
+};
+
+/*
+ * DEFINE_PERCPU_RWSEM() and DEFINE_STATIC_PERCPU_RWSEM() define a per-CPU
+ * __percpu_rwsem_rc_<name> variable, which (as a per-CPU variable) is always
+ * present in vmlinux BTF.
+ */
+static bool is_percpu_rwsem_sym(struct btf *btf, const char *name)
+{
+	char rc_name[160];
+
+	if (str_ends_with(name, "percpu_rwsem") ||
+	    str_ends_with(name, "pcpu_rwsem"))
+		return true;
+
+	if (!btf)
+		return false;
+
+	snprintf(rc_name, sizeof(rc_name), "__percpu_rwsem_rc_%s", name);
+	return btf__find_by_name_kind(btf, rc_name, BTF_KIND_VAR) > 0;
+}
+
+/*
+ * Classify a lock symbol by the type of its BTF variable. Global variables
+ * are only present in vmlinux BTF when pahole encodes them
+ * (--btf_features=global_var), otherwise LOCK_SYM_UNKNOWN is returned.
+ */
+static enum lock_sym_class btf_lock_sym_class(struct btf *btf, const char *name)
+{
+	const struct btf_type *t;
+	s32 id;
+
+	if (!btf)
+		return LOCK_SYM_UNKNOWN;
+
+	id = btf__find_by_name_kind(btf, name, BTF_KIND_VAR);
+	if (id <= 0)
+		return LOCK_SYM_UNKNOWN;
+
+	t = btf__type_by_id(btf, id);
+	while (t) {
+		const char *tname;
+
+		t = btf__type_by_id(btf, t->type);
+		if (!t)
+			break;
+		tname = btf__name_by_offset(btf, t->name_off) ?: "";
+		if (btf_is_typedef(t)) {
+			if (!strcmp(tname, "spinlock_t") || !strcmp(tname, "raw_spinlock_t"))
+				return LOCK_SYM_SPIN;
+			if (!strcmp(tname, "rwlock_t"))
+				return LOCK_SYM_RWLOCK;
+			continue;
+		}
+		if (btf_is_mod(t))
+			continue;
+		if (!btf_is_struct(t))
+			break;
+		if (!strcmp(tname, "mutex"))
+			return LOCK_SYM_MUTEX;
+		if (!strcmp(tname, "rt_mutex"))
+			return LOCK_SYM_RTMUTEX;
+		if (!strcmp(tname, "rw_semaphore"))
+			return LOCK_SYM_RWSEM;
+		if (!strcmp(tname, "percpu_rw_semaphore"))
+			return LOCK_SYM_PERCPU_RWSEM;
+		if (!strcmp(tname, "semaphore"))
+			return LOCK_SYM_SEM;
+		if (!strcmp(tname, "spinlock") || !strcmp(tname, "raw_spinlock"))
+			return LOCK_SYM_SPIN;
+		break;
+	}
+	return LOCK_SYM_UNKNOWN;
+}
+
+/*
+ * Classify a global/static kernel lock symbol, preferring BTF type
+ * information and falling back to the symbol's name suffix. Used both when
+ * pre-scanning filters (to select which lock tracing programs to load) and
+ * when resolving them, so the two always agree.
+ */
+static enum lock_sym_class classify_lock_sym(struct btf *btf, const char *name)
+{
+	enum lock_sym_class cls;
+
+	if (is_percpu_rwsem_sym(btf, name))
+		return LOCK_SYM_PERCPU_RWSEM;
+
+	cls = btf_lock_sym_class(btf, name);
+	if (cls != LOCK_SYM_UNKNOWN)
+		return cls;
+
+	if (str_ends_with(name, "rt_mutex") || str_ends_with(name, "rtmutex"))
+		return LOCK_SYM_RTMUTEX;
+	if (str_ends_with(name, "mutex"))
+		return LOCK_SYM_MUTEX;
+	if (str_ends_with(name, "rwsem"))
+		return LOCK_SYM_RWSEM;
+	if (str_ends_with(name, "spinlock"))
+		return LOCK_SYM_SPIN;
+	if (str_ends_with(name, "rwlock"))
+		return LOCK_SYM_RWLOCK;
+	/*
+	 * Both counting semaphores (e.g. console_sem) and rw_semaphores (e.g.
+	 * namespace_sem, uts_sem) commonly use a "_sem" suffix.
+	 */
+	if (str_ends_with(name, "sem"))
+		return LOCK_SYM_SEM_OR_RWSEM;
+	return LOCK_SYM_UNKNOWN;
+}
+
+static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
+				  struct btf **btf,
+				  bool *has_lock_filter)
+{
+	if (expr->term != PBF_TERM_LOCK_HELD || !expr->lock_name)
+		return;
+
+	if (!*has_lock_filter) {
+		*has_lock_filter = true;
+		/* Load vmlinux BTF on the first lock filter to classify locks. */
+		*btf = btf__load_vmlinux_btf();
+		if (libbpf_get_error(*btf))
+			*btf = NULL;
+	}
+}
+
+/*
+ * Pre-scan the filters of evsel for lock_held() expressions. On finding the
+ * first one, *btf is set to the loaded vmlinux BTF (or NULL on failure) for
+ * the caller to free.
+ */
+static void prescan_lock_filters(struct evsel *evsel, struct btf **btf,
+				 bool *has_lock_filter)
+{
+	struct perf_bpf_filter_expr *expr, *group;
+
+	*btf = NULL;
+	*has_lock_filter = false;
+
+	list_for_each_entry(expr, &evsel->bpf_filters, list) {
+		prescan_one_lock_expr(expr, btf, has_lock_filter);
+		if (expr->op == PBF_OP_GROUP_BEGIN) {
+			list_for_each_entry(group, &expr->groups, list)
+				prescan_one_lock_expr(group, btf, has_lock_filter);
+		}
+	}
+}
+
+static int normalize_lock_expr_op(const struct perf_bpf_filter_expr *expr,
+				  enum perf_bpf_filter_op *op_out)
+{
+	switch (expr->op) {
+	case PBF_OP_EQ:
+		if (expr->val == 1) {
+			*op_out = PBF_OP_EQ;
+			return 0;
+		}
+		if (expr->val == 0) {
+			*op_out = PBF_OP_NEQ;
+			return 0;
+		}
+		break;
+	case PBF_OP_NEQ:
+		if (expr->val == 0) {
+			*op_out = PBF_OP_EQ;
+			return 0;
+		}
+		if (expr->val == 1) {
+			*op_out = PBF_OP_NEQ;
+			return 0;
+		}
+		break;
+	case PBF_OP_GT:
+		if (expr->val == 0) {
+			*op_out = PBF_OP_EQ;
+			return 0;
+		}
+		break;
+	case PBF_OP_GE:
+		if (expr->val == 1) {
+			*op_out = PBF_OP_EQ;
+			return 0;
+		}
+		break;
+	case PBF_OP_LT:
+		if (expr->val == 1) {
+			*op_out = PBF_OP_NEQ;
+			return 0;
+		}
+		break;
+	case PBF_OP_LE:
+		if (expr->val == 0) {
+			*op_out = PBF_OP_NEQ;
+			return 0;
+		}
+		break;
+	case PBF_OP_AND:
+		if (expr->val & 1) {
+			*op_out = PBF_OP_EQ;
+			return 0;
+		}
+		break;
+	case PBF_OP_GROUP_BEGIN:
+	case PBF_OP_GROUP_END:
+	case PBF_OP_DONE:
+	default:
+		break;
+	}
+	pr_err("Error: Invalid comparison for boolean lock_held(%s) predicate\n",
+	       expr->lock_name ?: "");
+	return -EINVAL;
+}
+
+static int resolve_lock_expr(struct btf *btf, struct perf_bpf_filter_expr *expr,
+			     struct perf_bpf_filter_entry *entry)
+{
+	const char *name = expr->lock_name;
+	char base[128];
+	bool has_amp;
+	unsigned int mode;
+	u64 addr = 0;
+	int ret;
+
+	ret = normalize_lock_expr_op(expr, &entry->op);
+	if (ret < 0)
+		return ret;
+
+	if (split_lock_name_mode(name, expr->part, base, sizeof(base),
+				 &has_amp, &mode) < 0 || has_amp) {
+		pr_err("Error: Invalid kernel lock filter '%s'\n", name ?: "");
+		return -EINVAL;
+	}
+
+	if (btf_has_func(btf, base)) {
+		pr_err("Error: '%s' is a kernel function, not a lock\n", name);
+		return -EINVAL;
+	}
+
+	if (classify_lock_sym(btf, base) == LOCK_SYM_MUTEX) {
+		ret = find_kernel_lock_sym(base, &addr);
+		if (ret == 0) {
+			if (!(mode & PBF_LOCK_MODE_WRITE)) {
+				pr_err("Error: Lock '%s' is exclusive and does not support read/shared mode\n",
+				       name);
+				return -EINVAL;
+			}
+			entry->part = PBF_LOCK_ADDR | mode | PBF_LOCK_DIRECT_MUTEX;
+			entry->value = addr;
+			return 0;
+		}
+		if (ret == -EACCES)
+			return ret;
+	}
+
+	pr_err("Error: Cannot resolve kernel lock '%s'\n", name);
+	return -EINVAL;
+}
+
+static int get_filter_entries(struct evsel *evsel, struct btf *btf,
+			      struct perf_bpf_filter_entry *entry)
+{
+	int i = 0, ret;
 	struct perf_bpf_filter_expr *expr;
 
 	list_for_each_entry(expr, &evsel->bpf_filters, list) {
@@ -185,6 +608,11 @@ static int get_filter_entries(struct evsel *evsel, struct perf_bpf_filter_entry
 		entry[i].part = expr->part;
 		entry[i].term = expr->term;
 		entry[i].value = expr->val;
+		if (expr->term == PBF_TERM_LOCK_HELD) {
+			ret = resolve_lock_expr(btf, expr, &entry[i]);
+			if (ret < 0)
+				return ret;
+		}
 		i++;
 
 		if (expr->op == PBF_OP_GROUP_BEGIN) {
@@ -198,6 +626,11 @@ static int get_filter_entries(struct evsel *evsel, struct perf_bpf_filter_entry
 				entry[i].part = group->part;
 				entry[i].term = group->term;
 				entry[i].value = group->val;
+				if (group->term == PBF_TERM_LOCK_HELD) {
+					ret = resolve_lock_expr(btf, group, &entry[i]);
+					if (ret < 0)
+						return ret;
+				}
 				i++;
 			}
 
@@ -437,23 +870,28 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 {
 	int i, x, y, fd, ret;
 	struct sample_filter_bpf *skel = NULL;
+	struct btf *btf = NULL;
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
 	bool is_tracepoint = (evsel->core.attr.type == PERF_TYPE_TRACEPOINT);
+	bool has_lock_filter = false;
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
 		return -1;
 
-	ret = get_filter_entries(evsel, entry);
-	if (ret < 0) {
-		pr_err("Failed to process filter entries\n");
+	prescan_lock_filters(evsel, &btf, &has_lock_filter);
+
+	if ((has_lock_filter || is_tracepoint) && geteuid() != 0 &&
+	    !perf_cap__capable(CAP_BPF)) {
+		pr_err("Error: BPF filter requires CAP_BPF capability\n");
+		ret = -EPERM;
 		goto err;
 	}
 
-	if (is_tracepoint && geteuid() != 0 && !perf_cap__capable(CAP_BPF)) {
-		pr_err("Error: Tracepoint BPF filter requires CAP_BPF capability\n");
-		ret = -EPERM;
+	ret = get_filter_entries(evsel, btf, entry);
+	if (ret < 0) {
+		pr_err("Failed to process filter entries\n");
 		goto err;
 	}
 
@@ -493,6 +931,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		}
 
 		close(fd);
+		btf__free(btf);
 		free(entry);
 		return 0;
 	}
@@ -513,6 +952,9 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
+	if (has_lock_filter)
+		skel->bss->lock_enabled = 1;
+
 	i = 0;
 	fd = bpf_map__fd(skel->maps.filters);
 
@@ -552,11 +994,13 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 			}
 		}
 	}
+	btf__free(btf);
 	free(entry);
 	evsel->bpf_skel = skel;
 	return 0;
 
 err:
+	btf__free(btf);
 	free(entry);
 	if (!list_empty(&pinned_filters)) {
 		struct pinned_filter_idx *pfi, *tmp;
@@ -571,6 +1015,21 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	return ret;
 }
 
+void perf_bpf_filter_expr__delete(struct perf_bpf_filter_expr *expr)
+{
+	struct perf_bpf_filter_expr *group, *tmp;
+
+	if (!expr)
+		return;
+
+	list_for_each_entry_safe(group, tmp, &expr->groups, list) {
+		list_del(&group->list);
+		perf_bpf_filter_expr__delete(group);
+	}
+	zfree(&expr->lock_name);
+	free(expr);
+}
+
 int perf_bpf_filter__destroy(struct evsel *evsel)
 {
 	struct perf_bpf_filter_expr *expr, *tmp;
@@ -578,7 +1037,7 @@ int perf_bpf_filter__destroy(struct evsel *evsel)
 
 	list_for_each_entry_safe(expr, tmp, &evsel->bpf_filters, list) {
 		list_del(&expr->list);
-		free(expr);
+		perf_bpf_filter_expr__delete(expr);
 	}
 	sample_filter_bpf__destroy(evsel->bpf_skel);
 
@@ -630,7 +1089,7 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term
 {
 	struct perf_bpf_filter_expr *expr;
 
-	expr = malloc(sizeof(*expr));
+	expr = zalloc(sizeof(*expr));
 	if (expr != NULL) {
 		expr->term = term;
 		expr->part = part;
@@ -641,6 +1100,28 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term
 	return expr;
 }
 
+struct perf_bpf_filter_expr *perf_bpf_filter_expr__new_lock(const char *lock_name,
+							    int mode,
+							    enum perf_bpf_filter_op op,
+							    unsigned long val)
+{
+	struct perf_bpf_filter_expr *expr;
+
+	if (!lock_name || !*lock_name)
+		return NULL;
+
+	expr = perf_bpf_filter_expr__new(PBF_TERM_LOCK_HELD, mode, op, val);
+	if (!expr)
+		return NULL;
+
+	expr->lock_name = strdup(lock_name);
+	if (!expr->lock_name) {
+		free(expr);
+		return NULL;
+	}
+	return expr;
+}
+
 static bool check_bpf_filter_capable(void)
 {
 	int fd;
@@ -661,14 +1142,11 @@ static bool check_bpf_filter_capable(void)
 	return false;
 }
 
-int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
+int __perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
 {
 	YY_BUFFER_STATE buffer;
 	int ret;
 
-	if (!check_bpf_filter_capable())
-		return -EPERM;
-
 	buffer = perf_bpf_filter__scan_string(str);
 
 	ret = perf_bpf_filter_parse(expr_head);
@@ -680,6 +1158,14 @@ int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
 	return ret;
 }
 
+int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
+{
+	if (!check_bpf_filter_capable())
+		return -EPERM;
+
+	return __perf_bpf_filter__parse(expr_head, str);
+}
+
 /*
  * perf_bpf_filter__pin() and perf_bpf_filter__unpin() only load
  * perf_sample_filter and disable autoload on other programs in the skeleton
diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
index 818c554b91b2..fda95ff226b3 100644
--- a/tools/perf/util/bpf-filter.h
+++ b/tools/perf/util/bpf-filter.h
@@ -14,6 +14,13 @@ struct perf_bpf_filter_expr {
 	int part;
 	enum perf_bpf_filter_term term;
 	unsigned long val;
+	/*
+	 * Raw lock descriptor string for PBF_TERM_LOCK_HELD expressions
+	 * (e.g. "&cgroup_mutex", "mmap_lock", "&dentry", "rwsem:R").
+	 * Resolved into `entry.part` and `entry.target` during
+	 * perf_bpf_filter__prepare().
+	 */
+	char *lock_name;
 };
 
 struct evsel;
@@ -27,6 +34,12 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term
 						       int part,
 						       enum perf_bpf_filter_op op,
 						       unsigned long val);
+struct perf_bpf_filter_expr *perf_bpf_filter_expr__new_lock(const char *lock_name,
+							    int mode,
+							    enum perf_bpf_filter_op op,
+							    unsigned long val);
+void perf_bpf_filter_expr__delete(struct perf_bpf_filter_expr *expr);
+int __perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
 int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
 int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target);
 int perf_bpf_filter__destroy(struct evsel *evsel);
diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index 1be9df6550fc..b4022110f1e5 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -1,9 +1,12 @@
 %option prefix="perf_bpf_filter_"
 %option noyywrap
 
+%x LOCK_ARG
+
 %{
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <linux/perf_event.h>
 
 #include "bpf-filter.h"
@@ -76,7 +79,7 @@ static int path_or_error(void)
 num_dec		[0-9]+
 num_hex		0[Xx][0-9a-fA-F]+
 space		[ \t]+
-path		[^ \t\n,]+
+path		[^ \t\n,()!=>&|<]+
 ident		[_a-zA-Z][_a-zA-Z0-9]+
 
 %%
@@ -116,7 +119,31 @@ mem_hops	{ return sample_part(PBF_TERM_DATA_SRC, 8); }
 uid		{ return sample(PBF_TERM_UID); }
 gid		{ return sample(PBF_TERM_GID); }
 cgroup		{ return sample_path(PBF_TERM_CGROUP); }
-
+lock_held[ \t]*"("	{
+				BEGIN(LOCK_ARG);
+				perf_bpf_filter_lval.num = PBF_LOCK_MODE_ANY;
+				return BFT_LOCK_HELD;
+			}
+(lock_held_read|lock_held_shared)[ \t]*"("	{
+				BEGIN(LOCK_ARG);
+				perf_bpf_filter_lval.num = PBF_LOCK_MODE_READ;
+				return BFT_LOCK_HELD;
+			}
+(lock_held_write|lock_held_exclusive)[ \t]*"("	{
+				BEGIN(LOCK_ARG);
+				perf_bpf_filter_lval.num = PBF_LOCK_MODE_WRITE;
+				return BFT_LOCK_HELD;
+			}
+
+<LOCK_ARG>{space}	{ }
+<LOCK_ARG>[^ \t\n()]+	{
+				perf_bpf_filter_lval.lock_name = strdup(perf_bpf_filter_text);
+				return BFT_LOCK_NAME;
+			}
+<LOCK_ARG>")"		{ BEGIN(INITIAL); return ')'; }
+<LOCK_ARG>.|\n		{ BEGIN(INITIAL); return BFT_ERROR; }
+
+"!"		{ return '!'; }
 "=="		{ return operator(PBF_OP_EQ); }
 "!="		{ return operator(PBF_OP_NEQ); }
 ">"		{ return operator(PBF_OP_GT); }
diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
index 5a79a8e7a45b..5ae05d4608c6 100644
--- a/tools/perf/util/bpf-filter.y
+++ b/tools/perf/util/bpf-filter.y
@@ -8,9 +8,11 @@
 #endif
 
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <linux/compiler.h>
 #include <linux/list.h>
+#include <linux/zalloc.h>
 #include "bpf-filter.h"
 #include "cgroup.h"
 
@@ -31,6 +33,11 @@ static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
 {
 	unsigned long num;
 	char *path;
+	char *lock_name;
+	struct {
+		char *name;
+		int mode;
+	} lock;
 	struct {
 		enum perf_bpf_filter_term term;
 		int part;
@@ -40,12 +47,17 @@ static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
 }
 
 %token BFT_SAMPLE BFT_SAMPLE_PATH BFT_OP BFT_ERROR BFT_NUM BFT_LOGICAL_OR BFT_PATH
+%token BFT_LOCK_HELD BFT_LOCK_NAME
 %type <expr> filter_term filter_expr
-%destructor { free ($$); } <expr>
+%destructor { perf_bpf_filter_expr__delete($$); } <expr>
+%destructor { free($$); } <lock_name>
+%destructor { free($$.name); } <lock>
 %type <sample> BFT_SAMPLE BFT_SAMPLE_PATH
 %type <op> BFT_OP
-%type <num> BFT_NUM
+%type <num> BFT_NUM BFT_LOCK_HELD
 %type <path> BFT_PATH
+%type <lock_name> BFT_LOCK_NAME
+%type <lock> lock_term
 
 %%
 
@@ -105,5 +117,36 @@ BFT_SAMPLE_PATH BFT_OP BFT_PATH
 	$$ = perf_bpf_filter_expr__new($1.term, $1.part, $2, cgroup_id);
 	cgroup__put(cgrp);
 }
+|
+lock_term
+{
+	$$ = perf_bpf_filter_expr__new_lock($1.name, $1.mode, PBF_OP_EQ, 1);
+	zfree(&$1.name);
+	if (!$$)
+		YYERROR;
+}
+|
+'!' lock_term
+{
+	$$ = perf_bpf_filter_expr__new_lock($2.name, $2.mode, PBF_OP_EQ, 0);
+	zfree(&$2.name);
+	if (!$$)
+		YYERROR;
+}
+|
+lock_term BFT_OP BFT_NUM
+{
+	$$ = perf_bpf_filter_expr__new_lock($1.name, $1.mode, $2, $3);
+	zfree(&$1.name);
+	if (!$$)
+		YYERROR;
+}
+
+lock_term:
+BFT_LOCK_HELD BFT_LOCK_NAME ')'
+{
+	$$.name = $2;
+	$$.mode = $1;
+}
 
 %%
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index 683fec85e71e..ca1cf586ed6e 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -53,8 +53,44 @@ enum perf_bpf_filter_term {
 	/* Terms computed from BPF helpers. */
 	PBF_TERM_UID,
 	PBF_TERM_GID,
+	/*
+	 * Kernel lock held predicate (`lock_held(...)`). Evaluates whether the
+	 * specified kernel lock is currently held by the running task/CPU.
+	 * The lock specification kind is stored in `entry.part`
+	 * (`enum perf_bpf_lock_target_kind`), `entry.op` is normalized to
+	 * `PBF_OP_EQ` (match when held) or `PBF_OP_NEQ` (match when not held),
+	 * and the resolved target address is stored in `entry.value`.
+	 */
+	PBF_TERM_LOCK_HELD,
 };
 
+/*
+ * Lock target categories for PBF_TERM_LOCK_HELD filters.
+ * Stored in `perf_bpf_filter_entry.part`.
+ */
+enum perf_bpf_lock_target_kind {
+	PBF_LOCK_NONE = 0,
+	/*
+	 * Specific global or static lock address resolved from kallsyms.
+	 * `entry.value` holds the kernel address.
+	 */
+	PBF_LOCK_ADDR,
+};
+
+/*
+ * `perf_bpf_filter_entry.part` layout for PBF_TERM_LOCK_HELD:
+ *   Bits 0..3: `enum perf_bpf_lock_target_kind`
+ *   Bit  4:    PBF_LOCK_MODE_READ      (match read/shared lock holding)
+ *   Bit  5:    PBF_LOCK_MODE_WRITE     (match write/exclusive lock holding)
+ *   Bit  6:    PBF_LOCK_DIRECT_MUTEX   (inspect struct mutex owner)
+ */
+#define PBF_LOCK_KIND_MASK	0x0fU
+#define PBF_LOCK_MODE_READ	(1U << 4)
+#define PBF_LOCK_MODE_WRITE	(1U << 5)
+#define PBF_LOCK_MODE_ANY	(PBF_LOCK_MODE_READ | PBF_LOCK_MODE_WRITE)
+#define PBF_LOCK_MODE_MASK	PBF_LOCK_MODE_ANY
+#define PBF_LOCK_DIRECT_MUTEX	(1U << 6)
+
 /* BPF map entry for filtering */
 struct perf_bpf_filter_entry {
 	enum perf_bpf_filter_op op;
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index a190374ed87a..42556ab0e2d5 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
+#include "lock_data.h"
 #include "sample-filter.h"
 
 /* BPF map that will be filled by user space */
@@ -45,8 +46,57 @@ struct lost_count {
 
 volatile const int use_idx_hash;
 
+/* Control flag set by userspace when lock_held(...) filters are active. */
+int lock_enabled;
+
 void *bpf_cast_to_kern_ctx(void *) __ksym;
 
+static __always_inline bool is_direct_lock_owner(__u64 lock_addr, __u64 curr, __u32 part)
+{
+	if (!curr)
+		return false;
+
+	if ((part & PBF_LOCK_DIRECT_MUTEX) &&
+	    (__u64)get_lock_owner(lock_addr, LCB_F_MUTEX) == curr)
+		return true;
+	return false;
+}
+
+static __always_inline bool is_lock_held(struct perf_bpf_filter_entry *entry)
+{
+	__u64 curr = bpf_get_current_task();
+	__u32 kind = entry->part & PBF_LOCK_KIND_MASK;
+	__u32 mode = entry->part & PBF_LOCK_MODE_MASK;
+
+	if (!mode)
+		mode = PBF_LOCK_MODE_ANY;
+
+	switch (kind) {
+	case PBF_LOCK_ADDR:
+		if ((mode & PBF_LOCK_MODE_WRITE) &&
+		    is_direct_lock_owner(entry->value, curr, entry->part))
+			return true;
+		return false;
+
+	default:
+		return false;
+	}
+}
+
+static __always_inline __u64 check_lock_held(struct perf_bpf_filter_entry *entry)
+{
+	/*
+	 * Pinned filters (use_idx_hash != 0) share a world-writable filters
+	 * map and do not support lock_held(). Reject evaluation when pinned
+	 * or when lock_enabled is not set so unprivileged users cannot probe
+	 * arbitrary kernel addresses via entry->value.
+	 */
+	if (use_idx_hash || !lock_enabled)
+		return entry->op == PBF_OP_EQ ? ~entry->value : entry->value;
+
+	return is_lock_held(entry) ? entry->value : ~entry->value;
+}
+
 /* new kernel perf_sample_data definition */
 struct perf_sample_data___new {
 	__u64 sample_flags;
@@ -175,6 +225,8 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		return bpf_get_current_uid_gid() & 0xFFFFFFFF;
 	case PBF_TERM_GID:
 		return bpf_get_current_uid_gid() >> 32;
+	case PBF_TERM_LOCK_HELD:
+		return check_lock_held(entry);
 	case PBF_TERM_NONE:
 	case __PBF_UNUSED_TERM4:
 	case __PBF_UNUSED_TERM5:
@@ -209,6 +261,8 @@ static __always_inline __u64 perf_get_common_sample(struct perf_bpf_filter_entry
 		return bpf_get_current_uid_gid() & 0xFFFFFFFF;
 	case PBF_TERM_GID:
 		return bpf_get_current_uid_gid() >> 32;
+	case PBF_TERM_LOCK_HELD:
+		return check_lock_held(entry);
 	default:
 		return 0;
 	}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7110c9ca928e..81316fabf496 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2672,6 +2672,8 @@ static int is_possible_tp_filter(struct evsel *evsel, const char *str)
 	 */
 	static const char *const bpf_tp_terms[] = {
 		"uid", "gid", "tid", "pid", "time", "cgroup",
+		"lock_held", "lock_held_read", "lock_held_shared",
+		"lock_held_write", "lock_held_exclusive",
 	};
 	const char *bpf_term = NULL, *tp_field = NULL;
 
-- 
2.56.0.307.g5fe7bd680c-goog

