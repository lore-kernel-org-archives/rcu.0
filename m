Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2DD2DF130
	for <rcu@vger.kernel.org>; Wed, 11 Feb 2026 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770805019; cv=none; b=tZ1ynha7gvJz9drKHeg2A+pWUrHxwUcSRA+k7oXnZUXkENmXZoe5Wio0zMQOagwFifnIL5kseaNG3ng+uAug4knmx/UdotSFGNzeEGgc8PZuqwZj30eG3oAwGXB1Kb4SyiQjwFtat/QMyLQ4e3ib9Sa5K1yk/V7QDWwy9RbIsFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770805019; c=relaxed/simple;
	bh=f9T/vTqYrhfenx3QQeCmgFCY6qkXEsi9qXftduN0ey4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1ibWf5sNIdE40769QVsxPRnx6Pb9T7CevBJbZajjB6VAx5Q2H2p1hKf67svL+htVysISUz+czkt6/wNOQdmfHSkikIy7XPibuvishgBjLoHWV61MKOU8G38s9SKPUFYQj4KBdg/oXNaeId2UncI8cdNBSx+IJxAABzcz9rnAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWtKqGP3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWtKqGP3"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59e4993e00aso1789373e87.3
        for <rcu@vger.kernel.org>; Wed, 11 Feb 2026 02:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770805014; x=1771409814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/bpz+fockC+/IFBLnG8M7+Uj5fbJveug8L/H6uDYPmc=;
        b=VWtKqGP3tknm+cuHufk5ufd8UBykkcT+Wjb4XC1G5AD30RocQX2KQ+sbnCNY5P6WTu
         hzkDMUGkPRlpopwYxcVpFjhlCIEciYkvrgfem8S5ISv75kP8bvb+Gcr40sCHzTU0yZpR
         ZK02LWSEzprc59Ld5zwCcBWB/zT81N3zwP5/QD2z/9k40qqntnPGZ/hH8Nytu7bF2w+3
         NiGbhrPwZu6k+C1SnDxFFuE8n33yyKlhQMUJ2A9UBvagI3/qNDPi+u6VraRz6TRu2xo/
         0AdnNIR6uqvjjYq1rLFy8zb9mpznNn4LjXlzl1ZU57KohvTZqAAaf8DFXkPtfkNfHuF5
         Hu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770805014; x=1771409814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bpz+fockC+/IFBLnG8M7+Uj5fbJveug8L/H6uDYPmc=;
        b=J59kH0b+NbemTgrmbRQqzD5dkkPFoYbfR/QVvFOhroCl3hfgc66gLoM/h4OI+W0tGN
         W9tiPhyo5ZNNrS0dovrHW0XqEMkQeNEB0BXMNp6JhUMgmLy96x8Plb3MIbMyWUmR/QIF
         EjgZAkMw0tEFM3WGMUu6tuOsobaFY7oWxf2WEqxiKM6Y4IL2jx5mIz8WwkC9gy0NnHHm
         0IUnD3aoFnULR0Z85RFqqUeE03kym0RdFKOZPBrlGyTdpFDZd7K02dkuWJa0o5UxUkZG
         fIgkHnEj7UddKp354F8/L5XHnvUfLdYCcusJeQXI3HrrPqyra4B2NLzYeDxjd2lMNN9k
         /qoA==
X-Forwarded-Encrypted: i=1; AJvYcCX9DSTfH+nWpfpTtjzpk+FuwkaRkC0ICz2yTaVutJT9IO4C7KlTuVA4eadERTTj0TdVAEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzquOG8l+CL6ks+EbnURi92AXCb3SDeuX34UA1GQlHPQGPFl5q3
	u04EWZmCk7HAfrYe+nkRPbJkM+M4WLJbeHJTrdUHNief6hapLIdU5oAn
X-Gm-Gg: AZuq6aKFmUHBBevxjo1vqClH5ZMNh9vmk1NGubJHcOmC9CR1nCcrj/BYT493+vsxDWY
	tY3DoSzkMmC8hpKQfOD0JXcivCyJu3asn2RU0RBlHZDlLmbbs5RZPl5Ny9SgXQaQnr1elbePQvy
	CM17yWnv9WXxol5jhaiiia2Yvt7COyUCiWtWHVUU7G1nSZsfjXKcoC0akQoALRofinZxOFH+BFx
	X1zHMsHUPXxCq+3zcGeWa3CUGNB8Ok0zlrbJ/SmMvwdkkbeYu5ZHzv0FR40tfa1+z8ewcbhtywF
	MaEDJ/YFZIo3VBiQOQt5yGyXy0b8AM/3x+/vyyKyoWY+SZUHKUAQEHUWwtPeXymeYcEXhlnNBOy
	MoMEXu73+xeQPKwRWjfwFpdOgstPKej0ooYlsgZ32FmdGXfZeOCqq1L1U6fWdBcDq
