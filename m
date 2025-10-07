Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A51D5CD1
	for <rcu@vger.kernel.org>; Tue,  7 Oct 2025 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759824188; cv=none; b=mfqx+/YChid5k5rxEK3wpevRaq3X/j0JWTGYWnE46Av41vQKLD+Vo6ONonoW0fUDeoGi59Goccy+xLYZKsdjtT5wnOTdRqWXCqCfbHOqoRlm+wziwRRjWyLTkQiD3NlFvZVuA9wuMF5lvF8hHi+AJ92c1H5/PvHtvLA7dxxeN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759824188; c=relaxed/simple;
	bh=6wGeXxWXkSAVYS163OiXCeex4vjUrbcdP6PKJ3cAMp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5c3hbYU0FlSdoJ1IK+CazFoY9evE+t4KtygGkp6sJkbKv9iL8f05nkd2weTbpYreil4aZmZVw2fFPMfCMfCMyOquIXBu/66/+CeB3IHdsw3DOJgGIqOgRU8aVWtdra2Lh4QicIRPyoAON6fyvaNqLW7Skgc79y1zYouUFq9EjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0v4Uq8qV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aM7fIy/N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0v4Uq8qV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aM7fIy/N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0v4Uq8qV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aM7fIy/N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0v4Uq8qV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aM7fIy/N"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B031336EA;
	Tue,  7 Oct 2025 08:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759824184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wmu0jNa2/LllNseazk+8f4BK8o7kNGrbiuBCDc9lhw8=;
	b=0v4Uq8qVqdpyIQTXWZMhi0xiuOHfNdqD2KhHikwNTITCGtnw3/FAXugEkhTAy5I98g7mqv
	cii9qW8TMpCeS9mGner0atKe35oFbS3+TP1cD8g1T427rWUzh3OeBynhg6UbAZTWj0zIqj
	vRxGjG8cpMLnzv/DXWBkN8tX3w7xBRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759824184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wmu0jNa2/LllNseazk+8f4BK8o7kNGrbiuBCDc9lhw8=;
	b=aM7fIy/NK/MQR3O1zzSWlghajImgM+GAw8VkUdZsltf6m06mOctZK8IY9BqtYPYKWpGUT2
	WKFGNdGfMI3lxjAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759824184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wmu0jNa2/LllNseazk+8f4BK8o7kNGrbiuBCDc9lhw8=;
	b=0v4Uq8qVqdpyIQTXWZMhi0xiuOHfNdqD2KhHikwNTITCGtnw3/FAXugEkhTAy5I98g7mqv
	cii9qW8TMpCeS9mGner0atKe35oFbS3+TP1cD8g1T427rWUzh3OeBynhg6UbAZTWj0zIqj
	vRxGjG8cpMLnzv/DXWBkN8tX3w7xBRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759824184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wmu0jNa2/LllNseazk+8f4BK8o7kNGrbiuBCDc9lhw8=;
	b=aM7fIy/NK/MQR3O1zzSWlghajImgM+GAw8VkUdZsltf6m06mOctZK8IY9BqtYPYKWpGUT2
	WKFGNdGfMI3lxjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DEF813AAC;
	Tue,  7 Oct 2025 08:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z8NYEjjJ5GiCMwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 07 Oct 2025 08:03:04 +0000
Message-ID: <c750ab62-a3d4-422e-ac5b-c531dfcc749d@suse.cz>
Date: Tue, 7 Oct 2025 10:03:04 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/23] SLUB percpu sheaves
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Qianfeng Rong <rongqianfeng@vivo.com>, Wei Yang <richard.weiyang@gmail.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 WangYuli <wangyuli@uniontech.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <aOS0Z5N4HaBNeb_J@infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <aOS0Z5N4HaBNeb_J@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,oracle.com,gentwo.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,kernel.org,linutronix.de,linux.ibm.com,vivo.com,infradead.org,linux-foundation.org,uniontech.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On 10/7/25 08:34, Christoph Hellwig wrote:
> On Wed, Sep 10, 2025 at 10:01:02AM +0200, Vlastimil Babka wrote:
>> Hi,
>> 
>> I'm sending full v8 due to more changes in the middle of the series that
>> resulted in later patches being fixed up due to conflicts (details in
>> the changelog below).
>> The v8 will replace+extend the v7 in slab/for-next.
> 
> So I've been reading through this and wonder how the preallocation
> using shaves is to be used.  Do you have example code for that
> somewhere?

Maple tree uses this but through its internal layers it's not super clear.

Basically it's for situations where you have an upper bound on the objects
you might need to allocate in some restricted context where you can't fail
but also can't reclaim etc. The steps are:

- kmem_cache_create() with kmem_cache_args.sheaf_capacity to be enough for
any reasonable upper bounds you might need (but also at least e.g. 32 to get
the performance effect of sheaves in general - this will be autotuned in the
followup work). If there's a possibility you might need more than this
capacity in some rare cases, it's fine, just will be slower when it happens.

- kmem_cache_prefill_sheaf() with size being your upper bound for the
following critical section operation, you might get more but not less if
that succeeds

(enter critical section)

- kmem_cache_alloc_from_sheaf(gfp, sheaf) - this is guaranteed to succeed as
many times as the size you requested in your prefill. gfp is there only for
__GFP_ZERO or __GFP_ACCOUNT, where the latter will breach the memcg limit
instead of failing

- kmem_cache_sheaf_size() tells you how much is left in the prefilled sheaf

(exit critical section)

- kmem_cache_return_sheaf() will return the sheaf with unused objects

later freeing the objects allocated via prefilled sheaf is done normally

- alternatively kmem_cache_refill_sheaf() for another round

The whole point compared to preallocation via bulk alloc/bulk free is if you
have a large upper bound for some corner case but only need few objects
typically, this way will be more effective on average.

If you preallocate and know you will use everything, you can keep using
kmem_cache_alloc_bulk() and this won't give you extra benefits.






