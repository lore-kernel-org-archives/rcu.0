Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538C1B983F;
	Thu, 24 Oct 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782268; cv=none; b=nYPLwVpTGS0k0AvqMgvJVnKZXLoim31aNinIELJgRVMf/5stZduGZ6ciGaEwHOzQcob5dJymyFPBI1jVm+BesyHYX9G8BKx/TxwovpUiaC6IJqes1NEtELtLspK+6KJAr+6td48PqRQiTMF5ZxaovkoqeYlX1mwbEHqAXSwchT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782268; c=relaxed/simple;
	bh=SoohIX4A8iq+a394BKxuqcPe7xfBSY1DJV2TDucHwFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tvLakex+qjXGJSnvv17ZIAt/LVmnK6z14/WZTCk3SxKHvQPNXKrz6AK/sHP2/qCUW0kp6F/1lE0RW64gwkvxty52z/xZQRPSDdhhiaWAcCWyZ0F5aPeUYtfKNmOKwGJq6BzHLgqz8tOwrTIM5dngGd5gQFfUPuasJH+Pg6Cenzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yVtgLiY7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a6eQ1FRy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yVtgLiY7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a6eQ1FRy"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729782259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OsoLDSGHUhlix5riksMYLdDZFvTpSEdwUTBBLqYAa0A=;
	b=yVtgLiY7kxzdJAXqBiRJFOj8DnNeDT2isvUHmPbsqMzV9QJWqQPvXB/C1U3E4nP6IKdFAx
	Rj9iE94wuncptQvy6S9PSACkpkNjqR0hZ26jHl4Vglrm9ZYcBX7+0TVrw+LV+xX9fm1H+M
	cpcytt0iZ9QV+/WBdJ0EYBBAiEKq8vckq8RDPi+UW0FgG/j41+dLp6s+FFwLxaUkMLQqEU
	wiSzNJLo38/w/YWRPGBXChXqiYT9jDQMvjyNg0/EKTAKsHaAS8pNsP9Ftg+pFvLm6GK1x1
	kgB0MpTr56/rbrpVml9xeLp0J5W5jBUW0k7TMbSOjyv76+AkPx4llVxf1tLpzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729782259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OsoLDSGHUhlix5riksMYLdDZFvTpSEdwUTBBLqYAa0A=;
	b=a6eQ1FRyvtMi/JErjcYKTw8UKKRW40XRIfpD+fCBC7q5E3giV//eLtnmRqF3tYKnpoNjLc
	2jkxPblvIZX6z2CQ==
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 0/3] softirq: Use a dedicated thread for timer wakeups on PREEMPT_RT.
Date: Thu, 24 Oct 2024 16:55:48 +0200
Message-ID: <20241024150413.518862-1-bigeasy@linutronix.de>
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

The patch is limited to PREEMPT_RT. The ksoftirqd bullets from above
apply also to !PREEMPT_RT +threadirqs. Would it make sense to restrict
it to force_irqthreads() instead?

v1=E2=80=A6v2: https://lore.kernel.org/all/20241004103842.131014-1-bigeasy@=
linutronix.de/
 Frederick's comments:
 - Use __raise_softirq_irqoff() to raise the softirq for !PREEMPT_RT. Also a
   lockdep test to ensure that this is always invoked from an IRQ.
 - Make raise_ktimers_thread() only OR the flag and nothing else to
   align with __raise_softirq_irqoff(). The wake happens on return from
   interrupt anyway.
 - A comment in timersd_setup() and interrupt.h
 - local_pending_timers() =3D> local_timers_pending().

Sebastian

