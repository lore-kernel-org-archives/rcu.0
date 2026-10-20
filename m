Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529955;
	b=b4XrBcQgtbN0gfmNY0gVOgPvG/4oDDqTGFxDyGvmstskANGXqX5ueMl/hkfXZMY3w75d
	 +Jym1aRmetNGKU/V8JVFwTEcpxy/7pmwC+F9af/yUEmVjB5PnCJMQbl+pkGlEdiBpWQbt
	 +H8glYx8ok8PPi8EH6ImNgqzczH+jyzrEp+5+Gd00dHRltG0f9Ypso9Vw1A6PSIM5ELo/
	 sY24wf+C+pQ9weooR+RxS6QZ2yKovG18FCfWr5pqSxuDhV8AVBfGnHlIMr90ijNuYLPhX
	 jEwm+B7pSSF0+8dlTnJ86AgWf9DYi1QuyKwe+x6xsBGHTsRyUjbhhZ1kRVYCkg5Badw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=6W8OuMcK4Do8rJVA4avU3Jn9lfIghu1vnll26wBHiy4=;
	b=ddD9zYOSZfvJ3jFRjMqaWxrcnJMgsJVGnUplRPnnvhe/9qLZih0E0s+zzyR8hoai0Bq1
	 G69TYj9B1Ssqd032Z8AS2H8s0uRglT0SB1Uflo64MNu/8GNAqUmao7XaXjz3Mt/fgc9va
	 ldENCQHuHpXFjNVFC8jgQyb3pqbqMzpe2DsUMg3hDnIEtSL7exZGjwI7vEU/tRhLEVAqg
	 hXSpiu03XZheR8s8hw8c0x6LXlFxeIuj5XFZe14jNKh+7JjpWpUXWnh//x9/TFjh+LB0g
	 tEp8DUaq9o7Ox90End97VYH9o6AJrXjYGlDMl/j1qxz1VdjF1hGXYLeJQlKowGA3ZuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=M7Pzu25N;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611B606A31A
	for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 20:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8611B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=M7Pzu25N
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-186c1aae818so100026c88.0
        for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 13:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792529953; x=1793134753; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6W8OuMcK4Do8rJVA4avU3Jn9lfIghu1vnll26wBHiy4=;
        b=M7Pzu25N2E5GeHyfe8mKFAmR7X6I6LpTo8ycYke/T/RPsU8EAfn/8aqiqkVtdp7IFh
         PcsJwIr2Ql5mgM2KyrWOYE6jTqFLBNLbN7tVMOaD5+UwJ4Yxm02gMamAQHwxqu8phr1D
         ui0tFepDCYTo99jlrkW2QPlugiXvetDhFSGiEbinrWfCS5glVme8w8lNmnmIeemhHWet
         JBkbtIVS2CEw6jlWoEy+T9gcc7L121y6gN6U1x9rGoEO7jxjnxtqIKni+B57uXM4SsuZ
         aG54d+I29BrREJa2xigVcpIuobmmomckSyduWRjOv4bCC0aLcyurpII98v5pw32ymcqw
         7GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529953; x=1793134753;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6W8OuMcK4Do8rJVA4avU3Jn9lfIghu1vnll26wBHiy4=;
        b=anr31Dg2MEGhhgeb7fuxNb8iy6hrsgmkrPC2EXhekIvUTNcIIUPxiCKz5xxoZPPn9m
         8podFsOPPHN5xTKHaTeHFCXjrw9FWPCOLguJxykTp7ZGuY/slQcQxnWhhIICtWS0Px00
         d7wAavQyB+HvJvWOBUUm0arCBh6IXRG3vHsVwCDn1DzSJFXFw2t65kCI7ztCCKogvfKp
         4GOheEoqD4lm7RQA/VuvbNatG5nI9d9QJLqJBlrE3N73wz7xQtWVwbx4Nkh+bWu4dWfg
         QExiMOY9fmYhmmbW7ajFRFBxM1r3ZabYB39tsSBNikpusjtWo65+bVOni1ervm/ld0gY
         SdGw==
