Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A645CA4E
	for <rcu@vger.kernel.org>; Sun, 22 Mar 2026 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774196224; cv=none; b=J3TiS8R3nEsY+FORpr1fmscBIQvqdEvnPgoqbPJ2pj5Gujl9mVvyuCMAsujcNY9yc4GC7DcICOvjVLa59Paxc8mU93ydvTFmGHd14cu0w88q08Dx3/4eoRw8kAc7fgRdJ7zTjbobvC9dFmTcO0ap40YpU1J9xP1XWzWWBhU+Ye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774196224; c=relaxed/simple;
	bh=blUG7B4JdkGtIxEKF9tmlJNMk6cUUI19xq7UHnv/i4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyaGNNf2QKVP+3vjvbYeBUXY5POfoBHY/UF0wavPNNj8nKeKwVCHYas419odF3q6CSOHDJbPB1Wy0cHek946Wud5Qtr/JrhI/Yf4U0o9gMeIWUag2tkD5SO0SA5dUPAQ/AC6Clb4LMV/MYsbR/uA0/Wa6+9X/t3fObXtbxrlBdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B71X4Lb3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B71X4Lb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755DFC4AF09;
	Sun, 22 Mar 2026 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774196223;
	bh=blUG7B4JdkGtIxEKF9tmlJNMk6cUUI19xq7UHnv/i4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B71X4Lb3iDChAEKAC3gN0ANqK8hNUSqpxtgydmYJNxpOnchERhnx08CL4kPaLEZ9N
	 uktnJ3mQ2n6dJtTFTQ3AoHQEgQyA5TB64KJ+R7iZ5mD64bRA51beHhjDat3EWjey+z
	 I9WxWSrvH7ojkTnwzctI9VT7t84rOB3fPsyfZ7Wwu9W5QACabqOo7vmpBBszO7+Uq/
	 tz7y4vLcMqMSudhH4iTMXFRyMx1jsSKwmagJS4J9lw46+Uu78j4F9uC5eiV+qa4ZvZ
	 1ltxUUrmwITqT+fYb52W2lQ9qtWTnF3AQ8QkEFb+JcJ2lyN4panhrrXuyBDwsXj9GV
	 c6Xi6hsryzgdw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5E81DF40072;
	Sun, 22 Mar 2026 12:17:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 22 Mar 2026 12:17:02 -0400
X-ME-Sender: <xms:_hXAaUssEVwCWeUazpqbhRKi1b4-VqhB3j7OEhK2NQTZYW-6Af_7Zw>
    <xme:_hXAaa2JpVFXxAZoTov5SgtgLpdGowJ64_xq1gXGEuTVEPahUYRNvv5km3jpqrg45
    eckCQgXtn0O9COafd8lFWrgh5QCMCcWKMrKsZE6buKytQpEclrADX8>
X-ME-Received: <xmr:_hXAaYRKqD5_moU1QxO8RAQ5pzaV_pSJ9Pl0f7CJccwKeoDkfyyBODHuSIpifhXPWmIQTEw2lWkAAbg3I2m6fRlNAXIOBCNF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeivdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elueehtefhtddtgfejvdejueehhfekteevueeuueekgeetieeggeehvdffhefhhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpthht
    ohepmhgvmhigohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghighgvrghshieslh
    hinhhuthhrohhnihigrdguvgdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhiihhtrhdutdesghhmrghilhdrtghomh
    dprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopegsohhq
    uhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehrtghusehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_hXAaWvQgkady-b3oxmzHjHMg5NpBt2JNHx2T-3uZCFwsnpDn7LHLg>
    <xmx:_hXAaWLlQ1grRKf0CVmkgA9hR4_-mXp6KBs5EoVlbCZBO4JJRdXh2w>
    <xmx:_hXAaaeA2LQEjKw5Lsrhr_sY-ViVJgTgCmhY9nS4OQWGHiYeG0KksA>
    <xmx:_hXAaYVzrqnthea0M1toUWTGc1VQF_1oyWUlxzjz4n64vuCvIAcf9Q>
    <xmx:_hXAaYhs8RgDrgHh9QDnmOTajiWeWbWiWqxAG-FlXXBR2tt8gMpwhNhA>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Mar 2026 12:17:00 -0400 (EDT)
Date: Sun, 22 Mar 2026 09:16:59 -0700
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
	John Fastabend <john.fastabend@gmail.com>,
	Andrea Righi <arighi@nvidia.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] rcu: Use an intermediate irq_work to start process_srcu()
