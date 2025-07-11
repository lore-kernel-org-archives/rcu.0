Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8851C3C11;
	Fri, 11 Jul 2025 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253527; cv=none; b=ltRMhQbSS/bY6qCYu6zgJgz7Hvg5MKkeMLdUVZtleRKblVJg1XOa0CUudB/Lr/VJNHCBb/JCfDVRTZJ6FHYGRLOr2nCd6tsXvWu4D/bX4WebKkqb1quanjfORPaCrgo9bGAMaAereyYu/pnmmS6DytvDRerZc3nt/U14pMeclxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253527; c=relaxed/simple;
	bh=6ZJHLwP5Xlls7UnpMxvjtIwYhaPhNA0L/+4wEz0x2As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C07SBGKBN4zMsqr8JupFZBoXXj59+lWXTr0CsSkcUY5SwfogOCEeH+i2kgC/KuGISVnd2yxobscS7m7RVzwYi2lqwy8AsDYh/aFSKQVlND61GAixocuT+pOqy1TVUQE/XzPn0bbpSl511nnIYA7T+HeJJoOV783/o8HUoxHbWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtpEEb0c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtpEEb0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11E4C4CEED;
	Fri, 11 Jul 2025 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752253527;
	bh=6ZJHLwP5Xlls7UnpMxvjtIwYhaPhNA0L/+4wEz0x2As=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZtpEEb0cxG/E0IVZgx1jXS+XbOpzBpJG/s0ZPTmrNk0YBpWKcDWBnT+x6IMaDrax9
	 uuPVGYEsiVl9qmPfdAPL68DC5mGVYcjjXau0y14c8AqXEWoYFzFPS6QJIJMuN4gHb/
	 4YT2c45sfyWPLv8wzVAEdN6F7oJAlxx/y7NTFY/EH6eFg14E7oE7Pn+aCvpopcC/LK
	 Wk4ycfEzh/Pfb/pJOfpR6JKQ56XEI7qB4F4edfdSLQWuIztO8UtEHZ6k3FZGEP1phe
	 s5fJZ/fdumFWxni4GMQIyK4M/LZXRRk/t7dK56cpBye/UizbmrUTH8DATf3mrFjcKb
	 /AdX6m/IsipGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9885BCE0C16; Fri, 11 Jul 2025 10:05:26 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:05:26 -0700
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
Message-ID: <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250620084334.Zb8O2SwS@linutronix.de>
 <34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>
 <20250623104941.WxOQtAmV@linutronix.de>
 <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>

On Fri, Jul 11, 2025 at 09:46:25AM -0400, Mathieu Desnoyers wrote:
> On 2025-07-09 14:33, Paul E. McKenney wrote:
> > On Wed, Jul 09, 2025 at 10:31:14AM -0400, Mathieu Desnoyers wrote:
> > > On 2025-07-08 16:49, Paul E. McKenney wrote:
> > > > On Tue, Jul 08, 2025 at 03:40:05PM -0400, Mathieu Desnoyers wrote:
> > > > > On 2025-07-07 17:56, Paul E. McKenney wrote:
> > > > > > On Mon, Jun 23, 2025 at 11:13:03AM -0700, Paul E. McKenney wrote:
> > > > > > > On Mon, Jun 23, 2025 at 12:49:41PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > > > > On 2025-06-20 04:23:49 [-0700], Paul E. McKenney wrote:
> [...]
> > 
> > > I have nothing against an immediate IRQ-work, but I'm worried about
> > > _nested_ immediate IRQ-work, where we end up triggering a endless
> > > recursion of IRQ-work through instrumentation.
> > > 
> > > Ideally we would want to figure out a way to prevent endless recursion,
> > > while keeping the immediate IRQ-work within rcu_read_unlock_notrace()
> > > to keep RT latency within bounded ranges, but without adding unwanted
> > > overhead by adding too many conditional branches to the fast-paths.
> > > 
> > > Is there a way to issue a given IRQ-work only when not nested in that
> > > IRQ-work handler ? Any way we can detect and prevent that recursion
> > > should work fine.
> > 
> > You are looking for this commit from Joel Fernandes:
> > 
> > 3284e4adca9b ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
> > 
> > This is in the shiny-ish new-ish shared RCU tree at:
> > 
> > 	git@gitolite.kernel.org:pub/scm/linux/kernel/git/rcu/linux
> > 
> > Or Message-Id <20250709104118.15532-6-neeraj.upadhyay@kernel.org>.
> 
> Whatever means of tracking whether we are already in an irq work
> context and prevent emitting a recursive irq work should do.
> 
> Do I understand correctly that this commit takes care of preventing
> recursive irq_work_queue_on() calls, but does not solve the issue of
> recursive raise_softirq_irqoff() caused by tracepoint instrumentation ?

