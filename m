Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FF5253B73
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 01:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773882794; cv=none; b=NakIh8PIiueFKh+lXEm1/SAEGK2mGhlQC+5POr//JXliza/vmycsCJukI6u+BpKZiSs/Hh/pUnQxTJyQtwQ+Mff1hTVeFo2Kt+5rKg92v+aHn9SQVnBt0JpctC8KueGyQGIs9jAXgfPvVA2hnB4d1dRZMO9MkAvURVbS+j/4mTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773882794; c=relaxed/simple;
	bh=hzBqHsA1YjsRNpi0dcHwTL34qLAtqbFIQeRl6wwTM40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzxiVBVLyd2i8FQYe7avwZkO2veLC2LK5sMPYPbwygPL7vmVyMlYBHN836Z87TWaMebdA9TfB8QTbVAUyhbr2aQzAFWGkypvrVDT+8ufZz056uyhc4ne6dfohEs0BhZt6La3GQovT79PVRxOrX9RJhka1lJdqgxdjeQC9pyP9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/63YZSj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/63YZSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B9AC2BC87;
	Thu, 19 Mar 2026 01:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773882794;
	bh=hzBqHsA1YjsRNpi0dcHwTL34qLAtqbFIQeRl6wwTM40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/63YZSjYIyY/bCT13PrTbODW53pAiJceJLGzDpOjMCwjgAwSv+hTa4BGiHMH8Wxw
	 gURmhI+TnBzxOo6nyx3+m2EjF7H3HzgL6LST88x9c/ZofmHEfsfbTEnXw6roqLe7gZ
	 JgLIJJsD4Blvf0lV3PpYWFC7umCR4z3A8iFKqdztfHvRgpf+IB48odF8A0VuEvfdbP
	 w8y4Bovnga6CGc5covmjYy0uETakb5QI4x31HrTZCmtCo7FudjiWoFEKgMf25xWL46
	 xV3mRzkcM2KZvRJ5aXB4Ut5WKFEmPLaFkZsulrCMHJWrLX+8iXfkA1+ki5gOpQ1v3z
	 M8EYvmvuVx3QQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id D5E11F4006A;
	Wed, 18 Mar 2026 21:13:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 18 Mar 2026 21:13:12 -0400
X-ME-Sender: <xms:qE27aZcqSxF9RrOSTnKNdbLFDfjTboSCB67r4OPDeI4IhxWyWj7kIA>
    <xme:qE27afbc6ty5ApE1-Zse4ZviOhhcBz19S1ujBuo4_rc75DduMgIrBSH_F6pNmm-Qz
    IIeUKjNIc8CdilnOCunHvAAu1Ex_4tlGHYaJtwIZwYRwz5BlGRN>
X-ME-Received: <xmr:qE27aeHax6IN36WUI09fo_QsjDBIwHlNRKxkXAGd93-iC2cMNKyOVITYAA5bnEmhfIsF7FH-lvRtZk0mGi1DJUlW_rlbimrc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnsehkvghrnhgvlhdr
    ohhrgheqnecuggftrfgrthhtvghrnhepleeuheethfdttdfgjedvjeeuhefhkeetveeuue
    eukeegteeigeeghedvffehhffhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhhi
    rghnghdriihhrghngheslhhinhhugidruggvvhdprhgtphhtthhopehmvghmgihorhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgt
    ohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epsghighgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehfrhgvuggv
    rhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhiihhtrhdutd
    esghhmrghilhdrtghomhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdp
    rhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:qE27adndoiWt9e1ivr4dcZm4MuUdqr6bfsZGz-0Tj0ENFn1uE3vXtw>
    <xmx:qE27aRevAwPx82z-SLfkPvBItylktSOwLCvWRFsld0rT82FC24nezw>
    <xmx:qE27abEJ-ek743CKSjBGWIyf5Xi0sw9YB17DKAALvaW_hqfnlM_QtA>
    <xmx:qE27aXhBtZpiogpL66CmaAv_MlKIxwNXs9SXdN1QWL6KZ5wMIi-WOg>
    <xmx:qE27af0a0N_oyxGz4KDLF41Fcgh1nWdpk9F-jk8oHBl-L64dchoUNgeo>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 21:13:12 -0400 (EDT)
Date: Wed, 18 Mar 2026 18:13:11 -0700
From: Boqun Feng <boqun@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, paulmck@kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <abtNpyDsRdkzVA0G@tardis.local>
References: <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
 <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local>
 <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local>
 <CAP01T76Ud2yBWwXFyzNaLLOq6yjKbHRAXFsg=TMc7LYkZH_Opg@mail.gmail.com>
 <f41b71aa2a39a7841e8913ae291cde5edc5e33c8@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f41b71aa2a39a7841e8913ae291cde5edc5e33c8@linux.dev>

