Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325D4442FB8;
	Tue, 21 Jul 2026 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628460; cv=none; b=jUdGhQeU9Xt3cpU/PIBw+9y+EbpXzu/UjO5wfkiSMYQrIIa9hlG3J/zGnq2f5lTGZ3CeHPMLras9SoF4wTaqBKICIPOu97lcKaEdZf+14YFX+5DfhOYQxXcBUi9COob5jyMr1W4GEEl0wXfj6AKURhdFYGI7FkC2lrDgzDvOHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628460; c=relaxed/simple;
	bh=EX86EBA1Lpd+L1z2KYaIjSNr/t3YbxGeFxCyt+vkhvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXe2/T485H+AtQX/1M6t93GOrwJyjsZ2eefhYRc6/ln4IPmTrcofSlxhBAOPUtdDkBy5KaW/UM2W9U3SZMfg4f8eHNjw1zXqfl8ceR3oK5g9YItHhiTogH9OibkkiDWtHQMFgWVZ6S3tH6GVYdGOedYlqZjLyeMxHB0PEa3OcCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+XgjAmg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+XgjAmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1722B1F00A3A;
	Tue, 21 Jul 2026 10:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628459;
	bh=bOploRvDj134COovQFMYbavpqHjEd7HZWn3WCljAxGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c+XgjAmgGbN4YGbGofBEf6QaJ4+OzyF+uyxW5Lbiu/b+Bx+Ghw3EBQVy0+a7ELCCb
	 KTsigTcX0kRsAvMAqfvxWiPJgpY60F1DapyGEjHQRP7X9sNyGcZiPXblyvPPSBhmhd
	 X8wQqDUCZ4DmpA3F0xyh6ZkZV9hDD3uhfVJt7ZWH3VDiiS/v9O99GVzR0k4XRkJWjz
	 RsoySu/eKwL7XgFbm0ImUaXEzXgHmnBtcN/DlCewPNrLbUzJtbNfQ0byWKxvA8qON+
	 SOxMmrYn5KUO76dtdAHxN3Oetv9ktGLMJ5+vvgPNumGe7OQWVzkf3NjGOHoKsauDbT
	 Vtm/bXBdlk+UA==
Message-ID: <1d0d8021-62d2-4c42-a2a6-a7e8ce2f5d37@kernel.org>
Date: Tue, 21 Jul 2026 12:07:31 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab/for-next v4 2/8] mm/slab: handle the !allow_spin case
 in kfree_rcu_sheaf()
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
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Shengming Hu <hu.shengming@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-2-964e03c41a4e@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260720-kfree_rcu_nolock-v4-2-964e03c41a4e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/20/26 14:44, Harry Yoo (Oracle) wrote:
> Teach kfree_rcu_sheaf() how to handle the !allow_spin case. Try to get
> an empty sheaf from pcs->spare or the barn even when spinning is not
> allowed. Unlike __pcs_replace_full_main(), try harder to allocate
> an empty sheaf because the fallback path will be more expensive than
> kfree_nolock().
> 
> Now that slab has internal alloc_flags to describe context, introduce
> free_flags analogously and convert free_flags to alloc_flags when
> allocating memory in the free path. alloc_empty_sheaf() now strips
> __GFP_RECLAIM when SLAB_ALLOC_NOLOCK is specified.
> 
> When trylock fails or the kernel observes non-NULL pcs->rcu_free after
> lock acquisition, free the sheaf instead of putting it to the barn.
> This is rare and not worth complicating the code.
> 
> Since call_rcu() cannot be called in an unknown context,
> kfree_rcu_sheaf() fails when the rcu sheaf becomes full.
> 
> Link: https://lore.kernel.org/linux-mm/872bd673-3d45-4111-8a41-31185db3ece5@kernel.org
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>

LGTM.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Nits below:

> ---
>  mm/slab.h        | 18 +++++++++++++++++-
>  mm/slab_common.c |  2 +-
>  mm/slub.c        | 36 ++++++++++++++++++++++++++++--------
>  3 files changed, 46 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 281a65233795..85ef2ebc9812 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -23,11 +23,27 @@
>  #define SLAB_ALLOC_NEW_SLAB	0x02 /* a flag for alloc_slab_obj_exts() */
>  #define SLAB_ALLOC_NO_RECURSE	0x04 /* prevent kmalloc() recursion */
>  
> +#define SLAB_FREE_DEFAULT	0x00 /* no flags */
> +#define SLAB_FREE_NOLOCK	0x01 /* spinning not allowed */
> +
> +static inline unsigned int to_alloc_flags(unsigned int free_flags)
> +{
> +	if (free_flags & SLAB_FREE_NOLOCK)
> +		return SLAB_ALLOC_NOLOCK;
> +	else
> +		return SLAB_ALLOC_DEFAULT;
> +}
> +
>  static inline bool alloc_flags_allow_spinning(const unsigned int alloc_flags)
>  {
>  	return !(alloc_flags & SLAB_ALLOC_NOLOCK);
>  }
>  
> +static inline bool free_flags_allow_spinning(const unsigned int free_flags)
> +{
> +	return !(free_flags & SLAB_FREE_NOLOCK);
> +}
> +
>  void *__kmalloc_flags_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t flags,
>  				  unsigned int alloc_flags, int node)
>  				  __assume_kmalloc_alignment __alloc_size(1);
> @@ -429,7 +445,7 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
>  	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
>  }
>  
> -bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int free_flags);
>  void flush_all_rcu_sheaves(void);
>  void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
>  
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index b6426d7ceec9..e07b4e6d6679 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1605,7 +1605,7 @@ static bool kfree_rcu_sheaf(void *obj)
>  
>  	s = slab->slab_cache;
>  	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id()))
> -		return __kfree_rcu_sheaf(s, obj);
> +		return __kfree_rcu_sheaf(s, obj, SLAB_FREE_DEFAULT);
>  
>  	return false;
>  }
> diff --git a/mm/slub.c b/mm/slub.c
> index e32a68677537..0c350274fbff 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2814,10 +2814,14 @@ static inline struct slab_sheaf *alloc_empty_sheaf(struct kmem_cache *s,
>  
>  	gfp &= ~OBJCGS_CLEAR_MASK;
>  
> +	if (alloc_flags & SLAB_ALLOC_NOLOCK)
> +		gfp &= ~__GFP_RECLAIM;

So in general we expect gfp and alloc flags to be compatible and warn if
they are not. This now performs an auto-adjustment, which makes it unusual.
But AFAICS only one caller relies on it - __kfree_rcu_sheaf(). So maybe we
could just do it there?

> +
>  	return __alloc_empty_sheaf(s, gfp, alloc_flags, s->sheaf_capacity);
>  }
>  
> -static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
> +static void __free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
> +			       bool allow_spin)

Why not free_flags instead of allow_spin? Since you already introduced them.

>  {
>  	/*
>  	 * If the sheaf was created with SLAB_ALLOC_NO_RECURSE flag then its
> @@ -2829,11 +2833,20 @@ static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
>  		mark_obj_codetag_empty(sheaf);
>  
>  	VM_WARN_ON_ONCE(sheaf->size > 0);
> -	kfree(sheaf);
> +
> +	if (likely(allow_spin))
> +		kfree(sheaf);
> +	else
> +		kfree_nolock(sheaf);
>  
>  	stat(s, SHEAF_FREE);
>  }
>  
> +static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
> +{
> +	__free_empty_sheaf(s, sheaf, /* allow_spin = */ true);

Would avoid this ugliness.

> +}
> +
>  static unsigned int
>  refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
>  	       unsigned int max);
