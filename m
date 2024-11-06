Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93A18FDA9;
	Wed,  6 Nov 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905467; cv=none; b=IeucNbJ7rqTIVeqoIIMVFBHegj+iVxqIWU52ijXu+nOpZM9v03o43IaWAl+JaO2PeAzouLkErNs83yiAxYcLU2Y/4BtVKyTy8EXVu1VbahsIwpohoI0g/Mja6udVIvhm/ik8qhrSwTmcSXVFBlkfIms+67HJnnP7GekBop0xuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905467; c=relaxed/simple;
	bh=UyPsuXNOHce6w3ZVswEX3aJQjzNv+biy8tB8kZZlk8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=txX+j0DfQR52HiBfjytCeZoU7upkB4fMwbywTTvGFzuIKAyp70/uRkLjXfUV1e9OrkiwvIeYlP9GII0buoWwKWU/HtXZIBckqE5tqiWwpEAT2O0RgqK4/thPPjncJCM1KRGi4KzoYf78wALG+DtfqQL0VNcXPtKRNMXzdSucgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SYbb8gQB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bLFIvxa3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SYbb8gQB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bLFIvxa3"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730905463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CAg6mrQUSWZlpu+t+H2pQH5oOn4/8PZrFlZDChI/EgU=;
	b=SYbb8gQBZ8cK7YDNLI5s8xpkdCLWGOHoWKaOR5yiC2KPA1pBh8As7e0vdXTdDTxlRs3zG0
	UtDzrI/Y0ZvKMt/gvYIxhsf5O9vKUs5skVKA94UCvDyhYA2WCy+mMSdhqlMpBc66w/rNi6
	RavjkoAMLQVqhQIrmgf9egMSTm0aMVXf3huxdSkqbJ4g+meU4z9uzftn19BjN9HZ++mxK5
	lrBz7u7ACk9CkV00QovDtORsMwfnmFRsHGTbvVOzNqJEdeLDxM30gaakEzO7t/eRBt1H4l
	GoKKQTdUGAwJqZum4lpQ1Nq56cyFdYr+7oWSpq0do36Ah4fhMGF48OqCly/sIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730905463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CAg6mrQUSWZlpu+t+H2pQH5oOn4/8PZrFlZDChI/EgU=;
	b=bLFIvxa3Cq6rXd1WBNlVY9ECpXBS6E5GPwgZmikA3wDsu+Zw+K6Z/6LTk6kRC1BmfxZmP2
	UqWyvDFi54r6JkCg==
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: PATCH v3 0/3] softirq: Use a dedicated thread for timer wakeups with forced-threading.
Date: Wed,  6 Nov 2024 15:51:36 +0100
Message-ID: <20241106150419.2593080-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

the following was in the PREEMPT_RT queue since last softirq rework. The
result is that timer wake ups (hrtimer, timer_list) happens in hardirq
processing them requires to wake ksoftirqd. ksoftirqd runs at SCHED_OTHER s=
o it
will compete for resources with all other tasks in the system, potentially
delayed the processing further.

The idea was to let the timers be processed by a dedicated thread
running at low SCHED_FIFO priority.
While looking at it again, it might make sense to have the
pending_softirq flag per-thread to avoid threads with higher priority
picking up softirqs from low-priority threads. This isn't yet a problem
because adding softirqs for processing happens only from threaded
interrupts. So the low-priority thread will wait until the high-priority
thread is done. And the high-priority thread will PI-boost the
low-priority thread until it is done. It would only make sense to make
the flags per-thread once the BH lock is gone.

The patch is limited to the forced threaded case.

v2=E2=80=A6v3 https://lore.kernel.org/all/20241024150413.518862-1-bigeasy@l=
inutronix.de/
 - Redo the comment in interrupt.h. Make it more verbose and add more
   details. Frederick asked for it.

 - After updating the comment I convinced myself that it also makes
   sense to use this in the forced threaded case.

 - Merged raise_hrtimer_softirq() and raise_timer_softirq() into a
   single function since both use __raise_softirq_irqoff() in the
   alternative case.
=20
v1=E2=80=A6v2 https://lore.kernel.org/all/20241004103842.131014-1-bigeasy@l=
inutronix.de/
 Frederick's comments:
 - Use __raise_softirq_irqoff() to raise the softirq for !PREEMPT_RT. Also a
   lockdep test to ensure that this is always invoked from an IRQ.
 - Make raise_ktimers_thread() only OR the flag and nothing else to
   align with __raise_softirq_irqoff(). The wake happens on return from
   interrupt anyway.
 - A comment in timersd_setup() and interrupt.h
 - local_pending_timers() =3D> local_timers_pending().

Sebastian

