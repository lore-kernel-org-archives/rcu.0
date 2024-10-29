Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63705EAF1;
	Tue, 29 Oct 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209957; cv=none; b=X4xp9eAp8AH2xyBxaequGd/udlyBjZarfqEHdaj2pNzyXHtoTmK5b+Wcpwg6QJhNfypHrJ8+8dtl+N9eWqqge6sREwKuuCLNt2a044+2aSAFnvYQD7kzeGekwoMNQpxLRw5DEApjh+LHNedvtEn4iL4hJr5q4VDNS28Yyf5l/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209957; c=relaxed/simple;
	bh=1JCk9rdpuj6PKz8WH+fzlMLoV82bnuU2ZMBDormG6RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+408Dck6frIGEI4VbDV0nU68m1NKqMsT9xWpCPx/EQwOSp5nQ9aFCY/vFUINEjL9yaMom7HxK2A4Oy+nng7s4nPHjDq+JOpknkEJy1QuXawwz3zt5GskG7qt0eJvTlj9hALYkkSpv36gW82d72o7QFwuIiHpvfCYDB55hs09mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MV9DO5xb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lwGjSqAh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MV9DO5xb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lwGjSqAh"
Date: Tue, 29 Oct 2024 14:52:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730209952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84hP6MRbQhJSQQYBUvvRwctKSrXoY74rO7nolo+OhAY=;
	b=MV9DO5xbD3g7dZt85B0NBg2dNWx1MpPA2qcdVZ0TGreYeLWUMra8KgckPPGb/wove5PsaE
	hV/NsEPdhDjZpamm89cofGPHn1zmLVszTXca6CwGL2fGFIleUPwzKrBGmCSr6fKILh2pE1
	0ObKqleQZ9jso3jmRge10yJAOYmjKJO6CwWzuhuEK090khVWL6mS0lhilHc3bzF6IBh2Y1
	FI4V1/wEyTK5u4yTgrQibGGivaAUJM3PQ5BrNZsK6uPLmHpNL9pKNkEE8etn7MHAMlC38Q
	8RivuuPnz40xSSqgBmg0EHzI82AtS2qK+jEVoSmRiRYdmWXUPMajeG3Khq8upA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730209952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84hP6MRbQhJSQQYBUvvRwctKSrXoY74rO7nolo+OhAY=;
	b=lwGjSqAhViHJxaf1n0x9QzQNNVZJhxFvMMTK8pynncCPAx6KcHEuR6YU0yxZrrBJsKn/oW
	4HArUe3IqDceQqDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 3/3] softirq: Use a dedicated thread for timer wakeups
 on PREEMPT_RT.
Message-ID: <20241029135231.ScfxKhz1@linutronix.de>
References: <20241024150413.518862-1-bigeasy@linutronix.de>
 <20241024150413.518862-4-bigeasy@linutronix.de>
 <Zx-ZUyMLWWsxR8nL@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Zx-ZUyMLWWsxR8nL@localhost.localdomain>

On 2024-10-28 15:01:55 [+0100], Frederic Weisbecker wrote:
> > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> > index 457151f9f263d..9637af78087f3 100644
> > --- a/include/linux/interrupt.h
> > +++ b/include/linux/interrupt.h
> > @@ -616,6 +616,50 @@ extern void __raise_softirq_irqoff(unsigned int nr=
);
> >  extern void raise_softirq_irqoff(unsigned int nr);
> >  extern void raise_softirq(unsigned int nr);
> > =20
> > +/*
> > + * Handle timers in a dedicated thread at a low SCHED_FIFO priority in=
stead in
> > + * ksoftirqd as to be prefred over SCHED_NORMAL tasks.
> > + */
>=20
> This doesn't parse. How about, inspired by your changelog:
=E2=80=A6

What about this essay instead:

| With forced-threaded interrupts enabled a raised softirq is deferred to
| ksoftirqd unless it can be handled within the threaded interrupt. This
| affects timer_list timers and hrtimers which are explicitly marked with
| HRTIMER_MODE_SOFT.
| With PREEMPT_RT enabled more hrtimers are moved to softirq for processing
| which includes all timers which are not explicitly marked HRTIMER_MODE_HA=
RD.
| Userspace controlled timers (like the clock_nanosleep() interface) is div=
ided
| into two categories: Tasks with elevated scheduling policy including
| SCHED_{FIFO|RR|DL} and the remaining scheduling policy. The tasks with the
| elevated scheduling policy are woken up directly from the HARDIRQ while a=
ll
| other wake ups are delayed to so softirq and so to ksoftirqd.
|
| The ksoftirqd runs at SCHED_OTHER policy at which it should remain since =
it
| handles the softirq in an overloaded situation (not handled everything
| within its last run).
| If the timers are handled at SCHED_OTHER priority then they competes with=
 all
| other SCHED_OTHER tasks for CPU resources are possibly delayed.
| Moving timers softirqs to a low priority SCHED_FIFO thread instead ensures
| that timer are performed before scheduling any SCHED_OTHER thread.

And with this piece of text I convinced myself to also enable this in
the forced-threaded case.

> Thanks.

Sebastian
