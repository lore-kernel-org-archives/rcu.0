Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CAD35A384;
	Tue, 16 Jun 2026 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596518; cv=none; b=Xkc2xjQPM3KoHrJAgFDGoRA86DLshJXCxzCZMw4MoFQRcVN0oD4qwc1If/p30rE9wUjBUNsBWnFsMkBlxqjyKk5MeZgx6o7HMVKcCuTvbXYWqAm/oeeN+UfXLGx/fY46n8GvIIddZvJvNbtIEsdWfo1elgU7nWsVzsy9i7VzbA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596518; c=relaxed/simple;
	bh=eJdqyv4hJpz+5xYRRlWO8e2A6D+CHZ+zYvuR3m+8C+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dS1SI3pbJZTOcigx3RPfQbYebHHOB4TO8NRLCjf5ape8CwHy0UiqJAEMiEGUNI3iE2esOxe/e7DTxCSvf6w8YnCudxMbLMc71RA/uH2zSioPIsHj6w0qxQaS5VGMHa1Avk3hZOWelVRwve7SDx/k/mwzjQMsq4T+VOyR3Vsi/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkdPriGn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkdPriGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228D21F000E9;
	Tue, 16 Jun 2026 07:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781596516;
	bh=n8yo6IeeQUch0PIwpPtioYGk9SmXvxlaWBe70kkkR6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QkdPriGnJTwVj05m+T5Ki7nROr14VsrYgXqzl3WhfN6z5X6o97l6fEr+yv4mwKqlA
	 egTkmsB603voSA1Lzh3+IWSacBh7KwYcZLAr6LGc9ci+uzG79Lv3CGn5XxXD/2J8iQ
	 PzrwDdzl/KcLcDH7Jub2Ntu8EK9HrtMD9R8tyCHLUkT9aTUpmzBcha6lOZtXUg4//s
	 VAKDL1cTrOTlI1ihwV4RnevI0BoWph25XnR8MgDcT0OpWDLWSJBLLBgZ+kuNw6dY2g
	 hgb+EujlBevwthD6KMkeJKCK42JL92MWjmTmzbzx6H13AVXC1q0gHPVUSNgzzBL6aq
	 i8jZ42xICef+g==
Message-ID: <4d7ebcd5-f3b7-4c73-94f1-b7d3ac12a521@kernel.org>
Date: Tue, 16 Jun 2026 09:55:09 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 3/9] mm/slab: handle the !allow_spin case in
 kfree_rcu_sheaf()
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
 <20260615-kfree_rcu_nolock-v3-3-70a54f3775bb@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260615-kfree_rcu_nolock-v3-3-70a54f3775bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/26 13:05, Harry Yoo (Oracle) wrote:
> Teach kfree_rcu_sheaf() how to handle the !allow_spin case. Try to get
> an empty sheaf from pcs->spare or the barn even when spinning is not
> allowed. Unlike __pcs_replace_full_main(), try harder to allocate
> an empty sheaf because the fallback path will be more expensive than
> kfree_nolock().

You mean that it will try to allocate an empty sheaf, while
__pcs_replace_full_main() doesn't with allow_spin == false.
I just noticed the comment there is a bit stale... nevermind.

