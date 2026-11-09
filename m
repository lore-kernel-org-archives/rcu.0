Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262781;
	b=tl2sjpmvSsliryLPE+LqfSYhwBtCPOE3uwkVY1eQtYHi70yoF97KLU4C9PY58oYDAoQm
	 NwHyniMbLVPekKrNnz8dMUKcmks3TxLyYZ8pYD2dsRbLQpTFxzugf2noFCZI82mbl0r02
	 bNz4uYuE15jd6uMQj/trUh2X2rNpodTvkcAAlTgtW2utua0b2n+IuFtX6tYv6dI+addCQ
	 Bo1e2nKN/KI61hqWJI2/5ySkmdrxsr5lPxBRAnCvbcFa3GeCunI3VbaWQAO5uZLX5IONb
	 tx5lNndsN60D/ddtS7dUALj+ENBlPF3jL7K0aQXziNLlbAPWZTZB7xzF4JxG94JDLCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262781;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nzlBDH+htcsbY5WgGNXKIA3VuC4acyNgviDGnFeoE2c=;
	b=fl65mXmUsN7rybmwErtIbX61ADdtarUXJA/M+7zQj/HYQRmsTL4Z4VzirKFMdZIOmReo
	 2bpAy9xlCAC8toLA+rFc6W0NneKwUI0gZzaAgOVV3HHZhhyTEqZBSgjPz2HPXXBeJbE2J
	 nltEzP9FWB51kTN1n5gWJdGi3sL7O1GjMoKFxFepHUlZdKpbyTdQ82gVgo3j5kacCyT+c
	 2FaVosgY5XZK7NJtRkCXMHWXSsBmAfCiD0pu0in1yfXpJzkQrCixlaxMqSG/0MJ5e7fOX
	 KrZ1ogtWKGd1am+N5aMjo+V4Uhyl3qLpyc3tAuMdgS/0fR5bvdgzrmEyKZ3ymYc0+UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dl7tP3LU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C451606A338;
	Mon,  9 Nov 2026 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dl7tP3LU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E841F00902;
	Mon,  9 Nov 2026 22:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262781;
	bh=nzlBDH+htcsbY5WgGNXKIA3VuC4acyNgviDGnFeoE2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dl7tP3LUsvioprA1yJkfViOQqirDxj0HqPNBbF6W9matdzDFlp0yjCuIG6+nV8hp3
	 IcEozqXrzTPfPea9YGuAuMj8+SmLHNwDvT5HYpYIDwBo3egyQlX3rfU3ivQsiwkuC7
	 DSL3aY/hC9Nn3oAJ/GkqRmzonPjPebhdic0MZ9Z8aqHQiL7xB2OpI1n+QSMLe3XAmP
	 V/PBjsRXifiupvV+O+0I/PAXEiCUeVRZUhXZwAboFxqXk8l4POkeGmc3S3/mrl/FF7
	 lBofRcLg8S2awniFvW+5izDgHkB3o7QZwSIDX0k8DgKNusrKSBFu/6VDgiagQ4QTn5
	 iXPE+RFaHaCfA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BC57DCE112A; Mon,  9 Nov 2026 14:19:40 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 7/8] rcu: Print CPU that preempted stalled reader wants to run on
Date: Mon,  9 Nov 2026 14:19:38 -0800
Message-Id: <20261109221939.2070171-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <db8c185c-5523-48e5-abee-020503b4875f@paulmck-laptop>
References: <db8c185c-5523-48e5-abee-020503b4875f@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit defines a cpu_curr_snapshot_rcu() function that invokes
rcu_dereference_all(cpu_curr()) to determine which task is currently
running on the specified CPU.  The RCU CPU stall warning then uses this
new function in order to print the task that has preempted the stalled
task (the stalled task being the one that is in an RCU read-side critical
section, thus preventing the current RCU grace period from completing).
This modified stall-warning message also includes the CPU, along with
an exclamation mark ("!") after the CPU number if that CPU is currently
offline.

This is a potential step towards allowing people (or LLMs, for that
matter) locate any tasks that might be preventing the preempted RCU
reader task from running.

Adding a get_task_struct() for the currently running task would be a
bug because we are not in a position to prevent that task from exiting.
Yes, yes, because interrupts are disabled throughout, the corresponding
task_struct structure cannot be freed, but following sequence of events
is all too possible:

o	The check_slow_task() function places a pointer to the task_struct
	structure in its local variable "th".

o	The corresponding task exits, reducing its task_struct structure's
	->usage to zero.  The task_struct structure is therefore passed
	to call_rcu().

o	The check_slow_task() function invokes get_task_struct(th),
	setting th->usage to one.

o	The rcu_print_task_stall() function invokes put_task_struct(),
	again reducing ->usage to zero, and again passing the task
	struct to call_rcu().  This results in either double-call_rcu()
	or use-after-free, depending on when the RCU grace period for
	the first call_rcu() completes.  Both outcomes are bad.

This commit therefore relies solely on disabled interrupts acting as
an implicit RCU read-side critical section that prevents all of the
task_struct structures from being freed, thus avoiding the need for
get_task_struct().

The original get_task_struct() calls in rcu_print_task_stall() on the
tasks on the ->blkd_tasks list are safe because those tasks cannot exit
without first acquiring the rcu_node ->lock that this code already holds
(because these tasks must remove themselves from the ->blkd_tasks list).
But it is better to be consistent and rely on RCU in both cases.
These pre-existing get_task_struct() and put_task_struct() calls are
therefore removed.

