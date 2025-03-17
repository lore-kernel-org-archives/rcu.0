Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634323314E
	for <rcu@vger.kernel.org>; Mon, 17 Mar 2025 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209739; cv=none; b=pQvw/x8TAHaAjjIgENTV6y9T2KJ0/cFFp92Sz27npBEt8XZ4u8AqRXcTT8JGh/2locFrSnqzuGQPwzM50a/PvGqWiYGbvFk9cq5VYz1udJ0Y+63g+JOTkEpcgpwKlYf2rIZS5ePDrQpUTr/tKaO/Cwsyjq5ZbHdwk3mdube75ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209739; c=relaxed/simple;
	bh=tWtg1QWw/sSvhu0Irttbs6EX4vmu0Sl///oymLht61s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CR577RdRMGXrt8aiy+i5hLDHAjGg9P1uAvWKUIV80JtQ6UaBMbQR/BNUwwf+0QSztHXGJj7OMDJu9wFlejUklbZ0qfZ5TUgk6MZzd9SJpKXEEBeTwp1yBF6w61X1eOnV6HXSletoF+iL/ArerGYzobX4jAhqhV9oQEYFIuJ1v+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hwWjiKe4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B0T0sJOJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hwWjiKe4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B0T0sJOJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hwWjiKe4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B0T0sJOJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hwWjiKe4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B0T0sJOJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1614B21C94;
	Mon, 17 Mar 2025 11:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742209736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/DK9r72Uol6zgQzU2gC1hGvx4LoRdqfQlA9txMt/Pg=;
	b=hwWjiKe4+VhV/uDqgYQCVtEp6iPqo//Gghh2Uclg9qsm7CAW8y0WUk79lIYOspdCGfXHZn
	Nu0S8yFRFhO4C+KgjopzH1DTSjODZdQQIMkGWvI02CogM/wqPNyRwXr8RyAyiVOhlN5Jeh
	qGoPQtIzNCueZaEocPQnQKesdqcwO5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742209736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/DK9r72Uol6zgQzU2gC1hGvx4LoRdqfQlA9txMt/Pg=;
	b=B0T0sJOJKeCFIJiQ4OJAT4s4s29ghj+674SrtqIOwEIIjprm/G+NqeTzcHYSdZBnIQYexW
	bOyFuPBtCepgkJCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hwWjiKe4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B0T0sJOJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742209736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/DK9r72Uol6zgQzU2gC1hGvx4LoRdqfQlA9txMt/Pg=;
	b=hwWjiKe4+VhV/uDqgYQCVtEp6iPqo//Gghh2Uclg9qsm7CAW8y0WUk79lIYOspdCGfXHZn
	Nu0S8yFRFhO4C+KgjopzH1DTSjODZdQQIMkGWvI02CogM/wqPNyRwXr8RyAyiVOhlN5Jeh
	qGoPQtIzNCueZaEocPQnQKesdqcwO5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742209736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/DK9r72Uol6zgQzU2gC1hGvx4LoRdqfQlA9txMt/Pg=;
	b=B0T0sJOJKeCFIJiQ4OJAT4s4s29ghj+674SrtqIOwEIIjprm/G+NqeTzcHYSdZBnIQYexW
	bOyFuPBtCepgkJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E85FA139D2;
	Mon, 17 Mar 2025 11:08:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e+QlOMcC2GfnLgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 17 Mar 2025 11:08:55 +0000
