Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D962E156C5F;
	Fri,  4 Oct 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038334; cv=none; b=d8H8kuz2ixAZazl8ON9Z82iaJSnGy25qD5OVPJnR1BGZ2Mx1YFlGpzmbcipHIJL8rva2yTwUJ+AQFOQkg9wX+6+o/+dAyUudDRKqJPFvr6f1uYfXpBjr1LxB/jC0fQhldyCU3T0/UbJemdsUaQt6DvNr5K+qBbwUBDm4jWm07As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038334; c=relaxed/simple;
	bh=z8ZXkay8HgoELDWCWTIHS0pMX3WrRR08Fki0/CTISx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPHvyAz0qC9/4xPA/XhOZq4g6M+MIfwNdU+O6P/Dd3L4UGeeJhbluk2blLK6pq8RBEdit/UsOUk0mkAQwKm+FAAv83/lrDcKydeep8naiuvyF6/23hZyF1AZdc8UX0slNV3OADNDEI4u8P6u5xlna1gqlgFCa3Cp/Xt0hrkNwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=joD9SW80; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/YSBy8ug; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="joD9SW80";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/YSBy8ug"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728038331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBgKKAO0Q/Z9dNt4RdWxipCkz06XMACjsNyLFX8vuSc=;
	b=joD9SW804yEFtyv77HdaOV7gDonSksTii7kyw8zorQb+qLBZl2Zo4m3acbhvhlAThjxHxn
	B+rf+tA1fnGjH06+FsYv6/vqyqhlh3NZk0Iuf2aCladge1j8jC9IABfRZWdUGTBjmKB0T7
	GAN2WOa/xuMEa8BZQg1dRr0sexjof0vaNll9bj1eACYjCZEzYFZAQyng/1coyPSWMyclwG
	39wIyMuod9iyVMky0qFJ+gxkF3tIrReCdUX2iqu8erItsnHk/Kw0gGlB7HlbfOBqdAW1Dw
	t0Fmm02Qn9JhivcdTkHayhElTAypjaYYpoPX3nwiY+d+ZM+RX5KlZRzbx/raFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728038331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBgKKAO0Q/Z9dNt4RdWxipCkz06XMACjsNyLFX8vuSc=;
	b=/YSBy8ug96ISxvIOTgVgJy0zRG9njNFnil6lXK4kpl0NhPPKpzWBCpDcIOYTbUcXYydKTa
	ghenMSGrZIP7yfAw==
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/1] softirq: Use a dedicated thread for timer wakeups on PREEMPT_RT.
Date: Fri,  4 Oct 2024 12:17:04 +0200
Message-ID: <20241004103842.131014-2-bigeasy@linutronix.de>
In-Reply-To: <20241004103842.131014-1-bigeasy@linutronix.de>
References: <20241004103842.131014-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A timer/ hrtimer softirq is raised in-IRQ context. With threaded
interrupts enabled or on PREEMPT_RT this leads to waking the ksoftirqd
for the processing of the softirq.
Once the ksoftirqd is marked as pending (or is running) it will collect
all raised softirqs. This in turn means that a softirq which would have
been processed at the end of the threaded interrupt, which runs at an
elevated priority, is now moved to ksoftirqd which runs at SCHED_OTHER
priority and competes with every regular task for CPU resources.
This introduces long delays on heavy loaded systems and is not desired
especially if the system is not overloaded by the softirqs.

Split the TIMER_SOFTIRQ and HRTIMER_SOFTIRQ processing into a dedicated
timers thread and let it run at the lowest SCHED_FIFO priority.
Wake-ups for RT tasks happen from hardirq context so only timer_list timers
and hrtimers for "regular" tasks are processed here. The higher priority
ensures that wakeups are performed before scheduling SCHED_OTHER tasks.

Using a dedicated variable to store the pending softirq bits values
ensure that the timer are not accidentally picked up by ksoftirqd and
other threaded interrupts.
It shouldn't be picked up by ksoftirqd since it runs at lower priority.
However if ksoftirqd is already running while a timer fires, then
ksoftird will be PI-boosted due to the BH-lock to ktimer's priority.
Ideally we try to avoid having ksoftirqd running.

The timer thread can pick up pending softirqs from ksoftirqd but only
if the softirq load is high. It is not be desired that the picked up
softirqs are processed at SCHED_FIFO priority under high softirq load
but this can already happen by a PI-boost by a force-threaded interrupt.

[ frederic@kernel.org: rcutorture.c fixes, storm fix by introduction of
  local_pending_timers() for tick_nohz_next_event() ]

