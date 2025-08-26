Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB0130F55C
	for <rcu@vger.kernel.org>; Tue, 26 Aug 2025 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202386; cv=none; b=ADZgMIX9xz81dnAIoVblaslJ1UME0jVEVugUW/0uDC+O9lhmbycg3wkCPZumoq3RTCms46sRLjqWm7JNtJBMVy5jolidW4nmo1UzX4mZcpAI1ARcH7EeZ+jznRm1bjU03ozLGvly14oPn7ssrjDjDU62+FwKRuffuVwpHPmnx08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202386; c=relaxed/simple;
	bh=geFfM2smiA1cL76SlJ1JGQrp0uSK+mK1slJUy124+dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9tSynWMmI25lmWZwM7H0E0B11e4gONUr2mfggGJ/1v1Ya1QQagV6m1/7dPsUR88CsVuHM8Yn+eFtn/UVbXotrN3H1+SVo6exAiLVPXmNp9ugjAclhr4y2dnYVWBQ53rzp8QyvnFLJx1acATwik8G/Tm+9mVgzONkAmc/NMId68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H6pRfWAC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D6FZDjnb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H6pRfWAC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D6FZDjnb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H6pRfWAC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D6FZDjnb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H6pRfWAC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D6FZDjnb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ACBFD1F449;
	Tue, 26 Aug 2025 09:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756202382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nLnkaLaHWhifO4yBm8d+LtS+mu5qj07MhWGaW1OLi/4=;
	b=H6pRfWAChXxpTYcPn/SkA1t9dNK50OYRLK0eswwiufg12Pk5Y+44Cp4zFSZTfOfGiJq1M5
	ITbrrl2qsp2sdbPIv26Tyzp6UtPoEekEnd0CPK9S/O+cZre57mLQ7HGYd7WmjwQZgLPSZP
	fhtX2basGMcOLC6PD43AXdA/5x23CqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756202382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nLnkaLaHWhifO4yBm8d+LtS+mu5qj07MhWGaW1OLi/4=;
	b=D6FZDjnbzbl0izyiAagyDx796+uJEZTL0skqhvcmgwODddu7zx//681uViDp47oZOuUJaQ
	tBxvU3iOfq3CzxDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756202382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nLnkaLaHWhifO4yBm8d+LtS+mu5qj07MhWGaW1OLi/4=;
	b=H6pRfWAChXxpTYcPn/SkA1t9dNK50OYRLK0eswwiufg12Pk5Y+44Cp4zFSZTfOfGiJq1M5
	ITbrrl2qsp2sdbPIv26Tyzp6UtPoEekEnd0CPK9S/O+cZre57mLQ7HGYd7WmjwQZgLPSZP
	fhtX2basGMcOLC6PD43AXdA/5x23CqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756202382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nLnkaLaHWhifO4yBm8d+LtS+mu5qj07MhWGaW1OLi/4=;
	b=D6FZDjnbzbl0izyiAagyDx796+uJEZTL0skqhvcmgwODddu7zx//681uViDp47oZOuUJaQ
	tBxvU3iOfq3CzxDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9275213479;
	Tue, 26 Aug 2025 09:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LFlpI46FrWhKawAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 26 Aug 2025 09:59:42 +0000
Message-ID: <95413138-1a9c-4b10-847d-cb37b68ba7c4@suse.cz>
Date: Tue, 26 Aug 2025 11:59:42 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/14] tools: Add sheaves support to testing
 infrastructure
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250723-slub-percpu-caches-v5-6-b792cd830f5d@suse.cz>
 <CAJuCfpEsVE7Jae7PqWvgTtm38C5MPFx43+dDyYzfKLMQFuE_3A@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAJuCfpEsVE7Jae7PqWvgTtm38C5MPFx43+dDyYzfKLMQFuE_3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,gentwo.org,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 8/22/25 18:56, Suren Baghdasaryan wrote:
>> @@ -270,6 +276,84 @@ __kmem_cache_create_args(const char *name, unsigned int size,
>>         return ret;
>>  }
>>
>> +struct slab_sheaf *
>> +kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
>> +{
>> +       struct slab_sheaf *sheaf;
>> +       unsigned int capacity;
>> +
>> +       if (size > s->sheaf_capacity)
>> +               capacity = size;
>> +       else
>> +               capacity = s->sheaf_capacity;
> 
> nit:
> capacity = max(size, s->sheaf_capacity);

OK

>> +
>> +       sheaf = malloc(sizeof(*sheaf) + sizeof(void *) * s->sheaf_capacity * capacity);
> 
> Should this really be `sizeof(void *) * s->sheaf_capacity * capacity`
> or just `sizeof(void *) * capacity` ?

Right, so the whole thing should be:
sizeof(*sheaf) + sizeof(void *) * capacity

> 
>> +       if (!sheaf) {
>> +               return NULL;
>> +       }
>> +
>> +       memset(sheaf, 0, size);

This is also wrong, so I'm changing it to calloc(1, ...) to get the zeroing
there.

>> +       sheaf->cache = s;
>> +       sheaf->capacity = capacity;
>> +       sheaf->size = kmem_cache_alloc_bulk(s, gfp, size, sheaf->objects);
>> +       if (!sheaf->size) {
>> +               free(sheaf);
>> +               return NULL;
>> +       }
>> +
>> +       return sheaf;
>> +}
>> +
>> +int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
>> +                struct slab_sheaf **sheafp, unsigned int size)
>> +{
>> +       struct slab_sheaf *sheaf = *sheafp;
>> +       int refill;
>> +
>> +       if (sheaf->size >= size)
>> +               return 0;
>> +
>> +       if (size > sheaf->capacity) {
>> +               sheaf = kmem_cache_prefill_sheaf(s, gfp, size);
>> +               if (!sheaf)
>> +                       return -ENOMEM;
>> +
>> +               kmem_cache_return_sheaf(s, gfp, *sheafp);
>> +               *sheafp = sheaf;
>> +               return 0;
>> +       }
>> +
>> +       refill = kmem_cache_alloc_bulk(s, gfp, size - sheaf->size,
>> +                                      &sheaf->objects[sheaf->size]);
>> +       if (!refill)
>> +               return -ENOMEM;
>> +
>> +       sheaf->size += refill;
>> +       return 0;
>> +}
>> +
>> +void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
>> +                struct slab_sheaf *sheaf)
>> +{
>> +       if (sheaf->size) {
>> +               //s->non_kernel += sheaf->size;
> 
> Above comment seems obsolete.

Ack.

> 
>> +               kmem_cache_free_bulk(s, sheaf->size, &sheaf->objects[0]);
>> +       }
>> +       free(sheaf);
>> +}
>> +
>> +void *
>> +kmem_cache_alloc_from_sheaf(struct kmem_cache *s, gfp_t gfp,
>> +               struct slab_sheaf *sheaf)
>> +{
>> +       if (sheaf->size == 0) {
>> +               printf("Nothing left in sheaf!\n");
>> +               return NULL;
>> +       }
>> +
> 
> Should we clear sheaf->objects[sheaf->size] for additional safety?

OK.
>> +       return sheaf->objects[--sheaf->size];
>> +}
>> +
>>  /*
>>   * Test the test infrastructure for kem_cache_alloc/free and bulk counterparts.
>>   */
>>
>> --
>> 2.50.1
>>

