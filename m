Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BCB382299
	for <rcu@vger.kernel.org>; Mon, 23 Mar 2026 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304024; cv=none; b=U1H9gJhgy5/riXNVc6m5RGsdXB2WhGVVqgPrqBI2nmFC5exrpI51MGsB/ebsonLJNfbAx4jtWlpBIulDzj1a0WmahO9tOu9Z1MjWhWIpvAefFmgKBK0hImWnh8ninF6qtpSwFS5qvv+YdsJw7FYKrJOFtuDRyhZgK39oZtH/900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304024; c=relaxed/simple;
	bh=p9lC7Nl6cczyTh3iSW5dtTx38VCtXweTWQ9ahOE1YH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFEJz/mH0kVg2y00e2gGf30JvItflRqwHHTbYN3WSEUEWlLroShauqL6/VsLhkuN2gP1jW/47wKU79d01cLQW3UV3ScXMIMRsjQ8/AE36WpnVUm08HCbsuh0040gBMqJWY+UWyH5cAbocke3LrINZ5VXCibUjrPK9Rf3zJ2qpM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=of7k5AdK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of7k5AdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E76C4CEF7;
	Mon, 23 Mar 2026 22:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774304023;
	bh=p9lC7Nl6cczyTh3iSW5dtTx38VCtXweTWQ9ahOE1YH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=of7k5AdKUgHdpD66yuN1DohPfZwS5hXlmuqcQ/2zTG9URJjUKo9FZlxQrpqK2ahMx
	 IRa1zhksMItXOz8kco6PTaZchK77CSVTKCMWBhKR+jSkXTnuw2scz0/oen+mCUmVal
	 itZYHDAqmS0G4Reelv3Y7eVZrWZ8I6oUal1zrfZG+vb2A7sRq9wWY4v/aHq6fMlpIJ
	 6Tm9B3XjIS8UtGsoMqdplIXy2+GxBns7+VR0B9teJA3MQniUYPkgn0/+EeEQbnwTSU
	 EbcR5liuMBffi4bkQZ4Mtq/9RE4brfHY8xzXcWwBfCTldGuQ3nEVKAYoABopFjOmdi
	 7Zmc5jNB+IkQw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 89D56F4006C;
	Mon, 23 Mar 2026 18:13:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 23 Mar 2026 18:13:42 -0400
X-ME-Sender: <xms:FrvBaRPrlswhdf9gGv1LgyQhAe2iGsIW77Cb4nGZ0mONIvV0fpeH0g>
    <xme:FrvBadV0X7R7izdQAgnv794J3lRJAI8DFmTQ2kfjGVwdykj-foOi6h5fUT_gNCmk-
    q-m3Wvn9j4Y1_7P_Ok2NSonjqqRylcVOsY76phEyBNVmV2x8mqMpKE>
X-ME-Received: <xmr:FrvBaYxa98n2d4waUzMCviKfcwllD2xrO7BXPwCzxzK6NhL9NDOOfl281mFYU5pu05kCzDefs-ZCamU_C3pr_Ez70f3cPtDR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fhveeuvdfggfefuedtgeefvedtteekveeitefffffgfefhvddvhfeijedvudeggeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeejkeehheehvd
    dqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpdhnsggprhgt
    phhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvmhigohhrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvhhiughirgdr
    tghomhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepfhhrvggu
    vghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdrihhithhrud
    dtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FrvBadPT81bBuv9MOPx6ox07TqfIBa-yu4Nf-xLIksABY9n7g6DQUw>
    <xmx:FrvBaarIUTWl-N9-OupfHOcQuXnWfOXl-dSgQfZ6qc2KYrFUqWj_0w>
    <xmx:FrvBaU_2VETXcqqaMaBWFE0qILTI3sUshKwu16B_kzybfVGoRapmIQ>
    <xmx:FrvBaQ18QbrtDHZemXT2ul9BhqTaN6sHddtCkrTtDm_cl3zX_oREBQ>
    <xmx:FrvBaXA-lg7C-0Xg7P2Ina17fGlZbe0xlRKjUrrVNR32R85ej-fFBZIx>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 18:13:41 -0400 (EDT)
Date: Mon, 23 Mar 2026 15:13:40 -0700
From: Boqun Feng <boqun@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Song Liu <song@kernel.org>, stable@kernel.org
Subject: Re: [RFC PATCH] rcu-tasks: Avoid using mod_timer() in
 call_rcu_tasks_generic()
Message-ID: <acG7FK-_1EFzYtbs@tardis.local>
References: <2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop>
 <20260321170321.32257-1-boqun@kernel.org>
 <acFZem9MNHRXin2h@tardis.local>
 <CAP01T761Y4AMau-4OyuvgSCNMHRD-3YW6+8JDYFxm0Nf9ycwaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T761Y4AMau-4OyuvgSCNMHRD-3YW6+8JDYFxm0Nf9ycwaw@mail.gmail.com>

