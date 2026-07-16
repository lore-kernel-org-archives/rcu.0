Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DA283FDC;
	Thu, 16 Jul 2026 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161526; cv=none; b=jYYLbDboCtEipqstdLZvVIvpFA89Zxxw8fmgOAt2aU+Jt3nl2ehU3U0xNKDRUIKjtYOZ5Jg0KSfIZUU2dGjdePc0PrC3ToSbwHUWGPG+Bmw5zUD/J1m8D+nRJqQLrVZZvOVfNViwlzWXF8fUXjZPS67aOdlpmcS3GdnIMeJQJWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161526; c=relaxed/simple;
	bh=Fp1S4CRvW8WyKvOKMb6g8l3GzM4Ar49CmxkWRADPVLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zt2eb2A5HtDIBnTxuwljVCzPUNg9VQrLu/5q+WKS/RZ4WqcefL6TbfidA8BH30eHoelcB+kTvIpLA3LnecBMEjPEGutL3SzjelNxvlfhB9gOVGkSDCI1R7bzXodlgiqR9Q76a0ZzDsbLNhr7pmTIQOOSuk10H576Vlz7uL0R3lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRhYE/kP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRhYE/kP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6931F00A3F;
	Thu, 16 Jul 2026 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161522;
	bh=y9F4AsnS2gHcnajM+AAYGEb3rcNhUl/Z3dMPF7FxKYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GRhYE/kPr7vDbfdmMQvKQYjeAdFRtR0JgC4wcqYbiX/CdmUnDvhBSo7qKPisZTa8L
	 nwezdSJy/jqzrKyUdJGzYeiy8fc7tDyeqe24DWk2wJePoLky4P2GnainQ1hH7XN3Le
	 iw6BsBTrMI2onLeyGRCMHmGLyGR0ZHarGydFKVrErjfE5ZBTtHak1PvPzPYlUX1/Xf
	 04LeIOOQsg7toX+LMCtnBGIN7MHIQ231ZVRU/RAH+Mn7+V2PI8MfWYH8eGIj+Ia971
	 s5TcwYq8hsjSnHq8c5It5zz115TdvwywJQ1vwSO5EK7UMSM7cAObb+Vg/EGDsmmT1F
	 jPrucxnd1c0Pg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 775A3CE0C44; Wed, 15 Jul 2026 17:25:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 04/11] rcutorture: Test RCU readers from hardware interrupt handlers
Date: Wed, 15 Jul 2026 17:25:13 -0700
Message-Id: <20260716002520.11895-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>
References: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although rcutorture has long had the irqreader module parameter, this
parameter results only in RCU readers in softirq handlers, specifically,
timers.  This commit therefore uses smp_call_function_single() to test
RCU readers in real hardware interrupt handlers, thus providing the full
effect from the irqreader module parameter.

However, consistency/debug checks must account for the possibility that
the smp_call_function_single() handler function is directly invoked
from the idle loop, in which case, for example, in_hardirq() will
return false.  This commit uses a per-CPU variable to record being in
the rcu_torture_irq() smp_call_function_single() handler function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 77 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0e0ad4cccc3644..2f510743722fce 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -213,6 +213,7 @@ static long n_rcu_torture_boost_ktrerror;
 static long n_rcu_torture_boost_failure;
 static long n_rcu_torture_boosts;
 static atomic_long_t n_rcu_torture_timers;
+static atomic_long_t n_rcu_torture_irqs;
 static long n_barrier_attempts;
 static long n_barrier_successes; /* did rcu_barrier test succeed? */
 static unsigned long n_read_exits;
@@ -2127,6 +2128,8 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
 	smp_store_release(&rtrcp_assigner->rtc_chkrdr, -1); // Assigner can again assign.
 }
 
+static DEFINE_PER_CPU(bool, torture_in_scf_handler);
+
 // Verify the specified RCUTORTURE_RDR* state.
 #define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
 static void rcutorture_one_extend_check(char *s, int curstate, int new, int old)
@@ -2136,7 +2139,7 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old)
 	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE) || in_nmi())
 		return;
 
-	WARN_ONCE(!(curstate & RCUTORTURE_RDR_IRQ) && irqs_disabled() && !in_hardirq(), ROEC_ARGS);
+	WARN_ONCE(!(curstate & RCUTORTURE_RDR_IRQ) && irqs_disabled() && !in_hardirq() && !this_cpu_read(torture_in_scf_handler), ROEC_ARGS);
 	WARN_ONCE((curstate & RCUTORTURE_RDR_IRQ) && !irqs_disabled(), ROEC_ARGS);
 
 	// If CONFIG_PREEMPT_COUNT=n, further checks are unreliable.
@@ -2153,7 +2156,7 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old)
 
 	// Interrupt handlers have all sorts of stuff disabled, so ignore
 	// unintended disabling.
-	if (in_serving_softirq() || in_hardirq())
+	if (in_serving_softirq() || in_hardirq() || this_cpu_read(torture_in_scf_handler))
 		return;
 
 	WARN_ONCE(cur_ops->extendables &&
@@ -2345,12 +2348,19 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 			mask |= RCUTORTURE_RDR_RCU_1;
 	}
 
+	/*
+	 * Don't mess with interrupt masking in interrupt handlers.
+	 */
+	if (in_hardirq() || this_cpu_read(torture_in_scf_handler))
+		mask &= ~(preempts_irq | bhs);
+
 	/*
 	 * Can't enable bh w/irq disabled.
 	 */
 	if (mask & RCUTORTURE_RDR_IRQ)
 		mask |= oldmask & bhs;
 
