Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48503D969;
	Sat, 10 Aug 2024 20:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723321419; cv=none; b=XF02DuhQVRuonYVD1Rs6JEkD5I4uYIMROafh3zMDe8FEBzpWqo9R3JbSsAG7XWiI4ReEpg660DruKuWGNBM3KEK40U7feuyEcPC9paVhcdYUocMyDxF4X5uQ54kQZ9rt8C5TJudThWg7I4+Z5zsIL/Xya4kT2AMOxB/+upovFFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723321419; c=relaxed/simple;
	bh=lwcqvkB7zYsO9Pogh8Hf9x/nFY6mDvi6Jc9vMI8LsS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWWKl9fKo+BHb6EE3Rkpw6Z+/OCI4/Nxi80GTnPVFPxXYOCzDGNZq73BbeUAgnVbzxGY8iEq1sHMwoTWbJ9IItZYC1DPSf4pn8qxbu/eAvVO47+MvfUDXtrAey7u36mfNnavipJw5MCqYUV6bteIU3KxQM2oel05ZuWBvyRCT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TGmFIMzF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TqPtBLoE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TGmFIMzF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TqPtBLoE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TGmFIMzF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TqPtBLoE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TGmFIMzF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TqPtBLoE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 516EA1F86C;
	Sat, 10 Aug 2024 20:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723321410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dU5FpYeZ5zWDwOs2yWnFMVpSiFRDeYnnwFffftni6eo=;
	b=TGmFIMzFIMV3cKlNeopKwIJe+8PdLEKWBx2CUqapgYU5OfcVY5aDlw66da1JUPgXKOYoQb
	ybuqOhnrOf8DgjYtX7cdwV9JUfJWFVh+9ZvTJ08rhJRlk1i6vS33/lbpBh8L8qGWYwXZTi
	pprIAlvC8xqXBjCFI+6J95zhmEENdCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723321410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dU5FpYeZ5zWDwOs2yWnFMVpSiFRDeYnnwFffftni6eo=;
	b=TqPtBLoEucA4YZTADDSDyeLt0AqTOeL+L/PXOBJ1VLvU72CgQWmBTObd8gxDdAC7BnPbxe
	Stz2Hp3iGmaxE1BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723321410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dU5FpYeZ5zWDwOs2yWnFMVpSiFRDeYnnwFffftni6eo=;
	b=TGmFIMzFIMV3cKlNeopKwIJe+8PdLEKWBx2CUqapgYU5OfcVY5aDlw66da1JUPgXKOYoQb
	ybuqOhnrOf8DgjYtX7cdwV9JUfJWFVh+9ZvTJ08rhJRlk1i6vS33/lbpBh8L8qGWYwXZTi
	pprIAlvC8xqXBjCFI+6J95zhmEENdCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723321410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dU5FpYeZ5zWDwOs2yWnFMVpSiFRDeYnnwFffftni6eo=;
	b=TqPtBLoEucA4YZTADDSDyeLt0AqTOeL+L/PXOBJ1VLvU72CgQWmBTObd8gxDdAC7BnPbxe
	Stz2Hp3iGmaxE1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3997E13704;
	Sat, 10 Aug 2024 20:23:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O9/cC0HMt2bmQAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sat, 10 Aug 2024 20:23:29 +0000
Message-ID: <167495c0-187b-4fb8-8de5-63db0aef193e@suse.cz>
Date: Sat, 10 Aug 2024 22:25:05 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-next conflict imminent] Re: [PATCH v2 0/7] mm, slub: handle
 pending kfree_rcu() in kmem_cache_destroy()
To: Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jann Horn <jannh@google.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 Mateusz Guzik <mjguzik@gmail.com>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <54d62d5a-16e3-4ea9-83c6-8801ee99855e@suse.cz>
 <CAG48ez3Y7NbEGV0JzGvWjQtBwjrO3BNTEZZLNc3_T09zvp8T-g@mail.gmail.com>
 <e7f58926-80a7-4dcc-9a6a-21c42d664d4a@suse.cz>
 <20240809171115.9e5faf65d43143efb57a7c96@linux-foundation.org>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20240809171115.9e5faf65d43143efb57a7c96@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,goodmis.org,efficios.com,inria.fr,zx2c4.com,linux.dev,kvack.org,vger.kernel.org,googlegroups.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.79

On 8/10/24 2:11 AM, Andrew Morton wrote:
> On Fri, 9 Aug 2024 17:14:40 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> On 8/9/24 17:12, Jann Horn wrote:
>>> On Fri, Aug 9, 2024 at 5:02 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>> On 8/7/24 12:31, Vlastimil Babka wrote:
>>>>> Also in git:
>>>>> https://git.kernel.org/vbabka/l/slab-kfree_rcu-destroy-v2r2
>>>>
>>>> I've added this to slab/for-next, there will be some conflicts and here's my
>>>> resulting git show or the merge commit I tried over today's next.
>>>>
>>>> It might look a bit different with tomorrow's next as mm will have v7 of the
>>>> conflicting series from Jann:
>>>>
>>>> https://lore.kernel.org/all/1ca6275f-a2fc-4bad-81dc-6257d4f8d750@suse.cz/
>>>>
>>>> (also I did resolve it in the way I suggested to move Jann's block before
>>>> taking slab_mutex() but unless that happens in mm-unstable it would probably be more
>>>> correct to keep where he did)
>>>
>>> Regarding my conflicting patch: Do you want me to send a v8 of that
>>> one now to move things around in my patch as you suggested? Or should
>>> we do that in the slab tree after the conflict has been resolved in
>>> Linus' tree, or something like that?
>>> I'm not sure which way of doing this would minimize work for maintainers...
>>
>> I guess it would be easiest to send a -fix to Andrew as it's rather minor
>> change. Thanks!
> 
> That's quite a large conflict.  How about we carry Jann's patchset in
> the slab tree?

OK I've done that and pushed to slab/for-next. Had no issues applying
the kasan parts and merge with mm-unstable (locally rebased with Jann's
commits dropped) had no conflicts either so it should work fine. Thanks!
