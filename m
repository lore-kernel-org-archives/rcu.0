Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CD1E9919;
	Sun, 22 Mar 2026 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774174162; cv=none; b=P7YZjom23+EyrnFghw3Pjq08ZNRKRgil/sXYFfXuw7egWPTcWAthvT4cdEROsevw0A8vuKmHQz/K86JvyITwfp46aG84O7YN+SNUziz05tDMc3fYrY59HIFhQCNLIdB2nNkTIT1YcEdxrIYajPLLA2urt5TF9XTPNfviU/N8v/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774174162; c=relaxed/simple;
	bh=+r+Ov/kFKKAn16bYC7HI0AXw5e87svbdfVJDgkKx4f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2QiBCCJteWtPvtzuWsmYRBQrSRiw5zIvrZwphVNOH7ruZ+O1xKPnxApz3f9r2IX9lhOvXqGppaRH3gZl6HF994Ia3TJlDWkzX3SzzwqbihboqOlF3ODmpSseG5PnyDe56CMsEMFA6Aqx4B10vOrHoa8hY5W9ukcORMZWNAQQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsVnqeJn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsVnqeJn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94327C19424;
	Sun, 22 Mar 2026 10:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774174161;
	bh=+r+Ov/kFKKAn16bYC7HI0AXw5e87svbdfVJDgkKx4f8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YsVnqeJnTyLJDqVeCCyMtrsBAfcJ/4lQb/uh5XujToloMQPCJ/9gtc/Vz01t0oCoc
	 /RLwhPfl7cZsVa3ZF8CUKmEot01YH25d/9cvE2/KH8LIGqH2XR+QeTsGRIOOiCHmMV
	 lPyg0PWD2aGFM+Lpjq9xFPD4uDKSHFkEigLPQyvPqpMfOyeiO3/i8nBzY02v1PhwZn
	 29jW1r/V0qD7UHd32M08RbXnZyw0bYvHh32gGrtRYk5qygdyBcJBsiJaicEUFxA43q
	 Htr4SzUvsByvAG98EnQ72eMKGqAkjiSZQlehgd6PYRgOWQTbMc1SZxX0e4xnifRuj1
	 ug53XttF4cefQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9CB28CE0FFC; Sun, 22 Mar 2026 03:09:19 -0700 (PDT)
Date: Sun, 22 Mar 2026 03:09:19 -0700
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
Message-ID: <3486c7a2-73e6-46f2-a030-c9349ce964dd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
 <b4857e4f-5a8d-4ccc-9e8b-df57718e4aee@paulmck-laptop>
 <ab7SQ3L1F-ap7mNl@tardis.local>
 <492ba226-79c7-4345-b691-eb775082b799@paulmck-laptop>
 <ab7eQ0QDNV9ZjQMN@tardis.local>
 <609b5df1-aa06-46a9-8e93-0bf9eb8b7738@paulmck-laptop>
 <ab71Vz9zmlVywWQT@tardis.local>
 <4d2b07a9-e3fd-4a95-8924-0839bdfc28b3@paulmck-laptop>
 <ab7623FFsiUOocHP@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7623FFsiUOocHP@tardis.local>

On Sat, Mar 21, 2026 at 01:08:59PM -0700, Boqun Feng wrote:
> On Sat, Mar 21, 2026 at 01:07:45PM -0700, Paul E. McKenney wrote:
> > On Sat, Mar 21, 2026 at 12:45:27PM -0700, Boqun Feng wrote:
> > > On Sat, Mar 21, 2026 at 12:31:04PM -0700, Paul E. McKenney wrote:
> > > > On Sat, Mar 21, 2026 at 11:06:59AM -0700, Boqun Feng wrote:
> > > > > On Sat, Mar 21, 2026 at 10:41:47AM -0700, Paul E. McKenney wrote:
> > > > > [...]
> > > > > > > > +	raw_spin_lock_rcu_node(ssp->srcu_sup);
> > > > > > > > +	delay = srcu_get_delay(ssp);
> > > > > > > > +	raw_spin_unlock_rcu_node(ssp->srcu_sup);
> > > > > > > > 
> > > > > > > 
> > > > > > > It was fixed differently in v2:
> > > > > > > 
> > > > > > > 	https://lore.kernel.org/rcu/20260320222916.19987-1-boqun@kernel.org/
> > > > > > > 
> > > > > > > I used _irqsave/_irqrestore just in case. Given it's an urgent fix,
> > > > > > > overly careful code is probably fine ;-)
> > > > > > > 
> > > > > > > Thanks for the testing and feedback.
> > > > > > 
> > > > > > OK, I will try that one, thank you!
> > > > > > 
> > > > > > FYI, with my change on your earlier version, SRCU-T got deadlocks between
> > > > > > the pi-lock and the workqueue pool lock.  Which might or might not be
> > > > > > particularly urgent.
> > > > > > 
> > > > > 
> > > > > I just checked my run yesterday, I also hit it. It's probably what
> > > > > Zqiang has found:
> > > > > 
> > > > > 	https://lore.kernel.org/rcu/4c23c66f86a2aff8f2d7b759f9dd257b82147a17@linux.dev/
> > > > > 
> > > > > We have a queue_work_on() in srcu_schedule_cbs_sdp(), so
> > > > > 
> > > > >     srcu_torture_deferred_free():
> > > > >       raw_spin_lock_irqsave(->pi_lock,...);
> > > > >       call_srcu():
> > > > >         if (snp == snp_leaf && snp_seq != s) {
> > > > >            srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0):
> > > > > 	     if (!delay)
> > > > >                queue_work_on(...)
> > > > > 
> > > > > I was about to reply to Zqiang, fixing that could be a touch design
> > > > > decision. Since it's a per srcu_data work ;-) NR_CPUS x irq_work
> > > > > incoming.
> > > > 
> > > > Just to be clear, SRCU-T is Tiny SRCU rather than Tree SRCU.  So perhaps
> > > > lower priority, though perhaps not lower irritation.  ;-)
> > > 
> > > I see, there is a schedule_work() in srcutiny's
> > > srcu_gp_start_if_needed(). But it couldn't cause deadlock on UP since
> > > locks are (almost) no-op. Maybe we can make RCU torture only test it on
> > > SMP?
> > 
> > Like this, you mean?  I will give it a shot tomorrow.
> 
> Yes, thanks!

OK, the previous patch did fine on short rcutorture testing aside from
the !SMP lockdep splat, so I have started the test without pi_lock.

Longer term, shouldn't lockdep take into account the fact that on !SMP,
the disabling of preemption (or interrupts or...) is essentially the same
as acquiring a global lock?  This means that only one task at a time can
be acquiring a raw spinlock on !SMP, so that the order of acquisition
of raw spinlocks on !SMP is irrelevant?  (Aside from self-deadlocking
double acquisitions, perhaps.)  In other words, shouldn't lockdep leave
raw spinlocks out of lockdep's cycle-detection data structure?

							Thanx, Paul
