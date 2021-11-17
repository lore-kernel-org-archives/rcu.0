Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4CAC433F5
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 15:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2DB261A52
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 15:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbhKQP7r (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:59:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238815AbhKQP7p (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 10:59:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE47961A52;
        Wed, 17 Nov 2021 15:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637164606;
        bh=yBaythZTkvWVI7GNz5Xjy9/CXzVjkVmh5zFWttXBr1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYU0FEiPIzeYx5j7AM1l0py0jcxzFDJS0qRuYn1Cgs3GFpFbaw4gvYhyuflSq8GFF
         +DmDHEhfcz6wxVnZHa9U0ghnpKxIH+TpSgPvgaj1Bd9BjJ5DKHMPcW0P16gbaaVb3C
         VnWi3Wp8/ZVcCeRt9zVfNjuBbgN/E5UycCq0177eIgpfAAqje/k3wFwIFXI+7hDkcd
         ddbhCshrxBfLn3F1kPooUgAocI9GlvjHQtuzABbFghRab2cQE579U7wA0O71Towvwp
         oFeyGi+sOMBqt1P72QOXMZFsZg4eDlCPED0VREON9COMJJt5eN2hA9kWO9xBsTRM6O
         sNTaICnvkNtNw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 1/6] rcu/nocb: Remove rdp from nocb list when de-offloaded
Date:   Wed, 17 Nov 2021 16:56:32 +0100
Message-Id: <20211117155637.363706-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117155637.363706-1-frederic@kernel.org>
References: <20211117155637.363706-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

nocb_gp_wait() iterates all CPUs within the rcuog's group even if they
are have been de-offloaded. This is suboptimal if only few CPUs are
offloaded within the group. And this will become even more a problem
when a nocb kthread will be created for all possible CPUs in the future.

Therefore use a standard double linked list to link all the offloaded
rdps and safely add/del their nodes as we (de-)offloaded them.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree.h      |  7 +++++--
 kernel/rcu/tree_nocb.h | 29 ++++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index deeaf2fee714..486fc901bd08 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -221,8 +221,11 @@ struct rcu_data {
 	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
 	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
 	struct task_struct *nocb_cb_kthread;
-	struct rcu_data *nocb_next_cb_rdp;
-					/* Next rcu_data in wakeup chain. */
+	struct list_head nocb_head_rdp; /*
+					 * Head of rcu_data list in wakeup chain,
+					 * if rdp_gp.
+					 */
+	struct list_head nocb_entry_rdp; /* rcu_data node in wakeup chain. */
 
 	/* The following fields are used by CB kthread, hence new cacheline. */
 	struct rcu_data *nocb_gp_rdp ____cacheline_internodealigned_in_smp;
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 2461fe8d0c23..e728128be02a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -625,7 +625,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 * and the global grace-period kthread are awakened if needed.
 	 */
 	WARN_ON_ONCE(my_rdp->nocb_gp_rdp != my_rdp);
-	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
+	list_for_each_entry_rcu(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp, 1) {
 		bool needwake_state = false;
 
 		if (!nocb_gp_enabled_cb(rdp))
@@ -1003,6 +1003,8 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
+	/* Don't bother iterate this one anymore on nocb_gp_wait() */
+	list_del_rcu(&rdp->nocb_entry_rdp);
 	/*
 	 * Lock one last time to acquire latest callback updates from kthreads
 	 * so we can later handle callbacks locally without locking.
@@ -1066,6 +1068,15 @@ static long rcu_nocb_rdp_offload(void *arg)
 		return -EINVAL;
 
 	pr_info("Offloading %d\n", rdp->cpu);
+
+	/*
+	 * Iterate this CPU on nocb_gp_wait(). We do it before locking nocb_gp_lock,
+	 * resetting nocb_gp_sleep and waking up the related "rcuog". Since nocb_gp_wait()
+	 * in turn locks nocb_gp_lock before setting nocb_gp_sleep again, we are guaranteed
+	 * to iterate this new rdp before "rcuog" goes to sleep again.
+	 */
+	list_add_tail_rcu(&rdp->nocb_entry_rdp, &rdp->nocb_gp_rdp->nocb_head_rdp);
+
 	/*
 	 * Can't use rcu_nocb_lock_irqsave() before SEGCBLIST_LOCKING
 	 * is set.
@@ -1268,7 +1279,6 @@ static void __init rcu_organize_nocb_kthreads(void)
 	int nl = 0;  /* Next GP kthread. */
 	struct rcu_data *rdp;
 	struct rcu_data *rdp_gp = NULL;  /* Suppress misguided gcc warn. */
-	struct rcu_data *rdp_prev = NULL;
 
 	if (!cpumask_available(rcu_nocb_mask))
 		return;
@@ -1288,8 +1298,8 @@ static void __init rcu_organize_nocb_kthreads(void)
 			/* New GP kthread, set up for CBs & next GP. */
 			gotnocbs = true;
 			nl = DIV_ROUND_UP(rdp->cpu + 1, ls) * ls;
-			rdp->nocb_gp_rdp = rdp;
 			rdp_gp = rdp;
+			INIT_LIST_HEAD(&rdp->nocb_head_rdp);
 			if (dump_tree) {
 				if (!firsttime)
 					pr_cont("%s\n", gotnocbscbs
@@ -1302,12 +1312,11 @@ static void __init rcu_organize_nocb_kthreads(void)
 		} else {
 			/* Another CB kthread, link to previous GP kthread. */
 			gotnocbscbs = true;
-			rdp->nocb_gp_rdp = rdp_gp;
-			rdp_prev->nocb_next_cb_rdp = rdp;
 			if (dump_tree)
 				pr_cont(" %d", cpu);
 		}
-		rdp_prev = rdp;
+		rdp->nocb_gp_rdp = rdp_gp;
+		list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
 	}
 	if (gotnocbs && dump_tree)
 		pr_cont("%s\n", gotnocbscbs ? "" : " (self only)");
@@ -1369,6 +1378,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 {
 	char bufw[20];
 	char bufr[20];
+	struct rcu_data *nocb_next_rdp = NULL;
 	struct rcu_segcblist *rsclp = &rdp->cblist;
 	bool waslocked;
 	bool wassleep;
@@ -1376,11 +1386,16 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 	if (rdp->nocb_gp_rdp == rdp)
 		show_rcu_nocb_gp_state(rdp);
 
+	nocb_next_rdp = list_next_or_null_rcu(&rdp->nocb_gp_rdp->nocb_head_rdp,
+					      &rdp->nocb_entry_rdp,
+					      typeof(*rdp),
+					      nocb_entry_rdp);
+
 	sprintf(bufw, "%ld", rsclp->gp_seq[RCU_WAIT_TAIL]);
 	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
 	pr_info("   CB %d^%d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
 		rdp->cpu, rdp->nocb_gp_rdp->cpu,
-		rdp->nocb_next_cb_rdp ? rdp->nocb_next_cb_rdp->cpu : -1,
+		nocb_next_rdp ? nocb_next_rdp->cpu : -1,
 		"kK"[!!rdp->nocb_cb_kthread],
 		"bB"[raw_spin_is_locked(&rdp->nocb_bypass_lock)],
 		"cC"[!!atomic_read(&rdp->nocb_lock_contended)],
-- 
2.25.1

