Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486D524BC07
	for <rcu@vger.kernel.org>; Wed, 12 Mar 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791485; cv=none; b=cCPfb6LvYV/2DwLg+AVALtiFbBDth7JUfBYIpo1zqeeEE3UdN8ZitQWXm75GKvdVWb7wsxWoqqc1+YCMva+s93tOXci3akzOpsIzmsVpQYym+6UX3CnQO2Rir3XcS44xJtCWPG9KA/aYpisd6rSKBHqnZ/+66kEz+ixGSn3Z3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791485; c=relaxed/simple;
	bh=cd4WBhUHKfcc5EID31IvjjhuqQ0bx++CKGLdmXt7td8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAxnrp8phAH69pzjRz6RlB2Lp4TtknQPKqXSyvAPJvPwVlB2dDewap4EOIQSq03oVJGT723pA65tE0OMOKWjHD1IDv8B5wdIT/hzODOMj+tfEL/nPUPA/sFGVF53n7K9NMPCdw0eDw1Jbv0Jth+NWwX6Ru3BzNNaAPml90b1lYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bUAecovx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SMYvXAmW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pXsFZoM5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=scuwjW2o; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bUAecovx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SMYvXAmW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pXsFZoM5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="scuwjW2o"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 410451F388;
	Wed, 12 Mar 2025 14:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741791481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7WD2XsTpzTFKoZOc3nhZIXrM4cIYiYfZH3pyvx6hMI=;
	b=bUAecovxufFsvQxggDCCx8Y3DyZk+rNGotjoDo6HIb0ITUEkWAQgEMt8zcVqvu8fuj8/Kx
	Bt0wotsAJFBMx0hr8DyJXQk/rRZ+aZYybsiqR26MIO4F78tNSn4Bzn2VvJyFr1+wpol0AT
	cT0AzVn23PX7NG2Qj3QI0fxlg2KF9W8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741791481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7WD2XsTpzTFKoZOc3nhZIXrM4cIYiYfZH3pyvx6hMI=;
	b=SMYvXAmW1g3TNwwTc4XM8onhkEEi2xT9rKWJCM6PiUASWWYirgzwKlOVhyBF+1ulO+1Y0k
	0p7IEvNggRmYj3CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pXsFZoM5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=scuwjW2o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741791480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7WD2XsTpzTFKoZOc3nhZIXrM4cIYiYfZH3pyvx6hMI=;
	b=pXsFZoM5XCoHDOisVf0wbfSWsX/ZkkbLTWW1KnH2cqkTVDWQvkeoQWAMZujvwWRqFhVwx+
	Nkql1e2hcyKK+tnZmyLCCfoZBWcYijaQpiK3UXe4vm3j4kAElqhKQLplCGpqKMOAruhKgX
	Ul13dIjsNLL0L6QzMztH6UgDIObajcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741791480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7WD2XsTpzTFKoZOc3nhZIXrM4cIYiYfZH3pyvx6hMI=;
	b=scuwjW2o9N+zQ6gvHgqJ11+GAWNBVKBW1YbwQpB1ElgyO9+YR4CoOtVwGcYKy1IqpdzasI
	yqjYVUlIzLgE4OCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26061132CB;
	Wed, 12 Mar 2025 14:58:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bmnNCPig0WdOAgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 12 Mar 2025 14:58:00 +0000
