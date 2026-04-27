Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8CC3C199A
	for <rcu@vger.kernel.org>; Mon, 27 Apr 2026 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304865; cv=none; b=s36ENDxxynTOJ4d8iljHdVaPMe/JRLFSRWo1a9D8nO3N5SkKmRjcCFmz2rXFAJsfByaPGljbvtEIRsgZ/1y3JDU0u2IL/1cWNOGZN3nFHWtkIP+22NYfnYe6tMtlam9na6ncGiYnoVHseQ7Chbecrp0yuh3ugMXg2TkVDhdZJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304865; c=relaxed/simple;
	bh=6QyhfmdKWsqLeaywBIrX3y0EggSxtNipVXYb8EQYAwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HE8bBQMYGy7WLHOxlgwTC2RvrG9xeHUrKepqfxGPX/mw0CTjtwJuCHmgId9dtTg2roHFjJoT3yCZ/MTpO0HXH8BrtJNIWEpUrHfivX1VJN0CFv0DaowQ3xN9BZwR/G3AwFzpE62aUeMbcXf5v7V2lgA9kwksXWr24OmYuSrZEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhKAxlUM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhKAxlUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587BCC19425;
	Mon, 27 Apr 2026 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777304864;
	bh=6QyhfmdKWsqLeaywBIrX3y0EggSxtNipVXYb8EQYAwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZhKAxlUMRWyfsqXwj4T6Fkz9QSKKjgegXNz4WzuQTf9KMWkJPTy8ph3ZbZ8Bd7G46
	 xJ5aCLOxJGJOYWDfSGelgl4ysDhLuhxqeZFtBORtiihq6sI51VPoisfvYbhcKZ8p36
	 3tR/ImU/GqjtVQ/GzphvIuYx33SGJMOdNZNJN30om4ygH4JE0RjOS/TqVgGzUw+FOI
	 SDvDxURqQboX4OI5EBEumkv1SXxo4Uw9jIxuBBGFIzGR0qQTL6auU8ignQprGWLOuL
	 C9JTFrULcaNM517z8Wo3pF43BH71wWLgsmkkJGZ+zSIr5SoxrhC5h6q+QeB28oBwiY
	 lSQEF6WSZk6hA==
Message-ID: <8f5952c2-d710-46dc-8ba0-012db08c9578@kernel.org>
Date: Mon, 27 Apr 2026 17:47:39 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] mm/slab: wrap rcu sheaf handling with ifdef
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
 <20260416091022.36823-7-harry@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260416091022.36823-7-harry@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/26 11:10, Harry Yoo (Oracle) wrote:
> Freeing objects via rcu sheaves is only done with
> CONFIG_KVFREE_RCU_BATCHED. Wrap the related functions and struct
> fields with ifdef to make this dependency explicit.

With SLUB_TINY we have recently took the approach of limiting it to only
necessary parts, and not care about unused code etc where it doesn't cause
issues. I think it's good to minimize the ifdef complexity, so maybe it's
possible to limit it only to allow compiling with no warnings (including
IIRC W=1 clang that IIRC is stricter about unused functions)?

> Also remove a TODO about implementing __kvfree_rcu_barrier_on_cache()
> for a specific slab cache, as there doesn't seem to be a simple and
> effective way to do so.

Ack.

