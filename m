Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4163330F540;
	Sat, 19 Sep 2026 00:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778132; cv=none; b=QRgFlYdmV1K73zcPv76WPY5bH2Ur4RALsTSnSsUY4aCgVzlDOqPH+QsWyPADbiQ4zBKD1/RcB5NT/Ayp7jAvuDGmvgO99SmKzmcUxGCILvDfqPN6Ioff+1tYODd7Ogr7d6CbtqqN5vdqjgk6jO2khx4O+vEBfPkH930FHmQ3szo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778132; c=relaxed/simple;
	bh=d4j09ruRw/K4F9/TxKJfNLBZqsAZxaVIe1N9gTmganU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ctbaZMo8pl7wgP7Zbstz3SyAiY06fB9Y5hVQIz5bG4jvmGNTRVmDwqmXSUJNdgCDg5VTybGk3oGN9ZkKKQAdVlUXwZ36NZd9LHHb6n3BkUELjFAtiWYvaaXLoRRjfVWZW4SixT9Hu4I7WjhkPzu9peP6zgybDar5VQza9sFsHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rty5pnLJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rty5pnLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06F61F00898;
	Sat, 19 Sep 2026 00:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778122;
	bh=5X3n3SbL6yjfY7i0kjbW990bAjkk+TLx5g/Sy6/tvxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rty5pnLJFVAaJKVuP5cwQPPwRZtjTi9/fdtQs3nnswFMvtSGjg/MNoMVHlChohH+n
	 Vvl2ViG7/cKh8GJeHWl//SMoX9TygZPHj/kZOcNE3epHtsS0CXaxjS1u/s5Ttfvy1g
	 TN8WQnyd/LJ7zIiaUF2aNAVf8nC1gbep1iCZXWaE9A3h9JgZq8z3zmpbCz+yZQN1F8
	 /qonuBpRnDx6ULysfQTAVGGsDI0JhoMWoC7Vj2fytn/RpdhAc5Y/rsmOK3khnIiiOO
	 G0PtLJUhG14l8VkVkGDvmRSGozzodj1rpP10UzPYvn2UF5ach8+b/qKivM8GLXuvnd
	 zQMDnEpGjV6FQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 954D4CE178A; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 02/19] srcutree: Suppress srcu_advance_state() mutex_lock in atomic
Date: Fri, 18 Sep 2026 17:35:04 -0700
Message-Id: <20260919003521.3134552-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new SRCU_READ_FLAVOR_ATOMIC prohibits sleeping in both readers and
grace-period waits in order to permit waiting on an SRCU grace period
within an OOM notifier.  This means that srcu_advance_state() cannot
acquire ->srcu_gp_mutex in this case, because mutex_lock() can sleep.

This commit therefore adds an is_atomic parameter to srcu_advance_state().
When this parameter is false, current behavior is maintained, in other
words, ->srcu_gp_mutex is acquired and released as before.  But when this
is_atomic parameter is false, the caller is responsible for excluding
other callers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d32c374ee72a..dc063eb49b0d 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1941,13 +1941,16 @@ EXPORT_SYMBOL_GPL(srcu_batches_completed);
 /*
  * Core SRCU state machine.  Push state bits of ->srcu_gp_seq
  * to SRCU_STATE_SCAN2, and invoke srcu_gp_end() when scan has
- * completed in that state.
+ * completed in that state.  Set is_atomic to indicate that
+ * the caller is excluding other calls so that ->srcu_gp_mutex
+ * is not needed, and to indicate that blocking is forbidden.
  */
-static void srcu_advance_state(struct srcu_struct *ssp)
+static void srcu_advance_state(struct srcu_struct *ssp, bool is_atomic)
 {
 	int idx;
 
-	mutex_lock(&ssp->srcu_sup->srcu_gp_mutex);
+	if (!is_atomic)
+		mutex_lock(&ssp->srcu_sup->srcu_gp_mutex);
 
 	/*
 	 * Because readers might be delayed for an extended period after
@@ -1965,7 +1968,8 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 		if (ULONG_CMP_GE(ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed)) {
 			WARN_ON_ONCE(rcu_seq_state(ssp->srcu_sup->srcu_gp_seq));
 			raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
-			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
+			if (!is_atomic)
+				mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return;
 		}
 		idx = rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq));
@@ -1973,7 +1977,8 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 			srcu_gp_start(ssp);
 		raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
 		if (idx != SRCU_STATE_IDLE) {
-			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
+			if (!is_atomic)
+				mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* Someone else started the grace period. */
 		}
 	}
@@ -1981,7 +1986,8 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 	if (rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)) == SRCU_STATE_SCAN1) {
 		idx = !(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0]);
 		if (!try_check_zero(ssp, idx, 1)) {
-			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
+			if (!is_atomic)
+				mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* readers present, retry later. */
 		}
 		srcu_flip(ssp);
@@ -1999,7 +2005,8 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 		 */
 		idx = !(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0]);
 		if (!try_check_zero(ssp, idx, 2)) {
-			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
+			if (!is_atomic)
+				mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* readers present, retry later. */
 		}
 		ssp->srcu_sup->srcu_n_exp_nodelay = 0;
@@ -2107,7 +2114,7 @@ static void process_srcu(struct work_struct *work)
 	sup = container_of(work, struct srcu_usage, work.work);
 	ssp = sup->srcu_ssp;
 
-	srcu_advance_state(ssp);
+	srcu_advance_state(ssp, false);
 	raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
 	curdelay = srcu_get_delay(ssp);
 	raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
-- 
2.40.1

