Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBABF3B71BE;
	Wed, 24 Jun 2026 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307496; cv=none; b=TAPLZGbkkZwpcEu0rmXN2cPkIYqCqWfYdIPru28J/3keCT2wrZh8G8FFgGCz1RVxsN7Z83zmVcN54TNXZ7Fwm74GUGIiSWi1xzZGLnhTJ+d+s2SLdPgVWd0Lxoyv/Mt20ajpQyqi9Wc+YPmXrcBJqJdizZLX5AaaTfMEg+zFP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307496; c=relaxed/simple;
	bh=+QEOQTeZG2azoomWCrVHlUWgfGoszrTM77REaC65Re0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmgeBiU2AuBO1L+l3jLo3dNr+A75Uadz8ya1kVxiNt0zNwFplDOwdU8xKfhjCHq8XFslmMcCB6iVsoc8dIzrc4OQT9C5t4AdBmR0aShs1gw4PIhrhPycPhIM29KLZkQgYY1RurpEHUZeYfY1fNJbg2xuQENPw5xSdEEcnWyLY/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1pAMttQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1pAMttQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77E31F000E9;
	Wed, 24 Jun 2026 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307494;
	bh=bSZzL9xHnGpaj2wl7D+A9JSmOfqbmyzZONAq5V2zlGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R1pAMttQykl2heTRNgeOu01mkX879XOvZkFKMmPKdN8j6k2ucH8lphzv2gEgVS8pj
	 SFtrrM+lt/PTWagVcT9bzasjcZOjJONnwmFIzHvNTCFGtX8upQi4aACOsCNjN7Z3ma
	 BrLnKzjzWQCughIIh7+7EH6HJoZrY07NU+Vlj/ORDh7YTZP8RvaE1fGWm4dDIkxxDx
	 5a+PXOGMc8FfY6WLyjjMoOYUp5ezueN8J5O6X4CA/lMfdgNMI6QcT/SmvHI7Ap8WLV
	 IqogpWXciWOODgs/UIosCE8zwCr+fJCguo/gjnTnJtWCRWaS+ieN7td75yShxrQhPt
	 /s4s9SFALdOwQ==
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
Subject: [PATCH v1 10/11] rcu: Advance callbacks for expedited GP completion in rcu_core()
Date: Wed, 24 Jun 2026 06:23:52 -0700
Message-ID: <20260624132356.516959-11-puranjay@kernel.org>
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
 kernel/rcu/tree.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b01d7bf6b57b1..f42e01ef479c4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2891,6 +2891,23 @@ static __latent_entropy void rcu_core(void)
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
2.53.0-Meta

