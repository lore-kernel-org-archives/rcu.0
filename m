Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0DA19E7F8;
	Fri, 29 Nov 2024 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732888442; cv=none; b=Vfrnq6PYMnrywxfS/XxK7QXUkVJSjdUwfvxdqS3Vj9A1HidL+tH/JgjP4SsYJxguxpIkCP9etBLO3xSOBgk4fzWg3v2Z8Mn/WodTl8cGxCxTEB6e0ivW0Erfkwm6QPKqA5xkLxfotVXr5dv+lcSLSvwv8rPqqFasSljNf1Md6VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732888442; c=relaxed/simple;
	bh=ulRXc+UQPJr9unXfxKOH5BNE/FiKc8LKcH5cupQhVtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXBMElKFxyPq7J1Q4DzLCwY/C2Xu/K20v+LIc9XWiZf6VgyEE6G50sk3oc11SlSHp1SMclH9CAyX7IT2KHbJMuztg4uJcYVgr2fJmR6pobINwKcgIB0lI2858wpKRwJKG2mFBN3+TMxzQB+dUIW5E/M40co4z4LNihKNsHDEpk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PJeWgULh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sjjl89g0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DYW8pKat; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dfo01d+V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PJeWgULh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sjjl89g0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DYW8pKat";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dfo01d+V"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 420171F391;
	Fri, 29 Nov 2024 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732888431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5ZbFQBAAXIt1crcpC/JIUkBIOvqoKaU3YliG8F1AKQ=;
	b=PJeWgULh23oUhHTvWP+oK8+5CJNqCw4N8EGdVjtJUD2GVue3uOjzUODiGTiJPafik6dN7e
	1rCIEJoFazNXCbG6udNbjlLMd62mfJei6RhSC9MEnn+k9Y+8nI9VjWlpEA4w3+DkS/OjOV
	k5NCa0s/QD64y1aFd/1mXb40l5WU6gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732888431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5ZbFQBAAXIt1crcpC/JIUkBIOvqoKaU3YliG8F1AKQ=;
	b=sjjl89g0eimSbmOav0mbkKyMqKF2PTOyHDWmhSGbC7nLIcgjq40dWMVT/IptXH6S8/0e1R
	Ye2HGOrx9OssfeBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DYW8pKat;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Dfo01d+V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732888430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5ZbFQBAAXIt1crcpC/JIUkBIOvqoKaU3YliG8F1AKQ=;
	b=DYW8pKatlNLBWUFMFHZXghw6pjtmQLDHanAAuDQx8ZF+hYypBtXcbGSPTZrH3MGdk29hqc
	Xr0AHX4JoTE2jJhYCFe/SyMj55obstTak1kq3Yga3atrUKGDe1rGWFF1qwbzxHXz9Hs2FW
	fhqUzSIDJ+Km4jzY6SnRyhzTWXIibSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732888430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5ZbFQBAAXIt1crcpC/JIUkBIOvqoKaU3YliG8F1AKQ=;
	b=Dfo01d+Vh2Bu7bjj3PPI+fYxTj6fX7iMxnnOGDuuiEppN/ZilC5d8EfN1o7HZ8dn8lyQOe
	EeAtptBw9a3pXyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14A4E133F3;
	Fri, 29 Nov 2024 13:53:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iH6MBG7HSWcUKAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 29 Nov 2024 13:53:50 +0000
Message-ID: <d16bef14-eaee-4917-8cb6-5571327220df@suse.cz>
Date: Fri, 29 Nov 2024 14:54:10 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/6] mm/slub: add sheaf support for batching
 kfree_rcu() operations
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz>
 <20241112-slub-percpu-caches-v1-2-ddc0bdc27e05@suse.cz>
 <ZzYsBu_rJWSAcAYf@pc636> <cc7f24b8-4de5-4023-b40b-5f62287aafe8@suse.cz>
 <Zz3YDI4Bb04opI2d@pc636> <a4bd2aef-6402-49e0-9ad6-f353c5200ee7@suse.cz>
 <CA+KHdyXH5X=J2ontChFVUqFx15=VVng23H4gh_o-2Vzfo+mmjw@mail.gmail.com>
 <Z0iZOFAUSqN7cN5Z@pc636>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <Z0iZOFAUSqN7cN5Z@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 420171F391
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux.com,kernel.org,lge.com,linux.dev,gmail.com,infradead.org,kvack.org,vger.kernel.org,lists.infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 11/28/24 5:24 PM, Uladzislau Rezki wrote:
> On Mon, Nov 25, 2024 at 12:18:19PM +0100, Uladzislau Rezki wrote:
>>> On 11/20/24 13:37, Uladzislau Rezki wrote:
>>>> Thank you. Let me try to start moving it into mm/. I am thinking to place
>>>> it to the slab_common.c file. I am not sure if it makes sense to have a
>>>> dedicated file name for this purpose.
>>>
>>> Yeah sounds good. slub.c is becoming rather large and this should not
>>> interact with SLUB internals heavily anyway, slab_common.c makes sense.
>>> Thanks!
>>>
>> Got it :)
>>
> There is one question. Do you think it works if i do a migration as one
> big commit? I am asking, because it is easier to go that way.

Hi, I think one big move is fine. In case there are further adjustments,
those would be better in separate patches. That makes it easy to review
the move with git diff --color-moved.

Thanks,
Vlastimil

> If it looks ugly for you, we can use another approach which is to split
> the work into several patches and deploy it a series.
> 
> --
> Uladzislau Rezki

