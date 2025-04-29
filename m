Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3192E2D1F68;
	Tue, 29 Apr 2025 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934194; cv=none; b=EoNhznKHMiWL+JOr9JdNgzIqoS0plwJi2QPyVXiiRTED9KI9ZWbOi+6ACliNswDcLsTy3u4FKyYbJBaLGcXbqVHJFrd27tGVdQU8+JUjuvuHI49MnMjTMGxsKDh1pSVN3rw7EO7xikQa81tjF1FDnBHdnmiQSNnzfi5HTA23M6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934194; c=relaxed/simple;
	bh=tNR7OxZ4D8Xc5LSW0eegi8c20pJ6DRwVBXL2pcIjr2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMlbvFDrentb6Tcyx1s5XpqmpRNeoBCp+R+dGZtJnzUzxrpa5ToU24s0KpQwNh7nwFUGJCyDj65F8pbtAmeYazaNlJiTnzNNBeRPPrhuohHHdx4gKhL7f4G29BT/FbRyXmFpQR3i9DJJ3J0La3pXkaD+ma50//ROfG8pNRLTxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htQ9SkSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htQ9SkSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1495DC4CEED;
	Tue, 29 Apr 2025 13:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745934194;
	bh=tNR7OxZ4D8Xc5LSW0eegi8c20pJ6DRwVBXL2pcIjr2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=htQ9SkSSYp6CDrTeHCN9tTubzgDe2taTnQbqBgLymRB2OpeKCCv4CZhQ4eWEOJ2e9
	 9EQEp+j3L3YMxwJIqsxUcwrZn0cW0WnlPI2i2PsJr19jZhk4VTd9cQE/DvbWx9xPQT
	 cIWKFe/30a4cmMsPMYxl7f6fNvdGv4kp4GO9ND3XGFAdvG6sHz2mO6pIWsbv598K68
	 tnejouFYMi1ibzRd3D4ZX0NkuFL+JrhYd4Hg4MIEyFhFv9MLHnN66D6+jOD7u9QTsb
	 Yj6otiy5MKS3Gyz+YAl8gSjL4ASZmTIDNmFME+joe3WuSssBGI8LnmvUermNaiSmjZ
	 9p2MWqB0X6n0g==
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
Subject: [PATCH 1/5] rcu/exp: Protect against early QS report
Date: Tue, 29 Apr 2025 15:43:00 +0200
Message-ID: <20250429134304.3824863-2-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429134304.3824863-1-frederic@kernel.org>
References: <20250429134304.3824863-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a grace period is started, the ->expmask of each node is set up
from sync_exp_reset_tree(). Then later on each leaf node also initialize
its ->exp_tasks pointer.

This means that the initialization of the quiescent state of a node and
the initialization of its blocking tasks happen with an unlocked node
gap in-between.

It happens to be fine because nothing is expected to report an exp
quiescent state within this gap, since no IPI have been issued yet and
every rdp's ->cpu_no_qs.b.exp should be false.

However if it were to happen by accident, the quiescent state could be
reported and propagated while ignoring tasks that blocked _before_ the
start of the grace period.

Prevent such trouble to happen in the future and initialize both the
quiescent states mask to report and the blocked tasks head from the same
node locked block.

If a task blocks within an RCU read side critical section before
sync_exp_reset_tree() is called and is then unblocked between
sync_exp_reset_tree() and __sync_rcu_exp_select_node_cpus(), the QS
won't be reported because no RCU exp IPI had been issued to request it
through the setting of srdp->cpu_no_qs.b.exp.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_exp.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index c36c7d5575ca..2fa7aa9155bd 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -141,6 +141,13 @@ static void __maybe_unused sync_exp_reset_tree(void)
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		WARN_ON_ONCE(rnp->expmask);
 		WRITE_ONCE(rnp->expmask, rnp->expmaskinit);
+		/*
+		 * Need to wait for any blocked tasks as well.	Note that
+		 * additional blocking tasks will also block the expedited GP
+		 * until such time as the ->expmask bits are cleared.
+		 */
+		if (rcu_is_leaf_node(rnp) && rcu_preempt_has_tasks(rnp))
+			WRITE_ONCE(rnp->exp_tasks, rnp->blkd_tasks.next);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 }
@@ -393,13 +400,6 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 	}
 	mask_ofl_ipi = rnp->expmask & ~mask_ofl_test;
 
-	/*
-	 * Need to wait for any blocked tasks as well.	Note that
-	 * additional blocking tasks will also block the expedited GP
-	 * until such time as the ->expmask bits are cleared.
-	 */
-	if (rcu_preempt_has_tasks(rnp))
-		WRITE_ONCE(rnp->exp_tasks, rnp->blkd_tasks.next);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	/* IPI the remaining CPUs for expedited quiescent state. */
-- 
2.48.1

