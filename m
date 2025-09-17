Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51194293C4E
	for <rcu@vger.kernel.org>; Wed, 17 Sep 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118481; cv=none; b=lgKJfOurdnt0Lm6F9HYbWn/VzmFMO6sLAjSXdAC/goKpe0KBk2XRrxIcv671iXBxUr3coaYz1CI8pgmo24VCoNeTsfCqDTMwwiV0z8Jro2J5l5jOBAq0IpjbKF88BlwbXFslbNdlQXo0w/2eTZSJ6PVKgeVwbLNLWO1D0z5/4tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118481; c=relaxed/simple;
	bh=QLg34w+tOU3ZIyXqZVA8u1w1TxcyObmpz0aAkQ5BuTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8lpl5kmUYAZI/GEp0dXrGPElCpsd0MT2rcA4t8itZvVFvz/274pEwNUng/Jab83R5EyNAbq2QuChjob6a9YycT+PsuXoZi2Gd0BzrHgXcI+66zXYO8zwSoFRh2wTJ2GUX74YkzOA6vpWeGCktTPHGf/9zq6pOFRyCV3bxdV/as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FwJf5Wso; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uwCLR8Pj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FwJf5Wso; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uwCLR8Pj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FwJf5Wso";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uwCLR8Pj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FwJf5Wso";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uwCLR8Pj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F7A82037D;
	Wed, 17 Sep 2025 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758118477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cTQTjSokaGDrNuQ/J4+a2gYgPaSNBVSDKzhuOd4ah1o=;
	b=FwJf5WsoDOmp0EYNZcXIepoUOp+cdkExwzRDCSZAPTwy78U6cLFTGZKuInxR/vo04JtAd6
	bhAd3oIyp29bW3VisWy2vElKL4SQAJ/EgHUjmRqiEnJlhCmvE+LYrsoQoloJURmxdmRG9s
	BPt0Wf5ZQGHkAtEO7AWugxgYgR0E2Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758118477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cTQTjSokaGDrNuQ/J4+a2gYgPaSNBVSDKzhuOd4ah1o=;
	b=uwCLR8PjYkq7lLQWBRAjxmdb1vtLvWwZdcB7BY294t2H/E6dC9Gq8SrqN62AXMnfJw+p/r
	WKPoToDmlSfZNhAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758118477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cTQTjSokaGDrNuQ/J4+a2gYgPaSNBVSDKzhuOd4ah1o=;
	b=FwJf5WsoDOmp0EYNZcXIepoUOp+cdkExwzRDCSZAPTwy78U6cLFTGZKuInxR/vo04JtAd6
	bhAd3oIyp29bW3VisWy2vElKL4SQAJ/EgHUjmRqiEnJlhCmvE+LYrsoQoloJURmxdmRG9s
	BPt0Wf5ZQGHkAtEO7AWugxgYgR0E2Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758118477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cTQTjSokaGDrNuQ/J4+a2gYgPaSNBVSDKzhuOd4ah1o=;
	b=uwCLR8PjYkq7lLQWBRAjxmdb1vtLvWwZdcB7BY294t2H/E6dC9Gq8SrqN62AXMnfJw+p/r
	WKPoToDmlSfZNhAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4457D137C3;
	Wed, 17 Sep 2025 14:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kUpcEE3CymhOBQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 17 Sep 2025 14:14:37 +0000
Message-ID: <a32bd837-2597-43d0-9da3-1ce5a53b15f4@suse.cz>
Date: Wed, 17 Sep 2025 16:14:36 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching kfree_rcu()
 operations
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org, "Paul E . McKenney" <paulmck@kernel.org>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz>
 <aMpxnACqmsQl-lp0@hyeyoo> <bbda8c25-b575-4e98-b1ae-b103c6598d38@suse.cz>
 <aMqcXyKRlZggLxu_@hyeyoo> <6f92eca3-863e-4b77-b2df-dc2752c0ff4e@suse.cz>
 <aMqyn6nenR8V_p1y@hyeyoo> <bf8b4741-1025-4cc8-b9ed-5b566bdcb2d7@suse.cz>
 <aMq40h5iOjj8K7cc@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aMq40h5iOjj8K7cc@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,gentwo.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 9/17/25 15:34, Harry Yoo wrote:
