Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACF837F007;
	Fri, 20 Mar 2026 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774048289; cv=none; b=YyZshuXqQC8SWHQUw18TfdnwK1833skEq3gFVg7UG5uU8s+T5tpOgIDq4U+h9cRIOKXWZJ6ZzK7ZQRaMm3F07HziV8pGuuGNo90qwLsrXvSQW0qhf5ioOsgUDCBTqVzUn2yFkLUUaKtc0tcPB7SIQTAWMo6JJkFPJIl7KZRibSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774048289; c=relaxed/simple;
	bh=mL+PTM17dcwPcA8AYWODxL65EaqjULT2cGblxQzD7ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHUhTAneAftAspDDnXRT7awAoPuiDKHMmGtFevzfhMkq3DHwY9afMT5Vj+xGmw7bBCsdd1IT9bMR8mov2d4cv5EBRy2brCTH6fbuFjswjF65PuHzh8yoNLrDWpz5MDtc7BvxSOV3ymPxq/A9OgdVjs6DjrlcRR4JzG5BjhuHhRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR9pprAS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR9pprAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D158C4CEF7;
	Fri, 20 Mar 2026 23:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774048289;
	bh=mL+PTM17dcwPcA8AYWODxL65EaqjULT2cGblxQzD7ME=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CR9pprASKvixgG7XKaZm8e2KO/yAMnVC2zaC/c4DgHcLOkdajE3UTQ3XoAfFYDn6q
	 3XLp9uCQRMRg4GNwkQfqTm6HHJ0Vm0JZARGEgMSBHuxb/Yva0G9F8dnJNQ8vJC+uua
	 Eb8HgkFJQ9+ezsVYLp5f3qbKx8FVzgEtPgmKuXEBkIrcWkJvZDNKGG5ASviakmseDE
	 dHkqxTIJ0XeVjOOKUPBuGmYNa7oszzbvN7nK5OUmu70SlGzpCL6QSh+kPjnsUgxpZt
	 BGxRd/8OkHbsVYU2VQTLbVMMTnpkQVbQg+D6zcm2EwaxigpumH6iFDpC3Q32NEKAeQ
	 aVq6LvsMX+47Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DF519CE0AB1; Fri, 20 Mar 2026 16:11:26 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:11:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <64a29c44-395a-4199-b580-5bfca715a816@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAP01T75J4EXu8MFD2WEQ71Ou-bapqS=_wXFFQJ6Ed62X28HO2A@mail.gmail.com>
 <abwyGtG7hDpd8vBN@tardis.local>
 <CAP01T75S-NMgB=s_0jqq52xRwe1cQ29DzD33eeqUZHM3cSb=oA@mail.gmail.com>
 <abxZEE4SAMkNEleq@tardis.local>
 <89763fcd-3710-49a0-91ca-cd923b47fc1e@nvidia.com>
 <abxfBZ89wIJILuom@tardis.local>
 <c391f8b9-a168-4235-aa7b-6902b4f07002@paulmck-laptop>
 <ab1u-AuqIbJakUYW@tardis.local>
 <2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop>
 <ab18cUI_4jKA8wcA@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab18cUI_4jKA8wcA@tardis.local>

On Fri, Mar 20, 2026 at 09:57:21AM -0700, Boqun Feng wrote:
> On Fri, Mar 20, 2026 at 09:24:15AM -0700, Paul E. McKenney wrote:
> [...]
> > > > > In an alternative universe, BPF has a defer mechanism, and BPF core
> > > > > would just call (for example):
> > > > > 
> > > > >     bpf_defer(call_srcu, ...); // <- a lockless defer
> > > > > 
> > > > > so the issue won't happen.
> > > > 
> > > > In theory, this is quite true.
> > > > 
> > > > In practice, unfortunately for keeping this part of RCU as simple as
> > > > we might wish, when a BPF program gets attached to some function in
> > > > the kernel, it does not know whether or not that function holds a given
> > > > scheduler lock.  For example, there are any number of utility functions
> > > > that can be (and are) called both with and without those scheduler
> > > > locks held.  Worse yet, it might be attached to a function that is
> > > > *never* invoked with a scheduler lock held -- until some out-of-tree
> > > > module is loaded.  Which means that this module might well be loaded
> > > > after BPF has JIT-ed the BPF program.
> > > > 
> > > 
> > > Hmm.. maybe I failed to make myself more clear. I was suggesting we
> > > treat BPF as a special context, and you cannot do everything, if there
> > > is any call_srcu() needed, switch it to bpf_defer(). We should have the
> > > same result as either 1) call_srcu() locklessly defer itself or 2) a
> > > call_srcu_lockless().
> > > 
> > > Certainly we can call_srcu() do locklessly defer, but if it's only for
> > > BPF, that looks like a whack-a-mole approach to me. Say later on we want
> > > to use call_hazptr() in BPF for some reason (there is hoping!), then we
> > > need to make it locklessly defer as well. Now we have two lockless logic
> > > in both call_srcu() and call_hazptr(), if there is a third one, we need
> > > to do that as well. So where's the end?
> > 
> > Except that by the same line of reasoning, how do the BPF guys figure out
> > exactly which function calls they need to defer and under what conditions
> > they need to defer them?  Keeping in mind that the list of functions and
> 
> Can't they just defer anything that is deferrable? If it's deferrable,
> then what's the actual cost for BPF to defer it?

