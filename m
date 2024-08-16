Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDFC2E859;
	Fri, 16 Aug 2024 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788853; cv=none; b=iQ/PXCG2D+wMKEgZW7/ImAOegI2bgdVeGn4XiEiI/Vl6IhElBlk49FQQn2oKiBQUGAcUvft9G6PcAnGr+XVmFEDmhwbZSzYa11Nb9xkl79Dv/Kimn6JfH0huZVvHKTi6X51maVQwGl253gTxgQjkzAt/TcboMBlZSw+Ev5HHfr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788853; c=relaxed/simple;
	bh=kbqoRxS0REFF16B8tCthIXXPEkLqu32lnFeaTK/bu5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GBqW+uM+LepifK+WZ2f9UBfMNF1YpaElK7ZzqFU2+pme9H1bFFWYxJl8rNi0Zb/ugYY2MCQIFLye+22sfxYmX7Rv81iF2iL63FWwuDA+Dmq7dmYJGOTy8KC2lynu5Jggl0ZFGy4luamk8VQ2UAn9abnpyc9myCpLsNOapnQ6y/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6/wi1hC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6/wi1hC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAE1C32782;
	Fri, 16 Aug 2024 06:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723788853;
	bh=kbqoRxS0REFF16B8tCthIXXPEkLqu32lnFeaTK/bu5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6/wi1hCqsg2OOd1yHiqDL5iP/DW5ROEPi6QRAfuqNPiVXwq7k1JXRoo6Vv5Vc9sH
	 CyzoJBNYMta8s3WlrN3hVGdmy0ofqqNdjo0XDVdigYAw76zaEkm/fSafMo0KIWe23H
	 1alPuaY75z+ZgzcZYfWZRokx6pP5Isjs1cslGmnBgi5h/hjNPBw8H9+Wn7lA3iAnZw
	 35j3r9MMwXZdimmW8ZhW3cypa+3/D0z/oR++6FtzFR0rTc/yEzyDx1wRYfjgcyu9V1
	 WgB6gqeUvNmPPkST+f+WD4ylPeAsZgVxLgPvDopR6QGMKjFpGbKcwdrXmFOIgh0bOu
	 D5GF8voOGxzvg==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 2/4] rcu: Extract synchronize_rcu_expedited_stall() from synchronize_rcu_expedited_wait()
Date: Fri, 16 Aug 2024 11:43:02 +0530
Message-Id: <20240816061304.48843-2-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816061050.GA46994@neeraj.linux>
References: <20240816061050.GA46994@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit extracts the RCU CPU stall-warning report code from
synchronize_rcu_expedited_wait() and places it in a new function named
synchronize_rcu_expedited_stall().  This is strictly a code-movement
commit.  A later commit will use this reorganization to avoid printing
expedited RCU CPU stall warnings while there are ongoing CSD-lock stall
reports.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree_exp.h | 111 +++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 51 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 4acd29d16fdb..17dd5169012d 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -542,6 +542,65 @@ static bool synchronize_rcu_expedited_wait_once(long tlimit)
 	return false;
 }
 
