Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6D1FCF72
	for <rcu@vger.kernel.org>; Tue,  4 Mar 2025 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085702; cv=none; b=IIEBRW9KxyMxeo0cav++PxvsHGtiUuv8H0m5jtbDtV0VVSCKgEw1534unLJBPPxNFMT9cceu8B0ayBXUdGqj9yuO0um2Qi6UkQuGsONE66Jdi/LFFDNUkt/3bOvLDKHtPqIwiAQDzcC9Ybg3TwA3c1SsQGhf3ZX8rLNM/J64/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085702; c=relaxed/simple;
	bh=PMup+WsIQnQifzoxT6kN3Bx4jt7qmX2BCLcUlW05gSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C07QsAjBw8NfxVG5C6wcg5tdlDD988p+TNknavX/rHBPwbGl6yAlhc/iTySE+o9yBB0BeY8QbE9X/Q8JFOjNdZkHtZdUT/LJ03smS54YvZzMsh+v/WuKdPWZc7H3/CY+30Z3b+PGY63NeoaKSp0iY0/tUqSTZrQ+gm85wMl2BjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qHwIcoG+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JnMXtkX8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qHwIcoG+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JnMXtkX8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qHwIcoG+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JnMXtkX8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qHwIcoG+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JnMXtkX8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4143321187;
	Tue,  4 Mar 2025 10:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741085699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EO9kVHSdTHn2fWrMycpwAcQb5rp2wiW+HXpcxpE+EdM=;
	b=qHwIcoG+3IwI3t1Ze7bqX4B6nFBEhJSjc6MEkonUdJvXCOE4qS2JUmYaOxaAE58wycI3kP
	8FwCa7LCbUU1NWHglejxHSiaYMLKAsDsQWEnlQCeBFrMqz/F+7BcSZXYyt40shFN/7p6LC
	79BEhLo0S/kwWX7RkNjmmu+GG19aofQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741085699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EO9kVHSdTHn2fWrMycpwAcQb5rp2wiW+HXpcxpE+EdM=;
	b=JnMXtkX8m+6WvVVH4zhb5aYrnrYlFy0yGKs239TMdq1eK0JvUU63WtLur6QGUYpQORhVai
	t0PgHH1tLpXvSSCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741085699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EO9kVHSdTHn2fWrMycpwAcQb5rp2wiW+HXpcxpE+EdM=;
	b=qHwIcoG+3IwI3t1Ze7bqX4B6nFBEhJSjc6MEkonUdJvXCOE4qS2JUmYaOxaAE58wycI3kP
	8FwCa7LCbUU1NWHglejxHSiaYMLKAsDsQWEnlQCeBFrMqz/F+7BcSZXYyt40shFN/7p6LC
	79BEhLo0S/kwWX7RkNjmmu+GG19aofQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741085699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EO9kVHSdTHn2fWrMycpwAcQb5rp2wiW+HXpcxpE+EdM=;
	b=JnMXtkX8m+6WvVVH4zhb5aYrnrYlFy0yGKs239TMdq1eK0JvUU63WtLur6QGUYpQORhVai
	t0PgHH1tLpXvSSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2207A1393C;
	Tue,  4 Mar 2025 10:54:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JZUACAPcxmc2agAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 04 Mar 2025 10:54:59 +0000
Message-ID: <19df9218-c984-4cbc-8b5d-4e0f7658935f@suse.cz>
Date: Tue, 4 Mar 2025 11:54:58 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>,
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
 <173d4dbe-399d-4330-944c-9689588f18e8@suse.cz>
 <CAJuCfpHHXYKGjaOxHcuJcuQbUVO7YqLMpcYeF3HM5Ayxy1fE+g@mail.gmail.com>
 <CAJuCfpE7t83PKWw+8XJLE5538kKJnbhirLg2siDSw=F4sw=9uA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAJuCfpE7t83PKWw+8XJLE5538kKJnbhirLg2siDSw=F4sw=9uA@mail.gmail.com>
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
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,linux.com,google.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,linutronix.de,kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/25/25 21:26, Suren Baghdasaryan wrote:
> On Mon, Feb 24, 2025 at 1:12 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> >
>> > > The values represent the total time it took to perform mmap syscalls, less is
>> > > better.
>> > >
>> > > (1)                  baseline       control
>> > > Little core       7.58327       6.614939 (-12.77%)
>> > > Medium core  2.125315     1.428702 (-32.78%)
>> > > Big core          0.514673     0.422948 (-17.82%)
>> > >
>> > > (2)                  baseline      control
>> > > Little core       7.58327       5.141478 (-32.20%)
>> > > Medium core  2.125315     0.427692 (-79.88%)
>> > > Big core          0.514673    0.046642 (-90.94%)
>> > >
>> > > (3)                   baseline      control
>> > > Little core        7.58327      4.779624 (-36.97%)
>> > > Medium core   2.125315    0.450368 (-78.81%)
>> > > Big core           0.514673    0.037776 (-92.66%)
> 
> (4)                   baseline      control
> Little core        7.58327      4.642977 (-38.77%)
> Medium core   2.125315    0.373692 (-82.42%)
> Big core           0.514673    0.043613 (-91.53%)
> 
> I think the difference between (3) and (4) is noise.
> Thanks,
> Suren.

Hi, as we discussed yesterday, it would be useful to set the baseline to
include everything before sheaves as that's already on the way to 6.15, so
we can see more clearly what sheaves do relative to that. So at this point
it's the vma lock conversion including TYPESAFE_BY_RCU (that's not undone,
thus like in scenario (4)), and benchmark the following:

- baseline - vma locking conversion with TYPESAFE_BY_RCU
- baseline+maple tree node reduction from mm-unstable (Liam might point out
which patches?)
- the above + this series + sheaves enabled for vm_area_struct cache
- the above + full maple node sheaves conversion [1]
- the above + the top-most patches from [1] that are optimizations with a
tradeoff (not clear win-win) so it would be good to know if they are useful

[1] currently the 4 commits here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-percpu-sheaves-v2-maple
from "maple_tree: Sheaf conversion" to "maple_tree: Clean up sheaf"
but as Liam noted, they won't cherry pick without conflict once maple tree
node reduction is backported, but he's working on a rebase

Thanks in advance!

>> > >
>> > > Results in (3) vs (2) indicate that using sheaves for vm_area_struct
>> > > yields slightly better averages and I noticed that this was mostly due
>> > > to sheaves results missing occasional spikes that worsened
>> > > TYPESAFE_BY_RCU averages (the results seemed more stable with
>> > > sheaves).
>> >
>> > Thanks a lot, that looks promising!
>>
>> Indeed, that looks better than I expected :)
>> Cheers!
>>
>> >
>> > > [1] https://lore.kernel.org/all/20250213224655.1680278-1-surenb@google.com/
>> > >
>> >

