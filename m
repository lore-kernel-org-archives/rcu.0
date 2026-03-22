Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB362D2496;
	Sun, 22 Mar 2026 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774199396; cv=none; b=QiPPjQnNOfg0KvjXTd5aismcCDtZS8NaP5KDm+hZ79VnRaK9vBX+1pB6how2vyQe93Fm0FtL9quIq4e97S1m/oGeovxGkq3SCVU69Y1pnP070i3LsUrAz8QjxISRSZGUq3I1gByjzCW2SZY/KxvOvtYhuT2zd6wszu9BDn51D0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774199396; c=relaxed/simple;
	bh=tSu7aABFW5bmb4o6ixU5ljhUjmqsSkMUjKnIQidBwmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahey/vLwWNEazsR+wZajEXRT5aOGi9LjoY1Q+tAr/2imUPL9Dj0e/oWniyhmK6sa1ySFNi92SjUxlP4e3FPY2AlzYb5Wv3dlPxkLIFP97c6Nh3Alq9mVG64urKM/hjLMibIhh4bqW0omoTXYteTxix7WbAfj5HDs8pJ5k7ZZsZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZSa6eU7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZSa6eU7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3F8C19424;
	Sun, 22 Mar 2026 17:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774199396;
	bh=tSu7aABFW5bmb4o6ixU5ljhUjmqsSkMUjKnIQidBwmI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QZSa6eU71TORwghkenQy9Yi0CgJJ/MpO0T8QuvY/I4ifweOMXLWNrLi+jisS6Fr0q
	 kAVHfu3oe6x0LPlDeXg645Rzde/rLO66DHuuJEkk74UgFiu3ClU6jMwnJ1QR+xAlFn
	 Xg03LSf00GNIcrD3QVdIPJ/WX4R63oNUV2SeSgYjT2wsbOQyzRwdd6c9kbrYHXCcCQ
	 226D9NredPVhvBn8oMeg+LF8BSNN8ktTvQmeJP7dT2uZX2xmokH2q0xDpyudZSS+4i
	 Ky73BhJVpX+mMhTy9BA9Z89AoN4B+PX36jwVSfOjr2YtXROzqvy7xuOdZi3VMSwwv4
	 p9arPHdptv8aw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E0953CE0FFC; Sun, 22 Mar 2026 10:09:53 -0700 (PDT)
Date: Sun, 22 Mar 2026 10:09:53 -0700
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
Message-ID: <902d80c5-02a9-46d0-9d6a-06e8cd94cd37@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b4857e4f-5a8d-4ccc-9e8b-df57718e4aee@paulmck-laptop>
 <ab7SQ3L1F-ap7mNl@tardis.local>
 <492ba226-79c7-4345-b691-eb775082b799@paulmck-laptop>
 <ab7eQ0QDNV9ZjQMN@tardis.local>
 <609b5df1-aa06-46a9-8e93-0bf9eb8b7738@paulmck-laptop>
 <ab71Vz9zmlVywWQT@tardis.local>
 <4d2b07a9-e3fd-4a95-8924-0839bdfc28b3@paulmck-laptop>
 <ab7623FFsiUOocHP@tardis.local>
 <3486c7a2-73e6-46f2-a030-c9349ce964dd@paulmck-laptop>
 <acAV-16pYQvy06aw@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acAV-16pYQvy06aw@tardis.local>

