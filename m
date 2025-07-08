Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C95298243;
	Tue,  8 Jul 2025 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959406; cv=none; b=LJAnN5IkFFAe1XJeGQBAtiIVaWlRK7mbql0rn48NWTS2GOmBR4HIlp2fcZp+3ZeFCoKvEzO7OZQ4jJ1dcZ3w3REtzwL2dBWkafgSwyNgWAlALtBJnwFIQ0YaIL0QnHFyZlloqAhL7GcKBSEqa3oW8FSwOqwaceFa0UKykw8uYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959406; c=relaxed/simple;
	bh=MDmNI4M5ZnJkQQHe884BnVSI7XT89edo0tFHwZWzrk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0Awn1ooKa7ixugfnqh7kO5rcSy6vSAyd/0b7CmfFgCBDpNjORQeCBCVWoHDMvcb+SFltAunp/hV7qV5SBYL7y/MWsa7k2DBfIqAdxj8e91cSH6D8jVZM31diPiIlZCYQ5telfQWAVzEb1NNqPMDKNzprnTj6jCMjVWDCISfbDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vmVbSKBD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vmVbSKBD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MWUo8HXlsTm5OwwfF27p27ZVMUSPkhIkvmpgsg4RTMk=; b=vmVbSKBDD3kXmxjp13hnlTd+9D
	0yhJKb/BoxuLoAZ0+hU7wsNwlEXyZDgZ0PgmH54/gYNYzPuboSAhI/a9HwAevCYHLIXrxk4D2dlws
	ouXWRRMIbAWP9kAeOrdAfcP/1Zr1DxGP+L7oKGmH43XWjL/k7EpmyxG3jNCCklt/slYbO9s/g9npM
	a1yWCX97zrvoaEQqud0xKuK0Nl81wHeWK+nbWDhq7HBhnDftJdAvBLiVup7DTMQg51rsIzTrJD/Q/
	ZLyJSTPYbD5YGv2jFM5miEHvMqDAMXfDqElxTZaciIostMNm1IRCT/j1scHS6h4DYA2PxTzlrEAmM
	nOgARA7w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ2fi-0000000GOfQ-2sKf;
	Tue, 08 Jul 2025 07:23:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 390A230065D; Tue, 08 Jul 2025 09:23:21 +0200 (CEST)
Date: Tue, 8 Jul 2025 09:23:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrea Righi <arighi@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] smp: Document preemption and stop_machine() mutual
 exclusion
Message-ID: <20250708072321.GB1613376@noisy.programming.kicks-ass.net>
References: <20250705172328.4114289-1-joelagnelf@nvidia.com>
 <20250707075050.GB1613200@noisy.programming.kicks-ass.net>
 <298d86df-65bc-4f7a-a361-a8382cdee296@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <298d86df-65bc-4f7a-a361-a8382cdee296@paulmck-laptop>

On Mon, Jul 07, 2025 at 08:56:04AM -0700, Paul E. McKenney wrote:
> On Mon, Jul 07, 2025 at 09:50:50AM +0200, Peter Zijlstra wrote:
> > On Sat, Jul 05, 2025 at 01:23:27PM -0400, Joel Fernandes wrote:
> > > Recently while revising RCU's cpu online checks, there was some discussion
> > > around how IPIs synchronize with hotplug.
> > > 
> > > Add comments explaining how preemption disable creates mutual exclusion with
> > > CPU hotplug's stop_machine mechanism. The key insight is that stop_machine()
> > > atomically updates CPU masks and flushes IPIs with interrupts disabled, and
> > > cannot proceed while any CPU (including the IPI sender) has preemption
> > > disabled.
> > 
> > I'm very conflicted on this. While the added comments aren't wrong,
> > they're not quite accurate either. Stop_machine doesn't wait for people
> > to enable preemption as such.
> > 
> > Fundamentally there seems to be a misconception around what stop machine
> > is and how it works, and I don't feel these comments make things better.
> > 
> > Basically, stop-machine (and stop_one_cpu(), stop_two_cpus()) use the
> > stopper task, a task running at the ultimate priority; if it is
> > runnable, it will run.
> > 
> > Stop-machine simply wakes all the stopper tasks and co-ordinates them to
> > literally stop the machine. All CPUs have the stopper task scheduled and
> > then they go sit in a spin-loop driven state machine with IRQs disabled.
> > 
> > There really isn't anything magical about any of this.
> 
> There is the mechanism (which you have described above), and then there
> are the use cases.  Those of us maintaining a given mechanism might
> argue that a detailed description of the mechanism suffices, but that
> argument does not always win the day.
> 
> I do like the description in the stop_machine() kernel-doc header:
> 
>  * This can be thought of as a very heavy write lock, equivalent to
>  * grabbing every spinlock in the kernel.
> 
> Though doesn't this need to upgrace "spinlock" to "raw spinlock"
> now that PREEMPT_RT is in mainline?
> 
> Also, this function is more powerful than grabbing every write lock
> in the kernel because it also excludes all regions of code that have
> preemption disabled, which is one thing that CPU hotplug is relying on.
> Any objection to calling out that additional semantic?

Best to just re-formulate the entire comment I think. State it provides
exclusion vs all non-preemptible regions in the kernel -- at insane cost
and should not be used when humanly possible :-)
