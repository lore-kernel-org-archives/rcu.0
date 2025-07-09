Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676228DEE8;
	Wed,  9 Jul 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057595; cv=none; b=Cpqqkj4OyRxdrvr7kqxJAjGUabxzqRgjU5Cq6KNV9yKftMfucYMYn5JSWuu5YMVP+ClvEqxZ0wS1wRuOZk3WDaIge+9Qc4aa9Aacky18aN6P4IDekQ99qp5qqSYwkPIVhgptOAhDheedfncR21nUoy/dm1LQHZU5dJd3nA/Yv9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057595; c=relaxed/simple;
	bh=PxHHLkx1VHK181EbcOOUVDwD6SaEG/JAFcZiYpxdAyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C4jNEU3Ot7n8r4G2iw/oOSzrjjJLZwxGYt3lET4o3g72V2U807DBoqMV72WLFMNGZXYivAHetuQ0I3UNGAsGj0FnF38bC6SHLSCg9sXUs7cxQTB9mCC4Lq1tjfvJunQqjF6fCp8SECd48z4FSLL60qeGqJWBa4VW4rnT9qA+dzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t70636v+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t70636v+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43BDC4CEF4;
	Wed,  9 Jul 2025 10:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057594;
	bh=PxHHLkx1VHK181EbcOOUVDwD6SaEG/JAFcZiYpxdAyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t70636v+9hIiUkqS6/SLOSQXsvAYAHtjiwUsqbp7bpABuNOJ+4nLW4TN4NRMa9Jmd
	 Tj+eDcdSMSOEOTo1y5IDmWiPGMQhO15u1NTmXayVSLdKK4Xfu/zAggVh1AovgEGUkp
	 KVbTdv8LCSI78FwF8Yd50j6V5Z6h2qT0nAe033e8bAjSRFOovARA3r9uTb4DDHkxCW
	 0M5UfBmLEPkzWQ9yTEupigqYalj2GmWbiUHPDkrdc82SEEZHjpKesGHNpaZPHPNpMF
	 hoscYxetbBottenls7WG97EjGZ27QoFwzgg4UgR886icfMrGZxIjavuFZQ7kXtwDar
	 CyE4xEgX13reQ==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 2/5] rcu/exp: Remove confusing needless full barrier on task unblock
Date: Wed,  9 Jul 2025 16:09:06 +0530
Message-Id: <20250709103909.15498-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709103909.15498-1-neeraj.upadhyay@kernel.org>
References: <20250709103909.15498-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

A full memory barrier in the RCU-PREEMPT task unblock path advertizes
to order the context switch (or rather the accesses prior to
rcu_read_unlock()) with the expedited grace period fastpath.

However the grace period can not complete without the rnp calling into
rcu_report_exp_rnp() with the node locked. This reports the quiescent
state in a fully ordered fashion against updater's accesses thanks to:

1) The READ-SIDE smp_mb__after_unlock_lock() barrier across nodes
   locking while propagating QS up to the root.

2) The UPDATE-SIDE smp_mb__after_unlock_lock() barrier while holding the
   the root rnp to wait/check for the GP completion.

3) The (perhaps redundant given step 1) and 2)) smp_mb() in rcu_seq_end()
   before the grace period completes.

This makes the explicit barrier in this place superfluous. Therefore
remove it as it is confusing.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0b0f56f6abc8..0532a13cb75e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -534,7 +534,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		WARN_ON_ONCE(rnp->completedqs == rnp->gp_seq &&
 			     (!empty_norm || rnp->qsmask));
 		empty_exp = sync_rcu_exp_done(rnp);
-		smp_mb(); /* ensure expedited fastpath sees end of RCU c-s. */
 		np = rcu_next_node_entry(t, rnp);
 		list_del_init(&t->rcu_node_entry);
 		t->rcu_blocked_node = NULL;
-- 
2.40.1

