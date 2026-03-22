Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E31C5D44
	for <rcu@vger.kernel.org>; Sun, 22 Mar 2026 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774200678; cv=none; b=BSZkGD/qa2wYJoRtRQ+YPrldQZSbIEndROEbsVJt/gApWYNgbTw+Fi1296OGr+gQSEGZuKfSeMW14+qPoDIM86jkZC5C19szml/qCjCG/rMjSrKWgDiLsMRBhYjAjLtAnTJHvRlVengJbsW5ZD7WDooUnviqehZY3Hoee8plb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774200678; c=relaxed/simple;
	bh=1Znp/LkwnTopQHFTgzY+BV9K+X9J2j1oFk72Tew2sf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+2lA9AYg1hqOBxo99dGcnogjVEWX95DTtkqSbvAIqEnH0UbRPKHO2675gPH9Muv2ELSPeXCa6kIw+/lJexSOjNpHzSKJfchWTlqY8SxIG+atxdnqjC2DsGbh5nh6VX/6Iio86tg2mnVDZqm3j53wNfCdU9a+vuZEVYS1ALIe34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWXH9gKY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWXH9gKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189BBC19424;
	Sun, 22 Mar 2026 17:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774200677;
	bh=1Znp/LkwnTopQHFTgzY+BV9K+X9J2j1oFk72Tew2sf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PWXH9gKYw7bu5kWBM9sUEJqi/4GGlVgO3SbbMDsxH7gMMiBobcs2nBsVvLh9OvGJo
	 cwWpeAvtz0/MnokHzh2ZYHrx4MSwnSI7CfBmuflOxz7p8zcNYFb9PFKMrzLzIT+pnx
	 TuULlwfoAVeaifnWSFeq7RCa+HlXGoOvApBX7q0jwvtQljdDK4uhRfebW+xehg1UaO
	 m+qPvaGE626QUYvb2QqxBJ0a6WoVnvclEiEKQJwUA/xQsT864ft+eupFkbIz3TETgg
	 wI4ySlhpWM1/vvGEZcknPI4w0hoKJwwmL3Fl4VqWbtrnnj1tpakhB8UxHjhl/WJhk/
	 5Zv5Up8N1CEgQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 09D78F40071;
	Sun, 22 Mar 2026 13:31:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 22 Mar 2026 13:31:16 -0400
X-ME-Sender: <xms:YyfAaW4Rt8qdxxsoyN8a50phyS__SsWQF7cU9tiFHLzszVQXj6gtmw>
    <xme:YyfAaZSLaRBzCmAoXYRomqXd_0eO-1aNkoivjbcUzCL3ttH5FRxhE8QQRES0UnqBz
    Y2at0mjjJngFoR_HFFEG7T-MGDZZakPCgTo0BHg__4ugRTceQNUwA>
X-ME-Received: <xmr:YyfAad-jxqQX11Lamp0H2AUIebTeGnUhLVuGNfLKGhIBK22f6DY3akTm56IuHMb_H_SuERTgTIKz-XK5uoB2mYPGDH38OLE1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeigeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fhudegieevvdetgfeugfeuteekfeegkeeggfehkedugeehgffhheelkeeftdetudenucff
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
X-ME-Proxy: <xmx:YyfAaSqemk_9MfvBUZFcFhH2McBWku0zkqAdl20wSW3lDucZqO70oQ>
    <xmx:YyfAabUZVOgWjokQNkJ1RnYoCpD4L5RE3_Za6cboXIPvG0Zh8GXxPQ>
    <xmx:YyfAaf5ZRdHA0hMO6eEIRC1He7scoS6OL1Ck9qMcF8YOtfEvUylK2Q>
    <xmx:YyfAaZAnf11KQrUx_LcvIVxMywZdzWGlko1C0kpG44E254DujXfkkg>
    <xmx:ZCfAaTf3s67NjMfgmq-Stx2jstsSANnv2zU6vqmI9M_4Y3vQsNk8-0Ia>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Mar 2026 13:31:15 -0400 (EDT)
Date: Sun, 22 Mar 2026 10:31:14 -0700
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
Message-ID: <acAnYrlkkUvbNkGG@tardis.local>
References: <ab7SQ3L1F-ap7mNl@tardis.local>
 <492ba226-79c7-4345-b691-eb775082b799@paulmck-laptop>
 <ab7eQ0QDNV9ZjQMN@tardis.local>
 <609b5df1-aa06-46a9-8e93-0bf9eb8b7738@paulmck-laptop>
 <ab71Vz9zmlVywWQT@tardis.local>
 <4d2b07a9-e3fd-4a95-8924-0839bdfc28b3@paulmck-laptop>
 <ab7623FFsiUOocHP@tardis.local>
 <3486c7a2-73e6-46f2-a030-c9349ce964dd@paulmck-laptop>
 <acAV-16pYQvy06aw@tardis.local>
 <902d80c5-02a9-46d0-9d6a-06e8cd94cd37@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <902d80c5-02a9-46d0-9d6a-06e8cd94cd37@paulmck-laptop>

