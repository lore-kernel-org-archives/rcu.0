Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69A1DFE22
	for <rcu@vger.kernel.org>; Mon,  8 Sep 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334379; cv=none; b=AlJWTECNJ+ENgFsv0t9ufLJAAcfZgEE6ptWqprB1Jjh53xmlSNB6MIGv1QMYmmNf7oD0L152oDp6FPqomiW96pmck29ji9JKkGnITgk3g31rkgSNzlJfocftM4BtKiDh1aqshlYTdEARJjLTv/c/xi7YVdckE597OYI+sgfDFcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334379; c=relaxed/simple;
	bh=n+4pymKREDmgi/xsXZFwoqB0KUTG/4I3HucWzD/6oSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAGj7Wd3E3D9VqOpMqQNczIrPGrfIXeyXM72RLJbi4wKat3CMihgvLDfaGfbrM7t1WXJSwTT/HZ+TMbnjOC7Ax/5trb4DCHQO2y2mF3B1nh7ghG9/JTEjos+IVqn6qnkvyth/cyErfkTWNfzImfm/nGQ9LRiICCNuGmZ3N51ZP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sVdZd8po; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zFSsZDC6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sVdZd8po; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zFSsZDC6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sVdZd8po";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zFSsZDC6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sVdZd8po";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zFSsZDC6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 306546BF8D;
	Mon,  8 Sep 2025 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757334372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DRQnfV7KacqgKnXu/9rxHwsFubE78Co0XLB4BS11uuo=;
	b=sVdZd8po7eWGx5Ww9w3Avpn5gXpxLOF9LEyI3qvJoivDJ433rPmpDycz1Y/NWrxS024LC7
	BubEWxx8UPvfAB4uynAFWv1pyC8UUoUX9XpyW8BFVZUtkKFzMCtb6xQie2/sz1SjLWSVY9
	XuJRk4XhjLazNrPZUMpX1N7qLQV0xhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757334372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DRQnfV7KacqgKnXu/9rxHwsFubE78Co0XLB4BS11uuo=;
	b=zFSsZDC6Yc+HndyH6cao9U/6LThplTGnuWttOH5MYaPdxd/oRpmVEgE46ZRVwl7J3XlldY
	OHjot5ea72H9D9Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757334372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DRQnfV7KacqgKnXu/9rxHwsFubE78Co0XLB4BS11uuo=;
	b=sVdZd8po7eWGx5Ww9w3Avpn5gXpxLOF9LEyI3qvJoivDJ433rPmpDycz1Y/NWrxS024LC7
	BubEWxx8UPvfAB4uynAFWv1pyC8UUoUX9XpyW8BFVZUtkKFzMCtb6xQie2/sz1SjLWSVY9
	XuJRk4XhjLazNrPZUMpX1N7qLQV0xhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757334372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DRQnfV7KacqgKnXu/9rxHwsFubE78Co0XLB4BS11uuo=;
	b=zFSsZDC6Yc+HndyH6cao9U/6LThplTGnuWttOH5MYaPdxd/oRpmVEgE46ZRVwl7J3XlldY
	OHjot5ea72H9D9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DD4413946;
	Mon,  8 Sep 2025 12:26:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hSHfAWTLvmiqIwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 08 Sep 2025 12:26:12 +0000
Message-ID: <be0ba18e-f752-4df3-a224-fc978431236c@suse.cz>
Date: Mon, 8 Sep 2025 14:26:11 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/21] slab: add opt-in caching layer of percpu sheaves
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20250903-slub-percpu-caches-v7-0-71c114cdefef@suse.cz>
 <20250903-slub-percpu-caches-v7-3-71c114cdefef@suse.cz>
 <aL672Jeqi99atefN@hyeyoo>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aL672Jeqi99atefN@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,gentwo.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,linux.ibm.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 9/8/25 13:19, Harry Yoo wrote:
> On Wed, Sep 03, 2025 at 02:59:45PM +0200, Vlastimil Babka wrote:
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index bfe7c40eeee1a01c175766935c1e3c0304434a53..e2b197e47866c30acdbd1fee4159f262a751c5a7 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -163,6 +163,9 @@ int slab_unmergeable(struct kmem_cache *s)
>>  		return 1;
>>  #endif
>>  
>> +	if (s->cpu_sheaves)
>> +		return 1;
>> +
>>  	/*
>>  	 * We may have set a slab to be unmergeable during bootstrap.
>>  	 */
>> @@ -321,7 +324,7 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
>>  		    object_size - args->usersize < args->useroffset))
>>  		args->usersize = args->useroffset = 0;
>>  
>> -	if (!args->usersize)
>> +	if (!args->usersize && !args->sheaf_capacity)
>>  		s = __kmem_cache_alias(name, object_size, args->align, flags,
>>  				       args->ctor);
> 
> Can we merge caches that use sheaves in the future if the capacity
> is the same, or are there any restrictions for merging that I overlooked?

I think we will be able to merge. It will make more sense if we get to
enabling sheaves for everything and set capacity automatically, with the
args->sheaf_capacity serving only as a lower bound. Right now we can leave
it as is I think.
>> +static bool has_pcs_used(int cpu, struct kmem_cache *s)
>> +{
>> +	struct slub_percpu_sheaves *pcs;
>> +
>> +	if (!s->cpu_sheaves)
>> +		return false;
>> +
>> +	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
>> +
>> +	return (pcs->spare || pcs->main->size);
>> +}
>> +
>> +static void pcs_flush_all(struct kmem_cache *s);
> 
> nit: we don't need these functions to flush sheaves if SLUB_TINY=y
> as we don't create sheaves for SLUB_TINY anymore?

