Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F0241679;
	Tue,  8 Jul 2025 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007746; cv=none; b=MyQT4QY864IFRuGTsT4jFlgRNiy3r09yMz91kNYinWoO2gtHqDz4dJ1COIdVzykDj5PmpSrLXg6Igbac2VAZSeDHGfE3wrFI1B/J6IiDngAp+W3N9D7do5KxR8kqCwCH/bcqC9DTjE1k+yQ6EICC7jTGhuWzxQQuC7/k1inU7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007746; c=relaxed/simple;
	bh=T959HA9XhI+zBTQ8LMfRnZYEo8DlfGYdxMV9+pKlsQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/9+liCU7b8iMkwpa0x87DRBzKscbJ7Vs3Air1oz8h/+9eSczq8SObopgmnUaRomw8/4novdyApx5Q6Mm9yeknzihx4V3LF52HGCIE8cqtNulj0zCD3OBqD+60rM0RRpG0pFK7y1OzfOCdlQXe1OZmD0e8MBuBwfHDo8y/HlPOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBN1Pavr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBN1Pavr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06015C4CEED;
	Tue,  8 Jul 2025 20:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752007746;
	bh=T959HA9XhI+zBTQ8LMfRnZYEo8DlfGYdxMV9+pKlsQQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uBN1Pavr7dqNGf1SThmdcNf4x6JJ3dCGV8mLAqqjG6hsgrRXEPVYvhypZL2fAgCDu
	 +omTeuCgdM311hgxEahtP0ZO/FjaGdq4T7qAZYfOY0inETbTdvm0B4e+Vl2ECrGIg0
	 zP61/rbQRCnuO+9IFwxGS0gilJxlPt2ZWfU++VwPHa6yib5HzHXP1jeC5RYNQ1rh6Q
	 lRPU4DNL5gifK70mEq7wkgdHt5Y7FiWZxXeaCDin/mNQK595CdlhApHQEA0f7qXnhR
	 6+BI5UTTrhnhxN5v6PZ+OdQRaxR173bRq8W4g3yP5E9aEbF7QiSHniXvMgfVxqq0yF
	 3dKa8i4wSsy1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A098ACE0856; Tue,  8 Jul 2025 13:49:05 -0700 (PDT)
Date: Tue, 8 Jul 2025 13:49:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250613152218.1924093-1-bigeasy@linutronix.de>
 <20250613152218.1924093-2-bigeasy@linutronix.de>
 <aFL1pIGMDX5DG9f_@tardis.local>
 <20250620084334.Zb8O2SwS@linutronix.de>
 <34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>
 <20250623104941.WxOQtAmV@linutronix.de>
 <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>

On Tue, Jul 08, 2025 at 03:40:05PM -0400, Mathieu Desnoyers wrote:
> On 2025-07-07 17:56, Paul E. McKenney wrote:
> > On Mon, Jun 23, 2025 at 11:13:03AM -0700, Paul E. McKenney wrote:
> > > On Mon, Jun 23, 2025 at 12:49:41PM +0200, Sebastian Andrzej Siewior wrote:
> > > > On 2025-06-20 04:23:49 [-0700], Paul E. McKenney wrote:
> > > > > > I hope not because it is not any different from
> > > > > > 
> > > > > >   	CPU 2			CPU 3
> > > > > >   	=====                   =====
> > > > > > 	NMI
> > > > > >   	rcu_read_lock();
> > > > > >   				synchronize_rcu();
> > > > > >   				// need all CPUs report a QS.
> > > > > >   	rcu_read_unlock();
> > > > > >   	// no rcu_read_unlock_special() due to in_nmi().
> > > > > > 
> > > > > > If the NMI happens while the CPU is in userland (say a perf event) then
> > > > > > the NMI returns directly to userland.
> > > > > > After the tracing event completes (in this case) the CPU should run into
> > > > > > another RCU section on its way out via context switch or the tick
> > > > > > interrupt.
> > > > > > I assume the tick interrupt is what makes the NMI case work.
> > > > > 
> > > > > Are you promising that interrupts will be always be disabled across
> > > > > the whole rcu_read_lock_notrace() read-side critical section?  If so,
> > > > > could we please have a lockdep_assert_irqs_disabled() call to check that?
> > > > 
> > > > No, that should stay preemptible because bpf can attach itself to
> > > > tracepoints and this is the root cause of the exercise. Now if you say
> > > > it has to be run with disabled interrupts to match the NMI case then it
> > > > makes sense (since NMIs have interrupts off) but I do not understand why
> > > > it matters here (since the CPU returns to userland without passing the
> > > > kernel).
> > > 
> > > Given your patch, if you don't disable interrupts in a preemptible kernel
> > > across your rcu_read_lock_notrace()/rcu_read_unlock_notrace() pair, then a
> > > concurrent expedited grace period might send its IPI in the middle of that
> > > critical section.  That IPI handler would set up state so that the next
> > > rcu_preempt_deferred_qs_irqrestore() would report the quiescent state.
> > > Except that without the call to rcu_read_unlock_special(), there might
> > > not be any subsequent call to rcu_preempt_deferred_qs_irqrestore().
> > > 
> > > This is even more painful if this is a CONFIG_PREEMPT_RT kernel.
> > > Then if that critical section was preempted and then priority-boosted,
> > > the unboosting also won't happen until the next call to that same
> > > rcu_preempt_deferred_qs_irqrestore() function, which again might not
> > > happen.  Or might be significantly delayed.
> > > 
> > > Or am I missing some trick that fixes all of this?
> > > 
> > > > I'm not sure how much can be done here due to the notrace part. Assuming
> > > > rcu_read_unlock_special() is not doable, would forcing a context switch
> > > > (via setting need-resched and irq_work, as the IRQ-off case) do the
> > > > trick?
> > > > Looking through rcu_preempt_deferred_qs_irqrestore() it does not look to
> > > > be "usable from the scheduler (with rq lock held)" due to RCU-boosting
> > > > or the wake of expedited_wq (which is one of the requirement).
> > > 
> > > But if rq_lock is held, then interrupts are disabled, which will
> > > cause the unboosting to be deferred.
> > > 
> > > Or are the various deferral mechanisms also unusable in this context?
> > 
> > OK, looking back through this thread, it appears that you need both
> > an rcu_read_lock_notrace() and an rcu_read_unlock_notrace() that are
> > covered by Mathieu's list of requirements [1]:
> 
> I'm just jumping into this email thread, so I'll try to clarify
> what I may.

