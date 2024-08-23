Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06141917D0;
	Fri, 23 Aug 2024 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447717; cv=none; b=e7HvDNexbMMwbNA6MKL9WdjVzoFEOEn73HOC4rWLnzniz5MkkAGH0IRZNI90MhFf5t/KfRWt258DHiF6ClEEVcrdiHeqf8HxZTKB/ScXz/dBSbwbEI+WNGoFjHZZGdsteL1Cdf4S0731flwWQc9RZ4uhqBpsvngqgp++Gamyl5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447717; c=relaxed/simple;
	bh=0OOpu3k8NVeX3ztovi2iVp34wCer+lJEp1NxMQDNF5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hYQ+VbLw4avThni9ma23gTT1gJ42k76LaFRu8P/leDgQUzWDxVwaUtJbt3bwMv3jlA0Ssr5UyyNHnsHnPbMAOmC5QP8xVGJu6A93GVBn/Pma1UfDIFv9LZt5ugDD73EhYiQ4RCxFqRu176KjSjD/l8N3Smms8fNeN6VVgrXjMMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyBNbByL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyBNbByL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C00BC4AF0F;
	Fri, 23 Aug 2024 21:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724447717;
	bh=0OOpu3k8NVeX3ztovi2iVp34wCer+lJEp1NxMQDNF5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyBNbByLTboUUxyoghpARnEOAVGkfnWMg28grrezR1JRsPMayVkZqa9C5wmirrHdZ
	 uWL5I1cFWEGoRMXfmTldgmEH/ZpuJwWzNemT7Yx3B8jbVG6CkYWxLdmFzLSAb1YxRb
	 Wbf0cpDEiKlhii+yCeZ4CGU+cVcdfvdLitJSpsq6YNHkMPw8jaStK8Ukl+f4cQIARS
	 4k79oaeLMrXX8YJ0uezQqeh6A7vOdK+oaxm+NXMzhUXEyApO0ELFTkoGoLj/i9dTqD
	 WtL/cyM+F+h54lgQBOFqgkL/FjEAO4kErjEKCvWfng1MjvVYEM7lXOhZne23DfT0qF
	 D29xK4H1NuJNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2D0D6CE1257; Fri, 23 Aug 2024 14:15:17 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	riel@surriel.com,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/4] rcu: Stop stall warning from dumping stacks if grace period ends
Date: Fri, 23 Aug 2024 14:15:14 -0700
Message-Id: <20240823211516.2984627-3-paulmck@kernel.org>
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
index ed065e3ce5c33..9c8eb4b8dfb33 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -334,13 +334,17 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
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
@@ -605,7 +609,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen,
 	       data_race(rcu_state.n_online_cpus)); // Diagnostic read
 	if (ndetected) {
-		rcu_dump_cpu_stacks();
+		rcu_dump_cpu_stacks(gp_seq);
 
 		/* Complain about tasks blocking the grace period. */
 		rcu_for_each_leaf_node(rnp)
@@ -635,7 +639,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	rcu_force_quiescent_state();  /* Kick them all. */
 }
 
-static void print_cpu_stall(unsigned long gps)
+static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
 	int cpu;
 	unsigned long flags;
@@ -670,7 +674,7 @@ static void print_cpu_stall(unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
-	rcu_dump_cpu_stacks();
+	rcu_dump_cpu_stacks(gp_seq);
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	/* Rewrite if needed in case of slow consoles. */
@@ -750,7 +754,8 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	gs2 = READ_ONCE(rcu_state.gp_seq);
 	if (gs1 != gs2 ||
 	    ULONG_CMP_LT(j, js) ||
-	    ULONG_CMP_GE(gps, js))
+	    ULONG_CMP_GE(gps, js) ||
+	    !rcu_seq_state(gs2))
 		return; /* No stall or GP completed since entering function. */
 	rnp = rdp->mynode;
 	jn = jiffies + ULONG_MAX / 2;
@@ -771,7 +776,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
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

