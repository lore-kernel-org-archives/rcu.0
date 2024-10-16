Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28420F5AA;
	Wed, 16 Oct 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095573; cv=none; b=X6o9C53a+5rH6Ua4NaeqjYoPsRC9iaorYphILQFC2FubTgwuQsUEh+72dlZsQwzK6iHDHRIOlaJI068c3UC7rY88lRIXsTklEA5lznqPEdi5Kx80RjqSWm7XhQK53jJvQP/4N/OmvnobT0MJXblM0kpfBtGctAhO1G4yWowbOfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095573; c=relaxed/simple;
	bh=b/Ydri4xRhgAwhSosvwIWIB9nRy/kHsOi/HMFdJm+Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uqiC2Ceh7m+rWBt9Mf8l0eGV9rRvQO5BVJYRr6okVDM8cuOQwqlK1t82+pdvO4IQrj71oxtW1HygpC26w9dYPR9KBiiAV198xzCwyNjgqXpabkGwViOsX/aJH+DyjxS4rfhJoZa23TO81KI39H0C3RcEER+HOWTMkBuFHrKK63s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/+H1O2n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/+H1O2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B02C4CED0;
	Wed, 16 Oct 2024 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729095573;
	bh=b/Ydri4xRhgAwhSosvwIWIB9nRy/kHsOi/HMFdJm+Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/+H1O2nyM7yqxyhnNoIRnVbd3KlUXN5OdWSyBpJdU+tcdrBcP3H8e25dNWN5dxsU
	 WehNWhQrCXxTq7eWm96j8teeXaPSQxmmjHwAj9BrLqf9aXwttXwozD/66Uywfir4HM
	 2KGdkK5/BGWDYyYcCqUpvsz++LLnFcNg2m9XDr8Z35tdWefkK7zKlk1YXrGThlyKgl
	 Es8UE4/rd6WTfPIea9RaRgNo0oIn0i9CJJc6zD7Gacz3f5Ln6FVdLKthfqPcfw9qTc
	 OGFP/4J9Ak9APcpNAssJfObx1zgiIoUVxb/I6hEm8OYYzDHRoQpSABpCRWvFwSwZF/
	 dDBda1fD3S0kQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EBDFFCE0F9A; Wed, 16 Oct 2024 09:19:32 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v2 rcu 3/3] rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()
Date: Wed, 16 Oct 2024 09:19:31 -0700
Message-Id: <20241016161931.478592-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
References: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
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
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_stall.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b530844becf85..8994391b95c76 100644
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
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			}
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		}
 		printk_deferred_exit();
 	}
 }
-- 
2.40.1

