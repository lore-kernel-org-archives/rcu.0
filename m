Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D02D3225
	for <rcu@vger.kernel.org>; Tue, 26 Aug 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203124; cv=none; b=LKhYhmmfbGS76+/Q0A7W0Eu5MJHJI4nS+m/Gejk4ASuZI5fAWsanA7PRumaRFwJz7PAYzk1zrIed2zR71rTGch3YWNexsEqUDtzfuOIQE/4bhJ0pGbciM5rTbOHFNdbUnk4lV14xRK2VwUpC+ycjwCS/IkbfQSA6OTDbCOkEVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203124; c=relaxed/simple;
	bh=2jBxlp7eFmbdTueoxcgWuQMvmEO8B8R+FpL1s6uOyXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D23LbZeH2vNwWQZ91fZZfV0V9aeYKmxlq15g53ljaDP7ZSYaP8dOmCgYBKYmUHSNzFQjY/BtJzCbRKCqKbpWs36jlMAJzkg5gK4fpkr67+ciKBHulV6Ayv6hfI70ecp8AkzFLfa0flH1W1jjKDyX07u7+ljhgrgOegyThnv54Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VhHj3jLN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FHDP1PGK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FRnrljDd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V4uN9i5L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VhHj3jLN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FHDP1PGK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FRnrljDd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V4uN9i5L"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9046421247;
	Tue, 26 Aug 2025 10:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756203120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mmE9SEYGD2F3s4ICA+kzQeVmgCLv9DYvPz9hobyINKM=;
	b=VhHj3jLNuEqak9vRiJQLJ6BX9DyzonAYtK5MRWGohb4hE5GX0Q7SiSNgY11Ut5cj/ewkdJ
	emhk5DnwJ3yLgWnVCHnIFhuxZpydXz+u8dh/VMrBsxDb6m1qsAlJVCHBIhY2saM2zWGWH0
	GorKOvfsQe1RSvTwJOctsYrnNfCYne8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756203120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mmE9SEYGD2F3s4ICA+kzQeVmgCLv9DYvPz9hobyINKM=;
	b=FHDP1PGKNaRRsS+6/d6SJSr3LF+WI/esNSSMgzpma4Jsb7d/q22LluKCPGrvKHz8olynIK
	1z4pc6DsSPmgJmCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FRnrljDd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=V4uN9i5L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756203119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mmE9SEYGD2F3s4ICA+kzQeVmgCLv9DYvPz9hobyINKM=;
	b=FRnrljDdXRC7Y1Iv20e7I3f40YzplWMV9xvdLO5CAGFAnH1f+5fgPZvPiYVDhK6k/udszh
	xyf/rhCxxyLa/STM0Pf/l4ETdvV3UjCHeGegHTuscrRjmsq9BZWeizMmgn7s1LwIP189Ya
	84Xx99nk12ymmmpySJCbZQcgbkEmlso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756203119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mmE9SEYGD2F3s4ICA+kzQeVmgCLv9DYvPz9hobyINKM=;
	b=V4uN9i5LFt9Hrvzh7qquMcNeebUF+sT//Dcz7rPSQOJhaBrR2WRiWP8ynwPQd43ZQB+Nop
	r1dk7l5CBPp0RoDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7909513479;
	Tue, 26 Aug 2025 10:11:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pawmHW+IrWikbwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 26 Aug 2025 10:11:59 +0000
Message-ID: <c57e3da8-93b4-4c4a-8731-efafd382ddf1@suse.cz>
Date: Tue, 26 Aug 2025 12:11:59 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/14] mm, slub: skip percpu sheaves for remote object
 freeing
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250723-slub-percpu-caches-v5-9-b792cd830f5d@suse.cz>
 <aKvzAvgwUyZN5GC6@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aKvzAvgwUyZN5GC6@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,gentwo.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 9046421247
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 8/25/25 07:22, Harry Yoo wrote:
> On Wed, Jul 23, 2025 at 03:34:42PM +0200, Vlastimil Babka wrote:
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
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slab_common.c |  7 +++++--
>>  mm/slub.c        | 42 ++++++++++++++++++++++++++++++++++++------
>>  2 files changed, 41 insertions(+), 8 deletions(-)
>> 
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 2d806e02568532a1000fd3912db6978e945dcfa8..f466f68a5bd82030a987baf849a98154cd48ef23 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1623,8 +1623,11 @@ static bool kfree_rcu_sheaf(void *obj)
>>  
>>  	slab = folio_slab(folio);
>>  	s = slab->slab_cache;
>> -	if (s->cpu_sheaves)
>> -		return __kfree_rcu_sheaf(s, obj);
>> +	if (s->cpu_sheaves) {
>> +		if (likely(!IS_ENABLED(CONFIG_NUMA) ||
>> +			   slab_nid(slab) == numa_node_id()))
>> +			return __kfree_rcu_sheaf(s, obj);
>> +	}
> 
> This should be numa_mem_id() to handle memory-less NUMA nodes as
> Christoph mentioned [1]?
> 
> I saw you addressed this in most of places but not this one.

Oops, right.
> With that addressed, please feel free to add:
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Thanks!

> [1] https://lore.kernel.org/linux-mm/c60ae681-6027-0626-8d4e-5833982bf1f0@gentwo.org
> 
>>  
>>  	return false;
>>  }
> 

