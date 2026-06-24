Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478B23BB111;
	Wed, 24 Jun 2026 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307494; cv=none; b=cO5L1YLBwsHjbiLPaXZ3BQrlsVcmm3uGuS0hkBtk/nV9wQOPJ2zyu79lFaRW5UJVO9+kzn2XPCaf9zqzw9TEfRF+y/NirnbDN5a18myYAr4zqC1T0955dvXqfytHGOW6DQqMWfWyAsyK2ETobp0nQr6g0ntmARzh0kjuVhyI+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307494; c=relaxed/simple;
	bh=oWU7rB0yrC4ly+UFNFMY8NTrK6QGpd5Sbm0Rxo9ApWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1IoWETbTZU/DHnoVDLl3AZ5jhJFzV+uhQ33bl188R8PoueFOSSCMon0Of+l6NVuuU6NRCfEQ7bE39omzIqYg8P0/sAs2VeEx1jb4W1Z/l2rkJLUqoeHqGVqVS54Ohfhk9MchQum+EwDtgXvKWIRMAaKKwBCGCbfM0dTLmXBXdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YavcFCCd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YavcFCCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1251F000E9;
	Wed, 24 Jun 2026 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307491;
	bh=n5S+qkkAnGNxxrrGS7UAMIW2CqxWG8yPo0Lc73iF9us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YavcFCCdnyi7UZq9ug4SUdYFHkCNOQJuLb8nhKwtAuH6Dk97ewCeLLt9o5rbgZn11
	 DftJmuWITMtiiGJA5vQb6JP1vWRgdmCr6+hCgMJyjmg3c1Y3LtjmTWpa+j+q64v/zX
	 qa/mT92hYCcptNHvSc4BcL0E6FcJF5Dk2+sbRjOIOt+mLcMiVOAplMA+tr4qGm2M4K
	 Xc+UabXJTLX1D/8uKiIpK0gNk6E8eghXD90rGRrSms5nsyu2WXWOlLyNRPjznAKzKZ
	 oO7ifOsp3cuAXo6rpgfLlrQ0SVL/tluUrXkhF0aDZKy6oo4AvsN/7DHOdEgRnCX6NZ
	 YVKKT+EbN86sg==
From: Puranjay Mohan <puranjay@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH v1 09/11] rcu: Detect expedited grace period completion in rcu_pending()
Date: Wed, 24 Jun 2026 06:23:51 -0700
Message-ID: <20260624132356.516959-10-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624132356.516959-1-puranjay@kernel.org>
References: <20260624132356.516959-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 kernel/rcu/tree.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 169d98ed52bbb..b01d7bf6b57b1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3598,6 +3598,24 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
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
@@ -3633,14 +3651,8 @@ EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
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
@@ -3710,6 +3722,7 @@ EXPORT_SYMBOL_GPL(cond_synchronize_rcu_full);
 static int rcu_pending(int user)
 {
 	bool gp_in_progress;
+	struct rcu_gp_seq gp_state;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 
@@ -3740,6 +3753,17 @@ static int rcu_pending(int user)
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
2.53.0-Meta

