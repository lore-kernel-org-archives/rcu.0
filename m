Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1986B1FA844;
	Wed, 18 Dec 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734540624; cv=none; b=cmD+kjNTzx/XGEHrwK1mb+w79hNKtHGEQMoAq6K+UXf+4/zgaJUEuDobchLAh3tebYvSDf2oS5f5dyzmQ27NY91C1olpDOLO4DDdKTOzA5+ZpIiW/zXDCBQlYoM9uoZxIa0Kmm9ojKhQQQCD+2zl+JWZkPT7HYe9x4ve7JEqi4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734540624; c=relaxed/simple;
	bh=wsSFbaS5gHpFjn7Wfsdir/WXJuDIjV9rXiSlyPWPMQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi2k/4oYrsaXDphOzvJz6x6MrYR5ABpBlqe/UWIQGhLqBq02vpb1GtuTiJiS7S/fP/628+x5rlWpTF+DV5oyG2W0CVH7970qHZ1eyNWfNj7x8FQZLLWDyV7QQZuP6out5mQP1bR0JWuAScM/PBK2EqKGBWhAs2OCwDIO9brFSaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6pUHtUW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6pUHtUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F96C4CED0;
	Wed, 18 Dec 2024 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734540623;
	bh=wsSFbaS5gHpFjn7Wfsdir/WXJuDIjV9rXiSlyPWPMQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6pUHtUWCameKpZ4NRaIU4vIuWoERimsAki4k6i1Ijt4tNNLR1XEXTcK3nnW+jyPR
	 Ye7udxzSuydTcufbCs7GvxWaYurgu14Vm1axhtrSRcu9ipj/mLNst8gdC3h+JZnDjH
	 2j7d/ZAeBGgMQ197/3FX+7m0CE4SyWbxzTHmvY+U+ao7KR7O8uBM58F6oSI+8jupeD
	 iiDXpfSQ/QGJi7hL7R1CUODvj+kY1JbCe8wll2PffppcVReMysaXOZP2i6Hrk9KMpe
	 5vH1SngktU6IlH1waUGNnG02ve428tLelPYlTatX4C9lGOpEl8C73/lbJZ8Y0uw9NI
	 PtJIBRTRJDCrg==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	vlad.wing@gmail.com,
	rcu@vger.kernel.org,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	neeraj.upadhyay@amd.com,
	urezki@gmail.com,
	qiang.zhang1211@gmail.com,
	Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	paulmck@kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 2/3] rcu: Remove swake_up_one_online() bandaid
Date: Wed, 18 Dec 2024 17:50:07 +0100
Message-ID: <20241218165008.37820-3-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241218165008.37820-1-frederic@kernel.org>
References: <20241218165008.37820-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's now ok to perform a wake-up from an offline CPU because the
resulting armed scheduler bandwidth hrtimers are now correctly targeted
by hrtimer infrastructure.

Remove the obsolete hackerry.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c      | 34 +---------------------------------
 kernel/rcu/tree_exp.h  |  2 +-
 kernel/rcu/tree_nocb.h |  2 +-
 3 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c160e05dfb7c..576b5c365145 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1060,38 +1060,6 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
 	return needmore;
 }
 
-static void swake_up_one_online_ipi(void *arg)
-{
-	struct swait_queue_head *wqh = arg;
-
-	swake_up_one(wqh);
-}
-
-static void swake_up_one_online(struct swait_queue_head *wqh)
-{
-	int cpu = get_cpu();
-
-	/*
-	 * If called from rcutree_report_cpu_starting(), wake up
-	 * is dangerous that late in the CPU-down hotplug process. The
-	 * scheduler might queue an ignored hrtimer. Defer the wake up
-	 * to an online CPU instead.
-	 */
-	if (unlikely(cpu_is_offline(cpu))) {
-		int target;
-
-		target = cpumask_any_and(housekeeping_cpumask(HK_TYPE_RCU),
-					 cpu_online_mask);
-
-		smp_call_function_single(target, swake_up_one_online_ipi,
-					 wqh, 0);
-		put_cpu();
-	} else {
-		put_cpu();
-		swake_up_one(wqh);
-	}
-}
-
 /*
  * Awaken the grace-period kthread.  Don't do a self-awaken (unless in an
  * interrupt or softirq handler, in which case we just might immediately
@@ -1116,7 +1084,7 @@ static void rcu_gp_kthread_wake(void)
 		return;
 	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
 	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
-	swake_up_one_online(&rcu_state.gp_wq);
+	swake_up_one(&rcu_state.gp_wq);
 }
 
 /*
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index fb664d3a01c9..17b1a5e3590c 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -200,7 +200,7 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 		if (rnp->parent == NULL) {
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			if (wake)
-				swake_up_one_online(&rcu_state.expedited_wq);
+				swake_up_one(&rcu_state.expedited_wq);
 
 			break;
 		}
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 2605dd234a13..a43141a1b3a5 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -216,7 +216,7 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 	if (needwake) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DoWake"));
-		swake_up_one_online(&rdp_gp->nocb_gp_wq);
+		swake_up_one(&rdp_gp->nocb_gp_wq);
 	}
 
 	return needwake;
-- 
2.46.0

