Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B62D1A2396
	for <rcu@vger.kernel.org>; Thu, 15 May 2025 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298740; cv=none; b=gPtrMXEWTNpS5UBf3O0VcS2lnifCImwvwFgWql1NWzOoQ8lTbtZluEPmMIszLy//2S/NRj0cNnQc6jL7ijmnwgLCVlswnvE1xDhJIKL8fkzbWW/SPGC5RD7ilh1gvZ/lSlxf9fqCb5UOgWwpqnKKU4v0ENNvywr2HsCL/m/5/A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298740; c=relaxed/simple;
	bh=vSsNhJiyAn3s3OhcgAxNKV1C08rwcm+xP8znhvNGVVs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gEPEDcc4wTF0QAjQR/KXQsVPE0P+C2kSWQnR/v3UZ7zM5MXkgYyAxXr0YWgWdLPiRLZ+RnZA4u8WLBvamSWBB70d2Cbs/g8KIx20SSkZLP70WVRI8Kexsf+EyAsD++ZtYdm7/Q99zd1mNmukrLdq+cXWxwVsF6qCW7Ay6JIhH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W+Du45ot; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=392r+Jex; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W+Du45ot; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=392r+Jex; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W+Du45ot";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="392r+Jex";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W+Du45ot";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="392r+Jex"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E475C2115E;
	Thu, 15 May 2025 08:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747298736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VumhYrRKD4m6/mW6n6DUnExU9MsUD1DrmUJaXs125Mg=;
	b=W+Du45otPPQRaFkRaLYmcz7ggB6BCAlpE/zVfwtlsWAPIP3ON+1StnIgtZrga7yadtRdfq
	U8K4trvMAxchBtiReYjdE8L1eCpyrdyRgQAqINXsHZkoMlGnv/pUS/4YI3sEN/1EuiJgSN
	miaVemQzC4zTXlkE8LbJrhgXLuVaTeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747298736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VumhYrRKD4m6/mW6n6DUnExU9MsUD1DrmUJaXs125Mg=;
	b=392r+JexXT9DmX8Q0iB8+hJXlgQxtamR/qGkLsIhys0UPMnz3m4UE0VjVifL7hJuTjiN/g
	vyt71YdzetYB9xCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747298736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VumhYrRKD4m6/mW6n6DUnExU9MsUD1DrmUJaXs125Mg=;
	b=W+Du45otPPQRaFkRaLYmcz7ggB6BCAlpE/zVfwtlsWAPIP3ON+1StnIgtZrga7yadtRdfq
	U8K4trvMAxchBtiReYjdE8L1eCpyrdyRgQAqINXsHZkoMlGnv/pUS/4YI3sEN/1EuiJgSN
	miaVemQzC4zTXlkE8LbJrhgXLuVaTeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747298736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VumhYrRKD4m6/mW6n6DUnExU9MsUD1DrmUJaXs125Mg=;
	b=392r+JexXT9DmX8Q0iB8+hJXlgQxtamR/qGkLsIhys0UPMnz3m4UE0VjVifL7hJuTjiN/g
	vyt71YdzetYB9xCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFEF4137E8;
	Thu, 15 May 2025 08:45:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lHp0MrCpJWjcPwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 May 2025 08:45:36 +0000
Message-ID: <07f321d5-4416-4be4-9696-00f0d83895f5@suse.cz>
Date: Thu, 15 May 2025 10:45:36 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] slab: add sheaf support for batching kfree_rcu()
 operations
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
 <20250425-slub-percpu-caches-v4-2-8a636982b4a4@suse.cz>
 <CAJuCfpGVx2jG+S2ch2hqK=sAdmTcs9dW0kOdopxgLtH4V_wNXQ@mail.gmail.com>
 <f181285e-4167-4581-a712-8e444a0ab2bb@suse.cz>
In-Reply-To: <f181285e-4167-4581-a712-8e444a0ab2bb@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.com,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]

On 5/14/25 16:01, Vlastimil Babka wrote:
> On 5/6/25 23:34, Suren Baghdasaryan wrote:
>> On Fri, Apr 25, 2025 at 1:27 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>> @@ -2631,6 +2637,24 @@ static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf)
>>>         sheaf->size = 0;
>>>  }
>>>
>>> +static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
>>> +                                    struct slab_sheaf *sheaf);
>> 
>> I think you could safely move __rcu_free_sheaf_prepare() here and
>> avoid the above forward declaration.
> 
> Right, done.
> 
>>> @@ -5304,6 +5340,140 @@ bool free_to_pcs(struct kmem_cache *s, void *object)
>>>         return true;
>>>  }
>>>
>>> +static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
>>> +                                    struct slab_sheaf *sheaf)
>> 
>> This function seems to be an almost exact copy of free_to_pcs_bulk()
>> from your previous patch. Maybe they can be consolidated?
> 
> True, I've extracted it to __kmem_cache_free_bulk_prepare().

... and that was a mistake as free_to_pcs_bulk() diverges in patch 9/9 in a
way that this makes it too infeasible
