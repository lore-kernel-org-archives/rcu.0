Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E97208974
	for <rcu@vger.kernel.org>; Tue,  4 Feb 2025 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663372; cv=none; b=nGIc4cOufT/vg81qtE8kh7YqhmlUPnUsXMa9ELIWBfiH6JZ42uTX2Zxg1Fc2F50mcT0LrefaA/QMsN8p5H9OOK3zUrgh2BTLW+1mCZOeelUzcU7b+GYhVdftcwx90Ryy9gOcHxGhfHzMUm9Idt/R3ejO79/C4tAZOixu5sc8+R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663372; c=relaxed/simple;
	bh=hx7QC6xtkocAVZonkEY16Dq1kjnFJPx6Wy5bRF15S4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEnzkSk0jlSzjhhILWCAyGpmdDi6qPeIRsVnECEqUydfbioez3OrI7nPpKIYcBeB5HVD/+tWTics+S5MMShFhYDzQBcOfCxq3u886SqcuP7Cjik5FIEAkDWoZlwt/kTDOXnCrtEjp/TCJnOt4Hnr3rG11euBzlulcQgJnbPIDBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TvSqu+F0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QzKmz/76; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TvSqu+F0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QzKmz/76; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TvSqu+F0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QzKmz/76";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TvSqu+F0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QzKmz/76"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 22A0B1F365;
	Tue,  4 Feb 2025 10:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738663368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mpaNqCNIGHHEn1Hg4ptzdNaVqLW53qXd1RWYSzZBJyI=;
	b=TvSqu+F0oMZ2ELIrs/i3u116JWhslvvnjFYbvEB3JQaRABw+H/COZ4p0E8UeUpErggMSQY
	axYMTBzD5rhaiQ37xbvbvdi2esaQyQUIvFo3+qwPCLjwlJB4RTMH2e4hXFR/349Sati34b
	5agQJCcxons/xBdhclcEVQnhzhX6ipE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738663368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mpaNqCNIGHHEn1Hg4ptzdNaVqLW53qXd1RWYSzZBJyI=;
	b=QzKmz/76GJgcrV+qYnuLszJ+/sx9K2JtlUhH8iXKdM2TLD+UulSSwGjUH+51/oSYKHhyVL
	cXZi1lx2Vkz6s4Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TvSqu+F0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="QzKmz/76"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738663368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mpaNqCNIGHHEn1Hg4ptzdNaVqLW53qXd1RWYSzZBJyI=;
	b=TvSqu+F0oMZ2ELIrs/i3u116JWhslvvnjFYbvEB3JQaRABw+H/COZ4p0E8UeUpErggMSQY
	axYMTBzD5rhaiQ37xbvbvdi2esaQyQUIvFo3+qwPCLjwlJB4RTMH2e4hXFR/349Sati34b
	5agQJCcxons/xBdhclcEVQnhzhX6ipE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738663368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mpaNqCNIGHHEn1Hg4ptzdNaVqLW53qXd1RWYSzZBJyI=;
	b=QzKmz/76GJgcrV+qYnuLszJ+/sx9K2JtlUhH8iXKdM2TLD+UulSSwGjUH+51/oSYKHhyVL
	cXZi1lx2Vkz6s4Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F40BF1393E;
	Tue,  4 Feb 2025 10:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OgNFO8floWdzDQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 04 Feb 2025 10:02:47 +0000
Message-ID: <4fdbb91c-df21-4dab-a165-a4e864625628@suse.cz>
Date: Tue, 4 Feb 2025 11:02:47 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] slab, rcu: move and consolidate TINY_RCU kvfree_rcu()
 to SLAB
Content-Language: en-US
To: paulmck@kernel.org
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu@vger.kernel.org
References: <20250203-slub-tiny-kfree_rcu-v1-0-d4428bf9a8a1@suse.cz>
 <5ee3321c-417a-4638-8d9e-77faa5f07462@paulmck-laptop>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <5ee3321c-417a-4638-8d9e-77faa5f07462@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 22A0B1F365
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.com,google.com,joelfernandes.org,joshtriplett.org,gmail.com,linux-foundation.org,linux.dev,kvack.org,goodmis.org,efficios.com,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/3/25 20:07, Paul E. McKenney wrote:
> On Mon, Feb 03, 2025 at 10:28:46AM +0100, Vlastimil Babka wrote:
>> Following the move of the TREE_RCU batching kvfree_rcu() implementation
>> to slab, we still have the simple non-batching implementation in tiny
>> RCU, and RCU implementation specific ifdefs in slab code.
>> 
>> Finish the move and integration into slab. Allow using the simple
>> call_rcu() based implementation also with tree RCU when SLUB_TINY is
>> enabled, as its goal is also to limit memory footprint with less concern
>> for top performance.
>> 
>> In order to avoid RCU having to recognize the fake callback function
>> pointers (__is_kvfree_rcu_offset()) when handling call_rcu(), implement
>> a callback that can calculate the object's address from the embedded
>> rcu_head pointer without knowing the specific offset (previously SLOB
>> would not have made it possible, but it's gone now).
>> 
>> After this series, AFAIK only the following kvfree_rcu specific code
>> remains in RCU:
>> 
>> - a call to kfree_rcu_scheduler_running() from rcu_set_runtime_mode()
>> 
>>   - probably necessary and a generic registration interface would be
>>     unnecessary bloat?
> 
> I am OK with this calling directly.
> 
> Alternatively, you could create a core_initcall() that did nothing
> but invoke kfree_rcu_scheduler_running(), and then drop that call from
> rcu_set_runtime_mode().  Up to you guys!

I was afraid there's some ordering necessary with the rest of what
rcu_set_runtime_mode() does, but perhaps there's actually not.

>> - declarations of kfree_rcu() API in include/linux/rcupdate.h
>> 
>>   - could be moved to slab.h after checking for/fixing up potential
>>     missing includes
> 
> It would be good to move them, but no real hurry from this end.
> 
>> git tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/slub-tiny-kfree_rcu
>> 
>> Changes since RFC [1]:
>> - Rebased to v6.14-rc1
>> - Fixed build errors reported by bots.
>> - Changed where kvfree_call_rcu() is moved to in patch 1 to avoid another
>>   move in patch 4.
>> - R-b's by Ulad and Joel
>> - Fix a memory leak in kvfree_rcu_list() thanks to Ulad
>> - Various comments' improvements and fixes (Joel, Ulad)
>> - Rename config to CONFIG_KFREE_RCU_BATCHED (Ulad)
>> 
>> Due to changes, didn't keep Paul's Tested-by (but thanks!)
> 
> I re-ran the tests, so feel free to add it back in.  ;-)

Thanks, will do :)


