Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3540036B06D;
	Sun, 22 Mar 2026 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774201501; cv=none; b=XPbHrT6OyFZczb17/LwlBWuKmpVuxziPwiDf4XxKaUkROiWDiQD3MBm/xDT0eJdlYi5577wkAFqed7EWWyf57D8t3GYwqCYBXO1ZKtaG+foKgmnQCdW1X7MEL0yTwePTEHandlFAQcOQ2QXQPubrWjG7yC3vHcAZUT4UIYHVAWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774201501; c=relaxed/simple;
	bh=BT8IhkdAWfYzEDoQbAvWuKvKNyooGyPeniqD6UgiJEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFn4h1YNxM1b283iItK57WjMeajsQC+yN90qltXOLr+nL3JaPE5bIYmkVL6TBzsuIovRssBejaLBOom/er38xPycmyr02LPx5oYdCxntw4yh9VQsAuLSdXrPAk1z6bpOzkyFVzD9//WX5gTv6QYlb3F9Bm0mPnlk9f/SyntNj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiCs4bvD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiCs4bvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDADCC19424;
	Sun, 22 Mar 2026 17:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774201500;
	bh=BT8IhkdAWfYzEDoQbAvWuKvKNyooGyPeniqD6UgiJEY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MiCs4bvDv1RRdd2GW3m7tdJzWIKLTVx7Kv/haPfDd9hC+dfXY3M0YoS8OO2y3hsGz
	 4Eu0MvzNDSZUx0ndbQEdn9569foUAKGpKP0YmzGgv59EFF6ypKD1ArZmt0TppqtBNv
	 +USm6SpziuhGv6W6Svo1kzHgOD1YuJP8e5fL2u//I7exr/pQupTBatpmmEowKgo2yD
	 ceHWR771QNk5pylKU15iEezbCHChOBuoOSIZuCKCKazv91znHDcf6MujeOnKZwALdf
	 0hRN3bsNCJDjgM1LF3h0WAd34AjCqRNXvCCrztKx2ms+368+AebJJarUm85KDnE/OM
	 QZPaKUeYE3HaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9FE4DCE04A3; Sun, 22 Mar 2026 10:44:58 -0700 (PDT)
Date: Sun, 22 Mar 2026 10:44:58 -0700
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
	John Fastabend <john.fastabend@gmail.com>,
	Andrea Righi <arighi@nvidia.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] rcu: Use an intermediate irq_work to start process_srcu()
Message-ID: <e5fdd5db-4897-4975-a2db-ddb951385e89@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <492ba226-79c7-4345-b691-eb775082b799@paulmck-laptop>
 <ab7eQ0QDNV9ZjQMN@tardis.local>
 <609b5df1-aa06-46a9-8e93-0bf9eb8b7738@paulmck-laptop>
 <ab71Vz9zmlVywWQT@tardis.local>
 <4d2b07a9-e3fd-4a95-8924-0839bdfc28b3@paulmck-laptop>
 <ab7623FFsiUOocHP@tardis.local>
 <3486c7a2-73e6-46f2-a030-c9349ce964dd@paulmck-laptop>
 <acAV-16pYQvy06aw@tardis.local>
 <902d80c5-02a9-46d0-9d6a-06e8cd94cd37@paulmck-laptop>
 <acAnYrlkkUvbNkGG@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acAnYrlkkUvbNkGG@tardis.local>

