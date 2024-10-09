Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3ED1F947;
	Wed,  9 Oct 2024 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728439431; cv=none; b=tnXKa9P+SFeeszKB/YjhXGxsiBcoEg4jR/QIkCxFGpFFzsu3aaKx+dJulRG9KavgxP46mLZPUjlzViS2iLqApSs6Qd+zMzd/40CunrqoZQV+xnPHx/sL89mFTjefUZBJ4a4s4iKugQkGzvI6iJKO3DIpLlPWPDLcSnm1bYI6NOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728439431; c=relaxed/simple;
	bh=xiFBD9mO/DfN6A+tSvzZcW/0DaSRmPIEAAW5mTgn15o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lcuo7ENp6pD4K1LMU66x0k/9D+fxt5Sw9gbqHN5GzU4Yb78Ge41JplYa9wHrabnzKJgMAShxejkuezmEo+ASOHNA7yg1af8RLHv9NXaJe5LSnZSHm7xNnVeHejo7ezt/r4hgGn7h/mB2R1Lo0mmRiWxI2xu2e/4YnMGgojuSFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFd7bhyx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFd7bhyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3290C4CEC7;
	Wed,  9 Oct 2024 02:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728439430;
	bh=xiFBD9mO/DfN6A+tSvzZcW/0DaSRmPIEAAW5mTgn15o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HFd7bhyx8eAndOwl5DElLIXBR14rivEY4RQHieb1LpSqPMP5fuop3FxBmUyHg1gze
	 evj/OnW2lTnr//oH0ve9WuwjytZt8Cj8nlweQOhdzfP4NzMRMGvsJMFwFOBI/94ZtQ
	 rkzzvQeb1oXsZcnOAXYu/nARAs1QcTcmqUvRfd0sY39E5pq/ig+mPtZNyFFsRDycsh
	 1NeK4i6sL2p64Eykk6fnpwlKPsrctLYI5y1V6F9O/Fx5Abf/ZikQIbqTqnmutEaUL/
	 M/4OkqjlRxuG/2C8QihUEQX6FvPBPCbFtCIbFq8K+l2qHos9fNX1gzgQ/mZW4IdiXy
	 Z1ycktPRXOXew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 76863CE0FEF; Tue,  8 Oct 2024 19:03:50 -0700 (PDT)
Date: Tue, 8 Oct 2024 19:03:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 3/3] rcu: Report callbacks enqueued on offline CPU blind
 spot
Message-ID: <4e81816e-3a4d-4642-a86c-fd9bd49ca163@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241002145738.38226-1-frederic@kernel.org>
 <20241002145738.38226-4-frederic@kernel.org>
 <Zv1f8-1tLd-r1cyu@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zv1f8-1tLd-r1cyu@localhost.localdomain>

On Wed, Oct 02, 2024 at 05:00:03PM +0200, Frederic Weisbecker wrote:
> Le Wed, Oct 02, 2024 at 04:57:38PM +0200, Frederic Weisbecker a écrit :
> > Callbacks enqueued after rcutree_report_cpu_dead() fall into RCU barrier
> > blind spot. Report any potential misuse.
> > 
> > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/tree.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index a60616e69b66..36070b6bf4a1 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3084,8 +3084,11 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> >  	head->func = func;
> >  	head->next = NULL;
> >  	kasan_record_aux_stack_noalloc(head);
> > +
> >  	local_irq_save(flags);
> >  	rdp = this_cpu_ptr(&rcu_data);
> > +	RCU_LOCKDEP_WARN(rcu_rdp_cpu_online(rdp), "Callback enqueued on offline
> > CPU!");
> 
> This should be !rcu_rdp_cpu_online(rdp)
> 
> Sigh...

I am pulling this in for testing with this change, thank you!

							Thanx, Paul

> > +
> >  	lazy = lazy_in && !rcu_async_should_hurry();
> >  
> >  	/* Add the callback to our list. */
> > -- 
> > 2.46.0
> > 
> > 
