Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6AC390204
	for <rcu@vger.kernel.org>; Sat, 17 Oct 2026 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215986; cv=none; b=OoDc226R+y49Dld5Th+KNH5Jbw98xwRQCINNHKd8sZBXQHhUsq5YnXe8axTPYNGCkKVfqP9LYpg28/AatlpnmVMqcWX4TJVl82WbdF9zpYbjCJoUF+9QDCRRAjz9mg8yA/gfcbfMhsIzKQW9SYdyZ4FPIz/QR5QOyl8XMhYcRPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215986; c=relaxed/simple;
	bh=oRoToiON3ZaD1lI1MPyxw1i6r2WmBIZ4K/66dw+svII=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CgLrUWkRxJdBd3Ag04o1feveX20bndQ8BDbq+C2o2U8dufM2POt37Qae8BhGJGfYKuuVPoEQwZhQhdFndtlEROeTdKL1BfSey5EZJSGF+Y20yENRavH9TP8dj4KtLe/6YYOLTccZ7fEyqZpcKbh7QLfFOr8s8OmASiCb4S8sH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HutJpr3j; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HutJpr3j"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1058072eec.1
        for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 22:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792215984; x=1792820784; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K2jhVCppV5GQjYVL/RGnDCx4V2eYYpWesrsS42HkL+s=;
        b=HutJpr3jf8WwlM23vnCv7Q8QNXwA8nIH7WxGGo2ulAwfBkWDkXrAtU7zju4lQ/KAuF
         JNuc8wjAGKGyUyLuUOZAhAtpNNl0CBT63jUkmAW40C9kIhAkUxUcjpdGE3YsDc8Gfr1n
         72rn2R0TjcJRWJFCpodgUAUGb6JG4UmxGIeDtiQOTNtWpObIbbs60bOPI5VfwbhJzl1L
         fqWFKCuNDowMi9NivBeN6r9U7bNySEZjoyd3tE8ujqjGtAIb2pyhZPHh/Uciuu3mPA0q
         ksup4tOvP6PryrsABbFsECnBeRfgKRFh04XhNELFAs9pEptdTXmVanoiWtQpmyHJdPID
         tHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792215984; x=1792820784;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K2jhVCppV5GQjYVL/RGnDCx4V2eYYpWesrsS42HkL+s=;
        b=d5AM5+R3Ddm7UwoUCfQNKu72hUt9PTI10RLa2Lia3PX3DkjmAF9e8rdboLYnj6m/67
         CxriAs6OBgCoSaqhnx0YrnhCbuxdcAkTAAbUEwQHrHmo1Q4XrDJoeNtNgXlmd3p0oJc0
         O8y7iTtSMifMmxxcqNky+ezue/s3NX1iH6O3hY5lWyGIRYIf0c83UMzxJocKXfap+LnE
         wkBqZpiw/Q1xBc+9LAwUgpTgb+6ugC1xbWmpWoL9H88SBf1imaZBbVOz9S7cyba5w8bx
         0bJp2NKuuqPmSSkl+dQ96podxsyAyuCWPS2tOeIUgxuiRH/UcDj9rzYb7jc3Uf+MWWXd
         6mNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzY2dKx2aCyBcomm/oMtk9b32Ae0Zw7pk9snqP4F/DZf38VRW3AVqxNQWcczM8LYKzIfqA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpuw3pCFbVEj6D4jeSM4KU5bQeOPHJQJGSn/FMLiDEaPloFyzL
	g9H55hExDRpXgfrtiQqR2D1OboDw8F4AFd9LBwy72Q0i6Ps3DuJ0l7ExTLzfw01K3RkZh640Enm
	RfPHpw72Apg==
X-Received: from dyp23.prod.google.com ([2002:a05:693c:65d7:b0:343:520f:7a80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:424a:b0:35b:9bd:1435
 with SMTP id 5a478bee46e88-3619ea236e5mr2314060eec.2.1792215983849; Fri, 16
 Oct 2026 22:46:23 -0700 (PDT)
Date: Fri, 16 Oct 2026 22:45:50 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261017054555.1655407-1-irogers@google.com>
Subject: [PATCH v1 0/5] perf bpf-filter / lock contention: Add lock_held()
 sample filter and RCU/SRCU support
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series adds a new BPF sample filter predicate, `lock_held(<lock>)`
(along with `lock_held_read(<lock>)` / `lock_held_shared(<lock>)`,
`lock_held_write(<lock>)` / `lock_held_exclusive(<lock>)`, and `:R` / `:W`
mode suffixes), to `perf record --filter`, allowing perf event samples to
be recorded only when a specified kernel lock is held (or not held with
`!`) by the running kernel thread or CPU. It also extends both
`lock_held()` and `perf lock contention --use-bpf` to support RCU and
SRCU.

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
    `CONFIG_INLINE_WRITE_LOCK`, etc., which are enabled on many
    `!CONFIG_PREEMPT_RT` / `!CONFIG_PROVE_LOCKING` builds unless
    `CONFIG_UNINLINE_SPIN_UNLOCK` or lockdep/preemption forces them out of
    line), `_raw_spin_lock*` / `_raw_spin_unlock*` and
    `_raw_read_lock*` / `_raw_write_lock*` are inlined into callers and
    have no BTF function entry points for `fentry`/`fexit` to attach to.
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

Assisted-by: Antigravity:gemini-3.1-pro

Ian Rogers (5):
  perf lock contention: Share common BPF and lock type definitions in
    lock_data.h
  perf bpf-filter: Add lock_held() sample filter
  perf test: Add tests for lock_held() BPF sample filter
  perf bpf-filter: Extend lock_held() to support RCU, Tasks Trace RCU,
    and SRCU
  perf lock contention: Extend BPF lock contention to RCU and SRCU

 tools/perf/Documentation/perf-lock.txt        |    7 +-
 tools/perf/Documentation/perf-record.txt      |   51 +-
 tools/perf/builtin-lock.c                     |   27 -
 tools/perf/tests/parse-events.c               |  121 ++
 tools/perf/tests/shell/lock_contention.sh     |   14 +
 tools/perf/tests/shell/record_bpf_filter.sh   |  119 ++
 tools/perf/util/bpf-filter.c                  | 1070 ++++++++++++++++-
 tools/perf/util/bpf-filter.h                  |   13 +
 tools/perf/util/bpf-filter.l                  |   31 +-
 tools/perf/util/bpf-filter.y                  |   46 +-
 tools/perf/util/bpf_lock_contention.c         |  167 ++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  410 +++----
 tools/perf/util/bpf_skel/lock_data.h          |  360 +++++-
 tools/perf/util/bpf_skel/sample-filter.h      |   71 ++
 tools/perf/util/bpf_skel/sample_filter.bpf.c  | 1051 ++++++++++++++++
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |    7 +
 tools/perf/util/lock-contention.c             |   22 +
 tools/perf/util/lock-contention.h             |   15 +
 tools/perf/util/parse-events.c                |    3 +-
 19 files changed, 3273 insertions(+), 332 deletions(-)

-- 
2.56.0.212.g129ede20d9-goog