Message-ID: <e728af67-4f7b-43ef-8fe5-0eec4064c625@suse.cz>
Date: Mon, 17 Mar 2025 12:08:55 +0100
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
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd>
 <CAJuCfpHi4Od4K2xQEUFWuG=a4zCKecWBMwBiy_7mVn6QgsTSvA@mail.gmail.com>
 <CAJuCfpEq8P4cz7HXaRVqaagONPBKrFgOSqdigEYU60sGAE4-rg@mail.gmail.com>
 <173d4dbe-399d-4330-944c-9689588f18e8@suse.cz>
 <CAJuCfpHHXYKGjaOxHcuJcuQbUVO7YqLMpcYeF3HM5Ayxy1fE+g@mail.gmail.com>
 <CAJuCfpE7t83PKWw+8XJLE5538kKJnbhirLg2siDSw=F4sw=9uA@mail.gmail.com>
 <19df9218-c984-4cbc-8b5d-4e0f7658935f@suse.cz>
 <ape445nrqgod4ivtzcwacmfdshi3fgcqmmu54iascbjsk3sluo@w4jjihiz5jzr>
 <CAJuCfpFVopL+sMdU4bLRxs+HS_WPCmFZBdCmwE8qV2Dpa5WZnA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpFVopL+sMdU4bLRxs+HS_WPCmFZBdCmwE8qV2Dpa5WZnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1614B21C94
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
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[google.com,oracle.com,linux.dev,linux.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,linutronix.de,kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/14/25 18:10, Suren Baghdasaryan wrote:
> On Tue, Mar 4, 2025 at 11:08 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>>
>> * Vlastimil Babka <vbabka@suse.cz> [250304 05:55]:
>> > On 2/25/25 21:26, Suren Baghdasaryan wrote:
>> > > On Mon, Feb 24, 2025 at 1:12 PM Suren Baghdasaryan <surenb@google.com> wrote:
>> > >>
>> > >> >
>> > >> > > The values represent the total time it took to perform mmap syscalls, less is
>> > >> > > better.
>> > >> > >
>> > >> > > (1)                  baseline       control
>> > >> > > Little core       7.58327       6.614939 (-12.77%)
>> > >> > > Medium core  2.125315     1.428702 (-32.78%)
>> > >> > > Big core          0.514673     0.422948 (-17.82%)
>> > >> > >
>> > >> > > (2)                  baseline      control
>> > >> > > Little core       7.58327       5.141478 (-32.20%)
>> > >> > > Medium core  2.125315     0.427692 (-79.88%)
>> > >> > > Big core          0.514673    0.046642 (-90.94%)
>> > >> > >
>> > >> > > (3)                   baseline      control
>> > >> > > Little core        7.58327      4.779624 (-36.97%)
>> > >> > > Medium core   2.125315    0.450368 (-78.81%)
>> > >> > > Big core           0.514673    0.037776 (-92.66%)
>> > >
>> > > (4)                   baseline      control
>> > > Little core        7.58327      4.642977 (-38.77%)
>> > > Medium core   2.125315    0.373692 (-82.42%)
>> > > Big core           0.514673    0.043613 (-91.53%)
>> > >
>> > > I think the difference between (3) and (4) is noise.
>> > > Thanks,
>> > > Suren.
>> >
>> > Hi, as we discussed yesterday, it would be useful to set the baseline to
>> > include everything before sheaves as that's already on the way to 6.15, so
>> > we can see more clearly what sheaves do relative to that. So at this point
>> > it's the vma lock conversion including TYPESAFE_BY_RCU (that's not undone,
>> > thus like in scenario (4)), and benchmark the following:
>> >
>> > - baseline - vma locking conversion with TYPESAFE_BY_RCU
>> > - baseline+maple tree node reduction from mm-unstable (Liam might point out
>> > which patches?)
>>
>> Sid's patches [1] are already in mm-unstable.
>>
>>
>> > - the above + this series + sheaves enabled for vm_area_struct cache
>> > - the above + full maple node sheaves conversion [1]
>> > - the above + the top-most patches from [1] that are optimizations with a
>> > tradeoff (not clear win-win) so it would be good to know if they are useful
>> >
>> > [1] currently the 4 commits here:
>> > https://web.git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-percpu-sheaves-v2-maple
>> > from "maple_tree: Sheaf conversion" to "maple_tree: Clean up sheaf"
>> > but as Liam noted, they won't cherry pick without conflict once maple tree
>> > node reduction is backported, but he's working on a rebase
>>
>> Rebased maple tree sheaves, patches are here [2].
> 
> Hi Folks,
> Sorry for the delay. I got the numbers last week but they looked a bit
> weird, so I reran the test increasing the number of iterations to make
> sure noise is not a factor. That took most of this week. Below are the
> results. Please note that I had to backport the patchsets to 6.12
> because that's the closest stable Android kernel I can use. I measure
> cumulative time to execute mmap syscalls, so the smaller the number
> the better mmap performance is:

Is that a particular benchmark doing those syscalls, or you time them within
actual workloads?

> baseline: 6.12 + vm_lock conversion and TYPESAFE_BY_RCU
> config1: baseline + Sid's patches [1]
> config2: sheaves RFC
> config3: config1 + vm_area_struct with sheaves
> config4: config2 + maple_tree Sheaf conversion [2]
> config5: config3 + 2 last optimization patches from [3]
> 
>                config1     config2     config3     config4     config5
> Little core    -0.10%      -10.10%     -12.89%     -10.02%     -13.64%
> Mid core       -21.05%     -37.31%     -44.97%     -15.81%     -22.15%
> Big core       -17.17%     -34.41%     -45.68%     -11.39%     -15.29%

Thanks a lot, Suren.

> [1] https://lore.kernel.org/linux-mm/20250227204823.758784-1-sidhartha.kumar@oracle.com/
> [2] https://www.infradead.org/git/?p=users/jedix/linux-maple.git;a=shortlog;h=refs/heads/sheaves_rebase_20250304
> [3] https://web.git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-percpu-sheaves-v2-maple
> 
> From the numbers, it looks like config4 regresses the performance and
> that's what looked weird to me last week and I wanted to confirm this.
> But from sheaves POV, it looks like they provide the benefits I saw
> before. Sid's patches which I did not test separately before also look
> beneficial.

Indeed, good job, Sid. It's weird that config4 isn't doing well. The problem
can be either in sheaves side (the sheaves preallocation isn't effective) or
maple tree side doing some excessive work. It could be caused by the wrong
condition in kmem_cache_return_sheaf() that Harry pointed out, so v3 might
improve if that was it. Otherwise we'll probably need to fill the gaps in
sheaf-related stats and see what are the differences between config3 and
config4.

> Thanks,
> Suren.
> 
>>
>>
>> >
>> >
>> ...
>>
>> Thanks,
>> Liam
>>
>> [1]. https://lore.kernel.org/linux-mm/20250227204823.758784-1-sidhartha.kumar@oracle.com/
>> [2]. https://www.infradead.org/git/?p=users/jedix/linux-maple.git;a=shortlog;h=refs/heads/sheaves_rebase_20250304

