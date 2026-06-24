Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E073C9ED5
	for <rcu@vger.kernel.org>; Wed, 24 Jun 2026 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311850; cv=none; b=kqWhFY0iBpMnULX8/YRM6Eu2uSwnjnDAyO7S8iRSNARo+xk1FQvfHhvdB0yvOD2dcz2MZkUupNhh42PvgDzhrrWngjfpdrcUhYr8280ODB6e6aUOT+/ZQ7eJ+2d9oJsaY97NCNzN65B5rYxPDSv5nUCSwGS2bjRumT8AnOtYtl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311850; c=relaxed/simple;
	bh=Z8zO5e8G8iEi+o4sWmSQQJEdHKF3QcvxYwhJwzclGu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qohjhP4c1ONCHpLvrw+8b6wcNH0pWs0IWGWXhDAz64eAFDc6Zo34Z0FZ/4dpnTcyld6geQmGe9Xg5QPxu57egYplXoDETwvg2qCh+6htC1Gg75CvJLsW9wT8LwFC3/Vbbf8B3BgJfwt/zwfn7VxEtQ6G3vDjG93FCsQQmaz+9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YyKj3973; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9xkpX6Dx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YyKj3973; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9xkpX6Dx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YyKj3973";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9xkpX6Dx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YyKj3973";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9xkpX6Dx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68BD0713CB;
	Wed, 24 Jun 2026 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782311847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGpCqhie84Lk+N3qc4OewQcNGuUPftRJsClpCvq+bXc=;
	b=YyKj3973y1Xg/Oexbfr+PBiwVs954B0yLiqrokAVRdaDVt9/vtrG8OemPouwnTr1MqpbF7
	D5VjEvClG4TtTsHZ7gd5ALruogq4zndLtwq5641bAN36cyXP1FMJWmVkELQkPn/g8gjlaz
	ClgxEBuAXe99303UYjSPsB1fLg3Unfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782311847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGpCqhie84Lk+N3qc4OewQcNGuUPftRJsClpCvq+bXc=;
	b=9xkpX6DxD6Y3QtPtaDBmuzjK/5CJ9QAPJTFALvoAtKxaaRQPzzeGLmJAsdWQrT+eX5tMrW
	+gtrhTb44yjt4kCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782311847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGpCqhie84Lk+N3qc4OewQcNGuUPftRJsClpCvq+bXc=;
	b=YyKj3973y1Xg/Oexbfr+PBiwVs954B0yLiqrokAVRdaDVt9/vtrG8OemPouwnTr1MqpbF7
	D5VjEvClG4TtTsHZ7gd5ALruogq4zndLtwq5641bAN36cyXP1FMJWmVkELQkPn/g8gjlaz
	ClgxEBuAXe99303UYjSPsB1fLg3Unfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782311847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGpCqhie84Lk+N3qc4OewQcNGuUPftRJsClpCvq+bXc=;
	b=9xkpX6DxD6Y3QtPtaDBmuzjK/5CJ9QAPJTFALvoAtKxaaRQPzzeGLmJAsdWQrT+eX5tMrW
	+gtrhTb44yjt4kCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93E96779A8;
	Wed, 24 Jun 2026 14:37:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6z3cIKXrO2oJTQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 24 Jun 2026 14:37:25 +0000
Date: Wed, 24 Jun 2026 15:37:23 +0100
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
Subject: Re: [PATCH for-next v3 5/9] mm/slab: extend deferred free mechanism
 to handle rcu sheaves
Message-ID: <ajvrNoE81J-_4zsM@pedro-suse>
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-5-70a54f3775bb@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-kfree_rcu_nolock-v3-5-70a54f3775bb@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLg9nrgqsibwm9ympc34uc4grz)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,linux.dev,gentwo.org,google.com,gmail.com,linutronix.de,goodmis.org,nvidia.com,joshtriplett.org,efficios.com,kvack.org,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Mon, Jun 15, 2026 at 08:05:59PM +0900, Harry Yoo (Oracle) wrote:
> __kfree_rcu_sheaf() cannot invoke call_rcu() when spinning is not
> allowed and IRQs are disabled. To relax the limitation, extend the
> deferred free fallback so that a full rcu sheaf can be submitted to
> call_rcu() via the existing IRQ work.
> 
> Since the deferred mechanism does more than deferred free of objects,
> rename the struct to deferred_percpu_work and adjust names accordingly.
> 
> When a sheaf is queued on an IRQ work, it is detached from
> pcs->rcu_free but call_rcu() is not invoked until the irq_work runs.
> To keep the kvfree_rcu barrier's promise, call irq_work_sync() on each
> CPU before calling rcu_barrier().
> 
> In the meantime, remove the TODO item as apparently there is no simple
> and effective way to achieve that.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
>  mm/slab.h        |  2 +-
>  mm/slab_common.c |  7 ++---
>  mm/slub.c        | 79 ++++++++++++++++++++++++++++++++++----------------------
>  3 files changed, 51 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index b1bd33a16544..961581e35ec8 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -744,7 +744,7 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>  void __check_heap_object(const void *ptr, unsigned long n,
>  			 const struct slab *slab, bool to_user);
>  
> -void defer_free_barrier(void);
> +void deferred_work_barrier(void);
>  
>  static inline bool slub_debug_orig_size(struct kmem_cache *s)
>  {
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index bc1a8ec938d9..55546b8385ff 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -551,7 +551,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	}
>  
>  	/* Wait for deferred work from kmalloc/kfree_nolock() */
> -	defer_free_barrier();
> +	deferred_work_barrier();
>  
>  	cpus_read_lock();
>  	mutex_lock(&slab_mutex);
> @@ -2113,13 +2113,10 @@ void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
>  		cpus_read_lock();
>  		flush_rcu_sheaves_on_cache(s);
>  		cpus_read_unlock();
> +		deferred_work_barrier();
>  		rcu_barrier();
>  	}
>  
> -	/*
> -	 * TODO: Introduce a version of __kvfree_rcu_barrier() that works
> -	 * on a specific slab cache.
> -	 */

