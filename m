Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0DF84DE4;
	Fri, 16 Aug 2024 04:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781096; cv=none; b=Gnok/U565D4djiRDCOERHdozJ8OzcTN+q215lqNRkk8ZjIo9GEMWaaeEjFFnZVbatG8bnd6z4nU4lC2XIPJf7s+ucXY2pHyLvulCxbJmWkP4UNV21qVSz3BqNxgBSe98l2c1IpTq7YI7t2TMcCb6rS40Y/O0prxDc+7mIBNIE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781096; c=relaxed/simple;
	bh=THKTu+qqZwMD5L0kBlzwGcrwFIAlx/sAcIbij6QiS+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b1GVFGsCvgtgMpixs0zlyxO1SfFeIXvm655ZWzmcw1tNXYqktQtqvfzXnFLIBrpgsJKGwe/L4D0BuA3cIrsL0auZeeMMkFbrHljymAcCK62xR/QZDkPxFTj5LxFLWczTXMt0320G2TG4+JGcWSUutkRmPdiA1/kk9771Nm7DQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7ZTaUJ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7ZTaUJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738EBC4AF0B;
	Fri, 16 Aug 2024 04:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781096;
	bh=THKTu+qqZwMD5L0kBlzwGcrwFIAlx/sAcIbij6QiS+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H7ZTaUJ1d5wA92LmRxQ/7LnW83Eaz2keopv7OXCO9ZBMf7LAVSMv+D4uV9reH1OLx
	 ZbKqNsql38TNYfAX2HnpPKhRt1bw49TwlMU2LHAQqxvbcT011U3SbMkI8NNA5aWXnU
	 QT4m8ObktHWkL1c4ocPeysmlhOQdf8cdtwfMyv0Zwp5OwKfZ347TfcJiKegNT7XrNU
	 gyzK7T/KsiQS4WJwmGETyZefM0gzCBfCTc1G7cZhssufSqAa+hIrrAvAUEqJkjTpEl
	 /BAdm0b8Rv+sOdN2r9Fvk5aS8cZuB3diuzIpl0bd3uZtTm+K3eg1DL2xNZbT9jNz/p
	 VIcNkcNprYP4A==
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
Subject: [PATCH rcu 12/26] context_tracking, rcu: Rename DYNTICK_IRQ_NONIDLE into CT_NESTING_IRQ_NONIDLE
Date: Fri, 16 Aug 2024 09:32:27 +0530
Message-Id: <20240816040241.17776-12-neeraj.upadhyay@kernel.org>
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
RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
meaning.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/context_tracking_state.h | 2 +-
 kernel/context_tracking.c              | 8 ++++----
 kernel/rcu/tree.c                      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 34fd504e53a8..0dbda59c9f37 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -7,7 +7,7 @@
 #include <linux/context_tracking_irq.h>
 
 /* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
-#define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
+#define CT_NESTING_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
 
 enum ctx_state {
 	CT_STATE_DISABLED	= -1,	/* returned by ct_state() if unknown */
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 115843eeb030..8262f57a4363 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -29,7 +29,7 @@
 DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 	.nesting = 1,
-	.nmi_nesting = DYNTICK_IRQ_NONIDLE,
+	.nmi_nesting = CT_NESTING_IRQ_NONIDLE,
 #endif
 	.state = ATOMIC_INIT(CT_RCU_WATCHING),
 };
@@ -125,7 +125,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
-	WARN_ON_ONCE(ct_nmi_nesting() != DYNTICK_IRQ_NONIDLE);
+	WARN_ON_ONCE(ct_nmi_nesting() != CT_NESTING_IRQ_NONIDLE);
 	WRITE_ONCE(ct->nmi_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     ct_nesting() == 0);
@@ -156,7 +156,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
  * Exit an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
  *
- * We crowbar the ->nmi_nesting field to DYNTICK_IRQ_NONIDLE to
+ * We crowbar the ->nmi_nesting field to CT_NESTING_IRQ_NONIDLE to
  * allow for the possibility of usermode upcalls messing up our count of
  * interrupt nesting level during the busy period that is just now starting.
  */
@@ -186,7 +186,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(ct->nesting, 1);
 	WARN_ON_ONCE(ct_nmi_nesting());
-	WRITE_ONCE(ct->nmi_nesting, DYNTICK_IRQ_NONIDLE);
+	WRITE_ONCE(ct->nmi_nesting, CT_NESTING_IRQ_NONIDLE);
 	instrumentation_end();
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 14cc314eedad..4778c873f4ac 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -599,7 +599,7 @@ void rcu_irq_exit_check_preempt(void)
 	RCU_LOCKDEP_WARN(ct_nesting() <= 0,
 			 "RCU nesting counter underflow/zero!");
 	RCU_LOCKDEP_WARN(ct_nmi_nesting() !=
-			 DYNTICK_IRQ_NONIDLE,
+			 CT_NESTING_IRQ_NONIDLE,
 			 "Bad RCU  nmi_nesting counter\n");
 	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
 			 "RCU in extended quiescent state!");
-- 
2.40.1

