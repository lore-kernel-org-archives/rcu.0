Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6274FC2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450EB20787
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974893;
	bh=421cJ/3mEr/O6xXiETtx1rbc6G9VT972AIw9SaRUQHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tHwD90Q8xm7HdGI0IR11uBHEFHmtbze1sFo2YYvfEmIYLCXcfBXVdLpd1z1X+gTy4
	 8Edo09Evaisi2YR1C6defrZ3fr4Ii9VOMswmN8TVmdDXYFGwsEGqZyhBdb77T9tWlA
	 jy43phIzO8qJJGME3CUkEvOxg/M64SAfwjwjtSD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441464AbgDOSVa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441391AbgDOSTy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A06021D7F;
        Wed, 15 Apr 2020 18:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974793;
        bh=421cJ/3mEr/O6xXiETtx1rbc6G9VT972AIw9SaRUQHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvaWfn/FO0kwGlH8ifwCZjHva85lrDz5pWSUbYaNK4r4IXDcVH2ppFknS68tgBEB+
         4wzK+B6N2B3EPnH2DbuPJsEk71HE6AvW3ZPy4DRheV2GW4NkqBzGVX334et2ttkXfu
         QdU6OY6cvKXDQxTMBqnEVWksIsqk/iowErfHN4ZQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 29/38] rcu-tasks: Disable CPU hotplug across RCU tasks trace scans
Date:   Wed, 15 Apr 2020 11:19:32 -0700
Message-Id: <20200415181941.11653-29-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit disables CPU hotplug across RCU tasks trace scans, which
is a first step towards correctly recognizing idle tasks "running" on
offline CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 0cdeeb3..e8c03bd 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -906,16 +906,16 @@ static void rcu_tasks_trace_pregp_step(void)
 {
 	int cpu;
 
-	// Wait for CPU-hotplug paths to complete.
-	cpus_read_lock();
-	cpus_read_unlock();
-
 	// Allow for fast-acting IPIs.
 	atomic_set(&trc_n_readers_need_end, 1);
 
 	// There shouldn't be any old IPIs, but...
 	for_each_possible_cpu(cpu)
 		WARN_ON_ONCE(per_cpu(trc_ipi_to_cpu, cpu));
+
+	// Disable CPU hotplug across the tasklist scan.
+	// This also waits for all readers in CPU-hotplug code paths.
+	cpus_read_lock();
 }
 
 /* Do first-round processing for the specified task. */
@@ -931,6 +931,9 @@ static void rcu_tasks_trace_pertask(struct task_struct *t,
 /* Do intermediate processing between task and holdout scans. */
 static void rcu_tasks_trace_postscan(void)
 {
+	// Re-enable CPU hotplug now that the tasklist scan has completed.
+	cpus_read_unlock();
+
 	// Wait for late-stage exiting tasks to finish exiting.
 	// These might have passed the call to exit_tasks_rcu_finish().
 	synchronize_rcu();
@@ -975,6 +978,9 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 {
 	struct task_struct *g, *t;
 
+	// Disable CPU hotplug across the holdout list scan.
+	cpus_read_lock();
+
 	list_for_each_entry_safe(t, g, hop, trc_holdout_list) {
 		// If safe and needed, try to check the current task.
 		if (READ_ONCE(t->trc_ipi_to_cpu) == -1 &&
@@ -987,6 +993,10 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 		else if (needreport)
 			show_stalled_task_trace(t, firstreport);
 	}
+
+	// Re-enable CPU hotplug now that the holdout list scan has completed.
+	cpus_read_unlock();
+
 	if (needreport) {
 		if (firstreport)
 			pr_err("INFO: rcu_tasks_trace detected stalls? (Late IPI?)\n");
-- 
2.9.5

