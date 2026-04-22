Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23D3ED5D4
	for <rcu@vger.kernel.org>; Wed, 22 Apr 2026 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868956; cv=none; b=KkdEKOsL9lTLPpSSCNXx2skfLJCPmxS5FlY8V7y1azvb48rHIJxvaDLr1E7ln2rdB2f586CDxcjkrvQCYUQlGPYvA8IrNz0qPf46ebgXfLPlaqd2Y9LSAxdU86TQq3uonjRWIZ2QW4Lz7op2TrFlTQTdaABuE9u5q64yY+5XCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868956; c=relaxed/simple;
	bh=055lUXxF6F4cdKelnuFBNtHBuISDnCy7GWxXsQpxbxw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EV3JQzyFFTcoeR7fhifPfIX4OYx5xHjQlf+s/7H6Dh/tezjBnNS5FjPLa1qN4d7JVm8YeDrVCBuHydAZKIOMQ3pPQ1IbTZEMRpeoJZxMjrsSo3EO0JDGDGNcWDEEPeL/Mda9crUfaqQYNeSfqxGaqzKCF7iInouByFNLh5kUKNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHZuqU87; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHZuqU87"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a3cee3a271so5711849e87.3
        for <rcu@vger.kernel.org>; Wed, 22 Apr 2026 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776868952; x=1777473752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SPbsrPGLG9xMvOdF2nLoe3SEbryafUSJDEvKzQRns/M=;
        b=nHZuqU87KK9lXhmYYImysX2VersL3PD1bwkEsNgK72brUZlkE12isYWDvCY5dkp82E
         6T6TXyOKKCJRWEvJcGiNj2hyRDT7Gxz1PIN7rGQbBVmxETTzdK4U0fJjsrttbDGoarEC
         GM/9nc7kAasU8oyXEJN8qvzE4/Rqss/8SzFsR2XJsnh0r9UpkS1MPi3lP8NpkfePR4G+
         1kSZRl3TIOB7e2im9uIW+V8dxGTkZZHGW8Pc1c42zWDkcz5y7lsv+l7kLksrgJ1u0GmI
         2M7MfgX4yf+6Nijj7pmPlVBy9P/vY5GZsRR1seTxrby4MsNbanZenc2BCEKqaYDQbhNJ
         Nbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776868952; x=1777473752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPbsrPGLG9xMvOdF2nLoe3SEbryafUSJDEvKzQRns/M=;
        b=UWvYvNlvgR89mDHHX98tiGLdDWM1fw5F3U9aMSa+QIKFe8ZXQvbUTpSWZ14xRdJ7sb
         S3FswQOf0bbum+v/4o1piOqlw/eDhqb+k0PkA55naaYxnMTk6t6jZcPULhdNY3xcYahd
         ziW+p8dr0BHBlcXax5OHb11ADeZtnDRyh7MDVnHBJKA8NuUTAi0v7D1/u4PHih00oyps
         AXlxO2VrjSt23bf934CJ9A/wQwJBJMKBVMELrohi12Jg8xq/I9aEjgZUox2Jd7sxuzSn
         kZzJNwgxfQWUIhDgAGIEG81rHfWVQMrpqxi301amtO0lIaJ6U4dOuZUKKsojTbgVIS5s
         uriA==
X-Forwarded-Encrypted: i=1; AFNElJ9wMX2NKk1DWJU08O2W4bmVyVvjSZ4w/bhBaOUEXPpmBg4JkI8GiLp8pFICgjIYi0cF47w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiz3+CekRETvD9PiW7eGLAnBCHsqTHpcAJoCoQsMxajj2F8BfP
	ekjlhJU3zQ7BPb767nHU1VwFuY8Pl4eKvrr9kiMgGw/r5+cC7AxuEBOu
X-Gm-Gg: AeBDiesk0WLxLfDLNPXfnEiWBbJ8sDm9TxzcKPsRIQOcC9S7QRAWSFzk8I5O5/M09er
	CU1oD7mBhqr5QRMboxt7J03IFOCRUGA+ceam/nFgEn9XfsU0oGdKZ7GIRmaz4hGVxFDIIPA4kO+
	xcgm6NZStvkENuOaY3uA1h94M8H7ddpWktnIEOJ/ZDE5RHrC7u+MQxwE/RY1nFv07zp66xtHjMZ
	Y4OcZ4MIob+YMiWvZeDkSvcJ1fs54tDVv18ieSzuyGzEoiL0a2c7uPH1kJWG6uaDL/fscqhiHq7
	2VBrIpAKSflunMAlB4R041g2jppE1FX4v6eZ2y4c8PVGrLcZ6yhQY0GlfM+uvwxUr0I1MtxrFQl
	xqwCQiAiYIiplZS0JsWzPZMjhnPnrQGh2j12Fa2ibhgrnNVhQAygMYK181KtjtNqmEV8IGuwSKB
	w=