+/*
+ * Print out an expedited RCU CPU stall warning message.
+ */
+static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigned long j)
+{
+	int cpu;
+	unsigned long mask;
+	int ndetected;
+	struct rcu_node *rnp;
+	struct rcu_node *rnp_root = rcu_get_root();
+
+	pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {", rcu_state.name);
+	ndetected = 0;
+	rcu_for_each_leaf_node(rnp) {
+		ndetected += rcu_print_task_exp_stall(rnp);
+		for_each_leaf_node_possible_cpu(rnp, cpu) {
+			struct rcu_data *rdp;
+
+			mask = leaf_node_cpu_bit(rnp, cpu);
+			if (!(READ_ONCE(rnp->expmask) & mask))
+				continue;
+			ndetected++;
+			rdp = per_cpu_ptr(&rcu_data, cpu);
+			pr_cont(" %d-%c%c%c%c", cpu,
+				"O."[!!cpu_online(cpu)],
+				"o."[!!(rdp->grpmask & rnp->expmaskinit)],
+				"N."[!!(rdp->grpmask & rnp->expmaskinitnext)],
+				"D."[!!data_race(rdp->cpu_no_qs.b.exp)]);
+		}
+	}
+	pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
+		j - jiffies_start, rcu_state.expedited_sequence, data_race(rnp_root->expmask),
+		".T"[!!data_race(rnp_root->exp_tasks)]);
+	if (ndetected) {
+		pr_err("blocking rcu_node structures (internal RCU debug):");
+		rcu_for_each_node_breadth_first(rnp) {
+			if (rnp == rnp_root)
+				continue; /* printed unconditionally */
+			if (sync_rcu_exp_done_unlocked(rnp))
+				continue;
+			pr_cont(" l=%u:%d-%d:%#lx/%c",
+				rnp->level, rnp->grplo, rnp->grphi, data_race(rnp->expmask),
+				".T"[!!data_race(rnp->exp_tasks)]);
+		}
+		pr_cont("\n");
+	}
+	rcu_for_each_leaf_node(rnp) {
+		for_each_leaf_node_possible_cpu(rnp, cpu) {
+			mask = leaf_node_cpu_bit(rnp, cpu);
+			if (!(READ_ONCE(rnp->expmask) & mask))
+				continue;
+			preempt_disable(); // For smp_processor_id() in dump_cpu_task().
+			dump_cpu_task(cpu);
+			preempt_enable();
+		}
+		rcu_exp_print_detail_task_stall_rnp(rnp);
+	}
+}
+
 /*
  * Wait for the expedited grace period to elapse, issuing any needed
  * RCU CPU stall warnings along the way.
@@ -553,10 +612,8 @@ static void synchronize_rcu_expedited_wait(void)
 	unsigned long jiffies_stall;
 	unsigned long jiffies_start;
 	unsigned long mask;
-	int ndetected;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
-	struct rcu_node *rnp_root = rcu_get_root();
 	unsigned long flags;
 
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
@@ -593,55 +650,7 @@ static void synchronize_rcu_expedited_wait(void)
 		j = jiffies;
 		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_EXP, (void *)(j - jiffies_start));
 		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
-		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
-		       rcu_state.name);
-		ndetected = 0;
-		rcu_for_each_leaf_node(rnp) {
-			ndetected += rcu_print_task_exp_stall(rnp);
-			for_each_leaf_node_possible_cpu(rnp, cpu) {
-				struct rcu_data *rdp;
-
-				mask = leaf_node_cpu_bit(rnp, cpu);
-				if (!(READ_ONCE(rnp->expmask) & mask))
-					continue;
-				ndetected++;
-				rdp = per_cpu_ptr(&rcu_data, cpu);
-				pr_cont(" %d-%c%c%c%c", cpu,
-					"O."[!!cpu_online(cpu)],
-					"o."[!!(rdp->grpmask & rnp->expmaskinit)],
-					"N."[!!(rdp->grpmask & rnp->expmaskinitnext)],
-					"D."[!!data_race(rdp->cpu_no_qs.b.exp)]);
-			}
-		}
-		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
-			j - jiffies_start, rcu_state.expedited_sequence,
-			data_race(rnp_root->expmask),
-			".T"[!!data_race(rnp_root->exp_tasks)]);
-		if (ndetected) {
-			pr_err("blocking rcu_node structures (internal RCU debug):");
-			rcu_for_each_node_breadth_first(rnp) {
-				if (rnp == rnp_root)
-					continue; /* printed unconditionally */
-				if (sync_rcu_exp_done_unlocked(rnp))
-					continue;
-				pr_cont(" l=%u:%d-%d:%#lx/%c",
-					rnp->level, rnp->grplo, rnp->grphi,
-					data_race(rnp->expmask),
-					".T"[!!data_race(rnp->exp_tasks)]);
-			}
-			pr_cont("\n");
-		}
-		rcu_for_each_leaf_node(rnp) {
-			for_each_leaf_node_possible_cpu(rnp, cpu) {
-				mask = leaf_node_cpu_bit(rnp, cpu);
-				if (!(READ_ONCE(rnp->expmask) & mask))
-					continue;
-				preempt_disable(); // For smp_processor_id() in dump_cpu_task().
-				dump_cpu_task(cpu);
-				preempt_enable();
-			}
-			rcu_exp_print_detail_task_stall_rnp(rnp);
-		}
+		synchronize_rcu_expedited_stall(jiffies_start, j);
 		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
 		panic_on_rcu_stall();
 	}
-- 
2.40.1

