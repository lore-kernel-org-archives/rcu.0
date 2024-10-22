Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1382E406;
	Tue, 22 Oct 2024 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611269; cv=none; b=fMPQkHT+FYCR9o7+HRzMA0Aib67UJlIXdRuAs+0RxV48L5lJxXv260GdQ55oYAuE00w+08MP6prRdYZhPs8v9lAtDLH4lLMJ9sBJw0uKXRPfIu4fCWuX+l9CRBt67dvr1Yqg+qGtwBxDqd9G1Sbwx/Va+H2V0E/VfHNoaht+byQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611269; c=relaxed/simple;
	bh=WTT9n2/PNilXGm6zGJ+nXbkXPErEwo0WspX+D+nAxsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4biHpnUdHrisP2zDtXjG2oy3YbxiTrnPA2Qwx5Df4utbE8i6Tbo8ny6TAGsUqI8Vo0C8vhW79MMjdBQB2u1CXvbs1PzfIuLkzpGqPrKvxh0udcyG9B2xhhqTMsjKzHCr4GKIHgreXZoYZAmjmPKuPjmah5k/BOqiZkuMbZ5LBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kewLYScJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6d71W1R8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kewLYScJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6d71W1R8"
Date: Tue, 22 Oct 2024 17:34:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729611263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHGHaUWDWX+IWGBPfOe3MVJPsb+2BgkqR9GtGbroFjc=;
	b=kewLYScJFRqCvN+Ao7+BuRLdKlMhuITQdz7dcPVcaF4GKiEw5t+i5lWT4VjK99yspekP0s
	pW5vnki+2e9L8eBwdXx/ZV/7nrivdUH5b+pLDl8XGOc7O0+oisOPklHIV5f5SV1TMb8+Tu
	Tc4ZPTMjLeEdwTS0sBNyY0hMGggItHN5HQj5/XtJbRBzmzxHP0HA4uzZCXM7YEb+yl3lC6
	wkZgzfO5zBb2lwdDTNhDtoIv+vNyO05l/UR537JOPN9fj6HCL1x54su9R8AD8RMnv7StQ3
	x0UJZoQ8SLwLq7TfFzlznCc15Lug3ZXgLpCjCfxbs528ylQmnrwgRgCsucV2qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729611263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHGHaUWDWX+IWGBPfOe3MVJPsb+2BgkqR9GtGbroFjc=;
	b=6d71W1R8gRlitrcVkTI8Ia70hXKoPFDDXAA5bNbv6X1j6FgXoZHZ//VjgtqIutO0pqZO2q
	BJNpX1tWufSjxTAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] softirq: Use a dedicated thread for timer wakeups on
 PREEMPT_RT.
Message-ID: <20241022153421.zLWiABPU@linutronix.de>
References: <20241004103842.131014-1-bigeasy@linutronix.de>
 <20241004103842.131014-2-bigeasy@linutronix.de>
 <ZxeomPnsi6oGHKPT@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZxeomPnsi6oGHKPT@localhost.localdomain>

On 2024-10-22 15:28:56 [+0200], Frederic Weisbecker wrote:
> Le Fri, Oct 04, 2024 at 12:17:04PM +0200, Sebastian Andrzej Siewior a =C3=
=A9crit :
> > A timer/ hrtimer softirq is raised in-IRQ context. With threaded
> > interrupts enabled or on PREEMPT_RT this leads to waking the ksoftirqd
> > for the processing of the softirq.
>=20
> It took me some time to understand the actual problem (yeah I know...)
>=20
> Can this be rephrased as: "Timer and hrtimer softirq vectors are special
> in that they are always raised in-IRQ context whereas other vectors are
> more likely to be raised from threaded interrupts or any regular tasks
> when threaded interrupts or PREEMPT_RT are enabled. This leads to
> waking ksoftirqd for the processing of the softirqs whenever timer
> vectors are involved.

Oki.

> > Once the ksoftirqd is marked as pending (or is running) it will collect
> > all raised softirqs. This in turn means that a softirq which would have
> > been processed at the end of the threaded interrupt, which runs at an
> > elevated priority, is now moved to ksoftirqd which runs at SCHED_OTHER
> > priority and competes with every regular task for CPU resources.
>=20
> But for ksoftirqd to collect other non-timers softirqs, those vectors must
> have been raised before from a threaded interrupt, right? So why those
> vectors didn't get a chance to execute at the end of that threaded interr=
upt?

This statement is no longer accurate since
	d15121be74856 ("Revert "softirq: Let ksoftirqd do its job"")

So the "collect all" part is no longer.

> OTOH one problem I can imagine is a threaded interrupt preempting ksoftir=
qd
> which must wait for ksoftirqd to complete due to the local_bh_disable()
> in the beginning of irq_forced_thread_fn(). But then isn't there some
> PI involved on the local lock?

