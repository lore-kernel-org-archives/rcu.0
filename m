Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B4B41D4E9;
	Wed,  7 Oct 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406771; cv=none; b=euxg3RFMF3U9JpqJJjgHVtHexmc4+4epznYrKkGDJaerPO8vaxJKWpjVD7Z6CrEQPFOT/YhZ9Kg0GqIb/H1j94hDZYH9eRZO3pgWF8QM81tnEJA/Vh2WxPooOtPWx/p2cDrVSQiaPcQPK1AMtN5g5+Oq9nlpnh6UnqrV7g79EnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406771; c=relaxed/simple;
	bh=qW1U9Tn8sK00tRSmwW7M3RoWBLdQ73Pbxw0EUOM1+M4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmpSg9TVGcesAeXJJnp7/yf4gHmZctDLgecj+6yGsQC7hS+924hUZGOHz8Sng0HPI9GfYIfo7Mg48Gapfyqe/lW79dWdWKYktDMMtRiLZnHhtAyGfoAgZleD/ICpSSttBC6UQg2Rnk7cdHS7In4vq5xr9UlHi38Y2sztwkWngnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVHnGw+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVHnGw+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12A51F008A4;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406766;
	bh=HTJa96a9LFFoiQCN8tL5p628hYSm3JYsH8jXk8jtbzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jVHnGw+MmXnVbM2MfShThMMVuGbn93Mg0ppz64izTvnuKnu4UPGH1dr5ws3MFUd6y
	 oBqW7yHJZKK22r36g6i3oE9Tyt1idvm+kx5tFlDqDbSQwSCe1AHxoVF8xsn5/suNKr
	 /vDQE2Rd2Dkba3PmQQVRIvL/2ski000D01TSrHn+2QnSUt/Ju1ohQMIvgEoyUsSSy6
	 NdG+IuXPDhJs1UfpXDU0RYlLAgW9UobaTBrKPu+7h/dMVDlY8k143T3uvIbm369DsI
	 GtSFJ6+mO1JxA9gcqPGEzA0FFZNilnMjeg8J8B1Msh8Dwg02Ac0lcOHu/30PlnAhAA
	 23Z9VZK+no36g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 44FCCCE39A0; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 21/21] srcutree: Preserve IRQ state in synchronize_srcu_atomic() callchain
Date: Wed,  7 Oct 2026 13:59:24 -0700
Message-Id: <20261007205924.1983367-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

synchronize_srcu_atomic() may be called with interrupts disabled, but
its callchain uses raw_spin_lock_irq_rcu_node() /
raw_spin_unlock_irq_rcu_node(), which unconditionally enables
interrupts on unlock. This can incorrectly change the caller's IRQ
state.

Use the irqsave/irqrestore variants for the locks in this callchain
so that the caller's IRQ state is preserved.

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7890f7c7c2ee7..c8209aa6552a1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -985,6 +985,7 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 	bool cbs;
 	bool last_lvl;
 	int cpu;
+	unsigned long flags;
 	unsigned long gpseq;
 	int idx;
 	unsigned long mask;
@@ -999,7 +1000,7 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 		mutex_lock(&sup->srcu_cb_mutex);
 
 	/* End the current grace period. */
-	raw_spin_lock_irq_rcu_node(sup);
+	raw_spin_lock_irqsave_rcu_node(sup, flags);
 	idx = rcu_seq_state(sup->srcu_gp_seq);
 	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
 	if (srcu_gp_is_expedited(ssp))
@@ -1010,7 +1011,7 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 	gpseq = rcu_seq_current(&sup->srcu_gp_seq);
 	if (ULONG_CMP_LT(sup->srcu_gp_seq_needed_exp, gpseq))
 		WRITE_ONCE(sup->srcu_gp_seq_needed_exp, gpseq);
-	raw_spin_unlock_irq_rcu_node(sup);
+	raw_spin_unlock_irqrestore_rcu_node(sup, flags);
 	if (!is_atomic)
 		mutex_unlock(&sup->srcu_gp_mutex);
 	/* A new grace period can start at this point.  But only one. */
@@ -1048,12 +1049,12 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 	if (!(gpseq & counter_wrap_check))
 		for_each_possible_cpu(cpu) {
 			sdp = per_cpu_ptr(ssp->sda, cpu);
-			raw_spin_lock_irq_rcu_node(sdp);
+			raw_spin_lock_irqsave_rcu_node(sdp, flags);
 			if (ULONG_CMP_GE(gpseq, sdp->srcu_gp_seq_needed + 100))
 				sdp->srcu_gp_seq_needed = gpseq;
 			if (ULONG_CMP_GE(gpseq, sdp->srcu_gp_seq_needed_exp + 100))
 				sdp->srcu_gp_seq_needed_exp = gpseq;
-			raw_spin_unlock_irq_rcu_node(sdp);
+			raw_spin_unlock_irqrestore_rcu_node(sdp, flags);
 		}
 
 	/* Callback initiation done, allow grace periods after next. */
@@ -1061,16 +1062,16 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 		mutex_unlock(&sup->srcu_cb_mutex);
 
 	/* Start a new grace period if needed. */
