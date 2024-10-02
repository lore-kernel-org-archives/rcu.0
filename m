Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8950748F;
	Wed,  2 Oct 2024 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883228; cv=none; b=rkA1EGz+/aCYDzvBEyIIVH24+kOZ3zqCrWn8R5wWbYnViqgokTonqbx1FRlvl3QGWmFsVjmYMZgbWntDWpxxJ3xPsa4ZxYOfvQ80tbAJx1tTPTBUR4g/hB9TasSqGc7fI99Jr48aLfO5HH7M+LDDy3AS21SLeNRLkj4H9mekcPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883228; c=relaxed/simple;
	bh=axaFRdTjND5DpZyu3FHdA8PUD5xedSDzyQMmaUHT1OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e915jQr/+f7LjAxaDVbpV758YWegYGtMWBKlneRAkQkUUs8KJFOnwULdX3mZsn7oxiL0fCSjZppP33gD3HLek3XYFNVgxF0dNlreeVTcBIyWv66T6yqhbLzmib1w8koO3fUPlDP8hQqs8MBP2SbA39uDLgudvu26CfF/nMcsf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hd7Mg3Xh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hd7Mg3Xh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gBpqJBDwQKrPqLyQ9Q2uURot1tAS7zm9LakDbxifVT8=; b=Hd7Mg3Xh+n99RAmp47YRGbSZqN
	8/kQ90n5DAWLFLaXVQYuUTLR8Aw1aJ4Ef3Z6eyX5vd7gg6d6L9mqUpcwxFa/WjtC5UOE1A5a/LWQy
	w2KLP5V+BSvAfiV4WTyVKfenDfLrC50fdcVXsZZQK53R6n8UVhYOj98Ce2fkkjfoVZ8tqbVe6kKCb
	rSneBrX61n2StxB/9y4P12deUhMOmO7+nMQnIyVxaNZVHN7ZYwJS9E2aTtr6Gxs4/QDLUT92AkiR5
	FlOOTZ4qpG47ad0E5bLXaqAfUtRdAO9iy5VaIFRK2JtZ3nWYHju9JPbdAYMBQRb1crgKrjy0GbwIr
	lt0GlgKg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sw1M9-00000005gCA-3fpE;
	Wed, 02 Oct 2024 15:33:37 +0000
Date: Wed, 2 Oct 2024 16:33:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: paulmck@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
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
Subject: Re: [RFC PATCH 0/4] sched+mm: Track lazy active mm existence with
 hazard pointers
Message-ID: <Zv1n0VeM3ZSVPyyE@casper.infradead.org>
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
 <cfcf9c05-c639-4757-a3ac-6504d154cdfe@paulmck-laptop>
 <d412fa7e-6348-4e51-89e8-4c740184cb2f@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d412fa7e-6348-4e51-89e8-4c740184cb2f@efficios.com>

On Wed, Oct 02, 2024 at 11:26:27AM -0400, Mathieu Desnoyers wrote:
> On 2024-10-02 16:09, Paul E. McKenney wrote:
> > On Tue, Oct 01, 2024 at 09:02:01PM -0400, Mathieu Desnoyers wrote:
> > > Hazard pointers appear to be a good fit for replacing refcount based lazy
> > > active mm tracking.
> > > 
> > > Highlight:
> > > 
> > > will-it-scale context_switch1_threads
> > > 
> > > nr threads (-t)     speedup
> > >      24                +3%
> > >      48               +12%
> > >      96               +21%
> > >     192               +28%
> > 
> > Impressive!!!
> > 
> > I have to ask...  Any data for smaller numbers of CPUs?
> 
> Sure, but they are far less exciting ;-)

How many CPUs in the system under test?

> nr threads (-t)     speedup
>      1                -0.2%
>      2                +0.4%
>      3                +0.2%
>      6                +0.6%
>     12                +0.8%
>     24                +3%
>     48               +12%
>     96               +21%
>    192               +28%
>    384                +4%
>    768                -0.6%
> 
> Thanks,
> 
> Mathieu
> 
> > 
> > 							Thanx, Paul
> > 
> > > I'm curious to see what the build bots have to say about this.
> > > 
> > > This series applies on top of v6.11.1.
> > > 
> > > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Nicholas Piggin <npiggin@gmail.com>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > Cc: John Stultz <jstultz@google.com>
> > > Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Uladzislau Rezki <urezki@gmail.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Cc: Zqiang <qiang.zhang1211@gmail.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Waiman Long <longman@redhat.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: maged.michael@gmail.com
> > > Cc: Mateusz Guzik <mjguzik@gmail.com>
> > > Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> > > Cc: rcu@vger.kernel.org
> > > Cc: linux-mm@kvack.org
> > > Cc: lkmm@lists.linux.dev
> > > 
> > > Mathieu Desnoyers (4):
> > >    compiler.h: Introduce ptr_eq() to preserve address dependency
> > >    Documentation: RCU: Refer to ptr_eq()
> > >    hp: Implement Hazard Pointers
> > >    sched+mm: Use hazard pointers to track lazy active mm existence
> > > 
> > >   Documentation/RCU/rcu_dereference.rst |  38 ++++++-
> > >   Documentation/mm/active_mm.rst        |   9 +-
> > >   arch/Kconfig                          |  32 ------
> > >   arch/powerpc/Kconfig                  |   1 -
> > >   arch/powerpc/mm/book3s64/radix_tlb.c  |  23 +---
> > >   include/linux/compiler.h              |  63 +++++++++++
> > >   include/linux/hp.h                    | 154 ++++++++++++++++++++++++++
> > >   include/linux/mm_types.h              |   3 -
> > >   include/linux/sched/mm.h              |  71 +++++-------
> > >   kernel/Makefile                       |   2 +-
> > >   kernel/exit.c                         |   4 +-
> > >   kernel/fork.c                         |  47 ++------
> > >   kernel/hp.c                           |  46 ++++++++
> > >   kernel/sched/sched.h                  |   8 +-
> > >   lib/Kconfig.debug                     |  10 --
> > >   15 files changed, 346 insertions(+), 165 deletions(-)
> > >   create mode 100644 include/linux/hp.h
> > >   create mode 100644 kernel/hp.c
> > > 
> > > -- 
> > > 2.39.2
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
> 
