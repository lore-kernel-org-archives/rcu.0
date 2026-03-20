Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6BB192B90
	for <rcu@vger.kernel.org>; Fri, 20 Mar 2026 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025844; cv=none; b=uwS4/Oe6myCZ/YM2PDZlh9gFRilrzYV0f5+6QspzGqTvnj32WzWUhBwJO1P7S63JEdWjaC9/2LC2Ci2ucF1eKXFMf5bnMeMc5beNKz4CxbJ9FOP1Xb7r1Q+f6cwtmuGNgdAJxpFvasY+rS8mL8ZyNo49xUx7hCJujCjiv1JtcQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025844; c=relaxed/simple;
	bh=LySU7ge2y1wNx3ACPnF021ssd8zn8roMZ8T14nCKIRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQNg84awpbjFYJXIgOtSpg2S+xFRTcXsaPvh68Dt+uqY9CREYq5g1Dl+2jR634mUUVEu7BPUQUXNgIRSOgIKQnIOTYf7TXknI2jQDfMimw+5pBviOFSVAHkgG6qidQb1OkEzyINDVLpm8W/C1FZQsTcvD/TWP3U2zJmMBYl34/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShN2/QI4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShN2/QI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E25C4AF0B;
	Fri, 20 Mar 2026 16:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774025844;
	bh=LySU7ge2y1wNx3ACPnF021ssd8zn8roMZ8T14nCKIRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShN2/QI4WiU8vhvR0i0KuHZfDZI+tQskxnNFRV95mB9y2coNgULfQMYwJ0m1+b3Pe
	 M6qQbY6hak6IJF7q+MQgHOCSMV8oVvafUQpBfQbGdDTcyNKRQibN7plVSO46YDkswI
	 qY58vyubtkAd37309xmIkrOzKRVYZpkiVx3VvFMNGJXQqisPAJbQJBibo8pXsmfS4S
	 AJ/ovYP9O0eBSKb+vfFgzIZJKPqOtSOsSm935xHTm3ObH9h+bFFRJEwVyhhYftHJY4
	 2/d4ahqWwWodJxswVL1UHhVnAC70bnumCet+4OyO3Ovuljn2L6/ZZrfkiqWMZ7aoQ8
	 V4qMFUmICiPdA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id C88B9F40069;
	Fri, 20 Mar 2026 12:57:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 12:57:22 -0400
X-ME-Sender: <xms:cny9aZxDKdARRZb5--LG7xW8TccR3LCNXT9LflVbgY871-EiXc9Lvw>
    <xme:cny9aToGVdf-ak4Kqq8P1u3skkxTXIoFtUY-awC1neQncFcQjZwY8B2Dyi32-G4t-
    IVN5rCfpkbDs5WUvjK4EEBv2MhIK_m_3A_hbxH5y5milKusynaP>
X-ME-Received: <xmr:cny9aZdiCsnMnuPhX-f9OTxU6i8uBZGrrrHNsOfgrMt7ffcLHIZ6K_jYs7Dnv98M9jgbGPtM-3F5rGk0No4FmFfIBDSt2vfH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    euieeileeffeeuhfelgeevjeeltdejveethffhteffvdekuefhgfffhfeugefhudenucff
    ohhmrghinhepsghoohhtlhhinhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdduieejtdelkeegjeduqddujeejkeehheehvddqsghoqhhunheppehkvg
    hrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphht
    thhopehmvghmgihorhesghhmrghilhdrtghomhdprhgtphhtthhopegsihhgvggrshihse
    hlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdrihhithhruddtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsgho
    qhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgtuhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cny9aWrImt4bEpJxAibTkA1_hQ2JPwzedwg-ZqEHcq3NaKzXczmzfw>
    <xmx:cny9aTmW2RnKbTl3LYMp6-tZQcvTqOqLJZDWcB__MDbPBh1ta3U8eg>
    <xmx:cny9aXSf0pxNEFeyYhQE2M4QuBdpN443dfX3oUtAIHua0p9Soljw3w>
    <xmx:cny9aZaMw_hgbYrdGwcjFMPDq_AuKHqIa1KR0whuKslF7uentytzlg>
    <xmx:cny9aX9va6BcamvcAm58vQpN8p48K2DFPRD-9eJOjpM5x6TzEYVuzNE5>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 12:57:22 -0400 (EDT)
Date: Fri, 20 Mar 2026 09:57:21 -0700
From: Boqun Feng <boqun@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <ab18cUI_4jKA8wcA@tardis.local>
References: <abwo0I_mu94t5Ews@tardis.local>
 <CAP01T75J4EXu8MFD2WEQ71Ou-bapqS=_wXFFQJ6Ed62X28HO2A@mail.gmail.com>
 <abwyGtG7hDpd8vBN@tardis.local>
 <CAP01T75S-NMgB=s_0jqq52xRwe1cQ29DzD33eeqUZHM3cSb=oA@mail.gmail.com>
 <abxZEE4SAMkNEleq@tardis.local>
 <89763fcd-3710-49a0-91ca-cd923b47fc1e@nvidia.com>
 <abxfBZ89wIJILuom@tardis.local>
 <c391f8b9-a168-4235-aa7b-6902b4f07002@paulmck-laptop>
 <ab1u-AuqIbJakUYW@tardis.local>
 <2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop>

