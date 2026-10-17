Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E3F3C13E0
	for <rcu@vger.kernel.org>; Sat, 17 Oct 2026 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257303; cv=none; b=nq78MGru61t+NpEeYTILKRiFBej8hTRprGlt7bWREIbQYnaJe5TkFFUNhhxP4tFoWIr9euxSjeye9HxBreQu3Qftwm5NK2glRhPJ64K/Jc64uYW+zf1lQDWadG8dM+q4K983vnQEgstXj1bmNBwFbWGmwGAEfZpRGuPNdD8wLjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257303; c=relaxed/simple;
	bh=ekEcZdyRDrHduwFfh+Ji1evqG0q0eRElBh4u2QDEZWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QBHh1UWFGMDKr9e8tyvQDOMOaE6Tqd4h2WKuZ3Rx4xJMdCL191aGzmI7ctBnEeh5Pn1WPv+mQoN3vDFsDO56XIq3crSsv8kLBh1GYrhtnoQrxooQTeQopRRwZtGoLsGEx+FLcoU/QC55AwgsZOL86gippoVLuCyOz9uA1WzBbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQdu/OVA; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQdu/OVA"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so1622343eec.1
        for <rcu@vger.kernel.org>; Sat, 17 Oct 2026 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792257298; x=1792862098; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hjag6Ne3b2KV88t5yRhqB9YJxb/UctyL/lFn3H5GNuA=;
        b=pQdu/OVABF/FoUjic1wd30grTLjRQ9m2EdbWlrK4u8X4V5lNYgCKS1cBFz3MyzXymU
         uGBaqYc2peo1gU1qJNcdNT8B5N1hpPOfQiDBjmdR0SwFdCFVXJqls9G3zRO3hRwz234k
         /hG3jKIkfSWE+ldS4Lwi8XPcg8jPmaoVw/HHMfqXnblux6gUGLIGoBn+gsJ+t69kU/ti
         zICNgoGEvPbiTc5/AvQVUOttfx96LzQu2mKpCnEIiPH0F1+fVTY9oBnv4QzvhXoM/14p
         wbJZWgsUzH8D22QyKUnWZxNhhEgVi/BCb03e1FYBqxT3b1SF6eD01kSU7XEaqX9X6vnd
         Kpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792257298; x=1792862098;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hjag6Ne3b2KV88t5yRhqB9YJxb/UctyL/lFn3H5GNuA=;
        b=hO9BeCDsgGH+haT0/4gMLtpZH2Fj14RTTokCnKsJTV2M8qS2V7XFAfA1sL+Evg6Swd
         kJjzqSoLdGhQSkLERn+mv9a1Z4vGZbpqAzp3KK0b11Ye+ljA+x4p0I9lwFJg7BK1DhQT
         7EQutfWmprI6xVU8+zwcy9D/QoyeJs30r6an/PR/8vbBcWInEPTqvz0q4XFkOMC3YiuF
         uaPhsLwLWlswTEeJ2evuMhKVL+/a3eEFzk3hLzGVl9F/rL9PlHcnWgWTKFJuXYWSGlsl
         KY2+lgT1kIZjj4AG/CIJWwptTGUXqHfmF9Fxc58k8RuxqPhI4N1LDBMjkrTmZPl81LjM
         pYRA==
X-Forwarded-Encrypted: i=1; AKwUvBzAGEwcrqRMmWLXKoqmuCFplKSDoKE1bef57WBe7qhN/P0AtkemlD1Ru8Vs58rT3wV9mbI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQNkanw14L2yc50UjmMi1PUb8ylzQokm9DpjByQWLd5eKCj2x7
	b+R5eoFFv8yC8fl92ysWA3IndTwNfSKrJL4xOpmdT3/oOypGx3qDdD5vGTa+dX1o8//p3PBRJdI
	9nInDZwHjXQ==
