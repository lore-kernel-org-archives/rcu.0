Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709811;
	b=A2aOkhn5M/O0T3wNa1S9qjhjHzzH4qY60+7XIdBmG9G0upPTtSb6XusY6ODmgZWEcfUz
	 GVNaWP7Ko2XCKw0SVA6ZKPb5H6PDzPb+Yk1qCAVpZ8wYuP315gtnGxUTvPWWFUBTzXCre
	 uTj8FFB0Aq6zzlmAlMshTEvE/vQkRPz8eYrkBbSeNKZGv2xFofPurBUR9mrPUXKvHHvU+
	 IWX2InAHZcdFPzk7v8pBlSc5scagQAtyRJV/AwLTEzcmB9GghlBohmG+12ym8de03jHrN
	 ysfD1lBYivVmoQxx5ijDGIHK6Ax+8VDecinZeA9wJ0WfIZ3vaU0yTyZbDS0B93XwaSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709811;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QviJL45pv1qxvmikC1tBy08twPmWYrAmRtqILCLTcFY=;
	b=TAcAf9razWXOydCsE2t4t9jH4vNNtZ3A171RkSYo2f12scu4fEe3iYJJO3x/V9CfnEQR
	 vbZH5ZDUwUaCmdYnfahYRq/TXbRTyMXG0l+gwjFmFs9NmjIEmoQb0g9mq57iezH99SvA0
	 rhW7parY7WkAFnLKdix5Ns3bSlV2bd4JW2+73cQ0iuok3pWC8DILAIPPLld6Jym+qzY3E
	 WU2THB+sV92K/ncqhEL2gRiOeSUj43pLRksYBWEwgkfsmZatjqJ7QgtO769rDCo78eGTi
	 IL2kEQ7HDJoh1NGnXToEeH7Hph6xXS9Uj1n5WaS71+zZEIaY247YXVFyfy1jFrEoI4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZtuxpIh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80B606A319;
	Thu, 22 Oct 2026 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZtuxpIh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E8F1F01825;
	Thu, 22 Oct 2026 22:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792709810;
	bh=QviJL45pv1qxvmikC1tBy08twPmWYrAmRtqILCLTcFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mZtuxpIhOwNI8c5ggB4VrFk58W3YrnZT4YJlE9LLmsoGwJYrwROzMf7tUvhX0hPp3
	 OBFwsK6Tadmk5jiqCG/T/n+5nwgocb3Vj8RAs5sO/FExnDA5zNWAAvjFnpbR2CJMQ2
	 e1RM5xLQlwPozG3BVt/oqZTmtlpg5dRC/xwMcd+c0XVCk4+ZUsrHyh0jnu1x9HtzP8
	 ZLN7J5uBAIM3Q+CO34+K5NBFKeBdmDaSBPs12UA3j3ndSKxQ15YJkC6+RCInNRSk1s
	 Pp9lUYHoJzdH0GmEyZrmrmABv7ZjI1Qjizl3Wbhti7Bz+1DsI+0E5yB14HH2B9TlNh
	 GcpbuEnSdA+PQ==
Date: Thu, 22 Oct 2026 15:56:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ddhariwal@google.com,
	eranian@google.com, james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
Subject: Re: [PATCH v6 06/11] perf bpf-filter: Extend lock_held() to other
 kernel lock types
Message-ID: <atqUsIBhPaxjp3p8@google.com>
References: <20261020205859.1080743-1-irogers@google.com>
 <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-7-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261022203003.1779152-7-irogers@google.com>

