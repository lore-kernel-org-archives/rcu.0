Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAB41C4A24;
	Tue, 15 Jul 2025 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752621526; cv=none; b=ds4IoyLi4zWqQNFKzuaDJJmhvcrTG+UaxILKrO7dhF7xSSlUli10mb3zRUnbdN8NsE3tH8ZE/SOHqboNW1XjA9Ltl/TtZsRYDIuG+9GfJXyuX/MfllWM0lk/7PJwTyapXzGR1Rb2YvTYAapYVbQNDhcAXu69IxYqhD4q3M9neak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752621526; c=relaxed/simple;
	bh=zrYo3UNiAYYvAEZDtOTs0qBWLrttYiq8kqCcxJOyZq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUmf2lKuJVt4ZSps2EiMd2rA7LirENIbcX+TEcQlarRBVRxV0VIPXjCzxFv3aWbw4HgaJTs24N28TghZqNbsvPjypklDdnS4Fn8ZpRvYUt1AOn6oIcQeLB8XFyFA4fHZmSwbQHqca8pl6KyiwWTa4Ys0ZrWxCfTAIXcYbo0r6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j19oIcnS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j19oIcnS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12798C4CEE3;
	Tue, 15 Jul 2025 23:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752621526;
	bh=zrYo3UNiAYYvAEZDtOTs0qBWLrttYiq8kqCcxJOyZq0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=j19oIcnSrlrkzmEOrOlqk9n+QoLF9uABe229uyn4wSOjyKrmQ2Y40OFk2JeUXeEtj
	 /Jxnp0crF32yVJfm7WMPs2FB3KVGlj6LOkVQkpsIadlbC2kj+BccShw1TXAW8rTAYJ
	 eb48/RenxyNlrWjhM2ia4RoSytANTNPAN/qAs8qfw6wwOVC5dnpq8f9WTJS3U2bI+/
	 sSig0l/aqGaQ5Q74JJW6omN3sZInymQ+kyJ/phpSP0ZswnP1p78Mj3m/2EUkTjnSoO
	 gE68wU+R8Ka+Qg0dlwbNMm9uukCw7scCjCMWZuuA5R4vVcSuDB81SvxvqpqcErtufc
	 sOM3m0gc71CRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A55A3CE09FF; Tue, 15 Jul 2025 16:18:45 -0700 (PDT)
Date: Tue, 15 Jul 2025 16:18:45 -0700
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
Message-ID: <b1b5d560-7c9b-4098-bb0f-469dcea4d8d6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250623104941.WxOQtAmV@linutronix.de>
 <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <2bc2c9cd-f1bf-4c9a-b722-256561082854@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bc2c9cd-f1bf-4c9a-b722-256561082854@efficios.com>

On Tue, Jul 15, 2025 at 03:54:02PM -0400, Mathieu Desnoyers wrote:
> On 2025-07-11 13:05, Paul E. McKenney wrote:
> > On Fri, Jul 11, 2025 at 09:46:25AM -0400, Mathieu Desnoyers wrote:
> > > On 2025-07-09 14:33, Paul E. McKenney wrote:
> > > > On Wed, Jul 09, 2025 at 10:31:14AM -0400, Mathieu Desnoyers wrote:

First, do we have a well-defined repeat-by to reproduce this issue?

Failing that, do we have a well-defined problem statement?  This is
all I have thus far:

o	Disabling preemption at tracepoints causes problems for BPF.
	(I have not yet checked this with the BFP folks, but last I knew
	it was OK to attach BPF programs to preempt-disabled regions
	of code, but perhaps this issue is specific to PREEMPT_RT.
	Perhaps involving memory allocation.)

o	Thus, there is a desire to move tracepoints from using
	preempt_disable_notrace() to a new rcu_read_lock_notrace()
	whose required semantics I do not yet understand.  However,
	from a first-principles RCU perspective, it must not unduly
	delay expedited grace periods and RCU priority deboosting.
	It also must not starve normal grace periods.

o	We clearly need to avoid destructive recursion in both tracepoints
	and in BPF.

o	Apparently, the interval across which tracepoint/BPF recursion is
	destructive extends beyond the proposed rcu_read_lock_notrace()
	critical section.  (If so, how far beyond, and can the RCU reader
	be extended to cover the full extent?  If not, why do we have
	a problem?)

	The definition of __DECLARE_TRACE looks to me like the RCU
	reader does in fact cover the full extent of the region in
	which (finite) recursion is destructive, at least given
	Joel's aforementioned IRQ-work patch:

	2e154d164418 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")

	Without that patch, yes, life is recursively hard.  So recursively
	hard, in fact, that the recursion itself kills you before you
	have a chance to die.

	Except that, assuming that I understand this (ha!), we also need
	to prevent rcu_read_unlock_special() from directly invoking
	rcu_preempt_deferred_qs_irqrestore().  The usual PREEMPT_RT
	configuration won't ever invoke raise_softirq_irqoff(), but
	maybe other configurations will.  But there are similar issues
	with irq_work_queue_on().

