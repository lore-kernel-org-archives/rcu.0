Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1952A326939
	for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 03:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752325; cv=none; b=ot0W3yVLtzX48Zs4+8YLraArc+0Ia8oGYNmDgv2m9YcHXCxgS050F9uIpuVafDPdqit6H9Z5wpu+npYxc/7GwXmqdzEDsrI53jv52mtarLsh1Z75BuOI/4qPLI4ZtUPvHpLZGY9LnTgpVQR8HKmLCQziRAVNIpBgnhXByFpUMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752325; c=relaxed/simple;
	bh=NGMo6Qrww1dJu/rQIpKoY8Dsqru3A+nBInxhSjZKlJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JV75CJzS7iWi0N8ZTNcAmu4wCcov9B5kE6x1kvJxWKeIk6PbnYcThuKxKHZORJyjA2I+XuqG8j7oPqcejgaegf+R1tSeJ3UvXwL/Sex1/w+AJyTW7QgrACO/TbqQHTwL+Bn8tr0NW0GEDkKIXOpfa8cA4uknSV3xbQL9ZGe+DHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgIzoKEG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgIzoKEG"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c6d31bfc8aso3096045ad.2
        for <rcu@vger.kernel.org>; Wed, 17 Jun 2026 20:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752323; x=1782357123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHPKcwKivbUSuSD1ETvryOn1BWPlqo5A5EDmYEYSw9g=;
        b=VgIzoKEGvj64yDtKUpABwC6fSoqI9NQdNIRNsIvl208WEH5OtxLqVw1TVszBPx8jKB
         2fTUZEMpm9oE/7jQ5URCsEs0LVwVwhb9hlPsvi3tidk0+HOJkGxcnRByebmG26Ta6XIz
         5hrOJMN2G9nWHfC5ZLH0AVIZ2JUcqMGp1wRRz53BqxAipuNzphl5SEzYOAEhjDGmRwD1
         rLVbJDjL8TFmtli9WfD2SUIXvYQOY48UV2QNy7xOHKghB2nZ4ouiIQM7LGFU0IrdoQu7
         1UKK4ZluK6eV4M/MN4tfBhwsPqGk8fKWzkfO28s3Mm9lX0hN6/r3EJIYrzmTQf/tlata
         IhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752323; x=1782357123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HHPKcwKivbUSuSD1ETvryOn1BWPlqo5A5EDmYEYSw9g=;
        b=i7YxaAXGY09b0B66D2Z9utVIdsbWiTCoySLXo2N55OUrj0Yr+a0w3ssnn8pGXXt7Lc
         ZeTvzuaHskeIeIUWHvfcTgKYGGaQh9roR48rsLyiDlY7/5uKyBc8CrLsGZurEFlRoSDK
         vxDaXZh1v/RF7Zock8cUNv01DoUV948XBSIQwGv5IJqVKSz79q9iEChwv2LmsyktMJSR
         btJWO48yZqrXjp3M7OB74aJiMaNGnLhST98lTQ+TCouC4x1wfl3XROuU/r03lk1pHXeT
         0ohAC/GuX1VSDkH79Yf0uh9LUZvUenBPeR7KsvONXoiPytwwtJHhPdxMISN3s+FpjiS3
         oMvA==
X-Forwarded-Encrypted: i=1; AFNElJ+rsc8083TYM8TbfdBHrhCdZkitfHetQ/z5eSOZj+PKhJef9s27s/sXn7GoE+DuWkFVsuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsU8OBAEBAqWgdg5a1c3cvMQ0AbCFd8LbmJsbLWPdJ9bYA0K3S
	lZD/TyMj78G1dSJOySYUcjdJg1apIl/xJP1chJZ0eU4Y0BdhF7u7yDtC
X-Gm-Gg: AfdE7ckr4d+spZYnxhe3yMirVP26QpjAiZEgc5xp3YjC+vOAm+Q6TMkgeKdqyim6y3c
	Qe4q1klpl48gvgn45s+pdwofU3CXmUdySnuAvl1+x04O1xbEDKD+qPB3EcwKU9lsOpTdO8TGBmH
	VuOZQDV8fJCz2nOBbPmovw19aB2c9gbqCgg+EqPcsX+iJvIN1ZT/11Q+lv7on5k/A/7BpBcjkeq
	Vcc0/aXB3P7SGtXD60+eGS4a6cpv8SI1NogqvCpXyA2h7sysKfrDQkE+TDMdFRW3Bun5itBrvXf
	mGAmWDoH5CvbZeuk6Va+XQa5Eh1GSufTMjzgVnj7oSok/qLZGAJMvtrFwoIJyoPyVSBzfEmGxgD
	9JMEaMHQQbaA38xC5wLnCPijvGqCdlSop92m1gj+mZcww1TekaioQeG2oelWV0DcqWKhUROaw4b
	VmwvAH40MBw6o=
