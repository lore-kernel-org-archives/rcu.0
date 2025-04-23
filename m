Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5EA81749
	for <rcu@vger.kernel.org>; Wed, 23 Apr 2025 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745413623; cv=none; b=DIiPJuH7oS92dIryH/npLP4YSgQ1EkCnqge8NbQVg2dMVdv1ChMpvrm+8w6Kx0T7zQ1siafHAA578XyhPmV+GwJyrICS5rMNX1Tr1H4LKaBP1qja7rYgZbH4E3sdMkmGfXpbK64OSyo7nhl3YbgZa7Z1TVM4jMGvJ/E6rC+citk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745413623; c=relaxed/simple;
	bh=JvQsrhmSRnDGQ8NfR2/+/N0BJWT7+gNw4O/f+A/cJlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dd6uaLyTfBpsJ5RHsTXB5RGiO9wuvxIlr4zUVg38Z9k9jdaoXkQD5kL+KVNEiNe1nHZ9u3YFp4FwBfmnNosAomifYwSO1sfUSi6j6x7WfHhkocBcqedNHV1sRN9IVeo/1NqRH5qQty81cB97DYgyRe0DBhCLZv8YvKz68FQkS50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dn1S+BWW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wibj3zQE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dn1S+BWW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wibj3zQE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dn1S+BWW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wibj3zQE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dn1S+BWW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wibj3zQE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 53466211B5;
	Wed, 23 Apr 2025 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745413618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCXSygqQaZz2sFZKWsGVR3zoYdmBl8B48kUOxgpdrUg=;
	b=dn1S+BWWUHqHnOLJgdxIex+yaeauBaeWK3AXgOVEkVRYuTBAChK4qRykLyhnbS0NH6IRel
	KoHroteBuQ16vx/9IoQIXMmI/8b63pIaMG/OcLkQZ21RgDa39PWvnd4FJsySaRvgUItJ2Y
	DAUHq+a/DrcvB9hfojQRKeXBu8jLtYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745413618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCXSygqQaZz2sFZKWsGVR3zoYdmBl8B48kUOxgpdrUg=;
	b=Wibj3zQEytrlFQ/z24z/yrWEV/f26wdOcO0pnUDY8UDLFvCkmSak/ctLnmGEM4sYBkRHpa
	4381HrRDnLu5oVBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745413618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCXSygqQaZz2sFZKWsGVR3zoYdmBl8B48kUOxgpdrUg=;
	b=dn1S+BWWUHqHnOLJgdxIex+yaeauBaeWK3AXgOVEkVRYuTBAChK4qRykLyhnbS0NH6IRel
	KoHroteBuQ16vx/9IoQIXMmI/8b63pIaMG/OcLkQZ21RgDa39PWvnd4FJsySaRvgUItJ2Y
	DAUHq+a/DrcvB9hfojQRKeXBu8jLtYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745413618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCXSygqQaZz2sFZKWsGVR3zoYdmBl8B48kUOxgpdrUg=;
	b=Wibj3zQEytrlFQ/z24z/yrWEV/f26wdOcO0pnUDY8UDLFvCkmSak/ctLnmGEM4sYBkRHpa
	4381HrRDnLu5oVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C88913A3D;
	Wed, 23 Apr 2025 13:06:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5XRmDvLlCGhCUwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Apr 2025 13:06:58 +0000
Message-ID: <7c4fe3af-a38b-4d40-9824-2935b46e1ecd@suse.cz>
Date: Wed, 23 Apr 2025 15:06:57 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 4/8] slab: sheaf prefilling for guaranteed
 allocations
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
 <20250317-slub-percpu-caches-v3-4-9d9884d8b643@suse.cz>
 <CAJuCfpEg8bXVy2F61VNfn2AGW-SJBovGf69SEhK9oJeijjVpJA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpEg8bXVy2F61VNfn2AGW-SJBovGf69SEhK9oJeijjVpJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.com,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 4/10/25 22:47, Suren Baghdasaryan wrote:
>> +/*
>> + * refill a sheaf previously returned by kmem_cache_prefill_sheaf to at least
>> + * the given size
>> + *
>> + * the sheaf might be replaced by a new one when requesting more than
>> + * s->sheaf_capacity objects if such replacement is necessary, but the refill
>> + * fails (returning -ENOMEM), the existing sheaf is left intact
>> + *
>> + * In practice we always refill to full sheaf's capacity.
>> + */
>> +int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
>> +                           struct slab_sheaf **sheafp, unsigned int size)
> 
> nit: Would returning a refilled sheaf be a slightly better API than
> passing pointer to a pointer?

I'm not sure it would be simpler to use, since we need to be able to
indicate -ENOMEM which would presumably become NULL, so the user would have
to store the existing sheaf pointer and not just blindly do "sheaf =
refill(sheaf)". Or the semantics would have to be that in case of failure
the existing sheaf is returned and caller is left with nothing. Liam, what
do you think?

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
>> +       if (!sheaf)
>> +               return -ENOMEM;
>> +
>> +       kmem_cache_return_sheaf(s, gfp, *sheafp);
>> +       *sheafp = sheaf;
>> +       return 0;
>> +}
>> +
>> +/*
>> + * Allocate from a sheaf obtained by kmem_cache_prefill_sheaf()
>> + *
>> + * Guaranteed not to fail as many allocations as was the requested size.
>> + * After the sheaf is emptied, it fails - no fallback to the slab cache itself.
>> + *
>> + * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACCOUNT
>> + * memcg charging is forced over limit if necessary, to avoid failure.
>> + */
>> +void *
>> +kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
>> +                                  struct slab_sheaf *sheaf)
>> +{
>> +       void *ret = NULL;
>> +       bool init;
>> +
>> +       if (sheaf->size == 0)
>> +               goto out;
>> +
>> +       ret = sheaf->objects[--sheaf->size];
>> +
>> +       init = slab_want_init_on_alloc(gfp, s);
>> +
>> +       /* add __GFP_NOFAIL to force successful memcg charging */
>> +       slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, init, s->object_size);
>> +out:
>> +       trace_kmem_cache_alloc(_RET_IP_, ret, s, gfp, NUMA_NO_NODE);
>> +
>> +       return ret;
>> +}
>> +
>> +unsigned int kmem_cache_sheaf_size(struct slab_sheaf *sheaf)
>> +{
>> +       return sheaf->size;
>> +}
>>  /*
>>   * To avoid unnecessary overhead, we pass through large allocation requests
>>   * directly to the page allocator. We use __GFP_COMP, because we will need to
>>
>> --
>> 2.48.1
>>

