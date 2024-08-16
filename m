Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19612C54B;
	Fri, 16 Aug 2024 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791102; cv=none; b=Fye3uOfY1ZkDakjcCjHbwOF344zj49aoUR8nLtcj2ZxKIySV5pCRnFHr0Fx+zRTbl2A1LCfXUYc4qB8c/wBcez3pUd6p6n5fPdMgg7UHCGYY/3l0Te/fYO6H36qZyER4xfPk/kz8QSutXLEKsExltszGyMVj9KuSnvYE6F1nqCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791102; c=relaxed/simple;
	bh=KkDJYH3rH2rJUD9sYZd1IWM6+Gk+sX8bQc9VkZJuQM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CrkJbJO9bhFl4vSHALITv22pTas7nj+/bH6/xXsC++kDJnJuo8su8TGkYmHEW0QdTmmkxGrNPEjkHJcFYEeFGSqPw5O93VVp1K1mvKLzlj9ZmMKioGwZqa/0045N1JC3i9XmlY45J2gLGXNFkAzMf1mbm5Cr/+ggggOVDEYUikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY15I7/q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY15I7/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE63DC4AF0F;
	Fri, 16 Aug 2024 06:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791102;
	bh=KkDJYH3rH2rJUD9sYZd1IWM6+Gk+sX8bQc9VkZJuQM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UY15I7/qzUnEx4mqauQWDzX5wnzBYK20U4WEBn6jjHxx6LVMlzw76recGrSTlyHiR
	 EQXyBIdmZYWLNEyLJfBPmcaV6FuiBz589RibyaAxjhy1PtytuCQkXspYVhJTY1Je5C
	 pEQjUgh5n2ub4JOHDjvXrIS9bIPUEAMbMAakuORpcjxTahJjftY1O6ShzzCrbSz6zS
	 e3XseIU/9K2/WICiYCmOrmh1ox+ouA6lhCjuSuMVm754LtmqFPmL7bwC4dduKoKlOp
	 Gktwf3ipGwo6DRY2A7a1b9fpK5LlHCn7llfQ/b4saQOhfleWYimDXHtlS1XojknCI0
	 Wgn+fzEDTXfXA==
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
Subject: [PATCH rcu 11/12] rcu/tasks: Add detailed grace-period and barrier diagnostics
Date: Fri, 16 Aug 2024 12:19:20 +0530
Message-Id: <20240816064921.57645-11-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816064730.GA56949@neeraj.linux>
References: <20240816064730.GA56949@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds rcu_tasks_torture_stats_print(),
rcu_tasks_trace_torture_stats_print(), and
rcu_tasks_rude_torture_stats_print() functions that provide detailed
diagnostics on grace-period, callback, and barrier state.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/rcupdate.h |  3 ++
 kernel/rcu/tasks.h       | 66 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 31e679c7110e..17463e95b6ef 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -164,6 +164,7 @@ static inline void rcu_nocb_flush_deferred_wakeup(void) { }
 	} while (0)
 void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks(void);
+void rcu_tasks_torture_stats_print(char *tt, char *tf);
 # else
 # define rcu_tasks_classic_qs(t, preempt) do { } while (0)
 # define call_rcu_tasks call_rcu
@@ -190,6 +191,7 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
 			rcu_tasks_trace_qs_blkd(t);				\
 		}								\
 	} while (0)
+void rcu_tasks_trace_torture_stats_print(char *tt, char *tf);
 # else
 # define rcu_tasks_trace_qs(t) do { } while (0)
 # endif
