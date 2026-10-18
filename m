Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D963E49C0
	for <rcu@vger.kernel.org>; Sun, 18 Oct 2026 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792301845; cv=none; b=fD1LIPeRbXy4KsqRA9h2Ley8YIjP7w8cJB4kEujxeSWYSGXaPh9y7f/aHiq5/LYWg+PPLfeuWdbcGwuiSdUZ3juS7EvZDy8Ot1xYJa+3CYuBbHWcDa/X7Kksq1yHFJ58sXMOncvli4Pvo2x2hsXtDbeIAN11mpZx+W7m0EIe32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792301845; c=relaxed/simple;
	bh=cHbxA+tuAmYO1hlH7szhbp//u0LmUOIrxBrlJPaDafo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g/PfGSoXn0iZWWhiNgXv8NDiAo2W9nMsSvfFhhy/Yc2d/3LxKhJ1ro8B3PWR7G+UrxgFaS+fankZ4oFVFu31C8Bpkbhd9gRTrZnhspJh8GKl/xAFuKHXqhpvixaF0w5+vcyxgbVDuMLUFW9pWD35xbFbzNxMY9MZ2p856tjhiug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DwJFGaGW; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwJFGaGW"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35cbea41088so1925889eec.1
        for <rcu@vger.kernel.org>; Sat, 17 Oct 2026 22:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792301838; x=1792906638; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=99ngFpVIJqVKhMxl7xtdYi8CTr6PqGZ+gpTqH45vUyM=;
        b=DwJFGaGWhJ+iKFMA1/y4D44y033AXLlIJFO1vTr04Pgd5he8hvkc6jYSjKNeDh7//B
         gmRbydcPnAPP8p94aT4slN7kgeHPseG0p1JGlHj4hQysUJzW/EWbapOzIHqAZ5axyGjp
         7NIlY0AGs5c+830Bbgo+KZVmqEXx1nuoLZ4NQnE91cB+cyzfij0cqGUR8bryGfHvrtBs
         zF+se70ZcGIp0dyosczQByYGQyvyixmuQRGwnllo4swZ5uqB4b9t4C+WcwbAMIHi5aA8
         h1qqehejtyMxuJGumn9YZE4hipIAEzDJWMnR8vG4zickVjcAEwJS7ebBsHuKToSF0MRV
         WL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792301838; x=1792906638;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=99ngFpVIJqVKhMxl7xtdYi8CTr6PqGZ+gpTqH45vUyM=;
        b=xewxpNbOhBNt8+edAs+iXSHRJSOXqd8i0lUKSnkaMF1Z5tiW5kC37qkcdudnXWMUKI
         vGGT9EnLs/pvbn+5CYcXk2b9IC7RTd/N4bgLQO4hDNBVpakObz946QKXGgwQcMjP7LpY
         KlYsrh46JqmCnxcSnnWWApYxfzmvLtrSKLaY6LkZ7JbjrUzzCkg2t5XDR1eEJw9YWOgU
         3HrTUWRbm3rr3ly83GY8V/sjQiKvyLdXEDDVbIQSu61Kja2oNLalS/szk1vbFrQ7WIyh
         2rmdjPV45uLd/BjJ+owEMyG0en4VrSuXal5JdtUVMozMO4uzDHk5g1SEMnXkKdn/rReJ
         vwBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDd9zlEXTrqzdzcZGsIRPWM9rkTKlJceiFcCXESEtJ0sw0gYwruuUj5NLvebK5Bm06ZdQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKvfWFvN5HIhTXHu057fGPVXfS9DmGe938x2uwDBc7LcHVDWpP
	Ljlv/xlcymMASVLypJSkC0EB+vTIUn+HoKg3B6cFpOnqtbggfKsVktOYmuRMXnxfywY/2not/Ay
	Hq1TbXyVQaQ==
X-Received: from dldyr6-n2.prod.google.com ([2002:a05:701b:4506:20b0:184:e9aa:8728])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:438d:b0:185:869a:8c64
 with SMTP id a92af1059eb24-185869a8c8emr8455160c88.1.1792301837875; Sat, 17
 Oct 2026 22:37:17 -0700 (PDT)
Date: Sat, 17 Oct 2026 22:37:06 -0700
In-Reply-To: <20261018053710.2572636-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261017171437.2066343-1-irogers@google.com> <20261018053710.2572636-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261018053710.2572636-3-irogers@google.com>
Subject: [PATCH v3 2/6] perf bpf-filter: Add lock_held() sample filter
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add BPF sample filter predicates lock_held(<lock>),
lock_held_read(<lock>) / lock_held_shared(<lock>), and
lock_held_write(<lock>) / lock_held_exclusive(<lock>) (as well as ':R'
and ':W' suffixes on <lock>) to allow recording perf event samples only
when a specified kernel lock is held (or not held with '!').

Supported <lock> specifications match perf lock contention:
- Global/static kernel lock symbols (with or without '&', e.g.
  lock_held(&cgroup_mutex) or lock_held(cgroup_mutex))
- Hexadecimal kernel lock addresses
- Slab cache names prefixed with '&' (e.g. lock_held(&dentry),
  lock_held_read(&dentry))
- Per-process and semi-global locks: mmap_lock, siglock, rq_lock,
  zone_lock
- Lock types and flags: mutex, spinlock, rwsem, rwsem:R, rwsem:W,
  rwlock, rwlock:R, rwlock:W, rt-mutex, percpu-rwsem, pcpu-sem:W,
  semaphore

Supported lock hold modes by lock family:
- Both read/shared and write/exclusive: rwsem (including mmap_lock)
  and rwlock.
- Write/exclusive only: mutex, spinlock (including siglock, rq_lock,
  zone_lock), rt-mutex, semaphore, and percpu-rwsem (percpu_down_write()
  / percpu_up_write(); fast-path percpu_down_read() / percpu_up_read()
  are inlined per-CPU counter operations without function entry points).

When evaluating the filter on sample overflow, perf_sample_filter first
inspects the lock's owner field directly in kernel memory where
possible (for mutexes, rt-mutexes, and write-locked rwsems), and falls
back to a held_locks BPF hash map (tracking separate read_count and
write_count) populated by fentry/fexit hooks on kernel lock/unlock
functions. To minimize tracing overhead, only the BPF hooks for the
requested lock family and mode are autoloaded and attached.

Example usage:

  # perf record -a -g -e cycles --filter 'lock_held(&mmap_lock)' \
      -- perf bench mem mmap -t 2 -l 100
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.342 MB perf.data (318 samples) ]

  # perf report --stdio --no-children
  # Overhead  Command   Shared Object      Symbol
  # ........  ........  .................  ........................
  #
      18.24%  mem-mmap  [kernel.kallsyms]  [k] clear_page_erms
              |
              ---clear_page_erms
                 get_page_from_freelist
                 __alloc_pages_noprof
                 folio_alloc_mpol_noprof
                 vma_alloc_folio_noprof
                 do_anonymous_page
                 __handle_mm_fault
                 handle_mm_fault
                 do_user_addr_fault
                 exc_page_fault
                 asm_exc_page_fault
                 worker_thread

Read/shared vs write/exclusive holding can also be filtered separately:

  # perf record -a -g -e cycles --filter 'lock_held_read(&mmap_lock)' ...
  # perf record -a -g -e cycles --filter 'lock_held_write(&mmap_lock)' ...
  # perf record -a -g -e cycles --filter 'lock_held(&mmap_lock:W)' ...

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt     |   54 +-
 tools/perf/util/bpf-filter.c                 | 1114 +++++++++++++++++-
 tools/perf/util/bpf-filter.h                 |   13 +
 tools/perf/util/bpf-filter.l                 |   31 +-
 tools/perf/util/bpf-filter.y                 |   46 +-
 tools/perf/util/bpf_skel/sample-filter.h     |   65 +
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 1094 +++++++++++++++++
 tools/perf/util/parse-events.c               |    3 +-
 8 files changed, 2380 insertions(+), 40 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 2351f7b4f5fc..39dfe63fe3a8 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -204,7 +204,59 @@ OPTIONS
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
+	by the kernel thread or CPU.  To differentiate between shared/read
+	holding and exclusive/write holding, use 'lock_held_read(<lock>)'
+	(alias 'lock_held_shared(<lock>)') or 'lock_held_write(<lock>)'
+	(alias 'lock_held_exclusive(<lock>)'), or append ':R' or ':W' to
+	<lock> (e.g. 'lock_held(&mmap_lock:R)' or 'lock_held(&mmap_lock:W)').
+	<lock> can be a kernel lock symbol name (with or without a leading
+	'&', e.g. 'lock_held(&cgroup_mutex)' or 'lock_held(cgroup_mutex)'),
+	a hexadecimal lock address, a slab cache name prefixed with '&'
+	(e.g. 'lock_held(&dentry)', 'lock_held_read(&dentry)'), a well-known
+	lock name ('mmap_lock', 'siglock', 'rq_lock', 'zone_lock'), or a lock
+	type ('mutex', 'spinlock', 'rwsem', 'rwsem:R', 'rwsem:W', 'rwlock',
+	'rwlock:R', 'rwlock:W', 'rt-mutex', 'percpu-rwsem', 'pcpu-sem:W',
+	'semaphore').  Both read/shared and write/exclusive tracking are
+	supported for 'rwsem' (including 'mmap_lock') and 'rwlock';
+	'mutex', 'spinlock' (including 'siglock', 'rq_lock', 'zone_lock'),
+	'rt-mutex', 'semaphore', and 'percpu-rwsem' ('percpu_down_write()')
+	support write/exclusive tracking only.
+
+	For example, 'lock_held()' can be combined with memory allocation or
+	reclaim events to detect allocations or direct memory reclaim occurring
+	while a kernel lock is held (which can stall lock waiters for extended
+	periods):
+
+	  # perf record -a -g -e vmscan:mm_vmscan_direct_reclaim_begin \
+	      --filter 'lock_held(mutex) || lock_held(rwsem)'
+	  # perf record -a -g -e kmem:mm_page_alloc \
+	      --filter 'gfp_flags & 0x400' \
+	      --filter 'lock_held(mutex) || lock_held(rwsem)'
+	  # perf record -a -g -e major-faults \
+	      --filter 'lock_held(mutex) || lock_held(rwsem)'
+
+	Note that 'lock_held(<lock>)' introduces overhead outside of sample
+	overflow handling: in addition to checking the lock's owner field on
+	each sample where possible (such as for mutexes, rt-mutexes, and
+	write-locked rwsems), it attaches BPF fentry/fexit programs to kernel
+	lock acquire and release functions to track held locks (such as
+	spinlocks, rwlocks, reader-locked rwsems, and slab/type filters) in a
+	BPF map.  These BPF hooks run on every kernel lock acquisition and
+	release for the attached lock family, even when no perf sample is
+	being taken.  To minimize this overhead, only the hooks for the
+	relevant lock family and mode are attached when known (for example,
+	'lock_held_read(&mmap_lock)' only hooks rwsem read functions,
+	'lock_held_write(&mmap_lock)' only hooks rwsem write functions,
+	'&cgroup_mutex' only hooks mutex functions, and 'rq_lock' only hooks
+	spinlock functions), whereas slab filters ('&<slab>'), raw hex
+	addresses, or symbols without a recognizable lock-type suffix attach
+	hooks across all lock families (including high-frequency spinlocks).
 
 	The <operator> can be one of:
 	  ==, !=, >, >=, <, <=, &
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 72e83ac1d6a4..0c133b31b5d5 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -40,21 +40,35 @@
  * The 'dropped' map is to keep how many samples it dropped by the filter and
  * it will be reported as lost samples.
  */
+#include <errno.h>
+#include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <string.h>
 #include <fcntl.h>
+#include <unistd.h>
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
+#include "util/lock-contention.h"
+#include "util/string2.h"
+#include "util/symbol_conf.h"
 #include "util/target.h"
 #include "util/thread_map.h"
 #include "util/bpf-utils.h"
@@ -63,6 +77,7 @@
 #include <util/bpf-filter-flex.h>
 #include <util/bpf-filter-bison.h>
 
+#include "bpf_skel/lock_data.h"
 #include "bpf_skel/sample-filter.h"
 #include "bpf_skel/sample_filter.skel.h"
 