Exactly!

In case you are testing this, we do have a new version of the above
commit with a bug fix:

2e154d164418 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")

> [...]
> 
> > > 
> > > As a side-note, I think the "_notrace" suffix I've described comes from
> > > the "notrace" function attribute background, which is indeed also used
> > > to prevent function tracing of the annotated functions, for similar
> > > purposes.
> > > 
> > > Kprobes also has annotation mechanisms to prevent inserting breakpoints
> > > in specific functions, and in other cases we rely on compiler flags to
> > > prevent instrumentation of entire objects.
> > > 
> > > But mostly the goal of all of those mechanisms is the same: allow some
> > > kernel code to be used from instrumentation and tracer callbacks without
> > > triggering endless recursion.
> > 
> > OK, so is there some tracing anti-recursion flag in effect?
> > Or is there something else that I must do before invoking either
> > raise_softirq_irqoff() or irq_work_queue_on()?
> 
> Note that we have two scenarios:
> 
> - A nested scenario with a causality relationship, IOW circular
>   dependency, which leads to endless recursion and a crash, and
> 
> - A nested scenario which is just the result of softirq, irq, nmi
>   nesting,
> 
> In all of those scenarios, what we really care about here is to make
> sure the outermost execution context emits the irq work to prevent
> long latency, but we don't care if the nested contexts skip it.

From what I can see, the above commit deals with the endless recursion,
but not with the calls to the non-notrace functions.  (If the calls to
non-notrace functions are in fact a problem?)

> > Plus RCU does need *some* hint that it is not supposed to invoke
> > rcu_preempt_deferred_qs_irqrestore() in this case.  Which might be
> > why you are suggesting an rcu_read_unlock_notrace().
> 
> The rcu_read_unlock_notrace() approach removes RCU instrumentation, even
> for the outermost nesting level. We'd be losing some RCU instrumentation
> coverage there, but on the upside we would prevent emitting an RCU read
> unlock tracepoint for every other tracepoint hit, which I think is good.
> 
> If instead we take an approach where we track in which instrumentation
> nesting level we are within the task_struct, then we can skip calls to
> rcu_preempt_deferred_qs_irqrestore() in all nested contexts, but keep
> calling it in the outermost context.
> 
> But I would tend to favor the notrace approach so we don't emit
> semi-useless RCU read lock/unlock events for every other tracepoint
> hit. It would clutter the trace.

But we still need to avoid grace-period hangs, needlessly high-latency
RCU expedited grace periods, and delayed RCU priority deboosts.

