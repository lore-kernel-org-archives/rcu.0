Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D743C19340C;
	Wed,  9 Oct 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478332; cv=none; b=VOBSBK/zqXXaS1jQO2RjiinOp0ragzCdMjpzhlr1MDy57baefkIUFN+bZNRj1at2ELVMzrojQu9ohd7sbXw3Wq+YFYHxNz9dSKbs/VyEpbHpGcOP51lNnYMIOpGT54W7Cwo00APzdSKy5kIVmF57C9ntPZB004OP1gwEcCehRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478332; c=relaxed/simple;
	bh=3OB6pgXC0VJmU+IWwSUEhbW9bzPbw6tk0P+9End7n00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OoeVP++IF0n6mjOGcaohACy7wRCBP0asoR5BqAgSmMhScggrzJSe7MA/2tyCMdivuHn4Xr61kiNX63E7akVb17osZbtlVBy5oa26TMoMvSA+/UTxO9L0o3NfAWa81QYMfQh/JpE8YnloShgF/GraZ4pjHujOi2d5rGzmMXgbFGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kImqHSvJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kImqHSvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256B5C4CEC5;
	Wed,  9 Oct 2024 12:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478332;
	bh=3OB6pgXC0VJmU+IWwSUEhbW9bzPbw6tk0P+9End7n00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kImqHSvJ1PoiZEKcKs8q2xRocxvYhexe2uq702SwleNQks1fQbcyjrffJIHmXYsWT
	 eKoY5wOdWCvbx9rYEvUGSLbTMeAoPjISNjyQAxKB/Jt72Yr/6B+FYYzhZnrRqz5WdS
	 qNkVr8l30RdI/9dyjSHEt3XuPocjV+V7BmaeY7jrDX2XctJM07wRgcEYDcntVPcwLf
	 OSRYBOWRrgURVggEMuuMEq4y8tdTJkZnfmUdWtirjPBf7986mvuUimm2whIe78QSm2
	 0k9cHtV7t7Dea1GO9FYFD8r2KtBh7ABck34MiOaYulJNjZhotYKnDUBiei3Hox+e7S
	 lNflP2X/in2cw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joel@joelfernandes.org,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	peterz@infradead.org,
	neeraj.upadhyay@amd.com,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH v2 06/10] rcu/tasks: Check RCU watching state for holdout idle tasks
Date: Wed,  9 Oct 2024 18:21:23 +0530
Message-Id: <20241009125127.18902-7-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
References: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

Use RCU watching state of a CPU to check whether RCU-tasks GP
need to wait for idle task on that CPU. Idle tasks which are
in deep-idle states where RCU is not watching or which have
transitioned to/from deep-idle state do not block RCU-tasks
grace period.

Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tasks.h | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 9523aff6cdae..d8506d2e6f54 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -36,6 +36,8 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @cpu: CPU number corresponding to this entry.
  * @index: Index of this CPU in rtpcp_array of the rcu_tasks structure.
  * @rtpp: Pointer to the rcu_tasks structure.
+ * @rcu_watching_snap: Per-GP RCU-watching snapshot for idle tasks.
+ * @rcu_watching_snap_rec: RCU-watching snapshot recorded for idle task.
  */
 struct rcu_tasks_percpu {
 	struct rcu_segcblist cblist;
@@ -52,6 +54,8 @@ struct rcu_tasks_percpu {
 	int cpu;
 	int index;
 	struct rcu_tasks *rtpp;
+	int rcu_watching_snap;
+	bool rcu_watching_snap_rec;
 };
 
 /**
@@ -957,9 +961,14 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 // rcu_tasks_pregp_step() and by the scheduler's locks and interrupt
 // disabling.
 
+void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
+DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
+
 /* Pre-grace-period preparation. */
 static void rcu_tasks_pregp_step(struct list_head *hop)
 {
+	int cpu;
+
 	/*
 	 * Wait for all pre-existing t->on_rq and t->nvcsw transitions
 	 * to complete.  Invoking synchronize_rcu() suffices because all
@@ -974,11 +983,20 @@ static void rcu_tasks_pregp_step(struct list_head *hop)
 	 * grace period.
 	 */
 	synchronize_rcu();
+
+	/* Initialize watching snapshots for this GP */
+	for_each_possible_cpu(cpu) {
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
+
+		rtpcp->rcu_watching_snap_rec = false;
+	}
 }
 
 #ifdef CONFIG_SMP
 static bool rcu_idle_task_is_holdout(struct task_struct *t, int cpu)
 {
+	struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
+
 	/* Idle tasks on offline CPUs are RCU-tasks quiescent states. */
 	if (!rcu_cpu_online(cpu))
 		return false;
@@ -992,6 +1010,21 @@ static bool rcu_idle_task_is_holdout(struct task_struct *t, int cpu)
 	if (!t->on_cpu)
 		return false;
 
+	if (!rtpcp->rcu_watching_snap_rec) {
+		/*
+		 * Do plain access. Ordering between remote CPU's pre idle accesses
+		 * and post rcu-tasks grace period is provided by synchronize_rcu()
+		 * in rcu_tasks_postgp().
+		 */
+		rtpcp->rcu_watching_snap = ct_rcu_watching_cpu(cpu);
+		rtpcp->rcu_watching_snap_rec = true;
+		/* RCU-idle contexts are RCU-tasks quiescent state for idle tasks. */
+		if (rcu_watching_snap_in_eqs(rtpcp->rcu_watching_snap))
+			return false;
+	} else if (rcu_watching_snap_stopped_since(cpu, rtpcp->rcu_watching_snap)) {
+		return false;
+	}
+
 	return true;
 }
 #else /* #ifdef CONFIG_SMP */
@@ -1042,9 +1075,6 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 	}
 }
 
-void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
-DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
-
 /* Processing between scanning taskslist and draining the holdout list. */
 static void rcu_tasks_postscan(struct list_head *hop)
 {
-- 
2.40.1

