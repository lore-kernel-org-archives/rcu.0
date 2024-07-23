Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44713B2AF
	for <rcu@vger.kernel.org>; Tue, 23 Jul 2024 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721725520; cv=none; b=tfKqg/HhozdLIHLPR2cJPgElX+gyx1SztEOLtMcaVM40GDhhulWVPA+kZlMpmNbwUPCy29hiNrn6Wk4YI6y+9kZsEy97HfdTHCsF71oq2tQcpBk7s09mZ9W34YYCPDsrd20S561FaQtmwhMmjBXbPIfTd2b7Me8pVo0XcOM9bGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721725520; c=relaxed/simple;
	bh=q1Fz6FOky5sy7ld1/9TYo/AmUleQ2WdsGiC8JQJVyng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/yfdawKTyTCVM3jlan/hLlaQmLthEO96W33P7rJy0v3NwOFKiJxQKTCvcXcs5FTWWUsc8yQlSAAkk5FHD8KIBueUeb3zwFXZcoRy/J0KZelXLx+rX78T34FpbJYwG7lCAYu46oUM2cIwXzy2DR7JWvjCqV4fRloC6SWCWVuYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=188lmCaz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5WQ+oFee; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=188lmCaz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5WQ+oFee; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="188lmCaz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5WQ+oFee";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="188lmCaz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5WQ+oFee"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B5721F8B0;
	Tue, 23 Jul 2024 09:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721725516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=90lemylvQwVP2pk5sS3e0egESyxYjrpshrDdCTj2SoM=;
	b=188lmCazi3RkNvIMgWLgymdt1PFnWtYlBPg2R3H2BfbCbONjPvPzuM5yKF3VoRNCXGVf9z
	FuuAsDtKMbOpLV0sCqFzopNAdrDL+cCAIjQbnv4DbGX2JRGjrMCoyk1QHml5av8P8gUNNN
	I4ykNO7RLyBU/BLA0YXsiDKLYVHkSys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721725516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=90lemylvQwVP2pk5sS3e0egESyxYjrpshrDdCTj2SoM=;
	b=5WQ+oFee+/ng0fPRfoLf9IQCf2GZz1qjvoNwmTC62qYpl0SYshsy621H8LglAuRVsoO558
	rsJMGG6gQbVRjyDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721725516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=90lemylvQwVP2pk5sS3e0egESyxYjrpshrDdCTj2SoM=;
	b=188lmCazi3RkNvIMgWLgymdt1PFnWtYlBPg2R3H2BfbCbONjPvPzuM5yKF3VoRNCXGVf9z
	FuuAsDtKMbOpLV0sCqFzopNAdrDL+cCAIjQbnv4DbGX2JRGjrMCoyk1QHml5av8P8gUNNN
	I4ykNO7RLyBU/BLA0YXsiDKLYVHkSys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721725516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=90lemylvQwVP2pk5sS3e0egESyxYjrpshrDdCTj2SoM=;
	b=5WQ+oFee+/ng0fPRfoLf9IQCf2GZz1qjvoNwmTC62qYpl0SYshsy621H8LglAuRVsoO558
	rsJMGG6gQbVRjyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5502013874;
	Tue, 23 Jul 2024 09:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W1VsFExyn2aHcwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 23 Jul 2024 09:05:16 +0000
Message-ID: <591ffb38-f92c-41ec-a849-561c34413be5@suse.cz>
Date: Tue, 23 Jul 2024 11:05:16 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible slab-allocator issue
Content-Language: en-US
To: paulmck@kernel.org, linux-mm@kvack.org
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, hannes@cmpxchg.org, willy@infradead.org,
 rcu@vger.kernel.org
References: <e6db32f7-d1fa-4d38-acf9-f78234f87170@paulmck-laptop>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <e6db32f7-d1fa-4d38-acf9-f78234f87170@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.41
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.41 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,cmpxchg.org,infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 7/22/24 11:38 PM, Paul E. McKenney wrote:
> Hello!

Hi!