X-Received: by 2002:a17:903:32d0:b0:2c1:ef9:4516 with SMTP id d9443c01a7336-2c6e52e23edmr17236945ad.35.1781752323371;
        Wed, 17 Jun 2026 20:12:03 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:12:03 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:17 +0800
Subject: [PATCH v3 06/13] tick/nohz, context_tracking: Prepare for runtime
 nohz_full updates
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260618-wujing-dhm-v3-6-28f1a4d83b68@gmail.com>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
In-Reply-To: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0

Remove __init from ct_cpu_track_user() and __initdata from the
initialized flag so context tracking can be activated on CPUs that
join nohz_full at runtime.  Drop the __ro_after_init attribute from
the context_tracking_key static key, allowing static_branch_dec()
when a CPU leaves nohz_full.

Add ct_cpu_untrack_user() to reverse ct_cpu_track_user(), decrementing
the static key and clearing the per-CPU tracking state.

Register a housekeeping_cbs for HK_TYPE_KERNEL_NOISE that:
- pre_validate: checks CONFIG_NO_HZ_FULL is available.
- apply: snapshots the new HK_TYPE_KERNEL_NOISE mask under an RCU
  read lock (the lockdep annotation in housekeeping_cpumask() requires
  this even after synchronize_rcu() completes), computes nohz_full as
  the complement of the housekeeping mask, then under tick_nohz_lock:
  - Activates context tracking (ct_cpu_track_user()) on CPUs newly
    added to nohz_full, and deactivates it (ct_cpu_untrack_user()) on
    CPUs returning to the housekeeping set.  This activates the
    context_tracking_key static key dynamically, eliminating the
    need for CONFIG_CONTEXT_TRACKING_USER_FORCE.
  - Updates tick_nohz_full_mask in-place (legacy EXPORT_SYMBOL_GPL
    snapshot, eventually consistent).
  - Migrates tick_do_timer_cpu if it moved into the isolated set.
  - Kicks all CPUs to re-evaluate tick behaviour.

When CONFIG_CONTEXT_TRACKING_USER_FORCE is enabled and nohz_full= is
given at boot, tick_nohz_init() now calls context_tracking_init()
before iterating over tick_nohz_full_mask to call ct_cpu_track_user().
This ensures the per-CPU tracking state is set up before any CPU is
tracked, which is also required for CPUs later added to nohz_full at
runtime via DHM isolated partitions.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 include/linux/context_tracking.h |   1 +
 kernel/context_tracking.c        |  23 ++----
 kernel/time/tick-sched.c         | 157 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 161 insertions(+), 20 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index af9fe87a09225..632cfc97b5b22 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -12,6 +12,7 @@
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 extern void ct_cpu_track_user(int cpu);
+extern void ct_cpu_untrack_user(int cpu);
 
 /* Called with interrupts disabled.  */
 extern void __ct_user_enter(enum ctx_state state);
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index a743e7ffa6c00..e68fb02b25ad4 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -411,7 +411,7 @@ static __always_inline void ct_kernel_enter(bool user, int offset) { }
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
-DEFINE_STATIC_KEY_FALSE_RO(context_tracking_key);
+DEFINE_STATIC_KEY_FALSE(context_tracking_key);
 EXPORT_SYMBOL_GPL(context_tracking_key);
 
 static noinstr bool context_tracking_recursion_enter(void)
@@ -674,28 +674,21 @@ void user_exit_callable(void)
 }
 NOKPROBE_SYMBOL(user_exit_callable);
 
-void __init ct_cpu_track_user(int cpu)
+void ct_cpu_track_user(int cpu)
 {
-	static __initdata bool initialized = false;
-
 	if (!per_cpu(context_tracking.active, cpu)) {
 		per_cpu(context_tracking.active, cpu) = true;
 		static_branch_inc(&context_tracking_key);
 	}
+}
 
