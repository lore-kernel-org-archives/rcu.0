Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49453C5DC5
	for <rcu@vger.kernel.org>; Wed, 24 Jun 2026 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311423; cv=none; b=H779J5BribpHtf3mIzMvcGrWAyXKvm57l9ujx/NsXyglqeQyrUqS/AsmygMARLkO5VvFJeqS4Qlj9vqOHD/E5XrN8oiDIAOiHKtrRZ24pkkzsDpHN8+OpwLiTeyA25spT4YDexFFLAhGQUUG+JVYumTKuuF7e9WhQ9EsZkDHiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311423; c=relaxed/simple;
	bh=FRt098v0V+Fv1Ij08tN/Ml9VlCaMRMintPWYBaPjl14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRZeIq0wdLu3Dgs/fdGNOsCYGau7pMNpSTasGaz7u6fnmNlvQEELfQY/G95H3OiiJByKI9OO91A/CFAI7wwiWTE6TDOZ5HnvnjSFQq2qZD7gK+0fincik1Y4Qbrk0AlnjMdpZ05N8E/FNkYw3PAHSRLyKTZABZ7U+ESNDJwA87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=efQK7yFs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rP4xkJoS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t/LGhA4g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2JHYmjbG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="efQK7yFs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rP4xkJoS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t/LGhA4g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2JHYmjbG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DEC246CFC4;
	Wed, 24 Jun 2026 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782311420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bDUcBVoM9gSGROPcuY7Mn0vWKWX29qFwrzj5APjK3C4=;
	b=efQK7yFsHlv0OJKUB5g6Eo+12pf2yoHmSmIWcdCocEyKa8kHdrCfoRbZ/p3lkvKBSogepl
	cwpQHEidrTSCNPN/SCvdLuLMehwYyDnhDBI7ZR61SCscN7FeMI3hGMihOmVv+LWvRBniLo
	mXvRkJHu2+vv8Gw42IaTkmHDzacjCrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782311420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bDUcBVoM9gSGROPcuY7Mn0vWKWX29qFwrzj5APjK3C4=;
	b=rP4xkJoSxY9r9aIeGXiMSquCRH7xsGdnpKsMUrH3I90GuxwCsF8VB4KwOG2/Mk6AjjwxPB
	qNFxy1tGs3EYpYBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="t/LGhA4g";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2JHYmjbG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782311419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bDUcBVoM9gSGROPcuY7Mn0vWKWX29qFwrzj5APjK3C4=;
	b=t/LGhA4g85m5EzELTXWNcw+vRn0krzoE+Sh7Hx+W7i4/N9tJzalGPn1qxCsZGVEVqFlOAZ
	R5RKBiYAYP2hGYlp4QEYx1yi8XDS6gZQLE5sE77U6uPRaMzmE6rv6ydkCMV6HK8Gq72fAr
	hof8usLxlL6hghkRI4xoVfQYjdPuFxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782311419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bDUcBVoM9gSGROPcuY7Mn0vWKWX29qFwrzj5APjK3C4=;
	b=2JHYmjbGybxWeS9J4ua47txjjZzHXCHOYKV4qmnjgGBhqobHKPpCRVN6QU4bKoPjTP4ARR
	lVZzDXptms4noLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12326779A8;
	Wed, 24 Jun 2026 14:30:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rUgUAfrpO2o5RQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 24 Jun 2026 14:30:18 +0000
Date: Wed, 24 Jun 2026 15:30:16 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH for-next v3 4/9] mm/slab: use call_rcu() in unknown
 context if irqs are enabled
Message-ID: <ajvpq2Ay-nRH7s-X@pedro-suse>
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-4-70a54f3775bb@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-kfree_rcu_nolock-v3-4-70a54f3775bb@kernel.org>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,linux.dev,gentwo.org,google.com,gmail.com,linutronix.de,goodmis.org,nvidia.com,joshtriplett.org,efficios.com,kvack.org,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLj61o5ry9wekc93e5gwgzgtt8)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DEC246CFC4
X-Spam-Score: -4.01

On Mon, Jun 15, 2026 at 08:05:58PM +0900, Harry Yoo (Oracle) wrote:
> call_rcu() disables IRQs with local_irq_save() to protect its per-cpu
> data structures. Therefore, if IRQs are not disabled, they cannot be
> corrupted by reentrance into call_rcu(). So fall back to the deferred
> path only when !allow_spin && irqs_disabled().
> 
> The RCU subsystem does not guarantee this contractually, and this
> optimization relies on RCU's implementation details. Ideally, it should
> be removed once call_rcu_nolock() is supported by the RCU subsystem.
> 
> Link: https://lore.kernel.org/linux-mm/CAADnVQKRVD5ZSnEKbZZU7w86gHbGHUug2pvzpgZTngNS+fg4rw@mail.gmail.com
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
>  mm/slub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b0d38d515386..6a3552b70683 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6158,8 +6158,8 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
>  	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
>  		rcu_sheaf = NULL;
>  	} else {
> -		if (unlikely(!allow_spin)) {
> -			/* call_rcu() cannot be called in an unknown context */
> +		/* call_rcu() disables IRQs to protect percpu data structures */
> +		if (unlikely(!allow_spin && irqs_disabled())) {

Perhaps this could be more neatly exposed by RCU? something like
maybe_in_call_rcu(). Also, it's a bit odd that you're introducing code and
then subsequently patching over it with an improvement. Maybe this could be
squashed into patch 3?

>  			rcu_sheaf->size--;
>  			local_unlock(&s->cpu_sheaves->lock);
>  			goto fail;
> 
> -- 
> 2.53.0
> 

-- 
Pedro