> > > > > > One possible path forward is to ensure that rcu_read_unlock_special()
> > > > > > calls only functions that are compatible with the notrace/trace
> > > > > > requirements.  The ones that look like they might need some help are
> > > > > > raise_softirq_irqoff() and irq_work_queue_on().  Note that although
> > > > > > rcu_preempt_deferred_qs_irqrestore() would also need help, it is easy to
> > > > > > avoid its being invoked, for example, by disabing interrupts across the
> > > > > > call to rcu_read_unlock_notrace().  Or by making rcu_read_unlock_notrace()
> > > > > > do the disabling.
> > > > > > 
> > > > > > However, I could easily be missing something, especially given my being
> > > > > > confused by the juxtaposition of "notrace" and "usable to trace the
> > > > > > RCU implementation".  These appear to me to be contradicting each other.
> > > > > > 
> > > > > > Help?
> > > > > 
> > > > > You indeed need to ensure that everything that is called from
> > > > > rcu_{lock,unlock]_notrace don't end up executing instrumentation
> > > > > to prevent a circular dependency. You hinted at a few ways to achieve
> > > > > this. Other possible approaches:
> > > > > 
> > > > > - Add a "trace" bool parameter to rcu_read_unlock_special(),
> > > > > - Duplicate rcu_read_unlock_special() and introduce a notrace symbol.
> > > > 
> > > > OK, both of these are reasonable alternatives for the API, but it will
> > > > still be necessary to figure out how to make the notrace-incompatible
> > > > work happen.
> > > 
> > > One downside of those two approaches is that they require to somewhat
> > > duplicate the code (trace vs notrace). This makes it tricky in the
> > > case of irq work, because the irq work is just some interrupt, so we're
> > > limited in how we can pass around parameters that would use the
> > > notrace code.
> > 
> > Joel's patch, which is currently slated for the upcoming merge window,
> > should take care of the endless-IRQ-work recursion problem.  So the
> > main remaining issue is how rcu_read_unlock_special() should go about
> > safely invoking raise_softirq_irqoff() and irq_work_queue_on() when in
> > notrace mode.
> 
> Are those two functions only needed from the outermost rcu_read_unlock
> within a thread ? If yes, then keeping track of nesting level and
> preventing those calls in nested contexts (per thread) should work.

You lost me on this one.

Yes, these are invoked only by the outermost rcu_read_unlock{,_notrace}().
And we already have a nexting counter, current->rcu_read_lock_nesting.

However...

If the tracing invokes an outermost rcu_read_unlock{,_notrace}(), then in
some contexts we absolutely need to invoke the raise_softirq_irqoff()
and irq_work_queue_on() functions, both of which are notrace functions.

Or are you telling me that it is OK for a rcu_read_unlock_notrace()
to directly call these non-notrace functions?

> > > > > - Keep some nesting count in the task struct to prevent calling the
> > > > >     instrumentation when nested in notrace,
> > > > 
> > > > OK, for this one, is the idea to invoke some TBD RCU API the tracing
> > > > exits the notrace region?  I could see that working.  But there would
> > > > need to be a guarantee that if the notrace API was invoked, a call to
> > > > this TBD RCU API would follow in short order.  And I suspect that
> > > > preemption (and probably also interrupts) would need to be disabled
> > > > across this region.
> > > 
> > > No quite.
> > > 
> > > What I have in mind is to try to find the most elegant way to prevent
> > > endless recursion of the irq work issued immediately on
> > > rcu_read_unlock_notrace without slowing down most fast paths, and
> > > ideally without too much code duplication.
> > > 
> > > I'm not entirely sure what would be the best approach though.
> > 
> > Joel's patch adjusts use of the rcu_data structure's ->defer_qs_iw_pending
> > flag, so that it is cleared not in the IRQ-work handler, but
> > instead in rcu_preempt_deferred_qs_irqrestore().  That prevents
> > rcu_read_unlock_special() from requeueing the IRQ-work handler until
> > after the previous request for a quiescent state has been satisfied.
> > 
> > So my main concern is again safely invoking raise_softirq_irqoff()
> > and irq_work_queue_on() when in notrace mode.
> 
> Would the nesting counter (per thread) approach suffice for your use
> case ?

Over and above the t->rcu_read_lock_nesting that we already use?
As in only the outermost rcu_read_unlock{,_notrace}() will invoke
rcu_read_unlock_special().

OK, let's look at a couple of scenarios.

First, suppose that we apply Joel's patch above, and someone sets a trace
point in task context outside of any RCU read-side critical section.
Suppose further that this task is preempted in the tracepoint's RCU
read-side critical section, and that RCU priority boosting is applied.

This trace point will invoke rcu_read_unlock{,_notrace}(), which
will in turn invoke rcu_read_unlock_special(), which will in turn
will note that preemption, interrupts, and softirqs are all enabled.
It will therefore directly invoke rcu_preempt_deferred_qs_irqrestore(),
a non-notrace function, which can in turn invoke all sorts of interesting
functions involving locking, the scheduler, ...