I'll check but also if this is true I would expect to have a clang warning
report already. Maybe they are called but don't need to?
TBH we should get rid of SLUB_TINY at this point, maybe have only a boot
option that disables percpu caching and keep the code compiled.
>>  /*
>>   * Flush cpu slab.
>> @@ -3358,30 +3793,18 @@ struct slub_flush_work {
>>  static void flush_cpu_slab(struct work_struct *w)
>>  {
>>  	struct kmem_cache *s;
>> -	struct kmem_cache_cpu *c;
>>  	struct slub_flush_work *sfw;
>>  
>>  	sfw = container_of(w, struct slub_flush_work, work);
>>  
>>  	s = sfw->s;
>> -	c = this_cpu_ptr(s->cpu_slab);
>> -
>> -	if (c->slab)
>> -		flush_slab(s, c);
>> -
>> -	put_partials(s);
>> -}
>>  
>> -static bool has_cpu_slab(int cpu, struct kmem_cache *s)
>> -{
>> -	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
>> +	if (s->cpu_sheaves)
>> +		pcs_flush_all(s);
>>  
>> -	return c->slab || slub_percpu_partial(c);
>> +	flush_this_cpu_slab(s);
>>  } 
>> -#else /* CONFIG_SLUB_TINY */
>> -static inline void flush_all_cpus_locked(struct kmem_cache *s) { }
>> -static inline void flush_all(struct kmem_cache *s) { }
>> -static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu) { }
>> -static inline int slub_cpu_dead(unsigned int cpu) { return 0; }
>> -#endif /* CONFIG_SLUB_TINY */
>> -
>>  /*
>>   * Check if the objects in a per cpu structure fit numa
>>   * locality expectations.
>> @@ -4191,30 +4610,240 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>>  }
>>  
>>  /*
>> - * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_alloc)
>> - * have the fastpath folded into their functions. So no function call
>> - * overhead for requests that can be satisfied on the fastpath.
>> - *
>> - * The fastpath works by first checking if the lockless freelist can be used.
>> - * If not then __slab_alloc is called for slow processing.
>> + * Replace the empty main sheaf with a (at least partially) full sheaf.
>>   *
>> - * Otherwise we can simply pick the next object from the lockless free list.
>> + * Must be called with the cpu_sheaves local lock locked. If successful, returns
>> + * the pcs pointer and the local lock locked (possibly on a different cpu than
>> + * initially called). If not successful, returns NULL and the local lock
>> + * unlocked.
>>   */
>> -static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
>> -		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
>> +static struct slub_percpu_sheaves *
>> +__pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs, gfp_t gfp)
>>  {
>> -	void *object;
>> -	bool init = false;
>> +	struct slab_sheaf *empty = NULL;
>> +	struct slab_sheaf *full;
>> +	struct node_barn *barn;
>> +	bool can_alloc;
>>  
>> -	s = slab_pre_alloc_hook(s, gfpflags);
>> -	if (unlikely(!s))
>> +	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
>> +
>> +	if (pcs->spare && pcs->spare->size > 0) {
>> +		swap(pcs->main, pcs->spare);
>> +		return pcs;
>> +	}
>> +
>> +	barn = get_barn(s);
>> +
>> +	full = barn_replace_empty_sheaf(barn, pcs->main);
>> +
>> +	if (full) {
>> +		stat(s, BARN_GET);
>> +		pcs->main = full;
>> +		return pcs;
>> +	}
>> +
>> +	stat(s, BARN_GET_FAIL);
>> +
>> +	can_alloc = gfpflags_allow_blocking(gfp);
>> +
>> +	if (can_alloc) {
>> +		if (pcs->spare) {
>> +			empty = pcs->spare;
>> +			pcs->spare = NULL;
>> +		} else {
>> +			empty = barn_get_empty_sheaf(barn);
>> +		}
>> +	}
>> +
>> +	local_unlock(&s->cpu_sheaves->lock);
>> +
>> +	if (!can_alloc)
>> +		return NULL;
>> +
>> +	if (empty) {
>> +		if (!refill_sheaf(s, empty, gfp)) {
>> +			full = empty;
>> +		} else {
>> +			/*
>> +			 * we must be very low on memory so don't bother
>> +			 * with the barn
>> +			 */
>> +			free_empty_sheaf(s, empty);
>> +		}
>> +	} else {
>> +		full = alloc_full_sheaf(s, gfp);
>> +	}
>> +
>> +	if (!full)
>> +		return NULL;
>> +
>> +	/*
>> +	 * we can reach here only when gfpflags_allow_blocking
>> +	 * so this must not be an irq
>> +	 */
>> +	local_lock(&s->cpu_sheaves->lock);
>> +	pcs = this_cpu_ptr(s->cpu_sheaves);
>> +
>> +	/*
>> +	 * If we are returning empty sheaf, we either got it from the
>> +	 * barn or had to allocate one. If we are returning a full
>> +	 * sheaf, it's due to racing or being migrated to a different
>> +	 * cpu. Breaching the barn's sheaf limits should be thus rare
>> +	 * enough so just ignore them to simplify the recovery.
>> +	 */
>> +
>> +	if (pcs->main->size == 0) {
>> +		barn_put_empty_sheaf(barn, pcs->main);
> 
> It should be very rare but it should do
> barn = get_barn(s); again after taking s->cpu_sheaves->lock?

Yeah but it shouldn't really matter which node we use for the empty sheaf
return. And in case of the full sheaf below it's actually better for
preserving numa locality to use the original barn.
