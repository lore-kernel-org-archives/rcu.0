Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792436934;
	b=xNS+/1wD0jorIwH4BEi+zgBT/N2jsDjmnO50lCRfg8axrnPy0diKw8EU4JFg7EAq1NTt
	 iXfu59loCKiqLXDdEXgaR92HUN7IjfLZmQ2Ags6HUUGkBguyu/BbIRACHrBYRNdK2ZnPz
	 4whOAF496fBW3XzLsVbwk4btUDm0GRkBZqP8f9oRJLA6cCKQz0lWJhijVe8s42xbUkenJ
	 3r+p+Q958tjycHF36OqgEzJCR2kastllUhpsz79U3Hr3C883slBzfPMDodoNjAtwQMoYd
	 ynnx97mAwHXSjrhTD5NZQ6DvkpV8Q3J1A6wnssO2qOxmOYZ6CL7bs5fEZ2hg8T6D/mQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TYLqhCFDxdbl3oBrmPzHG7SZLF+LHPu2FrQHdibvGHY=;
	b=Ji30ZCHsj3bYWkCAexqhqtvveyS6dRzV1WkbJH35+jKgNhQWowWVcjfKHVN96jDUU0Tm
	 HqTAKTczFNbtgJkgPG27zfsp/gda4F08Ht84oLcxR/Be/276OhT8WBh9DZUNnpi5GVp0D
	 Y6yXefHmF3dBjizG6HRF34hX31mzmnfmATPv372vrUnnMKuiSTrytsL4yaC57SLNORSwU
	 vnvbFvkJB5ZZug6PECXWKU4kTf2lGlTi/wW1uqOe+gWYWkHBMS3I2kGdQYx7e5bEd6wUs
	 VA6wV1YDvZ9hGFFHhYrwTFoN3IHJ56APhZrkRDb8jSpsuzHVaHxAcg7YsTflQ0TjZHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bhu5GQyE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D365606A319
	for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 19:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D365606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bhu5GQyE
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5337fa12431so47911cf.1
        for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 12:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792436933; cv=none;
        d=google.com; s=arc-20260327;
        b=Cp9zP6WyWlBBk59qvGhKuyMhccYbcFu/AzbcvSuQsbHLgSg+cxZ77GsnWVsXCNhL6M
         3eQppxwP87lDVMmm9ZTx/SrXq8Oo8W6Nv/0cdrhblX95yMaxsZNvj1/UQUNx/HY5+Xba
         BpLq2WOG8/D6fIcMcUXwKa2ilnRGf4rtbz+iUth2aDX8iOPQtbfM3a/loQPKF1PpL25i
         NR84C6yMgxv54l0nuRO1LQ8Z+QIfmtiUg1de37iVTAIN82OnxL44hlYq3IhR5TZKaGZ6
         QBo1RK7V1xBbr83CTFUEke1jC2ViTWPaAxnyd0oAWXbJJVkPUDQikon8/ZzcQJKX4FyK
         z9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TYLqhCFDxdbl3oBrmPzHG7SZLF+LHPu2FrQHdibvGHY=;
        fh=OxhQDpvwLr7ORrzV94V2i+MllDtlv1+0S1zp8JvHxi8=;
        b=om1055zebcJjzXUIi9UmAswFhf+3NzAMskg8HtnaDoSRlJLZJLNNHEyDowzMuNha21
         MYdPBFMH3mqIJ6AekuytFsSPceiKLqSB8iV8n36xbYg1lEVzkzYX1PgSBlAIObEVlAzh
         FP3wfow6PLfWTALgdB+DghSyHvS7gi8ChaexsUWUOGDimE4rR7Tdo44ZcZqe+YkpOgUU
         jVtanR/iYDqspMuc86CRsAiiW7l05yZ6p085i+hAuEjTNc0sPobdawTwbpX7UCSpk+Zl
         t1lqSZwQYaQ2WXckEYKhfD+fBuylF9amDjpLwxN64i0sPJuDtnuLulxHoEMRPcitvzUm
         JfRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792436933; x=1793041733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TYLqhCFDxdbl3oBrmPzHG7SZLF+LHPu2FrQHdibvGHY=;
        b=bhu5GQyELWG8LrzKn+cHDyUgJleI9vuALG73QBqqLr/dEJuyNq/4KacAyahR/m027A
         uGA3OqenkAC94xPEAwoWHcE5xKdkVbwRCVo+t7KtK01iO1Shk2VIl8PIQbFu8+SMmlZv
         8glp1MPjaYzFVKI22uc7kKrk20IeV8kcnGpVbwnBu2OjP05jdVNMHD6YzdAi5KDA93Jr
         ZNrh2Utx5RyHl/6zn3oewzJ1eTehEuHFOOVVTFsReq0+2V1nrer7tBUeOrfs12F4MA3y
         0VwdMGoGIO+Egp8hFkBBjGVKCwB8CwEf5qv86/AsOLTksWS1jUIkB5Z/OJs+S1KdKtKT
         1DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436933; x=1793041733;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TYLqhCFDxdbl3oBrmPzHG7SZLF+LHPu2FrQHdibvGHY=;
        b=QCeTvD6AlTYwW8esWol0Qw1lsnSCSlofRquNFmZTq2tIWwUy0FegfecFB+hVgo8iUu
         ZAi9Ol0cVRIzdWI8Er5W6gy4J5FHoS21Ug/7wYKXZkdcSgcDeILbTK8zufbtokG8FY83
         vsE0IKi9a6S7hKQE2C74YsBBaTD3rn65aTBj/S4kV9PRq3iy9xPQJUBu/1UgHn6IYtP/
         wRvpuLBCDW8eHTCZg4CJRu+H8DNIMGM205tQDwcWoILxDH1Dqlxz0ed1Pqf/iUi17Vzx
         L+OrsIJBM3Zi95CGmdtO7YHhFidqkn7b+UlwrTCuTCkv11nI+nwCnZ8/TRqqU2V6e4Hv
         HCtg==