Message-ID: <befd17b0-160e-4933-96d9-8d5c4a774162@suse.cz>
Date: Wed, 12 Mar 2025 15:57:59 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/10] slab: add opt-in caching layer of percpu
 sheaves
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-1-88592ee0966a@suse.cz>
 <CAJuCfpG4BYNWM24_Jha-SapfeaGdO0GKuteHwNE1hDdWXRS+1Q@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpG4BYNWM24_Jha-SapfeaGdO0GKuteHwNE1hDdWXRS+1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 410451F388
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.com,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/22/25 23:46, Suren Baghdasaryan wrote:
> On Fri, Feb 14, 2025 at 8:27 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> Specifying a non-zero value for a new struct kmem_cache_args field
>> sheaf_capacity will setup a caching layer of percpu arrays called
>> sheaves of given capacity for the created cache.
>>
>> Allocations from the cache will allocate via the percpu sheaves (main or
>> spare) as long as they have no NUMA node preference. Frees will also
>> refill one of the sheaves.
>>
>> When both percpu sheaves are found empty during an allocation, an empty
>> sheaf may be replaced with a full one from the per-node barn. If none
>> are available and the allocation is allowed to block, an empty sheaf is
>> refilled from slab(s) by an internal bulk alloc operation. When both
>> percpu sheaves are full during freeing, the barn can replace a full one
>> with an empty one, unless over a full sheaves limit. In that case a
>> sheaf is flushed to slab(s) by an internal bulk free operation. Flushing
>> sheaves and barns is also wired to the existing cpu flushing and cache
>> shrinking operations.
>>
>> The sheaves do not distinguish NUMA locality of the cached objects. If
>> an allocation is requested with kmem_cache_alloc_node() with a specific
>> node (not NUMA_NO_NODE), sheaves are bypassed.
>>
>> The bulk operations exposed to slab users also try to utilize the
>> sheaves as long as the necessary (full or empty) sheaves are available
>> on the cpu or in the barn. Once depleted, they will fallback to bulk
>> alloc/free to slabs directly to avoid double copying.
>>
>> Sysfs stat counters alloc_cpu_sheaf and free_cpu_sheaf count objects
>> allocated or freed using the sheaves. Counters sheaf_refill,
>> sheaf_flush_main and sheaf_flush_other count objects filled or flushed
>> from or to slab pages, and can be used to assess how effective the
>> caching is. The refill and flush operations will also count towards the
>> usual alloc_fastpath/slowpath, free_fastpath/slowpath and other
>> counters.
>>
>> Access to the percpu sheaves is protected by local_lock_irqsave()
>> operations, each per-NUMA-node barn has a spin_lock.
>>
>> A current limitation is that when slub_debug is enabled for a cache with
>> percpu sheaves, the objects in the array are considered as allocated from
>> the slub_debug perspective, and the alloc/free debugging hooks occur
>> when moving the objects between the array and slab pages. This means
>> that e.g. an use-after-free that occurs for an object cached in the
>> array is undetected. Collected alloc/free stacktraces might also be less
>> useful. This limitation could be changed in the future.
>>
>> On the other hand, KASAN, kmemcg and other hooks are executed on actual
>> allocations and frees by kmem_cache users even if those use the array,
>> so their debugging or accounting accuracy should be unaffected.
>>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Only one possible issue in __pcs_flush_all_cpu(), all other comments
> are nits and suggestions.

Thanks.

>> +        * Limitations: when slub_debug is enabled for the cache, all relevant
>> +        * actions (i.e. poisoning, obtaining stacktraces) and checks happen
>> +        * when objects move between sheaves and slab pages, which may result in
>> +        * e.g. not detecting a use-after-free while the object is in the array
>> +        * cache, and the stacktraces may be less useful.
> 
> I would also love to see a short comparison of sheaves (when objects
> are freed using kfree_rcu()) vs SLAB_TYPESAFE_BY_RCU. I think both
> mechanisms rcu-free objects in bulk but sheaves would not reuse an
> object before RCU grace period is passed. Is that right?

I don't think that's right. SLAB_TYPESAFE_BY_RCU doesn't rcu-free objects in
bulk, the objects are freed immediately. It only rcu-delays freeing the slab
folio once all objects are freed.

