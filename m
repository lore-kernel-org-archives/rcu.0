Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A0F157466;
	Tue, 30 Jul 2024 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722377873; cv=none; b=j7O3TEwGdZ6izpHr+0P5bQdMUaKVAkiAEr0AEEYUPDOqBvcylystv4xR1UAhAFs4XO/ANxPo/0SDMkrHTpjlRSHfcZh+hWXqlgR5SjQ7rXpgCkaB8vGjeql1lXltgC2qTtdQcewhBGEaHE5IrhJ4m2fV2ULY48eyMMayim124xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722377873; c=relaxed/simple;
	bh=YybkcUYxUqpqpli8HO6mbkTLp9GQFuDUuGBq2RcnVow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrW+CciKP46VmfePiOyEO1ouUGeqS3Cvfw5pmb6ST1SHPZyKLGjRz7wFfl9bv3CmlvETor+mH20uifT8ReH0EIjLwsfsDmkzFkRKyQQq3m6ROlM5AVujUsVqSbx1AoIlWhG2pOFjXSnIIeysPCY7hEs40U2h3GMSSB6+/msCwy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3MFS7ln; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3MFS7ln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C1AC32782;
	Tue, 30 Jul 2024 22:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722377872;
	bh=YybkcUYxUqpqpli8HO6mbkTLp9GQFuDUuGBq2RcnVow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3MFS7ln8pjCp1q+JHfKsxFSSUcvu3lpDofyDgXqUJJ0DJCFrWakWPrPXurSiCO8e
	 qU5jMZKcY3+njjH9+OyvZBQ/mN5bVMNnOKUTzJGR/ufTfNKXWZdnCI9woPvoD1j8fZ
	 ATuAIqBDKswoVEzPXdBi9kM1TQ7KHq3ZvfhoRhPO3XURTwNlMtHrZgsiKpeDHyZuSY
	 fanRrpj34F/ZoBvYoULlc8QlKc81ZJJbHtGdH31ovYO9emF/OzBVU3YI8tTyivNGWV
	 lZnFt4F5w29JJgs5A2H+6JXxwjvhFjzaDQWYYCG7Q8oPD6d1A49QZS6+De/XYxkzB4
	 dmkmZVsqI6lCQ==
Date: Wed, 31 Jul 2024 00:17:49 +0200
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
Message-ID: <ZqlmjVyWXIneklCm@pavilion.home>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-14-vschneid@redhat.com>
 <ZqJiDlKtD4wvsv1j@localhost.localdomain>
 <31d78183-4526-41e8-90df-d03c95fdb9b2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31d78183-4526-41e8-90df-d03c95fdb9b2@paulmck-laptop>

Le Tue, Jul 30, 2024 at 07:23:58AM -0700, Paul E. McKenney a écrit :
> On Thu, Jul 25, 2024 at 04:32:46PM +0200, Frederic Weisbecker wrote:
> > Le Wed, Jul 24, 2024 at 04:43:13PM +0200, Valentin Schneider a écrit :
> > > -/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
> > > -static __always_inline void rcu_dynticks_task_trace_enter(void)
> > > +/* Turn on heavyweight RCU tasks trace readers on kernel exit. */
> > > +static __always_inline void rcu_task_trace_exit(void)
> > 
> > Before I proceed on this last one, a few questions for Paul and others:
> > 
> > 1) Why is rcu_dynticks_task_exit() not called while entering in NMI?
> >    Does that mean that NMIs aren't RCU-Task read side critical sections?
> 
> Because Tasks RCU Rude handles that case currently.  So good catch,
> because this might need adjustment when we get rid of Tasks RCU Rude.
> And both rcu_dynticks_task_enter() and rcu_dynticks_task_exit() look safe
> to invoke from NMI handlers.  Memory ordering needs checking, of course.
> 
> Except that on architectures defining CONFIG_ARCH_WANTS_NO_INSTR, Tasks
> RCU should instead check the ct_kernel_enter_state(RCU_DYNTICKS_IDX)
> state, right?  And on those architectures, I believe that
> rcu_dynticks_task_enter() and rcu_dynticks_task_exit() can just be no-ops.
> Or am I missing something here?

I think rcu_dynticks_task_enter() and rcu_dynticks_task_exit() are
still needed anyway because the target task can migrate. So unless the rq is locked,
it's hard to match a stable task_cpu() with the corresponding RCU_DYNTICKS_IDX.

> 
> > 2) Looking further into CONFIG_TASKS_TRACE_RCU_READ_MB=y, it seems to
> >    allow for uses of rcu_read_[un]lock_trace() while RCU is not watching
> >    (EQS). Is it really a good idea to support that? Are we aware of any
> >    such potential usecase?
> 
> I hope that in the longer term, there will be no reason to support this.
> Right now, architectures not defining CONFIG_ARCH_WANTS_NO_INSTR must
> support this because tracers really can attach probes where RCU is
> not watching.
> 
> And even now, in architectures defining CONFIG_ARCH_WANTS_NO_INSTR, I
> am not convinced that the early incoming and late outgoing CPU-hotplug
> paths are handled correctly.  RCU is not watching them, but I am not so
> sure that they are all marked noinstr as needed.

Ok I see...

Thanks.
