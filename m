Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0774EC4742C
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85262073A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620119;
	bh=MU6emrq29RkuU/tk4hK16G6QfDH70QVRiaNynIsxyoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iHi65RQ8FsmXKfsLlFU1qYYr42VjLjgPoaW2ZFudIaLyEfi7OJsFB+V/LpNJb0QI7
	 s0HZ7wLn3YDcruycJt4EBNQlo7RFbwFC8C9NeFTsFtcKDNxqgTSK0g1NQZrsR+LELi
	 DcFWMtvMoWg+eUpYW/yWhg5ASmSsuKBaAgVZxdaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732804AbgKEXse (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:48:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732754AbgKEXr3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:29 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FF1F22228;
        Thu,  5 Nov 2020 23:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620048;
        bh=MU6emrq29RkuU/tk4hK16G6QfDH70QVRiaNynIsxyoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxQ91eNrAeMGGy++7GbW3ZnI9/G5THaOJx3rsivPl5Yyr0CenuOUSmMB4ohXOI2Rz
         JdqVSn5Nd7l1lmn1Xp9lWAeMCp4nvQYCIuNBpMpYtIzlG3JRGFywiIE1Xca1FrflJP
         e3r0xIkuq5SMmpV1LSpByCJVnMAUy0QEs1n2Ow0o=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/28] rcutorture:  Make stutter_wait() caller restore priority
Date:   Thu,  5 Nov 2020 15:47:09 -0800
Message-Id: <20201105234719.23307-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, stutter_wait() will happily spin waiting for the stutter
interval to end even if the caller is running at a real-time priority
level.  This could starve normal-priority tasks for no good reason.  This
commit therefore drops the calling task's priority to SCHED_OTHER MAX_NICE
if stutter_wait() needs to wait.  But when it waits, stutter_wait()
returns true, which allows the caller to restore the priority if needed.
Callers that were already running at SCHED_OTHER MAX_NICE obviously
do not need any changes, but this commit also restores priority for
higher-priority callers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 24 ++++++++++++++++++------
 kernel/torture.c        |  9 ++++-----
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index db37671..4391d2f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -912,7 +912,8 @@ static int rcu_torture_boost(void *arg)
 		oldstarttime = boost_starttime;
 		while (time_before(jiffies, oldstarttime)) {
 			schedule_timeout_interruptible(oldstarttime - jiffies);
-			stutter_wait("rcu_torture_boost");
+			if (stutter_wait("rcu_torture_boost"))
+				sched_set_fifo_low(current);
 			if (torture_must_stop())
 				goto checkwait;
 		}
@@ -932,7 +933,8 @@ static int rcu_torture_boost(void *arg)
 								 jiffies);
 				call_rcu_time = jiffies;
 			}
-			stutter_wait("rcu_torture_boost");
+			if (stutter_wait("rcu_torture_boost"))
+				sched_set_fifo_low(current);
 			if (torture_must_stop())
 				goto checkwait;
 		}
@@ -964,7 +966,8 @@ static int rcu_torture_boost(void *arg)
 		}
 
 		/* Go do the stutter. */
-checkwait:	stutter_wait("rcu_torture_boost");
+checkwait:	if (stutter_wait("rcu_torture_boost"))
+			sched_set_fifo_low(current);
 	} while (!torture_must_stop());
 
 	/* Clean up and exit. */
@@ -987,6 +990,7 @@ rcu_torture_fqs(void *arg)
 {
 	unsigned long fqs_resume_time;
 	int fqs_burst_remaining;
+	int oldnice = task_nice(current);
 
 	VERBOSE_TOROUT_STRING("rcu_torture_fqs task started");
 	do {
@@ -1002,7 +1006,8 @@ rcu_torture_fqs(void *arg)
 			udelay(fqs_holdoff);
 			fqs_burst_remaining -= fqs_holdoff;
 		}
-		stutter_wait("rcu_torture_fqs");
+		if (stutter_wait("rcu_torture_fqs"))
+			sched_set_normal(current, oldnice);
 	} while (!torture_must_stop());
 	torture_kthread_stopping("rcu_torture_fqs");
 	return 0;