>> +struct slub_percpu_sheaves {
>> +       local_lock_t lock;
>> +       struct slab_sheaf *main; /* never NULL when unlocked */
>> +       struct slab_sheaf *spare; /* empty or full, may be NULL */
>> +       struct slab_sheaf *rcu_free;
> 
> Would be nice to have a short comment for rcu_free as well. I could
> guess what main and spare are but for rcu_free had to look further.

Added.

>> +static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
>> +                                  size_t size, void **p);
>> +
>> +
>> +static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
>> +                        gfp_t gfp)
>> +{
>> +       int to_fill = s->sheaf_capacity - sheaf->size;
>> +       int filled;
>> +
>> +       if (!to_fill)
>> +               return 0;
>> +
>> +       filled = __kmem_cache_alloc_bulk(s, gfp, to_fill,
>> +                                        &sheaf->objects[sheaf->size]);
>> +
>> +       if (!filled)
>> +               return -ENOMEM;
>> +
>> +       sheaf->size = s->sheaf_capacity;
> 
> nit: __kmem_cache_alloc_bulk() either allocates requested number of
> objects or returns 0, so the current code is fine but if at some point
> the implementation changes so that it can return smaller number of
> objects than requested (filled < to_fill) then the above assignment
> will become invalid. I think a safer thing here would be to just:
> 
>        sheaf->size += filled;
> 
> which also makes logical sense. Alternatively you could add
> VM_BUG_ON(filled != to_fill) but the increment I think would be
> better.

It's useful to indicate the refill was not successful, for patch 6. So I'm
changing this to:

        sheaf->size += filled;

        stat_add(s, SHEAF_REFILL, filled);

        if (filled < to_fill)
                return -ENOMEM;

        return 0;

>> +
>> +       stat_add(s, SHEAF_REFILL, filled);
>> +
>> +       return 0;
>> +}
>> +
>> +
>> +static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
>> +{
>> +       struct slab_sheaf *sheaf = alloc_empty_sheaf(s, gfp);
>> +
>> +       if (!sheaf)
>> +               return NULL;
>> +
>> +       if (refill_sheaf(s, sheaf, gfp)) {
>> +               free_empty_sheaf(s, sheaf);
>> +               return NULL;
>> +       }
>> +
>> +       return sheaf;
>> +}
>> +
>> +/*
>> + * Maximum number of objects freed during a single flush of main pcs sheaf.
>> + * Translates directly to an on-stack array size.
>> + */
>> +#define PCS_BATCH_MAX  32U
>> +
> .> +static void __kmem_cache_free_bulk(struct kmem_cache *s, size_t
> size, void **p);
>> +
> 
> A comment clarifying why you are freeing in PCS_BATCH_MAX batches here
> would be helpful. My understanding is that you do that to free objects
> outside of the cpu_sheaves->lock, so you isolate a batch, release the
> lock and then free the batch.

OK.

>> +static void sheaf_flush_main(struct kmem_cache *s)
>> +{
>> +       struct slub_percpu_sheaves *pcs;
>> +       unsigned int batch, remaining;
>> +       void *objects[PCS_BATCH_MAX];
>> +       struct slab_sheaf *sheaf;
>> +       unsigned long flags;
>> +
>> +next_batch:
>> +       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
>> +       pcs = this_cpu_ptr(s->cpu_sheaves);
>> +       sheaf = pcs->main;
>> +
>> +       batch = min(PCS_BATCH_MAX, sheaf->size);
>> +
>> +       sheaf->size -= batch;
>> +       memcpy(objects, sheaf->objects + sheaf->size, batch * sizeof(void *));
>> +
>> +       remaining = sheaf->size;
>> +
>> +       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
>> +
>> +       __kmem_cache_free_bulk(s, batch, &objects[0]);
>> +
>> +       stat_add(s, SHEAF_FLUSH_MAIN, batch);
>> +
>> +       if (remaining)
>> +               goto next_batch;
>> +}
>> +
> 
> This function seems to be used against either isolated sheaves or in
> slub_cpu_dead() --> __pcs_flush_all_cpu() path where we hold
> slab_mutex and I think that guarantees that the sheaf is unused. Maybe
> a short comment clarifying this requirement or rename the function to
> reflect that? Something like flush_unused_sheaf()?

It's not slab_mutex, but the fact slub_cpu_dead() is executed in a hotplug
phase when the given cpu is already not executing anymore and thus cannot be
manipulating its percpu sheaves, so we are the only one that does.
So I will clarify and rename to sheaf_flush_unused().