X-Received: by 2002:a05:6512:b1b:b0:59b:7185:757d with SMTP id 2adb3069b0e04-59e4516eaffmr5943215e87.50.1770805014074;
        Wed, 11 Feb 2026 02:16:54 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f56312csm254910e87.6.2026.02.11.02.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 02:16:53 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 11 Feb 2026 11:16:51 +0100
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] mm/slab: introduce k[v]free_rcu() with struct
 rcu_ptr
Message-ID: <aYxXE6CC0XQr1KNK@milan>
References: <20260206093410.160622-1-harry.yoo@oracle.com>
 <20260206093410.160622-2-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206093410.160622-2-harry.yoo@oracle.com>

On Fri, Feb 06, 2026 at 06:34:04PM +0900, Harry Yoo wrote:
> k[v]free_rcu() repurposes two fields of struct rcu_head: 'func' to store
> the start address of the object, and 'next' to link objects.
> 
> However, using 'func' to store the start address is unnecessary:
> 
>   1. slab can get the start address from the address of struct rcu_head
>      field via nearest_obj(), and
> 
>   2. vmalloc and large kmalloc can get the start address by aligning
>      down the address of the struct rcu_head field to the page boundary.
> 
> Therefore, allow an 8-byte (on 64-bit) field (of a new type called
> struct rcu_ptr) to be used with k[v]free_rcu() with two arguments.
> 
> Some users use both call_rcu() and k[v]free_rcu() to process callbacks
> (e.g., maple tree), so it makes sense to have struct rcu_head field
> to handle both cases. However, many users that simply free objects via
> kvfree_rcu() can save one pointer by using struct rcu_ptr instead of
> struct rcu_head.
> 
> Note that struct rcu_ptr is a single pointer only when
> CONFIG_KVFREE_RCU_BATCHED=y. To keep kvfree_rcu() implementation minimal
> when CONFIG_KVFREE_RCU_BATCHED is disabled, struct rcu_ptr is the size
> as struct rcu_head, and the implementation of kvfree_rcu() remains
> unchanged in that configuration.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  include/linux/rcupdate.h | 61 +++++++++++++++++++++++++++-------------
>  include/linux/types.h    |  9 ++++++
>  mm/slab_common.c         | 40 +++++++++++++++-----------
>  3 files changed, 75 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index c5b30054cd01..8924edf7e8c1 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1059,22 +1059,30 @@ static inline void rcu_read_unlock_migrate(void)
>  /**
>   * kfree_rcu() - kfree an object after a grace period.
>   * @ptr: pointer to kfree for double-argument invocations.
> - * @rhf: the name of the struct rcu_head within the type of @ptr.
> + * @rf: the name of the struct rcu_head or struct rcu_ptr within the type of @ptr.
>   *
>   * Many rcu callbacks functions just call kfree() on the base structure.
>   * These functions are trivial, but their size adds up, and furthermore
>   * when they are used in a kernel module, that module must invoke the
>   * high-latency rcu_barrier() function at module-unload time.
> + * The kfree_rcu() function handles this issue by batching.
>   *
> - * The kfree_rcu() function handles this issue. In order to have a universal
> - * callback function handling different offsets of rcu_head, the callback needs
> - * to determine the starting address of the freed object, which can be a large
> - * kmalloc or vmalloc allocation. To allow simply aligning the pointer down to
> - * page boundary for those, only offsets up to 4095 bytes can be accommodated.
> - * If the offset is larger than 4095 bytes, a compile-time error will
> - * be generated in kvfree_rcu_arg_2(). If this error is triggered, you can
> - * either fall back to use of call_rcu() or rearrange the structure to
> - * position the rcu_head structure into the first 4096 bytes.
> + * Typically, struct rcu_head is used to process RCU callbacks, but it requires
> + * two pointers. However, since kfree_rcu() uses kfree() as the callback
> + * function, it can process callbacks with struct rcu_ptr, which is only
> + * one pointer in size (unless !CONFIG_KVFREE_RCU_BATCHED).
> + *
> + * The type of @rf can be either struct rcu_head or struct rcu_ptr, and when
> + * possible, it is recommended to use struct rcu_ptr due to its smaller size.
> + *
> + * In order to have a universal callback function handling different offsets
> + * of @rf, the callback needs to determine the starting address of the freed
> + * object, which can be a large kmalloc or vmalloc allocation. To allow simply
> + * aligning the pointer down to page boundary for those, only offsets up to
> + * 4095 bytes can be accommodated. If the offset is larger than 4095 bytes,
> + * a compile-time error will be generated in kvfree_rcu_arg_2().
> + * If this error is triggered, you can either fall back to use of call_rcu()
> + * or rearrange the structure to position @rf into the first 4096 bytes.
>   *
>   * The object to be freed can be allocated either by kmalloc() or
>   * kmem_cache_alloc().
> @@ -1084,8 +1092,8 @@ static inline void rcu_read_unlock_migrate(void)
>   * The BUILD_BUG_ON check must not involve any function calls, hence the
>   * checks are done in macros here.
>   */
> -#define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
> -#define kvfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
> +#define kfree_rcu(ptr, rf) kvfree_rcu_arg_2(ptr, rf)
> +#define kvfree_rcu(ptr, rf) kvfree_rcu_arg_2(ptr, rf)
>  
>  /**
>   * kfree_rcu_mightsleep() - kfree an object after a grace period.
> @@ -1107,22 +1115,37 @@ static inline void rcu_read_unlock_migrate(void)
>  #define kfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
>  #define kvfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
>  
> -/*
> - * In mm/slab_common.c, no suitable header to include here.
> - */
> -void kvfree_call_rcu(struct rcu_head *head, void *ptr);
> +
> +#ifdef CONFIG_KVFREE_RCU_BATCHED
> +void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr);
> +#define kvfree_call_rcu(head, ptr) \
> +	_Generic((head), \
> +		struct rcu_head *: kvfree_call_rcu_ptr,		\
> +		struct rcu_ptr *: kvfree_call_rcu_ptr,		\
> +		void *: kvfree_call_rcu_ptr			\
> +	)((struct rcu_ptr *)(head), (ptr))
> +#else
> +void kvfree_call_rcu_head(struct rcu_head *head, void *ptr);
> +static_assert(sizeof(struct rcu_head) == sizeof(struct rcu_ptr));
> +#define kvfree_call_rcu(head, ptr) \
> +	_Generic((head), \
> +		struct rcu_head *: kvfree_call_rcu_head,	\
> +		struct rcu_ptr *: kvfree_call_rcu_head,		\
> +		void *: kvfree_call_rcu_head			\
> +	)((struct rcu_head *)(head), (ptr))
> +#endif
>  
>  /*
>   * The BUILD_BUG_ON() makes sure the rcu_head offset can be handled. See the
>   * comment of kfree_rcu() for details.
>   */
> -#define kvfree_rcu_arg_2(ptr, rhf)					\
> +#define kvfree_rcu_arg_2(ptr, rf)					\
>  do {									\
>  	typeof (ptr) ___p = (ptr);					\
>  									\
>  	if (___p) {							\
> -		BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >= 4096);	\
> -		kvfree_call_rcu(&((___p)->rhf), (void *) (___p));	\
> +		BUILD_BUG_ON(offsetof(typeof(*(ptr)), rf) >= 4096);	\
> +		kvfree_call_rcu(&((___p)->rf), (void *) (___p));	\
>  	}								\
>  } while (0)
>  
> diff --git a/include/linux/types.h b/include/linux/types.h
> index d4437e9c452c..e5596ebab29c 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -245,6 +245,15 @@ struct callback_head {
>  } __attribute__((aligned(sizeof(void *))));
>  #define rcu_head callback_head
>  
> +
> +struct rcu_ptr {
> +#ifdef CONFIG_KVFREE_RCU_BATCHED
> +	struct rcu_ptr *next;
> +#else
> +	struct callback_head;
> +#endif
> +} __attribute__((aligned(sizeof(void *))));
> +
>  typedef void (*rcu_callback_t)(struct rcu_head *head);
>  typedef void (*call_rcu_func_t)(struct rcu_head *head, rcu_callback_t func);
>  
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index d5a70a831a2a..3ec99a5463d3 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1265,7 +1265,7 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
>  
>  #ifndef CONFIG_KVFREE_RCU_BATCHED
>  
> -void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> +void kvfree_call_rcu_head(struct rcu_head *head, void *ptr)
>  {
>  	if (head) {
>  		kasan_record_aux_stack(ptr);
> @@ -1278,7 +1278,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  	synchronize_rcu();
>  	kvfree(ptr);
>  }
> -EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> +EXPORT_SYMBOL_GPL(kvfree_call_rcu_head);
>  
>  void __init kvfree_rcu_init(void)
>  {
> @@ -1346,7 +1346,7 @@ struct kvfree_rcu_bulk_data {
>  
>  struct kfree_rcu_cpu_work {
>  	struct rcu_work rcu_work;
> -	struct rcu_head *head_free;
> +	struct rcu_ptr *head_free;
>  	struct rcu_gp_oldstate head_free_gp_snap;
>  	struct list_head bulk_head_free[FREE_N_CHANNELS];
>  	struct kfree_rcu_cpu *krcp;
> @@ -1381,8 +1381,7 @@ struct kfree_rcu_cpu_work {
>   */
>  struct kfree_rcu_cpu {
>  	// Objects queued on a linked list
> -	// through their rcu_head structures.
> -	struct rcu_head *head;
> +	struct rcu_ptr *head;
>  	unsigned long head_gp_snap;
>  	atomic_t head_count;
>  
> @@ -1523,18 +1522,28 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
>  }
>  
>  static void
> -kvfree_rcu_list(struct rcu_head *head)
> +kvfree_rcu_list(struct rcu_ptr *head)
>  {
> -	struct rcu_head *next;
> +	struct rcu_ptr *next;
>  
>  	for (; head; head = next) {
> -		void *ptr = (void *) head->func;
> -		unsigned long offset = (void *) head - ptr;
> +		void *ptr;
> +		unsigned long offset;
> +		struct slab *slab;
> +
> +		slab = virt_to_slab(head);
> +		if (is_vmalloc_addr(head) || !slab)
> +			ptr = (void *)PAGE_ALIGN_DOWN((unsigned long)head);
> +		else
> +			ptr = nearest_obj(slab->slab_cache, slab, head);
> +		offset = (void *)head - ptr;
>  
>  		next = head->next;
>  		debug_rcu_head_unqueue((struct rcu_head *)ptr);
>  		rcu_lock_acquire(&rcu_callback_map);
> -		trace_rcu_invoke_kvfree_callback("slab", head, offset);
> +		trace_rcu_invoke_kvfree_callback("slab",
> +						(struct rcu_head *)head,
> +						offset);
>  
>  		kvfree(ptr);
>  
> @@ -1552,7 +1561,7 @@ static void kfree_rcu_work(struct work_struct *work)
>  	unsigned long flags;
>  	struct kvfree_rcu_bulk_data *bnode, *n;
>  	struct list_head bulk_head[FREE_N_CHANNELS];
> -	struct rcu_head *head;
> +	struct rcu_ptr *head;
>  	struct kfree_rcu_cpu *krcp;
>  	struct kfree_rcu_cpu_work *krwp;
>  	struct rcu_gp_oldstate head_gp_snap;
> @@ -1675,7 +1684,7 @@ kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
>  {
>  	struct list_head bulk_ready[FREE_N_CHANNELS];
>  	struct kvfree_rcu_bulk_data *bnode, *n;
> -	struct rcu_head *head_ready = NULL;
> +	struct rcu_ptr *head_ready = NULL;
>  	unsigned long flags;
>  	int i;
>  
> @@ -1938,7 +1947,7 @@ void __init kfree_rcu_scheduler_running(void)
>   * be free'd in workqueue context. This allows us to: batch requests together to
>   * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
>   */
> -void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> +void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr)
>  {
>  	unsigned long flags;
>  	struct kfree_rcu_cpu *krcp;
> @@ -1960,7 +1969,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  	// Queue the object but don't yet schedule the batch.
>  	if (debug_rcu_head_queue(ptr)) {
>  		// Probable double kfree_rcu(), just leak.
> -		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> +		WARN_ONCE(1, "%s(): Double-freed call. rcu_ptr %p\n",
>  			  __func__, head);
>  
>  		// Mark as success and leave.
> @@ -1976,7 +1985,6 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  			// Inline if kvfree_rcu(one_arg) call.
>  			goto unlock_return;
>  
> -		head->func = ptr;
>  		head->next = krcp->head;
>  		WRITE_ONCE(krcp->head, head);
>  		atomic_inc(&krcp->head_count);
> @@ -2012,7 +2020,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  		kvfree(ptr);
>  	}
>  }
> -EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> +EXPORT_SYMBOL_GPL(kvfree_call_rcu_ptr);
>  
>  static inline void __kvfree_rcu_barrier(void)
>  {
> -- 
> 2.43.0
> 
If this is supposed to be invoked from NMI, should we better just detect
such context in the kvfree_call_rcu()? There are lot of "allow_spin" checks
which make it easy to get lost.

As i see you maintain llist and the idea is simply to re-enter to the
kvfree_rcu() again with allow-spin=true, since then it will be "normal"
context.

--
Uladzislau Rezki
