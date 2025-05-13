Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461C1C8632
	for <rcu@vger.kernel.org>; Tue, 13 May 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152515; cv=none; b=cBpBySj1mV//z1azd0e1CyZZx2vxsEu7C1DZXCgvbayszdKP42wHHWIp3F1S15oIAsVKzds7LQX+ArVV/GNQewgf0fYDcVJyqVlWresfnV/iQgU8mR7K1zrRMXkZoccoWUyZK4OaEPP4kt+uyCqTuC6+mDX5JvEM2Yf8XiS0joo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152515; c=relaxed/simple;
	bh=/Vb4sd+3hcM5Me2MdG5VzqnOvvov6MQZnukrsT0Iuac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTQ6uMTudIz18kOycLN7N9Zya35xkTHzxn+6X+YKrm1ShW/L2tWHcuEvKs1Zaq5mqe4TR/ZuTDGZ96FvgCBNWDgF9P80tI9/ZQQdR68WviI2NyjaaMgE1jOcPZ+EHAtC1Q8XUg657DMSLZ9HHh0Dt3uYLagWzSDaicxGBvclfac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cQgcxTg+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O4Etl99W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cQgcxTg+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O4Etl99W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cQgcxTg+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O4Etl99W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cQgcxTg+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O4Etl99W"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FCE0211AC;
	Tue, 13 May 2025 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747152511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBvtkgHlz5SobIfyPxIXYeeroBpFTJXa2BoBZCQAARY=;
	b=cQgcxTg+InItRrJ/Jo2FeGn2PTozXt8Vlb9Z2WsRtvbIvm0tDBXx9aLB3QR6aM4ihhltRW
	nayHZa/04MV15cc1ajIK+fNqp9oWc40qtt608ybwGErE/yP6NrlC9Zqo8m6ITlQObcfxTF
	WfBFk+mvCWGMdgi7POZjK0lZ4668P2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747152511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBvtkgHlz5SobIfyPxIXYeeroBpFTJXa2BoBZCQAARY=;
	b=O4Etl99WSKMRAFEfXcI2fqjvmTC9t+ntOo5upyppAGpQ5UADNQtgaNiR3uOq69mViVW+rl
	zzxW90OhyV812SBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747152511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBvtkgHlz5SobIfyPxIXYeeroBpFTJXa2BoBZCQAARY=;
	b=cQgcxTg+InItRrJ/Jo2FeGn2PTozXt8Vlb9Z2WsRtvbIvm0tDBXx9aLB3QR6aM4ihhltRW
	nayHZa/04MV15cc1ajIK+fNqp9oWc40qtt608ybwGErE/yP6NrlC9Zqo8m6ITlQObcfxTF
	WfBFk+mvCWGMdgi7POZjK0lZ4668P2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747152511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBvtkgHlz5SobIfyPxIXYeeroBpFTJXa2BoBZCQAARY=;
	b=O4Etl99WSKMRAFEfXcI2fqjvmTC9t+ntOo5upyppAGpQ5UADNQtgaNiR3uOq69mViVW+rl
	zzxW90OhyV812SBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 221531365D;
	Tue, 13 May 2025 16:08:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A9/SB39uI2gAFAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 May 2025 16:08:31 +0000
Message-ID: <1724b59a-0c3a-482c-b141-b5611665d1f4@suse.cz>
Date: Tue, 13 May 2025 18:08:30 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] slab: add opt-in caching layer of percpu sheaves
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
 <20250425-slub-percpu-caches-v4-1-8a636982b4a4@suse.cz>
 <aBAmi38oWka6ckjk@harry>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <aBAmi38oWka6ckjk@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:mid,suse.cz:email]
X-Spam-Score: -4.30

