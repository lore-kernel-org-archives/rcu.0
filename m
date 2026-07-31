Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36EA1A262A;
	Fri, 31 Jul 2026 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460043; cv=none; b=CAvSHjO2Wc6uXvgE0uFqnQXY7dTnV2anatvRaNbjpFhnfZTzZhw+1NU4KfTNWuPffzEMtFF44r8YtMRkLyyk96UNwA84MWxUHF2qUCCDb4H+cd+IWY/ZLLE/87Nw1NwuEO4keFzoJF2G7kdZ7/2mYOa/kXpPB9R116zcngZiVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460043; c=relaxed/simple;
	bh=43yXAu2aAtdmQqKptqhhtG5b8DZiNtXX+KH8fTgEibo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=teWbahaz8C/4ypjloTPheGmcuC6lSGzmeE6ylp8HtAIElkpgZzd4s2nBV/Mjx7j5uqDJDpDRWpBcwhco/TzQA9FZzR1TyiWaAnlSMSvapaevB8GURPl0P+lOmjZ/LrGLJevdUaGA3dg41VZ2zb6Nn2TAg0CJSCAfFmHXOIuRYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQE4Q4+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQE4Q4+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3DD1F00A3A;
	Fri, 31 Jul 2026 01:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460040;
	bh=G+V/idbqoCDMkEP7fe+sC8B1MjjWlvGR4WR9+6RPNPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PQE4Q4+L7ltbOIYzx3LzrSvBacAgQ0szQSKncExFmKZEf37GjwsUlYWu4ZuXttD3c
	 B5qGEIsMXUlvslcZIT7JtRjlf/AV65jblk6CjFyAALWwWLCNAqFgHm81WBYI9iyMIt
	 V2EQoitrxg2FyhFGE+2Mi/zOuUxYB4cWbQLQx8MqiCG9Rz9FGHyW2TVIygkUVTmFgk
	 we8UOR4pNfr91R0z56+9ZjueMHoWe0lNH3tyTQUl+x3VItyTjh/IB0HJRY7K46S0T7
	 wNH08FU6CZBx18RZCfxvb14/WmcxJVTE2bTu/riUToQr6v4X8elqJOXDdBEuXPAcFB
	 siz8QEDdUZw4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8476DCE0F6A; Thu, 30 Jul 2026 18:07:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 02/13] rcutorture: Check for immediate deboosting at reader end
Date: Thu, 30 Jul 2026 18:07:08 -0700
Message-Id: <20260731010719.3531912-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
References: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a check for failure to have fully deboosted a
multi-segmented RCU reader at the end of the full read-side critical
section.  This check only happens for fully task-level readers, because
a a handler might have interrupted an already-boosted task-level RCU
reader, and a reader in that handler could then cause false positives.
The first failed check (due to an RCU reader that was not immediately
deboosted) causes a splat, but only when the disabled-by-default
deboost_timeliness_check module parameter is enabled.  Regardless of the
value of this parameter, it produces a list of the segments making up that
RCU reader following a "Slow-deboost rcutorture reader segments" heading.
Subsequent failures fail silently, all in the name of keeping console
output down to a dull roar.

Although most uses of RCU priority boosting serve as debugging aids,
this might change, and in fact might already have changed.  And allowing
(for example) RCU priority boosting to persist until the next scheduler
tick could cause an aggressively real-time system to miss sub-millisecond
deadlines.  So we do need to find this sort of problem during testing,
and preferably not in the field.

The name and type of the newly added rcu_torture_ops function pointer
(named "->is_task_rcu_boosted()") may need to change should other
end-of-reader checks be needed.  But let's start simple.

