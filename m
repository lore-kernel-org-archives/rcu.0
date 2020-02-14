Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A77C47409
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B15206B6
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724652;
	bh=+FcCIlNfRmNqblTYA1Ebk3e6DqvVuEc4W18g2CI3txs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o8CXLM5yGJwrEOc9EMk5o2Mug5gjvdsWCKomPmjjo63lco3+Aa5delzZCgQL8UcPg
	 Sxz0XP3V/sQpo6T3yXjxAqhuLPtmKQr6v6o/eZt2JZWDZ5JghBpYmIx8o4skGOUvCE
	 6DY1h8UnDYSTKDmpipx8mSGWrSmXCne129+a4HfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgBNX5c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgBNX5b (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:31 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DFDC22314;
        Fri, 14 Feb 2020 23:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724651;
        bh=+FcCIlNfRmNqblTYA1Ebk3e6DqvVuEc4W18g2CI3txs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yErVqLqgzD2ogGuUFs8YDZVMxfO7xzByPACqlCiU98NvJTpNBrUj/DSG/cqUUOZIa
         pUDIHmE5HBgI1JruRfa+KkgKIQEQ63zMvEwn6XLvoRCQgAGXvA0wyhiB1byKIz93pe
         o0oWjo3QbzXPiTpMoom8CCl/9kM3TdDcu5zkfSbI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 22/30] rcu: Don't flag non-starting GPs before GP kthread is running
Date:   Fri, 14 Feb 2020 15:55:59 -0800
Message-Id: <20200214235607.13749-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently rcu_check_gp_start_stall() complains if a grace period takes
too long to start, where "too long" is roughly one RCU CPU stall-warning
interval.  This has worked well, but there are some debugging Kconfig
options (such as CONFIG_EFI_PGT_DUMP=y) that can make booting take a
very long time, so much so that the stall-warning interval has expired
before RCU's grace-period kthread has even been spawned.

This commit therefore resets the rcu_state.gp_req_activity and
rcu_state.gp_activity timestamps just before the grace-period kthread
is spawned, and modifies the checks and adds ordering to ensure that
if rcu_check_gp_start_stall() sees that the grace-period kthread
has been spawned, that it will also see the resets applied to the
rcu_state.gp_req_activity and rcu_state.gp_activity timestamps.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ paulmck: Fix whitespace issues reported by Qian Cai. ]
Tested-by: Qian Cai <cai@lca.pw>
---
 kernel/rcu/tree.c       | 11 +++++++----
 kernel/rcu/tree_stall.h | 11 ++++++-----
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 62383ce..5ee5657 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1202,7 +1202,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedroot"));
 	WRITE_ONCE(rcu_state.gp_flags, rcu_state.gp_flags | RCU_GP_FLAG_INIT);
 	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
-	if (!rcu_state.gp_kthread) {
+	if (!READ_ONCE(rcu_state.gp_kthread)) {
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
@@ -1252,10 +1252,10 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
  */
 static void rcu_gp_kthread_wake(void)
 {
-	if ((current == rcu_state.gp_kthread &&
+	if ((current == READ_ONCE(rcu_state.gp_kthread) &&
 	     !in_irq() && !in_serving_softirq()) ||
 	    !READ_ONCE(rcu_state.gp_flags) ||
-	    !rcu_state.gp_kthread)
+	    !READ_ONCE(rcu_state.gp_kthread))
 		return;
 	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
 	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
@@ -3554,7 +3554,10 @@ static int __init rcu_spawn_gp_kthread(void)
 	}
 	rnp = rcu_get_root();
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	rcu_state.gp_kthread = t;
+	WRITE_ONCE(rcu_state.gp_activity, jiffies);
+	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
+	// Reset .gp_activity and .gp_req_activity before setting .gp_kthread.
+	smp_store_release(&rcu_state.gp_kthread, t);  /* ^^^ */
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	wake_up_process(t);
 	rcu_spawn_nocb_kthreads();
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 56df88e..4c216f7 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -578,6 +578,7 @@ void show_rcu_gp_kthreads(void)
 	unsigned long jw;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
+	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
 
 	j = jiffies;
 	ja = j - READ_ONCE(rcu_state.gp_activity);
@@ -585,8 +586,7 @@ void show_rcu_gp_kthreads(void)
 	jw = j - READ_ONCE(rcu_state.gp_wake_time);
 	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
-		rcu_state.gp_state,
-		rcu_state.gp_kthread ? rcu_state.gp_kthread->state : 0x1ffffL,
+		rcu_state.gp_state, t ? t->state : 0x1ffffL,
 		ja, jr, jw, (long)READ_ONCE(rcu_state.gp_wake_seq),
 		(long)READ_ONCE(rcu_state.gp_seq),
 		(long)READ_ONCE(rcu_get_root()->gp_seq_needed),
@@ -633,7 +633,8 @@ static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 
 	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress() ||
 	    ULONG_CMP_GE(READ_ONCE(rnp_root->gp_seq),
-	    		 READ_ONCE(rnp_root->gp_seq_needed)))
+			 READ_ONCE(rnp_root->gp_seq_needed)) ||
+	    !smp_load_acquire(&rcu_state.gp_kthread))
 		return;
 	j = jiffies; /* Expensive access, and in common case don't get here. */
 	if (time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
@@ -645,7 +646,7 @@ static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 	j = jiffies;
 	if (rcu_gp_in_progress() ||
 	    ULONG_CMP_GE(READ_ONCE(rnp_root->gp_seq),
-	    		 READ_ONCE(rnp_root->gp_seq_needed)) ||
+			 READ_ONCE(rnp_root->gp_seq_needed)) ||
 	    time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
 	    time_before(j, READ_ONCE(rcu_state.gp_activity) + gpssdelay) ||
 	    atomic_read(&warned)) {
@@ -659,7 +660,7 @@ static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 	j = jiffies;
 	if (rcu_gp_in_progress() ||
 	    ULONG_CMP_GE(READ_ONCE(rnp_root->gp_seq),
-	    		 READ_ONCE(rnp_root->gp_seq_needed)) ||
+			 READ_ONCE(rnp_root->gp_seq_needed)) ||
 	    time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
 	    time_before(j, READ_ONCE(rcu_state.gp_activity) + gpssdelay) ||
 	    atomic_xchg(&warned, 1)) {
-- 
2.9.5