On 4/29/25 03:08, Harry Yoo wrote:
> On Fri, Apr 25, 2025 at 10:27:21AM +0200, Vlastimil Babka wrote:
>> Specifying a non-zero value for a new struct kmem_cache_args field
>> sheaf_capacity will setup a caching layer of percpu arrays called
>> sheaves of given capacity for the created cache.
>> 
>> Allocations from the cache will allocate via the percpu sheaves (main or
>> spare) as long as they have no NUMA node preference. Frees will also
>> put the object back into one of the sheaves.
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
>> an allocation is requested with kmem_cache_alloc_node() (or a mempolicy
>> with strict_numa mode enabled) with a specific node (not NUMA_NO_NODE),
>> the sheaves are bypassed.
>> 
>> The bulk operations exposed to slab users also try to utilize the
>> sheaves as long as the necessary (full or empty) sheaves are available
>> on the cpu or in the barn. Once depleted, they will fallback to bulk
>> alloc/free to slabs directly to avoid double copying.
>> 
>> The sheaf_capacity value is exported in sysfs for observability.
>> 
>> Sysfs CONFIG_SLUB_STATS counters alloc_cpu_sheaf and free_cpu_sheaf
>> count objects allocated or freed using the sheaves (and thus not
>> counting towards the other alloc/free path counters). Counters
>> sheaf_refill and sheaf_flush count objects filled or flushed from or to
>> slab pages, and can be used to assess how effective the caching is. The
>> refill and flush operations will also count towards the usual
>> alloc_fastpath/slowpath, free_fastpath/slowpath and other counters for
>> the backing slabs.  For barn operations, barn_get and barn_put count how
>> many full sheaves were get from or put to the barn, the _fail variants
>> count how many such requests could not be satisfied mainly  because the
>> barn was either empty or full.
> 
>> While the barn also holds empty sheaves
>> to make some operations easier, these are not as critical to mandate own
>> counters.  Finally, there are sheaf_alloc/sheaf_free counters.
> 
> I initially thought we need counters for empty sheaves to see how many times
> it grabs empty sheaves from the barn, but looks like barn_put
> ("put full sheaves to the barn") is effectively a proxy for that, right?

Mostly yes, the free sheaves in barn is mainly to make the "replace full
with empty" easy, but if that fails because there's no empty sheaves, the
fallback with allocating an empty sheaf should still be successful enough
that tracking it in detail doesn't seem that useful.

>> Access to the percpu sheaves is protected by local_trylock() when
>> potential callers include irq context, and local_lock() otherwise (such
>> as when we already know the gfp flags allow blocking). The trylock
>> failures should be rare and we can easily fallback. Each per-NUMA-node
>> barn has a spin_lock.
>> 
>> When slub_debug is enabled for a cache with sheaf_capacity also
>> specified, the latter is ignored so that allocations and frees reach the
>> slow path where debugging hooks are processed.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Thanks!

> LGTM, with a few nits:

I've applied them, thanks. Responding only to one that needs it:

>> +static __fastpath_inline
>> +bool free_to_pcs(struct kmem_cache *s, void *object)
>> +{
>> +	struct slub_percpu_sheaves *pcs;
>> +
>> +restart:
>> +	if (!local_trylock(&s->cpu_sheaves->lock))
>> +		return false;
>> +
>> +	pcs = this_cpu_ptr(s->cpu_sheaves);
>> +
>> +	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
>> +
>> +		struct slab_sheaf *empty;
>> +
>> +		if (!pcs->spare) {
>> +			empty = barn_get_empty_sheaf(pcs->barn);
>> +			if (empty) {
>> +				pcs->spare = pcs->main;
>> +				pcs->main = empty;
>> +				goto do_free;
>> +			}
>> +			goto alloc_empty;
>> +		}
>> +
>> +		if (pcs->spare->size < s->sheaf_capacity) {
>> +			swap(pcs->main, pcs->spare);
>> +			goto do_free;
>> +		}
>> +
>> +		empty = barn_replace_full_sheaf(pcs->barn, pcs->main);
>> +
>> +		if (!IS_ERR(empty)) {
>> +			stat(s, BARN_PUT);
>> +			pcs->main = empty;
>> +			goto do_free;
>> +		}
> 
> nit: stat(s, BARN_PUT_FAIL); should probably be here instead?

Hm, the intention was that no, because when PTR_ERR(empty) == -ENOMEM, we
try alloc_empty_sheaf(), and that will likely succeed, and then
__pcs_install_empty_sheaf() will just force the put full sheaf (and record a
BARN_PUT), because we already saw that we're not over capacity. But now I
see I didn't describe it as a scenario for the function's comment, so I will
add that.

But technically we should also record stat(s, BARN_PUT_FAIL) when that
alloc_empty_sheaf() fails, but not when we "goto alloc_empty" from the "no
spare" above. Bit icky but I'll add that too.

>> +
>> +		if (PTR_ERR(empty) == -E2BIG) {
>> +			/* Since we got here, spare exists and is full */
>> +			struct slab_sheaf *to_flush = pcs->spare;
>> +
>> +			stat(s, BARN_PUT_FAIL);
>> +
>> +			pcs->spare = NULL;
>> +			local_unlock(&s->cpu_sheaves->lock);
>> +
>> +			sheaf_flush_unused(s, to_flush);
>> +			empty = to_flush;
>> +			goto got_empty;
>> +		}
> 


