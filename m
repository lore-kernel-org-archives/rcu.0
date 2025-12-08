Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFF12D0C9C
	for <rcu@vger.kernel.org>; Mon,  8 Dec 2025 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765219906; cv=none; b=r2t82y2uNZOwPare6xdpd4i2t05/FNnXj/+3r5OuZMxaqtH1+us97hXg2Ld3vGK2IZfzfHNc6/rWaOv8HdaOBhVZ9A1TjnVzBfc7hs5bVXX1V38fjVE+QKPe6DW7RjqP4+kE18ncldWdRreeJhSUUGzNcXmhKss4Yf/q/aisv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765219906; c=relaxed/simple;
	bh=9+WjJTyydZVqcja//nLSETNwDSz9bOpoRhHRXv6mu0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjCtl2QlHdfCbqthsTYKP9mqhhCU7JVBmMnt9N9U2sRyQueEPFOTvT9C0nHT60EYHUbeFmo7bPZ9Jyw7VA1OLaqdj6IVaR9cTPFHzYFE4+x7wFLICJF37I7Z8nJLHCzvK0yiunQutkN6HFqkdeUH5bX9RAx6erZM847YsHacwwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yxThk8gk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wf5ui1/J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHjnvjZV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SFv1yVid; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yxThk8gk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wf5ui1/J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHjnvjZV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SFv1yVid"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 53B8B336EB;
	Mon,  8 Dec 2025 18:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765219902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OT9U1O6MPkV0s0UVcm6zY8yzl1v0YkCWdNdw5gdDNjA=;
	b=yxThk8gk86zoC2di0Dcp8fc3VFWI0MSyY5X/RnqgfqRDw5iRJ2ngr5Lp9GipVHl/MCjW/T
	DMxk6QGm1Bcs4DH6ZjBdIA+/jkiuABGbzoKKFHbvULUjL6PF5z7B7OFXWgOvnZmL1t6aAu
	DsnC5WIrx9a4LqSzbUKe0T7LEPwQqwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765219902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OT9U1O6MPkV0s0UVcm6zY8yzl1v0YkCWdNdw5gdDNjA=;
	b=wf5ui1/JpFhjQZztBZ8gmw+3PWJgrsZa+7eh+dHU1tDDeGR7yaZCBYySS/ankKCU5W/bF2
	BpyqOx0LZMIhgvDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rHjnvjZV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SFv1yVid
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765219901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OT9U1O6MPkV0s0UVcm6zY8yzl1v0YkCWdNdw5gdDNjA=;
	b=rHjnvjZVrGZZ++G4kf7VxLK0u0+AwezkVg64andcftrMzAQk2Y8aRXU4Ix7w7Fn1t8gJqT
	khYC7Zg7bs6L/ku4fwKbeLYhAYkT514y7gvKgXf/7JN271W4cht9SxWBYtf5Dlj04VvXgC
	Ll1UPSfMe/oQoENX1FZuorFFY/S/ZII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765219901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OT9U1O6MPkV0s0UVcm6zY8yzl1v0YkCWdNdw5gdDNjA=;
	b=SFv1yVid4EKrbgMbA9lUsRFzf1v2IaL3O2UcUzSEZOCQQ+TFfSRs4RHvZs64pSEZo2BRqV
	ry1B/a7ZKI+z1WAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37D8B3EA63;
	Mon,  8 Dec 2025 18:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LLRDDT0eN2nxKgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 08 Dec 2025 18:51:41 +0000
Message-ID: <8bbbaa65-2783-4006-97b4-a1628525e7c7@suse.cz>
Date: Mon, 8 Dec 2025 19:51:40 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: slub: add barn_get_full_sheaf() and refine empty-main sheaf
 replacement
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, Hao Li <haoli.tcs@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
 <lvagftdnxgpyafafl2ish6x6phno6xstd6r3zxffs652lyxzyc@2pbngufu7wro>
 <aS_OrvHmgyhQzQIj@hyeyoo>
 <dq67tbm6bbvm7opvuq5vwtjjrcnrponmhfv7xwnvpv6vp3u2lv@bkruq4dtx3rd>
 <aTWIQ0s3EbOa0azX@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aTWIQ0s3EbOa0azX@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,oracle.com,gentwo.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,linux.ibm.com];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 53B8B336EB
X-Spam-Flag: NO
X-Spam-Score: -3.01

