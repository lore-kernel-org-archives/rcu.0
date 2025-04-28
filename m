Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F31D5170
	for <rcu@vger.kernel.org>; Mon, 28 Apr 2025 07:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824141; cv=none; b=LThc9JLaJ8aLV8g8c24MIsOXAkDALhiA59u915ONQuODQBTyvOaniylt3DMg5uO1/0XOAD6joSkufIOv0rFmGiZMcXoQ9yG8pIaFb/fT18mE/yKUQQ9GRJa8VXxdS3kHFy7OLNpNhookg694jSvD4BE6QtUL17HvKgTN8Nx6TF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824141; c=relaxed/simple;
	bh=X/d8c9yK9dhj6foZwP5LprADsf/VKS7l6kuVoqJ0HmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBeVZaKLuBFzVZ4ShFt57DyjkHQirMKIKvz/ubDOTcMiOuPGWnCHxoe2ApaDjdWJmlq99saSCIYP9n1rC/HEBAAtn3oMs1N26HmNfRspTU8yO1Smda9d1QhDymTIbI18U/45A9SyVQI3/9dC+ANHB/igZ5WV2mhKRInttUu6jp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NWXgkX6B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WPoCqY/9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NWXgkX6B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WPoCqY/9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NWXgkX6B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WPoCqY/9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NWXgkX6B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WPoCqY/9"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 356561F79A;
	Mon, 28 Apr 2025 07:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745824137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sZmDOuIogPe7qEvLrhXcVBYttZaKXWZ8nMnVn+4+zY=;
	b=NWXgkX6BzdbXDFFm26+TQqCBhjDzZvhjB5h9OkpJiL4ZOoMfiImGZvnIIPEPpVIJ8Ji63o
	rm68FeyqtCJns9X823nwyr6eDpDbKbisR40oryeqmtHWpuybT+5o++BfjFxqaf+8R7hdHE
	WmBa+PkMtVOQlX5W4REo8grxHoDWcw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745824137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sZmDOuIogPe7qEvLrhXcVBYttZaKXWZ8nMnVn+4+zY=;
	b=WPoCqY/9pFrNI+nVaceSjsOWEzDoKhr6pwqzpFEfhqvMu9mrcdaJTVF1o4PTYqLWtPFMSl
	/WrmToKjtQ3MN8CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745824137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sZmDOuIogPe7qEvLrhXcVBYttZaKXWZ8nMnVn+4+zY=;
	b=NWXgkX6BzdbXDFFm26+TQqCBhjDzZvhjB5h9OkpJiL4ZOoMfiImGZvnIIPEPpVIJ8Ji63o
	rm68FeyqtCJns9X823nwyr6eDpDbKbisR40oryeqmtHWpuybT+5o++BfjFxqaf+8R7hdHE
	WmBa+PkMtVOQlX5W4REo8grxHoDWcw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745824137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sZmDOuIogPe7qEvLrhXcVBYttZaKXWZ8nMnVn+4+zY=;
	b=WPoCqY/9pFrNI+nVaceSjsOWEzDoKhr6pwqzpFEfhqvMu9mrcdaJTVF1o4PTYqLWtPFMSl
	/WrmToKjtQ3MN8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1478713A25;
	Mon, 28 Apr 2025 07:08:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iHCpBIkpD2hFZgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 28 Apr 2025 07:08:57 +0000
Message-ID: <1ceedd5b-16c1-4844-815d-1623ab7e7ae8@suse.cz>
Date: Mon, 28 Apr 2025 09:08:56 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] mm, slub: skip percpu sheaves for remote object
 freeing
Content-Language: en-US
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
 <20250425-slub-percpu-caches-v4-9-8a636982b4a4@suse.cz>
 <c60ae681-6027-0626-8d4e-5833982bf1f0@gentwo.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <c60ae681-6027-0626-8d4e-5833982bf1f0@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 4/25/25 19:35, Christoph Lameter (Ampere) wrote:
> On Fri, 25 Apr 2025, Vlastimil Babka wrote:
> 
>> @@ -5924,8 +5948,15 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>>  	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
>>  		return;
>>
>> -	if (!s->cpu_sheaves || !free_to_pcs(s, object))
>> -		do_slab_free(s, slab, object, object, 1, addr);
>> +	if (s->cpu_sheaves) {
>> +		if (likely(!IS_ENABLED(CONFIG_NUMA) ||
>> +			   slab_nid(slab) == numa_node_id())) {
> 
> Ah. ok this removes remote object freeing to the pcs.
> 
> numa_mem_id() is needed to support memory less numa nodes.

Ah right those... will fix, thanks.

>> +			free_to_pcs(s, object);
>> +			return;
>> +		}
>> +	}
>> +
>> +	do_slab_free(s, slab, object, object, 1, addr);
>>  }
>>
>>  #ifdef CONFIG_MEMCG
>>
>>

