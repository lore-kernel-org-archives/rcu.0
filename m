Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82D2459DC
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773876447; cv=none; b=CG+kH/agcL9RAtDaP6//egKmq5HwIhzZqps0ACiLKrVaxSbS/M8JOCS2AnjHaFSolqpNehdJUN5RXfLen9xopUgoqP4Lzp0SXG7w9vTWx9W5HJd4Pb0DaJG4/pTB1PYZkefKCHK4bu/86etpL967VJZezHWlj6ipNBzDtOhttJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773876447; c=relaxed/simple;
	bh=NgG9vCVZtP6s4tQLUVXenD7UIPCd4nbeHt0gtQ8+YC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0uUFsURWNGTtBmXn4JyGSs6DDXMgMnbNB0JlYAx+v5J81UVOKiopD7R+VrK+CaduCgUyxjcojEiHPDJn7HzS3cnc3tRnFSuQkzjirNqMEd6iEnMoNKD2MaEPt7HT72hqD1Ph1WB1UUbFp2zaNMle77ojZVV0PeCvBMLHe4h/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=queYdN6K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="queYdN6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D732C4AF09;
	Wed, 18 Mar 2026 23:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773876447;
	bh=NgG9vCVZtP6s4tQLUVXenD7UIPCd4nbeHt0gtQ8+YC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=queYdN6Ky6SsqaWGeN6me4TIurRsPVUSVHsEoN5aGpGsvGOEe1O/viu/i0yteRbJE
	 uaNdv4Roqfgtxj7YgfZcoQ2D/VbCI770r/O9BVdnW8VDkFXS8HSuqnXluwvti8fOGG
	 Xg3LPWilKlNzGGWcouhVDwyy2NyPoFJflQsThg9y1OzBietk+n4A1Qf/3wamY9PnCF
	 4qQ1OU64ZPouqKwpEaSUlOaT6C0m/Jo5Qvl3FdhsS3Nmf6OtS8WD4T30kUwnTyZLnv
	 zxxzzRkGwVWH1Ch7L1OL8XwiO79heyeQnpey3FeDCjevtF4Fx93f3FXOiBjGvhJMHS
	 4YWalmQ4g/dtA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1883DF4008C;
	Wed, 18 Mar 2026 19:27:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 18 Mar 2026 19:27:25 -0400
X-ME-Sender: <xms:3TS7aeQasNQ32uxSd4PIaZXkdG85xjP2BcCbzrtnJatl3ZXeUaJGuQ>
    <xme:3TS7ab9bxgv6vT3sWuIIg67QOq6iM9_8vDlpr8jamPKp5SuiajOIvXPfSMZPa2ZXF
    QkMI0K47Fcu3rnNgicKa3mSBpIQyEln9u-UdDVSjPl-PxutIadYag>
X-ME-Received: <xmr:3TS7aXZscfmpCV3SzjTcHs5IAoFEFM0Mfb1hAzIcOVBx2A_VVupG9I9vr6lHbIYTSPVRXHw5I8qwgGwjTTBTEcdhLhMOmFt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnsehkvghrnhgvlhdr
    ohhrgheqnecuggftrfgrthhtvghrnhepleeuheethfdttdfgjedvjeeuhefhkeetveeuue
    eukeegteeigeeghedvffehhffhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhho
    vghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopehprghulhhmtghkse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhi
    gidruggvpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnvggvrhgrjhdrihhithhruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    uhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvghmgihorhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:3TS7aUq4_c8Ooamc-rgt6ZaGN59S6op1ZQqWQQwaOkm8aN1jQ1uGwA>
    <xmx:3TS7aTQ3IIpVP6ofQ-kwcvdoDPnOa2vjIXHogrqR-X7bRKGxXWXcZA>
    <xmx:3TS7aQoMJbRfClth5PvyGeQjEUOYAXnAJ-9xOW5hJk_35IAyGC-Ofg>
    <xmx:3TS7aV03mpGnJ5oe9JNxgRIGeo1glQSn0nl7DQ1tdP-Cz9yPp5NsvA>
    <xmx:3TS7aX6LVPkAWOtCXZgQLR_DyzWWqo7cbPF7Bai3EAHuI-aAb9LbS2Z7>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 19:27:24 -0400 (EDT)
Date: Wed, 18 Mar 2026 16:27:23 -0700
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <abs026TUV9oAg_Xy@tardis.local>
References: <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
 <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local>
 <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local>
 <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>

