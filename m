Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5DECA40;
	Sat,  3 Aug 2024 04:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659528; cv=none; b=VHDAiahUid00TZRBJ3O64YjWIL9EoAhzpNc5cDxvxOwh0Jpg3RFC+B5+egfaIll7lgux9ebwO1jR+Tugfw3Hbb69HUY/Bk0jPtEMVi2HofqOKIerIc9UtCgA0Yhxi4iba43heRr/I7VKF5pTAEmaM/drd27c/e4SwbXCCDdt+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659528; c=relaxed/simple;
	bh=AMYmJIWBDLuRET0sJCM296xo2XX40//f3XJ2fojhobc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGSWIvsYndp7SwBEBpwg0EYBx7HrKIH2EzRGygAYBjv03Z2cavLrfrhyaC6vRNASo6WYMjMfrcCsuA0mTvzux+KvI0i2GYHioKD+bc34WJQ0Ot18TAV9ZsFjUioWnaGfsGS5DlYKmjkkVoEXwAkt8M0tj5GAw50dex3H032qqx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPbjXkxb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPbjXkxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCDFC116B1;
	Sat,  3 Aug 2024 04:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722659528;
	bh=AMYmJIWBDLuRET0sJCM296xo2XX40//f3XJ2fojhobc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vPbjXkxbaUTpAh6IVPq0ipgwWIe+gKhaPB/fyCWFiCaNag7UkCrLC3jn+BWkGpwS+
	 NViiusqHJ7awStJ2dqHTCErC31Yi9WWJLtLhHigKGagc0IK28TfQIdH1xhuwU1fwls
	 PzZ3Vx3sZnC37kWFNoeG7hbyfkOQMTU4CmgawEfOPxbdsqdoHoZ470YFF+PqiYFSUp
	 2D2+leduBDwsfkww59wueth+rLtbn0LyeJRjpUrOZaMjEHZncZn8GLvhFxhGz1RMDL
	 bz2l0uLPwe1wQfoUSTOkdy5Lwdz2Zqr3B2/JT4WsUOq3Yjp9JruXUEZhE3QXnRSxyC
	 j6vA7/G69IwBQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 094BDCE08FF; Fri,  2 Aug 2024 21:32:08 -0700 (PDT)
Date: Fri, 2 Aug 2024 21:32:08 -0700
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
Message-ID: <6c915a8d-983a-4cbb-8d89-01e326a16876@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-14-vschneid@redhat.com>
 <ZqJiDlKtD4wvsv1j@localhost.localdomain>
 <31d78183-4526-41e8-90df-d03c95fdb9b2@paulmck-laptop>
 <ZqlmjVyWXIneklCm@pavilion.home>
 <30c6d4aa-7598-4dc1-8592-7533d64714c2@paulmck-laptop>
 <Zqot4NpepOORtNzv@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zqot4NpepOORtNzv@localhost.localdomain>