We have some non-problems:

o	If rcu_read_unlock() or one of its friends is invoked with a
	scheduler lock held, then interrupts will be disabled, which
	will cause rcu_read_unlock_special() to defer its calls into
	the scheduler, for example, via IRQ work.

o	NMI safety is already provided.

Have you guys been working with anyone on the BPF team?  If so, I should
reach out to that person, if not, I should find someone in BPF-land to
reach out to.  They might have some useful feedback.

> [...]
> > > > 
> > > > Joel's patch, which is currently slated for the upcoming merge window,
> > > > should take care of the endless-IRQ-work recursion problem.  So the
> > > > main remaining issue is how rcu_read_unlock_special() should go about
> > > > safely invoking raise_softirq_irqoff() and irq_work_queue_on() when in
> > > > notrace mode.
> > > 
> > > Are those two functions only needed from the outermost rcu_read_unlock
> > > within a thread ? If yes, then keeping track of nesting level and
> > > preventing those calls in nested contexts (per thread) should work.
> > 
> > You lost me on this one.
> > 
> > Yes, these are invoked only by the outermost rcu_read_unlock{,_notrace}().
> > And we already have a nexting counter, current->rcu_read_lock_nesting.
> 
> But AFAIU those are invoked after decrementing the nesting counter,
> right ? So any instrumentation call done within those functions may
> end up doing a read-side critical section again.

They are indeed invoked after decrementing ->rcu_read_lock_nesting.

> > However...
> > 
> > If the tracing invokes an outermost rcu_read_unlock{,_notrace}(), then in
> > some contexts we absolutely need to invoke the raise_softirq_irqoff()
> > and irq_work_queue_on() functions, both of which are notrace functions.
> 
> I guess you mean "both of which are non-notrace functions", otherwise
> we would not be having this discussion.
> 
> > 
> > Or are you telling me that it is OK for a rcu_read_unlock_notrace()
> > to directly call these non-notrace functions?
> 
> What I am getting at is that it may be OK for the outermost nesting
> level of rcu_read_unlock_notrace() to call those non-notrace functions,
> but only if we manage to keep track of that nesting level while those
> non-notrace functions are called.
> 
> So AFAIU one issue here is that when the non-notrace functions are
> called, the nesting level is back to 0 already.

So you are worried about something like this?

	rcu_read_unlock() -> rcu_read_unlock_special() ->
	rcu_preempt_deferred_qs_irqrestore() -> *tracepoint* ->
	rcu_read_unlock() -> rcu_read_unlock_special() ->
	rcu_preempt_deferred_qs_irqrestore() -> *tracepoint* ->
	rcu_read_unlock() -> rcu_read_unlock_special() ->
	rcu_preempt_deferred_qs_irqrestore() -> *tracepoint* ->
	rcu_read_unlock() -> rcu_read_unlock_special() ->
	rcu_preempt_deferred_qs_irqrestore() -> *tracepoint* ->

And so on forever?

Ditto for irq_work_queue_on()?

