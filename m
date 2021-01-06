Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2B4C4332E
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C232221EA
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbhAFRRz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:17:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbhAFRRy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:17:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE4A723137;
        Wed,  6 Jan 2021 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953433;
        bh=dJKB1Seld/aPWAIbVyEarvxi8yJh2NGngiS29t6dWN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bwmRuq57zaBJOcQUf+dPZJ3e+bvw153GpMQoZFFkm2P2jddVHhTDJqGYImdyuVf9y
         CBJ/Zt/yztzYQdyqinYN7R223bvMqZvUaKbmDYKiYxzsY5ynEbK3UeU7HUGJ/peAr1
         7YxM+z0k3LZumZELQ5id5T7jSrAh6BbYdmBNoWiXvQ8y6t56Bn5PiUcHvQ7rUFz7O0
         zAR3rBY+xVia4JIRuyiL22k/VMj1zjaavIzqyH9z9lpCywVdfuEmYWSvcllF5T4y/4
         L+7P6EyyMh+33V66gfP4wIDNvdBxMlYbtFKh+/4c8NwbSI/7Ok6xm1D2+TQ90H6FiT
         2BqIc0Iuuu3uQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/17] rcutorture: Make synctype[] and nsynctype be static global
Date:   Wed,  6 Jan 2021 09:16:58 -0800
Message-Id: <20210106171710.22239-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Full testing of the new SRCU polling API requires that the fake writers
also use it in order to test concurrent calls to all of the API members,
especially start_poll_synchronize_srcu().  This commit prepares the ground
for this by making the synctype[] and nsynctype variables be static
globals so that the rcu_torture_fakewriter() function can access them.
Initialization of these variables is moved from rcu_torture_writer()
to a new rcu_torture_write_types() function that is invoked from
rcu_torture_init() just before the first writer kthread is spawned.

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 62 ++++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1930d92..ea44a2b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1062,37 +1062,18 @@ rcu_torture_fqs(void *arg)
 	return 0;
 }
 
+// Used by writers to randomly choose from the available grace-period
+// primitives.  The only purpose of the initialization is to size the array.
+static int synctype[] = { RTWS_DEF_FREE, RTWS_EXP_SYNC, RTWS_COND_GET, RTWS_POLL_GET, RTWS_SYNC };
+static int nsynctypes = 0;
+
 /*
- * RCU torture writer kthread.  Repeatedly substitutes a new structure
- * for that pointed to by rcu_torture_current, freeing the old structure
- * after a series of grace periods (the "pipeline").
+ * Determine which grace-period primitives are available.
  */
-static int
-rcu_torture_writer(void *arg)
+static void rcu_torture_write_types(void)
 {
-	bool boot_ended;
-	bool can_expedite = !rcu_gp_is_expedited() && !rcu_gp_is_normal();
-	unsigned long cookie;
-	int expediting = 0;
-	unsigned long gp_snap;
 	bool gp_cond1 = gp_cond, gp_exp1 = gp_exp, gp_normal1 = gp_normal;
 	bool gp_poll1 = gp_poll, gp_sync1 = gp_sync;
-	int i;
-	int idx;
-	int oldnice = task_nice(current);
-	struct rcu_torture *rp;
-	struct rcu_torture *old_rp;
-	static DEFINE_TORTURE_RANDOM(rand);
-	bool stutter_waited;
-	int synctype[] = { RTWS_DEF_FREE, RTWS_EXP_SYNC,
-			   RTWS_COND_GET, RTWS_POLL_GET, RTWS_SYNC };
-	int nsynctypes = 0;
-
-	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
-	if (!can_expedite)
-		pr_alert("%s" TORTURE_FLAG
-			 " GP expediting controlled from boot/sysfs for %s.\n",
-			 torture_type, cur_ops->name);
 
 	/* Initialize synctype[] array.  If none set, take default. */
 	if (!gp_cond1 && !gp_exp1 && !gp_normal1 && !gp_poll1 && !gp_sync1)
@@ -1127,6 +1108,34 @@ rcu_torture_writer(void *arg)
 	} else if (gp_sync && !cur_ops->sync) {
 		pr_alert("%s: gp_sync without primitives.\n", __func__);
 	}
+}
+
+/*
+ * RCU torture writer kthread.  Repeatedly substitutes a new structure
+ * for that pointed to by rcu_torture_current, freeing the old structure
+ * after a series of grace periods (the "pipeline").
+ */
+static int
+rcu_torture_writer(void *arg)
+{
+	bool boot_ended;
+	bool can_expedite = !rcu_gp_is_expedited() && !rcu_gp_is_normal();
+	unsigned long cookie;
+	int expediting = 0;
+	unsigned long gp_snap;
+	int i;
+	int idx;
+	int oldnice = task_nice(current);
+	struct rcu_torture *rp;
+	struct rcu_torture *old_rp;
+	static DEFINE_TORTURE_RANDOM(rand);
+	bool stutter_waited;
+
+	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
+	if (!can_expedite)
+		pr_alert("%s" TORTURE_FLAG
+			 " GP expediting controlled from boot/sysfs for %s.\n",
+			 torture_type, cur_ops->name);
 	if (WARN_ONCE(nsynctypes == 0,
 		      "rcu_torture_writer: No update-side primitives.\n")) {
 		/*
@@ -2889,6 +2898,7 @@ rcu_torture_init(void)
 
 	/* Start up the kthreads. */
 
+	rcu_torture_write_types();
 	firsterr = torture_create_kthread(rcu_torture_writer, NULL,
 					  writer_task);
 	if (firsterr)
-- 
2.9.5

