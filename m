Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC121B8FE;
	Wed,  9 Jul 2025 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086013; cv=none; b=iIhhCMcXJLawo2FXjs1Z1DDqQAmtO5BVFT3uBogYyhZutgodERgPH2+7dyTCBpuG3nrC0jOaX2lhHE9P8TIVzfkvzjVFL5m9RU55YkG261WEH4aRovf45tgCrJAmnXJe+xtfb+F8qsP4vhox1RDBjjsOU2gvIp3jL3+hKt0WMGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086013; c=relaxed/simple;
	bh=c4mdHAA9awpoFVodouEoViIyXG5NON4TZdyl4dv744g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBQFg4e/dOYmkAeA9BkMiKgDXnx6NL0qIlolBcxDBrObW4BlTdrexwypmtn9k0x80CnN58CI7fIaU2W8OPsSZvjiXZVEj7fI09Le8+cI5wDaolI/z6DkqbFvrrGbZNszcQGP5mjamLOvVCTVM6ILWf+Fd+Ak71UrYjPCTTKqCRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjnXG0+T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjnXG0+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E80C4CEEF;
	Wed,  9 Jul 2025 18:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752086013;
	bh=c4mdHAA9awpoFVodouEoViIyXG5NON4TZdyl4dv744g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rjnXG0+Tu4v3FumqH5wVuWd65ICmsHDO2evFae7wRnatZcr5scpv4lu8eD4+X+B8k
	 LeQ95HM8Ow+Ur3ZdQHq2sI11KuZcFXL3ijj93/8j9+L0q48S4vkxyrOwgwTQCfuFDt
	 nzUNIRnqdzvlsUPUeTgLjLD9S5M1egr8kqIavctkN9pnykoqyEmGGuk9MafgoUWRg2
	 xsO8KbOk1yn7eweqjd02DGua8fXA0NCeGvF0Gtl+rOGW6l207AO1qbjpWps5BfeKe5
	 q6YfH0v2pRNjvRQt+JNK8ys2tGvuVRAOqbYsCy/sZgCSvnHSrFey38GH/LiGQ2E6ul
	 siCDtRoRrVw2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C6850CE0B9F; Wed,  9 Jul 2025 11:33:32 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:33:32 -0700
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
Message-ID: <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250613152218.1924093-2-bigeasy@linutronix.de>
 <aFL1pIGMDX5DG9f_@tardis.local>
 <20250620084334.Zb8O2SwS@linutronix.de>
 <34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>
 <20250623104941.WxOQtAmV@linutronix.de>
 <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>

