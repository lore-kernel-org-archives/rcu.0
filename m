Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A17040DFDF
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773880010; cv=none; b=eDg8av9L4OyeD8p08oil8trE5LEa88VTzCeagRdHppIzw1noz4VHQMU7Wh6K6t6VoaApYmiciaOBvXTbMR9n3dyeuPKih/vFkImDfZGyLp3irC7UpfsiQnLq9iuPRkRguvzRH/4JGRH/lnyxQhqPxQuJ4ptE03ibOFBIGp9U1q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773880010; c=relaxed/simple;
	bh=oxDkwddMnJU3W3KW8mMwTyjLnYW5YB8M2afb4AqzVd8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ooH7L2APS6TK7GTGiiHPifalLgaOIQO/FXdamFTOvygbR6ZLy7xH7zaMQhlxBAOyCzSctuL20tVCegNR7jMsuVigp1FQUX+CxvydbXW2AHDqKv+uYHy8+dVMKXny0LhF/Bry5DTB5slGVeaPO4YqsqcUHohDHB613muvTVtj2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=onC8B83K; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="onC8B83K"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773880006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfT+L5R3uH5ZvZB1etcvmF3B0SvZhe/dh3CJdLVCaZY=;
	b=onC8B83KKvhrZi/2IRhHeaZKHJx7vOHSBnwtV9CAMooXbf+JwKCHs5XtCPENzfSWNMSINk
	2zHrl3uGW3Fd1szetU+lMPhpsvhnjbqhYwKtpnbXziDJHd1qh6mdFJnOI81XNBFoWV7EnH
	EPTPdE8AqIHKL28Y+fEpRv8XRgDh5zM=
Date: Thu, 19 Mar 2026 00:26:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <f41b71aa2a39a7841e8913ae291cde5edc5e33c8@linux.dev>
TLS-Required: No
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Boqun Feng"
 <boqun@kernel.org>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, paulmck@kernel.org, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, frederic@kernel.org,
 neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com,
 rcu@vger.kernel.org
In-Reply-To: <CAP01T76Ud2yBWwXFyzNaLLOq6yjKbHRAXFsg=TMc7LYkZH_Opg@mail.gmail.com>
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
 <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local> <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local>
 <CAP01T76Ud2yBWwXFyzNaLLOq6yjKbHRAXFsg=TMc7LYkZH_Opg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Wed, 18 Mar 2026 at 23:15, Boqun Feng <boqun@kernel.org> wrote:
>=20
>=20>=20
>=20> On Wed, Mar 18, 2026 at 02:55:48PM -0700, Boqun Feng wrote:
> >  On Wed, Mar 18, 2026 at 02:52:48PM -0700, Boqun Feng wrote:
> >  [...]
> >  > > Ah so it is an ABBA deadlock, not a ABA self-deadlock. I guess t=
his is a
> >  > > different issue, from the NMI issue? It is more of an issue of c=
alling
> >  > > call_srcu API with scheduler locks held.
> >  > >
> >  > > Something like below I think:
> >  > >
> >  > > CPU A (BPF tracepoint) CPU B (concurrent call_srcu)
> >  > > ---------------------------- -----------------------------------=
-
> >  > > [1] holds &rq->__lock
> >  > > [2]
> >  > > -> call_srcu
> >  > > -> srcu_gp_start_if_needed
> >  > > -> srcu_funnel_gp_start
> >  > > -> spin_lock_irqsave_ssp_content...
> >  > > -> holds srcu locks
> >  > >
> >  > > [4] calls call_rcu_tasks_trace() [5] srcu_funnel_gp_start (cont.=
.)
> >  > > -> queue_delayed_work
> >  > > -> call_srcu() -> __queue_work()
> >  > > -> srcu_gp_start_if_needed() -> wake_up_worker()
> >  > > -> srcu_funnel_gp_start() -> try_to_wake_up()
> >  > > -> spin_lock_irqsave_ssp_contention() [6] WANTS rq->__lock
> >  > > -> WANTS srcu locks
> >  >
> >  > I see, we can also have a self deadlock even without CPU B, when C=
PU A
> >  > is going to try_to_wake_up() the a worker on the same CPU.
> >  >
> >  > An interesting observation is that the deadlock can be avoided in
> >  > queue_delayed_work() uses a non-zero delay, that means a timer wil=
l be
> >  > armed instead of acquiring the rq lock.
> >  >
> >=20
>=20>  If my observation is correct, then this can probably fix the deadl=
ock
> >  issue with runqueue lock (untested though), but it won't work if BPF
> >  tracepoint can happen with timer base lock held.
> >=20
>=20Unfortunately it can be, there is at least one tracepoint that is
> invoked with hrtimer base lock held.
> Alexei ended up fixing this in the recent past [0]. So I think this
> would cause trouble too.
>=20
>=20hrtimer_start_range_ns() -> __hrtimer_start_range_ns() ->
> remove_timer() -> __remove_hrtimer() -> debug_deactivate() ->
> trace_hrtimer_cancel().
> BPF can attach to such a tracepoint.

