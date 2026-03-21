Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477736A013
	for <rcu@vger.kernel.org>; Sat, 21 Mar 2026 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123743; cv=none; b=DstuiTFbwo7zIgNC3zRbugUqbWu4YPKsIGXjWtyS1YI6x6y8lg6SvBCSM9cqgG5ElMIPhjbkF9silXocKpv7JrXclpax/w1MqJT4tye1Por2er0lXJWpMBeLxTX3jrygLblk0Sr6ngHhxymY/TQppc34bHY52egwp51OeKEH9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123743; c=relaxed/simple;
	bh=Na5uV7GMFd98q0d31tyJbIZ813Y+idgZCEKmjaCHFKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5Z09UnpombIW2MZEBC612NQoVLhwYP+SZGSaFb+O1tp+z2HtaenobUVV6AJHPnVeBTvLTTFEYlWL/61mzXVKyijjrKuAaU9QMHeoNL9B21uag8q9lAALUVBAFDbwS+b2YFBRPIC8y3Zfy9naP7vJ2mq9+Kg+nWP6utOaR1X9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH0eEoOR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH0eEoOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBF5C2BCAF;
	Sat, 21 Mar 2026 20:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774123743;
	bh=Na5uV7GMFd98q0d31tyJbIZ813Y+idgZCEKmjaCHFKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gH0eEoORNb/n9uDzvdyS5nbpRCh5GUso7/mF9ydwtFGt5OjVgnSDGadvheWSDWq8m
	 SD44odaeV4IfLHfAYBaMbEJsKoliDkHj7e4BScTE7CHO1kLvodwC4yLM9w6fnBgjHG
	 5PnZA4i4Nu0O8Z2XJvgQ0gSg5gZ1vuDQFLy6RQEmx5eilCTfaOoNJSKWsT9Y9NWKj1
	 XRQaEWEx7hbCNY/Vc9n1qvDmjLIV8X8K2XTUaViKe1Rl01/PaN+w9JChNlz817pMfr
	 OGLIFN2iunv0HVZroc1oNp4y7+onoFz/QsR4rmYi7Q28lqLYAaecRHPQ6bpyQBXeCx
	 nAOUgqjy3DeGw==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 81357F40068;
	Sat, 21 Mar 2026 16:09:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 21 Mar 2026 16:09:01 -0400
X-ME-Sender: <xms:3fq-aSmOjZ8YwZ6e9ldW96mDx8oC-5nPn8iMEuKNKZW6qCafw_HPvw>
    <xme:3fq-aTOpMIrneGXWEJLQi-R-qm71sNL4mS7kx6CMAtd90j4HJhntLZOUKYkaLR-Pa
    PaLs1TUWk_r2-YjMadqLNSlWTxzNwPTLdCWH_2xpPp--B17re-3sw>
X-ME-Received: <xmr:3fq-aZIav5OybE6ZJ7wSh4EvD1WTUAPmfDWdRbn3rKx7eok1HDRZs8_pyH3Z_4jV3whvh2TChpG-LeQc1WX6LXav4hRfeYqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudefjeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:3fq-aWH6DfE2mnsLcOf0HMZpYQDuAjy2vcMbcUUicQOZ5yHiDM3W4w>
    <xmx:3fq-aSDH___ZdJcZtxInI10f5atdGQP929-oV11qxd4JsaxN1XkyAg>
    <xmx:3fq-aY1S0MsRAzvtj6NZtd5LeeEutmB38cWvB2cBCuao_OvMdd327Q>
    <xmx:3fq-aXN2zwvldbsmq32ACW86cPjuaHGfPSMv8Et8bMdN42PC-pF9IA>
    <xmx:3fq-ad5_CaHe7wvoBe6E3pk4Wo0qIWlNBJbAlzjDzgxwlqDPsa9YzYfN>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 16:09:00 -0400 (EDT)