On Wed, Jul 09, 2025 at 10:31:14AM -0400, Mathieu Desnoyers wrote:
> On 2025-07-08 16:49, Paul E. McKenney wrote:
> > On Tue, Jul 08, 2025 at 03:40:05PM -0400, Mathieu Desnoyers wrote:
> > > On 2025-07-07 17:56, Paul E. McKenney wrote:
> > > > On Mon, Jun 23, 2025 at 11:13:03AM -0700, Paul E. McKenney wrote:
> > > > > On Mon, Jun 23, 2025 at 12:49:41PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > > On 2025-06-20 04:23:49 [-0700], Paul E. McKenney wrote:
> > > > > > > > I hope not because it is not any different from
> > > > > > > > 
> > > > > > > >    	CPU 2			CPU 3
> > > > > > > >    	=====                   =====
> > > > > > > > 	NMI
> > > > > > > >    	rcu_read_lock();
> > > > > > > >    				synchronize_rcu();
> > > > > > > >    				// need all CPUs report a QS.
> > > > > > > >    	rcu_read_unlock();
> > > > > > > >    	// no rcu_read_unlock_special() due to in_nmi().
> > > > > > > > 
> > > > > > > > If the NMI happens while the CPU is in userland (say a perf event) then
> > > > > > > > the NMI returns directly to userland.
> > > > > > > > After the tracing event completes (in this case) the CPU should run into
> > > > > > > > another RCU section on its way out via context switch or the tick
> > > > > > > > interrupt.
> > > > > > > > I assume the tick interrupt is what makes the NMI case work.
> > > > > > > 
> > > > > > > Are you promising that interrupts will be always be disabled across
> > > > > > > the whole rcu_read_lock_notrace() read-side critical section?  If so,
> > > > > > > could we please have a lockdep_assert_irqs_disabled() call to check that?
> > > > > > 
> > > > > > No, that should stay preemptible because bpf can attach itself to
> > > > > > tracepoints and this is the root cause of the exercise. Now if you say
> > > > > > it has to be run with disabled interrupts to match the NMI case then it
> > > > > > makes sense (since NMIs have interrupts off) but I do not understand why
> > > > > > it matters here (since the CPU returns to userland without passing the
> > > > > > kernel).
> > > > > 
> > > > > Given your patch, if you don't disable interrupts in a preemptible kernel
> > > > > across your rcu_read_lock_notrace()/rcu_read_unlock_notrace() pair, then a
> > > > > concurrent expedited grace period might send its IPI in the middle of that
> > > > > critical section.  That IPI handler would set up state so that the next
> > > > > rcu_preempt_deferred_qs_irqrestore() would report the quiescent state.
> > > > > Except that without the call to rcu_read_unlock_special(), there might
> > > > > not be any subsequent call to rcu_preempt_deferred_qs_irqrestore().
> > > > > 
> > > > > This is even more painful if this is a CONFIG_PREEMPT_RT kernel.
> > > > > Then if that critical section was preempted and then priority-boosted,
> > > > > the unboosting also won't happen until the next call to that same
> > > > > rcu_preempt_deferred_qs_irqrestore() function, which again might not
> > > > > happen.  Or might be significantly delayed.
> > > > > 
> > > > > Or am I missing some trick that fixes all of this?
> > > > > 
> > > > > > I'm not sure how much can be done here due to the notrace part. Assuming
> > > > > > rcu_read_unlock_special() is not doable, would forcing a context switch
> > > > > > (via setting need-resched and irq_work, as the IRQ-off case) do the
> > > > > > trick?
> > > > > > Looking through rcu_preempt_deferred_qs_irqrestore() it does not look to
> > > > > > be "usable from the scheduler (with rq lock held)" due to RCU-boosting
> > > > > > or the wake of expedited_wq (which is one of the requirement).
> > > > > 
> > > > > But if rq_lock is held, then interrupts are disabled, which will
> > > > > cause the unboosting to be deferred.
> > > > > 
> > > > > Or are the various deferral mechanisms also unusable in this context?
> > > > 
> > > > OK, looking back through this thread, it appears that you need both
> > > > an rcu_read_lock_notrace() and an rcu_read_unlock_notrace() that are
> > > > covered by Mathieu's list of requirements [1]:
> > > 
> > > I'm just jumping into this email thread, so I'll try to clarify
> > > what I may.
> > 
> > Thank you for jumping in!
> > 
> > > > | - NMI-safe
> > > > 	This is covered by the existing rcu_read_lock() and
> > > > 	rcu_read_unlock().
> > > 
> > > OK
> > > 
> > > > | - notrace
> > > > 	I am guessing that by "notrace", you mean the "notrace" CPP
> > > > 	macro attribute defined in include/linux/compiler_types.h.
> > > > 	This has no fewer than four different definitions, so I will
> > > > 	need some help understanding what the restrictions are.
> > > 
> > > When I listed notrace in my desiderata, I had in mind the
> > > preempt_{disable,enable}_notrace macros, which ensure that
> > > those macros don't call instrumentation, and therefore can be
> > > used from the implementation of tracepoint instrumentation or
> > > from a tracer callback.
> > 
> > OK, that makes sense.  I have some questions:
> > 
> > Are interrupts disabled at the calls to rcu_read_unlock_notrace()?
> 
> No.

OK, so much for that family of approaches!  ;-)