On Fri, Mar 20, 2026 at 09:24:15AM -0700, Paul E. McKenney wrote:
[...]
> > > > In an alternative universe, BPF has a defer mechanism, and BPF core
> > > > would just call (for example):
> > > > 
> > > >     bpf_defer(call_srcu, ...); // <- a lockless defer
> > > > 
> > > > so the issue won't happen.
> > > 
> > > In theory, this is quite true.
> > > 
> > > In practice, unfortunately for keeping this part of RCU as simple as
> > > we might wish, when a BPF program gets attached to some function in
> > > the kernel, it does not know whether or not that function holds a given
> > > scheduler lock.  For example, there are any number of utility functions
> > > that can be (and are) called both with and without those scheduler
> > > locks held.  Worse yet, it might be attached to a function that is
> > > *never* invoked with a scheduler lock held -- until some out-of-tree
> > > module is loaded.  Which means that this module might well be loaded
> > > after BPF has JIT-ed the BPF program.
> > > 
> > 
> > Hmm.. maybe I failed to make myself more clear. I was suggesting we
> > treat BPF as a special context, and you cannot do everything, if there
> > is any call_srcu() needed, switch it to bpf_defer(). We should have the
> > same result as either 1) call_srcu() locklessly defer itself or 2) a
> > call_srcu_lockless().
> > 
> > Certainly we can call_srcu() do locklessly defer, but if it's only for
> > BPF, that looks like a whack-a-mole approach to me. Say later on we want
> > to use call_hazptr() in BPF for some reason (there is hoping!), then we
> > need to make it locklessly defer as well. Now we have two lockless logic
> > in both call_srcu() and call_hazptr(), if there is a third one, we need
> > to do that as well. So where's the end?
> 
> Except that by the same line of reasoning, how do the BPF guys figure out
> exactly which function calls they need to defer and under what conditions
> they need to defer them?  Keeping in mind that the list of functions and

Can't they just defer anything that is deferrable? If it's deferrable,
then what's the actual cost for BPF to defer it?

> corresponding conditions is subject to change as the kernel continues
> to change.
> 
> > The lockless defer request comes from BPF being special, a proper way to
> > deal with it IMO would be BPF has a general defer mechanism. Whether
> > call_srcu() or call_srcu_lockless() can do lockless defer is
> > orthogonal.
> 
> Fair point, and for the general defer mechanism, I hereby nominate
> the irq_work_queue() function.  We can use this both for RCU and
> for hazard pointers.  The code to make a call_srcu_lockless() and
> call_hazptr_lockless() that includes the relevant checks and that does
> the deferral will not be large, complex, or slow.  Especially assuming
> that we consolidate common checks.
> 
> > BTW, an example to my point, I think we have a deadlock even with the
> > old call_rcu_tasks_trace(), because at:
> > 
> > https://elixir.bootlin.com/linux/v6.19.8/source/kernel/rcu/tasks.h#L384
> > 
> > We do a:
> > 
> > 	mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
> > 
> > which means call_rcu_tasks_trace() may acquire timer base lock, and that
> > means if BPF was to trace a point where timer base lock is held, then we
> > may have a deadlock. So Now I wonder whether you had any magic to avoid
> > the deadlock pre-7.0 or we are just lucky ;-)
> 
> Test it and see!  ;-)
> 

"Program testing can be used to show the presence of bugs, but never to
show their absence!" ;-)

> > See, without a general defer mechanism, we will have a lot of fun
> > auditing all the primitives that BPF may use.
> 
> No, *we* only audit the primitives in our subsystem that BPF actually
> uses when BPF starts using them.  We let the *other* subsystems worry
> about *their* interactions with BPF.
> 

As an RCU mainatainer: fine

As a LOCKING maintainer: shake my head, because for every primitive that
BPF uses, now there could be a normal version and a _bpf/lockless()
version. That could create more maintenance issues, but only time can
tell.

> > > So we really do need to make some variant of call_srcu() that deals
> > > with this.
> > > 
> > > We do have some options.  First, we could make call_srcu() deal with it
> > > directly, or second, we could create something like call_srcu_lockless()
> > > or call_srcu_nolock() or whatever that can safely be invoked from any
> > > context, including NMI handlers, and that invokes call_srcu() directly
> > > when it determines that it is safe to do so.  The advantage of the second
> > > approach is that it avoids incurring the overhead of checking in the
> > > common case.
> > 
> > Within the RCU scope, I prefer the second option.
> 
> Works for me!
> 
> Would you guys like to implement this, or would you prefer that I do so?
> 

I feel I don't have cycles for it soon, I have a big backlog (including
making preempt_count 64bit on 64bit x86). But I will send the fix in the
current call_srcu() for v7.0 and work with Joel to get into Linus' tree.

I will definitely review it if you beat me to it ;-)

Regards,
Boqun

> 							Thanx, Paul
> 
> > Regards,
> > Boqun
> > 
[..]
