Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8D193418;
	Fri, 23 Aug 2024 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447718; cv=none; b=LK3XqQd2mU/gavERnLhP19UM3jZLa5lynf+JsRrPmQAf41DUFQJCJEvVwK6Pgf9Rm+ZvLT0PrCEwtp4+qOfO1GSekbL+6yVBTOZPxZrXP84vSx7gYRdLgG9y6AHMYOmkyCKGkq7B4qj43bxL2FjkjGTxgGt0wFURzvmOk6Ob5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447718; c=relaxed/simple;
	bh=DkzXOO64SLa1CEcGq1E7i7N2RHxWUUhHE+4zJSeNSXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gz+zBpkGUNz9cyt+Q8KY4hiomZbLpH010Kk2eXGjYLBKKws3FYBfXonsNVdmOigVS0Vc+cxMDr0miGd7GSXVjx3vOV4vfu1Nfu/6072uzEM92SJKAb7/XhpX01+JgBiIs+7uI/CDFkNoIqcbcJ6aNKYJ6GQSdlNJmn/cCFm93BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaszPb+v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaszPb+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92226C4AF09;
	Fri, 23 Aug 2024 21:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724447717;
	bh=DkzXOO64SLa1CEcGq1E7i7N2RHxWUUhHE+4zJSeNSXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QaszPb+vaUVvWuE2DRZp5kCrLS+hlEqGHJfKBZ3MOe3eLi9Z8CrreKOSnqTW1vvdC
	 zDvys+w7qOTBkui2HcNri7fe+WH2a+6UbWf43QMmcsTmpj8Gsqfq28KLiytQTM1ABW
	 P1x+QAgHsjcl1GwfLussyEosiJTZH67puX2tFbM377JZcNMboIT0SUozTb5W8k7+Q0
	 XodxgrNoWSvq9NdDH7wgRI/HtfKJgh/z1/12E13edOLwez7h8yMbaP6UEP5F9xNYCr
	 UKylE0dWHpYphUXYW7D+FqRvrSO0wkgvF2em6QUceJmCCzX47YswNylgTTXaGlIstt
	 YFo3FNAAZhYUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2F8A7CE14F4; Fri, 23 Aug 2024 14:15:17 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	riel@surriel.com,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/4] rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()
Date: Fri, 23 Aug 2024 14:15:15 -0700
Message-Id: <20240823211516.2984627-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <415b108b-1046-4027-aa2a-c829b77f39f6@paulmck-laptop>
References: <415b108b-1046-4027-aa2a-c829b77f39f6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit pushes the grace-period-end checks further down into
rcu_dump_cpu_stacks(), and also uses lockless checks coupled with
finer-grained locking.

The result is that the current leaf rcu_node structure's ->lock is
acquired only if a stack backtrace might be needed from the current CPU,
and is held across only that CPU's backtrace.  As a result, if there are
no stalled CPUs associated with a given rcu_node structure, then its
->lock will not be acquired at all.  On large systems, it is usually
(though not always) the case that a small number of CPUs are stalling
the current grace period, which means that the ->lock need be acquired
only for a small fraction of the rcu_node structures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 9c8eb4b8dfb33..ab6848baba4f6 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -341,20 +341,24 @@ static void rcu_dump_cpu_stacks(unsigned long gp_seq)
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp) {
-		if (gp_seq != rcu_state.gp_seq) {
-			pr_err("INFO: Stall ended during stack backtracing.\n");
-			return;
-		}
 		printk_deferred_enter();
-		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		for_each_leaf_node_possible_cpu(rnp, cpu)
+		for_each_leaf_node_possible_cpu(rnp, cpu) {
+			if (gp_seq != data_race(rcu_state.gp_seq)) {
+				printk_deferred_exit();
+				pr_err("INFO: Stall ended during stack backtracing.\n");
+				return;
+			}
+			if (!(data_race(rnp->qsmask) & leaf_node_cpu_bit(rnp, cpu)))
+				continue;
+			raw_spin_lock_irqsave_rcu_node(rnp, flags);
 			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
 				if (cpu_is_offline(cpu))
 					pr_err("Offline CPU %d blocking current GP.\n", cpu);
 				else
 					dump_cpu_task(cpu);
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			}
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		}
 		printk_deferred_exit();
 	}
 }
-- 
2.40.1

