Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A32C027E;
	Tue,  6 Jan 2026 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731737; cv=none; b=LB0B9FQevER13g3GH00ckYIndjjIm4GEoQP/svQJo4zeCxXrd8YZU4+8avhb/b/5TNeof9gNF0N5ziCAGT82SeD9QrqqjP7DWcWFuTZPMQwLLMbXZ2ZPdyPTgYKbpoDkoSEUE00vVIBARtKGokOrktAUF6xO+lzDwur+WAIHXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731737; c=relaxed/simple;
	bh=oBEvVE7acfo7b32iDqsvcfR2zHSVw0WsO4qSQom4d1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puALNI9grETrkCNAvwPSIuqtBWN16vV/ICiYngNjwB6vsrbg9JNYuP0fw+JAa+CPsj7iJBgJYP89X+WbA38ZG4bgehOClT+c5hT2tgIgRxSJ9FtQ8k9602ZG0ujfdIInrRYPU6sWkOsqn10UbRCR2tuGBb0x5QKtgz+5cJoFYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7Y2l8pW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7Y2l8pW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BBDC116C6;
	Tue,  6 Jan 2026 20:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767731737;
	bh=oBEvVE7acfo7b32iDqsvcfR2zHSVw0WsO4qSQom4d1c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=W7Y2l8pW6vy+J7xst3AoVX6jm4Y3WObqtU53z4OHgLKtzUc9BA9y7GQLJv461xxIV
	 dhreMbozJxez9EB0Cw6IZfCCymPDzhsEQnuFlqQOAAm6vJ0jhnOhPQgx9vvdg13G32
	 nwhkGJG7PL4U1ZIcoNwJfkhJX/r6TpbQEmW1qC75pFC5gvpLslSo9ka1yot6JLydht
	 /zdhdkl5SK6WURDseyMXtbjt7i0krBdc2jdU+zeSxQMwKDr9AgN4cnPrH7O3qCdgFb
	 LX7RYmgPrLMHuJyCRPPOdqVlA7ucE2xzLvN9RSQWDaMQ10tu01uWeri5t/YDc2HtF4
	 E6qlZ3bh2JcqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A18DCCE0B06; Tue,  6 Jan 2026 12:35:36 -0800 (PST)
Date: Tue, 6 Jan 2026 12:35:36 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org
Subject: Re: [PATCH RFC 00/14] rcu: Reduce rnp->lock contention with per-CPU
 blocked task lists
Message-ID: <7c860b04-5ef4-4ab7-8e73-283b5260b78c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
 <658b114e-b362-47e1-9dc8-9271cbcf2c4d@paulmck-laptop>
 <f679698b-3fc3-4bcc-834a-97c670e6ffe1@joelfernandes.org>
 <9a6016f5-3051-4055-9fd2-05a01c0c9171@paulmck-laptop>
 <20260106151924.7acd74a4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106151924.7acd74a4@gandalf.local.home>

On Tue, Jan 06, 2026 at 03:19:24PM -0500, Steven Rostedt wrote:
> On Tue, 6 Jan 2026 11:17:19 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > Interesting. I might look into the boosting logic to see whether we can avoid
> > > boosting certain tasks depending on whether they help the grace period complete
> > > or not. Thank you for the suggestion.  
> > 
> > Just so you know, all of my simplification efforts thus far have instead
> > made it more complex, but who knows what I might have been missing?
> 
> Maybe you are too smart to make it simple? ;-)

There is the old adage that the complexity of any software artifact
grows to just barely exceed the capabilities of those working on it.  ;-)

But all that aside, getting fresh eyes on it would be a good thing.

> > I could easily believe that the vCPU preemption problem needs to be
> > addressed, but doing so on a per-spinlock basis would lead to greatly
> > increased complexity throughout the kernel, not just RCU.
> 
> Agreed.
> 
> > > > The main point of this patch series is to avoid lock contention due to
> > > > vCPU preemption, correct?  If so, will we need similar work on the other
> > > > locks in the Linux kernel, both within RCU and elsewhere?  I vaguely
> > > > recall your doing some work along those lines a few years back, and
> > > > maybe Thomas Gleixner's deferred-preemption work could help with this.
> > > > Or not, who knows?  Keeping the hypervisor informed of lock state is
> > > > not necessarily free.  
> > > 
> > > Yes, I did some work on this at Google, but it turned out to be a very
> > > fragmented effort in terms of where (which subsystem - KVM, scheduler etc)
> > > should we do the priority boosting of vCPU threads. In the end, we just ended up
> > > with an internal prototype that was not upstreamable but worked pretty well and
> > > only had time for production (a lesson I learned there is we should probably
> > > work on upstream solutions first, but life is not that easy sometimes).  
> > 
> > Which is one reason deferred preemption would be attractive.
> 
> Yes. That's why I've been pushing it.

Very good to hear!

> > > About the deferred-preemption, I believe Steven Rostedt at one point was looking
> > > at that for VMs, but that effort stalled as Peter is concerned about doing that
> > > would mess up the scheduler. The idea (AFAIU) is to use the rseq page to
> > > communicate locking information between vCPU threads and the host and then let
> > > the host avoid vCPU preemption - but the scheduler needs to do something with
> > > that information. Otherwise, it's no use.  
> > 
> > Has deferred preemption for userspace locking also stalled?  If not,
> > then the scheduler's support for userspace should apply directly to
> > guest OSes, right?
> 
> No, the user space deferred preemption is still moving along nicely (I
> believe Thomas has completed most of it). The issue here is that the
> deferred happens before going back to user space. That's a different
> location than going back to the guest. The logic needs to be in that path
> too.

OK, got it, thank you!

> One thing that Peter Zijlstra pushed was the limited amount of time that
> deferred wait may happen. He says user space spinlocks are a bad design,
> but it has been proven for that they are currently the most efficient when
> coming to very short critical sections. That is, where the critical section
> is shorter than the cost of a system call. Thus, he forces the deferred
> scheduling to be at most 50us max (he's also suggested less than that).
> 
> But when it comes to the guest, where kernel spinlocks are user space
> spinlocks, and can be held for more than 50us, I would like a way to have
> the guests defer the scheduling for even longer than user space spin locks.

I would *hope* that the rcu_node ->lock instances are held for less
than 50us!  At least in the absence of SMIs, NMIs, or vCPU preemption on
systems with at least 100MHz core CPU clock frequency.  Besides, SMIs,
NMIs, vCPU preemption affect userspace locks, as do IRQs and softirqs.

Of course, hope springs eternal...

							Thanx, Paul
