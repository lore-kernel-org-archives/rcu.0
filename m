Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE053148C9
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870772; cv=none; b=rAAcVA65Xb8D6p29cW9Zkmt9N7VnJYfoLMumvo8SIl46Odze6hbjhfJBf17ZP/X5+R0p4GeGhorGI6z6oQcvwMIHUIOHmt4o0qc07+nOPtZLXPImYI6X0ztKXVleQZbCa+TSA2NO2oKAgY//4ILBiLlSuRcl9TpbrGkg5y3BpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870772; c=relaxed/simple;
	bh=z8HN6+ngYJMhOKkixUKgTuni8nrxbmnZ66mQCxST42A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rht0rBUaJdxehQ9i+YBmSmGkeOZdxPsdjs3vJ96iviixdcksr0asMCgXueXy0FxZiaqP8vpKdFD6B1tj4eHxEzE9opABwn2WBFrk77in5C71FK+W0FSBSMgMP+SgMHxfckSF68MlgUdLxYIZBprrr3aP/6QcctA/gR1atsyT/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7144y+y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7144y+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEB9C19424;
	Wed, 18 Mar 2026 21:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773870772;
	bh=z8HN6+ngYJMhOKkixUKgTuni8nrxbmnZ66mQCxST42A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J7144y+ySmOrDBEaMerZU1tQP8QIpJUR0irOkMKSppc7sx7MeiI4TsvBZCl2QkhKD
	 tAdFaly4nSNIPbsZL9q1JOesjNnv98oAwTOdmOJ9rW1nX4ZskNL5JXs/X6WUlgSUkL
	 BymmT0HOoIVJgAYm9ijFfYMyvbo4RwlcGMQLY8Uy0AEiPVGZuEONkpLfVSbbRGGWvY
	 PSYPQOt8+Bkfs6cwlvonPNVjoNPF+Ug54iRamJnhnTXk45ydNQolbafmuVGTQAwah+
	 BugfJrlXnaORXcxQJLg8yeIqzeDIjWMcx6V7wbVy9NpY86b2HZlk3dONDHHc7bMogw
	 BmcthA8U9tt9A==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 69490F4008D;
	Wed, 18 Mar 2026 17:52:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 18 Mar 2026 17:52:50 -0400
X-ME-Sender: <xms:sh67aRXTtYqlTvNEDZLydeBpLTeBL-wCV075WC3_JeROvIucLjD2kA>
    <xme:sh67aeKkN7DzTtuWO-5RkXiQuJFIKyIdEtG8UqrydnHrriIarDWSWA4YMfisevqiY
    Ksm_RSyWcvLqBJMDa8R52hsi2Baq0bjXCfWl6tKyvAaRiftrl8yjQ>
X-ME-Received: <xmr:sh67aR150nVX4HSoGM_dgxJhlIluoenzGW57Zfqd3Iw7kGo69CfQBIxELb1JXKqWkOBrhefU7GnD3g9nv_vtqelPYN4S9gLp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnsehkvghrnhgvlhdr
    ohhrgheqnecuggftrfgrthhtvghrnhepleeuheethfdttdfgjedvjeeuhefhkeetveeuue
    eukeegteeigeeghedvffehhffhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhho
    vghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopehprghulhhmtghkse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhi
    gidruggvpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnvggvrhgrjhdrihhithhruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    uhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvghmgihorhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:sh67abKgnkCHsVcR2jZwI-ugZhrzHGUAGaR-bWgKk3DTYLzyDjqr5g>
    <xmx:sh67acgvIOScT_r-8tfT6twk2bB7BL1e3yKS-_jZeRACpr9FMCktQQ>
    <xmx:sh67abB_BGJPOlI_5XytdaPx6ZwDa8votZOGXIzbE6OLbimQwl_hKw>
    <xmx:sh67ae7morCRRbpQXLzxr0AmUsjpCn-NNJdx7e8NztDl585-Nk_Dpg>
    <xmx:sh67aQE4sJre9G2uKDxnaFjsslBSN_Tz453sZJE6uFvHI-tmalrgrWxu>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 17:52:49 -0400 (EDT)
Date: Wed, 18 Mar 2026 14:52:48 -0700
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <absesPf-10awctq9@tardis.local>
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
 <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>

