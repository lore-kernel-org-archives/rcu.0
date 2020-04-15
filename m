Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47D3C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59E420787
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974943;
	bh=yGRMtH20Rh8i3PCF3yestqxkWzIyt0WgNjtRB5YtRJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KOEkFtUOzOU0r9lJa8K6Bv9MnpT532vFrnGrtY+NaY83CDkcwYF7fye5vVlktvU09
	 l5THYZI//yMfw4mW3Q0CoP/088XC3wpUQZJXYWVmPL3xozcWPTp/tPWDPk91S8yNks
	 TXZK9Y1Zh8ny4RrunaBb1WToehZ3f+LBvcgL2R7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416600AbgDOSWW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441387AbgDOSTx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CC4E21974;
        Wed, 15 Apr 2020 18:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974792;
        bh=yGRMtH20Rh8i3PCF3yestqxkWzIyt0WgNjtRB5YtRJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4o3zzaDDD0qZonDrtQVH5Qskl5D4zPlHmFXdn2jk28ERaGGrSB3pdGAf6/LRfsvo
         69xTVbqhoPokZ7lkgBuGMjiFWwgrzYB4mS5apo6iRGkk2KlJgDvZ/ltGTO5zJJc9Qj
         2ot3XbSvaSezMrdD25lVx8c2jIJ0rc8GudJxZZGk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 25/38] rcu-tasks: Add grace-period and IPI counts to statistics
Date:   Wed, 15 Apr 2020 11:19:28 -0700
Message-Id: <20200415181941.11653-25-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a grace-period count and a count of IPIs sent since
boot, which is printed in response to rcutorture writer stalls and at
the end of rcutorture testing.  These counts will be used to evaluate
various schemes to reduce the number of IPIs sent.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4a730f1..94225f9 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -30,6 +30,8 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @gp_state: Grace period's most recent state transition (debugging).
  * @gp_jiffies: Time of last @gp_state transition.
  * @gp_start: Most recent grace-period start in jiffies.
+ * @n_gps: Number of grace periods completed since boot.
+ * @n_ipis: Number of IPIs sent to encourage grace periods to end.
  * @pregp_func: This flavor's pre-grace-period function (optional).
  * @pertask_func: This flavor's per-task scan function (optional).
  * @postscan_func: This flavor's post-task scan function (optional).
@@ -47,6 +49,8 @@ struct rcu_tasks {
 	int gp_state;
 	unsigned long gp_jiffies;
 	unsigned long gp_start;
+	unsigned long n_gps;
+	unsigned long n_ipis;
 	struct task_struct *kthread_ptr;
 	rcu_tasks_gp_func_t gp_func;
 	pregp_func_t pregp_func;
@@ -208,6 +212,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		set_tasks_gp_state(rtp, RTGS_WAIT_GP);
 		rtp->gp_start = jiffies;
 		rtp->gp_func(rtp);
+		rtp->n_gps++;
 
 		/* Invoke the callbacks. */
 		set_tasks_gp_state(rtp, RTGS_INVOKE_CBS);
@@ -285,11 +290,12 @@ static void __init rcu_tasks_bootup_oddness(void)
 /* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
 static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 {
-	pr_info("%s: %s(%d) since %lu %c%c %s\n",
+	pr_info("%s: %s(%d) since %lu g:%lu i:%lu %c%c %s\n",
 		rtp->kname,
 		tasks_gp_state_getname(rtp),
 		data_race(rtp->gp_state),
 		jiffies - data_race(rtp->gp_jiffies),
+		data_race(rtp->n_gps), data_race(rtp->n_ipis),
 		".k"[!!data_race(rtp->kthread_ptr)],
 		".C"[!!data_race(rtp->cbs_head)],
 		s);
@@ -592,6 +598,7 @@ static void rcu_tasks_be_rude(struct work_struct *work)
 // Wait for one rude RCU-tasks grace period.
 static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 {
+	rtp->n_ipis += cpumask_weight(cpu_online_mask);
 	schedule_on_each_cpu(rcu_tasks_be_rude);
 }
 
@@ -852,6 +859,7 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 		atomic_inc(&trc_n_readers_need_end);
 		per_cpu(trc_ipi_to_cpu, cpu) = true;
 		t->trc_ipi_to_cpu = cpu;
+		rcu_tasks_trace.n_ipis++;
 		if (smp_call_function_single(cpu,
 					     trc_read_check_handler, t, 0)) {
 			// Just in case there is some other reason for
-- 
2.9.5

