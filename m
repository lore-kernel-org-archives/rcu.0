Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48CD47F2D1;
	Mon, 19 Oct 2026 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393259; cv=none; b=VK5FJJY4cEZICOLkHO5N5/ciKwtbG1Z9IQAYvTcBIru0RcfOuTnltMGr3NmiX/6Sw/5QbbyFe6GoxaIaBcBvlieEjtfg8i2M5cgdEakIsdVNK/aLViURpt6XUAg8MaEcT4Tc+ahTXzTjMFOFFLdRdfi5Ok8nkAxyqLxQXp8P5ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393259; c=relaxed/simple;
	bh=lmf1l6RMAuNPSACVzdfAOmPqOBgNn10PJwdnLs7abzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFqOh+mWtovSW5V9IBUcF2XgDfkQs5gTPyaj5h9LopwkEGWy/rpPENkJ1n/JwnTL1OAK476EecvYsZ6YeRhWfXvE6co62UpuHn3yMWXxoqiSPpyJJKxS+CYvnLPCBZ1SRN/Y6CafTyKIlBueWH4uSW2BEDLiVEjZOCe1TyfjaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vfrn5aK8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vfrn5aK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67BA1F000C4;
	Mon, 19 Oct 2026 07:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792393257;
	bh=ioyI8Oq0pOeBpMOUrxgYFO/bGmu6pBTLTYcXOY5fj8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vfrn5aK89mCRaN7vRbtv96nso7z5YUmaKII6+jiZHmGc3fAsctjnC+tz1o6gfc4pW
	 mc31CN3EMHrojkLkpaMlzy+6IdEiljJL+CLpgnWAjtm1RoxhIy+A1XmYJLv81RAlGv
	 4GGqbBE7o2nYBpzeMQ0N0DMGkOXopExklsmigeVXKODBiLPs9n78HUNZvoSdwLy1GO
	 qmK+hJR8GQI/2pIjKFW5nSSytziKblj9iyVBl1V/jkzFVBhGyBp27blj+t9i4XhJ0S
	 4uOaLl+DGHHKK+EoRsLt4OSKOfFa5RIJ7hwnirk0Eh3T/aRb3RS+g03jzArCojy6MP
	 EGsVhZplRttdw==
Date: Mon, 19 Oct 2026 00:00:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3 0/6] perf bpf-filter / lock contention: Add
 lock_held() sample filter and RCU/SRCU support
Message-ID: <atXAJ4FMCq21dPmn@z2>
References: <20261017171437.2066343-1-irogers@google.com>
 <20261018053710.2572636-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261018053710.2572636-1-irogers@google.com>

Hi Ian,

On Sat, Oct 17, 2026 at 10:37:04PM -0700, Ian Rogers wrote:
> This series adds a new BPF sample filter predicate, `lock_held(<lock>)`
> (along with `lock_held_read(<lock>)` / `lock_held_shared(<lock>)`,
> `lock_held_write(<lock>)` / `lock_held_exclusive(<lock>)`, and `:R` / `:W`
> mode suffixes), to `perf record --filter`, allowing perf event samples to
> be recorded only when a specified kernel lock is held (or not held with
> `!`) by the running kernel thread or CPU. It also extends both
> `lock_held()` and `perf lock contention --use-bpf` to support RCU and
> SRCU, and fixes a pre-existing `lock_stat` filtering bug in `perf lock
> contention`.

Awesome!  Looks really useful!

> 
> For example:
> 
>   # perf record -a -g -e cycles --filter 'lock_held(&cgroup_mutex)' -- ...
>   # perf record -a -g -e cycles --filter 'lock_held_read(&mmap_lock)' -- ...
>   # perf record -a -g -e cycles --filter 'lock_held(&mmap_lock:W)' -- ...
>   # perf record -a -g -e cycles --filter 'lock_held_read(rcu)' -- ...
>   # perf lock contention -a -b -Y rcu,srcu -- sleep 1
> 
> An important use-case is detecting memory allocations or direct memory
> reclaim occurring while kernel locks are held, which can stall lock
> waiters for extended periods under memory pressure:
> 
>   # Direct memory reclaim triggered while holding any mutex or rwsem:
>   # perf record -a -g -e vmscan:mm_vmscan_direct_reclaim_begin \
>       --filter 'lock_held(mutex) || lock_held(rwsem)' -- ...
> 
>   # Page allocations permitted to enter direct reclaim (__GFP_DIRECT_RECLAIM)
>   # while holding a mutex or rwsem:
>   # perf record -a -g -e kmem:mm_page_alloc \
>       --filter 'gfp_flags & 0x400' \
>       --filter 'lock_held(mutex) || lock_held(rwsem)' -- ...

