Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D7D1E377D;
	Thu, 24 Oct 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782269; cv=none; b=fHiQYxKiCQF7gyhKSeC4iFX2hqJa2YgiLy/GjyLEYXoxQGbe9bntxtQ1fxdIaQRrh+GzgIecGyxhGFV/M66aQnoeORIGhknlW6ELByFN+Oq/bgV62WxhAISfWncAV8suoCCNFl0/aVxEeSxUC7BMlkYuJRQUfV3oBiA20DyRJ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782269; c=relaxed/simple;
	bh=xcGhakrZUBn48OepV138/F7Fax1Vq6RyEkJQAX6vOCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phpE+S772E59wjBMqazFLTKyE/3qZzMAigKyneConV6hJrg0pZjTrWaQwtxXQkejyY9lwycpvnLoyzIl1T2S0XByRIBH31Sibfoago6hh5wqqf8JYPv8CnCVOk00geurz0coJYKMJIE427CCDDmhL4+ayN6o58y5bGTrqQSvYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GVzKZVHv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9iwJxl1a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GVzKZVHv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9iwJxl1a"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729782260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/12p1wmUAGKBLrwHiGde7XNj74xQnBZYdchqQ0uIiA=;
	b=GVzKZVHvTWU/hEVDPA4LpwKsGqciuLzfyLhE7NmxRj9ieJAijHXp0MFrLigvA1QtW9s3Lm
	bnoCaZ17u02ZRjRGJGs9hZYfhMtbopvvN4J/SDvbTZeHcxik8ZrEwidad6zS8+oQhzq7Xg
	WG5dOoUNd+5joW9WZl57V7K4o9YkqoGMrMcXNzbv+ZM6rSbNCFwDh8OSZHVRoIyYjj+zQZ
	JXa1ot7KAaWpSxp2nZE9syjGyQggMwL11jjA2APB2Q7ixHh5qYX9mpES+moZAFYoB5V8nw
	LLckmlSj51HFfLPWi1eqrgKzwmFkCNqCXNPAnlunFzd6PTDkR9WqyGhy1cdaJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729782260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/12p1wmUAGKBLrwHiGde7XNj74xQnBZYdchqQ0uIiA=;
	b=9iwJxl1aau/1a/3xsGIkftUvETeuDro6EWvPDsM3gh0Na8RWbKKFjVyI48boBhpHqWXGtR
	/GWA1bmcdK7et4Dw==
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
Subject: [PATCH v2 3/3] softirq: Use a dedicated thread for timer wakeups on PREEMPT_RT.
Date: Thu, 24 Oct 2024 16:55:51 +0200
Message-ID: <20241024150413.518862-4-bigeasy@linutronix.de>
In-Reply-To: <20241024150413.518862-1-bigeasy@linutronix.de>
References: <20241024150413.518862-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A timer/ hrtimer softirq is raised in-IRQ context. With threaded
interrupts enabled or on PREEMPT_RT this leads to waking the ksoftirqd
for the processing of the softirq. ksoftirqd runs as SCHED_OTHER which
means it will compete with other tasks for CPU ressources.
This can introduce long delays for timer processing on heavy loaded
systems and is not desired.

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
  local_timers_pending() for tick_nohz_next_event() ]

[ junxiao.chang@intel.com: Ensure ktimersd gets woken up even if a
  softirq is currently served. ]

Reviewed-by: Paul E. McKenney <paulmck@kernel.org> [rcutorture]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/interrupt.h | 44 +++++++++++++++++++++++++
 kernel/rcu/rcutorture.c   |  6 ++++
 kernel/softirq.c          | 69 ++++++++++++++++++++++++++++++++++++++-
 kernel/time/hrtimer.c     |  4 +--
 kernel/time/tick-sched.c  |  2 +-
 kernel/time/timer.c       |  2 +-
 6 files changed, 122 insertions(+), 5 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 457151f9f263d..9637af78087f3 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -616,6 +616,50 @@ extern void __raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