On Sun, Mar 22, 2026 at 10:31:14AM -0700, Boqun Feng wrote:
> On Sun, Mar 22, 2026 at 10:09:53AM -0700, Paul E. McKenney wrote:
> > On Sun, Mar 22, 2026 at 09:16:59AM -0700, Boqun Feng wrote:
> > > On Sun, Mar 22, 2026 at 03:09:19AM -0700, Paul E. McKenney wrote:
> > > > On Sat, Mar 21, 2026 at 01:08:59PM -0700, Boqun Feng wrote:
> > > > > On Sat, Mar 21, 2026 at 01:07:45PM -0700, Paul E. McKenney wrote:
> > > > > > On Sat, Mar 21, 2026 at 12:45:27PM -0700, Boqun Feng wrote:
> > > > > > > On Sat, Mar 21, 2026 at 12:31:04PM -0700, Paul E. McKenney wrote:
> > > > > > > > On Sat, Mar 21, 2026 at 11:06:59AM -0700, Boqun Feng wrote:
> > > > > > > > > On Sat, Mar 21, 2026 at 10:41:47AM -0700, Paul E. McKenney wrote:
> > > > > > > > > [...]
> > > > > > > > > > > > +	raw_spin_lock_rcu_node(ssp->srcu_sup);
> > > > > > > > > > > > +	delay = srcu_get_delay(ssp);
> > > > > > > > > > > > +	raw_spin_unlock_rcu_node(ssp->srcu_sup);
> > > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > It was fixed differently in v2:
> > > > > > > > > > > 
> > > > > > > > > > > 	https://lore.kernel.org/rcu/20260320222916.19987-1-boqun@kernel.org/
> > > > > > > > > > > 
> > > > > > > > > > > I used _irqsave/_irqrestore just in case. Given it's an urgent fix,
> > > > > > > > > > > overly careful code is probably fine ;-)
> > > > > > > > > > > 
> > > > > > > > > > > Thanks for the testing and feedback.
> > > > > > > > > > 
> > > > > > > > > > OK, I will try that one, thank you!
> > > > > > > > > > 
> > > > > > > > > > FYI, with my change on your earlier version, SRCU-T got deadlocks between
> > > > > > > > > > the pi-lock and the workqueue pool lock.  Which might or might not be
> > > > > > > > > > particularly urgent.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > I just checked my run yesterday, I also hit it. It's probably what
> > > > > > > > > Zqiang has found:
> > > > > > > > > 
> > > > > > > > > 	https://lore.kernel.org/rcu/4c23c66f86a2aff8f2d7b759f9dd257b82147a17@linux.dev/
> > > > > > > > > 
> > > > > > > > > We have a queue_work_on() in srcu_schedule_cbs_sdp(), so
> > > > > > > > > 
> > > > > > > > >     srcu_torture_deferred_free():
> > > > > > > > >       raw_spin_lock_irqsave(->pi_lock,...);
> > > > > > > > >       call_srcu():
> > > > > > > > >         if (snp == snp_leaf && snp_seq != s) {
> > > > > > > > >            srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0):
> > > > > > > > > 	     if (!delay)
> > > > > > > > >                queue_work_on(...)
> > > > > > > > > 
> > > > > > > > > I was about to reply to Zqiang, fixing that could be a touch design
> > > > > > > > > decision. Since it's a per srcu_data work ;-) NR_CPUS x irq_work
> > > > > > > > > incoming.
> > > > > > > > 
> > > > > > > > Just to be clear, SRCU-T is Tiny SRCU rather than Tree SRCU.  So perhaps
> > > > > > > > lower priority, though perhaps not lower irritation.  ;-)
> > > > > > > 
> > > > > > > I see, there is a schedule_work() in srcutiny's
> > > > > > > srcu_gp_start_if_needed(). But it couldn't cause deadlock on UP since
> > > > > > > locks are (almost) no-op. Maybe we can make RCU torture only test it on
> > > > > > > SMP?
> > > > > > 
> > > > > > Like this, you mean?  I will give it a shot tomorrow.
> > > > > 
> > > > > Yes, thanks!
> > > > 
> > > > OK, the previous patch did fine on short rcutorture testing aside from
> > > > the !SMP lockdep splat, so I have started the test without pi_lock.
> > > > 
> > > > Longer term, shouldn't lockdep take into account the fact that on !SMP,
> > > > the disabling of preemption (or interrupts or...) is essentially the same
> > > > as acquiring a global lock?  This means that only one task at a time can
> > > > be acquiring a raw spinlock on !SMP, so that the order of acquisition
> > > > of raw spinlocks on !SMP is irrelevant?  (Aside from self-deadlocking
> > > > double acquisitions, perhaps.)  In other words, shouldn't lockdep leave
> > > > raw spinlocks out of lockdep's cycle-detection data structure?
> > > 
> > > Lockdep doesn't know whether a code path is UP-only, so it'll apply the
> > > general locking rule to check. Similar as lockdep still detect
> > > PREEMPT_RT locking issue for !PREEMPT_RT kernel. Maybe we can add a
> > > separate kconfig to narrow down lockdep detection for UP-only if UP=y.
> > 
> > But lockdep *does* know when it is running in a CONFIG_SMP=n kernel,
> > correct?  In which case all the code paths are UP-only.
> 
> Why? UP and SMP can share the same code path, no? Just because lockdep
> is running in UP and see a code path, doesn't mean that code path is
> UP-only, right? What I was trying to say is Lockdep detects generel
> locking rule violation, so even when it's running in UP kernel, it'll
> use rules that SMP uses.

I know that this is what lockdep is doing.  I am instead saying that
what lockdep is doing is not a good thing.  ;-)

> > The situation with CONFIG_PREEMPT_RT=y is quite different: The motivation
> > was for people running lockdep on CONFIG_PREEMPT_RT=n kernels to
> > detect and fix locking issues that would otherwise only show up in
> > CONFIG_PREEMPT_RT=y kernels.
> 
> I'm not sure how it's different than people wanted to detect SMP=y
> locking issues when running UP kernel. Of course, I didn't know whether
> that's the intention because I wasn't there ;-)

It is very different.

There were very few people developing and running PREEMPT_RT, so it
was quite difficult for them to clean up the lock-context issues that
everyone else was creating.  Making lockdep check for PREEMPT_RT issues
in !PREEMPT_RT kernels was therefore very helpful, at least to the
PREEMPT_RT guys.

In contrast (and unlike 20 years ago), almost everyone runs SMP, so there
is no harm in !SMP lockdep ignoring things that would be deadlocks in
SMP kernels.  The ample SMP lockdep testing will catch those issues,
so there is no need for extra help from UP lockdep testing.

							Thanx, Paul

> Regards,
> Boqun
> 
> > And of course, CONFIG_SMP=n kernels still need deadlock detection for
> > mutexes and the like.
> > 
> > 							Thanx, Paul
