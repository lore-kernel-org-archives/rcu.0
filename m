Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44B524EAA3
	for <rcu@vger.kernel.org>; Thu,  3 Apr 2025 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689487; cv=none; b=dL6IvwpW/tKp2KDXEjfCGVwX0eN4dOqHRSOTM+dosYSYfhtKhbGZSVoQVWdpXZjcFxHFkzw4fL8GaRxvfLB6oFt8JRTRgxNOYxG/JfIzlQB5SAoNwaQ1DdaLpd21C4k5W9odq4fjcnwvfAYBjP/b5yG4GfRyiAyJsUJYghHXFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689487; c=relaxed/simple;
	bh=+WKjDzZj9IcTEhtSM9Sb8z9iwCc0GDB+JKmfQKdnd5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3t+CTKSxYdVlCF+7sGznozUovipOlXPPBPR7XfdUduAWGUtc7xHEnDYYqCjv0nkx2F8xZd335CDg9ED229NWeOBqQh5ZxtPALN0jaJnQrNSKYACZVE07v70prrCZ2b7MhYrb3jjxtGdLFfUPO9E+3VnNYIiThKzDOx1U0V78oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2l64JBxQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kuc3/WQF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2l64JBxQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kuc3/WQF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2l64JBxQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kuc3/WQF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2l64JBxQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kuc3/WQF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CC531F390;
	Thu,  3 Apr 2025 14:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743689483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpKQJ1DZO4HDvv1M1OG+goh5mFQUpBNjEB6oS1DI/0Q=;
	b=2l64JBxQfvX4U/Pp4BW677aGlOZFcFy558f1v4eM7STMGl4vU5EZgf6o/rUzVISL4dTOdM
	X9WU/TYp6wuEYYRR26b0W2ZbsYy0u4arRo62Zlxs8sHm9kP8yp2UzYqU0SRnkUx+Nclxj7
	f/Ye8MhAcsCShLTkVMbXJqFfKB0l1Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743689483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpKQJ1DZO4HDvv1M1OG+goh5mFQUpBNjEB6oS1DI/0Q=;
	b=kuc3/WQFmJXoAHMkRqgoLcY32DnurrQeMaYlD45gyuqrLCeQQXdZHwfSSHVm2BYzGYXpOW
	F50N78k+LmAhtQAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743689483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpKQJ1DZO4HDvv1M1OG+goh5mFQUpBNjEB6oS1DI/0Q=;
	b=2l64JBxQfvX4U/Pp4BW677aGlOZFcFy558f1v4eM7STMGl4vU5EZgf6o/rUzVISL4dTOdM
	X9WU/TYp6wuEYYRR26b0W2ZbsYy0u4arRo62Zlxs8sHm9kP8yp2UzYqU0SRnkUx+Nclxj7
	f/Ye8MhAcsCShLTkVMbXJqFfKB0l1Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743689483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpKQJ1DZO4HDvv1M1OG+goh5mFQUpBNjEB6oS1DI/0Q=;
	b=kuc3/WQFmJXoAHMkRqgoLcY32DnurrQeMaYlD45gyuqrLCeQQXdZHwfSSHVm2BYzGYXpOW
	F50N78k+LmAhtQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E55081392A;
	Thu,  3 Apr 2025 14:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gOGZNwqX7mePUAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 03 Apr 2025 14:11:22 +0000
Message-ID: <81ffcfee-8f18-4392-a9ce-ff3f60f7b5b1@suse.cz>
Date: Thu, 3 Apr 2025 16:11:22 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 2/8] slab: add opt-in caching layer of percpu
 sheaves
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
 <20250317-slub-percpu-caches-v3-2-9d9884d8b643@suse.cz>
 <Z-5HWApFjrOr7Q8_@harry>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z-5HWApFjrOr7Q8_@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 4/3/25 10:31, Harry Yoo wrote:
>> +/*
>> + * Bulk free objects to the percpu sheaves.
>> + * Unlike free_to_pcs() this includes the calls to all necessary hooks
>> + * and the fallback to freeing to slab pages.
>> + */
>> +static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>> +{
> 
> [...snip...]
> 
>> +next_batch:
>> +	if (!localtry_trylock(&s->cpu_sheaves->lock))
>> +		goto fallback;
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
>> +			goto no_empty;
> 
> Maybe a silly question, but if neither of alloc_from_pcs_bulk() or
> free_to_pcs_bulk() allocates empty sheaves (and sometimes put empty or full
> sheaves in the barn), you should expect usually sheaves not to be in the barn
> when using bulk interfces?

Hm maybe, but with patch 5/8 it becomes cheap to check? And there might be
caches mixing both bulk and individual allocs?
But maybe I should at least add the free sheaf alloc with GFP_NOWAIT attempt
to bulk free? Can't recall if I missed it intentionally or forgot.

>> -static void
>> -init_kmem_cache_node(struct kmem_cache_node *n)
>> +static bool
>> +init_kmem_cache_node(struct kmem_cache_node *n, struct node_barn *barn)
>>  {
> 
> Why is the return type bool, when it always succeeds?

I guess leftover from earlier versions. Will fix.

>> @@ -5421,20 +6295,27 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
>>  
>>  	for_each_node_mask(node, slab_nodes) {
>>  		struct kmem_cache_node *n;
>> +		struct node_barn *barn = NULL;
>>  
>>  		if (slab_state == DOWN) {
>>  			early_kmem_cache_node_alloc(node);
>>  			continue;
>>  		}
>> +
>> +		if (s->cpu_sheaves) {
>> +			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, node);
>> +
>> +			if (!barn)
>> +				return 0;
>> +		}
>> +
>>  		n = kmem_cache_alloc_node(kmem_cache_node,
>>  						GFP_KERNEL, node);
>> -
>> -		if (!n) {
>> -			free_kmem_cache_nodes(s);
>> +		if (!n)
>>  			return 0;
>> -		}
> 
> Looks like it's leaking the barn
> if the allocation of kmem_cache_node fails?

Oops right, will add kfree(barn) before return 0;

> 
>> -		init_kmem_cache_node(n);
>> +		init_kmem_cache_node(n, barn);
>> +
>>  		s->node[node] = n;
>>  	}
>>  	return 1;
>> @@ -6005,12 +6891,24 @@ static int slab_mem_going_online_callback(void *arg)
>>  	 */
>>  	mutex_lock(&slab_mutex);
>>  	list_for_each_entry(s, &slab_caches, list) {
>> +		struct node_barn *barn = NULL;
>> +
>>  		/*
>>  		 * The structure may already exist if the node was previously
>>  		 * onlined and offlined.
>>  		 */
>>  		if (get_node(s, nid))
>>  			continue;
>> +
>> +		if (s->cpu_sheaves) {
>> +			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, nid);
>> +
>> +			if (!barn) {
>> +				ret = -ENOMEM;
>> +				goto out;
>> +			}
>> +		}
>> +
> 
> Ditto.
> 
> Otherwise looks good to me :)

Thanks a lot!