@@ -1022,9 +1027,11 @@ rcu_torture_writer(void *arg)
 	bool gp_cond1 = gp_cond, gp_exp1 = gp_exp, gp_normal1 = gp_normal;
 	bool gp_sync1 = gp_sync;
 	int i;
+	int oldnice = task_nice(current);
 	struct rcu_torture *rp;
 	struct rcu_torture *old_rp;
 	static DEFINE_TORTURE_RANDOM(rand);
+	bool stutter_waited;
 	int synctype[] = { RTWS_DEF_FREE, RTWS_EXP_SYNC,
 			   RTWS_COND_GET, RTWS_SYNC };
 	int nsynctypes = 0;
@@ -1143,7 +1150,8 @@ rcu_torture_writer(void *arg)
 				       !rcu_gp_is_normal();
 		}
 		rcu_torture_writer_state = RTWS_STUTTER;
-		if (stutter_wait("rcu_torture_writer") &&
+		stutter_waited = stutter_wait("rcu_torture_writer");
+		if (stutter_waited &&
 		    !READ_ONCE(rcu_fwd_cb_nodelay) &&
 		    !cur_ops->slow_gps &&
 		    !torture_must_stop() &&
@@ -1155,6 +1163,8 @@ rcu_torture_writer(void *arg)
 					rcu_ftrace_dump(DUMP_ALL);
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
 				}
+		if (stutter_waited)
+			sched_set_normal(current, oldnice);
 	} while (!torture_must_stop());
 	rcu_torture_current = NULL;  // Let stats task know that we are done.
 	/* Reset expediting back to unexpedited. */
@@ -2103,6 +2113,7 @@ static struct notifier_block rcutorture_oom_nb = {
 /* Carry out grace-period forward-progress testing. */
 static int rcu_torture_fwd_prog(void *args)
 {
+	int oldnice = task_nice(current);
 	struct rcu_fwd *rfp = args;
 	int tested = 0;
 	int tested_tries = 0;
@@ -2121,7 +2132,8 @@ static int rcu_torture_fwd_prog(void *args)
 			rcu_torture_fwd_prog_cr(rfp);
 
 		/* Avoid slow periods, better to test when busy. */
-		stutter_wait("rcu_torture_fwd_prog");
+		if (stutter_wait("rcu_torture_fwd_prog"))
+			sched_set_normal(current, oldnice);
 	} while (!torture_must_stop());
 	/* Short runs might not contain a valid forward-progress attempt. */
 	WARN_ON(!tested && tested_tries >= 5);
diff --git a/kernel/torture.c b/kernel/torture.c
index d8bdd9a..8995ed1 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -604,19 +604,19 @@ bool stutter_wait(const char *title)
 {
 	ktime_t delay;
 	unsigned i = 0;
-	int oldnice;
 	bool ret = false;
 	int spt;
 
 	cond_resched_tasks_rcu_qs();
 	spt = READ_ONCE(stutter_pause_test);
 	for (; spt; spt = READ_ONCE(stutter_pause_test)) {
-		ret = true;
+		if (!ret) {
+			sched_set_normal(current, MAX_NICE);
+			ret = true;
+		}
 		if (spt == 1) {
 			schedule_timeout_interruptible(1);
 		} else if (spt == 2) {
-			oldnice = task_nice(current);
-			set_user_nice(current, MAX_NICE);
 			while (READ_ONCE(stutter_pause_test)) {
 				if (!(i++ & 0xffff)) {
 					set_current_state(TASK_INTERRUPTIBLE);
@@ -625,7 +625,6 @@ bool stutter_wait(const char *title)
 				}
 				cond_resched();
 			}
-			set_user_nice(current, oldnice);
 		} else {
 			schedule_timeout_interruptible(round_jiffies_relative(HZ));
 		}
-- 
2.9.5

