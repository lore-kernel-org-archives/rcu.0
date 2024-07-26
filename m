Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AE42B9C4;
	Fri, 26 Jul 2024 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989491; cv=none; b=LTB2tRjpoWmsmiltcgOLCJS1Bp680G712DUip60q2okPleFKv7aC0nuQHzjSG8hzX06AgSLvfpCQPYydwRcR3wkGsyCUeN3Q9NDbRUFM5jHuOogtQzaIANd03XjTaHTj72Mb0gr85K2yPvRfHuKXgq0aPooFcFeHt5MemfGtqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989491; c=relaxed/simple;
	bh=jzD5KSEZrG5/TKfwwIJ2yrs9SurzYe9Te1LUYLNJV3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1PANLNaWtNyQfZr54rAEfC8/KtvO0NsGeSCnyk00yZxSF2jQrm+NaXwzpApJ4HCuLBDGzjV+T2EosEMQaf/JI6dx/n1qDWCJOFPi4WS3LZS6v4TvMjy1PQFn39ie4iPiGbku/cWu6NzJUrWaRNNFi24cQZ0lv4Uzr3VHlwlRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QI7qfIlD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9TVuSKUB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QI7qfIlD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9TVuSKUB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QI7qfIlD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9TVuSKUB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QI7qfIlD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9TVuSKUB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E1321F894;
	Fri, 26 Jul 2024 10:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721989487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k0rbo83WGrdiBw3VPTxjOcp+r2MBYszaRI3wSGV/s+Y=;
	b=QI7qfIlDffqHV2Yoml7CTXWL1sEzt/i26uoRIXt9F8CFOGmVbXZg1vDHk0Hgs4fGSyoKiY
	ZaDkDI+oenfAmW9HwUNmMqEVpv75rt+efLpjZmZA4f0m5beCT720W/fV5gh8qLP8t4OBCk
	es9dfVZHerALIOpd6nBynn3S5/gGiWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721989487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k0rbo83WGrdiBw3VPTxjOcp+r2MBYszaRI3wSGV/s+Y=;
	b=9TVuSKUBp+MohXphEmff55MbXCBXz6ZzYoTTSO8scpUtXj3purAvCKO550c0OIb77kLvqB
	OoA7r7vOmT3Dz5Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QI7qfIlD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9TVuSKUB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721989487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k0rbo83WGrdiBw3VPTxjOcp+r2MBYszaRI3wSGV/s+Y=;
	b=QI7qfIlDffqHV2Yoml7CTXWL1sEzt/i26uoRIXt9F8CFOGmVbXZg1vDHk0Hgs4fGSyoKiY
	ZaDkDI+oenfAmW9HwUNmMqEVpv75rt+efLpjZmZA4f0m5beCT720W/fV5gh8qLP8t4OBCk
	es9dfVZHerALIOpd6nBynn3S5/gGiWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721989487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k0rbo83WGrdiBw3VPTxjOcp+r2MBYszaRI3wSGV/s+Y=;
	b=9TVuSKUBp+MohXphEmff55MbXCBXz6ZzYoTTSO8scpUtXj3purAvCKO550c0OIb77kLvqB
	OoA7r7vOmT3Dz5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 202E4138A7;
	Fri, 26 Jul 2024 10:24:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 60RmB295o2bUVQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 26 Jul 2024 10:24:47 +0000
Message-ID: <915667d7-a13e-423c-89a0-9f877143fd14@suse.cz>
Date: Fri, 26 Jul 2024 12:24:46 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/6] mm, slab: always maintain per-node slab and
 object count
Content-Language: en-US
To: Xiongwei Song <sxwjean@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org
References: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz>
 <20240715-b4-slab-kfree_rcu-destroy-v1-2-46b2984c2205@suse.cz>
 <CAEVVKH_XRmPUEJmo7xXwuNV3mCA8=SHxLdY9EjC9XFZsuqAXJw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAEVVKH_XRmPUEJmo7xXwuNV3mCA8=SHxLdY9EjC9XFZsuqAXJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4E1321F894
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com,goodmis.org,efficios.com,inria.fr,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]

On 7/22/24 4:16 PM, Xiongwei Song wrote:
> Don't we need the following changes for this patch?

Yes thanks, will fix!

