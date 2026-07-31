Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020B2D73A6;
	Fri, 31 Jul 2026 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459457; cv=none; b=hlSeYfzX5uO4eDyGAa/UBw4XKoSUVjGIF9YKa2ka7oOBXQRq4PtLJ4whrFPgoYGOA5LCYwRqTjLSY8N2j1Y8zAsQ5K374wMNIx6KocNy7UC6AyuDN3Hf4foRJkA0YcuVd61cX2edmM9jjfbOMMbEt0JsMSJjiRUANiuDv2V759A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459457; c=relaxed/simple;
	bh=bLA/RBDhbZEhkdLjTjGd9f8Cb+dvO8owvA22NuNoxeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FE9hGUsJTSy6TlGk4MZacqXJ4/hBGTObfRfJbzWtJgg/M2c7YREQZsM4DcyFkjEpQ4T9sCzQU7Vwu4pPfw8vY05YEM5t0g3G5C45pLnfp6c6qbcxEBoe0zlQztZBhsMztosIqquvdo2I82+tMQWECbePF1aGf6gdoNwVBaLbrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7fZ80rJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7fZ80rJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA26C1F00ADE;
	Fri, 31 Jul 2026 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459454;
	bh=BLpqbK3RCdc7l6xrgasqC/eQMxZSS6mmpXVz+R8xzg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S7fZ80rJAGF+Kh/oV7FqaO7wrzPHI932/RQMmR1Ro/SMHGIWPNTqiVyd6k6dHRHYY
	 FylDeV3OEl3s1QNn4jkwEPf0OhSzHEBTi1VDCEWJHTNcUrXIlugszg+MbfByyAWNKc
	 3B2QryXy10WoEDnuEnoV4DXACQG9OHIEOx9pxtIfUCJRMCaWye/X0qwZ+7RsulstMS
	 Vb+yDdus8WMA+jqaBEdiLZL78WVGtwWNApaQQ5CdEeiFU6zyCfdDyMWDmbQSYjTCdF
	 q46X6pHVNPJbKoWgz18HHUqZiWQqaUyF5XghyTkeYf+ncJrAfSUeLTUjx/tNVIj1cs
	 +oq38w2nK0eJA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4BFB0CE14DB; Thu, 30 Jul 2026 17:57:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Puranjay Mohan <puranjay@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 10/12] rcu: Detect expedited grace period completion in rcu_pending()
Date: Thu, 30 Jul 2026 17:57:30 -0700
Message-Id: <20260731005732.3530999-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <58bcd561-0520-43ff-95b0-1ed10e1e3bff@paulmck-laptop>
References: <58bcd561-0520-43ff-95b0-1ed10e1e3bff@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

rcu_pending() decides whether rcu_core() should run on the current CPU's
timer tick.  It does not account for expedited grace periods: after an
expedited GP completes, a non-offloaded CPU's callbacks remain in
RCU_WAIT_TAIL (not yet advanced to RCU_DONE_TAIL) and rcu_core() is
never invoked to advance them.

Detect that case via rcu_segcblist_nextgp() combined with a new
memory-ordering-free poll variant,
poll_state_synchronize_rcu_full_unordered().  This keeps rcu_pending()
cheap: it runs on every tick that has pending callbacks, so it must
not pay for the two memory barriers in
poll_state_synchronize_rcu_full().  The check is only a hint to run
rcu_core(); the ordered re-check and the actual callback advancement
happen there.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 251114eb974bca..3541feed95573c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3592,6 +3592,24 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
 }
 EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
 
+/*
+ * Racy, memory-ordering-free test of whether the normal or expedited grace
+ * period recorded in *gsp has completed.  Callers that need the full
+ * memory-ordering guarantees must use poll_state_synchronize_rcu_full();
+ * this variant is only a hint (e.g. for rcu_pending()) and leaves any
+ * required ordering to a subsequent ordered check.
+ */
+static bool poll_state_synchronize_rcu_full_unordered(struct rcu_gp_seq *gsp)
+{
+	struct rcu_node *rnp = rcu_get_root();
+
+	return gsp->norm == RCU_GET_STATE_COMPLETED ||
+	       rcu_seq_done_exact(&rnp->gp_seq, gsp->norm) ||
+	       gsp->exp == RCU_GET_STATE_COMPLETED ||
+	       (gsp->exp != RCU_GET_STATE_NOT_TRACKED &&
+		rcu_seq_done_exact(&rcu_state.expedited_sequence, gsp->exp));
+}
+
 /**
  * poll_state_synchronize_rcu_full - Has the specified RCU grace period completed?
  * @gsp: value from get_state_synchronize_rcu_full() or start_poll_synchronize_rcu_full()
@@ -3627,14 +3645,8 @@ EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
  */
 bool poll_state_synchronize_rcu_full(struct rcu_gp_seq *gsp)
 {
-	struct rcu_node *rnp = rcu_get_root();
-
 	smp_mb(); // Order against root rcu_node structure grace-period cleanup.
-	if (gsp->norm == RCU_GET_STATE_COMPLETED ||
-	    rcu_seq_done_exact(&rnp->gp_seq, gsp->norm) ||
-	    gsp->exp == RCU_GET_STATE_COMPLETED ||
-	    (gsp->exp != RCU_GET_STATE_NOT_TRACKED &&
-	     rcu_seq_done_exact(&rcu_state.expedited_sequence, gsp->exp))) {
+	if (poll_state_synchronize_rcu_full_unordered(gsp)) {
 		smp_mb(); /* Ensure GP ends before subsequent accesses. */
 		return true;
 	}
@@ -3704,6 +3716,7 @@ EXPORT_SYMBOL_GPL(cond_synchronize_rcu_full);
 static int rcu_pending(int user)
 {
 	bool gp_in_progress;
+	struct rcu_gp_seq gp_state;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 
@@ -3734,6 +3747,17 @@ static int rcu_pending(int user)
 	    rcu_segcblist_ready_cbs(&rdp->cblist))
 		return 1;
 
+	/*
+	 * Has a GP (normal or expedited) completed for pending callbacks?
+	 * This is only a racy hint to decide whether to run rcu_core(); the
+	 * ordered re-check and callback advancement happen there, so the
+	 * unordered test avoids paying for memory barriers on every tick.
+	 */
+	if (!rcu_rdp_is_offloaded(rdp) &&
+	    rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
+	    poll_state_synchronize_rcu_full_unordered(&gp_state))
+		return 1;
+
 	/* Has RCU gone idle with this CPU needing another grace period? */
 	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
 	    !rcu_rdp_is_offloaded(rdp) &&
-- 
2.40.1

