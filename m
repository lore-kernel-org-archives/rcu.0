Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A101FC7FB;
	Tue, 16 Jun 2026 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593073; cv=none; b=trohbD0U1m4CDqXVz9Cf3YAN3IcFdnpzyn4YVoA5GeSihJyLf2iDGc+C53kJI4ykZomQP9Gq3z5Zt79CRaDWlQvGYa3IjrVJf8k40D5YFMYqyUL98UnzDN0d4GvkesiMSwwJoe5u3Dzfgyz52zNRERrb+jK6zOodup14zP9Pz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593073; c=relaxed/simple;
	bh=ShF/kWa2CviwYqZxt7Rlzm9lYLieHp0PQcJ0ZicPi+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4VUMpTGzItEOrVhJXBNl2LlfQwfukJXx5bqAraw6fjA7Lf9o6QZH8OTB3z+I1ApONLqHexwEbp0qqIx6zo8VaXZGFaRV79h+1+SbHP5cCn5YyyjK9Zr9LJE+jddeZrPSVUypwNff5BMo/qrCLF6b71GSlSM1sykYVAQD7xgee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG0ASzzB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG0ASzzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6291A1F000E9;
	Tue, 16 Jun 2026 06:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781593072;
	bh=5YYnjwXkhIaJkMK4KVBBMhIkUoLKifb+v7A8S2YfApM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fG0ASzzB2I00G5iVEAds9Q0q7Bms6RNkBLE07l71xjSDi1o26hZfRZfswbg31vdsK
	 ce5IeSOVRKXGkI/hpwduGQILYFHaUrY+2ssX4eXph+FypjmNykxQW8fD0dDu7qA5xq
	 DRvPVbYt8/y6/e0z7neaIY8iRXWRnxCcZU1l9CWmZHCq4kTr0ascmZ+KjtYJOC9YJi
	 IN6OL83bQhAqlgkSTAib+xvaI0FH55lUdY0CPs/orNwXoBsZkAUT8/cP6T019r5GxX
	 rVW4XyLhkNnHxNeac/MHoNNQJdlBJM37Ii+dZrmKRkrHsClpnDXYcFjw3+kn87wsIn
	 P7w3/bYbfhirg==
Message-ID: <a64777b0-dfdf-4cc4-bb3a-87f25ca394bf@kernel.org>
Date: Tue, 16 Jun 2026 08:57:44 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 2/9] mm/slab, slub_kunit: register kprobe to
 trigger _nolock APIs
Content-Language: en-US
To: "Harry Yoo (Oracle)" <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/26 13:05, Harry Yoo (Oracle) wrote:
> Since kmalloc_nolock() always fails in NMI and hardirq contexts on
> PREEMPT_RT, slub_kunit cannot properly test _nolock() APIs.
> 
> Register a kprobe pre-handler to invoke kmalloc_nolock() and
> kfree_nolock() in the middle of the slab allocator. However, do not
> register the handler on UP kernels [1].
> 
> To attach the pre-handler while s->cpu_sheaves->lock or n->list_lock
> is held, add a wrapper function for lockdep_assert_held() that calls
> a no-op function slab_attach_kprobe_locked() on debug builds. The
> function is optimized away when neither CONFIG_PROVE_LOCKING nor
> CONFIG_DEBUG_VM is selected and register_kprobe() fails.
> 
> The function calls barrier() to prevent the compiler from optimizing
> away its callsites. Otherwise, the compiler may consider the function
> does not have any side effect and remove callsites.
> 
> Link: https://lore.kernel.org/linux-mm/20260427-nolock-api-fix-v2-0-a6b83a92d9a4@kernel.org [1]
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>