> On Wed, Sep 17, 2025 at 03:21:31PM +0200, Vlastimil Babka wrote:
>> On 9/17/25 15:07, Harry Yoo wrote:
>> > On Wed, Sep 17, 2025 at 02:05:49PM +0200, Vlastimil Babka wrote:
>> >> On 9/17/25 13:32, Harry Yoo wrote:
>> >> > On Wed, Sep 17, 2025 at 11:55:10AM +0200, Vlastimil Babka wrote:
>> >> >> On 9/17/25 10:30, Harry Yoo wrote:
>> >> >> > On Wed, Sep 10, 2025 at 10:01:06AM +0200, Vlastimil Babka wrote:
>> >> >> >> +				sfw->skip = true;
>> >> >> >> +				continue;
>> >> >> >> +			}
>> >> >> >>
>> >> >> >> +			INIT_WORK(&sfw->work, flush_rcu_sheaf);
>> >> >> >> +			sfw->skip = false;
>> >> >> >> +			sfw->s = s;
>> >> >> >> +			queue_work_on(cpu, flushwq, &sfw->work);
>> >> >> >> +			flushed = true;
>> >> >> >> +		}
>> >> >> >> +
>> >> >> >> +		for_each_online_cpu(cpu) {
>> >> >> >> +			sfw = &per_cpu(slub_flush, cpu);
>> >> >> >> +			if (sfw->skip)
>> >> >> >> +				continue;
>> >> >> >> +			flush_work(&sfw->work);
>> >> >> >> +		}
>> >> >> >> +
>> >> >> >> +		mutex_unlock(&flush_lock);
>> >> >> >> +	}
>> >> >> >> +
>> >> >> >> +	mutex_unlock(&slab_mutex);
>> >> >> >> +	cpus_read_unlock();
>> >> >> >> +
>> >> >> >> +	if (flushed)
>> >> >> >> +		rcu_barrier();
>> >> >> > 
>> >> >> > I think we need to call rcu_barrier() even if flushed == false?
>> >> >> > 
>> >> >> > Maybe a kvfree_rcu()'d object was already waiting for the rcu callback to
>> >> >> > be processed before flush_all_rcu_sheaves() is called, and
>> >> >> > in flush_all_rcu_sheaves() we skipped all (cache, cpu) pairs,
>> >> >> > so flushed == false but the rcu callback isn't processed yet
>> >> >> > by the end of the function?
>> >> >> > 
>> >> >> > That sounds like a very unlikely to happen in a realistic scenario,
>> >> >> > but still possible...
>> >> >> 
>> >> >> Yes also good point, will flush unconditionally.
>> >> >> 
>> >> >> Maybe in __kfree_rcu_sheaf() I should also move the call_rcu(...) before
>> >> >> local_unlock().
>> >> >>
>> >> >> So we don't end up seeing a NULL pcs->rcu_free in
>> >> >> flush_all_rcu_sheaves() because __kfree_rcu_sheaf() already set it to NULL,
>> >> >> but didn't yet do the call_rcu() as it got preempted after local_unlock().
>> >> > 
>> >> > Makes sense to me.
>> > 
>> > Wait, I'm confused.
>> > 
>> > I think the caller of kvfree_rcu_barrier() should make sure that it's invoked
>> > only after a kvfree_rcu(X, rhs) call has returned, if the caller expects
>> > the object X to be freed before kvfree_rcu_barrier() returns?
>> 
>> Hmm, the caller of kvfree_rcu(X, rhs) might have returned without filling up
>> the rcu_sheaf fully and thus without submitting it to call_rcu(), then
>> migrated to another cpu. Then it calls kvfree_rcu_barrier() while another
>> unrelated kvfree_rcu(X, rhs) call on the previous cpu is for the same
>> kmem_cache (kvfree_rcu_barrier() is not only for cache destruction), fills
>> up the rcu_sheaf fully and is about to call_rcu() on it. And since that
>> sheaf also contains the object X, we should make sure that is flushed.
> 
> I was going to say "but we queue and wait for the flushing work to
> complete, so the sheaf containing object X should be flushed?"
> 
> But nah, that's true only if we see pcs->rcu_free != NULL in
> flush_all_rcu_sheaves().
> 
> You are right...
> 
> Hmm, maybe it's simpler to fix this by never skipping queueing the work
> even when pcs->rcu_sheaf == NULL?

I guess it's simpler, yeah.
We might have to think of something better once all caches have sheaves,
queueing and waiting for work to finish on each cpu, repeated for each
kmem_cache, might be just too much?

>> > IOW if flush_all_rcu_sheaves() is called while __kfree_rcu_sheaf(s, X) was
>> > running on another CPU, we don't have to guarantee that
>> > flush_all_rcu_sheaves() returns after the object X is freed?
>> > 
>> >> >> But then rcu_barrier() itself probably won't mean we make sure such cpus
>> >> >> finished the local_locked section, if we didn't queue work on them. So maybe
>> >> >> we need synchronize_rcu()?
>> > 
>> > So... we don't need a synchronize_rcu() then?
>> > 
>> > Or my brain started malfunctioning again :D
> 

