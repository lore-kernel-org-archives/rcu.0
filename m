Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F01143C4B;
	Tue,  6 Aug 2024 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942523; cv=none; b=eklTzOYYsb22qeQciTWVc9N9IHF6p/CNUElKtI1ewM28gcynnhwcP6Akzk3+ptMVUpcIkZeDm0lOPvoNgJzK0cGIvHd0stodqmtbZS0oFYG2UZnaCD3FZgYh/PRfPoijOpjmilJOXndS1A/P2Yw4rPCT8KA37UNcqjJP8TYoxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942523; c=relaxed/simple;
	bh=kqjd1RndqoKtsQOhXiT5G5GjYhb1LlW7HBnhRJnm26U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eD98YI9kxUqMldXEnpO84++s6vUHdP448Kka148XLHG4aRv2YhT+rMMsQHVJXyMG8J2mvLT/O2eso/m5rKJ5j2/9DIwPqlxyeE/SEymUPi1uAF25brdShsQMbQH/rF386MG32w11kn0D+Rej154ERkusxJHDw7wH7O/sCLJImow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q5CaJ0td; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MykqE4Bh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q5CaJ0td; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MykqE4Bh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q5CaJ0td";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MykqE4Bh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q5CaJ0td";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MykqE4Bh"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B91D21C86;
	Tue,  6 Aug 2024 11:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722942519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=74A2Gq5YchB9c5c4oXkZu7v/z59QVoU6ktEL0jehpUA=;
	b=Q5CaJ0tdnTriVIY1SHKoH0JXKN8iQ80mTnFT4P3Fg207nUmmGh8LDq0eBizOh7lCWPD6lc
	DChKhh93/xJQVH/PfNZdQtX+ZLy6oCigXQ8ShmbRU0kYCfbzW+pLRgk/xzJNIEPMJxPWg9
	KnRg3fLoQLlxa5jcPjXnQMCZpXk6GlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722942519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=74A2Gq5YchB9c5c4oXkZu7v/z59QVoU6ktEL0jehpUA=;
	b=MykqE4Bh96QBwI7ukg2vjMp23P0DAOCPL08u8fKFj7zRl8C1Fv+YCZ5IBy9pXalTV4jzzt
	sO2t8jVjOTF8/wDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Q5CaJ0td;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MykqE4Bh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722942519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=74A2Gq5YchB9c5c4oXkZu7v/z59QVoU6ktEL0jehpUA=;
	b=Q5CaJ0tdnTriVIY1SHKoH0JXKN8iQ80mTnFT4P3Fg207nUmmGh8LDq0eBizOh7lCWPD6lc
	DChKhh93/xJQVH/PfNZdQtX+ZLy6oCigXQ8ShmbRU0kYCfbzW+pLRgk/xzJNIEPMJxPWg9
	KnRg3fLoQLlxa5jcPjXnQMCZpXk6GlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722942519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=74A2Gq5YchB9c5c4oXkZu7v/z59QVoU6ktEL0jehpUA=;
	b=MykqE4Bh96QBwI7ukg2vjMp23P0DAOCPL08u8fKFj7zRl8C1Fv+YCZ5IBy9pXalTV4jzzt
	sO2t8jVjOTF8/wDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69A6B13770;
	Tue,  6 Aug 2024 11:08:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VWxvGTcEsmb1HQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 06 Aug 2024 11:08:39 +0000
Message-ID: <8f5d3a92-f90c-4a0d-bd24-10dc49235afe@suse.cz>
Date: Tue, 6 Aug 2024 13:08:39 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/20] kthread: Implement preferred affinity
Content-Language: en-US
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
References: <20240726215701.19459-1-frederic@kernel.org>
 <20240726215701.19459-13-frederic@kernel.org>
 <4e9d1f6d-9cd8-493c-9440-b46a99f1c8af@suse.cz>
 <ZrDhp3TLz6Kp93BJ@localhost.localdomain>
 <00914d25-f0ae-4b00-9608-2457821c071c@suse.cz>
 <ZrD8kmRw73bS3Lj6@localhost.localdomain>
 <b358e42e-e8aa-40e9-9fca-90ae28cfdfaa@suse.cz> <ZrFncpgfJj9sWuDO@lothringen>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <ZrFncpgfJj9sWuDO@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.00 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,kernel.org,infradead.org,linutronix.de,kvack.org,joelfernandes.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 8B91D21C86
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.00

On 8/6/24 01:59, Frederic Weisbecker wrote:
> On Mon, Aug 05, 2024 at 11:25:59PM +0200, Vlastimil Babka wrote:
>> > It's too bad we don't have a way to have a cpumask_possible_of_node(). I've
>> > looked into the guts of numa but that doesn't look easy to do.
>> 
>> That was my impression as well. Maybe not even possible because exact cpu
>> ids might not be pre-determined like this?
> 
> Probably.
> 
>> 
>> > Or there could be kthread_set_preferred_node()... ?
>> 
>> Possible instead of the callback idea suggested above?
>> kthreads_hotplug_update() could check if this is set and construct the mask
>> accordingly.
> 
> Or even better, callers of kthread_create_on_node() with actual node passed
> (!NUMA_NO_NODE) can be preferrably affined to the corresponding node by default
> unless told otherwise (that is unless kthread_bind() or
> kthread_set_preferred_affinity() has been called before the first wake up, and
> that includes kthread_create_on_cpu()).

Sounds logical and great!

> There are a few callers concerned: kswapd, kcompactd, some drivers:
> drivers/block/mtip32xx/mtip32xx.c, drivers/firmware/stratix10-svc.c,
> kernel/dma/map_benchmark.c, net/sunrpc/svc.c
> 
> After all kthread_create_on_cpu() affines to the corresponding CPU. So
> it sounds natural that kthread_create_on_node() affines to the corresponding
> node.

Yes.

> And then it's handled on hotplug just as a special case of preferred affinity.
> 
> Or is there something that wouldn't make that work?

Hopefully not.

> Thanks.
> 
> 
>> 
>> > Thanks.
>> > 
>> >> 
>> >> > Thanks.
>> >> 
>> 

