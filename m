Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8915B55E
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832298; cv=none; b=ZIqYrbi4pkgl1dMg6baIrOk51hLsy4wS2QXFd5KsCjS+HwqY/smuJk29QEJpgAJ7nbceI5u5CL7a5CLTsHoB3YIGaZWDq9P+8T+/0OT3JvIc1VRDNDt/vP7PgtGGQ9YzLUCaKjIS+8L9IeSAI3Opa6dwYqUpKyAew3gZ70nEEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832298; c=relaxed/simple;
	bh=1XoCmDLPgJ7fMhEkFFvWDr4WwdTOd6MSAxqKnuyhZfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3bI5S7uyheb8iypoDTJBDJff4OamgpVe1FVAW0JET0zU3NfkXL5oDoNyGJMlrUzCSECN+kxJo2GEUQs3qJ39vJgqqPx81BmoBg4+9o1ejrangTvhXfQ4b1BN4WZbFx9qowvZcHg0QQfPWG5srFii4Y6DdtLeuGuda/bfHy8NQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4fHcZz5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4fHcZz5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmjeaW0wzezH39aGzViYM99zHu1ZJwZ5d7D+gL35wwM=;
	b=b4fHcZz5gFInUq6+Hri2f/oDtBgT3jixmMyOAhnrZp+xFBwmzb8wMgZ3sIiSWk5x5yI7y1
	dMHtPnuVBkufTrgdZMELUvHUD/ldq/CyZKqmkOTuBZ07sD2oUsQsbzVkZAieGTOGcNKitX
	bg2FinZ5hsTh1jscB1bXq6/AwhvDr3I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-5yQbhCYkNnqTj1U488mlWA-1; Wed,
 24 Jul 2024 10:44:51 -0400
X-MC-Unique: 5yQbhCYkNnqTj1U488mlWA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70F251955D50;
	Wed, 24 Jul 2024 14:44:49 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD67B1955F40;
	Wed, 24 Jul 2024 14:44:44 +0000 (UTC)
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
Subject: [PATCH v3 03/25] context_tracking, rcu: Rename ct_dynticks() into ct_rcu_watching()
Date: Wed, 24 Jul 2024 16:43:03 +0200
Message-ID: <20240724144325.3307148-4-vschneid@redhat.com>
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

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/context_tracking_state.h |  2 +-
 kernel/context_tracking.c              | 10 +++++-----
 kernel/rcu/tree.c                      |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 94d6a935af3be..cb90d8c178104 100644
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
index b2589bc59e186..868ae0bcd4bed 100644
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
index c0d7fbe8f6756..ae478e13fc837 100644
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
2.43.0

