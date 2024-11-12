Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93D8200133;
	Tue, 12 Nov 2024 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422247; cv=none; b=Cgl52mhqn4Gy5qkDuFY1djEaXW/3anjnclgybaGg9qD00LanWpuRvz92vqLM1h83rkhW1LLwxxQJSdTXLE7fqG3yOfanzNAMOlQYSDH7Wq0HTtVi1kb3K8Z1ctDEa236zicqaplrb6LZWDG46QYOVVaxMWuvFqaPq3s7jhSTZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422247; c=relaxed/simple;
	bh=2S3GF9YgOUVpSAFE9yXBXJbkzVZbHzXUYGcIPmCPbZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lemDlobhfEwA5M6n33CGZbTn1SEEtzy/WrwZKrVSt2a/KctboSYY/zGsey2r7R0ORTs7D9qfRnWS6FGw0/lZ3Js8Phk6hKkAN/7xNbSpuANxGOQqKKpSwk05q3qj0iS4ilZ2vAMko9FRms6NwA6pMm4laBqhxnWW6qF5HAPtgIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2Mn6xzC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2Mn6xzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B26C4CED0;
	Tue, 12 Nov 2024 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731422247;
	bh=2S3GF9YgOUVpSAFE9yXBXJbkzVZbHzXUYGcIPmCPbZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2Mn6xzCC22m1WxtxUGNvC2lSrvLRNlRgjRuhrdlOyrUOIZnLSVP/Yo8k6WcGze6j
	 9Ka9JBu64D+JMdH1PueyIoUUZ7Ewhn+9XydE01xmBhQSbYrvI14/RUqaLpGiMUfZSo
	 ICkvifnHUUskFbqBVJBqCmnrYzAlAc12Scwz1WFNzzQbJRRzYNmSM3btCBo4Imvvzu
	 NyK0w8YG1qwmtjE2AaU2W/InanaH9tRBAsxwvsjYCC4vrnInjCKMsYJXngjaxmDOzu
	 r0UJhz50sJdUeYTgJE9dwar3Kmcg4s0z/wsFvHzjx3PXfMyvIqI7vg5TkA8whm/jXn
	 mvaFriSbpmkBQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 3/3] rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()
Date: Tue, 12 Nov 2024 15:37:11 +0100
Message-ID: <20241112143711.21239-4-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112143711.21239-1-frederic@kernel.org>
References: <20241112143711.21239-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

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

[ paulmck: Apply Dan Carpenter feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_stall.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b530844becf8..925fcdad5dea 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -342,20 +342,24 @@ static void rcu_dump_cpu_stacks(unsigned long gp_seq)
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp) {
-		if (gp_seq != data_race(rcu_state.gp_seq)) {
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
 			}
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		}
 		printk_deferred_exit();
 	}
 }
-- 
2.46.0

