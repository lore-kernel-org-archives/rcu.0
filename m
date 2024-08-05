Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12913C8F9;
	Mon,  5 Aug 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869635; cv=none; b=GrdAys9JFm1tQiSPGpNk1X+lu+K+uf6oEr0dZG5k3vPSXGevCEOwprj3CDzeBX6zx9xGAaWFR8iZjjp+EgvvBqNhj4uTvMUgft7QoVkBxFe3unXWHvvVrQ+G8bzGxIw4kWKcNpOIDD0O9fqdN1Jsxol8eqcRTf8qgo89rXXNnFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869635; c=relaxed/simple;
	bh=AFKkK9wMtt0ZdpSsvOJbRBLYQvbBfWYor76BBMLpY24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gt83J5AZ0+C/FTdphI7p1dgSUy37r01BGzfaxKtxJAFxYv5gEhklUpb5JZbu4WRWeWw+gKrX8C133t1BNSMJJ4fN0HcO/bcG0FDR60e4Y7lu+ZNHHo6yMaJL5M2SUP5HZfIFO8nfoNGXyZ4wySem60GR4ArE30221Yl6E+5hZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tWJzkcjL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ELgkofOV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tWJzkcjL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ELgkofOV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tWJzkcjL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ELgkofOV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tWJzkcjL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ELgkofOV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 13D5F1F842;
	Mon,  5 Aug 2024 14:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722869632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bvNbJoamxu2M7+IQIldidNtyEfetX5P75wnrRRF3zi4=;
	b=tWJzkcjLGsnnViO0e/yHXPkVFnVOz8ywCedF8Tv88h5EHM9dLZtfcwnxnTdi5oujbvYbKF
	wq24RZU126X317bAlF38LjGi0N0nteEU8eaYlU0YMux4SND6Ua8T1tY385QL3g54xVGDIw
	QKUxtxdNa9s2bjfQgWVzTFaXDUePeAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722869632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bvNbJoamxu2M7+IQIldidNtyEfetX5P75wnrRRF3zi4=;
	b=ELgkofOVCZ3V9w7xtC5B87rQDsueOQunXmqpFeaIoPKcEket4kZN7/YqpAfH9JqqtxwEfb
	3fcB84h9dJVO2IBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722869632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bvNbJoamxu2M7+IQIldidNtyEfetX5P75wnrRRF3zi4=;
	b=tWJzkcjLGsnnViO0e/yHXPkVFnVOz8ywCedF8Tv88h5EHM9dLZtfcwnxnTdi5oujbvYbKF
	wq24RZU126X317bAlF38LjGi0N0nteEU8eaYlU0YMux4SND6Ua8T1tY385QL3g54xVGDIw
	QKUxtxdNa9s2bjfQgWVzTFaXDUePeAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722869632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bvNbJoamxu2M7+IQIldidNtyEfetX5P75wnrRRF3zi4=;
	b=ELgkofOVCZ3V9w7xtC5B87rQDsueOQunXmqpFeaIoPKcEket4kZN7/YqpAfH9JqqtxwEfb
	3fcB84h9dJVO2IBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7E8013ACF;
	Mon,  5 Aug 2024 14:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g4cVOH/nsGaMVQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 05 Aug 2024 14:53:51 +0000
Message-ID: <00914d25-f0ae-4b00-9608-2457821c071c@suse.cz>
Date: Mon, 5 Aug 2024 16:53:51 +0200
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
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <ZrDhp3TLz6Kp93BJ@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,kernel.org,infradead.org,linutronix.de,kvack.org,joelfernandes.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Score: -2.79
X-Spam-Flag: NO
X-Spam-Level: 

On 8/5/24 16:28, Frederic Weisbecker wrote:
> Le Tue, Jul 30, 2024 at 05:49:51PM +0200, Vlastimil Babka a écrit :
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> 
>> Nit:
>> 
>> > +int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
>> > +{
>> > +	struct kthread *kthread = to_kthread(p);
>> > +	cpumask_var_t affinity;
>> > +	unsigned long flags;
>> > +	int ret;
>> > +
>> > +	if (!wait_task_inactive(p, TASK_UNINTERRUPTIBLE) || kthread->started) {
>> > +		WARN_ON(1);
>> > +		return -EINVAL;
>> > +	}
>> > +
>> 
>> Should we also fail if kthread->preferred_affinity already exist? In
>> case somebody calls this twice.
> 
> Good point!
> 
>> 
>> Also for some of the use cases (kswapd, kcompactd) it would make sense
>> to be able to add cpus of a node as they are onlined. Which seems we
>> didn't do, except some corner case handling in kcompactd, but maybe we
>> should? I wonder if the current implementation of onlining a completely
>> new node with cpus does the right thing as a result of the individual
>> onlining operations, or we end up with being affined to a single cpu (or
>> none).
>> 
>> But that would need some kind of kthread_affine_preferred_update()
>> implementation?
> 
> So you mean that the "for_each_node_state()" loop in kcompactd doesn't
> handle all possible nodes but only those online when it's called? Or
> am I confused?

If you mean the loop in kcompactd_init() then indeed, but we also have a
hook in online_pages() to start new threads on newly onlined nodes, so
that's not a problem.

The problem (I think) I see is cpumask_of_node(pgdat->node_id) is a snapshot
of cpus running on the NUMA node the time, and is never updated later as new
cpus might be brought up.

kcompactd_cpu_online() does try to update that when cpus are onlined (in a
clumsy way), there was nothing like that for kswapd and after your series
this update is also removed for kcompactd.

> If all users of preferred affinity were to use NUMA nodes, it could be
> a good idea to do a flavour of kernel/smpboot.c which would handle
> per-node kthreads instead of per-cpu kthreads. I initially thought
> about that. It would have handled all the lifecycle of those kthreads,
> including creation, against hotplug. Unfortunately RCU doesn't rely on
> per-NUMA nodes but rather use its own tree.
> 
> If there be more users of real per NUMA nodes kthreads than kswapd and
> kcompactd, of course that would be much worth considering.

Yeah it's not that compelling, but a way to update the preferred affine mask
in response to cpu hotplug events, that kswapd and kcompactd could use,
would be sufficient. And maybe more widely useful.

I guess there could be a callback defined for kthread to provide a new
preferred_affinity, that you'd call from kthreads_hotplug_update() ?
And kcompactd and kswapd could both use the same callback that interprets
kthread_data() as pgdat and fetches a new cpumask of it?

> Thanks.

