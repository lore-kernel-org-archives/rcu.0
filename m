Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47352F88
	for <rcu@vger.kernel.org>; Wed, 14 May 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231282; cv=none; b=Jb39KXg0n4wmkIY5dlL3Ltzie0nOmxVY8r2z1kKuB0RHmeTXB46Lo1XQgQwdbE5ETVteYSYzgLMZHUas8voPw4n6RqaG0+4ar2RBX2m2yZxLBDm6u/04N3JZTQfYQS5MMROkit1BAmoRfjopcscehOqREfoIhwajRFbH8Yc10lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231282; c=relaxed/simple;
	bh=oF4P9o/W9fIPOyqixE/g5Cq3TmC5T1O9Jhi2PUxGs9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uP1M9ZKASU5z6ArsDPagT2WZcHpKfnwBVPEyUURe4Djlpdyby2qtdpoSk+nEEUbnZ2yDV0oa//oP/0NgDX+obAUSjDwbLVc9ePp/7gSUMIECmVI2mSV2CzuPMHkhLeZvOsn7Bt84Q+zT9czWFyRHh8YFW2FEi3y+vSkuy7zh28c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UjBuT4qm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HzAefIuD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UjBuT4qm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HzAefIuD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UjBuT4qm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HzAefIuD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UjBuT4qm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HzAefIuD"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 569271F7C4;
	Wed, 14 May 2025 14:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747231278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7pjNJhG3L0zAzXf2BefC48+ZaUDK3Dac9PaRcrtBMX4=;
	b=UjBuT4qmfCVgyPdGfEiUzIcpAH9aqdhkB2npjDFPiLuooOks6LoICam3u8FNuZYglWoJpz
	Rtfd9zK/unJ0ualUFt3nE30Kn0fwb9X51nqL9x1UVC5kGBmpXi81uMwGllyMCbdkNmZm1P
	tgIh9LR4dOSwUdlF9AupDdv74PfeYFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747231278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7pjNJhG3L0zAzXf2BefC48+ZaUDK3Dac9PaRcrtBMX4=;
	b=HzAefIuD6NVp9PhTTI8Nnk7j+1w3CbHemXo7wpeK1Zfh/3BsFJZdtXwAkAZ4wjhBmu16wu
	NrLr009Y1TBYwOCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UjBuT4qm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HzAefIuD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747231278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7pjNJhG3L0zAzXf2BefC48+ZaUDK3Dac9PaRcrtBMX4=;
	b=UjBuT4qmfCVgyPdGfEiUzIcpAH9aqdhkB2npjDFPiLuooOks6LoICam3u8FNuZYglWoJpz
	Rtfd9zK/unJ0ualUFt3nE30Kn0fwb9X51nqL9x1UVC5kGBmpXi81uMwGllyMCbdkNmZm1P
	tgIh9LR4dOSwUdlF9AupDdv74PfeYFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747231278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7pjNJhG3L0zAzXf2BefC48+ZaUDK3Dac9PaRcrtBMX4=;
	b=HzAefIuD6NVp9PhTTI8Nnk7j+1w3CbHemXo7wpeK1Zfh/3BsFJZdtXwAkAZ4wjhBmu16wu
	NrLr009Y1TBYwOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BD5A139A2;
	Wed, 14 May 2025 14:01:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PLp3DS6iJGjbCgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 14 May 2025 14:01:18 +0000
Message-ID: <f181285e-4167-4581-a712-8e444a0ab2bb@suse.cz>
Date: Wed, 14 May 2025 16:01:17 +0200
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
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
 <20250425-slub-percpu-caches-v4-2-8a636982b4a4@suse.cz>
 <CAJuCfpGVx2jG+S2ch2hqK=sAdmTcs9dW0kOdopxgLtH4V_wNXQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpGVx2jG+S2ch2hqK=sAdmTcs9dW0kOdopxgLtH4V_wNXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 569271F7C4
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.com,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action

On 5/6/25 23:34, Suren Baghdasaryan wrote:
> On Fri, Apr 25, 2025 at 1:27 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> @@ -2631,6 +2637,24 @@ static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf)
>>         sheaf->size = 0;
>>  }
>>
>> +static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
>> +                                    struct slab_sheaf *sheaf);
> 
> I think you could safely move __rcu_free_sheaf_prepare() here and
> avoid the above forward declaration.

Right, done.

>> @@ -5304,6 +5340,140 @@ bool free_to_pcs(struct kmem_cache *s, void *object)
>>         return true;
>>  }
>>
>> +static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
>> +                                    struct slab_sheaf *sheaf)
> 
> This function seems to be an almost exact copy of free_to_pcs_bulk()
> from your previous patch. Maybe they can be consolidated?