Thank you for jumping in!

> > | - NMI-safe
> > 	This is covered by the existing rcu_read_lock() and
> > 	rcu_read_unlock().
> 
> OK
> 
> > | - notrace
> > 	I am guessing that by "notrace", you mean the "notrace" CPP
> > 	macro attribute defined in include/linux/compiler_types.h.
> > 	This has no fewer than four different definitions, so I will
> > 	need some help understanding what the restrictions are.
> 
> When I listed notrace in my desiderata, I had in mind the
> preempt_{disable,enable}_notrace macros, which ensure that
> those macros don't call instrumentation, and therefore can be
> used from the implementation of tracepoint instrumentation or
> from a tracer callback.

OK, that makes sense.  I have some questions:

Are interrupts disabled at the calls to rcu_read_unlock_notrace()?

If interrupts are instead enabled, is it OK for an IRQ-work handler that
did an immediate self-interrupt and a bunch of non-notrace work?

If interrupts are to be enabled, but an immediate IRQ-work handler is
ruled out, what mechanism should I be using to defer the work, given
that it cannot be deferred for very long without messing up real-time
latencies?  As in a delay of nanoseconds or maybe a microsecond, but
not multiple microseconds let alone milliseconds?

(I could imagine short-timeout hrtimer, but I am not seeing notrace
variants of these guys, either.)

> > | - usable from the scheduler (with rq lock held)
> > 	This is covered by the existing rcu_read_lock() and
> > 	rcu_read_unlock().
> 
> OK
> 
> > | - usable to trace the RCU implementation
> > 	This one I don't understand.  Can I put tracepoints on
> > 	rcu_read_lock_notrace() and rcu_read_unlock_notrace() or can't I?
> > 	I was assuming that tracepoints would be forbidden.  Until I
> > 	reached this requirement, that is.
> 
> At a high level, a rcu_read_{lock,unlock}_notrace should be something
> that is safe to call from the tracepoint implementation or from a
> tracer callback.
> 
> My expectation is that the "normal" (not notrace) RCU APIs would
> be instrumented with tracepoints, and tracepoints and tracer callbacks
> are allowed to use the _notrace RCU APIs.
> 
> This provides instrumentation coverage of RCU with the exception of the
> _notrace users, which is pretty much the best we can hope for without
> having a circular dependency.

OK, got it, and that does make sense.  I am not sure how I would have
intuited that from the description, but what is life without a challenge?

> > One possible path forward is to ensure that rcu_read_unlock_special()
> > calls only functions that are compatible with the notrace/trace
> > requirements.  The ones that look like they might need some help are
> > raise_softirq_irqoff() and irq_work_queue_on().  Note that although
> > rcu_preempt_deferred_qs_irqrestore() would also need help, it is easy to
> > avoid its being invoked, for example, by disabing interrupts across the
> > call to rcu_read_unlock_notrace().  Or by making rcu_read_unlock_notrace()
> > do the disabling.
> > 
> > However, I could easily be missing something, especially given my being
> > confused by the juxtaposition of "notrace" and "usable to trace the
> > RCU implementation".  These appear to me to be contradicting each other.
> > 
> > Help?
> 
> You indeed need to ensure that everything that is called from
> rcu_{lock,unlock]_notrace don't end up executing instrumentation
> to prevent a circular dependency. You hinted at a few ways to achieve
> this. Other possible approaches:
> 
> - Add a "trace" bool parameter to rcu_read_unlock_special(),
> - Duplicate rcu_read_unlock_special() and introduce a notrace symbol.

OK, both of these are reasonable alternatives for the API, but it will
still be necessary to figure out how to make the notrace-incompatible
work happen.

> - Keep some nesting count in the task struct to prevent calling the
>   instrumentation when nested in notrace,

OK, for this one, is the idea to invoke some TBD RCU API the tracing
exits the notrace region?  I could see that working.  But there would
need to be a guarantee that if the notrace API was invoked, a call to
this TBD RCU API would follow in short order.  And I suspect that
preemption (and probably also interrupts) would need to be disabled
across this region.

> There are probably other possible approaches I am missing, each with
> their respective trade offs.

I am pretty sure that we also have some ways to go before we have the
requirements fully laid out, for that matter.  ;-)

Could you please tell me where in the current tracing code these
rcu_read_lock_notrace()/rcu_read_unlock_notrace() calls would be placed?

							Thanx, Paul