On Wed, Mar 18, 2026 at 04:04:05PM -0400, Joel Fernandes wrote:
> On 3/18/2026 2:42 PM, Paul E. McKenney wrote:
> > On Wed, Mar 18, 2026 at 08:51:16AM -0700, Boqun Feng wrote:
> >> On Wed, Mar 18, 2026 at 03:43:05PM +0100, Sebastian Andrzej Siewior wrote:
> >> [..]
> >>>>>> way that vanilla RCU's call_rcu_core() function takes an early exit if
> >>>>>> interrupts are disabled.  Of course, vanilla RCU can rely on things like
> >>>>>> the scheduling-clock interrupt to start any needed grace periods [1],
> >>>>>> but SRCU will instead need to manually defer this work, perhaps using
> >>>>>> workqueues or IRQ work.
> >>>>>>
> >>>>>> In addition, rcutorture needs to be upgraded to sometimes invoke
> >>>>>> ->call() with the scheduler pi lock held, but this change is not fixing
> >>>>>> a regression, so could be deferred.  (There is already code in rcutorture
> >>>>>> that invokes the readers while holding a scheduler pi lock.)
> >>>>>>
> >>>>>> Given that RCU for this week through the end of March belongs to you guys,
> >>>>>> if one of you can get this done by end of day Thursday, London time,
> >>>>>> very good!  Otherwise, I can put something together.
> >>>>>>
> >>>>>> Please let me know!
> >>>>>
> >>>>> Given that the current locking does allow it and lockdep should have
> >>>>> complained, I am curious if we could rule that out ;)
> >>>
> >>> Your patch just s/spinlock_t/raw_spinlock_t so we get the locking/
> >>> nesting right. The wakeup problem remains, right?
> >>> But looking at the code, there is just srcu_funnel_gp_start(). If its
> >>> srcu_schedule_cbs_sdp() / queue_delayed_work() usage is always delayed
> >>> then there will be always a timer and never a direct wake up of the
> >>> worker. Wouldn't that work?
> >>
> >> Late to the party, so just make sure I understand the problem. The
> >> problem is the wakeup in call_srcu() when it's called with scheduler
> >> lock held, right? If so I think the current code works as what you
> >> already explain, we defer the wakeup into a workqueue.
> >
> > The issue is that call_rcu_tasks() (which is call_srcu() now) is
> > also invoked with a scheduler pi/rq lock held, which results in a
> > deadlock cycle.  So the srcu_gp_start_if_needed() function's call to
> > raw_spin_lock_irqsave_sdp_contention() must be deferred to the workqueue
> > handler, not just the wake-up.  And that in turn means that the callback
> > point also needs to be passed to this handler.
> >
> > See this email thread:
> >
> > https://lore.kernel.org/all/CAP01T75eKpvw+95NqNWg9P-1+kzVzojpN0NLat+28SF1B9wQQQ@mail.gmail.com/
> >
> >> (but Paul, we are not talking about calling call_srcu(), that requires
> >> some more work to get it work)
> >
> > Agreed, splitting srcu_gp_start_if_needed() and using a workqueue if
> > interrupts were already disabled on entry.  Otherwise, directly invoking
> > the split-out portion of srcu_gp_start_if_needed().
> >
> > But we might be talking past each other.
> >
> 
> Ah so it is an ABBA deadlock, not a ABA self-deadlock. I guess this is a
> different issue, from the NMI issue? It is more of an issue of calling
> call_srcu  API with scheduler locks held.
> 
> Something like below I think:
> 
>   CPU A (BPF tracepoint)                CPU B (concurrent call_srcu)
>   ----------------------------         ------------------------------------
>   [1] holds  &rq->__lock
>                                         [2]
>                                         -> call_srcu
>                                         -> srcu_gp_start_if_needed
>                                         -> srcu_funnel_gp_start
>                                         -> spin_lock_irqsave_ssp_content...
> 					  -> holds srcu locks
> 
>   [4] calls  call_rcu_tasks_trace()      [5] srcu_funnel_gp_start (cont..)
>                                                  -> queue_delayed_work
>           -> call_srcu()                         -> __queue_work()
>           -> srcu_gp_start_if_needed()           -> wake_up_worker()
>           -> srcu_funnel_gp_start()              -> try_to_wake_up()
>           -> spin_lock_irqsave_ssp_contention()  [6] WANTS  rq->__lock
>           -> WANTS srcu locks

I see, we can also have a self deadlock even without CPU B, when CPU A
is going to try_to_wake_up() the a worker on the same CPU.

An interesting observation is that the deadlock can be avoided in
queue_delayed_work() uses a non-zero delay, that means a timer will be
armed instead of acquiring the rq lock.

(But I guess BPF also wants to run with timer base lock held, right? ;-)
;-) ;-)).

/me going to check Paul's second fix at rcu/dev.

Regards,
Boqun

> 
> If I understand this, this looks like an issue that can happen independent
> of the conversion of the spin locks.
> 
> thanks,
> 
> -- 
> Joel Fernandes
