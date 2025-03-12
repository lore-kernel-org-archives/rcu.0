Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1F1D9688
	for <rcu@vger.kernel.org>; Wed, 12 Mar 2025 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799348; cv=none; b=LzT1dqb4K7ZxMWO2tys8QfqJySiD90d1vV8mf1fOPd6Wt+GsUik+8W3403XfFKxMfKfhiVg0nt+/n9jc8eGtQXBmZUNouMlTKQuzEGrpwzBc5IREfyOq4TNm3Fxgohn8tokfYOa+RXCUci3P1XNrwdtW4kWiKGc7zn8jHpQ60Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799348; c=relaxed/simple;
	bh=mF1Wm9hw4qscjzJ8ObVcQ1icZUwjMzcUoYkArCFnc8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qi0Kh5BN3mHQbShVC6ZDffIIc9fQuNWAUY7UtnBjF9d63aqI+MoCwkS0lBtF7olqqn3AhLtpqNKkx9/cQlrn7tBdQc4KZqNhSPJ3yVXZKax6hswL65llYYv9yuAwU4zs+rUiNwPEG1ZDXwD20uc1pFRN60UnUbOvpUtAlTcRw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qvG6ryEr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pzQVjAhR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qvG6ryEr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pzQVjAhR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qvG6ryEr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pzQVjAhR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qvG6ryEr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pzQVjAhR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A244021184;
	Wed, 12 Mar 2025 17:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741799344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+o/so2FcuEbUAtgWAGtwB3kM8iQKUbAip3d2nC1dS4=;
	b=qvG6ryErgaK3fJshys4Ix668FFwcJOMqDUEqDhqciLFTUUh5Ccm6dyLFJi5vPvDafEjNK0
	9YlpIBKA556s4TG99PdHTk4RivDVz1sj3SUW7iW72HbQYJm4MzZwhW1l4WJ72KUs4bt8Ml
	6s3VuX8umqYA4lk8ipavyyr/MXYgO2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741799344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+o/so2FcuEbUAtgWAGtwB3kM8iQKUbAip3d2nC1dS4=;
	b=pzQVjAhRqV2L6txlKzkk8ZdqEWtOlBaQ6Xe2AnQAm6Szcj8//I5JBHIxLsZs077x7k1HfK
	4Y7NRVr0x3H+z8Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qvG6ryEr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pzQVjAhR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741799344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+o/so2FcuEbUAtgWAGtwB3kM8iQKUbAip3d2nC1dS4=;
	b=qvG6ryErgaK3fJshys4Ix668FFwcJOMqDUEqDhqciLFTUUh5Ccm6dyLFJi5vPvDafEjNK0
	9YlpIBKA556s4TG99PdHTk4RivDVz1sj3SUW7iW72HbQYJm4MzZwhW1l4WJ72KUs4bt8Ml
	6s3VuX8umqYA4lk8ipavyyr/MXYgO2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741799344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+o/so2FcuEbUAtgWAGtwB3kM8iQKUbAip3d2nC1dS4=;
	b=pzQVjAhRqV2L6txlKzkk8ZdqEWtOlBaQ6Xe2AnQAm6Szcj8//I5JBHIxLsZs077x7k1HfK
	4Y7NRVr0x3H+z8Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84FEE132CB;
	Wed, 12 Mar 2025 17:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x6xuH7C/0Wc+LQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 12 Mar 2025 17:09:04 +0000
Message-ID: <4a825090-bdc6-46c5-bd5d-71357a03087a@suse.cz>
Date: Wed, 12 Mar 2025 18:09:04 +0100
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
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-6-88592ee0966a@suse.cz>
 <CAJuCfpEBqfhaCQnZFKFkNRhXe0z1k0ZBTDw5BXr=Zu9_s0TfkQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpEBqfhaCQnZFKFkNRhXe0z1k0ZBTDw5BXr=Zu9_s0TfkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A244021184
X-Spam-Level: 
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.com,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 2/23/25 04:54, Suren Baghdasaryan wrote:
> On Fri, Feb 14, 2025 at 8:27 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
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
> 
> s/expecially/especially
> 
>> ineffective when replacing a sheaf with a new one of a larger capacity.
>> It is therefore better to size cache's sheaf_capacity accordingly.
> 
> If support for sizes exceeding sheaf_capacity adds much complexity
> with no performance benefits, I think it would be ok not to support
> them at all. Users know the capacity of a particular kmem_cache, so
> they can use this API only when their needs are within sheaf_capacity,
> otherwise either size the sheaf appropriately or use slab bulk
> allocation.

As Harry explained, the users (e.g. maple tree) would have to implement the
fallback for unusual situations instead, so it's better to implement it just
once here.

