Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679251E1C2F;
	Wed, 30 Oct 2024 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282534; cv=none; b=lqnzLwOYoMXpiIEQHs/KEQrA394m3oumXIwKfFRNzTnDPqL7wAoF+C7ksw9iqo+AgkYNIx5LjqMhT+2l02/Njsey4O5ql5NkWI8/fMQym2dLq6e++XjRze39vAkTZt4BNYtsfqNIwzAgo7YGxcu2p5VdORtmXWwf2yqGP7MV2ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282534; c=relaxed/simple;
	bh=z6mL2fX4JMKul4M5iZSgoIjsJfF1R8Bij68rxnH6vtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4acfIjHeAgIjjmzaA+5k0tX7rWBm+vJr37TU/Vs8P9KqKZNNIRpaz+rd2wNx7CXcrctc6L/kaRQvDzJeE+GL6ScsbAPP3Wsfs/wRt2Wjwu9TQETEa/zHce7cTNMzSmCyT+iCldZ/Lq1giw/cxBGDhYIsyjutG129CYe61Ley3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dcopkdfl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OlhKreHC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dcopkdfl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OlhKreHC"
Date: Wed, 30 Oct 2024 11:02:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730282530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zO50zcxsIEHgZXPTC/5eQCKFakrTmKnwGXxVPcDAFiw=;
	b=Dcopkdfl3RXhwF00kKvMUBt3X4UI3V3I6m0ByRa83Vb48NE0H71XafZ8cV1GO2XZEC8r6w
	DIdOzBnbe8rFCB+Esd4peK34L0wcG4Kwb4fu+/HQN23ynLFeLBOv4CXFM4P0XDbsQaYYIP
	T9HiKhCFqovXNrwL0MGv5/NCnvuuLncG5WuMhaHgn+Auye4Y9iFXSwRkxY5Xg5b28vQyDB
	lQ7Q/lSRuZL4I1hkNxKsjAnV9TpQhr6zacICdI6jNba1d6iTgVcrZXon/jyYA1wod16WD/
	LSdjLXtCA/3eFxHGsZ12aCggw/XncwA6L/hDXA2SjGcbEhjnfttjHW+GFdLdRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730282530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zO50zcxsIEHgZXPTC/5eQCKFakrTmKnwGXxVPcDAFiw=;
	b=OlhKreHCeJ97y01wOmheuaEqbwVWH2LceacW5eBtlGgUq5ga/eR/i/3ZmDfYJDV1kbiDDA
	3EUDPr92nAlnPtCQ==
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
Message-ID: <20241030100209.p9JX4qDb@linutronix.de>
References: <20241024150413.518862-1-bigeasy@linutronix.de>
 <20241024150413.518862-4-bigeasy@linutronix.de>
 <Zx-ZUyMLWWsxR8nL@localhost.localdomain>
 <20241029135231.ScfxKhz1@linutronix.de>
 <ZyFX6R_7HptXRdsK@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZyFX6R_7HptXRdsK@pavilion.home>

On 2024-10-29 22:47:21 [+0100], Frederic Weisbecker wrote:
> Le Tue, Oct 29, 2024 at 02:52:31PM +0100, Sebastian Andrzej Siewior a =C3=
=A9crit :
> > On 2024-10-28 15:01:55 [+0100], Frederic Weisbecker wrote:
> > > > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> > > > index 457151f9f263d..9637af78087f3 100644
> > > > --- a/include/linux/interrupt.h
> > > > +++ b/include/linux/interrupt.h
> > > > @@ -616,6 +616,50 @@ extern void __raise_softirq_irqoff(unsigned in=
t nr);
> > > >  extern void raise_softirq_irqoff(unsigned int nr);
> > > >  extern void raise_softirq(unsigned int nr);
> > > > =20
> > > > +/*
> > > > + * Handle timers in a dedicated thread at a low SCHED_FIFO priorit=
y instead in
> > > > + * ksoftirqd as to be prefred over SCHED_NORMAL tasks.
> > > > + */
> > >=20
> > > This doesn't parse. How about, inspired by your changelog:
> > =E2=80=A6
> >=20
> > What about this essay instead:
> >=20
> > | With forced-threaded interrupts enabled a raised softirq is deferred =
to
> > | ksoftirqd unless it can be handled within the threaded interrupt. This
> > | affects timer_list timers and hrtimers which are explicitly marked wi=
th
> > | HRTIMER_MODE_SOFT.
> > | With PREEMPT_RT enabled more hrtimers are moved to softirq for proces=
sing
> > | which includes all timers which are not explicitly marked HRTIMER_MOD=
E_HARD.
> > | Userspace controlled timers (like the clock_nanosleep() interface) is=
 divided
> > | into two categories: Tasks with elevated scheduling policy including
> > | SCHED_{FIFO|RR|DL} and the remaining scheduling policy. The tasks wit=
h the
> > | elevated scheduling policy are woken up directly from the HARDIRQ whi=
le all
> > | other wake ups are delayed to so softirq and so to ksoftirqd.
>=20
> First "so" is intended?

No, it needs to go.

> > |
> > | The ksoftirqd runs at SCHED_OTHER policy at which it should remain si=
nce it
> > | handles the softirq in an overloaded situation (not handled everything
> > | within its last run).
> > | If the timers are handled at SCHED_OTHER priority then they competes =
with all
> > | other SCHED_OTHER tasks for CPU resources are possibly delayed.
> > | Moving timers softirqs to a low priority SCHED_FIFO thread instead en=
sures
> > | that timer are performed before scheduling any SCHED_OTHER thread.
>=20
> Works for me!

Great.

> > And with this piece of text I convinced myself to also enable this in
> > the forced-threaded case.
>=20
> Yes, that makes sense.

Good. Then I'm pick to up your tag for that patch. Thank you.

> Thanks.
>=20
Sebastian
