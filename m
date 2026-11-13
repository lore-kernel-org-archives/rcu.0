Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531021;
	b=4DkPqL7lutjk1fj38f2QujDD90yA6R8hDnj0JCkm7iECVBha21rhWRPB9DvWAxt42Q0x
	 AE4RpM4qUR2VshzDM9wCWbt048iKrO99z+z7Xhw9CBglaw43Ae9BW20XubmIL592ScEQz
	 4+5r04/yRpj5Gzgq1Ywh0IsP4E4/vnBYTa8Td3nViSx3N1UDAt4MCroiH/bxVPjppdvfc
	 KuZVQxlkg6zRDgAoA2LQqeMt0y8b98v5kWHdXx9TQVihmqwsgIaG31wTQhHl5YFwygAFk
	 +PSVlljcNTrv0Kcgwulj3Ni1jRgBgTOWSXuvjlCSoTTndP4t+ZUtb8HoPS/O8me74Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531021;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b3NxQG++j8x9YsqTAsJ+0H5VwX5FJjwT6jL5cwfhvZg=;
	b=A3qZ2CIDz/L4i/82e1NviApzoFyrFqcTwK9d9YQXRyrvCPuydnZu4e/uB41XogqR1CSm
	 Uh280ryT+W2Flo+c/LvSk+9ZLGLS//6m3QGuGm/Ss3aXDR3B2+FASnWkDBEghoAL5G08G
	 zvRSo7MHPsT8SKjkoYElfEyBS2Kr/teGTFZsEVmMCOjdDAh+jcwTLHcfkf3QJDbJ1W8qG
	 z4flueVNUkm30iGlf6h5kgkKNMMMvLuUVJzKurTmpIKEFdwdW7dk5Os4VBM1GlqOvM7FK
	 +ohensllkJUfN63nCs71pOWDZ0eLl23gbt/1lkHNVRGXHToEnu7QNcz8ADa4bGOlfew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2PmRbPJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D8DD8606A895;
	Fri, 13 Nov 2026 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2PmRbPJ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2B6D11F000C4;
	Fri, 13 Nov 2026 00:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531021;
	bh=b3NxQG++j8x9YsqTAsJ+0H5VwX5FJjwT6jL5cwfhvZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V2PmRbPJ+InSjVthOfRjW0+C65p4xbSzcmcDhzyPOVUVo9q5al+R2dTBvDaS2xxmO
	 aHuztWk3NDGLPgpH7nUl36cJgG9aM5rFyVJZIgKU2+yWIrG8FS3jkRX5h3outcJO0/
	 7QEqHNh8n5XGwX4IehpXwjvOmMYl5cSAXBrAZVgEgvduq62T8A1D+rCQoD/yA93NtY
	 URgNHxg/kogTyy8R/5F0TXhnwpjmED5B3dbHhYA/VopFOHZOk7v47fZwiAMkWHRDev
	 OtH8a80oofucAY5keAgZEbLLHSKhdIG/n+HHWCHkao94AYkoFI+7LZcL5P+3u5Hpr/
	 85GGQqAtVEoow==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: rcu@vger.kernel.org
Subject: [PATCH for-v7.5 01/11] rcu: Print CPU that preempted stalled reader wants to run on
Date: Thu, 12 Nov 2026 19:50:03 -0500
Message-ID: <20261113005017.2772440-2-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005017.2772440-1-jfern@kernel.org>
References: <20261113005017.2772440-1-jfern@kernel.org>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

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
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 include/linux/sched.h   |  2 ++
 kernel/rcu/tree_stall.h | 33 +++++++++++++++++++++++++++------
 kernel/sched/core.c     | 13 +++++++++++++
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e4f6323d7855..09e05e2b6c9a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2529,3 +2529,5 @@ extern void migrate_enable(void);
 DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
 #endif
+
+struct task_struct *cpu_curr_snapshot_rcu(int cpu);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 803a56af3259..08699652f51c 100644
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
index 1a088d4576f5..7449290264b1 100644
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
2.54.0

