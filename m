Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A94EC4742C
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB0020719
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617814;
	bh=93t775pWhXjDlj+6vsCO+3xOfD10h30J3VqMFARVeL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A1YdrpIc5JqlXblKWUu4ipv7lzXYh7JyVZd6q4Q07SMsURYTcJnv21hXqB5bhbayj
	 vIkQXGfP9Na88hGq56n2ms2h38Gcpho3FP761TW9jTZoAXBfRJ8PVGYLeGRjgHWVIv
	 aTKGC7UhGtEr9UWq3Nt/5NvtnseKWp1NaTAKprR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbgKEXKK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:10:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732506AbgKEXJ0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:26 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 859A6221F8;
        Thu,  5 Nov 2020 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617765;
        bh=93t775pWhXjDlj+6vsCO+3xOfD10h30J3VqMFARVeL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sg06LzsRAxEf/kZi6LiP2QspRVF53GbiU40byAln/+25Lq7mPeCsyY99BCc59pfxE
         TADtF0of+JdpzgCpYUr6/M26SmT1rpFz2OHyqJDOw/ORoKTjunZo/iRoS/WuHGs8n1
         GuliPt0nXndn90xu3+M1tYaWBJPhE4PABRm3EGTk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/16] rcu: Implement rcu_segcblist_is_offloaded() config dependent
Date:   Thu,  5 Nov 2020 15:09:10 -0800
Message-Id: <20201105230921.19017-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

This commit simplifies the use of the rcu_segcblist_is_offloaded() API so
that its callers no longer need to check the RCU_NOCB_CPU Kconfig option.
Note that rcu_segcblist_is_offloaded() is defined in the header file,
which means that the generated code should be just as efficient as before.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.h |  2 +-
 kernel/rcu/tree.c          | 21 +++++++--------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 5c293af..492262b 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -62,7 +62,7 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 /* Is the specified rcu_segcblist offloaded?  */
 static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 {
-	return rsclp->offloaded;
+	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) && rsclp->offloaded;
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 06895ef..dc1e578 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1603,8 +1603,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	bool ret = false;
 	bool need_qs;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -2048,8 +2047,7 @@ static void rcu_gp_cleanup(void)
 		needgp = true;
 	}
 	/* Advance CBs to reduce false positives below. */
-	offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-		    rcu_segcblist_is_offloaded(&rdp->cblist);
+	offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
 		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
@@ -2248,8 +2246,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	unsigned long flags;
 	unsigned long mask;
 	bool needwake = false;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2417,8 +2414,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 {
 	int div;
 	unsigned long flags;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count;
@@ -2675,8 +2671,7 @@ static __latent_entropy void rcu_core(void)
 	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 
 	if (cpu_is_offline(smp_processor_id()))
 		return;
@@ -2978,8 +2973,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
 	/* Go handle any RCU core processing required. */
-	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
+	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
 	} else {
 		__call_rcu_core(rdp, head, flags);
@@ -3712,8 +3706,7 @@ static int rcu_pending(int user)
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
 	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
-	    (!IS_ENABLED(CONFIG_RCU_NOCB_CPU) ||
-	     !rcu_segcblist_is_offloaded(&rdp->cblist)) &&
+	    !rcu_segcblist_is_offloaded(&rdp->cblist) &&
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 		return 1;
 
-- 
2.9.5