True, I've extracted it to __kmem_cache_free_bulk_prepare().

>> +{
>> +       bool init = slab_want_init_on_free(s);
>> +       void **p = &sheaf->objects[0];
>> +       unsigned int i = 0;
>> +
>> +       while (i < sheaf->size) {
>> +               struct slab *slab = virt_to_slab(p[i]);
>> +
>> +               memcg_slab_free_hook(s, slab, p + i, 1);
>> +               alloc_tagging_slab_free_hook(s, slab, p + i, 1);
>> +
>> +               if (unlikely(!slab_free_hook(s, p[i], init, true))) {
>> +                       p[i] = p[--sheaf->size];
>> +                       continue;
>> +               }
>> +
>> +               i++;
>> +       }
>> +}
>> +
>> +static void rcu_free_sheaf(struct rcu_head *head)
>> +{
>> +       struct slab_sheaf *sheaf;
>> +       struct node_barn *barn;
>> +       struct kmem_cache *s;
>> +
>> +       sheaf = container_of(head, struct slab_sheaf, rcu_head);
>> +
>> +       s = sheaf->cache;
>> +
>> +       /*
>> +        * This may reduce the number of objects that the sheaf is no longer
>> +        * technically full, but it's easier to treat it that way (unless it's
> 
> I don't understand the sentence above. Could you please clarify and
> maybe reword it?

Is this more clear?

/*
 * This may remove some objects due to slab_free_hook() returning false,
 * so that the sheaf might no longer be completely full. But it's easier
 * to handle it as full (unless it became completely empty), as the code
 * handles it fine. The only downside is that sheaf will serve fewer
 * allocations when reused. It only happens due to debugging, which is a
 * performance hit anyway.
 */

>> +
>> +               if (!local_trylock(&s->cpu_sheaves->lock))
> 
> Aren't you leaking `empty` sheaf on this failure?

Right! Fixed, thanks.

>> +                       goto fail;
>> +
>> +               pcs = this_cpu_ptr(s->cpu_sheaves);
>> +
>> +               if (unlikely(pcs->rcu_free))
>> +                       barn_put_empty_sheaf(pcs->barn, empty);
>> +               else
>> +                       pcs->rcu_free = empty;
>> +       }
>> +
>> +do_free:
>> +
>> +       rcu_sheaf = pcs->rcu_free;
>> +
>> +       rcu_sheaf->objects[rcu_sheaf->size++] = obj;
>> +
>> +       if (likely(rcu_sheaf->size < s->sheaf_capacity))
>> +               rcu_sheaf = NULL;
>> +       else
>> +               pcs->rcu_free = NULL;
>> +
>> +       local_unlock(&s->cpu_sheaves->lock);
>> +
>> +       if (rcu_sheaf)
>> +               call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
>> +
>> +       stat(s, FREE_RCU_SHEAF);
>> +       return true;
>> +
>> +fail:
>> +       stat(s, FREE_RCU_SHEAF_FAIL);
>> +       return false;
>> +}
>> +
>>  /*
>>   * Bulk free objects to the percpu sheaves.
>>   * Unlike free_to_pcs() this includes the calls to all necessary hooks
>> @@ -6802,6 +6972,11 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>>         struct kmem_cache_node *n;
>>
>>         flush_all_cpus_locked(s);
>> +
>> +       /* we might have rcu sheaves in flight */
>> +       if (s->cpu_sheaves)
>> +               rcu_barrier();
>> +
>>         /* Attempt to free all objects */
>>         for_each_kmem_cache_node(s, node, n) {
>>                 if (n->barn)
>> @@ -8214,6 +8389,8 @@ STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
>>  STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
>>  STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
>>  STAT_ATTR(FREE_PCS, free_cpu_sheaf);
>> +STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
>> +STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
>>  STAT_ATTR(FREE_FASTPATH, free_fastpath);
>>  STAT_ATTR(FREE_SLOWPATH, free_slowpath);
>>  STAT_ATTR(FREE_FROZEN, free_frozen);
>> @@ -8312,6 +8489,8 @@ static struct attribute *slab_attrs[] = {
>>         &alloc_fastpath_attr.attr,
>>         &alloc_slowpath_attr.attr,
>>         &free_cpu_sheaf_attr.attr,
>> +       &free_rcu_sheaf_attr.attr,
>> +       &free_rcu_sheaf_fail_attr.attr,
>>         &free_fastpath_attr.attr,
>>         &free_slowpath_attr.attr,
>>         &free_frozen_attr.attr,
>>
>> --
>> 2.49.0
>>