> 
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
>  mm/slab.h        |  3 +++
>  mm/slab_common.c |  4 ----
>  mm/slub.c        | 27 +++++++++++++++++++++++++--
>  3 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index d7fd7626e9fe..bdad5f389490 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -409,9 +409,12 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
>  	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
>  }
>  
> +#ifdef CONFIG_KVFREE_RCU_BATCHED
>  bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin);
>  void flush_all_rcu_sheaves(void);
>  void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
> +#endif
> +
>  void defer_kvfree_rcu_barrier(void);
>  
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 46a2bee1662b..347e52f1538c 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -2289,10 +2289,6 @@ void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
>  		rcu_barrier();
>  	}
>  
> -	/*
> -	 * TODO: Introduce a version of __kvfree_rcu_barrier() that works
> -	 * on a specific slab cache.
> -	 */
>  	__kvfree_rcu_barrier();
>  }
>  EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
> diff --git a/mm/slub.c b/mm/slub.c
> index d0db8d070570..91b8827d65da 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -421,7 +421,9 @@ struct slub_percpu_sheaves {
>  	local_trylock_t lock;
>  	struct slab_sheaf *main; /* never NULL when unlocked */
>  	struct slab_sheaf *spare; /* empty or full, may be NULL */
> +#ifdef CONFIG_KVFREE_RCU_BATCHED
>  	struct slab_sheaf *rcu_free; /* for batching kfree_rcu() */
> +#endif
>  };
>  
>  /*
> @@ -2923,6 +2925,7 @@ static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf)
>  	sheaf->size = 0;
>  }
>  
> +#ifdef CONFIG_KVFREE_RCU_BATCHED
>  static bool __rcu_free_sheaf_prepare(struct kmem_cache *s,
>  				     struct slab_sheaf *sheaf)
>  {
> @@ -2965,6 +2968,7 @@ static void rcu_free_sheaf_nobarn(struct rcu_head *head)
>  
>  	free_empty_sheaf(s, sheaf);
>  }
> +#endif
>  
>  /*
>   * Caller needs to make sure migration is disabled in order to fully flush
> @@ -2978,7 +2982,10 @@ static void rcu_free_sheaf_nobarn(struct rcu_head *head)
>  static void pcs_flush_all(struct kmem_cache *s)
>  {
>  	struct slub_percpu_sheaves *pcs;
> -	struct slab_sheaf *spare, *rcu_free;
> +	struct slab_sheaf *spare;
> +#ifdef CONFIG_KVFREE_RCU_BATCHED
> +	struct slab_sheaf *rcu_free;
> +#endif
>  
>  	local_lock(&s->cpu_sheaves->lock);
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
> @@ -2986,8 +2993,10 @@ static void pcs_flush_all(struct kmem_cache *s)
>  	spare = pcs->spare;
>  	pcs->spare = NULL;
>  
> +#ifdef CONFIG_KVFREE_RCU_BATCHED
>  	rcu_free = pcs->rcu_free;
>  	pcs->rcu_free = NULL;
> +#endif
>  
>  	local_unlock(&s->cpu_sheaves->lock);
>  
> @@ -2996,8 +3005,10 @@ static void pcs_flush_all(struct kmem_cache *s)
>  		free_empty_sheaf(s, spare);
>  	}
>  
> +#ifdef CONFIG_KVFREE_RCU_BATCHED
>  	if (rcu_free)
>  		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
> +#endif
>  
>  	sheaf_flush_main(s);
>  }
> @@ -3016,10 +3027,12 @@ static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
>  		pcs->spare = NULL;
>  	}
>  
> +#ifdef CONFIG_KVFREE_RCU_BATCHED
>  	if (pcs->rcu_free) {
>  		call_rcu(&pcs->rcu_free->rcu_head, rcu_free_sheaf_nobarn);
>  		pcs->rcu_free = NULL;
>  	}
> +#endif
>  }
>  
>  static void pcs_destroy(struct kmem_cache *s)
> @@ -3056,7 +3069,9 @@ static void pcs_destroy(struct kmem_cache *s)
>  		 */
>  
>  		WARN_ON(pcs->spare);
> +#ifdef CONFIG_KVFREE_RCU_BATCHED
>  		WARN_ON(pcs->rcu_free);
> +#endif
>  
>  		if (!WARN_ON(pcs->main->size)) {
>  			free_empty_sheaf(s, pcs->main);
> @@ -3937,7 +3952,11 @@ static bool has_pcs_used(int cpu, struct kmem_cache *s)
>  
>  	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
>  
> -	return (pcs->spare || pcs->rcu_free || pcs->main->size);
> +#ifdef CONFIG_KVFREE_RCU_BATCHED
> +	if (pcs->rcu_free)
> +		return true;
> +#endif
> +	return (pcs->spare || pcs->main->size);
>  }
>  
>  /*
> @@ -3995,6 +4014,7 @@ static void flush_all(struct kmem_cache *s)
>  	cpus_read_unlock();
>  }
>  
> +#ifdef CONFIG_KVFREE_RCU_BATCHED
>  static void flush_rcu_sheaf(struct work_struct *w)
>  {
>  	struct slub_percpu_sheaves *pcs;
> @@ -4071,6 +4091,7 @@ void flush_all_rcu_sheaves(void)
>  
>  	rcu_barrier();
>  }
> +#endif /* CONFIG_KVFREE_RCU_BATCHED */
>  
>  static int slub_cpu_setup(unsigned int cpu)
>  {
> @@ -5825,6 +5846,7 @@ bool free_to_pcs(struct kmem_cache *s, void *object, bool allow_spin)
>  	return true;
>  }
>  
> +#ifdef CONFIG_KVFREE_RCU_BATCHED
>  static void rcu_free_sheaf(struct rcu_head *head)
>  {
>  	struct slab_sheaf *sheaf;
> @@ -6005,6 +6027,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
>  	lock_map_release(&kfree_rcu_sheaf_map);
>  	return false;
>  }
> +#endif /* CONFIG_KVFREE_RCU_BATCHED */
>  
>  static __always_inline bool can_free_to_pcs(struct slab *slab)
>  {

