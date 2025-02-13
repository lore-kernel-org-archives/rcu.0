Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE4222D7BC;
	Thu, 13 Feb 2025 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739489170; cv=none; b=triNvrAHw5+kT7onoy1sM7Uj/cEycLHUyI1SDwdO7Wklag+6CAUf8s6kuXuKF/oUrVX/+9WABmRIag4FzmgUGd4S1hPQmwg6xSa6R9fLZisKQJUUlnN5db6Nj2Thfpm8rmDB5Zmf+oKMzxizlhcflb8LcWDutfPRLDdNIa3xRYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739489170; c=relaxed/simple;
	bh=CKxsi2aJsPtfh0/X6LjUEirL7VKDHgefV+VYEBXQ+AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhEtM0eFlYFy/698jYiYcMmsWfs4E+YbYp8pIlsKWjTvC9oPGcLPkyn+jjYkWs38lnyhrt3UN8caAFGhcxz9DrhVyU4yqbByofOdKLoTA93d/dejHv2jIZ4XjCT/WQTIV40QmfQk4TisddTRvmCOtQ9b/W5yxZQDIBQHgR9JMrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYNj6XPU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYNj6XPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E615FC4CEE5;
	Thu, 13 Feb 2025 23:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739489169;
	bh=CKxsi2aJsPtfh0/X6LjUEirL7VKDHgefV+VYEBXQ+AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYNj6XPUYSEeCZhFlhis2xUvJqjnkcHBEL7DwRlQ4IDzgD+Os46kHEqHCqBaFUNCb
	 V8Gnr1xwZfT8TXDtbcANMjLsCZaFWD1n/2si9zc5+rjw3LFUBtqtmu8ntgD6eGAn9o
	 rSL7UElTcEMsxZyqQpsBPJXuFwRDCszhI+jIdEsD+qAqq/zUN2J0LMHGvFLngWVIp4
	 oE2SgAnsBS0tWZNXQU6JZYQtnn2/RLlVrNDwc/m1MNR44C0ihd2wpDfehTK9vr+QN1
	 s/OcX7LTBVzR2U+c67HOPN5SQtPv0bRevoSkPVNucp91Vsx49U8iZdZ3JTCf7zirgi
	 UYydzBuTU/XpQ==
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
Subject: [PATCH 1/3] rcu/exp: Protect against early QS report
Date: Fri, 14 Feb 2025 00:25:57 +0100
Message-ID: <20250213232559.34163-2-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250213232559.34163-1-frederic@kernel.org>
References: <20250213232559.34163-1-frederic@kernel.org>
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

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_exp.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8d4895c854c5..caff16e441d1 100644
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
2.46.0

