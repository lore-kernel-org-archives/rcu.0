Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEB1C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5124520784
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974823;
	bh=qfY7oAjrMfcm/GPKUik8xyHSTHJAx6QYani+IyTuX3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EYr/+iC+cQiUFGDfPXsPqrljpFC67mky7IWwhJf+C1uTRB1fOQ+HrleY6pMvJ5CyB
	 zkZIY7KAIGjEgKMKFUGpHPGN2AzjAF8LVsNqkhHBhOiQTBlC6DzSZ8aFkRxKM2WgI7
	 LEI7sR93TjjM39qRpZ+YcVKhGhno+0ADEktOwEdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898347AbgDOSUP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441398AbgDOST4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C47921D92;
        Wed, 15 Apr 2020 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974795;
        bh=qfY7oAjrMfcm/GPKUik8xyHSTHJAx6QYani+IyTuX3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0AlpiWTZ0iiqtSqT6ujn6zvgaTrLmETVeKp4MRpl/rBs3w85IePl8vVoZ45PSpffG
         rLWzV44O6jUwqakEpUtJ+YCql52xNdD2CjDrlSpoUDkIZk10NZgxhKSeNfT598/riW
         mk2H+FGFgbwNhLlokQNuehnFjzH2R0hZDVGyyz7k=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 35/38] rcu-tasks: Add IPI failure count to statistics
Date:   Wed, 15 Apr 2020 11:19:38 -0700
Message-Id: <20200415181941.11653-35-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a failure-return count for smp_call_function_single(),
and adds this to the console messages for rcutorture writer stalls and at
the end of rcutorture testing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 43cac4b..e600d29 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -32,6 +32,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @gp_start: Most recent grace-period start in jiffies.
  * @n_gps: Number of grace periods completed since boot.
  * @n_ipis: Number of IPIs sent to encourage grace periods to end.
+ * @n_ipis_fails: Number of IPI-send failures.
  * @pregp_func: This flavor's pre-grace-period function (optional).
  * @pertask_func: This flavor's per-task scan function (optional).
  * @postscan_func: This flavor's post-task scan function (optional).
@@ -51,6 +52,7 @@ struct rcu_tasks {
 	unsigned long gp_start;
 	unsigned long n_gps;
 	unsigned long n_ipis;
+	unsigned long n_ipis_fails;
 	struct task_struct *kthread_ptr;
 	rcu_tasks_gp_func_t gp_func;
 	pregp_func_t pregp_func;
@@ -290,12 +292,12 @@ static void __init rcu_tasks_bootup_oddness(void)
 /* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
 static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 {
-	pr_info("%s: %s(%d) since %lu g:%lu i:%lu %c%c %s\n",
+	pr_info("%s: %s(%d) since %lu g:%lu i:%lu/%lu %c%c %s\n",
 		rtp->kname,
-		tasks_gp_state_getname(rtp),
-		data_race(rtp->gp_state),
+		tasks_gp_state_getname(rtp), data_race(rtp->gp_state),
 		jiffies - data_race(rtp->gp_jiffies),
-		data_race(rtp->n_gps), data_race(rtp->n_ipis),
+		data_race(rtp->n_gps),
+		data_race(rtp->n_ipis_fails), data_race(rtp->n_ipis),
 		".k"[!!data_race(rtp->kthread_ptr)],
 		".C"[!!data_race(rtp->cbs_head)],
 		s);
@@ -905,6 +907,7 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 					     trc_read_check_handler, t, 0)) {
 			// Just in case there is some other reason for
 			// failure than the target CPU being offline.
+			rcu_tasks_trace.n_ipis_fails++;
 			per_cpu(trc_ipi_to_cpu, cpu) = false;
 			t->trc_ipi_to_cpu = cpu;
 			if (atomic_dec_and_test(&trc_n_readers_need_end)) {
-- 
2.9.5