=20
+/*
+ * Handle timers in a dedicated thread at a low SCHED_FIFO priority instea=
d in
+ * ksoftirqd as to be prefred over SCHED_NORMAL tasks.
+ */
+#ifdef CONFIG_PREEMPT_RT
+DECLARE_PER_CPU(struct task_struct *, timersd);
+DECLARE_PER_CPU(unsigned long, pending_timer_softirq);
+
+void raise_ktimers_thread(unsigned int nr);
+
+static inline void raise_timer_softirq(void)
+{
+	raise_ktimers_thread(TIMER_SOFTIRQ);
+}
+
+static inline void raise_hrtimer_softirq(void)
+{
+	raise_ktimers_thread(HRTIMER_SOFTIRQ);
+}
+
+static inline unsigned int local_timers_pending(void)
+{
+	return __this_cpu_read(pending_timer_softirq);
+}
+
+#else
+static inline void raise_timer_softirq(void)
+{
+	lockdep_assert_in_irq();
+	__raise_softirq_irqoff(TIMER_SOFTIRQ);
+}
+
+static inline void raise_hrtimer_softirq(void)
+{
+	lockdep_assert_in_irq();
+	__raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+}
+
+static inline unsigned int local_timers_pending(void)
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
index d082e7840f880..b452206cf93b2 100644
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
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_timers_pending() &&
+	    !(in_nmi() | in_hardirq()))
+		wake_timersd();
+
 	tick_irq_exit();
 }
=20
@@ -971,12 +993,57 @@ static struct smp_hotplug_thread softirq_threads =3D {
 	.thread_comm		=3D "ksoftirqd/%u",
 };
=20
+#ifdef CONFIG_PREEMPT_RT
+static void timersd_setup(unsigned int cpu)
+{
+	/* Above SCHED_NORMAL to handle timers before regular tasks. */
+	sched_set_fifo_low(current);
+}
+
+static int timersd_should_run(unsigned int cpu)
+{
+	return local_timers_pending();
+}
+
+void raise_ktimers_thread(unsigned int nr)
+{
+	lockdep_assert_in_irq();
+	trace_softirq_raise(nr);
+	__this_cpu_or(pending_timer_softirq, 1 << nr);
+}
+
+static void run_timersd(unsigned int cpu)
+{
+	unsigned int timer_si;
+
+	ksoftirqd_run_begin();
+
+	timer_si =3D local_timers_pending();
+	__this_cpu_write(pending_timer_softirq, 0);
+	or_softirq_pending(timer_si);
+
+	__do_softirq();
+
+	ksoftirqd_run_end();
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
index 5402e0f242178..133d49f703d93 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1811,7 +1811,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next =3D KTIME_MAX;
 		cpu_base->softirq_activated =3D 1;
-		__raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		raise_hrtimer_softirq();
 	}
=20
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
@@ -1906,7 +1906,7 @@ void hrtimer_run_queues(void)
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next =3D KTIME_MAX;
 		cpu_base->softirq_activated =3D 1;
-		__raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		raise_hrtimer_softirq();
 	}
=20
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 753a184c70907..976a212cca2e8 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -859,7 +859,7 @@ static void tick_nohz_restart(struct tick_sched *ts, kt=
ime_t now)
=20
 static inline bool local_timer_softirq_pending(void)
 {
-	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
+	return local_timers_pending() & BIT(TIMER_SOFTIRQ);
 }
=20
 /*
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 1759de934284c..79f0dc73ac436 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2499,7 +2499,7 @@ static void run_local_timers(void)
 		 */
 		if (time_after_eq(jiffies, READ_ONCE(base->next_expiry)) ||
 		    (i =3D=3D BASE_DEF && tmigr_requires_handle_remote())) {
-			__raise_softirq_irqoff(TIMER_SOFTIRQ);
+			raise_timer_softirq();
 			return;
 		}
 	}
--=20
2.45.2