On Wed, Jul 31, 2024 at 02:28:16PM +0200, Frederic Weisbecker wrote:
> Le Tue, Jul 30, 2024 at 03:39:44PM -0700, Paul E. McKenney a écrit :
> > On Wed, Jul 31, 2024 at 12:17:49AM +0200, Frederic Weisbecker wrote:
> > > Le Tue, Jul 30, 2024 at 07:23:58AM -0700, Paul E. McKenney a écrit :
> > > > On Thu, Jul 25, 2024 at 04:32:46PM +0200, Frederic Weisbecker wrote:
> > > > > Le Wed, Jul 24, 2024 at 04:43:13PM +0200, Valentin Schneider a écrit :
> > > > > > -/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
> > > > > > -static __always_inline void rcu_dynticks_task_trace_enter(void)
> > > > > > +/* Turn on heavyweight RCU tasks trace readers on kernel exit. */
> > > > > > +static __always_inline void rcu_task_trace_exit(void)
> > > > > 
> > > > > Before I proceed on this last one, a few questions for Paul and others:
> > > > > 
> > > > > 1) Why is rcu_dynticks_task_exit() not called while entering in NMI?
> > > > >    Does that mean that NMIs aren't RCU-Task read side critical sections?
> > > > 
> > > > Because Tasks RCU Rude handles that case currently.  So good catch,
> > > > because this might need adjustment when we get rid of Tasks RCU Rude.
> > > > And both rcu_dynticks_task_enter() and rcu_dynticks_task_exit() look safe
> > > > to invoke from NMI handlers.  Memory ordering needs checking, of course.
> > > > 
> > > > Except that on architectures defining CONFIG_ARCH_WANTS_NO_INSTR, Tasks
> > > > RCU should instead check the ct_kernel_enter_state(RCU_DYNTICKS_IDX)
> > > > state, right?  And on those architectures, I believe that
> > > > rcu_dynticks_task_enter() and rcu_dynticks_task_exit() can just be no-ops.
> > > > Or am I missing something here?
> > > 
> > > I think rcu_dynticks_task_enter() and rcu_dynticks_task_exit() are
> > > still needed anyway because the target task can migrate. So unless the rq is locked,
> > > it's hard to match a stable task_cpu() with the corresponding RCU_DYNTICKS_IDX.
> > 
> > Can it really migrate while in entry/exit or deep idle code?  Or am I
> > missing a trick here?
> 
> No but it can migrate before or after EQS. So we need to handle situations like:
> 
>  == CPU 0 ==                      == CPU 1 ==
>                                   // TASK A is on rq
>                                   set_task_cpu(TASK A, 0)
> // TASK B runs
> ct_user_enter()
> ct_user_exit()
> 
> //TASK A runs
> 
> 
> It could be something like the following:
> 
> 
> int rcu_tasks_nohz_full_holdout(struct task_struct *t)
> {
> 	int cpu;
> 	int snap;
> 
> 	cpu = task_cpu(t);
> 
> 	/* Don't miss EQS exit if the task migrated out and in */
> 	smp_rmb()
> 
> 	snap = ct_dynticks_cpu(cpu);
> 	if (snap & RCU_DYNTICKS_IDX)
> 		return true;
> 
> 	/* Check if it's the actual task running */
> 	smp_rmb()
> 
> 	if (rcu_dereference_raw(cpu_curr(cpu)) != t)
> 		return true;
> 
> 	/* Make sure the task hasn't migrated in after the above EQS */
> 	smp_rmb()
> 
> 	
> 	return ct_dynticks_cpu(cpu) != snap;
> }
> 
> But there is still a risk that ct_dynticks wraps before the last test. So
> we would need task_call_func() if task_cpu() is in nohz_full mode.

Good point, migration just before or just after can look much the same
as migrating during..

> > > > > 2) Looking further into CONFIG_TASKS_TRACE_RCU_READ_MB=y, it seems to
> > > > >    allow for uses of rcu_read_[un]lock_trace() while RCU is not watching
> > > > >    (EQS). Is it really a good idea to support that? Are we aware of any
> > > > >    such potential usecase?
> > > > 
> > > > I hope that in the longer term, there will be no reason to support this.
> > > > Right now, architectures not defining CONFIG_ARCH_WANTS_NO_INSTR must
> > > > support this because tracers really can attach probes where RCU is
> > > > not watching.
> > > > 
> > > > And even now, in architectures defining CONFIG_ARCH_WANTS_NO_INSTR, I
> > > > am not convinced that the early incoming and late outgoing CPU-hotplug
> > > > paths are handled correctly.  RCU is not watching them, but I am not so
> > > > sure that they are all marked noinstr as needed.
> > > 
> > > Ok I see...
> > 
> > If need be, the outgoing-CPU transition to RCU-not-watching could be
> > delayed into arch-specific code.  We already allow this for the incoming
> > transition.
> 
> That's a lot of scary architectures code to handle :-)
> And how do we determine which place is finally safe to stop watching?

Huh.  One reason for the current smp_call_function_single() in
cpuhp_report_idle_dead() was some ARM32 CPUs that shut down caching on
their way out.  this made it impossible to use shared-variable-based
CPU-dead notification.  I wonder if Arnd's deprecation schedule
for ARM32-based platforms will allow us to go back to shared-memory
notification, which might make this sort of thing easier.

							Thanx, Paul
