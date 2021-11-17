Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF55C433F5
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 15:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038E660EE4
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 15:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbhKQP7x (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238836AbhKQP7w (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 10:59:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C72A360EE4;
        Wed, 17 Nov 2021 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637164613;
        bh=7ewpNnh/3IQEiTEnxe1PLjl/G76/xv32y7m+ACP7XLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NX0kTcrpWzTlLAax3dLBHcRxF2zximqx8s6l00ez7i6Tye2GyhCO8axdnOqqzQRSl
         1X54YzipMUkkQ5+kEfMtMGp6LoIEwgwBvQ5TGxwTt5ppSLrUKbjhFOuZTAJo1o4RXZ
         KhD7rKSTKRuH+xPJRlthcJYW6lf8uSgaWwPCYYgIJMeoMgaONvFO1eDD3/JOHutrCU
         rYDTdW/O7V0ZnuF3ARhQccwxcpGGvdC59eHCKpwfhjLGn1M9O0gZ4gJFm2AKZfV7y6
         2vIiLb//3qqR6ZBHIJDn0d70pFTY4C3kHJ/otMgdY3SlbCCpouz3EaQCZTUTU52sC2
         CkYRFL5JQzepw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 4/6] rcu/nocb: Create nocb kthreads on all CPUs as long as the "rcu_nocb=" is passed
Date:   Wed, 17 Nov 2021 16:56:35 +0100
Message-Id: <20211117155637.363706-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117155637.363706-1-frederic@kernel.org>
References: <20211117155637.363706-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In order to be able to (de-)offload any CPU using cpuset in the future,
create a NOCB kthread for all possible CPUs. For now this is done only
as long as the "rcu_nocb=" kernel parameter is passed to avoid
the unnecessary overhead for most users.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 9fe4be10fde7..1871f15b8472 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1221,11 +1221,8 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
 	struct rcu_data *rdp_gp;
 	struct task_struct *t;
 
-	/*
-	 * If this isn't a no-CBs CPU or if it already has an rcuo kthread,
-	 * then nothing to do.
-	 */
-	if (!rcu_is_nocb_cpu(cpu) || rdp->nocb_cb_kthread)
+	/* If it already has an rcuo kthread, then nothing to do. */
+	if (rdp->nocb_cb_kthread)
 		return;
 
 	/* If we didn't spawn the GP kthread first, reorganize! */
@@ -1253,7 +1250,7 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
  */
 static void rcu_spawn_cpu_nocb_kthread(int cpu)
 {
-	if (rcu_scheduler_fully_active)
+	if (rcu_scheduler_fully_active && rcu_nocb_is_setup)
 		rcu_spawn_one_nocb_kthread(cpu);
 }
 
@@ -1268,7 +1265,7 @@ static void __init rcu_spawn_nocb_kthreads(void)
 	int cpu;
 
 	if (rcu_nocb_is_setup) {
-		for_each_online_cpu(cpu)
+		for_each_possible_cpu(cpu)
 			rcu_spawn_cpu_nocb_kthread(cpu);
 	}
 }
@@ -1303,7 +1300,7 @@ static void __init rcu_organize_nocb_kthreads(void)
 	 * Should the corresponding CPU come online in the future, then
 	 * we will spawn the needed set of rcu_nocb_kthread() kthreads.
 	 */
-	for_each_cpu(cpu, rcu_nocb_mask) {
+	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rdp->cpu >= nl) {
 			/* New GP kthread, set up for CBs & next GP. */
@@ -1327,7 +1324,8 @@ static void __init rcu_organize_nocb_kthreads(void)
 				pr_cont(" %d", cpu);
 		}
 		rdp->nocb_gp_rdp = rdp_gp;
-		list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
+		if (cpumask_test_cpu(cpu, rcu_nocb_mask))
+			list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
 	}
 	if (gotnocbs && dump_tree)
 		pr_cont("%s\n", gotnocbscbs ? "" : " (self only)");
-- 
2.25.1