I believe that there are overhead issues with unconditional deferral,
but I must defer to the BPF guys.

> > corresponding conditions is subject to change as the kernel continues
> > to change.
> > 
> > > The lockless defer request comes from BPF being special, a proper way to
> > > deal with it IMO would be BPF has a general defer mechanism. Whether
> > > call_srcu() or call_srcu_lockless() can do lockless defer is
> > > orthogonal.
> > 
> > Fair point, and for the general defer mechanism, I hereby nominate
> > the irq_work_queue() function.  We can use this both for RCU and
> > for hazard pointers.  The code to make a call_srcu_lockless() and
> > call_hazptr_lockless() that includes the relevant checks and that does
> > the deferral will not be large, complex, or slow.  Especially assuming
> > that we consolidate common checks.
> > 
> > > BTW, an example to my point, I think we have a deadlock even with the
> > > old call_rcu_tasks_trace(), because at:
> > > 
> > > https://elixir.bootlin.com/linux/v6.19.8/source/kernel/rcu/tasks.h#L384
> > > 
> > > We do a:
> > > 
> > > 	mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
> > > 
> > > which means call_rcu_tasks_trace() may acquire timer base lock, and that
> > > means if BPF was to trace a point where timer base lock is held, then we
> > > may have a deadlock. So Now I wonder whether you had any magic to avoid
> > > the deadlock pre-7.0 or we are just lucky ;-)
> > 
> > Test it and see!  ;-)
> 
> "Program testing can be used to show the presence of bugs, but never to
> show their absence!" ;-)

But with the exceptions of trivial programs, and I assert that the Linux
kernel is non-trivial, there will always be bugs.  We therefore need
not concern ourselves with showing their absence.  ;-)

> > > See, without a general defer mechanism, we will have a lot of fun
> > > auditing all the primitives that BPF may use.
> > 
> > No, *we* only audit the primitives in our subsystem that BPF actually
> > uses when BPF starts using them.  We let the *other* subsystems worry
> > about *their* interactions with BPF.
> 
> As an RCU mainatainer: fine
> 
> As a LOCKING maintainer: shake my head, because for every primitive that
> BPF uses, now there could be a normal version and a _bpf/lockless()
> version. That could create more maintenance issues, but only time can
> tell.

One might be surprised by no-lock locking primitives, but you are right
that there is always trylock and release.

> > > > So we really do need to make some variant of call_srcu() that deals
> > > > with this.
> > > > 
> > > > We do have some options.  First, we could make call_srcu() deal with it
> > > > directly, or second, we could create something like call_srcu_lockless()
> > > > or call_srcu_nolock() or whatever that can safely be invoked from any
> > > > context, including NMI handlers, and that invokes call_srcu() directly
> > > > when it determines that it is safe to do so.  The advantage of the second
> > > > approach is that it avoids incurring the overhead of checking in the
> > > > common case.
> > > 
> > > Within the RCU scope, I prefer the second option.
> > 
> > Works for me!
> > 
> > Would you guys like to implement this, or would you prefer that I do so?
> 
> I feel I don't have cycles for it soon, I have a big backlog (including
> making preempt_count 64bit on 64bit x86). But I will send the fix in the
> current call_srcu() for v7.0 and work with Joel to get into Linus' tree.
> 
> I will definitely review it if you beat me to it ;-)

I am sure that further adjustments will be required.  ;-)

							Thanx, Paul
