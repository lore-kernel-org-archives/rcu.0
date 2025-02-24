Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC62512D3
	for <rcu@vger.kernel.org>; Mon, 24 Feb 2025 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430395; cv=none; b=qh1lK8y95gRsCb+Tn3WZ1aljgsme6ltroII9dMeCFxnT7c8PUfy7C1owU9qiWZwk7RLYjJGUBYq6JNZlHr/W5GwQwOXX5wG6fLgQ130CPBmGtzjYSXWdppNGjExR7DwY3U/nUv2p71Jnvk0XTlGK2On2fND5NG/3GMJhNJHHzQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430395; c=relaxed/simple;
	bh=fH5K5cT4slfPgNSl4Lqh0gMntLBBPKKNUKXeVN+SX10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFoLGuFFf6C/5RVcWj3N16fD3n63NArQ92SrSfuhbbTbGU8HUAKBEHcn5imuyYA3rOlT5GRsA63+ss4563t5NGiOF8bctlbC3oOFzL8WCqIHfZpOIK8XkMUa0ehEzxgQXwoEqdprQFKkb95sbYJkw+yUQcEV5ApZQWjsSETdv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KN9+CLAD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H2YYL45L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KN9+CLAD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H2YYL45L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KN9+CLAD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H2YYL45L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KN9+CLAD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H2YYL45L"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74B4B1F44E;
	Mon, 24 Feb 2025 20:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740430391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qJOXvzmoxen8Yfe4DbyjOI0SBc1bw6aCP1zccs3V4bI=;
	b=KN9+CLADZxRzmzLwqO9felhSgKzpKKlXBV04+iU3jz++H7SDJNM7lw2YsMVV01buDOKaXn
	j6Pt+f7nAdOQDcbCtpmdrmdkEJRXh3+41ai+OaWK00KSZUDQum6xOiGLTYDcML9wuURr/F
	KmEPWY7qcozMYheuAPROkxfHySMIe/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740430391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qJOXvzmoxen8Yfe4DbyjOI0SBc1bw6aCP1zccs3V4bI=;
	b=H2YYL45LjH73GwXFtIlFSuweY7V1MAUcmN5B+Wp42XyKlgvpLO4l/mezSLykb4RE766y7F
	+o5FaOIB7Mj/UqAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KN9+CLAD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=H2YYL45L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740430391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qJOXvzmoxen8Yfe4DbyjOI0SBc1bw6aCP1zccs3V4bI=;
	b=KN9+CLADZxRzmzLwqO9felhSgKzpKKlXBV04+iU3jz++H7SDJNM7lw2YsMVV01buDOKaXn
	j6Pt+f7nAdOQDcbCtpmdrmdkEJRXh3+41ai+OaWK00KSZUDQum6xOiGLTYDcML9wuURr/F
	KmEPWY7qcozMYheuAPROkxfHySMIe/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740430391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qJOXvzmoxen8Yfe4DbyjOI0SBc1bw6aCP1zccs3V4bI=;
	b=H2YYL45LjH73GwXFtIlFSuweY7V1MAUcmN5B+Wp42XyKlgvpLO4l/mezSLykb4RE766y7F
	+o5FaOIB7Mj/UqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55BAD13332;
	Mon, 24 Feb 2025 20:53:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CvOMFDfcvGcJQAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 24 Feb 2025 20:53:11 +0000
Message-ID: <173d4dbe-399d-4330-944c-9689588f18e8@suse.cz>
Date: Mon, 24 Feb 2025 21:53:11 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd>
 <CAJuCfpHi4Od4K2xQEUFWuG=a4zCKecWBMwBiy_7mVn6QgsTSvA@mail.gmail.com>
 <CAJuCfpEq8P4cz7HXaRVqaagONPBKrFgOSqdigEYU60sGAE4-rg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAJuCfpEq8P4cz7HXaRVqaagONPBKrFgOSqdigEYU60sGAE4-rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 74B4B1F44E
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.com,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,linutronix.de,kernel.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/24/25 02:36, Suren Baghdasaryan wrote:
> On Sat, Feb 22, 2025 at 8:44 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> Don't know about this particular part but testing sheaves with maple
>> node cache and stress testing mmap/munmap syscalls shows performance
>> benefits as long as there is some delay to let kfree_rcu() do its job.
>> I'm still gathering results and will most likely post them tomorrow.

Without such delay, the perf is same or worse?

> Here are the promised test results:
> 
> First I ran an Android app cycle test comparing the baseline against sheaves
> used for maple tree nodes (as this patchset implements). I registered about
> 3% improvement in app launch times, indicating improvement in mmap syscall
> performance.

There was no artificial 500us delay added for this test, right?

> Next I ran an mmap stress test which maps 5 1-page readable file-backed
> areas, faults them in and finally unmaps them, timing mmap syscalls.
> Repeats that 200000 cycles and reports the total time. Average of 10 such
> runs is used as the final result.
> 3 configurations were tested:
> 
> 1. Sheaves used for maple tree nodes only (this patchset).
> 
> 2. Sheaves used for maple tree nodes with vm_lock to vm_refcnt conversion [1].
> This patchset avoids allocating additional vm_lock structure on each mmap
> syscall and uses TYPESAFE_BY_RCU for vm_area_struct cache.
> 
> 3. Sheaves used for maple tree nodes and for vm_area_struct cache with vm_lock
> to vm_refcnt conversion [1]. For the vm_area_struct cache I had to replace
> TYPESAFE_BY_RCU with sheaves, as we can't use both for the same cache.

Hm why we can't use both? I don't think any kmem_cache_create check makes
them exclusive? TYPESAFE_BY_RCU only affects how slab pages are freed, it
doesn't e.g. delay reuse of individual objects, and caching in a sheaf
doesn't write to the object. Am I missing something?

> The values represent the total time it took to perform mmap syscalls, less is
> better.
> 
> (1)                  baseline       control
> Little core       7.58327       6.614939 (-12.77%)
> Medium core  2.125315     1.428702 (-32.78%)
> Big core          0.514673     0.422948 (-17.82%)
> 
> (2)                  baseline      control
> Little core       7.58327       5.141478 (-32.20%)
> Medium core  2.125315     0.427692 (-79.88%)
> Big core          0.514673    0.046642 (-90.94%)
> 
> (3)                   baseline      control
> Little core        7.58327      4.779624 (-36.97%)
> Medium core   2.125315    0.450368 (-78.81%)
> Big core           0.514673    0.037776 (-92.66%)
> 
> Results in (3) vs (2) indicate that using sheaves for vm_area_struct
> yields slightly better averages and I noticed that this was mostly due
> to sheaves results missing occasional spikes that worsened
> TYPESAFE_BY_RCU averages (the results seemed more stable with
> sheaves).

Thanks a lot, that looks promising!

> [1] https://lore.kernel.org/all/20250213224655.1680278-1-surenb@google.com/
> 

