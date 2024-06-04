Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8014B94E;
	Tue,  4 Jun 2024 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540107; cv=none; b=Ndvi298J72lbet8HTlLo97BZg1JsD40l6QBNbA3Bhv1WM5cAdGfMbInaXBxbqiGlvi92vypkqMjKplOTN7wr0tqwfIDeXAX3vDFcSJ9rAkMTy4Jr2/RqJMcZfZnWY79Wv6p5ZHDgSaIszH24dQokzCkf2BR95BHPGouaKE9Wwuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540107; c=relaxed/simple;
	bh=hIatMNNer9qEGPpFzy2C+6DmZvWCa0X8jHOsNHjnQAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eD6BIqWb+TgnPbIeLEJFfODuYCy1uN/4RJeXGQ9Z83XceuqzpLZ4hdKggnGnQQB7ZsveT9O1YrGs/zeSIKJRTuPdVWJiFp1N5dOA02lgBoxVJRFuW/i+66Rl+3GH6fQvSHjUejzqKTlQpRJU4IXGwInx33k11emB5HdrtOGMfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/eD6Svy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/eD6Svy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0A9C2BBFC;
	Tue,  4 Jun 2024 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540107;
	bh=hIatMNNer9qEGPpFzy2C+6DmZvWCa0X8jHOsNHjnQAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/eD6SvymUlpjhtDXVVQuVOY6vbgePhoZkRTXT1L851UJrX8aieIPci0eCfgRB/Hg
	 pPl//YuzZ6/9ESJ/uOuU7KSsvV2YQzUDSO4v6jmc1GR36TY0CeRRYM8wkwqFyu1qOO
	 vYx+bZ9xOP4QABDuCcNSFe7CdH4a0vrJYdhne06F6Q9kybf9IFNp4pCvYNKyn++3eC
	 TxYrrQ+5hG2NBY6ulN3aF9sViudbBgqDhzejCDj7JSqwicHYSqX11CeVykTNcgKU4B
	 KPgbaL4vdh6kRuovvaUIM3DRAuWpPLnmU6ZLqyJv8cDe3E5tBYBVeWll2JRU/o5Ka7
	 6rlzlGIatimoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C6632CE3F26; Tue,  4 Jun 2024 15:28:26 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/4] rcu/nocb: Use kthread parking instead of ad-hoc implementation
Date: Tue,  4 Jun 2024 15:28:24 -0700
Message-Id: <20240604222825.2371133-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <f750378b-1eaf-4d22-80c3-a6a086c79702@paulmck-laptop>
References: <f750378b-1eaf-4d22-80c3-a6a086c79702@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

Upon NOCB deoffloading, the rcuo kthread must be forced to sleep
until the corresponding rdp is ever offloaded again. The deoffloader
clears the SEGCBLIST_OFFLOADED flag, wakes up the rcuo kthread which
then notices that change and clears in turn its SEGCBLIST_KTHREAD_CB
flag before going to sleep, until it ever sees the SEGCBLIST_OFFLOADED
flag again, should a re-offloading happen.

Upon NOCB offloading, the rcuo kthread must be forced to wake up and
handle callbacks until the corresponding rdp is ever deoffloaded again.
The offloader sets the SEGCBLIST_OFFLOADED flag, wakes up the rcuo
kthread which then notices that change and sets in turn its
SEGCBLIST_KTHREAD_CB flag before going to check callbacks, until it
ever sees the SEGCBLIST_OFFLOADED flag cleared again, should a
de-offloading happen again.

This is all a crude ad-hoc and error-prone kthread (un-)parking
re-implementation.

Consolidate the behaviour with the appropriate API instead.

