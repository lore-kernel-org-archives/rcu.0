Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8F18DF9D;
	Tue, 30 Jul 2024 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379185; cv=none; b=u2W6JRrEl0Q5NPsA0FzJP0XKqlog9BNQY8ivTxNc90/4/lYD7LoUY2zIRhGuRNjDD185D5/t52vxP8JJ/GEWiNu570s32bQsjidZs/E/7JRyg688k0MAX7n+tqY8NdWyTDjHgrWkvIHY924vFQviVrNH8CqFkkcP0mrNt6otF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379185; c=relaxed/simple;
	bh=rtuFGI9jAe9/Raa5wEA4SM4Wq3tXO1YX1GDI7wdpApA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBMTYLTRGLRmvzASVL3x470jBCbnOWAzpnwOC6lsfSoI+VtzC/Hej1lnhWAYAZ2Cg/cj1oTwhEHjrXYGmPl7zwh2ONUiS687+hEC5WcwaEJ+2dcbGAbPv7So3EG7zolNX7WEb1yP5V1EjX+U7bzd+XP0pLHBxeb33ZUU9tyf2io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kuuv4gBS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kuuv4gBS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA1AC32782;
	Tue, 30 Jul 2024 22:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722379185;
	bh=rtuFGI9jAe9/Raa5wEA4SM4Wq3tXO1YX1GDI7wdpApA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Kuuv4gBSULAP6CRw/beCkkN0jcplY6SVlH4GzyKcM6aj8wBqbd+HDhohPa85uvf1b
	 ewRQAPLBHJVvzbUDVfUPdH/+ClBjyfklgIvN6C93r9abiWNDXjuv9saJegVRuLB1o2
	 BqrkhatJ+BDLwrULqMV/XR2BsCacpvvMZu8sshIfB1ZOQNF7GegoLkrWasR7ilc2jL
	 GWDhOOoTbvRt5fiAY5lPexOexVG6ON1grfxQZsE7YEmsGneLWBkoNkso7A4Cq4Cxn9
	 Y7sstDuN3jB4qJeznIBo0F4Hj/INNvl3BdQ2urCbnx3Wy4xb1gt7kCfY5vOl2SmKNz
	 aXaQ8jOANEo/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A2F4ACE0A63; Tue, 30 Jul 2024 15:39:44 -0700 (PDT)
Date: Tue, 30 Jul 2024 15:39:44 -0700
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
Message-ID: <30c6d4aa-7598-4dc1-8592-7533d64714c2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-14-vschneid@redhat.com>
 <ZqJiDlKtD4wvsv1j@localhost.localdomain>
 <31d78183-4526-41e8-90df-d03c95fdb9b2@paulmck-laptop>
 <ZqlmjVyWXIneklCm@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqlmjVyWXIneklCm@pavilion.home>

On Wed, Jul 31, 2024 at 12:17:49AM +0200, Frederic Weisbecker wrote:
> Le Tue, Jul 30, 2024 at 07:23:58AM -0700, Paul E. McKenney a écrit :
> > On Thu, Jul 25, 2024 at 04:32:46PM +0200, Frederic Weisbecker wrote:
> > > Le Wed, Jul 24, 2024 at 04:43:13PM +0200, Valentin Schneider a écrit :
> > > > -/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
> > > > -static __always_inline void rcu_dynticks_task_trace_enter(void)
> > > > +/* Turn on heavyweight RCU tasks trace readers on kernel exit. */
> > > > +static __always_inline void rcu_task_trace_exit(void)
> > > 
> > > Before I proceed on this last one, a few questions for Paul and others:
> > > 
> > > 1) Why is rcu_dynticks_task_exit() not called while entering in NMI?
> > >    Does that mean that NMIs aren't RCU-Task read side critical sections?
> > 
> > Because Tasks RCU Rude handles that case currently.  So good catch,
> > because this might need adjustment when we get rid of Tasks RCU Rude.
> > And both rcu_dynticks_task_enter() and rcu_dynticks_task_exit() look safe
> > to invoke from NMI handlers.  Memory ordering needs checking, of course.
> > 
> > Except that on architectures defining CONFIG_ARCH_WANTS_NO_INSTR, Tasks
> > RCU should instead check the ct_kernel_enter_state(RCU_DYNTICKS_IDX)
> > state, right?  And on those architectures, I believe that
> > rcu_dynticks_task_enter() and rcu_dynticks_task_exit() can just be no-ops.
> > Or am I missing something here?
> 
> I think rcu_dynticks_task_enter() and rcu_dynticks_task_exit() are
> still needed anyway because the target task can migrate. So unless the rq is locked,
> it's hard to match a stable task_cpu() with the corresponding RCU_DYNTICKS_IDX.

Can it really migrate while in entry/exit or deep idle code?  Or am I
missing a trick here?

> > > 2) Looking further into CONFIG_TASKS_TRACE_RCU_READ_MB=y, it seems to
> > >    allow for uses of rcu_read_[un]lock_trace() while RCU is not watching
> > >    (EQS). Is it really a good idea to support that? Are we aware of any
> > >    such potential usecase?
> > 
> > I hope that in the longer term, there will be no reason to support this.
> > Right now, architectures not defining CONFIG_ARCH_WANTS_NO_INSTR must
> > support this because tracers really can attach probes where RCU is
> > not watching.
> > 
> > And even now, in architectures defining CONFIG_ARCH_WANTS_NO_INSTR, I
> > am not convinced that the early incoming and late outgoing CPU-hotplug
> > paths are handled correctly.  RCU is not watching them, but I am not so
> > sure that they are all marked noinstr as needed.
> 
> Ok I see...

If need be, the outgoing-CPU transition to RCU-not-watching could be
delayed into arch-specific code.  We already allow this for the incoming
transition.

							Thanx, Paul
