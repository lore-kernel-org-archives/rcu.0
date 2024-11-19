Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8554A1474CF;
	Tue, 19 Nov 2024 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004825; cv=none; b=Hi52Lwj5oxyBzmZAzO8otC9N/duw/sLsJ1MlSXpH84e/z/rVz8XHJ81X6Y83wPNhFzNG4/mNHrGPhXrDeSVtQOwnNF22FZeBaE//kGWZ0AifhZ/rEBw8740llQeCKszO4kzkRCVlkqaDbbG3inhRAT5G9Y9uwQBj7St5McZqjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004825; c=relaxed/simple;
	bh=tkq4zObVRNQByTql+WMX7eZhvMy9TmXpklyorfsuXgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEn5eenB/yflcnrbWX/+WKnVf8YtlkmVz+a7TjpYfEZRXgudiESiMuR8oYnC5QYKs9qfaI51nUgedmbdSBXO+aYpWzZhHZeo9BPLIGgUab1iPrnxzM+/attov1eR4N19BQpT7f6Ej8YzgPzHAyK5MXsvMCRrj29REsit4c3Qgeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oDuags+N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wtw5mxVH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ov/f0z1q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HWjrXogI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oDuags+N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wtw5mxVH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ov/f0z1q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HWjrXogI"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9778D219B1;
	Tue, 19 Nov 2024 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732004821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1CqGxfnLhjjKAtoHqBBZTj9BQVcyhPyGgM8/YbUQzLM=;
	b=oDuags+NXxzGv+KBUDq5QR58vISL9VmChHQKNLLzI76P8ponkt/7dG7lofZVNCf1F16KM3
	SM/avjfzaUPAU1og2wwVT3aQ93AsGuCaHhKyMGngAyyMM22rHfhTT23X/5D/xj6rYdHxp4
	KId4XRv8p1ABaGBlRjVlgSFjS1i5nk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732004821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1CqGxfnLhjjKAtoHqBBZTj9BQVcyhPyGgM8/YbUQzLM=;
	b=Wtw5mxVHOIWfA2zJHwsvNq7ovlO+gwQOuuFVtDHHMOt17ZZ6nzuHfsYgQhby0XeswQ6lHT
	DZKAHi0ZwewfX5Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732004820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1CqGxfnLhjjKAtoHqBBZTj9BQVcyhPyGgM8/YbUQzLM=;
	b=ov/f0z1qvcTKsyJEfEjXr43r5Gd0g0G3fxuaPPa84sTwCVS1vi3U/cFUiAapcrIpKoIp6E
	FEUjo8JKjAcmrPJNlwVy+bj/VJIEO41KO9j4cExYHttkwtz3unSZMxiv1XJpwhI7DrH5Fm
	eH+F9qbh07ToDTRIrI7f7lOcPXorIzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732004820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1CqGxfnLhjjKAtoHqBBZTj9BQVcyhPyGgM8/YbUQzLM=;
	b=HWjrXogImRq2L00Dc42wz919YTWVI7EGurr17gHf8M/vAlAGxbft3mxdZFPRdLrlcaYWaL
	6eqGvTEwV1RGHpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7099F13736;
	Tue, 19 Nov 2024 08:27:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U8vJGtRLPGcsGgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 19 Nov 2024 08:27:00 +0000
Message-ID: <dac2e02c-9a71-4ced-8ac1-7b15dea120c3@suse.cz>
Date: Tue, 19 Nov 2024 09:27:00 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6/6] mm, slub: sheaf prefilling for guaranteed
 allocations
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz>
 <20241112-slub-percpu-caches-v1-6-ddc0bdc27e05@suse.cz>
 <CAB=+i9QoavVWZ6HxiOb8ypqov0rM+HAK4ge7nKHdQRPUaNPmkw@mail.gmail.com>
 <9dc33d5f-fc04-4780-80ae-3c5f80a8b891@suse.cz>
 <CAB=+i9RZra587ik+A-hZtVwzppAt9CsA7oiuVg9QhgEHT=-daQ@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAB=+i9RZra587ik+A-hZtVwzppAt9CsA7oiuVg9QhgEHT=-daQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux.com,kernel.org,lge.com,linux.dev,infradead.org,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/19/24 03:29, Hyeonggon Yoo wrote:
> On Mon, Nov 18, 2024 at 11:26 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 11/18/24 14:13, Hyeonggon Yoo wrote:
>> > On Wed, Nov 13, 2024 at 1:39 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> >> +
>> >> +/*
>> >> + * Allocate from a sheaf obtained by kmem_cache_prefill_sheaf()
>> >> + *
>> >> + * Guaranteed not to fail as many allocations as was the requested count.
>> >> + * After the sheaf is emptied, it fails - no fallback to the slab cache itself.
>> >> + *
>> >> + * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACCOUNT
>> >> + * memcg charging is forced over limit if necessary, to avoid failure.
>> >> + */
>> >> +void *
>> >> +kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
>> >> +                                  struct slab_sheaf *sheaf)
>> >> +{
>> >> +       void *ret = NULL;
>> >> +       bool init;
>> >> +
>> >> +       if (sheaf->size == 0)
>> >> +               goto out;
>> >> +
>> >> +       ret = sheaf->objects[--sheaf->size];
>> >> +
>> >> +       init = slab_want_init_on_alloc(gfp, s);
>> >> +
>> >> +       /* add __GFP_NOFAIL to force successful memcg charging */
>> >> +       slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, init, s->object_size);
>> >
>> > Maybe I'm missing something, but how can this be used for non-sleepable contexts
>> > if __GFP_NOFAIL is used? I think we have to charge them when the sheaf
>>
>> AFAIK it forces memcg to simply charge even if allocated memory goes over
>> the memcg limit. So there's no issue with a non-sleepable context, there
>> shouldn't be memcg reclaim happening in that case.
> 
> Ok, but I am still worried about mem alloc profiling/memcg trying to
> allocate some memory
> with __GFP_NOFAIL flag and eventually passing it to the buddy allocator,
> which does not want __GFP_NOFAIL without __GFP_DIRECT_RECLAIM?
> e.g.) memcg hook calls
> alloc_slab_obj_exts()->kcalloc_node()->....->alloc_pages()

alloc_slab_obj_exts() removes __GFP_NOFAIL via OBJCGS_CLEAR_MASK so that's fine.
I think kmemleak_alloc_recursive() is also fine as it ends up in
mem_pool_alloc() and will clear __GFP_NOFAIL it via gfp_nested_mask()
Hope I'm not missing something else.

>> > is returned
>> > via kmem_cache_prefill_sheaf(), just like users of bulk alloc/free?
>>
>> That would be very costly to charge/uncharge if most of the objects are not
>> actually used - it's what we want to avoid here.
>> Going over the memcgs limit a bit in a very rare case isn't considered such
>> an issue, for example Linus advocated such approach too in another context.
> 
> Thanks for the explanation! That was a point I was missing.
> 
>> > Best,
>> > Hyeonggon
>> >
>> >> +out:
>> >> +       trace_kmem_cache_alloc(_RET_IP_, ret, s, gfp, NUMA_NO_NODE);
>> >> +
>> >> +       return ret;
>> >> +}
>> >> +
>> >>  /*
>> >>   * To avoid unnecessary overhead, we pass through large allocation requests
>> >>   * directly to the page allocator. We use __GFP_COMP, because we will need to
>> >>
>> >> --
>> >> 2.47.0
>> >>
>>