[ paulmck: Apply Qiang Zhang feedback provided in Link: below. ]
Link: https://lore.kernel.org/all/20240509074046.15629-1-qiang.zhang1211@gmail.com/

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcu_segcblist.h |  81 +++++++++++-------------
 kernel/rcu/tree_nocb.h        | 115 ++++++++++------------------------
 kernel/rcu/tree_plugin.h      |   4 +-
 3 files changed, 72 insertions(+), 128 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 8018045989af9..ba95c06675e11 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -84,31 +84,31 @@ struct rcu_cblist {
  *  ----------------------------------------------------------------------------
  *                                         |
  *                                         v
- *                        -----------------------------------
- *                        |                                 |
- *                        v                                 v
- *  ---------------------------------------  ----------------------------------|
- *  |        SEGCBLIST_RCU_CORE   |       |  |     SEGCBLIST_RCU_CORE   |      |
- *  |        SEGCBLIST_LOCKING    |       |  |     SEGCBLIST_LOCKING    |      |
- *  |        SEGCBLIST_OFFLOADED  |       |  |     SEGCBLIST_OFFLOADED  |      |
- *  |        SEGCBLIST_KTHREAD_CB         |  |     SEGCBLIST_KTHREAD_GP        |
- *  |                                     |  |                                 |
- *  |                                     |  |                                 |
- *  | CB kthread woke up and              |  | GP kthread woke up and          |
- *  | acknowledged SEGCBLIST_OFFLOADED.   |  | acknowledged SEGCBLIST_OFFLOADED|
- *  | Processes callbacks concurrently    |  |                                 |
- *  | with rcu_core(), holding            |  |                                 |
- *  | nocb_lock.                          |  |                                 |
- *  ---------------------------------------  -----------------------------------
- *                        |                                 |
- *                        -----------------------------------
+ *  ----------------------------------------------------------------------------
+ *  |        SEGCBLIST_RCU_CORE | SEGCBLIST_LOCKING | SEGCBLIST_OFFLOADED      |
+ *  |                              + unparked CB kthread                       |
+ *  |                                                                          |
+ *  | CB kthread got unparked and processes callbacks concurrently with        |
+ *  | rcu_core(), holding nocb_lock.                                           |
+ *  ---------------------------------------------------------------------------
+ *                                         |
+ *                                         v
+ *  ---------------------------------------------------------------------------|
+ *  |                           SEGCBLIST_RCU_CORE |                           |
+ *  |                           SEGCBLIST_LOCKING |                            |
+ *  |                           SEGCBLIST_OFFLOADED |                          |
+ *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                           + unparked CB kthread                          |
+ *  |                                                                          |
+ *  | GP kthread woke up and acknowledged nocb_lock.                           |
+ *  ---------------------------------------- -----------------------------------
  *                                         |
  *                                         v
  *  |--------------------------------------------------------------------------|
- *  |                           SEGCBLIST_LOCKING    |                         |
- *  |                           SEGCBLIST_OFFLOADED  |                         |
+ *  |                           SEGCBLIST_LOCKING |                            |
+ *  |                           SEGCBLIST_OFFLOADED |                          |
  *  |                           SEGCBLIST_KTHREAD_GP |                         |
- *  |                           SEGCBLIST_KTHREAD_CB                           |
+ *  |                           + unparked CB kthread                          |
  *  |                                                                          |
  *  |   Kthreads handle callbacks holding nocb_lock, local rcu_core() stops    |
  *  |   handling callbacks. Enable bypass queueing.                            |
@@ -124,8 +124,8 @@ struct rcu_cblist {
  *  |--------------------------------------------------------------------------|
  *  |                           SEGCBLIST_LOCKING    |                         |
  *  |                           SEGCBLIST_OFFLOADED  |                         |
- *  |                           SEGCBLIST_KTHREAD_CB |                         |
  *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                           + unparked CB kthread                          |
  *  |                                                                          |
  *  |   CB/GP kthreads handle callbacks holding nocb_lock, local rcu_core()    |
  *  |   ignores callbacks. Bypass enqueue is enabled.                          |
@@ -136,8 +136,8 @@ struct rcu_cblist {
  *  |                           SEGCBLIST_RCU_CORE   |                         |
  *  |                           SEGCBLIST_LOCKING    |                         |
  *  |                           SEGCBLIST_OFFLOADED  |                         |
- *  |                           SEGCBLIST_KTHREAD_CB |                         |
  *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                           + unparked CB kthread                          |
  *  |                                                                          |
  *  |   CB/GP kthreads handle callbacks holding nocb_lock, local rcu_core()    |
  *  |   handles callbacks concurrently. Bypass enqueue is disabled.            |
@@ -149,40 +149,31 @@ struct rcu_cblist {
  *  |--------------------------------------------------------------------------|
  *  |                           SEGCBLIST_RCU_CORE   |                         |
  *  |                           SEGCBLIST_LOCKING    |                         |
- *  |                           SEGCBLIST_KTHREAD_CB |                         |
  *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                           + unparked CB kthread                          |
  *  |                                                                          |
  *  |   CB/GP kthreads and local rcu_core() handle callbacks concurrently      |
- *  |   holding nocb_lock. Wake up CB and GP kthreads if necessary.            |
+ *  |   holding nocb_lock. Wake up GP kthread if necessary.                    |
  *  ----------------------------------------------------------------------------
  *                                      |
  *                                      v
- *                     -----------------------------------
- *                     |                                 |
- *                     v                                 v
- *  ---------------------------------------------------------------------------|
- *  |                                     |                                    |
- *  |        SEGCBLIST_RCU_CORE |         |       SEGCBLIST_RCU_CORE |         |
- *  |        SEGCBLIST_LOCKING  |         |       SEGCBLIST_LOCKING  |         |
- *  |        SEGCBLIST_KTHREAD_CB         |       SEGCBLIST_KTHREAD_GP         |
- *  |                                     |                                    |
- *  | GP kthread woke up and              |   CB kthread woke up and           |
- *  | acknowledged the fact that          |   acknowledged the fact that       |
- *  | SEGCBLIST_OFFLOADED got cleared.    |   SEGCBLIST_OFFLOADED got cleared. |
- *  |                                     |   The CB kthread goes to sleep     |
- *  | The callbacks from the target CPU   |   until it ever gets re-offloaded. |
- *  | will be ignored from the GP kthread |                                    |
- *  | loop.                               |                                    |
+ *  |--------------------------------------------------------------------------|
+ *  |                           SEGCBLIST_RCU_CORE   |                         |
+ *  |                           SEGCBLIST_LOCKING    |                         |
+ *  |                           + unparked CB kthread                          |
+ *  |                                                                          |
+ *  |   GP kthread woke up and acknowledged the fact that SEGCBLIST_OFFLOADED  |
+ *  |   got cleared. The callbacks from the target CPU will be ignored from the|
+ *  |   GP kthread loop.                                                       |
  *  ----------------------------------------------------------------------------
- *                      |                                 |
- *                      -----------------------------------
  *                                      |
  *                                      v
  *  ----------------------------------------------------------------------------
  *  |                SEGCBLIST_RCU_CORE | SEGCBLIST_LOCKING                    |
+ *  |                          + parked CB kthread                             |
  *  |                                                                          |
- *  | Callbacks processed by rcu_core() from softirqs or local                 |
- *  | rcuc kthread, while holding nocb_lock.                                   |
+ *  | CB kthread is parked. Callbacks processed by rcu_core() from softirqs or |
+ *  | local rcuc kthread, while holding nocb_lock.                             |
  *  ----------------------------------------------------------------------------
  *                                      |
  *                                      v
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 3f85577bddd4e..808c9a19fe1d0 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -635,8 +635,7 @@ static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
 	}
 }
 
-static int nocb_gp_toggle_rdp(struct rcu_data *rdp,
-			       bool *wake_state)
+static int nocb_gp_toggle_rdp(struct rcu_data *rdp)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
@@ -650,8 +649,6 @@ static int nocb_gp_toggle_rdp(struct rcu_data *rdp,
 		 * We will handle this rdp until it ever gets de-offloaded.
 		 */
 		rcu_segcblist_set_flags(cblist, SEGCBLIST_KTHREAD_GP);
-		if (rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
-			*wake_state = true;
 		ret = 1;
 	} else if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED) &&
 		   rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP)) {
@@ -660,8 +657,6 @@ static int nocb_gp_toggle_rdp(struct rcu_data *rdp,
 		 * We will ignore this rdp until it ever gets re-offloaded.
 		 */
 		rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);
-		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
-			*wake_state = true;
 		ret = 0;
 	} else {
 		WARN_ON_ONCE(1);
@@ -877,16 +872,15 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	}
 
 	if (rdp_toggling) {
-		bool wake_state = false;
 		int ret;
 
-		ret = nocb_gp_toggle_rdp(rdp_toggling, &wake_state);
+		ret = nocb_gp_toggle_rdp(rdp_toggling);
 		if (ret == 1)
 			list_add_tail(&rdp_toggling->nocb_entry_rdp, &my_rdp->nocb_head_rdp);
 		else if (ret == 0)
 			list_del(&rdp_toggling->nocb_entry_rdp);
-		if (wake_state)
-			swake_up_one(&rdp_toggling->nocb_state_wq);
+
+		swake_up_one(&rdp_toggling->nocb_state_wq);
 	}
 
 	my_rdp->nocb_gp_seq = -1;
