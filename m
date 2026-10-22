Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701038;
	b=PyUYNDhYylJm98by2Q7jnfM2LpX1OtgZub5eHplKgLF4utP6N4GcLvU30Yh3Dx8NZayo
	 +igrj8Ymez+pHPy+pgiXJPU7xqB0O5TXHZXkjKm3zysrz0mx62v4JCFhJ2Kx3l9hNYtav
	 wD/kyAnvHDcwABo+eFa9+RlXzjtpsS2mMZlFuexzoxF7jG6UNiarfcZJWtveTOdZY3xGF
	 Zo4P6O/KyPI3bDdQ48wCo2Hl0lOqoOVNy/yN/yw9HQYTHkUIHBgYZNCBqm6CNAVsS2SpS
	 JQ0GcpQk+rGl5YW4aJ2q8m/TLgRMzGVg2nB6O+lqPz4HWrzsCk0tBmBFm09gmH2wZjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=PcMJ4I/jlWiETt5qxCswgIWRpEhiY8TPiPf0D/dnKTQ=;
	b=lRs7UPTIjn5IUWGQf3NU0gq85MyYHMkNwq/8jevcRRhhjKj8n/VnVeGzUVWtoX7rAStN
	 0HK/6ABGvmURDUkktaFlV9NBBkkfITWOlIRFgqmWrpXoNMPKZ31I7yi01C2ZE5cQkrOZu
	 1w+ao5bbJYV/R1lH6ASmopndFC4Eqkf6qFiP0jV3ASplkzOjR+MIP3bgsNskRQRzVcSdv
	 o181ny3aLphq18BTjLufm/gMWVOmKez9b+UAn4Nq3H79ivPywei+/gqZfW1jFOP8G8R0C
	 SMB7xvmY+oyj11pEn3SNCAs2gL5TTJlXmCVOYMxcgNPuuhpV9ERsseHgWCkHie43ndA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dNyRFPaZ;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8044960A2604
	for <rcu@vger.kernel.org>; Thu, 22 Oct 2026 20:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8044960A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dNyRFPaZ
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36637676140so324416eec.0
        for <rcu@vger.kernel.org>; Thu, 22 Oct 2026 13:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792701037; x=1793305837; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PcMJ4I/jlWiETt5qxCswgIWRpEhiY8TPiPf0D/dnKTQ=;
        b=dNyRFPaZsvnuTywpBicH5OdmXWyc1IhxlqnFgElg+Cq1hse7YY+Lw87+aTAcxsiPEh
         ysNhVwjhU38K+T4F65AgiBUtXpub6qO51elnrdSnkn6hhQKNNzeRAQLSBR7MSQ7EgKIM
         y/qiVbXYW+4DqDoC77M+EZOI1lYGDVcZVa8qLOv7FjfcckpjWIxBRNyTYOQ2c8b/uXxp
         1bsbISrH1heseWFA2LCJ0dCsShyoivt39Gr0LP2SUbKSP8mgnyvFscSB9uML0oPuaa2q
         JW710v1z5w+e1Kx/yuhT6OTEIWwAxieaKtYTuKMjOIseNpDLNKi7ivWRjId2IK05EY6p
         T5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792701037; x=1793305837;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PcMJ4I/jlWiETt5qxCswgIWRpEhiY8TPiPf0D/dnKTQ=;
        b=UK2JQ2od+lzJcylz78Ms3QwmuXadgkKOXmK5y5ya4bNJH6gx1ZEeHwbfE0EAGBWXBx
         rQ9nT0+4byrasy5+R5mmYsGHHn7YtTpo7rRACLp1cT6zCzr2Z1P9Adt46hctxb8TtRc7
         OK0Qp/tSu+pu/KaLHzw8IooB4WPgU5WSPLCwlSsnM4eqfbfsf/W82HsBFQzp91WyQGjS
         ZoLdikoBT16qXEdxRqItihwIeWjbDeJgc2MVcrKbZ6RVeyt/wykuBlSD2GAadxKEcNoI
         0WUKqya3tUc8LguIvu4GcYXmKVLspwO7qBXxCBpNQIxcTFIPsKxQuvXf2hIsrNakb5CP
         F6MQ==
X-Forwarded-Encrypted: i=1; AKwUvBzAYB52oaoU3W4gcasro7CdH9Yyjq/fPY7m4wF7bpMJoAAASzGge5lKOCDQVu+tRdKl4nk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEyliW3eMu+5AIcI+p6nO9mTjCxHxm7e027F/EX0cibn1FDYHW
	2SXQtvdkpljSmuodRJgyOb9nLWHPoRGUgkhe+S8SGwy1ljsDXVQ0ixMRfon3rYImdpw6YhsgrgN
	N7dHLDWgL+w==
