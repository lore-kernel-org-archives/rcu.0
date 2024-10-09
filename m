Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CFB1E22E0;
	Wed,  9 Oct 2024 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478337; cv=none; b=bTUfLBWjvvkHP5XJFp2UcbfJffECzZKBIl2oyeEL1CyoYfd1gE/d45PrnXxrvkg1VOq+BPtCcjyRSOJRbomRQSIuuT6ZDesNSxY9NK7oE74CyPTy+tP0JyD+q56GbvBU/Ve8xka7lnZ3/rXVcNAck2AzczGIvwj796N2nIDjm94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478337; c=relaxed/simple;
	bh=7YdM26j1jMpKxr6XHqzYpzezpp/C8Ve3E5DloVJy/gU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fdLsRC+d78Ums+ExjhLhpGZgrpfgEa9lQJjc3wnJauzidpr+yR+qOqQBcohFYnD600Es8ppoGYOWcilsjJMW0ezcFr1jw2DXi7+6foZTU/oRyUeakSpi/MDtLVYSFXGDUJNnzu2YSeKen5rsc+hg740vVH8cngp6bCbV58cNfVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsQfYygc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsQfYygc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2912C4CECD;
	Wed,  9 Oct 2024 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478337;
	bh=7YdM26j1jMpKxr6XHqzYpzezpp/C8Ve3E5DloVJy/gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LsQfYygcSmoCwuA694YgKY2dSbaETofQTA9rENoTfNJfSQScWWElGpPKsPl3OwWXh
	 rDfFghdnHcF3wY6GTRk1LATMXyq18G2VcK0EhuyZ+GjQtcewLJWfMMGiHAAd708xYt
	 aQGctj6p+EbKNxKhEVag0iGIFjk9/ufr6dfPvfuM8QbMH7j+lghTthCslEc3Lr4dsV
	 SayLRihHihgbiLqkuwDHDgSM8FlF/ZsyYWxyPaoLVWGxZieqsa+kDesMdtgQdeb1Ws
	 OvszKRpL1DPmkklFEeH33cxs2vHV5MtviN81iYDRV1voR1KVPmH35SFgGSQTqylW2G
	 FsIdok45w/dvA==
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
Subject: [PATCH v2 07/10] rcu/tasks: Check RCU watching state for holdout idle injection tasks
Date: Wed,  9 Oct 2024 18:21:24 +0530
Message-Id: <20241009125127.18902-8-neeraj.upadhyay@kernel.org>
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
need to wait for idle injection task on that CPU. Idle injection
tasks which are in deep-idle states where RCU is not watching or
which have transitioned to/from deep-idle state do not block
RCU-tasks grace period.

Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tasks.h | 63 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d8506d2e6f54..1947f9b6346d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -38,6 +38,8 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @rtpp: Pointer to the rcu_tasks structure.
  * @rcu_watching_snap: Per-GP RCU-watching snapshot for idle tasks.
  * @rcu_watching_snap_rec: RCU-watching snapshot recorded for idle task.
+ * @rcu_watching_idle_inj_snap: Per-GP RCU-watching snapshot for idle inject task.
+ * @rcu_watching_idle_inj_rec: RCU-watching snapshot recorded for idle inject task.
  */
 struct rcu_tasks_percpu {
 	struct rcu_segcblist cblist;
@@ -56,6 +58,8 @@ struct rcu_tasks_percpu {
 	struct rcu_tasks *rtpp;
 	int rcu_watching_snap;
 	bool rcu_watching_snap_rec;
+	int rcu_watching_idle_inj_snap;
+	bool rcu_watching_idle_inj_rec;
 };
 
 /**
@@ -989,10 +993,34 @@ static void rcu_tasks_pregp_step(struct list_head *hop)
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
 
 		rtpcp->rcu_watching_snap_rec = false;
+		rtpcp->rcu_watching_idle_inj_rec = false;
 	}
 }
 
 #ifdef CONFIG_SMP
+static bool rcu_idle_check_rcu_watching(int *rcu_watching_snap, bool *rcu_watching_rec, int cpu)
+{
+	if (!*rcu_watching_rec) {
+		/*
+		 * Do plain access. Ordering between remote CPU's pre idle accesses
+		 * and post rcu-tasks grace period is provided by synchronize_rcu()
+		 * in rcu_tasks_postgp().
+		 */
+		*rcu_watching_snap = ct_rcu_watching_cpu(cpu);
+		*rcu_watching_rec = true;
+		if (rcu_watching_snap_in_eqs(*rcu_watching_snap))
+			/*
+			 * RCU-idle contexts are RCU-tasks quiescent state for idle
+			 * (and idle injection) tasks.
+			 */
+			return false;
+	} else if (rcu_watching_snap_stopped_since(cpu, *rcu_watching_snap)) {
+		return false;
+	}
+
+	return true;
+}
+
 static bool rcu_idle_task_is_holdout(struct task_struct *t, int cpu)
 {
 	struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
@@ -1010,22 +1038,16 @@ static bool rcu_idle_task_is_holdout(struct task_struct *t, int cpu)
 	if (!t->on_cpu)
 		return false;
 
-	if (!rtpcp->rcu_watching_snap_rec) {
-		/*
-		 * Do plain access. Ordering between remote CPU's pre idle accesses
-		 * and post rcu-tasks grace period is provided by synchronize_rcu()
-		 * in rcu_tasks_postgp().
-		 */
-		rtpcp->rcu_watching_snap = ct_rcu_watching_cpu(cpu);
-		rtpcp->rcu_watching_snap_rec = true;
-		/* RCU-idle contexts are RCU-tasks quiescent state for idle tasks. */
-		if (rcu_watching_snap_in_eqs(rtpcp->rcu_watching_snap))
-			return false;
-	} else if (rcu_watching_snap_stopped_since(cpu, rtpcp->rcu_watching_snap)) {
-		return false;
-	}
+	return rcu_idle_check_rcu_watching(&rtpcp->rcu_watching_snap,
+			&rtpcp->rcu_watching_snap_rec, cpu);
+}
 
-	return true;
+static bool rcu_idle_inj_is_holdout(struct task_struct *t, int cpu)
+{
+	struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
+
+	return rcu_idle_check_rcu_watching(&rtpcp->rcu_watching_idle_inj_snap,
+			&rtpcp->rcu_watching_idle_inj_rec, cpu);
 }
 #else /* #ifdef CONFIG_SMP */
 static inline bool rcu_idle_task_is_holdout(struct task_struct *t, int cpu)
@@ -1037,6 +1059,15 @@ static inline bool rcu_idle_task_is_holdout(struct task_struct *t, int cpu)
 	 */
 	return false;
 }
+
+static inline bool rcu_idle_inj_is_holdout(struct task_struct *t, int cpu)
+{
+	/*
+	 * Idle injection tasks are PF_IDLE within preempt disabled
+	 * region. So, we should not enter this call for !SMP.
+	 */
+	return false;
+}
 #endif
 
 /* Check for quiescent states since the pregp's synchronize_rcu() */
@@ -1060,6 +1091,8 @@ static bool rcu_tasks_is_holdout(struct task_struct *t)
 
 	if (t == idle_task(cpu))
 		return rcu_idle_task_is_holdout(t, cpu);
+	else if (is_idle_task(t))
+		return rcu_idle_inj_is_holdout(t, cpu);
 
 	return true;
 }
-- 
2.40.1