@@ -913,16 +907,9 @@ static int rcu_nocb_gp_kthread(void *arg)
 	return 0;
 }
 
-static inline bool nocb_cb_can_run(struct rcu_data *rdp)
-{
-	u8 flags = SEGCBLIST_OFFLOADED | SEGCBLIST_KTHREAD_CB;
-
-	return rcu_segcblist_test_flags(&rdp->cblist, flags);
-}
-
 static inline bool nocb_cb_wait_cond(struct rcu_data *rdp)
 {
-	return nocb_cb_can_run(rdp) && !READ_ONCE(rdp->nocb_cb_sleep);
+	return !READ_ONCE(rdp->nocb_cb_sleep) || kthread_should_park();
 }
 
 /*
@@ -934,21 +921,19 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long cur_gp_seq;
 	unsigned long flags;
-	bool needwake_state = false;
 	bool needwake_gp = false;
-	bool can_sleep = true;
 	struct rcu_node *rnp = rdp->mynode;
 
-	do {
-		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
-						    nocb_cb_wait_cond(rdp));
-
-		if (READ_ONCE(rdp->nocb_cb_sleep)) {
-			WARN_ON(signal_pending(current));
-			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
-		}
-	} while (!nocb_cb_can_run(rdp));
+	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
+					    nocb_cb_wait_cond(rdp));
+	if (kthread_should_park()) {
+		kthread_parkme();
+	} else if (READ_ONCE(rdp->nocb_cb_sleep)) {
+		WARN_ON(signal_pending(current));
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
+	}
 
+	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
 
 	local_irq_save(flags);
 	rcu_momentary_dyntick_idle();
@@ -971,37 +956,16 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 	}
 
-	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
-		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB)) {
-			rcu_segcblist_set_flags(cblist, SEGCBLIST_KTHREAD_CB);
-			if (rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP))
-				needwake_state = true;
-		}
-		if (rcu_segcblist_ready_cbs(cblist))
-			can_sleep = false;
+	if (!rcu_segcblist_ready_cbs(cblist)) {
+		WRITE_ONCE(rdp->nocb_cb_sleep, true);
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
 	} else {
-		/*
-		 * De-offloading. Clear our flag and notify the de-offload worker.
-		 * We won't touch the callbacks and keep sleeping until we ever
-		 * get re-offloaded.
-		 */
-		WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
-		rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_CB);
-		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP))
-			needwake_state = true;
+		WRITE_ONCE(rdp->nocb_cb_sleep, false);
 	}
 
