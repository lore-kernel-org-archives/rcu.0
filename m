Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939F78F29
	for <rcu@vger.kernel.org>; Wed, 12 Mar 2025 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796209; cv=none; b=cNUGNAKd5Y3qi7r6qdgGqj1Pkvs2QP7MhGrLH4QQv8ZEThHVFWlBDEV2wwzqPN5u6aI2+V41HBl6QSR/39ZuRDW1Ae4wyvxq2CJwDRgbKbKc0ItT7fuNC7VYAhRxv4eNU8cjxeX6JZWEXDUU/QgL81dQw2X35MemQ8zbgGg8lkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796209; c=relaxed/simple;
	bh=4EQSks7ABnZp8jyg+gvmTS0PjFV2gBcRNtca8KtuZfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WA5pL6IFN9I8xCTfKJa5SOWtZfL3MeDnm/0yQtBabKeVWHHEv4ZQglnZcknpedtniR79a3626bYv73YbXKUTMo8n5aYKumUfV2atSZro/qf3jjR67hHfsOnFvWfQBheDpqs6dnBirJUdcifQDxof7IwEgz06XZpUyVv4j9viW3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GMj1FHqk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8Xp5iAxR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GMj1FHqk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8Xp5iAxR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GMj1FHqk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8Xp5iAxR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GMj1FHqk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8Xp5iAxR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6391C1F388;
	Wed, 12 Mar 2025 16:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741796206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppOhyx0kE4ei6ipVBks4/WS+k6TC55C6fYxiAo4Xs3Y=;
	b=GMj1FHqkciFjlfl2AbEeGCyGdU+HLEtzneLUWGK16/ZDxRLJNsrFKTI2Db1/c3rwIErFWh
	MyeA8bpbRNpAURd93YMDpiTP44d0m6DWwtpko5eH9l1Aw/gih2F1oGnfgKGSHCTwrFhl+z
	ApW92AV1wP0PkzwWLWmv19MyuKXuZso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741796206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppOhyx0kE4ei6ipVBks4/WS+k6TC55C6fYxiAo4Xs3Y=;
	b=8Xp5iAxR/kq7ggDTGycn6cEhGYwSIn0zz2Ajays4o20u/gBLUvXJArlJH8RhsdSjKBmlMn
	mkeeJHmMEir5rlDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GMj1FHqk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8Xp5iAxR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741796206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppOhyx0kE4ei6ipVBks4/WS+k6TC55C6fYxiAo4Xs3Y=;
	b=GMj1FHqkciFjlfl2AbEeGCyGdU+HLEtzneLUWGK16/ZDxRLJNsrFKTI2Db1/c3rwIErFWh
	MyeA8bpbRNpAURd93YMDpiTP44d0m6DWwtpko5eH9l1Aw/gih2F1oGnfgKGSHCTwrFhl+z
	ApW92AV1wP0PkzwWLWmv19MyuKXuZso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741796206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppOhyx0kE4ei6ipVBks4/WS+k6TC55C6fYxiAo4Xs3Y=;
	b=8Xp5iAxR/kq7ggDTGycn6cEhGYwSIn0zz2Ajays4o20u/gBLUvXJArlJH8RhsdSjKBmlMn
	mkeeJHmMEir5rlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46F051377F;
	Wed, 12 Mar 2025 16:16:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Azr6EG6z0WfkHAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 12 Mar 2025 16:16:46 +0000
Message-ID: <711b5e47-ed20-45a2-a912-42db5491a25f@suse.cz>
Date: Wed, 12 Mar 2025 17:16:46 +0100
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
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-2-88592ee0966a@suse.cz>
 <Z7wwlLQFBDlcmsDT@harry>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z7wwlLQFBDlcmsDT@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6391C1F388
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/24/25 09:40, Harry Yoo wrote:
>> +static bool kfree_rcu_sheaf(void *obj)
>> +{
>> +	struct kmem_cache *s;
>> +	struct folio *folio;
>> +	struct slab *slab;
>> +
>> +	folio = virt_to_folio(obj);
>> +	if (unlikely(!folio_test_slab(folio)))
>> +		return false;
> 
> Does virt_to_folio() work for vmalloc addresses?

Hm, no. Good catch.

> Probably it should check is_vmalloc_addr() first?

Yes, thanks!

> Otherwise look good to me.
> 
