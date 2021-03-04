Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5176AC43381
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279C764F1D
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhCDBA6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240689AbhCDAXz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:23:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95AB764EFD;
        Thu,  4 Mar 2021 00:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817393;
        bh=86HZnrwDd4o9/nc/AAg1/g535ilMOsE2DsnD8/PVHx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cr4TpiYnhsgzk7ExsfTqp5Va0v1PSqt6qD/EYu/yzBLzGuStEUhKHkRu0QDkD7l6o
         0mdokteESmQlT+qKDrUl3YtgefTneLfJQe0yQSL46oRJBekw3CTtD8IFdwFTbu9Eku
         IuvEcJ1JCRz11QD2XAyLr0Q1P5HUQ6afDVt9cKMTDgcAo1sgkhodT2tomUtw/lPcD2
         K96IHMllmkHlZoRz1WEytVS46Z7gWd4bzjJn9fFtpqStutQ6HFCJ0mo+o/h06HMDKm
         Nq2uOWSevnCYlHEPmUWDkgVxVHiLaNY0IuAbdNycTSWiBlrML7OVypDOOhnq4/yPWi
         BpxXzW4Lz+ZGw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/12] rcu/nocb: Forbid NOCB toggling on offline CPUs
Date:   Wed,  3 Mar 2021 16:23:03 -0800
Message-Id: <20210304002311.23655-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002225.GA23492@paulmck-ThinkPad-P72>
References: <20210304002225.GA23492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

It makes no sense to de-offload an offline CPU because that CPU will never
invoke any remaining callbacks.  It also makes little sense to offload an
offline CPU because any pending RCU callbacks were migrated when that CPU
went offline.  Yes, it is in theory possible to use a number of tricks
to permit offloading and deoffloading offline CPUs in certain cases, but
in practice it is far better to have the simple and deterministic rule
"Toggling the offload state of an offline CPU is forbidden".

For but one example, consider that an offloaded offline CPU might have
millions of callbacks queued.  Best to just say "no".

This commit therefore forbids toggling of the offloaded state of
offline CPUs.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        |  3 +--
 kernel/rcu/tree_plugin.h | 57 ++++++++++++++++++------------------------------
 2 files changed, 22 insertions(+), 38 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 03503e2..ee77858 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4086,8 +4086,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
 	/*
 	 * Lock in case the CB/GP kthreads are still around handling
-	 * old callbacks (longer term we should flush all callbacks
-	 * before completing CPU offline)
+	 * old callbacks.
 	 */
 	rcu_nocb_lock(rdp);
 	if (rcu_segcblist_empty(&rdp->cblist)) /* No early-boot CBs? */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 013142d..9fd8588 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2399,23 +2399,18 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
 	return 0;
 }
 
-static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
+static long rcu_nocb_rdp_deoffload(void *arg)
 {
+	struct rcu_data *rdp = arg;
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
 	int ret;
 
+	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
+
 	pr_info("De-offloading %d\n", rdp->cpu);
 
 	rcu_nocb_lock_irqsave(rdp, flags);
-	/*
-	 * If there are still pending work offloaded, the offline
-	 * CPU won't help much handling them.
-	 */
-	if (cpu_is_offline(rdp->cpu) && !rcu_segcblist_empty(&rdp->cblist)) {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
-		return -EBUSY;
-	}
 
 	ret = rdp_offload_toggle(rdp, false, flags);
 	swait_event_exclusive(rdp->nocb_state_wq,
@@ -2446,14 +2441,6 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	return ret;
 }
 
-static long rcu_nocb_rdp_deoffload(void *arg)
-{
-	struct rcu_data *rdp = arg;
-
-	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
-	return __rcu_nocb_rdp_deoffload(rdp);
-}
-
 int rcu_nocb_cpu_deoffload(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
@@ -2466,12 +2453,14 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
 	if (rcu_rdp_is_offloaded(rdp)) {
-		if (cpu_online(cpu))
+		if (cpu_online(cpu)) {
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
-		else
-			ret = __rcu_nocb_rdp_deoffload(rdp);
-		if (!ret)
-			cpumask_clear_cpu(cpu, rcu_nocb_mask);
+			if (!ret)
+				cpumask_clear_cpu(cpu, rcu_nocb_mask);
+		} else {
+			pr_info("NOCB: Can't CB-deoffload an offline CPU\n");
+			ret = -EINVAL;
+		}
 	}
 	cpus_read_unlock();
 	mutex_unlock(&rcu_state.barrier_mutex);
@@ -2480,12 +2469,14 @@ int rcu_nocb_cpu_deoffload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
 
-static int __rcu_nocb_rdp_offload(struct rcu_data *rdp)
+static long rcu_nocb_rdp_offload(void *arg)
 {
+	struct rcu_data *rdp = arg;
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
 	int ret;
 
+	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
 	/*
 	 * For now we only support re-offload, ie: the rdp must have been
 	 * offloaded on boot first.
@@ -2525,14 +2516,6 @@ static int __rcu_nocb_rdp_offload(struct rcu_data *rdp)
 	return ret;
 }
 
-static long rcu_nocb_rdp_offload(void *arg)
-{
-	struct rcu_data *rdp = arg;
-
-	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
-	return __rcu_nocb_rdp_offload(rdp);
-}
-
 int rcu_nocb_cpu_offload(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
@@ -2541,12 +2524,14 @@ int rcu_nocb_cpu_offload(int cpu)
 	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
 	if (!rcu_rdp_is_offloaded(rdp)) {
-		if (cpu_online(cpu))
+		if (cpu_online(cpu)) {
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
-		else
-			ret = __rcu_nocb_rdp_offload(rdp);
-		if (!ret)
-			cpumask_set_cpu(cpu, rcu_nocb_mask);
+			if (!ret)
+				cpumask_set_cpu(cpu, rcu_nocb_mask);
+		} else {
+			pr_info("NOCB: Can't CB-offload an offline CPU\n");
+			ret = -EINVAL;
+		}
 	}
 	cpus_read_unlock();
 	mutex_unlock(&rcu_state.barrier_mutex);
-- 
2.9.5

