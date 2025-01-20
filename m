Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95514830F;
	Mon, 20 Jan 2025 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737410780; cv=none; b=UBpyG2RFlpF7/Vs/y8wiPmd3i7Tub0LFmvEd3whAruITyVQG/MWZKW2T0Lv28F+0rwiMRyWDbAbF2dDJk4vyaaIyiyjBN5FVIVlrK1/q0+KUmZZzgVZTv2bs7vvQi+Q0AcjFnyOxeN210umv5UIJsVifGhGixJ5ewk9Rnrp9ZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737410780; c=relaxed/simple;
	bh=4XU35kECN/h6l0C0DXCNRQARjIf3f7RXpY1RwT9LVpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7uRJN2ENOceCaSJwsFt66eZzlQZdSeUT2aaylh/CsK136luL2xd99PQgVgpWy7Db6rixADp4nHXCtpQ9qfm2mRwp3cCcKMa8LeqoKqneHIJC/qGEMVZdehytWMf94QD1aPaZyHcSjMT5ZGagKBBax2vT+7E8HvJHqzZ42f7qoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pjbLn1ee; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aHywZC/6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pjbLn1ee; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aHywZC/6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pjbLn1ee";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aHywZC/6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pjbLn1ee";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aHywZC/6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E7671F7D8;
	Mon, 20 Jan 2025 22:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737410774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DTLjdPmT0LTN5fwk6pwn8UsoA4oH6zmI/RGxKsg1g/4=;
	b=pjbLn1eeRpFAqFdin+q7KswJs3TbrlQSi8272cGyE3aBSA/gpnYNNmi1xtFZzhqhkf/DBp
	beTLDUwV+c5RyyK5CiFFUmysHXr6W8kAyrcItxQIsLJxsZaz1kEweqtF986eXk9bdJPslv
	Z5kKbhdf9fQHip5QdNIcnJzxPQLpang=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737410774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DTLjdPmT0LTN5fwk6pwn8UsoA4oH6zmI/RGxKsg1g/4=;
	b=aHywZC/6tvSe/XMErmMQGU4kqHNhWnW0SRP+1T5V/6OMa9DKn0rn7/2huCHD4Lx0SBBAwO
	i0cTriirg7x94PBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pjbLn1ee;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="aHywZC/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737410774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DTLjdPmT0LTN5fwk6pwn8UsoA4oH6zmI/RGxKsg1g/4=;
	b=pjbLn1eeRpFAqFdin+q7KswJs3TbrlQSi8272cGyE3aBSA/gpnYNNmi1xtFZzhqhkf/DBp
	beTLDUwV+c5RyyK5CiFFUmysHXr6W8kAyrcItxQIsLJxsZaz1kEweqtF986eXk9bdJPslv
	Z5kKbhdf9fQHip5QdNIcnJzxPQLpang=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737410774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DTLjdPmT0LTN5fwk6pwn8UsoA4oH6zmI/RGxKsg1g/4=;
	b=aHywZC/6tvSe/XMErmMQGU4kqHNhWnW0SRP+1T5V/6OMa9DKn0rn7/2huCHD4Lx0SBBAwO
	i0cTriirg7x94PBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20F6C1393E;
	Mon, 20 Jan 2025 22:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Icm4B9bIjmcNVAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 20 Jan 2025 22:06:14 +0000
