Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334E17622C;
	Thu, 30 May 2024 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076788; cv=none; b=fpI1rGb2ISJG1ov6yQHKiKe0bZBFUcu/CbS8Yf7mPDx089WBRlWpIznJylu3/DLKKss2xOa2lmfLnb5l5SCHI1NQMbChvsSSmS2ih9xkOZkSH29mfd3gNFcwFwCuqzAm0wNbHgwryqICOpe0OA1gCT/Me7MPoqsAlOLAvXG/5fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076788; c=relaxed/simple;
	bh=YrjH2xrWlC5tQJfhshKipi5vOU0pIegfL1JgGkSpqiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSKSEk+p7ojElwihz1XQgs7wj+Nx0kvvsyhEhses+XAKQZqvaH9dRf3JVT7AxOAbJX520SPxJZk1Jx3i9es+MUdcOlIlaI/7WCjhZCxXB4XuU4OVoXVTm8L/rXW3TZUkWpXWp2B9TyQncjYQ65x9vyo7DmkVCJuvsWuXMj9+c/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvridsxF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvridsxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173DAC32786;
	Thu, 30 May 2024 13:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717076788;
	bh=YrjH2xrWlC5tQJfhshKipi5vOU0pIegfL1JgGkSpqiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvridsxFGYPGdCvjw4uR9ikDEKtbn6JbSWdwpDSAq4MUevfM09TdB6WsG80RYlm8D
	 JolTqbMQnjEOglV5slSWbVq0I3kJzlf7CTEjBVrRWcyjvmoWShS103G0fkjr5V/yxY
	 Api5ogA1947XtziYfZUIfeQI3JlxmkTTcIHt0Iw5WJMCGxgulq8g7+3IakOCy73Ey+
	 vpMUIa+LRycoDeHQwFhnMDSpAd5qSMfs7ijEEveEUYUMOLEI8cHbpMVgnApr+Uoikf
	 AbhdGULzRjD5cV/jDFfBYG+BWnJmCXnbNQBRSutubv+ClTUP0j3wZSZpoHkY61ol9a
	 kHJSu1zA67V0A==
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
Subject: [PATCH 08/11] rcu/nocb: Remove halfway (de-)offloading handling from rcu_core
Date: Thu, 30 May 2024 15:45:49 +0200
Message-ID: <20240530134552.5467-9-frederic@kernel.org>
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

The locked callback acceleration handling during the transition can
therefore be removed, along with concurrent batch execution.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c502a38dc5f3..4f1863a0536d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2776,24 +2776,6 @@ static __latent_entropy void rcu_core(void)
 	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
-	/*
-	 * On RT rcu_core() can be preempted when IRQs aren't disabled.
-	 * Therefore this function can race with concurrent NOCB (de-)offloading
-	 * on this CPU and the below condition must be considered volatile.
-	 * However if we race with:
-	 *
-	 * _ Offloading:   In the worst case we accelerate or process callbacks
-	 *                 concurrently with NOCB kthreads. We are guaranteed to
-	 *                 call rcu_nocb_lock() if that happens.
-	 *
-	 * _ Deoffloading: In the worst case we miss callbacks acceleration or
-	 *                 processing. This is fine because the early stage
-	 *                 of deoffloading invokes rcu_core() after setting
-	 *                 SEGCBLIST_RCU_CORE. So we guarantee that we'll process
-	 *                 what could have been dismissed without the need to wait
-	 *                 for the next rcu_pending() check in the next jiffy.
-	 */
-	const bool do_batch = !rcu_segcblist_completely_offloaded(&rdp->cblist);
 
 	if (cpu_is_offline(smp_processor_id()))
 		return;
@@ -2813,17 +2795,17 @@ static __latent_entropy void rcu_core(void)
 
 	/* No grace period and unregistered callbacks? */
 	if (!rcu_gp_in_progress() &&
-	    rcu_segcblist_is_enabled(&rdp->cblist) && do_batch) {
-		rcu_nocb_lock_irqsave(rdp, flags);
+	    rcu_segcblist_is_enabled(&rdp->cblist) && !rcu_rdp_is_offloaded(rdp)) {
+		local_irq_save(flags);
 		if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 			rcu_accelerate_cbs_unlocked(rnp, rdp);
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		local_irq_restore(flags);
 	}
 
 	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
 
 	/* If there are callbacks ready, invoke them. */
-	if (do_batch && rcu_segcblist_ready_cbs(&rdp->cblist) &&
+	if (!rcu_rdp_is_offloaded(rdp) && rcu_segcblist_ready_cbs(&rdp->cblist) &&
 	    likely(READ_ONCE(rcu_scheduler_fully_active))) {
 		rcu_do_batch(rdp);
 		/* Re-invoke RCU core processing if there are callbacks remaining. */
-- 
2.45.1