-	if (initialized)
+void ct_cpu_untrack_user(int cpu)
+{
+	if (!per_cpu(context_tracking.active, cpu))
 		return;
 
-#ifdef CONFIG_HAVE_TIF_NOHZ
-	/*
-	 * Set TIF_NOHZ to init/0 and let it propagate to all tasks through fork
-	 * This assumes that init is the only task at this early boot stage.
-	 */
-	set_tsk_thread_flag(&init_task, TIF_NOHZ);
-#endif
-	WARN_ON_ONCE(!tasklist_empty());
-
-	initialized = true;
+	per_cpu(context_tracking.active, cpu) = false;
+	static_branch_dec(&context_tracking_key);
 }
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER_FORCE
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cbbb87a0c6e7c..a7fe097042f7d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -26,6 +26,7 @@
 #include <linux/irq_work.h>
 #include <linux/posix-timers.h>
 #include <linux/context_tracking.h>
+#include <linux/sched/isolation.h>
 #include <linux/mm.h>
 
 #include <asm/irq_regs.h>
@@ -653,11 +654,6 @@ void __init tick_nohz_init(void)
 	if (!tick_nohz_full_running)
 		return;
 
-	/*
-	 * Full dynticks uses IRQ work to drive the tick rescheduling on safe
-	 * locking contexts. But then we need IRQ work to raise its own
-	 * interrupts to avoid circular dependency on the tick.
-	 */
 	if (!arch_irq_work_has_interrupt()) {
 		pr_warn("NO_HZ: Can't run full dynticks because arch doesn't support IRQ work self-IPIs\n");
 		cpumask_clear(tick_nohz_full_mask);
@@ -676,6 +672,16 @@ void __init tick_nohz_init(void)
 		}
 	}
 
+	/*
+	 * Pre-initialize context tracking for all possible CPUs so
+	 * ctx tracking is already active when a CPU is later added to
+	 * nohz_full at runtime.  The tracking overhead is negligible
+	 * because the static key is not incremented yet — only per-CPU
+	 * tracking state is set up.
+	 */
+	if (IS_ENABLED(CONFIG_CONTEXT_TRACKING_USER_FORCE))
+		context_tracking_init();
+
 	for_each_cpu(cpu, tick_nohz_full_mask)
 		ct_cpu_track_user(cpu);
 
@@ -686,6 +692,147 @@ void __init tick_nohz_init(void)
 	pr_info("NO_HZ: Full dynticks CPUs: %*pbl.\n",
 		cpumask_pr_args(tick_nohz_full_mask));
 }
