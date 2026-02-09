Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903BB328635
	for <rcu@vger.kernel.org>; Mon,  9 Feb 2026 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629927; cv=none; b=h3Op7PbU+gCupxfT2mvmJptQHZOTqXFmIrpz2PDBXiFBASB3itEJpqNKtyNOzKF9JT1REkVFFTd5zQ98WnvYd4gkxZlo2SinVoH6uf1QdDvwHKtMsRELIASPuiO9yddGw8NSjGt3k+aOsjU4kbGmjD0oPKma1F0+9beydP6U0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629927; c=relaxed/simple;
	bh=6fk1plRGtLdqK2lGI65BpEEzjAsJ87tUykHRBu0KQ1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRGIvs8AaPo0dZaSX0Fpl1v1uBpp14dwb16VaHNj4v3LjouOW7+ixIYixg4tx4cgESbWOqtVvcHC7NXUwlrVLUswRTobtMOsRhBsx63Er4mCYaj3p5BrmNoXzQAkn82axaBbDFFAEqDaMXvVRpF1+YF8mEaBJU33Xhf97cLW7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QMazHPSc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hjPCs1Si; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vpgyqBiA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hLPIN9MU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QMazHPSc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hjPCs1Si";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vpgyqBiA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hLPIN9MU"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 865AB5BCD8;
	Mon,  9 Feb 2026 09:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770629924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JAf3pqkFnwq+zdsxVQQtCzWCRKHcpfVHtUf9wwuLw4I=;
	b=QMazHPScT78p8/A5LSY0zf5Gy+ntNYaAa/KDEvAaZOnAAMMo7cMO1AXhXYu6fUzeYfudkA
	ohbandRiORga0tPe56Gl4jv0lN5ERKxGJeARGkJg9DmD22NGNsLlHcdILRVF1lelq6W5ns
	8D7PfWHjLJHkc0YxX3BosNzbOvdznDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770629924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JAf3pqkFnwq+zdsxVQQtCzWCRKHcpfVHtUf9wwuLw4I=;
	b=hjPCs1SiuZlmsnRmm4WuXxzlgIWtcI1+FwmskJMUwsahkuoZ2KgwDN+BGXF9pQu6H2bo4r
	c4cnzNXKNe01/GBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vpgyqBiA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hLPIN9MU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770629923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JAf3pqkFnwq+zdsxVQQtCzWCRKHcpfVHtUf9wwuLw4I=;
	b=vpgyqBiAF59GS8TN0tj1Yw4gD3AFubW2+nvp95OMWMNE0RoW4gl8GaHjOMqeILjreb20hq
	00ZGgX5153b9c8kxfXq7QfLWsg1laWcWqFoW9AFUjp0SlZhVETsWU8YS2GZLWAAXa6vqs/
	L2U14MsiN6/8NfIO/A/QkNJybl2XLY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770629923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JAf3pqkFnwq+zdsxVQQtCzWCRKHcpfVHtUf9wwuLw4I=;
	b=hLPIN9MUGlpFuBJIypL8kyMsuSxsVGSzMW/nK9OcuWkkG/N9PFuCMLKLUFB/bduiIe0pHK
	G0jxZU53UMZRAVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 438E33EA63;
	Mon,  9 Feb 2026 09:38:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QC8kDyOriWnnCgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 09 Feb 2026 09:38:43 +0000
Message-ID: <ebc2eb77-722d-4966-8376-f11607de53c2@suse.cz>
Date: Mon, 9 Feb 2026 10:38:42 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/7] mm/slab: free a bit in enum objexts_flags
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>
References: <20260206093410.160622-1-harry.yoo@oracle.com>
 <20260206093410.160622-5-harry.yoo@oracle.com>
 <CAADnVQ+rNYeb5Pu2aHRVc+hYDeAF5t19MVwzXsyn2HkOuLPNLg@mail.gmail.com>
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
In-Reply-To: <CAADnVQ+rNYeb5Pu2aHRVc+hYDeAF5t19MVwzXsyn2HkOuLPNLg@mail.gmail.com>
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
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,oracle.com:email,suse.cz:dkim,suse.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[32];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,gentwo.org,google.com,linux.dev,cmpxchg.org,kernel.org,gmail.com,arm.com,nvidia.com,joshtriplett.org,goodmis.org,efficios.com,fromorbit.com,bytedance.com,vger.kernel.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLo39o19myzc71a6h1g6fiybuc)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 865AB5BCD8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 2/6/26 21:09, Alexei Starovoitov wrote:
> On Fri, Feb 6, 2026 at 1:35 AM Harry Yoo <harry.yoo@oracle.com> wrote:
>>
>> Since kfree() now supports freeing objects allocated with
>> kmalloc_nolock(), free one bit in enum object_flags.
>>
>> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> 
> For patches 3 and 4:
> 
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> 
> I think patches 3 and 4 are ready.
> Would be great to land them for this merge window
> (if Vlastimil agrees).

We should have an ack from Catalin for kmemleak. Also better take them out
of the RFC and send as 2 non-rfc patches first, with cc list reduced
accordingly etc.

Then I can put them to -next and try sending second merge window PR next
week. Can you also point to any bug reports that would be fixed? (that you
had to work around or delay merging or something) that would help the
argument to not wait a cycle.

> Patch 3 is tiny, but the impact is huge and
> patch 4 is a very nice cleanup.
> If we land it now we can start using kfree_rcu() on bpf side
> in the next release cycle. That will help us a lot.

