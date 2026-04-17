Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCFF199D8;
	Fri, 17 Apr 2026 23:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467586; cv=none; b=SDetpydNnxQRQo/v7taLMQVRBhppA3RXxuaeLsuu4nwT5brfmcjHN+BFbXlqoAtSYgIo+UlhWtjbuzA7tX7Bp1szJuHdwRhlclCBzNLfJJwj++h3muUIPQ5V4ikoj170XxF/ccfiGM9eNhNid3oPLDmN693gICwCZqdOLnIXFwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467586; c=relaxed/simple;
	bh=loKj5p5RGW7ZsaVNGWVL2jGjOwz7i8YTGPxNZoS+54w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/OsPmstUtn+Z+/lx2EXlYysPF48y3z/F7jbYtr9uPKCCAbzpvaFAW9K25a+9YrrtEWJnyRjg+biSY50+Sf2nKae1WIYXGHTsnYxZk1a6cSE9nO+RMv2b6gUFcJoeCVzfjKmXhi6xt9swGe/V2+vSfeAbBjfqqgqZ7oGg1IvNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aV4Y+4C2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aV4Y+4C2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCC0C19425;
	Fri, 17 Apr 2026 23:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467586;
	bh=loKj5p5RGW7ZsaVNGWVL2jGjOwz7i8YTGPxNZoS+54w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aV4Y+4C2F1eUqmRwJJaikiUN0c4Gi4K1yCDTVJMgLBH39sFGDzN6zhsnX8ffMKm9+
	 oaF2tAHer0xjwwBgHQ+eVDU6NFq2k6BbZVOnbZ2OWRUQ+rTrAitLQBf4BZVSxCglAk
	 w0OGxZc2Hqo92R860fRj9Tm0mY9BrM2VPn/ssSY1bHk4iyfGRfAzkARTisgfpHaC6X
	 JIgAdSu9D2ED8hPSpxOYyT+NRF2yvA8aHRcaF07f4M/+h5qqFI9MQK1gTEGlkW5k60
	 K27Zy3nl0lQKR88yKgpA8PxqKlHNhr3swPaYyyOnF32AFNrGY1NxEF2Y14hunzRsb2
	 wj+VCcfVGof7A==
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
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [RFC PATCH 09/10] rcu: Advance callbacks for expedited GP completion in rcu_core()
Date: Fri, 17 Apr 2026 16:11:57 -0700
Message-ID: <20260417231203.785172-10-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417231203.785172-1-puranjay@kernel.org>
References: <20260417231203.785172-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 kernel/rcu/tree.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 309273a37b0a..1a92b6105de5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2853,6 +2853,22 @@ static __latent_entropy void rcu_core(void)
 	/* Update RCU state based on any recent quiescent states. */
 	rcu_check_quiescent_state(rdp);
 
+	/* Advance callbacks if an expedited GP has completed. */
+	if (!rcu_rdp_is_offloaded(rdp) &&
+	    rcu_segcblist_is_enabled(&rdp->cblist)) {
+		struct rcu_gp_oldstate gp_state;
+
+		if (rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
+		    poll_state_synchronize_rcu_full(&gp_state)) {
+			guard(irqsave)();
+			if (raw_spin_trylock_rcu_node(rnp)) {
+				if (rcu_advance_cbs(rnp, rdp))
+					rcu_gp_kthread_wake();
+				raw_spin_unlock_rcu_node(rnp);
+			}
+		}
+	}
+
 	/* No grace period and unregistered callbacks? */
 	if (!rcu_gp_in_progress() &&
 	    rcu_segcblist_is_enabled(&rdp->cblist) && !rcu_rdp_is_offloaded(rdp)) {
-- 
2.52.0

