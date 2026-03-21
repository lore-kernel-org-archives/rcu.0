Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515682C1586
	for <rcu@vger.kernel.org>; Sat, 21 Mar 2026 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774122331; cv=none; b=QjDq1FrOd5PYNgurpFiROemjngm+C0+0KZcZaDkvvfo5w21fYMds7AvmUtBHydmoxQr3jc0lFSHFemiCviJMWy3HTB0Sdv8jskPSPlmOb7eo1aqO7IDC4GHDtqksIpC5aujnCfKEKUA1Lzbuzo0f74kEJhyVn4Zc5hWcICXB3+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774122331; c=relaxed/simple;
	bh=UZaHZ43UtKwYrDvozF15j133cHdPTpTHKvJWSIom670=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiJmgtoQCebAiBNZBW0xzUVgOpZiPpOfmOUxkBb3ttqbWcAeKgiUjo6wwg11TROzVLZxqYbAAGFQg8v8aV3PfpPSyYtY/rn5IWw6M3Ad3WI0z3OOb9fa+I5/Yy6THrOhwFCtnxyBJJXCSgfc2pNY4M8dGlbMhuvt8EBcTCZbUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtK6CjUi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtK6CjUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF51C2BCAF;
	Sat, 21 Mar 2026 19:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774122330;
	bh=UZaHZ43UtKwYrDvozF15j133cHdPTpTHKvJWSIom670=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtK6CjUieeoxfnGXpuvzJE6Vj3AIcOFzv69fNhIVfqf1FE9L91OxSVqXHWJ62ve9G
	 Tk+91dd5PHhxXab08wMPoQJlre60P9QhvsaldU8eykEi7KRjSPBT/ixOBlSXdnFFKJ
	 xew0Ku3CrmQqU7RTvGe5Ok5H/nGw69YJiFYQXnCyngjKICIqd4kN7RoDNxusHTQNgA
	 etw+1Hln7t0mSVJdnba1SPUr1O+et0QSv6HoDF6jJB280nh64r1bSBH6BCv1HPzPMr
	 TiYtKmV4YRDDnAEkmwxQGR6El6+SSQDfCJ3DP8sMkd09Jh5zwlKxAKNbYEhbt9NKyf
	 f9gt+3zJ/yg5Q==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5C773F4007F;
	Sat, 21 Mar 2026 15:45:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 21 Mar 2026 15:45:29 -0400
X-ME-Sender: <xms:WfW-aX8ft7fYP5XvsSQhbOwfCSG6wRGbOaFr58igiGwbzbgL3jGHkA>
    <xme:WfW-adHOvrtGz3LuxMrL4rOcVs62VC8i8yA9R5DvYeI7FJKE4cRo_yKEHGlEAdGlM
    A2GdQL_n5OqHpRS2pOSP2DYw967N5FlS9g123J631NZq31KpbCtMg>
X-ME-Received: <xmr:WfW-adgSuRTO9bEI8O_tkcBh1X3MR8oIb1ZvD70tkHxT2ZnpJ4h3f1Tt1E_CTgNX1P__q3ahOT2sE-oBUijb9wgclzZZ3rgd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudefjeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WfW-aS-UEwUaCWUk9ymOi3QrOQ3mo-7DPu1zkhVnw4Cn12hsZ2cv1A>
    <xmx:WfW-adZXefzTlAtn3ozu_77d6aqEpFtB6oA2Bgfsq5i-XZXMqvqz_A>
    <xmx:WfW-aQt0Xr_WgUvtY8J0QsyxGrPSDApnsJzxLZ_ksYY084Ew_VthGw>
    <xmx:WfW-aRntkpU8Cb11lp54hEvxkkOu-NRk19Madc3-o-vesMW2D37agA>
    <xmx:WfW-aYwo5DroKtbNQEw2iCn_Kne6f6peD-lkScsS14-coWl4Kd_kAIow>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 15:45:28 -0400 (EDT)
Date: Sat, 21 Mar 2026 12:45:27 -0700
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
Message-ID: <ab71Vz9zmlVywWQT@tardis.local>
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
 <b4857e4f-5a8d-4ccc-9e8b-df57718e4aee@paulmck-laptop>
 <ab7SQ3L1F-ap7mNl@tardis.local>
 <492ba226-79c7-4345-b691-eb775082b799@paulmck-laptop>
 <ab7eQ0QDNV9ZjQMN@tardis.local>
 <609b5df1-aa06-46a9-8e93-0bf9eb8b7738@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <609b5df1-aa06-46a9-8e93-0bf9eb8b7738@paulmck-laptop>

On Sat, Mar 21, 2026 at 12:31:04PM -0700, Paul E. McKenney wrote:
> On Sat, Mar 21, 2026 at 11:06:59AM -0700, Boqun Feng wrote:
> > On Sat, Mar 21, 2026 at 10:41:47AM -0700, Paul E. McKenney wrote:
> > [...]
> > > > > +	raw_spin_lock_rcu_node(ssp->srcu_sup);
> > > > > +	delay = srcu_get_delay(ssp);
> > > > > +	raw_spin_unlock_rcu_node(ssp->srcu_sup);
> > > > > 
> > > > 
> > > > It was fixed differently in v2:
> > > > 
> > > > 	https://lore.kernel.org/rcu/20260320222916.19987-1-boqun@kernel.org/
> > > > 
> > > > I used _irqsave/_irqrestore just in case. Given it's an urgent fix,
> > > > overly careful code is probably fine ;-)
> > > > 
> > > > Thanks for the testing and feedback.
> > > 
> > > OK, I will try that one, thank you!
> > > 
> > > FYI, with my change on your earlier version, SRCU-T got deadlocks between
> > > the pi-lock and the workqueue pool lock.  Which might or might not be
> > > particularly urgent.
> > > 
> > 
> > I just checked my run yesterday, I also hit it. It's probably what
> > Zqiang has found:
> > 
> > 	https://lore.kernel.org/rcu/4c23c66f86a2aff8f2d7b759f9dd257b82147a17@linux.dev/
> > 
> > We have a queue_work_on() in srcu_schedule_cbs_sdp(), so
> > 
> >     srcu_torture_deferred_free():
> >       raw_spin_lock_irqsave(->pi_lock,...);
> >       call_srcu():
> >         if (snp == snp_leaf && snp_seq != s) {
> >            srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0):
> > 	     if (!delay)
> >                queue_work_on(...)
> > 
> > I was about to reply to Zqiang, fixing that could be a touch design
> > decision. Since it's a per srcu_data work ;-) NR_CPUS x irq_work
> > incoming.
> 
> Just to be clear, SRCU-T is Tiny SRCU rather than Tree SRCU.  So perhaps
> lower priority, though perhaps not lower irritation.  ;-)
> 

I see, there is a schedule_work() in srcutiny's
srcu_gp_start_if_needed(). But it couldn't cause deadlock on UP since
locks are (almost) no-op. Maybe we can make RCU torture only test it on
SMP?

Regards,
Boqun

> 							Thanx, Paul
