Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CC14A43EB
	for <rcu@vger.kernel.org>; Fri,  2 Oct 2026 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946680; cv=none; b=TCUtCS7ft5y94/S+FlIal1Nmd6TtJ1Ttb2b+NNXBXoiEBSXNGF+vGFqtFL2r0G5gvAtoSYbjBM7PZo22kpuK8FS8ThLP+qy/z+y1heHFjL5ZO3ZJD9UgIXTlRXLbncrHOx8mH+Pp+RjfRW48WI3MytNYzJo6K5CIgeTh9Frd9KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946680; c=relaxed/simple;
	bh=7QvZkqasdhulNkXszpS0tpwM49MyqDv5UCggA3JJ858=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V7N/P6w+aq7AKzznuuBpLw5F4bDF61/PLN6k9sZKdKEPfXSKRgBWtjAuYh+JQ/xncrridQ3otSHgC9RfSyzixgZIV0YLqMEpXs2WJ9Osil3MvU8vj+eFTuqwC3bkEMu9ikde9UtWyJdru4xAcB63IDd3A+TCDXMRqIwcVt8JTMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL0zlLUN; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL0zlLUN"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3428f70d7e7so4359942eec.3
        for <rcu@vger.kernel.org>; Fri, 02 Oct 2026 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790946674; x=1791551474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CATXTkxYpbqMwc3sPzpFt8avLOKzYpBFTwjOumo8LEw=;
        b=XL0zlLUNh1wlkAQx5EZHdQ/rQtnAoJqbS0b/5oVW87zjKl06Ek9WObHTegyHAS6yWK
         xcFrG8kMYu6lyQw4/bPaU15S/H3dle7/yNW4EXOaq0eZwsVyp4N8yOtDMvKtL5HK+aeV
         CUGuK33vKNvG6KOy0Fs+N+dMysbL+YHm4Mrdv/USXN45HtG39x4trskqLxjf4OhlAE0f
         nRfvNrivRm4ULNZLsak1eizh7A98iHZ7VABcpOCK1Z1eznhZAZAVNrXkmcfx36IpChu4
         JR+C9l1rpsrbNbZstogxFICvl73zOaIC0ml7sk6daABV3r7QJako66xoCmY3vIj7zqaO
         umSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790946674; x=1791551474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CATXTkxYpbqMwc3sPzpFt8avLOKzYpBFTwjOumo8LEw=;
        b=BTj93mwD1ImB3V6d+2fR0mqe7ske8ZsTGXEb+5PclC+VAW9L1iAJFyqOpDJmFZv8CJ
         P9G4GM1HP6E2K/hNJyuVm9lxiGthLk23BciH5SkRpNdTls0C+JGZu09keAt9t6yO6x8+
         70oISMzUsiZxKs4N2z3nlkCH/ngi+pq6OIaoIF1HwIkXVMIwmJwuTHiABrwNL02iDCVa
         KxUycRnuGiSVwno4MSfNBF6cymuTqu0Ad8sEM3JdFoNvD1tiABHANf+GHsJ5kJe7qr9D
         /UdOncN9qvT8HRn2eN1NtWWvYBrqfY5tv94aRJsSYuIcOqx3tUis7YHbIVnPi8zpQn6v
         NqrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmszaTSwrDDBYeR869KTLYxT5HAZ6ntptCDt9zBFs1igo5difv4wYriUSxS1KRgm40njM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIC9BRedQ+7J07P6mopbNhBVM+JYUEx8FWm4Z4lU8gTDVc5e28l
	PQrbmWOA51pPLlvyuWZw+FRIiAGomQ2rKWpgCGnbLnxWKABXO0OAvRc1
X-Gm-Gg: AYBFou2hpwoRPbA53j+oBcD2xQoS4SmYB3nIbWjOOm8fBW7tz1XnjeeeS0tsWkn9AU7
	df8ttQfxj+VHNXsXkkMFYxDS3wobbWRNv2yMgmV5/Aqb05LxxqasS8nfCpvE3HXL9lBRvDaOOR9
	E+t20jpQvo2RWwzValMBl1hVMTIvczj7FwUp5L1tLN/nqU/os3d7JzR7JTkjUV/mE6AFpn/JlUY
	Bk5QZpsx9Hck9FFUW8g8zgYFxech4hDum/auqS9B3VNMmFFeoHbWZ7Jtvg9LoNaQx0rIKbbAtWY
	clulkREkKBIYUOCZgNQvlFyH5k2+P9wxUdFj2ohejJoqaJCE7BhpykNkwYNpgXAn8fdo2Iyrv6Z
	GXxg3UWSLLW0PvBPpKncWRpwQqynkRCBwivea3ofOb6sWvbfjBXfqpGO5U6MHIDuMp2KsnUcWCc
	1HGf30t2gnZDE7cpCNGxP7SDjbVonNBrbTAHm03pIrxISyR7dcY6T1knsJVDWmvsY2qdhfA8+nl
	+br
