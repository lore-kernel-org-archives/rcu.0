Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC61221282;
	Fri,  9 Jan 2026 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767923737; cv=none; b=LPAG43CqHO9C7ZcbjmwqmC/pu+bco6neG4SvmysAgl6GwVNWRaUr6S0q4NO7pRJsw6qYWukQFo/5Er/So9HsPY1n0zP86PfHpsnP9PdWhErs+Asnu11880/mhouaYegS8YQi+XPkayjJxUS+W4Cmbi5zIqYBOriaIhB+dggv1u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767923737; c=relaxed/simple;
	bh=czX3+EvWp2+5YP4l89c8PAiVusMn3+G4ZpEgKdrxi+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbPPPSO5ALIB+qn8U6qeeqF6rTW6jM/8PIQjE0cNp+cHZTDqtivhdUjUvT+vo15pZP7otkHKjbiz7b7gQ7fCx89QnkfSUGoHRF8Q/Lbx+Qneu9Lk8Nq+bKmnUArOV21guIhHNom4tc4e5v0pQ+jk62Zx69xDgslmh7RUR5oM0sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSpeEaSz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSpeEaSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD41C116C6;
	Fri,  9 Jan 2026 01:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767923736;
	bh=czX3+EvWp2+5YP4l89c8PAiVusMn3+G4ZpEgKdrxi+Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HSpeEaSzg/Eyi1w5DpseNWEtPx7+i9H81bHXlWG9sQtoO+zyPtCwr7Aj3mtEZtLkv
	 o9zFgxJNXLW4htc+kujeFjdxeCl5n0yu88/dPb5J+JoorojOICfYD7qVTuz4yQNW+W
	 GJLYwQxEC2ajba0p9ppSVvCoz/jxoADbrdo4QQAUCMFtWDac1ee29qGlbgMI81cNIK
	 Pwjqz1ICB7uxMqMkedx4X5bwfBxn3o8qgLz0Q/Q3KKb3MbhhhXu8wQ6qPKQlPt9ZoP
	 OizTjZ1RC9eBJA1gZ/49BZ83eX5l7rakZsVk/yGaCzoi5bIkzw8xDbKBJ2Sb+oTx6B
	 QUMjOj1w3agrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 26155CE1690; Thu,  8 Jan 2026 17:55:36 -0800 (PST)
Date: Thu, 8 Jan 2026 17:55:36 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <b56c44e1-644b-4e5b-a518-9a9737d0a376@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
 <658b114e-b362-47e1-9dc8-9271cbcf2c4d@paulmck-laptop>
 <f679698b-3fc3-4bcc-834a-97c670e6ffe1@joelfernandes.org>
 <9a6016f5-3051-4055-9fd2-05a01c0c9171@paulmck-laptop>
 <20260106151924.7acd74a4@gandalf.local.home>
 <7c860b04-5ef4-4ab7-8e73-283b5260b78c@paulmck-laptop>
 <8d7b1107-ec1e-4c1d-989c-20c73af9c43c@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d7b1107-ec1e-4c1d-989c-20c73af9c43c@nvidia.com>

On Tue, Jan 06, 2026 at 03:49:07PM -0500, Joel Fernandes wrote:
> 
> 
> On 1/6/2026 3:35 PM, Paul E. McKenney wrote:
> >>>> About the deferred-preemption, I believe Steven Rostedt at one point was looking
> >>>> at that for VMs, but that effort stalled as Peter is concerned about doing that
> >>>> would mess up the scheduler. The idea (AFAIU) is to use the rseq page to
> >>>> communicate locking information between vCPU threads and the host and then let
> >>>> the host avoid vCPU preemption - but the scheduler needs to do something with
> >>>> that information. Otherwise, it's no use.  
> >>> Has deferred preemption for userspace locking also stalled?  If not,
> >>> then the scheduler's support for userspace should apply directly to
> >>> guest OSes, right?
> >> No, the user space deferred preemption is still moving along nicely (I
> >> believe Thomas has completed most of it). The issue here is that the
> >> deferred happens before going back to user space. That's a different
> >> location than going back to the guest. The logic needs to be in that path
> >> too.
> >
> > OK, got it, thank you!
> 
> There's also the challenge of sharing the locking information with the guest
> even when there is *no contention*. KVM being unaware of lock critical sections
> in the VM-exit path. Then after that wiring it up with the deffered preemption
> infra and moving beyond the 50 micro second limits. If we VM exited and then
> made a decision, I think we are easily going to blow past 50 micro seconds anyway.

Yes, the VM-exit path would need to do its part.  Could the 50 microseconds
be measured up to but not including the VM exit?

> But again to clarify, I didn't mean to use vCPU preemption as the driving
> usecase for this.. but I ran into it when I wrote a benchmark to see how RCU
> behaves in a VM.

Me, I am just trying to keep the complexity down to a dull roar.
So please do not take my pushback personally.  "Just doing my job."

							Thanx, Paul
