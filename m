Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0078C6D;
	Fri, 16 Aug 2024 04:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781120; cv=none; b=lLIaEdY0YoHda7FE6ytjzz1r8K1yJI8b6XidVnOvJcTQxyQfnht4Pc2KSVBKMul1H6IC757hs2vacQv78sOUL5MXWytnVfQ6yU9qtsapIQSCjpxeStj16m6o6AzLdEGBW8Wz+zKb7ZI+qhsaNaxXP4Xc/0SF9AyieKdw1KtZ6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781120; c=relaxed/simple;
	bh=38Y/IJhB87OLzqPmhC++nD4wUogBNY48hQVAJtlQdIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ln02VB721z5lquTNKSNjc2I743scerHfowx6cJsABR35NmgUbkMGc/ygvTljJi7V9HlXCAETdVz2aCNWvDEvpGKLmrww2s96gCpmR+Nz+OMcq4kk7RwIVLCTuImyqLPkOTkZ4oPxTHy949aEOBIYeHRi9JH6cB1ec9kk3CQstX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meGHsZhp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meGHsZhp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0077AC32782;
	Fri, 16 Aug 2024 04:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781120;
	bh=38Y/IJhB87OLzqPmhC++nD4wUogBNY48hQVAJtlQdIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meGHsZhp4zLkXmZpcBfgyvbfyRf4lMQhOQbheLxorgupFPrZjMbbO32uFk/8Url84
	 +3KoPnS+7VbK6wg0H7m6eSxSEgCjg1TZqb/hVs8qPLc3uNMcuym4jrJsFYqY59NieA
	 2AMEQr7T4PXeUrrs78UeuBOIf50P/scr8cCepvrROYZ1tsF8O/HW98WCMLu0RrvJdI
	 X9i4gWwaE8tP51G2I6ORKFJw1nbqfCIkJ7PmZdKJAiP4oYIjUzyMXt2UI0/p7UPPOq
	 pIHfpF1tERmyOLLFTJleBxCarF1/bdbyB9gYlPOiO3PCaYo8d0/BmTy3yKQpj9Iy1o
	 6yN9cKifkXTSg==
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
Subject: [PATCH rcu 14/26] context_tracking, rcu: Rename rcu_dynticks_curr_cpu_in_eqs() into rcu_is_watching_curr_cpu()
Date: Fri, 16 Aug 2024 09:32:29 +0530
Message-Id: <20240816040241.17776-14-neeraj.upadhyay@kernel.org>
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

Note that "watching" is the opposite of "in EQS", so the negation is lifted
out of the helper and into the callsites.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/context_tracking.h | 12 ++++++++----
 kernel/context_tracking.c        |  6 +++---
 kernel/rcu/tree.c                |  6 +++---
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index a6c36780cc3b..d53092ffa9db 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -113,13 +113,17 @@ extern void ct_idle_enter(void);
 extern void ct_idle_exit(void);
 
 /*
- * Is the current CPU in an extended quiescent state?
+ * Is RCU watching the current CPU (IOW, it is not in an extended quiescent state)?
+ *
+ * Note that this returns the actual boolean data (watching / not watching),
+ * whereas ct_rcu_watching() returns the RCU_WATCHING subvariable of
+ * context_tracking.state.
  *
  * No ordering, as we are sampling CPU-local information.
  */
-static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
+static __always_inline bool rcu_is_watching_curr_cpu(void)
 {
-	return !(raw_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_RCU_WATCHING);
+	return raw_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_RCU_WATCHING;
 }
 
 /*
@@ -140,7 +144,7 @@ static __always_inline bool warn_rcu_enter(void)
 	 * lots of the actual reporting also relies on RCU.
 	 */
 	preempt_disable_notrace();
-	if (rcu_dynticks_curr_cpu_in_eqs()) {
+	if (!rcu_is_watching_curr_cpu()) {
 		ret = true;
 		ct_state_inc(CT_RCU_WATCHING);
 	}
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 00c8f128885a..31c6d0c1b79d 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -212,7 +212,7 @@ void noinstr ct_nmi_exit(void)
 	 * to us!)
 	 */
 	WARN_ON_ONCE(ct_nmi_nesting() <= 0);
-	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
+	WARN_ON_ONCE(!rcu_is_watching_curr_cpu());
 
 	/*
 	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
@@ -271,7 +271,7 @@ void noinstr ct_nmi_enter(void)
 	 * to be in the outermost NMI handler that interrupted an RCU-idle
 	 * period (observation due to Andy Lutomirski).
 	 */
-	if (rcu_dynticks_curr_cpu_in_eqs()) {
+	if (!rcu_is_watching_curr_cpu()) {
 
 		if (!in_nmi())
 			rcu_task_enter();
@@ -281,7 +281,7 @@ void noinstr ct_nmi_enter(void)
 		// ... but is watching here.
 
 		instrumentation_begin();
-		// instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
+		// instrumentation for the noinstr rcu_is_watching_curr_cpu()
 		instrument_atomic_read(&ct->state, sizeof(ct->state));
 		// instrumentation for the noinstr ct_kernel_enter_state()
 		instrument_atomic_write(&ct->state, sizeof(ct->state));
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4778c873f4ac..68eca7d3fdd1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -601,7 +601,7 @@ void rcu_irq_exit_check_preempt(void)
 	RCU_LOCKDEP_WARN(ct_nmi_nesting() !=
 			 CT_NESTING_IRQ_NONIDLE,
 			 "Bad RCU  nmi_nesting counter\n");
-	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
+	RCU_LOCKDEP_WARN(!rcu_is_watching_curr_cpu(),
 			 "RCU in extended quiescent state!");
 }
 #endif /* #ifdef CONFIG_PROVE_RCU */
@@ -641,7 +641,7 @@ void __rcu_irq_enter_check_tick(void)
 	if (in_nmi())
 		return;
 
-	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
+	RCU_LOCKDEP_WARN(!rcu_is_watching_curr_cpu(),
 			 "Illegal rcu_irq_enter_check_tick() from extended quiescent state");
 
 	if (!tick_nohz_full_cpu(rdp->cpu) ||
@@ -723,7 +723,7 @@ notrace bool rcu_is_watching(void)
 	bool ret;
 
 	preempt_disable_notrace();
-	ret = !rcu_dynticks_curr_cpu_in_eqs();
+	ret = rcu_is_watching_curr_cpu();
 	preempt_enable_notrace();
 	return ret;
 }
-- 
2.40.1

