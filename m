Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18FF19DF66;
	Wed,  9 Oct 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497111; cv=none; b=Qw6KwTB+gux4dGwFYMMUZYYoLPl1hk8iVtQAAP1QQIz2VmJHKQUbuxmL8+rbrFpZF+mVh/QglLtTQ6u5KuZlD83RixYkxwdiUEy56RqOi8i0q5TtUN19tb6R2t4mbdMOTVo4Lehw/+j5cDtkvnNmWSuPuoiqzqH+sOFfQ1a7T/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497111; c=relaxed/simple;
	bh=LXGw5NZfIRWF05WERyYwMt48zLZsjeoEitaRbfqAzcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gu25mGNqOv5eqhctsXWHsd5oA603TUSQKIO16FP1oMk5vBFqnpJ1Zpz+f3vsGT+APhxofPTaGVbSSJ/nlSzof1nPNa9e9VuWMAfUMvrORudWtN6W42PO6bJVJqzFZfuHkB1FO1BGlwhXKF4tQ/1ksU37oYva/fD9G/4rRvuBl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2H09bcq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2H09bcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A051C4CECF;
	Wed,  9 Oct 2024 18:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497111;
	bh=LXGw5NZfIRWF05WERyYwMt48zLZsjeoEitaRbfqAzcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c2H09bcquVszeNTbbwLGvSRoTwW5NnJAkcpb8ZXUJA0IHbjvKgY3310QyyONKr+dq
	 4WYyZQIjbN/yq23dNmfr4lRC/XTojre+vsa37/zMN8MSI97UHczXq21VmwdU4u4DTb
	 j8RXIb3mBQAxONX2px8eIoYSt35K17bWjsaRMFHx+4ttZ/kG6rnsV7XCggtcgEgO5b
	 4j4ptCTvyhjIIzgUN6LNqnDyc4pnP7j/qVwRrBKpMAt6WHqcNgyBTs9Sr1J+IuJAUY
	 aoiNv9n9+pbyWM0lLyjq5TY7Xd27FirsABBFmgWpRu57Y1ZXXA0qcKqFoqjHJcZI7h
	 sP1nIQEr/8sOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F2DC8CE0BB1; Wed,  9 Oct 2024 11:05:10 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/3] rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()
Date: Wed,  9 Oct 2024 11:05:09 -0700
Message-Id: <20241009180509.778133-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <fb0b7a92-d371-4510-80c4-25a57f2c4f3d@paulmck-laptop>
References: <fb0b7a92-d371-4510-80c4-25a57f2c4f3d@paulmck-laptop>
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
index 9d79133377ff6..8994391b95c76 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -342,20 +342,24 @@ static void rcu_dump_cpu_stacks(unsigned long gp_seq)
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

