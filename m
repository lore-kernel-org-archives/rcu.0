Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D6369225;
	Fri, 17 Apr 2026 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467579; cv=none; b=ZYL2RDkXo8NQzTybixOFyaMvj7quCQTy7lCQVX3PhVMua7OlQNboWiPKYIMS9SMpsV5NPezzK2JWj0qpnywBlv6IMe53IqwZnE5Bxwyq2TFVi6EwCnciBJG+mBXdoBUbrPgsOYQxL51ILV3/ETRQ8wffrevAgs5xG6M8n3KwoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467579; c=relaxed/simple;
	bh=ST4B86cvglVTb39TAigSDO2IOx/GTXn/36uOCk8V6kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ya2kNclSlHusgzEElXHQjjJMc3yf04oj+5+OHrhYU1IKDBZrufCd7eMZxdEXNSU89/QwRCpWibn1HjkAea1SV2u72OEYfRbmlmc5hefrzDraDTneNEbz7c3VI6IQuU4TTbvgTQseG39w4QNyh++Lc8/0FW/xQB0seGe3TocWY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeVysn5c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeVysn5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3D1C2BCB3;
	Fri, 17 Apr 2026 23:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467579;
	bh=ST4B86cvglVTb39TAigSDO2IOx/GTXn/36uOCk8V6kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SeVysn5cFgAqfl68qoJNx83ON4LhpGfyY1FrOPktEHtZgePeGFIzgFPjskC7qPKLS
	 RXov4Wgpzaft6Jd1A9gVOhLOVBHEhpaErg9Ca8k+ANoBbrOmcvBhMxRV0sOz2vwW+V
	 0iNLg3uD8d5JOFx3s71sR5wr4b/EjDkwIRdpzdiER45J4g4WfD2pjFIeBfz/rMFgqZ
	 EdmQTn9wjZ542SB378WH6EZreJR8F/Kd67OSEtnj1ISWoTSQVKLk8+hs3/y93fkPAD
	 lBhPvHZun8TOLx612cI5jQ7AlZztn8rks+czna3TE8KzrQly4qjsHv9Y+gvffs+8NC
	 0b7AQYIC+D6eA==
From: Puranjay Mohan <puranjay@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [RFC PATCH 07/10] rcu: Wake NOCB rcuog kthreads on expedited grace period completion
Date: Fri, 17 Apr 2026 16:11:55 -0700
Message-ID: <20260417231203.785172-8-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417231203.785172-1-puranjay@kernel.org>
References: <20260417231203.785172-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an expedited grace period completes, rcu_exp_wait_wake() wakes
waiters on rnp->exp_wq[] but does not notify NOCB rcuog kthreads.  These
kthreads may be sleeping waiting for a grace period to complete.
Without this wakeup, callbacks on offloaded CPUs that could benefit from
the expedited GP must wait until the rcuog kthread wakes for some other
reason (e.g., next normal GP completion or a timer).

Add rcu_exp_wake_nocb() which wakes rcuog kthreads for leaf-node CPUs,
deduplicating via rdp->nocb_gp_rdp since multiple CPUs share one rcuog
kthread.  Uses for_each_leaf_node_possible_cpu() because offline CPUs
can have pending callbacks. The function is defined in tree_nocb.h with
an empty stub for CONFIG_RCU_NOCB_CPU=n builds.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/tree.h      |  1 +
 kernel/rcu/tree_exp.h  |  1 +
 kernel/rcu/tree_nocb.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7dfc57e9adb1..40f778453591 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -500,6 +500,7 @@ static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
 static bool wake_nocb_gp(struct rcu_data *rdp);
+static void rcu_exp_wake_nocb(struct rcu_node *rnp);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, bool lazy);
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 82cada459e5d..0df1009c6e97 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -708,6 +708,7 @@ static void rcu_exp_wait_wake(unsigned long s)
 		}
 		smp_mb(); /* All above changes before wakeup. */
 		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(s) & 0x3]);
+		rcu_exp_wake_nocb(rnp);
 	}
 	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
 	mutex_unlock(&rcu_state.exp_wake_mutex);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 7462cd5e2507..f37ee56d62a9 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -190,6 +190,31 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 	init_swait_queue_head(&rnp->nocb_gp_wq[1]);
 }
 
+/*
+ * Wake NOCB rcuog kthreads for leaf-node CPUs so that they can advance
+ * callbacks that were waiting for the just-completed expedited GP.
+ * Deduplicate via nocb_gp_rdp since multiple CPUs share one rcuog
+ * kthread.  Use for_each_leaf_node_possible_cpu() because offline CPUs
+ * may have pending callbacks.
+ */
+static void rcu_exp_wake_nocb(struct rcu_node *rnp)
+{
+	struct rcu_data *last_rdp_gp = NULL;
+	int cpu;
+
+	if (!rcu_is_leaf_node(rnp))
+		return;
+
+	for_each_leaf_node_possible_cpu(rnp, cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+		if (rdp->nocb_gp_rdp == last_rdp_gp)
+			continue;
+		last_rdp_gp = rdp->nocb_gp_rdp;
+		wake_nocb_gp(rdp);
+	}
+}
+
 /* Clear any pending deferred wakeup timer (nocb_gp_lock must be held). */
 static void nocb_defer_wakeup_cancel(struct rcu_data *rdp_gp)
 {
@@ -1668,6 +1693,10 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
+static void rcu_exp_wake_nocb(struct rcu_node *rnp)
+{
+}
+
 static bool wake_nocb_gp(struct rcu_data *rdp)
 {
 	return false;
-- 
2.52.0