> > > > > > > - Keep some nesting count in the task struct to prevent calling the
> > > > > > >      instrumentation when nested in notrace,
> > > > > > 
> > > > > > OK, for this one, is the idea to invoke some TBD RCU API the tracing
> > > > > > exits the notrace region?  I could see that working.  But there would
> > > > > > need to be a guarantee that if the notrace API was invoked, a call to
> > > > > > this TBD RCU API would follow in short order.  And I suspect that
> > > > > > preemption (and probably also interrupts) would need to be disabled
> > > > > > across this region.
> > > > > 
> > > > > No quite.
> > > > > 
> > > > > What I have in mind is to try to find the most elegant way to prevent
> > > > > endless recursion of the irq work issued immediately on
> > > > > rcu_read_unlock_notrace without slowing down most fast paths, and
> > > > > ideally without too much code duplication.
> > > > > 
> > > > > I'm not entirely sure what would be the best approach though.
> > > > 
> > > > Joel's patch adjusts use of the rcu_data structure's ->defer_qs_iw_pending
> > > > flag, so that it is cleared not in the IRQ-work handler, but
> > > > instead in rcu_preempt_deferred_qs_irqrestore().  That prevents
> > > > rcu_read_unlock_special() from requeueing the IRQ-work handler until
> > > > after the previous request for a quiescent state has been satisfied.
> > > > 
> > > > So my main concern is again safely invoking raise_softirq_irqoff()
> > > > and irq_work_queue_on() when in notrace mode.
> > > 
> > > Would the nesting counter (per thread) approach suffice for your use
> > > case ?
> > 
> > Over and above the t->rcu_read_lock_nesting that we already use?
> > As in only the outermost rcu_read_unlock{,_notrace}() will invoke
> > rcu_read_unlock_special().
> > 
> > OK, let's look at a couple of scenarios.
> > 
> > First, suppose that we apply Joel's patch above, and someone sets a trace
> > point in task context outside of any RCU read-side critical section.
> > Suppose further that this task is preempted in the tracepoint's RCU
> > read-side critical section, and that RCU priority boosting is applied.
> > 
> > This trace point will invoke rcu_read_unlock{,_notrace}(), which
> > will in turn invoke rcu_read_unlock_special(), which will in turn
> > will note that preemption, interrupts, and softirqs are all enabled.
> > It will therefore directly invoke rcu_preempt_deferred_qs_irqrestore(),
> > a non-notrace function, which can in turn invoke all sorts of interesting
> > functions involving locking, the scheduler, ...
> > 
> > Is this OK, or should I set some sort of tracepoint recursion flag?
> 
> Or somehow modify the semantic of t->rcu_read_lock_nesting if at all
> possible. Rather than decrementing it first and then if 0 invoke
> a rcu_read_unlock_special, it could perhaps invoke
> rcu_read_unlock_special if the nesting counter is _about to be
> decremented from 1 to 0_, and then decrement to 0. This would
> hopefully prevent recursion.
> 
> But I may be entirely misunderstanding the whole problem. If so,
> please let me know!
> 
> And if for some reason is really needs to be decremented before
> calling rcu_read_unlock_special, then we can have the following:
> when exiting the outermost critical section, it could be decremented
> from 2 to 1, then call rcu_read_unlock_special, after which it's
> decremented to 0. The outermost read lock increment would have to
> be adapted accordingly. But this would add overhead on the fast-paths,
> which may be frowned upon.
> 
> The idea here is to keep tracking the fact that we are within the
> execution of rcu_read_unlock_special, so it does not call it again
> recursively, even though we are technically not nested within a
> read-side critical section anymore.

Heh!  Some years back, rcu_read_unlock() used to do exactly that.
This changed in 2020 with this commit:

5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read_unlock()")

Quoting the commit log: "it is no longer necessary for __rcu_read_unlock()
to set the nesting level negative."

No longer necessary until now, perhaps?

How to revert this puppy?  Let's see...

The addition of "depth" to rcu_exp_handler() can stay, but that last hunk
needs to be restored.  And the rcu_data structure's ->exp_deferred_qs
might need to come back.  Ah, but it is now ->cpu_no_qs.b.exp in that
same structure.  So should be fine.  (Famous last words.)

And rcu_dynticks_curr_cpu_in_eqs() is no longer with us.  I believe that
it is now named !rcu_is_watching_curr_cpu(), but Frederic would know best.

On to kernel/rcu/tree_plugin.h...

We need RCU_NEST_BIAS and RCU_NEST_NMAX back.  Do we want to revert
the change to __rcu_read_unlock() or just leave it alone (for the
performance benefit, miniscule though it might be) and create an
__rcu_read_unlock_notrace()?  The former is simpler, especially
from an rcutorture testing viewpoint.  So the former it is, unless
and until someone like Lai Jiangshan (already CCed) can show a
strong need.  This would require an rcu_read_unlock_notrace() and an
__rcu_read_unlock_notrace(), with near-duplicate code.  Not a disaster,
but let's do it only if we really need it.

So put rcu_preempt_read_exit() back the way it was, and ditto for
__rcu_read_unlock(), rcu_preempt_need_deferred_qs(), and
rcu_flavor_sched_clock_irq().

Note that RCU_NEST_PMAX stayed and is still checked in __rcu_read_lock(),
so that part remained.

Give or take the inevitable bugs.  Initial testing is in progress.

The initial patch may be found at the end of this email, but it should
be used for entertainment purposes only.

