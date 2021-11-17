Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C552EC433F5
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 15:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9EB160EE4
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 15:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbhKQQAA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 11:00:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238883AbhKQP74 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 10:59:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66CA360EE4;
        Wed, 17 Nov 2021 15:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637164618;
        bh=UnQvcvpPch96ILO10ZHnFKIO+yVSOutunoWjIkOFA1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rPvqisjuThazQPe7EUG2iNiuD5783uw0xMpJRJLzkvdPJWuDv+Xmrysyaj7ZNQcUo
         FBbeirrADbEWeVWr35Z3FUKW3T7kSPYtuppqKs4dX1T46KId1G/lybhjp7M4KsfnnS
         a0oHKf7pncos/p2GtoZ2amtsl/6DiX8deKFA2TeTOeUWnt6fvozi4r4vQUdqwtf5M8
         hlkFoQSsQeQStaJMFoY1UOyh4+F/Z2D1F/NdALYWeM+jtyvvbP8FcOsfuV0OiT7OmV
         8dyu7H23fbmuGyj5HjDLn1wUmophLQEazmrvAV/Ax0cIZlkew3uSSCN9XE2K6UzCww
         0Vrk18N7Goe6A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 6/6] rcu/nocb: Merge rcu_spawn_cpu_nocb_kthread() and rcu_spawn_one_nocb_kthread()
Date:   Wed, 17 Nov 2021 16:56:37 +0100
Message-Id: <20211117155637.363706-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117155637.363706-1-frederic@kernel.org>
References: <20211117155637.363706-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcu_spawn_one_nocb_kthread() is only called by
rcu_spawn_cpu_nocb_kthread(). Don't bother with two separate functions
and merge them.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 3845f1885ffc..248b90333b08 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1217,12 +1217,15 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
  * rcuo CB kthread, spawn it.  Additionally, if the rcuo GP kthread
  * for this CPU's group has not yet been created, spawn it as well.
  */
-static void rcu_spawn_one_nocb_kthread(int cpu)
+static void rcu_spawn_cpu_nocb_kthread(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_data *rdp_gp;
 	struct task_struct *t;
 
+	if (!rcu_scheduler_fully_active || !rcu_nocb_is_setup)
+		return;
+
 	/* If it already has an rcuo kthread, then nothing to do. */
 	if (rdp->nocb_cb_kthread)
 		return;
@@ -1246,16 +1249,6 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
 }
 
-/*
- * If the specified CPU is a no-CBs CPU that does not already have its
- * rcuo kthread, spawn it.
- */
-static void rcu_spawn_cpu_nocb_kthread(int cpu)
-{
-	if (rcu_scheduler_fully_active && rcu_nocb_is_setup)
-		rcu_spawn_one_nocb_kthread(cpu);
-}
-
 /*
  * Once the scheduler is running, spawn rcuo kthreads for all online
  * no-CBs CPUs.  This assumes that the early_initcall()s happen before
-- 
2.25.1

