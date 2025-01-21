Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A67139B;
	Tue, 21 Jan 2025 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737467292; cv=none; b=IGtUZGM3F84y5GP5qkk7DbwnEU+vx+PZq0cfXGYC8OdqA1A+pkW5y1tksV2k5k7uKUOJrtUglAjQJyNPxZT4ye/C7+uFL1wMqgUF/BBogr7BdMKz4wTBI6Y3iQyqb8dj+5zGrGZQwUggGk8dP/hq2QnlYHjzDSPDpPR0YON3VY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737467292; c=relaxed/simple;
	bh=RDYCQHFgAfyruOtG7pwDotoia0rIxs9GrIS6ARK4a98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLVMVIZi1MXh/WvFfxY+3vJZqqZVWyvUu/fbK+PcnBFXADLK4Mu3ctx9SASAZHswNnBKsVlM79dbH0ZDbeBtlJgZXje2U4a8VFsSmSB/TmHVgc2DDGdN1y3w3jMR+pZhq90Lv/OoN07toX8dGBZujkxAgp8PXuhfnuP+AYIpLaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0PutRMfy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xB3CAo1I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0PutRMfy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xB3CAo1I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0PutRMfy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xB3CAo1I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0PutRMfy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xB3CAo1I"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F10F211BB;
	Tue, 21 Jan 2025 13:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737467288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PDuGfDwUyydZ0gDPvcl/hcmjIG+al/xob095x4Nj9g=;
	b=0PutRMfyjRpWd+5bhM9s6pIkmdoYOqOX8nnRs6rReye5IQVfnHX1rKLd9VZnnsjUI1YKEF
	Lv6v01IerVIe+teRxs97vuvyWZa/kC2VvlPpN2D4iuhWj89a1NHjWmJFzQT/8y/QgSKIdb
	PU0bYFwdBdkYlHpX7HUuFNdM5EJaZVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737467288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PDuGfDwUyydZ0gDPvcl/hcmjIG+al/xob095x4Nj9g=;
	b=xB3CAo1I8pH+txWRk61tKTEqqlFL/uVxh6bbC5CvBkaAturVKYIjUyt2cOu/p2hmmQrpCl
	qVNmx1ogr/41rzAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737467288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PDuGfDwUyydZ0gDPvcl/hcmjIG+al/xob095x4Nj9g=;
	b=0PutRMfyjRpWd+5bhM9s6pIkmdoYOqOX8nnRs6rReye5IQVfnHX1rKLd9VZnnsjUI1YKEF
	Lv6v01IerVIe+teRxs97vuvyWZa/kC2VvlPpN2D4iuhWj89a1NHjWmJFzQT/8y/QgSKIdb
	PU0bYFwdBdkYlHpX7HUuFNdM5EJaZVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737467288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PDuGfDwUyydZ0gDPvcl/hcmjIG+al/xob095x4Nj9g=;
	b=xB3CAo1I8pH+txWRk61tKTEqqlFL/uVxh6bbC5CvBkaAturVKYIjUyt2cOu/p2hmmQrpCl
	qVNmx1ogr/41rzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1595E13963;
	Tue, 21 Jan 2025 13:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DbybBJilj2dWPAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 21 Jan 2025 13:48:08 +0000
