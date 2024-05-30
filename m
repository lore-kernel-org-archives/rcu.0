Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C51856F2;
	Thu, 30 May 2024 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076792; cv=none; b=g9v3R5Ll8wLSj9xlnMzZq8fIGhPYSR6BkwcLouI57VGcC3EJofKGCOcTpQ2P0CNEum1S2YQjkrwgUycx89mtDjuwO9qPlQTXgc5LsgW8cMqnqalojW05ASJt7pkTK1/axieE+NGVZj+SzCny9+rCDJqnUw9/iIb2r7GxRTEIj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076792; c=relaxed/simple;
	bh=IYODWsPK3Egb5SjCYr+mLUaF9VNJJZjEGwfR/HQi4pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2pcdtqB3TDn1I1QTvHVa3HRrb49HqBMxoSlP+XJ4CAqsFW9/H3TJK6gxrhy+n7RPCXXIjphhzGjT6unORa6fJwM9ugpOU4MOXfVxnxYnmEnWXq3GIOYX16pBlCOJO0k4jWaNeQwwjH8UQpUCPW360cVjGyUXOr/qkCjLbxOsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF3IR2Y4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF3IR2Y4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D801BC32789;
	Thu, 30 May 2024 13:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717076791;
	bh=IYODWsPK3Egb5SjCYr+mLUaF9VNJJZjEGwfR/HQi4pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nF3IR2Y4ZsVtVOhtrklXrjfW9q+U4wyf1DTBOrh537kQjoAIyZX/BQPIMdv8vOV11
	 LRBm9Nh/CK2+uBbReS4QVLWtDPgvEere/pa9irp2SCWQ0SLOl2s+Dr8muiW6/6Hg4n
	 9k/XXQFiZM49jP19yvJm/N3wdNeIr5BJEplMaiijLTpO9iHyqEF2mC+9SUZHh0hDhW
	 PaK/m6UY+2ne58Wlr/7wjb9vdk2jZVnTnzDdclfgdDdRUb0q5jzv5W3LMXJXOTnFh4
	 IFqgWHf/+/vz+PApa1FytNayieKKRNOhJF50bY3VKAGU+jzFHM1FbFRC0t6kJ6FkhU
	 BYDxTDw08XgVQ==
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
Subject: [PATCH 09/11] rcu/nocb: Remove SEGCBLIST_RCU_CORE
Date: Thu, 30 May 2024 15:45:50 +0200
Message-ID: <20240530134552.5467-10-frederic@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530134552.5467-1-frederic@kernel.org>
References: <20240530134552.5467-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RCU core can't be running anymore while in the middle of (de-)offloading
since this sort of transition now only applies to offline CPUs.

The SEGCBLIST_RCU_CORE state can therefore be removed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
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
index 4f1863a0536d..8bec3c0c9636 100644
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
2.45.1