>> +
>> +static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
>> +{
>> +       struct slub_percpu_sheaves *pcs;
>> +
>> +       pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
>> +
>> +       if (pcs->spare) {
>> +               sheaf_flush(s, pcs->spare);
>> +               free_empty_sheaf(s, pcs->spare);
>> +               pcs->spare = NULL;
>> +       }
>> +
>> +       // TODO: handle rcu_free
>> +       BUG_ON(pcs->rcu_free);
>> +
>> +       sheaf_flush_main(s);
> 
> Hmm. sheaf_flush_main() always flushes for this_cpu only, so IIUC this
> call will not necessarily flush the main sheaf for the cpu passed to
> __pcs_flush_all_cpu().

Thanks, yes I need to call sheaf_flush_unused(pcs->main). It's ok to do
given my reply above.

>> +/*
>> + * Free an object to the percpu sheaves.
>> + * The object is expected to have passed slab_free_hook() already.
>> + */
>> +static __fastpath_inline
>> +void free_to_pcs(struct kmem_cache *s, void *object)
>> +{
>> +       struct slub_percpu_sheaves *pcs;
>> +       unsigned long flags;
>> +
>> +restart:
>> +       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
>> +       pcs = this_cpu_ptr(s->cpu_sheaves);
>> +
>> +       if (unlikely(pcs->main->size == s->sheaf_capacity)) {
>> +
>> +               struct slab_sheaf *empty;
>> +
>> +               if (!pcs->spare) {
>> +                       empty = barn_get_empty_sheaf(pcs->barn);
>> +                       if (empty) {
>> +                               pcs->spare = pcs->main;
>> +                               pcs->main = empty;
>> +                               goto do_free;
>> +                       }
>> +                       goto alloc_empty;
>> +               }
>> +
>> +               if (pcs->spare->size < s->sheaf_capacity) {
>> +                       stat(s, SHEAF_SWAP);
>> +                       swap(pcs->main, pcs->spare);
>> +                       goto do_free;
>> +               }
>> +
>> +               empty = barn_replace_full_sheaf(pcs->barn, pcs->main);
>> +
>> +               if (!IS_ERR(empty)) {
>> +                       pcs->main = empty;
>> +                       goto do_free;
>> +               }
>> +
>> +               if (PTR_ERR(empty) == -E2BIG) {
>> +                       /* Since we got here, spare exists and is full */
>> +                       struct slab_sheaf *to_flush = pcs->spare;
>> +
>> +                       pcs->spare = NULL;
>> +                       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
>> +
>> +                       sheaf_flush(s, to_flush);
>> +                       empty = to_flush;
>> +                       goto got_empty;
>> +               }
>> +
>> +alloc_empty:
>> +               local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
>> +
>> +               empty = alloc_empty_sheaf(s, GFP_NOWAIT);
>> +
>> +               if (!empty) {
>> +                       sheaf_flush_main(s);
>> +                       goto restart;
>> +               }
>> +
>> +got_empty:
>> +               local_lock_irqsave(&s->cpu_sheaves->lock, flags);
>> +               pcs = this_cpu_ptr(s->cpu_sheaves);
>> +
>> +               /*
>> +                * if we put any sheaf to barn here, it's because we raced or
>> +                * have been migrated to a different cpu, which should be rare
>> +                * enough so just ignore the barn's limits to simplify
>> +                */
>> +               if (unlikely(pcs->main->size < s->sheaf_capacity)) {
>> +                       if (!pcs->spare)
>> +                               pcs->spare = empty;
>> +                       else
>> +                               barn_put_empty_sheaf(pcs->barn, empty, true);
>> +                       goto do_free;
>> +               }
>> +
>> +               if (!pcs->spare) {
>> +                       pcs->spare = pcs->main;
>> +                       pcs->main = empty;
>> +                       goto do_free;
>> +               }
>> +
>> +               barn_put_full_sheaf(pcs->barn, pcs->main, true);
>> +               pcs->main = empty;
> 
> I find the program flow in this function quite complex and hard to
> follow. I think refactoring the above block starting from "pcs =
> this_cpu_ptr(s->cpu_sheaves)" would somewhat simplify it. That
> eliminates the need for the "got_empty" label and makes the
> locking/unlocking sequence of s->cpu_sheaves->lock a bit more clear.

I'm a bit lost, refactoring how exactly?

>> +       }
>> +
>> +do_free:
>> +       pcs->main->objects[pcs->main->size++] = object;
>> +
>> +       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
>> +
>> +       stat(s, FREE_PCS);
>> +}
