Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F204A1B0408;
	Sat, 11 Jan 2025 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736624643; cv=none; b=YTIwE8yXMsItuH5zeMFZBux48JtkpvknBxd0kjaDhkkqq7x/8vk4KNi+TUqHs4YozUR+shfmQYGDuDPdahWrsLQTuy/Hkt+v7qsGaLGY0RSiFtBj3f7sXQfk9JtzgZoDaqrubMkyPdMi7/PjA37HmBQb6MkKJ9SNDKQWIrYlf5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736624643; c=relaxed/simple;
	bh=qaPCLYm9k3wT6P8k8lbtwHNUG+NGHSneT9y9072KxT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGbnlHjar1A02lHqoCpzNaPFklfWKGfEtw1PyZmUXdmzmrSNWHR8N98S3kTGH7NmbaeAHkEyoLLTb6iVoysDB+jx/Doqf9Pd9jrTrB0zajY5NyZR0WgCaQ2vKKwV/GoNIxQiGlBpJ60cKCjK+9qo4MaGMaskw0Xv/6dTCMWYpVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dkQT23ww; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZqdSpxmN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dkQT23ww; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZqdSpxmN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dkQT23ww";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZqdSpxmN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dkQT23ww";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZqdSpxmN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 067BE21160;
	Sat, 11 Jan 2025 19:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736624634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wKbl5AGH/Y/74GCxEaZBx38Eogph+MPR7vZph9Szr2Y=;
	b=dkQT23wwOJmefMsxRx6QwRVOS0BGmWPWVTqYDFXR3lligBlraYxTyKZVFdd/E+AHpBV/2W
	ajXxtBPxCLqg/0KCqWjU8PqexvXw622Q4mp9kMDwx0kMMDZ7wroUT69RncqqmqC4qnFdR3
	6wvoVCxo1mNXq++Pj93Z/06SVX0HXow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736624634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wKbl5AGH/Y/74GCxEaZBx38Eogph+MPR7vZph9Szr2Y=;
	b=ZqdSpxmN9durSRlObEcUn4WVlrikZEV766z2jwndo1IC7Gpk7KmJB2pOZiu4ULNdShoulf
	cX5BvKx7CsyJ6DAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736624634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wKbl5AGH/Y/74GCxEaZBx38Eogph+MPR7vZph9Szr2Y=;
	b=dkQT23wwOJmefMsxRx6QwRVOS0BGmWPWVTqYDFXR3lligBlraYxTyKZVFdd/E+AHpBV/2W
	ajXxtBPxCLqg/0KCqWjU8PqexvXw622Q4mp9kMDwx0kMMDZ7wroUT69RncqqmqC4qnFdR3
	6wvoVCxo1mNXq++Pj93Z/06SVX0HXow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736624634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wKbl5AGH/Y/74GCxEaZBx38Eogph+MPR7vZph9Szr2Y=;
	b=ZqdSpxmN9durSRlObEcUn4WVlrikZEV766z2jwndo1IC7Gpk7KmJB2pOZiu4ULNdShoulf
	cX5BvKx7CsyJ6DAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D67E113763;
	Sat, 11 Jan 2025 19:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XQGIM/nJgmeOKwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sat, 11 Jan 2025 19:43:53 +0000
Message-ID: <0c6fea47-c0ac-4398-a820-ac33f981c1f9@suse.cz>
Date: Sat, 11 Jan 2025 20:43:53 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External Mail] [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
Content-Language: en-US
To: Hyeonggon Yoo <hyeonggon.yoo@sk.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: kernel_team@skhynix.com, 42.hyeyoo@gmail.com, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20241212180208.274813-1-urezki@gmail.com>
 <9ceb805c-4b42-4517-93cf-6b3cd3cdce5f@sk.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <9ceb805c-4b42-4517-93cf-6b3cd3cdce5f@sk.com>
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
	FREEMAIL_TO(0.00)[sk.com,gmail.com,kvack.org,kernel.org,linux-foundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[skhynix.com,gmail.com,vger.kernel.org,linux.com,kernel.org,google.com,lge.com,linux.dev,sony.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 1/6/25 08:21, Hyeonggon Yoo wrote:
> 
> 
> On 2024-12-13 3:02 AM, Uladzislau Rezki (Sony) wrote:
>> Hello!
>> 
>> This is v2. It is based on the Linux 6.13-rc2. The first version is
>> here:
>> 
>> https://lore.kernel.org/linux-mm/20241210164035.3391747-4-urezki@gmail.com/T/
>> 
>> The difference between v1 and v2 is that, the preparation process is
>> done in original place instead and after that there is one final move.
>> 
>> Uladzislau Rezki (Sony) (5):
>>    rcu/kvfree: Initialize kvfree_rcu() separately
>>    rcu/kvfree: Move some functions under CONFIG_TINY_RCU
>>    rcu/kvfree: Adjust names passed into trace functions
>>    rcu/kvfree: Adjust a shrinker name
>>    mm/slab: Move kvfree_rcu() into SLAB
>> 
>>   include/linux/slab.h |   1 +
>>   init/main.c          |   1 +
>>   kernel/rcu/tree.c    | 876 ------------------------------------------
>>   mm/slab_common.c     | 880 +++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 882 insertions(+), 876 deletions(-)
> 
> Sorry for the late reply, but better late than never...
> 
> FWIW,
> 
> Acked-by: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
> Tested-by: Hyeonggon Yoo <hyeonggon.yoo@sk.com>

Thanks, applied.

> Thanks for all the efforts!
> 
> By the way, any future plans how to take advantage of internal slab
> state?

One way is the sheaves effort which in the last RFC also replaced the way
kfree_rcu() is handled for caches with enabled sheaves.

Perhaps even without those we could consider e.g. doing the kfree_rcu()
batching by grouping the pending frees per kmem cache, which could perhaps
lead to more efficient flushing later.

> --
> Hyeonggon

