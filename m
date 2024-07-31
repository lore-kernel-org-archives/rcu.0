Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485718CC1C;
	Wed, 31 Jul 2024 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428899; cv=none; b=l5CkZWBVazU6nF+8tTAkoh1K/JvjZXJzxZJcQlm1iWrw7zxg/m7gWzKKmrNjPp8UXsunZQtA15k9+1v2CPE087hO8uW/cgQ9Nb1Att9wi/j/SQFSm0d+j2e2v9tPjBI1NLfB0ikIlG+W6XFDFYGi3L8hpabbedIGUTi//3AqVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428899; c=relaxed/simple;
	bh=e41QtC3FwXyJ0F1j+sY5OXLnbQYN3h7oBWeSgwGs00w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4zNL8+q9y3nm8EK7Q0pHQrv3rBXHyaTENyhXEMSmYC8V/Py4giqQ3jylfzO9EL0/uKT+9nciAf/Yscyn/F/XX6QMzNoIyDG++P76BEw/GDXxkahvA3JjtLin1gw3rLl4ltaw7AS+3UBhe3ZV9wXWLVBaJQ1qMAPi7hDEh4Du6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa5zbo8V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa5zbo8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBB8C116B1;
	Wed, 31 Jul 2024 12:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722428899;
	bh=e41QtC3FwXyJ0F1j+sY5OXLnbQYN3h7oBWeSgwGs00w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qa5zbo8V4KSnB1pbQOP7lJzfVpBzM9D+OaZSES9vDPpg0zPZmcEFzgmSHAex/l935
	 7bv2GAxxdEdXghh6+uHS2fZzyOOUuUpFdfpDHOSuiRBvHNDyeDmiY0tQCLpPKUH+Tx
	 QgijDl9mSMgaUqi95PZpm+l3SBnlQVeCakLg3BHyfXjE6xwGFuEJKZBENyAoCXKc8X
	 KQFQUv1EXVSp8VpzuKijKi9BAByDDHkkEin7vAV0tPC6I3JHslNpCMkbSRgXE6kZSw
	 st5a4aHwFTOVF6AvfURUGkd0Zb464o+7D4AelbePpvYr4PQ6ulgwYNeiESXlIBCfZy
	 wF7+ULoXEy5bQ==
Date: Wed, 31 Jul 2024 14:28:16 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <Zqot4NpepOORtNzv@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-14-vschneid@redhat.com>
 <ZqJiDlKtD4wvsv1j@localhost.localdomain>
 <31d78183-4526-41e8-90df-d03c95fdb9b2@paulmck-laptop>
 <ZqlmjVyWXIneklCm@pavilion.home>
 <30c6d4aa-7598-4dc1-8592-7533d64714c2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30c6d4aa-7598-4dc1-8592-7533d64714c2@paulmck-laptop>

Le Tue, Jul 30, 2024 at 03:39:44PM -0700, Paul E. McKenney a écrit :
> On Wed, Jul 31, 2024 at 12:17:49AM +0200, Frederic Weisbecker wrote:
> > Le Tue, Jul 30, 2024 at 07:23:58AM -0700, Paul E. McKenney a écrit :
> > > On Thu, Jul 25, 2024 at 04:32:46PM +0200, Frederic Weisbecker wrote:
> > > > Le Wed, Jul 24, 2024 at 04:43:13PM +0200, Valentin Schneider a écrit :
> > > > > -/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
> > > > > -static __always_inline void rcu_dynticks_task_trace_enter(void)
> > > > > +/* Turn on heavyweight RCU tasks trace readers on kernel exit. */
> > > > > +static __always_inline void rcu_task_trace_exit(void)
> > > > 
> > > > Before I proceed on this last one, a few questions for Paul and others:
> > > > 
> > > > 1) Why is rcu_dynticks_task_exit() not called while entering in NMI?
> > > >    Does that mean that NMIs aren't RCU-Task read side critical sections?
> > > 
> > > Because Tasks RCU Rude handles that case currently.  So good catch,
> > > because this might need adjustment when we get rid of Tasks RCU Rude.
> > > And both rcu_dynticks_task_enter() and rcu_dynticks_task_exit() look safe
> > > to invoke from NMI handlers.  Memory ordering needs checking, of course.
> > > 
> > > Except that on architectures defining CONFIG_ARCH_WANTS_NO_INSTR, Tasks
> > > RCU should instead check the ct_kernel_enter_state(RCU_DYNTICKS_IDX)
> > > state, right?  And on those architectures, I believe that
> > > rcu_dynticks_task_enter() and rcu_dynticks_task_exit() can just be no-ops.
> > > Or am I missing something here?
> > 
> > I think rcu_dynticks_task_enter() and rcu_dynticks_task_exit() are
> > still needed anyway because the target task can migrate. So unless the rq is locked,
> > it's hard to match a stable task_cpu() with the corresponding RCU_DYNTICKS_IDX.
> 
> Can it really migrate while in entry/exit or deep idle code?  Or am I
> missing a trick here?

No but it can migrate before or after EQS. So we need to handle situations like:

 == CPU 0 ==                      == CPU 1 ==
                                  // TASK A is on rq
                                  set_task_cpu(TASK A, 0)
// TASK B runs
ct_user_enter()
ct_user_exit()

//TASK A runs


It could be something like the following:


int rcu_tasks_nohz_full_holdout(struct task_struct *t)
{
	int cpu;
	int snap;

	cpu = task_cpu(t);

	/* Don't miss EQS exit if the task migrated out and in */
	smp_rmb()

	snap = ct_dynticks_cpu(cpu);
	if (snap & RCU_DYNTICKS_IDX)
		return true;

	/* Check if it's the actual task running */
	smp_rmb()

	if (rcu_dereference_raw(cpu_curr(cpu)) != t)
		return true;

	/* Make sure the task hasn't migrated in after the above EQS */
	smp_rmb()

	
	return ct_dynticks_cpu(cpu) != snap;
}

But there is still a risk that ct_dynticks wraps before the last test. So
we would need task_call_func() if task_cpu() is in nohz_full mode.

> 
> > > > 2) Looking further into CONFIG_TASKS_TRACE_RCU_READ_MB=y, it seems to
> > > >    allow for uses of rcu_read_[un]lock_trace() while RCU is not watching
> > > >    (EQS). Is it really a good idea to support that? Are we aware of any
> > > >    such potential usecase?
> > > 
> > > I hope that in the longer term, there will be no reason to support this.
> > > Right now, architectures not defining CONFIG_ARCH_WANTS_NO_INSTR must
> > > support this because tracers really can attach probes where RCU is
> > > not watching.
> > > 
> > > And even now, in architectures defining CONFIG_ARCH_WANTS_NO_INSTR, I
> > > am not convinced that the early incoming and late outgoing CPU-hotplug
> > > paths are handled correctly.  RCU is not watching them, but I am not so
> > > sure that they are all marked noinstr as needed.
> > 
> > Ok I see...
> 
> If need be, the outgoing-CPU transition to RCU-not-watching could be
> delayed into arch-specific code.  We already allow this for the incoming
> transition.

That's a lot of scary architectures code to handle :-)
And how do we determine which place is finally safe to stop watching?

Thanks.

> 
> 							Thanx, Paul
