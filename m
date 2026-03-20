Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF9F352C58;
	Fri, 20 Mar 2026 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774040763; cv=none; b=m5M4H7u5G62O/f/p4+OQJRfszpsMsq+38hLh1b8+uw6MYq3GCMIPy4Se8kfQ2K4E79OomtvNoYg/sBCnKzJbceGqVB2Z0XuWAAvq6iHlknIkBXIgmBp2e52QNGEx/V5lSQOmUIJUx20ooLw5ltCWHsylDahjv1eA64WGw75EEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774040763; c=relaxed/simple;
	bh=l/kKS6/2hdgLK6ptqj9CCRPuYF3gtXUUOvnmoYMnvm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hE/4NaTbiYthPu+bfM0KjubvgnIY4aPqXKjXbXi5eemmfgZxbUr4LFFm5VN7sAs//l4RpoYZMEJcrZrDZnAIjq/KyxgjA026jl1RutxllctNmTj7lLcvmagtxvm8K3mOx2Xu2EPihBmKfFOgGbHbDToViFkAH6woYhWrsA1KKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn7JjKUu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn7JjKUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AD2C2BC87;
	Fri, 20 Mar 2026 21:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774040763;
	bh=l/kKS6/2hdgLK6ptqj9CCRPuYF3gtXUUOvnmoYMnvm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wn7JjKUuBzANBiRUr+l4MqW/t1A4GZpYYazL/xY5TeGSRIf5Q/7+kn0ML/wfX4LpS
	 o9ojTBEzMyliUsocJG/pxBZE1bKfPed2YN9Gi7Yr4tdPvBFoSXbzoqQmm2wspeh4IV
	 hWhEALP9EF5TmY5uTKyLmJvLemSPxfy2JVk0i53hxPl9h6VtGSRw3dwxa3zAv/ry4K
	 Ht5w1WhzCTRbTra2cAVVxFg6K65yzvJgPu7WLy5V6gWbJ4ex49YVvzQGZByC3Q23wb
	 z8H12R8fg3sXVbhNjYY9on6Z2kG6Pe8J0FFTf3XSNvr5DYnvMoMnd0xfuf3CJb06VY
	 VkcmywwQQtHoQ==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 141A3F40069;
	Fri, 20 Mar 2026 17:06:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 20 Mar 2026 17:06:02 -0400
X-ME-Sender: <xms:uba9aRcSneLH_GIrv6PeR9LV05inoJswjfL4gxY9a9HCQ2s1TN23EA>
    <xme:uba9aYmpuwtuofuiqbQXRxCyZJd0JG_DhOMCSWA7dYEGKRkZq9APhSiq9GDU7pUEn
    gV8HM4xC0qpfQHUo6yTdrEfDhhc1I2rB8cDqPAb261EUFcA-3UZfA>
X-ME-Received: <xmr:uba9aTCDg4FZbXEWBc92ZJMcwmxxcTH5_X3qPiMYLpiEOnVcR7c80D4V34Xufgw8ykebmLBMBXhv9K6WKRwnEXeCvdVdbHAq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elueehtefhtddtgfejvdejueehhfekteevueeuueekgeetieeggeehvdffhefhhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrrhhighhhihesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthho
    pehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvghmgihorhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigidr
    uggvpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehnvggvrhgrjhdrihhithhruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhr
    vgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:ura9aad5VBmzt9nbPtt44b1yE5vXK4yTOM5Fx_09FQm7E4rqcgUltQ>
    <xmx:ura9ae7b5IS0CifP-At6ziys6r_6q0UWW0HE2s8_K1qPwEtzQLYkQg>
    <xmx:ura9aUNC8wNYIfwn1h1tbRvh8_cjx4hAeYHWk5irzmsgXJPn7sdyyw>
    <xmx:ura9afEK1SXV1ZzoEK_pfvhyOmFOYBiayDOpXjPmKLU8AFTAXJ_d5g>
    <xmx:ura9aYTt-uCxPoj0RuRD4Ev7_qwx5LzRPqnLjvkpNPg19wnikfGs_b38>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 17:06:01 -0400 (EDT)
Date: Fri, 20 Mar 2026 14:06:00 -0700
From: Boqun Feng <boqun@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] rcu: Use an intermediate irq_work to start process_srcu()
Message-ID: <ab22uNqrGoVB_KmB@tardis.local>
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
 <ab2yd35rm6OgZUmb@gpd4>
 <ab2z6XRzTajNADK2@tardis.local>
 <ab21dx-Z1zE-TI4s@gpd4>
 <ab211KSqJI9gzTUd@gpd4>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab211KSqJI9gzTUd@gpd4>

On Fri, Mar 20, 2026 at 10:02:12PM +0100, Andrea Righi wrote:
> On Fri, Mar 20, 2026 at 10:00:47PM +0100, Andrea Righi wrote:
> > On Fri, Mar 20, 2026 at 01:54:01PM -0700, Boqun Feng wrote:
> > > On Fri, Mar 20, 2026 at 09:47:51PM +0100, Andrea Righi wrote:
> > > > Hi Boqun,
> > > > 
> > > > On Fri, Mar 20, 2026 at 11:14:00AM -0700, Boqun Feng wrote:
> > > > > Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> > > > > of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> > > > > happen basically everywhere (including where a scheduler lock is held),
> > > > > call_srcu() now needs to avoid acquiring scheduler lock because
> > > > > otherwise it could cause deadlock [1]. Fix this by following what the
> > > > > previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> > > > > the work to start process_srcu().
> > > > > 
> > > > > [boqun: Apply Joel's feedback]
> > > > > 
> > > > > Reported-by: Andrea Righi <arighi@nvidia.com>
> > > > > Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> > > > > Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> > > > > Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> > > > > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > > > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > > > > ---
> > > > > @Zqiang, I put your name as Suggested-by because you proposed the same
> > > > > idea, let me know if you rather not have it.
> > > > > 
> > > > > @Joel, I did two updates (including your test feedback, other one is
> > > > > call irq_work_sync() when we clean the srcu_struct), please give it a
> > > > > try.
> > > > 
> > > > I'm getting this at boot with this patch applied (testing directly from
> > > > Joel's branch rcu/dev):
> > > > 
> > > > [    0.639477] DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
> > > 
> > > My bad, this is missing:
> > > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 73aef361a524..e08aaacad695 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1993,13 +1993,14 @@ static void srcu_irq_work(struct irq_work *work)
> > >         struct srcu_struct *ssp;
> > >         struct srcu_usage *sup;
> > >         unsigned long delay;
> > > +       unsigned long flags;
> > > 
> > >         sup = container_of(work, struct srcu_usage, irq_work);
> > >         ssp = sup->srcu_ssp;
> > > 
> > > -       raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
> > > +       raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
> > >         delay = srcu_get_delay(ssp);
> > > -       raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
> > > +       raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
> > > 
> > >         queue_delayed_work(rcu_gp_wq, &sup->work, !!delay);
> > >  }
> > 
> > Ah yes, much better with this one. :) And I confirm that it fixes the
> > initial locking issue that I reported.
> 
> Forgot to add my:
> 
> Tested-by: Andrea Righi <arighi@nvidia.com>
> 

Thank you ;-)

Regards,
Boqun

> -Andrea
