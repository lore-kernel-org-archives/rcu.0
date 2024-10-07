Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DF718A6C3;
	Mon,  7 Oct 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297656; cv=none; b=ML4uPiKZMkdRLKHrztKBV2DpOK49Q2sj6lD6sMfQ/1BUtNlqWo7yeE46mapKi2iTAAWEciW7dwPysqjUiSLMULopQkBWMRJge3awnXQwnMMaUE2sXgW0v7ktXanEBGgno+bXU3U95RWM+I/CiU5O69YPsisY9Nut0mf/kexpRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297656; c=relaxed/simple;
	bh=GjzXmCfS7SaTOwQwOhTPaTKhhXJZhtzbusKDQpKLKTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQo0nTa3QL3HQYguuXY5mm1Y/t9zBRfs5BMGW1YlxUcr1jO0WaskADJ7JkWcnH4fC5UAbQDnpK5s9gDb6lXSeva1Hr2LQ7ZWH4HKq6HKuTEKEox1ZpH7HhtePZd4h3R1foVYP0z0KbnfE+A28hUGS6IE581J75zfZ9xcfm+x6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f+wT0dE8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f+wT0dE8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lwh9tJ35d1c8o+PW9Ww4chBCSD6YYk59hwSaIamIuE4=; b=f+wT0dE8i5aifk3S8szrr3YCCa
	y1323ZwpG++SyQKdW1lRpczCWQ+77ZXz9kiaoW1v+kOw6peFjjIumnq2ey2wgKdxCI+f6WtrSp3x4
	HuYKDUuLrErt6hd93izRkawloew7tv6GMpCrWFB9N4FlV7LRsogofTLTpvId/Vwsk4VW9FiTJdIdf
	AJEPkx6FxaaVoH/bUEfBTqT/osHOtK8IVtIdfs1MDSmQH22gv6GPY84E0IBvCcCauya3KUjdujBtO
	mgynWr5+dLjvOz7bdkgsU6ZjCqFsp/rzp5hBijTJaCdjwShwM8kbMVf5xtnd2zD2zCidGORjpsEi3
	kEocGheQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxlAG-00000004PAP-02aA;
	Mon, 07 Oct 2024 10:40:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D4DF030088D; Mon,  7 Oct 2024 12:40:30 +0200 (CEST)
Date: Mon, 7 Oct 2024 12:40:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH v2 3/4] hp: Implement Hazard Pointers
Message-ID: <20241007104030.GB4879@noisy.programming.kicks-ass.net>
References: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com>
 <20241004182734.1761555-4-mathieu.desnoyers@efficios.com>
 <20241005160444.GA18071@noisy.programming.kicks-ass.net>
 <df28acef-cf35-49fc-8b40-bc105e3f818f@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df28acef-cf35-49fc-8b40-bc105e3f818f@efficios.com>

On Sat, Oct 05, 2024 at 02:50:17PM -0400, Mathieu Desnoyers wrote:
> On 2024-10-05 18:04, Peter Zijlstra wrote:


> > > +/*
> > > + * hp_allocate: Allocate a hazard pointer.
> > > + *
> > > + * Allocate a hazard pointer slot for @addr. The object existence should
> > > + * be guaranteed by the caller. Expects to be called from preempt
> > > + * disable context.
> > > + *
> > > + * Returns a hazard pointer context.
> > 
> > So you made the WTF'o'meter crack, this here function does not allocate
> > nothing. Naming is bad. At best this is something like
> > try-set-hazard-pointer or somesuch.
> 
> I went with the naming from the 2004 paper from Maged Michael, but I
> agree it could be clearer.
> 
> I'm tempted to go for "hp_try_post()" and "hp_remove()", basically
> "posting" the intent to use a pointer (as in on a metaphorical billboard),
> and removing it when it's done.

For RCU we've taken to using the word: 'publish', no?


> > > +/*
> > > + * hp_dereference_allocate: Dereference and allocate a hazard pointer.
> > > + *
> > > + * Returns a hazard pointer context. Expects to be called from preempt
> > > + * disable context.
> > > + */
> > 
> > More terrible naming. Same as above, but additionally, I would expect a
> > 'dereference' to actually dereference the pointer and have a return
> > value of the dereferenced type.
> 
> hp_dereference_try_post() ?
> 
> > 
> > This function seems to double check and update the hp_ctx thing. I'm not
> > at all sure yet wtf this is doing -- and the total lack of comments
> > aren't helping.
> 
> The hp_ctx contains the outputs.
> 
> The function loads *addr_p to then try_post it into a HP slot. On success,
> it re-reads the *addr_p (with address dependency) and if it still matches,
> use that as output address pointer.
> 
> I'm planning to remove hp_ctx, and just have:
> 
> /*
>  * hp_try_post: Try to post a hazard pointer.
>  *
>  * Post a hazard pointer slot for @addr. The object existence should
>  * be guaranteed by the caller. Expects to be called from preempt
>  * disable context.
>  *
>  * Returns true if post succeeds, false otherwise.
>  */
> static inline
> bool hp_try_post(struct hp_domain *hp_domain, void *addr, struct hp_slot **_slot)
> [...]
> 
> /*
>  * hp_dereference_try_post: Dereference and try to post a hazard pointer.
>  *
>  * Returns a hazard pointer context. Expects to be called from preempt
>  * disable context.
>  */
> static inline
> void *__hp_dereference_try_post(struct hp_domain *hp_domain,
>                                 void * const * addr_p, struct hp_slot **_slot)
> [...]
> 
> #define hp_dereference_try_post(domain, p, slot_p)              \
>         ((__typeof__(*(p))) __hp_dereference_try_post(domain, (void * const *) p, slot_p))

This will compile, but do the wrong thing when p is a regular pointer, no?

> 
> /* Clear the hazard pointer in @slot. */
> static inline
> void hp_remove(struct hp_slot *slot)
> [...]

Differently weird, but better I suppose :-)


> > > +void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
> > > +	     void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr))
> > > +{
> > > +	int cpu;
> > > +
> > > +	/*
> > > +	 * Store A precedes hp_scan(): it unpublishes addr (sets it to
> > > +	 * NULL or to a different value), and thus hides it from hazard
> > > +	 * pointer readers.
> > > +	 */
> > > +
> > > +	if (!addr)
> > > +		return;
> > > +	/* Memory ordering: Store A before Load B. */
> > > +	smp_mb();
> > > +	/* Scan all CPUs slots. */
> > > +	for_each_possible_cpu(cpu) {
> > > +		struct hp_slot *slot = per_cpu_ptr(percpu_slots, cpu);
> > > +
> > > +		if (retire_cb && smp_load_acquire(&slot->addr) == addr)	/* Load B */
> > > +			retire_cb(cpu, slot, addr);
> > 
> > Is retirce_cb allowed to cmpxchg the thing?
> 
> It could, but we'd need to make sure the slot is not re-used by another
> hp_try_post() before the current user removes its own post. It would
> need to synchronize with the current HP user (e.g. with IPI).
> 
> I've actually renamed retire_cb to "on_match_cb".

Hmm, I think I see. Would it make sense to pass the expected addr to
hp_remove() and double check we don't NULL out something unexpected? --
maybe just for a DEBUG option.

I'm always seeing the NOHZ_FULL guys hating on this :-)