X-Received: from dycmi12.prod.google.com ([2002:a05:693c:25cc:b0:369:51d5:e07a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8207:b0:353:812a:f43b
 with SMTP id 5a478bee46e88-369d9793b28mr290840eec.26.1792701036092; Thu, 22
 Oct 2026 13:30:36 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:30:02 -0700
In-Reply-To: <20261022203003.1779152-1-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020205859.1080743-1-irogers@google.com> <20261022203003.1779152-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022203003.1779152-11-irogers@google.com>
Subject: [PATCH v6 10/11] perf bpf-filter: Extend lock_held() to support RCU,
 Tasks Trace RCU, and SRCU
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend the lock_held(<lock>) BPF sample filter to support RCU, Tasks
Trace RCU, and SRCU locks:

- 'rcu' (supports both read/shared and write/exclusive modes):
  - Read/shared ('lock_held_read(rcu)', 'lock_held(rcu:R)',
    'lock_held(rcu_read_lock)'): directly inspects
    current->rcu_read_lock_nesting in perf_sample_filter via CO-RE (on
    CONFIG_PREEMPT_RCU kernels), accounting for the baseline
    rcu_read_lock() nesting acquired by the perf overflow handler itself
    (bpf_overflow_handler() and do_perf_sw_event()) with zero extra
    fentry/fexit tracing hooks.
  - Write/exclusive ('lock_held_write(rcu)', 'lock_held(rcu:W)'):
    attaches fentry/fexit hooks to synchronize_rcu(),
    synchronize_rcu_expedited(), synchronize_rcu_tasks(), and
    rcu_barrier() to track grace-period and barrier waits.
- 'srcu' and specific SRCU symbols (e.g. '&srcu_symbol', supports both
  read/shared and write/exclusive modes):
  - Read/shared ('lock_held_read(srcu)', 'lock_held(srcu:R)'): attaches
    fexit/__srcu_read_lock and fentry/__srcu_read_unlock.
  - Write/exclusive ('lock_held_write(srcu)', 'lock_held(srcu:W)'):
    attaches fentry/fexit on synchronize_srcu(),
    synchronize_srcu_expedited(), and srcu_barrier().
- 'rcu-trace' / 'rcu_trace' / 'rcu_read_lock_trace' (supports
  read/shared mode only): directly inspects
  current->trc_reader_nesting > 0 on CONFIG_TASKS_TRACE_RCU kernels
  with zero extra tracing hooks.

Example usage:

  # perf record -a -g -e cycles --filter 'lock_held_read(rcu)' -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.482 MB perf.data (412 samples) ]

  # perf report --stdio --no-children
  # Overhead  Command  Shared Object      Symbol
  # ........  .......  .................  ........................
  #
      14.32%  perf     [kernel.kallsyms]  [k] __d_lookup_rcu
              |
              ---__d_lookup_rcu
                 lookup_fast
                 walk_component
                 link_path_walk
                 path_lookupat
                 filename_lookup
                 vfs_statx
                 __do_sys_newstat
                 do_syscall_64
                 entry_SYSCALL_64_after_hwframe

  # perf record -a -g -e task-clock --filter 'lock_held(rcu:W)' -- sleep 1
  # perf record -a -g -e cycles --filter 'lock_held(srcu)' -- sleep 1

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt     |  44 ++--
 tools/perf/tests/parse-events.c              |  13 +
 tools/perf/tests/shell/record_bpf_filter.sh  |  20 ++
 tools/perf/util/bpf-filter.c                 | 237 ++++++++++++++++++-
 tools/perf/util/bpf_skel/lock_data.h         |  47 +++-
 tools/perf/util/bpf_skel/sample-filter.h     |  14 ++
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 136 ++++++++++-
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h   |   2 +
 tools/perf/util/lock-contention.c            |   4 +
 tools/perf/util/lock-contention.h            |   4 +-
 10 files changed, 490 insertions(+), 31 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 8fc3196ed93d..6869a465d8e3 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -225,11 +225,17 @@ OPTIONS
 	'lock_held(cgroup_mutex)'), a hexadecimal lock address, a slab cache
 	name prefixed with '&' (e.g. 'lock_held(&dentry)',
 	'lock_held_read(&dentry)'), a well-known lock name ('mmap_lock',
-	'siglock', 'rq_lock', 'zone_lock'), or a lock type ('mutex',
-	'spinlock', 'rwsem', 'rwsem:R', 'rwsem:W', 'rwlock', 'rwlock:R',
-	'rwlock:W', 'rt-mutex', 'percpu-rwsem', 'pcpu-sem:W', 'semaphore').
-	Both read/shared and write/exclusive tracking are supported for
-	'rwsem' (including 'mmap_lock') and 'rwlock'; 'mutex', 'spinlock'
+	'siglock', 'rq_lock', 'zone_lock', 'rcu', 'rcu-trace'), or a lock
+	type ('mutex', 'spinlock', 'rwsem', 'rwsem:R', 'rwsem:W', 'rwlock',
+	'rwlock:R', 'rwlock:W', 'rt-mutex', 'percpu-rwsem', 'pcpu-sem:W',
+	'srcu', 'srcu:R', 'srcu:W', 'rcu:R', 'rcu:W', 'semaphore').  Both
+	read/shared and write/exclusive tracking are supported for 'rwsem'
+	(including 'mmap_lock'), 'rwlock', 'rcu', and 'srcu' (where
+	read/shared mode matches 'rcu_read_lock()' / 'srcu_read_lock()'
+	critical sections and write/exclusive mode matches grace-period
+	waits 'synchronize_rcu*()', 'synchronize_srcu*()', 'rcu_barrier()',
+	and 'srcu_barrier()'); 'rcu-trace' ('rcu_read_lock_trace()')
+	supports read/shared tracking only; and 'mutex', 'spinlock'
 	(including 'siglock', 'rq_lock', 'zone_lock'), 'rt-mutex',
 	'semaphore', and 'percpu-rwsem' ('percpu_down_write()') support
 	write/exclusive tracking only.  Note that 'semaphore' tracking
@@ -251,19 +257,21 @@ OPTIONS
 	      --filter 'lock_held(mutex) || lock_held(rwsem)'
 
 	When filtering on a specific mutex symbol ('*_mutex'), rt-mutex symbol