>>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks.

>> +/*
>> + * Use this to return a sheaf obtained by kmem_cache_prefill_sheaf()
>> + * It tries to refill the sheaf back to the cache's sheaf_capacity
>> + * to avoid handling partially full sheaves.
>> + *
>> + * If the refill fails because gfp is e.g. GFP_NOWAIT, the sheaf is
>> + * instead dissolved
> 
> Refilling the sheaf here assumes that in the future we are more likely
> to allocate than to free objects or shrink the slab. If the reverse is
> true then it would make sense to flush the sheaf and add it as an
> empty one into the barn. The fact that flushing can't fail would be
> another advantage... We don't know the future but should we be
> predicting a more costly case?

What the comment doesn't say is we first try to make the sheaf become
pcs->spare without any refill. This is the ideal scenario if nobody
interrupts us between prefill (we grab the spare) and return (we return the
spare).

Also the refill is only attempted if the barn can accept full sheaf.

I have clarified the comment.

Maybe we could make the decision to flush e.g. if the sheaf is below half of
the capacity, but that can be subject to further performance evaluation.

>> + */
>> +void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
>> +                            struct slab_sheaf *sheaf)
>> +{
>> +       struct slub_percpu_sheaves *pcs;
>> +       bool refill = false;
>> +       struct node_barn *barn;
>> +
>> +       if (unlikely(sheaf->capacity != s->sheaf_capacity)) {
>> +               sheaf_flush(s, sheaf);
>> +               kfree(sheaf);
>> +               return;
>> +       }
>> +
>> +       localtry_lock(&s->cpu_sheaves->lock);
>> +       pcs = this_cpu_ptr(s->cpu_sheaves);
>> +
>> +       if (!pcs->spare) {
>> +               pcs->spare = sheaf;
>> +               sheaf = NULL;
>> +       } else if (pcs->barn->nr_full >= MAX_FULL_SHEAVES) {
>> +               /* racy check */
>> +               barn = pcs->barn;
>> +               refill = true;
>> +       }
>> +
>> +       localtry_unlock(&s->cpu_sheaves->lock);
>> +
>> +       if (!sheaf)
>> +               return;
>> +
>> +       /*
>> +        * if the barn is full of full sheaves or we fail to refill the sheaf,
>> +        * simply flush and free it
>> +        */
>> +       if (!refill || refill_sheaf(s, sheaf, gfp)) {
>> +               sheaf_flush(s, sheaf);
>> +               free_empty_sheaf(s, sheaf);
>> +               return;
>> +       }
>> +
>> +       /* we racily determined the sheaf would fit, so now force it */
>> +       barn_put_full_sheaf(barn, sheaf, true);
>> +}
>> +
>> +/*
>> + * refill a sheaf previously returned by kmem_cache_prefill_sheaf to at least
>> + * the given size
>> + *
>> + * the sheaf might be replaced by a new one when requesting more than
>> + * s->sheaf_capacity objects if such replacement is necessary, but the refill
>> + * fails (with -ENOMEM), the existing sheaf is left intact
>> + */
>> +int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
>> +                           struct slab_sheaf **sheafp, unsigned int size)
>> +{
>> +       struct slab_sheaf *sheaf;
>> +
>> +       /*
>> +        * TODO: do we want to support *sheaf == NULL to be equivalent of
>> +        * kmem_cache_prefill_sheaf() ?
>> +        */
>> +       if (!sheafp || !(*sheafp))
>> +               return -EINVAL;
>> +
>> +       sheaf = *sheafp;
>> +       if (sheaf->size >= size)
>> +               return 0;
>> +
>> +       if (likely(sheaf->capacity >= size)) {
>> +               if (likely(sheaf->capacity == s->sheaf_capacity))
>> +                       return refill_sheaf(s, sheaf, gfp);
>> +
>> +               if (!__kmem_cache_alloc_bulk(s, gfp, sheaf->capacity - sheaf->size,
>> +                                            &sheaf->objects[sheaf->size])) {
>> +                       return -ENOMEM;
>> +               }
>> +               sheaf->size = sheaf->capacity;
>> +
>> +               return 0;
>> +       }
>> +
>> +       /*
>> +        * We had a regular sized sheaf and need an oversize one, or we had an
>> +        * oversize one already but need a larger one now.
>> +        * This should be a very rare path so let's not complicate it.
>> +        */
>> +       sheaf = kmem_cache_prefill_sheaf(s, gfp, size);
> 
> WIth all the above I think you always end up refilling up to
> sheaf->capacity. Not sure if we should mention that in the comment for
> this function because your statement about refilling to at least the
> given size is still correct.

OK mentioned it in the comment.