Message-ID: <970317a9-0283-4eec-94ae-63056659d7de@suse.cz>
Date: Tue, 21 Jan 2025 14:49:13 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
To: Uladzislau Rezki <urezki@gmail.com>
Cc: paulmck@kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20241212180208.274813-1-urezki@gmail.com>
 <17476947-d447-4de3-87bb-97d5f3c0497d@suse.cz> <Z2AJCI3cIR9ETFFu@pc636>
 <d352db4f-4bb8-4300-b235-bbd1bdb3aa21@suse.cz> <Z2BKLzOGv_Ki_7fj@pc636>
 <6fb206de-0185-4026-a6f5-1d150752d8d0@suse.cz> <Z2BNWpkruY6rJv6A@pc636>
 <5bb80786-220d-45d2-bd35-51876df4203c@paulmck-laptop>
 <55931fdd-1d5f-4ffd-8496-fe436171dee2@suse.cz> <Z4-iDAONPyf7ljBU@pc636>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <Z4-iDAONPyf7ljBU@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
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
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,linux-foundation.org,vger.kernel.org,linux.com,google.com,lge.com,linux.dev,gmail.com,sony.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 1/21/25 2:33 PM, Uladzislau Rezki wrote:
> On Mon, Jan 20, 2025 at 11:06:13PM +0100, Vlastimil Babka wrote:
>> On 12/16/24 17:46, Paul E. McKenney wrote:
>>> On Mon, Dec 16, 2024 at 04:55:06PM +0100, Uladzislau Rezki wrote:
>>>> On Mon, Dec 16, 2024 at 04:44:41PM +0100, Vlastimil Babka wrote:
>>>>> On 12/16/24 16:41, Uladzislau Rezki wrote:
>>>>>> On Mon, Dec 16, 2024 at 03:20:44PM +0100, Vlastimil Babka wrote:
>>>>>>> On 12/16/24 12:03, Uladzislau Rezki wrote:
>>>>>>>> On Sun, Dec 15, 2024 at 06:30:02PM +0100, Vlastimil Babka wrote:
>>>>>>>>
>>>>>>>>> Also how about a followup patch moving the rcu-tiny implementation of
>>>>>>>>> kvfree_call_rcu()?
>>>>>>>>>
>>>>>>>> As, Paul already noted, it would make sense. Or just remove a tiny
>>>>>>>> implementation.
>>>>>>>
>>>>>>> AFAICS tiny rcu is for !SMP systems. Do they benefit from the "full"
>>>>>>> implementation with all the batching etc or would that be unnecessary overhead?
>>>>>>>
>>>>>> Yes, it is for a really small systems with low amount of memory. I see
>>>>>> only one overhead it is about driving objects in pages. For a small
>>>>>> system it can be critical because we allocate.
>>>>>>
>>>>>> From the other hand, for a tiny variant we can modify the normal variant
>>>>>> by bypassing batching logic, thus do not consume memory(for Tiny case)
>>>>>> i.e. merge it to a normal kvfree_rcu() path.
>>>>>
>>>>> Maybe we could change it to use CONFIG_SLUB_TINY as that has similar use
>>>>> case (less memory usage on low memory system, tradeoff for worse performance).
>>>>>
>>>> Yep, i also was thinking about that without saying it :)
>>>
>>> Works for me as well!
>>
>> Hi, so I tried looking at this. First I just moved the code to slab as seen
>> in the top-most commit here [1]. Hope the non-inlined __kvfree_call_rcu() is
>> not a show-stopper here.
>>
>> Then I wanted to switch the #ifdefs from CONFIG_TINY_RCU to CONFIG_SLUB_TINY
>> to control whether we use the full blown batching implementation or the
>> simple call_rcu() implmentation, and realized it's not straightforward and
>> reveals there are still some subtle dependencies of kvfree_rcu() on RCU
>> internals :)
>>
>> Problem 1: !CONFIG_SLUB_TINY with CONFIG_TINY_RCU
>>
>> AFAICS the batching implementation includes kfree_rcu_scheduler_running()
>> which is called from rcu_set_runtime_mode() but only on TREE_RCU. Perhaps
>> there are other facilities the batching implementation needs that only
>> exists in the TREE_RCU implementation
>>
>> Possible solution: batching implementation depends on both !CONFIG_SLUB_TINY
>> and !CONFIG_TINY_RCU. I think it makes sense as both !SMP systems and small
>> memory systems are fine with the simple implementation.
>>
>> Problem 2: CONFIG_TREE_RCU with !CONFIG_SLUB_TINY
>>
>> AFAICS I can't just make the simple implementation do call_rcu() on
>> CONFIG_TREE_RCU, because call_rcu() no longer knows how to handle the fake
>> callback (__is_kvfree_rcu_offset()) - I see how rcu_reclaim_tiny() does that
>> but no such equivalent exists in TREE_RCU. Am I right?
>>
>> Possible solution: teach TREE_RCU callback invocation to handle
>> __is_kvfree_rcu_offset() again, perhaps hide that branch behind #ifndef
>> CONFIG_SLUB_TINY to avoid overhead if the batching implementation is used.
>> Downside: we visibly demonstrate how kvfree_rcu() is not purely a slab thing
>> but RCU has to special case it still.
>>
>> Possible solution 2: instead of the special offset handling, SLUB provides a
>> callback function, which will determine pointer to the object from the
>> pointer to a middle of it without knowing the rcu_head offset.
>> Downside: this will have some overhead, but SLUB_TINY is not meant to be
>> performant anyway so we might not care.
>> Upside: we can remove __is_kvfree_rcu_offset() from TINY_RCU as well
>>
>> Thoughts?
>>
> For the call_rcu() and to be able to reclaim over it we need to patch the
> tree.c(please note TINY already works):
> 
> <snip>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b1f883fcd918..ab24229dfa73 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2559,13 +2559,19 @@ static void rcu_do_batch(struct rcu_data *rdp)
>                 debug_rcu_head_unqueue(rhp);
> 
>                 rcu_lock_acquire(&rcu_callback_map);
> -               trace_rcu_invoke_callback(rcu_state.name, rhp);
> 
>                 f = rhp->func;
> -               debug_rcu_head_callback(rhp);
> -               WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> -               f(rhp);
> 
> +               if (__is_kvfree_rcu_offset((unsigned long) f)) {
> +                       trace_rcu_invoke_kvfree_callback("", rhp, (unsigned long) f);
> +                       kvfree((void *) rhp - (unsigned long) f);
> +               } else {
> +                       trace_rcu_invoke_callback(rcu_state.name, rhp);
> +                       debug_rcu_head_callback(rhp);
> +                       WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> +                       f(rhp);
> +               }
>                 rcu_lock_release(&rcu_callback_map);

Right so that's the first Possible solution, but without the #ifdef. So
there's an overhead of checking __is_kvfree_rcu_offset() even if the
batching is done in slab and this function is never called with an offset.

After coming up with Possible solution 2, I've started liking the idea
more as RCU could then forget about the __is_kvfree_rcu_offset()
"callbacks" completely, and the performant case of TREE_RCU + batching
would be unaffected.

I'm speculating perhaps if there was not CONFIG_SLOB in the past, the
__is_kvfree_rcu_offset() would never exist in the first place? SLAB and
SLUB both can determine start of the object from a pointer to the middle
of it, while SLOB couldn't.

>                 /*
> <snip>
> 
> Mixing up CONFIG_SLUB_TINY with CONFIG_TINY_RCU in the slab_common.c
> should be avoided, i.e. if we can, we should eliminate a dependency on
> TREE_RCU or TINY_RCU in a slab. As much as possible.
> 
> So, it requires a more closer look for sure :)

That requires solving Problem 1 above, but question is if it's worth the
trouble. Systems running TINY_RCU are unlikely to benefit from the batching?

But sure there's also possibility to hide these dependencies in KConfig,
so the slab code would only consider a single (for example) #ifdef
CONFIG_KVFREE_RCU_BATCHING that would be set automatically depending on
TREE_RCU and !SLUB_TINY.

> --
> Uladzislau Rezki

