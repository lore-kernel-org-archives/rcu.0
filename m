Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FABC296BA8;
	Tue,  6 Jan 2026 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767730748; cv=none; b=CTvZCteIbT/1vvQS+uoAihrr4sMVpoZm20MIWiO1cEoB4oYm54LF6Fb6mI7pqwfCjRAvPc2lyC8X1luZxNlG/45vaNHLpoXteFo3PfMTQC43o0sA7TAX2mnGqxg5zvMWlTicHBTR1mCyX2Ha5uUZe6fCMgvIYNqFvqO4oxlCqAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767730748; c=relaxed/simple;
	bh=oXjqIg2xcXGp1OC0JSd/26NAYsasnqvVW4zzQdNqz3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGVeMFwm/C3/5GkHgxR7gA1ER2vMhwWsWAnRyt5DWPtOd1kmUMEupEIuadWN4PBuNOJ2d2vac4GqkPr/ml2+SguDuD8Doq6/0ULSa9D3eUwhvhkuFeZpg5CLkL6SynINFjqmD4NND5ASi3YVuYu9J18ayVptQfctMROS6WKQmZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2BBCE5C4B5;
	Tue,  6 Jan 2026 20:19:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 80F2020010;
	Tue,  6 Jan 2026 20:19:00 +0000 (UTC)
Date: Tue, 6 Jan 2026 15:19:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Uladzislau Rezki
 <urezki@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 00/14] rcu: Reduce rnp->lock contention with per-CPU
 blocked task lists
Message-ID: <20260106151924.7acd74a4@gandalf.local.home>
In-Reply-To: <9a6016f5-3051-4055-9fd2-05a01c0c9171@paulmck-laptop>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
	<658b114e-b362-47e1-9dc8-9271cbcf2c4d@paulmck-laptop>
	<f679698b-3fc3-4bcc-834a-97c670e6ffe1@joelfernandes.org>
	<9a6016f5-3051-4055-9fd2-05a01c0c9171@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 80F2020010
X-Stat-Signature: w1ifp6eoani4p5g7hgr6myrgg8bi7oau
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19XHhapWe5o/lXRMvJvQ1UWpAMGaHi3kNQ=
X-HE-Tag: 1767730740-51845
X-HE-Meta: U2FsdGVkX1+S0uUbxRGZtA0U7w93eq4y467d6PgABkgypK5HCqL9IdwldhDbZZxRkFtL/f2vzmGggbrvMtFYkLtW7OeUVpUkIWBSSjCHRxRKN+fKNVF5+PAJzHuHwBnf7qDjeRMaCv7C/Z+Zj3jTxRPrEJ2R0sbE7DkfwOLe/JuCjyjXdmHm0/lWTJdW6x72bfI9v2GTT71U7BLvDDCU1vl636EL5p50zcnQ4+u3gmYVeIBDeEpyCCyx1he8sfXdY7bUgJRBWM/fyxfVFY/JtU2Cuf3ZMOvv5iJdGN77TvM7YiDTQHLg3WcFxn5pbnNZ8/iXzzcyRVVhTYz1O0h8AMS0gbpCcSYz

On Tue, 6 Jan 2026 11:17:19 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > Interesting. I might look into the boosting logic to see whether we can avoid
> > boosting certain tasks depending on whether they help the grace period complete
> > or not. Thank you for the suggestion.  
> 
> Just so you know, all of my simplification efforts thus far have instead
> made it more complex, but who knows what I might have been missing?

Maybe you are too smart to make it simple? ;-)


> I could easily believe that the vCPU preemption problem needs to be
> addressed, but doing so on a per-spinlock basis would lead to greatly
> increased complexity throughout the kernel, not just RCU.

Agreed.

> 
> > > The main point of this patch series is to avoid lock contention due to
> > > vCPU preemption, correct?  If so, will we need similar work on the other
> > > locks in the Linux kernel, both within RCU and elsewhere?  I vaguely
> > > recall your doing some work along those lines a few years back, and
> > > maybe Thomas Gleixner's deferred-preemption work could help with this.
> > > Or not, who knows?  Keeping the hypervisor informed of lock state is
> > > not necessarily free.  
> > 
> > Yes, I did some work on this at Google, but it turned out to be a very
> > fragmented effort in terms of where (which subsystem - KVM, scheduler etc)
> > should we do the priority boosting of vCPU threads. In the end, we just ended up
> > with an internal prototype that was not upstreamable but worked pretty well and
> > only had time for production (a lesson I learned there is we should probably
> > work on upstream solutions first, but life is not that easy sometimes).  
> 
> Which is one reason deferred preemption would be attractive.

Yes. That's why I've been pushing it.

> 
> > About the deferred-preemption, I believe Steven Rostedt at one point was looking
> > at that for VMs, but that effort stalled as Peter is concerned about doing that
> > would mess up the scheduler. The idea (AFAIU) is to use the rseq page to
> > communicate locking information between vCPU threads and the host and then let
> > the host avoid vCPU preemption - but the scheduler needs to do something with
> > that information. Otherwise, it's no use.  
> 
> Has deferred preemption for userspace locking also stalled?  If not,
> then the scheduler's support for userspace should apply directly to
> guest OSes, right?

No, the user space deferred preemption is still moving along nicely (I
believe Thomas has completed most of it). The issue here is that the
deferred happens before going back to user space. That's a different
location than going back to the guest. The logic needs to be in that path
too.

One thing that Peter Zijlstra pushed was the limited amount of time that
deferred wait may happen. He says user space spinlocks are a bad design,
but it has been proven for that they are currently the most efficient when
coming to very short critical sections. That is, where the critical section
is shorter than the cost of a system call. Thus, he forces the deferred
scheduling to be at most 50us max (he's also suggested less than that).

But when it comes to the guest, where kernel spinlocks are user space
spinlocks, and can be held for more than 50us, I would like a way to have
the guests defer the scheduling for even longer than user space spin locks.

-- Steve

