Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4874418;
	Fri, 16 Aug 2024 04:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781026; cv=none; b=Y8+zTlvYZLQkSi7zYnfB0rLXIyVsLLSJdt8QidvCS/29l5pvFK2GmpdcvoTGwj3vpLsgNXZY0PE0KiNxAZNGIk8v3pLXnaBc/eQAa6z24ClzSzCVN4LxhuLe+VzyAOoH4JB72ojNFNqqaQdHI92j+yuHzTDr4CkwKBkCs5Wv8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781026; c=relaxed/simple;
	bh=xOSNuSYiybYrwARpAf5EHCoOy7qhk0v8Ujjxxy15+so=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUPD811kas8LRS/g66GNXUfQ/jmb65VSbslFtmg1UCExHd+RFf/NqrMJ8LPlI+57vIA9L11j2gYmpTw+qIXYw4fXmoXnawHmTNubPkz3ivoent2dIgmeUpbkDQAsbSBEtu35WZgICf4eJ/1AdgcCZL6zXkJeg5koIZfU+TrbLr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTd+BdpV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTd+BdpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC2EC4AF09;
	Fri, 16 Aug 2024 04:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781026;
	bh=xOSNuSYiybYrwARpAf5EHCoOy7qhk0v8Ujjxxy15+so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTd+BdpVpVK5DsXh4z81ObLJrJzyzUNlhN9cxx2Ho3UJGIwytm0E3AVBhnIljXbao
	 3rOy7x2y/8wvEw8zuBCtA/GbYss++iDjtu/hX6QXhoITMqOcHNn0kIjJju0iuwz0gG
	 +43VEZC3baw8rUFr0IKBX2YHlvNLjxH4izvnhTEhZeHnrQHadXTCejmJ98ryO3tsj0
	 /41oNDiuWbKPGG3UjUPGmsbY1FD7TjygKoEGzNTVkeJNnjQRCQfpmWT0GEC5qAwAky
	 xRgjg7UWXuiMiBGL9hFcqdYepNzn861GH7hY/47PDh5sDSbUGYrrJHG6va7GAJMyNs
	 EbCRxDII/Notg==
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
Subject: [PATCH rcu 04/26] context_tracking, rcu: Rename ct_dynticks_cpu() into ct_rcu_watching_cpu()
Date: Fri, 16 Aug 2024 09:32:19 +0530
Message-Id: <20240816040241.17776-4-neeraj.upadhyay@kernel.org>
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

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/context_tracking_state.h |  2 +-
 kernel/rcu/tree.c                      | 10 +++++-----
 kernel/rcu/tree_stall.h                |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index cb90d8c17810..ad5a06a42b4a 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -61,7 +61,7 @@ static __always_inline int ct_rcu_watching(void)
 	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_RCU_WATCHING_MASK;
 }
 
-static __always_inline int ct_dynticks_cpu(int cpu)
+static __always_inline int ct_rcu_watching_cpu(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3a2f0325aa43..e7f612e9f7e5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -335,14 +335,14 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 	int snap;
 
 	// If not quiescent, force back to earlier extended quiescent state.
-	snap = ct_dynticks_cpu(cpu) & ~CT_RCU_WATCHING;
-	smp_rmb(); // Order ->dynticks and *vp reads.
+	snap = ct_rcu_watching_cpu(cpu) & ~CT_RCU_WATCHING;
+	smp_rmb(); // Order CT state and *vp reads.
 	if (READ_ONCE(*vp))
 		return false;  // Non-zero, so report failure;
-	smp_rmb(); // Order *vp read and ->dynticks re-read.
+	smp_rmb(); // Order *vp read and CT state re-read.
 
 	// If still in the same extended quiescent state, we are good!
-	return snap == ct_dynticks_cpu(cpu);
+	return snap == ct_rcu_watching_cpu(cpu);
 }
 
 /*
@@ -4805,7 +4805,7 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(ct->dynticks_nesting != 1);
-	WARN_ON_ONCE(rcu_dynticks_in_eqs(ct_dynticks_cpu(cpu)));
+	WARN_ON_ONCE(rcu_dynticks_in_eqs(ct_rcu_watching_cpu(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_state = RCU_GP_CLEANED;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 4b0e9d7c4c68..d65974448e81 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -501,7 +501,7 @@ static void print_cpu_stall_info(int cpu)
 	}
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
-			rcu_dynticks_in_eqs(ct_dynticks_cpu(cpu));
+			rcu_dynticks_in_eqs(ct_rcu_watching_cpu(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
 		// Print signed value, as negative values indicate a probable bug.
@@ -515,7 +515,7 @@ static void print_cpu_stall_info(int cpu)
 			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
 				"!."[!delta],
 	       ticks_value, ticks_title,
-	       ct_dynticks_cpu(cpu) & 0xffff,
+	       ct_rcu_watching_cpu(cpu) & 0xffff,
 	       ct_dynticks_nesting_cpu(cpu), ct_dynticks_nmi_nesting_cpu(cpu),
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
-- 
2.40.1

