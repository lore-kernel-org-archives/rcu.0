Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F415C15A;
	Mon,  5 Aug 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877441; cv=none; b=lQpycWlVWn2RgUX74kvtpm95ctwd6aqjduda6MMv4hrId2XkAWOW1rXPb2gj8dK46DBGwJF0fjizD//zTncCuMF1Q8pN2dTcv6tCabES43DZK3IxYafj5DxdmmcaHJbVe4x3wpmMVXQMZtOiOgmnNGKmYny+kfjHWf3LQTT5XM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877441; c=relaxed/simple;
	bh=fNwSB7o8YKcGU7ZIAibAAIr/+RmBBJ46AIfJJkGAwi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYxonPvhTDvfbOof/cHk3uRTFCdrVc9S4NoMvU4p5TQCPTZhovczb3L/wEW72q2INkCpfRafPraJyZ7X69cuShS2/YSGRuY1YD/rNJpgzPrY8cFNnRBswYwnyxqZa7dOhQ9d8tUt/hRksZI0bR5H+kY9XyRVpezIdr+JTtQYPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Selayysz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Selayysz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24494C4AF12;
	Mon,  5 Aug 2024 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722877441;
	bh=fNwSB7o8YKcGU7ZIAibAAIr/+RmBBJ46AIfJJkGAwi8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SelayyszznRBWfBuyru9dNOToPiw0kgtAhZis+KeP7BSGT1lKGVl7IOfevPCUT4Ug
	 9/RTwHZxi1w0WxMhq431dsHBXYZUtMmwmP6nLvSSDGSnQDFN+jBpZ+1/Z0J47nwr2F
	 Z7FJjGCVQFpCJizI76s1Qm1Ef9w51O2FTvSaqvKUqiBzrD4VrcnN9u1GrHCPqp5OmK
	 K9DtIRa187VI9BVa+iMM6UB9s5DS21osoW7HzJTuqXvyxS3iqE9k6WH5WsA/XWYxyx
	 jWDcjXJVkdAil3CfeJJhyhp1sAbnzHOkXL8H9IGgIhvZIztVzNujBshH9xu1/pTrpJ
	 MIHxrVP6isH0A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BDEF2CE09EE; Mon,  5 Aug 2024 10:04:00 -0700 (PDT)
Date: Mon, 5 Aug 2024 10:04:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: RCU-Task[-Trace] VS EQS (was Re: [PATCH v3 13/25]
 context_tracking, rcu: Rename rcu_dynticks_task*() into rcu_task*())
Message-ID: <aceda0ba-dac3-4adc-bdc0-a2f63338a52e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-14-vschneid@redhat.com>
 <ZqJiDlKtD4wvsv1j@localhost.localdomain>
 <31d78183-4526-41e8-90df-d03c95fdb9b2@paulmck-laptop>
 <ZqlmjVyWXIneklCm@pavilion.home>
 <30c6d4aa-7598-4dc1-8592-7533d64714c2@paulmck-laptop>
 <Zqot4NpepOORtNzv@localhost.localdomain>
 <6c915a8d-983a-4cbb-8d89-01e326a16876@paulmck-laptop>
 <ZrDTDkdq6iJvHDWX@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrDTDkdq6iJvHDWX@localhost.localdomain>

