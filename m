Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E8EAE9;
	Fri,  2 Aug 2024 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558868; cv=none; b=dkXQgm20L/gqSXaboZavZerl6H4Xrjk/eyYedM4tMI5GwRzQykrSY0EdbMc5EJ6ChpdLA/emYV24K4EQt2XQXA6GhrZZPI7XWJX+2Y27RWwClY8o+02e9rX3pM9L6EWWBpDRyskv4SJqJ1Giy4mXDGroENDlUxOQMm84cwzkBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558868; c=relaxed/simple;
	bh=S/VfjVcS8Be7DWVforJ3o2DzecpeB4W6woz2WULZdnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=daaJh66q2TkTKlgZCRX/mbbh9+GhtTxs3kfv6+fWtrKqNoBc11g5yXUQaBv+lXI0kTfy2X6e3S1B8L/PXnAtJWDWkScf473ePbTpGDPA/JWVBf5cl3W8Ne7EGILwMw95mgSkp6vxB3kgOaaKnlwVLJWjTldlJsgqPhjuDM/8fGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiZjm0+N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiZjm0+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B17EC4AF0F;
	Fri,  2 Aug 2024 00:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558868;
	bh=S/VfjVcS8Be7DWVforJ3o2DzecpeB4W6woz2WULZdnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PiZjm0+Nn936+7RteanWAYOc+FAWLt5WdjGPvXFL23bqd8ilawnnad6hCMAVUL+oZ
	 UEbLTRXIf/BbdM+/Uhf2z+Oo0aGb50mcn+2Ub6DiD5mu3Buq0tV5iZq4HAXRd1bH2Q
	 5rlM7ycyTC4TS7XEL+1JSa8s45Nr4BqXGVgxemcf87U/9Oz0+Ojf289aZ5rsqZiHJv
	 Y/w0SKskEbtIeD+8rDSoIo2DD+cysxPoxd3gIH/IyfvTIbrGGL8IBAyxxeR2YoenjP
	 PGp+ewpatxofqipKySdwGrLG1vidB2VczT8k7EQuT0lKnxeI99Nx6o2ixocnLKzJnN
	 ds+aZ6kHmHOxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ECB4BCE0F69; Thu,  1 Aug 2024 17:34:27 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/6] rcu/tasks: Add detailed grace-period and barrier diagnostics
Date: Thu,  1 Aug 2024 17:34:25 -0700
Message-Id: <20240802003426.4134196-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
References: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds rcu_tasks_torture_stats_print(),
rcu_tasks_trace_torture_stats_print(), and
rcu_tasks_rude_torture_stats_print() functions that provide detailed
diagnostics on grace-period, callback, and barrier state.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |  3 ++
 kernel/rcu/tasks.h       | 63 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index e40a726fe1a03..58d84c59f3dda 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -174,6 +174,7 @@ static inline void rcu_nocb_flush_deferred_wakeup(void) { }
 	} while (0)
 void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks(void);
+void rcu_tasks_torture_stats_print(char *tt, char *tf);
 # else
 # define rcu_tasks_classic_qs(t, preempt) do { } while (0)
 # define call_rcu_tasks call_rcu
@@ -200,6 +201,7 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
 			rcu_tasks_trace_qs_blkd(t);				\
 		}								\
 	} while (0)
+void rcu_tasks_trace_torture_stats_print(char *tt, char *tf);
 # else
 # define rcu_tasks_trace_qs(t) do { } while (0)
 # endif
@@ -212,6 +214,7 @@ do {									\
 
 # ifdef CONFIG_TASKS_RUDE_RCU
 void synchronize_rcu_tasks_rude(void);
+void rcu_tasks_rude_torture_stats_print(char *tt, char *tf);
 # endif
 
 #define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t, false)
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6f1e82e548bbc..37597f7c581ca 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -712,9 +712,7 @@ static void __init rcu_tasks_bootup_oddness(void)
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
-#endif /* #ifndef CONFIG_TINY_RCU */
 
-#ifndef CONFIG_TINY_RCU
 /* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
 static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 {
@@ -748,6 +746,52 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
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
@@ -1199,6 +1243,11 @@ void show_rcu_tasks_classic_gp_kthread(void)
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks, "");
 }
 EXPORT_SYMBOL_GPL(show_rcu_tasks_classic_gp_kthread);
+void rcu_tasks_torture_stats_print(char *tt, char *tf)
+{
+	rcu_tasks_torture_stats_print_generic(&rcu_tasks, tt, tf, "");
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_torture_stats_print);
 #endif // !defined(CONFIG_TINY_RCU)
 
 struct task_struct *get_rcu_tasks_gp_kthread(void)
@@ -1360,6 +1409,11 @@ void show_rcu_tasks_rude_gp_kthread(void)
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
 }
 EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
+void rcu_tasks_rude_torture_stats_print(char *tt, char *tf)
+{
+	rcu_tasks_torture_stats_print_generic(&rcu_tasks_rude, tt, tf, "");
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_rude_torture_stats_print);
 #endif // !defined(CONFIG_TINY_RCU)
 
 struct task_struct *get_rcu_tasks_rude_gp_kthread(void)
@@ -2037,6 +2091,11 @@ void show_rcu_tasks_trace_gp_kthread(void)
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
 }
 EXPORT_SYMBOL_GPL(show_rcu_tasks_trace_gp_kthread);
+void rcu_tasks_trace_torture_stats_print(char *tt, char *tf)
+{
+	rcu_tasks_torture_stats_print_generic(&rcu_tasks_trace, tt, tf, "");
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_trace_torture_stats_print);
 #endif // !defined(CONFIG_TINY_RCU)
 
 struct task_struct *get_rcu_tasks_trace_gp_kthread(void)
-- 
2.40.1

