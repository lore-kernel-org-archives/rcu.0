Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A7770F0;
	Fri, 16 Aug 2024 04:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784253; cv=none; b=rQRmdkInD54Wu/KefdUVzex3eQn9PLxX8/FdsrffF0qGhbG4HxvdCua9trmkbUdwLl71wHS2XU8F9SKdtqIJ6rei7lTJ84AUKtKBKGwfrWILWE9o2OrwiyEbFjnhYjc/pDypYYl4pY9JFClxgQVdidiTxRdVq31//jOu341yEak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784253; c=relaxed/simple;
	bh=ER1Jq0SEHJHN/Q00K1nfZVHbMFwXFFukaC7UZS0qAXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KeNFW4fnF8D6nL6XwXhOlTxjP0CYd/BzMVP9s/zTfmN+rWY82+dxwWBw2zswhBQQnvl7o12Vw7lSkj5xj9nWhKdhhmrQHlhLJBGR0/QeJeBQPsvtbQh8xXEzpQKTYyGRcAajpGIgQ1nwZT3AY8L8q1AWF2twTl0qzPxCKZPkBi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYOqy0qJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYOqy0qJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD83C4AF0B;
	Fri, 16 Aug 2024 04:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723784252;
	bh=ER1Jq0SEHJHN/Q00K1nfZVHbMFwXFFukaC7UZS0qAXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NYOqy0qJQyfjqlkZC8+GbKE76EGOILvwzoLjjrF8q+coTwKOiTBBUSrF967WqF19n
	 Ta7x5zkNjc1xyUCcNZT7KlQ4CsAj5jJ40pV7R0VG5NmOOS6KfVAH5sX9KQXePysWEd
	 m8wIPY5SsmFge9A4BvXNqKD79N4H4tU+GdYwQuYpJ6mF2n7SxF0BTRHj6bQzPHrHGn
	 sexnr4NmW4w+du0FhH8Bz74pNhqJale22Fv4ql3mf37T/E+PRNvh/PriwydPqJ+jUc
	 0O+C4ZCS/DHTPzz8RfWeWNXAwAZG0xzLLHtq7YYPJCK+n4fP+g685o/rNNZhYPptsG
	 dY99WcCI415sA==
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
Subject: [PATCH rcu 08/11] rcu/nocb: Remove halfway (de-)offloading handling from rcu_core
Date: Fri, 16 Aug 2024 10:26:05 +0530
Message-Id: <20240816045608.30564-9-neeraj.upadhyay@kernel.org>
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

The locked callback acceleration handling during the transition can
therefore be removed, along with concurrent batch execution.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 60f271f5c079..1a272c678533 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2781,24 +2781,6 @@ static __latent_entropy void rcu_core(void)
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
@@ -2818,17 +2800,17 @@ static __latent_entropy void rcu_core(void)
 
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
2.40.1

