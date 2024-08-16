Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2DC13B597;
	Fri, 16 Aug 2024 04:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781189; cv=none; b=Wwhqvu0l2tihLnTbPecNd7M6K+2nDx/7Rdv/Jeq9nSze9NyHAzpDLVgHaP3ahGnsHCpEdr2NwjMYUXKBypJT05xNXRWRqfgkfrtAcn2lH7tzMFEjaf6bx9vRzF8tZdlKJA+acLGLxybKpuWUodv5z47dz/hIMP86qe/+FpZB/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781189; c=relaxed/simple;
	bh=1AKpEgn3U4vxGjMUiUyEqACsLBPHdiJlIcWsaU4OHL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H+n3UHYUC33xy0sgsAnJzmkiUYvgH8b1MrqTRx0pTn5j+q2U+/nHh5HnF6jau1wkg4ZR08sOGzYzYtCCoa6TeAcGvwOYu78aaF2pbJWeafG+MRv/E+reoSYajGfzLKxVarpzafWqiXmOvV0k/lNWA25s25H7cLelUgufmiYoNPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7cjazo6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7cjazo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C1DC32782;
	Fri, 16 Aug 2024 04:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781188;
	bh=1AKpEgn3U4vxGjMUiUyEqACsLBPHdiJlIcWsaU4OHL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7cjazo6+WgNuDELxbgr+tCuWahDGvpThg0ZKXSOy99VkebuLy72vgRuRIj//Udgy
	 zBUcYIe80FsNRnG1kXvjN8PYzLzF1grXUYVb+xLom6AOV8R2HgWZNaGUdq603c25LP
	 RVomR5JqHuWi395Ewb6kSCmgoGFG/ylz8XLWaSGqPfrwKWXuuDJEOTh93/H4ND+qre
	 ZLOcOK8iCr9vmqvtH95gpLy+hUEx1XOXvIDqIrBYORgVlwhxHc9P0S14le8H2kTjvr
	 +jNYTwbYvO/xwDvFCMq/ByjOqU4flIGel7aBuNTKm0UNQng8QePA/9iRWqUZJIp09a
	 phbUbMDFgcIJg==
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
Subject: [PATCH rcu 23/26] rcu: Rename rcu_momentary_dyntick_idle() into rcu_momentary_eqs()
Date: Fri, 16 Aug 2024 09:32:38 +0530
Message-Id: <20240816040241.17776-23-neeraj.upadhyay@kernel.org>
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
RCU_WATCHING, replace "dyntick_idle" into "eqs" to drop the dyntick
reference.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/rcutiny.h      | 2 +-
 include/linux/rcutree.h      | 2 +-
 kernel/rcu/rcutorture.c      | 4 ++--
 kernel/rcu/tree.c            | 4 ++--
 kernel/rcu/tree_nocb.h       | 2 +-
 kernel/rcu/tree_plugin.h     | 6 +++---
 kernel/stop_machine.c        | 2 +-
 kernel/trace/trace_osnoise.c | 4 ++--
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index d9ac7b136aea..cf2b5a188f78 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -158,7 +158,7 @@ void rcu_scheduler_starting(void);
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
-static inline void rcu_momentary_dyntick_idle(void) { }
+static inline void rcu_momentary_eqs(void) { }
 static inline void kfree_rcu_scheduler_running(void) { }
 static inline bool rcu_gp_might_be_stalled(void) { return false; }
 
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 254244202ea9..7dbde2b6f714 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -37,7 +37,7 @@ void synchronize_rcu_expedited(void);
 void kvfree_call_rcu(struct rcu_head *head, void *ptr);
 
 void rcu_barrier(void);
-void rcu_momentary_dyntick_idle(void);
+void rcu_momentary_eqs(void);
 void kfree_rcu_scheduler_running(void);
 bool rcu_gp_might_be_stalled(void);
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 08bf7c669dd3..ef757c3e84a2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2680,7 +2680,7 @@ static unsigned long rcu_torture_fwd_prog_cbfree(struct rcu_fwd *rfp)
 		rcu_torture_fwd_prog_cond_resched(freed);
 		if (tick_nohz_full_enabled()) {
 			local_irq_save(flags);
-			rcu_momentary_dyntick_idle();
+			rcu_momentary_eqs();
 			local_irq_restore(flags);
 		}
 	}
