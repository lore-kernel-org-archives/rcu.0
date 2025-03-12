Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E171D514E
	for <rcu@vger.kernel.org>; Wed, 12 Mar 2025 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796362; cv=none; b=ApJuPtR+mIZjaVfQDvK/26/YwdSiwZq3PRC0sm8ysWSJDNTntcVVQ0Ajcz/ruhUZlmYJ1lfqilL0hESMXVkKhhYSTbYKHLqydRVVuocQtNto40IT8Pp7Oo6gArlarPiTi39U73JF+KEUdS7WCB2nk8CHLckURW5aUkDCJmpq/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796362; c=relaxed/simple;
	bh=tuJElgZKRCERZsoEoK9ywsoznTlCrdkFYk161ps7GKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQEH2xTJYX4Xjau5YYgafcMmBNMQJz5sizczRg0fp6RhAo5gZa+w5LkiSIZsXmP8wJKODopi9nzrVUo/AQgSWjbG51owtRBf/I/icZ4UYjJcHMsM2a/YeYFWdDyfz7V9UtIOWv9gyG11QYFi/Lwwlq58z9qI7wCa4L98WhJ8/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=olUsii4b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HObC+vVS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=olUsii4b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HObC+vVS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="olUsii4b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HObC+vVS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="olUsii4b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HObC+vVS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 841902118C;
	Wed, 12 Mar 2025 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741796358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DnTwYGcMdt2yD7Bx/7ZXmsbNs3yi4b7YI/y4yBC4Fcc=;
	b=olUsii4b7a7IQ8gk3yHHmXLdmnzC4C3L+oJwrgTQLbSdHjxsRO9s41N1phyqM/+IURZ0WG
	W3jFRBsEGjf0Rr8j4KIoi5Mjhzk98ZqFGshWxFdeJrCBa2A1tdnJSaI5MZezHcIjN/PqQE
	ezPrhc4l1YQOStgk/vx1rch/bg5NN+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741796358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DnTwYGcMdt2yD7Bx/7ZXmsbNs3yi4b7YI/y4yBC4Fcc=;
	b=HObC+vVSS/Wpao5eAhBkPwafJLeb5mSTnjwbFmv16/Qe+lUCeqVHdUjlrq2AN8U6kmarji
	tjffBKarma0bmSBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741796358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DnTwYGcMdt2yD7Bx/7ZXmsbNs3yi4b7YI/y4yBC4Fcc=;
	b=olUsii4b7a7IQ8gk3yHHmXLdmnzC4C3L+oJwrgTQLbSdHjxsRO9s41N1phyqM/+IURZ0WG
	W3jFRBsEGjf0Rr8j4KIoi5Mjhzk98ZqFGshWxFdeJrCBa2A1tdnJSaI5MZezHcIjN/PqQE
	ezPrhc4l1YQOStgk/vx1rch/bg5NN+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741796358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DnTwYGcMdt2yD7Bx/7ZXmsbNs3yi4b7YI/y4yBC4Fcc=;
	b=HObC+vVSS/Wpao5eAhBkPwafJLeb5mSTnjwbFmv16/Qe+lUCeqVHdUjlrq2AN8U6kmarji
	tjffBKarma0bmSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 504A51377F;
	Wed, 12 Mar 2025 16:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KrvsDga00WeoHQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 12 Mar 2025 16:19:18 +0000
Message-ID: <ba1dcb86-4585-4eb7-927e-d2c8a648f662@suse.cz>
Date: Wed, 12 Mar 2025 17:19:18 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 02/10] slab: add sheaf support for batching
 kfree_rcu() operations
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-2-88592ee0966a@suse.cz>
 <CAJuCfpH+sKs6j02j_hFALTT=ccrGXkny1=aUvuHZKKjtgr1fmA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpH+sKs6j02j_hFALTT=ccrGXkny1=aUvuHZKKjtgr1fmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.com,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 2/23/25 00:08, Suren Baghdasaryan wrote:
> On Fri, Feb 14, 2025 at 8:27 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
>> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
>> addition to main and spare sheaves.
>>
>> kfree_rcu() operations will try to put objects on this sheaf. Once full,
>> the sheaf is detached and submitted to call_rcu() with a handler that
>> will try to put in in the barn, or flush to slab pages using bulk free,
> 
> s/in in/it in
> 
>> when the barn is full. Then a new empty sheaf must be obtained to put
>> more objects there.
>>
>> It's possible that no free sheaves are available to use for a new
>> rcu_free sheaf, and the allocation in kfree_rcu() context can only use
>> GFP_NOWAIT and thus may fail. In that case, fall back to the existing
>> kfree_rcu() machinery.
>>
>> Expected advantages:
>> - batching the kfree_rcu() operations, that could eventually replace the
>>   existing batching
>> - sheaves can be reused for allocations via barn instead of being
>>   flushed to slabs, which is more efficient
>>   - this includes cases where only some cpus are allowed to process rcu
>>     callbacks (Android)
>>
>> Possible disadvantage:
>> - objects might be waiting for more than their grace period (it is
>>   determined by the last object freed into the sheaf), increasing memory
>>   usage - but the existing batching does that too?
>>
>> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
>> implementation favors smaller memory footprint over performance.
>>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks.

>> @@ -2569,6 +2571,24 @@ static void sheaf_flush(struct kmem_cache *s, struct slab_sheaf *sheaf)
>>         sheaf->size = 0;
>>  }
>>
>> +static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
>> +                                    struct slab_sheaf *sheaf);
>> +
>> +static void rcu_free_sheaf_nobarn(struct rcu_head *head)
>> +{
>> +       struct slab_sheaf *sheaf;
>> +       struct kmem_cache *s;
>> +
>> +       sheaf = container_of(head, struct slab_sheaf, rcu_head);
>> +       s = sheaf->cache;
> 
> Ah, that's where you are using sheaf->cache. Maybe you should
> introduce it in this patch?

Yeah. Will also move the addition of rcu_free to struct slub_percpu_sheaves
instead of those TODOs.

