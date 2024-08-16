Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D46F077;
	Fri, 16 Aug 2024 04:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781057; cv=none; b=cfDMWKghfKrhT9lTfZEd9DscTqopvQNPwhaJw+O861q2BEmyu1jRkRQEubtkkInG68k4zoOT93cnKJkFJWnmyxDorQ6Tq59PAF1Ng8ogtX4P2ENtaaLVq+Tr4yy8SdxKxo06vOj5ARINjSIO3eeD3E+/vDVx+B9lCzPfOiJRc+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781057; c=relaxed/simple;
	bh=ekhSu6/CJ43f9nrJP4ALZW5Tq/0idh0P3w/90Gcl9f8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=glChQKfVsQKIPiUE+/kfhadRJSowYiT7PpnihzmuJLlq0mnqfK5qYWnHy0fAnSdxXQHmNK59ZLhqveyqhxLI8sdOi511XrsZ0jiD/R4LAzV2DWltX8YwcWqjN/LKzCsOaysvvN6Z/KZWBQZV2iSW4znYoc6l4B1qve+khfrr1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Axi+u7g8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Axi+u7g8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96FAC4AF09;
	Fri, 16 Aug 2024 04:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781056;
	bh=ekhSu6/CJ43f9nrJP4ALZW5Tq/0idh0P3w/90Gcl9f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Axi+u7g8OfRbktStpUAF6wDcyUNNzeDzDfTV6eg0QspgcFFReXqKwkK8A+fYSPx5B
	 hF0FrAmcprfemgFvltXwRqBV8PVlij+zE82AFl2kMz0u/N5rLxhhhmxr9P6uLEcIZL
	 q81ClEXqINZXfznpS68UBdI3IL9+pXvqhq1P5DC34kf/YEW5dqa/meHrT4c9pBpGNX
	 MK9L/GEqeRi19iolVuqkUVgnFa3qUBuD/FGJ1YOx8pK6sBNqQx7rfRjtHMXIYluHWL
	 50RjrAWKU5iTTJOOJT+jcw21P9+Ydk/A35KhJ3fSZnW39S3AGvt4I3LsIjz4Am7lQc
	 PTbh+hN2g67MQ==
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
Subject: [PATCH rcu 07/26] context_tracking, rcu: Rename ct_dynticks_nesting() into ct_nesting()
Date: Fri, 16 Aug 2024 09:32:22 +0530
Message-Id: <20240816040241.17776-7-neeraj.upadhyay@kernel.org>
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

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/context_tracking_state.h |  2 +-
 kernel/context_tracking.c              | 10 +++++-----
 kernel/rcu/tree.c                      |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 65290e7677e6..586c1ff22c2e 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -75,7 +75,7 @@ static __always_inline int ct_rcu_watching_cpu_acquire(int cpu)
 	return atomic_read_acquire(&ct->state) & CT_RCU_WATCHING_MASK;
 }
 
-static __always_inline long ct_dynticks_nesting(void)
+static __always_inline long ct_nesting(void)
 {
 	return __this_cpu_read(context_tracking.nesting);
 }
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 5cfdfc03b401..a951bde0bbcb 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -128,8 +128,8 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 	WARN_ON_ONCE(ct_dynticks_nmi_nesting() != DYNTICK_IRQ_NONIDLE);
 	WRITE_ONCE(ct->dynticks_nmi_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     ct_dynticks_nesting() == 0);
-	if (ct_dynticks_nesting() != 1) {
+		     ct_nesting() == 0);
+	if (ct_nesting() != 1) {
 		// RCU will still be watching, so just do accounting and leave.
 		ct->nesting--;
 		return;
@@ -137,7 +137,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 
 	instrumentation_begin();
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), ct_dynticks_nesting(), 0, ct_rcu_watching());
+	trace_rcu_dyntick(TPS("Start"), ct_nesting(), 0, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rcu_preempt_deferred_qs(current);
 
@@ -166,7 +166,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	long oldval;
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
-	oldval = ct_dynticks_nesting();
+	oldval = ct_nesting();
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
 	if (oldval) {
 		// RCU was already watching, so just do accounting and leave.
@@ -182,7 +182,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	// instrumentation for the noinstr ct_kernel_enter_state()
 	instrument_atomic_write(&ct->state, sizeof(ct->state));
 
-	trace_rcu_dyntick(TPS("End"), ct_dynticks_nesting(), 1, ct_rcu_watching());
+	trace_rcu_dyntick(TPS("End"), ct_nesting(), 1, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(ct->nesting, 1);
 	WARN_ON_ONCE(ct_dynticks_nmi_nesting());
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0d5a539acd58..cf69a234080f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -388,7 +388,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	lockdep_assert_irqs_disabled();
 
 	/* Check for counter underflows */
-	RCU_LOCKDEP_WARN(ct_dynticks_nesting() < 0,
+	RCU_LOCKDEP_WARN(ct_nesting() < 0,
 			 "RCU nesting counter underflow!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() <= 0,
 			 "RCU dynticks_nmi_nesting counter underflow/zero!");
@@ -404,7 +404,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	WARN_ON_ONCE(!nesting && !is_idle_task(current));
 
 	/* Does CPU appear to be idle from an RCU standpoint? */
-	return ct_dynticks_nesting() == 0;
+	return ct_nesting() == 0;
 }
 
 #define DEFAULT_RCU_BLIMIT (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ? 1000 : 10)
@@ -596,7 +596,7 @@ void rcu_irq_exit_check_preempt(void)
 {
 	lockdep_assert_irqs_disabled();
 
-	RCU_LOCKDEP_WARN(ct_dynticks_nesting() <= 0,
+	RCU_LOCKDEP_WARN(ct_nesting() <= 0,
 			 "RCU nesting counter underflow/zero!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() !=
 			 DYNTICK_IRQ_NONIDLE,
-- 
2.40.1

