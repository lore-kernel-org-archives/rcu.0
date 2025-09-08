Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489A2FFDF4
	for <rcu@vger.kernel.org>; Mon,  8 Sep 2025 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335518; cv=none; b=l8iFxXnVpH64hTPROiQlXL/8jxzQlOEFkLLlViDLa9+VQPdA5eSLL5JzpqFcD83bRn6pCD39h3tkYLht6en6yjAeem51ybI2mOwGRlnCTLQM7rhdBo7bOI8kbbf3yPfSSBCoM1Aglyhv19VwePxWlrVMxihY77J29358EGrsQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335518; c=relaxed/simple;
	bh=9Yt++TiQVAgg0vjYxQ/ubX6nDcAuh0I15ogWRrK+RWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CR3iXA280padjWsmEptjCWq0z2VftFVRxM4o+PTU0I1x01rUcRvUog9lGF9YyZeAvcxYAU4Eij64siFkJYRMhr3MStMl2iQyG2Z1vGqfobnZUoryhDcI8szycqvw2bvcBSUB8HshnEZNCyro80JD5Su/4hvw8jZpZUCdpSW0Mvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vVHuFZ6T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5yOwn8Wd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vVHuFZ6T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5yOwn8Wd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vVHuFZ6T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5yOwn8Wd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vVHuFZ6T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5yOwn8Wd"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09F4B23A0E;
	Mon,  8 Sep 2025 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757335512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o/phBBca+BcSZcgqMkeF3dcpXMArooCkey/CEsPn6WY=;
	b=vVHuFZ6TN2Em/sqoaULD9+kf8EDac5JvDGG7gyjppSuBPVP97yGo85rY/noGNBP1XvE69q
	7GmxLr/C9Y4XF52DGxZ4xoEQtuhMzQAYsNzWAszqRLQd1WNpMg1vBsaivg+vvuXxKsJ7op
	8Cc5+4uOr5iU8WHjdu1FBRLtUVJPz6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757335512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o/phBBca+BcSZcgqMkeF3dcpXMArooCkey/CEsPn6WY=;
	b=5yOwn8Wdga33Xzc5xin3PE2AgE2QWxw3GTSHMJJkJ945WAHx1OJ38zcZYldkXszcduDb9K
	jdtMUzeXhMMVhsAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vVHuFZ6T;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5yOwn8Wd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757335512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o/phBBca+BcSZcgqMkeF3dcpXMArooCkey/CEsPn6WY=;
	b=vVHuFZ6TN2Em/sqoaULD9+kf8EDac5JvDGG7gyjppSuBPVP97yGo85rY/noGNBP1XvE69q
	7GmxLr/C9Y4XF52DGxZ4xoEQtuhMzQAYsNzWAszqRLQd1WNpMg1vBsaivg+vvuXxKsJ7op
	8Cc5+4uOr5iU8WHjdu1FBRLtUVJPz6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757335512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o/phBBca+BcSZcgqMkeF3dcpXMArooCkey/CEsPn6WY=;
	b=5yOwn8Wdga33Xzc5xin3PE2AgE2QWxw3GTSHMJJkJ945WAHx1OJ38zcZYldkXszcduDb9K
	jdtMUzeXhMMVhsAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFCB513946;
	Mon,  8 Sep 2025 12:45:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zs9tMdfPvmiwKQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 08 Sep 2025 12:45:11 +0000
Message-ID: <6f8274da-a010-4bb3-b3d6-690481b5ace0@suse.cz>
Date: Mon, 8 Sep 2025 14:45:11 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/21] slab: add sheaf support for batching kfree_rcu()
 operations
Content-Language: en-US
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250903-slub-percpu-caches-v7-0-71c114cdefef@suse.cz>
 <20250903-slub-percpu-caches-v7-4-71c114cdefef@suse.cz>
 <aL7FFpIMmXtzzSL1@pc638.lan>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aL7FFpIMmXtzzSL1@pc638.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 09F4B23A0E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 9/8/25 13:59, Uladzislau Rezki wrote:
> On Wed, Sep 03, 2025 at 02:59:46PM +0200, Vlastimil Babka wrote:
>> Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
>> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
>> addition to main and spare sheaves.
>> 
>> kfree_rcu() operations will try to put objects on this sheaf. Once full,
>> the sheaf is detached and submitted to call_rcu() with a handler that
>> will try to put it in the barn, or flush to slab pages using bulk free,
>> when the barn is full. Then a new empty sheaf must be obtained to put
>> more objects there.
>> 
>> It's possible that no free sheaves are available to use for a new
>> rcu_free sheaf, and the allocation in kfree_rcu() context can only use
>> GFP_NOWAIT and thus may fail. In that case, fall back to the existing
>> kfree_rcu() implementation.
>> 
>> Expected advantages:
>> - batching the kfree_rcu() operations, that could eventually replace the
>>   existing batching
>> - sheaves can be reused for allocations via barn instead of being
>>   flushed to slabs, which is more efficient
>>   - this includes cases where only some cpus are allowed to process rcu
>>     callbacks (Android)
>> 
>> Possible disadvantage:
>> - objects might be waiting for more than their grace period (it is
>>   determined by the last object freed into the sheaf), increasing memory
>>   usage - but the existing batching does that too.
>> 
>> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
>> implementation favors smaller memory footprint over performance.
>> 
>> Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fail to
>> count how many kfree_rcu() used the rcu_free sheaf successfully and how
>> many had to fall back to the existing implementation.
>> 
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slab.h        |   2 +
>>  mm/slab_common.c |  24 +++++++
>>  mm/slub.c        | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  3 files changed, 216 insertions(+), 2 deletions(-)
>> 
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 206987ce44a4d053ebe3b5e50784d2dd23822cd1..f1866f2d9b211bb0d7f24644b80ef4b50a7c3d24 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -435,6 +435,8 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
>>  	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
>>  }
>>  
>> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
>> +
>>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>>  			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
>>  			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index e2b197e47866c30acdbd1fee4159f262a751c5a7..2d806e02568532a1000fd3912db6978e945dcfa8 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1608,6 +1608,27 @@ static void kfree_rcu_work(struct work_struct *work)
>>  		kvfree_rcu_list(head);
>>  }
>>  
>> +static bool kfree_rcu_sheaf(void *obj)
>> +{
>> +	struct kmem_cache *s;
>> +	struct folio *folio;
>> +	struct slab *slab;
>> +
>> +	if (is_vmalloc_addr(obj))
>> +		return false;
>> +
>> +	folio = virt_to_folio(obj);
>> +	if (unlikely(!folio_test_slab(folio)))
>> +		return false;
>> +
>> +	slab = folio_slab(folio);
>> +	s = slab->slab_cache;
>> +	if (s->cpu_sheaves)
>> +		return __kfree_rcu_sheaf(s, obj);
>> +
>> +	return false;
>> +}
>> +
>>  static bool
>>  need_offload_krc(struct kfree_rcu_cpu *krcp)
>>  {
>> @@ -1952,6 +1973,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>>  	if (!head)
>>  		might_sleep();
>>  
>> +	if (kfree_rcu_sheaf(ptr))
>> +		return;
>> +
> Uh.. I have some concerns about this.
> 
> This patch introduces a new path which is a collision to the
> existing kvfree_rcu() logic. It implements some batching which
> we already have.

Yes but for caches with sheaves it's better to recycle the whole sheaf (as
described), which is so different from the existing batching scheme that I'm
not sure if there's a sensible way to combine them.

> - kvfree_rcu_barrier() does not know about "sheaf" path. Am i missing
>   something? How do you guarantee that kvfree_rcu_barrier() flushes
>   sheafs? If it is part of kvfree_rcu() it has to care about this.

Hm good point, thanks. I've taken care of handling flushing related to
kfree_rcu() sheaves in kmem_cache_destroy(), but forgot that
kvfree_rcu_barrier() can be also used outside of that - we have one user in
codetag_unload_module() currently.

> - we do not allocate in kvfree_rcu() path because of PREEMMPT_RT, i.e.
>   kvfree_rcu() is supposed it can be called from the non-sleeping contexts.

Hm I could not find where that distinction is in the code, can you give a
hint please. In __kfree_rcu_sheaf() I do only have a GFP_NOWAIT attempt.

> - call_rcu() can be slow, therefore we do not use it in the kvfree_rcu().

If call_rcu() is called once per 32 kfree_rcu() filling up the rcu sheaf, is
it still too slow?
> IMO, it is worth to reuse existing logic in the kvfree_rcu(). I can help
> with it when i have more cycles as part of my RCU work.
It would be most welcome! I'd suggest we currently proceed with this after I
fix up kvfree_rcu_barrier(), and can attempt to consolidate later.

> --
> Uladzislau Rezki