On Sun, Mar 22, 2026 at 10:09:53AM -0700, Paul E. McKenney wrote:
> On Sun, Mar 22, 2026 at 09:16:59AM -0700, Boqun Feng wrote:
> > On Sun, Mar 22, 2026 at 03:09:19AM -0700, Paul E. McKenney wrote:
> > > On Sat, Mar 21, 2026 at 01:08:59PM -0700, Boqun Feng wrote:
> > > > On Sat, Mar 21, 2026 at 01:07:45PM -0700, Paul E. McKenney wrote:
> > > > > On Sat, Mar 21, 2026 at 12:45:27PM -0700, Boqun Feng wrote:
> > > > > > On Sat, Mar 21, 2026 at 12:31:04PM -0700, Paul E. McKenney wrote:
> > > > > > > On Sat, Mar 21, 2026 at 11:06:59AM -0700, Boqun Feng wrote:
> > > > > > > > On Sat, Mar 21, 2026 at 10:41:47AM -0700, Paul E. McKenney wrote:
> > > > > > > > [...]
> > > > > > > > > > > +	raw_spin_lock_rcu_node(ssp->srcu_sup);
> > > > > > > > > > > +	delay = srcu_get_delay(ssp);
> > > > > > > > > > > +	raw_spin_unlock_rcu_node(ssp->srcu_sup);
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > It was fixed differently in v2:
> > > > > > > > > > 
> > > > > > > > > > 	https://lore.kernel.org/rcu/20260320222916.19987-1-boqun@kernel.org/
> > > > > > > > > > 
> > > > > > > > > > I used _irqsave/_irqrestore just in case. Given it's an urgent fix,
> > > > > > > > > > overly careful code is probably fine ;-)
> > > > > > > > > > 
> > > > > > > > > > Thanks for the testing and feedback.
> > > > > > > > > 
> > > > > > > > > OK, I will try that one, thank you!
> > > > > > > > > 
> > > > > > > > > FYI, with my change on your earlier version, SRCU-T got deadlocks between
> > > > > > > > > the pi-lock and the workqueue pool lock.  Which might or might not be
> > > > > > > > > particularly urgent.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > I just checked my run yesterday, I also hit it. It's probably what
> > > > > > > > Zqiang has found:
> > > > > > > > 
> > > > > > > > 	https://lore.kernel.org/rcu/4c23c66f86a2aff8f2d7b759f9dd257b82147a17@linux.dev/
> > > > > > > > 
> > > > > > > > We have a queue_work_on() in srcu_schedule_cbs_sdp(), so
> > > > > > > > 
> > > > > > > >     srcu_torture_deferred_free():
> > > > > > > >       raw_spin_lock_irqsave(->pi_lock,...);
> > > > > > > >       call_srcu():
> > > > > > > >         if (snp == snp_leaf && snp_seq != s) {
> > > > > > > >            srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0):
> > > > > > > > 	     if (!delay)
> > > > > > > >                queue_work_on(...)
> > > > > > > > 
> > > > > > > > I was about to reply to Zqiang, fixing that could be a touch design
> > > > > > > > decision. Since it's a per srcu_data work ;-) NR_CPUS x irq_work
> > > > > > > > incoming.
> > > > > > > 
> > > > > > > Just to be clear, SRCU-T is Tiny SRCU rather than Tree SRCU.  So perhaps
> > > > > > > lower priority, though perhaps not lower irritation.  ;-)
> > > > > > 
> > > > > > I see, there is a schedule_work() in srcutiny's
> > > > > > srcu_gp_start_if_needed(). But it couldn't cause deadlock on UP since
> > > > > > locks are (almost) no-op. Maybe we can make RCU torture only test it on
> > > > > > SMP?
> > > > > 
> > > > > Like this, you mean?  I will give it a shot tomorrow.
> > > > 
> > > > Yes, thanks!
> > > 
> > > OK, the previous patch did fine on short rcutorture testing aside from
> > > the !SMP lockdep splat, so I have started the test without pi_lock.
> > > 
> > > Longer term, shouldn't lockdep take into account the fact that on !SMP,
> > > the disabling of preemption (or interrupts or...) is essentially the same
> > > as acquiring a global lock?  This means that only one task at a time can
> > > be acquiring a raw spinlock on !SMP, so that the order of acquisition
> > > of raw spinlocks on !SMP is irrelevant?  (Aside from self-deadlocking
> > > double acquisitions, perhaps.)  In other words, shouldn't lockdep leave
> > > raw spinlocks out of lockdep's cycle-detection data structure?
> > 
> > Lockdep doesn't know whether a code path is UP-only, so it'll apply the
> > general locking rule to check. Similar as lockdep still detect
> > PREEMPT_RT locking issue for !PREEMPT_RT kernel. Maybe we can add a
> > separate kconfig to narrow down lockdep detection for UP-only if UP=y.
> 
> But lockdep *does* know when it is running in a CONFIG_SMP=n kernel,
> correct?  In which case all the code paths are UP-only.
> 

Why? UP and SMP can share the same code path, no? Just because lockdep
is running in UP and see a code path, doesn't mean that code path is
UP-only, right? What I was trying to say is Lockdep detects generel
locking rule violation, so even when it's running in UP kernel, it'll
use rules that SMP uses.

> The situation with CONFIG_PREEMPT_RT=y is quite different: The motivation
> was for people running lockdep on CONFIG_PREEMPT_RT=n kernels to
> detect and fix locking issues that would otherwise only show up in
> CONFIG_PREEMPT_RT=y kernels.
> 

I'm not sure how it's different than people wanted to detect SMP=y
locking issues when running UP kernel. Of course, I didn't know whether
that's the intention because I wasn't there ;-)

Regards,
Boqun

> And of course, CONFIG_SMP=n kernels still need deadlock detection for
> mutexes and the like.
> 
> 							Thanx, Paul
