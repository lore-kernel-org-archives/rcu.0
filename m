Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447764;
	b=dAdj4uxf4jCXorqKt5N4lG3uU9dlFzE8A6srIg9ORkBnanP6B6Ldq/kZcy53fxorzOIt
	 3i687mn3zWS0B+b8ZLUdZOWmPd4dxIHSNFTM3H/wJCjY1njIuKrpp5GdtVIesgTjJyaIq
	 FSa+6pzBfYhfR71d+3+2fdvBSoKKJNYlvrmr97AIz66LTtty2pfVGFOFmhbhD8AKYqSfP
	 pxZVMuGbx1GKT8qIZVA8pCCZsNI/Q4ZZxXNk9w8WarGEh5Ub8/Yla8x7jfyPViafE0031
	 +wR8l2A0XhpVyhUMoNvAR/apG64ONf+sZ6e/FHhHBzpdozugLGLWBXX6f1Nl42DTSDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=akm/ireGVJg065LIbn5Wb7GkmLXuYYWuliMk1Wj5Fes=;
	b=dAmcZMLrjDr5PmwndR+XyAsfGLAXkkS2ytkz4WtUC9b3e03vgGVfYySa8wpopjop7YWz
	 9kk4ViP12mXmjXl5l36JA07zRY5wASE6mKC/rwT9M//XEiX70A8EoGtIL/ryd1Exvfmot
	 bPbOt4C8/bnB5p9VxGXOLFMcddDawFdopsAcJLLKEdO3DEfa+fqvCeDYDvUIfdSLrnKnw
	 SKLfdPeNCu5HJAJzvgTF4djv3wDJcaXXhmCzDDJQPb3nBeXRJ0N/+jorJRrd/tVR6RCU2
	 q5c/G5bbLI+Xr8keBuZTDL6QYXnxlpIAjSgkQ8LS2kptizd7KVgMJgVaz3P7/i+1X6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=P2N8wFYH;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D03606A31B
	for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 22:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5D03606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=P2N8wFYH
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so7623641eec.1
        for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 15:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792447763; x=1793052563; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=akm/ireGVJg065LIbn5Wb7GkmLXuYYWuliMk1Wj5Fes=;
        b=P2N8wFYHTzwnW8xn7RYsLnmOzYDpBmx9QMJpr6VoKSFHa2L0F0OXCDrD3qFK/9FnFr
         /2oS+uJm4ZgQr9BJlR17wx7ABAp5XQ/H6AjcMoguAVGYIvY/wKYJ2OPoPgTcNwsWCeQl
         Jt00m122cW/ynL+IIR8wlsUvfJOLVti1qCFU/e9fEdmSns6+W5Ni2D7FRSSIPWQ8fcpd
         EYOGAYLtVk8lC7230eIK2vfMvRDvOROYRbTePUnGerANCVc/N+DS4ZCBEmhrnU576mpL
         XdRa9YUJrYIV6Yc21P0LWzm0LRqQE4AEyrdY9yQ1gvFZYjTWGU8h1emDcHsYKtIfR5cW
         XOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792447763; x=1793052563;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=akm/ireGVJg065LIbn5Wb7GkmLXuYYWuliMk1Wj5Fes=;
        b=oDdjD9ajVWHL3Lvk2eA69PgCSur2IxlVDqbvrjfQ+cg0escRBWeNPCSlxB/qRhrFp3
         uW8v5dwbHzAsZjzSi1/3cL8/UGS4oFncq9rlho4Y8wx7pb44fvJvqC+ybkIQ7FOnQb+S
         fRyRbold7WvJky/LU8OIVHzut5ly69AyNrLDDDPBm9f1QkPQzeTtpWEbFVIJXbCUZS6Z
         9HRHO3FswEhif3haz9kD1R/eD/krI4Oao+gw4Flu85AoV8SngvIlxhe7+f9S7TPT/tpz
         bsi2KE+D7YGOnS53Suv+jsV7zTPTiVGi4RFe9W4Grt/XitrgbYiIlKDAFPpsTkAINSrl
         cQ5A==
X-Forwarded-Encrypted: i=1; AKwUvBzfk7a6skquKENaqyFTW6av53sJ/arK/wjwKvvTHfS1VekeIBI1FJ9y52KqMaUBwTM6Ndc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlyNIm3rXu87PsR+8VVK5tmext8snfabLuJRJtolzk5yAGSpTO
	Rxs337XCukWjO/RMwHD+f7Gkejnp34ubId66EpFNdC1bOLag4w5eOFPmUIY8CzYexQ6+/8osVpW
	9V8X3X+DRnw==