On 12/7/25 14:59, Harry Yoo wrote:
> On Wed, Dec 03, 2025 at 07:15:12PM +0800, Hao Li wrote:
>> On Wed, Dec 03, 2025 at 02:46:22PM +0900, Harry Yoo wrote:
>> > On Tue, Dec 02, 2025 at 05:00:08PM +0800, Hao Li wrote:
>> > > Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
>> > > the per-node barn without requiring an empty sheaf in exchange.
>> > > 
>> > > Use this helper in __pcs_replace_empty_main() to change how an empty main
>> > > per-CPU sheaf is handled:
>> > > 
>> > >   - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
>> > >     full sheaf from the barn via barn_get_full_sheaf(). On success, park
>> > >     the empty main sheaf in pcs->spare and install the full sheaf as the
>> > >     new pcs->main.
>> > > 
>> > >   - If pcs->spare already exists and has objects, keep the existing
>> > >     behavior of simply swapping pcs->main and pcs->spare.
>> > > 
>> > >   - Only when both pcs->main and pcs->spare are empty do we fall back to
>> > >     barn_replace_empty_sheaf() and trade the empty main sheaf into the
>> > >     barn in exchange for a full one.
>> > 
>> > Hi Hao,
>> > 
>> > Yeah this is a very subtle difference between __pcs_replace_full_main()
>> > and __pcs_replace_empty_main(), that the former installs the full main
>> > sheaf in pcs->spare, while the latter replaces the empty main sheaf with
>> > a full sheaf from the barn without populating pcs->spare.
>> 
>> Exactly.
>> 
>> > Is it intentional, Vlastimil?
> 
> Let's first see if Vlastimil had an intention, and...

Hm I don't think I aimed to make this difference on purpose, but I didn't
also aim to make the alloc/free paths completely symmetric. Rather the goal
was just to do what seemed the best option in each situation. And probably
getting a full sheaf and populating spare never seemed to be an important
case to warrant the extra code for a situation that's only transient after
boot (see below).

>> > > This makes the empty-main path more symmetric with __pcs_replace_full_main(),
>> > > which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
>> > > empty sheaf from the barn. It also matches the documented design more closely:
>> > > 
>> > >   "When both percpu sheaves are found empty during an allocation, an empty
>> > >    sheaf may be replaced with a full one from the per-node barn."
>> > 
>> > I'm not convinced that this change is worthwhile by adding more code;
>> > you probably need to make a stronger argument for why it should be done.
>> 
>> Hi Harry,
>> 
>> Let me explain my intuition in more detail.
>> 
>> Previously, when pcs->main was empty and pcs->spare was NULL, we used
>> barn_replace_empty_sheaf() to trade the empty main sheaf into the barn
>> in exchange for a full one. As a result, pcs->main became full, but
>> pcs->spare remained NULL. Later, when frees filled pcs->main again,
>> __pcs_replace_full_main() had to call into the barn to obtain an empty
>> sheaf, because there was still no local spare to use.

As Harry suggests, that assumes a specific pattern where we exhaust main
sheaf first and then we fill it fully back. But even then this can only
happen once per cpu and then we have populated the spare and are very
unlikely to run into this situation again.

Also it's unlikely that full sheaves even exist in the barn during this
early stage when we would request them. That assumes cpus behave differently
and some have returned full sheaves to the barn before other cpus have
consumed their first full sheaf and request another.

More likely both barn_replace_empty_sheaf() and barn_get_empty_sheaf() will
fail and we do alloc_full_sheaf(). And then... I think I can see an issue in
__pcs_replace_empty_main() that's more likely to be suboptimal than the lack
of symmetry you point out. When we reach the last part below "we can reach
here only when gfpflags_allow_blocking..." and we have empty pcs->main, a
full sheaf from alloc_full_sheaf() and no spare, we should be doing
"pcs->spare = pcs->main" and not barn_put_empty_sheaf(). Right? This is what
can delay populating the spare more likely I think.

>> With this patch, when pcs->main is empty and pcs->spare is NULL,
>> __pcs_replace_empty_main() instead uses barn_get_full_sheaf() to pull a
>> full sheaf from the barn while keeping the now‑empty main sheaf locally
>> as pcs->spare. The next time pcs->main becomes full,
>> __pcs_replace_full_main() can simply swap main and spare, with no barn
>> operations and no need to allocate a new empty sheaf.
> 
> I'm not still sure that either way is superior, as it really depends on
> the alloc/free pattern. If the CPU keeps allocating more objects, keeping
> the empty sheaf is unnecessary, but we don't know what the alloc/free
> pattern will be.

Yeah.

> So strong opinion from me, but I think it'd be better make
> __pcs_replace_{full,empty}_main() handle it consistently,
> if there is no special intention.

I'd rather see some numbers. But the suboptimality pointed out above is more
obvious to me. Do you agree and want to send a patch? :)

>> In other words, although we still need one barn operation when main
>> first becomes empty in __pcs_replace_empty_main(), we avoid a future
>> barn operation on the subsequent “main full” path in
>> __pcs_replace_full_main.
>> 
>> Thanks.
>> 
>> > 
>> > > Signed-off-by: Hao Li <haoli.tcs@gmail.com>
> 

