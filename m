Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4414C66;
	Tue, 17 Sep 2024 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726556327; cv=none; b=Wxm/He90u0m/E9gCmvHSwpTxpUXF4LLuVXNYIbrS/CqYwqIJE5nuroslJZ7EkMV8J+72Tm7ekOiYOmY4pZ7srL3b3NODc6GFpFNbMP3/ClmhHBOZ82LK1RJVX/Qy2oZ8dr5/uG+y94TY8db/EXPLxbv7ft61Hd0iUyxd+Lpah40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726556327; c=relaxed/simple;
	bh=RwswKx2Ru4HlGwngkygrKPS1zc9jVIfGlB10Nwsi/vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usV3gX9gNkg9rx51tpyMK686GeY8hH+on/F3LLdutJ4R2oIRUG/PEiREDp7rSR/x7I7naECDOmOTaO9OXxENXkKw9iYfBHLo+0EBk1qQzzVdv1ayjqWArMuPrYRtS8s7gl7NG5Li+ZId0DW1SMLIYMmkrzDpc3wjzckO+JKnL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2CVDQJMu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iwb8hpMg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2CVDQJMu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iwb8hpMg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2CVDQJMu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iwb8hpMg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2CVDQJMu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iwb8hpMg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D4452203A;
	Tue, 17 Sep 2024 06:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726556324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eb6/2/53r1amqAN8+Pxosb0NBJtbXKF+syEPphgBDmA=;
	b=2CVDQJMuRbly79vOqT2OVsObIe8NtK43I+OXPZ/Aaqs5/JYl5fFwC6q48YJyUqkh3WTW6v
	1BHS2gzNOeT1uMray2CB1Db9FJvF1lWruQ5zF05ChrDzm2ar907l1eBtIcxtTUByedFOlQ
	P/r39fsJ6kbolu0wgO37ZPEG00ZRo7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726556324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eb6/2/53r1amqAN8+Pxosb0NBJtbXKF+syEPphgBDmA=;
	b=iwb8hpMgHE++RS/frFPzcd/x/4+48zRpv+0xEHyhe2C9ppCXCVwaB1zKjXzNOB0bgCUv+M
	ZUqtpa8Lby5XFRDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2CVDQJMu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iwb8hpMg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726556324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eb6/2/53r1amqAN8+Pxosb0NBJtbXKF+syEPphgBDmA=;
	b=2CVDQJMuRbly79vOqT2OVsObIe8NtK43I+OXPZ/Aaqs5/JYl5fFwC6q48YJyUqkh3WTW6v
	1BHS2gzNOeT1uMray2CB1Db9FJvF1lWruQ5zF05ChrDzm2ar907l1eBtIcxtTUByedFOlQ
	P/r39fsJ6kbolu0wgO37ZPEG00ZRo7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726556324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eb6/2/53r1amqAN8+Pxosb0NBJtbXKF+syEPphgBDmA=;
	b=iwb8hpMgHE++RS/frFPzcd/x/4+48zRpv+0xEHyhe2C9ppCXCVwaB1zKjXzNOB0bgCUv+M
	ZUqtpa8Lby5XFRDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDD32139CE;
	Tue, 17 Sep 2024 06:58:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /CimNaMo6WbwNQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 17 Sep 2024 06:58:43 +0000
Message-ID: <4b107fec-e391-4680-9457-b282310b4454@suse.cz>
Date: Tue, 17 Sep 2024 09:01:08 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] kthread: Default affine kthread to its preferred
 NUMA node
To: Michal Hocko <mhocko@suse.com>, Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-mm@kvack.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
References: <20240916224925.20540-1-frederic@kernel.org>
 <20240916224925.20540-13-frederic@kernel.org> <ZukhKXxErPOaXtAL@tiehlicka>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZukhKXxErPOaXtAL@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0D4452203A
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,kernel.org,infradead.org,linutronix.de,kvack.org,joelfernandes.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 9/17/24 8:26 AM, Michal Hocko wrote:
> On Tue 17-09-24 00:49:16, Frederic Weisbecker wrote:
>> Kthreads attached to a preferred NUMA node for their task structure
>> allocation can also be assumed to run preferrably within that same node.
>>
>> A more precise affinity is usually notified by calling
>> kthread_create_on_cpu() or kthread_bind[_mask]() before the first wakeup.
>>
>> For the others, a default affinity to the node is desired and sometimes
>> implemented with more or less success when it comes to deal with hotplug
>> events and nohz_full / CPU Isolation interactions:
>>
>> - kcompactd is affine to its node and handles hotplug but not CPU Isolation
>> - kswapd is affine to its node and ignores hotplug and CPU Isolation
>> - A bunch of drivers create their kthreads on a specific node and
>>   don't take care about affining further.
>>
>> Handle that default node affinity preference at the generic level
>> instead, provided a kthread is created on an actual node and doesn't
>> apply any specific affinity such as a given CPU or a custom cpumask to
>> bind to before its first wake-up.
> 
> Makes sense.
> 
>> This generic handling is aware of CPU hotplug events and CPU isolation
>> such that:
>>
>> * When a housekeeping CPU goes up and is part of the node of a given
>>   kthread, it is added to its applied affinity set (and
>>   possibly the default last resort online housekeeping set is removed
>>   from the set).
>>
>> * When a housekeeping CPU goes down while it was part of the node of a
>>   kthread, it is removed from the kthread's applied
>>   affinity. The last resort is to affine the kthread to all online
>>   housekeeping CPUs.
> 
> But I am not really sure about this part. Sure it makes sense to set the
> affinity to exclude isolated CPUs but why do we care about hotplug
> events at all. Let's say we offline all cpus from a given node (or
> that all but isolated cpus are offline - is this even
> realistic/reasonable usecase?). Wouldn't scheduler ignore the kthread's
> affinity in such a case? In other words how is that different from
> tasksetting an userspace task to a cpu that goes offline? We still do
> allow such a task to run, right? We just do not care about affinity
> anymore.

AFAIU it handles better the situation where all houskeeping cpus from
the preferred node go down, then it affines to houskeeping cpus from any
node vs any cpu including isolated ones.
Yes it's probably a scenario that's not recommendable, but someone might
do it anyway...
