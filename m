Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC29B215061;
	Wed, 22 Jan 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737564190; cv=none; b=N6nf5Gv/NBEcfh47VglOAp5eMrmf251VMCUqfWMJcU0xGlmG+81bwpjdiH656PM8yiWTz0ngQwQorbbxTwHYdcV3lw2jm+RkaxeqIVzKxYsi3g0sWn5jV10/awIarNzlAqaVOnCvU3Q9O92nQ5E/xCtf5G1kHfX3943NmI520qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737564190; c=relaxed/simple;
	bh=uXbngOe3ms3BD4khXn+SOKyGwDfvhTi1Ex+0aUstiNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INHLzO4HKe5GOuwZSPYyYJbGrcycwl5BvVDsVpPumC9irTZeAhnGFMu0CcSNivJ6W9Vzqr0mRh6eie1hSErqcJ/lRQryvsMOvWjXiBjOoJ1q2cqRYmAkBWE0rlC+0RQvNzecSoEHKN37X+omFknNhlIE99p58vqK48mkzD45Z4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xg8bXjgG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w+22/3TX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xg8bXjgG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w+22/3TX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xg8bXjgG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w+22/3TX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xg8bXjgG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w+22/3TX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1B861F80A;
	Wed, 22 Jan 2025 16:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737564186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mwgVlHr5+35USFBo9OXC3GNw9sb4DJKkmcmIPPfo1pk=;
	b=Xg8bXjgGxYOWBghpUUKBQhh0BiJ2vGBR+vqHdprpYaddF1C/Y20FdrYdXcuN1sb6Zvqr46
	Jy2S6s+7cvR6foqguHtx/QgkHO1hpVlv2WqHLcQHCjS43K1/QezHQE9SY9thWmpdx36Heq
	tT0RukYwsKhjel3iRo8JXYdTcrdnAwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737564186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mwgVlHr5+35USFBo9OXC3GNw9sb4DJKkmcmIPPfo1pk=;
	b=w+22/3TXl2o9pIyJZ2VxWwuyW0gjh63PNp5UQf7nEWwIhJ6IsNbP68II9mt1F1JK/WLIax
	PwvMnmdTjQRJUwCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737564186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mwgVlHr5+35USFBo9OXC3GNw9sb4DJKkmcmIPPfo1pk=;
	b=Xg8bXjgGxYOWBghpUUKBQhh0BiJ2vGBR+vqHdprpYaddF1C/Y20FdrYdXcuN1sb6Zvqr46
	Jy2S6s+7cvR6foqguHtx/QgkHO1hpVlv2WqHLcQHCjS43K1/QezHQE9SY9thWmpdx36Heq
	tT0RukYwsKhjel3iRo8JXYdTcrdnAwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737564186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mwgVlHr5+35USFBo9OXC3GNw9sb4DJKkmcmIPPfo1pk=;
	b=w+22/3TXl2o9pIyJZ2VxWwuyW0gjh63PNp5UQf7nEWwIhJ6IsNbP68II9mt1F1JK/WLIax
	PwvMnmdTjQRJUwCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1E59136A1;
	Wed, 22 Jan 2025 16:43:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0NAVJxogkWewCgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 22 Jan 2025 16:43:06 +0000
Message-ID: <c210c44d-d1b1-4dc3-839d-f99ad73c3ee9@suse.cz>
Date: Wed, 22 Jan 2025 17:43:06 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
To: Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <Z2AJCI3cIR9ETFFu@pc636>
 <d352db4f-4bb8-4300-b235-bbd1bdb3aa21@suse.cz> <Z2BKLzOGv_Ki_7fj@pc636>
 <6fb206de-0185-4026-a6f5-1d150752d8d0@suse.cz> <Z2BNWpkruY6rJv6A@pc636>
 <5bb80786-220d-45d2-bd35-51876df4203c@paulmck-laptop>
 <55931fdd-1d5f-4ffd-8496-fe436171dee2@suse.cz> <Z4-iDAONPyf7ljBU@pc636>
 <970317a9-0283-4eec-94ae-63056659d7de@suse.cz> <Z4-ruJ3KVD3PieZi@pc636>
 <7b7b92a3-780e-4db0-a5cf-3e78d79587a2@paulmck-laptop>
 <CAEXW_YQQii5061aNCvdCtvoBZra+5PxFWJcDCO0JWjSM3PURTQ@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAEXW_YQQii5061aNCvdCtvoBZra+5PxFWJcDCO0JWjSM3PURTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,linux-foundation.org,vger.kernel.org,linux.com,kernel.org,google.com,lge.com,linux.dev,sony.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 1/22/25 16:04, Joel Fernandes wrote:
> On Tue, Jan 21, 2025 at 3:32 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>>
>> On Tue, Jan 21, 2025 at 03:14:16PM +0100, Uladzislau Rezki wrote:
>> > On Tue, Jan 21, 2025 at 02:49:13PM +0100, Vlastimil Babka wrote:
>> > > Right so that's the first Possible solution, but without the #ifdef. So
>> > > there's an overhead of checking __is_kvfree_rcu_offset() even if the
>> > > batching is done in slab and this function is never called with an offset.
>> > >
>> > Or fulfilling a missing functionality? TREE is broken in that sense
>> > whereas a TINY handles it without any issues.
>> >
>> > It can be called for SLUB_TINY option, just call_rcu() instead of
>> > batching layer. And yes, kvfree_rcu_barrier() switches to rcu_barrier().
>>
>> Would this make sense?
>>
>>                 if (IS_ENABLED(CONFIG_TINY_RCU) && __is_kvfree_rcu_offset((unsigned long) f)) {
>>
>> Just to be repetitive, other alternatives include:
>>
>> 1.      Take advantage of SLOB being no longer with us.
>>
>> 2.      Get rid of Tiny RCU's special casing of kfree_rcu(), and then
>>         eliminate the above "if" statement in favor of its "else" clause.
>>
>> 3.      Make Tiny RCU implement a trivial version of kfree_rcu() that
>>         passes a list through RCU.
>>
>> I don't have strong feelings, and am happy to defer to your guys'
>> decision.
> 
> If I may chime in with an opinion, I think the cleanest approach would
> be to not special-case the func pointer and instead provide a callback
> from the SLAB layer which does the kfree. Then get rid of

Right.

> __is_kvfree_rcu_offset() and its usage from Tiny. Granted, there is
> the overhead of function calling, but I highly doubt that it is going
> to be a bottleneck, considering that the __is_kvfree_rcu_offset() path
> is a kfree slow-path.  I feel in the long run, this will also be more
> maintainable.
> 
> Or is there a reason other than the theoretical function call overhead
> why this may not work?

My concern was about the overhead of calculating the pointer to the object
starting address, but it's just some arithmetics, so it should be
negligible. So I'm prototyping this approach now. Thanks all.

> thanks,
> 
>  - Joel