X-Received: from dlbut3.prod.google.com ([2002:a05:7022:7e03:b0:143:7311:4b88])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4587:b0:17d:961d:7db0
 with SMTP id a92af1059eb24-18512e254fbmr4011450c88.28.1792257297503; Sat, 17
 Oct 2026 10:14:57 -0700 (PDT)
Date: Sat, 17 Oct 2026 10:14:35 -0700
In-Reply-To: <20261017171437.2066343-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261017054555.1655407-1-irogers@google.com> <20261017171437.2066343-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261017171437.2066343-5-irogers@google.com>
Subject: [PATCH v2 4/6] perf bpf-filter: Extend lock_held() to support RCU,
 Tasks Trace RCU, and SRCU
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
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

# Conflicts:
#	tools/perf/util/bpf-filter.c
#	tools/perf/util/bpf_skel/sample_filter.bpf.c
---
 tools/perf/Documentation/perf-record.txt     |  42 +++--
 tools/perf/tests/parse-events.c              |  13 ++
 tools/perf/tests/shell/record_bpf_filter.sh  |  20 +++
 tools/perf/util/bpf-filter.c                 | 174 +++++++++++++++++--
 tools/perf/util/bpf_skel/lock_data.h         |  44 ++++-
 tools/perf/util/bpf_skel/sample-filter.h     |  12 ++
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 135 +++++++++++++-
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h   |   2 +
 tools/perf/util/lock-contention.c            |   4 +
 tools/perf/util/lock-contention.h            |   4 +-
 10 files changed, 418 insertions(+), 32 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 246ae085744d..c8ccfb0e0ce6 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -219,28 +219,38 @@ OPTIONS
 	'&', e.g. 'lock_held(&cgroup_mutex)' or 'lock_held(cgroup_mutex)'),
 	a hexadecimal lock address, a slab cache name prefixed with '&'
 	(e.g. 'lock_held(&dentry)', 'lock_held_read(&dentry)'), a well-known
-	lock name ('mmap_lock', 'siglock', 'rq_lock', 'zone_lock'), or a lock
-	type ('mutex', 'spinlock', 'rwsem', 'rwsem:R', 'rwsem:W', 'rwlock',
-	'rwlock:R', 'rwlock:W', 'rt-mutex', 'percpu-rwsem', 'pcpu-sem:W',
-	'semaphore').  Both read/shared and write/exclusive tracking are
-	supported for 'rwsem' (including 'mmap_lock') and 'rwlock';
+	lock name ('mmap_lock', 'siglock', 'rq_lock', 'zone_lock', 'rcu',
+	'rcu-trace'), or a lock type ('mutex', 'spinlock', 'rwsem', 'rwsem:R',
+	'rwsem:W', 'rwlock', 'rwlock:R', 'rwlock:W', 'rt-mutex',
+	'percpu-rwsem', 'pcpu-sem:W', 'srcu', 'srcu:R', 'srcu:W', 'rcu:R',
+	'rcu:W', 'semaphore').  Both read/shared and write/exclusive tracking
+	are supported for 'rwsem' (including 'mmap_lock'), 'rwlock', 'rcu',
+	and 'srcu' (where read/shared mode matches 'rcu_read_lock()' /
+	'srcu_read_lock()' critical sections and write/exclusive mode matches
+	grace-period waits 'synchronize_rcu*()', 'synchronize_srcu*()',
+	'rcu_barrier()', and 'srcu_barrier()'); 'rcu-trace'
+	('rcu_read_lock_trace()') supports read/shared tracking only; and
 	'mutex', 'spinlock' (including 'siglock', 'rq_lock', 'zone_lock'),
 	'rt-mutex', 'semaphore', and 'percpu-rwsem' ('percpu_down_write()')
 	support write/exclusive tracking only.
 
 	Note that 'lock_held(<lock>)' introduces overhead outside of sample
 	overflow handling: in addition to checking the lock's owner field on