+
 	/*
 	 * Ideally these sequences would be detected in debug builds
 	 * (regardless of RT), but until then don't stop testing
@@ -2605,6 +2615,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 		return false;
 	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, trsp, rtors.rtrsp);
 	rcu_torture_one_read_end(&rtors, trsp);
+
 	// This splat will happen on systems built with CONFIG_IRQ_WORK=n
 	// and on systems where arch_irq_work_has_interrupt() returns false.
 	// It might also happen on systems using a short-duration clock
@@ -2643,7 +2654,7 @@ static void rcu_torture_timer(struct timer_list *unused)
 	atomic_long_inc(&n_rcu_torture_timers);
 	(void)rcu_torture_one_read(this_cpu_ptr(&rcu_torture_timer_rand), -1);
 
-	/* Test call_rcu() invocation from interrupt handler. */
+	/* Test call_rcu() invocation from softirq handler. */
 	if (cur_ops->call) {
 		struct rcu_head *rhp = kmalloc_obj(*rhp, GFP_NOWAIT);
 
@@ -2652,6 +2663,41 @@ static void rcu_torture_timer(struct timer_list *unused)
 	}
 }
 
+static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_irq_rand);
+
+/*
+ * RCU torture reader from timer handler.  Dereferences rcu_torture_current,
+ * incrementing the corresponding element of the pipeline array.  The
+ * counter in the element should never be greater than 1, otherwise, the
+ * RCU implementation is broken.
+ *
+ * Note that on some systems, "interrupts" from idle are direct calls
+ * rather than interrupts.  The torture_in_scf_handler per-CPU variable
+ * accounts for this case.
+ */
+static void rcu_torture_irq(void *unused)
+{
+	WARN_ON_ONCE(in_nmi());
+	lockdep_assert_irqs_disabled();
+	atomic_long_inc(&n_rcu_torture_irqs);
+	this_cpu_write(torture_in_scf_handler, true);
+	(void)rcu_torture_one_read(this_cpu_ptr(&rcu_torture_irq_rand), -1);
+	this_cpu_write(torture_in_scf_handler, false);
+
+	// Test call_rcu() invocation from interrupt handler.  Interrupts
+	// will always be disabled here, even in CONFIG_PREEMPT_RT=y kernels.
+	// The "right" thing to do would be to create a special-purpose
+	// lockless or raw-spinlock-protected allocator, but in the meantime,
+	// skip testing call_rcu() from interrupt handlers in kernels built
+	// with either CONFIG_PREEMPT_RT=y or CONFIG_PROVE_LOCKING=y.
+	if (cur_ops->call && !IS_ENABLED(CONFIG_PROVE_LOCKING) && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		struct rcu_head *rhp = kmalloc_obj(*rhp, GFP_NOWAIT);
+
+		if (rhp)
+			cur_ops->call(rhp, rcu_torture_timer_cb);
+	}
+}
+
 /*
  * RCU torture reader kthread.  Repeatedly dereferences rcu_torture_current,
  * incrementing the corresponding element of the pipeline array.  The
@@ -2661,6 +2707,7 @@ static void rcu_torture_timer(struct timer_list *unused)
 static int
 rcu_torture_reader(void *arg)
 {
+	unsigned long lastscf = jiffies;
 	unsigned long lastsleep = jiffies;
 	long myid = (long)arg;
 	int mynumonline = myid;
@@ -2674,8 +2721,25 @@ rcu_torture_reader(void *arg)
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);  // CPU bound, so need tick.
 	do {
 		if (irqreader && cur_ops->irq_capable) {
-			if (!timer_pending(&t))
+			if (!timer_pending(&t)) {
+				int cpu;
+
 				mod_timer(&t, jiffies + 1);
+				preempt_disable();
+				cpu = torture_random(&rand) % nr_cpu_ids;
+				if (!cpu_online(cpu)) {
+					cpu = cpumask_next(cpu, cpu_online_mask);
+					if (cpu >= nr_cpu_ids)
+						cpu = cpumask_next(-1, cpu_online_mask);
+				}
+				// An smp_call_function_single() to self is not an interrupt!
+				if (cpu != smp_processor_id() &&
+				    time_after(jiffies, lastscf + HZ * nrealreaders / 50)) {
+					smp_call_function_single(cpu, rcu_torture_irq, NULL, 0);
+					lastscf = jiffies;
+				}
+				preempt_enable();
+			}
 		}
 		if (!rcu_torture_one_read(&rand, myid) && !torture_must_stop())
 			schedule_timeout_interruptible(HZ);
@@ -2951,10 +3015,11 @@ rcu_torture_stats_print(void)
 		atomic_read(&n_rcu_torture_mbchk_fail), atomic_read(&n_rcu_torture_mbchk_tries),
 		n_rcu_torture_barrier_error,
 		n_rcu_torture_boost_ktrerror);
-	pr_cont("rtbf: %ld rtb: %ld nt: %ld ",
+	pr_cont("rtbf: %ld rtb: %ld nt: %ld ni: %ld ",
 		n_rcu_torture_boost_failure,
 		n_rcu_torture_boosts,
-		atomic_long_read(&n_rcu_torture_timers));
+		atomic_long_read(&n_rcu_torture_timers),
+		atomic_long_read(&n_rcu_torture_irqs));
 	if (updownreaders)
 		pr_cont("ndowns: %lu nups: %lu nhrt: %lu nmigrates: %lu ", ndowns, nups, nunexpired,  nmigrates);
 	torture_onoff_stats();
-- 
2.40.1