Is this OK, or should I set some sort of tracepoint recursion flag?

Second, suppose that we apply Joel's patch above, and someone sets a trace
point in task context outside of an RCU read-side critical section, but in
an preemption-disabled region of code.  Suppose further that this code is
delayed, perhaps due to a flurry of interrupts, so that a scheduling-clock
interrupt sets t->rcu_read_unlock_special.b.need_qs to true.

This trace point will invoke rcu_read_unlock{,_notrace}(), which will
note that preemption is disabled.  If rcutree.use_softirq is set and
this task is blocking an expedited RCU grace period, it will directly
invoke the non-notrace function raise_softirq_irqoff().  Otherwise,
it will directly invoke the non-notrace function irq_work_queue_on().

Is this OK, or should I set some sort of tracepoint recursion flag?

There are other scenarios, but they require interrupts to be disabled
across the rcu_read_unlock{,_notrace}(), but to have been enabled somewhere
in the just-ended RCU read-side critical section.  It does not look to
me like tracing does this.  But I might be missing something.  If so,
we have more scenarios to think through.  ;-)

> > > > > There are probably other possible approaches I am missing, each with
> > > > > their respective trade offs.
> > > > 
> > > > I am pretty sure that we also have some ways to go before we have the
> > > > requirements fully laid out, for that matter.  ;-)
> > > > 
> > > > Could you please tell me where in the current tracing code these
> > > > rcu_read_lock_notrace()/rcu_read_unlock_notrace() calls would be placed?
> > > 
> > > AFAIU here:
> > > 
> > > include/linux/tracepoint.h:
> > > 
> > > #define __DECLARE_TRACE(name, proto, args, cond, data_proto) [...]
> > > 
> > >          static inline void __do_trace_##name(proto)                     \
> > >          {                                                               \
> > >                  if (cond) {                                             \
> > >                          guard(preempt_notrace)();                       \
> > >                          __DO_TRACE_CALL(name, TP_ARGS(args));           \
> > >                  }                                                       \
> > >          }                                                               \
> > >          static inline void trace_##name(proto)                          \
> > >          {                                                               \
> > >                  if (static_branch_unlikely(&__tracepoint_##name.key))   \
> > >                          __do_trace_##name(args);                        \
> > >                  if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {             \
> > >                          WARN_ONCE(!rcu_is_watching(),                   \
> > >                                    "RCU not watching for tracepoint");   \
> > >                  }                                                       \
> > >          }
> > > 
> > > and
> > > 
> > > #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto) [...]
> > > 
> > >          static inline void __do_trace_##name(proto)                     \
> > >          {                                                               \
> > >                  guard(rcu_tasks_trace)();                               \
> > >                  __DO_TRACE_CALL(name, TP_ARGS(args));                   \
> > >          }                                                               \
> > >          static inline void trace_##name(proto)                          \
> > >          {                                                               \
> > >                  might_fault();                                          \
> > >                  if (static_branch_unlikely(&__tracepoint_##name.key))   \
> > >                          __do_trace_##name(args);                        \
> > >                  if (IS_ENABLED(CONFIG_LOCKDEP)) {                       \
> > >                          WARN_ONCE(!rcu_is_watching(),                   \
> > >                                    "RCU not watching for tracepoint");   \
> > >                  }                                                       \
> > >          }
> > 
> > I am not seeing a guard(rcu)() in here, only guard(preempt_notrace)()
> > and guard(rcu_tasks_trace)().  Or is the idea to move the first to
> > guard(rcu_notrace)() in order to improve PREEMPT_RT latency?
> 
> AFAIU the goal here is to turn the guard(preempt_notrace)() into a
> guard(rcu_notrace)() because the preempt-off critical sections don't
> agree with BPF.

OK, got it, thank you!

The combination of BPF and CONFIG_PREEMPT_RT certainly has provided at
least its share of entertainment, that is for sure.  ;-)

							Thanx, Paul
