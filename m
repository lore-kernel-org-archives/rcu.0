Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A559A17C9AF;
	Wed, 28 Aug 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857138; cv=none; b=l2X6iql3FZxWTgl4S1neWpwahZIAQP30fkxCrSOQtjVdj5wTDACBtcVT3DRRozfy7sxRHR3tBSWy0HBF+GP8s2gVvGWgiTlAVf3ZEATDMaRrkoXNDDKIEy6auVTHpBJnIvIfEP01MqlZcvRhCNkqlthdLIbW//0M6GuBdsixUv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857138; c=relaxed/simple;
	bh=LbsxPayLMWfK73/R5i5q74VLRliZidX0XUgV0P9d/QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djf3tP9jn5p3k3ZddzNEA7gMLM00TXTJr/lXmwpkxJ5+WaRrC8ws3X50LyPF7bmAiKJI+Fco5MPv3QH1AkEvPAjhwGC4rAX54QRFNz/GhmAv0Ay/F2VdpFwnL9l1uHN9oRmCh6nQN5bMCefkNZdE7utttEkp98b4rDUZbRwU5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BvivgHcn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6owY7GFC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BvivgHcn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6owY7GFC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BvivgHcn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6owY7GFC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BvivgHcn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6owY7GFC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04C4021203;
	Wed, 28 Aug 2024 14:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724857129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NYPKuh69LXMoS1namcX71BKt74Sjexuqhp2RNEdwEFk=;
	b=BvivgHcntzcrxUfiP+dVCYU4ZAgnXizXNE04F/nlRW6BpHju7WLzSO7QxigJmbl/yGjh+E
	ZuL69PuJeTKskaLmYEvJ8gjfQelUnOP30XY72p49dcsWL36uNkybq2HzyxLQa0HGEmWIla
	dJYyJl1kYPu2Rab6dgaiw6TMfcBM5PA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724857129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NYPKuh69LXMoS1namcX71BKt74Sjexuqhp2RNEdwEFk=;
	b=6owY7GFCW/Cb6ae7xnJVR+0JrROJg1kjBmRpAYvbmR0u8u6YYNrUdCsEgLtLhdOhj/LDHL
	blTs3L+t/rKNwiAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BvivgHcn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6owY7GFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724857129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NYPKuh69LXMoS1namcX71BKt74Sjexuqhp2RNEdwEFk=;
	b=BvivgHcntzcrxUfiP+dVCYU4ZAgnXizXNE04F/nlRW6BpHju7WLzSO7QxigJmbl/yGjh+E
	ZuL69PuJeTKskaLmYEvJ8gjfQelUnOP30XY72p49dcsWL36uNkybq2HzyxLQa0HGEmWIla
	dJYyJl1kYPu2Rab6dgaiw6TMfcBM5PA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724857129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NYPKuh69LXMoS1namcX71BKt74Sjexuqhp2RNEdwEFk=;
	b=6owY7GFCW/Cb6ae7xnJVR+0JrROJg1kjBmRpAYvbmR0u8u6YYNrUdCsEgLtLhdOhj/LDHL
	blTs3L+t/rKNwiAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2A58138D2;
	Wed, 28 Aug 2024 14:58:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OV35Nig7z2bbRgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 28 Aug 2024 14:58:48 +0000
Message-ID: <64bebc29-a007-4ebc-bf86-8c2c0a7e6bf6@suse.cz>
Date: Wed, 28 Aug 2024 16:58:48 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] rcu/kvfree: Support dynamic rcu_head for single
 argument objects
Content-Language: en-US
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng
 <boqun.feng@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20240828110929.3713-1-urezki@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240828110929.3713-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 04C4021203
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,joelfernandes.org,kernel.org,sony.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 8/28/24 13:09, Uladzislau Rezki (Sony) wrote:
> Add a support of dynamically attaching an rcu_head to an object
> which gets freed via the single argument of kvfree_rcu(). This is
> used in the path, when a page allocation fails due to a high memory
> pressure.
> 
> The basic idea behind of this is to minimize a hit of slow path
> which requires a caller to wait until a grace period is passed.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

So IIUC it's a situation where we can't allocate a page, but we hope the
kmalloc-32 slab has still free objects to give us dyn_rcu_head's before it
would have to also make a page allocation?

So that may really be possible and there might potentially be many such
objects, but I wonder if there's really a benefit. The system is struggling
for memory and the single-argument caller specifically is _mightsleep so it
could e.g. instead go direct reclaim a page rather than start depleting the
kmalloc-32 slab, no?

> ---
>  kernel/rcu/tree.c | 53 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index be00aac5f4e7..0124411fecfb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3425,6 +3425,11 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
>  	cond_resched_tasks_rcu_qs();
>  }
>  
> +struct dyn_rcu_head {
> +	unsigned long *ptr;
> +	struct rcu_head rh;
> +};
> +
>  static void
>  kvfree_rcu_list(struct rcu_head *head)
>  {
> @@ -3433,15 +3438,32 @@ kvfree_rcu_list(struct rcu_head *head)
>  	for (; head; head = next) {
>  		void *ptr = (void *) head->func;
>  		unsigned long offset = (void *) head - ptr;
> +		struct dyn_rcu_head *drhp = NULL;
> +
> +		/*
> +		 * For dynamically attached rcu_head, a ->func field
> +		 * points to _offset_, i.e. not to a pointer which has
> +		 * to be freed. For such objects, adjust an offset and
> +		 * pointer.
> +		 */
> +		if (__is_kvfree_rcu_offset((unsigned long) ptr)) {
> +			drhp = container_of(head, struct dyn_rcu_head, rh);
> +			offset = (unsigned long) drhp->rh.func;
> +			ptr = drhp->ptr;
> +		}
>  
>  		next = head->next;
>  		debug_rcu_head_unqueue((struct rcu_head *)ptr);
>  		rcu_lock_acquire(&rcu_callback_map);
>  		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
>  
> -		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
> +		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset))) {
>  			kvfree(ptr);
>  
> +			if (drhp)
> +				kvfree(drhp);
> +		}
> +
>  		rcu_lock_release(&rcu_callback_map);
>  		cond_resched_tasks_rcu_qs();
>  	}
> @@ -3787,6 +3809,21 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  	return true;
>  }
>  
> +static struct rcu_head *
> +attach_rcu_head_to_object(void *obj)
> +{
> +	struct dyn_rcu_head *rhp;
> +
> +	rhp = kmalloc(sizeof(struct dyn_rcu_head), GFP_KERNEL |
> +		__GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
> +
> +	if (!rhp)
> +		return NULL;
> +
> +	rhp->ptr = obj;
> +	return &rhp->rh;
> +}
> +
>  /*
>   * Queue a request for lazy invocation of the appropriate free routine
>   * after a grace period.  Please note that three paths are maintained,
> @@ -3830,9 +3867,17 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  	if (!success) {
>  		run_page_cache_worker(krcp);
>  
> -		if (head == NULL)
> -			// Inline if kvfree_rcu(one_arg) call.
> -			goto unlock_return;
> +		if (!head) {
> +			krc_this_cpu_unlock(krcp, flags);
> +			head = attach_rcu_head_to_object(ptr);
> +			krcp = krc_this_cpu_lock(&flags);
> +
> +			if (!head)
> +				// Inline if kvfree_rcu(one_arg) call.
> +				goto unlock_return;
> +
> +			ptr = (rcu_callback_t) offsetof(struct dyn_rcu_head, rh);
> +		}
>  
>  		head->func = ptr;
>  		head->next = krcp->head;

