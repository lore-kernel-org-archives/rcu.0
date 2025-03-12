Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F72224500F
	for <rcu@vger.kernel.org>; Wed, 12 Mar 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791550; cv=none; b=UHAxtZHqCRw85uP8qr+h3FX6XLg3yepaQWj8ySHXszlRfLNI0S1YDug+yLCBOo15/Sh6MsaT8BkA4etF7H5UvyqlJ9BRbMZH6hK6X7rDoP6yAdpa+IdwMwF2fxwcUbD9MHapdYCyE6cHKBNWOQluGNie6CkHkxrgwuKSN0BpX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791550; c=relaxed/simple;
	bh=DDschxg9aON+yUX+qbbRhunT4IdafoatbQyYwH2uQjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrSU0sYydHn5e6df7hhku54guWS8yrpaYJHF1WOx/dIPniNkeHvLGyibJtHc6PzzefXcaGA3J66iUj1B1jUFJbd2cykZjv57BD4k0OV9GhLszCDtvuHAgJkEMotyhS6Vi5zxQig8CDbTf6o/PB0HmYwbHvP4X7sCR3M26y1XOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qF8Q3tmZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PkVWaqgd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qF8Q3tmZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PkVWaqgd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qF8Q3tmZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PkVWaqgd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qF8Q3tmZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PkVWaqgd"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBE6721162;
	Wed, 12 Mar 2025 14:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741791546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZvV4vKA5vYd6vr6nTnELCHn+UXS+fNwMlNQ1aAYmss=;
	b=qF8Q3tmZQZrDdBv4pMmY45d2A+kaMugGTS20tq10V6NpXXsG6Km8+BTnSEcHpI/jzsZe5T
	frhJhBD/4qkEdojAGoANn+ppAJeN/zgJENg2FNpn0OQO/BQKM2EMlQ/aXNEAfM+8t1w7/m
	i6xRGcon6sUO3kBPv8zaklEQF0PxTWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741791546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZvV4vKA5vYd6vr6nTnELCHn+UXS+fNwMlNQ1aAYmss=;
	b=PkVWaqgd1GFjeCjYjEMsjlUU9kjZtzbA5tLgTp4SLL1PuAVyMsUNyXix5t2dPn4UiSf714
	z3kbGe3sC8MNdfCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741791546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZvV4vKA5vYd6vr6nTnELCHn+UXS+fNwMlNQ1aAYmss=;
	b=qF8Q3tmZQZrDdBv4pMmY45d2A+kaMugGTS20tq10V6NpXXsG6Km8+BTnSEcHpI/jzsZe5T
	frhJhBD/4qkEdojAGoANn+ppAJeN/zgJENg2FNpn0OQO/BQKM2EMlQ/aXNEAfM+8t1w7/m
	i6xRGcon6sUO3kBPv8zaklEQF0PxTWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741791546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZvV4vKA5vYd6vr6nTnELCHn+UXS+fNwMlNQ1aAYmss=;
	b=PkVWaqgd1GFjeCjYjEMsjlUU9kjZtzbA5tLgTp4SLL1PuAVyMsUNyXix5t2dPn4UiSf714
	z3kbGe3sC8MNdfCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6960132CB;
	Wed, 12 Mar 2025 14:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0HkqKDqh0WfTAgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 12 Mar 2025 14:59:06 +0000
Message-ID: <0b843e18-1e1e-427f-832e-f49c156ee99d@suse.cz>
Date: Wed, 12 Mar 2025 15:59:06 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/10] slab: add opt-in caching layer of percpu
 sheaves
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
 <20250214-slub-percpu-caches-v2-1-88592ee0966a@suse.cz>
 <Z7woDjICqD0fkghA@harry>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z7woDjICqD0fkghA@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/24/25 09:04, Harry Yoo wrote:
>> +static void barn_shrink(struct kmem_cache *s, struct node_barn *barn)
>> +{
>> +	struct list_head empty_list;
>> +	struct list_head full_list;
>> +	struct slab_sheaf *sheaf, *sheaf2;
>> +	unsigned long flags;
>> +
>> +	INIT_LIST_HEAD(&empty_list);
>> +	INIT_LIST_HEAD(&full_list);
>> +
>> +	spin_lock_irqsave(&barn->lock, flags);
>> +
>> +	list_splice_init(&barn->sheaves_full, &full_list);
>> +	barn->nr_full = 0;
>> +	list_splice_init(&barn->sheaves_empty, &empty_list);
>> +	barn->nr_empty = 0;
>> +
>> +	spin_unlock_irqrestore(&barn->lock, flags);
>> +
>> +	list_for_each_entry_safe(sheaf, sheaf2, &full_list, barn_list) {
>> +		sheaf_flush(s, sheaf);
>> +		list_move(&sheaf->barn_list, &empty_list);
>> +	}
> 
> nit: is this list_move() necessary?

You mean I can just do free_empty_sheaf(s, sheaf); ? Yeah why not.

>> +
>> +	list_for_each_entry_safe(sheaf, sheaf2, &empty_list, barn_list)
>> +		free_empty_sheaf(s, sheaf);
>> +}
> 
> Otherwise looks good to me.

Thanks.

