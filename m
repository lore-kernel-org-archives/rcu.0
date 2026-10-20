Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792536182;
	b=tf6dtKXVF6CRjJtAFEGlkJJYcTH7xtsYn8HE+no2fhHMrCfJDygJixHsnluR694dBu3M
	 fDx795l/piMC8EWg2Z1zFQJzNbRuV8SqfoOZ/nSklT/fFQsFo3d4og14b+UoH8cvEQJLm
	 cx8UYIwhWLU4MyYjWEwCqZtx5Qxew425aDe/wQY29PlH7wgkUFj6EP8VQmqmgx1sE/Z14
	 8dctC6xWzhVAytjt69o+wgEfetzuQ7khR0wCCiIjsjrQMDP2vNaVJKJM2yX1wGHLlFvan
	 NzPyi3vvb9mRGvsKktc+W2GsfqDx0npS+IJEKOm/3UU9vZ9/Oi0KgabUnxb90HdCzoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792536182;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7Bv4V7OO3mv7VLfaBLTh0ktLgqtNJpvVSxcK99c79Fg=;
	b=Lj2wHlCA3GhiK8mD5fsH2yiwERJqXhELCzU/cHOuWUv5KbHDROuarWteuzfPqypKb0k0
	 wAFquyvJlU5QLrlHcS/4PS9IYQc5FyVw/2UkU2fVLbCusAHZRLcIhCsS+ENz2nvmfTAwV
	 n6n49B63jBRU62w1m5+4cdRVTIzRaFHt8KsJ4Cg1bO62JbkGKZa3zNYHbVDbKbgaAo33l
	 ml2VS6GeHPr1watjTDGUWUwyE3wCeux3qrkCm6jhCROFnTmYQXfkEa10h12TMtNT2ZOK5
	 BimnQaq+9aX/wqukdCJR3WhcQCum8kleU1wZYgwnMjwA7cOMwc+6yGLzcAJLBLQCKuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYohx7y7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6E3606A31A;
	Tue, 20 Oct 2026 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYohx7y7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E85D1F000C9;
	Tue, 20 Oct 2026 22:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792536181;
	bh=7Bv4V7OO3mv7VLfaBLTh0ktLgqtNJpvVSxcK99c79Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fYohx7y72sl4Y4g7VpQAsmN7pxM2NIEb9MDWeUk1N5MrTlsltN0zQPKKDKwcc5oPI
	 CRG3FrcIsaoSuWMMUBYKbfQ4s2kd1+w3vt54JbK6EGzzj0uY/5fGBe5Ecp/eY+VbCI
	 6Yp3pHpOwPsbWs0rAN9JIWp7tfjkmrfd6RVEc+nYRxO5CTlCW9F+JhVefO97LSUs5E
	 /9JCw7OtgO2WjZo7A61fBIOmfUMpdqA8l4bw9t/nUaIiMdU/uoa3EGlXCEOdcI2OwZ
	 FRl0wwaw9XtAPuATrVQu7bk5wqnqPI1ctEpn/mgzFP6Otq/n6yNuEhfQl34LleGOrI
	 Im+/f9+i/sncA==
Date: Tue, 20 Oct 2026 15:42:59 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ddhariwal@google.com,
	eranian@google.com, james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
Subject: Re: [PATCH v5 4/8] perf lock contention: Share common BPF and lock
 type definitions in lock_data.h
Message-ID: <atfuc1Y8pofwI2HZ@google.com>
References: <20261019220915.3943592-1-irogers@google.com>
 <20261020205859.1080743-1-irogers@google.com>
 <20261020205859.1080743-5-irogers@google.com>
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
In-Reply-To: <20261020205859.1080743-5-irogers@google.com>

On Tue, Oct 20, 2026 at 01:58:54PM -0700, Ian Rogers wrote:
> Move lock_type_table, LCB_F_* flags, and the common BPF lock helpers
> (get_lock_owner, get_current_mmap_lock, get_current_siglock,
> get_lock_addr, check_lock_type, do_collect_zone_lock,
> do_collect_lock_syms, do_slab_cache_iter) and shared CO-RE structs into
> tools/perf/util/bpf_skel/lock_data.h so they can be reused by BPF
> sample filtering.

This is fine.

> 
> Also add rw_semaphore.count and struct rt_mutex_base to the minimal
> vmlinux.h and extend get_lock_owner() to support rt_mutex and check
> the mutex handoff flag.

Please do this in a separate commit.  I'd like to see this kind of
commit only moves the existing code.


> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-lock.c                     |  27 --
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 265 +-------------
>  tools/perf/util/bpf_skel/lock_data.h          | 338 ++++++++++++++++++
>  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |   5 +
>  tools/perf/util/lock-contention.c             |  19 +
>  tools/perf/util/lock-contention.h             |  13 +
>  6 files changed, 393 insertions(+), 274 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 778923c92f42..a031709a2cc2 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1482,33 +1482,6 @@ static void sort_result(void)
>  	}
>  }
>  
> -static const struct {
> -	unsigned int flags;
> -	/*
> -	 * Name of the lock flags (access), with delimeter ':'.
> -	 * For example, rwsem:R of rwsem:W.
> -	 */
> -	const char *flags_name;
> -	/* Name of the lock (type), for example, rwlock or rwsem. */
> -	const char *lock_name;
> -} lock_type_table[] = {
> -	{ 0,				"semaphore",	"semaphore" },
> -	{ LCB_F_SPIN,			"spinlock",	"spinlock" },
> -	{ LCB_F_SPIN | LCB_F_READ,	"rwlock:R",	"rwlock" },
> -	{ LCB_F_SPIN | LCB_F_WRITE,	"rwlock:W",	"rwlock" },
> -	{ LCB_F_READ,			"rwsem:R",	"rwsem" },
> -	{ LCB_F_WRITE,			"rwsem:W",	"rwsem" },
> -	{ LCB_F_RT,			"rt-mutex",	"rt-mutex" },
> -	{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R",	"rwlock-rt" },
> -	{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W",	"rwlock-rt" },
> -	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"percpu-rwsem" },
> -	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
> -	{ LCB_F_MUTEX,			"mutex",	"mutex" },
> -	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
> -	/* alias for optimistic spinning only */
> -	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex:spin",	"mutex-spin" },
> -};
> -
>  static const char *get_type_flags_name(unsigned int flags)
>  {
>  	flags &= LCB_F_TYPE_MASK;
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 0d9c6f55050e..0f2118006005 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -8,23 +8,9 @@
>  
>  #include "lock_data.h"
>  
> -/* for collect_lock_syms().  4096 was rejected by the verifier */
> -#define MAX_CPUS  1024
> -
> -/* for collect_zone_lock().  It should be more than the actual zones. */
> -#define MAX_ZONES  10
> -
>  /* for do_lock_delay().  Arbitrarily set to 1 million. */
>  #define MAX_LOOP  (1U << 20)
>  
> -/* lock contention flags from include/trace/events/lock.h */
> -#define LCB_F_SPIN	(1U << 0)
> -#define LCB_F_READ	(1U << 1)
> -#define LCB_F_WRITE	(1U << 2)
> -#define LCB_F_RT	(1U << 3)
> -#define LCB_F_PERCPU	(1U << 4)
> -#define LCB_F_MUTEX	(1U << 5)
> -
>  /* callstack storage  */
>  struct {
>  	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
> @@ -96,13 +82,6 @@ struct {
>  	__uint(max_entries, MAX_ENTRIES);
>  } task_data SEC(".maps");
>  
> -struct {
> -	__uint(type, BPF_MAP_TYPE_HASH);
> -	__uint(key_size, sizeof(__u64));
> -	__uint(value_size, sizeof(__u32));
> -	__uint(max_entries, MAX_ENTRIES);
> -} lock_syms SEC(".maps");
> -
>  struct {
>  	__uint(type, BPF_MAP_TYPE_HASH);
>  	__uint(key_size, sizeof(__u32));
> @@ -138,6 +117,13 @@ struct {
>  	__uint(max_entries, 1);
>  } cgroup_filter SEC(".maps");
>  
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(__u64));
> +	__uint(value_size, sizeof(__u32));
> +	__uint(max_entries, MAX_ENTRIES);
> +} lock_syms SEC(".maps");
> +

Looks like un uncessasry change.


>  struct {
>  	__uint(type, BPF_MAP_TYPE_HASH);
>  	__uint(key_size, sizeof(long));
> @@ -159,22 +145,6 @@ struct {
>  	__uint(max_entries, 1);
>  } lock_delays SEC(".maps");
>  
> -struct rw_semaphore___old {
> -	struct task_struct *owner;
> -} __attribute__((preserve_access_index));
> -
> -struct rw_semaphore___new {
> -	atomic_long_t owner;
> -} __attribute__((preserve_access_index));
> -
> -struct mm_struct___old {
> -	struct rw_semaphore mmap_sem;
> -} __attribute__((preserve_access_index));
> -
> -struct mm_struct___new {
> -	struct rw_semaphore mmap_lock;
> -} __attribute__((preserve_access_index));
> -
>  struct cas_ctx {
>  	struct contention_data *data;
>  	u64 duration;
> @@ -182,8 +152,6 @@ struct cas_ctx {
[SNIP]
> diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
> index 652e114e6b87..317d8ccae63e 100644
> --- a/tools/perf/util/bpf_skel/lock_data.h
> +++ b/tools/perf/util/bpf_skel/lock_data.h
> @@ -45,6 +45,14 @@ struct contention_task_data {
>  #define LCB_F_SLAB_ID_END	(1U << 26)
>  #define LCB_F_SLAB_ID_MASK	0x03FF0000U
>  
> +/* lock contention flags from include/trace/events/lock.h */
> +#define LCB_F_SPIN	(1U << 0)
> +#define LCB_F_READ	(1U << 1)
> +#define LCB_F_WRITE	(1U << 2)
> +#define LCB_F_RT	(1U << 3)
> +#define LCB_F_PERCPU	(1U << 4)
> +#define LCB_F_MUTEX	(1U << 5)
> +
>  #define LCB_F_TYPE_MAX		(1U << 7)
>  #define LCB_F_TYPE_MASK		0x0000007FU
>  
> @@ -76,4 +84,334 @@ struct slab_cache_data {
>  	char name[SLAB_NAME_MAX];
>  };
>  
> +#ifdef __BPF__

Why is this needed?

Thanks,
Namhyung

