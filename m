Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212BA770F0;
	Fri, 16 Aug 2024 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784258; cv=none; b=CYzYWKFW001/IPImY1z6s5JuX2na1lhBI2nQbwfcUGT85j6YYDL3k8S9OBglM34aPUk3uAl6yEXsTOzm3t8m9jER+7xXrXIl9qTcp6MtrdSFPKqvajzd9haYXqDpj4NyRx96eI78DxQT3KE+p+8kbKzQdFsKoxOpyxmcvOMYuek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784258; c=relaxed/simple;
	bh=0RxThKzhMu4OaNgmE3Z+QbdkQaB14Uld1PAQoMv7CUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F9ITqv1CSCbA4xGNb9OxGXbRET/DAjqquICUp1WRwOlaI5CJL3d6J17E+tWXt2c9iAZCD/itl6ur8VXMBLlgkO6vZN5AYEKqccqlmD4gsVtUQ+vzKpKUF9Hl+SbM/mMhaK8w1/u3vpNApEHz2ApxNrvAv417DDS3UnjRAfmCo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7cj6rNV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7cj6rNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48834C4AF10;
	Fri, 16 Aug 2024 04:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723784258;
	bh=0RxThKzhMu4OaNgmE3Z+QbdkQaB14Uld1PAQoMv7CUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7cj6rNVO2j4RlE3Vtea0DGUEN0U4Haay3w7/v7F9DiQL2xCtZ5bXujne1kKQuP4p
	 AzBqcG+DPl10nL2mpFSVktsWHIgKU4nIfQRG7mPpCKJGsvZ/InJf7MwuIq9ECYFSG5
	 VYOYEBc+coIzy35PuxqXANMzhTIyy54PHyATlQBoBdee6b50gTQwbwPE8yvdbsq83E
	 /IGq8euEo9sO30L/BuNaDFLGbepTfwoUvHb0XTBwIUXx24vVDFN1Hg9En8thqtFiZS
	 UEi6EuN7EgRvwlcRz9L65dEaNIXeu0qKKxw5QtK3SlhzWPRHq6e2CwuR8BQwz3+F3g
	 ACkaIuAI76+cQ==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 09/11] rcu/nocb: Remove SEGCBLIST_RCU_CORE
Date: Fri, 16 Aug 2024 10:26:06 +0530
Message-Id: <20240816045608.30564-10-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
References: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

RCU core can't be running anymore while in the middle of (de-)offloading
since this sort of transition now only applies to offline CPUs.

The SEGCBLIST_RCU_CORE state can therefore be removed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/rcu_segcblist.h | 9 ++++-----
 kernel/rcu/rcu_segcblist.h    | 9 ---------
 kernel/rcu/tree.c             | 3 ---
 kernel/rcu/tree_nocb.h        | 9 ---------
 4 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index ba95c06675e1..5469c54cd778 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -185,11 +185,10 @@ struct rcu_cblist {
  *  ----------------------------------------------------------------------------
  */
 #define SEGCBLIST_ENABLED	BIT(0)
-#define SEGCBLIST_RCU_CORE	BIT(1)
-#define SEGCBLIST_LOCKING	BIT(2)
-#define SEGCBLIST_KTHREAD_CB	BIT(3)
-#define SEGCBLIST_KTHREAD_GP	BIT(4)
-#define SEGCBLIST_OFFLOADED	BIT(5)
+#define SEGCBLIST_LOCKING	BIT(1)
+#define SEGCBLIST_KTHREAD_CB	BIT(2)
+#define SEGCBLIST_KTHREAD_GP	BIT(3)
+#define SEGCBLIST_OFFLOADED	BIT(4)
 
 struct rcu_segcblist {
 	struct rcu_head *head;
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 4fe877f5f654..7a0962dfee86 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -95,15 +95,6 @@ static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 	return false;
 }
 
-static inline bool rcu_segcblist_completely_offloaded(struct rcu_segcblist *rsclp)
-{
-	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-	    !rcu_segcblist_test_flags(rsclp, SEGCBLIST_RCU_CORE))
-		return true;
-
-	return false;
-}
-
 /*
  * Are all segments following the specified segment of the specified
  * rcu_segcblist structure empty of callbacks?  (The specified
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1a272c678533..82e831b969e4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -79,9 +79,6 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *);
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.gpwrap = true,
-#ifdef CONFIG_RCU_NOCB_CPU
-	.cblist.flags = SEGCBLIST_RCU_CORE,
-#endif
 };
 static struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index af44e75eb0cd..24daf606de0c 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1060,7 +1060,6 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 	WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
 
-	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
 	wake_gp = rdp_offload_toggle(rdp, false, flags);
 
 	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
@@ -1168,13 +1167,6 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
 
-	/*
-	 * All kthreads are ready to work, we can finally enable nocb bypass.
-	 */
-	rcu_nocb_lock_irqsave(rdp, flags);
-	rcu_segcblist_clear_flags(cblist, SEGCBLIST_RCU_CORE);
-	rcu_nocb_unlock_irqrestore(rdp, flags);
-
 	return 0;
 }
 
@@ -1350,7 +1342,6 @@ void __init rcu_init_nohz(void)
 			rcu_segcblist_init(&rdp->cblist);
 		rcu_segcblist_offload(&rdp->cblist, true);
 		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
-		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_RCU_CORE);
 	}
 	rcu_organize_nocb_kthreads();
 }
-- 
2.40.1