@@ -2830,7 +2830,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 		rcu_torture_fwd_prog_cond_resched(n_launders + n_max_cbs);
 		if (tick_nohz_full_enabled()) {
 			local_irq_save(flags);
-			rcu_momentary_dyntick_idle();
+			rcu_momentary_eqs();
 			local_irq_restore(flags);
 		}
 	}
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b53b354417ae..e0f6fc272906 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -367,7 +367,7 @@ bool rcu_watching_zero_in_eqs(int cpu, int *vp)
  *
  * The caller must have disabled interrupts and must not be idle.
  */
-notrace void rcu_momentary_dyntick_idle(void)
+notrace void rcu_momentary_eqs(void)
 {
 	int seq;
 
@@ -377,7 +377,7 @@ notrace void rcu_momentary_dyntick_idle(void)
 	WARN_ON_ONCE(!(seq & CT_RCU_WATCHING));
 	rcu_preempt_deferred_qs(current);
 }
-EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
+EXPORT_SYMBOL_GPL(rcu_momentary_eqs);
 
 /**
  * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 3ce30841119a..e629646ac6f5 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -917,7 +917,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
 
 	local_irq_save(flags);
-	rcu_momentary_dyntick_idle();
+	rcu_momentary_eqs();
 	local_irq_restore(flags);
 	/*
 	 * Disable BH to provide the expected environment.  Also, when
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c569da65b421..354fbf2e411c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -869,7 +869,7 @@ static void rcu_qs(void)
 
 /*
  * Register an urgently needed quiescent state.  If there is an
- * emergency, invoke rcu_momentary_dyntick_idle() to do a heavy-weight
+ * emergency, invoke rcu_momentary_eqs() to do a heavy-weight
  * dyntick-idle quiescent state visible to other CPUs, which will in
  * some cases serve for expedited as well as normal grace periods.
  * Either way, register a lightweight quiescent state.
@@ -889,7 +889,7 @@ void rcu_all_qs(void)
 	this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs))) {
 		local_irq_save(flags);
-		rcu_momentary_dyntick_idle();
+		rcu_momentary_eqs();
 		local_irq_restore(flags);
 	}
 	rcu_qs();
@@ -909,7 +909,7 @@ void rcu_note_context_switch(bool preempt)
 		goto out;
 	this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs)))
-		rcu_momentary_dyntick_idle();
+		rcu_momentary_eqs();
 out:
 	rcu_tasks_qs(current, preempt);
 	trace_rcu_utilization(TPS("End context switch"));
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a..da821ce258ea 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -251,7 +251,7 @@ static int multi_cpu_stop(void *data)
 			 */
 			touch_nmi_watchdog();
 		}
-		rcu_momentary_dyntick_idle();
+		rcu_momentary_eqs();
 	} while (curstate != MULTI_STOP_EXIT);
 
 	local_irq_restore(flags);
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 66a871553d4a..ad86b1ba2e43 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1535,7 +1535,7 @@ static int run_osnoise(void)
 		 * This will eventually cause unwarranted noise as PREEMPT_RCU
 		 * will force preemption as the means of ending the current
 		 * grace period. We avoid this problem by calling
-		 * rcu_momentary_dyntick_idle(), which performs a zero duration
+		 * rcu_momentary_eqs(), which performs a zero duration
 		 * EQS allowing PREEMPT_RCU to end the current grace period.
 		 * This call shouldn't be wrapped inside an RCU critical
 		 * section.
@@ -1547,7 +1547,7 @@ static int run_osnoise(void)
 			if (!disable_irq)
 				local_irq_disable();
 
-			rcu_momentary_dyntick_idle();
+			rcu_momentary_eqs();
 
 			if (!disable_irq)
 				local_irq_enable();
-- 
2.40.1

