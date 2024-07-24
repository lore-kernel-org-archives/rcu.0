Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C92D15B0FA
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832330; cv=none; b=bDLPXzhbnIrN7e4WI3uHe4TEhclrB4TBO01l9yaqnA6F0Tld/aMucHBGkpXmcvZNJ08l7gqMaiUtaRYFjDBtkzuZGY8NSwkVNvyt1CiBjLSe4Mau3X193vCBLVtQ3ah5rKs77ldI0PVVUlmnqt14nmq/9NZSvs2MO8NIoZ1DP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832330; c=relaxed/simple;
	bh=zUwnYXLcMg+gyPVninfoorMVlBke0dzUVyd+txzvS2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/ix8IMwfBCoQNT/AMi2Tzcm3z6H9Bf1eOhVoxBURWrlcg2DgR9jzaRLPZnpPJzWZ5UqfQ4ujQcGifaInSvkSekAHFQS5qGbFs05sQnh2S3vwad6Hbw5E/uyNV1HAp2sYsP7FfH6wAqrRA5xNoZwtEYvAnvtoRZLMM7BsxuNW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMSkCANx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMSkCANx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8M2kgxPWrm0Lra4FmTG8LNL53kGYyIVLKAyWJCVKxWU=;
	b=FMSkCANxAuwOptpcWXlPdn3bLGKPDQmC4rDpr9LwYo06MdI5yCNaSaH5FUqJS3lSrWsj/y
	4s5lm3KoxEv6ZRyKAULrIFxAnRAQlofm50+rZ3hbjETVJ18JjWZT1WwxHiJ7exn3fgerVS
	EULgKtIGlVtUeJJ352CkIPM6AVJWYN4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-TsgfaI4MOF-HvhVorInazA-1; Wed,
 24 Jul 2024 10:45:23 -0400
X-MC-Unique: TsgfaI4MOF-HvhVorInazA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44F5F1955D4A;
	Wed, 24 Jul 2024 14:45:21 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA0E51955E80;
	Wed, 24 Jul 2024 14:45:16 +0000 (UTC)
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
Subject: [PATCH v3 10/25] context_tracking, rcu: Rename ct_dynticks_nmi_nesting() into ct_nmi_nesting()
Date: Wed, 24 Jul 2024 16:43:10 +0200
Message-ID: <20240724144325.3307148-11-vschneid@redhat.com>
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

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/context_tracking_state.h |  2 +-
 kernel/context_tracking.c              | 24 ++++++++++++------------
 kernel/rcu/tree.c                      |  6 +++---
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 12d00adf29e1e..8f32fe599c5c0 100644
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
index ae94215aa132a..115843eeb0309 100644
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
index 4ccb4bb8df1d3..22322387cefb7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -382,11 +382,11 @@ static int rcu_is_cpu_rrupt_from_idle(void)
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
 
@@ -590,7 +590,7 @@ void rcu_irq_exit_check_preempt(void)
 
 	RCU_LOCKDEP_WARN(ct_nesting() <= 0,
 			 "RCU nesting counter underflow/zero!");
-	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() !=
+	RCU_LOCKDEP_WARN(ct_nmi_nesting() !=
 			 DYNTICK_IRQ_NONIDLE,
 			 "Bad RCU  nmi_nesting counter\n");
 	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
-- 
2.43.0