On Thu, Mar 19, 2026 at 12:26:38AM +0000, Zqiang wrote:
> > 
> > On Wed, 18 Mar 2026 at 23:15, Boqun Feng <boqun@kernel.org> wrote:
> > 
> > > 
> > > On Wed, Mar 18, 2026 at 02:55:48PM -0700, Boqun Feng wrote:
> > >  On Wed, Mar 18, 2026 at 02:52:48PM -0700, Boqun Feng wrote:
> > >  [...]
> > >  > > Ah so it is an ABBA deadlock, not a ABA self-deadlock. I guess this is a
> > >  > > different issue, from the NMI issue? It is more of an issue of calling
> > >  > > call_srcu API with scheduler locks held.
> > >  > >
> > >  > > Something like below I think:
> > >  > >
> > >  > > CPU A (BPF tracepoint) CPU B (concurrent call_srcu)
> > >  > > ---------------------------- ------------------------------------
> > >  > > [1] holds &rq->__lock
> > >  > > [2]
> > >  > > -> call_srcu
> > >  > > -> srcu_gp_start_if_needed
> > >  > > -> srcu_funnel_gp_start
> > >  > > -> spin_lock_irqsave_ssp_content...
> > >  > > -> holds srcu locks
> > >  > >
> > >  > > [4] calls call_rcu_tasks_trace() [5] srcu_funnel_gp_start (cont..)
> > >  > > -> queue_delayed_work
> > >  > > -> call_srcu() -> __queue_work()
> > >  > > -> srcu_gp_start_if_needed() -> wake_up_worker()
> > >  > > -> srcu_funnel_gp_start() -> try_to_wake_up()
> > >  > > -> spin_lock_irqsave_ssp_contention() [6] WANTS rq->__lock
> > >  > > -> WANTS srcu locks
> > >  >
> > >  > I see, we can also have a self deadlock even without CPU B, when CPU A
> > >  > is going to try_to_wake_up() the a worker on the same CPU.
> > >  >
> > >  > An interesting observation is that the deadlock can be avoided in
> > >  > queue_delayed_work() uses a non-zero delay, that means a timer will be
> > >  > armed instead of acquiring the rq lock.
> > >  >
> > > 
> > >  If my observation is correct, then this can probably fix the deadlock
> > >  issue with runqueue lock (untested though), but it won't work if BPF
> > >  tracepoint can happen with timer base lock held.
> > > 
> > Unfortunately it can be, there is at least one tracepoint that is
> > invoked with hrtimer base lock held.
> > Alexei ended up fixing this in the recent past [0]. So I think this
> > would cause trouble too.
> > 
> > hrtimer_start_range_ns() -> __hrtimer_start_range_ns() ->
> > remove_timer() -> __remove_hrtimer() -> debug_deactivate() ->
> > trace_hrtimer_cancel().
> > BPF can attach to such a tracepoint.
> 
> Is it possible to use irq_work_queue() to trigger queue_delay_work()
> by checking if ssp == &rcu_tasks_trace_srcu_struct ?
> 

Good call! I didn't do the exact == check, but close:

	https://lore.kernel.org/rcu/abtMhd_LVp3uL_pA@tardis.local/

;-)

Regards,
Boqun

> Thanks
> Zqiang
> 
> 
> > 
> >  [0]: https://lore.kernel.org/bpf/20260204040834.22263-2-alexei.starovoitov@gmail.com
> > 
> > > 
> > > Regards,
> > >  Boqun
> > > 
> > >  ------>
> > >  diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > >  index 2328827f8775..a5d67264acb5 100644
> > >  --- a/kernel/rcu/srcutree.c
> > >  +++ b/kernel/rcu/srcutree.c
> > >  @@ -1061,6 +1061,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > >  struct srcu_node *snp_leaf;
> > >  unsigned long snp_seq;
> > >  struct srcu_usage *sup = ssp->srcu_sup;
> > >  + bool irqs_were_disabled;
> > > 
> > >  /* Ensure that snp node tree is fully initialized before traversing it */
> > >  if (smp_load_acquire(&sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> > >  @@ -1098,6 +1099,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > > 
> > >  /* Top of tree, must ensure the grace period will be started. */
> > >  raw_spin_lock_irqsave_ssp_contention(ssp, &flags);
> > >  + irqs_were_disabled = irqs_disabled_flags(flags);
> > >  if (ULONG_CMP_LT(sup->srcu_gp_seq_needed, s)) {
> > >  /*
> > >  * Record need for grace period s. Pair with load
> > >  @@ -1118,9 +1120,16 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > >  // it isn't. And it does not have to be. After all, it
> > >  // can only be executed during early boot when there is only
> > >  // the one boot CPU running with interrupts still disabled.
> > >  + //
> > >  + // If irq was disabled when call_srcu() is called, then we
> > >  + // could be in the scheduler path with a runqueue lock held,
> > >  + // delay the process_srcu() work 1 more jiffies so we don't go
> > >  + // through the kick_pool() -> wake_up_process() path below, and
> > >  + // we could avoid deadlock with runqueue lock.
> > >  if (likely(srcu_init_done))
> > >  queue_delayed_work(rcu_gp_wq, &sup->work,
> > >  - !!srcu_get_delay(ssp));
> > >  + !!srcu_get_delay(ssp) +
> > >  + !!irqs_were_disabled);
> > >  else if (list_empty(&sup->work.work.entry))
> > >  list_add(&sup->work.work.entry, &srcu_boot_list);
> > >  }
> > >
> >