Perhaps could be worth detailing why this is not possible.

>  	__kvfree_rcu_barrier();
>  }
>  EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
> diff --git a/mm/slub.c b/mm/slub.c
> index 6a3552b70683..ba593c1c53d5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -418,6 +418,8 @@ struct slab_sheaf {
>  	union {
>  		struct rcu_head rcu_head;
>  		struct list_head barn_list;
> +		/* only used to defer call_rcu() in unknown context */
> +		struct llist_node llnode;
>  		/* only used for prefilled sheafs */
>  		struct {
>  			unsigned int capacity;
> @@ -4071,6 +4073,20 @@ static void flush_all(struct kmem_cache *s)
>  	cpus_read_unlock();
>  }
>  
> +struct deferred_percpu_work {
> +	struct llist_head objects;
> +	struct llist_head rcu_sheaves;
> +	struct irq_work work;
> +};
> +
> +static void deferred_percpu_work_fn(struct irq_work *work);
> +
> +static DEFINE_PER_CPU(struct deferred_percpu_work, deferred_percpu_work) = {
> +	.objects = LLIST_HEAD_INIT(objects),
> +	.rcu_sheaves = LLIST_HEAD_INIT(rcu_sheaves),
> +	.work = IRQ_WORK_INIT(deferred_percpu_work_fn),
> +};
> +
>  static void flush_rcu_sheaf(struct work_struct *w)
>  {
>  	struct slub_percpu_sheaves *pcs;
> @@ -4142,6 +4158,7 @@ void flush_all_rcu_sheaves(void)
>  	mutex_unlock(&slab_mutex);
>  	cpus_read_unlock();
>  
> +	deferred_work_barrier();
>  	rcu_barrier();
>  }
>  
> @@ -6158,12 +6175,6 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
>  	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
>  		rcu_sheaf = NULL;
>  	} else {
> -		/* call_rcu() disables IRQs to protect percpu data structures */
> -		if (unlikely(!allow_spin && irqs_disabled())) {
> -			rcu_sheaf->size--;
> -			local_unlock(&s->cpu_sheaves->lock);
> -			goto fail;
> -		}
>  		pcs->rcu_free = NULL;
>  		rcu_sheaf->node = numa_node_id();
>  	}
> @@ -6172,8 +6183,18 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
>  	 * we flush before local_unlock to make sure a racing
>  	 * flush_all_rcu_sheaves() doesn't miss this sheaf
>  	 */
> -	if (rcu_sheaf)
> -		call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> +	if (rcu_sheaf) {
> +		/* call_rcu() disables IRQs to protect percpu data structures */
> +		if (unlikely(!allow_spin && irqs_disabled())) {
> +			struct deferred_percpu_work *dpw;
> +
> +			dpw = this_cpu_ptr(&deferred_percpu_work);
> +			if (llist_add(&rcu_sheaf->llnode, &dpw->rcu_sheaves))
> +				irq_work_queue(&dpw->work);
> +		} else {
> +			call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> +		}
> +	}
>  
>  	local_unlock(&s->cpu_sheaves->lock);
>  
> @@ -6360,31 +6381,20 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  	}
>  }
>  
> -struct defer_free {
> -	struct llist_head objects;
> -	struct irq_work work;
> -};
> -
> -static void free_deferred_objects(struct irq_work *work);
> -
> -static DEFINE_PER_CPU(struct defer_free, defer_free_objects) = {
> -	.objects = LLIST_HEAD_INIT(objects),
> -	.work = IRQ_WORK_INIT(free_deferred_objects),
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
> -	struct defer_free *df = container_of(work, struct defer_free, work);
> -	struct llist_head *objs = &df->objects;
> +	struct deferred_percpu_work *dpw;
> +	struct llist_head *objs, *rcu_sheaves;
>  	struct llist_node *llnode, *pos, *t;
>  
> -	if (llist_empty(objs))
> -		return;
> +	dpw = container_of(work, struct deferred_percpu_work, work);
> +	rcu_sheaves = &dpw->rcu_sheaves;
> +	objs = &dpw->objects;
>  
>  	llnode = llist_del_all(objs);
>  	llist_for_each_safe(pos, t, llnode) {
> @@ -6408,27 +6418,34 @@ static void free_deferred_objects(struct irq_work *work)
>  		__slab_free(s, slab, x, x, 1, _THIS_IP_);
>  		stat(s, FREE_SLOWPATH);
>  	}
> +
> +	llnode = llist_del_all(rcu_sheaves);
> +	llist_for_each_safe(pos, t, llnode) {
	llist_for_each_entry_safe?

> +		struct slab_sheaf *rcu_sheaf = llist_entry(pos, struct slab_sheaf, llnode);
> +
> +		call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> +	}
>  }
>  

Otherwise LGTM!
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
 

-- 
Pedro