Oh, and Claude figured out that rcu_is_task_rcu_boosted() could be
lockless.  Perhaps there is hope for AI yet!  ;-)

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h         |  7 +++++++
 kernel/rcu/rcutorture.c  | 24 ++++++++++++++++++++++++
 kernel/rcu/tree_plugin.h | 37 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index fa6d30ce73d1fd..14faa11ef23cd0 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -695,4 +695,11 @@ static inline int rcu_stall_notifier_call_chain(unsigned long val, void *v) { re
 void synchronize_rcu_trivial_preempt(void);
 #endif // #ifdef CONFIG_TRIVIAL_PREEMPT_RCU
 
+#if defined(CONFIG_RCU_TORTURE_TEST) && defined(CONFIG_RCU_BOOST)
+bool rcu_is_task_rcu_boosted(void);
+#else // #if defined(CONFIG_RCU_TORTURE_TEST) && defined(CONFIG_RCU_BOOST)
+static inline bool rcu_is_task_rcu_boosted(void) { return false; }
+#endif // #else // #if defined(CONFIG_RCU_TORTURE_TEST) && defined(CONFIG_RCU_BOOST)
+
+
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ffeca1b7e17016..1a033ae1f1eb6a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -80,6 +80,7 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@
 					/* Must be power of two minus one. */
 #define RCUTORTURE_RDR_MAX_SEGS (RCUTORTURE_RDR_MAX_LOOPS + 3)
 
+torture_param(bool, deboost_timeliness_check, 0, "Enable checks for immediate deboosting");
 torture_param(int, extendables, RCUTORTURE_MAX_EXTEND,
 	      "Extend readers by disabling bh (1), irqs (2), or preempt (4)");
 torture_param(int, fqs_duration, 0, "Duration of fqs bursts (us), 0 to disable");
@@ -426,6 +427,7 @@ struct rcu_torture_ops {
 	void (*format_gp_seqs)(unsigned long long seqs, char *cp, size_t len);
 	void (*set_gpwrap_lag)(unsigned long lag);
 	int (*get_gpwrap_count)(int cpu);
+	bool (*is_task_rcu_boosted)(void);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -635,6 +637,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.format_gp_seqs		= rcutorture_format_gp_seqs,
 	.set_gpwrap_lag		= rcu_set_gpwrap_lag,
 	.get_gpwrap_count	= rcu_get_gpwrap_count,
+	.is_task_rcu_boosted	= rcu_is_task_rcu_boosted,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -2588,7 +2591,9 @@ static void rcu_torture_one_read_end(struct rcu_torture_one_read_state *rtorsp,
  */
 static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 {
+	static int firsttime = 1;
 	int newstate;
+	unsigned int nsegs;
 	struct rcu_torture_one_read_state rtors;
 
 	WARN_ON_ONCE(!rcu_is_watching());
@@ -2600,6 +2605,25 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 		return false;
 	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, trsp, rtors.rtrsp);
 	rcu_torture_one_read_end(&rtors, trsp);
+	// This splat will happen on systems built with CONFIG_IRQ_WORK=n
+	// and on systems where arch_irq_work_has_interrupt() returns false.
+	// It might also happen on systems using a short-duration clock
+	// interrupt instead of a self-IPI (powerpc, s390) or that use
+	// neither a self-IPI nor a short-duration clock interrupts
+	// (all architectures using the generic implementation
+	// of arch_irq_work_raise()).  On such systems, RCU cannot
+	// guarantee to immediately deboost RCU readers when the outermost
+	// rcu_read_unlock() does not end the full segmented RCU read-side
+	// critical section.
+	if (cur_ops->is_task_rcu_boosted && cur_ops->is_task_rcu_boosted() &&
+	    !in_serving_softirq() && !in_hardirq() && !in_nmi() &&
+	    READ_ONCE(firsttime) && xchg(&firsttime, 0)) {
+		WARN_ON_ONCE(deboost_timeliness_check);
+		nsegs = rtors.rtrsp - rtors.rtseg;
+		nsegs = clamp_val(nsegs, 0, RCUTORTURE_RDR_MAX_SEGS);
+		pr_alert("Slow-deboost rcutorture reader segments:\n");
+		rcu_torture_dump_read_segs(rtors.rtseg, nsegs);
+	}
 	return true;
 }
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 95ad967adcf3cb..3331930b199fb9 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -923,7 +923,7 @@ void rcu_read_unlock_strict(void)
 	 *
 	 * The in_atomic_preempt_off() check ensures that we come here holding
 	 * the last preempt_count (which will get dropped once we return to
-	 * __rcu_read_unlock().
+	 * __rcu_read_unlock()).
 	 */
 	rdp = this_cpu_ptr(&rcu_data);
 	rdp->cpu_no_qs.b.norm = false;
@@ -1320,6 +1320,41 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
 }
 
+#ifdef CONFIG_RCU_TORTURE_TEST
+
+/*
+ * Is the current task RCU priority boosted?  This is used by
+ * rcutorture to check that tasks are always deboosted once then exit
+ * an RCU read-side critical section, no matter how many overlapping
+ * segments of rcu_read_lock(), preempt_disable(), local_bh_disable(),
+ * or local_irq_disable() made up that reader.
+ *
+ * The lockless accesses in rt_mutex_owner(&rnp->boost_mtx.rtmutex)
+ * are safe because tasks release ->boost_mtx when they own it, they
+ * cannot be boosted unless current->rcu_blocked_node is non-NULL,
+ * current->rcu_blocked_node is modified only by the current task,
+ * rt_mutex_owner() uses READ_ONCE() on the ->owner field, and the owner
+ * switching among other tasks cannot force an equality comparison.
+ */
+bool rcu_is_task_rcu_boosted(void)
+{
+	bool ret;
+	struct rcu_node *rnp;
+	struct task_struct *t = current;
+
+	preempt_disable(); // Stabilize ->rcu_blocked_node
+	rnp = t->rcu_blocked_node;
+	if (!rnp)
+		ret = false;
+	else
+		ret = (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t);
+	preempt_enable();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rcu_is_task_rcu_boosted);
+
+#endif // #ifdef CONFIG_RCU_TORTURE_TEST
+
 #else /* #ifdef CONFIG_RCU_BOOST */
 
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
-- 
2.40.1