X-Received: by 2002:a05:6512:159f:b0:5a3:f0f7:7da1 with SMTP id 2adb3069b0e04-5a4172cd17amr8844091e87.17.1776868951215;
        Wed, 22 Apr 2026 07:42:31 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e1248sm4469540e87.38.2026.04.22.07.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:42:30 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 22 Apr 2026 16:42:28 +0200
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/slab: introduce kfree_rcu_nolock()
Message-ID: <aejeVK0J_jHSfVhD@milan>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416091022.36823-5-harry@kernel.org>

On Thu, Apr 16, 2026 at 06:10:18PM +0900, Harry Yoo (Oracle) wrote:
> Currently, kfree_rcu() cannot be called when the context is unknown,
> which might not allow spinning on a lock. In such an unknown
> context, even calling call_rcu() is not legal, forcing users to
> implement some sort of deferred freeing.
> 
> Make users' lives easier by introducing kfree_rcu_nolock() variant.
> It passes allow_spin = false to kvfree_call_rcu(), which means spinning
> on a lock is not allowed because the context is unknown.
> 
> Unlike kfree_rcu(), kfree_rcu_nolock() only supports a 2-argument
> variant because, in the worst case where memory allocation fails,
> the caller cannot synchronously wait for the grace period to finish.
> 
> kfree_rcu_nolock() tries to acquire kfree_rcu_cpu spinlock.
> When trylock succeeds, get a cached bnode and use it to store the
> pointer. Just like existing kvfree_rcu() with 2-arg variant, fall back
> if there's no cached bnode available.
> 
> If trylock fails, insert the object to the per-cpu lockless list
> and defer freeing using irq_work that calls kvfree_call_rcu() later.
> Note that in the most of the cases the context allows spinning,
> and thus it is worth trying to acquire the lock.
> 
> To ensure rcu sheaves are flushed in flush_rcu_all_sheaves() and
> flush_rcu_sheaves_on_cache(), deferred objects must be processed before
> calling them. Otherwise, irq work might insert objects to a sheaf and
> end up not flushing it. Implement a defer_kvfree_rcu_barrier() and
> call it before flushing rcu sheaves.
> 
> In case kmemleak or debug objects is enabled, always defer freeing as
> those debug features use spinlocks.
> 
> Determine whether work items (page cache worker or delayed monitor) need
> to be queued under krcp->lock. If so, use irq_work to defer the actual
> work submission. The existing logic prevents excessive irq_work
> queueing.
> 
> For now, the sheaves layer is bypassed if spinning is not allowed.
> 
> Without CONFIG_KVFREE_RCU_BATCHED, all frees in the !allow_spin case are
> deferred using irq_work. Move kvfree_rcu_barrier[_on_cache]() to
> mm/slab_common.c and let them wait for irq_works.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
>  include/linux/rcupdate.h |  23 ++--
>  include/linux/slab.h     |  16 +--
>  mm/slab.h                |   1 +
>  mm/slab_common.c         | 260 +++++++++++++++++++++++++++++++--------
>  mm/slub.c                |   6 +-
>  5 files changed, 231 insertions(+), 75 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 3ca82500a19f..8776b2a394bb 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1090,8 +1090,9 @@ static inline void rcu_read_unlock_migrate(void)
>   * The BUILD_BUG_ON check must not involve any function calls, hence the
>   * checks are done in macros here.
>   */
> -#define kfree_rcu(ptr, rf) kvfree_rcu_arg_2(ptr, rf)
> -#define kvfree_rcu(ptr, rf) kvfree_rcu_arg_2(ptr, rf)
> +#define kfree_rcu(ptr, rf) kvfree_rcu_arg_2(ptr, rf, true)
> +#define kfree_rcu_nolock(ptr, rf) kvfree_rcu_arg_2(ptr, rf, false)
> +#define kvfree_rcu(ptr, rf) kvfree_rcu_arg_2(ptr, rf, true)
>  
>  /**
>   * kfree_rcu_mightsleep() - kfree an object after a grace period.
> @@ -1115,35 +1116,35 @@ static inline void rcu_read_unlock_migrate(void)
>  
>  
>  #ifdef CONFIG_KVFREE_RCU_BATCHED
> -void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr);
> -#define kvfree_call_rcu(head, ptr) \
> +void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr, bool allow_spin);
> +#define kvfree_call_rcu(head, ptr, spin) \
>  	_Generic((head), \
>  		struct rcu_head *: kvfree_call_rcu_ptr,		\
>  		struct rcu_ptr *: kvfree_call_rcu_ptr,		\
>  		void *: kvfree_call_rcu_ptr			\
> -	)((struct rcu_ptr *)(head), (ptr))
> +	)((struct rcu_ptr *)(head), (ptr), spin)
>  #else
> -void kvfree_call_rcu_head(struct rcu_head *head, void *ptr);
> +void kvfree_call_rcu_head(struct rcu_head *head, void *ptr, bool allow_spin);
>  static_assert(sizeof(struct rcu_head) == sizeof(struct rcu_ptr));
> -#define kvfree_call_rcu(head, ptr) \
> +#define kvfree_call_rcu(head, ptr, spin) \
>  	_Generic((head), \
>  		struct rcu_head *: kvfree_call_rcu_head,	\
>  		struct rcu_ptr *: kvfree_call_rcu_head,		\
>  		void *: kvfree_call_rcu_head			\
> -	)((struct rcu_head *)(head), (ptr))
> +	)((struct rcu_head *)(head), (ptr), spin)
>  #endif
>  
>  /*
>   * The BUILD_BUG_ON() makes sure the rcu_head offset can be handled. See the
>   * comment of kfree_rcu() for details.
>   */
> -#define kvfree_rcu_arg_2(ptr, rf)					\
> +#define kvfree_rcu_arg_2(ptr, rf, spin)					\
>  do {									\
>  	typeof (ptr) ___p = (ptr);					\
>  									\
>  	if (___p) {							\
>  		BUILD_BUG_ON(offsetof(typeof(*(ptr)), rf) >= 4096);	\
> -		kvfree_call_rcu(&((___p)->rf), (void *) (___p));	\
> +		kvfree_call_rcu(&((___p)->rf), (void *) (___p), spin);	\
>  	}								\
>  } while (0)
>  
> @@ -1152,7 +1153,7 @@ do {								\
>  	typeof(ptr) ___p = (ptr);				\
>  								\
>  	if (___p)						\
> -		kvfree_call_rcu(NULL, (void *) (___p));		\
> +		kvfree_call_rcu(NULL, (void *) (___p), true);	\
>  } while (0)
>  
>  /*
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 15a60b501b95..67528f698fe2 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -1238,23 +1238,13 @@ extern void kvfree_sensitive(const void *addr, size_t len);
>  
>  unsigned int kmem_cache_size(struct kmem_cache *s);
>  
> -#ifndef CONFIG_KVFREE_RCU_BATCHED
> -static inline void kvfree_rcu_barrier(void)
> -{
> -	rcu_barrier();
> -}
> -
> -static inline void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
> -{
> -	rcu_barrier();
> -}
> -
> -static inline void kfree_rcu_scheduler_running(void) { }
> -#else
>  void kvfree_rcu_barrier(void);
>  
>  void kvfree_rcu_barrier_on_cache(struct kmem_cache *s);
>  
> +#ifndef CONFIG_KVFREE_RCU_BATCHED
> +static inline void kfree_rcu_scheduler_running(void) { }
> +#else
>  void kfree_rcu_scheduler_running(void);
>  #endif
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index c735e6b4dddb..ae2e990e8dc2 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -412,6 +412,7 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
>  bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
>  void flush_all_rcu_sheaves(void);
>  void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
> +void defer_kvfree_rcu_barrier(void);
>  
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>  			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index cddbf3279c13..e840956233dd 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1311,6 +1311,14 @@ struct kfree_rcu_cpu_work {
>   * the interactions with the slab allocators.
>   */
>  struct kfree_rcu_cpu {
> +	// Objects queued on a lockless linked list, used to free objects
> +	// in unknown contexts when trylock fails.
> +	struct llist_head defer_head;
> +
> +	struct irq_work defer_free;
> +	struct irq_work sched_delayed_monitor;
> +	struct irq_work run_page_cache_worker;
> +
>  	// Objects queued on a linked list
>  	struct rcu_ptr *head;
>  	unsigned long head_gp_snap;
> @@ -1333,12 +1341,99 @@ struct kfree_rcu_cpu {
>  	struct llist_head bkvcache;
>  	int nr_bkv_objs;
>  };
> +
> +static void defer_kfree_rcu_irq_work_fn(struct irq_work *work);
> +static void sched_delayed_monitor_irq_work_fn(struct irq_work *work);
> +static void run_page_cache_worker_irq_work_fn(struct irq_work *work);
> +
> +static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> +	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
> +	.defer_head = LLIST_HEAD_INIT(defer_head),
> +	.defer_free = IRQ_WORK_INIT(defer_kfree_rcu_irq_work_fn),
> +	.sched_delayed_monitor =
> +		IRQ_WORK_INIT_LAZY(sched_delayed_monitor_irq_work_fn),
> +	.run_page_cache_worker =
> +		IRQ_WORK_INIT_LAZY(run_page_cache_worker_irq_work_fn),
> +};
> +#else
> +struct kfree_rcu_cpu {
> +	struct llist_head defer_head;
> +	struct irq_work defer_free;
> +};
> +
> +static void defer_kfree_rcu_irq_work_fn(struct irq_work *work);
> +
> +static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> +	.defer_head = LLIST_HEAD_INIT(defer_head),
> +	.defer_free = IRQ_WORK_INIT(defer_kfree_rcu_irq_work_fn),
> +};
>  #endif
>  
> -#ifndef CONFIG_KVFREE_RCU_BATCHED
> +/* Wait for deferred work from kfree_rcu_nolock() */
> +void defer_kvfree_rcu_barrier(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		irq_work_sync(&per_cpu_ptr(&krc, cpu)->defer_free);
> +}
> +
> +static void *object_start_addr(void *ptr)
> +{
> +	struct slab *slab;
> +	void *start;
> +
> +	if (is_vmalloc_addr(ptr)) {
> +		start  = (void *)PAGE_ALIGN_DOWN((unsigned long)ptr);
> +	} else {
> +		slab = virt_to_slab(ptr);
> +		if (!slab)
> +			start = (void *)PAGE_ALIGN_DOWN((unsigned long)ptr);
> +		else if (is_kfence_address(ptr))
> +			start = kfence_object_start(ptr);
> +		else
> +			start = nearest_obj(slab->slab_cache, slab, ptr);
> +	}
>  
> -void kvfree_call_rcu_head(struct rcu_head *head, void *ptr)
> +	return start;
> +}
> +
> +static void defer_kfree_rcu_irq_work_fn(struct irq_work *work)
>  {
> +	struct kfree_rcu_cpu *krcp;
> +	struct llist_head *head;
> +	struct llist_node *llnode, *pos, *t;
> +
> +	krcp = container_of(work, struct kfree_rcu_cpu, defer_free);
> +	head = &krcp->defer_head;
> +
> +	if (llist_empty(head))
> +		return;
> +
> +	llnode = llist_del_all(head);
> +	llist_for_each_safe(pos, t, llnode) {
> +		void *objp;
> +		struct rcu_ptr *rcup = (struct rcu_ptr *)pos;
> +
> +		objp = object_start_addr(rcup);
> +		kvfree_call_rcu(rcup, objp, true);
> +	}
> +}
> +
> +#ifndef CONFIG_KVFREE_RCU_BATCHED
> +void kvfree_call_rcu_head(struct rcu_head *head, void *ptr, bool allow_spin)
> +{
> +	if (!allow_spin) {
> +		struct kfree_rcu_cpu *krcp;
> +
> +		guard(preempt)();
> +
> +		krcp = this_cpu_ptr(&krc);
> +		if (llist_add((struct llist_node *)head, &krcp->defer_head))
> +			irq_work_queue(&krcp->defer_free);
> +		return;
> +	}
> +
>  	if (head) {
>  		kasan_record_aux_stack(ptr);
>  		call_rcu(head, kvfree_rcu_cb);
> @@ -1356,6 +1451,19 @@ void __init kvfree_rcu_init(void)
>  {
>  }
>  
> +void kvfree_rcu_barrier(void)
> +{
> +	defer_kvfree_rcu_barrier();
> +	rcu_barrier();
> +}
> +EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
> +
> +void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
> +{
> +	kvfree_rcu_barrier();
> +}
> +EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
> +
>  #else /* CONFIG_KVFREE_RCU_BATCHED */
>  
>  /*
> @@ -1405,9 +1513,16 @@ struct kvfree_rcu_bulk_data {
>  #define KVFREE_BULK_MAX_ENTR \
>  	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
>  
> -static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> -	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
> -};
> +
> +static void schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp);
> +
> +static void sched_delayed_monitor_irq_work_fn(struct irq_work *work)
> +{
> +	struct kfree_rcu_cpu *krcp;
> +
> +	krcp = container_of(work, struct kfree_rcu_cpu, sched_delayed_monitor);
> +	schedule_delayed_monitor_work(krcp);
> +}
>  
>  static __always_inline void
>  debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
> @@ -1421,13 +1536,18 @@ debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
>  }
>  
>  static inline struct kfree_rcu_cpu *
> -krc_this_cpu_lock(unsigned long *flags)
> +krc_this_cpu_lock(unsigned long *flags, bool allow_spin)
>  {
>  	struct kfree_rcu_cpu *krcp;
>  
>  	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
>  	krcp = this_cpu_ptr(&krc);
> -	raw_spin_lock(&krcp->lock);
> +	if (allow_spin) {
> +		raw_spin_lock(&krcp->lock);
> +	} else if (!raw_spin_trylock(&krcp->lock)) {
> +		local_irq_restore(*flags);
> +		return NULL;
> +	}
>  
>  	return krcp;
>  }
> @@ -1531,20 +1651,8 @@ kvfree_rcu_list(struct rcu_ptr *head)
>  	for (; head; head = next) {
>  		void *ptr;
>  		unsigned long offset;
> -		struct slab *slab;
> -
> -		if (is_vmalloc_addr(head)) {
> -			ptr = (void *)PAGE_ALIGN_DOWN((unsigned long)head);
> -		} else {
> -			slab = virt_to_slab(head);
> -			if (!slab)
> -				ptr = (void *)PAGE_ALIGN_DOWN((unsigned long)head);
> -			else if (is_kfence_address(head))
> -				ptr = kfence_object_start(head);
> -			else
> -				ptr = nearest_obj(slab->slab_cache, slab, head);
> -		}
>  
> +		ptr = object_start_addr(head);
>  		offset = (void *)head - ptr;
>  		next = head->next;
>  		debug_rcu_head_unqueue((struct rcu_head *)ptr);
> @@ -1663,18 +1771,26 @@ static int krc_count(struct kfree_rcu_cpu *krcp)
>  }
>  
>  static void
> -__schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> +__schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp, bool allow_spin)
>  {
>  	long delay, delay_left;
>  
>  	delay = krc_count(krcp) >= KVFREE_BULK_MAX_ENTR ? 1:KFREE_DRAIN_JIFFIES;
>  	if (delayed_work_pending(&krcp->monitor_work)) {
>  		delay_left = krcp->monitor_work.timer.expires - jiffies;
> -		if (delay < delay_left)
> -			mod_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
> +		if (delay < delay_left) {
> +			if (allow_spin)
> +				mod_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
> +			else
> +				irq_work_queue(&krcp->sched_delayed_monitor);
> +		}
>  		return;
>  	}
> -	queue_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
> +
> +	if (allow_spin)
> +		queue_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
> +	else
> +		irq_work_queue(&krcp->sched_delayed_monitor);
>  }
>  
>  static void
> @@ -1683,7 +1799,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
>  	unsigned long flags;
>  
>  	raw_spin_lock_irqsave(&krcp->lock, flags);
> -	__schedule_delayed_monitor_work(krcp);
> +	__schedule_delayed_monitor_work(krcp, true);
>  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  }
>  
> @@ -1847,25 +1963,25 @@ static void fill_page_cache_func(struct work_struct *work)
>  // Returns true if ptr was successfully recorded, else the caller must
>  // use a fallback.
>  static inline bool
> -add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> -	unsigned long *flags, void *ptr, bool can_alloc)
> +add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu *krcp,
> +	unsigned long *flags, void *ptr, bool can_alloc, bool allow_spin)
>  {
>  	struct kvfree_rcu_bulk_data *bnode;
>  	int idx;
>  
> -	*krcp = krc_this_cpu_lock(flags);
> -	if (unlikely(!(*krcp)->initialized))
> +	if (unlikely(!krcp->initialized))
>  		return false;
>  
>  	idx = !!is_vmalloc_addr(ptr);
> -	bnode = list_first_entry_or_null(&(*krcp)->bulk_head[idx],
> +	bnode = list_first_entry_or_null(&krcp->bulk_head[idx],
>  		struct kvfree_rcu_bulk_data, list);
>  
>  	/* Check if a new block is required. */
>  	if (!bnode || bnode->nr_records == KVFREE_BULK_MAX_ENTR) {
> -		bnode = get_cached_bnode(*krcp);
> +		bnode = get_cached_bnode(krcp);
>  		if (!bnode && can_alloc) {
> -			krc_this_cpu_unlock(*krcp, *flags);
> +			krc_this_cpu_unlock(krcp, *flags);
> +			VM_WARN_ON_ONCE(!allow_spin);
>  
>  			// __GFP_NORETRY - allows a light-weight direct reclaim
>  			// what is OK from minimizing of fallback hitting point of
> @@ -1880,7 +1996,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  			// scenarios.
>  			bnode = (struct kvfree_rcu_bulk_data *)
>  				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
> -			raw_spin_lock_irqsave(&(*krcp)->lock, *flags);
> +			raw_spin_lock_irqsave(&krcp->lock, *flags);
>  		}
>  
>  		if (!bnode)
> @@ -1888,14 +2004,14 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  
>  		// Initialize the new block and attach it.
>  		bnode->nr_records = 0;
> -		list_add(&bnode->list, &(*krcp)->bulk_head[idx]);
> +		list_add(&bnode->list, &krcp->bulk_head[idx]);
>  	}
>  
>  	// Finally insert and update the GP for this page.
>  	bnode->nr_records++;
>  	bnode->records[bnode->nr_records - 1] = ptr;
>  	get_state_synchronize_rcu_full(&bnode->gp_snap);
> -	atomic_inc(&(*krcp)->bulk_count[idx]);
> +	atomic_inc(&krcp->bulk_count[idx]);
>  
>  	return true;
>  }
> @@ -1911,7 +2027,32 @@ schedule_page_work_fn(struct hrtimer *t)
>  }
>  
>  static void
> -run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> +__run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> +{
> +	if (atomic_read(&krcp->backoff_page_cache_fill)) {
> +		queue_delayed_work(rcu_reclaim_wq,
> +			&krcp->page_cache_work,
> +				msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
> +	} else {
> +		hrtimer_setup(&krcp->hrtimer, schedule_page_work_fn, CLOCK_MONOTONIC,
> +			      HRTIMER_MODE_REL);
> +		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> +	}
> +}
> +
> +static void run_page_cache_worker_irq_work_fn(struct irq_work *work)
> +{
> +	unsigned long flags;
> +	struct kfree_rcu_cpu *krcp =
> +		container_of(work, struct kfree_rcu_cpu, run_page_cache_worker);
> +
> +	raw_spin_lock_irqsave(&krcp->lock, flags);
> +	__run_page_cache_worker(krcp);
> +	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> +}
> +
> +static void
> +run_page_cache_worker(struct kfree_rcu_cpu *krcp, bool allow_spin)
>  {
>  	// If cache disabled, bail out.
>  	if (!rcu_min_cached_objs)
> @@ -1919,15 +2060,10 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>  			!atomic_xchg(&krcp->work_in_progress, 1)) {
> -		if (atomic_read(&krcp->backoff_page_cache_fill)) {
> -			queue_delayed_work(rcu_reclaim_wq,
> -				&krcp->page_cache_work,
> -					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
> -		} else {
> -			hrtimer_setup(&krcp->hrtimer, schedule_page_work_fn, CLOCK_MONOTONIC,
> -				      HRTIMER_MODE_REL);
> -			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> -		}
> +		if (allow_spin)
> +			__run_page_cache_worker(krcp);
> +		else
> +			irq_work_queue(&krcp->run_page_cache_worker);
>  	}
>  }
>  
> @@ -1955,7 +2091,7 @@ void __init kfree_rcu_scheduler_running(void)
>   * be free'd in workqueue context. This allows us to: batch requests together to
>   * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
>   */
> -void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr)
> +void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr, bool allow_spin)
>  {
>  	unsigned long flags;
>  	struct kfree_rcu_cpu *krcp;
> @@ -1971,7 +2107,12 @@ void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr)
>  	if (!head)
>  		might_sleep();
>  
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
> +	if (!allow_spin && (IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD) ||
> +				IS_ENABLED(CONFIG_DEBUG_KMEMLEAK)))
> +		goto defer_free;
> +
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> +			(allow_spin && kfree_rcu_sheaf(ptr)))
>  		return;
>  
>  	// Queue the object but don't yet schedule the batch.
> @@ -1985,9 +2126,14 @@ void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr)
>  	}
>  
>  	kasan_record_aux_stack(ptr);
> -	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
> +
> +	krcp = krc_this_cpu_lock(&flags, allow_spin);
> +	if (!krcp)
> +		goto defer_free;
> +
> +	success = add_ptr_to_bulk_krc_lock(krcp, &flags, ptr, !head, allow_spin);
>  	if (!success) {
> -		run_page_cache_worker(krcp);
> +		run_page_cache_worker(krcp, allow_spin);
>  
>  		if (head == NULL)
>  			// Inline if kvfree_rcu(one_arg) call.
> @@ -2012,7 +2158,7 @@ void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr)
>  
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
> -		__schedule_delayed_monitor_work(krcp);
> +		__schedule_delayed_monitor_work(krcp, allow_spin);
>  
>  unlock_return:
>  	krc_this_cpu_unlock(krcp, flags);
> @@ -2023,10 +2169,22 @@ void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr)
>  	 * CPU can pass the QS state.
>  	 */
>  	if (!success) {
> +		VM_WARN_ON_ONCE(!allow_spin);
>  		debug_rcu_head_unqueue((struct rcu_head *) ptr);
>  		synchronize_rcu();
>  		kvfree(ptr);
>  	}
> +	return;
> +
> +defer_free:
> +	VM_WARN_ON_ONCE(allow_spin);
> +	guard(preempt)();
> +
> +	krcp = this_cpu_ptr(&krc);
> +	if (llist_add((struct llist_node *)head, &krcp->defer_head))
> +		irq_work_queue(&krcp->defer_free);
> +	return;
> +
>  }
>  EXPORT_SYMBOL_GPL(kvfree_call_rcu_ptr);
>  
> @@ -2125,6 +2283,8 @@ EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
>   */
>  void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
>  {
> +	defer_kvfree_rcu_barrier();
> +
>  	if (cache_has_sheaves(s)) {
>  		flush_rcu_sheaves_on_cache(s);
>  		rcu_barrier();
> diff --git a/mm/slub.c b/mm/slub.c
> index 92362eeb13e5..6f658ec00751 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4018,7 +4018,10 @@ static void flush_rcu_sheaf(struct work_struct *w)
>  }
>  
>  
> -/* needed for kvfree_rcu_barrier() */
> +/*
> + * Needed for kvfree_rcu_barrier(). The caller should invoke
> + * defer_kvfree_rcu_barrier() before calling this function.
> + */
>  void flush_rcu_sheaves_on_cache(struct kmem_cache *s)
>  {
>  	struct slub_flush_work *sfw;
> @@ -4053,6 +4056,7 @@ void flush_all_rcu_sheaves(void)
>  {
>  	struct kmem_cache *s;
>  
> +	defer_kvfree_rcu_barrier();
>  	cpus_read_lock();
>  	mutex_lock(&slab_mutex);
>  
> -- 
> 2.43.0
> 
As discussed or noted earlier, having third argument and check the
entire path with "if (allow_spin)" is not optimal and is not good
approach. I do not think it this would be a good fit for mainline.

Also, re-entering the same path with allow_spin = false feels awkward.

I think a better option is to add a separate kvfree_rcu_nmi() helper,
or similar, and avoid complicating the generic implementation. Otherwise,
the common path risks becoming harder to maintain.

Below is a simple implementation.

<patch>
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 04f3f86a4145..a9d674b9b806 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1109,6 +1109,7 @@ static inline void rcu_read_unlock_migrate(void)
  * In mm/slab_common.c, no suitable header to include here.
  */
 void kvfree_call_rcu(struct rcu_head *head, void *ptr);
+void kvfree_call_rcu_nolock(struct rcu_head *head, void *ptr);
 
 /*
  * The BUILD_BUG_ON() makes sure the rcu_head offset can be handled. See the
@@ -1132,6 +1133,16 @@ do {								\
 		kvfree_call_rcu(NULL, (void *) (___p));		\
 } while (0)
 
+#define kvfree_rcu_nmi(ptr, rhf)					\
+do {									\
+	typeof (ptr) ___p = (ptr);					\
+									\
+	if (___p) {							\
+		BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >= 4096);	\
+		kvfree_call_rcu_nolock(&((___p)->rhf), (void *) (___p));\
+	}								\
+} while (0)
+
 /*
  * Place this after a lock-acquisition primitive to guarantee that
  * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
diff --git a/mm/slab_common.c b/mm/slab_common.c
index d5a70a831a2a..f6ae3795ec6c 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1402,6 +1402,14 @@ struct kfree_rcu_cpu {
 
 	struct llist_head bkvcache;
 	int nr_bkv_objs;
+
+	/* For NMI context. */
+	struct llist_head drain_list;
+	struct llist_node *pending_list;
+
+	struct rcu_work drain_rcu_work;
+	struct irq_work drain_irqwork;
+	atomic_t drain_in_progress;
 };
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
@@ -1926,6 +1934,69 @@ void __init kfree_rcu_scheduler_running(void)
 	}
 }
 
