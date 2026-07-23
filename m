Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9227433E61;
	Thu, 23 Jul 2026 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802462; cv=none; b=YAMs6xlMI73aBGvbpoGDDo9DuuRWfhlc7Jgoo87kwUkEXx1wn4/hTaN+MmJIjBCBP1eV+mceB2JFME8TnjsXo17WJK7Ubx8PKFIdFgfF+JL8oCa+0wMZSp539DOqHGSGf8WdPV7o7Cigt/vF38Kbk9pIhFHz4OYBhPBjdAtHt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802462; c=relaxed/simple;
	bh=CJWaVovH99NihRVmgGeOPEm0XQ6OX4r7AE41LMn7xWE=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=njtaN+5wNQf8wIAiVb+SosFNDPPxf3fXgjMkpGmN6dy+bY9tTnJyOHvzf15vPIuYn13WiGg4lsNgNfGGvkF1m1Hp1tRijNHwZAab1ekm1+o63ke0VRTG2awbYSTMw9c9xE1yMCGJICdFoAeqGHS4PhFSwAy3fdXr0PqEBNByf5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h5S434j4Vz4yjjK;
	Thu, 23 Jul 2026 18:27:31 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 66NARPOw069720;
	Thu, 23 Jul 2026 18:27:25 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 23 Jul 2026 18:27:27 +0800 (CST)
X-Zmail-TransId: 2afa6a61ec8f45b-ef006
X-Mailer: Zmail v1.0
Message-ID: <20260723182727858gUQJ4TgRU2b6v1kdgpkfV@zte.com.cn>
In-Reply-To: <20260720-kfree_rcu_nolock-v4-4-964e03c41a4e@kernel.org>
References: 20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org,20260720-kfree_rcu_nolock-v4-4-964e03c41a4e@kernel.org
Date: Thu, 23 Jul 2026 18:27:27 +0800 (CST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <harry@kernel.org>
Cc: <vbabka@kernel.org>, <akpm@linux-foundation.org>, <hao.li@linux.dev>,
        <cl@gentwo.org>, <rientjes@google.com>, <roman.gushchin@linux.dev>,
        <ast@kernel.org>, <andrii@kernel.org>, <puranjay@kernel.org>,
        <ameryhung@gmail.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>,
        <rostedt@goodmis.org>, <paulmck@kernel.org>, <frederic@kernel.org>,
        <neeraj.upadhyay@kernel.org>, <joelagnelf@nvidia.com>,
        <josh@joshtriplett.org>, <boqun@kernel.org>, <urezki@gmail.com>,
        <mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
        <qiang.zhang@linux.dev>, <pfalcato@suse.de>, <surenb@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-rt-devel@lists.linux.dev>, <rcu@vger.kernel.org>,
        <bpf@vger.kernel.org>, <harry@kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBzbGFiL2Zvci1uZXh0IHY0IDQvOF0gbW0vc2xhYjogZXh0ZW5kIGRlZmVycmVkIGZyZWUgbWVjaGFuaXNtIHRvIGhhbmRsZSByY3Ugc2hlYXZlcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 66NARPOw069720
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 23 Jul 2026 18:27:31 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A61EC93.000/4h5S434j4Vz4yjjK

Harry wrote:
> __kfree_rcu_sheaf() cannot invoke call_rcu() when spinning is not
> allowed and IRQs are disabled. To relax the limitation, extend the
> deferred free fallback so that a full rcu sheaf can be submitted to
> call_rcu() via the existing IRQ work.
> 
> Since the deferred mechanism does more than deferred freeing of objects,
> rename the struct to deferred_percpu_work and adjust names accordingly.
> 
> When a sheaf is queued on an IRQ work, it is detached from
> pcs->rcu_free but call_rcu() is not invoked until the irq_work runs.
> To keep the kvfree_rcu barrier's promise, call irq_work_sync() on each
> CPU before calling rcu_barrier().
> 
> In the meantime, remove the TODO item as apparently there is no simple
> and effective way to achieve that. This is because, unlike sheaves,
> kfree_rcu() batches objects from different caches together.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
>  mm/slab.h        |  2 +-
>  mm/slab_common.c |  7 ++---
>  mm/slub.c        | 85 +++++++++++++++++++++++++++++++++-----------------------
>  3 files changed, 53 insertions(+), 41 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 85ef2ebc9812..fdd293b3efa5 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -760,7 +760,7 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>  void __check_heap_object(const void *ptr, unsigned long n,
>               const struct slab *slab, bool to_user);
>  
> -void defer_free_barrier(void);
> +void deferred_work_barrier(void);
>  
>  static inline bool slub_debug_orig_size(struct kmem_cache *s)
>  {
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e07b4e6d6679..9c9ae1384f47 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -551,7 +551,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
>      }
>  
>      /* Wait for deferred work from kmalloc/kfree_nolock() */
> -    defer_free_barrier();
> +    deferred_work_barrier();
>  
>      cpus_read_lock();
>      mutex_lock(&slab_mutex);
> @@ -2113,13 +2113,10 @@ void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
>          cpus_read_lock();
>          flush_rcu_sheaves_on_cache(s);
>          cpus_read_unlock();
> +        deferred_work_barrier();
>          rcu_barrier();
>      }
>  

