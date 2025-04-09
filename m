Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E297F266EE2
	for <rcu@vger.kernel.org>; Wed,  9 Apr 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211351; cv=none; b=L1GJW7KXfmU9QLj50QN3sMSUru2W/7PYAAVL1nTRmc7nVIXE+2Jn+rPsudC/P6JDJSZuRk/v5cgyecoY48BnGqtJ0vRMgr9/ZYYAyHyO6jCGVLXK9q9bi/1HIK4o3v5+MfHJ/4qoPq9VJh+8RJwIRBpQb6A0YxdG5kMyNi0qJRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211351; c=relaxed/simple;
	bh=dccumOqzcotHIcSTHMQVxrHHRSWZwdakiBo+SRB27Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnvbxeoaVu1iHqXazjGGBdEXAaM8Xtk7oXMENVYluraMKAx8BpbA5e69uQlWnWT4o3dZSHpzdzmnDwZbNtfc/d6uC53zl2mefbps8rScPwMzCAdHH2S5gIMK0ET1sR3UWmOpoywD0lT/4HnnoEUIAsFUqWAlCBTvIbE29jHxB74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lHeHIBXB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CL0zlLRp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lHeHIBXB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CL0zlLRp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lHeHIBXB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CL0zlLRp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lHeHIBXB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CL0zlLRp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B04151F445;
	Wed,  9 Apr 2025 15:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744211347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GzjR4oQ2qzzHMq50duuwsOgZ3sY0afnl6ZVMYTeN7mQ=;
	b=lHeHIBXB9K0yN22hxOlp/aqyN035ygY/uCteI0u4BeP5R/23NHblkxtNz1t4tB5o77tZNI
	qDImqWPRzPPT8H26XeMYXfrGOwWMuUEE5xg+oo2zFpoiUOENSa1VuqGnVBHLdv8mi6blJo
	SkqpYQed5XnESE7yfxX97Q58ATupaYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744211347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GzjR4oQ2qzzHMq50duuwsOgZ3sY0afnl6ZVMYTeN7mQ=;
	b=CL0zlLRpfL/PdyHX/n/HeVuT/po0VWiPjAV/2Gaz4tOBc6Sp78vd1uEKMhyrTJYcTpjxxU
	gm12g6kK96UYLoAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lHeHIBXB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CL0zlLRp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744211347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GzjR4oQ2qzzHMq50duuwsOgZ3sY0afnl6ZVMYTeN7mQ=;
	b=lHeHIBXB9K0yN22hxOlp/aqyN035ygY/uCteI0u4BeP5R/23NHblkxtNz1t4tB5o77tZNI
	qDImqWPRzPPT8H26XeMYXfrGOwWMuUEE5xg+oo2zFpoiUOENSa1VuqGnVBHLdv8mi6blJo
	SkqpYQed5XnESE7yfxX97Q58ATupaYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744211347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GzjR4oQ2qzzHMq50duuwsOgZ3sY0afnl6ZVMYTeN7mQ=;
	b=CL0zlLRpfL/PdyHX/n/HeVuT/po0VWiPjAV/2Gaz4tOBc6Sp78vd1uEKMhyrTJYcTpjxxU
	gm12g6kK96UYLoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D34B13691;
	Wed,  9 Apr 2025 15:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +D25IZON9mfPYAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 09 Apr 2025 15:09:07 +0000
Message-ID: <4f4adc4c-72fd-481f-8b41-f107f2b91ef8@suse.cz>
Date: Wed, 9 Apr 2025 17:09:08 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 3/8] slab: add sheaf support for batching
 kfree_rcu() operations
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
 <20250317-slub-percpu-caches-v3-3-9d9884d8b643@suse.cz>
 <Z_XScomDqU_Dke17@harry>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z_XScomDqU_Dke17@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B04151F445
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/9/25 3:50 AM, Harry Yoo wrote:
> On Mon, Mar 17, 2025 at 03:33:04PM +0100, Vlastimil Babka wrote:
> 
> Hmm this hunk in v3 is fine, but on your slub-percpu-shaves-v4r0 branch
> it's calling local_unlock() twice. Probably a rebase error?

Yeah, thanks a lot for catching that! I've just pushed
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-percpu-sheaves-v4r1

with this fixed, and fixups for 2/8 to the points you made, plus a
proper strict_numa handling in 2/8, and an extra patch for better NUMA
locality

> Otherwise looks good to me.
> 
> When you address this, please feel free to add:
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Thanks!
> 

