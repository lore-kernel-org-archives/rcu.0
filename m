Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679B721B1BC;
	Mon, 17 Feb 2025 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802002; cv=none; b=sy94bP6kO6pPr0Lr5TNs40DV6RiIOEdCT/d9DwdnOOpHgWdranV0Y2W5NdZZAY1D+/mOiNO4ENIh8U/Xu77PQbAJ+kmNZE1/6Jll4u4rDD2cZaXF1nIWjY4o5GHBp/QUpWeH05aZ3tKLVZJJ1qWPefOKgz61dcUCBpknHrE0Fjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802002; c=relaxed/simple;
	bh=F5Fq4V08KjRjvKMrLulUhqT0/eJwNG0iacCf2irg2mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9zKiDDglWL+9oHUi+rUi5HqOgebsTfrrFYzDFPhkI6bjz1VlN/g8TS9BY4cxf6SQp47BPbje04tIsw/r6ZE84019b+WWwWuHAku/7o491zlRyJkuIGXajeUoC7vpvVbjSeQrfssMTIQgyIfqxjAMj9g6eomMOTVPFI0off01hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n/5qO8KR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DTx3N+0p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n/5qO8KR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DTx3N+0p"
Date: Mon, 17 Feb 2025 15:19:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739801998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uyo5k+GprhxLkM9w+L8CKX8UCCowCbgz4V8rWU94hrg=;
	b=n/5qO8KRcWA5TDw7mzbASwa8PTTRlvWJeskMNFDCEY1LSP2GJcqN8Xo1OhZF1NlPR5CKrt
	o5iJ4Pgw07grRwEtIpkKmQYLoFpYpOWbXk7D6qhiC/pnfmjrNoc/YXqKUOZPqpKcQhyRue
	1wfytWALSZLDIvwFOv1Y3erUq7+NY6ncvL1sMzLTUNe59tdKah/JevsF59wm5TYF4bqYnb
	wWjYVL/r9TowTYkJqqZU4nx1LyPGtLH6K9X90WpeFkGGQGs3UmFe8odwUWd+ee0XBtOaLZ
	mXKb3mOJoEEX8IaIl6Hm/Lu/EvJpmPfTwmVBTaP+i/OEnkAvYCNrcWnlkfpPxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739801998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uyo5k+GprhxLkM9w+L8CKX8UCCowCbgz4V8rWU94hrg=;
	b=DTx3N+0ptr7aSyabWFl3/dtr/ABDwRBuekFvwkohqTkrN6CilHfXC3uuPCRqMS5DQPaUAH
	tiATJ0uyVQn/OUCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH RFC v2 03/10] locking/local_lock: Introduce
 localtry_lock_t
Message-ID: <20250217141956._01BcsrG@linutronix.de>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-3-88592ee0966a@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250214-slub-percpu-caches-v2-3-88592ee0966a@suse.cz>

On 2025-02-14 17:27:39 [+0100], Vlastimil Babka wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> In !PREEMPT_RT local_lock_irqsave() disables interrupts to protect
> critical section, but it doesn't prevent NMI, so the fully reentrant
> code cannot use local_lock_irqsave() for exclusive access.
> 
> Introduce localtry_lock_t and localtry_lock_irqsave() that
> disables interrupts and sets acquired=1, so localtry_lock_irqsave()
> from NMI attempting to acquire the same lock will return false.
> 
> In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
> Map localtry_lock_irqsave() to preemptible spin_trylock().
> When in hard IRQ or NMI return false right away, since
> spin_trylock() is not safe due to PI issues.

spin_trylock() is not safe due to explicit locking in the underneath
rt_spin_trylock() implementation. Removing this explicit locking and
attempting only "trylock" is undesired due to PI implications.

> Note there is no need to use local_inc for acquired variable,
> since it's a percpu variable with strict nesting scopes.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Other than that, thank you two ;)

Sebastian
