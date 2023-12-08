Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A758ADE
	for <rcu@vger.kernel.org>; Fri,  8 Dec 2023 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi1AB688"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402D3C433C8;
	Fri,  8 Dec 2023 22:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702073155;
	bh=m4pjfWFUMrRQntPdsKm0V/mNKmveqDHFHRRYTbCkI3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yi1AB688dExVB+lGyES6dYBZycKdaNfH9mQxxVbWHG3r6+uUpAU9yspsSo31ixBEV
	 +4ERDwEsw4h6MSniMHhEw25JB2SdUs/KFltswE5fIsuVcB6YLru30dWGRoYLn8hwvv
	 sl617tcUAv0vuMIbT5GGnJnyr4T1hEnx/48QZ3aPMxjGgoU1ZdpcmBaxEpAtY6rCx2
	 fei+kMOiFFCG3xd460V4uj5HYHjnpIYlGnE8RPYFayBt+/WXN9ih3mRaJn4GtRXdbz
	 mNJBxRFEEreHngtIWcBi+fZ2FUs6WXYOBl6lfsh8TXC2Dfy3PdMJiOLtwCL09N907X
	 l66Ki9++fNI+Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 1/8] rcu/nocb: Make IRQs disablement symetric
Date: Fri,  8 Dec 2023 23:05:38 +0100
Message-ID: <20231208220545.7452-2-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231208220545.7452-1-frederic@kernel.org>
References: <20231208220545.7452-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently IRQs are disabled on call_rcu() and then depending on the
context:

* If the CPU is in nocb mode:

   - If the callback is enqueued in the bypass list, IRQs are re-enabled
     implictly by rcu_nocb_try_bypass()

   - If the callback is enqueued in the normal list, IRQs are re-enabled
     implicitly by __call_rcu_nocb_wake()

* If the CPU is NOT in nocb mode, IRQs are reenabled explicitly from call_rcu()

This makes the code a bit hard to follow, especially as it interleaves
with nocb locking.

To make the IRQ flags coverage clearer and also in order to prepare for
moving all the nocb enqueue code to its own function, always re-enable
the IRQ flags explicitly from call_rcu().

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c      |  9 ++++++---
 kernel/rcu/tree_nocb.h | 20 +++++++++-----------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 52c2fdbc6363..74159c6d3bdf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2697,8 +2697,10 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
+	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy)) {
+		local_irq_restore(flags);
 		return; // Enqueued onto ->nocb_bypass, so just leave.
+	}
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
 	if (__is_kvfree_rcu_offset((unsigned long)func))
@@ -2716,8 +2718,8 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
 	} else {
 		__call_rcu_core(rdp, head, flags);
-		local_irq_restore(flags);
 	}
+	local_irq_restore(flags);
 }
 
 #ifdef CONFIG_RCU_LAZY
@@ -4615,8 +4617,9 @@ void rcutree_migrate_callbacks(int cpu)
 		__call_rcu_nocb_wake(my_rdp, true, flags);
 	} else {
 		rcu_nocb_unlock(my_rdp); /* irqs remain disabled. */
-		raw_spin_unlock_irqrestore_rcu_node(my_rnp, flags);
+		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
 	}
+	local_irq_restore(flags);
 	if (needwake)
 		rcu_gp_kthread_wake();
 	lockdep_assert_irqs_enabled();
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 5598212d1f27..3f70fd0a2db4 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -532,9 +532,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// 2. Both of these conditions are met:
 	//    a. The bypass list previously had only lazy CBs, and:
 	//    b. The new CB is non-lazy.
-	if (ncbs && (!bypass_is_lazy || lazy)) {
-		local_irq_restore(flags);
-	} else {
+	if (!ncbs || (bypass_is_lazy && !lazy)) {
 		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
 		rcu_nocb_lock(rdp); // Rare during call_rcu() flood.
 		if (!rcu_segcblist_pend_cbs(&rdp->cblist)) {
@@ -544,7 +542,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		} else {
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstBQnoWake"));
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 		}
 	}
 	return true; // Callback already enqueued.
@@ -570,7 +568,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	// If we are being polled or there is no kthread, just leave.
 	t = READ_ONCE(rdp->nocb_gp_kthread);
 	if (rcu_nocb_poll || !t) {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		rcu_nocb_unlock(rdp);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 				    TPS("WakeNotPoll"));
 		return;
@@ -583,17 +581,17 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		rdp->qlen_last_fqs_check = len;
 		// Only lazy CBs in bypass list
 		if (lazy_len && bypass_len == lazy_len) {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
 					   TPS("WakeLazy"));
 		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			wake_nocb_gp(rdp, false);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
 		}
@@ -611,15 +609,15 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		if ((rdp->nocb_cb_sleep ||
 		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
 		    !timer_pending(&rdp->nocb_timer)) {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					   TPS("WakeOvfIsDeferred"));
 		} else {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 		}
 	} else {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		rcu_nocb_unlock(rdp);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 	}
 }
-- 
2.42.1

