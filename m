Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900201E0480;
	Wed,  6 Nov 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905468; cv=none; b=ZepPXaq/RQPHfe7X4h/kCXVL6n08LoTCyXsq/UnLGGr3TCpPnrzMLhn876jKq9ipOSGJdUaV/RvS89UufLl1Tq/dBXx0Dx9mJj99LIwTxUrQJrCC4QhZ3B12y6gNj2mARorP4R+2yPALaDBk/Wb3Vw8MF1W6rgzICyEB3XeC2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905468; c=relaxed/simple;
	bh=/OhfqejPJef7VQXGemb/KclkCjTjnbbRntwudVrIMOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6Szz9vyekZ1ULktiWMlPxgkugnogBUsn5D9LVRd4bLDq6zWE7xhRExGAex+ZtGtdFQb1DS04ktnH+nsALN/yL2aL8Vt8Z0EFYxVmOi1OFyF3l+4c5LG8dlk3yYEswkJ8kYahfm/pdmBBbJjBaGvc22I5fO6VJVWnykfsnCtXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0S0xVQ99; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MvabPoPV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0S0xVQ99";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MvabPoPV"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730905465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYGme8j2WAcycpd4M3rLdGZG1I9wfekiNHMJbeO0PY8=;
	b=0S0xVQ99vZCpXTLXwN3sTYKnIFmycTfeJmmvjnId9mZPJ148Jr+kYrQL+3ktsg42zmmuS5
	ADu7v9U74/MJc1GaERu/yJPpqaXEYAFvvbbpJ+qd+OPGfmvm16QDENwI4gOMOwspXY0fPP
	Jj2FBp5o4VoTkp7DvZ9+miMT23zSfdz/iFrfWXmnOXiQE2IELxVkpJD7AFNJ+Wc1c/cbNX
	KqefTikzUJ8zM0PyMfkhStBWgnhNBORSbI3RGuckITcVEUUGOH1ggN9Mx3HBOBLZtdUTcN
	6nQD2zQHL3dJh/FPv8wHxpd37MoaZPiDc4u7687giXHyreTnhbS/SJLRGbyZwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730905465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYGme8j2WAcycpd4M3rLdGZG1I9wfekiNHMJbeO0PY8=;
	b=MvabPoPVVB8E/aiAqsn3zWiRt8X/d0+5wNy+dWirav4gyufxp0ywch9IeKRX4kPUrbnkTi
	BI1tIM1SiKWwAQAA==
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
Subject: [PATCH v3 3/3] softirq: Use a dedicated thread for timer wakeups on PREEMPT_RT.
Date: Wed,  6 Nov 2024 15:51:39 +0100
Message-ID: <20241106150419.2593080-4-bigeasy@linutronix.de>
In-Reply-To: <20241106150419.2593080-1-bigeasy@linutronix.de>
References: <20241106150419.2593080-1-bigeasy@linutronix.de>
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
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/interrupt.h | 47 ++++++++++++++++++++++++++
 kernel/rcu/rcutorture.c   |  8 +++++
 kernel/softirq.c          | 69 ++++++++++++++++++++++++++++++++++++++-
 kernel/time/hrtimer.c     |  4 +--
 kernel/time/tick-sched.c  |  2 +-
 kernel/time/timer.c       |  2 +-
 6 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 457151f9f263d..8cd9327e4e78d 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -616,6 +616,53 @@ extern void __raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
=20
+/*
+ * With forced-threaded interrupts enabled a raised softirq is deferred to
+ * ksoftirqd unless it can be handled within the threaded interrupt. This
+ * affects timer_list timers and hrtimers which are explicitly marked with
+ * HRTIMER_MODE_SOFT.
+ * With PREEMPT_RT enabled more hrtimers are moved to softirq for processi=
ng
+ * which includes all timers which are not explicitly marked HRTIMER_MODE_=
HARD.
+ * Userspace controlled timers (like the clock_nanosleep() interface) is d=
ivided
+ * into two categories: Tasks with elevated scheduling policy including
+ * SCHED_{FIFO|RR|DL} and the remaining scheduling policy. The tasks with =
the
+ * elevated scheduling policy are woken up directly from the HARDIRQ while=
 all
+ * other wake ups are delayed to softirq and so to ksoftirqd.
+ *
+ * The ksoftirqd runs at SCHED_OTHER policy at which it should remain sinc=
e it
+ * handles the softirq in an overloaded situation (not handled everything
+ * within its last run).
+ * If the timers are handled at SCHED_OTHER priority then they competes wi=
th all
+ * other SCHED_OTHER tasks for CPU resources are possibly delayed.
+ * Moving timers softirqs to a low priority SCHED_FIFO thread instead ensu=
res
+ * that timer are performed before scheduling any SCHED_OTHER thread.
+ */
+DECLARE_PER_CPU(struct task_struct *, ktimerd);
+DECLARE_PER_CPU(unsigned long, pending_timer_softirq);
+void raise_ktimers_thread(unsigned int nr);
+
+static inline unsigned int local_timers_pending_force_th(void)
+{
+	return __this_cpu_read(pending_timer_softirq);
+}
+
+static inline void raise_timer_softirq(unsigned int nr)
+{
+	lockdep_assert_in_irq();
+	if (force_irqthreads())
+		raise_ktimers_thread(nr);
+	else
+		__raise_softirq_irqoff(nr);
+}
+
+static inline unsigned int local_timers_pending(void)
+{
+	if (force_irqthreads())
+		return local_timers_pending_force_th();
+	else
+		return local_softirq_pending();
+}
+
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
=20
 static inline struct task_struct *this_cpu_ksoftirqd(void)
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bb75dbf5c800c..270c31a1e8570 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2440,6 +2440,14 @@ static int rcutorture_booster_init(unsigned int cpu)
 		WARN_ON_ONCE(!t);
 		sp.sched_priority =3D 2;
 		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+#ifdef CONFIG_IRQ_FORCED_THREADING