+static void
+kvfree_rcu_nolock_work(struct work_struct *work)
+{
+	struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
+		struct kfree_rcu_cpu, drain_rcu_work);
+	struct llist_node *pos, *n, *pending;
+	bool queued;
+
+	pending = krcp->pending_list;
+	krcp->pending_list = NULL;
+	ASSERT_EXCLUSIVE_WRITER(krcp->pending_list);
+
+	llist_for_each_safe(pos, n, pending) {
+		struct rcu_head *rcu = (struct rcu_head *) pos;
+		void *ptr = (void *) rcu->func;
+		kvfree(ptr);
+	}
+
+	atomic_set(&krcp->drain_in_progress, 0);
+	if (!llist_empty(&krcp->drain_list)) {
+		if (!atomic_cmpxchg(&krcp->drain_in_progress, 0, 1)) {
+			krcp->pending_list = llist_del_all(&krcp->drain_list);
+			ASSERT_EXCLUSIVE_WRITER(krcp->pending_list);
+			queued = queue_rcu_work(rcu_reclaim_wq, &krcp->drain_rcu_work);
+			WARN_ON_ONCE(!queued);
+		}
+	}
+}
+
+static void
+kvfree_rcu_nolock_irqwork(struct irq_work *irqwork)
+{
+	struct kfree_rcu_cpu *krcp =
+		container_of(irqwork, struct kfree_rcu_cpu, drain_irqwork);
+	bool queued;
+
+	krcp->pending_list = llist_del_all(&krcp->drain_list);
+	ASSERT_EXCLUSIVE_WRITER(krcp->pending_list);
+
+	queued = queue_rcu_work(rcu_reclaim_wq, &krcp->drain_rcu_work);
+	WARN_ON_ONCE(!queued);
+}
+
+/*
+ * Queue a request for lazy invocation.
+ * Context: For NMI contexts or unknown contexts only.
+ */
+void
+kvfree_call_rcu_nolock(struct rcu_head *head, void *ptr)
+{
+	struct kfree_rcu_cpu *krcp = this_cpu_ptr(&krc);
+
+	head->func = ptr;
+	llist_add((struct llist_node *) head, &krcp->drain_list);
+
+	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING) {
+		/* Only first(and only one) user rings the bell. */
+		if (!atomic_cmpxchg(&krcp->drain_in_progress, 0, 1))
+			irq_work_queue(&krcp->drain_irqwork);
+	}
+}
+EXPORT_SYMBOL_GPL(kvfree_call_rcu_nolock);
+
 /*
  * Queue a request for lazy invocation of the appropriate free routine
  * after a grace period.  Please note that three paths are maintained,
@@ -2201,6 +2272,10 @@ void __init kvfree_rcu_init(void)
 
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
+
+		/* For NMI part. */
+		INIT_RCU_WORK(&krcp->drain_rcu_work, kvfree_rcu_nolock_work);
+		init_irq_work(&krcp->drain_irqwork, kvfree_rcu_nolock_irqwork);
 		krcp->initialized = true;
 	}
<patch>

I can prepare a patch to handle NMI safe or unknown contexts.

--
Uladzislau Rezki
