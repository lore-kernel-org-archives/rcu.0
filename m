Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370D3BD651
	for <rcu@vger.kernel.org>; Sat, 17 Oct 2026 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257293; cv=none; b=iK2k/cQshpw3eTiHyLGqXeZlt6ICgP5bQsspL4NGpf6dGLLw8W2XnChL2APfxD1DQ/611dEujrluOnDb3ju0lXPgAG+9ZVGCMOAdTnzpvFGNBZ2D9G/VLVVccOVGznP9tKJIiAtxtRcKgwXKqNA6hgxr29JG+pOYppiqDKqQBBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257293; c=relaxed/simple;
	bh=RPqCQDxjE3n++2VgM6o+8e4cV0MBPujj1BtwrxM7pGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k2N8VjQeZi9ZHRn5cYQ1vqrF4De34FfMftrh07he0G35UI5viwxngxiNN9j2sT8Rgxm2/wvD/e8nFPhouwJD3xCCgpqC8p9q567RXc1jL0lQWwwbAmqEi4vKc65zT50Xle8VtEIbrseJ/MACg8LqjBLmcXK8yeFg2KWc0WcpiaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bG4KvOZX; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bG4KvOZX"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510d0baf63so2347057eec.1
        for <rcu@vger.kernel.org>; Sat, 17 Oct 2026 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792257290; x=1792862090; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I0+uAxPvAKtTv0jimWUt+98k1pt+pzeo/v/v6OmosKA=;
        b=bG4KvOZXJkeXG2FNGrfn6Kj7rv0bYfOOc1UL2zRI7508D9Gdpjv/xFjrcZUNHx0vgz
         Tyb1cvkOJNkKpxmFBT80lZUqwuYKiV5LCIKqlFPdwwSDYQhrvzIJdHGYX2aTCY0FGmw9
         lOsJflWj2nLojccwShUdUtYDzd00pBDtI8ty9tOua3zPuCan1LQ0V4GNPg0B6vWAEdEx
         V2qIfrQ308nCI7FhhvRN/JS/xWV8CnJmSzwmaT0jXV5R6hZjOj+1gYm8vYBAd+KsOFw3
         rcymIHY7Mnk66hzlz9xOLboylJb4SS5oCgZWwWcnUgUd+ksqS3ryyLXWW3M5thG4V6pd
         NiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792257290; x=1792862090;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I0+uAxPvAKtTv0jimWUt+98k1pt+pzeo/v/v6OmosKA=;
        b=0gNAQzaVBUHVu7WLUlL35XG3N+rLqMlyyKFHUSO6VtaCrMSIf3eQp7BDH0yKuujUnS
         Lz0Vlp4dnx2tgGIsitczJVIfk6MtP/zsrCXBI6GKpuLswmKdL4s/LDFvs9Wrjg1S297e
         f95Xg1tzP+nhzuyk3eCJUZmy6ZELJBhpZ7CxlXNU9Pm6g25KILziaJxh46twqHICx7/E
         u0rxVhPEOBNwVZs/xZU3WME+LctZz3OlzfuBciUA/DDuulKw/hog87c66is7y8zTvkCb
         oWian6jX4ecCQgDF/4pF1Qu7sbDVUZppmh7Wbh0WotfyAfbTnCXjvr6rK3Xfgqtpgmsk
         uAvQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTbKs0q9XWUwG31TOYxRlIio8FuMg6R0i1RnqUtbLD9N5nCtywCEVJrkeXYBA664Yr5Gw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIItrecicObMQQMJJH+o21na/VIIiq9g38gLJ3o6a82q29si2rI
	QbtBTeTWclHm5cgK8HQaFqUUzSbqu6ho80OkgqycVWnSfXU70WwXDXc+JJjZeohyeBHRGJ+yr1s
	gp7HlGPXz0A==
X-Received: from dlbrn12.prod.google.com ([2002:a05:7022:150c:b0:15e:caa1:d304])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4281:20b0:145:152:b547
 with SMTP id a92af1059eb24-1850c5f792emr4688826c88.1.1792257289477; Sat, 17
 Oct 2026 10:14:49 -0700 (PDT)
Date: Sat, 17 Oct 2026 10:14:31 -0700
In-Reply-To: <20261017054555.1655407-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261017054555.1655407-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261017171437.2066343-1-irogers@google.com>
Subject: [PATCH v2 0/6] perf bpf-filter / lock contention: Add lock_held()
 sample filter and RCU/SRCU support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series adds a new BPF sample filter predicate, `lock_held(<lock>)`
(along with `lock_held_read(<lock>)` / `lock_held_shared(<lock>)`,
`lock_held_write(<lock>)` / `lock_held_exclusive(<lock>)`, and `:R` / `:W`
mode suffixes), to `perf record --filter`, allowing perf event samples to
be recorded only when a specified kernel lock is held (or not held with
`!`) by the running kernel thread or CPU. It also extends both
`lock_held()` and `perf lock contention --use-bpf` to support RCU and
SRCU, and fixes a pre-existing `lock_stat` filtering bug in `perf lock
contention`.

