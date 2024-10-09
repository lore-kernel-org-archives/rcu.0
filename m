Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1A1DEFCE;
	Wed,  9 Oct 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497111; cv=none; b=TEmoAgrQE1sRCr9dHy+yVChJofxetndKihZJafVvqXZVdamp9EBovGV8YDyVCr6cmMmnTGcNg6Cp+xmS995Fyjnh1UhIKk2Zbxd0s/VHiEouOBYfZbksfeVUqPq42eZlabuS1QsCtaFSS3KWBpOghYcnS0X0/DZDUaP/YRjJAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497111; c=relaxed/simple;
	bh=36w1sLkGTystT8QKSFmDo6WwK0sm86D4acqxrcVO96I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eo+Asd/B90H5eotMTmZZPegxlV3QnnAv1VuMPdQLdRzhd3xAnYbVtz6U0lkDSohCzoNlCz/UUjNE2CYiJsUgfBEkPBBOU8+JuQx9cy7eroM3js2laGhRIHVxvkB11W3GKN30DbHv7MiVMsHXvnl573WMVud7nuUYiNpQzfiJymU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpuY5n88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpuY5n88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7CEC4CECC;
	Wed,  9 Oct 2024 18:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497111;
	bh=36w1sLkGTystT8QKSFmDo6WwK0sm86D4acqxrcVO96I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpuY5n889I+dtV8LsUtX7+9lDFdvqD47WRXhGQ0kgXn1lz39zCKJ0TYBM1yUA0DGN
	 Sub6OjB9pPxLFy9vCZfbv9DOZ6M/nuqnnz3j3WkrS/y+1M8CIpfMIFsRv0sKXxGQkh
	 icD2eXMdQ4gCyow/XLzAecX8ChX+araKkFPmFJR1mbmoDLV8hQi0m0kFUn+1acTxox
	 Fcs73xOVvxsagW1NIm6/3unVKEQtPXX/OUUGPqfZhJXLIrMg/Vla+IG1Y6qvfjGWxH
	 oMpd0B1R0NtcKffJh2XfC8ELNxTk5wSjQds7LdNEAP9ACf8wv9yw1TrYWXqUPH+WsW
	 fAxb8VSQWHhDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EFC3ECE0B68; Wed,  9 Oct 2024 11:05:10 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/3] rcu: Stop stall warning from dumping stacks if grace period ends
Date: Wed,  9 Oct 2024 11:05:08 -0700
Message-Id: <20241009180509.778133-2-paulmck@kernel.org>
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

Currently, once an RCU CPU stall warning decides to dump the stalling
CPUs' stacks, the rcu_dump_cpu_stacks() function persists until it
has gone through the full list.  Unfortunately, if the stalled grace
periods ends midway through, this function will be dumping stacks of
innocent-bystander CPUs that happen to be blocking not the old grace
period, but instead the new one.  This can cause serious confusion.

This commit therefore stops dumping stacks if and when the stalled grace
period ends.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d7cdd535e50b1..9d79133377ff6 100644
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
+		if (gp_seq != rcu_state.gp_seq) {
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