Looks very useful!
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  lib/tests/slub_kunit.c | 82 +++++++++++++++++++++++++++++++++++++++++++-------
>  mm/slub.c              | 36 ++++++++++++++++------
>  2 files changed, 98 insertions(+), 20 deletions(-)
> 
> diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
> index 11255fc8eb78..01d808cb77fa 100644
> --- a/lib/tests/slub_kunit.c
> +++ b/lib/tests/slub_kunit.c
> @@ -8,6 +8,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/delay.h>
>  #include <linux/perf_event.h>
> +#include <linux/kprobes.h>
>  #include "../mm/slab.h"
>  
>  static struct kunit_resource resource;
> @@ -292,7 +293,8 @@ static void test_krealloc_redzone_zeroing(struct kunit *test)
>  	kmem_cache_destroy(s);
>  }
>  
> -#ifdef CONFIG_PERF_EVENTS
> +#if defined(CONFIG_PERF_EVENTS) || (defined(CONFIG_KPROBES) && defined(CONFIG_SMP))
> +#define SLUB_KUNIT_TEST_KMALLOC_KFREE_NOLOCK
>  #define NR_ITERATIONS 1000
>  #define NR_OBJECTS 1000
>  static void *objects[NR_OBJECTS];
> @@ -302,10 +304,16 @@ struct test_nolock_context {
>  	int callback_count;
>  	int alloc_ok;
>  	int alloc_fail;
> +#ifdef CONFIG_PERF_EVENTS
>  	struct perf_event *event;
>  	bool is_perf_type_hw;
> +#endif
> +#ifdef CONFIG_KPROBES
> +	struct kprobe kprobe;
> +#endif
>  };
>  
> +#ifdef CONFIG_PERF_EVENTS
>  static struct perf_event_attr hw_attr = {
>  	.type = PERF_TYPE_HARDWARE,
>  	.config = PERF_COUNT_HW_CPU_CYCLES,
> @@ -326,13 +334,10 @@ static struct perf_event_attr sw_attr = {
>  	.sample_freq = 100000,
>  };
>  
> -static void overflow_handler_test_nolock(struct perf_event *event,
> -					 struct perf_sample_data *data,
> -					 struct pt_regs *regs)
> +static void test_nolock(struct test_nolock_context *ctx)
>  {
>  	void *objp;
>  	gfp_t gfp;
> -	struct test_nolock_context *ctx = event->overflow_handler_context;
>  
>  	/* __GFP_ACCOUNT to test kmalloc_nolock() in alloc_slab_obj_exts() */
>  	gfp = (ctx->callback_count % 2) ? 0 : __GFP_ACCOUNT;
> @@ -347,6 +352,15 @@ static void overflow_handler_test_nolock(struct perf_event *event,
>  	ctx->callback_count++;
>  }
>  
> +static void overflow_handler_test_nolock(struct perf_event *event,
> +					 struct perf_sample_data *data,
> +					 struct pt_regs *regs)
> +{
> +	struct test_nolock_context *ctx = event->overflow_handler_context;
> +
> +	test_nolock(ctx);
> +}
> +
>  static bool enable_perf_events(struct test_nolock_context *ctx)
>  {
>  	struct perf_event *event;
> @@ -382,17 +396,60 @@ static void disable_perf_events(struct test_nolock_context *ctx)
>  	perf_event_disable(ctx->event);
>  	perf_event_release_kernel(ctx->event);
>  }
> +#else
> +static bool enable_perf_events(struct test_nolock_context *ctx) { return false; }
> +static void disable_perf_events(struct test_nolock_context *ctx) { }
> +#endif
> +
> +#if defined(CONFIG_KPROBES) && defined(CONFIG_SMP)
> +static int slab_kprobe_pre_handler(struct kprobe *p, struct pt_regs *regs)
> +{
> +	struct test_nolock_context *ctx;
> +
> +	ctx = container_of(p, struct test_nolock_context, kprobe);
> +	test_nolock(ctx);
> +	return 0;
> +}
> +
> +static bool register_slab_kprobes(struct test_nolock_context *ctx)
> +{
> +	ctx->kprobe.symbol_name = "slab_attach_kprobe_locked";
> +	ctx->kprobe.pre_handler = slab_kprobe_pre_handler;
> +
> +	if (register_kprobe(&ctx->kprobe))
> +		return false;
> +	return true;
> +}
> +
> +static void unregister_slab_kprobes(struct test_nolock_context *ctx)
> +{
> +	kunit_info(ctx->test, "kprobes: callback_count: %d, alloc_ok: %d, alloc_fail: %d\n",
> +		   ctx->callback_count, ctx->alloc_ok, ctx->alloc_fail);
> +	unregister_kprobe(&ctx->kprobe);
> +}
> +#else
> +static bool register_slab_kprobes(struct test_nolock_context *ctx) { return false; }
> +static void unregister_slab_kprobes(struct test_nolock_context *ctx) { }
> +#endif
>  
>  static void test_kmalloc_kfree_nolock(struct kunit *test)
>  {
>  	int i, j;
> -	struct test_nolock_context ctx = { .test = test };
> +	struct test_nolock_context perf_ctx = { .test = test };
> +	struct test_nolock_context kprobe_ctx = { .test = test };
>  	bool alloc_fail = false;
>  	bool perf_events_enabled;
> +	bool slab_kprobes_enabled;
>  
> -	perf_events_enabled = enable_perf_events(&ctx);
> -	if (!perf_events_enabled)
> -		kunit_skip(test, "Failed to create perf event");
> +	perf_events_enabled = enable_perf_events(&perf_ctx);
> +	slab_kprobes_enabled = register_slab_kprobes(&kprobe_ctx);
> +
> +	if (!perf_events_enabled && !slab_kprobes_enabled)
> +		kunit_skip(test, "Failed to enable perf event and kprobe, skipping");
> +	else if (!perf_events_enabled)
> +		kunit_info(test, "Failed to create perf event");
> +	if (!slab_kprobes_enabled)
> +		kunit_info(test, "Failed to register kprobe pre-handler");
>  
>  	for (i = 0; i < NR_ITERATIONS; i++) {
>  		for (j = 0; j < NR_OBJECTS; j++) {
> @@ -412,7 +469,10 @@ static void test_kmalloc_kfree_nolock(struct kunit *test)
>  	}
>  
>  cleanup:
> -	disable_perf_events(&ctx);
> +	if (perf_events_enabled)
> +		disable_perf_events(&perf_ctx);
> +	if (slab_kprobes_enabled)
> +		unregister_slab_kprobes(&kprobe_ctx);
>  
>  	if (alloc_fail)
>  		kunit_skip(test, "Allocation failed");
> @@ -444,7 +504,7 @@ static struct kunit_case test_cases[] = {
>  	KUNIT_CASE(test_kfree_rcu_wq_destroy),
>  	KUNIT_CASE(test_leak_destroy),
>  	KUNIT_CASE(test_krealloc_redzone_zeroing),
> -#ifdef CONFIG_PERF_EVENTS
> +#ifdef SLUB_KUNIT_TEST_KMALLOC_KFREE_NOLOCK
>  	KUNIT_CASE_SLOW(test_kmalloc_kfree_nolock),
>  #endif
>  	{}
> diff --git a/mm/slub.c b/mm/slub.c
> index 813fb863254d..87ca154ccd80 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -908,6 +908,24 @@ static inline unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
>  }
>  #endif
>  
> +/*
> + * A no-op function used to attach kprobe handlers in slub_kunit tests.
> + * The barrier is needed to prevent the compiler from optimizing out callsites.
> + */
> +#if defined(CONFIG_DEBUG_VM) || defined(CONFIG_PROVE_LOCKING)
> +static noinline void slab_attach_kprobe_locked(void)
> +{
> +	barrier();
> +}
> +#else
> +static inline void slab_attach_kprobe_locked(void) { }
> +#endif
> +
> +#define slab_lockdep_assert_held(lock) do {	\
> +	lockdep_assert_held(lock);		\
> +	slab_attach_kprobe_locked();	\
> +} while (0)
> +
>  #ifdef CONFIG_SLUB_DEBUG
>  
>  /*
> @@ -1665,7 +1683,7 @@ static void add_full(struct kmem_cache *s,
>  	if (!(s->flags & SLAB_STORE_USER))
>  		return;
>  
> -	lockdep_assert_held(&n->list_lock);
> +	slab_lockdep_assert_held(&n->list_lock);
>  	list_add(&slab->slab_list, &n->full);
>  }
>  
> @@ -1674,7 +1692,7 @@ static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct
>  	if (!(s->flags & SLAB_STORE_USER))
>  		return;
>  
> -	lockdep_assert_held(&n->list_lock);
> +	slab_lockdep_assert_held(&n->list_lock);
>  	list_del(&slab->slab_list);
>  }
>  
> @@ -2866,7 +2884,7 @@ static unsigned int __sheaf_flush_main_batch(struct kmem_cache *s)
>  	void *objects[PCS_BATCH_MAX];
>  	struct slab_sheaf *sheaf;
>  
> -	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
> +	slab_lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
>  
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  	sheaf = pcs->main;
> @@ -3545,7 +3563,7 @@ __add_partial(struct kmem_cache_node *n, struct slab *slab, enum add_mode mode)
>  static inline void add_partial(struct kmem_cache_node *n,
>  				struct slab *slab, enum add_mode mode)
>  {
> -	lockdep_assert_held(&n->list_lock);
> +	slab_lockdep_assert_held(&n->list_lock);
>  	__add_partial(n, slab, mode);
>  }
>  
> @@ -3559,7 +3577,7 @@ static inline void clear_node_partial_state(struct kmem_cache_node *n,
>  static inline void remove_partial(struct kmem_cache_node *n,
>  					struct slab *slab)
>  {
> -	lockdep_assert_held(&n->list_lock);
> +	slab_lockdep_assert_held(&n->list_lock);
>  	list_del(&slab->slab_list);
>  	clear_node_partial_state(n, slab);
>  }
> @@ -3575,7 +3593,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
>  {
>  	void *object;
>  
> -	lockdep_assert_held(&n->list_lock);
> +	slab_lockdep_assert_held(&n->list_lock);
>  
>  #ifdef CONFIG_SLUB_DEBUG
>  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> @@ -4646,7 +4664,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
>  	struct node_barn *barn;
>  	bool allow_spin;
>  
> -	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
> +	slab_lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
>  
>  	/* Bootstrap or debug cache, back off */
>  	if (unlikely(!cache_has_sheaves(s))) {
> @@ -5786,7 +5804,7 @@ static void __pcs_install_empty_sheaf(struct kmem_cache *s,
>  		struct slub_percpu_sheaves *pcs, struct slab_sheaf *empty,
>  		struct node_barn *barn)
>  {
> -	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
> +	slab_lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
>  
>  	/* This is what we expect to find if nobody interrupted us. */
>  	if (likely(!pcs->spare)) {
> @@ -5837,7 +5855,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
>  	bool put_fail;
>  
>  restart:
> -	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
> +	slab_lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
>  
>  	/* Bootstrap or debug cache, back off */
>  	if (unlikely(!cache_has_sheaves(s))) {
> 