Is it possible to use irq_work_queue() to trigger queue_delay_work()
by checking if ssp =3D=3D &rcu_tasks_trace_srcu_struct ?

Thanks
Zqiang


>=20
>=20 [0]: https://lore.kernel.org/bpf/20260204040834.22263-2-alexei.staro=
voitov@gmail.com
>=20
>=20>=20
>=20> Regards,
> >  Boqun
> >=20
>=20>  ------>
> >  diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >  index 2328827f8775..a5d67264acb5 100644
> >  --- a/kernel/rcu/srcutree.c
> >  +++ b/kernel/rcu/srcutree.c
> >  @@ -1061,6 +1061,7 @@ static void srcu_funnel_gp_start(struct srcu_s=
truct *ssp, struct srcu_data *sdp,
> >  struct srcu_node *snp_leaf;
> >  unsigned long snp_seq;
> >  struct srcu_usage *sup =3D ssp->srcu_sup;
> >  + bool irqs_were_disabled;
> >=20
>=20>  /* Ensure that snp node tree is fully initialized before traversin=
g it */
> >  if (smp_load_acquire(&sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER=
)
> >  @@ -1098,6 +1099,7 @@ static void srcu_funnel_gp_start(struct srcu_s=
truct *ssp, struct srcu_data *sdp,
> >=20
>=20>  /* Top of tree, must ensure the grace period will be started. */
> >  raw_spin_lock_irqsave_ssp_contention(ssp, &flags);
> >  + irqs_were_disabled =3D irqs_disabled_flags(flags);
> >  if (ULONG_CMP_LT(sup->srcu_gp_seq_needed, s)) {
> >  /*
> >  * Record need for grace period s. Pair with load
> >  @@ -1118,9 +1120,16 @@ static void srcu_funnel_gp_start(struct srcu_=
struct *ssp, struct srcu_data *sdp,
> >  // it isn't. And it does not have to be. After all, it
> >  // can only be executed during early boot when there is only
> >  // the one boot CPU running with interrupts still disabled.
> >  + //
> >  + // If irq was disabled when call_srcu() is called, then we
> >  + // could be in the scheduler path with a runqueue lock held,
> >  + // delay the process_srcu() work 1 more jiffies so we don't go
> >  + // through the kick_pool() -> wake_up_process() path below, and
> >  + // we could avoid deadlock with runqueue lock.
> >  if (likely(srcu_init_done))
> >  queue_delayed_work(rcu_gp_wq, &sup->work,
> >  - !!srcu_get_delay(ssp));
> >  + !!srcu_get_delay(ssp) +
> >  + !!irqs_were_disabled);
> >  else if (list_empty(&sup->work.work.entry))
> >  list_add(&sup->work.work.entry, &srcu_boot_list);
> >  }
> >
>
