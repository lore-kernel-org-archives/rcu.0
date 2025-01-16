Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB52361DE;
	Thu, 16 Jan 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058410; cv=none; b=G0G3r7CRcNrQNBe8Fdq20fEGfcNkqILH2td+lda+Bmitqmbki7wYnB/bifuYK0J6MdUqeHaPJbqTn7siuOHW4kCqiLg7qbfcrxuCSrQHioYrKa3v6VClUjEQAc825XsWCYgr7ImM2zb41bZ0jd2IX+2BQiOK6NSCKht+ldunECI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058410; c=relaxed/simple;
	bh=UlkuzeoqMzYgR+og5Wa1i/pWnGmyFhloUaxNTrXLAcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idwn1ZPZTjM0AeNKsE8cX4MzekX5o582nv896llAOotnx6Kq9FYuMKtZs56kMzbYDKFMHz7Crb94VSNEV0KQ3qBaPZVIYiS7oL+EdaQzwb/XRmLkYdCEowg+3lq5lL93TFG8tdlpdcaT370fUfvXc4OKuOLz+s7eqgJG9vK82KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL1tsiJX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL1tsiJX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21C2C4CEDF;
	Thu, 16 Jan 2025 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058409;
	bh=UlkuzeoqMzYgR+og5Wa1i/pWnGmyFhloUaxNTrXLAcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eL1tsiJX0l3qAYVtd8nXR0IM9MDWdFw5QOSYAFEEf+WC23k8BvEjd1SRpS0z48iem
	 OkuuYEQVkqixEgbm/gPsweYCmYAyj/SlchGB+n8X6Lijg6aseLYA36M0dFPp9M5Ws1
	 eb2BFHVGeijUcQMB+QzhCF3b4YWIJJjJgH65LGTEt65OOJBaDJ2SkLwYNoFlTNDY6x
	 Fy0NJoo5Yxm2in53WPAoaMbngMUknYX3C1cfNsl+eHOkny0+s+yNUpUQPAm8zZjUY0
	 N74QPWWe7bO8oiENy+bJnJgY0qgwZv7rIYJZ0SNX15A3qfDSyWk2JvJjpdy1DxDw7s
	 s/1BtBeJY170w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4CE74CE13C4; Thu, 16 Jan 2025 12:13:29 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH rcu 2/9] rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
Date: Thu, 16 Jan 2025 12:13:20 -0800
Message-Id: <20250116201327.3782963-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
References: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

Replace mentions of PREEMPT_AUTO with PREEMPT_LAZY.

Also, since PREMPT_LAZY implies PREEMPTION, we can reduce the
TASKS_RCU selection criteria from:

  NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
to:
  NEED_TASKS_RCU && PREEMPTION

CC: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutiny.h |  2 +-
 kernel/rcu/Kconfig       |  2 +-
 kernel/rcu/srcutiny.c    | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 1321da803274d..31b59b4be2a74 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -64,7 +64,7 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 {
 	int idx;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], READ_ONCE(ssp->srcu_lock_nesting[idx]) + 1);
 	preempt_enable();
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 2bb22dac3b5a9..582d461c9ab7d 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -91,7 +91,7 @@ config NEED_TASKS_RCU
 
 config TASKS_RCU
 	bool
-	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
+	default NEED_TASKS_RCU && PREEMPTION
 	select IRQ_WORK
 
 config FORCE_TASKS_RUDE_RCU
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 4dcbf8aa80ff7..f688bdad293ed 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -98,7 +98,7 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	int newval;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
 	preempt_enable();
@@ -120,7 +120,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	struct srcu_struct *ssp;
 
 	ssp = container_of(wp, struct srcu_struct, srcu_work);
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	if (ssp->srcu_gp_running || ULONG_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max))) {
 		preempt_enable();
 		return; /* Already running or nothing to do. */
@@ -138,7 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
 	preempt_enable();
 	swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 	preempt_enable();
@@ -159,7 +159,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	 * at interrupt level, but the ->srcu_gp_running checks will
 	 * straighten that out.
 	 */
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	WRITE_ONCE(ssp->srcu_gp_running, false);
 	idx = ULONG_CMP_LT(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max));
 	preempt_enable();
@@ -172,7 +172,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
 	unsigned long cookie;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	cookie = get_state_synchronize_srcu(ssp);
 	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
 		preempt_enable();
@@ -199,7 +199,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 
 	rhp->func = func;
 	rhp->next = NULL;
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	local_irq_save(flags);
 	*ssp->srcu_cb_tail = rhp;
 	ssp->srcu_cb_tail = &rhp->next;
@@ -261,7 +261,7 @@ unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
 {
 	unsigned long ret;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	ret = get_state_synchronize_srcu(ssp);
 	srcu_gp_start_if_needed(ssp);
 	preempt_enable();
-- 
2.40.1