X-Forwarded-Encrypted: i=1; AKwUvBz9xYNgw9HA3uJlZtZQdIgxnzOdweP/eJyzXt/EiEvYfDJe3NXdxR1x5AqYKkHndQpU9gY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2zdouf3nPmDfYEIf7SbxXlsPXQvne1b16gqFY0fLSwiuY6nDx
	P574Km+hAepCOXyyFYIDb43kMf0bfhrMgo/KwT6a9fExt7zth0crQRlNU+nV5LVRoNEA099Mbzc
	ydGwdnwVSd6DXJ7hwhLUXpeIwb+Syd24SWMFeF8ir
X-Gm-Gg: AYBFou0q3DFf21cg48CyV2nmMTQIXobX82jT5qy7KmJ6XYxLko3AQ9VvRF9jz0guEIT
	Bx7zl869lQna/F7ckwZlROjvofluWkFIXDmryI5JF5ZyZvfUealJ8Qt1Z4QdhNFptmCie6nwJrK
	OA9Axx1b1RH23sdSvU7JVi2O6KOntXd4YWEqRcwxd0ShyV0LwnpqUOQaVESCKwvGFBbj8BviEzW
	IVT/WAr1U7gJIWJeuwzk9GJjVIVz3VMIVR3eruByVAX7uqDcWgdYbq2QtzbPHFCDxcBM1sTKkgM
	z+v5ac7dkYxS1w1ipxXBA44HWYxU6tETFH4L4dPtZ0NvQy/BwgDkR1bMxxYZxlt7VGrDH5+F6oi
	1a/TMB291gw==
X-Received: by 2002:a05:622a:1812:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-53684efe942mr2413831cf.10.1792436931830; Mon, 19 Oct 2026
 12:08:51 -0700 (PDT)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017171437.2066343-1-irogers@google.com> <20261018053710.2572636-1-irogers@google.com>
 <atXAJ4FMCq21dPmn@z2>