X-Forwarded-Encrypted: i=1; AKwUvBx2MYLgVTMgS3imAyW8L5CWc1AnqXsd94AKhPxx1WSi2fhcZJHAh4XRmg9R0QVAfW6lCeE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9T/REiozjjWDx+l0EXPerqoSsrcHsTZ5wShso15qaIcJkPNTw
	inmCWO6t5Y81Aqw5g/Rv6xbBNydDEC6nxs41hq9xwKm3yR+Hc88bP6pW65f5cHreii5emXAFzE0
	Zefo1mMW12A==
X-Received: from dlbbo2.prod.google.com ([2002:a05:7022:4382:b0:18a:e397:f0e8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4190:20b0:14d:c9e:a356
 with SMTP id a92af1059eb24-190a4f05a21mr25207c88.12.1792529953117; Tue, 20
 Oct 2026 13:59:13 -0700 (PDT)
Date: Tue, 20 Oct 2026 13:58:50 -0700
In-Reply-To: <20261019220915.3943592-1-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019220915.3943592-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020205859.1080743-1-irogers@google.com>
Subject: [PATCH v5 0/8] perf bpf-filter / lock contention: Add lock_held()
 sample filter and RCU/SRCU support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series adds a new BPF sample filter predicate, `lock_held(<lock>)`
(along with `lock_held_read(<lock>)` / `lock_held_shared(<lock>)`,
`lock_held_write(<lock>)` / `lock_held_exclusive(<lock>)`, and `:R` / `:W`
mode suffixes), to `perf record --filter`, allowing perf event samples to
be recorded only when a specified kernel lock is held (or not held with
`!`) by the running kernel thread or CPU. It also fixes a pre-existing
`lock_stat` filtering bug in `perf lock contention`, fixes a `bpf_link`
memory leak in `perf_bpf_filter__prepare()`, enables BPF sample filters on
tracepoint events (`PERF_TYPE_TRACEPOINT`), and extends both `lock_held()`
and `perf lock contention --use-bpf` to support RCU and SRCU.

For example:

  # perf record -a -g -e cycles --filter 'lock_held(cgroup_mutex)' -- ...
  # perf record -a -g -e cycles --filter 'lock_held_read(mmap_lock)' -- ...
  # perf record -a -g -e cycles --filter 'lock_held(mmap_lock:W)' -- ...
  # perf record -a -g -e cycles --filter 'lock_held_read(rcu)' -- ...
  # perf lock contention -a -b -Y rcu,srcu -- sleep 1

An important use-case is detecting memory allocations or direct memory
reclaim occurring while kernel locks are held, which can stall lock
waiters for extended periods under memory pressure:

  # Direct memory reclaim triggered while holding any mutex or rwsem:
  # perf record -a -g -e vmscan:mm_vmscan_direct_reclaim_begin \
      --filter 'lock_held(mutex) || lock_held(rwsem)' -- ...

  # Page allocations permitted to enter direct reclaim (__GFP_DIRECT_RECLAIM)
  # while holding a mutex or rwsem:
  # perf record -a -g -e kmem:mm_page_alloc \
      --filter 'gfp_flags & 0x400' \
      --filter 'lock_held(mutex) || lock_held(rwsem)' -- ...

  # Major page faults occurring while holding a mutex or rwsem:
  # perf record -a -g -e major-faults \
      --filter 'lock_held(mutex) || lock_held(rwsem)' -- ...

Supported `<lock>` specifications match `perf lock contention`:
- Global/static kernel lock symbols (e.g. `lock_held(cgroup_mutex)`)
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
    sample overflow when filtering by lock address without attaching any
    `fentry`/`fexit` hooks for `*_mutex`, `*_rt_mutex`, and `mmap_lock:W`),
    spinlocks, rwlocks, semaphores, SRCU, and reader-locked
    `rw_semaphore`s (where `__up_read()` does not clear `sem->owner` when
    `!CONFIG_DEBUG_RWSEMS`) do not maintain an authoritative per-task
    owner pointer.
  - Tracking these locks (as well as slab-cache and lock-type filters)
    relies on `fexit` (acquire) and `fentry` (release) BPF hooks
    maintaining the `held_locks` BPF LRU hash map:
    - Any such lock already held before `perf record` attaches its BPF
      programs will not be present in `held_locks` until it is released
      and re-acquired.
    - The attached `fentry`/`fexit` hooks execute on every kernel lock
      acquire and release for the hooked lock family across the system,
      adding tracing overhead outside of perf sample handling.
- Cross-task semaphore signaling (`down*()` / `up()`):
  - Counting `struct semaphore`s do not enforce same-task ownership in the
    kernel: when a semaphore is used as a completion/signaling mechanism
    (`down()` in one task woken by `up()` in another task or interrupt
    handler, which proposed kernel dependency trackers like `CONFIG_DEPT`
    model as wait/event dependencies bounded by execution context rather
    than lock ownership), `fexit/down` and `fentry/up` do not pair on the
    same task ID. Semaphore hooks are therefore only enabled when
    `semaphore` or a `*_sem` symbol (such as `console_sem`) is explicitly
    specified, and `held_locks` uses `BPF_MAP_TYPE_LRU_HASH` so any
    unpaired cross-task entries are automatically evicted.

Patch overview (patches 1-3 are standalone fixes independent of the rest
of the series):
1. "perf lock contention: Filter events before creating lock_stat":
   Fixes `report_lock_contention_begin_event()` in `builtin-lock.c` to
   apply `-Y`, `-L`, and `-S` filters before calling
   `lock_stat_findnew()`.
2. "perf bpf-filter: Fix bpf_link leak by using PERF_EVENT_IOC_SET_BPF":
   Attaches `perf_sample_filter` directly via `PERF_EVENT_IOC_SET_BPF` in
   `perf_bpf_filter__prepare()`, matching the pinned filter path and
   avoiding leaking `struct bpf_link_perf` or double-closing
   `FD(evsel, x, y)`.
3. "perf bpf-filter: Support BPF sample filters on tracepoint events":
   Adds `SEC("tracepoint") int perf_tp_sample_filter(void *ctx)` so BPF
   sample filters can attach to `PERF_TYPE_TRACEPOINT` events (where
   `__perf_event_set_bpf_prog()` in `kernel/events/core.c` requires
   `BPF_PROG_TYPE_TRACEPOINT` rather than `BPF_PROG_TYPE_PERF_EVENT`).
4. "perf lock contention: Share common BPF and lock type definitions in
   lock_data.h": Moves `lock_type_table` to `util/lock-contention.c` and
   `LCB_F_*` flags, CO-RE structs, and common BPF lock helpers
   (`get_lock_owner`, `get_current_mmap_lock`, `get_current_siglock`,
   `get_lock_addr`, `check_lock_type`, `do_collect_lock_syms`,
   `do_slab_cache_iter`) into `tools/perf/util/bpf_skel/lock_data.h`.
5. "perf bpf-filter: Add lock_held() sample filter": Implements
   `lock_held()`, `lock_held_read()`/`lock_held_shared()`,
   `lock_held_write()`/`lock_held_exclusive()`, and `:R`/`:W` mode
   suffixes using direct lock owner inspection where possible (`mutex`,
   `rt_mutex`, write-locked `rw_semaphore`) and a `held_locks` BPF LRU
   hash map updated by selectively attached `fentry`/`fexit` hooks.
6. "perf test: Add tests for lock_held() BPF sample filter": Adds unit
   tests in `tests/parse-events.c` and shell tests in
   `tests/shell/record_bpf_filter.sh`.
7. "perf bpf-filter: Extend lock_held() to support RCU, Tasks Trace RCU,
   and SRCU": Supports `rcu` (`rcu:R` via direct
   `current->rcu_read_lock_nesting` inspection with zero tracing hooks;
   `rcu:W` via `synchronize_rcu*()` / `rcu_barrier()` hooks),
   `rcu-trace` (via `current->trc_reader_nesting`), and `srcu`
   (`srcu:R` via `__srcu_read_lock*` / `__srcu_read_unlock*`; `srcu:W`
   via `synchronize_srcu*()` / `srcu_barrier()`).
