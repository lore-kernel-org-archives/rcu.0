Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260231195C
	for <rcu@vger.kernel.org>; Mon, 27 Apr 2026 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297993; cv=none; b=B3kwpmCLTu2sPtFga1RaEuoQ1DFNwfDErcRDs8xSwqy8rUXjj8ZtBg32lnJrzV5IDSi2vB3BrxUFs+zgiAb0hI+457AQ67oTiVzNpHZMJjtNreHtteUilmdmlt50C+v/utgqSrTHxenBLzX037C61I9Fbk5CwKv0G07ZOd7X97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297993; c=relaxed/simple;
	bh=ddHWZll+/l4Y6yaG2N+pebqPLgYmW4+I+mmivss745w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MBgLsOiYcjIdXkwOW2BTWd4k65rewA2m5J2cJfArw13adlao2tcLil/BsROJzKK+3VCvgxbUvml4t68mL/7KIiaU37Gl+s5UPGLYeOcvGN15TP+Avf+KG9lOnSaX10EgpD7Jad2dcvZQIY9Oh7UFq148svuwcyqgYmEu738leXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwi/JY4+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwi/JY4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FE2C19425;
	Mon, 27 Apr 2026 13:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297993;
	bh=ddHWZll+/l4Y6yaG2N+pebqPLgYmW4+I+mmivss745w=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=hwi/JY4+SVHsumZdfuyjG7FZ7O8Eo+BNs44kEekYy41QrAVPXqAnDJRUG910W3o4O
	 K2rPCo25lUdTtRJkcVHi2fKwBuOAR8hCcBCiqC+wgcSKXC6dkP/EtEEwdHsQBz4abc
	 AATXAkKXtKhKtOcc6cPwhjTHxrRf+4Xf3pCd0m8tJnTRrxJ+tgXUCGyfyGK3b7foUw
	 rwbh0BuBbQFePyJYlLBQKCZJtJLbJ2g/ZF6Lk6LayixQIaA0CrORNNggdxVnj4zWH9
	 h/FPbIbRPCK+w5bFjMstGP5PIL+NPCzUDwYupDuym3f5EjbjLHXwe0O0O27PdmWx9R
	 Jg8ujmmuTPgTg==
Message-ID: <7101d55e-ba43-4df9-a345-2af579f8e940@kernel.org>
Date: Mon, 27 Apr 2026 15:53:07 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] mm/slab: make kfree_rcu_nolock() work with sheaves
Content-Language: en-US
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
To: "Harry Yoo (Oracle)" <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Zqiang <qiang.zhang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
 linux-mm@kvack.org
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-6-harry@kernel.org>
 <56381493-214b-406d-9121-f80be7658445@kernel.org>
In-Reply-To: <56381493-214b-406d-9121-f80be7658445@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/26 15:32, Vlastimil Babka (SUSE) wrote:
> On 4/16/26 11:10, Harry Yoo (Oracle) wrote:
>> @@ -2111,8 +2111,7 @@ void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr, bool allow_spin)
>>  				IS_ENABLED(CONFIG_DEBUG_KMEMLEAK)))
>>  		goto defer_free;
>>  
>> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
>> -			(allow_spin && kfree_rcu_sheaf(ptr)))
>> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr, allow_spin))
>>  		return;
> 
> I wonder if this patch is enough to drop (or reduce a lot) the PREEMPT_RT
> incompatibility? It IIRC came from Ulad's review point [1] that since RT
> spinlock is in fact a mutex, it's not unsafe to take it with e.g. disabled
> preemption, and it's also why kfree_rcu_cpu uses a raw_spin_lock_t, etc.
> 
> But with kfree_rcu_sheaf now having allow_spin parameter and only doing a
> trylock at most with that false, it should now be safe to allow it for
> CONFIG_PREEMPT_RT, only pass allow_spin = false unconditionally there?

Oh I forgot about...

> [1] https://lore.kernel.org/all/aL_uhPtztx7Ef0T2@pc636/
> 
>>  
>>  	// Queue the object but don't yet schedule the batch.
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 6f658ec00751..d0db8d070570 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -5895,7 +5895,7 @@ static void rcu_free_sheaf(struct rcu_head *head)
>>   */
>>  static DEFINE_WAIT_OVERRIDE_MAP(kfree_rcu_sheaf_map, LD_WAIT_CONFIG);
>>  
>> -bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
>>  {
>>  	struct slub_percpu_sheaves *pcs;
>>  	struct slab_sheaf *rcu_sheaf;
>> @@ -5933,7 +5933,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>>  			goto fail;
>>  		}
>>  
>> -		empty = barn_get_empty_sheaf(barn, true);
>> +		empty = barn_get_empty_sheaf(barn, allow_spin);
>>  
>>  		if (empty) {
>>  			pcs->rcu_free = empty;
>> @@ -5942,6 +5942,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>>  
>>  		local_unlock(&s->cpu_sheaves->lock);
>>  
>> +		/* It's easier to fall back than trying harder with !allow_spin */
>> +		if (!allow_spin)
>> +			goto fail;
>> +
>>  		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
>>  
>>  		if (!empty)
>> @@ -5973,6 +5977,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>>  	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
>>  		rcu_sheaf = NULL;
>>  	} else {
>> +		if (unlikely(!allow_spin)) {
>> +			/* call_rcu() cannot be called in an unknown context */
>> +			rcu_sheaf->size--;
>> +			local_unlock(&s->cpu_sheaves->lock);
>> +			goto fail;
>> +		}

... this part, so an unconditional allow_spin=false on RT would only fill
the rcu_sheaf once and then stop working.

However, can we condition this on in_nmi() or something, and pretend the
other cases of "unknown context" exist? Installing BPF hooks
allocating/freeing memory into call_rcu() internals sounds crazy, no?

>>  		pcs->rcu_free = NULL;
>>  		rcu_sheaf->node = numa_node_id();
>>  	}
> 