In-Reply-To: <atXAJ4FMCq21dPmn@z2>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 Oct 2026 12:08:39 -0700
X-Gm-Features: AclHuK-14gBvT4WiHparxImm4R4Mkl5MIfN5JTRnXyklcppa0DC7S-WQYxRiST0
Message-ID: <CAP-5=fVXpt3-O4=rvw_aXBV8uEAD93E6PRaCdoP8b-Epeo3OkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] perf bpf-filter / lock contention: Add lock_held()
 sample filter and RCU/SRCU support
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 12:00=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Sat, Oct 17, 2026 at 10:37:04PM -0700, Ian Rogers wrote:
> > This series adds a new BPF sample filter predicate, `lock_held(<lock>)`
> > (along with `lock_held_read(<lock>)` / `lock_held_shared(<lock>)`,
> > `lock_held_write(<lock>)` / `lock_held_exclusive(<lock>)`, and `:R` / `=
:W`
> > mode suffixes), to `perf record --filter`, allowing perf event samples =
to
> > be recorded only when a specified kernel lock is held (or not held with
> > `!`) by the running kernel thread or CPU. It also extends both
> > `lock_held()` and `perf lock contention --use-bpf` to support RCU and
> > SRCU, and fixes a pre-existing `lock_stat` filtering bug in `perf lock
> > contention`.
>
> Awesome!  Looks really useful!
>
> >
> > For example:
> >
> >   # perf record -a -g -e cycles --filter 'lock_held(&cgroup_mutex)' -- =
...
> >   # perf record -a -g -e cycles --filter 'lock_held_read(&mmap_lock)' -=
- ...
> >   # perf record -a -g -e cycles --filter 'lock_held(&mmap_lock:W)' -- .=
..
> >   # perf record -a -g -e cycles --filter 'lock_held_read(rcu)' -- ...
> >   # perf lock contention -a -b -Y rcu,srcu -- sleep 1
> >
> > An important use-case is detecting memory allocations or direct memory
> > reclaim occurring while kernel locks are held, which can stall lock
> > waiters for extended periods under memory pressure:
> >
> >   # Direct memory reclaim triggered while holding any mutex or rwsem:
> >   # perf record -a -g -e vmscan:mm_vmscan_direct_reclaim_begin \
> >       --filter 'lock_held(mutex) || lock_held(rwsem)' -- ...
> >
> >   # Page allocations permitted to enter direct reclaim (__GFP_DIRECT_RE=
CLAIM)
> >   # while holding a mutex or rwsem:
> >   # perf record -a -g -e kmem:mm_page_alloc \
> >       --filter 'gfp_flags & 0x400' \
> >       --filter 'lock_held(mutex) || lock_held(rwsem)' -- ...
>
> It seems the first filter is processed by the kernel tracepoint
> filtering logic and the second is passed to the BPF filter, right?
> Does the ordering matter?

Right =E2=80=94 set_filter() in util/parse-events.c inspects each --filter
string independently with is_possible_tp_filter(): expressions without
BPF-only terms (uid, gid, lock_held) are appended to evsel->filter
(the kernel tracepoint filter), while expressions with lock_held() are
added to evsel->bpf_filters.

The command-line order of the two --filter options does not matter: in
evlist__apply_filters() both evsel->filter (PERF_EVENT_IOC_SET_FILTER)
and evsel->bpf_filters (PERF_EVENT_IOC_SET_BPF) are applied to the
tracepoint event, and in the kernel (perf_trace_run_bpf_submit() ->
perf_tp_event()) both must match (logical AND) for the sample to be
recorded.

> >
> >   # Major page faults occurring while holding a mutex or rwsem:
> >   # perf record -a -g -e major-faults \
> >       --filter 'lock_held(mutex) || lock_held(rwsem)' -- ...
> >
> > Supported `<lock>` specifications match `perf lock contention`:
> > - Global/static kernel lock symbols (with or without leading `&`, e.g.
> >   `lock_held(&cgroup_mutex)` or `lock_held(cgroup_mutex)`)
>
> It used to have no '&' for global locks.  While having it is more
> natural, I think it's better to leave it for slab locks so that we can
> distinguish them easily.

Good point =E2=80=94 in v4 I updated this so '&' is reserved strictly for s=
lab
cache locks (e.g. lock_held(&dentry)), and global/static lock symbols
and well-known locks do not use '&' (e.g. lock_held(cgroup_mutex),
lock_held_read(mmap_lock)). This also avoids running the kmem_cache
BPF iterator unless a '&<slab>' filter is specified.

