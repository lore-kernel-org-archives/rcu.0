Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7E9770F1;
	Fri, 16 Aug 2024 04:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781114; cv=none; b=d319jfyaWs2uKJXkCVx9LuutVSSU1WqG5iBXfY5jLv6HGnAnuDZTRl3eIrDu5OIBo1JnuIIis4NqOTS3thxGkPANBLoje6yWskrDlDu1nISY8sh7geXiNBetkbEiCuhwr2WgV9zKxzRRTcZxR6dcyVGwcU0ZWNl7gdOKndE+9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781114; c=relaxed/simple;
	bh=0tBGnHusoipi1DnYmvCYm+XQmQDY34ztMhfItPHweQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k3+l8ffuf6CVGTLUKxHCFvFs1YhVItCjWfj3jamZEn+/Kq4PHLVw+lNRYuTdCtl8OX1J8usxKO/idwlGCSDkwFuTZus9kXgCJvAuLlj0Glqp7eMmKpCWmh3mP286NnealU8NKXAj9LWymYhPoxVhlDQGyB9wOX4wPhKAkqa+Utw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeTTMhK8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeTTMhK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D048AC32782;
	Fri, 16 Aug 2024 04:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781113;
	bh=0tBGnHusoipi1DnYmvCYm+XQmQDY34ztMhfItPHweQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jeTTMhK8AqLx7C0EN9f5PZZ+YYEKLu/NIzKxksH2eKpftdXSob/8sWPKPOnz64y/E
	 aRfZ/3HWcO4ZwHKdCq+kRqhkIXTRT3DqFFRhs0+pA/XPMlOG74GJLeu642KAxW/qGK
	 sLSHtdEd+njuifDOM3uM6C9lBVAMWhvH49AgxCtkZ9uiGgkPPkSBXKnoFRYqTH43HR
	 Bn8Xh1ZTatbnqFguV5dU1IRAJzHmps3c1zFT9tG+sQVryLiRin8UFF5RzqFun8uXYS
	 4aAX6IzZI2+LJn8ZTSc6l+3KOgpMdE4IacdKW6HgvDfeiJk7Cy9F0kU65q8pufL+9Q
	 i/Bp8py5OIG0g==
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
Subject: [PATCH rcu 13/26] context_tracking, rcu: Rename rcu_dynticks_task*() into rcu_task*()
Date: Fri, 16 Aug 2024 09:32:28 +0530
Message-Id: <20240816040241.17776-13-neeraj.upadhyay@kernel.org>
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

While at it, flip the suffixes of these helpers. We are not telling
that we are entering dynticks mode from an RCU-task perspective anymore; we
are telling that we are exiting RCU-tasks because we are in eqs mode.

[ neeraj.upadhyay: Incorporate Frederic Weisbecker feedback. ]

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/context_tracking.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 8262f57a4363..00c8f128885a 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -38,24 +38,24 @@ EXPORT_SYMBOL_GPL(context_tracking);
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 #define TPS(x)  tracepoint_string(x)
 
-/* Record the current task on dyntick-idle entry. */
-static __always_inline void rcu_dynticks_task_enter(void)
+/* Record the current task on exiting RCU-tasks (dyntick-idle entry). */
+static __always_inline void rcu_task_exit(void)
 {
 #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
 	WRITE_ONCE(current->rcu_tasks_idle_cpu, smp_processor_id());
 #endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
 }
 
-/* Record no current task on dyntick-idle exit. */
-static __always_inline void rcu_dynticks_task_exit(void)
+/* Record no current task on entering RCU-tasks (dyntick-idle exit). */
+static __always_inline void rcu_task_enter(void)
 {
 #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
 	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
 #endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
 }
 
-/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
-static __always_inline void rcu_dynticks_task_trace_enter(void)
+/* Turn on heavyweight RCU tasks trace readers on kernel exit. */
+static __always_inline void rcu_task_trace_heavyweight_enter(void)
 {
 #ifdef CONFIG_TASKS_TRACE_RCU
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
@@ -63,8 +63,8 @@ static __always_inline void rcu_dynticks_task_trace_enter(void)
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
-/* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
-static __always_inline void rcu_dynticks_task_trace_exit(void)
+/* Turn off heavyweight RCU tasks trace readers on kernel entry. */
+static __always_inline void rcu_task_trace_heavyweight_exit(void)
 {
 #ifdef CONFIG_TASKS_TRACE_RCU
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
@@ -87,7 +87,7 @@ static noinstr void ct_kernel_exit_state(int offset)
 	 * critical sections, and we also must force ordering with the
 	 * next idle sojourn.
 	 */
-	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
+	rcu_task_trace_heavyweight_enter();  // Before CT state update!
 	seq = ct_state_inc(offset);
 	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & CT_RCU_WATCHING));
@@ -109,7 +109,7 @@ static noinstr void ct_kernel_enter_state(int offset)
 	 */
 	seq = ct_state_inc(offset);
 	// RCU is now watching.  Better not be in an extended quiescent state!
-	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
+	rcu_task_trace_heavyweight_exit();  // After CT state update!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & CT_RCU_WATCHING));
 }
 
@@ -149,7 +149,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 	// RCU is watching here ...
 	ct_kernel_exit_state(offset);
 	// ... but is no longer watching here.
-	rcu_dynticks_task_enter();
+	rcu_task_exit();
 }
 
 /*
@@ -173,7 +173,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 		ct->nesting++;
 		return;
 	}
-	rcu_dynticks_task_exit();
+	rcu_task_enter();
 	// RCU is not watching here ...
 	ct_kernel_enter_state(offset);
 	// ... but is watching here.
@@ -240,7 +240,7 @@ void noinstr ct_nmi_exit(void)
 	// ... but is no longer watching here.
 
 	if (!in_nmi())
-		rcu_dynticks_task_enter();
+		rcu_task_exit();
 }
 
 /**
@@ -274,7 +274,7 @@ void noinstr ct_nmi_enter(void)
 	if (rcu_dynticks_curr_cpu_in_eqs()) {
 
 		if (!in_nmi())
-			rcu_dynticks_task_exit();
+			rcu_task_enter();
 
 		// RCU is not watching here ...
 		ct_kernel_enter_state(CT_RCU_WATCHING);
-- 
2.40.1

