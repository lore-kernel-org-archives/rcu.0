Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1975878B4E;
	Fri, 16 Aug 2024 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781038; cv=none; b=iityYegEcLlWULVaY+FzIWJDp5zfAeBNp2kyrJMd0xeDuGKuU8liXtWyRp10/jhetsqUAotaLq5XmHqwK69o7zSAJLUu09MwPyg/Ssf4XK8GafDUHblhD63d/XAXagbH+Rv3mdQGPfUop3BOs4jgUnVY19QdvtgXpj+SVS8CbE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781038; c=relaxed/simple;
	bh=NyulHrMVLNYTfXy3AWfdScqtYEeVT/u7nVYWdKpf0a0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A13DKV+ffyasoM73SALNC8dJ273Wyi53vVDQZxUCBLCWfr1kthIBVhOdX6IBxE1B+diH6Tox4Vi0DXY5494Kg6IY31LnUps3EMG86bW72I4ZEBvAP4tC747UiZnDI/koS+ZKYLNoVs33UvRbcR4SQh6bIKSaxqQlJ4sFIyKKVvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbcMF76n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbcMF76n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BB7C32782;
	Fri, 16 Aug 2024 04:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781038;
	bh=NyulHrMVLNYTfXy3AWfdScqtYEeVT/u7nVYWdKpf0a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sbcMF76n+xKc5K9ln7rXe2TQ0G3TZx21NGvxesc39Dgx1bX1f63g28o0nmpBgawRV
	 eOL70jZgHdons0z47xud22dj4kK7grmUvMuB8XcDKhf9Q7juTNuPhgoBN2iWd6cLkf
	 bi1C7utE2R7x3TaLGWnZzn8rtWXhSLNSdwI+tbpExthrNTW4MQdFx4vIjmWatomA54
	 GC1bK/7OgQ2XlYhOuMbKpeW/VP8M+Tq4RiE+uG45FFAdkw2o4QmRblSlaRQbcO0poU
	 I+NIgD+ToIuytEDSX8ZK59wJY3dzyUf6mEvcXwuEmNzM6bb5nlVRBEZQMfuHffOfCb
	 QAHcjx5CzeyDw==
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
Subject: [PATCH rcu 05/26] context_tracking, rcu: Rename ct_dynticks_cpu_acquire() into ct_rcu_watching_cpu_acquire()
Date: Fri, 16 Aug 2024 09:32:20 +0530
Message-Id: <20240816040241.17776-5-neeraj.upadhyay@kernel.org>
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
 .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst   | 2 +-
 include/linux/context_tracking_state.h                        | 2 +-
 kernel/rcu/tree.c                                             | 4 ++--
 kernel/rcu/tree_exp.h                                         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 728b1e690c64..2d7036ad7476 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -149,7 +149,7 @@ This case is handled by calls to the strongly ordered
 ``atomic_add_return()`` read-modify-write atomic operation that
 is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
 time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
-The grace-period kthread invokes first ``ct_dynticks_cpu_acquire()``
+The grace-period kthread invokes first ``ct_rcu_watching_cpu_acquire()``
 (preceded by a full memory barrier) and ``rcu_dynticks_in_eqs_since()``
 (both of which rely on acquire semantics) to detect idle CPUs.
 
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index ad5a06a42b4a..ad6570ffeff3 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -68,7 +68,7 @@ static __always_inline int ct_rcu_watching_cpu(int cpu)
 	return atomic_read(&ct->state) & CT_RCU_WATCHING_MASK;
 }
 
-static __always_inline int ct_dynticks_cpu_acquire(int cpu)
+static __always_inline int ct_rcu_watching_cpu_acquire(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e7f612e9f7e5..45a9f3667c2a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -323,7 +323,7 @@ static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 	 * performed by the remote CPU prior to entering idle and therefore can
 	 * rely solely on acquire semantics.
 	 */
-	return snap != ct_dynticks_cpu_acquire(rdp->cpu);
+	return snap != ct_rcu_watching_cpu_acquire(rdp->cpu);
 }
 
 /*
@@ -782,7 +782,7 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 	 * Ordering between remote CPU's pre idle accesses and post grace period
 	 * updater's accesses is enforced by the below acquire semantic.
 	 */
-	rdp->dynticks_snap = ct_dynticks_cpu_acquire(rdp->cpu);
+	rdp->dynticks_snap = ct_rcu_watching_cpu_acquire(rdp->cpu);
 	if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 4acd29d16fdb..daa87fec703f 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -376,7 +376,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 			 * post grace period updater's accesses is enforced by the
 			 * below acquire semantic.
 			 */
-			snap = ct_dynticks_cpu_acquire(cpu);
+			snap = ct_rcu_watching_cpu_acquire(cpu);
 			if (rcu_dynticks_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
-- 
2.40.1

