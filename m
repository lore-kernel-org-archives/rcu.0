Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD8B82488;
	Fri, 16 Aug 2024 04:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781078; cv=none; b=Lm2wqOxBGahuTJkc+KpLe/VStNnRJQ6uorOKfPscQQ3BOCULoYWhDuqePe8fidUPSPmEAWFg+pVKvMF/UdxBTFQJ6FXX6bicBt9e4V2hkpWO1Uo77/RtO7R2P3TTOkMlMN43l8ZtnISnF65BB7MU1vtT7V6qeQhwjx0A1BbJlzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781078; c=relaxed/simple;
	bh=GRWciJuVIN13exrIEry43JWRpUFvmg9EQQUVwxm6HNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uvyTTpHDRp53D9JQQX8lO86gtDIK85S1bvvwERfE037Wg+3vXYLkK5ArqmlrxweqFvliXBzPj3IyxkLoYC5UvmXCt0ebDo/k0st+UY4L6ySTbZrrQM+kFiZMPKmIokMIbDg+1Bqocxm0eSlqZ1xSKJHK+RGeMgO80g4v0gdNj1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRpOi3hS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRpOi3hS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAE0C32782;
	Fri, 16 Aug 2024 04:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781078;
	bh=GRWciJuVIN13exrIEry43JWRpUFvmg9EQQUVwxm6HNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRpOi3hSopzo/Xx/+yXZ4yiEXJ5G5Oy/tdeM7y4kNUbd2JB07Ku0telDMj9Y9ohNp
	 4Glvt3oJiyjsvjQ4BbinZ5sWW2quNfrnDHH2cmh1Z95RYcXQ2vuwDRT0tgLppSXTw7
	 J/PpFXTd+w9Iz5YYnsmptbNiC2qvNceULEhqAcA9aWxYcQHsSTuwOrdsURKq07ze1b
	 A/55MkE7oacPqA4V+vmZexvCpRXYEChWjy1UbtW18y2RCR3k70N3mZVOB/R81e0A0r
	 zlYzjZO5ERzrSTE9we0GHC4GoHfqM6giIwOI81fIbSMzUNPOeZSvHya744ERc21M+I
	 sWin8xkwdqX3g==
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
Subject: [PATCH rcu 10/26] context_tracking, rcu: Rename ct_dynticks_nmi_nesting() into ct_nmi_nesting()
Date: Fri, 16 Aug 2024 09:32:25 +0530
Message-Id: <20240816040241.17776-10-neeraj.upadhyay@kernel.org>
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

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/context_tracking_state.h |  2 +-
 kernel/context_tracking.c              | 24 ++++++++++++------------
 kernel/rcu/tree.c                      |  6 +++---
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 12d00adf29e1..8f32fe599c5c 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -87,7 +87,7 @@ static __always_inline long ct_nesting_cpu(int cpu)
 	return ct->nesting;
 }
 
-static __always_inline long ct_dynticks_nmi_nesting(void)
+static __always_inline long ct_nmi_nesting(void)
 {
 	return __this_cpu_read(context_tracking.nmi_nesting);
 }
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index ae94215aa132..115843eeb030 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -125,7 +125,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
-	WARN_ON_ONCE(ct_dynticks_nmi_nesting() != DYNTICK_IRQ_NONIDLE);
+	WARN_ON_ONCE(ct_nmi_nesting() != DYNTICK_IRQ_NONIDLE);
 	WRITE_ONCE(ct->nmi_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     ct_nesting() == 0);
@@ -185,7 +185,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	trace_rcu_dyntick(TPS("End"), ct_nesting(), 1, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(ct->nesting, 1);
-	WARN_ON_ONCE(ct_dynticks_nmi_nesting());
+	WARN_ON_ONCE(ct_nmi_nesting());
 	WRITE_ONCE(ct->nmi_nesting, DYNTICK_IRQ_NONIDLE);
 	instrumentation_end();
 }
@@ -207,28 +207,28 @@ void noinstr ct_nmi_exit(void)
 
 	instrumentation_begin();
 	/*
-	 * Check for ->nmi_nesting underflow and bad ->dynticks.
+	 * Check for ->nmi_nesting underflow and bad CT state.
 	 * (We are exiting an NMI handler, so RCU better be paying attention
 	 * to us!)
 	 */
-	WARN_ON_ONCE(ct_dynticks_nmi_nesting() <= 0);
+	WARN_ON_ONCE(ct_nmi_nesting() <= 0);
 	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
 
 	/*
 	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
 	 * leave it in non-RCU-idle state.
 	 */
-	if (ct_dynticks_nmi_nesting() != 1) {
-		trace_rcu_dyntick(TPS("--="), ct_dynticks_nmi_nesting(), ct_dynticks_nmi_nesting() - 2,
+	if (ct_nmi_nesting() != 1) {
+		trace_rcu_dyntick(TPS("--="), ct_nmi_nesting(), ct_nmi_nesting() - 2,
 				  ct_rcu_watching());
 		WRITE_ONCE(ct->nmi_nesting, /* No store tearing. */
-			   ct_dynticks_nmi_nesting() - 2);
+			   ct_nmi_nesting() - 2);
 		instrumentation_end();
 		return;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), ct_dynticks_nmi_nesting(), 0, ct_rcu_watching());
+	trace_rcu_dyntick(TPS("Startirq"), ct_nmi_nesting(), 0, ct_rcu_watching());
 	WRITE_ONCE(ct->nmi_nesting, 0); /* Avoid store tearing. */
 
 	// instrumentation for the noinstr ct_kernel_exit_state()
@@ -261,7 +261,7 @@ void noinstr ct_nmi_enter(void)
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
 	/* Complain about underflow. */
-	WARN_ON_ONCE(ct_dynticks_nmi_nesting() < 0);
+	WARN_ON_ONCE(ct_nmi_nesting() < 0);
 
 	/*
 	 * If idle from RCU viewpoint, atomically increment CT state
@@ -295,11 +295,11 @@ void noinstr ct_nmi_enter(void)
 	}
 
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
-			  ct_dynticks_nmi_nesting(),
-			  ct_dynticks_nmi_nesting() + incby, ct_rcu_watching());
+			  ct_nmi_nesting(),
+			  ct_nmi_nesting() + incby, ct_rcu_watching());
 	instrumentation_end();
 	WRITE_ONCE(ct->nmi_nesting, /* Prevent store tearing. */
-		   ct_dynticks_nmi_nesting() + incby);
+		   ct_nmi_nesting() + incby);
 	barrier();
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 934f6b34a551..14cc314eedad 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -390,11 +390,11 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	/* Check for counter underflows */
 	RCU_LOCKDEP_WARN(ct_nesting() < 0,
 			 "RCU nesting counter underflow!");
-	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() <= 0,
+	RCU_LOCKDEP_WARN(ct_nmi_nesting() <= 0,
 			 "RCU nmi_nesting counter underflow/zero!");
 
 	/* Are we at first interrupt nesting level? */
-	nesting = ct_dynticks_nmi_nesting();
+	nesting = ct_nmi_nesting();
 	if (nesting > 1)
 		return false;
 
@@ -598,7 +598,7 @@ void rcu_irq_exit_check_preempt(void)
 
 	RCU_LOCKDEP_WARN(ct_nesting() <= 0,
 			 "RCU nesting counter underflow/zero!");
-	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() !=
+	RCU_LOCKDEP_WARN(ct_nmi_nesting() !=
 			 DYNTICK_IRQ_NONIDLE,
 			 "Bad RCU  nmi_nesting counter\n");
 	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
-- 
2.40.1