-	('*_rt_mutex'), or write-locked 'mmap_lock' ('lock_held_write(mmap_lock)'
-	or 'lock_held(mmap_lock:W)'), 'perf_sample_filter' inspects the lock's
-	'owner' field directly in kernel memory on each sample without attaching
-	any BPF fentry/fexit hooks.  For locks that do not maintain an
-	authoritative per-task owner pointer (such as spinlocks, rwlocks,
-	semaphores, reader-locked rwsems, and slab/type filters), it attaches
-	BPF fentry/fexit programs to kernel lock acquire and release functions
-	to track held locks in a BPF map.  These BPF hooks run on every kernel
-	lock acquisition and release for the attached lock family, even when no
-	perf sample is being taken.  To minimize this overhead, only the hooks
-	for the relevant lock family and mode are attached when known (for
-	example, 'lock_held_read(mmap_lock)' only hooks rwsem read functions
-	and 'rq_lock' only hooks spinlock functions), whereas slab filters
+	('*_rt_mutex'), write-locked 'mmap_lock' ('lock_held_write(mmap_lock)'
+	or 'lock_held(mmap_lock:W)'), or 'rcu:R' / 'rcu-trace' (which inspect
+	'current->rcu_read_lock_nesting' / 'current->trc_reader_nesting'),
+	'perf_sample_filter' inspects the kernel fields directly on each sample
+	without attaching any BPF fentry/fexit hooks.  For locks that do not
+	maintain an authoritative per-task owner pointer (such as spinlocks,
+	rwlocks, semaphores, reader-locked rwsems, SRCU locks, RCU synchronize
+	waits, and slab/type filters), it attaches BPF fentry/fexit programs to
+	kernel lock acquire and release functions to track held locks in a BPF
+	map.  These BPF hooks run on every kernel lock acquisition and release
+	for the attached lock family, even when no perf sample is being taken.
+	To minimize this overhead, only the hooks for the relevant lock family
+	and mode are attached when known (for example, 'lock_held_read(mmap_lock)'
+	only hooks rwsem read functions, 'srcu' only hooks SRCU functions, and
+	'rq_lock' only hooks spinlock functions), whereas slab filters
 	('&<slab>'), raw hex addresses, or symbols without a recognizable
 	lock-type suffix attach hooks across all lock families (including
 	high-frequency spinlocks).
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 4cf9192762f2..730466b7ebf6 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2980,6 +2980,19 @@ static int do_test_bpf_filters(struct list_head *expr_head)
 			expr->lock_name && !strcmp(expr->lock_name, "cgroup_mutex"));
 	clear_bpf_filter_exprs(expr_head);
 
+	/* RCU and SRCU lock_held(rcu) || lock_held(srcu) */
+	TEST_ASSERT_VAL("parse lock_held(rcu)",
+			__perf_bpf_filter__parse(expr_head, "lock_held(rcu)") == 0);
+	TEST_ASSERT_VAL("not empty", !list_empty(expr_head));
+	expr = list_first_entry(expr_head, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("term is PBF_TERM_LOCK_HELD", expr->term == PBF_TERM_LOCK_HELD);
+	TEST_ASSERT_VAL("part is PBF_LOCK_MODE_ANY", expr->part == PBF_LOCK_MODE_ANY);
+	TEST_ASSERT_VAL("op is PBF_OP_EQ", expr->op == PBF_OP_EQ);
+	TEST_ASSERT_VAL("val is 1", expr->val == 1);
+	TEST_ASSERT_VAL("lock_name is rcu",
+			expr->lock_name && !strcmp(expr->lock_name, "rcu"));
+	clear_bpf_filter_exprs(expr_head);
+
 	/* Read/shared and write/exclusive predicates */
 	TEST_ASSERT_VAL("parse lock_held_read(&mmap_lock)",
 			__perf_bpf_filter__parse(expr_head, "lock_held_read(&mmap_lock)") == 0);
diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tests/shell/record_bpf_filter.sh
index ebaf8ee41622..47f697f53a85 100755
--- a/tools/perf/tests/shell/record_bpf_filter.sh
+++ b/tools/perf/tests/shell/record_bpf_filter.sh
@@ -247,6 +247,26 @@ test_bpf_filter_lock_held() {
     return
   fi
 
+  if ! perf record -e task-clock --filter 'lock_held_write(rcu) || lock_held(srcu)' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed rcu:W/srcu]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock --filter 'lock_held_read(rcu)' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    if ! perf record -e task-clock --filter 'lock_held_read(rcu)' \
+         -o /dev/null true 2>&1 | grep -q CONFIG_PREEMPT_RCU
+    then
+      echo "Lock-held bpf-filter test [Failed lock_held_read(rcu)]"
+      err=1
+      return
+    fi
+  fi
+
   if ! perf record -e task-clock \
        --filter 'lock_held_read(mmap_lock) || lock_held_write(mmap_lock)' \
        -o "${perfdata}" true 2> /dev/null
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 1a75d779e891..0161ba1f4769 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -200,11 +200,19 @@ enum lock_prog_group {
 	LOCK_PROG_RTMUTEX       = 1U << 6,
 	LOCK_PROG_SEM           = 1U << 7,
 	LOCK_PROG_PERCPU_RWSEM  = 1U << 8,
-	LOCK_PROG_ALL           = 0x1ffU & ~LOCK_PROG_SEM,
+	LOCK_PROG_SRCU_READ     = 1U << 9,
+	LOCK_PROG_SRCU_WRITE    = 1U << 10,
+	LOCK_PROG_SRCU          = LOCK_PROG_SRCU_READ | LOCK_PROG_SRCU_WRITE,
+	LOCK_PROG_RCU_WRITE     = 1U << 11,
+	LOCK_PROG_ALL           = 0xfffU & ~LOCK_PROG_SEM,
 };
 
 static unsigned int lock_flags_to_prog_group(unsigned int flags)
 {
+	if (flags & LCB_F_RCU)
+		return (flags & LCB_F_WRITE) ? LOCK_PROG_RCU_WRITE : 0;
+	if (flags & LCB_F_SRCU)
+		return (flags & LCB_F_READ) ? LOCK_PROG_SRCU_READ : LOCK_PROG_SRCU_WRITE;
 	if (flags & LCB_F_MUTEX)
 		return LOCK_PROG_MUTEX;
 	if (flags & LCB_F_RT)
@@ -324,6 +332,32 @@ static const struct lock_prog_desc lock_progs[] = {
 	/* Percpu-RWsem */
 	LOCK_FPROG(fexit_percpu_down_write, "percpu_down_write", LOCK_PROG_PERCPU_RWSEM),
 	LOCK_FPROG(fentry_percpu_up_write, "percpu_up_write", LOCK_PROG_PERCPU_RWSEM),
+	/* SRCU */
+	LOCK_FPROG(fexit_srcu_read_lock, "__srcu_read_lock", LOCK_PROG_SRCU_READ),
+	LOCK_FPROG(fentry_srcu_read_unlock, "__srcu_read_unlock", LOCK_PROG_SRCU_READ),
+	LOCK_FPROG(fexit_srcu_read_lock_nmisafe, "__srcu_read_lock_nmisafe",
+		   LOCK_PROG_SRCU_READ),
+	LOCK_FPROG(fentry_srcu_read_unlock_nmisafe, "__srcu_read_unlock_nmisafe",
+		   LOCK_PROG_SRCU_READ),
+	LOCK_FPROG(fentry_synchronize_srcu, "synchronize_srcu", LOCK_PROG_SRCU_WRITE),
+	LOCK_FPROG(fexit_synchronize_srcu, "synchronize_srcu", LOCK_PROG_SRCU_WRITE),
+	LOCK_FPROG(fentry_synchronize_srcu_expedited, "synchronize_srcu_expedited",
+		   LOCK_PROG_SRCU_WRITE),
+	LOCK_FPROG(fexit_synchronize_srcu_expedited, "synchronize_srcu_expedited",
+		   LOCK_PROG_SRCU_WRITE),
+	LOCK_FPROG(fentry_srcu_barrier, "srcu_barrier", LOCK_PROG_SRCU_WRITE),
+	LOCK_FPROG(fexit_srcu_barrier, "srcu_barrier", LOCK_PROG_SRCU_WRITE),
+	/* RCU grace-period synchronize / barrier */
+	LOCK_FPROG(fentry_synchronize_rcu, "synchronize_rcu", LOCK_PROG_RCU_WRITE),
+	LOCK_FPROG(fexit_synchronize_rcu, "synchronize_rcu", LOCK_PROG_RCU_WRITE),
+	LOCK_FPROG(fentry_synchronize_rcu_expedited, "synchronize_rcu_expedited",
+		   LOCK_PROG_RCU_WRITE),
+	LOCK_FPROG(fexit_synchronize_rcu_expedited, "synchronize_rcu_expedited",
+		   LOCK_PROG_RCU_WRITE),
+	LOCK_FPROG(fentry_synchronize_rcu_tasks, "synchronize_rcu_tasks", LOCK_PROG_RCU_WRITE),
+	LOCK_FPROG(fexit_synchronize_rcu_tasks, "synchronize_rcu_tasks", LOCK_PROG_RCU_WRITE),
+	LOCK_FPROG(fentry_rcu_barrier, "rcu_barrier", LOCK_PROG_RCU_WRITE),
+	LOCK_FPROG(fexit_rcu_barrier, "rcu_barrier", LOCK_PROG_RCU_WRITE),
 };
 
 #undef LOCK_FPROG
@@ -642,6 +676,18 @@ static unsigned int supported_lock_prog_groups(struct btf *btf)
 	if (btf_has_func(btf, "percpu_down_write") && btf_has_func(btf, "percpu_up_write"))
 		supported |= LOCK_PROG_PERCPU_RWSEM;
 
+	if ((btf_has_func(btf, "__srcu_read_lock") ||
+	     btf_has_func(btf, "__srcu_read_lock_nmisafe")) &&
+	    (btf_has_func(btf, "__srcu_read_unlock") ||
+	     btf_has_func(btf, "__srcu_read_unlock_nmisafe")))
+		supported |= LOCK_PROG_SRCU_READ;
+
+	if (btf_has_func(btf, "synchronize_srcu"))
+		supported |= LOCK_PROG_SRCU_WRITE;
+
+	if (btf_has_func(btf, "synchronize_rcu"))
+		supported |= LOCK_PROG_RCU_WRITE;
+
 	return supported;
 }
 
@@ -759,6 +805,19 @@ static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
 		*needs_lock_syms = true;
 		return;
 	}