On Sun, Mar 22, 2026 at 09:16:59AM -0700, Boqun Feng wrote:
> On Sun, Mar 22, 2026 at 03:09:19AM -0700, Paul E. McKenney wrote:
> > On Sat, Mar 21, 2026 at 01:08:59PM -0700, Boqun Feng wrote:
> > > On Sat, Mar 21, 2026 at 01:07:45PM -0700, Paul E. McKenney wrote:
> > > > On Sat, Mar 21, 2026 at 12:45:27PM -0700, Boqun Feng wrote:
> > > > > On Sat, Mar 21, 2026 at 12:31:04PM -0700, Paul E. McKenney wrote:
> > > > > > On Sat, Mar 21, 2026 at 11:06:59AM -0700, Boqun Feng wrote:
> > > > > > > On Sat, Mar 21, 2026 at 10:41:47AM -0700, Paul E. McKenney wrote:
> > > > > > > [...]
> > > > > > > > > > +	raw_spin_lock_rcu_node(ssp->srcu_sup);
> > > > > > > > > > +	delay = srcu_get_delay(ssp);
> > > > > > > > > > +	raw_spin_unlock_rcu_node(ssp->srcu_sup);
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > It was fixed differently in v2:
> > > > > > > > > 
> > > > > > > > > 	https://lore.kernel.org/rcu/20260320222916.19987-1-boqun@kernel.org/
> > > > > > > > > 
> > > > > > > > > I used _irqsave/_irqrestore just in case. Given it's an urgent fix,
> > > > > > > > > overly careful code is probably fine ;-)
> > > > > > > > > 
> > > > > > > > > Thanks for the testing and feedback.
> > > > > > > > 
> > > > > > > > OK, I will try that one, thank you!
> > > > > > > > 
> > > > > > > > FYI, with my change on your earlier version, SRCU-T got deadlocks between
> > > > > > > > the pi-lock and the workqueue pool lock.  Which might or might not be
> > > > > > > > particularly urgent.
> > > > > > > > 
> > > > > > > 
> > > > > > > I just checked my run yesterday, I also hit it. It's probably what
> > > > > > > Zqiang has found:
> > > > > > > 
> > > > > > > 	https://lore.kernel.org/rcu/4c23c66f86a2aff8f2d7b759f9dd257b82147a17@linux.dev/
> > > > > > > 
> > > > > > > We have a queue_work_on() in srcu_schedule_cbs_sdp(), so
> > > > > > > 
> > > > > > >     srcu_torture_deferred_free():
> > > > > > >       raw_spin_lock_irqsave(->pi_lock,...);
> > > > > > >       call_srcu():
> > > > > > >         if (snp == snp_leaf && snp_seq != s) {
> > > > > > >            srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0):
> > > > > > > 	     if (!delay)
> > > > > > >                queue_work_on(...)
> > > > > > > 
> > > > > > > I was about to reply to Zqiang, fixing that could be a touch design
> > > > > > > decision. Since it's a per srcu_data work ;-) NR_CPUS x irq_work
> > > > > > > incoming.
> > > > > > 
> > > > > > Just to be clear, SRCU-T is Tiny SRCU rather than Tree SRCU.  So perhaps
> > > > > > lower priority, though perhaps not lower irritation.  ;-)
> > > > > 
> > > > > I see, there is a schedule_work() in srcutiny's
> > > > > srcu_gp_start_if_needed(). But it couldn't cause deadlock on UP since
> > > > > locks are (almost) no-op. Maybe we can make RCU torture only test it on
> > > > > SMP?
> > > > 
> > > > Like this, you mean?  I will give it a shot tomorrow.
> > > 
> > > Yes, thanks!
> > 
> > OK, the previous patch did fine on short rcutorture testing aside from
> > the !SMP lockdep splat, so I have started the test without pi_lock.
> > 
> > Longer term, shouldn't lockdep take into account the fact that on !SMP,
> > the disabling of preemption (or interrupts or...) is essentially the same
> > as acquiring a global lock?  This means that only one task at a time can
> > be acquiring a raw spinlock on !SMP, so that the order of acquisition
> > of raw spinlocks on !SMP is irrelevant?  (Aside from self-deadlocking
> > double acquisitions, perhaps.)  In other words, shouldn't lockdep leave
> > raw spinlocks out of lockdep's cycle-detection data structure?
> 
> Lockdep doesn't know whether a code path is UP-only, so it'll apply the
> general locking rule to check. Similar as lockdep still detect
> PREEMPT_RT locking issue for !PREEMPT_RT kernel. Maybe we can add a
> separate kconfig to narrow down lockdep detection for UP-only if UP=y.

But lockdep *does* know when it is running in a CONFIG_SMP=n kernel,
correct?  In which case all the code paths are UP-only.

The situation with CONFIG_PREEMPT_RT=y is quite different: The motivation
was for people running lockdep on CONFIG_PREEMPT_RT=n kernels to
detect and fix locking issues that would otherwise only show up in
CONFIG_PREEMPT_RT=y kernels.

And of course, CONFIG_SMP=n kernels still need deadlock detection for
mutexes and the like.

							Thanx, Paul