@@ -123,15 +138,27 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 {
 	const struct perf_sample_info *info;
 
-	if (expr->term >= PBF_TERM_SAMPLE_START && expr->term <= PBF_TERM_SAMPLE_END &&
-	    (evsel->core.attr.sample_type & (1 << (expr->term - PBF_TERM_SAMPLE_START))))
-		return 0;
-
-	if (expr->term == PBF_TERM_UID || expr->term == PBF_TERM_GID) {
+	if (expr->term == PBF_TERM_UID || expr->term == PBF_TERM_GID ||
+	    expr->term == PBF_TERM_LOCK_HELD) {
 		/* Not dependent on the sample_type as computed from a BPF helper. */
 		return 0;
 	}
 
+	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
+		if (expr->term == PBF_TERM_TID || expr->term == PBF_TERM_CPU ||
+		    expr->term == PBF_TERM_TIME || expr->term == PBF_TERM_CGROUP)
+			return 0;
+		if (expr->op != PBF_OP_GROUP_BEGIN) {
+			pr_err("Error: %s tracepoint event does not support BPF sample term %d\n",
+			       evsel__name(evsel), expr->term);
+			return -1;
+		}
+	}
+
+	if (expr->term >= PBF_TERM_SAMPLE_START && expr->term <= PBF_TERM_SAMPLE_END &&
+	    (evsel->core.attr.sample_type & (1 << (expr->term - PBF_TERM_SAMPLE_START))))
+		return 0;
+
 	if (expr->op == PBF_OP_GROUP_BEGIN) {
 		struct perf_bpf_filter_expr *group;
 
@@ -155,9 +182,831 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 	return -1;
 }
 
-static int get_filter_entries(struct evsel *evsel, struct perf_bpf_filter_entry *entry)
+/*
+ * Program groups for `lock_held(...)` BPF tracing hooks.
+ *
+ * When a `lock_held(...)` filter is specified, only the BPF tracing program
+ * groups required for the requested lock(s) are autoloaded and attached.
+ * If no `lock_held(...)` filter is present, none of these programs are loaded.
+ */
+enum lock_prog_group {
+	LOCK_PROG_MUTEX         = 1U << 0,
+	LOCK_PROG_RWSEM_READ    = 1U << 1,
+	LOCK_PROG_RWSEM_WRITE   = 1U << 2,
+	LOCK_PROG_RWSEM         = LOCK_PROG_RWSEM_READ | LOCK_PROG_RWSEM_WRITE,
+	LOCK_PROG_SPIN          = 1U << 3,
+	LOCK_PROG_RWLOCK_READ   = 1U << 4,
+	LOCK_PROG_RWLOCK_WRITE  = 1U << 5,
+	LOCK_PROG_RWLOCK        = LOCK_PROG_RWLOCK_READ | LOCK_PROG_RWLOCK_WRITE,
+	LOCK_PROG_RTMUTEX       = 1U << 6,
+	LOCK_PROG_SEM           = 1U << 7,
+	LOCK_PROG_PERCPU_RWSEM  = 1U << 8,
+	LOCK_PROG_ALL           = 0x1ffU,
+};
+
+static unsigned int lock_flags_to_prog_group(unsigned int flags)
+{
+	if (flags & LCB_F_MUTEX)
+		return LOCK_PROG_MUTEX;
+	if (flags & LCB_F_RT)
+		return LOCK_PROG_RTMUTEX;
+	if (flags & LCB_F_PERCPU)
+		return LOCK_PROG_PERCPU_RWSEM;
+	if (flags == LCB_F_SPIN)
+		return LOCK_PROG_SPIN;
+	if (flags & LCB_F_SPIN)
+		return (flags & LCB_F_READ) ? LOCK_PROG_RWLOCK_READ : LOCK_PROG_RWLOCK_WRITE;
+	if (flags & LCB_F_READ)
+		return LOCK_PROG_RWSEM_READ;
+	if (flags & LCB_F_WRITE)
+		return LOCK_PROG_RWSEM_WRITE;
+	return LOCK_PROG_SEM;
+}
+
+struct lock_prog_desc {
+	size_t prog_offset;
+	const char *btf_func;
+	unsigned int group;
+};
+
+#define LOCK_FPROG(field, func, grp) \
+	{ offsetof(struct sample_filter_bpf, progs.field), func, grp }
+
+static const struct lock_prog_desc lock_progs[] = {
+	/* Mutex */
+	LOCK_FPROG(fexit_mutex_lock, "mutex_lock", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit_mutex_lock_nested, "mutex_lock_nested", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit__mutex_lock_nest_lock, "_mutex_lock_nest_lock", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit_mutex_lock_io, "mutex_lock_io", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit_mutex_lock_io_nested, "mutex_lock_io_nested", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit_mutex_lock_interruptible, "mutex_lock_interruptible", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit_mutex_lock_interruptible_nested, "mutex_lock_interruptible_nested",
+		   LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit_mutex_lock_killable, "mutex_lock_killable", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit__mutex_lock_killable, "_mutex_lock_killable", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit_mutex_trylock, "mutex_trylock", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit__mutex_trylock_nest_lock, "_mutex_trylock_nest_lock", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fentry_mutex_unlock, "mutex_unlock", LOCK_PROG_MUTEX),
+	/* RW semaphore */
+	LOCK_FPROG(fexit_down_read, "down_read", LOCK_PROG_RWSEM_READ),
+	LOCK_FPROG(fexit_down_read_nested, "down_read_nested", LOCK_PROG_RWSEM_READ),
+	LOCK_FPROG(fexit_down_read_interruptible, "down_read_interruptible", LOCK_PROG_RWSEM_READ),
+	LOCK_FPROG(fexit_down_read_killable, "down_read_killable", LOCK_PROG_RWSEM_READ),
+	LOCK_FPROG(fexit_down_read_killable_nested, "down_read_killable_nested",
+		   LOCK_PROG_RWSEM_READ),
+	LOCK_FPROG(fexit_down_read_trylock, "down_read_trylock", LOCK_PROG_RWSEM_READ),
+	LOCK_FPROG(fexit_down_write, "down_write", LOCK_PROG_RWSEM_WRITE),
+	LOCK_FPROG(fexit_down_write_nested, "down_write_nested", LOCK_PROG_RWSEM_WRITE),
+	LOCK_FPROG(fexit__down_write_nest_lock, "_down_write_nest_lock", LOCK_PROG_RWSEM_WRITE),
+	LOCK_FPROG(fexit_down_write_killable, "down_write_killable", LOCK_PROG_RWSEM_WRITE),
+	LOCK_FPROG(fexit_down_write_killable_nested, "down_write_killable_nested",
+		   LOCK_PROG_RWSEM_WRITE),
+	LOCK_FPROG(fexit_down_write_trylock, "down_write_trylock", LOCK_PROG_RWSEM_WRITE),
+	LOCK_FPROG(fexit_downgrade_write, "downgrade_write", LOCK_PROG_RWSEM),
+	LOCK_FPROG(fentry_up_read, "up_read", LOCK_PROG_RWSEM_READ),
+	LOCK_FPROG(fentry_up_write, "up_write", LOCK_PROG_RWSEM_WRITE),
+	/* Spinlock */
+	LOCK_FPROG(fexit_raw_spin_lock, "_raw_spin_lock", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_lock_nested, "_raw_spin_lock_nested", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_lock_nest_lock, "_raw_spin_lock_nest_lock", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_lock_irq, "_raw_spin_lock_irq", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_lock_irq_disable, "_raw_spin_lock_irq_disable", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_lock_irqsave, "_raw_spin_lock_irqsave", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_lock_irqsave_nested, "_raw_spin_lock_irqsave_nested",
+		   LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_lock_bh, "_raw_spin_lock_bh", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_trylock, "_raw_spin_trylock", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_trylock_bh, "_raw_spin_trylock_bh", LOCK_PROG_SPIN),
+	LOCK_FPROG(fentry_raw_spin_unlock, "_raw_spin_unlock", LOCK_PROG_SPIN),
+	LOCK_FPROG(fentry_raw_spin_unlock_irq, "_raw_spin_unlock_irq", LOCK_PROG_SPIN),
+	LOCK_FPROG(fentry_raw_spin_unlock_irq_enable, "_raw_spin_unlock_irq_enable",
+		   LOCK_PROG_SPIN),
+	LOCK_FPROG(fentry_raw_spin_unlock_irqrestore, "_raw_spin_unlock_irqrestore",
+		   LOCK_PROG_SPIN),
+	LOCK_FPROG(fentry_raw_spin_unlock_bh, "_raw_spin_unlock_bh", LOCK_PROG_SPIN),
+	/* RWlock */
+	LOCK_FPROG(fexit_raw_read_lock, "_raw_read_lock", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fexit_raw_read_lock_irq, "_raw_read_lock_irq", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fexit_raw_read_lock_irqsave, "_raw_read_lock_irqsave", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fexit_raw_read_lock_bh, "_raw_read_lock_bh", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fexit_raw_read_trylock, "_raw_read_trylock", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fentry_raw_read_unlock, "_raw_read_unlock", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fentry_raw_read_unlock_irq, "_raw_read_unlock_irq", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fentry_raw_read_unlock_irqrestore, "_raw_read_unlock_irqrestore",
+		   LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fentry_raw_read_unlock_bh, "_raw_read_unlock_bh", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fexit_raw_write_lock, "_raw_write_lock", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fexit_raw_write_lock_nested, "_raw_write_lock_nested", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fexit_raw_write_lock_irq, "_raw_write_lock_irq", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fexit_raw_write_lock_irqsave, "_raw_write_lock_irqsave", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fexit_raw_write_lock_bh, "_raw_write_lock_bh", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fexit_raw_write_trylock, "_raw_write_trylock", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fentry_raw_write_unlock, "_raw_write_unlock", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fentry_raw_write_unlock_irq, "_raw_write_unlock_irq", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fentry_raw_write_unlock_irqrestore, "_raw_write_unlock_irqrestore",
+		   LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fentry_raw_write_unlock_bh, "_raw_write_unlock_bh", LOCK_PROG_RWLOCK_WRITE),
+	/* RT-Mutex */
+	LOCK_FPROG(fexit_rt_mutex_lock, "rt_mutex_lock", LOCK_PROG_RTMUTEX),
+	LOCK_FPROG(fexit_rt_mutex_lock_nested, "rt_mutex_lock_nested", LOCK_PROG_RTMUTEX),
+	LOCK_FPROG(fexit__rt_mutex_lock_nest_lock, "_rt_mutex_lock_nest_lock", LOCK_PROG_RTMUTEX),
+	LOCK_FPROG(fexit_rt_mutex_lock_interruptible, "rt_mutex_lock_interruptible",
+		   LOCK_PROG_RTMUTEX),
+	LOCK_FPROG(fexit_rt_mutex_lock_killable, "rt_mutex_lock_killable", LOCK_PROG_RTMUTEX),
+	LOCK_FPROG(fexit_rt_mutex_trylock, "rt_mutex_trylock", LOCK_PROG_RTMUTEX),
+	LOCK_FPROG(fentry_rt_mutex_unlock, "rt_mutex_unlock", LOCK_PROG_RTMUTEX),
+	/* Semaphore */
+	LOCK_FPROG(fexit_down, "down", LOCK_PROG_SEM),
+	LOCK_FPROG(fexit_down_interruptible, "down_interruptible", LOCK_PROG_SEM),
+	LOCK_FPROG(fexit_down_killable, "down_killable", LOCK_PROG_SEM),
+	LOCK_FPROG(fexit_down_timeout, "down_timeout", LOCK_PROG_SEM),
+	LOCK_FPROG(fexit_down_trylock, "down_trylock", LOCK_PROG_SEM),
+	LOCK_FPROG(fentry_up, "up", LOCK_PROG_SEM),
+	/* Percpu-RWsem */
+	LOCK_FPROG(fexit_percpu_down_write, "percpu_down_write", LOCK_PROG_PERCPU_RWSEM),
+	LOCK_FPROG(fentry_percpu_up_write, "percpu_up_write", LOCK_PROG_PERCPU_RWSEM),
+};
+
+#undef LOCK_FPROG
+
+static int split_lock_name_mode(const char *name, int expr_part,
+				char *base_buf, size_t buf_sz,
+				bool *has_amp, unsigned int *mode_out)
+{
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
+/*
+ * Parse a lock type name or flags name (e.g. "mutex", "rwsem", "rwsem:R",
+ * "spinlock", "percpu-rwsem").
+ *
+ * A lock type name may correspond to up to two flag combinations (e.g.
+ * "rwsem" matches both `LCB_F_READ` and `LCB_F_WRITE`). These are packed
+ * into `*encoded_pair` as `flag1 | (flag2 << 8)` (with 0xff if `flag2` is
+ * unused) for O(1) lookup in BPF, and accumulated as a bitmask in `*type_mask`.
+ */
+static bool parse_lock_type_name(const char *name, unsigned int mode,
+				 struct sample_filter_bpf *skel,
+				 u64 *encoded_pair, unsigned int *prog_groups)
+{
+	bool found = false;
+	u32 flag1 = 0xff, flag2 = 0xff;
+	unsigned int groups = 0;
+	const char *lookup = !strcmp(name, "pcpu-sem") ? "percpu-rwsem" : name;
+
+	for (size_t i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+		u32 f = lock_type_table[i].flags;
+		bool is_read = (f & LCB_F_READ) != 0;
+
+		if (strcmp(lock_type_table[i].lock_name, lookup) &&
+		    strcmp(lock_type_table[i].flags_name, name))
+			continue;
+
+		/*
+		 * percpu_down_read() / percpu_up_read() fast paths are inlined
+		 * per-CPU counter increments without function entry points, so
+		 * only writer holding (percpu_down_write / percpu_up_write) can
+		 * be tracked for percpu-rwsem. rwlock-rt is also not hooked.
+		 */
+		if ((f & LCB_F_PERCPU) && is_read)
+			continue;
+		if ((f & LCB_F_RT) && (f & (LCB_F_READ | LCB_F_WRITE)))
+			continue;
+
+		if (is_read && !(mode & PBF_LOCK_MODE_READ))
+			continue;
+		if (!is_read && !(mode & PBF_LOCK_MODE_WRITE))
+			continue;
+
+		if (!found)
+			flag1 = f;
+		else if (f != flag1)
+			flag2 = f;
+		if (skel && f < LCB_F_TYPE_MAX) {
+			skel->bss->has_lock_type = 1;
+			skel->bss->lock_type_filter[f] = 1;
+		}
+		groups |= lock_flags_to_prog_group(f);
+		found = true;
+	}
+
+	if (!found)
+		return false;
+
+	if (encoded_pair)
+		*encoded_pair = flag1 | ((u64)flag2 << 8);
+	if (prog_groups)
+		*prog_groups |= groups;
+	return true;
+}
+
+struct lock_sym_cb_args {
+	const char *name;
+	u64 addr;
+	bool found;
+};
+
+static int find_lock_sym_cb(void *arg, const char *name,
+			    char type __maybe_unused, u64 start)
+{
+	struct lock_sym_cb_args *args = arg;
+
+	if (!strcmp(name, args->name)) {
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
+static bool parse_lock_hex_addr(const char *str, u64 *addr)
+{
+	char *end;
+	unsigned long long val;
+
+	if (!str || !*str)
+		return false;
+
+	errno = 0;
+	val = strtoull(str, &end, 16);
+	if (*end != '\0' || errno != 0 || val == 0)
+		return false;
+
+	*addr = val;
+	return true;
+}
+
+static void init_numa_data(struct sample_filter_bpf *skel, struct btf *btf)
+{
+	u64 addr = 0;
+	char *buf = NULL, *p;
+	size_t len;
+	long last = -1;
+	int ret;
+
+	if (!btf)
+		return;
+
+	ret = btf__find_by_name_kind(btf, "zone", BTF_KIND_STRUCT);
+	if (ret < 0)
+		return;
+
+	ret = btf__resolve_size(btf, ret);
+	if (ret < 0)
+		return;
+
+	skel->rodata->sizeof_zone = ret;
+
+	if (find_kernel_lock_sym("contig_page_data", &addr) == 0) {
+		skel->rodata->contig_page_data_addr = addr;
+		return;
+	}
+
+	if (find_kernel_lock_sym("node_data", &addr) != 0)
+		return;
+
+	skel->rodata->node_data_addr = addr;
+
+	if (sysfs__read_str("devices/system/node/online", &buf, &len) >= 0) {
+		p = buf;
+		while (p && *p) {
+			char *end;
+
+			last = strtol(p, &end, 0);
+			if (end == p)
+				break;
+			p = end;
+			if (*p == ',' || *p == '-' || *p == '\n')
+				p++;
+		}
+		skel->rodata->nr_nodes = last + 1;
+		free(buf);
+	}
+}
+
+static bool btf_has_func(struct btf *btf, const char *name)
+{
+	return btf && name && btf__find_by_name_kind(btf, name, BTF_KIND_FUNC) > 0;
+}
+
+static unsigned int supported_lock_prog_groups(struct btf *btf)
+{
+	unsigned int supported = 0;
+
+	if (!btf)
+		return 0;
+
+	if ((btf_has_func(btf, "mutex_lock") || btf_has_func(btf, "mutex_lock_nested")) &&
+	    btf_has_func(btf, "mutex_unlock"))
+		supported |= LOCK_PROG_MUTEX;
+
+	if ((btf_has_func(btf, "down_read") || btf_has_func(btf, "down_read_nested")) &&
+	    btf_has_func(btf, "up_read"))
+		supported |= LOCK_PROG_RWSEM_READ;
+
+	if ((btf_has_func(btf, "down_write") || btf_has_func(btf, "down_write_nested")) &&
+	    btf_has_func(btf, "up_write"))
+		supported |= LOCK_PROG_RWSEM_WRITE;
+
+	/*
+	 * Require both acquire and all unlock entry points in BTF so we never
+	 * attach spinlock/rwlock acquire hooks when unlock functions are
+	 * inlined (e.g. !CONFIG_UNINLINE_SPIN_UNLOCK or CONFIG_INLINE_*_UNLOCK).
+	 */
+	if ((btf_has_func(btf, "_raw_spin_lock") || btf_has_func(btf, "_raw_spin_lock_nested")) &&
+	    btf_has_func(btf, "_raw_spin_unlock") &&
+	    btf_has_func(btf, "_raw_spin_unlock_irq") &&
+	    btf_has_func(btf, "_raw_spin_unlock_irqrestore") &&
+	    btf_has_func(btf, "_raw_spin_unlock_bh"))
+		supported |= LOCK_PROG_SPIN;
+
+	if (btf_has_func(btf, "_raw_read_lock") &&
+	    btf_has_func(btf, "_raw_read_unlock") &&
+	    btf_has_func(btf, "_raw_read_unlock_irq") &&
+	    btf_has_func(btf, "_raw_read_unlock_irqrestore") &&
+	    btf_has_func(btf, "_raw_read_unlock_bh"))
+		supported |= LOCK_PROG_RWLOCK_READ;
+
+	if ((btf_has_func(btf, "_raw_write_lock") || btf_has_func(btf, "_raw_write_lock_nested")) &&
+	    btf_has_func(btf, "_raw_write_unlock") &&
+	    btf_has_func(btf, "_raw_write_unlock_irq") &&
+	    btf_has_func(btf, "_raw_write_unlock_irqrestore") &&
+	    btf_has_func(btf, "_raw_write_unlock_bh"))
+		supported |= LOCK_PROG_RWLOCK_WRITE;
+
+	if ((btf_has_func(btf, "rt_mutex_lock") || btf_has_func(btf, "rt_mutex_lock_nested")) &&
+	    btf_has_func(btf, "rt_mutex_unlock"))
+		supported |= LOCK_PROG_RTMUTEX;
+
+	if (btf_has_func(btf, "down") && btf_has_func(btf, "up"))
+		supported |= LOCK_PROG_SEM;
+
+	if (btf_has_func(btf, "percpu_down_write") && btf_has_func(btf, "percpu_up_write"))
+		supported |= LOCK_PROG_PERCPU_RWSEM;
+
+	return supported;
+}
+
+/*
+ * Enable or disable autoload for each lock-tracking BPF program in the
+ * skeleton before `sample_filter_bpf__load()` is called.
+ *
+ * Each program is enabled only if its group is in `needed_groups` and its
+ * target kernel function or tracepoint exists in the running kernel's BTF.
+ */
+static int configure_lock_progs(struct sample_filter_bpf *skel, struct btf *btf,
+				unsigned int needed_groups,
+				unsigned int required_groups,
+				bool needs_lock_syms, bool needs_slab_iter,
+				bool is_tracepoint)
+{
+	unsigned int supported_groups = supported_lock_prog_groups(btf);
+	unsigned int enabled_progs = 0;
+
+	bpf_program__set_autoload(skel->progs.perf_sample_filter, !is_tracepoint);
+	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, is_tracepoint);
+
+	if ((required_groups & supported_groups) != required_groups) {
+		pr_err("Error: Kernel BTF lacks required lock/unlock tracing entry points\n");
+		return -ENOTSUP;
+	}
+
+	needed_groups &= supported_groups;
+	if (skel)
+		skel->bss->track_rwsem_read = !!(needed_groups & LOCK_PROG_RWSEM_READ);
+
+	for (size_t i = 0; i < ARRAY_SIZE(lock_progs); i++) {
+		struct bpf_program **progp = (void *)skel + lock_progs[i].prog_offset;
+		struct bpf_program *prog = *progp;
+		bool enable = false;
+
+		if ((needed_groups & lock_progs[i].group) && btf &&
+		    lock_progs[i].btf_func) {
+			if (btf__find_by_name_kind(btf, lock_progs[i].btf_func,
+						   BTF_KIND_FUNC) > 0)
+				enable = true;
+		}
+
+		if (enable)
+			enabled_progs++;
+		bpf_program__set_autoload(prog, enable);
+	}
+
+	bpf_program__set_autoload(skel->progs.collect_lock_syms, needs_lock_syms);
+	if (needs_slab_iter && btf &&
+	    btf__find_by_name_kind(btf, "bpf_iter__kmem_cache", BTF_KIND_STRUCT) > 0) {
+		bpf_program__set_autoload(skel->progs.slab_cache_iter, true);
+	} else {
+		bpf_program__set_autoload(skel->progs.slab_cache_iter, false);
+	}
+
+	if (needed_groups && !enabled_progs) {
+		pr_err("Error: Kernel BTF lacks required lock tracing entry points\n");
+		return -ENOTSUP;
+	}
+	return 0;
+}
+
+/*
+ * Pre-scan a single filter expression prior to loading the BPF skeleton in
+ * order to determine which BPF maps need to be sized and which lock tracing
+ * program groups need to be autoloaded.
+ */
+static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
+				  bool *has_lock_filter,
+				  unsigned int *prog_groups,
+				  unsigned int *required_groups,
+				  bool *needs_lock_syms,
+				  bool *needs_slab_iter)
+{
+	char base[128];
+	bool has_amp;
+	unsigned int mode, groups = 0;
+	u64 dummy;
+
+	if (expr->term != PBF_TERM_LOCK_HELD || !expr->lock_name)
+		return;
+
+	*has_lock_filter = true;
+	if (split_lock_name_mode(expr->lock_name, expr->part, base,
+				 sizeof(base), &has_amp, &mode) < 0)
+		return;
+
+	if (!strcmp(base, "mmap_lock") || !strcmp(base, "mmap_sem")) {
+		if (mode & PBF_LOCK_MODE_READ)
+			groups |= LOCK_PROG_RWSEM_READ;
+		if (mode & PBF_LOCK_MODE_WRITE)
+			groups |= LOCK_PROG_RWSEM_WRITE;
+		*prog_groups |= groups;
+		*required_groups |= groups;
+		return;
+	}
+	if (!strcmp(base, "siglock")) {
+		*prog_groups |= LOCK_PROG_SPIN;
+		*required_groups |= LOCK_PROG_SPIN;
+		return;
+	}
+	if (!strcmp(base, "rq_lock") || !strcmp(base, "zone_lock")) {
+		*prog_groups |= LOCK_PROG_SPIN;
+		*required_groups |= LOCK_PROG_SPIN;
+		*needs_lock_syms = true;
+		return;
+	}
+	if (!has_amp && parse_lock_type_name(base, mode, NULL, NULL, &groups)) {
+		*prog_groups |= groups;
+		*required_groups |= groups;
+		return;
+	}
+
+	if (!has_amp && parse_lock_hex_addr(base, &dummy)) {
+		*prog_groups |= LOCK_PROG_ALL;
+		return;
+	}
+
+	if (has_amp)
+		*needs_slab_iter = true;
+
+	if (strtailcmp(base, "rt_mutex") == 0 || strtailcmp(base, "rtmutex") == 0) {
+		*prog_groups |= LOCK_PROG_RTMUTEX;
+		*required_groups |= LOCK_PROG_RTMUTEX;
+	} else if (strtailcmp(base, "mutex") == 0) {
+		*prog_groups |= LOCK_PROG_MUTEX;
+		*required_groups |= LOCK_PROG_MUTEX;
+	} else if (strtailcmp(base, "percpu_rwsem") == 0 ||
+		   strtailcmp(base, "pcpu_rwsem") == 0) {
+		*prog_groups |= LOCK_PROG_PERCPU_RWSEM;
+		*required_groups |= LOCK_PROG_PERCPU_RWSEM;
+	} else if (strtailcmp(base, "rwsem") == 0) {
+		if (mode & PBF_LOCK_MODE_READ) {
+			*prog_groups |= LOCK_PROG_RWSEM_READ;
+			*required_groups |= LOCK_PROG_RWSEM_READ;
+		}
+		if (mode & PBF_LOCK_MODE_WRITE) {
+			*prog_groups |= LOCK_PROG_RWSEM_WRITE | LOCK_PROG_PERCPU_RWSEM;
+			*required_groups |= LOCK_PROG_RWSEM_WRITE;
+		}
+	} else if (strtailcmp(base, "spinlock") == 0) {
+		*prog_groups |= LOCK_PROG_SPIN;
+		*required_groups |= LOCK_PROG_SPIN;
+	} else if (strtailcmp(base, "rwlock") == 0) {
+		if (mode & PBF_LOCK_MODE_READ)
+			groups |= LOCK_PROG_RWLOCK_READ;
+		if (mode & PBF_LOCK_MODE_WRITE)
+			groups |= LOCK_PROG_RWLOCK_WRITE;
+		*prog_groups |= groups;
+		*required_groups |= groups;
+	} else {
+		*prog_groups |= LOCK_PROG_ALL;
+	}
+
+	if (!has_amp && find_kernel_lock_sym(base, &dummy) != 0)
+		*needs_slab_iter = true;
+}
+
+static void prescan_lock_filters(struct evsel *evsel, bool *has_lock_filter,
+				 unsigned int *prog_groups,
+				 unsigned int *required_groups,
+				 bool *needs_lock_syms,
+				 bool *needs_slab_iter)
+{
+	struct perf_bpf_filter_expr *expr, *group;
+
+	*has_lock_filter = false;
+	*prog_groups = 0;
+	*required_groups = 0;
+	*needs_lock_syms = false;
+	*needs_slab_iter = false;
+
+	list_for_each_entry(expr, &evsel->bpf_filters, list) {
+		prescan_one_lock_expr(expr, has_lock_filter, prog_groups,
+				      required_groups, needs_lock_syms,
+				      needs_slab_iter);
+		if (expr->op == PBF_OP_GROUP_BEGIN) {
+			list_for_each_entry(group, &expr->groups, list) {
+				prescan_one_lock_expr(group, has_lock_filter,
+						      prog_groups, required_groups,
+						      needs_lock_syms, needs_slab_iter);
+			}
+		}
+	}
+}
+
+static void run_slab_cache_iter(struct sample_filter_bpf *skel)
+{
+	struct bpf_link *link;
+	int fd;
+	char buf[256];
+
+	if (!bpf_program__autoload(skel->progs.slab_cache_iter))
+		return;
+
+	link = bpf_program__attach_iter(skel->progs.slab_cache_iter, NULL);
+	if (!link || IS_ERR(link)) {
+		pr_debug("cannot attach slab cache iter\n");
+		return;
+	}
+
+	fd = bpf_iter_create(bpf_link__fd(link));
+	if (fd >= 0) {
+		while (read(fd, buf, sizeof(buf)) > 0)
+			continue;
+		close(fd);
+	}
+
+	bpf_link__destroy(link);
+}
+
+static bool find_slab_cache(struct sample_filter_bpf *skel, const char *name,
+			    u64 *kmem_cache_addr)
+{
+	int cache_fd;
+	u64 key, *prev_key = NULL;
+
+	if (!skel || !bpf_program__autoload(skel->progs.slab_cache_iter))
+		return false;
+
+	cache_fd = bpf_map__fd(skel->maps.slab_caches);
+	while (!bpf_map_get_next_key(cache_fd, prev_key, &key)) {
+		struct slab_cache_data data;
+
+		if (bpf_map_lookup_elem(cache_fd, &key, &data) < 0)
+			break;
+
+		if (!strcmp(data.name, name)) {
+			*kmem_cache_addr = key;
+			return true;
+		}
+		prev_key = &key;
+	}
+	return false;
+}
+
+/*
+ * Resolve a `lock_held(<name>)` filter expression into `entry->part`
+ * (`enum perf_bpf_lock_target_kind`) and `entry->target`, and populate
+ * the corresponding BPF filter maps and BSS control flags.
+ *
+ * Resolution order:
+ * 1. Well-known per-process / semi-global locks: `mmap_lock`, `siglock`,
+ *    `rq_lock`, `zone_lock` (with or without leading '&').
+ * 2. Lock types / flags (when no leading '&'): `mutex`, `spinlock`,
+ *    `rwsem`, `rwsem:R`, `rwsem:W`, `rwlock`, `percpu-rwsem`,
+ *    `semaphore`, etc.
+ * 3. Hexadecimal lock address (when no leading '&').
+ * 4. Slab cache name (when prefixed with '&', e.g. `&dentry`).
+ * 5. Global/static kernel lock symbol in kallsyms (with or without leading '&',
+ *    e.g. `&cgroup_mutex` or `cgroup_mutex`).
+ * 6. Slab cache name without leading '&' fallback.
+ */
+static int resolve_lock_expr(struct sample_filter_bpf *skel,
+			     struct perf_bpf_filter_expr *expr,
+			     struct perf_bpf_filter_entry *entry)
 {
-	int i = 0;
+	const char *name = expr->lock_name;
+	char base[128];
+	bool has_amp;
+	unsigned int mode;
+	u64 addr = 0, encoded_pair = 0;
+	u8 one = 1;
+	int ret;
+
+	if (split_lock_name_mode(name, expr->part, base, sizeof(base),
+				 &has_amp, &mode) < 0) {
+		pr_err("Error: Invalid kernel lock filter '%s'\n", name ?: "");
+		return -EINVAL;
+	}
+
+	if (!strcmp(base, "mmap_lock") || !strcmp(base, "mmap_sem")) {
+		entry->part = PBF_LOCK_MMAP | mode;
+		entry->target = 0;
+		if (skel)
+			skel->bss->has_mmap_lock = 1;
+		return 0;
+	}
+
+	if (!strcmp(base, "siglock")) {
+		if (!(mode & PBF_LOCK_MODE_WRITE)) {
+			pr_err("Error: Lock '%s' is exclusive and does not support read/shared mode\n",
+			       name);
+			return -EINVAL;
+		}
+		entry->part = PBF_LOCK_SIGHAND | mode;
+		entry->target = 0;
+		if (skel)
+			skel->bss->has_siglock = 1;
+		return 0;
+	}
+
+	if (!strcmp(base, "rq_lock")) {
+		if (!(mode & PBF_LOCK_MODE_WRITE)) {
+			pr_err("Error: Lock '%s' is exclusive and does not support read/shared mode\n",
+			       name);
+			return -EINVAL;
+		}
+		entry->part = PBF_LOCK_CLASS | mode;
+		entry->target = LOCK_CLASS_RQLOCK;
+		if (skel)
+			skel->bss->has_lock_class = 1;
+		return 0;
+	}
+
+	if (!strcmp(base, "zone_lock")) {
+		if (!(mode & PBF_LOCK_MODE_WRITE)) {
+			pr_err("Error: Lock '%s' is exclusive and does not support read/shared mode\n",
+			       name);
+			return -EINVAL;
+		}
+		entry->part = PBF_LOCK_CLASS | mode;
+		entry->target = LOCK_CLASS_ZONE_LOCK;
+		if (skel)
+			skel->bss->has_lock_class = 1;
+		return 0;
+	}
+
+	if (!has_amp && parse_lock_type_name(base, mode, skel, &encoded_pair, NULL)) {
+		entry->part = PBF_LOCK_TYPE | mode;
+		entry->target = encoded_pair;
+		return 0;
+	}
+
+	if (!has_amp && parse_lock_type_name(base, PBF_LOCK_MODE_ANY, NULL, NULL, NULL)) {
+		pr_err("Error: Lock type '%s' does not support the requested read/write mode\n",
+		       name);
+		return -EINVAL;
+	}
+
+	if (!has_amp && parse_lock_hex_addr(base, &addr)) {
+		entry->part = PBF_LOCK_ADDR | mode;
+		entry->target = addr;
+		if (skel) {
+			int fd = bpf_map__fd(skel->maps.lock_addr_filter);
+
+			bpf_map_update_elem(fd, &addr, &one, BPF_ANY);
+			skel->bss->has_lock_addr = 1;
+		}
+		return 0;
+	}
+
+	if (has_amp && find_slab_cache(skel, base, &addr)) {
+		int fd = bpf_map__fd(skel->maps.slab_filter);
+
+		entry->part = PBF_LOCK_SLAB | mode;
+		entry->target = addr;
+		bpf_map_update_elem(fd, &addr, &one, BPF_ANY);
+		skel->bss->has_lock_slab = 1;
+		return 0;
+	}
+
+	ret = find_kernel_lock_sym(base, &addr);
+	if (ret == 0) {
+		unsigned int direct_flag = 0;
+
+		if (strtailcmp(base, "rt_mutex") == 0 || strtailcmp(base, "rtmutex") == 0)
+			direct_flag = PBF_LOCK_DIRECT_RTMUTEX;
+		else if (strtailcmp(base, "mutex") == 0)
+			direct_flag = PBF_LOCK_DIRECT_MUTEX;
+		else if (strtailcmp(base, "rwsem") == 0 &&
+			 strtailcmp(base, "percpu_rwsem") != 0 &&
+			 strtailcmp(base, "pcpu_rwsem") != 0)
+			direct_flag = PBF_LOCK_DIRECT_RWSEM;
+
+		entry->part = PBF_LOCK_ADDR | mode | direct_flag;
+		entry->target = addr;
+		if (skel) {
+			int fd = bpf_map__fd(skel->maps.lock_addr_filter);
+
+			bpf_map_update_elem(fd, &addr, &one, BPF_ANY);
+			skel->bss->has_lock_addr = 1;
+		}
+		return 0;
+	}
+	if (ret == -EACCES)
+		return ret;
+
+	if (!has_amp && find_slab_cache(skel, base, &addr)) {
+		int fd = bpf_map__fd(skel->maps.slab_filter);
+
+		entry->part = PBF_LOCK_SLAB | mode;
+		entry->target = addr;
+		bpf_map_update_elem(fd, &addr, &one, BPF_ANY);
+		skel->bss->has_lock_slab = 1;
+		return 0;
+	}
+
+	pr_err("Error: Cannot resolve kernel lock '%s'\n", name);
+	return -EINVAL;
+}
+
+static int get_filter_entries(struct evsel *evsel, struct sample_filter_bpf *skel,
+			      struct perf_bpf_filter_entry *entry)
+{
+	int i = 0, ret;
 	struct perf_bpf_filter_expr *expr;
 
 	list_for_each_entry(expr, &evsel->bpf_filters, list) {
@@ -171,6 +1020,12 @@ static int get_filter_entries(struct evsel *evsel, struct perf_bpf_filter_entry
 		entry[i].part = expr->part;
 		entry[i].term = expr->term;
 		entry[i].value = expr->val;
+		entry[i].target = 0;
+		if (expr->term == PBF_TERM_LOCK_HELD) {
+			ret = resolve_lock_expr(skel, expr, &entry[i]);
+			if (ret < 0)
+				return ret;
+		}
 		i++;
 
 		if (expr->op == PBF_OP_GROUP_BEGIN) {
@@ -184,6 +1039,12 @@ static int get_filter_entries(struct evsel *evsel, struct perf_bpf_filter_entry
 				entry[i].part = group->part;
 				entry[i].term = group->term;
 				entry[i].value = group->val;
+				entry[i].target = 0;
+				if (group->term == PBF_TERM_LOCK_HELD) {
+					ret = resolve_lock_expr(skel, group, &entry[i]);
+					if (ret < 0)
+						return ret;
+				}
 				i++;
 			}
 
@@ -423,10 +1284,14 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 {
 	int i, x, y, fd, ret;
 	struct sample_filter_bpf *skel = NULL;
+	struct btf *btf = NULL;
 	struct bpf_program *prog;
 	struct bpf_link *link;
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
+	bool is_tracepoint = (evsel->core.attr.type == PERF_TYPE_TRACEPOINT);
+	bool has_lock_filter = false, needs_lock_syms = false, needs_slab_iter = false;
+	unsigned int prog_groups = 0, required_groups = 0;
 #if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
 			    .dont_enable = true);
@@ -438,15 +1303,25 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	if (entry == NULL)
 		return -1;
 
-	ret = get_filter_entries(evsel, entry);
-	if (ret < 0) {
-		pr_err("Failed to process filter entries\n");
-		goto err;
-	}
+	prescan_lock_filters(evsel, &has_lock_filter, &prog_groups,
+			     &required_groups, &needs_lock_syms,
+			     &needs_slab_iter);
 
-	if (needs_idx_hash && geteuid() != 0) {
+	if (needs_idx_hash && geteuid() != 0 && !perf_cap__capable(CAP_BPF)) {
 		int zero = 0;
 
+		if (has_lock_filter || is_tracepoint) {
+			pr_err("Error: BPF filter requires CAP_BPF capability\n");
+			ret = -EPERM;
+			goto err;
+		}
+
+		ret = get_filter_entries(evsel, NULL, entry);
+		if (ret < 0) {
+			pr_err("Failed to process filter entries\n");
+			goto err;
+		}
+
 		/* The filters map is shared among other processes */
 		ret = create_idx_hash(evsel, entry);
 		if (ret < 0)
@@ -484,13 +1359,71 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		return 0;
 	}
 
-	skel = sample_filter_bpf__open_and_load();
+	skel = sample_filter_bpf__open();
 	if (!skel) {
+		ret = -errno;
+		pr_err("Failed to open perf sample-filter BPF skeleton\n");
+		goto err;
+	}
+
+	if (has_lock_filter) {
+		btf = btf__load_vmlinux_btf();
+		bpf_map__set_max_entries(skel->maps.held_locks, MAX_ENTRIES);
+		bpf_map__set_max_entries(skel->maps.lock_addr_filter, MAX_FILTERS);
+		if (needs_slab_iter) {
+			bpf_map__set_max_entries(skel->maps.slab_filter, MAX_FILTERS);
+			bpf_map__set_max_entries(skel->maps.slab_caches, MAX_ENTRIES);
+		}
+		if (needs_lock_syms) {
+			bpf_map__set_max_entries(skel->maps.lock_syms, MAX_ENTRIES);
+			init_numa_data(skel, btf);
+		}
+		ret = configure_lock_progs(skel, btf, prog_groups, required_groups,
+					   needs_lock_syms, needs_slab_iter,
+					   is_tracepoint);
+		if (ret < 0)
+			goto err;
+	} else {
+		configure_lock_progs(skel, NULL, 0, 0, false, false, is_tracepoint);
+	}
+
+	if (sample_filter_bpf__load(skel) < 0) {
 		ret = -errno;
 		pr_err("Failed to load perf sample-filter BPF skeleton\n");
 		goto err;
 	}
 
+	if (has_lock_filter && needs_slab_iter)
+		run_slab_cache_iter(skel);
+
+	ret = get_filter_entries(evsel, skel, entry);
+	if (ret < 0) {
+		pr_err("Failed to process filter entries\n");
+		goto err;
+	}
+
+	if (has_lock_filter) {
+		if (needs_lock_syms && skel->bss->has_lock_class) {
+			DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+				.flags = BPF_F_TEST_RUN_ON_CPU,
+			);
+			int prog_fd = bpf_program__fd(skel->progs.collect_lock_syms);
+
+			bpf_prog_test_run_opts(prog_fd, &opts);
+		}
+		bpf_program__set_autoattach(skel->progs.perf_sample_filter, false);
+		bpf_program__set_autoattach(skel->progs.perf_tp_sample_filter, false);
+		bpf_program__set_autoattach(skel->progs.collect_lock_syms, false);
+		bpf_program__set_autoattach(skel->progs.slab_cache_iter, false);
+
+		ret = sample_filter_bpf__attach(skel);
+		if (ret < 0) {
+			pr_err("Failed to attach lock sample-filter BPF programs\n");
+			goto err;
+		}
+		skel->bss->lock_enabled = 1;
+	}
+
 	i = 0;
 	fd = bpf_map__fd(skel->maps.filters);
 
@@ -501,23 +1434,44 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
-	prog = skel->progs.perf_sample_filter;
-	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
-		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
-			link = bpf_program__attach_perf_event_opts(prog, FD(evsel, x, y),
-								   &pe_opts);
-			if (IS_ERR(link)) {
-				pr_err("Failed to attach perf sample-filter program\n");
-				ret = PTR_ERR(link);
-				goto err;
+	if (is_tracepoint) {
+		/*
+		 * For PERF_TYPE_TRACEPOINT, PERF_EVENT_IOC_SET_BPF attaches the
+		 * BPF program to event->tp_event->prog_array on the shared
+		 * trace_event_call, which perf_trace_run_bpf_submit() executes
+		 * for all CPUs and tasks before iterating the per-CPU perf
+		 * events. Attach once on the first FD so tp_event->prog_array
+		 * does not get duplicate copies for each per-CPU FD.
+		 */
+		prog = skel->progs.perf_tp_sample_filter;
+		link = bpf_program__attach_perf_event_opts(prog, FD(evsel, 0, 0),
+							   &pe_opts);
+		ret = libbpf_get_error(link);
+		if (ret) {
+			pr_err("Failed to attach perf tracepoint sample-filter program\n");
+			goto err;
+		}
+	} else {
+		prog = skel->progs.perf_sample_filter;
+		for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
+			for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
+				link = bpf_program__attach_perf_event_opts(prog, FD(evsel, x, y),
+									   &pe_opts);
+				ret = libbpf_get_error(link);
+				if (ret) {
+					pr_err("Failed to attach perf sample-filter program\n");
+					goto err;
+				}
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
@@ -532,6 +1486,21 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
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
@@ -539,7 +1508,7 @@ int perf_bpf_filter__destroy(struct evsel *evsel)
 
 	list_for_each_entry_safe(expr, tmp, &evsel->bpf_filters, list) {
 		list_del(&expr->list);
-		free(expr);
+		perf_bpf_filter_expr__delete(expr);
 	}
 	sample_filter_bpf__destroy(evsel->bpf_skel);
 
@@ -591,7 +1560,7 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term
 {
 	struct perf_bpf_filter_expr *expr;
 
-	expr = malloc(sizeof(*expr));
+	expr = zalloc(sizeof(*expr));
 	if (expr != NULL) {
 		expr->term = term;
 		expr->part = part;
@@ -602,6 +1571,28 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term
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
@@ -622,14 +1613,11 @@ static bool check_bpf_filter_capable(void)
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
@@ -641,6 +1629,53 @@ int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
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
+static int pin_filter_object(struct sample_filter_bpf *skel, const char *path)
+{
+	char *prog_path = NULL;
+	int ret;
+
+	ret = bpf_object__pin_maps(skel->obj, path);
+	if (ret < 0)
+		return ret;
+
+	if (asprintf(&prog_path, "%s/perf_sample_filter", path) < 0) {
+		bpf_object__unpin_maps(skel->obj, path);
+		return -ENOMEM;
+	}
+
+	ret = bpf_program__pin(skel->progs.perf_sample_filter, prog_path);
+	if (ret < 0)
+		bpf_object__unpin_maps(skel->obj, path);
+
+	free(prog_path);
+	return ret;
+}
+
+static int unpin_filter_object(struct sample_filter_bpf *skel, const char *path)
+{
+	char *prog_path = NULL;
+	int ret, map_ret;
+
+	if (asprintf(&prog_path, "%s/perf_sample_filter", path) < 0) {
+		bpf_object__unpin_maps(skel->obj, path);
+		return -ENOMEM;
+	}
+
+	ret = bpf_program__unpin(skel->progs.perf_sample_filter, prog_path);
+	free(prog_path);
+
+	map_ret = bpf_object__unpin_maps(skel->obj, path);
+	return ret < 0 ? ret : map_ret;
+}
+
 int perf_bpf_filter__pin(void)
 {
 	struct sample_filter_bpf *skel;
@@ -654,6 +1689,8 @@ int perf_bpf_filter__pin(void)
 		goto err;
 	}
 
+	configure_lock_progs(skel, NULL, 0, 0, false, false, false);
+
 	/* pinned program will use pid-hash */
 	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
 	bpf_map__set_max_entries(skel->maps.event_hash, MAX_EVT_HASH);
@@ -674,7 +1711,7 @@ int perf_bpf_filter__pin(void)
 		goto err;
 	}
 
-	ret = bpf_object__pin(skel->obj, path);
+	ret = pin_filter_object(skel, path);
 	if (ret < 0) {
 		pr_err("Failed to pin BPF filter objects\n");
 		goto err;
@@ -683,8 +1720,8 @@ int perf_bpf_filter__pin(void)
 	/* setup access permissions for the pinned objects */
 	dir_fd = open(path, O_PATH);
 	if (dir_fd < 0) {
-		bpf_object__unpin(skel->obj, path);
-		ret = dir_fd;
+		ret = -errno;
+		unpin_filter_object(skel, path);
 		goto err;
 	}
 
@@ -727,6 +1764,8 @@ int perf_bpf_filter__pin(void)
 
 err_close:
 	close(dir_fd);
+	if (ret < 0)
+		unpin_filter_object(skel, path);
 
 err:
 	free(path);
@@ -740,13 +1779,20 @@ int perf_bpf_filter__unpin(void)
 	char *path = NULL;
 	int ret = -1;
 
-	skel = sample_filter_bpf__open_and_load();
+	skel = sample_filter_bpf__open();
 	if (!skel) {
 		ret = -errno;
 		pr_err("Failed to open perf sample-filter BPF skeleton\n");
 		goto err;
 	}
 
+	configure_lock_progs(skel, NULL, 0, 0, false, false, false);
+	if (sample_filter_bpf__load(skel) < 0) {
+		ret = -errno;
+		pr_err("Failed to load perf sample-filter BPF skeleton\n");
+		goto err;
+	}
+
 	if (asprintf(&path, "%s/fs/bpf/%s", sysfs__mountpoint(),
 		     PERF_BPF_FILTER_PIN_PATH) < 0) {
 		ret = -errno;
@@ -754,7 +1800,7 @@ int perf_bpf_filter__unpin(void)
 		goto err;
 	}
 
-	ret = bpf_object__unpin(skel->obj, path);
+	ret = unpin_filter_object(skel, path);
 
 err:
 	free(path);
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
index 5a79a8e7a45b..6ee6edef13f7 100644
--- a/tools/perf/util/bpf-filter.y
+++ b/tools/perf/util/bpf-filter.y
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <linux/compiler.h>
 #include <linux/list.h>
+#include <linux/zalloc.h>
 #include "bpf-filter.h"
 #include "cgroup.h"
 
@@ -31,6 +32,11 @@ static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
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
@@ -40,12 +46,17 @@ static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
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
 
@@ -105,5 +116,36 @@ BFT_SAMPLE_PATH BFT_OP BFT_PATH
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
index 683fec85e71e..215998897243 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -53,14 +53,79 @@ enum perf_bpf_filter_term {
 	/* Terms computed from BPF helpers. */
 	PBF_TERM_UID,
 	PBF_TERM_GID,
+	/*
+	 * Kernel lock held predicate (`lock_held(...)`). Evaluates to 1 if the
+	 * specified kernel lock is currently held by the running task/CPU, or
+	 * 0 otherwise. The lock specification kind is stored in `entry.part`
+	 * (`enum perf_bpf_lock_target_kind`) and the resolved target address,
+	 * class ID, or type flag encoding is stored in `entry.target`.
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
+	 * Specific global or static lock address (resolved from kallsyms or
+	 * given as a hex address). `entry.target` holds the kernel address.
+	 */
+	PBF_LOCK_ADDR,
+	/*
+	 * Dynamic lock allocated inside a slab cache (`&slab_name`).
+	 * `entry.target` holds the kernel `struct kmem_cache *` address.
+	 */
+	PBF_LOCK_SLAB,
+	/*
+	 * Per-process `current->mm->mmap_lock` (or `mmap_sem`).
+	 */
+	PBF_LOCK_MMAP,
+	/*
+	 * Per-process `current->sighand->siglock`.
+	 */
+	PBF_LOCK_SIGHAND,
+	/*
+	 * Semi-global lock class (`rq_lock` or `zone_lock`).
+	 * `entry.target` holds `enum lock_class_sym` (LOCK_CLASS_RQLOCK or
+	 * LOCK_CLASS_ZONE_LOCK).
+	 */
+	PBF_LOCK_CLASS,
+	/*
+	 * Lock type filter (`mutex`, `spinlock`, `rwsem`, `rwsem:R`, etc.).
+	 * `entry.target` packs up to two `LCB_F_*` flag combinations in the
+	 * low two bytes: `flag1 | (flag2 << 8)` (with 0xff indicating unused).
+	 */
+	PBF_LOCK_TYPE,
+};
+
+/*
+ * `perf_bpf_filter_entry.part` layout for PBF_TERM_LOCK_HELD:
+ *   Bits 0..3: `enum perf_bpf_lock_target_kind`
+ *   Bit  4:    PBF_LOCK_MODE_READ      (match read/shared lock holding)
+ *   Bit  5:    PBF_LOCK_MODE_WRITE     (match write/exclusive lock holding)
+ *   Bit  6:    PBF_LOCK_DIRECT_MUTEX   (inspect struct mutex owner)
+ *   Bit  7:    PBF_LOCK_DIRECT_RWSEM   (inspect struct rw_semaphore writer owner)
+ *   Bit  8:    PBF_LOCK_DIRECT_RTMUTEX (inspect struct rt_mutex_base owner)
+ */
+#define PBF_LOCK_KIND_MASK	0x0fU
+#define PBF_LOCK_MODE_READ	(1U << 4)
+#define PBF_LOCK_MODE_WRITE	(1U << 5)
+#define PBF_LOCK_MODE_ANY	(PBF_LOCK_MODE_READ | PBF_LOCK_MODE_WRITE)
+#define PBF_LOCK_MODE_MASK	PBF_LOCK_MODE_ANY
+#define PBF_LOCK_DIRECT_MUTEX	(1U << 6)
+#define PBF_LOCK_DIRECT_RWSEM	(1U << 7)
+#define PBF_LOCK_DIRECT_RTMUTEX	(1U << 8)
+
 /* BPF map entry for filtering */
 struct perf_bpf_filter_entry {
 	enum perf_bpf_filter_op op;
 	__u32 part; /* sub-sample type info when it has multiple values */
 	enum perf_bpf_filter_term term;
 	__u64 value;
+	__u64 target; /* lock address, kmem_cache *, class, or type flags */
 };
 
 struct idx_hash_key {
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index e5666d4c1722..583a5b98b929 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -5,8 +5,47 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
+#include "lock_data.h"
 #include "sample-filter.h"
 
+/*
+ * Key for the `held_locks` BPF hash map tracking currently held kernel locks.
+ *
+ * - `addr_or_id`:
+ *     - PBF_LOCK_ADDR:  kernel virtual address of the lock instance
+ *     - PBF_LOCK_CLASS: `enum lock_class_sym` (LOCK_CLASS_RQLOCK / LOCK_CLASS_ZONE_LOCK)
+ *     - PBF_LOCK_SLAB:  kernel `struct kmem_cache *` address
+ *     - PBF_LOCK_TYPE:  `LCB_F_*` lock type flags
+ * - `owner_id`:
+ *     - For sleeping locks: kernel task TID (`(__u32)bpf_get_current_pid_tgid()`),
+ *       since the holder may sleep and migrate across CPUs while holding the lock.
+ *     - For spinning locks (`LCB_F_SPIN` without `LCB_F_MUTEX`) or idle tasks
+ *       (`pid == 0`): `0x80000000U | bpf_get_smp_processor_id()`, since preemption
+ *       is disabled on the holding CPU and spinlocks such as `rq_lock` may be
+ *       acquired by one task and released by the next task across `context_switch()`.
+ * - `kind`: `enum perf_bpf_lock_target_kind`.
+ */
+struct held_lock_key {
+	__u64 addr_or_id;
+	__u32 owner_id;
+	__u32 kind;
+};
+
+/*
+ * Value for `held_locks` entries.
+ * `read_count` and `write_count` separately track shared/read (`LCB_F_READ`)
+ * and exclusive/write acquisitions (including nested class/slab/type
+ * acquisitions by the same owner). `flags` stores the `LCB_F_*` type flags of
+ * the lock so release tracepoints that do not carry flags (such as
+ * `lock:contended_release`) can decrement matching class/slab/type entries.
+ */
+struct held_lock_val {
+	__u32 read_count;
+	__u32 write_count;
+	__u32 flags;
+	__u32 pad;
+};
+
 /* BPF map that will be filled by user space */
 struct filters {
 	__uint(type, BPF_MAP_TYPE_HASH);
@@ -43,10 +82,220 @@ struct lost_count {
 	__uint(max_entries, 1);
 } dropped SEC(".maps");
 
+/* Currently held kernel locks tracked by fentry/fexit and lock tracepoints. */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, struct held_lock_key);
+	__type(value, struct held_lock_val);
+	__uint(max_entries, 1);
+} held_locks SEC(".maps");
+
+/* Target lock addresses for PBF_LOCK_ADDR filters. */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u64);
+	__type(value, __u8);
+	__uint(max_entries, 1);
+} lock_addr_filter SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, 1);
+} lock_syms SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} slab_filter SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(struct slab_cache_data));
+	__uint(max_entries, 1);
+} slab_caches SEC(".maps");
+
 volatile const int use_idx_hash;
 
+const volatile __u64 contig_page_data_addr;
+const volatile __u64 node_data_addr;
+const volatile int nr_nodes;
+const volatile int sizeof_zone;
+
+__u32 slab_cache_id;
+
+/* Control flags set by userspace when lock_held(...) filters are active. */
+int lock_enabled;
+int has_lock_addr;
+int has_lock_slab;
+int has_lock_class;
+int has_lock_type;
+int has_mmap_lock;
+int has_siglock;
+int track_rwsem_read;
+__u8 lock_type_filter[LCB_F_TYPE_MAX];
+
 void *bpf_cast_to_kern_ctx(void *) __ksym;
 
+/*
+ * Direct lock owner inspection helper using `get_lock_owner()` from `lock_data.h`.
+ *
+ * For locks that maintain a task_struct pointer in their `owner` field
+ * (`struct mutex`, write-locked `struct rw_semaphore`, and `struct rt_mutex`),
+ * `perf_sample_filter` can inspect the lock structure directly in kernel memory
+ * and compare the owner against `current` (`bpf_get_current_task()`).
+ *
+ * Note that for reader-locked `rw_semaphore`s, `__up_read()` does not clear
+ * `sem->owner` when `CONFIG_DEBUG_RWSEMS` is disabled, so reader locks and
+ * spinlocks are checked via the `held_locks` BPF map instead.
+ */
+static __always_inline bool is_rwsem_writer_owner(__u64 lock_addr, __u64 curr)
+{
+	struct rw_semaphore___new *rwsem = (void *)lock_addr;
+
+	if (bpf_core_field_exists(rwsem->count.counter) &&
+	    !(BPF_CORE_READ(rwsem, count.counter) & 1UL))
+		return false;
+	if (bpf_core_field_exists(rwsem->owner.counter) &&
+	    (BPF_CORE_READ(rwsem, owner.counter) & 1UL))
+		return false;
+
+	return (__u64)get_lock_owner(lock_addr, LCB_F_WRITE) == curr;
+}
+
+static __always_inline bool is_direct_lock_owner(__u64 lock_addr, __u64 curr, __u32 part)
+{
+	if (!curr)
+		return false;
+
+	if ((part & PBF_LOCK_DIRECT_MUTEX) &&
+	    (__u64)get_lock_owner(lock_addr, LCB_F_MUTEX) == curr)
+		return true;
+	if ((part & PBF_LOCK_DIRECT_RWSEM) &&
+	    is_rwsem_writer_owner(lock_addr, curr))
+		return true;
+	if ((part & PBF_LOCK_DIRECT_RTMUTEX) &&
+	    (__u64)get_lock_owner(lock_addr, LCB_F_RT) == curr)
+		return true;
+	return false;
+}
+
+static __always_inline bool match_held_val(struct held_lock_val *val, __u32 mode)
+{
+	if (!val)
+		return false;
+	if ((mode & PBF_LOCK_MODE_READ) && val->read_count > 0)
+		return true;
+	if ((mode & PBF_LOCK_MODE_WRITE) && val->write_count > 0)
+		return true;
+	return false;
+}
+
+static __always_inline __u64 is_lock_in_map(__u64 addr_or_id, __u32 kind,
+					    __u32 mode, __u32 pid, __u32 cpu_id)
+{
+	struct held_lock_key key = {
+		.addr_or_id = addr_or_id,
+		.owner_id = pid,
+		.kind = kind,
+	};
+	struct held_lock_val *val;
+
+	if (pid) {
+		val = bpf_map_lookup_elem(&held_locks, &key);
+		if (match_held_val(val, mode))
+			return 1;
+	}
+
+	key.owner_id = cpu_id;
+	val = bpf_map_lookup_elem(&held_locks, &key);
+	if (match_held_val(val, mode))
+		return 1;
+
+	return 0;
+}
+
+static __always_inline __u64 is_lock_type_in_map(__u64 target, __u32 mode,
+						 __u32 pid, __u32 cpu_id)
+{
+	__u32 flag1 = target & 0xff;
+	__u32 flag2 = (target >> 8) & 0xff;
+
+	if (is_lock_in_map(flag1, PBF_LOCK_TYPE, mode, pid, cpu_id))
+		return 1;
+	if (flag2 != 0xff && is_lock_in_map(flag2, PBF_LOCK_TYPE, mode, pid, cpu_id))
+		return 1;
+	return 0;
+}
+
+static __always_inline __u64 check_lock_held(struct perf_bpf_filter_entry *entry)
+{
+	__u64 curr;
+	__u32 pid;
+	__u32 cpu_id;
+	__u32 kind;
+	__u32 mode;
+	__u64 lock_addr;
+
+	/*
+	 * Pinned filters (use_idx_hash != 0) share a world-writable filters
+	 * map and do not support lock_held(). Reject evaluation when pinned
+	 * or when lock_enabled is not set so unprivileged users cannot probe
+	 * arbitrary kernel addresses via entry->target.
+	 */
+	if (use_idx_hash || !lock_enabled)
+		return 0;
+
+	curr = bpf_get_current_task();
+	pid = (__u32)bpf_get_current_pid_tgid();
+	cpu_id = 0x80000000U | bpf_get_smp_processor_id();
+	kind = entry->part & PBF_LOCK_KIND_MASK;
+	mode = entry->part & PBF_LOCK_MODE_MASK;
+
+	if (!mode)
+		mode = PBF_LOCK_MODE_ANY;
+
+	switch (kind) {
+	case PBF_LOCK_ADDR:
+		lock_addr = entry->target;
+		if ((mode & PBF_LOCK_MODE_WRITE) &&
+		    is_direct_lock_owner(lock_addr, curr, entry->part))
+			return 1;
+		return is_lock_in_map(lock_addr, PBF_LOCK_ADDR, mode, pid, cpu_id);
+
+	case PBF_LOCK_MMAP:
+		lock_addr = get_current_mmap_lock(curr);
+		if (!lock_addr)
+			return 0;
+		if ((mode & PBF_LOCK_MODE_WRITE) &&
+		    is_rwsem_writer_owner(lock_addr, curr))
+			return 1;
+		return is_lock_in_map(lock_addr, PBF_LOCK_ADDR, mode, pid, cpu_id);
+
+	case PBF_LOCK_SIGHAND:
+		lock_addr = get_current_siglock(curr);
+		if (!lock_addr)
+			return 0;
+		return is_lock_in_map(lock_addr, PBF_LOCK_ADDR, mode, pid, cpu_id);
+
+	case PBF_LOCK_CLASS:
+		return is_lock_in_map(entry->target, PBF_LOCK_CLASS, mode, pid, cpu_id);
+
+	case PBF_LOCK_SLAB:
+		return is_lock_in_map(entry->target, PBF_LOCK_SLAB, mode, pid, cpu_id);
+
+	case PBF_LOCK_TYPE:
+		return is_lock_type_in_map(entry->target, mode, pid, cpu_id);
+
+	default:
+		return 0;
+	}
+}
+
 /* new kernel perf_sample_data definition */
 struct perf_sample_data___new {
 	__u64 sample_flags;
@@ -175,6 +424,8 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		return bpf_get_current_uid_gid() & 0xFFFFFFFF;
 	case PBF_TERM_GID:
 		return bpf_get_current_uid_gid() >> 32;
+	case PBF_TERM_LOCK_HELD:
+		return check_lock_held(entry);
 	case PBF_TERM_NONE:
 	case __PBF_UNUSED_TERM4:
 	case __PBF_UNUSED_TERM5:
@@ -192,6 +443,30 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 	return 0;
 }
 
+static __always_inline __u64 perf_get_common_sample(struct perf_bpf_filter_entry *entry)
+{
+	switch (entry->term) {
+	case PBF_TERM_TID:
+		if (entry->part)
+			return bpf_get_current_pid_tgid() >> 32;
+		return (__u32)bpf_get_current_pid_tgid();
+	case PBF_TERM_CPU:
+		return bpf_get_smp_processor_id();
+	case PBF_TERM_TIME:
+		return bpf_ktime_get_ns();
+	case PBF_TERM_CGROUP:
+		return bpf_get_current_cgroup_id();
+	case PBF_TERM_UID:
+		return bpf_get_current_uid_gid() & 0xFFFFFFFF;
+	case PBF_TERM_GID:
+		return bpf_get_current_uid_gid() >> 32;
+	case PBF_TERM_LOCK_HELD:
+		return check_lock_held(entry);
+	default:
+		return 0;
+	}
+}
+
 #define CHECK_RESULT(data, op, val)			\
 	if (!(data op val)) {				\
 		if (!in_group)				\
@@ -295,4 +570,823 @@ int perf_sample_filter(void *ctx)
 	return 0;
 }
 
+/* BPF program to be called for tracepoint perf events */
+SEC("tracepoint")
+int perf_tp_sample_filter(void *ctx)
+{
+	struct perf_bpf_filter_entry *entry;
+	__u64 sample_data;
+	int in_group = 0;
+	int group_result = 0;
+	int i, k = 0;
+	int *losts;
+
+	entry = bpf_map_lookup_elem(&filters, &k);
+	if (entry == NULL)
+		goto drop;
+
+	for (i = 0; i < MAX_FILTERS; i++) {
+		sample_data = perf_get_common_sample(&entry[i]);
+
+		switch (entry[i].op) {
+		case PBF_OP_EQ:
+			CHECK_RESULT(sample_data, ==, entry[i].value)
+			break;
+		case PBF_OP_NEQ:
+			CHECK_RESULT(sample_data, !=, entry[i].value)
+			break;
+		case PBF_OP_GT:
+			CHECK_RESULT(sample_data, >, entry[i].value)
+			break;
+		case PBF_OP_GE:
+			CHECK_RESULT(sample_data, >=, entry[i].value)
+			break;
+		case PBF_OP_LT:
+			CHECK_RESULT(sample_data, <, entry[i].value)
+			break;
+		case PBF_OP_LE:
+			CHECK_RESULT(sample_data, <=, entry[i].value)
+			break;
+		case PBF_OP_AND:
+			CHECK_RESULT(sample_data, &, entry[i].value)
+			break;
+		case PBF_OP_GROUP_BEGIN:
+			in_group = 1;
+			group_result = 0;
+			break;
+		case PBF_OP_GROUP_END:
+			if (group_result == 0)
+				goto drop;
+			in_group = 0;
+			break;
+		case PBF_OP_DONE:
+			return 1;
+		}
+	}
+	return 1;
+
+drop:
+	losts = bpf_map_lookup_elem(&dropped, &k);
+	if (losts != NULL)
+		__sync_fetch_and_add(losts, 1);
+
+	return 0;
+}
+
+static __always_inline __u32 get_lock_owner_id(__u32 flags)
+{
+	__u32 owner_id;
+
+	if ((flags & (LCB_F_SPIN | LCB_F_MUTEX)) == LCB_F_SPIN)
+		return 0x80000000U | bpf_get_smp_processor_id();
+
+	owner_id = (__u32)bpf_get_current_pid_tgid();
+	if (!owner_id)
+		owner_id = 0x80000000U | bpf_get_smp_processor_id();
+	return owner_id;
+}
+
+static __always_inline void update_held_lock_count(__u64 addr_or_id, __u32 owner_id,
+						   __u32 kind, __u32 flags, bool acquired)
+{
+	struct held_lock_key key = {
+		.addr_or_id = addr_or_id,
+		.owner_id = owner_id,
+		.kind = kind,
+	};
+	struct held_lock_val *val;
+	bool is_read = (flags & LCB_F_READ) != 0;
+
+	val = bpf_map_lookup_elem(&held_locks, &key);
+	if (acquired) {
+		if (val) {
+			if (is_read)
+				__sync_fetch_and_add(&val->read_count, 1);
+			else
+				__sync_fetch_and_add(&val->write_count, 1);
+		} else {
+			struct held_lock_val first = {
+				.read_count = is_read ? 1 : 0,
+				.write_count = is_read ? 0 : 1,
+				.flags = flags,
+			};
+
+			bpf_map_update_elem(&held_locks, &key, &first, BPF_ANY);
+		}
+	} else if (val) {
+		if (is_read) {
+			if (val->read_count <= 1 && val->write_count == 0)
+				bpf_map_delete_elem(&held_locks, &key);
+			else if (val->read_count > 0)
+				__sync_fetch_and_add(&val->read_count, -1);
+		} else {
+			if (val->write_count <= 1 && val->read_count == 0)
+				bpf_map_delete_elem(&held_locks, &key);
+			else if (val->write_count > 0)
+				__sync_fetch_and_add(&val->write_count, -1);
+		}
+	}
+}
+
+#define LCB_F_READ_IRQSAVE	(1U << 30)
+#define LCB_F_READ_IRQ_BH	(1U << 31)
+
+static __always_inline int record_lock_acquired_owner(__u64 lock_addr, __u32 flags, __u32 owner_id)
+{
+	struct held_lock_key addr_key = {
+		.addr_or_id = lock_addr,
+		.owner_id = owner_id,
+		.kind = PBF_LOCK_ADDR,
+	};
+	struct held_lock_val *existing;
+	bool matched = false;
+	bool is_read = (flags & LCB_F_READ) != 0;
+	__u32 class_id = 0;
+	__u64 kmem_cache_addr = 0;
+	__u32 type_flag = flags & LCB_F_TYPE_MASK;
+	bool match_type = false;
+
+	if (!lock_enabled || !lock_addr)
+		return 0;
+
+	if (has_lock_addr && bpf_map_lookup_elem(&lock_addr_filter, &lock_addr))
+		matched = true;
+
+	if (has_mmap_lock || has_siglock) {
+		__u32 ltype = check_lock_type(lock_addr, type_flag);
+
+		if ((has_mmap_lock && ltype == LCD_F_MMAP_LOCK) ||
+		    (has_siglock && ltype == LCD_F_SIGHAND_LOCK))
+			matched = true;
+	}
+
+	if (has_lock_class && type_flag == LCB_F_SPIN) {
+		__u32 *cid = bpf_map_lookup_elem(&lock_syms, &lock_addr);
+
+		if (cid) {
+			class_id = *cid;
+			matched = true;
+		}
+	}
+
+	if (has_lock_slab && bpf_get_kmem_cache) {
+		kmem_cache_addr = (__u64)bpf_get_kmem_cache(lock_addr);
+		if (kmem_cache_addr && bpf_map_lookup_elem(&slab_filter, &kmem_cache_addr))
+			matched = true;
+		else
+			kmem_cache_addr = 0;
+	}
+
+	if (has_lock_type && type_flag < LCB_F_TYPE_MAX && lock_type_filter[type_flag]) {
+		match_type = true;
+		matched = true;
+	}
+
+	if (!matched)
+		return 0;
+
+	existing = bpf_map_lookup_elem(&held_locks, &addr_key);
+	if (existing) {
+		/*
+		 * On CONFIG_GENERIC_LOCKBREAK=y && !CONFIG_DEBUG_LOCK_ALLOC
+		 * kernels, _raw_read_lock_irq() and _raw_read_lock_bh() call
+		 * the out-of-line _raw_read_lock_irqsave(). Clear the marker
+		 * and skip the duplicate outer fexit increment.
+		 */
+		if ((flags & LCB_F_READ_IRQ_BH) &&
+		    (existing->flags & LCB_F_READ_IRQSAVE)) {
+			existing->flags &= ~LCB_F_READ_IRQSAVE;
+			return 0;
+		}
+		/* Non-reader locks are not recursive; avoid double-counting */
+		if (!is_read && existing->write_count > 0)
+			return 0;
+		if (is_read) {
+			__sync_fetch_and_add(&existing->read_count, 1);
+			if (flags & LCB_F_READ_IRQSAVE)
+				existing->flags |= LCB_F_READ_IRQSAVE;
+			else
+				existing->flags &= ~LCB_F_READ_IRQSAVE;
+		} else {
+			__sync_fetch_and_add(&existing->write_count, 1);
+		}
+	} else {
+		struct held_lock_val first = {
+			.read_count = is_read ? 1 : 0,
+			.write_count = is_read ? 0 : 1,
+			.flags = flags & (LCB_F_TYPE_MASK | LCB_F_READ_IRQSAVE),
+		};
+
+		if (bpf_map_update_elem(&held_locks, &addr_key, &first, BPF_ANY) < 0)
+			return 0;
+	}
+
+	if (class_id)
+		update_held_lock_count(class_id, owner_id, PBF_LOCK_CLASS, type_flag, true);
+	if (kmem_cache_addr) {
+		update_held_lock_count((__u64)kmem_cache_addr, owner_id,
+				       PBF_LOCK_SLAB, type_flag, true);
+	}
+	if (match_type)
+		update_held_lock_count(type_flag, owner_id, PBF_LOCK_TYPE, type_flag, true);
+
+	return 0;
+}
+
+static __always_inline int record_lock_acquired(void *ctx, __u32 flags)
+{
+	return record_lock_acquired_owner(get_lock_addr(ctx), flags, get_lock_owner_id(flags));
+}
+
+static __always_inline int record_lock_released_addr(__u64 lock_addr, __u32 flags)
+{
+	__u32 owner_id = get_lock_owner_id(flags);
+	struct held_lock_key addr_key = {
+		.addr_or_id = lock_addr,
+		.owner_id = owner_id,
+		.kind = PBF_LOCK_ADDR,
+	};
+	struct held_lock_val *existing;
+	__u32 type_flag = flags & LCB_F_TYPE_MASK;
+	bool is_read = (flags & LCB_F_READ) != 0;
+
+	if (!lock_enabled || !lock_addr)
+		return 0;
+
+	existing = bpf_map_lookup_elem(&held_locks, &addr_key);
+	if (!existing)
+		return 0;
+
+	if (is_read) {
+		if (existing->read_count == 0)
+			return 0;
+		if (existing->read_count == 1 && existing->write_count == 0) {
+			bpf_map_delete_elem(&held_locks, &addr_key);
+		} else {
+			existing->flags &= ~LCB_F_READ_IRQSAVE;
+			__sync_fetch_and_add(&existing->read_count, -1);
+		}
+	} else {
+		if (existing->write_count == 0)
+			return 0;
+		if (existing->read_count == 0)
+			bpf_map_delete_elem(&held_locks, &addr_key);
+		else
+			existing->write_count = 0;
+	}
+
+	if (has_lock_class && flags == LCB_F_SPIN) {
+		__u32 *cid = bpf_map_lookup_elem(&lock_syms, &lock_addr);
+
+		if (cid)
+			update_held_lock_count(*cid, owner_id, PBF_LOCK_CLASS, flags, false);
+	}
+
+	if (has_lock_slab && bpf_get_kmem_cache) {
+		__u64 kmem_cache_addr = (__u64)bpf_get_kmem_cache(lock_addr);
+
+		if (kmem_cache_addr && bpf_map_lookup_elem(&slab_filter, &kmem_cache_addr)) {
+			update_held_lock_count(kmem_cache_addr, owner_id,
+					       PBF_LOCK_SLAB, flags, false);
+		}
+	}
+
+	if (has_lock_type && type_flag < LCB_F_TYPE_MAX && lock_type_filter[type_flag])
+		update_held_lock_count(type_flag, owner_id, PBF_LOCK_TYPE, flags, false);
+
+	return 0;
+}
+
+static __always_inline int record_lock_released(void *ctx, __u32 flags)
+{
+	return record_lock_released_addr(get_lock_addr(ctx), flags);
+}
+
+/* Mutex acquire/release hooks */
+SEC("fexit/mutex_lock")
+int BPF_PROG(fexit_mutex_lock, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_MUTEX);
+}
+
+SEC("fexit/mutex_lock_nested")
+int BPF_PROG(fexit_mutex_lock_nested, void *lock, unsigned int subclass)
+{
+	return record_lock_acquired(ctx, LCB_F_MUTEX);
+}
+
+SEC("fexit/_mutex_lock_nest_lock")
+int BPF_PROG(fexit__mutex_lock_nest_lock, void *lock, void *nest_lock)
+{
+	return record_lock_acquired(ctx, LCB_F_MUTEX);
+}
+
+SEC("fexit/mutex_lock_io")
+int BPF_PROG(fexit_mutex_lock_io, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_MUTEX);
+}
+
+SEC("fexit/mutex_lock_io_nested")
+int BPF_PROG(fexit_mutex_lock_io_nested, void *lock, unsigned int subclass)
+{
+	return record_lock_acquired(ctx, LCB_F_MUTEX);
+}
+
+SEC("fexit/mutex_lock_interruptible")
+int BPF_PROG(fexit_mutex_lock_interruptible, void *lock, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_MUTEX);
+	return 0;
+}
+
+SEC("fexit/mutex_lock_interruptible_nested")
+int BPF_PROG(fexit_mutex_lock_interruptible_nested, void *lock, unsigned int subclass, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_MUTEX);
+	return 0;
+}
+
+SEC("fexit/mutex_lock_killable")
+int BPF_PROG(fexit_mutex_lock_killable, void *lock, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_MUTEX);
+	return 0;
+}
+
+SEC("fexit/_mutex_lock_killable")
+int BPF_PROG(fexit__mutex_lock_killable, void *lock, unsigned int subclass,
+	     void *nest_lock, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_MUTEX);
+	return 0;
+}
+
+SEC("fexit/mutex_trylock")
+int BPF_PROG(fexit_mutex_trylock, void *lock, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_MUTEX);
+	return 0;
+}
+
+SEC("fexit/_mutex_trylock_nest_lock")
+int BPF_PROG(fexit__mutex_trylock_nest_lock, void *lock, void *nest_lock, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_MUTEX);
+	return 0;
+}
+
+SEC("fentry/mutex_unlock")
+int BPF_PROG(fentry_mutex_unlock, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_MUTEX);
+}
+
+/* RW semaphore acquire/release hooks */
+SEC("fexit/down_read")
+int BPF_PROG(fexit_down_read, void *sem)
+{
+	return record_lock_acquired(ctx, LCB_F_READ);
+}
+
+SEC("fexit/down_read_nested")
+int BPF_PROG(fexit_down_read_nested, void *sem, int subclass)
+{
+	return record_lock_acquired(ctx, LCB_F_READ);
+}
+
+SEC("fexit/down_read_interruptible")
+int BPF_PROG(fexit_down_read_interruptible, void *sem, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_READ);
+	return 0;
+}
+
+SEC("fexit/down_read_killable")
+int BPF_PROG(fexit_down_read_killable, void *sem, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_READ);
+	return 0;
+}
+
+SEC("fexit/down_read_killable_nested")
+int BPF_PROG(fexit_down_read_killable_nested, void *sem, int subclass, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_READ);
+	return 0;
+}
+
+SEC("fexit/down_read_trylock")
+int BPF_PROG(fexit_down_read_trylock, void *sem, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_READ);
+	return 0;
+}
+
+SEC("fexit/down_write")
+int BPF_PROG(fexit_down_write, void *sem)
+{
+	return record_lock_acquired(ctx, LCB_F_WRITE);
+}
+
+SEC("fexit/down_write_nested")
+int BPF_PROG(fexit_down_write_nested, void *sem, int subclass)
+{
+	return record_lock_acquired(ctx, LCB_F_WRITE);
+}
+
+SEC("fexit/_down_write_nest_lock")
+int BPF_PROG(fexit__down_write_nest_lock, void *sem, void *nest_lock)
+{
+	return record_lock_acquired(ctx, LCB_F_WRITE);
+}
+
+SEC("fexit/down_write_killable")
+int BPF_PROG(fexit_down_write_killable, void *sem, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_WRITE);
+	return 0;
+}
+
+SEC("fexit/down_write_killable_nested")
+int BPF_PROG(fexit_down_write_killable_nested, void *sem, int subclass, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_WRITE);
+	return 0;
+}
+
+SEC("fexit/down_write_trylock")
+int BPF_PROG(fexit_down_write_trylock, void *sem, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_WRITE);
+	return 0;
+}
+
+SEC("fexit/downgrade_write")
+int BPF_PROG(fexit_downgrade_write, void *sem)
+{
+	if (track_rwsem_read)
+		record_lock_acquired(ctx, LCB_F_READ);
+	return record_lock_released(ctx, LCB_F_WRITE);
+}
+
+SEC("fentry/up_read")
+int BPF_PROG(fentry_up_read, void *sem)
+{
+	return record_lock_released(ctx, LCB_F_READ);
+}
+
+SEC("fentry/up_write")
+int BPF_PROG(fentry_up_write, void *sem)
+{
+	return record_lock_released(ctx, LCB_F_WRITE);
+}
+
+/* Spinlock acquire/release hooks */
+SEC("fexit/_raw_spin_lock")
+int BPF_PROG(fexit_raw_spin_lock, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_lock_nested")
+int BPF_PROG(fexit_raw_spin_lock_nested, void *lock, int subclass)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_lock_nest_lock")
+int BPF_PROG(fexit_raw_spin_lock_nest_lock, void *lock, void *nest_lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_lock_irq")
+int BPF_PROG(fexit_raw_spin_lock_irq, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_lock_irq_disable")
+int BPF_PROG(fexit_raw_spin_lock_irq_disable, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_lock_irqsave")
+int BPF_PROG(fexit_raw_spin_lock_irqsave, void *lock, unsigned long flags)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_lock_irqsave_nested")
+int BPF_PROG(fexit_raw_spin_lock_irqsave_nested, void *lock, int subclass, unsigned long flags)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_lock_bh")
+int BPF_PROG(fexit_raw_spin_lock_bh, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_trylock")
+int BPF_PROG(fexit_raw_spin_trylock, void *lock, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_SPIN);
+	return 0;
+}
+
+SEC("fexit/_raw_spin_trylock_bh")
+int BPF_PROG(fexit_raw_spin_trylock_bh, void *lock, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_SPIN);
+	return 0;
+}
+
+SEC("fentry/_raw_spin_unlock")
+int BPF_PROG(fentry_raw_spin_unlock, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN);
+}
+
+SEC("fentry/_raw_spin_unlock_irq")
+int BPF_PROG(fentry_raw_spin_unlock_irq, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN);
+}
+
+SEC("fentry/_raw_spin_unlock_irq_enable")
+int BPF_PROG(fentry_raw_spin_unlock_irq_enable, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN);
+}
+
+SEC("fentry/_raw_spin_unlock_irqrestore")
+int BPF_PROG(fentry_raw_spin_unlock_irqrestore, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN);
+}
+
+SEC("fentry/_raw_spin_unlock_bh")
+int BPF_PROG(fentry_raw_spin_unlock_bh, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN);
+}
+
+/* RWlock acquire/release hooks */
+SEC("fexit/_raw_read_lock")
+int BPF_PROG(fexit_raw_read_lock, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_READ);
+}
+
+SEC("fexit/_raw_read_lock_irq")
+int BPF_PROG(fexit_raw_read_lock_irq, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_READ | LCB_F_READ_IRQ_BH);
+}
+
+SEC("fexit/_raw_read_lock_irqsave")
+int BPF_PROG(fexit_raw_read_lock_irqsave, void *lock, unsigned long flags)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_READ | LCB_F_READ_IRQSAVE);
+}
+
+SEC("fexit/_raw_read_lock_bh")
+int BPF_PROG(fexit_raw_read_lock_bh, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_READ | LCB_F_READ_IRQ_BH);
+}
+
+SEC("fexit/_raw_read_trylock")
+int BPF_PROG(fexit_raw_read_trylock, void *lock, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_READ);
+	return 0;
+}
+
+SEC("fentry/_raw_read_unlock")
+int BPF_PROG(fentry_raw_read_unlock, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_READ);
+}
+
+SEC("fentry/_raw_read_unlock_irq")
+int BPF_PROG(fentry_raw_read_unlock_irq, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_READ);
+}
+
+SEC("fentry/_raw_read_unlock_irqrestore")
+int BPF_PROG(fentry_raw_read_unlock_irqrestore, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_READ);
+}
+
+SEC("fentry/_raw_read_unlock_bh")
+int BPF_PROG(fentry_raw_read_unlock_bh, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_READ);
+}
+
+SEC("fexit/_raw_write_lock")
+int BPF_PROG(fexit_raw_write_lock, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fexit/_raw_write_lock_nested")
+int BPF_PROG(fexit_raw_write_lock_nested, void *lock, int subclass)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fexit/_raw_write_lock_irq")
+int BPF_PROG(fexit_raw_write_lock_irq, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fexit/_raw_write_lock_irqsave")
+int BPF_PROG(fexit_raw_write_lock_irqsave, void *lock, unsigned long flags)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fexit/_raw_write_lock_bh")
+int BPF_PROG(fexit_raw_write_lock_bh, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fexit/_raw_write_trylock")
+int BPF_PROG(fexit_raw_write_trylock, void *lock, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_WRITE);
+	return 0;
+}
+
+SEC("fentry/_raw_write_unlock")
+int BPF_PROG(fentry_raw_write_unlock, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fentry/_raw_write_unlock_irq")
+int BPF_PROG(fentry_raw_write_unlock_irq, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fentry/_raw_write_unlock_irqrestore")
+int BPF_PROG(fentry_raw_write_unlock_irqrestore, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fentry/_raw_write_unlock_bh")
+int BPF_PROG(fentry_raw_write_unlock_bh, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+/* RT-Mutex acquire/release hooks */
+SEC("fexit/rt_mutex_lock")
+int BPF_PROG(fexit_rt_mutex_lock, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_RT);
+}
+
+SEC("fexit/rt_mutex_lock_nested")
+int BPF_PROG(fexit_rt_mutex_lock_nested, void *lock, unsigned int subclass)
+{
+	return record_lock_acquired(ctx, LCB_F_RT);
+}
+
+SEC("fexit/_rt_mutex_lock_nest_lock")
+int BPF_PROG(fexit__rt_mutex_lock_nest_lock, void *lock, void *nest_lock)
+{
+	return record_lock_acquired(ctx, LCB_F_RT);
+}
+
+SEC("fexit/rt_mutex_lock_interruptible")
+int BPF_PROG(fexit_rt_mutex_lock_interruptible, void *lock, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_RT);
+	return 0;
+}
+
+SEC("fexit/rt_mutex_lock_killable")
+int BPF_PROG(fexit_rt_mutex_lock_killable, void *lock, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_RT);
+	return 0;
+}
+
+SEC("fexit/rt_mutex_trylock")
+int BPF_PROG(fexit_rt_mutex_trylock, void *lock, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_RT);
+	return 0;
+}
+
+SEC("fentry/rt_mutex_unlock")
+int BPF_PROG(fentry_rt_mutex_unlock, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_RT);
+}
+
+/* Semaphore acquire/release hooks */
+SEC("fexit/down")
+int BPF_PROG(fexit_down, void *sem)
+{
+	return record_lock_acquired(ctx, 0);
+}
+
+SEC("fexit/down_interruptible")
+int BPF_PROG(fexit_down_interruptible, void *sem, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, 0);
+	return 0;
+}
+
+SEC("fexit/down_killable")
+int BPF_PROG(fexit_down_killable, void *sem, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, 0);
+	return 0;
+}
+
+SEC("fexit/down_timeout")
+int BPF_PROG(fexit_down_timeout, void *sem, long timeout, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, 0);
+	return 0;
+}
+
+SEC("fexit/down_trylock")
+int BPF_PROG(fexit_down_trylock, void *sem, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, 0);
+	return 0;
+}
+
+SEC("fentry/up")
+int BPF_PROG(fentry_up, void *sem)
+{
+	return record_lock_released(ctx, 0);
+}
+
+/* Percpu-rwsem write acquire/release hooks */
+SEC("fexit/percpu_down_write")
+int BPF_PROG(fexit_percpu_down_write, void *sem)
+{
+	return record_lock_acquired(ctx, LCB_F_PERCPU | LCB_F_WRITE);
+}
+
+SEC("fentry/percpu_up_write")
+int BPF_PROG(fentry_percpu_up_write, void *sem)
+{
+	return record_lock_released(ctx, LCB_F_PERCPU | LCB_F_WRITE);
+}
+
+SEC("raw_tp/bpf_test_finish")
+int BPF_PROG(collect_lock_syms)
+{
+	return do_collect_lock_syms(&lock_syms, contig_page_data_addr,
+				    node_data_addr, nr_nodes, sizeof_zone);
+}
+
+SEC("iter/kmem_cache")
+int slab_cache_iter(void *ctx)
+{
+	return do_slab_cache_iter(ctx, &slab_caches, &slab_cache_id);
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2f3317ce17f0..1fcb424b75c0 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2596,7 +2596,8 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 /* Will a tracepoint filter work for str or should a BPF filter be used? */
 static bool is_possible_tp_filter(const char *str)
 {
-	return strstr(str, "uid") == NULL;
+	return strstr(str, "uid") == NULL && strstr(str, "gid") == NULL &&
+	       strstr(str, "lock_held") == NULL;
 }
 
 static int set_filter(struct evsel *evsel, const void *arg)
-- 
2.56.0.212.g129ede20d9-goog