On Thu, Oct 22, 2026 at 01:29:58PM -0700, Ian Rogers wrote:
> Extend the lock_held() BPF sample filter beyond global mutexes to
> support:
> - Other global/static kernel lock symbols (rwsem, spinlock, rwlock,
>   rt-mutex, percpu-rwsem, semaphore) and hexadecimal kernel lock
>   addresses.
> - Lock types and flags: mutex, spinlock, rwsem, rwsem:R, rwsem:W,
>   rwlock, rwlock:R, rwlock:W, rt-mutex, percpu-rwsem, pcpu-sem:W,
>   semaphore.
> 
> For rt-mutexes and write-locked rwsems, perf_sample_filter inspects the
> lock's owner field directly in kernel memory. For locks and modes without
> an authoritative per-task owner pointer (spinlocks, rwlocks, semaphores,
> reader-locked rwsems, percpu-rwsems, and lock type filters), attach BPF
> fentry/fexit hooks on kernel lock acquire and release functions to track
> held locks in the held_locks BPF LRU hash map.
> 
> Note that counting semaphores (down*() / up()) do not enforce same-task
> ownership in the kernel: when a semaphore is used as a cross-task
> completion/signaling mechanism, fexit/down and fentry/up will not pair
> on the same task ID. Semaphore hooks are therefore only enabled when
> 'semaphore' or a '*_sem' symbol (such as console_sem) is explicitly
> specified, and held_locks uses BPF_MAP_TYPE_LRU_HASH so any unpaired
> cross-task entries are automatically evicted.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-record.txt     |  53 +-
>  tools/perf/util/bpf-filter.c                 | 596 ++++++++++++-
>  tools/perf/util/bpf_skel/sample-filter.h     |  17 +-
>  tools/perf/util/bpf_skel/sample_filter.bpf.c | 851 ++++++++++++++++++-
>  4 files changed, 1465 insertions(+), 52 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 445cc98a6c33..9fb5d15de135 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -216,15 +216,50 @@ OPTIONS
>  
>  	The 'lock_held(<lock>)' predicate (or '!lock_held(<lock>)') filters
>  	samples based on whether the specified kernel lock is currently held
> -	by the kernel thread.  To differentiate between shared/read holding
> -	and exclusive/write holding, use 'lock_held_read(<lock>)' (alias
> -	'lock_held_shared(<lock>)') or 'lock_held_write(<lock>)' (alias
> -	'lock_held_exclusive(<lock>)'), or append ':R' or ':W' to <lock>.
> -	<lock> can be a kernel mutex symbol name (e.g.
> -	'lock_held(cgroup_mutex)').  When filtering on a mutex symbol
> -	('*_mutex'), 'perf_sample_filter' inspects the lock's 'owner' field
> -	directly in kernel memory on each sample without attaching any BPF
> -	fentry/fexit hooks.
> +	by the kernel thread or CPU.  To differentiate between shared/read
> +	holding and exclusive/write holding, use 'lock_held_read(<lock>)'
> +	(alias 'lock_held_shared(<lock>)') or 'lock_held_write(<lock>)'
> +	(alias 'lock_held_exclusive(<lock>)'), or append ':R' or ':W' to
> +	<lock> (e.g. 'lock_held(rwsem:R)' or 'lock_held(rwsem:W)').
> +	<lock> can be a kernel lock symbol name (e.g.
> +	'lock_held(cgroup_mutex)'), a hexadecimal lock address, or a lock type
> +	('mutex', 'spinlock', 'rwsem', 'rwsem:R', 'rwsem:W', 'rwlock',
> +	'rwlock:R', 'rwlock:W', 'rt-mutex', 'percpu-rwsem', 'pcpu-sem:W',
> +	'semaphore').  Both read/shared and write/exclusive tracking are
> +	supported for 'rwsem' and 'rwlock'; 'mutex', 'spinlock', 'rt-mutex',
> +	'semaphore', and 'percpu-rwsem' ('percpu_down_write()') support
> +	write/exclusive tracking only.  Note that 'semaphore' tracking
> +	('down*()' / 'up()') assumes binary mutex-like usage where the
> +	acquiring task also releases the semaphore (such as 'console_sem'),
> +	rather than cross-task completion signaling.
> +
> +	For example, 'lock_held()' can be combined with memory allocation or
> +	reclaim events to detect allocations or direct memory reclaim occurring
> +	while a kernel lock is held (which can stall lock waiters for extended
> +	periods):
> +
> +	  # perf record -a -g -e vmscan:mm_vmscan_direct_reclaim_begin \
> +	      --filter 'lock_held(mutex) || lock_held(rwsem)'
> +	  # perf record -a -g -e kmem:mm_page_alloc \
> +	      --filter 'gfp_flags & 0x400' \
> +	      --filter 'lock_held(mutex) || lock_held(rwsem)'
> +	  # perf record -a -g -e major-faults \
> +	      --filter 'lock_held(mutex) || lock_held(rwsem)'
> +
> +	When filtering on a specific mutex symbol ('*_mutex') or rt-mutex
> +	symbol ('*_rt_mutex'), 'perf_sample_filter' inspects the lock's
> +	'owner' field directly in kernel memory on each sample without attaching
> +	any BPF fentry/fexit hooks.  For locks that do not maintain an
> +	authoritative per-task owner pointer (such as spinlocks, rwlocks,
> +	semaphores, reader-locked rwsems, and lock type filters), it attaches
> +	BPF fentry/fexit programs to kernel lock acquire and release functions
> +	to track held locks in a BPF map.  These BPF hooks run on every kernel
> +	lock acquisition and release for the attached lock family, even when no
> +	perf sample is being taken.  To minimize this overhead, only the hooks
> +	for the relevant lock family and mode are attached when known, whereas
> +	raw hex addresses or symbols without a recognizable lock-type suffix
> +	attach hooks across all lock families (including high-frequency
> +	spinlocks).
>  
>  	The <operator> can be one of:
>  	  ==, !=, >, >=, <, <=, &
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 639db6c03137..8797f67698f7 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -52,6 +52,7 @@
>  #include <sys/stat.h>
>  
>  #include <bpf/bpf.h>
> +#include <bpf/btf.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -65,6 +66,7 @@
>  #include "util/cap.h"
>  #include "util/debug.h"
>  #include "util/evsel.h"
> +#include "util/lock-contention.h"
>  #include "util/symbol_conf.h"
>  #include "util/target.h"
>  #include "util/thread_map.h"
> @@ -74,6 +76,7 @@
>  #include <util/bpf-filter-flex.h>
>  #include <util/bpf-filter-bison.h>
>  
> +#include "bpf_skel/lock_data.h"
>  #include "bpf_skel/sample-filter.h"
>  #include "bpf_skel/sample_filter.skel.h"
>  
> @@ -178,6 +181,153 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
>  	return -1;
>  }
>  
> +/*
> + * Program groups for `lock_held(...)` BPF tracing hooks.
> + *
> + * When a `lock_held(...)` filter is specified, only the BPF tracing program
> + * groups required for the requested lock(s) are autoloaded and attached.
> + * If no `lock_held(...)` filter is present, none of these programs are loaded.
> + */
> +enum lock_prog_group {
> +	LOCK_PROG_MUTEX         = 1U << 0,
> +	LOCK_PROG_RWSEM_READ    = 1U << 1,
> +	LOCK_PROG_RWSEM_WRITE   = 1U << 2,
> +	LOCK_PROG_RWSEM         = LOCK_PROG_RWSEM_READ | LOCK_PROG_RWSEM_WRITE,
> +	LOCK_PROG_SPIN          = 1U << 3,
> +	LOCK_PROG_RWLOCK_READ   = 1U << 4,
> +	LOCK_PROG_RWLOCK_WRITE  = 1U << 5,
> +	LOCK_PROG_RWLOCK        = LOCK_PROG_RWLOCK_READ | LOCK_PROG_RWLOCK_WRITE,
> +	LOCK_PROG_RTMUTEX       = 1U << 6,
> +	LOCK_PROG_SEM           = 1U << 7,
> +	LOCK_PROG_PERCPU_RWSEM  = 1U << 8,
> +	LOCK_PROG_ALL           = 0x1ffU & ~LOCK_PROG_SEM,
> +};
> +
> +static unsigned int lock_flags_to_prog_group(unsigned int flags)
> +{
> +	if (flags & LCB_F_MUTEX)
> +		return LOCK_PROG_MUTEX;
> +	if (flags & LCB_F_RT)
> +		return LOCK_PROG_RTMUTEX;
> +	if (flags & LCB_F_PERCPU)
> +		return LOCK_PROG_PERCPU_RWSEM;
> +	if (flags == LCB_F_SPIN)
> +		return LOCK_PROG_SPIN;
> +	if (flags & LCB_F_SPIN)
> +		return (flags & LCB_F_READ) ? LOCK_PROG_RWLOCK_READ : LOCK_PROG_RWLOCK_WRITE;
> +	if (flags & LCB_F_READ)
> +		return LOCK_PROG_RWSEM_READ;
> +	if (flags & LCB_F_WRITE)
> +		return LOCK_PROG_RWSEM_WRITE;
> +	return LOCK_PROG_SEM;
> +}
> +
> +struct lock_prog_desc {
> +	size_t prog_offset;
> +	const char *btf_func;
> +	unsigned int group;
> +};
> +
> +#define LOCK_FPROG(field, func, grp) \
> +	{ offsetof(struct sample_filter_bpf, progs.field), func, grp }
> +
> +static const struct lock_prog_desc lock_progs[] = {
> +	/* Mutex */
> +	LOCK_FPROG(fexit_mutex_lock, "mutex_lock", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_nested, "mutex_lock_nested", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit__mutex_lock_nest_lock, "_mutex_lock_nest_lock", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_io, "mutex_lock_io", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_io_nested, "mutex_lock_io_nested", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_interruptible, "mutex_lock_interruptible", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_interruptible_nested, "mutex_lock_interruptible_nested",
> +		   LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_lock_killable, "mutex_lock_killable", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit__mutex_lock_killable, "_mutex_lock_killable", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit_mutex_trylock, "mutex_trylock", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fexit__mutex_trylock_nest_lock, "_mutex_trylock_nest_lock", LOCK_PROG_MUTEX),
> +	LOCK_FPROG(fentry_mutex_unlock, "mutex_unlock", LOCK_PROG_MUTEX),

I'm not sure if these are still needed.. it can handle mutexes
specially, right?

Thanks,
Namhyung


> +	/* RW semaphore */
> +	LOCK_FPROG(fexit_down_read, "down_read", LOCK_PROG_RWSEM_READ),
> +	LOCK_FPROG(fexit_down_read_nested, "down_read_nested", LOCK_PROG_RWSEM_READ),
> +	LOCK_FPROG(fexit_down_read_interruptible, "down_read_interruptible", LOCK_PROG_RWSEM_READ),
> +	LOCK_FPROG(fexit_down_read_killable, "down_read_killable", LOCK_PROG_RWSEM_READ),
> +	LOCK_FPROG(fexit_down_read_killable_nested, "down_read_killable_nested",
> +		   LOCK_PROG_RWSEM_READ),
> +	LOCK_FPROG(fexit_down_read_trylock, "down_read_trylock", LOCK_PROG_RWSEM_READ),
> +	LOCK_FPROG(fexit_down_write, "down_write", LOCK_PROG_RWSEM_WRITE),
> +	LOCK_FPROG(fexit_down_write_nested, "down_write_nested", LOCK_PROG_RWSEM_WRITE),
> +	LOCK_FPROG(fexit__down_write_nest_lock, "_down_write_nest_lock", LOCK_PROG_RWSEM_WRITE),
> +	LOCK_FPROG(fexit_down_write_killable, "down_write_killable", LOCK_PROG_RWSEM_WRITE),
> +	LOCK_FPROG(fexit_down_write_killable_nested, "down_write_killable_nested",
> +		   LOCK_PROG_RWSEM_WRITE),
> +	LOCK_FPROG(fexit_down_write_trylock, "down_write_trylock", LOCK_PROG_RWSEM_WRITE),
> +	LOCK_FPROG(fexit_downgrade_write, "downgrade_write", LOCK_PROG_RWSEM),
> +	LOCK_FPROG(fentry_up_read, "up_read", LOCK_PROG_RWSEM_READ),
> +	LOCK_FPROG(fentry_up_write, "up_write", LOCK_PROG_RWSEM_WRITE),
> +	/* Spinlock */
> +	LOCK_FPROG(fexit_raw_spin_lock, "_raw_spin_lock", LOCK_PROG_SPIN),
> +	LOCK_FPROG(fexit_raw_spin_lock_nested, "_raw_spin_lock_nested", LOCK_PROG_SPIN),
> +	LOCK_FPROG(fexit_raw_spin_lock_nest_lock, "_raw_spin_lock_nest_lock", LOCK_PROG_SPIN),
> +	LOCK_FPROG(fexit_raw_spin_lock_irq, "_raw_spin_lock_irq", LOCK_PROG_SPIN),
> +	LOCK_FPROG(fexit_raw_spin_lock_irq_disable, "_raw_spin_lock_irq_disable", LOCK_PROG_SPIN),
> +	LOCK_FPROG(fexit_raw_spin_lock_irqsave, "_raw_spin_lock_irqsave", LOCK_PROG_SPIN),
> +	LOCK_FPROG(fexit_raw_spin_lock_irqsave_nested, "_raw_spin_lock_irqsave_nested",
> +		   LOCK_PROG_SPIN),
> +	LOCK_FPROG(fexit_raw_spin_lock_bh, "_raw_spin_lock_bh", LOCK_PROG_SPIN),
> +	LOCK_FPROG(fexit_raw_spin_trylock, "_raw_spin_trylock", LOCK_PROG_SPIN),
> +	LOCK_FPROG(fexit_raw_spin_trylock_bh, "_raw_spin_trylock_bh", LOCK_PROG_SPIN),
> +	LOCK_FPROG(fentry_raw_spin_unlock, "_raw_spin_unlock", LOCK_PROG_SPIN),
> +	LOCK_FPROG(fentry_raw_spin_unlock_irq, "_raw_spin_unlock_irq", LOCK_PROG_SPIN),
> +	LOCK_FPROG(fentry_raw_spin_unlock_irq_enable, "_raw_spin_unlock_irq_enable",
> +		   LOCK_PROG_SPIN),
> +	LOCK_FPROG(fentry_raw_spin_unlock_irqrestore, "_raw_spin_unlock_irqrestore",
> +		   LOCK_PROG_SPIN),
> +	LOCK_FPROG(fentry_raw_spin_unlock_bh, "_raw_spin_unlock_bh", LOCK_PROG_SPIN),
> +	/* RWlock */
> +	LOCK_FPROG(fexit_raw_read_lock, "_raw_read_lock", LOCK_PROG_RWLOCK_READ),
> +	LOCK_FPROG(fexit_raw_read_lock_irq, "_raw_read_lock_irq", LOCK_PROG_RWLOCK_READ),
> +	LOCK_FPROG(fexit_raw_read_lock_irqsave, "_raw_read_lock_irqsave", LOCK_PROG_RWLOCK_READ),
> +	LOCK_FPROG(fexit_raw_read_lock_bh, "_raw_read_lock_bh", LOCK_PROG_RWLOCK_READ),
> +	LOCK_FPROG(fexit_raw_read_trylock, "_raw_read_trylock", LOCK_PROG_RWLOCK_READ),
> +	LOCK_FPROG(fentry_raw_read_unlock, "_raw_read_unlock", LOCK_PROG_RWLOCK_READ),
> +	LOCK_FPROG(fentry_raw_read_unlock_irq, "_raw_read_unlock_irq", LOCK_PROG_RWLOCK_READ),
> +	LOCK_FPROG(fentry_raw_read_unlock_irqrestore, "_raw_read_unlock_irqrestore",
> +		   LOCK_PROG_RWLOCK_READ),
> +	LOCK_FPROG(fentry_raw_read_unlock_bh, "_raw_read_unlock_bh", LOCK_PROG_RWLOCK_READ),
> +	LOCK_FPROG(fexit_raw_write_lock, "_raw_write_lock", LOCK_PROG_RWLOCK_WRITE),
> +	LOCK_FPROG(fexit_raw_write_lock_nested, "_raw_write_lock_nested", LOCK_PROG_RWLOCK_WRITE),
> +	LOCK_FPROG(fexit_raw_write_lock_irq, "_raw_write_lock_irq", LOCK_PROG_RWLOCK_WRITE),
> +	LOCK_FPROG(fexit_raw_write_lock_irqsave, "_raw_write_lock_irqsave", LOCK_PROG_RWLOCK_WRITE),
> +	LOCK_FPROG(fexit_raw_write_lock_bh, "_raw_write_lock_bh", LOCK_PROG_RWLOCK_WRITE),
> +	LOCK_FPROG(fexit_raw_write_trylock, "_raw_write_trylock", LOCK_PROG_RWLOCK_WRITE),
> +	LOCK_FPROG(fentry_raw_write_unlock, "_raw_write_unlock", LOCK_PROG_RWLOCK_WRITE),
> +	LOCK_FPROG(fentry_raw_write_unlock_irq, "_raw_write_unlock_irq", LOCK_PROG_RWLOCK_WRITE),
> +	LOCK_FPROG(fentry_raw_write_unlock_irqrestore, "_raw_write_unlock_irqrestore",
> +		   LOCK_PROG_RWLOCK_WRITE),
> +	LOCK_FPROG(fentry_raw_write_unlock_bh, "_raw_write_unlock_bh", LOCK_PROG_RWLOCK_WRITE),
> +	/* RT-Mutex */
> +	LOCK_FPROG(fexit_rt_mutex_lock, "rt_mutex_lock", LOCK_PROG_RTMUTEX),
> +	LOCK_FPROG(fexit_rt_mutex_lock_nested, "rt_mutex_lock_nested", LOCK_PROG_RTMUTEX),
> +	LOCK_FPROG(fexit__rt_mutex_lock_nest_lock, "_rt_mutex_lock_nest_lock", LOCK_PROG_RTMUTEX),
> +	LOCK_FPROG(fexit_rt_mutex_lock_interruptible, "rt_mutex_lock_interruptible",
> +		   LOCK_PROG_RTMUTEX),
> +	LOCK_FPROG(fexit_rt_mutex_lock_killable, "rt_mutex_lock_killable", LOCK_PROG_RTMUTEX),
> +	LOCK_FPROG(fexit_rt_mutex_trylock, "rt_mutex_trylock", LOCK_PROG_RTMUTEX),
> +	LOCK_FPROG(fentry_rt_mutex_unlock, "rt_mutex_unlock", LOCK_PROG_RTMUTEX),
> +	/* Semaphore */
> +	LOCK_FPROG(fexit_down, "down", LOCK_PROG_SEM),
> +	LOCK_FPROG(fexit_down_interruptible, "down_interruptible", LOCK_PROG_SEM),
> +	LOCK_FPROG(fexit_down_killable, "down_killable", LOCK_PROG_SEM),
> +	LOCK_FPROG(fexit_down_timeout, "down_timeout", LOCK_PROG_SEM),
> +	LOCK_FPROG(fexit_down_trylock, "down_trylock", LOCK_PROG_SEM),
> +	LOCK_FPROG(fentry_up, "up", LOCK_PROG_SEM),
> +	/* Percpu-RWsem */
> +	LOCK_FPROG(fexit_percpu_down_write, "percpu_down_write", LOCK_PROG_PERCPU_RWSEM),
> +	LOCK_FPROG(fentry_percpu_up_write, "percpu_up_write", LOCK_PROG_PERCPU_RWSEM),
> +};
> +
> +#undef LOCK_FPROG