X-Received: by 2002:a05:7300:50d1:b0:34e:f7cb:605e with SMTP id 5a478bee46e88-34f2199955emr3532775eec.35.1790946673805;
        Fri, 02 Oct 2026 06:11:13 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c739sm7309347eec.3.2026.10.02.06.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:11:11 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 02 Oct 2026 21:10:25 +0800
Subject: [PATCH v5 05/12] context_tracking: Allow runtime per-CPU user
 tracking enable/disable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-wujing-dhm-v5-5-78a6996d87ad@gmail.com>
References: <20261002-wujing-dhm-v5-0-78a6996d87ad@gmail.com>
In-Reply-To: <20261002-wujing-dhm-v5-0-78a6996d87ad@gmail.com>
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
Cc: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

ct_cpu_track_user() and the context_tracking_key static key are currently
restricted to boot-time use: the key is __ro_after_init and the function
is __init with __initdata state.  This prevents enabling nohz_full context
tracking for CPUs isolated at runtime via cpuset partitions.

Split ct_cpu_track_user() into three functions:

  ct_cpu_track_user(cpu)      - sets per_cpu(context_tracking.active) and
                                increments context_tracking_key; callable
                                at runtime with the CPU offline.

  ct_cpu_untrack_user(cpu)    - reverses the above; for de-isolation.

  ct_cpu_track_user_init(cpu) - __init wrapper; calls ct_cpu_track_user()
                                and handles TIF_NOHZ / tasklist setup.

Change context_tracking_key from DEFINE_STATIC_KEY_FALSE_RO to
DEFINE_STATIC_KEY_FALSE so that static_branch_inc/dec() can be called
after the __ro_after_init window closes.

Update tick_nohz_init() to call ct_cpu_track_user_init() so boot
behaviour is unchanged.

This is a prerequisite for DHM (Dynamic Housekeeping Management) runtime
CPU noise isolation without boot parameters.

context_tracking_key is a single systemwide static branch, not a
per-CPU gate: once live, __ct_user_enter()/__ct_user_exit() run
unconditionally on every CPU, regardless of that CPU's own
context_tracking.active.  Going live happens through code patching,
and other CPUs only observe the patched code some time after
static_branch_inc() returns.  A CPU whose kernel<->user transition
lands in that window sees context_tracking_enabled() as still false
and silently skips recording it, leaving context_tracking.state
stuck, so the next traced kernel entry on that CPU wrongly trips
CT_WARN_ON(__ct_state() != CT_STATE_USER).  Reordering the enable and
a fixup sweep around each other cannot close this: whichever runs
last still has its own propagation delay to every other CPU.

Add context_tracking_activating, a plain per-CPU bool with no
code-patching delay of its own, and
context_tracking_enabled_or_activating() to test it alongside the
static key.  ct_cpu_track_user() sets it on every CPU via IPI
strictly before static_branch_inc(), and clears it via another IPI
only after static_branch_inc() returns, so every relevant call site
sees it in place for the whole window during which the static key
might not have propagated yet.  Route user_enter_irqoff(),
user_exit_irqoff(), the guest variants, CT_WARN_ON() and ct_state()
through it instead of the raw static key.  Also directly bootstrap
CT_STATE_USER for a CPU caught sitting in user mode by its
interrupted pt_regs, rather than leaving it to self-correct on its
own next transition.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 include/linux/context_tracking.h       | 16 +++---
 include/linux/context_tracking_state.h | 25 +++++++++-
 kernel/context_tracking.c              | 91 ++++++++++++++++++++++++++++++++--
 kernel/time/tick-sched.c               |  2 +-
 4 files changed, 122 insertions(+), 12 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index af9fe87a09225..a83a2f1f9f9a9 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -12,6 +12,8 @@
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 extern void ct_cpu_track_user(int cpu);
+extern void ct_cpu_untrack_user(int cpu);
+extern void __init ct_cpu_track_user_init(int cpu);
 
 /* Called with interrupts disabled.  */
 extern void __ct_user_enter(enum ctx_state state);