Message-ID: <acAV-16pYQvy06aw@tardis.local>
References: <20260320181400.15909-1-boqun@kernel.org>
 <b4857e4f-5a8d-4ccc-9e8b-df57718e4aee@paulmck-laptop>
 <ab7SQ3L1F-ap7mNl@tardis.local>
 <492ba226-79c7-4345-b691-eb775082b799@paulmck-laptop>
 <ab7eQ0QDNV9ZjQMN@tardis.local>
 <609b5df1-aa06-46a9-8e93-0bf9eb8b7738@paulmck-laptop>
 <ab71Vz9zmlVywWQT@tardis.local>
 <4d2b07a9-e3fd-4a95-8924-0839bdfc28b3@paulmck-laptop>
 <ab7623FFsiUOocHP@tardis.local>
 <3486c7a2-73e6-46f2-a030-c9349ce964dd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3486c7a2-73e6-46f2-a030-c9349ce964dd@paulmck-laptop>

On Sun, Mar 22, 2026 at 03:09:19AM -0700, Paul E. McKenney wrote:
> On Sat, Mar 21, 2026 at 01:08:59PM -0700, Boqun Feng wrote:
> > On Sat, Mar 21, 2026 at 01:07:45PM -0700, Paul E. McKenney wrote:
> > > On Sat, Mar 21, 2026 at 12:45:27PM -0700, Boqun Feng wrote:
> > > > On Sat, Mar 21, 2026 at 12:31:04PM -0700, Paul E. McKenney wrote:
> > > > > On Sat, Mar 21, 2026 at 11:06:59AM -0700, Boqun Feng wrote:
> > > > > > On Sat, Mar 21, 2026 at 10:41:47AM -0700, Paul E. McKenney wrote:
> > > > > > [...]
> > > > > > > > > +	raw_spin_lock_rcu_node(ssp->srcu_sup);
> > > > > > > > > +	delay = srcu_get_delay(ssp);
> > > > > > > > > +	raw_spin_unlock_rcu_node(ssp->srcu_sup);
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > It was fixed differently in v2:
> > > > > > > > 
> > > > > > > > 	https://lore.kernel.org/rcu/20260320222916.19987-1-boqun@kernel.org/
> > > > > > > > 
> > > > > > > > I used _irqsave/_irqrestore just in case. Given it's an urgent fix,
> > > > > > > > overly careful code is probably fine ;-)
> > > > > > > > 
> > > > > > > > Thanks for the testing and feedback.
> > > > > > > 
> > > > > > > OK, I will try that one, thank you!
> > > > > > > 
> > > > > > > FYI, with my change on your earlier version, SRCU-T got deadlocks between
> > > > > > > the pi-lock and the workqueue pool lock.  Which might or might not be
> > > > > > > particularly urgent.
> > > > > > > 
> > > > > > 
> > > > > > I just checked my run yesterday, I also hit it. It's probably what
> > > > > > Zqiang has found:
> > > > > > 
> > > > > > 	https://lore.kernel.org/rcu/4c23c66f86a2aff8f2d7b759f9dd257b82147a17@linux.dev/
> > > > > > 
> > > > > > We have a queue_work_on() in srcu_schedule_cbs_sdp(), so
> > > > > > 
> > > > > >     srcu_torture_deferred_free():
> > > > > >       raw_spin_lock_irqsave(->pi_lock,...);
> > > > > >       call_srcu():
> > > > > >         if (snp == snp_leaf && snp_seq != s) {
> > > > > >            srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0):
> > > > > > 	     if (!delay)
> > > > > >                queue_work_on(...)
> > > > > > 
> > > > > > I was about to reply to Zqiang, fixing that could be a touch design
> > > > > > decision. Since it's a per srcu_data work ;-) NR_CPUS x irq_work
> > > > > > incoming.
> > > > > 
> > > > > Just to be clear, SRCU-T is Tiny SRCU rather than Tree SRCU.  So perhaps
> > > > > lower priority, though perhaps not lower irritation.  ;-)
> > > > 
> > > > I see, there is a schedule_work() in srcutiny's
> > > > srcu_gp_start_if_needed(). But it couldn't cause deadlock on UP since
> > > > locks are (almost) no-op. Maybe we can make RCU torture only test it on
> > > > SMP?
> > > 
> > > Like this, you mean?  I will give it a shot tomorrow.
> > 
> > Yes, thanks!
> 
> OK, the previous patch did fine on short rcutorture testing aside from
> the !SMP lockdep splat, so I have started the test without pi_lock.
> 
> Longer term, shouldn't lockdep take into account the fact that on !SMP,
> the disabling of preemption (or interrupts or...) is essentially the same
> as acquiring a global lock?  This means that only one task at a time can
> be acquiring a raw spinlock on !SMP, so that the order of acquisition
> of raw spinlocks on !SMP is irrelevant?  (Aside from self-deadlocking
> double acquisitions, perhaps.)  In other words, shouldn't lockdep leave
> raw spinlocks out of lockdep's cycle-detection data structure?
> 

Lockdep doesn't know whether a code path is UP-only, so it'll apply the
general locking rule to check. Similar as lockdep still detect
PREEMPT_RT locking issue for !PREEMPT_RT kernel. Maybe we can add a
separate kconfig to narrow down lockdep detection for UP-only if UP=y.

Regards,
Boqun

> 							Thanx, Paul
