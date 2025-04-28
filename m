Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A71D61BB
	for <rcu@vger.kernel.org>; Mon, 28 Apr 2025 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823712; cv=none; b=XuLzvokoDDsYaDfMs9lX5VblL1+nO+UVBLKG9mutcshe9qZ7/HZ3gB9rd70aksfKMo6YGXKH33Y8VEoY0jSwehy5DqWD1XifUuNDbCVXs4XY5Nr9HlgRRI07HGIN6qcCfagrai3MxSsKpSoJqQ8WHzKzztdopNVIOHv8He7GlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823712; c=relaxed/simple;
	bh=oZBGe1irBmAZaO+efVPFdw0u5u4zvszkuEImQm3qr+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEnwV2G4m0vNRBB7U0Bf0QRFZrP8PR2F+0oGuCkKetAWmXDWBs1sK1J97u1dddyhU6Iurb26gMgtJlLzc5SbXxl4uFv2rR7wFBv3pc8yiU7kBTtuOk7i3vcMCdhX3KMt4wVJses62PMzwvhGFChMBuHJYIFQ7dvsK92PsnwWESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMZKVwRA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=smwrEnXw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMZKVwRA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=smwrEnXw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMZKVwRA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="smwrEnXw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMZKVwRA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="smwrEnXw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2DDC21244;
	Mon, 28 Apr 2025 07:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745823708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDZdfZr5HTz+mtGiFZ3mw3ndbMqIzh6pqQGl0YcDvWY=;
	b=nMZKVwRAxHrxjQ6/Q1I4K3TOehq7r3kRIrLNPi6wnX4eyEvP0OT0n8bF3U+BNQuCidrBvY
	s3kwdk/+nkFCXF2yjsyBlpn4yOlB/Q8dDRhJqwje/3hQmlwuDBmKVs7EtLNyuaek2FQfti
	ZtbVdGVTmOCxu0o5MRr+Uswcf+d94Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745823708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDZdfZr5HTz+mtGiFZ3mw3ndbMqIzh6pqQGl0YcDvWY=;
	b=smwrEnXw0HJRIB2egeRy3ZRam5DpnY+3FkLGSv0u8i3FAmH+YeJKYRS4awSfQ3fMpgjgPR
	nOsvku+s4/iL1nAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nMZKVwRA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=smwrEnXw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745823708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDZdfZr5HTz+mtGiFZ3mw3ndbMqIzh6pqQGl0YcDvWY=;
	b=nMZKVwRAxHrxjQ6/Q1I4K3TOehq7r3kRIrLNPi6wnX4eyEvP0OT0n8bF3U+BNQuCidrBvY
	s3kwdk/+nkFCXF2yjsyBlpn4yOlB/Q8dDRhJqwje/3hQmlwuDBmKVs7EtLNyuaek2FQfti
	ZtbVdGVTmOCxu0o5MRr+Uswcf+d94Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745823708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDZdfZr5HTz+mtGiFZ3mw3ndbMqIzh6pqQGl0YcDvWY=;
	b=smwrEnXw0HJRIB2egeRy3ZRam5DpnY+3FkLGSv0u8i3FAmH+YeJKYRS4awSfQ3fMpgjgPR
	nOsvku+s4/iL1nAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B28FC13A25;
	Mon, 28 Apr 2025 07:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3mCbKtwnD2g5ZAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 28 Apr 2025 07:01:48 +0000
Message-ID: <4fa1f4fb-4148-45e8-930c-1175ce212cab@suse.cz>
Date: Mon, 28 Apr 2025 09:01:48 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] slab: add opt-in caching layer of percpu sheaves
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
 <20250425-slub-percpu-caches-v4-1-8a636982b4a4@suse.cz>
 <142aeeb5-d6d8-84ca-e7a2-ba564185c565@gentwo.org>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <142aeeb5-d6d8-84ca-e7a2-ba564185c565@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D2DDC21244
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/25/25 19:31, Christoph Lameter (Ampere) wrote:
> On Fri, 25 Apr 2025, Vlastimil Babka wrote:
> 
>> @@ -4195,7 +4793,11 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
>>  	if (unlikely(object))
>>  		goto out;
>>
>> -	object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
>> +	if (s->cpu_sheaves && node == NUMA_NO_NODE)
>> +		object = alloc_from_pcs(s, gfpflags);
> 
> The node to use is determined in __slab_alloc_node() only based on the
> memory policy etc. NUMA_NO_NODE allocations can be redirected by memory
> policies and this check disables it.

To handle that, alloc_from_pcs() contains this:

#ifdef CONFIG_NUMA
        if (static_branch_unlikely(&strict_numa)) {
                if (current->mempolicy)
                        return NULL;
        }
#endif

And so there will be a fallback. It doesn't (currently) try to evaluate if
the local node is compatible as this is before taking the local lock (and
thus preventing migration).


>> @@ -4653,7 +5483,10 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>>  	memcg_slab_free_hook(s, slab, &object, 1);
>>  	alloc_tagging_slab_free_hook(s, slab, &object, 1);
>>
>> -	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), false)))
>> +	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
>> +		return;
>> +
>> +	if (!s->cpu_sheaves || !free_to_pcs(s, object))
>>  		do_slab_free(s, slab, object, object, 1, addr);
>>  }
> 
> We free to pcs even if the object is remote?
> 