@@ -25,26 +27,26 @@ extern void user_exit_callable(void);
 
 static inline void user_enter(void)
 {
-	if (context_tracking_enabled())
+	if (context_tracking_enabled_or_activating())
 		ct_user_enter(CT_STATE_USER);
 
 }
 static inline void user_exit(void)
 {
-	if (context_tracking_enabled())
+	if (context_tracking_enabled_or_activating())
 		ct_user_exit(CT_STATE_USER);
 }
 
 /* Called with interrupts disabled.  */
 static __always_inline void user_enter_irqoff(void)
 {
-	if (context_tracking_enabled())
+	if (context_tracking_enabled_or_activating())
 		__ct_user_enter(CT_STATE_USER);
 
 }
 static __always_inline void user_exit_irqoff(void)
 {
-	if (context_tracking_enabled())
+	if (context_tracking_enabled_or_activating())
 		__ct_user_exit(CT_STATE_USER);
 }
 
@@ -74,7 +76,7 @@ static inline void exception_exit(enum ctx_state prev_ctx)
 
 static __always_inline bool context_tracking_guest_enter(void)
 {
-	if (context_tracking_enabled())
+	if (context_tracking_enabled_or_activating())
 		__ct_user_enter(CT_STATE_GUEST);
 
 	return context_tracking_enabled_this_cpu();
@@ -82,13 +84,13 @@ static __always_inline bool context_tracking_guest_enter(void)
 
 static __always_inline bool context_tracking_guest_exit(void)
 {
-	if (context_tracking_enabled())
+	if (context_tracking_enabled_or_activating())
 		__ct_user_exit(CT_STATE_GUEST);
 
 	return context_tracking_enabled_this_cpu();
 }
 
-#define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
+#define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled_or_activating() && (cond))
 
 #else
 static inline void user_enter(void) { }
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 0b81248aa03e2..25f87a9763313 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -138,6 +138,28 @@ static __always_inline bool context_tracking_enabled(void)
 	return static_branch_unlikely(&context_tracking_key);
 }
 
