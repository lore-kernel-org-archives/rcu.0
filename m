Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7254C2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D9520857
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586971456;
	bh=9cWNvOBuFtO8wYiz1liQufquRY7A6S1vBnbO0MsNQc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2nap9WHaWPks8EFCKfLCECeCDlHOLdeM6lTBxboAjDDvADQ3uVPFsMgDPpfnZH4P6
	 SxlTv/BrpRmKQd3eEL72SQ1X3u289s/jUNf+/ZLrGpCnSv8Q2qObTDWvPPrz2CYbG2
	 IUiojtn4vDB6Mh0/MBXBEaG10hYoDAY2CrbyU+NA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410931AbgDORYI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410925AbgDORYG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:24:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D4D0214D8;
        Wed, 15 Apr 2020 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971445;
        bh=9cWNvOBuFtO8wYiz1liQufquRY7A6S1vBnbO0MsNQc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXP68iJ4/qV/M3FTgCGy/tzz7ut/Ys4t9szYIKe9Wc4h8T0cMQMEEVBMB9/PqIEEQ
         pogxY9/8tlJbQ2w1cERuMHw/wPkBEHx439IJbWvz+juE4j9BcgIebQeQJE5p+gt+qA
         c/8buwdwNamYMhCrpwS6lRm5uCqAP0Zr2jhx/YD0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/3] rcu: When GP kthread is starved, tag idle threads as false positives
Date:   Wed, 15 Apr 2020 10:24:02 -0700
Message-Id: <20200415172403.9647-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415172341.GA9519@paulmck-ThinkPad-P72>
References: <20200415172341.GA9519@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

If the grace-period kthread is starved, idle threads' extended quiescent
states are not reported.  These idle threads thus wrongly appear to
be blocking the current grace period.  This commit therefore tags such
idle threads as probable false positives when the grace-period kthread
is being starved.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 119ed6a..4da41a6 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -299,6 +299,16 @@ static const char *gp_state_getname(short gs)
 	return gp_state_names[gs];
 }
 
+/* Is the RCU grace-period kthread being starved of CPU time? */
+static bool rcu_is_gp_kthread_starving(unsigned long *jp)
+{
+	unsigned long j = jiffies - READ_ONCE(rcu_state.gp_activity);
+
+	if (jp)
+		*jp = j;
+	return j > 2 * HZ;
+}
+
 /*
  * Print out diagnostic information for the specified stalled CPU.
  *
@@ -313,6 +323,7 @@ static const char *gp_state_getname(short gs)
 static void print_cpu_stall_info(int cpu)
 {
 	unsigned long delta;
+	bool falsepositive;
 	char fast_no_hz[72];
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	char *ticks_title;
@@ -333,7 +344,9 @@ static void print_cpu_stall_info(int cpu)
 	}
 	print_cpu_stall_fast_no_hz(fast_no_hz, cpu);
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
+	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
+			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
 	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
@@ -345,8 +358,9 @@ static void print_cpu_stall_info(int cpu)
 	       rcu_dynticks_snap(rdp) & 0xfff,
 	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
-	       READ_ONCE(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
-	       fast_no_hz);
+	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
+	       fast_no_hz,
+	       falsepositive ? " (false positive?)" : "");
 }
 
 /* Complain about starvation of grace-period kthread.  */
@@ -355,8 +369,7 @@ static void rcu_check_gp_kthread_starvation(void)
 	struct task_struct *gpk = rcu_state.gp_kthread;
 	unsigned long j;
 
-	j = jiffies - READ_ONCE(rcu_state.gp_activity);
-	if (j > 2 * HZ) {
+	if (rcu_is_gp_kthread_starving(&j)) {
 		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
 		       rcu_state.name, j,
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
@@ -364,6 +377,7 @@ static void rcu_check_gp_kthread_starvation(void)
 		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
 		       gpk ? gpk->state : ~0, gpk ? task_cpu(gpk) : -1);
 		if (gpk) {
+			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
 			pr_err("RCU grace-period kthread stack dump:\n");
 			sched_show_task(gpk);
 			wake_up_process(gpk);
-- 
2.9.5

