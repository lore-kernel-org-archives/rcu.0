Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002415FA68
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832350; cv=none; b=OfA5iQKiTEqy2qndIuY9gixxnxv16tuTW9bHOffA/aX8SrBhDOJ12ahppNpOD/3s3riVFBnzTV4ZrrOaY4WvySGmxJLFWXZNLL6T9BCgsBvIozhnoTicqTlPL4wtycQHejk5SSlrLljHjgcUCRLBLkzIJ3GUEXNNlMYweWSPNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832350; c=relaxed/simple;
	bh=olWPzerWwKrdE3sCcPKSSSVM9ng+vq+lgW9yfTiKwMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDRqb7qdVz/yJSffHf3ARHVTDLpTvlNQ+hzuVAJXXHhsG49ROflMt9D+ewfD9WgcWTAxp3K4y23gjiso/fNegOLK0IET4CINbZMKndFEJxl5xskSg9Yhoe+RFpFdny1fXXj7iANxTwJ1e7L2EV1e/Lb2Ed09HajnC1z3qGDpBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxKzzodN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxKzzodN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7iE1VtD/3WpqZRSsoHZijVHICWUpo4Ce064sMYIewE=;
	b=FxKzzodNe406EyyGRtNgT2djw3cp+SuC6FvnIDglYpsB/SJQHR+bP3tUy3MMK02u/SWKzn
	Ag39cdifaQELflFvdldLjZ7ccYUjX8BWkGT23XekNOs6yioH6Z5ZoDO0yVGIn9Gn7I/Fub
	EHDJwnIAtlwHz6Dq6bPugecKEVAHdLs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-uzgkJ04LN7uMJfnaQlCY9Q-1; Wed,
 24 Jul 2024 10:45:41 -0400
X-MC-Unique: uzgkJ04LN7uMJfnaQlCY9Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 786501955D59;
	Wed, 24 Jul 2024 14:45:39 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A1801955F3B;
	Wed, 24 Jul 2024 14:45:35 +0000 (UTC)
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
Subject: [PATCH v3 14/25] context_tracking, rcu: Rename rcu_dynticks_curr_cpu_in_eqs() into rcu_watching_curr_cpu()
Date: Wed, 24 Jul 2024 16:43:14 +0200
Message-ID: <20240724144325.3307148-15-vschneid@redhat.com>
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

Note that "watching" is the opposite of "in EQS", so the negation is lifted
out of the helper and into the callsites.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/context_tracking.h | 12 ++++++++----
 kernel/context_tracking.c        |  6 +++---
 kernel/rcu/tree.c                |  6 +++---
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index a6c36780cc3bd..d53092ffa9dba 100644
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
index 1c16a7336360f..e64bb746cd9b3 100644
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
index 8a88d278e198e..90a0c14f80542 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -593,7 +593,7 @@ void rcu_irq_exit_check_preempt(void)
 	RCU_LOCKDEP_WARN(ct_nmi_nesting() !=
 			 CT_NESTING_IRQ_NONIDLE,
 			 "Bad RCU  nmi_nesting counter\n");
-	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
+	RCU_LOCKDEP_WARN(!rcu_is_watching_curr_cpu(),
 			 "RCU in extended quiescent state!");
 }
 #endif /* #ifdef CONFIG_PROVE_RCU */
@@ -633,7 +633,7 @@ void __rcu_irq_enter_check_tick(void)
 	if (in_nmi())
 		return;
 
-	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
+	RCU_LOCKDEP_WARN(!rcu_is_watching_curr_cpu(),
 			 "Illegal rcu_irq_enter_check_tick() from extended quiescent state");
 
 	if (!tick_nohz_full_cpu(rdp->cpu) ||
@@ -715,7 +715,7 @@ notrace bool rcu_is_watching(void)
 	bool ret;
 
 	preempt_disable_notrace();
-	ret = !rcu_dynticks_curr_cpu_in_eqs();
+	ret = rcu_is_watching_curr_cpu();
 	preempt_enable_notrace();
 	return ret;
 }
-- 
2.43.0