> > If interrupts are instead enabled, is it OK for an IRQ-work handler that
> > did an immediate self-interrupt and a bunch of non-notrace work?
> > 
> > If interrupts are to be enabled, but an immediate IRQ-work handler is
> > ruled out, what mechanism should I be using to defer the work, given
> > that it cannot be deferred for very long without messing up real-time
> > latencies?  As in a delay of nanoseconds or maybe a microsecond, but
> > not multiple microseconds let alone milliseconds?
> > 
> > (I could imagine short-timeout hrtimer, but I am not seeing notrace
> > variants of these guys, either.)
> 
> I have nothing against an immediate IRQ-work, but I'm worried about
> _nested_ immediate IRQ-work, where we end up triggering a endless
> recursion of IRQ-work through instrumentation.
> 
> Ideally we would want to figure out a way to prevent endless recursion,
> while keeping the immediate IRQ-work within rcu_read_unlock_notrace()
> to keep RT latency within bounded ranges, but without adding unwanted
> overhead by adding too many conditional branches to the fast-paths.
> 
> Is there a way to issue a given IRQ-work only when not nested in that
> IRQ-work handler ? Any way we can detect and prevent that recursion
> should work fine.

You are looking for this commit from Joel Fernandes:

3284e4adca9b ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")

This is in the shiny-ish new-ish shared RCU tree at:

	git@gitolite.kernel.org:pub/scm/linux/kernel/git/rcu/linux

Or Message-Id <20250709104118.15532-6-neeraj.upadhyay@kernel.org>.

> > > > | - usable from the scheduler (with rq lock held)
> > > > 	This is covered by the existing rcu_read_lock() and
> > > > 	rcu_read_unlock().
> > > 
> > > OK
> > > 
> > > > | - usable to trace the RCU implementation
> > > > 	This one I don't understand.  Can I put tracepoints on
> > > > 	rcu_read_lock_notrace() and rcu_read_unlock_notrace() or can't I?
> > > > 	I was assuming that tracepoints would be forbidden.  Until I
> > > > 	reached this requirement, that is.
> > > 
> > > At a high level, a rcu_read_{lock,unlock}_notrace should be something
> > > that is safe to call from the tracepoint implementation or from a
> > > tracer callback.
> > > 
> > > My expectation is that the "normal" (not notrace) RCU APIs would
> > > be instrumented with tracepoints, and tracepoints and tracer callbacks
> > > are allowed to use the _notrace RCU APIs.
> > > 
> > > This provides instrumentation coverage of RCU with the exception of the
> > > _notrace users, which is pretty much the best we can hope for without
> > > having a circular dependency.
> > 
> > OK, got it, and that does make sense.  I am not sure how I would have
> > intuited that from the description, but what is life without a challenge?
> 
> That certainly makes life interesting !
> 
> As a side-note, I think the "_notrace" suffix I've described comes from
> the "notrace" function attribute background, which is indeed also used
> to prevent function tracing of the annotated functions, for similar
> purposes.
> 
> Kprobes also has annotation mechanisms to prevent inserting breakpoints
> in specific functions, and in other cases we rely on compiler flags to
> prevent instrumentation of entire objects.
> 
> But mostly the goal of all of those mechanisms is the same: allow some
> kernel code to be used from instrumentation and tracer callbacks without
> triggering endless recursion.

OK, so is there some tracing anti-recursion flag in effect?
Or is there something else that I must do before invoking either
raise_softirq_irqoff() or irq_work_queue_on()?

Plus RCU does need *some* hint that it is not supposed to invoke
rcu_preempt_deferred_qs_irqrestore() in this case.  Which might be
why you are suggesting an rcu_read_unlock_notrace().

> > > > One possible path forward is to ensure that rcu_read_unlock_special()
> > > > calls only functions that are compatible with the notrace/trace
> > > > requirements.  The ones that look like they might need some help are
> > > > raise_softirq_irqoff() and irq_work_queue_on().  Note that although
> > > > rcu_preempt_deferred_qs_irqrestore() would also need help, it is easy to
> > > > avoid its being invoked, for example, by disabing interrupts across the
> > > > call to rcu_read_unlock_notrace().  Or by making rcu_read_unlock_notrace()
> > > > do the disabling.
> > > > 
> > > > However, I could easily be missing something, especially given my being
> > > > confused by the juxtaposition of "notrace" and "usable to trace the
> > > > RCU implementation".  These appear to me to be contradicting each other.
> > > > 
> > > > Help?
> > > 
> > > You indeed need to ensure that everything that is called from
> > > rcu_{lock,unlock]_notrace don't end up executing instrumentation
> > > to prevent a circular dependency. You hinted at a few ways to achieve
> > > this. Other possible approaches:
> > > 
> > > - Add a "trace" bool parameter to rcu_read_unlock_special(),
> > > - Duplicate rcu_read_unlock_special() and introduce a notrace symbol.
> > 
> > OK, both of these are reasonable alternatives for the API, but it will
> > still be necessary to figure out how to make the notrace-incompatible
> > work happen.
> 
> One downside of those two approaches is that they require to somewhat
> duplicate the code (trace vs notrace). This makes it tricky in the
> case of irq work, because the irq work is just some interrupt, so we're
> limited in how we can pass around parameters that would use the
> notrace code.