> > - Hexadecimal kernel lock addresses
> > - Slab cache names prefixed with `&` (e.g. `lock_held(&dentry)`,
> >   `lock_held_read(&dentry)`)
> > - Well-known per-process, semi-global, and RCU locks: `mmap_lock`,
> >   `siglock`, `rq_lock`, `zone_lock`, `rcu`, `rcu-trace`
> > - Lock types and flags: `mutex`, `spinlock`, `rwsem`, `rwsem:R`,
> >   `rwsem:W`, `rwlock`, `rwlock:R`, `rwlock:W`, `rt-mutex`,
> >   `percpu-rwsem`, `pcpu-sem:W`, `srcu`, `srcu:R`, `srcu:W`, `rcu:R`,
> >   `rcu:W`, `semaphore`
> >
> > Limitations and weaknesses in determining whether a lock is held:
> > - Inlined lock/unlock operations:
> >   - When the kernel is configured to inline spinlock or rwlock operatio=
ns
> >     (`CONFIG_INLINE_SPIN_LOCK`, `CONFIG_INLINE_READ_LOCK`,
> >     `CONFIG_INLINE_WRITE_LOCK`, `!CONFIG_UNINLINE_SPIN_UNLOCK`,
> >     `CONFIG_INLINE_*_UNLOCK*`, etc.), `_raw_spin_lock*` /
> >     `_raw_spin_unlock*` and `_raw_read_lock*` / `_raw_write_lock*` are
> >     inlined into callers and have no BTF function entry points for
> >     `fentry`/`fexit` to attach to. `configure_lock_progs()` verifies th=
at
> >     both acquire and release entry points exist in BTF before enabling =
a
> >     lock family.
> >   - Fast-path `percpu_down_read()` / `percpu_up_read()` and
> >     `srcu_read_lock_fast()` / `srcu_read_unlock_fast()` are inlined
> >     per-CPU counter increments without function calls, so only
> >     `percpu_down_write()` / `percpu_up_write()` and out-of-line
> >     `__srcu_read_lock*()` / `__srcu_read_unlock*()` can be hooked.
> >   - On `!CONFIG_PREEMPT_RCU` kernels, `rcu_read_lock()` compiles to
> >     `preempt_disable()` and does not maintain
> >     `current->rcu_read_lock_nesting` in `task_struct`, so `lock_held(rc=
u)`
> >     read-side inspection requires `CONFIG_PREEMPT_RCU`.
>
> Looks ok.  What happens if user specified unsupported locks - e.g. rcu:R
> on !CONFIG_PREEMPT_RCU.