+	if (!strcmp(base, "rcu")) {
+		if (mode & PBF_LOCK_MODE_WRITE) {
+			*prog_groups |= LOCK_PROG_RCU_WRITE;
+			*required_groups |= LOCK_PROG_RCU_WRITE;
+		}
+		return;
+	}
+	if (!strcmp(base, "rcu_read_lock") ||
+	    !strcmp(base, "rcu-trace") || !strcmp(base, "rcu_trace") ||
+	    !strcmp(base, "rcu_read_lock_trace")) {
+		/* Inspected directly on task_struct; no tracing hooks needed. */
+		return;
+	}
 	if (parse_lock_type_name(base, mode, NULL, NULL, &groups)) {
 		*prog_groups |= groups;
 		*required_groups |= groups;
@@ -800,6 +859,13 @@ static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
 			groups |= LOCK_PROG_RWLOCK_WRITE;
 		*prog_groups |= groups;
 		*required_groups |= groups;
+	} else if (str_ends_with(base, "srcu")) {
+		if (mode & PBF_LOCK_MODE_READ)
+			groups |= LOCK_PROG_SRCU_READ;
+		if (mode & PBF_LOCK_MODE_WRITE)
+			groups |= LOCK_PROG_SRCU_WRITE;
+		*prog_groups |= groups;
+		*required_groups |= groups;
 	} else {
 		*prog_groups |= LOCK_PROG_ALL;
 	}
@@ -963,6 +1029,108 @@ static bool is_percpu_rwsem_sym(struct btf *btf, const char *name)
 	return btf__find_by_name_kind(btf, rc_name, BTF_KIND_VAR) > 0;
 }
 
