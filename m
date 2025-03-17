Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8B2236FD
	for <rcu@vger.kernel.org>; Mon, 17 Mar 2025 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206180; cv=none; b=s1sCXIEmq4+ygzeq3wd95hqABWpD0k2wE7eL8lbdrTxONEMzXlcdyil4kBlt4+9adwqbQd9/NaKbnAZtoBllgmePK8cRWkL/aXMzN63icPtiqrrLr9CzfNRc1Y0KuWcjI3CCzKNORWlRZFgn8T6WYjKACYpyC3OC/ZUDwAD7jEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206180; c=relaxed/simple;
	bh=RWqYOAA5tbEc6bfm4D63/g9qpPi74sA1IhlXJ1qk+L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ytnv9CPTph7zs72PoCDhlP25IR/R0cH+m612lPJgs6c9CMS4ycf64kxHav36a54Mytdrs2JAf3Q9BDAhRyOhgPe8ORf4S0op54E9/WlWjPl/GQ6AtF92NRRSz0t7NE6i25UfAyvZJRoPxki+rteUI/rmtNm6QFW0AIxm1dz+gg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2zqCNa3k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZnSs9nuF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2zqCNa3k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZnSs9nuF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2zqCNa3k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZnSs9nuF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2zqCNa3k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZnSs9nuF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C79C721A9A;
	Mon, 17 Mar 2025 10:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742206176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Xq7lBKy5lPmzEwBcsRowSYenNgBJYixD9T0ziVEtAY=;
	b=2zqCNa3kOVVBSVca1eFpmuD2rauprLsaCT8uTN/qFLPOeMTXGiTS9CaD4OeQvhwEJq1gso
	ofI8IPJ+SvfaMp1x4Gu13/5lFeHK7hA5FgfKrOtBZS3QIh2NdLrilv4ga4Quh/VqsU+IUt
	jqQhTomHtMeYnTnv8IzfxnfvaJodeuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742206176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Xq7lBKy5lPmzEwBcsRowSYenNgBJYixD9T0ziVEtAY=;
	b=ZnSs9nuFD0z+rG2M8LU8sWQX3IW8ha2hxgwarPk0hSgs1pxan4YEvYoz3z5837YDFSdmn1
	rqxTVt50H90QMwCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2zqCNa3k;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZnSs9nuF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742206176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Xq7lBKy5lPmzEwBcsRowSYenNgBJYixD9T0ziVEtAY=;
	b=2zqCNa3kOVVBSVca1eFpmuD2rauprLsaCT8uTN/qFLPOeMTXGiTS9CaD4OeQvhwEJq1gso
	ofI8IPJ+SvfaMp1x4Gu13/5lFeHK7hA5FgfKrOtBZS3QIh2NdLrilv4ga4Quh/VqsU+IUt
	jqQhTomHtMeYnTnv8IzfxnfvaJodeuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742206176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Xq7lBKy5lPmzEwBcsRowSYenNgBJYixD9T0ziVEtAY=;
	b=ZnSs9nuFD0z+rG2M8LU8sWQX3IW8ha2hxgwarPk0hSgs1pxan4YEvYoz3z5837YDFSdmn1
	rqxTVt50H90QMwCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77728132CF;
	Mon, 17 Mar 2025 10:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FW3OHOD012cIHQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 17 Mar 2025 10:09:36 +0000
Message-ID: <cbbaa3f3-bbb2-4dab-8cd2-72a55df7a3a8@suse.cz>
Date: Mon, 17 Mar 2025 11:09:36 +0100
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
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-1-88592ee0966a@suse.cz>
 <CAJuCfpG4BYNWM24_Jha-SapfeaGdO0GKuteHwNE1hDdWXRS+1Q@mail.gmail.com>
 <befd17b0-160e-4933-96d9-8d5c4a774162@suse.cz>
 <CAJuCfpHwvAUep6YT3Eu2SCu-dDbUoN=WE8r9aEV4UDWKfHXV+g@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpHwvAUep6YT3Eu2SCu-dDbUoN=WE8r9aEV4UDWKfHXV+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C79C721A9A
X-Spam-Level: 
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.com,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 3/12/25 16:14, Suren Baghdasaryan wrote:
> On Wed, Mar 12, 2025 at 7:58 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> > I find the program flow in this function quite complex and hard to
>> > follow. I think refactoring the above block starting from "pcs =
>> > this_cpu_ptr(s->cpu_sheaves)" would somewhat simplify it. That
>> > eliminates the need for the "got_empty" label and makes the
>> > locking/unlocking sequence of s->cpu_sheaves->lock a bit more clear.
>>
>> I'm a bit lost, refactoring how exactly?
> 
> I thought moving the code above into a function above starting from
> "pcs = this_cpu_ptr(s->cpu_sheaves)" into its own function would
> simplify the flow. But as I said, it's a nit. If you try and don't
> like that feel free to ignore this suggestion.

OK did it and although I didn't manage to remove the got_empty label, it's
better and I realized I can handle the cases there in a better order and add
one extra possible fallback in the unlikely cases. Please check the result
when I send v3? thanks

>>
>> >> +       }
>> >> +
>> >> +do_free:
>> >> +       pcs->main->objects[pcs->main->size++] = object;
>> >> +
>> >> +       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
>> >> +
>> >> +       stat(s, FREE_PCS);
>> >> +}

