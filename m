Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9285C262D27
	for <rcu@vger.kernel.org>; Wed, 14 May 2025 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747228056; cv=none; b=CqdTe7wGe1eD8f4zKNlAvWrU/O/nHEOHpnxmOI10jESm4lVxtM0Ocong4NiSI1V3f0G0VkIkVFKTL2ZV6NSty1qJKd1uUqschcHr88uxaawB6Qt61sqCc8LvlCvuYPICs9IRYtCigUf4Ksl9/VfKqf7giKH2Alnli1oH6R0UYJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747228056; c=relaxed/simple;
	bh=bv4wnR43yZjD7sDoP2+HWoWv3eMcivkQlLouMnQHFNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKbFb92EZ85UyC71/im1endE3uVTdFZBWrHblEVqamEb92USyAPBGUo/OD64YYRT078j52M9YHs5VgNqmsaXkSO3LBpcLX+7e0+EwFXZGQkQ56A8xvvYJA76+y5AlhkRFjAHqWH/ECOPB3+hg2Jd0LY4B0HRH/iaKhQ2RTM/o5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X9cDcykG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NapuXXhH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X9cDcykG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NapuXXhH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X9cDcykG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NapuXXhH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X9cDcykG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NapuXXhH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9FA01F393;
	Wed, 14 May 2025 13:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747228052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTevUoX1NJ86upLyJVVYXZfr97nb3JES0EX6Dz2Mnio=;
	b=X9cDcykGfbu+gNwgzknPZbrouKsVTC3LaMBQka+T9chfiUl8i/I8XW+ULnzosyQQnIaUYH
	nR6Ksxe424xmq5kuCdiaRS3m3uQSJ7Nxymedb5DlxW8eQXBjn00fM/0J95RNRGuASYV2/q
	tmCF4tWzzcNsnV3s3Nke4d4eey1QK7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747228052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTevUoX1NJ86upLyJVVYXZfr97nb3JES0EX6Dz2Mnio=;
	b=NapuXXhH2L4gtzp0cy/t6W3tRvxuLVoYqMEcyxzS0I6Doy3V3EpP0MFXYwOQmb+UTbo/x+
	Odcwvl7xqejZfaBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X9cDcykG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NapuXXhH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747228052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTevUoX1NJ86upLyJVVYXZfr97nb3JES0EX6Dz2Mnio=;
	b=X9cDcykGfbu+gNwgzknPZbrouKsVTC3LaMBQka+T9chfiUl8i/I8XW+ULnzosyQQnIaUYH
	nR6Ksxe424xmq5kuCdiaRS3m3uQSJ7Nxymedb5DlxW8eQXBjn00fM/0J95RNRGuASYV2/q
	tmCF4tWzzcNsnV3s3Nke4d4eey1QK7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747228052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTevUoX1NJ86upLyJVVYXZfr97nb3JES0EX6Dz2Mnio=;
	b=NapuXXhH2L4gtzp0cy/t6W3tRvxuLVoYqMEcyxzS0I6Doy3V3EpP0MFXYwOQmb+UTbo/x+
	Odcwvl7xqejZfaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D22E137E8;
	Wed, 14 May 2025 13:07:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wnInIpSVJGj7dQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 14 May 2025 13:07:32 +0000
Message-ID: <505bfde6-6338-4747-b29f-0e80d6fa8fff@suse.cz>
Date: Wed, 14 May 2025 15:07:32 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] slab: add sheaf support for batching kfree_rcu()
 operations
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
 <20250425-slub-percpu-caches-v4-2-8a636982b4a4@suse.cz>
 <aBCBblup5P1F8SPE@harry>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <aBCBblup5P1F8SPE@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A9FA01F393
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.cz:mid,oracle.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:email,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Action: no action

On 4/29/25 09:36, Harry Yoo wrote:
> On Fri, Apr 25, 2025 at 10:27:22AM +0200, Vlastimil Babka wrote:
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
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
> 
> Looks good to me,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Thanks!

> 
>> +/* Legal flag mask for kmem_cache_create(), for various configurations */
> 
> nit: I think now this line should be removed?

Yeah looks like rebasing mistake. Removed.

>>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>>  			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
>>  			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 4f295bdd2d42355af6311a799955301005f8a532..6c3b90f03cb79b57f426824450f576a977d85c53 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> diff --git a/mm/slub.c b/mm/slub.c
>> index ae3e80ad9926ca15601eef2f2aa016ca059498f8..6f31a27b5d47fa6621fa8af6d6842564077d4b60 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -5304,6 +5340,140 @@ bool free_to_pcs(struct kmem_cache *s, void *object)
>>  	return true;
>>  }
>>  
>> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>> +{
>> +	struct slub_percpu_sheaves *pcs;
>> +	struct slab_sheaf *rcu_sheaf;
>> +
>> +	if (!local_trylock(&s->cpu_sheaves->lock))
>> +		goto fail;
>> +
>> +	pcs = this_cpu_ptr(s->cpu_sheaves);
>> +
>> +	if (unlikely(!pcs->rcu_free)) {
>> +
>> +		struct slab_sheaf *empty;
> 
> nit: should we grab the spare sheaf here if it's empty?

Hmm yeah why not. But only completely empty. Done, thanks!

>> +
>> +		empty = barn_get_empty_sheaf(pcs->barn);
>> +
>> +		if (empty) {
>> +			pcs->rcu_free = empty;
>> +			goto do_free;
>> +		}
>> +
>> +		local_unlock(&s->cpu_sheaves->lock);
>> +
>> +		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
>> +
>> +		if (!empty)
>> +			goto fail;
>> +
>>  /*
>>   * Bulk free objects to the percpu sheaves.
>>   * Unlike free_to_pcs() this includes the calls to all necessary hooks
> 