-	WRITE_ONCE(rdp->nocb_cb_sleep, can_sleep);
-
-	if (rdp->nocb_cb_sleep)
-		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
-
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 	if (needwake_gp)
 		rcu_gp_kthread_wake();
-
-	if (needwake_state)
-		swake_up_one(&rdp->nocb_state_wq);
 }
 
 /*
@@ -1094,17 +1058,8 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
 	bool wake_gp = false;
 
 	rcu_segcblist_offload(cblist, offload);
-
-	if (rdp->nocb_cb_sleep)
-		rdp->nocb_cb_sleep = false;
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
-	/*
-	 * Ignore former value of nocb_cb_sleep and force wake up as it could
-	 * have been spuriously set to false already.
-	 */
-	swake_up_one(&rdp->nocb_cb_wq);
-
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 	// Queue this rdp for add/del to/from the list to iterate on rcuog
 	WRITE_ONCE(rdp_gp->nocb_toggling_rdp, rdp);
@@ -1161,19 +1116,11 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 		if (wake_gp)
 			wake_up_process(rdp_gp->nocb_gp_kthread);
 
-		/*
-		 * If rcuo[p] kthread spawn failed, directly remove SEGCBLIST_KTHREAD_CB.
-		 * Just wait SEGCBLIST_KTHREAD_GP to be cleared by rcuog.
-		 */
-		if (!rdp->nocb_cb_kthread) {
-			rcu_nocb_lock_irqsave(rdp, flags);
-			rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
-			rcu_nocb_unlock_irqrestore(rdp, flags);
-		}
-
 		swait_event_exclusive(rdp->nocb_state_wq,
-					!rcu_segcblist_test_flags(cblist,
-					  SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP));
+				      !rcu_segcblist_test_flags(cblist,
+								SEGCBLIST_KTHREAD_GP));
+		if (rdp->nocb_cb_kthread)
+			kthread_park(rdp->nocb_cb_kthread);
 	} else {
 		/*
 		 * No kthread to clear the flags for us or remove the rdp from the nocb list
@@ -1181,8 +1128,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 		 * but we stick to paranoia in this rare path.
 		 */
 		rcu_nocb_lock_irqsave(rdp, flags);
-		rcu_segcblist_clear_flags(&rdp->cblist,
-				SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
+		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 
 		list_del(&rdp->nocb_entry_rdp);
@@ -1282,8 +1228,10 @@ static long rcu_nocb_rdp_offload(void *arg)
 	wake_gp = rdp_offload_toggle(rdp, true, flags);
 	if (wake_gp)
 		wake_up_process(rdp_gp->nocb_gp_kthread);
+
+	kthread_unpark(rdp->nocb_cb_kthread);
+
 	swait_event_exclusive(rdp->nocb_state_wq,
-			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
 
 	/*
@@ -1468,7 +1416,7 @@ void __init rcu_init_nohz(void)
 		if (rcu_segcblist_empty(&rdp->cblist))
 			rcu_segcblist_init(&rdp->cblist);
 		rcu_segcblist_offload(&rdp->cblist, true);
-		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
+		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
 		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_RCU_CORE);
 	}
 	rcu_organize_nocb_kthreads();
@@ -1526,11 +1474,16 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
 
 	/* Spawn the kthread for this CPU. */
-	t = kthread_run(rcu_nocb_cb_kthread, rdp,
-			"rcuo%c/%d", rcu_state.abbr, cpu);
+	t = kthread_create(rcu_nocb_cb_kthread, rdp,
+			   "rcuo%c/%d", rcu_state.abbr, cpu);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
 		goto end;
 
+	if (rcu_rdp_is_offloaded(rdp))
+		wake_up_process(t);
+	else
+		kthread_park(t);
+
 	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_CB_BOOST) && kthread_prio)
 		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 340bbefe5f652..1facbb365dc22 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -28,8 +28,8 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
 		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
 		  rcu_lockdep_is_held_nocb(rdp) ||
-		  (rdp == this_cpu_ptr(&rcu_data) &&
-		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
+		  (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
+		   rdp == this_cpu_ptr(&rcu_data)) ||
 		  rcu_current_is_nocb_kthread(rdp)),
 		"Unsafe read of RCU_NOCB offloaded state"
 	);
-- 
2.40.1

