Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657787DA8B;
	Fri, 16 Aug 2024 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781018; cv=none; b=FJ9h7aZYH1JHKpsAGz/GIGcdCLIMk7d5qNPTIYo6Xj/D7IvX45+Lo9+Zei6iHbEhlq+B1ESdLdcWGr7oXavfmXHCtDDFDnjaoIq4NJrnSmsn4Fej+xdkjqhO5KdoXdF7Lav2jGn4gS7JzPxKQSA9CU1WDUH6YiHPEIBt1EOQmWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781018; c=relaxed/simple;
	bh=++0c0XEDnidLQRlUlDS91vCsbWjdldBAxPFLpDWGdwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4kybxCa1TnLsgU1VOf6i8mmIC0IAGRH97T/0xzOWnCNGDPFji4NlOKvY7D15MeCdCywF3Ne06yWd+JrCe1W3j8s1Pvce50MPUUjXX2enSAnzMt8Y1JkLYAGlekDNWEsUcvyj9K5w8RbGdoxxGhIZUA0QfovagUld64pHmmvtGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0VwhuE1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0VwhuE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC3AC4AF09;
	Fri, 16 Aug 2024 04:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781016;
	bh=++0c0XEDnidLQRlUlDS91vCsbWjdldBAxPFLpDWGdwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0VwhuE1rAYTlNgAUWRuEvXob87Z4G8L/RV5WidbMSjHaJqA2ANNkrHAM5BExf7ZF
	 qldMWX/dwTqX2VcDlOwZoRlEMCrUzoOYrw518F+tDonm5kzehRyM1rv4BB6kl5AnMP
	 QgvZdegFbDQiyofVjxDOPTA6QmUkoH4MiCo3PSucZgwmqDwRXImpwlKVrXnZPbAHmb
	 jP9oNlzJA/MRE01kAk1KRWO5nQ64k7LNhtj0onjNV9hGdA7ViKDcs6Y0aIA7M0Y2xK
	 yuSwA6OgG0+hnsS2tbz1LMPqLz1E7IDeMrXPx/ACg3VvO4bi+EBARQKN8IxqKv2qKT
	 qMo7ShM4aJxpw==
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
Subject: [PATCH rcu 03/26] context_tracking, rcu: Rename ct_dynticks() into ct_rcu_watching()
Date: Fri, 16 Aug 2024 09:32:18 +0530
Message-Id: <20240816040241.17776-3-neeraj.upadhyay@kernel.org>
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
 include/linux/context_tracking_state.h |  2 +-
 kernel/context_tracking.c              | 10 +++++-----
 kernel/rcu/tree.c                      |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 94d6a935af3b..cb90d8c17810 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -56,7 +56,7 @@ static __always_inline int __ct_state(void)
 #endif
 
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
-static __always_inline int ct_dynticks(void)
+static __always_inline int ct_rcu_watching(void)
 {
 	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_RCU_WATCHING_MASK;
 }
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index b2589bc59e18..868ae0bcd4be 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -137,7 +137,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 
 	instrumentation_begin();
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), ct_dynticks_nesting(), 0, ct_dynticks());
+	trace_rcu_dyntick(TPS("Start"), ct_dynticks_nesting(), 0, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rcu_preempt_deferred_qs(current);
 
@@ -182,7 +182,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	// instrumentation for the noinstr ct_kernel_enter_state()
 	instrument_atomic_write(&ct->state, sizeof(ct->state));
 
-	trace_rcu_dyntick(TPS("End"), ct_dynticks_nesting(), 1, ct_dynticks());
+	trace_rcu_dyntick(TPS("End"), ct_dynticks_nesting(), 1, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(ct->dynticks_nesting, 1);
 	WARN_ON_ONCE(ct_dynticks_nmi_nesting());
@@ -220,7 +220,7 @@ void noinstr ct_nmi_exit(void)
 	 */
 	if (ct_dynticks_nmi_nesting() != 1) {
 		trace_rcu_dyntick(TPS("--="), ct_dynticks_nmi_nesting(), ct_dynticks_nmi_nesting() - 2,
-				  ct_dynticks());
+				  ct_rcu_watching());
 		WRITE_ONCE(ct->dynticks_nmi_nesting, /* No store tearing. */
 			   ct_dynticks_nmi_nesting() - 2);
 		instrumentation_end();
@@ -228,7 +228,7 @@ void noinstr ct_nmi_exit(void)
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), ct_dynticks_nmi_nesting(), 0, ct_dynticks());
+	trace_rcu_dyntick(TPS("Startirq"), ct_dynticks_nmi_nesting(), 0, ct_rcu_watching());
 	WRITE_ONCE(ct->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
 	// instrumentation for the noinstr ct_kernel_exit_state()
@@ -296,7 +296,7 @@ void noinstr ct_nmi_enter(void)
 
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  ct_dynticks_nmi_nesting(),
-			  ct_dynticks_nmi_nesting() + incby, ct_dynticks());
+			  ct_dynticks_nmi_nesting() + incby, ct_rcu_watching());
 	instrumentation_end();
 	WRITE_ONCE(ct->dynticks_nmi_nesting, /* Prevent store tearing. */
 		   ct_dynticks_nmi_nesting() + incby);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 04f87c44385c..3a2f0325aa43 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -294,7 +294,7 @@ void rcu_softirq_qs(void)
  */
 static void rcu_dynticks_eqs_online(void)
 {
-	if (ct_dynticks() & CT_RCU_WATCHING)
+	if (ct_rcu_watching() & CT_RCU_WATCHING)
 		return;
 	ct_state_inc(CT_RCU_WATCHING);
 }
-- 
2.40.1

