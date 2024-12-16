Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A684B360;
	Mon, 16 Dec 2024 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363885; cv=none; b=Vny9vxj1O8fFhE0HcnbW//L7A7BJbrobqRk0QCPh/b7Xu1vpiMDjYP8+sCqSVyXPprvn5YxX+CkqxafAwHCpgOjI15Z3hKWmpdSWYfwNb9hy650eYfMaPHZhcBfxryVJzoKrO8NLI/mmbeEQfQKb93V9EtNhfn0QFEzKgbvEfe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363885; c=relaxed/simple;
	bh=QZc9gfQ7x/baaNRiBlr5VM7wWc4QWcBKNkajvxGDRuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvN4LSWiYvraCnIqaOOO3UaXuxL7uTBsz8HNGmEBXfZ0AEeeoytaAndw+h/sw884xEVjz4M2qPqT41Nw7QhpFCwNygK9tttGTAdK5dKpF9fxYhGxv+441L2ca5hfVA5Q7RbsM+EaKvIF4U9HL20xNHEMTErRHs0UO1OBWZOx27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hpXZfWeC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iO6lBNr8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hpXZfWeC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iO6lBNr8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hpXZfWeC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iO6lBNr8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hpXZfWeC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iO6lBNr8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D91C71F394;
	Mon, 16 Dec 2024 15:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734363881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yexxc3MNi9KxffMrEX5ASfFRQP4BpBq5chcvzoCTnC0=;
	b=hpXZfWeCcy9AxLbfDU8Xo0BtWgObg082nmytYEuwhFnXVqmbNJDH/+CtSM3X39i0K1iPkK
	q70vIpPGo0B74ZSLxT3TGdMqJ64547jb04jdftrc3rhGpVRbmDiYoeClm8cuyw6FV1awIU
	1auRAmhIDAvpeD3ycgZy3VcuSfSZrMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734363881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yexxc3MNi9KxffMrEX5ASfFRQP4BpBq5chcvzoCTnC0=;
	b=iO6lBNr84nFOCSr2jLSzflcaVWjGpLZwliRtpsDyv1+syrKaZeynpedP/eotNMDqe++VWa
	wyIt76aMEIcHG2Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734363881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yexxc3MNi9KxffMrEX5ASfFRQP4BpBq5chcvzoCTnC0=;
	b=hpXZfWeCcy9AxLbfDU8Xo0BtWgObg082nmytYEuwhFnXVqmbNJDH/+CtSM3X39i0K1iPkK
	q70vIpPGo0B74ZSLxT3TGdMqJ64547jb04jdftrc3rhGpVRbmDiYoeClm8cuyw6FV1awIU
	1auRAmhIDAvpeD3ycgZy3VcuSfSZrMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734363881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yexxc3MNi9KxffMrEX5ASfFRQP4BpBq5chcvzoCTnC0=;
	b=iO6lBNr84nFOCSr2jLSzflcaVWjGpLZwliRtpsDyv1+syrKaZeynpedP/eotNMDqe++VWa
	wyIt76aMEIcHG2Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9D2013418;
	Mon, 16 Dec 2024 15:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y6AJLelKYGcvGwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 16 Dec 2024 15:44:41 +0000
Message-ID: <6fb206de-0185-4026-a6f5-1d150752d8d0@suse.cz>
Date: Mon, 16 Dec 2024 16:44:41 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
Content-Language: en-US
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, "Paul E . McKenney" <paulmck@kernel.org>,
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
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z2BKLzOGv_Ki_7fj@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,linux-foundation.org,vger.kernel.org,linux.com,google.com,lge.com,linux.dev,gmail.com,sony.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 12/16/24 16:41, Uladzislau Rezki wrote:
> On Mon, Dec 16, 2024 at 03:20:44PM +0100, Vlastimil Babka wrote:
>> On 12/16/24 12:03, Uladzislau Rezki wrote:
>> > On Sun, Dec 15, 2024 at 06:30:02PM +0100, Vlastimil Babka wrote:
>> >> On 12/12/24 19:02, Uladzislau Rezki (Sony) wrote:
>> >> > Hello!
>> >> > 
>> >> > This is v2. It is based on the Linux 6.13-rc2. The first version is
>> >> > here:
>> >> > 
>> >> > https://lore.kernel.org/linux-mm/20241210164035.3391747-4-urezki@gmail.com/T/
>> >> > 
>> >> > The difference between v1 and v2 is that, the preparation process is
>> >> > done in original place instead and after that there is one final move.
>> >> 
>> >> Looks good, will include in slab/for-next
>> >> 
>> >> I think patch 5 should add more explanation to the commit message - the
>> >> subthread started by Christoph could provide content :) Can you summarize so
>> >> I can amend the commit log?
>> >> 
>> > I will :)
>> > 
>> >> Also how about a followup patch moving the rcu-tiny implementation of
>> >> kvfree_call_rcu()?
>> >> 
>> > As, Paul already noted, it would make sense. Or just remove a tiny
>> > implementation.
>> 
>> AFAICS tiny rcu is for !SMP systems. Do they benefit from the "full"
>> implementation with all the batching etc or would that be unnecessary overhead?
>> 
> Yes, it is for a really small systems with low amount of memory. I see
> only one overhead it is about driving objects in pages. For a small
> system it can be critical because we allocate.
> 
> From the other hand, for a tiny variant we can modify the normal variant
> by bypassing batching logic, thus do not consume memory(for Tiny case)
> i.e. merge it to a normal kvfree_rcu() path.

Maybe we could change it to use CONFIG_SLUB_TINY as that has similar use
case (less memory usage on low memory system, tradeoff for worse performance).

> After that we do not depend on CONFIG_RCU_TINY option. Probably we need
> also to perform some adaptation of regular kvfree_rcu() for a single CPU
> system.
> 
> --
> Uladzislau Rezki

