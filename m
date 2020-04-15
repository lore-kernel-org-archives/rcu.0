Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC5CC2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 174682076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974906;
	bh=T9/w6q7CENdfvJFl6wJFXIO6IbM2kExEvSh42iLeJjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nWhfxb640DuOVM8ckjMWbBxcKWEIeKsNejK72fkq8XhH+6escttteW2NIyUpQInUT
	 hyBadZsdWLObOnZ0EUmYeWGBU25pHs8eGnOfrHeqaWQgcJa1inMLjcU02uwZUqc+Vl
	 /AFeT993PtcokbGSx6HNyqYNPhFX+NCkaK6/u7gE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441475AbgDOSVm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:21:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441380AbgDOSTx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 623962084D;
        Wed, 15 Apr 2020 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974790;
        bh=T9/w6q7CENdfvJFl6wJFXIO6IbM2kExEvSh42iLeJjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnB3MoCKIAM+lJGEbCxfPIudRkzQYn0LiqR6Ofz46WKIoIKdrDFRrz02Bn9AfVcCF
         fkKLtAWzR6MccWiNc9H/zDtqBkHcOUe/NwLovx30Os/rISIg1U/OKjl2TsyZ+WsiTb
         HmJblPTTX4/P2P+2wdNtR39Y45QGl/WgRKMB2mlo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 20/38] rcu-tasks: Make rcutorture writer stall output include GP state
Date:   Wed, 15 Apr 2020 11:19:23 -0700
Message-Id: <20200415181941.11653-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds grace-period state and time to the rcutorture writer
stall output.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index cd220a4..8dffe2b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -17,7 +17,7 @@ typedef void (*pregp_func_t)(void);
 typedef void (*pertask_func_t)(struct task_struct *t, struct list_head *hop);
 typedef void (*postscan_func_t)(void);
 typedef void (*holdouts_func_t)(struct list_head *hop, bool ndrpt, bool *frptp);
-typedef void (*postgp_func_t)(void);
+typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
 
 /**
  * Definition for a Tasks-RCU-like mechanism.
@@ -27,6 +27,9 @@ typedef void (*postgp_func_t)(void);
  * @cbs_lock: Lock protecting callback list.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
+ * @gp_state: Grace period's most recent state transition (debugging).
+ * @gp_jiffies: Time of last @gp_state transition.
+ * @gp_start: Most recent grace-period start in jiffies.
  * @pregp_func: This flavor's pre-grace-period function (optional).
  * @pertask_func: This flavor's per-task scan function (optional).
  * @postscan_func: This flavor's post-task scan function (optional).
@@ -41,6 +44,8 @@ struct rcu_tasks {
 	struct rcu_head **cbs_tail;
 	struct wait_queue_head cbs_wq;
 	raw_spinlock_t cbs_lock;
+	int gp_state;
+	unsigned long gp_jiffies;
 	struct task_struct *kthread_ptr;
 	rcu_tasks_gp_func_t gp_func;
 	pregp_func_t pregp_func;
@@ -73,10 +78,56 @@ DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
 module_param(rcu_task_stall_timeout, int, 0644);
 
+/* RCU tasks grace-period state for debugging. */
+#define RTGS_INIT		 0
+#define RTGS_WAIT_WAIT_CBS	 1
+#define RTGS_WAIT_GP		 2
+#define RTGS_PRE_WAIT_GP	 3
+#define RTGS_SCAN_TASKLIST	 4
+#define RTGS_POST_SCAN_TASKLIST	 5
+#define RTGS_WAIT_SCAN_HOLDOUTS	 6
+#define RTGS_SCAN_HOLDOUTS	 7
+#define RTGS_POST_GP		 8
+#define RTGS_WAIT_READERS	 9
+#define RTGS_INVOKE_CBS		10
+#define RTGS_WAIT_CBS		11
+static const char * const rcu_tasks_gp_state_names[] = {
+	"RTGS_INIT",
+	"RTGS_WAIT_WAIT_CBS",
+	"RTGS_WAIT_GP",
+	"RTGS_PRE_WAIT_GP",
+	"RTGS_SCAN_TASKLIST",
+	"RTGS_POST_SCAN_TASKLIST",
+	"RTGS_WAIT_SCAN_HOLDOUTS",
+	"RTGS_SCAN_HOLDOUTS",
+	"RTGS_POST_GP",
+	"RTGS_WAIT_READERS",
+	"RTGS_INVOKE_CBS",
+	"RTGS_WAIT_CBS",
+};
+
 ////////////////////////////////////////////////////////////////////////
 //
 // Generic code.
 