@@ -202,6 +204,7 @@ do {									\
 
 # ifdef CONFIG_TASKS_RUDE_RCU
 void synchronize_rcu_tasks_rude(void);
+void rcu_tasks_rude_torture_stats_print(char *tt, char *tf);
 # endif
 
 #define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t, false)
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d44abcd656d6..5f6d80ce1e47 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -714,9 +714,7 @@ static void __init rcu_tasks_bootup_oddness(void)
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
-#endif /* #ifndef CONFIG_TINY_RCU */
 
-#ifndef CONFIG_TINY_RCU
 /* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
 static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 {
@@ -750,6 +748,52 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		rtp->lazy_jiffies,
 		s);
 }
+
+/* Dump out more rcutorture-relevant state common to all RCU-tasks flavors. */
+static void rcu_tasks_torture_stats_print_generic(struct rcu_tasks *rtp, char *tt,
+						  char *tf, char *tst)
+{
+	cpumask_var_t cm;
+	int cpu;
+	bool gotcb = false;
+	unsigned long j = jiffies;
+
+	pr_alert("%s%s Tasks%s RCU g%ld gp_start %lu gp_jiffies %lu gp_state %d (%s).\n",
+		 tt, tf, tst, data_race(rtp->tasks_gp_seq),
+		 j - data_race(rtp->gp_start), j - data_race(rtp->gp_jiffies),
+		 data_race(rtp->gp_state), tasks_gp_state_getname(rtp));
+	pr_alert("\tEnqueue shift %d limit %d Dequeue limit %d gpseq %lu.\n",
+		 data_race(rtp->percpu_enqueue_shift),
+		 data_race(rtp->percpu_enqueue_lim),
+		 data_race(rtp->percpu_dequeue_lim),
+		 data_race(rtp->percpu_dequeue_gpseq));
+	(void)zalloc_cpumask_var(&cm, GFP_KERNEL);
+	pr_alert("\tCallback counts:");
+	for_each_possible_cpu(cpu) {
+		long n;
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
+
+		if (cpumask_available(cm) && !rcu_barrier_cb_is_done(&rtpcp->barrier_q_head))
+			cpumask_set_cpu(cpu, cm);
+		n = rcu_segcblist_n_cbs(&rtpcp->cblist);
+		if (!n)
+			continue;
+		pr_cont(" %d:%ld", cpu, n);
+		gotcb = true;
+	}
+	if (gotcb)
+		pr_cont(".\n");
+	else
+		pr_cont(" (none).\n");
+	pr_alert("\tBarrier seq %lu count %d holdout CPUs ",
+		 data_race(rtp->barrier_q_seq), atomic_read(&rtp->barrier_q_count));
+	if (cpumask_available(cm) && !cpumask_empty(cm))
+		pr_cont(" %*pbl.\n", cpumask_pr_args(cm));
+	else
+		pr_cont("(none).\n");
+	free_cpumask_var(cm);
+}
+
 #endif // #ifndef CONFIG_TINY_RCU
 
 static void exit_tasks_rcu_finish_trace(struct task_struct *t);
@@ -1201,6 +1245,12 @@ void show_rcu_tasks_classic_gp_kthread(void)
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks, "");
 }
 EXPORT_SYMBOL_GPL(show_rcu_tasks_classic_gp_kthread);
+
+void rcu_tasks_torture_stats_print(char *tt, char *tf)
+{
+	rcu_tasks_torture_stats_print_generic(&rcu_tasks, tt, tf, "");
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_torture_stats_print);
 #endif // !defined(CONFIG_TINY_RCU)
 
 struct task_struct *get_rcu_tasks_gp_kthread(void)
@@ -1361,6 +1411,12 @@ void show_rcu_tasks_rude_gp_kthread(void)
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
 }
 EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
+
+void rcu_tasks_rude_torture_stats_print(char *tt, char *tf)
+{
+	rcu_tasks_torture_stats_print_generic(&rcu_tasks_rude, tt, tf, "");
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_rude_torture_stats_print);
 #endif // !defined(CONFIG_TINY_RCU)
 
 struct task_struct *get_rcu_tasks_rude_gp_kthread(void)
@@ -2038,6 +2094,12 @@ void show_rcu_tasks_trace_gp_kthread(void)
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
 }
 EXPORT_SYMBOL_GPL(show_rcu_tasks_trace_gp_kthread);
+
+void rcu_tasks_trace_torture_stats_print(char *tt, char *tf)
+{
+	rcu_tasks_torture_stats_print_generic(&rcu_tasks_trace, tt, tf, "");
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_trace_torture_stats_print);
 #endif // !defined(CONFIG_TINY_RCU)
 
 struct task_struct *get_rcu_tasks_trace_gp_kthread(void)
-- 
2.40.1

