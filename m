Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E910615B10B
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832346; cv=none; b=DppFxm7BCYRQAYAD7xioOnnFwkbgm+8Gtgq/V8D3OSrDiSYViXJoREMxlftn7uDHTf4ztbstBjKM1tvQHYA2jHTDL3XAU3GDefDwOMUxR+uKKRAB61RcJ38gAOxk7YHHS6swxpCc8ZqVIOdHBsBpCcvq9zlJw9M8AOgHUtEevuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832346; c=relaxed/simple;
	bh=z+HDZNdOj4TLu+lbDfy1wPQANwm7WA3A7ThWMzo5V2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R91AuOV279XnV9K68a8BHDLbtp1VPlgxPFp9tCTIpJJhhw+q/GTY7Z4y6F3yjIVXzCqgVPc5hkJ8tfjxs9JDSMwh+rMgCXSug2k4re1rfZ9sSQrkm+UGwpgNp4rb72FKj87QeZJE2OIYShakUHXMt3MdiNcNyIEe597JtJVrztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WfYWZBW/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfYWZBW/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/7dBCcVRIOQUjtqmWXJpSdk1RmONTJ69MQr24Tk2YQ=;
	b=WfYWZBW/t7ozuoWaxZZ8hEEWeE+ODOkodWb9tPpbEk2Rwtfc8zDYr/eRn2mOyHSRC1TU1y
	7P+cjBNkVAC18vOt2dppavoF53aKn2NK/Fam9p3vhS6q+TYbpigDMpP0oeTY7egeXk2OM3
	jmgZiHbYH4f648ZMzk3d9cG5BuLmG80=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-IHd_mDcSMqW-6njA7FKjjw-1; Wed,
 24 Jul 2024 10:45:38 -0400
X-MC-Unique: IHd_mDcSMqW-6njA7FKjjw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE98B1955BFA;
	Wed, 24 Jul 2024 14:45:34 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA6C21955F40;
	Wed, 24 Jul 2024 14:45:30 +0000 (UTC)
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
Subject: [PATCH v3 13/25] context_tracking, rcu: Rename rcu_dynticks_task*() into rcu_task*()
Date: Wed, 24 Jul 2024 16:43:13 +0200
Message-ID: <20240724144325.3307148-14-vschneid@redhat.com>
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
RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
meaning.

While at it, flip the suffixes of these helpers. We are not telling
that we are entering dynticks mode from an RCU-task perspective anymore; we
are telling that we are exiting RCU-tasks because we are in eqs mode.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/context_tracking.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 8262f57a43636..1c16a7336360f 100644
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
+static __always_inline void rcu_task_trace_exit(void)
 {
 #ifdef CONFIG_TASKS_TRACE_RCU
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
@@ -63,8 +63,8 @@ static __always_inline void rcu_dynticks_task_trace_enter(void)
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
-/* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
-static __always_inline void rcu_dynticks_task_trace_exit(void)
+/* Turn off heavyweight RCU tasks trace readers on kernel entry. */
+static __always_inline void rcu_task_trace_enter(void)
 {
 #ifdef CONFIG_TASKS_TRACE_RCU
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
@@ -87,7 +87,7 @@ static noinstr void ct_kernel_exit_state(int offset)
 	 * critical sections, and we also must force ordering with the
 	 * next idle sojourn.
 	 */
-	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
+	rcu_task_trace_exit();  // Before CT state update!
 	seq = ct_state_inc(offset);
 	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & CT_RCU_WATCHING));
@@ -109,7 +109,7 @@ static noinstr void ct_kernel_enter_state(int offset)
 	 */
 	seq = ct_state_inc(offset);
 	// RCU is now watching.  Better not be in an extended quiescent state!
-	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
+	rcu_task_trace_enter();  // After CT state update!
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
2.43.0