> diff --git a/mm/slub.c b/mm/slub.c
> index c1222467c346..e6beb6743342 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4967,9 +4967,9 @@ init_kmem_cache_node(struct kmem_cache_node *n)
>         n->nr_partial = 0;
>         spin_lock_init(&n->list_lock);
>         INIT_LIST_HEAD(&n->partial);
> -#ifdef CONFIG_SLUB_DEBUG
>         atomic_long_set(&n->nr_slabs, 0);
>         atomic_long_set(&n->total_objects, 0);
> +#ifdef CONFIG_SLUB_DEBUG
>         INIT_LIST_HEAD(&n->full);
>  #endif
>  }
> 
> Thanks,
> Xiongwei
> 
> 
> On Tue, Jul 16, 2024 at 4:29 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> Currently SLUB counts per-node slabs and total objects only with
>> CONFIG_SLUB_DEBUG, in order to minimize overhead. However, the detection
>> in __kmem_cache_shutdown() whether there are no outstanding object
>> relies on the per-node slab count (node_nr_slabs()) so it may be
>> unreliable without CONFIG_SLUB_DEBUG. Thus we might be failing to warn
>> about such situations, and instead destroy a cache while leaving its
>> slab(s) around (due to a buggy slab user creating such a scenario, not
>> in normal operation).
>>
>> We will also need node_nr_slabs() to be reliable in the following work
>> to gracefully handle kmem_cache_destroy() with kfree_rcu() objects in
>> flight. Thus make the counting of per-node slabs and objects
>> unconditional.
>>
>> Note that CONFIG_SLUB_DEBUG is the default anyway, and the counting is
>> done only when allocating or freeing a slab page, so even in
>> !CONFIG_SLUB_DEBUG configs the overhead should be negligible.
>>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slub.c | 49 +++++++++++++++++++++----------------------------
>>  1 file changed, 21 insertions(+), 28 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 829a1f08e8a2..aa4d80109c49 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -426,9 +426,9 @@ struct kmem_cache_node {
>>         spinlock_t list_lock;
>>         unsigned long nr_partial;
>>         struct list_head partial;
>> -#ifdef CONFIG_SLUB_DEBUG
>>         atomic_long_t nr_slabs;
>>         atomic_long_t total_objects;
>> +#ifdef CONFIG_SLUB_DEBUG
>>         struct list_head full;
>>  #endif
>>  };
>> @@ -438,6 +438,26 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
>>         return s->node[node];
>>  }
>>
>> +static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
>> +{
>> +       return atomic_long_read(&n->nr_slabs);
>> +}
>> +
>> +static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
>> +{
>> +       struct kmem_cache_node *n = get_node(s, node);
>> +
>> +       atomic_long_inc(&n->nr_slabs);
>> +       atomic_long_add(objects, &n->total_objects);
>> +}
>> +static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
>> +{
>> +       struct kmem_cache_node *n = get_node(s, node);
>> +
>> +       atomic_long_dec(&n->nr_slabs);
>> +       atomic_long_sub(objects, &n->total_objects);
>> +}
>> +
>>  /*
>>   * Iterator over all nodes. The body will be executed for each node that has
>>   * a kmem_cache_node structure allocated (which is true for all online nodes)
>> @@ -1511,26 +1531,6 @@ static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct
>>         list_del(&slab->slab_list);
>>  }
>>
>> -static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
>> -{
>> -       return atomic_long_read(&n->nr_slabs);
>> -}
>> -
>> -static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
>> -{
>> -       struct kmem_cache_node *n = get_node(s, node);
>> -
>> -       atomic_long_inc(&n->nr_slabs);
>> -       atomic_long_add(objects, &n->total_objects);
>> -}
>> -static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
>> -{
>> -       struct kmem_cache_node *n = get_node(s, node);
>> -
>> -       atomic_long_dec(&n->nr_slabs);
>> -       atomic_long_sub(objects, &n->total_objects);
>> -}
>> -
>>  /* Object debug checks for alloc/free paths */
>>  static void setup_object_debug(struct kmem_cache *s, void *object)
>>  {
>> @@ -1871,13 +1871,6 @@ slab_flags_t kmem_cache_flags(slab_flags_t flags, const char *name)
>>
>>  #define disable_higher_order_debug 0
>>
>> -static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
>> -                                                       { return 0; }
>> -static inline void inc_slabs_node(struct kmem_cache *s, int node,
>> -                                                       int objects) {}
>> -static inline void dec_slabs_node(struct kmem_cache *s, int node,
>> -                                                       int objects) {}
>> -
>>  #ifndef CONFIG_SLUB_TINY
>>  static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
>>                                void **freelist, void *nextfree)
>>
>> --
>> 2.45.2
>>
>>
> 

