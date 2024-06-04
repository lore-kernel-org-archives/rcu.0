Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8844A5F;
	Tue,  4 Jun 2024 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539836; cv=none; b=rdxNTIPh4Bi1c0CFYcmj3phHAk6yyr2+a7FB0DjHPZEjefLqh+wghUW99PT0ld3m+C/98crF3ivpTrgpoTESaK4DPA+K81t20SJNLgkE0V0Q0esECF3rpeCT+l3Z3wjQLhCGci3t+maOq0XGZBHDPYkOuPNSMtMIvGavWWM2aB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539836; c=relaxed/simple;
	bh=RUq/x40RoZ1+Q28PHuHwZWpj7Bz1teiZmeOv5T+R3o0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KDSUad7wwcIyF26/bHgLMEGqPMRXDZ8g4HZxFVyaQjRdPbp5JlQsvaf3o2Be9pp2PcdjhPYBNR4q49Of3xJJq8GT9yQkpXmxH2tZQSulUWHz7MCqwWBxlxZKaJx//S06WT6ky84j0M3wT3WTnQBtSpr9jGMDvAhHylUAhh+JUdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kt3FpNKb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kt3FpNKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3980C3277B;
	Tue,  4 Jun 2024 22:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539836;
	bh=RUq/x40RoZ1+Q28PHuHwZWpj7Bz1teiZmeOv5T+R3o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kt3FpNKbTghXYwbkm+LzOtM+NWHFQdZhQcDh65ABKodYDBCJ9tOwN2z7AHbgYUgYi
	 WZv5/SAjdvqw1xhhnzcVMLiFhj203zOi71+yPHpjJakaYR8mHfYFpqGE+QTZ7B8YkA
	 0Dx467tCwu8w1vNNY+sK7o6J+aA38ub5gT7xW9rLBK5WVXWYOBEi1SD8iNyURotfsA
	 T+mX0rlyQb3Fk4MwuwrkrIlAO/+51MbITrNmrU8INEVOke6npkJWY0hqTZzZBWW5VQ
	 dJPx4MMSvGRNIbkzsdozlziGbRLkQGbZtIpWO7SdfUgMTFyq2jXC94waG7/sEcx/2O
	 vmNS3HSV9A35A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5CADECE3F0F; Tue,  4 Jun 2024 15:23:56 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/9] rcu: Reduce synchronize_rcu() delays when all wait heads are in use
Date: Tue,  4 Jun 2024 15:23:48 -0700
Message-Id: <20240604222355.2370768-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

When all wait heads are in use, which can happen when
rcu_sr_normal_gp_cleanup_work()'s callback processing
is slow, any new synchronize_rcu() user's rcu_synchronize
node's processing is deferred to future GP periods. This
can result in long list of synchronize_rcu() invocations
waiting for full grace period processing, which can delay
freeing of memory. Mitigate this problem by using first
node in the list as wait tail when all wait heads are in use.
While methods to speed up callback processing would be needed
to recover from this situation, allowing new nodes to complete
their grace period can help prevent delays due to a fixed
number of wait head nodes.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 28c7031711a3f..6ba36d9c09bde 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1463,14 +1463,11 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
  * for this new grace period. Given that there are a fixed
  * number of wait nodes, if all wait nodes are in use
  * (which can happen when kworker callback processing
- * is delayed) and additional grace period is requested.
- * This means, a system is slow in processing callbacks.
- *
- * TODO: If a slow processing is detected, a first node
- * in the llist should be used as a wait-tail for this
- * grace period, therefore users which should wait due
- * to a slow process are handled by _this_ grace period
- * and not next.
+ * is delayed), first node in the llist is used as wait
+ * tail for this grace period. This means, the first node
+ * has to go through additional grace periods before it is
+ * part of the wait callbacks. This should be ok, as
+ * the system is slow in processing callbacks anyway.
  *
  * Below is an illustration of how the done and wait
  * tail pointers move from one set of rcu_synchronize nodes
@@ -1639,7 +1636,6 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 	if (!done)
 		return;
 
-	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
 	head = done->next;
 	done->next = NULL;
 
@@ -1676,13 +1672,21 @@ static void rcu_sr_normal_gp_cleanup(void)
 
 	rcu_state.srs_wait_tail = NULL;
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_wait_tail);
-	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
 
 	/*
 	 * Process (a) and (d) cases. See an illustration.
 	 */
 	llist_for_each_safe(rcu, next, wait_tail->next) {
-		if (rcu_sr_is_wait_head(rcu))
+		/*
+		 * The done tail may reference a rcu_synchronize node.
+		 * Stop at done tail, as using rcu_sr_normal_complete()
+		 * from this path can result in use-after-free. This
+		 * may occur if, following the wake-up of the synchronize_rcu()
+		 * wait contexts and freeing up of node memory,
+		 * rcu_sr_normal_gp_cleanup_work() accesses the done tail and
+		 * its subsequent nodes.
+		 */
+		if (wait_tail->next == rcu_state.srs_done_tail)
 			break;
 
 		rcu_sr_normal_complete(rcu);
@@ -1719,15 +1723,17 @@ static bool rcu_sr_normal_gp_init(void)
 		return start_new_poll;
 
 	wait_head = rcu_sr_get_wait_head();
-	if (!wait_head) {
-		// Kick another GP to retry.
+	if (wait_head) {
+		/* Inject a wait-dummy-node. */
+		llist_add(wait_head, &rcu_state.srs_next);
+	} else {
+		// Kick another GP for first node.
 		start_new_poll = true;
-		return start_new_poll;
+		if (first == rcu_state.srs_done_tail)
+			return start_new_poll;
+		wait_head = first;
 	}
 
-	/* Inject a wait-dummy-node. */
-	llist_add(wait_head, &rcu_state.srs_next);
-
 	/*
 	 * A waiting list of rcu_synchronize nodes should be empty on
 	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
-- 
2.40.1