On Mon, Aug 05, 2024 at 03:26:38PM +0200, Frederic Weisbecker wrote:
> Le Fri, Aug 02, 2024 at 09:32:08PM -0700, Paul E. McKenney a écrit :
> > On Wed, Jul 31, 2024 at 02:28:16PM +0200, Frederic Weisbecker wrote:
> > > Le Tue, Jul 30, 2024 at 03:39:44PM -0700, Paul E. McKenney a écrit :
> > > > On Wed, Jul 31, 2024 at 12:17:49AM +0200, Frederic Weisbecker wrote:
> > > > > Le Tue, Jul 30, 2024 at 07:23:58AM -0700, Paul E. McKenney a écrit :
> > > > > > On Thu, Jul 25, 2024 at 04:32:46PM +0200, Frederic Weisbecker wrote:
> > > > > > > Le Wed, Jul 24, 2024 at 04:43:13PM +0200, Valentin Schneider a écrit :
> > > > > > > > -/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
> > > > > > > > -static __always_inline void rcu_dynticks_task_trace_enter(void)
> > > > > > > > +/* Turn on heavyweight RCU tasks trace readers on kernel exit. */
> > > > > > > > +static __always_inline void rcu_task_trace_exit(void)
> > > > > > > 
> > > > > > > Before I proceed on this last one, a few questions for Paul and others:
> > > > > > > 
> > > > > > > 1) Why is rcu_dynticks_task_exit() not called while entering in NMI?
> > > > > > >    Does that mean that NMIs aren't RCU-Task read side critical sections?
> > > > > > 
> > > > > > Because Tasks RCU Rude handles that case currently.  So good catch,
> > > > > > because this might need adjustment when we get rid of Tasks RCU Rude.
> > > > > > And both rcu_dynticks_task_enter() and rcu_dynticks_task_exit() look safe
> > > > > > to invoke from NMI handlers.  Memory ordering needs checking, of course.
> > > > > > 
> > > > > > Except that on architectures defining CONFIG_ARCH_WANTS_NO_INSTR, Tasks
> > > > > > RCU should instead check the ct_kernel_enter_state(RCU_DYNTICKS_IDX)
> > > > > > state, right?  And on those architectures, I believe that
> > > > > > rcu_dynticks_task_enter() and rcu_dynticks_task_exit() can just be no-ops.
> > > > > > Or am I missing something here?
> > > > > 
> > > > > I think rcu_dynticks_task_enter() and rcu_dynticks_task_exit() are
> > > > > still needed anyway because the target task can migrate. So unless the rq is locked,
> > > > > it's hard to match a stable task_cpu() with the corresponding RCU_DYNTICKS_IDX.
> > > > 
> > > > Can it really migrate while in entry/exit or deep idle code?  Or am I
> > > > missing a trick here?
> > > 
> > > No but it can migrate before or after EQS. So we need to handle situations like:
> > > 
> > >  == CPU 0 ==                      == CPU 1 ==
> > >                                   // TASK A is on rq
> > >                                   set_task_cpu(TASK A, 0)
> > > // TASK B runs
> > > ct_user_enter()
> > > ct_user_exit()
> > > 
> > > //TASK A runs
> > > 
> > > 
> > > It could be something like the following:
> > > 
> > > 
> > > int rcu_tasks_nohz_full_holdout(struct task_struct *t)
> > > {
> > > 	int cpu;
> > > 	int snap;
> > > 
> > > 	cpu = task_cpu(t);
> > > 
> > > 	/* Don't miss EQS exit if the task migrated out and in */
> > > 	smp_rmb()
> > > 
> > > 	snap = ct_dynticks_cpu(cpu);
> > > 	if (snap & RCU_DYNTICKS_IDX)
> > > 		return true;
> > > 
> > > 	/* Check if it's the actual task running */
> > > 	smp_rmb()
> > > 
> > > 	if (rcu_dereference_raw(cpu_curr(cpu)) != t)
> > > 		return true;
> > > 
> > > 	/* Make sure the task hasn't migrated in after the above EQS */
> > > 	smp_rmb()
> > > 
> > > 	
> > > 	return ct_dynticks_cpu(cpu) != snap;
> > > }
> > > 
> > > But there is still a risk that ct_dynticks wraps before the last test. So
> > > we would need task_call_func() if task_cpu() is in nohz_full mode.
> > 
> > Good point, migration just before or just after can look much the same
> > as migrating during..
> > 
> > > > > > > 2) Looking further into CONFIG_TASKS_TRACE_RCU_READ_MB=y, it seems to
> > > > > > >    allow for uses of rcu_read_[un]lock_trace() while RCU is not watching
> > > > > > >    (EQS). Is it really a good idea to support that? Are we aware of any
> > > > > > >    such potential usecase?
> > > > > > 
> > > > > > I hope that in the longer term, there will be no reason to support this.
> > > > > > Right now, architectures not defining CONFIG_ARCH_WANTS_NO_INSTR must
> > > > > > support this because tracers really can attach probes where RCU is
> > > > > > not watching.
> > > > > > 
> > > > > > And even now, in architectures defining CONFIG_ARCH_WANTS_NO_INSTR, I
> > > > > > am not convinced that the early incoming and late outgoing CPU-hotplug
> > > > > > paths are handled correctly.  RCU is not watching them, but I am not so
> > > > > > sure that they are all marked noinstr as needed.
> > > > > 
> > > > > Ok I see...
> > > > 
> > > > If need be, the outgoing-CPU transition to RCU-not-watching could be
> > > > delayed into arch-specific code.  We already allow this for the incoming
> > > > transition.
> > > 
> > > That's a lot of scary architectures code to handle :-)
> > > And how do we determine which place is finally safe to stop watching?
> > 
> > Huh.  One reason for the current smp_call_function_single() in
> > cpuhp_report_idle_dead() was some ARM32 CPUs that shut down caching on
> > their way out.  this made it impossible to use shared-variable-based
> > CPU-dead notification.  I wonder if Arnd's deprecation schedule
> > for ARM32-based platforms will allow us to go back to shared-memory
> > notification, which might make this sort of thing easier.
> 
> git blame retrieved that:
> 
> 71f87b2fc64c (cpu/hotplug: Plug death reporting race)
> 
> For the reason why using smp_call_function_single():
> 
>     """
>     We cant call complete after rcu_report_dead(), so instead of going back to
>     busy polling, simply issue a function call to do the completion.
>     """
> 
> This doesn't state exactly why as I don't see obvious use of RCU there. But
> RCU-TASK-TRACE definetly doesn't want to stop watching while complete() is
> called.

