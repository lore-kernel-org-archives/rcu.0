Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93F115ECD6
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832319; cv=none; b=sbKdyS7hnqUYDXvegEbpLh8CpIKmaHEW9lJ0llKK3I/yoTresHT9dTJRxxc5j2e8wwOXJidauRygaGbCS6Rn9c3k/UUla8EbAkVVTF3WXybDTgl3GlCfcY5PkUPUY3lPQAjI87U9R80cQgcZDW/R5+mC9oqw7n+FB7E0eoCqAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832319; c=relaxed/simple;
	bh=g3WK4DConEMyet2xZeml9Urd+boAFTsV3ktKpxSadM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqW0s85bzNEF++LH3VTlt6l1lGUNvvHIpZDDwd4IoxzG7RHrvGRFOYL0suK5yHoTaFEHG98KruDakF4TdHGXsJgivgkvT9Gz4WIKjKJv1KniV4jwqCYAxV00VNX6V1L1uMptoSaHT9IE7oLbVRwzr4grcQJhS5BPIo2mIaWlHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5VcwhLR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5VcwhLR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJTDpCL9+KP+sqgSMdKdXoT35zq+lG3Rh9cP8UDNeVA=;
	b=a5VcwhLRFiCglcHcgzB/crotbJba0edK2wgPzj0Wp/jxx44lr5MInJkjlwIL1UO+FLGeJB
	9XxeKsHSN0QCGXomlbjquSu8ENPLJ3eYqHyrP8m+KaMpxZUcFPLH0rN3IF2vHy0rusjcWz
	lWIfBwqavNWr63xrIkx7vbtGujZl75w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-Ez9wz_LeP1aINYxFwbczxA-1; Wed,
 24 Jul 2024 10:45:09 -0400
X-MC-Unique: Ez9wz_LeP1aINYxFwbczxA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69BC21955F0B;
	Wed, 24 Jul 2024 14:45:07 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39E381955F3B;
	Wed, 24 Jul 2024 14:45:02 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v3 07/25] context_tracking, rcu: Rename ct_dynticks_nesting() into ct_nesting()
Date: Wed, 24 Jul 2024 16:43:07 +0200
Message-ID: <20240724144325.3307148-8-vschneid@redhat.com>
In-Reply-To: <20240724144325.3307148-1-vschneid@redhat.com>
References: <20240724144325.3307148-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, reflect that change in the related helpers.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/context_tracking_state.h |  2 +-
 kernel/context_tracking.c              | 10 +++++-----
 kernel/rcu/tree.c                      |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 65290e7677e6c..586c1ff22c2e9 100644
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
index 5cfdfc03b4018..a951bde0bbcbb 100644
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
index 16007911c7890..35042ffeca73b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -380,7 +380,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	lockdep_assert_irqs_disabled();
 
 	/* Check for counter underflows */
-	RCU_LOCKDEP_WARN(ct_dynticks_nesting() < 0,
+	RCU_LOCKDEP_WARN(ct_nesting() < 0,
 			 "RCU nesting counter underflow!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() <= 0,
 			 "RCU dynticks_nmi_nesting counter underflow/zero!");
@@ -396,7 +396,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	WARN_ON_ONCE(!nesting && !is_idle_task(current));
 
 	/* Does CPU appear to be idle from an RCU standpoint? */
-	return ct_dynticks_nesting() == 0;
+	return ct_nesting() == 0;
 }
 
 #define DEFAULT_RCU_BLIMIT (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ? 1000 : 10)
@@ -588,7 +588,7 @@ void rcu_irq_exit_check_preempt(void)
 {
 	lockdep_assert_irqs_disabled();
 
-	RCU_LOCKDEP_WARN(ct_dynticks_nesting() <= 0,
+	RCU_LOCKDEP_WARN(ct_nesting() <= 0,
 			 "RCU nesting counter underflow/zero!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() !=
 			 DYNTICK_IRQ_NONIDLE,
-- 
2.43.0

