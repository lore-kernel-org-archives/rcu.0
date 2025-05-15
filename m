Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947EE293756
	for <rcu@vger.kernel.org>; Thu, 15 May 2025 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299559; cv=none; b=UXXS7PYuYIP1cY6e5V+I/Zs3ETiT0zfUgpFVZR8il1p4k9Pe3b6KMBnhNifkYBJeaL0aaWGQB8QhBt7jGWOWVwtxYwUrqhQyI4gsn8IyitTPCSf+HqIn+675A1sw2rsl/kMonwty18FbqlTbUOMbaL1yjWEwsbhR/uUAf2ZXU18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299559; c=relaxed/simple;
	bh=3NDHBRjrO56wPFSmrP/tqbVPNtVqcsNX3LEYFCznarY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGIlD9OTRQG3dnyr0sFSBfTctlT2B+5kilmlfVknKNxxu1yclujfZfXBKuzaWgPgi9FpG2FXmPTz/4a+dL6u6CqLKDlpiuso5XmWQ+DUDiNn5H8V7HBcYKBPmcj5zfXVYiRGvjGBIBadDoUi1tEWA5kZu/s2q+fX7AEwmdgx/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pnphta3p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NmIXdFnU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pnphta3p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NmIXdFnU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pnphta3p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NmIXdFnU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pnphta3p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NmIXdFnU"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B45651F391;
	Thu, 15 May 2025 08:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747299554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFkGUgAQs5DlUjM0ydlG9GUUFq/7KcW6NX7M7pmvjeQ=;
	b=Pnphta3pj/hPd36vEObXKs7oZ0yRXLXPve+d4n7PRI8BWxbpSlvygZrWnAcKZ3FH9Xl2c1
	Be8QO7NDCZVnPH+8GY5eKp+0IXQbjQVeZqJw169CCHTYPbe+EqedilZ9Qqzsq/lb3ybn3C
	LZkD6mMSDDZZ+dUG0KyyHODqR+TR9VI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747299554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFkGUgAQs5DlUjM0ydlG9GUUFq/7KcW6NX7M7pmvjeQ=;
	b=NmIXdFnUXuSNu01AoL3nca3Ijs1g4XLQ1IEDXnBpVbRnnWbWWz48AeD2HD4wmnz+mbOu+O
	5dBO7cFrMvmfO4Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Pnphta3p;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NmIXdFnU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747299554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFkGUgAQs5DlUjM0ydlG9GUUFq/7KcW6NX7M7pmvjeQ=;
	b=Pnphta3pj/hPd36vEObXKs7oZ0yRXLXPve+d4n7PRI8BWxbpSlvygZrWnAcKZ3FH9Xl2c1
	Be8QO7NDCZVnPH+8GY5eKp+0IXQbjQVeZqJw169CCHTYPbe+EqedilZ9Qqzsq/lb3ybn3C
	LZkD6mMSDDZZ+dUG0KyyHODqR+TR9VI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747299554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFkGUgAQs5DlUjM0ydlG9GUUFq/7KcW6NX7M7pmvjeQ=;
	b=NmIXdFnUXuSNu01AoL3nca3Ijs1g4XLQ1IEDXnBpVbRnnWbWWz48AeD2HD4wmnz+mbOu+O
	5dBO7cFrMvmfO4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DBEB139D0;
	Thu, 15 May 2025 08:59:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D5A2JuKsJWgTRAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 May 2025 08:59:14 +0000
Message-ID: <938fa0c7-86c3-44d4-b583-0612458aed98@suse.cz>
Date: Thu, 15 May 2025 10:59:14 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] mm, slub: skip percpu sheaves for remote object
 freeing
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
 <20250425-slub-percpu-caches-v4-9-8a636982b4a4@suse.cz>
 <aBs4WvzJb4X50Sr2@harry>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <aBs4WvzJb4X50Sr2@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B45651F391
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
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Action: no action

On 5/7/25 12:39, Harry Yoo wrote:
> On Fri, Apr 25, 2025 at 10:27:29AM +0200, Vlastimil Babka wrote:
>> Since we don't control the NUMA locality of objects in percpu sheaves,
>> allocations with node restrictions bypass them. Allocations without
>> restrictions may however still expect to get local objects with high
>> probability, and the introduction of sheaves can decrease it due to
>> freed object from a remote node ending up in percpu sheaves.
>> 
>> The fraction of such remote frees seems low (5% on an 8-node machine)
>> but it can be expected that some cache or workload specific corner cases
>> exist. We can either conclude that this is not a problem due to the low
>> fraction, or we can make remote frees bypass percpu sheaves and go
>> directly to their slabs. This will make the remote frees more expensive,
>> but if if's only a small fraction, most frees will still benefit from
>> the lower overhead of percpu sheaves.
>> 
>> This patch thus makes remote object freeing bypass percpu sheaves,
>> including bulk freeing, and kfree_rcu() via the rcu_free sheaf. However
>> it's not intended to be 100% guarantee that percpu sheaves will only
>> contain local objects. The refill from slabs does not provide that
>> guarantee in the first place, and there might be cpu migrations
>> happening when we need to unlock the local_lock. Avoiding all that could
>> be possible but complicated so we can leave it for later investigation
>> whether it would be worth it. It can be expected that the more selective
>> freeing will itself prevent accumulation of remote objects in percpu
>> sheaves so any such violations would have only short-term effects.
>> 
>> Another possible optimization to investigate is whether it would be
>> beneficial for node-restricted or strict_numa allocations to attempt to
>> obtain an object from percpu sheaves if the node or mempolicy (i.e.
>> MPOL_LOCAL) happens to want the local node of the allocating cpu. Right
>> now such allocations bypass sheaves, but they could probably look first
>> whether the first available object in percpu sheaves is local, and with
>> high probability succeed - and only bypass the sheaves in cases it's
>> not local.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slab_common.c |  7 +++++--
>>  mm/slub.c        | 43 +++++++++++++++++++++++++++++++++++++------
>>  2 files changed, 42 insertions(+), 8 deletions(-)
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index cc273cc45f632e16644355831132cdc391219cec..2bf83e2b85b23f4db2b311edaded4bef6b7d01de 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -5924,8 +5948,15 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>>  	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
>>  		return;
>>  
>> -	if (!s->cpu_sheaves || !free_to_pcs(s, object))
>> -		do_slab_free(s, slab, object, object, 1, addr);
>> +	if (s->cpu_sheaves) {
>> +		if (likely(!IS_ENABLED(CONFIG_NUMA) ||
>> +			   slab_nid(slab) == numa_node_id())) {
>> +			free_to_pcs(s, object);
> 
> Shouldn't it call do_slab_free() when free_to_pcs() failed?

Oops yes, thanks!

> 
>> +			return;
>> +		}
>> +	}
>> +
>> +	do_slab_free(s, slab, object, object, 1, addr);
>>  }
>>  
>>  #ifdef CONFIG_MEMCG
>> 
>> -- 
>> 2.49.0
>> 
>> 
> 