X-Received: from dyuq10.prod.google.com ([2002:a05:693c:66ca:b0:351:6b0d:f5c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6195:10b0:361:6884:78b1
 with SMTP id 5a478bee46e88-361a253f345mr12695833eec.28.1792447762374; Mon, 19
 Oct 2026 15:09:22 -0700 (PDT)
Date: Mon, 19 Oct 2026 15:09:08 -0700
In-Reply-To: <20261018053710.2572636-1-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261018053710.2572636-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019220915.3943592-1-irogers@google.com>
Subject: [PATCH v4 0/7] perf bpf-filter / lock contention: Add lock_held()
 sample filter and RCU/SRCU support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, eranian@google.com, 
	ddhariwal@google.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series adds a new BPF sample filter predicate, `lock_held(<lock>)`
(along with `lock_held_read(<lock>)` / `lock_held_shared(<lock>)`,
`lock_held_write(<lock>)` / `lock_held_exclusive(<lock>)`, and `:R` / `:W`
mode suffixes), to `perf record --filter`, allowing perf event samples to
be recorded only when a specified kernel lock is held (or not held with
`!`) by the running kernel thread or CPU. It also fixes a pre-existing
`lock_stat` filtering bug in `perf lock contention`, enables BPF sample
filters on tracepoint events (`PERF_TYPE_TRACEPOINT`), and extends both
`lock_held()` and `perf lock contention --use-bpf` to support RCU and
SRCU.

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

Patch overview (patches 1 and 2 are standalone fixes independent of the
rest of the series):
1. "perf lock contention: Filter events before creating lock_stat":
   Fixes `report_lock_contention_begin_event()` in `builtin-lock.c` to
   apply `-Y`, `-L`, and `-S` filters before calling
   `lock_stat_findnew()`.
2. "perf bpf-filter: Support BPF sample filters on tracepoint events":
   Adds `SEC("tracepoint") int perf_tp_sample_filter(void *ctx)` so BPF
   sample filters can attach to `PERF_TYPE_TRACEPOINT` events (where
   `__perf_event_set_bpf_prog()` in `kernel/events/core.c` requires
   `BPF_PROG_TYPE_TRACEPOINT` rather than `BPF_PROG_TYPE_PERF_EVENT`).
3. "perf lock contention: Share common BPF and lock type definitions in
   lock_data.h": Moves `lock_type_table` to `util/lock-contention.c` and
   `LCB_F_*` flags, CO-RE structs, and common BPF lock helpers
   (`get_lock_owner`, `get_current_mmap_lock`, `get_current_siglock`,
   `get_lock_addr`, `check_lock_type`, `do_collect_lock_syms`,
   `do_slab_cache_iter`) into `tools/perf/util/bpf_skel/lock_data.h`.
4. "perf bpf-filter: Add lock_held() sample filter": Implements
   `lock_held()`, `lock_held_read()`/`lock_held_shared()`,
   `lock_held_write()`/`lock_held_exclusive()`, and `:R`/`:W` mode
   suffixes using direct lock owner inspection where possible (`mutex`,
   `rt_mutex`, write-locked `rw_semaphore`) and a `held_locks` BPF LRU
   hash map updated by selectively attached `fentry`/`fexit` hooks.
5. "perf test: Add tests for lock_held() BPF sample filter": Adds unit
   tests in `tests/parse-events.c` and shell tests in
   `tests/shell/record_bpf_filter.sh`.
6. "perf bpf-filter: Extend lock_held() to support RCU, Tasks Trace RCU,
   and SRCU": Supports `rcu` (`rcu:R` via direct
   `current->rcu_read_lock_nesting` inspection with zero tracing hooks;
   `rcu:W` via `synchronize_rcu*()` / `rcu_barrier()` hooks),
   `rcu-trace` (via `current->trc_reader_nesting`), and `srcu`
   (`srcu:R` via `__srcu_read_lock*` / `__srcu_read_unlock*`; `srcu:W`
   via `synchronize_srcu*()` / `srcu_barrier()`).
7. "perf lock contention: Extend BPF lock contention to RCU and SRCU":
   Extends `perf lock contention --use-bpf` to track RCU and SRCU
   grace-period and barrier waits (`-Y rcu`, `-Y srcu`, `-L rcu`).

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
  `resolve_lock_expr()`, check `needed_groups & supported_groups` before
  masking `needed_groups` in `configure_lock_progs()`, and store
  `skel->links.perf_tp_sample_filter` so `sample_filter_bpf__destroy()`
  cleans up the tracepoint BPF link.
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

Ian Rogers (7):
  perf lock contention: Filter events before creating lock_stat
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
 tools/perf/util/bpf-filter.c                  | 1300 ++++++++++++++++-
 tools/perf/util/bpf-filter.h                  |   13 +
 tools/perf/util/bpf-filter.l                  |   31 +-
 tools/perf/util/bpf-filter.y                  |   46 +-
 tools/perf/util/bpf_lock_contention.c         |  171 ++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  448 +++---
 tools/perf/util/bpf_skel/lock_data.h          |  364 ++++-
 tools/perf/util/bpf_skel/sample-filter.h      |   77 +
 tools/perf/util/bpf_skel/sample_filter.bpf.c  | 1231 ++++++++++++++++
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |    7 +
 tools/perf/util/lock-contention.c             |   22 +
 tools/perf/util/lock-contention.h             |   15 +
 tools/perf/util/machine.c                     |   11 +
 tools/perf/util/parse-events.c                |    3 +-
 20 files changed, 3790 insertions(+), 387 deletions(-)

-- 
2.56.0.212.g129ede20d9-goog

