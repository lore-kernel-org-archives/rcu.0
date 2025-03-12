Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7F6188583
	for <rcu@vger.kernel.org>; Wed, 12 Mar 2025 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803415; cv=none; b=PvzfHHzaanEjZOwbmeF3fDN5TEOIyI2S52h3eWifVG/KylTXmGvoLf3qaAr4OjBZ5Br8CqMxOAXI8O7v860+ZTQt6Um9HcO2sjewdTE1whUnWi6q8QaZaGypwQdcCm5oZxYlRq3aLKrYokFSlKvM7czybKyHFRHWIfX2MjglCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803415; c=relaxed/simple;
	bh=OLIieO5TnvY0vNGsngnCDgcLImJH0zTirs+CZGUTxxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByVGbuYC74dfWZqKoRENoZdJg8ICVVNwjVS+W0gi/UY0fviKPWUq3oIi8ckeEGWnQhq11WTCBMaUQvQhY+bwLGL1iQgRWRsUESasxRXnBsy5coyjEMOjktpwr1fyr5gEfPi18/9EQBhAMMpg+W+C2yYT1JhaeTMSlJopL4eXdnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1filQUv6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3rpl+xID; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1filQUv6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3rpl+xID; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1filQUv6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3rpl+xID";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1filQUv6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3rpl+xID"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B21301F388;
	Wed, 12 Mar 2025 18:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741803411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VK3ZYDWQDEmhk3a7G3ezOfAYlodRmWWCnSzkuyMDPBU=;
	b=1filQUv660JODH5Klf5U1pk8p1Hc3ncHCjT/4ZKHhMU2ykFYqiSsOlsvZOtPGMODeCexUg
	shkBjAv31pPprozp1SlPIOT9X01I33GerY9AucdMIfugS8wiwXIJ5RtCtorGOYJUKq3hDU
	Pu5yqSOzA1wDH/kudIyegCdAWdiGvfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741803411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VK3ZYDWQDEmhk3a7G3ezOfAYlodRmWWCnSzkuyMDPBU=;
	b=3rpl+xIDczxmo4iD76lSip0UzpmqYViLWVNE44DBZR/QVlz1PkIurq3AO1O2yiVRSQVLiO
	rifzy1Muu+Z0gsCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741803411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VK3ZYDWQDEmhk3a7G3ezOfAYlodRmWWCnSzkuyMDPBU=;
	b=1filQUv660JODH5Klf5U1pk8p1Hc3ncHCjT/4ZKHhMU2ykFYqiSsOlsvZOtPGMODeCexUg
	shkBjAv31pPprozp1SlPIOT9X01I33GerY9AucdMIfugS8wiwXIJ5RtCtorGOYJUKq3hDU
	Pu5yqSOzA1wDH/kudIyegCdAWdiGvfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741803411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VK3ZYDWQDEmhk3a7G3ezOfAYlodRmWWCnSzkuyMDPBU=;
	b=3rpl+xIDczxmo4iD76lSip0UzpmqYViLWVNE44DBZR/QVlz1PkIurq3AO1O2yiVRSQVLiO
	rifzy1Muu+Z0gsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F93F1377F;
	Wed, 12 Mar 2025 18:16:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id McS1IpPP0We8PwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 12 Mar 2025 18:16:51 +0000
Message-ID: <ba9919b9-2231-45b1-b6e5-7239fbc167c1@suse.cz>
Date: Wed, 12 Mar 2025 19:16:51 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 06/10] slab: sheaf prefilling for guaranteed
 allocations
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-6-88592ee0966a@suse.cz>
 <Z714uDm4VcusQ7-Z@harry>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z714uDm4VcusQ7-Z@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/25/25 09:00, Harry Yoo wrote:
> On Fri, Feb 14, 2025 at 05:27:42PM +0100, Vlastimil Babka wrote:
>> Add functions for efficient guaranteed allocations e.g. in a critical
>> section that cannot sleep, when the exact number of allocations is not
>> known beforehand, but an upper limit can be calculated.
>> 
>> kmem_cache_prefill_sheaf() returns a sheaf containing at least given
>> number of objects.
>> 
>> kmem_cache_alloc_from_sheaf() will allocate an object from the sheaf
>> and is guaranteed not to fail until depleted.
>> 
>> kmem_cache_return_sheaf() is for giving the sheaf back to the slab
>> allocator after the critical section. This will also attempt to refill
>> it to cache's sheaf capacity for better efficiency of sheaves handling,
>> but it's not stricly necessary to succeed.
>> 
>> kmem_cache_refill_sheaf() can be used to refill a previously obtained
>> sheaf to requested size. If the current size is sufficient, it does
>> nothing. If the requested size exceeds cache's sheaf_capacity and the
>> sheaf's current capacity, the sheaf will be replaced with a new one,
>> hence the indirect pointer parameter.
>> 
>> kmem_cache_sheaf_size() can be used to query the current size.
>> 
>> The implementation supports requesting sizes that exceed cache's
>> sheaf_capacity, but it is not efficient - such sheaves are allocated
>> fresh in kmem_cache_prefill_sheaf() and flushed and freed immediately by
>> kmem_cache_return_sheaf(). kmem_cache_refill_sheaf() might be expecially
>> ineffective when replacing a sheaf with a new one of a larger capacity.
>> It is therefore better to size cache's sheaf_capacity accordingly.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  include/linux/slab.h |  16 ++++
>>  mm/slub.c            | 227 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 243 insertions(+)
> 
> [... snip ... ]
> 
>> @@ -4831,6 +4857,207 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t gfpflags, int nod
>>  }
>>  EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
>>  
>> +
>> +/*
>> + * returns a sheaf that has least the requested size
>> + * when prefilling is needed, do so with given gfp flags
>> + *
>> + * return NULL if sheaf allocation or prefilling failed
>> + */
>> +struct slab_sheaf *
>> +kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
>> +{
>> +	struct slub_percpu_sheaves *pcs;
>> +	struct slab_sheaf *sheaf = NULL;
>> +
>> +	if (unlikely(size > s->sheaf_capacity)) {
>> +		sheaf = kzalloc(struct_size(sheaf, objects, size), gfp);
>> +		if (!sheaf)
>> +			return NULL;
>> +
>> +		sheaf->cache = s;
>> +		sheaf->capacity = size;
>> +
>> +		if (!__kmem_cache_alloc_bulk(s, gfp, size,
>> +					     &sheaf->objects[0])) {
>> +			kfree(sheaf);
>> +			return NULL;
>> +		}
>> +
>> +		sheaf->size = size;
>> +
>> +		return sheaf;
>> +	}
>> +
>> +	localtry_lock(&s->cpu_sheaves->lock);
>> +	pcs = this_cpu_ptr(s->cpu_sheaves);
>> +
>> +	if (pcs->spare) {
>> +		sheaf = pcs->spare;
>> +		pcs->spare = NULL;
>> +	}
>> +
>> +	if (!sheaf)
>> +		sheaf = barn_get_full_or_empty_sheaf(pcs->barn);
> 
> Can this be outside localtry lock?

Strictly speaking we'd have to save the barn pointer first, otherwise cpu
hotremove could bite us, I think. But not worth the trouble, as localtry
lock is just disabling preemption and taking the barn lock would disable
irqs anyway. So we're not increasing contention by holding the localtry lock
more than strictly necessary.

> 
>> +
>> +	localtry_unlock(&s->cpu_sheaves->lock);
>> +
>> +	if (!sheaf) {
>> +		sheaf = alloc_empty_sheaf(s, gfp);
>> +	}
>> +
>> +	if (sheaf && sheaf->size < size) {
>> +		if (refill_sheaf(s, sheaf, gfp)) {
>> +			sheaf_flush(s, sheaf);
>> +			free_empty_sheaf(s, sheaf);
>> +			sheaf = NULL;
>> +		}
>> +	}
>> +
>> +	if (sheaf)
>> +		sheaf->capacity = s->sheaf_capacity;
>> +
>> +	return sheaf;
>> +}
>> +
>> +/*
>> + * Use this to return a sheaf obtained by kmem_cache_prefill_sheaf()
>> + * It tries to refill the sheaf back to the cache's sheaf_capacity
>> + * to avoid handling partially full sheaves.
>> + *
>> + * If the refill fails because gfp is e.g. GFP_NOWAIT, the sheaf is
>> + * instead dissolved
>> + */
>> +void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
>> +			     struct slab_sheaf *sheaf)
>> +{
>> +	struct slub_percpu_sheaves *pcs;
>> +	bool refill = false;
>> +	struct node_barn *barn;
>> +
>> +	if (unlikely(sheaf->capacity != s->sheaf_capacity)) {
>> +		sheaf_flush(s, sheaf);
>> +		kfree(sheaf);
>> +		return;
>> +	}
>> +
>> +	localtry_lock(&s->cpu_sheaves->lock);
>> +	pcs = this_cpu_ptr(s->cpu_sheaves);
>> +
>> +	if (!pcs->spare) {
>> +		pcs->spare = sheaf;
>> +		sheaf = NULL;
>> +	} else if (pcs->barn->nr_full >= MAX_FULL_SHEAVES) {
> 
> Did you mean (pcs->barn->nr_full < MAX_FULL_SHEAVES)?

Oops yeah, fixing this can potentially improve performance.

> Otherwise looks good to me.

Thanks a lot!