resolve_lock_expr() checks vmlinux BTF for task_struct's
rcu_read_lock_nesting field (and trc_reader_nesting for rcu-trace) and
configure_lock_progs() checks that both the acquire and unlock BTF
entry points exist for any required lock family. If the kernel lacks
support, perf record prints an error message (e.g. "Error:
lock_held(rcu) requires CONFIG_PREEMPT_RCU" or "Error: Kernel BTF
lacks required lock/unlock tracing entry points") and fails
immediately with -EOPNOTSUPP / -ENOTSUP.

> > - Lack of an inspectable owner field on non-exclusive / spinning locks:
> >   - While `struct mutex`, `struct rt_mutex`, and write-locked
> >     `struct rw_semaphore` store the owning `task_struct *` in `lock->ow=
ner`
> >     (allowing `perf_sample_filter` to inspect kernel memory directly on
> >     sample overflow when filtering by lock address), spinlocks, rwlocks=
,
> >     semaphores, SRCU, and reader-locked `rw_semaphore`s (where
> >     `__up_read()` does not clear `sem->owner` when `!CONFIG_DEBUG_RWSEM=
S`)
> >     do not maintain an authoritative per-task owner pointer.
>
> So do you use the owner field for the supported locks?  Then maybe it
> can skip tracing mutex_lock() and mutex_unlock().  Does it already do?

Great catch =E2=80=94 in v3 it was checking lock->owner in perf_sample_filt=
er,
but prescan_one_lock_expr() was still enabling the fentry/fexit hooks
for *_mutex, *_rt_mutex, and mmap_lock:W. In v4 I will update
prescan_one_lock_expr() to skip attaching fentry/fexit hooks
altogether for specific *_mutex symbols, *_rt_mutex symbols, and
write-locked mmap_lock (mmap_lock:W / lock_held_write(mmap_lock)), so
those filters only inspect lock->owner on sample overflow with zero
lock fastpath tracing overhead.

> >   - Tracking these locks (as well as slab-cache and lock-type filters)
> >     relies on `fexit` (acquire) and `fentry` (release) BPF hooks
> >     maintaining the `held_locks` BPF hash map:
> >     - Any such lock already held before `perf record` attaches its BPF
> >       programs will not be present in `held_locks` until it is released
> >       and re-acquired.
>
> Right, but this can be mitigated when it runs for long.
>
>
> >     - The attached `fentry`/`fexit` hooks execute on every kernel lock
> >       acquire and release for the hooked lock family across the system,
> >       adding tracing overhead outside of perf sample handling.
>
> This is a real problem.  As it touches the fastpath it can cause a lot
> of overhead if locking is frequent.  But having this capability would be
> very useful anyway!

Agreed. We may also be able to optimize or compromise between lock
performance and observability once this gets adopted.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Patch overview:
> > 1. "perf lock contention: Share common BPF and lock type definitions in
> >    lock_data.h": Moves `lock_type_table` to `util/lock-contention.c` an=
d
> >    `LCB_F_*` flags, CO-RE structs, and common BPF lock helpers
> >    (`get_lock_owner`, `get_current_mmap_lock`, `get_current_siglock`,
> >    `get_lock_addr`, `check_lock_type`, `do_collect_lock_syms`,
> >    `do_slab_cache_iter`) into `tools/perf/util/bpf_skel/lock_data.h`.
> > 2. "perf bpf-filter: Add lock_held() sample filter": Implements
> >    `lock_held()`, `lock_held_read()`/`lock_held_shared()`,
> >    `lock_held_write()`/`lock_held_exclusive()`, and `:R`/`:W` mode
> >    suffixes using direct lock owner inspection where possible (`mutex`,
> >    `rt_mutex`, write-locked `rw_semaphore`) and a `held_locks` BPF map
> >    updated by selectively attached `fentry`/`fexit` hooks, supporting
> >    both PMU/software events (`SEC("perf_event")`) and tracepoint events
> >    (`SEC("tracepoint")`).
> > 3. "perf test: Add tests for lock_held() BPF sample filter": Adds unit
> >    tests in `tests/parse-events.c` and shell tests in
> >    `tests/shell/record_bpf_filter.sh`.
> > 4. "perf bpf-filter: Extend lock_held() to support RCU, Tasks Trace RCU=
,
> >    and SRCU": Supports `rcu` (`rcu:R` via direct
> >    `current->rcu_read_lock_nesting` inspection with zero tracing hooks;
> >    `rcu:W` via `synchronize_rcu*()` / `rcu_barrier()` hooks),
> >    `rcu-trace` (via `current->trc_reader_nesting`), and `srcu`
> >    (`srcu:R` via `__srcu_read_lock*` / `__srcu_read_unlock*`; `srcu:W`
> >    via `synchronize_srcu*()` / `srcu_barrier()`).
> > 5. "perf lock contention: Extend BPF lock contention to RCU and SRCU":
> >    Extends `perf lock contention --use-bpf` to track RCU and SRCU
> >    grace-period and barrier waits (`-Y rcu`, `-Y srcu`, `-L rcu`).
> > 6. "perf lock contention: Filter events before creating lock_stat":
> >    Fixes `report_lock_contention_begin_event()` in `builtin-lock.c` to
> >    apply `-Y`, `-L`, and `-S` filters before calling
> >    `lock_stat_findnew()`.
> >
> > Changes in v3:
> > - Move the writer-only `rw_semaphore` check out of `get_lock_owner()` i=
n
> >   `lock_data.h` into `is_rwsem_writer_owner()` in `sample_filter.bpf.c`
> >   so `perf lock contention -b -o` still reports reader owners when a
> >   writer contends on a reader-owned `rw_semaphore`, and scope
> >   `is_direct_lock_owner()` by lock type (`PBF_LOCK_DIRECT_MUTEX`,
> >   `PBF_LOCK_DIRECT_RWSEM`, `PBF_LOCK_DIRECT_RTMUTEX`).
> > - Add `SEC("tracepoint") int perf_tp_sample_filter(void *ctx)` so BPF
> >   sample filters (`lock_held()`, `uid`, `gid`, etc.) can attach to
> >   `PERF_TYPE_TRACEPOINT` events (such as `kmem:mm_page_alloc` and
> >   `vmscan:mm_vmscan_direct_reclaim_begin`), check `libbpf_get_error()`
> >   when attaching, and document memory allocation / direct reclaim
> >   filtering with `lock_held()`.
> > - Return early in `init_numa_data()` in `bpf-filter.c` when `node_data`
> >   cannot be resolved and check `node_data_addr !=3D 0` in
> >   `do_collect_zone_lock()`.
> > - Avoid double-counting `_raw_read_lock_irq` / `_raw_read_lock_bh` in
> >   `sample_filter.bpf.c` on `CONFIG_GENERIC_LOCKBREAK=3Dy &&
> >   !CONFIG_DEBUG_LOCK_ALLOC` kernels where they call
> >   `_raw_read_lock_irqsave()`.
> > - Offset `rcu_state_addr` by 1 byte so it is distinct from
> >   `&rcu_state.node[0].lock` at offset 0 of `rcu_state`, and pass `bool
> >   is_rcu` to `do_contention_end()` in `lock_contention.bpf.c` so
> >   `tp_btf/contention_end` and RCU/SRCU `fexit` hooks never cross-match
> >   timestamp maps.
> >
> > Changes in v2:
> > - Guard `BPF_CORE_READ(mutex, owner.counter)` with `bpf_core_field_exis=
ts`
> >   and fall back to `struct rt_mutex_base` in `get_lock_owner()` so CO-R=
E
> >   relocation succeeds on `CONFIG_PREEMPT_RT=3Dy` kernels.
> > - Add `CONFIG_DEBUG_LOCK_ALLOC=3Dy` lock entry points
> >   (`_mutex_lock_nest_lock`, `_mutex_lock_killable`,
> >   `_mutex_trylock_nest_lock`, `_down_write_nest_lock`,
> >   `_raw_spin_lock_nest_lock`, `_rt_mutex_lock_nest_lock`) to
> >   `sample_filter.bpf.c` and `lock_progs[]`.
> > - Verify in `supported_lock_prog_groups()` that both acquire and all
> >   unlock BTF entry points exist for a lock family before enabling its
> >   tracing hooks, preventing acquire-only attachment when spinlock/rwloc=
k
> >   unlock functions are inlined.
> > - Enable `LOCK_PROG_PERCPU_RWSEM` alongside `LOCK_PROG_RWSEM_WRITE` whe=
n
> >   a symbol name ends in `rwsem` (such as `cgroup_threadgroup_rwsem`).
> > - Gate `record_lock_acquired(ctx, LCB_F_READ)` in `fexit_downgrade_writ=
e`
> >   on `track_rwsem_read` and verify non-zero read/write counts in
> >   `record_lock_released_addr()` before decrementing aggregate slab/type
> >   counts.
> > - Adjust stack skip depth by 2 for `fentry` RCU/SRCU programs in
> >   `lock_contention.bpf.c` and recognize `synchronize_rcu*`,
> >   `synchronize_srcu*`, `rcu_barrier`, and `srcu_barrier` in
> >   `machine__is_lock_function()`.
> > - Add patch 6 fixing `report_lock_contention_begin_event()` to check
> >   type, address, and callstack filters before creating `lock_stat`
> >   entries.
> >
> > Assisted-by: Antigravity:gemini-3.1-pro
> >
> > Ian Rogers (6):
> >   perf lock contention: Share common BPF and lock type definitions in
> >     lock_data.h
> >   perf bpf-filter: Add lock_held() sample filter
> >   perf test: Add tests for lock_held() BPF sample filter
> >   perf bpf-filter: Extend lock_held() to support RCU, Tasks Trace RCU,
> >     and SRCU
> >   perf lock contention: Extend BPF lock contention to RCU and SRCU
> >   perf lock contention: Filter events before creating lock_stat
> >
> >  tools/perf/Documentation/perf-lock.txt        |    7 +-
> >  tools/perf/Documentation/perf-record.txt      |   64 +-
> >  tools/perf/builtin-lock.c                     |   88 +-
> >  tools/perf/tests/parse-events.c               |  121 ++
> >  tools/perf/tests/shell/lock_contention.sh     |   14 +
> >  tools/perf/tests/shell/record_bpf_filter.sh   |  134 ++
> >  tools/perf/util/bpf-filter.c                  | 1271 ++++++++++++++++-
> >  tools/perf/util/bpf-filter.h                  |   13 +
> >  tools/perf/util/bpf-filter.l                  |   31 +-
> >  tools/perf/util/bpf-filter.y                  |   46 +-
> >  tools/perf/util/bpf_lock_contention.c         |  171 ++-
> >  .../perf/util/bpf_skel/lock_contention.bpf.c  |  448 +++---
> >  tools/perf/util/bpf_skel/lock_data.h          |  360 ++++-
> >  tools/perf/util/bpf_skel/sample-filter.h      |   77 +
> >  tools/perf/util/bpf_skel/sample_filter.bpf.c  | 1225 ++++++++++++++++
> >  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |    7 +
> >  tools/perf/util/lock-contention.c             |   22 +
> >  tools/perf/util/lock-contention.h             |   15 +
> >  tools/perf/util/machine.c                     |   11 +
> >  tools/perf/util/parse-events.c                |    3 +-
> >  20 files changed, 3741 insertions(+), 387 deletions(-)
> >
> > --
> > 2.56.0.212.g129ede20d9-goog
> >