-	each sample where possible (such as for mutexes, rt-mutexes, and
-	write-locked rwsems), it attaches BPF fentry/fexit programs to kernel
-	lock acquire and release functions to track held locks (such as
-	spinlocks, rwlocks, reader-locked rwsems, and slab/type filters) in a
-	BPF map.  These BPF hooks run on every kernel lock acquisition and
-	release for the attached lock family, even when no perf sample is
-	being taken.  To minimize this overhead, only the hooks for the
-	relevant lock family and mode are attached when known (for example,
-	'lock_held_read(&mmap_lock)' only hooks rwsem read functions,
-	'lock_held_write(&mmap_lock)' only hooks rwsem write functions,
-	'&cgroup_mutex' only hooks mutex functions, and 'rq_lock' only hooks
+	each sample where possible (such as for mutexes, rt-mutexes,
+	write-locked rwsems, and 'rcu:R' / 'rcu-trace' which inspect
+	'current->rcu_read_lock_nesting' / 'current->trc_reader_nesting'
+	directly with no extra tracing hooks), it attaches BPF fentry/fexit
+	programs to kernel lock acquire and release functions to track held
+	locks (such as spinlocks, rwlocks, reader-locked rwsems, SRCU locks,
+	RCU synchronize waits, and slab/type filters) in a BPF map.  These
+	BPF hooks run on every kernel lock acquisition and release for the
+	attached lock family, even when no perf sample is being taken.  To
+	minimize this overhead, only the hooks for the relevant lock family
+	and mode are attached when known (for example, 'lock_held_read(rcu)'
+	and 'rcu-trace' attach no extra hooks, 'lock_held_read(&mmap_lock)'
+	only hooks rwsem read functions, 'lock_held_write(&mmap_lock)' only
+	hooks rwsem write functions, '&cgroup_mutex' only hooks mutex
+	functions, 'srcu' only hooks SRCU functions, and 'rq_lock' only hooks
 	spinlock functions), whereas slab filters ('&<slab>'), raw hex
 	addresses, or symbols without a recognizable lock-type suffix attach
 	hooks across all lock families (including high-frequency spinlocks).
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
index adaa5363d0b7..dc1c1a02eaad 100755
--- a/tools/perf/tests/shell/record_bpf_filter.sh
+++ b/tools/perf/tests/shell/record_bpf_filter.sh
@@ -239,6 +239,26 @@ test_bpf_filter_lock_held() {
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
        --filter 'lock_held_read(&mmap_lock) || lock_held_write(&mmap_lock)' \
        -o "${perfdata}" true 2> /dev/null
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 2f4c6bd85f89..6261a79b1455 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -190,11 +190,19 @@ enum lock_prog_group {
 	LOCK_PROG_RTMUTEX       = 1U << 6,
 	LOCK_PROG_SEM           = 1U << 7,
 	LOCK_PROG_PERCPU_RWSEM  = 1U << 8,
-	LOCK_PROG_ALL           = 0x1ffU,
+	LOCK_PROG_SRCU_READ     = 1U << 9,
+	LOCK_PROG_SRCU_WRITE    = 1U << 10,
+	LOCK_PROG_SRCU          = LOCK_PROG_SRCU_READ | LOCK_PROG_SRCU_WRITE,
+	LOCK_PROG_RCU_WRITE     = 1U << 11,
+	LOCK_PROG_ALL           = 0xfffU,
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
@@ -314,6 +322,32 @@ static const struct lock_prog_desc lock_progs[] = {
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
@@ -597,6 +631,18 @@ static unsigned int supported_lock_prog_groups(struct btf *btf)
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
 
@@ -701,6 +747,19 @@ static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
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
 	if (!has_amp && parse_lock_type_name(base, mode, NULL, NULL, &groups)) {
 		*prog_groups |= groups;
 		*required_groups |= groups;
@@ -744,6 +803,13 @@ static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
 			groups |= LOCK_PROG_RWLOCK_WRITE;
 		*prog_groups |= groups;
 		*required_groups |= groups;
+	} else if (strtailcmp(base, "srcu") == 0) {
+		if (mode & PBF_LOCK_MODE_READ)
+			groups |= LOCK_PROG_SRCU_READ;
+		if (mode & PBF_LOCK_MODE_WRITE)
+			groups |= LOCK_PROG_SRCU_WRITE;
+		*prog_groups |= groups;
+		*required_groups |= groups;
 	} else {
 		*prog_groups |= LOCK_PROG_ALL;
 	}
@@ -830,16 +896,54 @@ static bool find_slab_cache(struct sample_filter_bpf *skel, const char *name,
 	return false;
 }
 
+static u64 rcu_min_depth(struct evsel *evsel)
+{
+	if (evsel && evsel->core.attr.type == PERF_TYPE_SOFTWARE &&
+	    evsel->core.attr.config != PERF_COUNT_SW_CPU_CLOCK &&
+	    evsel->core.attr.config != PERF_COUNT_SW_TASK_CLOCK)
+		return 2;
+	return 1;
+}
+
+static bool btf_has_task_field(struct btf *btf, const char *field_name)
+{
+	const struct btf_type *t;
+	const struct btf_member *m;
+	s32 id;
+	u16 i, vlen;
+
+	if (!btf)
+		return false;
+
+	id = btf__find_by_name_kind(btf, "task_struct", BTF_KIND_STRUCT);
+	if (id < 0)
+		return false;
+
+	t = btf__type_by_id(btf, id);
+	if (!t)
+		return false;
+
+	m = btf_members(t);
+	vlen = btf_vlen(t);
+	for (i = 0; i < vlen; i++, m++) {
+		const char *name = btf__name_by_offset(btf, m->name_off);
+
+		if (name && !strcmp(name, field_name))
+			return true;
+	}
+	return false;
+}
+
 /*
  * Resolve a `lock_held(<name>)` filter expression into `entry->part`
  * (`enum perf_bpf_lock_target_kind`) and `entry->target`, and populate
  * the corresponding BPF filter maps and BSS control flags.
  *
  * Resolution order:
- * 1. Well-known per-process / semi-global locks: `mmap_lock`, `siglock`,
- *    `rq_lock`, `zone_lock` (with or without leading '&').
+ * 1. Well-known per-process / semi-global / RCU locks: `mmap_lock`, `siglock`,
+ *    `rq_lock`, `zone_lock`, `rcu`, `rcu-trace` (with or without leading '&').
  * 2. Lock types / flags (when no leading '&'): `mutex`, `spinlock`,
- *    `rwsem`, `rwsem:R`, `rwsem:W`, `rwlock`, `percpu-rwsem`,
+ *    `rwsem`, `rwsem:R`, `rwsem:W`, `rwlock`, `percpu-rwsem`, `srcu`,
  *    `semaphore`, etc.
  * 3. Hexadecimal lock address (when no leading '&').
  * 4. Slab cache name (when prefixed with '&', e.g. `&dentry`).
@@ -847,8 +951,8 @@ static bool find_slab_cache(struct sample_filter_bpf *skel, const char *name,
  *    e.g. `&cgroup_mutex` or `cgroup_mutex`).
  * 6. Slab cache name without leading '&' fallback.
  */
-static int resolve_lock_expr(struct sample_filter_bpf *skel,
-			     struct perf_bpf_filter_expr *expr,
+static int resolve_lock_expr(struct evsel *evsel, struct sample_filter_bpf *skel,
+			     struct btf *btf, struct perf_bpf_filter_expr *expr,
 			     struct perf_bpf_filter_entry *entry)
 {
 	const char *name = expr->lock_name;
@@ -912,6 +1016,48 @@ static int resolve_lock_expr(struct sample_filter_bpf *skel,
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
+		entry->target = rcu_min_depth(evsel);
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
+		entry->target = rcu_min_depth(evsel);
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
+		entry->target = 0;
+		return 0;
+	}
+
 	if (!has_amp && parse_lock_type_name(base, mode, skel, &encoded_pair, NULL)) {
 		entry->part = PBF_LOCK_TYPE | mode;
 		entry->target = encoded_pair;
@@ -976,7 +1122,7 @@ static int resolve_lock_expr(struct sample_filter_bpf *skel,
 }
 
 static int get_filter_entries(struct evsel *evsel, struct sample_filter_bpf *skel,
-			      struct perf_bpf_filter_entry *entry)
+			      struct btf *btf, struct perf_bpf_filter_entry *entry)
 {
 	int i = 0, ret;
 	struct perf_bpf_filter_expr *expr;
@@ -994,7 +1140,7 @@ static int get_filter_entries(struct evsel *evsel, struct sample_filter_bpf *ske
 		entry[i].value = expr->val;
 		entry[i].target = 0;
 		if (expr->term == PBF_TERM_LOCK_HELD) {
-			ret = resolve_lock_expr(skel, expr, &entry[i]);
+			ret = resolve_lock_expr(evsel, skel, btf, expr, &entry[i]);
 			if (ret < 0)
 				return ret;
 		}
@@ -1013,7 +1159,7 @@ static int get_filter_entries(struct evsel *evsel, struct sample_filter_bpf *ske
 				entry[i].value = group->val;
 				entry[i].target = 0;
 				if (group->term == PBF_TERM_LOCK_HELD) {
-					ret = resolve_lock_expr(skel, group, &entry[i]);
+					ret = resolve_lock_expr(evsel, skel, btf, group, &entry[i]);
 					if (ret < 0)
 						return ret;
 				}
@@ -1287,7 +1433,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 			goto err;
 		}
 
-		ret = get_filter_entries(evsel, NULL, entry);
+		ret = get_filter_entries(evsel, NULL, NULL, entry);
 		if (ret < 0) {
 			pr_err("Failed to process filter entries\n");
 			goto err;
@@ -1349,6 +1495,12 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 			bpf_map__set_max_entries(skel->maps.lock_syms, MAX_ENTRIES);
 			init_numa_data(skel, btf);
 		}
+		if (prog_groups & LOCK_PROG_RCU_WRITE) {
+			u64 rcu_addr = 1ULL;
+
+			find_kernel_lock_sym("rcu_state", &rcu_addr);
+			skel->rodata->rcu_state_addr = rcu_addr;
+		}
 		ret = configure_lock_progs(skel, btf, prog_groups, required_groups,
 					   needs_lock_syms, needs_slab_iter);
 		if (ret < 0)
@@ -1366,7 +1518,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	if (has_lock_filter && needs_slab_iter)
 		run_slab_cache_iter(skel);
 
-	ret = get_filter_entries(evsel, skel, entry);
+	ret = get_filter_entries(evsel, skel, btf, entry);
 	if (ret < 0) {
 		pr_err("Failed to process filter entries\n");
 		goto err;
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index bf39128e0be1..85570798baae 100644
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
 
@@ -241,6 +244,40 @@ static __always_inline __u64 get_current_siglock(__u64 curr)
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
+ * (`rcu_read_lock_trace()`).
+ */
+static __always_inline bool is_rcu_trace_lock_held(__u64 curr)
+{
+	struct task_struct *task = (void *)curr;
+
+	if (!curr || !bpf_core_field_exists(task->trc_reader_nesting))
+		return false;
+
+	return BPF_CORE_READ(task, trc_reader_nesting) > 0;
+}
+
 /*
  * Read the 1st function argument (`lock` / `sem` / `ssp`) as a 64-bit scalar.
  *
@@ -273,6 +310,9 @@ static __always_inline __u32 check_lock_type(__u64 lock, __u32 flags)
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
index cd711d1d04b6..37c108608bbc 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -99,6 +99,18 @@ enum perf_bpf_lock_target_kind {
 	 * low two bytes: `flag1 | (flag2 << 8)` (with 0xff indicating unused).
 	 */
 	PBF_LOCK_TYPE,
+	/*
+	 * Preemptible RCU read-side lock (`rcu` / `rcu_read_lock`).
+	 * Inspected directly via `current->rcu_read_lock_nesting > entry.target`,
+	 * where `entry.target` is the baseline RCU nesting depth added by the
+	 * kernel perf overflow path.
+	 */
+	PBF_LOCK_RCU,
+	/*
+	 * Tasks Trace RCU read-side lock (`rcu-trace` / `rcu_read_lock_trace`).
+	 * Inspected directly via `current->trc_reader_nesting > 0`.
+	 */
+	PBF_LOCK_RCU_TRACE,
 };
 
 /*
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 480ba4b49793..6f3adbbe0289 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -123,6 +123,7 @@ volatile const int use_idx_hash;
 
 const volatile __u64 contig_page_data_addr;
 const volatile __u64 node_data_addr;
+const volatile __u64 rcu_state_addr;
 const volatile int nr_nodes;
 const volatile int sizeof_zone;
 
@@ -136,6 +137,7 @@ int has_lock_class;
 int has_lock_type;
 int has_mmap_lock;
 int has_siglock;
+int has_rcu_lock;
 int track_rwsem_read;
 __u8 lock_type_filter[LCB_F_TYPE_MAX];
 
@@ -270,6 +272,20 @@ static __always_inline __u64 check_lock_held(struct perf_bpf_filter_entry *entry
 	case PBF_LOCK_TYPE:
 		return is_lock_type_in_map(entry->target, mode, pid, cpu_id);
 
+	case PBF_LOCK_RCU:
+		if ((mode & PBF_LOCK_MODE_READ) &&
+		    is_rcu_lock_held(curr, (int)entry->target))
+			return 1;
+		if ((mode & PBF_LOCK_MODE_WRITE) && rcu_state_addr &&
+		    is_lock_in_map(rcu_state_addr, PBF_LOCK_ADDR, PBF_LOCK_MODE_WRITE, pid, cpu_id))
+			return 1;
+		return 0;
+
+	case PBF_LOCK_RCU_TRACE:
+		if ((mode & PBF_LOCK_MODE_READ) && is_rcu_trace_lock_held(curr))
+			return 1;
+		return 0;
+
 	default:
 		return 0;
 	}
@@ -601,11 +617,12 @@ static __always_inline int record_lock_acquired_owner(__u64 lock_addr, __u32 fla
 	if (has_lock_addr && bpf_map_lookup_elem(&lock_addr_filter, &lock_addr))
 		matched = true;
 
-	if (has_mmap_lock || has_siglock) {
+	if (has_mmap_lock || has_siglock || has_rcu_lock) {
 		__u32 ltype = check_lock_type(lock_addr, flags);
 
 		if ((has_mmap_lock && ltype == LCD_F_MMAP_LOCK) ||
-		    (has_siglock && ltype == LCD_F_SIGHAND_LOCK))
+		    (has_siglock && ltype == LCD_F_SIGHAND_LOCK) ||
+		    (has_rcu_lock && ltype == LCD_F_RCU_LOCK))
 			matched = true;
 	}
 
@@ -1247,6 +1264,120 @@ int BPF_PROG(fentry_percpu_up_write, void *sem)
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
index a1bb78d6e29c..b45b075f3346 100644
--- a/tools/perf/util/lock-contention.c
+++ b/tools/perf/util/lock-contention.c
@@ -38,6 +38,10 @@ const struct perf_lock_type lock_type_table[] = {
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
2.56.0.212.g129ede20d9-goog