-	raw_spin_lock_irq_rcu_node(sup);
+	raw_spin_lock_irqsave_rcu_node(sup, flags);
 	gpseq = rcu_seq_current(&sup->srcu_gp_seq);
 	if (!rcu_seq_state(gpseq) &&
 	    ULONG_CMP_LT(gpseq, sup->srcu_gp_seq_needed)) {
 		WARN_ON_ONCE(ssp->srcu_reader_flavor & SRCU_READ_FLAVOR_ATOMIC);
 		srcu_gp_start(ssp);
-		raw_spin_unlock_irq_rcu_node(sup);
+		raw_spin_unlock_irqrestore_rcu_node(sup, flags);
 		srcu_reschedule(ssp, 0);
 	} else {
-		raw_spin_unlock_irq_rcu_node(sup);
+		raw_spin_unlock_irqrestore_rcu_node(sup, flags);
 	}
 
 	/* Transition to big if needed, but never for atomic SRCU. */
@@ -1220,10 +1221,11 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 {
 	unsigned long curdelay;
+	unsigned long flags;
 
-	raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
+	raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
 	curdelay = !srcu_get_delay(ssp);
-	raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
+	raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 
 	for (;;) {
 		if (srcu_readers_active_idx_check(ssp, idx))
@@ -2023,6 +2025,7 @@ EXPORT_SYMBOL_GPL(srcu_batches_completed);
  */
 static void srcu_advance_state(struct srcu_struct *ssp, bool is_atomic)
 {
+	unsigned long flags;
 	int idx;
 
 	if (!is_atomic)
@@ -2040,10 +2043,10 @@ static void srcu_advance_state(struct srcu_struct *ssp, bool is_atomic)
 	 */
 	idx = rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq)); /* ^^^ */
 	if (idx == SRCU_STATE_IDLE) {
-		raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
+		raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
 		if (ULONG_CMP_GE(ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed)) {
 			WARN_ON_ONCE(rcu_seq_state(ssp->srcu_sup->srcu_gp_seq));
-			raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
+			raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 			if (!is_atomic)
 				mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return;
@@ -2053,7 +2056,7 @@ static void srcu_advance_state(struct srcu_struct *ssp, bool is_atomic)
 			WARN_ON_ONCE(ssp->srcu_reader_flavor & SRCU_READ_FLAVOR_ATOMIC);
 			srcu_gp_start(ssp);
 		}
-		raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
+		raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 		if (idx != SRCU_STATE_IDLE) {
 			if (!is_atomic)
 				mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
@@ -2069,10 +2072,10 @@ static void srcu_advance_state(struct srcu_struct *ssp, bool is_atomic)
 			return; /* readers present, retry later. */
 		}
 		srcu_flip(ssp);
-		raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
+		raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
 		rcu_seq_set_state(&ssp->srcu_sup->srcu_gp_seq, SRCU_STATE_SCAN2);
 		ssp->srcu_sup->srcu_n_exp_nodelay = 0;
-		raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
+		raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 	}
 
 	if (rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
@@ -2119,6 +2122,7 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 {
 	unsigned long srcu_state;
 	struct srcu_usage *sup = ssp->srcu_sup;
+	unsigned long flags;
 	unsigned long rdm0, rdm1;
 	unsigned long unlocks0, unlocks1;
 
@@ -2149,9 +2153,9 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 	}
 
 	// One last check for others doing our work for us under the lock.
-	raw_spin_lock_irq_rcu_node(sup);
+	raw_spin_lock_irqsave_rcu_node(sup, flags);
 	if (poll_state_synchronize_srcu(ssp, srcu_state)) {
-		raw_spin_unlock_irq_rcu_node(sup);
+		raw_spin_unlock_irqrestore_rcu_node(sup, flags);
 		atomic_set(&sup->srcu_atomic_gp_flag, 0);
 		preempt_enable();
 		return;
@@ -2162,7 +2166,7 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 	smp_store_release(&sup->srcu_gp_seq_needed, srcu_state); // See srcu_funnel_gp_start().
 	ASSERT_EXCLUSIVE_WRITER(ssp->srcu_sup->srcu_gp_seq);
 	srcu_gp_start(ssp);
-	raw_spin_unlock_irq_rcu_node(sup);
+	raw_spin_unlock_irqrestore_rcu_node(sup, flags);
 
 	//
 	// Fastpath:  If there are no readers at all, neither grace-period
@@ -2200,9 +2204,9 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 		// poll_state_synchronize_srcu() working, all under ->lock
 		// and ->srcu_atomic_gp_flag, which excludes concurrent
 		// sequence-number updates.
-		raw_spin_lock_irq_rcu_node(sup);
+		raw_spin_lock_irqsave_rcu_node(sup, flags);
 		rcu_seq_end(&sup->srcu_gp_seq);
-		raw_spin_unlock_irq_rcu_node(sup);
+		raw_spin_unlock_irqrestore_rcu_node(sup, flags);
 		WARN_ON_ONCE(!poll_state_synchronize_srcu(ssp, srcu_state));
 		atomic_set_release(&sup->srcu_atomic_gp_flag, 0);
 		preempt_enable();
-- 
2.40.1

