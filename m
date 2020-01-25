Return-Path: <SRS0=fEXk=3O=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45205C2D0DB
	for <rcu@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D99218AC
	for <rcu@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgAYKne (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:43:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44413 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbgAYKnd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:33 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuG-0000Br-KB; Sat, 25 Jan 2020 11:43:12 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A20781C1A8C;
        Sat, 25 Jan 2020 11:42:54 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:54 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Use CONFIG_PREEMPTION where appropriate
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897444.396.410592911890723402.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     90326f0521a88004194f88f1b597b54347482b5c
Gitweb:        https://git.kernel.org/tip/90326f0521a88004194f88f1b597b54347482b5c
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:18:14 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:37:51 -08:00

rcu: Use CONFIG_PREEMPTION where appropriate

The config option `CONFIG_PREEMPT' is used for the preemption model
"Low-Latency Desktop". The config option `CONFIG_PREEMPTION' is enabled
when kernel preemption is enabled which is true for the preemption model
`CONFIG_PREEMPT' and `CONFIG_PREEMPT_RT'.

Use `CONFIG_PREEMPTION' if it applies to both preemption models and not
just to `CONFIG_PREEMPT'.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 4 ++--
 kernel/rcu/Kconfig       | 4 ++--
 kernel/rcu/rcutorture.c  | 2 +-
 kernel/rcu/srcutiny.c    | 2 +-
 kernel/rcu/tree.c        | 4 ++--
 kernel/rcu/tree_exp.h    | 2 +-
 kernel/rcu/tree_plugin.h | 4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 70a41cd..eb32fff 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -154,7 +154,7 @@ static inline void exit_tasks_rcu_finish(void) { }
  *
  * This macro resembles cond_resched(), except that it is defined to
  * report potential quiescent states to RCU-tasks even if the cond_resched()
- * machinery were to be shut off, as some advocate for PREEMPT kernels.
+ * machinery were to be shut off, as some advocate for PREEMPTION kernels.
  */
 #define cond_resched_tasks_rcu_qs() \
 do { \
@@ -598,7 +598,7 @@ do {									      \
  *
  * You can avoid reading and understanding the next paragraph by
  * following this rule: don't put anything in an rcu_read_lock() RCU
- * read-side critical section that would block in a !PREEMPT kernel.
+ * read-side critical section that would block in a !PREEMPTION kernel.
  * But if you want the full story, read on!
  *
  * In non-preemptible RCU implementations (pure TREE_RCU and TINY_RCU),
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 0303934..1cc940f 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -201,8 +201,8 @@ config RCU_NOCB_CPU
 	  specified at boot time by the rcu_nocbs parameter.  For each
 	  such CPU, a kthread ("rcuox/N") will be created to invoke
 	  callbacks, where the "N" is the CPU being offloaded, and where
-	  the "p" for RCU-preempt (PREEMPT kernels) and "s" for RCU-sched
-	  (!PREEMPT kernels).  Nothing prevents this kthread from running
+	  the "p" for RCU-preempt (PREEMPTION kernels) and "s" for RCU-sched
+	  (!PREEMPTION kernels).  Nothing prevents this kthread from running
 	  on the specified CPUs, but (1) the kthreads may be preempted
 	  between each callback, and (2) affinity or cgroups can be used
 	  to force the kthreads to run on whatever set of CPUs is desired.
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index dee043f..121a050 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1730,7 +1730,7 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 // Give the scheduler a chance, even on nohz_full CPUs.
 static void rcu_torture_fwd_prog_cond_resched(unsigned long iter)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT) && IS_ENABLED(CONFIG_NO_HZ_FULL)) {
+	if (IS_ENABLED(CONFIG_PREEMPTION) && IS_ENABLED(CONFIG_NO_HZ_FULL)) {
 		// Real call_rcu() floods hit userspace, so emulate that.
 		if (need_resched() || (iter & 0xfff))
 			schedule();
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 44d6606..6208c1d 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -103,7 +103,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
 /*
  * Workqueue handler to drive one grace period and invoke any callbacks
- * that become ready as a result.  Single-CPU and !PREEMPT operation
+ * that become ready as a result.  Single-CPU and !PREEMPTION operation
  * means that we get away with murder on synchronization.  ;-)
  */
 void srcu_drive_gp(struct work_struct *wp)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1694a6b..c9dbb05 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2698,9 +2698,9 @@ EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
 /*
  * During early boot, any blocking grace-period wait automatically
- * implies a grace period.  Later on, this is never the case for PREEMPT.
+ * implies a grace period.  Later on, this is never the case for PREEMPTION.
  *
- * Howevr, because a context switch is a grace period for !PREEMPT, any
+ * Howevr, because a context switch is a grace period for !PREEMPTION, any
  * blocking grace-period wait automatically implies a grace period if
  * there is only one CPU online at any point time during execution of
  * either synchronize_rcu() or synchronize_rcu_expedited().  It is OK to
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d632cd0..98d078c 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -670,7 +670,7 @@ static void rcu_exp_handler(void *unused)
 	}
 }
 
-/* PREEMPT=y, so no PREEMPT=n expedited grace period to clean up after. */
+/* PREEMPTION=y, so no PREEMPTION=n expedited grace period to clean up after. */
 static void sync_sched_exp_online_cleanup(int cpu)
 {
 }
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ed54d36..8cdce11 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -789,7 +789,7 @@ static void __init rcu_bootup_announce(void)
 }
 
 /*
- * Note a quiescent state for PREEMPT=n.  Because we do not need to know
+ * Note a quiescent state for PREEMPTION=n.  Because we do not need to know
  * how many quiescent states passed, just if there was at least one since
  * the start of the grace period, this just sets a flag.  The caller must
  * have disabled preemption.
@@ -839,7 +839,7 @@ void rcu_all_qs(void)
 EXPORT_SYMBOL_GPL(rcu_all_qs);
 
 /*
- * Note a PREEMPT=n context switch.  The caller must have disabled interrupts.
+ * Note a PREEMPTION=n context switch. The caller must have disabled interrupts.
  */
 void rcu_note_context_switch(bool preempt)
 {