On Wed, Mar 18, 2026 at 06:52:53PM -0400, Joel Fernandes wrote:
> 
> 
> On 3/18/2026 6:15 PM, Boqun Feng wrote:
> > On Wed, Mar 18, 2026 at 02:55:48PM -0700, Boqun Feng wrote:
> >> On Wed, Mar 18, 2026 at 02:52:48PM -0700, Boqun Feng wrote:
> >> [...]
> >>>> Ah so it is an ABBA deadlock, not a ABA self-deadlock. I guess this is a
> >>>> different issue, from the NMI issue? It is more of an issue of calling
> >>>> call_srcu  API with scheduler locks held.
> >>>>
> >>>> Something like below I think:
> >>>>
> >>>>   CPU A (BPF tracepoint)                CPU B (concurrent call_srcu)
> >>>>   ----------------------------         ------------------------------------
> >>>>   [1] holds  &rq->__lock
> >>>>                                         [2]
> >>>>                                         -> call_srcu
> >>>>                                         -> srcu_gp_start_if_needed
> >>>>                                         -> srcu_funnel_gp_start
> >>>>                                         -> spin_lock_irqsave_ssp_content...
> >>>> 					  -> holds srcu locks
> >>>>
> >>>>   [4] calls  call_rcu_tasks_trace()      [5] srcu_funnel_gp_start (cont..)
> >>>>                                                  -> queue_delayed_work
> >>>>           -> call_srcu()                         -> __queue_work()
> >>>>           -> srcu_gp_start_if_needed()           -> wake_up_worker()
> >>>>           -> srcu_funnel_gp_start()              -> try_to_wake_up()
> >>>>           -> spin_lock_irqsave_ssp_contention()  [6] WANTS  rq->__lock
> >>>>           -> WANTS srcu locks
> >>>
> >>> I see, we can also have a self deadlock even without CPU B, when CPU A
> >>> is going to try_to_wake_up() the a worker on the same CPU.
> >>>
> >>> An interesting observation is that the deadlock can be avoided in
> >>> queue_delayed_work() uses a non-zero delay, that means a timer will be
> >>> armed instead of acquiring the rq lock.
> >>>
> > 
> > If my observation is correct, then this can probably fix the deadlock
> > issue with runqueue lock (untested though), but it won't work if BPF
> > tracepoint can happen with timer base lock held.
> > 
> > Regards,
> > Boqun
> > 
> > ------>
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 2328827f8775..a5d67264acb5 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1061,6 +1061,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> >         struct srcu_node *snp_leaf;
> >         unsigned long snp_seq;
> >         struct srcu_usage *sup = ssp->srcu_sup;
> > +       bool irqs_were_disabled;
> > 
> >         /* Ensure that snp node tree is fully initialized before traversing it */
> >         if (smp_load_acquire(&sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> > @@ -1098,6 +1099,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > 
> >         /* Top of tree, must ensure the grace period will be started. */
> >         raw_spin_lock_irqsave_ssp_contention(ssp, &flags);
> > +       irqs_were_disabled = irqs_disabled_flags(flags);
> >         if (ULONG_CMP_LT(sup->srcu_gp_seq_needed, s)) {
> >                 /*
> >                  * Record need for grace period s.  Pair with load
> > @@ -1118,9 +1120,16 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> >                 // it isn't.  And it does not have to be.  After all, it
> >                 // can only be executed during early boot when there is only
> >                 // the one boot CPU running with interrupts still disabled.
> > +               //
> > +               // If irq was disabled when call_srcu() is called, then we
> > +               // could be in the scheduler path with a runqueue lock held,
> > +               // delay the process_srcu() work 1 more jiffies so we don't go
> > +               // through the kick_pool() -> wake_up_process() path below, and
> > +               // we could avoid deadlock with runqueue lock.
> >                 if (likely(srcu_init_done))
> >                         queue_delayed_work(rcu_gp_wq, &sup->work,
> > -                                          !!srcu_get_delay(ssp));
> > +                                          !!srcu_get_delay(ssp) +
> > +                                          !!irqs_were_disabled);
> Nice, I wonder if it is better to do this in __queue_delayed_work() itself.
> Do we have queue_delayed_work() with zero delays that are in irq-disabled
> regions, and they depend on that zero-delay for correctness? Even with
> delay of 0 though, the work item doesn't execute right away anyway, the
> worker thread has to also be scheduler right?
> 
> Also if IRQ is disabled, I'd think this is a critical path that is not
> wanting to run the work item right-away anyway since workqueue is more a
> bottom-half mechanism, than "run this immediately".
> 
> IOW, would be good to make the workqueue-layer more resilient to waking up
> the scheduler when a delay would have been totally ok. But maybe +Tejun can
> yell if that sounds insane.
> 

I think all of these are probably a good point. However my fix is not
complete :( It's missing the ABBA case in your example (it obviously
could solve the self deadlock if my observation is correct), because we
will still build rcu_node::lock -> runqueue::lock in some conditions,
and BPF contributes the runqueue::lock -> rcu_node::lock dependency.
Hence we still have ABBA deadlock.

To remove the rcu_node::lock -> runqueue::lock entirely, we need to
always delay 1+ jiffies:

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2328827f8775..86733f7bf637 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1118,9 +1118,13 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
                // it isn't.  And it does not have to be.  After all, it
                // can only be executed during early boot when there is only
                // the one boot CPU running with interrupts still disabled.
+               //
+               // Delay the process_srcu() work 1 more jiffies so we don't go
+               // through the kick_pool() -> wake_up_process() path below, and
+               // we could avoid deadlock with runqueue lock.
                if (likely(srcu_init_done))
                        queue_delayed_work(rcu_gp_wq, &sup->work,
-                                          !!srcu_get_delay(ssp));
+                                          !!srcu_get_delay(ssp) + 1);
                else if (list_empty(&sup->work.work.entry))
                        list_add(&sup->work.work.entry, &srcu_boot_list);
        }


Paul's suggestion at [1] is basically breaking another dependecy
runqueue::lock -> rcu_node::lock, I'm investigating how we can do that.

[1]: https://lore.kernel.org/rcu/214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop/

Regards,
Boqun

> thanks,
> 
> --
> Joel Fernandes
> 