Hi Harry,

I noticed that your fix in [1] serializes defer_free_barrier() to
avoid concurrent irq_work_sync() waiters.

However, this patch still calls the renamed deferred_work_barrier()
outside that serialization scope, including the new call sites in
kvfree_rcu_barrier_on_cache() and flush_all_rcu_sheaves().

Is this series expected to depend on [1], with these call sites
moved under the same serialization? Or am I missing something?

[1]
https://lore.kernel.org/all/20260624-kmalloc-nolock-fixes-v1-4-fdf4d17351dd@kernel.org/

thanks,

--
With Best Regards,
Shengming

> -    /*
> -     * TODO: Introduce a version of __kvfree_rcu_barrier() that works
> -     * on a specific slab cache.
> -     */
>      __kvfree_rcu_barrier();
>  }
>  EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
> diff --git a/mm/slub.c b/mm/slub.c
> index 680fe64aff72..8afa6b47b1f2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -418,6 +418,8 @@ struct slab_sheaf {
>      union {
>          struct rcu_head rcu_head;
>          struct list_head barn_list;
> +        /* only used to defer call_rcu() in unknown context */
> +        struct llist_node llnode;
>          /* only used for prefilled sheafs */
>          struct {
>              unsigned int capacity;
> @@ -4077,6 +4079,20 @@ static void flush_all(struct kmem_cache *s)
>      cpus_read_unlock();
>  }
>  
> +struct deferred_percpu_work {
> +    struct llist_head objects;
> +    struct llist_head rcu_sheaves;
> +    struct irq_work work;
> +};
> +
> +static void deferred_percpu_work_fn(struct irq_work *work);
> +
> +static DEFINE_PER_CPU(struct deferred_percpu_work, deferred_percpu_work) = {
> +    .objects = LLIST_HEAD_INIT(objects),
> +    .rcu_sheaves = LLIST_HEAD_INIT(rcu_sheaves),
> +    .work = IRQ_WORK_INIT(deferred_percpu_work_fn),
> +};
> +
>  static void flush_rcu_sheaf(struct work_struct *w)
>  {
>      struct slub_percpu_sheaves *pcs;
> @@ -4148,6 +4164,7 @@ void flush_all_rcu_sheaves(void)
>      mutex_unlock(&slab_mutex);
>      cpus_read_unlock();
>  
> +    deferred_work_barrier();
>      rcu_barrier();
>  }
>  
> @@ -6136,16 +6153,6 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int free_flags)
>      if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
>          rcu_sheaf = NULL;
>      } else {
> -        /*
> -         * With !allow_spin, we might have interrupted call_rcu()'s
> -         * IRQ-disabled critical section. If IRQs are not disabled,
> -         * we know that's not the case.
> -         */
> -        if (unlikely(!allow_spin && irqs_disabled())) {
> -            rcu_sheaf->size--;
> -            local_unlock(&s->cpu_sheaves->lock);
> -            goto fail;
> -        }
>          pcs->rcu_free = NULL;
>          rcu_sheaf->node = numa_node_id();
>      }
> @@ -6154,8 +6161,22 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int free_flags)
>       * we flush before local_unlock to make sure a racing
>       * flush_all_rcu_sheaves() doesn't miss this sheaf
>       */
> -    if (rcu_sheaf)
> -        call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> +    if (rcu_sheaf) {
> +        /*
> +         * With !allow_spin, we might have interrupted call_rcu()'s
> +         * IRQ-disabled critical section. If IRQs are not disabled,
> +         * we know that's not the case.
> +         */
> +        if (unlikely(!allow_spin && irqs_disabled())) {
> +            struct deferred_percpu_work *dpw;
> +
> +            dpw = this_cpu_ptr(&deferred_percpu_work);
> +            if (llist_add(&rcu_sheaf->llnode, &dpw->rcu_sheaves))
> +                irq_work_queue(&dpw->work);
> +        } else {
> +            call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> +        }
> +    }
>  
>      local_unlock(&s->cpu_sheaves->lock);
>  
> @@ -6354,31 +6375,21 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>      }
>  }
>  
> -struct defer_free {
> -    struct llist_head objects;
> -    struct irq_work work;
> -};
> -
> -static void free_deferred_objects(struct irq_work *work);
> -
> -static DEFINE_PER_CPU(struct defer_free, defer_free_objects) = {
> -    .objects = LLIST_HEAD_INIT(objects),
> -    .work = IRQ_WORK_INIT(free_deferred_objects),
> -};
> -
>  /*
>   * In PREEMPT_RT irq_work runs in per-cpu kthread, so it's safe
>   * to take sleeping spin_locks from __slab_free().
>   * In !PREEMPT_RT irq_work will run after local_unlock_irqrestore().
>   */
> -static void free_deferred_objects(struct irq_work *work)
> +static void deferred_percpu_work_fn(struct irq_work *work)
>  {
> -    struct defer_free *df = container_of(work, struct defer_free, work);
> -    struct llist_head *objs = &df->objects;
> +    struct deferred_percpu_work *dpw;
> +    struct llist_head *objs, *rcu_sheaves;
>      struct llist_node *llnode, *pos, *t;
> +    struct slab_sheaf *sheaf, *next;
>  
> -    if (llist_empty(objs))
> -        return;
> +    dpw = container_of(work, struct deferred_percpu_work, work);
> +    rcu_sheaves = &dpw->rcu_sheaves;
> +    objs = &dpw->objects;
>  
>      llnode = llist_del_all(objs);
>      llist_for_each_safe(pos, t, llnode) {
> @@ -6402,27 +6413,31 @@ static void free_deferred_objects(struct irq_work *work)
>          __slab_free(s, slab, x, x, 1, _THIS_IP_);
>          stat(s, FREE_SLOWPATH);
>      }
> +
> +    llnode = llist_del_all(rcu_sheaves);
> +    llist_for_each_entry_safe(sheaf, next, llnode, llnode)
> +        call_rcu(&sheaf->rcu_head, rcu_free_sheaf);
>  }
>  
>  static void defer_free(struct kmem_cache *s, void *head)
>  {
> -    struct defer_free *df;
> +    struct deferred_percpu_work *dpw;
>  
>      guard(preempt)();
>  
>      head = kasan_reset_tag(head);
>  
> -    df = this_cpu_ptr(&defer_free_objects);
> -    if (llist_add(head + s->offset, &df->objects))
> -        irq_work_queue(&df->work);
> +    dpw = this_cpu_ptr(&deferred_percpu_work);
> +    if (llist_add(head + s->offset, &dpw->objects))
> +        irq_work_queue(&dpw->work);
>  }
>  
> -void defer_free_barrier(void)
> +void deferred_work_barrier(void)
>  {
>      int cpu;
>  
>      for_each_possible_cpu(cpu)
> -        irq_work_sync(&per_cpu_ptr(&defer_free_objects, cpu)->work);
> +        irq_work_sync(&per_cpu_ptr(&deferred_percpu_work, cpu)->work);
>  }
>  
>  static __fastpath_inline
> 
> -- 
> 2.53.0