Date: Sat, 21 Mar 2026 13:08:59 -0700
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
Message-ID: <ab7623FFsiUOocHP@tardis.local>
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
 <b4857e4f-5a8d-4ccc-9e8b-df57718e4aee@paulmck-laptop>
 <ab7SQ3L1F-ap7mNl@tardis.local>
 <492ba226-79c7-4345-b691-eb775082b799@paulmck-laptop>
 <ab7eQ0QDNV9ZjQMN@tardis.local>
 <609b5df1-aa06-46a9-8e93-0bf9eb8b7738@paulmck-laptop>
 <ab71Vz9zmlVywWQT@tardis.local>
 <4d2b07a9-e3fd-4a95-8924-0839bdfc28b3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d2b07a9-e3fd-4a95-8924-0839bdfc28b3@paulmck-laptop>

On Sat, Mar 21, 2026 at 01:07:45PM -0700, Paul E. McKenney wrote:
> On Sat, Mar 21, 2026 at 12:45:27PM -0700, Boqun Feng wrote:
> > On Sat, Mar 21, 2026 at 12:31:04PM -0700, Paul E. McKenney wrote:
> > > On Sat, Mar 21, 2026 at 11:06:59AM -0700, Boqun Feng wrote:
> > > > On Sat, Mar 21, 2026 at 10:41:47AM -0700, Paul E. McKenney wrote:
> > > > [...]
> > > > > > > +	raw_spin_lock_rcu_node(ssp->srcu_sup);
> > > > > > > +	delay = srcu_get_delay(ssp);
> > > > > > > +	raw_spin_unlock_rcu_node(ssp->srcu_sup);
> > > > > > > 
> > > > > > 
> > > > > > It was fixed differently in v2:
> > > > > > 
> > > > > > 	https://lore.kernel.org/rcu/20260320222916.19987-1-boqun@kernel.org/
> > > > > > 
> > > > > > I used _irqsave/_irqrestore just in case. Given it's an urgent fix,
> > > > > > overly careful code is probably fine ;-)
> > > > > > 
> > > > > > Thanks for the testing and feedback.
> > > > > 
> > > > > OK, I will try that one, thank you!
> > > > > 
> > > > > FYI, with my change on your earlier version, SRCU-T got deadlocks between
> > > > > the pi-lock and the workqueue pool lock.  Which might or might not be
> > > > > particularly urgent.
> > > > > 
> > > > 
> > > > I just checked my run yesterday, I also hit it. It's probably what
> > > > Zqiang has found:
> > > > 
> > > > 	https://lore.kernel.org/rcu/4c23c66f86a2aff8f2d7b759f9dd257b82147a17@linux.dev/
> > > > 
> > > > We have a queue_work_on() in srcu_schedule_cbs_sdp(), so
> > > > 
> > > >     srcu_torture_deferred_free():
> > > >       raw_spin_lock_irqsave(->pi_lock,...);
> > > >       call_srcu():
> > > >         if (snp == snp_leaf && snp_seq != s) {
> > > >            srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0):
> > > > 	     if (!delay)
> > > >                queue_work_on(...)
> > > > 
> > > > I was about to reply to Zqiang, fixing that could be a touch design
> > > > decision. Since it's a per srcu_data work ;-) NR_CPUS x irq_work
> > > > incoming.
> > > 
> > > Just to be clear, SRCU-T is Tiny SRCU rather than Tree SRCU.  So perhaps
> > > lower priority, though perhaps not lower irritation.  ;-)
> > 
> > I see, there is a schedule_work() in srcutiny's
> > srcu_gp_start_if_needed(). But it couldn't cause deadlock on UP since
> > locks are (almost) no-op. Maybe we can make RCU torture only test it on
> > SMP?
> 
> Like this, you mean?  I will give it a shot tomorrow.
> 

Yes, thanks!

Regards,
Boqun

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 3c8e4cd5b83e6..afef343eb8a19 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -843,7 +843,7 @@ static unsigned long srcu_torture_completed(void)
>  static void srcu_torture_deferred_free(struct rcu_torture *rp)
>  {
>  	unsigned long flags;
> -	bool lockit = jiffies & 0x1;
> +	bool lockit = IS_ENABLED(CONFIG_SMP) && (jiffies & 0x1);
>  
>  	if (lockit)
>  		raw_spin_lock_irqsave(&current->pi_lock, flags);
