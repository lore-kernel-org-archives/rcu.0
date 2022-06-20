Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34107C433EF
	for <rcu@archiver.kernel.org>; Mon, 20 Jun 2022 22:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbiFTWyU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jun 2022 18:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344307AbiFTWyQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975A017AB9;
        Mon, 20 Jun 2022 15:54:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0064E61355;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B4DC3411C;
        Mon, 20 Jun 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765653;
        bh=Ji7AQWLAUpW4HujcLsP8xHsp0+JWjwKFOhyckCQOuuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWHWd+kWYyufpE6/c6AYVFH0ttZw8N9NNF+gjw1fnGk+F2ZQ8I4zkkGAUrI8Bh/zG
         qE2Yyg4+OF9j5xBNGfVKv16dulZPA2Bhh1Pn84nsQSAJdcjc4LVBkXD2Rf3mtNfemP
         F88co98csxSIWcBDYpGb+lFmOb5ovZOhvMxDxUpw0/s9aPZxyGVIVHEE22ti04TBLZ
         4HKJKk8klF8pUiG86cjLjhcl+4mYFUoq57Gs271HDq5k/N8Pa9x6tagHksVLWoyQ2I
         jj3NBGmX33tCZd7y2TBe3jbs/ltGAcVJD2OiCcpxRCzWBmWohBoWQtmgk5S4bEd57G
         aj2Hix6Mkcx9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2BA295C0A15; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/32] rcu-tasks: Move synchronize_rcu_tasks_generic() down
Date:   Mon, 20 Jun 2022 15:53:42 -0700
Message-Id: <20220620225411.3842519-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is strictly a code-motion commit that moves the
synchronize_rcu_tasks_generic() down to where it can invoke
rcu_tasks_one_gp() without the need for a forward declaration.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d7b12f524e81c..ad993c4ed924f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -326,17 +326,6 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 		irq_work_queue(&rtpcp->rtp_irq_work);
 }
 
-// Wait for a grace period for the specified flavor of Tasks RCU.
-static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
-{
-	/* Complain if the scheduler has not started.  */
-	RCU_LOCKDEP_WARN(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
-			 "synchronize_rcu_tasks called too soon");
-
-	/* Wait for the grace period. */
-	wait_rcu_gp(rtp->call_func);
-}
-
 // RCU callback function for rcu_barrier_tasks_generic().
 static void rcu_barrier_tasks_generic_cb(struct rcu_head *rhp)
 {
@@ -558,6 +547,17 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	}
 }
 
+// Wait for a grace period for the specified flavor of Tasks RCU.
+static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
+{
+	/* Complain if the scheduler has not started.  */
+	RCU_LOCKDEP_WARN(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
+			 "synchronize_rcu_tasks called too soon");
+
+	/* Wait for the grace period. */
+	wait_rcu_gp(rtp->call_func);
+}
+
 /* Spawn RCU-tasks grace-period kthread. */
 static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
 {
-- 
2.31.1.189.g2e36527f23

