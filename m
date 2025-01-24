Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E732F224F6
	for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737728171; cv=none; b=QGidUDzPoPjp1Cx0Q2Cw5xJKakBYga02wy4xZ9ORIHZWHikzTJlaGxZAsmVLCCyfDaUnBAo57rH9eOAaHgvZShAH5o59+z7PQWoXx6c4EULTXxuEmhZcOBSiGFrJRjgUV9N+t7AztRV0w6LWM0ZGqMUro+hJ2IuZz+Jau1IMmRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737728171; c=relaxed/simple;
	bh=MuVEJ0Npv7S1E57PkAX68EMiLUtTlfCAXeJYdcq7Lo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYDFYSjfyfSDh+S/O1MKmm/ask4vg/EbCfel0XGuYeELQ3v8xsW/bd15gyO7REukDoayjjcuLhDHwWG7mo/8ZabmRS2t+EKgdwaIntXMZUvK3QO5Tfko9uVaCeSPl2QGxsGXeeM4lPsLO8+mJYvNzcPt1Om4vHDEoWdg27d3oUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sq+OxWD2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bxSvP9kH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wOtoRoiX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aNF8nRMI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sq+OxWD2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bxSvP9kH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wOtoRoiX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aNF8nRMI"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9FF321180;
	Fri, 24 Jan 2025 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737728167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/xj6Ijb7bSBcyF4sWaq+LJ/LpMvYnSGhKkKhCNpx0Uw=;
	b=Sq+OxWD2BU4acbQK8yiDLSQqldV9QcDA90nC8x1FGeFcuBGT9fPdxVXIwDkAFmHsVd95r6
	F18fzVqOo/QhbFPNK+YQABJHpmrPgBFZSmHTI9Wr29+QfzXaR1l/BscejuLSe+Mvs5BAwD
	2H8c9g1xG+X+vg3ahKHIb+G/lb+sYhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737728167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/xj6Ijb7bSBcyF4sWaq+LJ/LpMvYnSGhKkKhCNpx0Uw=;
	b=bxSvP9kHTROQv1+t2QrfIH445WQFrbimfKeVdhWMP4PP48sAi55ETpBLGwtoCqAl6A0m7m
	yI72xqlTfWv3DeBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737728165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/xj6Ijb7bSBcyF4sWaq+LJ/LpMvYnSGhKkKhCNpx0Uw=;
	b=wOtoRoiXG62tr8m+vMbHnboU4Ryg4nDM7eEAm9a2kMbJkkHg6I8fLXTKdR4gX2g772T8AG
	j5vsJQV9uB5tOIllnSpCXZTtjDG2yWtsI+sYAWucXqEK4BQbi9ah77JHgy0uzg3iW4iwav
	+jl/K7ZbESz8Dfw3iTf0RiUE/k0CW50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737728165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/xj6Ijb7bSBcyF4sWaq+LJ/LpMvYnSGhKkKhCNpx0Uw=;
	b=aNF8nRMIjS3fZPD11aZe6HK36qLTDEOhAfp/THO6M3IIVqh6/l8tVl0BrqCpnxidbntBDx
	loLj7hINZxapTABw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8416B13999;
	Fri, 24 Jan 2025 14:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C7nhH6Wgk2e7YwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 24 Jan 2025 14:16:05 +0000
Message-ID: <e8bcc4bd-3e3b-4a96-8183-4af1fbb14211@suse.cz>
Date: Fri, 24 Jan 2025 15:16:05 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/4] rcu, slab: use a regular callback function for
 kvfree_rcu
Content-Language: en-US
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu@vger.kernel.org
References: <20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz>
 <20250123-slub-tiny-kfree_rcu-v1-3-0e386ef1541a@suse.cz>
 <Z5OL_OeL8olMaeml@pc636>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z5OL_OeL8olMaeml@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,google.com,kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux-foundation.org,linux.dev,kvack.org,goodmis.org,efficios.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 1/24/25 13:47, Uladzislau Rezki wrote:
> On Thu, Jan 23, 2025 at 11:37:20AM +0100, Vlastimil Babka wrote:
>> RCU has been special-casing callback function pointers that are integers
>> lower than 4096 as offsets of rcu_head for kvfree() instead. The tree
>> RCU implementation no longer does that as the batched kvfree_rcu() is
>> not a simple call_rcu(). The tiny RCU still does, and the plan is also
>> to make tree RCU use call_rcu() for SLUB_TINY configurations.
>> 
>> Instead of teaching tree RCU again to special case the offsets, let's
>> remove the special casing completely. Since there's no SLOB anymore, it
>> is possible to create a callback function that can take a pointer to a
>> middle of slab object with unknown offset and determine the object's
>> pointer before freeing it, so implement that as kvfree_rcu_cb().
>> 
>> Large kmalloc and vmalloc allocations are handled simply by aligning
>> down to page size. For that we retain the requirement that the offset is
>> smaller than 4096. But we can remove __is_kvfree_rcu_offset() completely
>> and instead just opencode the condition in the BUILD_BUG_ON() check.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  include/linux/rcupdate.h | 24 +++++++++---------------
>>  kernel/rcu/tiny.c        | 13 -------------
>>  mm/slab.h                |  2 ++
>>  mm/slab_common.c         |  5 +----
>>  mm/slub.c                | 42 ++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 54 insertions(+), 32 deletions(-)
>> 
>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>> index 3f70d1c8144426f40553c8c589f07097ece8a706..7ff16a70ca1c0fb1012c4118388f60687c5e5b3f 100644
>> --- a/include/linux/rcupdate.h
>> +++ b/include/linux/rcupdate.h
>> @@ -1025,12 +1025,6 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>>  #define RCU_POINTER_INITIALIZER(p, v) \
>>  		.p = RCU_INITIALIZER(v)
>>  
>> -/*
>> - * Does the specified offset indicate that the corresponding rcu_head
>> - * structure can be handled by kvfree_rcu()?
>> - */
>> -#define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
>> -
>>  /**
>>   * kfree_rcu() - kfree an object after a grace period.
>>   * @ptr: pointer to kfree for double-argument invocations.
>> @@ -1041,11 +1035,11 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>>   * when they are used in a kernel module, that module must invoke the
>>   * high-latency rcu_barrier() function at module-unload time.
>>   *
>> - * The kfree_rcu() function handles this issue.  Rather than encoding a
>> - * function address in the embedded rcu_head structure, kfree_rcu() instead
>> - * encodes the offset of the rcu_head structure within the base structure.
>> - * Because the functions are not allowed in the low-order 4096 bytes of
>> - * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
>> + * The kfree_rcu() function handles this issue. In order to have a universal
>> + * callback function handling different offsets of rcu_head, the callback needs
>> + * to determine the starting address of the freed object, which can be a large
>> + * kmalloc of vmalloc allocation. To allow simply aligning the pointer down to
>> + * page boundary for those, only offsets up to 4095 bytes can be accommodated.
>>   * If the offset is larger than 4095 bytes, a compile-time error will
>>   * be generated in kvfree_rcu_arg_2(). If this error is triggered, you can
>>   * either fall back to use of call_rcu() or rearrange the structure to
>> @@ -1091,10 +1085,10 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr);
>>  do {									\
>>  	typeof (ptr) ___p = (ptr);					\
>>  									\
>> -	if (___p) {									\
>> -		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offsetof(typeof(*(ptr)), rhf)));	\
>> -		kvfree_call_rcu(&((___p)->rhf), (void *) (___p));			\
>> -	}										\
>> +	if (___p) {							\
>> +		BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >= 4096);	\
>> +		kvfree_call_rcu(&((___p)->rhf), (void *) (___p));	\
>> +	}								\
>>
> Why removing the macro? At least __is_kvfree_rcu_offset() makes it
> clear what and why + it has a nice comment what it is used for. 4096
> looks like hard-coded value.

Hmm but it's ultimately shorter. We could add a short comment to
kvfree_rcu_arg_2() referring to the longer explanation in the kfree_rcu()
comment?

> Or you do not want that someone else started to use that macro in
> another places?

And also that, since this has to be exposed in a "public" header.

>> diff --git a/mm/slab.h b/mm/slab.h
>> index e9fd9bf0bfa65b343a4ae0ecd5b4c2a325b04883..2f01c7317988ce036f0b22807403226a59f0f708 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -604,6 +604,8 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>>  			    void **p, int objects, struct slabobj_ext *obj_exts);
>>  #endif
>>  
>> +void kvfree_rcu_cb(struct rcu_head *head);
>> +
>>  size_t __ksize(const void *objp);
>>  
>>  static inline size_t slab_ksize(const struct kmem_cache *s)
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 330cdd8ebc5380090ee784c58e8ca1d1a52b3758..f13d2c901daf1419993620459fbd5845eecb85f1 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1532,9 +1532,6 @@ kvfree_rcu_list(struct rcu_head *head)
>>  		rcu_lock_acquire(&rcu_callback_map);
>>  		trace_rcu_invoke_kvfree_callback("slab", head, offset);
>>  
>> -		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
>> -			kvfree(ptr);
>> -
> This is not correct unless i miss something. Why do you remove this?

Oops, meant to remove just the warn check, and unconditionally call
kvfree(), thanks for noticing :)

The warning could really only trigger due to a use-after-free corruption of
the ptr pointer, because the BUILD_BUG_ON() would catch misuse with a too
large offset, so we don't need to keep it.

>> +void kvfree_rcu_cb(struct rcu_head *head)
>> +{
>> +	void *obj = head;
>> +	struct folio *folio;
>> +	struct slab *slab;
>> +	struct kmem_cache *s;
>> +	void *slab_addr;
>> +
>> +	if (unlikely(is_vmalloc_addr(obj))) {
>> +		obj = (void *) PAGE_ALIGN_DOWN((unsigned long)obj);
>> +		vfree(obj);
>> +		return;
>> +	}
>> +
>> +	folio = virt_to_folio(obj);
>> +	if (unlikely(!folio_test_slab(folio))) {
>> +		/*
>> +		 * rcu_head offset can be only less than page size so no need to
>> +		 * consider folio order
>> +		 */
>> +		obj = (void *) PAGE_ALIGN_DOWN((unsigned long)obj);
>> +		free_large_kmalloc(folio, obj);
>> +		return;
>> +	}
>> +
>> +	slab = folio_slab(folio);
>> +	s = slab->slab_cache;
>> +	slab_addr = folio_address(folio);
>> +
>> +	if (is_kfence_address(obj)) {
>> +		obj = kfence_object_start(obj);
>> +	} else {
>> +		unsigned int idx = __obj_to_index(s, slab_addr, obj);
>> +
>> +		obj = slab_addr + s->size * idx;
>> +		obj = fixup_red_left(s, obj);
>> +	}
>> +
>> +	slab_free(s, slab, obj, _RET_IP_);
>> +}
>> +
> Tiny computer case. Just small nit, maybe remove unlikely() but you decide :)

Force of habbit :)

> --
> Uladzislau Rezki

