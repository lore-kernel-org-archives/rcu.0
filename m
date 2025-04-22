Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC1028FFD7
	for <rcu@vger.kernel.org>; Tue, 22 Apr 2025 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335115; cv=none; b=CsnkeL8zjllt/zf+wWFmMZM242mVUDDVcJJbQEB9gNR//k8Bhiu+LulEyOr1oN5voEU3J0AbfQ2Vyta3hk5u/PoiswBp295GkzmFr2g46CweJ/Jt8w3M7czrpUn+PYSRoH6A6JSssATTOdxr3zaM/MBW2QIZtO4wzhvnWidnTKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335115; c=relaxed/simple;
	bh=O7O1HUOqXWtgi/7BbF6CmhXNu/pLf44I43COzKIOCAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgb+HZ6PfHC66h4ByxfFazx1RBQGbJMoekbGtiDgWM7XnRBrjb6HzD6kXbwnSd35iSGQr5sN5C6g9Y5MSsEMoG005HjxInhT0y85k8M1Oul6gfYXIu+PnR9Tm862v8nrXCnbpGuqR/16T8o6EXXCU+XpZIorUyoaA0YiT7pwEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rb6QrEHD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F8BRKD89; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rb6QrEHD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F8BRKD89; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rb6QrEHD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F8BRKD89";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rb6QrEHD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F8BRKD89"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A5D91F444;
	Tue, 22 Apr 2025 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745335112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qIowkUb8d5DnxERLcyZg+ki2dIcWLAGmwJky9ZSMEk=;
	b=Rb6QrEHDZXXJzMyX0jUPTsHJrnOgwVBs0FCB64+ZABTOF+xN07wmkJUF/s2cEj/F73mNzb
	jcBv18Pw3RBCzWU7pEsgZojjLHEMZYOMVEPaH9WmO7TYqXvOGkw7cIJ3JxgPnSQ/gp7ZmX
	brQJ5HagErM/8FMZ3ZQ8gAcKI/FxeHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745335112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qIowkUb8d5DnxERLcyZg+ki2dIcWLAGmwJky9ZSMEk=;
	b=F8BRKD89D6uSPLoxpKaRJzSU4yVPus4VOhZjJMzgTkKR61yPHtCmhahm7rwsaF5EQo2bDv
	xHO1JHOSKdrJnPDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Rb6QrEHD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=F8BRKD89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745335112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qIowkUb8d5DnxERLcyZg+ki2dIcWLAGmwJky9ZSMEk=;
	b=Rb6QrEHDZXXJzMyX0jUPTsHJrnOgwVBs0FCB64+ZABTOF+xN07wmkJUF/s2cEj/F73mNzb
	jcBv18Pw3RBCzWU7pEsgZojjLHEMZYOMVEPaH9WmO7TYqXvOGkw7cIJ3JxgPnSQ/gp7ZmX
	brQJ5HagErM/8FMZ3ZQ8gAcKI/FxeHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745335112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qIowkUb8d5DnxERLcyZg+ki2dIcWLAGmwJky9ZSMEk=;
	b=F8BRKD89D6uSPLoxpKaRJzSU4yVPus4VOhZjJMzgTkKR61yPHtCmhahm7rwsaF5EQo2bDv
	xHO1JHOSKdrJnPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EEC7137CF;
	Tue, 22 Apr 2025 15:18:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zJ/TFkizB2hQXAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 22 Apr 2025 15:18:32 +0000
Message-ID: <9073aa19-0f12-4dd7-8d10-2f159f3fd362@suse.cz>
Date: Tue, 22 Apr 2025 17:18:32 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 3/8] slab: add sheaf support for batching
 kfree_rcu() operations
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
 <20250317-slub-percpu-caches-v3-3-9d9884d8b643@suse.cz>
 <CAJuCfpGOcrTM3PCbdPpEjX--4BkQO=ErHJW_026osqex+LBSxg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpGOcrTM3PCbdPpEjX--4BkQO=ErHJW_026osqex+LBSxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A5D91F444
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,linux.com,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/10/25 22:24, Suren Baghdasaryan wrote:
> On Mon, Mar 17, 2025 at 7:33 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> +do_free:
>> +
>> +       rcu_sheaf = pcs->rcu_free;
>> +
>> +       rcu_sheaf->objects[rcu_sheaf->size++] = obj;
>> +
>> +       if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
>> +               localtry_unlock(&s->cpu_sheaves->lock);
>> +               stat(s, FREE_RCU_SHEAF);
>> +               return true;
>> +       }
>> +
>> +       pcs->rcu_free = NULL;
>> +       localtry_unlock(&s->cpu_sheaves->lock);
>> +
>> +       call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
>> +
>> +       stat(s, FREE_RCU_SHEAF);
>> +       return true;
> 
> nit: I think the above code could be simplified to:
> 
> do_free:
>         rcu_sheaf = pcs->rcu_free;
>         rcu_sheaf->objects[rcu_sheaf->size++] = obj;
>         if (likely(rcu_sheaf->size < s->sheaf_capacity))
>                 rcu_sheaf = NULL;
>         else
>                 pcs->rcu_free = NULL;
> 
>         localtry_unlock(&s->cpu_sheaves->lock);
>         stat(s, FREE_RCU_SHEAF);
>         if (rcu_sheaf)
>                 call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> 
>         return true;

Right, done. Thanks.

