Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66A2EC086;
	Fri, 31 Jul 2026 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459458; cv=none; b=AhajNSrBud0oB1c1QCg2Y9NbsWTZqxvsXkBcRcIKQtVzQLUyMTIkE3ceHy/OOGdkXF4vUCnsI8FJPA6m/nsdAwoOG5hyUlsOQPnZYP5WUCpUU8Zumrk4VMteW7g3u01o0tm/IRCPi1Ibi+7Ege+fpqb1LZnlfFvMnw+mIMUuhyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459458; c=relaxed/simple;
	bh=pGWbjAwmQ7GQyNZaXIURGg73xTtA3DL8gavvk5+cnqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ocMd8k0U+VkgNEwbSObb2cbhv5SWctTrVBaH0MfL8PJNTgDMUMlU86ix628/oXhH9/lZusjs5nei4c0Sc4Mv9DVlZ63HKbm/LSPej8kk4z4ERUvlwZjUbUoLGN8Rdxrk2mjfqxy3YsIhVlpytuGZrLnThGj+oacLpUrHDJ8SdV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0ZUi0S7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0ZUi0S7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43161F01563;
	Fri, 31 Jul 2026 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459454;
	bh=4sT1blXSgLoK8soPEN+sGTJr47CcoPN4fFLcBtLYPT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S0ZUi0S7jSiTNqwyBYg+x8wotWvON7Bm3iLJtRipY0sE19XmCeFxxddvi0xvKyKoy
	 /H2qJr6uXtr6/Ns0km2Dre9D5BZGTySMAsJXItLOMYq+kto8K1qiDNa9+5Ket8aQ3k
	 S/4B9T1aDTrbYtfYeK2qH9mEtuzVxNpkPzw6pG74YPygfvpmtfAvcinDnNgPxc0sc9
	 v7qWpaaXqUUSqxgaoSscKbs+ksElyvbpp2aplhOVgKYTrJTveGwq6FgmQ58jPWs67W
	 Ko/dUXSs6ghuQmcIxdYkrvcgzgs9h9ayWsPZ+uV1XC+rkGKFyKY/1DZ38vbLxQG4bU
	 5Rze0aL54ii8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4E57FCE1716; Thu, 30 Jul 2026 17:57:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Puranjay Mohan <puranjay@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 11/12] rcu: Advance callbacks for expedited GP completion in rcu_core()
Date: Thu, 30 Jul 2026 17:57:31 -0700
Message-Id: <20260731005732.3530999-11-paulmck@kernel.org>
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

Even when rcu_pending() triggers rcu_core(), the normal callback
advancement path through note_gp_changes() -> __note_gp_changes() bails
out when rdp->gp_seq == rnp->gp_seq (no normal GP change). Since
expedited GPs do not update rnp->gp_seq, rcu_advance_cbs() is never
called and callbacks remain stuck in RCU_WAIT_TAIL.

Add a direct callback advancement block in rcu_core() that checks for GP
completion via rcu_segcblist_nextgp() combined with
poll_state_synchronize_rcu_full(). When detected, trylock rnp and call
rcu_advance_cbs() to move completed callbacks to RCU_DONE_TAIL. Wake the
GP kthread if rcu_advance_cbs() requests a new grace period.

Uses trylock to avoid adding contention on rnp->lock. If the lock is
contended, callbacks will be advanced on the next tick.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3541feed95573c..f6809ccedfc1b4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2885,6 +2885,23 @@ static __latent_entropy void rcu_core(void)
 	/* Update RCU state based on any recent quiescent states. */
 	rcu_check_quiescent_state(rdp);
 
+	/* Advance callbacks if an expedited GP has completed. */
+	if (!rcu_rdp_is_offloaded(rdp) && rcu_segcblist_is_enabled(&rdp->cblist)) {
+		struct rcu_gp_seq gp_state;
+
+		if (rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
+		    poll_state_synchronize_rcu_full(&gp_state)) {
+			guard(irqsave)();
+			if (raw_spin_trylock_rcu_node(rnp)) {
+				bool needwake = rcu_advance_cbs(rnp, rdp);
+
+				raw_spin_unlock_rcu_node(rnp);
+				if (needwake)
+					rcu_gp_kthread_wake();
+			}
+		}
+	}
+
 	/* No grace period and unregistered callbacks? */
 	if (!rcu_gp_in_progress() &&
 	    rcu_segcblist_is_enabled(&rdp->cblist) && !rcu_rdp_is_offloaded(rdp)) {
-- 
2.40.1

