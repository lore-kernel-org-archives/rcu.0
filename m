Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCD235F16F
	for <rcu@vger.kernel.org>; Wed, 24 Jun 2026 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308487; cv=none; b=Yi0kpGmnL8pHYw7KqhY+87Sl7iLFPYhIW4TUw6mowt/0H6lRkXz21z2qEtFChHZcU4tciWGkVCfm/6dCn59zSGlSWxUbEbjE/ubbfVMfUTeEOPGJUYcV3jU1vYTKncGTeLvkupXnxE8HJd93e1LN06TbrpImODlaKOhU9/ZwaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308487; c=relaxed/simple;
	bh=V4baC9XDLxXBojAV6zUUjxYzzXqcwXtx1rIYrUbzjew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J245UQ19Qsc9wF+/UPjCynZ127Q+q6fGKphFEL1wBE0k8TjBqmj7vQVLb8krBOw1q7oE3PNjy9+vstE1kxI+X7BBXjraeL4YsP5hk8m52Tv9K/ltSfetXcbdPY4lLk6OT21agap5s14NDSuRLdOIj6V6F6jUSGMeKw/tYRMNmm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ojTLct+B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jsl310v6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ojTLct+B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jsl310v6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ojTLct+B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jsl310v6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ojTLct+B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jsl310v6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2F8971425;
	Wed, 24 Jun 2026 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782308485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sR3sJGwujfNLRWW+1TBYQaHSIL+b0DW9aOFZ/atPQkc=;
	b=ojTLct+B6Q134cNmxEmKnlNW4Pb1dd55qKYAkyXLnMwKcccVDVIAbU53kcQXsWUTFNxcZU
	f3AbFAVyVqVrPvoh/v1yXrWpnaZg1fGcg77FzYPvMRF/JM06fkneXi6LHW0hCO0+sKSA3t
	+gcNyr7zjUk1MLR5OIZYRAhlxe+cWA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782308485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sR3sJGwujfNLRWW+1TBYQaHSIL+b0DW9aOFZ/atPQkc=;
	b=jsl310v6c3qVx+TvswUZhMgyeTEJklTDi6CIYB/IJ9khWjX18P2wLJVMQVkAAHNFRDtTjH
	3W6gTUn2NJX1VlCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782308485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sR3sJGwujfNLRWW+1TBYQaHSIL+b0DW9aOFZ/atPQkc=;
	b=ojTLct+B6Q134cNmxEmKnlNW4Pb1dd55qKYAkyXLnMwKcccVDVIAbU53kcQXsWUTFNxcZU
	f3AbFAVyVqVrPvoh/v1yXrWpnaZg1fGcg77FzYPvMRF/JM06fkneXi6LHW0hCO0+sKSA3t
	+gcNyr7zjUk1MLR5OIZYRAhlxe+cWA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782308485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sR3sJGwujfNLRWW+1TBYQaHSIL+b0DW9aOFZ/atPQkc=;
	b=jsl310v6c3qVx+TvswUZhMgyeTEJklTDi6CIYB/IJ9khWjX18P2wLJVMQVkAAHNFRDtTjH
	3W6gTUn2NJX1VlCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22AC3779A8;
	Wed, 24 Jun 2026 13:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FeK3BIPeO2q0FQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 24 Jun 2026 13:41:23 +0000
Date: Wed, 24 Jun 2026 14:41:20 +0100
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
Subject: Re: [PATCH for-next v3 2/9] mm/slab, slub_kunit: register kprobe to
 trigger _nolock APIs
Message-ID: <ajvczSpMOGWFhe30@pedro-suse>
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLg9nrgqsibwm9ympc34uc4grz)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,linux.dev,gentwo.org,google.com,gmail.com,linutronix.de,goodmis.org,nvidia.com,joshtriplett.org,efficios.com,kvack.org,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Mon, Jun 15, 2026 at 08:05:56PM +0900, Harry Yoo (Oracle) wrote:
> Since kmalloc_nolock() always fails in NMI and hardirq contexts on
> PREEMPT_RT, slub_kunit cannot properly test _nolock() APIs.
> 
> Register a kprobe pre-handler to invoke kmalloc_nolock() and
> kfree_nolock() in the middle of the slab allocator. However, do not
> register the handler on UP kernels [1].

Maybe explain in the commit message why that is?
 
> To attach the pre-handler while s->cpu_sheaves->lock or n->list_lock
> is held, add a wrapper function for lockdep_assert_held() that calls
> a no-op function slab_attach_kprobe_locked() on debug builds. The

Why lockdep? Wouldn't it make more sense to add these triggers after
locking these locks?

> function is optimized away when neither CONFIG_PROVE_LOCKING nor
> CONFIG_DEBUG_VM is selected and register_kprobe() fails.
> 
> The function calls barrier() to prevent the compiler from optimizing
> away its callsites. Otherwise, the compiler may consider the function
> does not have any side effect and remove callsites.

My wider comment is the following: this looks very useful but perhaps should
be lifted to Kunit itself? There's already function redirection (which could
be used for this as well). I don't know if that suits your purposes?
Choosing to say "I want to hook this random function using kprobe and give
it custom behavior" sounds lovely for all sorts of testing.

-- 
Pedro
