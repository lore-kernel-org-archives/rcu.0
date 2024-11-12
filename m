Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175A1FF7CF;
	Tue, 12 Nov 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422244; cv=none; b=L7oxWYfCRAen19+aGWH8bQ4BwmrQV8g2UPiGnpniF5lWGv4K4cIPssj0hOv8lCNwuEL6EQhgIlQ84JVjFQE0N6vI5+iBXDIyF582EydNHSLFuD4n1xRzwVA45jzNz6xjPHvc7bLdPOoL9H7rFYPxafLoatrcu6tTcghxQszeiJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422244; c=relaxed/simple;
	bh=MBalVYHu+YCpiyEjXv1rcDKHPByokIPNarfrKVTvbcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLL7QUWtbpgSLyE1ilYbsK55gP7HsjJ4LDIv/gnRo9sUtdnwJ8Hgq/Owktyn0tkdxdvSZB5O3P5s11Iiz1G+tZaBOexa2F2/qer09glrQtRzCxAVHeULyDCLv5H1pBBXYGWtDg8unNC+0RloFJbsaB/oCp6u4gd/Yy/QcB38qUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV6VTGJx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV6VTGJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA61C4CEDB;
	Tue, 12 Nov 2024 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731422244;
	bh=MBalVYHu+YCpiyEjXv1rcDKHPByokIPNarfrKVTvbcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XV6VTGJx3sVmn30yYPcPxIfsDI7uTGEFpf5WhC+FMNxH4TVUSy2Ju3gRNA88hppVv
	 8n0OP9bsJ2LxG4g0rRynF1hjifAaNgn2qzLWSlL4ddAgAi6ZI/1t9puf59psPqPSWP
	 W2U5HoGgo8TYm0UyY9uBQd7oUGbTLMHeg2WPbp0Y6RwN/NVH+sdlc+KX7+9DktA9hZ
	 PhA3UogJtR7qHAha32ecarjsxkmaTCic4LQx2eSMXs3JLsLoJ8YVXKEXycIdzwg6x/
	 jVbxf9k3NVBOjChYLo053Xahdlf6rgSGvZJyUfZ7oksXH1Rj6r2X3YN4ylxuNX65Aj
	 BZXWKoHWcwlzA==
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
Subject: [PATCH 2/3] rcu: Stop stall warning from dumping stacks if grace period ends
Date: Tue, 12 Nov 2024 15:37:10 +0100
Message-ID: <20241112143711.21239-3-frederic@kernel.org>
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

Currently, once an RCU CPU stall warning decides to dump the stalling
CPUs' stacks, the rcu_dump_cpu_stacks() function persists until it
has gone through the full list.  Unfortunately, if the stalled grace
periods ends midway through, this function will be dumping stacks of
innocent-bystander CPUs that happen to be blocking not the old grace
period, but instead the new one.  This can cause serious confusion.

This commit therefore stops dumping stacks if and when the stalled grace
period ends.

[ paulmck: Apply Joel Fernandes feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_stall.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d7cdd535e50b..b530844becf8 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -335,13 +335,17 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
  * that don't support NMI-based stack dumps.  The NMI-triggered stack
  * traces are more accurate because they are printed by the target CPU.
  */
-static void rcu_dump_cpu_stacks(void)
+static void rcu_dump_cpu_stacks(unsigned long gp_seq)
 {
 	int cpu;
 	unsigned long flags;
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp) {
+		if (gp_seq != data_race(rcu_state.gp_seq)) {
+			pr_err("INFO: Stall ended during stack backtracing.\n");
+			return;
+		}
 		printk_deferred_enter();
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		for_each_leaf_node_possible_cpu(rnp, cpu)
@@ -608,7 +612,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen,
 	       data_race(rcu_state.n_online_cpus)); // Diagnostic read
 	if (ndetected) {
-		rcu_dump_cpu_stacks();
+		rcu_dump_cpu_stacks(gp_seq);
 
 		/* Complain about tasks blocking the grace period. */
 		rcu_for_each_leaf_node(rnp)
@@ -640,7 +644,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	rcu_force_quiescent_state();  /* Kick them all. */
 }
 
-static void print_cpu_stall(unsigned long gps)
+static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
 	int cpu;
 	unsigned long flags;
@@ -677,7 +681,7 @@ static void print_cpu_stall(unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
-	rcu_dump_cpu_stacks();
+	rcu_dump_cpu_stacks(gp_seq);
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	/* Rewrite if needed in case of slow consoles. */
@@ -759,7 +763,8 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	gs2 = READ_ONCE(rcu_state.gp_seq);
 	if (gs1 != gs2 ||
 	    ULONG_CMP_LT(j, js) ||
-	    ULONG_CMP_GE(gps, js))
+	    ULONG_CMP_GE(gps, js) ||
+	    !rcu_seq_state(gs2))
 		return; /* No stall or GP completed since entering function. */
 	rnp = rdp->mynode;
 	jn = jiffies + ULONG_MAX / 2;
@@ -780,7 +785,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 			pr_err("INFO: %s detected stall, but suppressed full report due to a stuck CSD-lock.\n", rcu_state.name);
 		} else if (self_detected) {
 			/* We haven't checked in, so go dump stack. */
-			print_cpu_stall(gps);
+			print_cpu_stall(gs2, gps);
 		} else {
 			/* They had a few time units to dump stack, so complain. */
 			print_other_cpu_stall(gs2, gps);
-- 
2.46.0