It seems the first filter is processed by the kernel tracepoint
filtering logic and the second is passed to the BPF filter, right?
Does the ordering matter?

> 
>   # Major page faults occurring while holding a mutex or rwsem:
>   # perf record -a -g -e major-faults \
>       --filter 'lock_held(mutex) || lock_held(rwsem)' -- ...
> 
> Supported `<lock>` specifications match `perf lock contention`:
> - Global/static kernel lock symbols (with or without leading `&`, e.g.
>   `lock_held(&cgroup_mutex)` or `lock_held(cgroup_mutex)`)

It used to have no '&' for global locks.  While having it is more
natural, I think it's better to leave it for slab locks so that we can
distinguish them easily.


> - Hexadecimal kernel lock addresses
> - Slab cache names prefixed with `&` (e.g. `lock_held(&dentry)`,
>   `lock_held_read(&dentry)`)
> - Well-known per-process, semi-global, and RCU locks: `mmap_lock`,
>   `siglock`, `rq_lock`, `zone_lock`, `rcu`, `rcu-trace`
> - Lock types and flags: `mutex`, `spinlock`, `rwsem`, `rwsem:R`,
>   `rwsem:W`, `rwlock`, `rwlock:R`, `rwlock:W`, `rt-mutex`,
>   `percpu-rwsem`, `pcpu-sem:W`, `srcu`, `srcu:R`, `srcu:W`, `rcu:R`,
>   `rcu:W`, `semaphore`
> 
> Limitations and weaknesses in determining whether a lock is held:
> - Inlined lock/unlock operations:
>   - When the kernel is configured to inline spinlock or rwlock operations
>     (`CONFIG_INLINE_SPIN_LOCK`, `CONFIG_INLINE_READ_LOCK`,
>     `CONFIG_INLINE_WRITE_LOCK`, `!CONFIG_UNINLINE_SPIN_UNLOCK`,
>     `CONFIG_INLINE_*_UNLOCK*`, etc.), `_raw_spin_lock*` /
>     `_raw_spin_unlock*` and `_raw_read_lock*` / `_raw_write_lock*` are
>     inlined into callers and have no BTF function entry points for
>     `fentry`/`fexit` to attach to. `configure_lock_progs()` verifies that
>     both acquire and release entry points exist in BTF before enabling a
>     lock family.
>   - Fast-path `percpu_down_read()` / `percpu_up_read()` and
>     `srcu_read_lock_fast()` / `srcu_read_unlock_fast()` are inlined
>     per-CPU counter increments without function calls, so only
>     `percpu_down_write()` / `percpu_up_write()` and out-of-line
>     `__srcu_read_lock*()` / `__srcu_read_unlock*()` can be hooked.
>   - On `!CONFIG_PREEMPT_RCU` kernels, `rcu_read_lock()` compiles to
>     `preempt_disable()` and does not maintain
>     `current->rcu_read_lock_nesting` in `task_struct`, so `lock_held(rcu)`
>     read-side inspection requires `CONFIG_PREEMPT_RCU`.

Looks ok.  What happens if user specified unsupported locks - e.g. rcu:R
on !CONFIG_PREEMPT_RCU.


> - Lack of an inspectable owner field on non-exclusive / spinning locks:
>   - While `struct mutex`, `struct rt_mutex`, and write-locked
>     `struct rw_semaphore` store the owning `task_struct *` in `lock->owner`
>     (allowing `perf_sample_filter` to inspect kernel memory directly on
>     sample overflow when filtering by lock address), spinlocks, rwlocks,
>     semaphores, SRCU, and reader-locked `rw_semaphore`s (where
>     `__up_read()` does not clear `sem->owner` when `!CONFIG_DEBUG_RWSEMS`)
>     do not maintain an authoritative per-task owner pointer.

So do you use the owner field for the supported locks?  Then maybe it
can skip tracing mutex_lock() and mutex_unlock().  Does it already do?


>   - Tracking these locks (as well as slab-cache and lock-type filters)
>     relies on `fexit` (acquire) and `fentry` (release) BPF hooks
>     maintaining the `held_locks` BPF hash map:
>     - Any such lock already held before `perf record` attaches its BPF
>       programs will not be present in `held_locks` until it is released
>       and re-acquired.

