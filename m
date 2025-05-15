Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA99284672
	for <rcu@vger.kernel.org>; Thu, 15 May 2025 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298503; cv=none; b=olY2p2gtHjpkuepoOMCQHyE+V2Wcx/6MnMRV1Kap/m/vjXFxTjKX3QzAen/OXcA7+hi2daoZIweBevSg9t/umDxdjQ61pSGTeiNPecLCzDAGj3t6gtR7d7D4mQ+VSHsXBrtmokzKNRDuUSp0ISgQlhof2yrklpNiarec/vxOUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298503; c=relaxed/simple;
	bh=JzBQa2+ENO/AX++PutUdUaOZREFdFb61zSEmCQ5WgdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJOddFxuvUbwo8ziPoXtF7ycKHQZYbwkTA3DUEUfs0lujAIBuCrmfUfPvtZdP1VhZAaN1rf+m46UWQgtdeNHJWlsVLz2IldowtWgz5d3qj6GqV2N2DcmIRnvWHml4AicUChWcXXsWNpZRkUQnAKA422ZHe06qwBi6ujXOkryBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cNPkKacg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0jZJW7Ko; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rfoEs13/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sqKh1Lqk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cNPkKacg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0jZJW7Ko";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rfoEs13/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sqKh1Lqk"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8C79211B5;
	Thu, 15 May 2025 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747298499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hds4IGkoceQaeUi/wJBpSLkCnk5XKktfUCvS0xFhBvI=;
	b=cNPkKacgAEltoTCy75IKkvQ8gn9mxFgaCHogP9vwBd4tbvzOT+dXzC9EZJNWYU8vCC4n/Y
	vNbyP1nVVf4udiu4dtIaFcW8+HLLxZFuvHQBDsbWe+E5HfCDNpYiDE7CqdHva4ZDeazoLR
	9pUn+htNTbZ4cSQp64uojLl2RxoTvPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747298499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hds4IGkoceQaeUi/wJBpSLkCnk5XKktfUCvS0xFhBvI=;
	b=0jZJW7KoUXa09MI6NueejmYgX9UqkFlQYSSN1Jzgsun6z2KxJalgt3L4kTE6PFe6kVO5i4
	bZguB3Bk+RQ577Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="rfoEs13/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sqKh1Lqk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747298497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hds4IGkoceQaeUi/wJBpSLkCnk5XKktfUCvS0xFhBvI=;
	b=rfoEs13/ATXNW3sCjEkaCwybAGskmpNUW+rfPueuikQ9rlDzmjM94YzKRchthxxScYdF6V
	Qnb9VtArXSBfzY26bWbAOjM6YLPbH5yqRvCksizjKwe174Keej60MFBvn68OKX6yZJ0PrW
	pz1ISFCV41Tf+mULqY1kxuQNnkVoPss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747298497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hds4IGkoceQaeUi/wJBpSLkCnk5XKktfUCvS0xFhBvI=;
	b=sqKh1Lqk1YSrQrfpb4SZEA2EE+mDrNso3Md3R01GDWr4KfSND3iyBqoCl9SaVN8NryVuBK
	TKI9Lnzu6Wxh50DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9265E137E8;
	Thu, 15 May 2025 08:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FEpuI8GoJWjUPQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 May 2025 08:41:37 +0000
Message-ID: <488fa28f-e778-4ca2-a171-dba32abaab21@suse.cz>
Date: Thu, 15 May 2025 10:41:37 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] slab: sheaf prefilling for guaranteed allocations
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
 <20250425-slub-percpu-caches-v4-3-8a636982b4a4@suse.cz>
 <aBsktvf4VjQfXGST@harry>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <aBsktvf4VjQfXGST@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A8C79211B5
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email]
X-Rspamd-Action: no action

On 5/7/25 11:15, Harry Yoo wrote:
> On Fri, Apr 25, 2025 at 10:27:23AM +0200, Vlastimil Babka wrote:
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
>> sheaf_capacity, but it is not efficient - such "oversize" sheaves are
>> allocated fresh in kmem_cache_prefill_sheaf() and flushed and freed
>> immediately by kmem_cache_return_sheaf(). kmem_cache_refill_sheaf()
>> might be especially ineffective when replacing a sheaf with a new one of
>> a larger capacity. It is therefore better to size cache's
>> sheaf_capacity accordingly to make oversize sheaves exceptional.
>> 
>> CONFIG_SLUB_STATS counters are added for sheaf prefill and return
>> operations. A prefill or return is considered _fast when it is able to
>> grab or return a percpu spare sheaf (even if the sheaf needs a refill to
>> satisfy the request, as those should amortize over time), and _slow
>> otherwise (when the barn or even sheaf allocation/freeing has to be
>> involved). sheaf_prefill_oversize is provided to determine how many
>> prefills were oversize (counter for oversize returns is not necessary as
>> all oversize refills result in oversize returns).
>> 
>> When slub_debug is enabled for a cache with sheaves, no percpu sheaves
>> exist for it, but the prefill functionality is still provided simply by
>> all prefilled sheaves becoming oversize. If percpu sheaves are not
>> created for a cache due to not passing the sheaf_capacity argument on
>> cache creation, the prefills also work through oversize sheaves, but
>> there's a WARN_ON_ONCE() to indicate the omission.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>> ---
> 
> Looks good to me,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> with a nit below.

Thanks, incorporated the suggestion!

