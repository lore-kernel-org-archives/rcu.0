Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E782488;
	Fri, 16 Aug 2024 04:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781136; cv=none; b=FX9nKy89w2SsocVCaOotRqRadwn2YKW8PSsUaLxzdte1Q7rNb7mnHR49DC5VHvKTuJMle/nthMsGYwVEthddmcnE74kMzzTw8jUAuk8pzPCLf1Q9wa320awziwyT/X/5mj1+xSS2OLAFhKYoFkwZEl7IvFWGyhqtUhzwbkk/EEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781136; c=relaxed/simple;
	bh=+Mo5q7GWPN7t00hvEjG+UUC6SUC5HOsEA7aWBEXTzsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rDW/CoU/AhVCag2jcewjCpiDZTpqYDmWnJG9PU+ki/b+zPeSTzfG44gqaknpsTGArHhnsWCVouWnqhuZXQ/zwg3VbDUG90Y5wP21h9H5jN4x9frKouYjibgjwrHhBwU6BWkY/TwFm+QfYyYUAjIdcDbDvbQHnFsY2+EJb/STlZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7mD8cd1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7mD8cd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5E0C4AF09;
	Fri, 16 Aug 2024 04:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781136;
	bh=+Mo5q7GWPN7t00hvEjG+UUC6SUC5HOsEA7aWBEXTzsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7mD8cd1wS1kVA4uCzXB07gAdF9jgv8mZ8Mkm/YVcBOQrMaIrbExGsIR2piAIuB0M
	 VNgOtC9fOZgI0I05g0Ao1XjXRhAcY+xZUNIQqgq7Nlg3Gvu0NDzVr06GmW4tfkBi1y
	 CV70aFdtdyLOp6BfhQZvc3P5l1nnPtyjphtN+UR+rktkdAc3JCiDy7F1Vs/3Ba71js
	 YZZq0H2OtNyxJ96ma9viOhjgYM6sJZhziq4jFo6vcVUN20lozB7G1yFsZbFEuXzyd7
	 se1sM+KGWBSwMEVoH8s7F1cA8j3bGKDfzh7NZKfFwNpI8MVnPT7g/LNzRUoZsE8oqr
	 eHqaCy1SVZdcw==
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
	frederic@kernel.org,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH rcu 16/26] rcu: Rename rcu_dynticks_in_eqs() into rcu_watching_snap_in_eqs()
Date: Fri, 16 Aug 2024 09:32:31 +0530
Message-Id: <20240816040241.17776-16-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816040030.GA16986@neeraj.linux>
References: <20240816040030.GA16986@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, reflect that change in the related helpers.

While at it, update a comment that still refers to rcu_dynticks_snap(),
which was removed by commit:

  7be2e6323b9b ("rcu: Remove full memory barrier on RCU stall printout")

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c       | 8 ++++----
 kernel/rcu/tree_exp.h   | 2 +-
 kernel/rcu/tree_stall.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 47ec9f2daaed..73516d76b70a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -300,10 +300,10 @@ static void rcu_watching_online(void)
 }
 
 /*
- * Return true if the snapshot returned from rcu_dynticks_snap()
+ * Return true if the snapshot returned from ct_rcu_watching()
  * indicates that RCU is in an extended quiescent state.
  */
-static bool rcu_dynticks_in_eqs(int snap)
+static bool rcu_watching_snap_in_eqs(int snap)
 {
 	return !(snap & CT_RCU_WATCHING);
 }
@@ -783,7 +783,7 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 	 * updater's accesses is enforced by the below acquire semantic.
 	 */
 	rdp->dynticks_snap = ct_rcu_watching_cpu_acquire(rdp->cpu);
-	if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
+	if (rcu_watching_snap_in_eqs(rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
 		return 1;
@@ -4805,7 +4805,7 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(ct->nesting != 1);
-	WARN_ON_ONCE(rcu_dynticks_in_eqs(ct_rcu_watching_cpu(cpu)));
+	WARN_ON_ONCE(rcu_watching_snap_in_eqs(ct_rcu_watching_cpu(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_state = RCU_GP_CLEANED;
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index daa87fec703f..137559c84309 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -377,7 +377,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 			 * below acquire semantic.
 			 */
 			snap = ct_rcu_watching_cpu_acquire(cpu);
-			if (rcu_dynticks_in_eqs(snap))
+			if (rcu_watching_snap_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
 				rdp->exp_dynticks_snap = snap;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index ec49f0155bec..e933c6a58d5f 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -501,7 +501,7 @@ static void print_cpu_stall_info(int cpu)
 	}
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
-			rcu_dynticks_in_eqs(ct_rcu_watching_cpu(cpu));
+			rcu_watching_snap_in_eqs(ct_rcu_watching_cpu(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
 		// Print signed value, as negative values indicate a probable bug.
-- 
2.40.1