[ junxiao.chang@intel.com: Ensure ktimersd gets woken up even if a
  softirq is currently served. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/interrupt.h | 29 ++++++++++++++
 kernel/rcu/rcutorture.c   |  6 +++
 kernel/softirq.c          | 82 ++++++++++++++++++++++++++++++++++++++-
 kernel/time/hrtimer.c     |  4 +-
 kernel/time/tick-sched.c  |  2 +-
 kernel/time/timer.c       |  2 +-
 6 files changed, 120 insertions(+), 5 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 457151f9f263d..4a4f367cd6864 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -616,6 +616,35 @@ extern void __raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
=20
+#ifdef CONFIG_PREEMPT_RT
+DECLARE_PER_CPU(struct task_struct *, timersd);
+DECLARE_PER_CPU(unsigned long, pending_timer_softirq);
+
+extern void raise_timer_softirq(void);
+extern void raise_hrtimer_softirq(void);
+
+static inline unsigned int local_pending_timers(void)
+{
+	return __this_cpu_read(pending_timer_softirq);
+}
+
+#else
+static inline void raise_timer_softirq(void)
+{
+	raise_softirq(TIMER_SOFTIRQ);
+}
+
+static inline void raise_hrtimer_softirq(void)
+{
+	raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+}
+
+static inline unsigned int local_pending_timers(void)
+{
+	return local_softirq_pending();
+}
+#endif
+
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
=20
 static inline struct task_struct *this_cpu_ksoftirqd(void)
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bb75dbf5c800c..609687fd742d5 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2440,6 +2440,12 @@ static int rcutorture_booster_init(unsigned int cpu)
 		WARN_ON_ONCE(!t);
 		sp.sched_priority =3D 2;
 		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+#ifdef CONFIG_PREEMPT_RT
+		t =3D per_cpu(timersd, cpu);
+		WARN_ON_ONCE(!t);
+		sp.sched_priority =3D 2;
+		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+#endif
 	}
=20
 	/* Don't allow time recalculation while creating a new task. */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d082e7840f880..2d847405e5a7f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -624,6 +624,24 @@ static inline void tick_irq_exit(void)
 #endif
 }
=20
+#ifdef CONFIG_PREEMPT_RT
+DEFINE_PER_CPU(struct task_struct *, timersd);
+DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
+
+static void wake_timersd(void)
+{
+	struct task_struct *tsk =3D __this_cpu_read(timersd);
+
+	if (tsk)
+		wake_up_process(tsk);
+}
+
+#else
+
+static inline void wake_timersd(void) { }
+
+#endif
+
 static inline void __irq_exit_rcu(void)
 {
 #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
@@ -636,6 +654,10 @@ static inline void __irq_exit_rcu(void)
 	if (!in_interrupt() && local_softirq_pending())
 		invoke_softirq();
=20
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers() &&
+	    !(in_nmi() | in_hardirq()))
+		wake_timersd();
+
 	tick_irq_exit();
 }
=20
@@ -971,12 +993,70 @@ static struct smp_hotplug_thread softirq_threads =3D {
 	.thread_comm		=3D "ksoftirqd/%u",
 };
=20
+#ifdef CONFIG_PREEMPT_RT
+static void timersd_setup(unsigned int cpu)
+{
+	sched_set_fifo_low(current);
+}
+
+static int timersd_should_run(unsigned int cpu)
+{
+	return local_pending_timers();
+}
+
+static void run_timersd(unsigned int cpu)
+{
+	unsigned int timer_si;
+
+	ksoftirqd_run_begin();
+
+	timer_si =3D local_pending_timers();
+	__this_cpu_write(pending_timer_softirq, 0);
+	or_softirq_pending(timer_si);
+
+	__do_softirq();
+
+	ksoftirqd_run_end();
+}
+
+static void raise_ktimers_thread(unsigned int nr)
+{
+	trace_softirq_raise(nr);
+	__this_cpu_or(pending_timer_softirq, 1 << nr);
+}
+
+void raise_hrtimer_softirq(void)
+{
+	raise_ktimers_thread(HRTIMER_SOFTIRQ);
+}
+
+void raise_timer_softirq(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	raise_ktimers_thread(TIMER_SOFTIRQ);
+	wake_timersd();
+	local_irq_restore(flags);
+}
+
+static struct smp_hotplug_thread timer_threads =3D {
+	.store			=3D &timersd,
+	.setup			=3D timersd_setup,
+	.thread_should_run	=3D timersd_should_run,
+	.thread_fn		=3D run_timersd,
+	.thread_comm		=3D "ktimers/%u",
+};
+#endif
+
 static __init int spawn_ksoftirqd(void)
 {
 	cpuhp_setup_state_nocalls(CPUHP_SOFTIRQ_DEAD, "softirq:dead", NULL,
 				  takeover_tasklets);
 	BUG_ON(smpboot_register_percpu_thread(&softirq_threads));
-
+#ifdef CONFIG_PREEMPT_RT
+	BUG_ON(smpboot_register_percpu_thread(&timer_threads));
+#endif
 	return 0;
 }
 early_initcall(spawn_ksoftirqd);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index cddcd08ea827f..133d49f703d93 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1811,7 +1811,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next =3D KTIME_MAX;
 		cpu_base->softirq_activated =3D 1;
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		raise_hrtimer_softirq();
 	}
=20
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
@@ -1906,7 +1906,7 @@ void hrtimer_run_queues(void)
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next =3D KTIME_MAX;
 		cpu_base->softirq_activated =3D 1;
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		raise_hrtimer_softirq();
 	}
=20
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 753a184c70907..efa3181607a2b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -859,7 +859,7 @@ static void tick_nohz_restart(struct tick_sched *ts, kt=
ime_t now)
=20
 static inline bool local_timer_softirq_pending(void)
 {
-	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
+	return local_pending_timers() & BIT(TIMER_SOFTIRQ);
 }
=20
 /*
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0fc9d066a7be4..79f0dc73ac436 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2499,7 +2499,7 @@ static void run_local_timers(void)
 		 */
 		if (time_after_eq(jiffies, READ_ONCE(base->next_expiry)) ||
 		    (i =3D=3D BASE_DEF && tmigr_requires_handle_remote())) {
-			raise_softirq(TIMER_SOFTIRQ);
+			raise_timer_softirq();
 			return;
 		}
 	}
--=20
2.45.2

