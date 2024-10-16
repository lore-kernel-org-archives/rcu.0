Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21012DD8A;
	Wed, 16 Oct 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095573; cv=none; b=ftCHgdyculIDPth71+AOHZuMfIzUQ22CWoIwRPlrvyz2WA9R9sdEpW1oGkHyMTBqLWPvXLElRVtMxjDLrc3AsKZr/Ii2X87POCpvitjDSExEt6yg4R7+tY5JSZkAg0RVvcZlJ++TPR1Q70dU3FfeQMHX+XA87wcrpuX75+yNOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095573; c=relaxed/simple;
	bh=sZq/5H24e81CBhBGj1qplbJtZ3lHNc2VHN4b3D53dts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eoobXB+FuPARnbgj5wkavvq0Mxw6IlPiqDvZ3iMHXYQ4IrFa7L0oltjQ0nGDX2EzpF/lvSI29QrVf4dbbArmAnTFX/Kw4R3YARq8bKh0nvdbf2CgQ4ioFtSHqGZV0Gwg/xDSzsCkIxeduHw4zbmzjMcQ75Tdt/C5asEc2t3T6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/GQfDlm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/GQfDlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AD6C4CECE;
	Wed, 16 Oct 2024 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729095573;
	bh=sZq/5H24e81CBhBGj1qplbJtZ3lHNc2VHN4b3D53dts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/GQfDlmviXmVr3f7aUo+z0kFYhW8H4L73q/kJMtUCxvREasPDUVw/2gjNbjZxXhv
	 WsbtNww5N+tY007vAUjU6BQi8IFI5vD7FyQ0NEXyFtFnk9dxbRYB6vxvIjBrW5CMJX
	 UsFlTilRPHE+g3uHouVr2cg3+MIx3Mg48Ou3orX55hiJwnf81MMBxhofsSQ2V+qwZO
	 P6SJBK9XGfu+W55AdLaixs97D2IJ+ifodf5R+4EoXuiKJNNuD2etglzbItJOaB2VF8
	 ti3PUreUpuRBU4ZtIikV0w9XIrLGO9BLAQjJxpkmeQL/LmIyTgX7yIbW4/3y9RkOAy
	 TL/SGPqU2vYoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E9209CE0E98; Wed, 16 Oct 2024 09:19:32 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 rcu 2/3] rcu: Stop stall warning from dumping stacks if grace period ends
Date: Wed, 16 Oct 2024 09:19:30 -0700
Message-Id: <20241016161931.478592-2-paulmck@kernel.org>
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
---
 kernel/rcu/tree_stall.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d7cdd535e50b1..b530844becf85 100644
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
2.40.1