+/*
+ * context_tracking_key goes live via code patching, which other CPUs only
+ * observe some time after ct_cpu_track_user() calls static_branch_inc().
+ * A CPU whose kernel<->user transition lands in that window would see
+ * context_tracking_enabled() as still false and silently skip recording
+ * it, leaving context_tracking.state stale.  ct_cpu_track_user() sets
+ * context_tracking_activating on every CPU with an IPI strictly before
+ * calling static_branch_inc(), and clears it again with another IPI only
+ * after static_branch_inc() returns (so only once every CPU is
+ * guaranteed to already observe the branch as enabled).  Checking it
+ * here closes that window: every transition in between is recorded via
+ * the normal __ct_user_enter()/__ct_user_exit() path instead of being
+ * silently dropped.
+ */
+DECLARE_PER_CPU(bool, context_tracking_activating);
+
+static __always_inline bool context_tracking_enabled_or_activating(void)
+{
+	return context_tracking_enabled() ||
+	       unlikely(__this_cpu_read(context_tracking_activating));
+}
+
 static __always_inline bool context_tracking_enabled_cpu(int cpu)
 {
 	return context_tracking_enabled() && per_cpu(context_tracking.active, cpu);
@@ -159,7 +181,7 @@ static __always_inline int ct_state(void)
 {
 	int ret;
 
-	if (!context_tracking_enabled())
+	if (!context_tracking_enabled_or_activating())
 		return CT_STATE_DISABLED;
 
 	preempt_disable();
@@ -171,6 +193,7 @@ static __always_inline int ct_state(void)
 
 #else
 static __always_inline bool context_tracking_enabled(void) { return false; }
+static __always_inline bool context_tracking_enabled_or_activating(void) { return false; }
 static __always_inline bool context_tracking_enabled_cpu(int cpu) { return false; }
 static __always_inline bool context_tracking_enabled_this_cpu(void) { return false; }
 #endif /* CONFIG_CONTEXT_TRACKING_USER */
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index a743e7ffa6c00..326862a2679e3 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -23,6 +23,9 @@
 #include <linux/hardirq.h>
 #include <linux/export.h>
 #include <linux/kprobes.h>
+#include <linux/smp.h>
+#include <linux/ptrace.h>
+#include <asm/irq_regs.h>
 #include <trace/events/rcu.h>
 
 
@@ -411,9 +414,12 @@ static __always_inline void ct_kernel_enter(bool user, int offset) { }
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
-DEFINE_STATIC_KEY_FALSE_RO(context_tracking_key);
+DEFINE_STATIC_KEY_FALSE(context_tracking_key);
 EXPORT_SYMBOL_GPL(context_tracking_key);
 
+DEFINE_PER_CPU(bool, context_tracking_activating);
+EXPORT_SYMBOL_GPL(context_tracking_activating);
+
 static noinstr bool context_tracking_recursion_enter(void)
 {
 	int recursion;
@@ -674,14 +680,93 @@ void user_exit_callable(void)
 }
 NOKPROBE_SYMBOL(user_exit_callable);
 
-void __init ct_cpu_track_user(int cpu)
+/*
+ * context_tracking_key is a single systemwide static branch, not a per-CPU
+ * gate: once live, __ct_user_enter()/__ct_user_exit() run unconditionally
+ * on every CPU (so that a task migrating between a tracked and an
+ * untracked CPU always sees consistent state), regardless of that CPU's
+ * own context_tracking.active.  Going live happens through code patching,
+ * though, and other CPUs only observe the patched code some time after
+ * static_branch_inc() is called on this one.  A CPU whose kernel<->user
+ * transition lands in that window would see context_tracking_enabled()
+ * as still false and silently skip recording it, leaving
+ * context_tracking.state stuck at whatever it was, so the first traced
+ * kernel entry on that CPU afterwards would wrongly trip
+ * CT_WARN_ON(__ct_state() != CT_STATE_USER).  Reordering the two calls
+ * below cannot close this: whichever runs last still has its own
+ * propagation delay to every other CPU.
+ *
+ * context_tracking_enabled_or_activating() closes the window instead:
+ * every user_enter_irqoff()/user_exit_irqoff()/CT_WARN_ON() site treats
+ * a CPU as tracking once context_tracking_activating is set on it, with
+ * no code-patching delay of its own, since it is a plain per-CPU bool
+ * set directly by the interrupting IPI handler rather than inferred
+ * from a jump label.  Set it on every CPU before static_branch_inc(),
+ * and only clear it once static_branch_inc() has returned, so there is
+ * no gap during which a CPU observes neither signal: every transition
+ * in between is recorded through the normal path instead of being
+ * silently dropped.  Also directly bootstrap CT_STATE_USER for a CPU
+ * caught sitting in user mode (via its interrupted pt_regs), rather
+ * than leaving it to self-correct on its own next transition.
+ */
+static void ct_activate_set_pending_ipi(void *unused)
 {
-	static __initdata bool initialized = false;
+	struct pt_regs *regs = get_irq_regs();
 
+	__this_cpu_write(context_tracking_activating, true);
+	if (regs && user_mode(regs))
+		__ct_user_enter(CT_STATE_USER);
+}
+
+static void ct_activate_clear_pending_ipi(void *unused)
+{
+	__this_cpu_write(context_tracking_activating, false);
+}
+
+/**
+ * ct_cpu_track_user - enable context tracking for a CPU
+ * @cpu: target CPU (must be offline when called at runtime)
+ *
+ * Marks @cpu as actively tracking user/kernel transitions and increments
+ * the context_tracking_key refcount.  Safe to call at runtime provided
+ * the CPU is offline so no context-tracking readers are active on it.
+ */
+void ct_cpu_track_user(int cpu)
+{
 	if (!per_cpu(context_tracking.active, cpu)) {
+		bool first_activation = !context_tracking_enabled();
+
 		per_cpu(context_tracking.active, cpu) = true;
+		if (first_activation)
+			on_each_cpu(ct_activate_set_pending_ipi, NULL, 1);
 		static_branch_inc(&context_tracking_key);
+		if (first_activation)
+			on_each_cpu(ct_activate_clear_pending_ipi, NULL, 1);
 	}
+}
+EXPORT_SYMBOL_GPL(ct_cpu_track_user);
+
+/**
+ * ct_cpu_untrack_user - disable context tracking for a CPU
+ * @cpu: target CPU (must be offline when called)
+ *
+ * Reverses ct_cpu_track_user().  The CPU must be offline so that no
+ * context-tracking readers are active on it.
+ */
+void ct_cpu_untrack_user(int cpu)
+{
+	if (per_cpu(context_tracking.active, cpu)) {
+		per_cpu(context_tracking.active, cpu) = false;
+		static_branch_dec(&context_tracking_key);
+	}
+}
+EXPORT_SYMBOL_GPL(ct_cpu_untrack_user);
+
+void __init ct_cpu_track_user_init(int cpu)
+{
+	static __initdata bool initialized = false;
+
+	ct_cpu_track_user(cpu);
 
 	if (initialized)
 		return;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6c3fea3867139..8c53754c4ac4a 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -675,7 +675,7 @@ void __init tick_nohz_init(void)
 	}
 
 	for_each_cpu(cpu, tick_nohz_full_mask)
-		ct_cpu_track_user(cpu);
+		ct_cpu_track_user_init(cpu);
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
 					"kernel/nohz:predown", NULL,

-- 
2.43.0

