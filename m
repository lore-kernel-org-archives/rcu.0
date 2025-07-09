Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB1C2749F1;
	Wed,  9 Jul 2025 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057588; cv=none; b=B9SAxb2tQQObDogUUVN9ihhiS67oab1pmUU5B/xquiEiCgT4YK5RGUPCLZ6Rk6hL2pRBSGlobxI8OUSTJIfC92JzlIXZ2u5zXSNVUQ2C2f60X8Y9n5WbGvhwTAaljeDLne0XI+6kHDtNye6JB3HIuLYCk+08ja5B3oDUUDvoRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057588; c=relaxed/simple;
	bh=a+ygBf+amrdcbD9NF+H30vF3/3M/W25SaCHncKnVNdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4g7z7+fnoH5eueRDBXchiwS8hvPPLLqfPOzJfnJNIoyAXoZsUGjuu7DQ13Xu+M5+RPnhtI678FlnQgJbWvez0jd6sQ6xV27vKBappl+du1CMulwGIzbFm4fohP9bZ5f5iRcf3q9j1O8GV5xzQmGzUfoo82/hNpiViQZiu9/6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcS7eFmU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcS7eFmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501DAC4CEEF;
	Wed,  9 Jul 2025 10:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057586;
	bh=a+ygBf+amrdcbD9NF+H30vF3/3M/W25SaCHncKnVNdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcS7eFmUkHnt7K8ZnLLXPttOZqaqny04nQYBrKEvHa5jc+Cix2fHEXUlnvx7ePq0N
	 nnSlTlxBuDeS5ch8jQ+MZtuxnb/Q7pbzKNw84+IJhD+h3T0HrxoJgxIbZWgKj1ubLD
	 Xx6cJTY6fjJwTUmmSHV++2fhGooi4yB4pzXFzj6rIMOccLw2hG/q4FpzH2ZmsFNhDo
	 d6YuD7VBtNyRBmEPfvuDAEdtf9ZOLTRx7zhaOZ9hwI10s+iK4eQIS3VX5NswKpFLHD
	 E9KKvvcWON+AQ7rUYhzaEdftMSS+Q+ACocX4LD8geLwX4WFRWQf4TrhwBoy8QC37Pf
	 NyHIOMfTdsipw==
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
Subject: [PATCH rcu 1/5] rcu/exp: Protect against early QS report
Date: Wed,  9 Jul 2025 16:09:05 +0530
Message-Id: <20250709103909.15498-2-neeraj.upadhyay@kernel.org>
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
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
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
2.40.1

