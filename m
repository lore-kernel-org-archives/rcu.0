Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095152D3A7E;
	Mon, 23 Jun 2025 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702386; cv=none; b=DMs/nYYdtH6vRhviGy9TRnJIpxfGL20db8n349CTyOgTGA3tmAIlojbQbDW0B/wnNu3TFdVByDhyUhnCtB2ytnLZqWPhODaIZWfDaTK4kh34pLuYgk+uqjsWDsrTB7bXwASWJseUUbIXEH+N5ubtPke2uF+94k6BINpqIHCy36Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702386; c=relaxed/simple;
	bh=R+tsBdrCWa6UpsXA9DiKbE9aOVOJ4GPEEVP9lQEDbh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUhcXMN1M/Ec+Acyq+mOSXDSkLYFzSjyVXn5UCzymkpdwaQ4Mmu1aF3OE+jdAHxxaEbE+SiyuJK38VXgfy9ajKfscUB5bF7lp7VbpTKxl3scSmgZu/aBKGPH3aKeDQfdWKXIDyULyq5abiFLiyp7338spyVtkNyc8cuxQEgkLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alOmVnq+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alOmVnq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE18C4CEEA;
	Mon, 23 Jun 2025 18:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750702385;
	bh=R+tsBdrCWa6UpsXA9DiKbE9aOVOJ4GPEEVP9lQEDbh8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=alOmVnq+HdR8MT3tRmV6O0TmOprvIK85VGyIK5SZ2W/ECB9bVUtSIIC+AcVinDknT
	 8r4hHiuOycRjkh6aKDZiRpj/qtaXBPbqL+lB6H0vczmcvoduL1zduQpSkYHIc7bLEN
	 TQ/vWdiSzNZhs8M6JPZLHkJP9uWCWyeHFmfxXDxi4K6+if7HjJSa0/5LKoA2CyTmlx
	 sh/81TX8ZZItaB+SLNrbA28ufB7d1/y3gp4JGsX481Cccb34zgKy6pC9DPZL/J8kcc
	 8VYYCSB1LzMBI/g2r3lOqDCyJ5Rvm9onMvRHiypm99mLBnDY+qax66eLVPVAFqCeZb
	 HPyDEmkOLMmHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6D69DCE0B20; Mon, 23 Jun 2025 11:13:03 -0700 (PDT)
Date: Mon, 23 Jun 2025 11:13:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250613152218.1924093-1-bigeasy@linutronix.de>
 <20250613152218.1924093-2-bigeasy@linutronix.de>
 <aFL1pIGMDX5DG9f_@tardis.local>
 <20250620084334.Zb8O2SwS@linutronix.de>
 <34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>
 <20250623104941.WxOQtAmV@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623104941.WxOQtAmV@linutronix.de>

On Mon, Jun 23, 2025 at 12:49:41PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-20 04:23:49 [-0700], Paul E. McKenney wrote:
> > > I hope not because it is not any different from
> > > 
> > >  	CPU 2			CPU 3
> > >  	=====                   =====
> > > 	NMI
> > >  	rcu_read_lock();
> > >  				synchronize_rcu();
> > >  				// need all CPUs report a QS.
> > >  	rcu_read_unlock();
> > >  	// no rcu_read_unlock_special() due to in_nmi().
> > > 
> > > If the NMI happens while the CPU is in userland (say a perf event) then
> > > the NMI returns directly to userland.
> > > After the tracing event completes (in this case) the CPU should run into
> > > another RCU section on its way out via context switch or the tick
> > > interrupt.
> > > I assume the tick interrupt is what makes the NMI case work.
> > 
> > Are you promising that interrupts will be always be disabled across
> > the whole rcu_read_lock_notrace() read-side critical section?  If so,
> > could we please have a lockdep_assert_irqs_disabled() call to check that?
> 
> No, that should stay preemptible because bpf can attach itself to
> tracepoints and this is the root cause of the exercise. Now if you say
> it has to be run with disabled interrupts to match the NMI case then it
> makes sense (since NMIs have interrupts off) but I do not understand why
> it matters here (since the CPU returns to userland without passing the
> kernel).

Given your patch, if you don't disable interrupts in a preemptible kernel
across your rcu_read_lock_notrace()/rcu_read_unlock_notrace() pair, then a
concurrent expedited grace period might send its IPI in the middle of that
critical section.  That IPI handler would set up state so that the next
rcu_preempt_deferred_qs_irqrestore() would report the quiescent state.
Except that without the call to rcu_read_unlock_special(), there might
not be any subsequent call to rcu_preempt_deferred_qs_irqrestore().

This is even more painful if this is a CONFIG_PREEMPT_RT kernel.
Then if that critical section was preempted and then priority-boosted,
the unboosting also won't happen until the next call to that same
rcu_preempt_deferred_qs_irqrestore() function, which again might not
happen.  Or might be significantly delayed.

Or am I missing some trick that fixes all of this?

> I'm not sure how much can be done here due to the notrace part. Assuming
> rcu_read_unlock_special() is not doable, would forcing a context switch
> (via setting need-resched and irq_work, as the IRQ-off case) do the
> trick?
> Looking through rcu_preempt_deferred_qs_irqrestore() it does not look to
> be "usable from the scheduler (with rq lock held)" due to RCU-boosting
> or the wake of expedited_wq (which is one of the requirement).

But if rq_lock is held, then interrupts are disabled, which will
cause the unboosting to be deferred.

Or are the various deferral mechanisms also unusable in this context?

							Thanx, Paul
