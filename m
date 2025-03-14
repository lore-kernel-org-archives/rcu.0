Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C85201253;
	Fri, 14 Mar 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963014; cv=none; b=HRMjjKWhlLGPEoGRMrVwWW/2r2eDO1reFm1wFbcBUgkmuK7WAmX5dE8SQ1rJArtoCyFMQHWkwHKSd629qWPPbVvwWE/ZOx3AZ4QL5GzU5Ijo8Mh2SiOudtsBQnnL6LdU/bdyTiqKb0zVRxOIddHAXczeuxRf3ow6ofyqqyPhBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963014; c=relaxed/simple;
	bh=Gf/HgxO4bwQVxa3pjudIyS3sTp30xi2+m/NxVQa/R4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t84N331Ig9pxfqN2A49vmv7CHuRTJrviROQYlPA+xyhpm2zCEiDS7DstxxAxWYpLQRSA3f2pXwn/IPvEEtyLRN/BDaIcGnbq686teMwmBNQOmE/Bty4nN3fFCOJbKyU3PhdfLSwIz3lXvmV6FBakivbXTsHrI6K6LLMkIPEGFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlIj3U4d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlIj3U4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA729C4CEE3;
	Fri, 14 Mar 2025 14:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741963013;
	bh=Gf/HgxO4bwQVxa3pjudIyS3sTp30xi2+m/NxVQa/R4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NlIj3U4dBsROonRiYS38mlEIrrS02+tvr3XxU8VA5wvjOD+WdariVZOWpGXVNr7sn
	 ybf0lYXSL/UT+wM4inllgpnsjkINEIawIQJ1g/VlR4b9tZmnqlZ6mqUmFSLNKCGl8G
	 S1RrDxkMg3N2LHDH7ItOo/kQblE6JadPL4wcoElVOH+X9/7vH39AmEbOGHQfIA6pOx
	 E0tbh6iR9HMSx3lJw6/GS+eKx4ACt+bqUpSzJ53QZVPgpVNWHHsyLcJjCzVODlNrpc
	 fzU0KVZYDwO0LPnF/t7SfcB1+tmydAhh20/EQifcZIVnSoxgDf9Tii6aavybMg324w
	 5riEP/pcFeYtg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 2/5] rcu/exp: Remove confusing needless full barrier on task unblock
Date: Fri, 14 Mar 2025 15:36:39 +0100
Message-ID: <20250314143642.72554-3-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314143642.72554-1-frederic@kernel.org>
References: <20250314143642.72554-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A full memory barrier in the RCU-PREEMPT task unblock path advertizes
to order the context switch (or rather the accesses prior to
rcu_read_unlock()) with the expedited grace period fastpath.

However the grace period can not complete without the rnp calling into
rcu_report_exp_rnp() with the node locked. This reports the quiescent
state in a fully ordered fashion against updater's accesses thanks to:

1) The READ-SIDE smp_mb__after_unlock_lock() barrier accross nodes
   locking while propagating QS up to the root.

2) The UPDATE-SIDE smp_mb__after_unlock_lock() barrier while holding the
   the root rnp to wait/check for the GP completion.

3) The (perhaps redundant given step 1) and 2)) smp_mb() in rcu_seq_end()
   before the grace period completes.

This makes the explicit barrier in this place superflous. Therefore
remove it as it is confusing.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3c0bbbbb686f..d51cc7a5dfc7 100644
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
2.48.1

