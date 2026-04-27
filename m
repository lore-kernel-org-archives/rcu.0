Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7211A3CB2E7
	for <rcu@vger.kernel.org>; Mon, 27 Apr 2026 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296770; cv=none; b=iQx+HffDkpunnO/piwpZwdQeUmDpVyEmVAnxsK8DXKFW4kfhVkwr4kTainSPLUzTg7ly57RDoD3CUEEvPwfvH/0FNtR6+H60s6t12VGpSChyXo8vbmZNXGV6wzOwl2FsvsP0ajBvB0ijuEUOD6YWvBhWlgZBDVUjxoD8jI9EHtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296770; c=relaxed/simple;
	bh=j406OpvUZz+7ciHe1QoVQlcLC12P+QXTt0xUkv0HFTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAaoqBxRhzlhdJO8VTQ+NEkFRemCGFnGu6aWMl3U+hv1INyHYd542cJYOYDdIApj+qsxODGjjkp6kDEaRG7FlRyHsBz1Mq3EJFWG78OcipyPFEatBr/ECyeuJPsW1vVM6ffvFI1lRAu4R2OotfjS0gyHQfDeb0e3uztNk/OzS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc6v+uxo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc6v+uxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C974C19425;
	Mon, 27 Apr 2026 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777296770;
	bh=j406OpvUZz+7ciHe1QoVQlcLC12P+QXTt0xUkv0HFTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nc6v+uxoJLbp7tjuc/ew2nH32fhXau6gnhIfzXNDVqZMhAxiRHj5oJhBI6ZMugdmp
	 /UYdNJRDR7DbZWbo0cxOC3lN2d3QUQSRMnZ1YlLl72F1SeglR2sdkldzLELbyReUe7
	 2MARoA01UaaRt7Sh9ZfikXvmRWCuHkt+9g+Fwc9q+Mk/QBstqaN3zKBQ/FV6trKpcS
	 zULqAUdLQFwX2PxnXgSXZdcz0YY10T4L3SqU+fX3d1KK+JFHOm6D3GTYYEOSSMNKDz
	 MqIboSkHwbTq0igsGJ/d/2r9utRZKQLU02TJBtEegidPCRP0G3d7AH1vt32JWZvo9o
	 cQN+KGbcqOwag==
Message-ID: <56381493-214b-406d-9121-f80be7658445@kernel.org>
Date: Mon, 27 Apr 2026 15:32:44 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] mm/slab: make kfree_rcu_nolock() work with sheaves
Content-Language: en-US
To: "Harry Yoo (Oracle)" <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Zqiang <qiang.zhang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
 linux-mm@kvack.org
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-6-harry@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260416091022.36823-6-harry@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/26 11:10, Harry Yoo (Oracle) wrote:
> Teach kfree_rcu_sheaf() how to handle the !allow_spin case. Similar to
> __pcs_replace_full_main(), try to get an empty sheaf from pcs->spare or
> the barn, but don't add !allow_spin support for alloc_empty_sheaf() and
> fail early instead.
> 
> Since call_rcu() does not support NMI contexts, kfree_rcu_sheaf() fails
> when the rcu sheaf becomes full.
> 
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
>  mm/slab.h        |  2 +-
>  mm/slab_common.c |  7 +++----
>  mm/slub.c        | 14 ++++++++++++--
>  3 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index ae2e990e8dc2..d7fd7626e9fe 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -409,7 +409,7 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
>  	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
>  }
>  
> -bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin);
>  void flush_all_rcu_sheaves(void);
>  void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
>  void defer_kvfree_rcu_barrier(void);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e840956233dd..46a2bee1662b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1716,7 +1716,7 @@ static void kfree_rcu_work(struct work_struct *work)
>  		kvfree_rcu_list(head);
>  }
>  
> -static bool kfree_rcu_sheaf(void *obj)
> +static bool kfree_rcu_sheaf(void *obj, bool allow_spin)
>  {
>  	struct kmem_cache *s;
>  	struct slab *slab;
> @@ -1730,7 +1730,7 @@ static bool kfree_rcu_sheaf(void *obj)
>  
>  	s = slab->slab_cache;
>  	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id()))
> -		return __kfree_rcu_sheaf(s, obj);
> +		return __kfree_rcu_sheaf(s, obj, allow_spin);
>  
>  	return false;
>  }
> @@ -2111,8 +2111,7 @@ void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr, bool allow_spin)
>  				IS_ENABLED(CONFIG_DEBUG_KMEMLEAK)))
>  		goto defer_free;
>  
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> -			(allow_spin && kfree_rcu_sheaf(ptr)))
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr, allow_spin))
>  		return;

I wonder if this patch is enough to drop (or reduce a lot) the PREEMPT_RT
incompatibility? It IIRC came from Ulad's review point [1] that since RT
spinlock is in fact a mutex, it's not unsafe to take it with e.g. disabled
preemption, and it's also why kfree_rcu_cpu uses a raw_spin_lock_t, etc.

But with kfree_rcu_sheaf now having allow_spin parameter and only doing a
trylock at most with that false, it should now be safe to allow it for
CONFIG_PREEMPT_RT, only pass allow_spin = false unconditionally there?

[1] https://lore.kernel.org/all/aL_uhPtztx7Ef0T2@pc636/

>  
>  	// Queue the object but don't yet schedule the batch.
> diff --git a/mm/slub.c b/mm/slub.c
> index 6f658ec00751..d0db8d070570 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5895,7 +5895,7 @@ static void rcu_free_sheaf(struct rcu_head *head)
>   */
>  static DEFINE_WAIT_OVERRIDE_MAP(kfree_rcu_sheaf_map, LD_WAIT_CONFIG);
>  
> -bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
>  {
>  	struct slub_percpu_sheaves *pcs;
>  	struct slab_sheaf *rcu_sheaf;
> @@ -5933,7 +5933,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>  			goto fail;
>  		}
>  
> -		empty = barn_get_empty_sheaf(barn, true);
> +		empty = barn_get_empty_sheaf(barn, allow_spin);
>  
>  		if (empty) {
>  			pcs->rcu_free = empty;
> @@ -5942,6 +5942,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>  
>  		local_unlock(&s->cpu_sheaves->lock);
>  
> +		/* It's easier to fall back than trying harder with !allow_spin */
> +		if (!allow_spin)
> +			goto fail;
> +
>  		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
>  
>  		if (!empty)
> @@ -5973,6 +5977,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>  	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
>  		rcu_sheaf = NULL;
>  	} else {
> +		if (unlikely(!allow_spin)) {
> +			/* call_rcu() cannot be called in an unknown context */
> +			rcu_sheaf->size--;
> +			local_unlock(&s->cpu_sheaves->lock);
> +			goto fail;
> +		}
>  		pcs->rcu_free = NULL;
>  		rcu_sheaf->node = numa_node_id();
>  	}