For example:

  # perf record -a -g -e cycles --filter 'lock_held(&cgroup_mutex)' -- ...
  # perf record -a -g -e cycles --filter 'lock_held_read(&mmap_lock)' -- ...
  # perf record -a -g -e cycles --filter 'lock_held(&mmap_lock:W)' -- ...
  # perf record -a -g -e cycles --filter 'lock_held_read(rcu)' -- ...
  # perf lock contention -a -b -Y rcu,srcu -- sleep 1

Supported `<lock>` specifications match `perf lock contention`:
- Global/static kernel lock symbols (with or without leading `&`, e.g.
  `lock_held(&cgroup_mutex)` or `lock_held(cgroup_mutex)`)
- Hexadecimal kernel lock addresses
- Slab cache names prefixed with `&` (e.g. `lock_held(&dentry)`,
  `lock_held_read(&dentry)`)
- Well-known per-process, semi-global, and RCU locks: `mmap_lock`,
  `siglock`, `rq_lock`, `zone_lock`, `rcu`, `rcu-trace`
- Lock types and flags: `mutex`, `spinlock`, `rwsem`, `rwsem:R`,
  `rwsem:W`, `rwlock`, `rwlock:R`, `rwlock:W`, `rt-mutex`,
  `percpu-rwsem`, `pcpu-sem:W`, `srcu`, `srcu:R`, `srcu:W`, `rcu:R`,
  `rcu:W`, `semaphore`

Limitations and weaknesses in determining whether a lock is held:
- Inlined lock/unlock operations:
  - When the kernel is configured to inline spinlock or rwlock operations
    (`CONFIG_INLINE_SPIN_LOCK`, `CONFIG_INLINE_READ_LOCK`,
    `CONFIG_INLINE_WRITE_LOCK`, `!CONFIG_UNINLINE_SPIN_UNLOCK`,
    `CONFIG_INLINE_*_UNLOCK*`, etc.), `_raw_spin_lock*` /
    `_raw_spin_unlock*` and `_raw_read_lock*` / `_raw_write_lock*` are
    inlined into callers and have no BTF function entry points for
    `fentry`/`fexit` to attach to. `configure_lock_progs()` verifies that
    both acquire and release entry points exist in BTF before enabling a
    lock family.
  - Fast-path `percpu_down_read()` / `percpu_up_read()` and
    `srcu_read_lock_fast()` / `srcu_read_unlock_fast()` are inlined
    per-CPU counter increments without function calls, so only
    `percpu_down_write()` / `percpu_up_write()` and out-of-line
    `__srcu_read_lock*()` / `__srcu_read_unlock*()` can be hooked.
  - On `!CONFIG_PREEMPT_RCU` kernels, `rcu_read_lock()` compiles to
    `preempt_disable()` and does not maintain
    `current->rcu_read_lock_nesting` in `task_struct`, so `lock_held(rcu)`
    read-side inspection requires `CONFIG_PREEMPT_RCU`.
- Lack of an inspectable owner field on non-exclusive / spinning locks:
  - While `struct mutex`, `struct rt_mutex`, and write-locked
    `struct rw_semaphore` store the owning `task_struct *` in `lock->owner`
    (allowing `perf_sample_filter` to inspect kernel memory directly on
    sample overflow when filtering by lock address), spinlocks, rwlocks,
    semaphores, SRCU, and reader-locked `rw_semaphore`s (where
    `__up_read()` does not clear `sem->owner` when `!CONFIG_DEBUG_RWSEMS`)
    do not maintain an authoritative per-task owner pointer.
  - Tracking these locks (as well as slab-cache and lock-type filters)
    relies on `fexit` (acquire) and `fentry` (release) BPF hooks
    maintaining the `held_locks` BPF hash map:
    - Any such lock already held before `perf record` attaches its BPF
      programs will not be present in `held_locks` until it is released
      and re-acquired.
    - The attached `fentry`/`fexit` hooks execute on every kernel lock
      acquire and release for the hooked lock family across the system,
      adding tracing overhead outside of perf sample handling.

Patch overview:
1. "perf lock contention: Share common BPF and lock type definitions in
   lock_data.h": Moves `lock_type_table` to `util/lock-contention.c` and
   `LCB_F_*` flags, CO-RE structs, and common BPF lock helpers
   (`get_lock_owner`, `get_current_mmap_lock`, `get_current_siglock`,
   `get_lock_addr`, `check_lock_type`, `do_collect_lock_syms`,
   `do_slab_cache_iter`) into `tools/perf/util/bpf_skel/lock_data.h`.
2. "perf bpf-filter: Add lock_held() sample filter": Implements
   `lock_held()`, `lock_held_read()`/`lock_held_shared()`,
   `lock_held_write()`/`lock_held_exclusive()`, and `:R`/`:W` mode
   suffixes using direct lock owner inspection where possible (`mutex`,
   `rt_mutex`, write-locked `rw_semaphore`) and a `held_locks` BPF map
   updated by selectively attached `fentry`/`fexit` hooks.