+
+static int tick_nohz_hk_validate(enum hk_type type,
+				 const struct cpumask *cur_mask,
+				 const struct cpumask *new_mask)
+{
+	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static void tick_nohz_hk_apply(enum hk_type type)
+{
+	static DEFINE_SPINLOCK(tick_nohz_lock);
+	cpumask_var_t nohz_full, added, removed;
+	bool was_running;
+	int cpu;
+
+	if (!alloc_cpumask_var(&nohz_full, GFP_KERNEL))
+		return;
+	if (!alloc_cpumask_var(&added, GFP_KERNEL)) {
+		free_cpumask_var(nohz_full);
+		return;
+	}
+	if (!alloc_cpumask_var(&removed, GFP_KERNEL)) {
+		free_cpumask_var(added);
+		free_cpumask_var(nohz_full);
+		return;
+	}
+
+	/*
+	 * Snapshot the new HK_TYPE_KERNEL_NOISE mask under an RCU read lock.
+	 * housekeeping_update_types() completes synchronize_rcu() before
+	 * invoking apply(), so the new pointer is stable; however the lockdep
+	 * annotation in housekeeping_cpumask() still requires an RCU read-side
+	 * critical section for runtime-mutable types.
+	 */
+	rcu_read_lock();
+	cpumask_andnot(nohz_full, cpu_possible_mask,
+		       housekeeping_cpumask_rcu(HK_TYPE_KERNEL_NOISE));
+	rcu_read_unlock();
+
+	/*
+	 * When "nohz_full=" was not passed at boot, tick_nohz_full_running is
+	 * false and the full dynticks infrastructure (sched_tick_offload_init,
+	 * RCU nohz quiescent-state reporting, context-tracking bootstrap) was
+	 * never initialised.  In that case restrict the update to
+	 * tick_nohz_full_mask so the /sys/devices/system/cpu/nohz_full sysfs
+	 * attribute reflects DHM-isolated CPUs without enabling tick
+	 * suppression, context tracking, or timer migration – all of which
+	 * require boot-time setup and would deadlock on the first
+	 * synchronize_rcu() call after CPUs are offlined.
+	 */
+	was_running = READ_ONCE(tick_nohz_full_running);
+
+	spin_lock(&tick_nohz_lock);
+
+	/*
+	 * When nohz_full= was active at boot, compute the delta and update
+	 * context tracking for CPUs joining or leaving the nohz_full set.
+	 * Skip when !was_running: ct_cpu_track_user() calls
+	 * static_branch_inc() which may sleep (jump_label_update on the
+	 * 0→1 transition) – illegal inside a spinlock.
+	 */
+	if (IS_ENABLED(CONFIG_CONTEXT_TRACKING_USER) &&
+	    was_running &&
+	    cpumask_available(tick_nohz_full_mask)) {
+		cpumask_andnot(added, nohz_full, tick_nohz_full_mask);
+		cpumask_andnot(removed, tick_nohz_full_mask, nohz_full);
+		for_each_cpu(cpu, added)
+			ct_cpu_track_user(cpu);
+		for_each_cpu(cpu, removed)
+			ct_cpu_untrack_user(cpu);
+	}
+
+	/*
+	 * Update tick_nohz_full_mask unconditionally: this is the snapshot
+	 * read by the /sys/devices/system/cpu/nohz_full sysfs attribute and
+	 * must reflect the current isolation set even in the DHM runtime case.
+	 */
+	if (cpumask_available(tick_nohz_full_mask))
+		cpumask_copy(tick_nohz_full_mask, nohz_full);
+
+	/*
+	 * Only modify tick_nohz_full_running and migrate the global tick when
+	 * nohz_full= was set at boot; without boot-time setup, setting
+	 * tick_nohz_full_running would suppress ticks on isolated CPUs and
+	 * prevent RCU quiescent-state reporting, causing synchronize_rcu()
+	 * to stall permanently when a CPU is subsequently offlined.
+	 */
+	if (was_running) {
+		tick_nohz_full_running = !cpumask_empty(nohz_full);
+
+		if (tick_nohz_full_running) {
+			cpu = READ_ONCE(tick_do_timer_cpu);
+			if (cpu < nr_cpu_ids &&
+			    !housekeeping_test_cpu(cpu, HK_TYPE_KERNEL_NOISE)) {
+				int new_cpu;
+
+				new_cpu = housekeeping_any_cpu(HK_TYPE_KERNEL_NOISE);
+				if (new_cpu < nr_cpu_ids)
+					WRITE_ONCE(tick_do_timer_cpu, new_cpu);
+			}
+		}
+	}
+
+	spin_unlock(&tick_nohz_lock);
+
+	if (was_running)
+		tick_nohz_full_kick_all();
+	free_cpumask_var(removed);
+	free_cpumask_var(added);
+	free_cpumask_var(nohz_full);
+}
+
+static struct housekeeping_cbs tick_nohz_hk_cbs = {
+	.name		= "tick/nohz",
+	.pre_validate	= tick_nohz_hk_validate,
+	.apply		= tick_nohz_hk_apply,
+};
+
+static int __init tick_nohz_hk_init_late(void)
+{
+	int ret;
+
+	/*
+	 * Ensure tick_nohz_full_mask is allocated so that tick_nohz_hk_apply()
+	 * can update it (and the /sys/devices/system/cpu/nohz_full sysfs
+	 * attribute) when CPUs are isolated at runtime via DHM.  If "nohz_full="
+	 * was passed at boot the mask is already allocated; allocate an empty
+	 * one here for the runtime-only case.
+	 */
+	if (!cpumask_available(tick_nohz_full_mask) &&
+	    !zalloc_cpumask_var(&tick_nohz_full_mask, GFP_KERNEL))
+		pr_warn("tick/nohz: failed to allocate nohz_full_mask for DHM\n");
+
+	ret = housekeeping_register_cbs(HK_TYPE_KERNEL_NOISE, &tick_nohz_hk_cbs);
+	if (ret)
+		pr_warn("tick/nohz: Failed to register hk callback: %d\n", ret);
+	return 0;
+}
+late_initcall(tick_nohz_hk_init_late);
 #endif /* #ifdef CONFIG_NO_HZ_FULL */
 
 /*

-- 
2.43.0