> > Second, suppose that we apply Joel's patch above, and someone sets a trace
> > point in task context outside of an RCU read-side critical section, but in
> > an preemption-disabled region of code.  Suppose further that this code is
> > delayed, perhaps due to a flurry of interrupts, so that a scheduling-clock
> > interrupt sets t->rcu_read_unlock_special.b.need_qs to true.
> > 
> > This trace point will invoke rcu_read_unlock{,_notrace}(), which will
> > note that preemption is disabled.  If rcutree.use_softirq is set and
> > this task is blocking an expedited RCU grace period, it will directly
> > invoke the non-notrace function raise_softirq_irqoff().  Otherwise,
> > it will directly invoke the non-notrace function irq_work_queue_on().
> > 
> > Is this OK, or should I set some sort of tracepoint recursion flag?
> 
> Invoking instrumentation from the implementation of instrumentation
> is a good recipe for endless recursion, so we'd need to check for
> recursion somehow there as well AFAIU.

Agreed, it could get ugly.

> > There are other scenarios, but they require interrupts to be disabled
> > across the rcu_read_unlock{,_notrace}(), but to have been enabled somewhere
> > in the just-ended RCU read-side critical section.  It does not look to
> > me like tracing does this.  But I might be missing something.  If so,
> > we have more scenarios to think through.  ;-)
> 
> I don't see a good use-case for that kind of scenario though. But I may
> simply be lacking imagination.

There was a time when there was an explicit rule against it, so yes,
they have existed in the past.  If they exist now, that is OK.

> > > > > > > There are probably other possible approaches I am missing, each with
> > > > > > > their respective trade offs.
> > > > > > 
> > > > > > I am pretty sure that we also have some ways to go before we have the
> > > > > > requirements fully laid out, for that matter.  ;-)
> > > > > > 
> > > > > > Could you please tell me where in the current tracing code these
> > > > > > rcu_read_lock_notrace()/rcu_read_unlock_notrace() calls would be placed?
> > > > > 
> > > > > AFAIU here:
> > > > > 
> > > > > include/linux/tracepoint.h:
> > > > > 
> > > > > #define __DECLARE_TRACE(name, proto, args, cond, data_proto) [...]
> > > > > 
> > > > >           static inline void __do_trace_##name(proto)                     \
> > > > >           {                                                               \
> > > > >                   if (cond) {                                             \
> > > > >                           guard(preempt_notrace)();                       \
> > > > >                           __DO_TRACE_CALL(name, TP_ARGS(args));           \
> > > > >                   }                                                       \
> > > > >           }                                                               \
> > > > >           static inline void trace_##name(proto)                          \
> > > > >           {                                                               \
> > > > >                   if (static_branch_unlikely(&__tracepoint_##name.key))   \
> > > > >                           __do_trace_##name(args);                        \
> > > > >                   if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {             \
> > > > >                           WARN_ONCE(!rcu_is_watching(),                   \
> > > > >                                     "RCU not watching for tracepoint");   \
> > > > >                   }                                                       \
> > > > >           }
> > > > > 
> > > > > and
> > > > > 
> > > > > #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto) [...]
> > > > > 
> > > > >           static inline void __do_trace_##name(proto)                     \
> > > > >           {                                                               \
> > > > >                   guard(rcu_tasks_trace)();                               \
> > > > >                   __DO_TRACE_CALL(name, TP_ARGS(args));                   \
> > > > >           }                                                               \
> > > > >           static inline void trace_##name(proto)                          \
> > > > >           {                                                               \
> > > > >                   might_fault();                                          \
> > > > >                   if (static_branch_unlikely(&__tracepoint_##name.key))   \
> > > > >                           __do_trace_##name(args);                        \
> > > > >                   if (IS_ENABLED(CONFIG_LOCKDEP)) {                       \
> > > > >                           WARN_ONCE(!rcu_is_watching(),                   \
> > > > >                                     "RCU not watching for tracepoint");   \
> > > > >                   }                                                       \
> > > > >           }
> > > > 
> > > > I am not seeing a guard(rcu)() in here, only guard(preempt_notrace)()
> > > > and guard(rcu_tasks_trace)().  Or is the idea to move the first to
> > > > guard(rcu_notrace)() in order to improve PREEMPT_RT latency?
> > > 
> > > AFAIU the goal here is to turn the guard(preempt_notrace)() into a
> > > guard(rcu_notrace)() because the preempt-off critical sections don't
> > > agree with BPF.
> > 
> > OK, got it, thank you!
> > 
> > The combination of BPF and CONFIG_PREEMPT_RT certainly has provided at
> > least its share of entertainment, that is for sure.  ;-)
> 
> There is indeed no shortage of entertainment when combining those rather
> distinct sets of requirements. :)

I am sure that Mr. Murphy has more entertainment in store for all of us.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 076ad61e42f4a..33bed40f2b024 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -805,8 +805,32 @@ static void rcu_exp_handler(void *unused)
 		return;
 	}
 
-	// Fourth and finally, negative nesting depth should not happen.
-	WARN_ON_ONCE(1);
+	/*
+	 * The final and least likely case is where the interrupted
+	 * code was just about to or just finished exiting the
+	 * RCU-preempt read-side critical section when using
+	 * rcu_read_unlock_notrace(), and no, we can't tell which.
+	 * So either way, set ->cpu_no_qs.b.exp to flag later code that
+	 * a quiescent state is required.
+	 *
+	 * If the CPU has preemption and softirq enabled (or if some
+	 * buggy no-trace RCU-preempt read-side critical section is
+	 * being used from idle), just invoke rcu_preempt_deferred_qs()
+	 * to immediately report the quiescent state.  We cannot use
+	 * rcu_read_unlock_special() because we are in an interrupt handler,
+	 * which will cause that function to take an early exit without
+	 * doing anything.
+	 *
+	 * Otherwise, force a context switch after the CPU enables everything.
+	 */
+	rdp->cpu_no_qs.b.exp = true;
+	if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
+	    WARN_ON_ONCE(!rcu_is_watching_curr_cpu())) {
+		rcu_preempt_deferred_qs(t);
+	} else {
+		set_tsk_need_resched(t);
+		set_preempt_need_resched();
+	}
 }
 
 /*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1ee0d34ec333a..4becfe51e0e14 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -383,6 +383,9 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 	return READ_ONCE(rnp->gp_tasks) != NULL;
 }
 
+/* Bias and limit values for ->rcu_read_lock_nesting. */
+#define RCU_NEST_BIAS INT_MAX
+#define RCU_NEST_NMAX (-INT_MAX / 2)
 /* limit value for ->rcu_read_lock_nesting. */
 #define RCU_NEST_PMAX (INT_MAX / 2)
 
