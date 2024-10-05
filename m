Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F1374EA;
	Sat,  5 Oct 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728144457; cv=none; b=muDOn0lme30dKnDiH0mpDA5xmWkD/SYbdF1Uc24a9kuYJnCzahlcthKFF8BEs7gGTY8hmjk/VuiXENz1bw9GkuhfXi2biXaCRF+aEyk9A7gb6fS33anb8KKYlfSl3PeszxF8UKka8abE3YJlzjKqAECtvM0QCwby5d684ZBPoHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728144457; c=relaxed/simple;
	bh=URkrEKoUDYSusnSv7gsPXAoThBMvrUg73nKyjQ3qrD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKBFQAPRPX7ER4HZUXFp2wlNkCqev+inasJwlGUQaMYs7fHfmIjNkOMRy60QlE7eYr4v3DA3ohD7nlWUF/D3EkxySVYo40Qg+nbL9n7N740b5JL5fxvBlQkKIJnAKdwE0rxL2HjccutkXU59P6OEowsQo/edG+DB7IfraV1JtrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rzb/hdPm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rzb/hdPm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tVz9zpYWjrEx98t10FsnvqgqUywp3znOijDg2YUcJ5Y=; b=Rzb/hdPmp9B6sNyqAMCukzE6dN
	vQxnklM6BMIwgGyip3D5FrAXTkPvKRF4ntsj/MnTb/PZuQVBLH0GI1z6w8TXm+atdf85R4VT1Qbrw
	g0K9oF0EgCVfsj5sqAJ34ngzulehQukovGBvYIBvx5SkplLehEIh0EFUT9iNMms/iX3/PyXku8SJR
	7gqmrSm8rj2kfroXQABmnrk8ddQ4VzBZSd6IKbkd4QsS8QusXdSdZ6LPyITNR4zp3tQgOhyPiDRyD
	2i+3FdxM+NvlE98eqsmYXJTJk2n2VLhITgVFK/vWLJaCeoA+tfMwp6QfcjFgq+QgDIdIBsLKnRd/Z
	pzesIxYA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sx7JT-0000000DAoP-2nvF;
	Sat, 05 Oct 2024 16:07:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D9B55300777; Sat,  5 Oct 2024 18:07:23 +0200 (CEST)
Date: Sat, 5 Oct 2024 18:07:23 +0200
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
Message-ID: <20241005160723.GI33184@noisy.programming.kicks-ass.net>
References: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com>
 <20241004182734.1761555-4-mathieu.desnoyers@efficios.com>
 <20241005160444.GA18071@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005160444.GA18071@noisy.programming.kicks-ass.net>

On Sat, Oct 05, 2024 at 06:04:44PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 04, 2024 at 02:27:33PM -0400, Mathieu Desnoyers wrote:

> > +void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
> > +	     void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr))
> > +{
> > +	int cpu;
> > +
> > +	/*
> > +	 * Store A precedes hp_scan(): it unpublishes addr (sets it to
> > +	 * NULL or to a different value), and thus hides it from hazard
> > +	 * pointer readers.
> > +	 */

This should probably assert we're in a preemptible context. Otherwise
people will start using this in non-preemptible context and then we get
to unfuck things later.

> > +
> > +	if (!addr)
> > +		return;
> > +	/* Memory ordering: Store A before Load B. */
> > +	smp_mb();
> > +	/* Scan all CPUs slots. */
> > +	for_each_possible_cpu(cpu) {
> > +		struct hp_slot *slot = per_cpu_ptr(percpu_slots, cpu);
> > +
> > +		if (retire_cb && smp_load_acquire(&slot->addr) == addr)	/* Load B */
> > +			retire_cb(cpu, slot, addr);
> 
> Is retirce_cb allowed to cmpxchg the thing?
> 
> > +		/* Busy-wait if node is found. */
> > +		while ((smp_load_acquire(&slot->addr)) == addr)	/* Load B */
> > +			cpu_relax();
> 
> This really should be using smp_cond_load_acquire()
> 
> > +	}
> > +}