Right, but this can be mitigated when it runs for long.


>     - The attached `fentry`/`fexit` hooks execute on every kernel lock
>       acquire and release for the hooked lock family across the system,
>       adding tracing overhead outside of perf sample handling.

This is a real problem.  As it touches the fastpath it can cause a lot
of overhead if locking is frequent.  But having this capability would be
very useful anyway!

Thanks,
Namhyung

> 
> Patch overview:
> 1. "perf lock contention: Share common BPF and lock type definitions in
>    lock_data.h": Moves `lock_type_table` to `util/lock-contention.c` and
>    `LCB_F_*` flags, CO-RE structs, and common BPF lock helpers
>    (`get_lock_owner`, `get_current_mmap_lock`, `get_current_siglock`,
>    `get_lock_addr`, `check_lock_type`, `do_collect_lock_syms`,
>    `do_slab_cache_iter`) into `tools/perf/util/bpf_skel/lock_data.h`.
> 2. "perf bpf-filter: Add lock_held() sample filter": Implements
>    `lock_held()`, `lock_held_read()`/`lock_held_shared()`,
>    `lock_held_write()`/`lock_held_exclusive()`, and `:R`/`:W` mode
>    suffixes using direct lock owner inspection where possible (`mutex`,
>    `rt_mutex`, write-locked `rw_semaphore`) and a `held_locks` BPF map
>    updated by selectively attached `fentry`/`fexit` hooks, supporting
>    both PMU/software events (`SEC("perf_event")`) and tracepoint events
>    (`SEC("tracepoint")`).
> 3. "perf test: Add tests for lock_held() BPF sample filter": Adds unit
>    tests in `tests/parse-events.c` and shell tests in
>    `tests/shell/record_bpf_filter.sh`.
> 4. "perf bpf-filter: Extend lock_held() to support RCU, Tasks Trace RCU,
>    and SRCU": Supports `rcu` (`rcu:R` via direct
>    `current->rcu_read_lock_nesting` inspection with zero tracing hooks;
>    `rcu:W` via `synchronize_rcu*()` / `rcu_barrier()` hooks),
>    `rcu-trace` (via `current->trc_reader_nesting`), and `srcu`
>    (`srcu:R` via `__srcu_read_lock*` / `__srcu_read_unlock*`; `srcu:W`
>    via `synchronize_srcu*()` / `srcu_barrier()`).
> 5. "perf lock contention: Extend BPF lock contention to RCU and SRCU":
>    Extends `perf lock contention --use-bpf` to track RCU and SRCU
>    grace-period and barrier waits (`-Y rcu`, `-Y srcu`, `-L rcu`).
> 6. "perf lock contention: Filter events before creating lock_stat":
>    Fixes `report_lock_contention_begin_event()` in `builtin-lock.c` to
>    apply `-Y`, `-L`, and `-S` filters before calling
>    `lock_stat_findnew()`.
> 
> Changes in v3:
> - Move the writer-only `rw_semaphore` check out of `get_lock_owner()` in
>   `lock_data.h` into `is_rwsem_writer_owner()` in `sample_filter.bpf.c`
>   so `perf lock contention -b -o` still reports reader owners when a
>   writer contends on a reader-owned `rw_semaphore`, and scope
>   `is_direct_lock_owner()` by lock type (`PBF_LOCK_DIRECT_MUTEX`,
>   `PBF_LOCK_DIRECT_RWSEM`, `PBF_LOCK_DIRECT_RTMUTEX`).
> - Add `SEC("tracepoint") int perf_tp_sample_filter(void *ctx)` so BPF
>   sample filters (`lock_held()`, `uid`, `gid`, etc.) can attach to
>   `PERF_TYPE_TRACEPOINT` events (such as `kmem:mm_page_alloc` and
>   `vmscan:mm_vmscan_direct_reclaim_begin`), check `libbpf_get_error()`
>   when attaching, and document memory allocation / direct reclaim
>   filtering with `lock_held()`.
> - Return early in `init_numa_data()` in `bpf-filter.c` when `node_data`
>   cannot be resolved and check `node_data_addr != 0` in
>   `do_collect_zone_lock()`.
> - Avoid double-counting `_raw_read_lock_irq` / `_raw_read_lock_bh` in
>   `sample_filter.bpf.c` on `CONFIG_GENERIC_LOCKBREAK=y &&
>   !CONFIG_DEBUG_LOCK_ALLOC` kernels where they call
>   `_raw_read_lock_irqsave()`.
> - Offset `rcu_state_addr` by 1 byte so it is distinct from
>   `&rcu_state.node[0].lock` at offset 0 of `rcu_state`, and pass `bool
>   is_rcu` to `do_contention_end()` in `lock_contention.bpf.c` so
>   `tp_btf/contention_end` and RCU/SRCU `fexit` hooks never cross-match
>   timestamp maps.
> 
> Changes in v2:
> - Guard `BPF_CORE_READ(mutex, owner.counter)` with `bpf_core_field_exists`
>   and fall back to `struct rt_mutex_base` in `get_lock_owner()` so CO-RE
>   relocation succeeds on `CONFIG_PREEMPT_RT=y` kernels.
> - Add `CONFIG_DEBUG_LOCK_ALLOC=y` lock entry points
>   (`_mutex_lock_nest_lock`, `_mutex_lock_killable`,
>   `_mutex_trylock_nest_lock`, `_down_write_nest_lock`,
>   `_raw_spin_lock_nest_lock`, `_rt_mutex_lock_nest_lock`) to
>   `sample_filter.bpf.c` and `lock_progs[]`.
> - Verify in `supported_lock_prog_groups()` that both acquire and all
>   unlock BTF entry points exist for a lock family before enabling its
>   tracing hooks, preventing acquire-only attachment when spinlock/rwlock
>   unlock functions are inlined.
> - Enable `LOCK_PROG_PERCPU_RWSEM` alongside `LOCK_PROG_RWSEM_WRITE` when
>   a symbol name ends in `rwsem` (such as `cgroup_threadgroup_rwsem`).
> - Gate `record_lock_acquired(ctx, LCB_F_READ)` in `fexit_downgrade_write`
>   on `track_rwsem_read` and verify non-zero read/write counts in
>   `record_lock_released_addr()` before decrementing aggregate slab/type
>   counts.
> - Adjust stack skip depth by 2 for `fentry` RCU/SRCU programs in
>   `lock_contention.bpf.c` and recognize `synchronize_rcu*`,
>   `synchronize_srcu*`, `rcu_barrier`, and `srcu_barrier` in
>   `machine__is_lock_function()`.
> - Add patch 6 fixing `report_lock_contention_begin_event()` to check
>   type, address, and callstack filters before creating `lock_stat`
>   entries.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> 
> Ian Rogers (6):
>   perf lock contention: Share common BPF and lock type definitions in
>     lock_data.h
>   perf bpf-filter: Add lock_held() sample filter
>   perf test: Add tests for lock_held() BPF sample filter
>   perf bpf-filter: Extend lock_held() to support RCU, Tasks Trace RCU,
>     and SRCU
>   perf lock contention: Extend BPF lock contention to RCU and SRCU
>   perf lock contention: Filter events before creating lock_stat
> 
>  tools/perf/Documentation/perf-lock.txt        |    7 +-
>  tools/perf/Documentation/perf-record.txt      |   64 +-
>  tools/perf/builtin-lock.c                     |   88 +-
>  tools/perf/tests/parse-events.c               |  121 ++
>  tools/perf/tests/shell/lock_contention.sh     |   14 +
>  tools/perf/tests/shell/record_bpf_filter.sh   |  134 ++
>  tools/perf/util/bpf-filter.c                  | 1271 ++++++++++++++++-
>  tools/perf/util/bpf-filter.h                  |   13 +
>  tools/perf/util/bpf-filter.l                  |   31 +-
>  tools/perf/util/bpf-filter.y                  |   46 +-
>  tools/perf/util/bpf_lock_contention.c         |  171 ++-
>  .../perf/util/bpf_skel/lock_contention.bpf.c  |  448 +++---
>  tools/perf/util/bpf_skel/lock_data.h          |  360 ++++-
>  tools/perf/util/bpf_skel/sample-filter.h      |   77 +
>  tools/perf/util/bpf_skel/sample_filter.bpf.c  | 1225 ++++++++++++++++
>  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |    7 +
>  tools/perf/util/lock-contention.c             |   22 +
>  tools/perf/util/lock-contention.h             |   15 +
>  tools/perf/util/machine.c                     |   11 +
>  tools/perf/util/parse-events.c                |    3 +-
>  20 files changed, 3741 insertions(+), 387 deletions(-)
> 
> -- 
> 2.56.0.212.g129ede20d9-goog
> 