+/* Record grace-period phase and time. */
+static void set_tasks_gp_state(struct rcu_tasks *rtp, int newstate)
+{
+	rtp->gp_state = newstate;
+	rtp->gp_jiffies = jiffies;
+}
+
+/* Return state name. */
+static const char *tasks_gp_state_getname(struct rcu_tasks *rtp)
+{
+	int i = data_race(rtp->gp_state); // Let KCSAN detect update races
+	int j = READ_ONCE(i); // Prevent the compiler from reading twice
+
+	if (j >= ARRAY_SIZE(rcu_tasks_gp_state_names))
+		return "???";
+	return rcu_tasks_gp_state_names[j];
+}
+
 // Enqueue a callback for the specified flavor of Tasks RCU.
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
@@ -141,15 +192,18 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 						 READ_ONCE(rtp->cbs_head));
 			if (!rtp->cbs_head) {
 				WARN_ON(signal_pending(current));
+				set_tasks_gp_state(rtp, RTGS_WAIT_WAIT_CBS);
 				schedule_timeout_interruptible(HZ/10);
 			}
 			continue;
 		}
 
 		// Wait for one grace period.
+		set_tasks_gp_state(rtp, RTGS_WAIT_GP);
 		rtp->gp_func(rtp);
 
 		/* Invoke the callbacks. */
+		set_tasks_gp_state(rtp, RTGS_INVOKE_CBS);
 		while (list) {
 			next = list->next;
 			local_bh_disable();
@@ -160,6 +214,8 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		}
 		/* Paranoid sleep to keep this from entering a tight loop */
 		schedule_timeout_uninterruptible(HZ/10);
+
+		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 	}
 }
 
@@ -222,8 +278,11 @@ static void __init rcu_tasks_bootup_oddness(void)
 /* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
 static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 {
-	pr_info("%s %c%c %s\n",
+	pr_info("%s: %s(%d) since %lu %c%c %s\n",
 		rtp->kname,
+		tasks_gp_state_getname(rtp),
+		data_race(rtp->gp_state),
+		jiffies - data_race(rtp->gp_jiffies),
 		".k"[!!data_race(rtp->kthread_ptr)],
 		".C"[!!data_race(rtp->cbs_head)],
 		s);
@@ -243,6 +302,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	LIST_HEAD(holdouts);
 	int fract;
 
+	set_tasks_gp_state(rtp, RTGS_PRE_WAIT_GP);
 	rtp->pregp_func();
 
 	/*
@@ -251,11 +311,13 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	 * that are not already voluntarily blocked.  Mark these tasks
 	 * and make a list of them in holdouts.
 	 */
+	set_tasks_gp_state(rtp, RTGS_SCAN_TASKLIST);
 	rcu_read_lock();
 	for_each_process_thread(g, t)
 		rtp->pertask_func(t, &holdouts);
 	rcu_read_unlock();
 
+	set_tasks_gp_state(rtp, RTGS_POST_SCAN_TASKLIST);
 	rtp->postscan_func();
 
 	/*
@@ -277,6 +339,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 			break;
 
 		/* Slowly back off waiting for holdouts */
+		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
 		schedule_timeout_interruptible(HZ/fract);
 
 		if (fract > 1)
@@ -288,10 +351,12 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 			lastreport = jiffies;
 		firstreport = true;
 		WARN_ON(signal_pending(current));
+		set_tasks_gp_state(rtp, RTGS_SCAN_HOLDOUTS);
 		rtp->holdouts_func(&holdouts, needreport, &firstreport);
 	}
 
-	rtp->postgp_func();
+	set_tasks_gp_state(rtp, RTGS_POST_GP);
+	rtp->postgp_func(rtp);
 }
 
 ////////////////////////////////////////////////////////////////////////
@@ -394,7 +459,7 @@ static void check_all_holdout_tasks(struct list_head *hop,
 }
 
 /* Finish off the Tasks-RCU grace period. */
-static void rcu_tasks_postgp(void)
+static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 {
 	/*
 	 * Because ->on_rq and ->nvcsw are not guaranteed to have a full
@@ -877,7 +942,7 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 }
 
 /* Wait for grace period to complete and provide ordering. */
-static void rcu_tasks_trace_postgp(void)
+static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 {
 	bool firstreport;
 	struct task_struct *g, *t;
@@ -890,6 +955,7 @@ static void rcu_tasks_trace_postgp(void)
 	smp_mb__after_atomic();  // Order vs. later atomics
 
 	// Wait for readers.
+	set_tasks_gp_state(rtp, RTGS_WAIT_READERS);
 	for (;;) {
 		ret = wait_event_idle_exclusive_timeout(
 				trc_wait,
@@ -897,6 +963,7 @@ static void rcu_tasks_trace_postgp(void)
 				READ_ONCE(rcu_task_stall_timeout));
 		if (ret)
 			break;  // Count reached zero.
+		// Stall warning time, so make a list of the offenders.
 		for_each_process_thread(g, t)
 			if (READ_ONCE(t->trc_reader_need_end))
 				trc_add_holdout(t, &holdouts);
-- 
2.9.5