[ paulmck: Apply feedback from K Prateek Nayak and Peter Zijlstra. ]
[ paulmck: Apply feedback from Steven Rostedt. ]

Link: https://lore.kernel.org/all/a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop/
Link: https://lore.kernel.org/all/e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop/
Link: https://lore.kernel.org/all/22d0d56c-6cef-47d7-a923-1d888e224b58@paulmck-laptop/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched.h   |  2 ++
 kernel/rcu/tree_stall.h | 33 +++++++++++++++++++++++++++------
 kernel/sched/core.c     | 13 +++++++++++++
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c93da75226e3..ba7c7bb13b6e9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2527,3 +2527,5 @@ extern void migrate_enable(void);
 DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
 #endif
+
+struct task_struct *cpu_curr_snapshot_rcu(int cpu);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 803a56af3259f..08699652f51c2 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -309,6 +309,9 @@ struct rcu_stall_chk_rdr {
 	bool on_blkd_list;
 	bool rcu_rdr_running;
 	int rcu_rdr_boosted;
+	int rcu_rdr_cpu;
+	int rcu_rdr_cpu_offline;
+	struct task_struct *rcu_rdr_cpu_task;
 };
 
 /*
@@ -317,8 +320,10 @@ struct rcu_stall_chk_rdr {
  */
 static int check_slow_task(struct task_struct *t, void *arg)
 {
+	int cpu;
 	struct rcu_node *rnp;
 	struct rcu_stall_chk_rdr *rscrp = arg;
+	struct task_struct *th;
 
 	if (task_curr(t))
 		return -EBUSY; // It is running, so decline to inspect it.
@@ -327,6 +332,13 @@ static int check_slow_task(struct task_struct *t, void *arg)
 	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
 	rscrp->rcu_rdr_running = task_curr(t);
 	rscrp->rcu_rdr_boosted = 0;
+	rscrp->rcu_rdr_cpu = cpu = task_cpu(t);
+	rscrp->rcu_rdr_cpu_offline = cpu_is_offline(cpu);
+	lockdep_assert_irqs_disabled();
+	rscrp->rcu_rdr_cpu_task = th = cpu_curr_snapshot_rcu(cpu);
+	// There is no need for get_task_struct(t) because we are in
+	// an implicit RCU read-side critical section due to interrupts
+	// being disabled.
 	if (rscrp->on_blkd_list) {
 		rnp = READ_ONCE(t->rcu_blocked_node);
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
@@ -352,6 +364,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	int ndetected = 0;
 	struct rcu_stall_chk_rdr rscr;
 	struct task_struct *t;
+	struct task_struct *tc;
 	struct task_struct *ts[8];
 
 	lockdep_assert_irqs_disabled();
@@ -364,7 +377,9 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	t = list_entry(rnp->gp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
-		get_task_struct(t);
+		// There is no need for get_task_struct(t) because we
+		// are in an implicit RCU read-side critical section due
+		// to interrupts being disabled.
 		ts[i++] = t;
 		if (i >= ARRAY_SIZE(ts))
 			break;
@@ -372,19 +387,25 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	while (i) {
 		t = ts[--i];
-		if (task_call_func(t, check_slow_task, &rscr))
+		if (task_call_func(t, check_slow_task, &rscr)) {
 			pr_cont(" P%d", t->pid);
-		else
-			pr_cont(" P%d/%d:%c%c%c%c%c%c",
+		} else {
+			tc = rscr.rcu_rdr_cpu_task;
+			pr_cont(" P%d/%d:%c%c%c%c%c%c CPU %d%s %s (%d)%s",
 				t->pid, rscr.nesting,
 				".b"[rscr.rs.b.blocked],
 				".q"[rscr.rs.b.need_qs],
 				".e"[rscr.rs.b.exp_hint],
 				".l"[rscr.on_blkd_list],
 				".R"[rscr.rcu_rdr_running],
-				".B?"[rscr.rcu_rdr_boosted]);
+				".B?"[rscr.rcu_rdr_boosted],
+				rscr.rcu_rdr_cpu,
+				rscr.rcu_rdr_cpu_offline ? "!" : "",
+				tc ? tc->comm : "???",
+				tc ? tc->pid : -1,
+				tc ? (is_idle_task(tc) ? " (idle!)" : "") : " (no task)");
+		}
 		lockdep_assert_irqs_disabled();
-		put_task_struct(t);
 		ndetected++;
 	}
 	pr_cont("\n");
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b5b205b1a6e22..98b45b2557e92 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4605,6 +4605,19 @@ struct task_struct *cpu_curr_snapshot(int cpu)
 	return t;
 }
 
+/**
+ * cpu_curr_snapshot_rcu - Return the task currently running on CPU
+ * @cpu: CPU to query
+ *
+ * The caller must be within an RCU read-side critical section.
+ *
+ * Return: Pointer to task_struct of task running on @cpu.
+ */
+struct task_struct *cpu_curr_snapshot_rcu(int cpu)
+{
+	return rcu_dereference_all(cpu_curr(cpu));
+}
+
 /**
  * wake_up_process - Wake up a specific process
  * @p: The process to be woken up.
-- 
2.40.1