Joel's patch, which is currently slated for the upcoming merge window,
should take care of the endless-IRQ-work recursion problem.  So the
main remaining issue is how rcu_read_unlock_special() should go about
safely invoking raise_softirq_irqoff() and irq_work_queue_on() when in
notrace mode.

> > > - Keep some nesting count in the task struct to prevent calling the
> > >    instrumentation when nested in notrace,
> > 
> > OK, for this one, is the idea to invoke some TBD RCU API the tracing
> > exits the notrace region?  I could see that working.  But there would
> > need to be a guarantee that if the notrace API was invoked, a call to
> > this TBD RCU API would follow in short order.  And I suspect that
> > preemption (and probably also interrupts) would need to be disabled
> > across this region.
> 
> No quite.
> 
> What I have in mind is to try to find the most elegant way to prevent
> endless recursion of the irq work issued immediately on
> rcu_read_unlock_notrace without slowing down most fast paths, and
> ideally without too much code duplication.
> 
> I'm not entirely sure what would be the best approach though.

Joel's patch adjusts use of the rcu_data structure's ->defer_qs_iw_pending
flag, so that it is cleared not in the IRQ-work handler, but
instead in rcu_preempt_deferred_qs_irqrestore().  That prevents
rcu_read_unlock_special() from requeueing the IRQ-work handler until
after the previous request for a quiescent state has been satisfied.

So my main concern is again safely invoking raise_softirq_irqoff()
and irq_work_queue_on() when in notrace mode.

> > > There are probably other possible approaches I am missing, each with
> > > their respective trade offs.
> > 
> > I am pretty sure that we also have some ways to go before we have the
> > requirements fully laid out, for that matter.  ;-)
> > 
> > Could you please tell me where in the current tracing code these
> > rcu_read_lock_notrace()/rcu_read_unlock_notrace() calls would be placed?
> 
> AFAIU here:
> 
> include/linux/tracepoint.h:
> 
> #define __DECLARE_TRACE(name, proto, args, cond, data_proto) [...]
> 
>         static inline void __do_trace_##name(proto)                     \
>         {                                                               \
>                 if (cond) {                                             \
>                         guard(preempt_notrace)();                       \
>                         __DO_TRACE_CALL(name, TP_ARGS(args));           \
>                 }                                                       \
>         }                                                               \
>         static inline void trace_##name(proto)                          \
>         {                                                               \
>                 if (static_branch_unlikely(&__tracepoint_##name.key))   \
>                         __do_trace_##name(args);                        \
>                 if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {             \
>                         WARN_ONCE(!rcu_is_watching(),                   \
>                                   "RCU not watching for tracepoint");   \
>                 }                                                       \
>         }
> 
> and
> 
> #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto) [...]
> 
>         static inline void __do_trace_##name(proto)                     \
>         {                                                               \
>                 guard(rcu_tasks_trace)();                               \
>                 __DO_TRACE_CALL(name, TP_ARGS(args));                   \
>         }                                                               \
>         static inline void trace_##name(proto)                          \
>         {                                                               \
>                 might_fault();                                          \
>                 if (static_branch_unlikely(&__tracepoint_##name.key))   \
>                         __do_trace_##name(args);                        \
>                 if (IS_ENABLED(CONFIG_LOCKDEP)) {                       \
>                         WARN_ONCE(!rcu_is_watching(),                   \
>                                   "RCU not watching for tracepoint");   \
>                 }                                                       \
>         }

I am not seeing a guard(rcu)() in here, only guard(preempt_notrace)()
and guard(rcu_tasks_trace)().  Or is the idea to move the first to
guard(rcu_notrace)() in order to improve PREEMPT_RT latency?

							Thanx, Paul