Message-ID: <55931fdd-1d5f-4ffd-8496-fe436171dee2@suse.cz>
Date: Mon, 20 Jan 2025 23:06:13 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
Content-Language: en-US
To: paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20241212180208.274813-1-urezki@gmail.com>
 <17476947-d447-4de3-87bb-97d5f3c0497d@suse.cz> <Z2AJCI3cIR9ETFFu@pc636>
 <d352db4f-4bb8-4300-b235-bbd1bdb3aa21@suse.cz> <Z2BKLzOGv_Ki_7fj@pc636>
 <6fb206de-0185-4026-a6f5-1d150752d8d0@suse.cz> <Z2BNWpkruY6rJv6A@pc636>
 <5bb80786-220d-45d2-bd35-51876df4203c@paulmck-laptop>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <5bb80786-220d-45d2-bd35-51876df4203c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3E7671F7D8
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,vger.kernel.org,linux.com,kernel.org,google.com,lge.com,linux.dev,gmail.com,sony.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 12/16/24 17:46, Paul E. McKenney wrote:
> On Mon, Dec 16, 2024 at 04:55:06PM +0100, Uladzislau Rezki wrote:
>> On Mon, Dec 16, 2024 at 04:44:41PM +0100, Vlastimil Babka wrote:
>> > On 12/16/24 16:41, Uladzislau Rezki wrote:
>> > > On Mon, Dec 16, 2024 at 03:20:44PM +0100, Vlastimil Babka wrote:
>> > >> On 12/16/24 12:03, Uladzislau Rezki wrote:
>> > >> > On Sun, Dec 15, 2024 at 06:30:02PM +0100, Vlastimil Babka wrote:
>> > >> > 
>> > >> >> Also how about a followup patch moving the rcu-tiny implementation of
>> > >> >> kvfree_call_rcu()?
>> > >> >> 
>> > >> > As, Paul already noted, it would make sense. Or just remove a tiny
>> > >> > implementation.
>> > >> 
>> > >> AFAICS tiny rcu is for !SMP systems. Do they benefit from the "full"
>> > >> implementation with all the batching etc or would that be unnecessary overhead?
>> > >> 
>> > > Yes, it is for a really small systems with low amount of memory. I see
>> > > only one overhead it is about driving objects in pages. For a small
>> > > system it can be critical because we allocate.
>> > > 
>> > > From the other hand, for a tiny variant we can modify the normal variant
>> > > by bypassing batching logic, thus do not consume memory(for Tiny case)
>> > > i.e. merge it to a normal kvfree_rcu() path.
>> > 
>> > Maybe we could change it to use CONFIG_SLUB_TINY as that has similar use
>> > case (less memory usage on low memory system, tradeoff for worse performance).
>> > 
>> Yep, i also was thinking about that without saying it :)
> 
> Works for me as well!

Hi, so I tried looking at this. First I just moved the code to slab as seen
in the top-most commit here [1]. Hope the non-inlined __kvfree_call_rcu() is
not a show-stopper here.

Then I wanted to switch the #ifdefs from CONFIG_TINY_RCU to CONFIG_SLUB_TINY
to control whether we use the full blown batching implementation or the
simple call_rcu() implmentation, and realized it's not straightforward and
reveals there are still some subtle dependencies of kvfree_rcu() on RCU
internals :)

Problem 1: !CONFIG_SLUB_TINY with CONFIG_TINY_RCU

AFAICS the batching implementation includes kfree_rcu_scheduler_running()
which is called from rcu_set_runtime_mode() but only on TREE_RCU. Perhaps
there are other facilities the batching implementation needs that only
exists in the TREE_RCU implementation

Possible solution: batching implementation depends on both !CONFIG_SLUB_TINY
and !CONFIG_TINY_RCU. I think it makes sense as both !SMP systems and small
memory systems are fine with the simple implementation.

Problem 2: CONFIG_TREE_RCU with !CONFIG_SLUB_TINY

AFAICS I can't just make the simple implementation do call_rcu() on
CONFIG_TREE_RCU, because call_rcu() no longer knows how to handle the fake
callback (__is_kvfree_rcu_offset()) - I see how rcu_reclaim_tiny() does that
but no such equivalent exists in TREE_RCU. Am I right?

Possible solution: teach TREE_RCU callback invocation to handle
__is_kvfree_rcu_offset() again, perhaps hide that branch behind #ifndef
CONFIG_SLUB_TINY to avoid overhead if the batching implementation is used.
Downside: we visibly demonstrate how kvfree_rcu() is not purely a slab thing
but RCU has to special case it still.

Possible solution 2: instead of the special offset handling, SLUB provides a
callback function, which will determine pointer to the object from the
pointer to a middle of it without knowing the rcu_head offset.
Downside: this will have some overhead, but SLUB_TINY is not meant to be
performant anyway so we might not care.
Upside: we can remove __is_kvfree_rcu_offset() from TINY_RCU as well

Thoughts?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-tiny-kfree_rcu
