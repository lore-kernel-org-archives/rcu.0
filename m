Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0149FC433F5
	for <rcu@archiver.kernel.org>; Tue, 23 Nov 2021 00:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhKWAkq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:40:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232101AbhKWAkc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Nov 2021 19:40:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A19D60F70;
        Tue, 23 Nov 2021 00:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637627845;
        bh=RQwilzt+jdf9Hm51kXPsmwXnDYa/Gvy9HLQhoOOpsv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXYuTcGDv3cPjS567uZkmObGG0QIVFouVLrah7PGHX9IiRKMeZTe7O6YFLQI6dv/S
         tCS4hDkMESmmHkeJ1AaFyXfxxEHXwLyxfUGn9EN4W/gkSurqIVo/B/wnuwM5DRZcd3
         AzZJHR6RnYB7luldIMGEPqCHqImAGlvPbbgXfW0b5giJVeR+DqUrlkyMogYmfsbSqQ
         jWm2UImsPnPp6n36LYYgMhqlyzKykiZ7UZ2FfbFQcvMao+qjD+mGxjoLSUS8uUXAqK
         7sKsh9sw0a0YcNNOdtRUZOyOlYKVn7wwQpmlibEhOG3RgvMWUn0WorbGtM3ih8Q9wZ
         wAWwoY40yc3Iw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 4/6] rcu/nocb: Create kthreads on all CPUs if "rcu_nocb=" or "nohz_full=" are passed
Date:   Tue, 23 Nov 2021 01:37:06 +0100
Message-Id: <20211123003708.468409-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211123003708.468409-1-frederic@kernel.org>
References: <20211123003708.468409-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In order to be able to (de-)offload any CPU using cpuset in the future,
create a NOCB kthread for all possible CPUs. For now this is done only
as long as the "rcu_nocb=" or "nohz_full=" kernel parameters are passed
to avoid the unnecessary overhead for most users.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index d8ed3ee47a67..9d37916278d4 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1229,11 +1229,8 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
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
@@ -1261,7 +1258,7 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
  */
 static void rcu_spawn_cpu_nocb_kthread(int cpu)
 {
-	if (rcu_scheduler_fully_active)
+	if (rcu_scheduler_fully_active && rcu_nocb_is_setup)
 		rcu_spawn_one_nocb_kthread(cpu);
 }
 
@@ -1311,7 +1308,7 @@ static void __init rcu_organize_nocb_kthreads(void)
 	 * Should the corresponding CPU come online in the future, then
 	 * we will spawn the needed set of rcu_nocb_kthread() kthreads.
 	 */
-	for_each_cpu(cpu, rcu_nocb_mask) {
+	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rdp->cpu >= nl) {
 			/* New GP kthread, set up for CBs & next GP. */
@@ -1335,7 +1332,8 @@ static void __init rcu_organize_nocb_kthreads(void)
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

