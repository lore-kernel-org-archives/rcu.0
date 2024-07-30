Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C297522F;
	Tue, 30 Jul 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349439; cv=none; b=OE700b0ZjmmAqqgRBXBVu9T4iGn8bqvF/Oz69hgksMOzMy2xJvRkknANHfNNMghgY9Uej4PGmIRsD1AzYwnJoVCCBt0rEV0w8UB0AAfwhQ9X+1iA+5A/oFZ9+5xOpJqYgKAjfPQawtQ9dZOVuW6qXoII3RCvyzcUrhKQfSyICF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349439; c=relaxed/simple;
	bh=yXTdmiqhqSyA6hk/tzqo8mOnHyDRZ70HsdeDKBmvZkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfNFOVjc37TJXka2NyFWrLRsIq5vNVRfX/2vAWOPnLDx/wcJrMAjRrdf3tz7p8K2HLV5cW8p5rnT0DtmRl32kOj0ebXlt0/shjyOD+v3KtsK27Q+v3gn3aVRH83p6U451ItDLSXmDtaFUU7n5rbQFhRW2aYTK3gi8wC7XLTuD3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+6XWx9J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+6XWx9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527F9C32782;
	Tue, 30 Jul 2024 14:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722349439;
	bh=yXTdmiqhqSyA6hk/tzqo8mOnHyDRZ70HsdeDKBmvZkU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=f+6XWx9J+eH+PT/X6Ky5wJ1dG8rPcLn5Wo3hO7zTfBrIAKtZNAfoBPpANCzi8l2cv
	 qYlwQrtGLfWnyxjU7Cu85w6taE5+4ydcATh+Gs7T6sPU1hDXAmuw+Yr+smjwqNgbrg
	 4aZzU0/LK4dU9Sv168HTbk8b4i8HUd//eeWQSFQNBVRJ+852n+h4Akbh+wYxEqAObX
	 qiS+ZqAOjQ2J21pPuxYV+6EymbC6uDhjBxm/a2agIu13NvZaihkmeLXsht9AVJa0Go
	 bC76H+iIe48bMqvSOwTqCAiuXUJigJlvuU74ySrKSeoM0qaiN6o0VOxGf5hlZmXaaD
	 vAvdjuJWCHDEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F0BFDCE0EA6; Tue, 30 Jul 2024 07:23:58 -0700 (PDT)
Date: Tue, 30 Jul 2024 07:23:58 -0700
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
Message-ID: <31d78183-4526-41e8-90df-d03c95fdb9b2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-14-vschneid@redhat.com>
 <ZqJiDlKtD4wvsv1j@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqJiDlKtD4wvsv1j@localhost.localdomain>

On Thu, Jul 25, 2024 at 04:32:46PM +0200, Frederic Weisbecker wrote:
> Le Wed, Jul 24, 2024 at 04:43:13PM +0200, Valentin Schneider a écrit :
> > -/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
> > -static __always_inline void rcu_dynticks_task_trace_enter(void)
> > +/* Turn on heavyweight RCU tasks trace readers on kernel exit. */
> > +static __always_inline void rcu_task_trace_exit(void)
> 
> Before I proceed on this last one, a few questions for Paul and others:
> 
> 1) Why is rcu_dynticks_task_exit() not called while entering in NMI?
>    Does that mean that NMIs aren't RCU-Task read side critical sections?

Because Tasks RCU Rude handles that case currently.  So good catch,
because this might need adjustment when we get rid of Tasks RCU Rude.
And both rcu_dynticks_task_enter() and rcu_dynticks_task_exit() look safe
to invoke from NMI handlers.  Memory ordering needs checking, of course.

Except that on architectures defining CONFIG_ARCH_WANTS_NO_INSTR, Tasks
RCU should instead check the ct_kernel_enter_state(RCU_DYNTICKS_IDX)
state, right?  And on those architectures, I believe that
rcu_dynticks_task_enter() and rcu_dynticks_task_exit() can just be no-ops.
Or am I missing something here?

> 2) Looking further into CONFIG_TASKS_TRACE_RCU_READ_MB=y, it seems to
>    allow for uses of rcu_read_[un]lock_trace() while RCU is not watching
>    (EQS). Is it really a good idea to support that? Are we aware of any
>    such potential usecase?

I hope that in the longer term, there will be no reason to support this.
Right now, architectures not defining CONFIG_ARCH_WANTS_NO_INSTR must
support this because tracers really can attach probes where RCU is
not watching.

And even now, in architectures defining CONFIG_ARCH_WANTS_NO_INSTR, I
am not convinced that the early incoming and late outgoing CPU-hotplug
paths are handled correctly.  RCU is not watching them, but I am not so
sure that they are all marked noinstr as needed.

Or am I missing some implicit reason why this all works?

							Thanx, Paul
