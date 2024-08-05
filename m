Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8D3175562;
	Mon,  5 Aug 2024 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893168; cv=none; b=hUoOeerOy+ARylMn68/87FrCND1C2CCF8mwswH04G1NfSAII3iL1QDVfFiziF9RitPk+TMmK832LLqwAu6sN2+OQcobHmnRGk7ZGuDLs3DKA4Zv3PBi4QhtPEnKKnXWV4+uTbpazIvFPaO3VCBEn3sXfvMplKOK3zfY5wr4tTO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893168; c=relaxed/simple;
	bh=1BVytNCZk+Dg70e1EBW/TZLKz4MQfi0OMZ69kb4u5F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4uPDcdHIePFvMXr+t3yGutfbKyAV2driOoQtKqImmIK5aiepLQQJ+smcCq9hGAo5AoMPWjdGBjBbacQBd1tKLC+rzPuDCTPLPnN/tSCx0uYsjlSuA84M+q6wP8RVOMCbT2O+TkXNbYbXICFuOQeTuOY4mhfLwOvG2c5YbGmU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kmmxcZk4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cEN9eR4b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kmmxcZk4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cEN9eR4b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kmmxcZk4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cEN9eR4b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kmmxcZk4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cEN9eR4b"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94E3F21CCA;
	Mon,  5 Aug 2024 21:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722893159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RzwYQufTrgFxwHNNxE5vv5xdFdhhOTlJ+F/YlPwej+E=;
	b=kmmxcZk4kbXnKrhFPujPnfsVm5FXl7tldcsbHMwylY98QV8839p/xpDIFyPNX5hllntmDb
	nz86fdSXyPIozJcmrN1/Cd3vYuO5vPfVD5+qwHnAJpzaJUGfFv/Nay5fWp1Vdfin71SxqZ
	vkHCerCJMYl6ny88iRSWXgdKeZzgf5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722893159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RzwYQufTrgFxwHNNxE5vv5xdFdhhOTlJ+F/YlPwej+E=;
	b=cEN9eR4b69bFKW9fHR1oKXQNRRwOiTaqpHLr6e21FzftgOF/tUUaI//w4KLDxZBWIP6kAQ
	jGw9v6oeoTEBIpCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722893159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RzwYQufTrgFxwHNNxE5vv5xdFdhhOTlJ+F/YlPwej+E=;
	b=kmmxcZk4kbXnKrhFPujPnfsVm5FXl7tldcsbHMwylY98QV8839p/xpDIFyPNX5hllntmDb
	nz86fdSXyPIozJcmrN1/Cd3vYuO5vPfVD5+qwHnAJpzaJUGfFv/Nay5fWp1Vdfin71SxqZ
	vkHCerCJMYl6ny88iRSWXgdKeZzgf5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722893159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RzwYQufTrgFxwHNNxE5vv5xdFdhhOTlJ+F/YlPwej+E=;
	b=cEN9eR4b69bFKW9fHR1oKXQNRRwOiTaqpHLr6e21FzftgOF/tUUaI//w4KLDxZBWIP6kAQ
	jGw9v6oeoTEBIpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67D1113946;
	Mon,  5 Aug 2024 21:25:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AiSzGGdDsWYHRQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 05 Aug 2024 21:25:59 +0000
Message-ID: <b358e42e-e8aa-40e9-9fca-90ae28cfdfaa@suse.cz>
Date: Mon, 5 Aug 2024 23:25:59 +0200
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
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <ZrD8kmRw73bS3Lj6@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.21 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,kernel.org,infradead.org,linutronix.de,kvack.org,joelfernandes.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.21

On 8/5/24 18:23, Frederic Weisbecker wrote:
> Le Mon, Aug 05, 2024 at 04:53:51PM +0200, Vlastimil Babka a écrit :
>> If you mean the loop in kcompactd_init() then indeed, but we also have a
>> hook in online_pages() to start new threads on newly onlined nodes, so
>> that's not a problem.
>> 
>> The problem (I think) I see is cpumask_of_node(pgdat->node_id) is a snapshot
>> of cpus running on the NUMA node the time, and is never updated later as new
>> cpus might be brought up.
> 
> Oh I see now...
> 
>> 
>> kcompactd_cpu_online() does try to update that when cpus are onlined (in a
>> clumsy way), there was nothing like that for kswapd and after your series
>> this update is also removed for kcompactd.
> 
> Ok...
> 
>> 
>> > If all users of preferred affinity were to use NUMA nodes, it could be
>> > a good idea to do a flavour of kernel/smpboot.c which would handle
>> > per-node kthreads instead of per-cpu kthreads. I initially thought
>> > about that. It would have handled all the lifecycle of those kthreads,
>> > including creation, against hotplug. Unfortunately RCU doesn't rely on
>> > per-NUMA nodes but rather use its own tree.
>> > 
>> > If there be more users of real per NUMA nodes kthreads than kswapd and
>> > kcompactd, of course that would be much worth considering.
>> 
>> Yeah it's not that compelling, but a way to update the preferred affine mask
>> in response to cpu hotplug events, that kswapd and kcompactd could use,
>> would be sufficient. And maybe more widely useful.
>> 
>> I guess there could be a callback defined for kthread to provide a new
>> preferred_affinity, that you'd call from kthreads_hotplug_update() ?
>> And kcompactd and kswapd could both use the same callback that interprets
>> kthread_data() as pgdat and fetches a new cpumask of it?
> 
> It's too bad we don't have a way to have a cpumask_possible_of_node(). I've
> looked into the guts of numa but that doesn't look easy to do.

That was my impression as well. Maybe not even possible because exact cpu
ids might not be pre-determined like this?

> Or there could be kthread_set_preferred_node()... ?

Possible instead of the callback idea suggested above?
kthreads_hotplug_update() could check if this is set and construct the mask
accordingly.

> Thanks.
> 
>> 
>> > Thanks.
>> 