On Mon, Mar 23, 2026 at 10:50:18PM +0100, Kumar Kartikeya Dwivedi wrote:
> On Mon, 23 Mar 2026 at 16:17, Boqun Feng <boqun@kernel.org> wrote:
> >
> > On Sat, Mar 21, 2026 at 10:03:21AM -0700, Boqun Feng wrote:
> > > The following deadlock is possible:
> > >
> > > __mod_timer()
> > >   lock_timer_base()
> > >     raw_spin_lock_irqsave(&base->lock)   <- base->lock ACQUIRED
> > >   trace_timer_start()                    <- tp_btf/timer_start fires here
> > >     [probe_timer_start BPF program]
> > >       bpf_task_storage_delete()
> > >         bpf_selem_unlink(selem, false)   <- reuse_now=false
> > >           bpf_selem_free(false)
> > >             call_rcu_tasks_trace()
> > >               call_rcu_tasks_generic()
> > >                 raw_spin_trylock(rtpcp)  <- succeeds (different lock)
> > >                 mod_timer(lazy_timer)    <- lazy_timer is on this CPU's base
> > >                   lock_timer_base()
> > >                     raw_spin_lock_irqsave(&base->lock) <- SAME LOCK -> DEADLOCK
> > >
> > > because BPF can instrument a place while the timer base lock is held.
> > > Fix it by using an intermediate irq_work.
> > >
> > > Further, because a "timer base->lock" to a "rtpcp lock" lock dependency
> > > can be establish in this way, we cannot mod_timer() with a rtpcp lock
> > > held. Fix that as well.
> > >
> > > Fixes: d119357d0743 ("rcu-tasks: Treat only synchronous grace periods urgently")
> > > Cc: stable@kernel.org
> > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > > ---
> > > This is a follow-up of [1], and yes we can trigger a whole system
> > > deadlock freeze easily with (even non-recursively) tracing the
> > > timer_start tracepoint. I have a reproduce at:
> > >
> > >       https://github.com/fbq/rcu_tasks_deadlock
> > >
> > > Be very careful, since it'll freeze your system when run it.
> > >
> > > I've tested it on 6.17 and 6.19 and can confirm the deadlock could be
> > > triggered. So this is an old bug if it's a bug.
> > >
> > > It's up to BPF whether this is a bug or not, because it has existed for
> > > a while and nobody seems to get hurt(?).
> > >
> >
> > Ping BPF ;-) I know this was sent in a Saturday and only 2 days have
> > passed, but we are at the decision point about how hard/urgent we should
> > fix these "BPF deadlocks": As this patch shows, the deadlocks existed
> > before v7.0 (i.e. before SRCU switches). And yes, ideally we should fix
> > all of them, but given we are close to v7.0 release, I would like to
> > focus the new issue that SRCU introduces, because that one would likely
> > affect SCHED_EXT. Thoughts?
> 
> I tried both of your changes, thanks for working on these. I agree the

No problem. :)

> one reported by Andrea is more important, so that should be the first
> priority and should be sent as a fix for 7.0.
> 

Agreed. I will work with Joel to forward these fixes to Linus.

> It would be good to make the timer-related fix too, but it doesn't
> need to be rushed for 7.0. We're aware of the issue being fixed by
> this patch in timer tracepoints [0].
> It's a corner case which no one has hit thus far. We already made
> similar fixes where we could, e.g. [1], but it's difficult to make a
> similar change for local storage.
> 

Right, we need more time to cover all the cases. For example, there is 
tracepoint inside irq_work_queue() where we can instrument it within
BPF, that could open a lot of fun interactions. ;-)

> Given Paul said he plans into looking into call_{s,}rcu_nolock()
> anyway, the guard can be dropped once call_{s,}rcu_nolock()
> materializes.
> 
> Something like what you did in this patch would be prerequisite for
> the call_{s,}rcu_nolock() anyway, the assumption will be that it could
> be invoked from NMI, so reentrancy can happen anywhere, it doesn't
> matter much then whether it happens in the same context when the lock
> is held and we end up invoking the same path through call_srcu(), or
> when an NMI prog interrupts when the timer lock is held.
> 

Sounds good, I will work with Paul on these.

Regards,
Boqun

>   [0]: https://lore.kernel.org/bpf/CAP01T76xUCrDH4G2XikNvhPTn6ZbNTgQH59qt2Q_o0c9uudd8w@mail.gmail.com
>   [1]: https://lore.kernel.org/bpf/20260204055147.54960-2-alexei.starovoitov@gmail.com
> 
> >
> > [...]