+		if (force_irqthreads()) {
+			t =3D per_cpu(ktimerd, cpu);
+			WARN_ON_ONCE(!t);
+			sp.sched_priority =3D 2;
+			sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+		}
+#endif
 	}
=20
 	/* Don't allow time recalculation while creating a new task. */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d082e7840f880..7b525c9044626 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -624,6 +624,24 @@ static inline void tick_irq_exit(void)
 #endif
 }
=20
+#ifdef CONFIG_IRQ_FORCED_THREADING
+DEFINE_PER_CPU(struct task_struct *, ktimerd);
+DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
+
+static void wake_timersd(void)
+{
+	struct task_struct *tsk =3D __this_cpu_read(ktimerd);
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
+	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
+	    local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))
+		wake_timersd();
+
 	tick_irq_exit();
 }
=20
@@ -971,12 +993,57 @@ static struct smp_hotplug_thread softirq_threads =3D {
 	.thread_comm		=3D "ksoftirqd/%u",
 };
=20
+#ifdef CONFIG_IRQ_FORCED_THREADING
+static void ktimerd_setup(unsigned int cpu)
+{
+	/* Above SCHED_NORMAL to handle timers before regular tasks. */
+	sched_set_fifo_low(current);
+}
+
+static int ktimerd_should_run(unsigned int cpu)
+{
+	return local_timers_pending_force_th();
+}
+
+void raise_ktimers_thread(unsigned int nr)
+{
+	trace_softirq_raise(nr);
+	__this_cpu_or(pending_timer_softirq, BIT(nr));
+}
+
+static void run_ktimerd(unsigned int cpu)
+{
+	unsigned int timer_si;
+
+	ksoftirqd_run_begin();
+
+	timer_si =3D local_timers_pending_force_th();
+	__this_cpu_write(pending_timer_softirq, 0);
+	or_softirq_pending(timer_si);
+
+	__do_softirq();
+
+	ksoftirqd_run_end();
+}
+
+static struct smp_hotplug_thread timer_thread =3D {
+	.store			=3D &ktimerd,
+	.setup			=3D ktimerd_setup,
+	.thread_should_run	=3D ktimerd_should_run,
+	.thread_fn		=3D run_ktimerd,
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
+#ifdef CONFIG_IRQ_FORCED_THREADING
+	if (force_irqthreads())
+		BUG_ON(smpboot_register_percpu_thread(&timer_thread));
+#endif
 	return 0;
 }
 early_initcall(spawn_ksoftirqd);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5402e0f242178..d9911516e7431 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1811,7 +1811,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next =3D KTIME_MAX;
 		cpu_base->softirq_activated =3D 1;
-		__raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		raise_timer_softirq(HRTIMER_SOFTIRQ);
 	}
=20
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
@@ -1906,7 +1906,7 @@ void hrtimer_run_queues(void)
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next =3D KTIME_MAX;
 		cpu_base->softirq_activated =3D 1;
-		__raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		raise_timer_softirq(HRTIMER_SOFTIRQ);
 	}
=20
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f203f000da1ad..e0c47259e91a7 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -865,7 +865,7 @@ static void tick_nohz_restart(struct tick_sched *ts, kt=
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
index 1759de934284c..06f0bc1db6d9a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2499,7 +2499,7 @@ static void run_local_timers(void)
 		 */
 		if (time_after_eq(jiffies, READ_ONCE(base->next_expiry)) ||
 		    (i =3D=3D BASE_DEF && tmigr_requires_handle_remote())) {
-			__raise_softirq_irqoff(TIMER_SOFTIRQ);
+			raise_timer_softirq(TIMER_SOFTIRQ);
 			return;
 		}
 	}
--=20
2.45.2