> 
> When trylock fails or the kernel observes non-NULL pcs->rcu_free after
> lock acquisition, free the sheaf instead of putting it to the barn.
> This is rare and not worth complicating the code.
> 
> Since call_rcu() cannot be called in an unknown context,
> kfree_rcu_sheaf() fails when the rcu sheaf becomes full.
> 
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
>  mm/slab.h        |  2 +-
>  mm/slab_common.c |  2 +-
>  mm/slub.c        | 39 ++++++++++++++++++++++++++++++---------
>  3 files changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 509f330654b8..b1bd33a16544 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -429,7 +429,7 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
>  	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
>  }
>  
> -bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin);
>  void flush_all_rcu_sheaves(void);
>  void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
>  
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index b6426d7ceec9..bc1a8ec938d9 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1605,7 +1605,7 @@ static bool kfree_rcu_sheaf(void *obj)
>  
>  	s = slab->slab_cache;
>  	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id()))
> -		return __kfree_rcu_sheaf(s, obj);
> +		return __kfree_rcu_sheaf(s, obj, /* allow_spin = */ true);
>  
>  	return false;
>  }
> diff --git a/mm/slub.c b/mm/slub.c
> index 87ca154ccd80..b0d38d515386 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2815,7 +2815,8 @@ static inline struct slab_sheaf *alloc_empty_sheaf(struct kmem_cache *s,
>  	return __alloc_empty_sheaf(s, gfp, alloc_flags, s->sheaf_capacity);
>  }
>  
> -static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
> +static void __free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
> +			       bool allow_spin)
>  {
>  	/*
>  	 * If the sheaf was created with SLAB_ALLOC_NO_RECURSE flag then its
> @@ -2827,11 +2828,20 @@ static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
>  		mark_obj_codetag_empty(sheaf);
>  
>  	VM_WARN_ON_ONCE(sheaf->size > 0);
> -	kfree(sheaf);
> +
> +	if (likely(allow_spin))
> +		kfree(sheaf);
> +	else
> +		kfree_nolock(sheaf);

Hmm what if the sheaf wasn't allocated with kmalloc_nolock()?

>  
>  	stat(s, SHEAF_FREE);
>  }
>  
> +static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
> +{
> +	__free_empty_sheaf(s, sheaf, /* allow_spin = */ true);
> +}
> +
>  static unsigned int
>  refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
>  	       unsigned int max);
> @@ -3132,7 +3142,6 @@ static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
>   * intended action due to a race or cpu migration. Thus they do not check the
>   * empty or full sheaf limits for simplicity.
>   */
> -
>  static void barn_put_empty_sheaf(struct node_barn *barn, struct slab_sheaf *sheaf)
>  {
>  	unsigned long flags;
> @@ -6065,7 +6074,7 @@ static void rcu_free_sheaf(struct rcu_head *head)
>   */
>  static DEFINE_WAIT_OVERRIDE_MAP(kfree_rcu_sheaf_map, LD_WAIT_CONFIG);
>  
> -bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
>  {
>  	struct slub_percpu_sheaves *pcs;
>  	struct slab_sheaf *rcu_sheaf;
> @@ -6081,9 +6090,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  	if (unlikely(!pcs->rcu_free)) {
> -
>  		struct slab_sheaf *empty;
>  		struct node_barn *barn;
> +		unsigned int alloc_flags = SLAB_ALLOC_DEFAULT;
> +		gfp_t gfp = GFP_NOWAIT;
>  
>  		/* Bootstrap or debug cache, fall back */
>  		if (unlikely(!cache_has_sheaves(s))) {
> @@ -6103,7 +6113,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>  			goto fail;
>  		}
>  
> -		empty = barn_get_empty_sheaf(barn, true);
> +		empty = barn_get_empty_sheaf(barn, allow_spin);

Here we might be getting a sheaf allocated previously with kmalloc().

>  
>  		if (empty) {
>  			pcs->rcu_free = empty;
> @@ -6112,20 +6122,25 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>  
>  		local_unlock(&s->cpu_sheaves->lock);
>  
> -		empty = alloc_empty_sheaf(s, GFP_NOWAIT, SLAB_ALLOC_DEFAULT);
> +		if (unlikely(!allow_spin)) {
> +			alloc_flags = SLAB_ALLOC_TRYLOCK;
> +			gfp = 0;

Maybe __GFP_NOWARN?
Here we would get a sheaf with kmalloc_nolock() so that's ok even if it's
later freed by someone else by kfree(), right.

> +		}
> +
> +		empty = alloc_empty_sheaf(s, gfp, alloc_flags);
>  
>  		if (!empty)
>  			goto fail;
>  
>  		if (!local_trylock(&s->cpu_sheaves->lock)) {
> -			barn_put_empty_sheaf(barn, empty);
> +			__free_empty_sheaf(s, empty, allow_spin);

Well we could still use the barn with allow_spin == true.
But more crucially, here we might be freeing with kfree_nolock() a sheaf
from the barn previously allocated with kmalloc()?
Maybe we need to track if it's the case and defer-free it or something.

Also maybe there could be a wrapper kfree_maybe_nolock() (~better name?)
That means "I want to kfree safely in kfree_nolock() context something that
MIGHT have been kmalloc()"
And maybe depending on the debugging options that make kmalloc() ->
kfree_nolock() incompatible, if those are not enabled, it wouldn't have to
defer, but proceed normally?

>  			goto fail;
>  		}
>  
>  		pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  		if (unlikely(pcs->rcu_free))
> -			barn_put_empty_sheaf(barn, empty);
> +			__free_empty_sheaf(s, empty, allow_spin);
>  		else
>  			pcs->rcu_free = empty;
>  	}
> @@ -6143,6 +6158,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
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
> 