8. "perf lock contention: Extend BPF lock contention to RCU and SRCU":
   Extends `perf lock contention --use-bpf` to track RCU and SRCU
   grace-period and barrier waits (`-Y rcu`, `-Y srcu`, `-L rcu`).

Changes in v5:
- Add patch 2 ("perf bpf-filter: Fix bpf_link leak by using
  PERF_EVENT_IOC_SET_BPF") attaching BPF sample filters via
  `ioctl(..., PERF_EVENT_IOC_SET_BPF, fd)` instead of
  `bpf_program__attach_perf_event_opts()`, fixing the `bpf_link` memory
  leak without double-closing `FD(evsel, x, y)`, and use the same
  attachment in patch 3 for tracepoint sample filters (Namhyung).
- Expand patch 3's commit message to detail why `pin_filter_object()`
  and `unpin_filter_object()` replace `bpf_object__pin()` and
  `bpf_object__unpin()` when `autoload` is disabled on
  `perf_tp_sample_filter` (Namhyung).
- Store the resolved lock target in `perf_bpf_filter_entry.value` (with
  `op` normalized to `PBF_OP_EQ` or `PBF_OP_NEQ`), keeping
  `struct perf_bpf_filter_entry` unchanged at 24 bytes for backwards
  compatibility with pinned `filters` maps.
- Add a CO-RE `struct rt_mutex___old` fallback in `get_lock_owner()` in
  `lock_data.h` for kernels prior to v5.15, and pass baseline nesting
  depth to `is_rcu_trace_lock_held()` for syscall tracepoints.

Changes in v4:
- Move the two bugfix commits (`Filter events before creating lock_stat`
  and `Support BPF sample filters on tracepoint events`) to patches 1
  and 2 at the start of the series for easier cherry-picking.
- Reserve leading `&` strictly for slab cache locks (e.g.
  `lock_held(&dentry)`) so global/static lock symbols and well-known
  locks do not use `&` (e.g. `lock_held(cgroup_mutex)`,
  `lock_held_read(mmap_lock)`), matching `perf lock contention`
  (Namhyung).
- Skip attaching `fentry`/`fexit` hooks when filtering on a specific
  `mutex` symbol (`*_mutex`), `rt_mutex` symbol (`*_rt_mutex`), or
  write-locked `mmap_lock` (`mmap_lock:W` / `lock_held_write(mmap_lock)`),
  evaluating them purely via direct `owner` inspection (Namhyung).
- Use a CO-RE flavor struct `struct mutex___non_rt` in `get_lock_owner()`
  in `lock_data.h` so `GEN_VMLINUX_H=1` builds succeed on
  `CONFIG_PREEMPT_RT=y` kernels.
- Switch `held_locks` to `BPF_MAP_TYPE_LRU_HASH`, exclude `LOCK_PROG_SEM`
  from `LOCK_PROG_ALL` unless `semaphore` or a `*_sem` symbol is
  explicitly requested, and document cross-task semaphore signaling
  limitations (and comparison with `CONFIG_DEPT`).
- Skip `LCB_F_MUTEX | LCB_F_SPIN` in `parse_lock_type_name()`, reject
  read-only mode on exclusive-only lock symbol suffixes in
  `resolve_lock_expr()`, and check `needed_groups & supported_groups`
  before masking `needed_groups` in `configure_lock_progs()`.
- Recursively traverse anonymous structs/unions in `btf_has_task_field()`
  so `lock_held(rcu)` and `lock_held(rcu-trace)` work on
  `CONFIG_RANDSTRUCT` kernels.

Changes in v3:
- Move the writer-only `rw_semaphore` check out of `get_lock_owner()` in
  `lock_data.h` into `is_rwsem_writer_owner()` in `sample_filter.bpf.c`
  so `perf lock contention -b -o` still reports reader owners when a
  writer contends on a reader-owned `rw_semaphore`, and scope
  `is_direct_lock_owner()` by lock type (`PBF_LOCK_DIRECT_MUTEX`,
  `PBF_LOCK_DIRECT_RWSEM`, `PBF_LOCK_DIRECT_RTMUTEX`).
- Add `SEC("tracepoint") int perf_tp_sample_filter(void *ctx)` so BPF
  sample filters (`lock_held()`, `uid`, `gid`, etc.) can attach to
  `PERF_TYPE_TRACEPOINT` events (such as `kmem:mm_page_alloc` and
  `vmscan:mm_vmscan_direct_reclaim_begin`), check `libbpf_get_error()`
  when attaching, and document memory allocation / direct reclaim
  filtering with `lock_held()`.
- Return early in `init_numa_data()` in `bpf-filter.c` when `node_data`
  cannot be resolved and check `node_data_addr != 0` in
  `do_collect_zone_lock()`.
- Avoid double-counting `_raw_read_lock_irq` / `_raw_read_lock_bh` in
  `sample_filter.bpf.c` on `CONFIG_GENERIC_LOCKBREAK=y &&
  !CONFIG_DEBUG_LOCK_ALLOC` kernels where they call
  `_raw_read_lock_irqsave()`.
- Offset `rcu_state_addr` by 1 byte so it is distinct from
  `&rcu_state.node[0].lock` at offset 0 of `rcu_state`, and pass `bool
  is_rcu` to `do_contention_end()` in `lock_contention.bpf.c` so
  `tp_btf/contention_end` and RCU/SRCU `fexit` hooks never cross-match
  timestamp maps.

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
- Add patch fixing `report_lock_contention_begin_event()` to check
  type, address, and callstack filters before creating `lock_stat`
  entries.

Assisted-by: Antigravity:gemini-3.1-pro

Ian Rogers (8):
  perf lock contention: Filter events before creating lock_stat
  perf bpf-filter: Fix bpf_link leak by using PERF_EVENT_IOC_SET_BPF
  perf bpf-filter: Support BPF sample filters on tracepoint events
  perf lock contention: Share common BPF and lock type definitions in
    lock_data.h
  perf bpf-filter: Add lock_held() sample filter
  perf test: Add tests for lock_held() BPF sample filter
  perf bpf-filter: Extend lock_held() to support RCU, Tasks Trace RCU,
    and SRCU
  perf lock contention: Extend BPF lock contention to RCU and SRCU

 tools/perf/Documentation/perf-lock.txt        |    7 +-
 tools/perf/Documentation/perf-record.txt      |   66 +-
 tools/perf/builtin-lock.c                     |   88 +-
 tools/perf/tests/parse-events.c               |  121 ++
 tools/perf/tests/shell/lock_contention.sh     |   14 +
 tools/perf/tests/shell/record_bpf_filter.sh   |  142 ++
 tools/perf/util/bpf-filter.c                  | 1417 ++++++++++++++++-
 tools/perf/util/bpf-filter.h                  |   13 +
 tools/perf/util/bpf-filter.l                  |   31 +-
 tools/perf/util/bpf-filter.y                  |   47 +-
 tools/perf/util/bpf_lock_contention.c         |  171 +-
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  448 +++---
 tools/perf/util/bpf_skel/lock_data.h          |  385 ++++-
 tools/perf/util/bpf_skel/sample-filter.h      |   80 +
 tools/perf/util/bpf_skel/sample_filter.bpf.c  | 1241 +++++++++++++++
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |    7 +
 tools/perf/util/lock-contention.c             |   23 +
 tools/perf/util/lock-contention.h             |   15 +
 tools/perf/util/machine.c                     |   11 +
 tools/perf/util/parse-events.c                |    3 +-
 20 files changed, 3937 insertions(+), 393 deletions(-)

-- 
2.56.0.212.g129ede20d9-goog