> I have been chasing a hang [1] in rcuscale, which is a kernel module
> that does performance testing for RCU updaters.  I have a good long-term
> workaround for this problem, namely an extremely stupid custom allocator,
> so I don't need a fix, but I am nevertheless posting this just in case
> this affects others.  Or in case I am doing something stupid that I
> should avoid doing in the future.
> 
> I first encountered this on RCU's "dev" branch, but the problem also
> exists in current mainline [2].  One high-probability reproducer for
> this hang, tested on both AMD and Intel x86, is as follows:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --configs TREE --bootargs "rcuscale.scale_type=tasks rcuscale.minruntime=5 rcuscale.nreaders=0 rcuscale.nwriters rcuscale.gp_async=1 rcuscale.gp_async_max=100000" --trust-make
> 
> This script builds a kernel, requires that virtualization be enabled,
> and uses the qemu-system-x86_64 command.  I have not run this on a system
> with fewer than 16 CPUs.
> 
> When it fails, this takes a bit less than ten minutes to fail, which
> results in a non-zero exit code from kvm.sh.  Rare successes normally
> consume kernel-build time plus less than a minute of run time.
> 
> The failure mode is CPU 0 (and always CPU 0) failing to get out of this
> (admittedly ugly, since reworked) "retry" loop in the rcu_scale_writer()
> function in kernel/rcu/rcuscale.c:
> 
>  1 retry:
>  2   if (!rhp)
>  3     rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
>  4   if (rhp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
>  5     atomic_inc(this_cpu_ptr(&n_async_inflight));
>  6     cur_ops->async(rhp, rcu_scale_async_cb);
>  7     rhp = NULL;
>  8   } else if (!kthread_should_stop()) {
>  9     cur_ops->gp_barrier();
> 10     goto retry;
> 11   } else {
> 12     kfree(rhp); /* Because we are stopping. */

Noted no "rhp = NULL;" but we probably really shouldn't reach this again due
to torture_must_stop() including kthread_should_stop() so it should be fine.

> 13   }
> 
> The loop begins with the "retry" label on line 1, finds "rhp"
> equal to NULL on line 2, gets a NULL from kmalloc(..., GFP_KERNEL)
> on line 3, proceeds to the "else if" clause on lines 8-11,

So it's been verified that rhp is indeed null after kmalloc() and it's not
going to the "else if" because of the rest of the condition?

I wonder how this loop works, it increases a percpu counter
n_async_inflight, and rcu_scale_async_cb() decreases it, but can't the
callback be invoked on a different cpu, making these counters imbalanced?

> invokes rcu_barrier_tasks() on line 9 (because that is what the
> rcuscale.scale_type=tasks kernel boot parameter tells it to do), then
> line 10 jumps back to the retry label.  This repeats thousands of times,
> consuming some minutes.  There is no drama in the console log, as in no
> mention of OOM killer, allocation failures, or much of anything other
> than Tasks RCU switching to per-CPU callback queueing due to the heavy
> load and the expected rcuscale output.

A GFP_KERNEL failure should definitely produce OOM or allocation failure
warning (and it's "too small to fail" to start with :)) Silently returning
NULL is, uh, inconcievable. That would really require a bug in the
implementation, or perhaps some slab structures corruption due to double
free or use after free (although I've seen those always manifest in a
different, much more noisy way).

> Note that all 16 CPUs are looping allocating and invoking either
> call_rcu_tasks() when allocation succeeds or rcu_barrier_tasks() when
> allocation fails.  So CPU 0 could simply be quite unlucky or have other
> work so that when the rcu_barrier_tasks() waits for memory to be released,
> the other CPUs allocate it all before CPU 0's rcu_scale_writer() task
> is awakened.  But again, there is no sign of memory-system drama on
> the console log.
> 
> I am good, as I implemented a stupid per-CPU-array-based allocator,
> which avoids this issue, admittedly quite crudely.

That shouldn't help if it was a problem with n_async_inflight imbalance as I
suggested above but who knows, maybe it's being busy in kmalloc() that
causes some rcu callbacks to be executed elsewhere than on the CPU that
submitted them, and using your allocator avoids that?

> Johannes suggested turning on tracing for the kmem:kmalloc and
> kmem:mm_page_alloc trace events, which I did using this command:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --configs TREE --kconfig "CONFIG_DEBUG_KERNEL=y CONFIG_RCU_TRACE=y CONFIG_FTRACE=y" --bootargs "rcuscale.scale_type=tasks rcuscale.minruntime=5 rcuscale.nreaders=0 rcuscale.nwriters rcuscale.gp_async=1 rcuscale.gp_async_max=100000 trace_event=kmem:kmalloc,kmem:mm_page_alloc trace_buf_size=3k" --trust-make
> 
> I collected the .config file [3] and console output [4].  The console
> output features more than 1500 kmalloc trace events and not quite 10
> mm_page_alloc trace events.

Hm but tracing doesn't output to console so I don't see any trace events there.

> Please let me know if more information would be helpful.
> 
> 							Thanx, Paul
> 
> [1] https://docs.google.com/document/d/1M_SJ_hVUe-jtkH6BjHzzRFOnAiu1sqThlFnx8Jfp-fg/edit?usp=sharing
> [2] bbb3556c014d ("Merge tag 'keys-next-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd"), for example.
> [3] https://drive.google.com/file/d/1lZmIvatLyVYzdRK_rv2xNNWDBiGwyQvk/view?usp=sharing
> [4] https://drive.google.com/file/d/1jh4hJG877j0Rp65153wtmzKm6jErXZ9n/view?usp=sharing

