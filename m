Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532913C2B9C
	for <rcu@vger.kernel.org>; Wed, 24 Jun 2026 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311300; cv=none; b=TBzO5mXhb5K60qB/FUoSSp0FpjSIaePYlujDh7P9HA4yz0h4aREFSAsyLZ3SLlYh/Cqln3wRoGTdJoG5Zahm1aSQbPJNSdE+Tg9Q/PY1jCMkcNm9vgtaXcylu+z1q2BgRF15n27o0S9ly/T2FHkZM6TUNH0uApgvUGCjj4ZWb88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311300; c=relaxed/simple;
	bh=zq1uG6JGRXuQikOLa+wb9I2eJVy78SluVXhOLe6UJX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOxwkw1Sgyno+Vg/UQQWw37I6aEO+IU7vH4qM5Db+6hbZNDSz52FICYTWvqJ2b8TAhKZLB5zRcX+gVuM4SSw2J2k4unEQpvp2i+KBLyC0HtYnsTRS+k61WSt6dc5o+oSEfBV6Js/0TKSSN3qql0rq61e792SWLVMBvZorK4LMmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KQkbv6XT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F/Hd+Tmo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KQkbv6XT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F/Hd+Tmo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KQkbv6XT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F/Hd+Tmo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KQkbv6XT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F/Hd+Tmo"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E88F75F42;
	Wed, 24 Jun 2026 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782311295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExC3wTG/pYX1uSPWpIMmjed8BsggjZ6ZCCx5gzuyEC8=;
	b=KQkbv6XTcaklRO9GsVwqPpY/SRJDC//NIRWVvfltHJFQK7EgaqNJTbtcD3ml+d4H9PZSb5
	YZcVPvTGZWudl8gKMI1NJveRuNXNAdrnyLHcOiNe5MF2psuFfQKi+h5AhJL3+pK/5G0ReY
	5lBKeKyvApf9AhuL0DbSyKBR/he9jZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782311295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExC3wTG/pYX1uSPWpIMmjed8BsggjZ6ZCCx5gzuyEC8=;
	b=F/Hd+Tmo3itq/3SsPZ4O5AseJn1xNPyzRktS4MmVBIc9aUGYgvda/IDbcowcqT03+Rlal/
	DTJcdMpCy88+PMCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KQkbv6XT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="F/Hd+Tmo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782311295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExC3wTG/pYX1uSPWpIMmjed8BsggjZ6ZCCx5gzuyEC8=;
	b=KQkbv6XTcaklRO9GsVwqPpY/SRJDC//NIRWVvfltHJFQK7EgaqNJTbtcD3ml+d4H9PZSb5
	YZcVPvTGZWudl8gKMI1NJveRuNXNAdrnyLHcOiNe5MF2psuFfQKi+h5AhJL3+pK/5G0ReY
	5lBKeKyvApf9AhuL0DbSyKBR/he9jZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782311295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExC3wTG/pYX1uSPWpIMmjed8BsggjZ6ZCCx5gzuyEC8=;
	b=F/Hd+Tmo3itq/3SsPZ4O5AseJn1xNPyzRktS4MmVBIc9aUGYgvda/IDbcowcqT03+Rlal/
	DTJcdMpCy88+PMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4F95779A8;
	Wed, 24 Jun 2026 14:28:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cbznJH3pO2qRQwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 24 Jun 2026 14:28:13 +0000
Date: Wed, 24 Jun 2026 15:28:11 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH for-next v3 3/9] mm/slab: handle the !allow_spin case in
 kfree_rcu_sheaf()
Message-ID: <ajvn5-2yJxykPlbP@pedro-suse>
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-3-70a54f3775bb@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-kfree_rcu_nolock-v3-3-70a54f3775bb@kernel.org>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,linux.dev,gentwo.org,google.com,gmail.com,linutronix.de,goodmis.org,nvidia.com,joshtriplett.org,efficios.com,kvack.org,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLj61o5ry9wekc93e5gwgzgtt8)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7E88F75F42
X-Spam-Score: -4.01

On Mon, Jun 15, 2026 at 08:05:57PM +0900, Harry Yoo (Oracle) wrote:
> Teach kfree_rcu_sheaf() how to handle the !allow_spin case. Try to get
> an empty sheaf from pcs->spare or the barn even when spinning is not
> allowed. Unlike __pcs_replace_full_main(), try harder to allocate
> an empty sheaf because the fallback path will be more expensive than
> kfree_nolock().
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

Since this is stacked on top of the slab alloc flags work, could it pass slab
alloc flags instead of allow_spin?

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

which would make this logic more natural.

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

and this as well (alloc_empty_sheaf() could derive gfp from whatever you
passed it, by simply knowing alloc_flags = TRYLOCK -> gfp = 0
(or gfp &= ~__GFP_RECLAIM)).

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
> -- 
> 2.53.0
> 

-- 
Pedro