@@ -391,12 +394,10 @@ static void rcu_preempt_read_enter(void)
 	WRITE_ONCE(current->rcu_read_lock_nesting, READ_ONCE(current->rcu_read_lock_nesting) + 1);
 }
 
-static int rcu_preempt_read_exit(void)
+static void rcu_preempt_read_exit(void)
 {
-	int ret = READ_ONCE(current->rcu_read_lock_nesting) - 1;
 
-	WRITE_ONCE(current->rcu_read_lock_nesting, ret);
-	return ret;
+	WRITE_ONCE(current->rcu_read_lock_nesting, READ_ONCE(current->rcu_read_lock_nesting) - 1);
 }
 
 static void rcu_preempt_depth_set(int val)
@@ -431,16 +432,22 @@ void __rcu_read_unlock(void)
 {
 	struct task_struct *t = current;
 
-	barrier();  // critical section before exit code.
-	if (rcu_preempt_read_exit() == 0) {
-		barrier();  // critical-section exit before .s check.
+	if (rcu_preempt_depth() != 1) {
+		rcu_preempt_read_exit();
+	} else {
+		barrier();  // critical section before exit code.
+		rcu_preempt_depth_set(-RCU_NEST_BIAS);
+		barrier();  // critical section before ->rcu_read_unlock_special load
 		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
 			rcu_read_unlock_special(t);
+		barrier();  // ->rcu_read_unlock_special load before assignment
+		rcu_preempt_depth_set(0);
 	}
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
 		int rrln = rcu_preempt_depth();
 
-		WARN_ON_ONCE(rrln < 0 || rrln > RCU_NEST_PMAX);
+		WARN_ON_ONCE(rrln < 0 && rrln > RCU_NEST_NMAX);
+		WARN_ON_ONCE(rrln > RCU_NEST_PMAX);
 	}
 }
 EXPORT_SYMBOL_GPL(__rcu_read_unlock);
@@ -601,7 +608,7 @@ static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return (__this_cpu_read(rcu_data.cpu_no_qs.b.exp) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
-	       rcu_preempt_depth() == 0;
+	       rcu_preempt_depth() <= 0;
 }
 
 /*
@@ -755,8 +762,8 @@ static void rcu_flavor_sched_clock_irq(int user)
 	} else if (rcu_preempt_need_deferred_qs(t)) {
 		rcu_preempt_deferred_qs(t); /* Report deferred QS. */
 		return;
-	} else if (!WARN_ON_ONCE(rcu_preempt_depth())) {
-		rcu_qs(); /* Report immediate QS. */
+	} else if (!rcu_preempt_depth()) {
+		rcu_qs(); /* On our way out anyway, so report immediate QS. */
 		return;
 	}
 