With lockdep, the lock acquisition and release in complete_with_flags()
would splat, though this could be handled by using a low-level lock
acquisition and release that didn't mess with lockdep.  With the resulting
risks of missed deadlock detection, of course!

With tracing enabled, there is the trace_sched_waking() within
try_to_wake_up() along with the trace_sched_wakeup() within
ttwu_do_wakeup().  And more beyond that, but I am lazy this morning.  ;-)

> Another thing to consider is that rcutree_migrate_callbacks() may execute
> concurrently with rcutree_report_cpu_dead() otherwise. This might work ok,
> despite the WARN_ON_ONCE(rcu_rdp_cpu_online(rdp)) in
> rcutree_migrate_callbacks(). But that's doesn't make it more a good idea :-)
> 
> As for the reason why calling complete() _after_ rcutree_report_cpu_dead():
> 
>     """
>     Paul noticed that the conversion of the death reporting introduced a race
>     where the outgoing cpu might be delayed after waking the controll processor,
>     so it might not be able to call rcu_report_dead() before being physically
>     removed, leading to RCU stalls.
>     """

There were also ARM32 splats that have aged out of my mental cache.

> I'm lacking details but perhaps the call to __cpu_die() by the control CPU on
> some archs may kill the CPU before it used to reach rcu_report_dead() ? No idea.
> But we need to know if __cpu_die() can kill the CPU before it reaches
> arch_cpu_idle_dead(). If it's not the case, then we can do something like this:
> 
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 24b1e1143260..fb5b866c2fb3 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -31,7 +31,6 @@ DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
>  	.dynticks_nesting = 1,
>  	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
>  #endif
> -	.state = ATOMIC_INIT(RCU_DYNTICKS_IDX),

Don't you still need the initial state for the boot CPU?

>  };
>  EXPORT_SYMBOL_GPL(context_tracking);
>  
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 6e78d071beb5..7ebaf04af37a 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -307,6 +307,7 @@ static void do_idle(void)
>  
>  		if (cpu_is_offline(cpu)) {
>  			cpuhp_report_idle_dead();
> +			ct_state_inc(RCU_DYNTICKS_IDX);
>  			arch_cpu_idle_dead();
>  		}
>  
> This mirrors rcutree_report_cpu_starting() -> rcu_dynticks_eqs_online()
> And then we can make RCU-TASKS not worry about rcu_cpu_online() anymore
> and only care about the context tracking.

For that to work, we need all architectures to be OK for Tasks Rude RCU
being removed, right?  Plus that would make all of arch_cpu_idle_dead()
untraceable.  Is that a good thing?

> The CPU up path looks saner with rcutree_report_cpu_starting() called early
> enough on sane archs... Otherwise it's easy to fix case by case.
> 
> Thoughts?

Not entirly sure yet, but I agree some fix would be good!

							Thanx, Paul