3. "perf test: Add tests for lock_held() BPF sample filter": Adds unit
   tests in `tests/parse-events.c` and shell tests in
   `tests/shell/record_bpf_filter.sh`.
4. "perf bpf-filter: Extend lock_held() to support RCU, Tasks Trace RCU,
   and SRCU": Supports `rcu` (`rcu:R` via direct
   `current->rcu_read_lock_nesting` inspection with zero tracing hooks;
   `rcu:W` via `synchronize_rcu*()` / `rcu_barrier()` hooks),
   `rcu-trace` (via `current->trc_reader_nesting`), and `srcu`
   (`srcu:R` via `__srcu_read_lock*` / `__srcu_read_unlock*`; `srcu:W`
   via `synchronize_srcu*()` / `srcu_barrier()`).
5. "perf lock contention: Extend BPF lock contention to RCU and SRCU":
   Extends `perf lock contention --use-bpf` to track RCU and SRCU
   grace-period and barrier waits (`-Y rcu`, `-Y srcu`, `-L rcu`).
6. "perf lock contention: Filter events before creating lock_stat":
   Fixes `report_lock_contention_begin_event()` in `builtin-lock.c` to
   apply `-Y`, `-L`, and `-S` filters before calling
   `lock_stat_findnew()`.

Changes in v2:
- Guard `BPF_CORE_READ(mutex, owner.counter)` with `bpf_core_field_exists`
  and fall back to `struct rt_mutex_base` in `get_lock_owner()` so CO-RE
  relocation succeeds on `CONFIG_PREEMPT_RT=y` kernels.
- Add `CONFIG_DEBUG_LOCK_ALLOC=y` lock entry points
  (`_mutex_lock_nest_lock`, `_mutex_lock_killable`,
  `_mutex_trylock_nest_lock`, `_down_write_nest_lock`,
  `_raw_spin_lock_nest_lock`, `_rt_mutex_lock_nest_lock`) to
  `sample_filter.bpf.c` and `lock_progs[]`.
- Verify in `supported_lock_prog_groups()` that both acquire and all
  unlock BTF entry points exist for a lock family before enabling its
  tracing hooks, preventing acquire-only attachment when spinlock/rwlock
  unlock functions are inlined.
- Enable `LOCK_PROG_PERCPU_RWSEM` alongside `LOCK_PROG_RWSEM_WRITE` when
  a symbol name ends in `rwsem` (such as `cgroup_threadgroup_rwsem`).
- Gate `record_lock_acquired(ctx, LCB_F_READ)` in `fexit_downgrade_write`
  on `track_rwsem_read` and verify non-zero read/write counts in
  `record_lock_released_addr()` before decrementing aggregate slab/type
  counts.
- Adjust stack skip depth by 2 for `fentry` RCU/SRCU programs in
  `lock_contention.bpf.c` and recognize `synchronize_rcu*`,
  `synchronize_srcu*`, `rcu_barrier`, and `srcu_barrier` in
  `machine__is_lock_function()`.
- Add patch 6 fixing `report_lock_contention_begin_event()` to check
  type, address, and callstack filters before creating `lock_stat`
  entries.

Assisted-by: Antigravity:gemini-3.1-pro

Ian Rogers (6):
  perf lock contention: Share common BPF and lock type definitions in
    lock_data.h
  perf bpf-filter: Add lock_held() sample filter
  perf test: Add tests for lock_held() BPF sample filter
  perf bpf-filter: Extend lock_held() to support RCU, Tasks Trace RCU,
    and SRCU
  perf lock contention: Extend BPF lock contention to RCU and SRCU
  perf lock contention: Filter events before creating lock_stat

 tools/perf/Documentation/perf-lock.txt        |    7 +-
 tools/perf/Documentation/perf-record.txt      |   51 +-
 tools/perf/builtin-lock.c                     |   88 +-
 tools/perf/tests/parse-events.c               |  121 ++
 tools/perf/tests/shell/lock_contention.sh     |   14 +
 tools/perf/tests/shell/record_bpf_filter.sh   |  123 ++
 tools/perf/util/bpf-filter.c                  | 1188 ++++++++++++++++-
 tools/perf/util/bpf-filter.h                  |   13 +
 tools/perf/util/bpf-filter.l                  |   31 +-
 tools/perf/util/bpf-filter.y                  |   46 +-
 tools/perf/util/bpf_lock_contention.c         |  167 ++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  427 +++---
 tools/perf/util/bpf_skel/lock_data.h          |  368 ++++-
 tools/perf/util/bpf_skel/sample-filter.h      |   71 +
 tools/perf/util/bpf_skel/sample_filter.bpf.c  | 1096 +++++++++++++++
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |    7 +
 tools/perf/util/lock-contention.c             |   22 +
 tools/perf/util/lock-contention.h             |   15 +
 tools/perf/util/machine.c                     |   11 +
 tools/perf/util/parse-events.c                |    3 +-
 20 files changed, 3507 insertions(+), 362 deletions(-)

-- 
2.56.0.212.g129ede20d9-goog

