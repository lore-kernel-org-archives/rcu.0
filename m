Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8FAC5479D
	for <rcu@archiver.kernel.org>; Wed, 11 Jan 2023 21:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjAKV1l (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 Jan 2023 16:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjAKV1k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 Jan 2023 16:27:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EB9B05
        for <rcu@vger.kernel.org>; Wed, 11 Jan 2023 13:27:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AF38B81D5C
        for <rcu@vger.kernel.org>; Wed, 11 Jan 2023 21:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B211FC433D2;
        Wed, 11 Jan 2023 21:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673472456;
        bh=My8dcVm18qlVfA6iZTsvu/bkWrJSZ41EorgT8PWmMfQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=D/vsGkIjyvjJL0AweoCh1F7xFSewMJW7O4ZlWVE+kRvONDZxVZvnRlMf+9YEKshkI
         86oofuxtMQcHs9DbIUSyuUBcGmuWzI5TPys59yol/VtFhcgpEhzqcgeP1VPIS72M8J
         MAFmKv7C31/9VR1RbM6EQvzBFUn8d2ZWKQM291k8pzLxZXBo6FTC0pnVqk3mtiycb8
         KDHJbEDeYZKfSU/Funs4Uu7x2XQ1D7ZGSgfUoaTKaO/P1OcFY5nZyfmp5TzZglBQG9
         1I5cCecwgelYhx+IGoOLJoxJurhBjxISfS32W48ojOt5zzRI2wLoF5CancnTXT8UUP
         v7KvZT0+Xl2GQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5DC455C0920; Wed, 11 Jan 2023 13:27:36 -0800 (PST)
Date:   Wed, 11 Jan 2023 13:27:36 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     broonie@kernel.org
Cc:     rcu@vger.kernel.org, quic_neeraju@quicinc.com
Subject: Diagnosing stall in synchronize_srcu() from rcu_tasks_postscan()
Message-ID: <20230111212736.GA1062057@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Mark,

A few days ago you mentioned stalls in RCU tasks.  Neeraj has supplied
the following diagnostic patch, which will confirm or invalidate my
assumptions about the cause of the stall.

Could you please try it out and let us know the outcome?

							Thanx, Paul

------------------------------------------------------------------------

commit 1e464bd08ee844fb43594b69f471c05eaeda5cda
Author: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Date:   Wed Jan 11 13:15:00 2023 +0530

    rcu-tasks: Report stalls during synchronize_srcu() in rcu_tasks_postscan()
    
    The call to synchronize_srcu() from rcu_tasks_postscan() can be stalled
    by a task getting stuck in do_exit() between that function's calls to
    exit_tasks_rcu_start() and exit_tasks_rcu_finish().   To ease diagnosis
    of this situation, print a stall warning message every rcu_task_stall_info
    period when rcu_tasks_postscan() is stalled.
    
    Reported-by: Mark Brown <broonie@kernel.org>
    Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bfb5e1549f2b2..53eb95748b4f0 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -139,6 +139,12 @@ static struct rcu_tasks rt_name =							\
 /* Track exiting tasks in order to allow them to be waited for. */
 DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 
+#ifdef CONFIG_TASKS_RCU
+/* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
+static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
+static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);
+#endif
+
 /* Avoid IPIing CPUs early in the grace period. */
 #define RCU_TASK_IPI_DELAY (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) ? HZ / 2 : 0)
 static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
@@ -830,6 +836,11 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 /* Processing between scanning taskslist and draining the holdout list. */
 static void rcu_tasks_postscan(struct list_head *hop)
 {
+	int rtsi = READ_ONCE(rcu_task_stall_info);
+
+	tasks_rcu_exit_srcu_stall_timer.expires = jiffies + rtsi;
+	add_timer(&tasks_rcu_exit_srcu_stall_timer);
+
 	/*
 	 * Exiting tasks may escape the tasklist scan. Those are vulnerable
 	 * until their final schedule() with TASK_DEAD state. To cope with
@@ -848,6 +859,7 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	 * call to synchronize_rcu().
 	 */
 	synchronize_srcu(&tasks_rcu_exit_srcu);
+	del_timer_sync(&tasks_rcu_exit_srcu_stall_timer);
 }
 
 /* See if tasks are still holding out, complain if so. */
@@ -923,6 +935,18 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
 
+static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
+{
+	int rtsi = READ_ONCE(rcu_task_stall_info);
+
+	pr_info("%s: %s grace period number %lu (since boot) gp_state: %s is %lu jiffies old.\n",
+		__func__, rcu_tasks.kname, rcu_tasks.tasks_gp_seq,
+		tasks_gp_state_getname(&rcu_tasks), jiffies - rcu_tasks.gp_jiffies);
+	pr_info("Please check any exiting tasks stuck between calls to exit_tasks_rcu_start() and exit_tasks_rcu_finish()\n");
+	tasks_rcu_exit_srcu_stall_timer.expires = jiffies + rtsi;
+	add_timer(&tasks_rcu_exit_srcu_stall_timer);
+}
+
 /**
  * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
  * @rhp: structure to be used for queueing the RCU updates.