+static u64 rcu_min_depth(struct evsel *evsel)
+{
+	/*
+	 * Non-sleepable BPF sample filter programs always run under at least
+	 * one kernel rcu_read_lock():
+	 * - PERF_TYPE_PERF_EVENT: bpf_overflow_handler() takes rcu_read_lock()
+	 *   (and perf_swevent_event() takes an outer rcu_read_lock() for
+	 *   non-timer PERF_TYPE_SOFTWARE events, giving depth 2).
+	 * - Standard tracepoints: trace_call_bpf() takes rcu_read_lock().
+	 * - Faultable syscall tracepoints: trace_call_bpf_faultable() invokes
+	 *   bpf_prog_run_array_sleepable(), which takes guard(rcu)() for
+	 *   non-sleepable programs (!prog->sleepable) such as
+	 *   perf_sample_filter_tp.
+	 */
+	if (evsel && evsel->core.attr.type == PERF_TYPE_SOFTWARE &&
+	    evsel->core.attr.config != PERF_COUNT_SW_CPU_CLOCK &&
+	    evsel->core.attr.config != PERF_COUNT_SW_TASK_CLOCK)
+		return 2;
+	return 1;
+}
+
+static u64 rcu_trace_min_depth(struct evsel *evsel, struct btf *btf)
+{
+	const char *ev_name;
+
+	/*
+	 * Only PERF_TYPE_PERF_EVENT and PERF_TYPE_TRACEPOINT events can attach
+	 * sample_filter.bpf.c (kprobes and uprobes require BPF_PROG_TYPE_KPROBE
+	 * in __perf_event_set_bpf_prog()).
+	 *
+	 * For syscall tracepoints:
+	 * - raw_syscalls:sys_enter and raw_syscalls:sys_exit are defined with
+	 *   TRACE_EVENT_SYSCALL(), whose __do_trace_sys_enter/exit wrapper
+	 *   takes guard(rcu_tasks_trace)() (depth 1) before perf_trace_buf
+	 *   submission calls trace_call_bpf().
+	 * - syscalls:sys_enter_* and syscalls:sys_exit_* register
+	 *   perf_syscall_enter/exit on the raw sys_enter/sys_exit tracepoints
+	 *   (1st guard(rcu_tasks_trace)()) and, on kernels with
+	 *   trace_call_bpf_faultable(), acquire a 2nd guard(rcu_tasks_trace)()
+	 *   in trace_call_bpf_faultable() (depth 2).
+	 */
+	if (evsel && evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
+		ev_name = evsel__name(evsel);
+		if (!ev_name)
+			return 0;
+		if (strstarts(ev_name, "raw_syscalls:"))
+			return 1;
+		if (strstarts(ev_name, "syscalls:")) {
+			if (!btf ||
+			    btf__find_by_name_kind(btf, "trace_call_bpf_faultable",
+						   BTF_KIND_FUNC) > 0)
+				return 2;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static bool btf_struct_has_field(const struct btf *btf, s32 type_id,
+				 const char *field_name)
+{
+	const struct btf_type *t;
+	const struct btf_member *m;
+	u16 i, vlen;
+
+	type_id = btf__resolve_type(btf, type_id);
+	if (type_id < 0)
+		return false;
+
+	t = btf__type_by_id(btf, type_id);
+	if (!t || (!btf_is_struct(t) && !btf_is_union(t)))
+		return false;
+
+	m = btf_members(t);
+	vlen = btf_vlen(t);
+	for (i = 0; i < vlen; i++, m++) {
+		const char *name = btf__name_by_offset(btf, m->name_off);
+
+		if (name && *name) {
+			if (!strcmp(name, field_name))
+				return true;
+		} else if (btf_struct_has_field(btf, m->type, field_name)) {
+			return true;
+		}
+	}
+	return false;
+}
+
+static bool btf_has_task_field(struct btf *btf, const char *field_name)
+{
+	s32 id;
+
+	if (!btf)
+		return false;
+
+	id = btf__find_by_name_kind(btf, "task_struct", BTF_KIND_STRUCT);
+	if (id < 0)
+		return false;
+
+	return btf_struct_has_field(btf, id, field_name);
+}
+
 /*
  * Resolve a `lock_held(<name>)` filter expression into `entry->op`,
  * `entry->part` (`enum perf_bpf_lock_target_kind`), and `entry->value`,
@@ -970,15 +1138,15 @@ static bool is_percpu_rwsem_sym(struct btf *btf, const char *name)
  *
  * Resolution order:
  * 1. Slab cache name (when prefixed with '&', e.g. `&dentry`).
- * 2. Well-known per-process / semi-global locks: `mmap_lock`, `siglock`,
- *    `rq_lock`, `zone_lock`.
+ * 2. Well-known per-process / semi-global / RCU locks: `mmap_lock`, `siglock`,
+ *    `rq_lock`, `zone_lock`, `rcu`, `rcu-trace`.
  * 3. Lock types / flags: `mutex`, `spinlock`, `rwsem`, `rwsem:R`, `rwsem:W`,
- *    `rwlock`, `percpu-rwsem`, `semaphore`, etc.
+ *    `rwlock`, `percpu-rwsem`, `srcu`, `semaphore`, etc.
  * 4. Hexadecimal lock address.
  * 5. Global/static kernel lock symbol in kallsyms (e.g. `cgroup_mutex`).
  */
-static int resolve_lock_expr(struct sample_filter_bpf *skel, struct btf *btf,
-			     struct perf_bpf_filter_expr *expr,
+static int resolve_lock_expr(struct evsel *evsel, struct sample_filter_bpf *skel,
+			     struct btf *btf, struct perf_bpf_filter_expr *expr,
 			     struct perf_bpf_filter_entry *entry)
 {
 	const char *name = expr->lock_name;
@@ -1060,6 +1228,48 @@ static int resolve_lock_expr(struct sample_filter_bpf *skel, struct btf *btf,
 		return 0;
 	}
 
+	if (!strcmp(base, "rcu_read_lock")) {
+		if (mode == PBF_LOCK_MODE_WRITE) {
+			pr_err("Error: Lock '%s' only supports read/shared mode\n", name);
+			return -EINVAL;
+		}
+		if (btf && !btf_has_task_field(btf, "rcu_read_lock_nesting")) {
+			pr_err("Error: lock_held(rcu) requires CONFIG_PREEMPT_RCU\n");
+			return -EOPNOTSUPP;
+		}
+		entry->part = PBF_LOCK_RCU | PBF_LOCK_MODE_READ;
+		entry->value = rcu_min_depth(evsel);
+		return 0;
+	}
+
+	if (!strcmp(base, "rcu")) {
+		if ((mode & PBF_LOCK_MODE_READ) && btf &&
+		    !btf_has_task_field(btf, "rcu_read_lock_nesting")) {
+			pr_err("Error: lock_held(rcu) requires CONFIG_PREEMPT_RCU\n");
+			return -EOPNOTSUPP;
+		}
+		entry->part = PBF_LOCK_RCU | mode;
+		entry->value = rcu_min_depth(evsel);
+		if ((mode & PBF_LOCK_MODE_WRITE) && skel)
+			skel->bss->has_rcu_lock = 1;
+		return 0;
+	}
+
+	if (!strcmp(base, "rcu-trace") || !strcmp(base, "rcu_trace") ||
+	    !strcmp(base, "rcu_read_lock_trace")) {
+		if (!(mode & PBF_LOCK_MODE_READ) || mode == PBF_LOCK_MODE_WRITE) {
+			pr_err("Error: Lock '%s' only supports read/shared mode\n", name);
+			return -EINVAL;
+		}
+		if (btf && !btf_has_task_field(btf, "trc_reader_nesting")) {
+			pr_err("Error: lock_held(rcu-trace) requires CONFIG_TASKS_TRACE_RCU\n");
+			return -EOPNOTSUPP;
+		}
+		entry->part = PBF_LOCK_RCU_TRACE | PBF_LOCK_MODE_READ;
+		entry->value = rcu_trace_min_depth(evsel, btf);
+		return 0;
+	}
+
 	if (parse_lock_type_name(base, mode, skel, &encoded_pair, NULL)) {
 		entry->part = PBF_LOCK_TYPE | mode;
 		entry->value = encoded_pair;
@@ -1149,7 +1359,7 @@ static int get_filter_entries(struct evsel *evsel, struct sample_filter_bpf *ske
 		entry[i].term = expr->term;
 		entry[i].value = expr->val;
 		if (expr->term == PBF_TERM_LOCK_HELD) {
-			ret = resolve_lock_expr(skel, btf, expr, &entry[i]);
+			ret = resolve_lock_expr(evsel, skel, btf, expr, &entry[i]);
 			if (ret < 0)
 				return ret;
 		}
@@ -1167,7 +1377,7 @@ static int get_filter_entries(struct evsel *evsel, struct sample_filter_bpf *ske
 				entry[i].term = group->term;
 				entry[i].value = group->val;
 				if (group->term == PBF_TERM_LOCK_HELD) {
-					ret = resolve_lock_expr(skel, btf, group, &entry[i]);
+					ret = resolve_lock_expr(evsel, skel, btf, group, &entry[i]);
 					if (ret < 0)
 						return ret;
 				}
@@ -1496,6 +1706,17 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 			bpf_map__set_max_entries(skel->maps.lock_syms, MAX_ENTRIES);
 			init_numa_data(skel, btf);
 		}
+		if (prog_groups & LOCK_PROG_RCU_WRITE) {
+			u64 rcu_addr = 1ULL;
+
+			/*
+			 * Offset by 1 byte so rcu_state_addr is distinct from
+			 * &rcu_state.node[0].lock at offset 0 of rcu_state.
+			 */
+			if (find_kernel_lock_sym("rcu_state", &rcu_addr) == 0)
+				rcu_addr += 1;
+			skel->rodata->rcu_state_addr = rcu_addr;
+		}
 		ret = configure_lock_progs(skel, btf, prog_groups, required_groups,
 					   needs_lock_syms, needs_slab_iter,
 					   is_tracepoint);
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index 43d8f5030bc1..f3f8076fdd0b 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -39,6 +39,7 @@ struct contention_task_data {
  */
 #define LCD_F_MMAP_LOCK		(1U << 31)
 #define LCD_F_SIGHAND_LOCK	(1U << 30)
+#define LCD_F_RCU_LOCK		(1U << 29)
 
 #define LCB_F_SLAB_ID_SHIFT	16
 #define LCB_F_SLAB_ID_START	(1U << 16)
@@ -52,9 +53,11 @@ struct contention_task_data {
 #define LCB_F_RT	(1U << 3)
 #define LCB_F_PERCPU	(1U << 4)
 #define LCB_F_MUTEX	(1U << 5)
+#define LCB_F_SRCU	(1U << 6)
+#define LCB_F_RCU	(1U << 7)
 
-#define LCB_F_TYPE_MAX		(1U << 7)
-#define LCB_F_TYPE_MASK		0x0000007FU
+#define LCB_F_TYPE_MAX		(1U << 8)
+#define LCB_F_TYPE_MASK		0x000000FFU
 
 #define SLAB_NAME_MAX  28
 
@@ -264,6 +267,43 @@ static __always_inline __u64 get_current_siglock(__u64 curr)
 	return sh + bpf_core_field_offset(sighand->siglock);
 }
 
+/*
+ * Check if `curr` is inside a preemptible RCU read-side critical section
+ * (`rcu_read_lock()`).
+ *
+ * Because `bpf_overflow_handler()` in `kernel/events/core.c` acquires
+ * `rcu_read_lock()` before invoking `perf_sample_filter` (and
+ * `do_perf_sw_event()` acquires an additional `rcu_read_lock()` for
+ * non-clock software events), `min_depth` is the baseline nesting count
+ * contributed by the perf event overflow handler itself (1 or 2).
+ */
+static __always_inline bool is_rcu_lock_held(__u64 curr, int min_depth)
+{
+	struct task_struct *task = (void *)curr;
+
+	if (!curr || !bpf_core_field_exists(task->rcu_read_lock_nesting))
+		return false;
+
+	return BPF_CORE_READ(task, rcu_read_lock_nesting) > min_depth;
+}
+
+/*
+ * Check if `curr` is inside a Tasks Trace RCU read-side critical section
+ * (`rcu_read_lock_trace()`). `min_depth` accounts for any baseline nesting
+ * contributed by the kernel tracing wrapper itself (2 on faultable
+ * `syscalls:*` tracepoints via `__DECLARE_TRACE_SYSCALL` and
+ * `trace_call_bpf_faultable()`, 1 on `raw_syscalls:*`, 0 otherwise).
+ */
+static __always_inline bool is_rcu_trace_lock_held(__u64 curr, int min_depth)
+{
+	struct task_struct *task = (void *)curr;
+
+	if (!curr || !bpf_core_field_exists(task->trc_reader_nesting))
+		return false;
+
+	return BPF_CORE_READ(task, trc_reader_nesting) > min_depth;
+}
+
 /*
  * Read the 1st function argument (`lock` / `sem` / `ssp`) as a 64-bit scalar.
  *
@@ -296,6 +336,9 @@ static __always_inline __u32 check_lock_type(__u64 lock, __u32 flags)
 		if (get_current_siglock(curr) == lock)
 			return LCD_F_SIGHAND_LOCK;
 		break;
+	case LCB_F_RCU:
+	case LCB_F_RCU | LCB_F_WRITE:
+		return LCD_F_RCU_LOCK;
 	default:
 		break;
 	}
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index a65ee780d64d..7abc530ed50d 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -101,6 +101,20 @@ enum perf_bpf_lock_target_kind {
 	 * low two bytes: `flag1 | (flag2 << 8)` (with 0xff indicating unused).
 	 */
 	PBF_LOCK_TYPE,
+	/*
+	 * Preemptible RCU read-side lock (`rcu` / `rcu_read_lock`).
+	 * Inspected directly via `current->rcu_read_lock_nesting > entry.value`,
+	 * where `entry.value` is the baseline RCU nesting depth added by the
+	 * kernel perf overflow path.
+	 */
+	PBF_LOCK_RCU,
+	/*
+	 * Tasks Trace RCU read-side lock (`rcu-trace` / `rcu_read_lock_trace`).
+	 * Inspected directly via `current->trc_reader_nesting > entry.value`,
+	 * where `entry.value` is the baseline nesting depth added by the
+	 * kernel event tracing path.
+	 */
+	PBF_LOCK_RCU_TRACE,
 };
 
 /*
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index d1192a93179e..60fe4c3a99a2 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -129,6 +129,7 @@ volatile const int use_idx_hash;
 
 const volatile __u64 contig_page_data_addr;
 const volatile __u64 node_data_addr;
+const volatile __u64 rcu_state_addr;
 const volatile int nr_nodes;
 const volatile int sizeof_zone;
 
@@ -142,6 +143,7 @@ int has_lock_class;
 int has_lock_type;
 int has_mmap_lock;
 int has_siglock;
+int has_rcu_lock;
 int track_rwsem_read;
 __u8 lock_type_filter[LCB_F_TYPE_MAX];
 
@@ -282,6 +284,21 @@ static __always_inline bool is_lock_held(struct perf_bpf_filter_entry *entry)
 	case PBF_LOCK_TYPE:
 		return is_lock_type_in_map(entry->value, mode, pid, cpu_id) != 0;
 
+	case PBF_LOCK_RCU:
+		if ((mode & PBF_LOCK_MODE_READ) &&
+		    is_rcu_lock_held(curr, (int)entry->value))
+			return true;
+		if ((mode & PBF_LOCK_MODE_WRITE) && rcu_state_addr &&
+		    is_lock_in_map(rcu_state_addr, PBF_LOCK_ADDR, PBF_LOCK_MODE_WRITE, pid, cpu_id))
+			return true;
+		return false;
+
+	case PBF_LOCK_RCU_TRACE:
+		if ((mode & PBF_LOCK_MODE_READ) &&
+		    is_rcu_trace_lock_held(curr, (int)entry->value))
+			return true;
+		return false;
+
 	default:
 		return false;
 	}
@@ -727,11 +744,12 @@ static __always_inline int record_lock_acquired_owner(__u64 lock_addr, __u32 fla
 	if (has_lock_addr && bpf_map_lookup_elem(&lock_addr_filter, &lock_addr))
 		matched = true;
 
-	if (has_mmap_lock || has_siglock) {
+	if (has_mmap_lock || has_siglock || has_rcu_lock) {
 		__u32 ltype = check_lock_type(lock_addr, type_flag);
 
 		if ((has_mmap_lock && ltype == LCD_F_MMAP_LOCK) ||
-		    (has_siglock && ltype == LCD_F_SIGHAND_LOCK))
+		    (has_siglock && ltype == LCD_F_SIGHAND_LOCK) ||
+		    (has_rcu_lock && ltype == LCD_F_RCU_LOCK))
 			matched = true;
 	}
 
@@ -1391,6 +1409,120 @@ int BPF_PROG(fentry_percpu_up_write, void *sem)
 	return record_lock_released(ctx, LCB_F_PERCPU | LCB_F_WRITE);
 }
 
+/* SRCU acquire/release and synchronize hooks */
+SEC("fexit/__srcu_read_lock")
+int BPF_PROG(fexit_srcu_read_lock, void *ssp, int ret)
+{
+	return record_lock_acquired(ctx, LCB_F_SRCU | LCB_F_READ);
+}
+
+SEC("fentry/__srcu_read_unlock")
+int BPF_PROG(fentry_srcu_read_unlock, void *ssp)
+{
+	return record_lock_released(ctx, LCB_F_SRCU | LCB_F_READ);
+}
+
+SEC("fexit/__srcu_read_lock_nmisafe")
+int BPF_PROG(fexit_srcu_read_lock_nmisafe, void *ssp, int ret)
+{
+	return record_lock_acquired(ctx, LCB_F_SRCU | LCB_F_READ);
+}
+
+SEC("fentry/__srcu_read_unlock_nmisafe")
+int BPF_PROG(fentry_srcu_read_unlock_nmisafe, void *ssp)
+{
+	return record_lock_released(ctx, LCB_F_SRCU | LCB_F_READ);
+}
+
+SEC("fentry/synchronize_srcu")
+int BPF_PROG(fentry_synchronize_srcu, void *ssp)
+{
+	return record_lock_acquired(ctx, LCB_F_SRCU | LCB_F_WRITE);
+}
+
+SEC("fexit/synchronize_srcu")
+int BPF_PROG(fexit_synchronize_srcu, void *ssp)
+{
+	return record_lock_released(ctx, LCB_F_SRCU | LCB_F_WRITE);
+}
+
+SEC("fentry/synchronize_srcu_expedited")
+int BPF_PROG(fentry_synchronize_srcu_expedited, void *ssp)
+{
+	return record_lock_acquired(ctx, LCB_F_SRCU | LCB_F_WRITE);
+}
+
+SEC("fexit/synchronize_srcu_expedited")
+int BPF_PROG(fexit_synchronize_srcu_expedited, void *ssp)
+{
+	return record_lock_released(ctx, LCB_F_SRCU | LCB_F_WRITE);
+}
+
+SEC("fentry/srcu_barrier")
+int BPF_PROG(fentry_srcu_barrier, void *ssp)
+{
+	return record_lock_acquired(ctx, LCB_F_SRCU | LCB_F_WRITE);
+}
+
+SEC("fexit/srcu_barrier")
+int BPF_PROG(fexit_srcu_barrier, void *ssp)
+{
+	return record_lock_released(ctx, LCB_F_SRCU | LCB_F_WRITE);
+}
+
+/* RCU grace-period synchronize / barrier hooks */
+SEC("fentry/synchronize_rcu")
+int BPF_PROG(fentry_synchronize_rcu)
+{
+	return record_lock_acquired_owner(rcu_state_addr, LCB_F_RCU | LCB_F_WRITE,
+					  get_lock_owner_id(LCB_F_RCU | LCB_F_WRITE));
+}
+
+SEC("fexit/synchronize_rcu")
+int BPF_PROG(fexit_synchronize_rcu)
+{
+	return record_lock_released_addr(rcu_state_addr, LCB_F_RCU | LCB_F_WRITE);
+}
+
+SEC("fentry/synchronize_rcu_expedited")
+int BPF_PROG(fentry_synchronize_rcu_expedited)
+{
+	return record_lock_acquired_owner(rcu_state_addr, LCB_F_RCU | LCB_F_WRITE,
+					  get_lock_owner_id(LCB_F_RCU | LCB_F_WRITE));
+}
+
+SEC("fexit/synchronize_rcu_expedited")
+int BPF_PROG(fexit_synchronize_rcu_expedited)
+{
+	return record_lock_released_addr(rcu_state_addr, LCB_F_RCU | LCB_F_WRITE);
+}
+
+SEC("fentry/synchronize_rcu_tasks")
+int BPF_PROG(fentry_synchronize_rcu_tasks)
+{
+	return record_lock_acquired_owner(rcu_state_addr, LCB_F_RCU | LCB_F_WRITE,
+					  get_lock_owner_id(LCB_F_RCU | LCB_F_WRITE));
+}
+
+SEC("fexit/synchronize_rcu_tasks")
+int BPF_PROG(fexit_synchronize_rcu_tasks)
+{
+	return record_lock_released_addr(rcu_state_addr, LCB_F_RCU | LCB_F_WRITE);
+}
+
+SEC("fentry/rcu_barrier")
+int BPF_PROG(fentry_rcu_barrier)
+{
+	return record_lock_acquired_owner(rcu_state_addr, LCB_F_RCU | LCB_F_WRITE,
+					  get_lock_owner_id(LCB_F_RCU | LCB_F_WRITE));
+}
+
+SEC("fexit/rcu_barrier")
+int BPF_PROG(fexit_rcu_barrier)
+{
+	return record_lock_released_addr(rcu_state_addr, LCB_F_RCU | LCB_F_WRITE);
+}
+
 SEC("raw_tp/bpf_test_finish")
 int BPF_PROG(collect_lock_syms)
 {
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index b75ddc6846bb..1fb91a829d54 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -119,6 +119,8 @@ struct task_struct {
 	struct signal_struct  *signal;
 	struct sighand_struct *sighand;
 	struct css_set	      *cgroups;
+	int		      rcu_read_lock_nesting;
+	int		      trc_reader_nesting;
 } __attribute__((preserve_access_index));
 
 struct trace_entry {
diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-contention.c
index f6e68d740860..37415f7b7f2c 100644
--- a/tools/perf/util/lock-contention.c
+++ b/tools/perf/util/lock-contention.c
@@ -39,6 +39,10 @@ const struct perf_lock_type lock_type_table[] = {
 	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
 	/* alias for optimistic spinning only */
 	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex:spin",	"mutex-spin" },
+	{ LCB_F_SRCU | LCB_F_READ,	"srcu:R",	"srcu" },
+	{ LCB_F_SRCU | LCB_F_WRITE,	"srcu:W",	"srcu" },
+	{ LCB_F_RCU | LCB_F_READ,	"rcu:R",	"rcu" },
+	{ LCB_F_RCU | LCB_F_WRITE,	"rcu:W",	"rcu" },
 };
 
 int parse_call_stack(const struct option *opt __maybe_unused, const char *str,
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 68e9bd77e8a9..88b2c11244ad 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -128,6 +128,8 @@ struct thread_stat {
 #define LCB_F_RT	(1U << 3)
 #define LCB_F_PERCPU	(1U << 4)
 #define LCB_F_MUTEX	(1U << 5)
+#define LCB_F_SRCU	(1U << 6)
+#define LCB_F_RCU	(1U << 7)
 
 struct perf_lock_type {
 	unsigned int flags;
@@ -140,7 +142,7 @@ struct perf_lock_type {
 	const char *lock_name;
 };
 
-extern const struct perf_lock_type lock_type_table[14];
+extern const struct perf_lock_type lock_type_table[18];
 
 struct evlist;
 struct machine;
-- 
2.56.0.307.g5fe7bd680c-goog