Yes, there is PI involved on the local lock. So this will happen.

> Sorry I'm probably missing something...

Try again without the "ksoftirqd will collect it all" since this won't
happen since the revert I mentioned.

> > This introduces long delays on heavy loaded systems and is not desired
> > especially if the system is not overloaded by the softirqs.
> >=20
> > Split the TIMER_SOFTIRQ and HRTIMER_SOFTIRQ processing into a dedicated
> > timers thread and let it run at the lowest SCHED_FIFO priority.
> > Wake-ups for RT tasks happen from hardirq context so only timer_list ti=
mers
> > and hrtimers for "regular" tasks are processed here.
>=20
> That last sentence confuses me. How are timers for non regular task proce=
ssed
> elsewhere? Ah you mean RT tasks rely on hard hrtimers?

Correct. A clock_nanosleep() for a RT task will result in wake_up() from
hardirq. A clock_nanosleep() for a !RT task will result in wake_up()
=66rom ksoftirqd or now the suggested ktimersd.

Quick question: Do we want this in forced-threaded mode, too? The timer
(timer_list timer) and all HRTIMER_MODE_SOFT are handled in ksoftirqd.

> > The higher priority
> > ensures that wakeups are performed before scheduling SCHED_OTHER tasks.
> >=20
> > Using a dedicated variable to store the pending softirq bits values
> > ensure that the timer are not accidentally picked up by ksoftirqd and
> > other threaded interrupts.
> > It shouldn't be picked up by ksoftirqd since it runs at lower priority.
> > However if ksoftirqd is already running while a timer fires, then
> > ksoftird will be PI-boosted due to the BH-lock to ktimer's priority.
> > Ideally we try to avoid having ksoftirqd running.
> >=20
> > The timer thread can pick up pending softirqs from ksoftirqd but only
> > if the softirq load is high. It is not be desired that the picked up
> > softirqs are processed at SCHED_FIFO priority under high softirq load
> > but this can already happen by a PI-boost by a force-threaded interrupt.
> >=20
> > [ frederic@kernel.org: rcutorture.c fixes, storm fix by introduction of
> >   local_pending_timers() for tick_nohz_next_event() ]
> >=20
> > [ junxiao.chang@intel.com: Ensure ktimersd gets woken up even if a
> >   softirq is currently served. ]
> >=20
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  include/linux/interrupt.h | 29 ++++++++++++++
> >  kernel/rcu/rcutorture.c   |  6 +++
> >  kernel/softirq.c          | 82 ++++++++++++++++++++++++++++++++++++++-
> >  kernel/time/hrtimer.c     |  4 +-
> >  kernel/time/tick-sched.c  |  2 +-
> >  kernel/time/timer.c       |  2 +-
> >  6 files changed, 120 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> > index 457151f9f263d..4a4f367cd6864 100644
> > --- a/include/linux/interrupt.h
> > +++ b/include/linux/interrupt.h
> > @@ -616,6 +616,35 @@ extern void __raise_softirq_irqoff(unsigned int nr=
);
> >  extern void raise_softirq_irqoff(unsigned int nr);
> >  extern void raise_softirq(unsigned int nr);
> > =20
> > +#ifdef CONFIG_PREEMPT_RT
>=20
> This needs a comment section to explain why a dedicated
> timers processing is needed.

Okay.

> > +DECLARE_PER_CPU(struct task_struct *, timersd);
> > +DECLARE_PER_CPU(unsigned long, pending_timer_softirq);
> > +
> > +extern void raise_timer_softirq(void);
> > +extern void raise_hrtimer_softirq(void);
> > +
> > +static inline unsigned int local_pending_timers(void)
>=20
> Let's align with local_softirq_pending() naming and rather
> have local_timers_pending() ?

good.

> > +{
> > +	return __this_cpu_read(pending_timer_softirq);
> > +}
> > +
> > +#ifdef CONFIG_PREEMPT_RT
> > +static void timersd_setup(unsigned int cpu)
> > +{
>=20
> That also needs a comment.

Why we want the priority I guess.

=E2=80=A6
> > +void raise_hrtimer_softirq(void)
> > +{
> > +	raise_ktimers_thread(HRTIMER_SOFTIRQ);
> > +}
> > +
> > +void raise_timer_softirq(void)
> > +{
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	raise_ktimers_thread(TIMER_SOFTIRQ);
> > +	wake_timersd();
>=20
> This is supposed to be called from hardirq only, right?
> Can't irq_exit_rcu() take care of it? Why is it different
> from HRTIMER_SOFTIRQ ?

Good question. This shouldn't be any different compared to the hrtimer
case. This is only raised in hardirq, so yes, the irq_save can go away
and the wake call, too.

> Thanks.

Sebastian
