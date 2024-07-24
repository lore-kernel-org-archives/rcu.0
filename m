Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19415AD9B
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832425; cv=none; b=PqvqkBDPpD1bU97b3ks9sola3xtyvnOpkYfWSrXlZ6d+Hsecnd/Ed5F0q/IeROrya31r4gzVcHxkTC+Bj0zTXux7ucEz7C/rLtZ71PFW4kLhVNEAby6NPEr3KGOnI4D9PlNTQPH+ekD5elz62kMCXvrjnourbwhpUlOjso7WlZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832425; c=relaxed/simple;
	bh=JslPgZexQJ8YxsjbHAMa/2MLxig4vL9j/3RhuQHxY/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Po3iRY7OI0ln5sZn/yHBbPxXBUd8tGDqOU47X8/AV276OA2dz+yP3ZQVOy1wye6Puy4R1+w7DJgK4CPsCewOx8ZIpSUl8SG3lKuxXQeITCzglMjN6/xJvZMaz6KS+g9w7GnZvzl3kwfZLgCifLSmjSoubbGeX5gf5U+WGWUlDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LK/qMwWc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LK/qMwWc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljhAb/voCwvDC1m5R2Wlfs86SFuWCKibv1oDMW9motQ=;
	b=LK/qMwWcm/bpJ8Vhlomp004daix5r4zAVqJwJrS/khs2DPgHXUAmk9jz6ARLqQEPh9KyAs
	uscYdgmNATn0ifvcVRlnnvIqULg2nTsxG3509yU1K04FlgW5ZRNhs03LSEwdcLjhW3iJrh
	95+BZbttj4ya/B8miIlLSxCotBfuboo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-EcVDsL-nPXKlESUogZGwvg-1; Wed,
 24 Jul 2024 10:46:57 -0400
X-MC-Unique: EcVDsL-nPXKlESUogZGwvg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE1A01955D47;
	Wed, 24 Jul 2024 14:46:54 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71E5A1955F40;
	Wed, 24 Jul 2024 14:46:50 +0000 (UTC)
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
Subject: [PATCH v3 25/25] context_tracking, rcu: Rename rcu_dyntick trace event into rcu_watching
Date: Wed, 24 Jul 2024 16:43:25 +0200
Message-ID: <20240724144325.3307148-26-vschneid@redhat.com>
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

The "rcu_dyntick" naming convention has been turned into "rcu_watching" for
all helpers now, align the trace event to that.

To add to the confusion, the strings passed to the trace event are now
reversed: when RCU "starts" the dyntick / EQS state, it "stops" watching.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/trace/events/rcu.h | 16 ++++++++--------
 kernel/context_tracking.c  | 10 +++++-----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 4066b6d51e46a..e51ef658437f0 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -466,40 +466,40 @@ TRACE_EVENT(rcu_stall_warning,
 /*
  * Tracepoint for dyntick-idle entry/exit events.  These take 2 strings
  * as argument:
- * polarity: "Start", "End", "StillNonIdle" for entering, exiting or still not
+ * polarity: "Start", "End", "StillWatching" for entering, exiting or still not
  *            being in dyntick-idle mode.
  * context: "USER" or "IDLE" or "IRQ".
  * NMIs nested in IRQs are inferred with nesting > 1 in IRQ context.
  *
  * These events also take a pair of numbers, which indicate the nesting
  * depth before and after the event of interest, and a third number that is
- * the ->dynticks counter.  Note that task-related and interrupt-related
+ * the RCU_WATCHING counter.  Note that task-related and interrupt-related
  * events use two separate counters, and that the "++=" and "--=" events
  * for irq/NMI will change the counter by two, otherwise by one.
  */
-TRACE_EVENT_RCU(rcu_dyntick,
+TRACE_EVENT_RCU(rcu_watching,
 
-	TP_PROTO(const char *polarity, long oldnesting, long newnesting, int dynticks),
+	TP_PROTO(const char *polarity, long oldnesting, long newnesting, int counter),
 
-	TP_ARGS(polarity, oldnesting, newnesting, dynticks),
+	TP_ARGS(polarity, oldnesting, newnesting, counter),
 
 	TP_STRUCT__entry(
 		__field(const char *, polarity)
 		__field(long, oldnesting)
 		__field(long, newnesting)
-		__field(int, dynticks)
+		__field(int, counter)
 	),
 
 	TP_fast_assign(
 		__entry->polarity = polarity;
 		__entry->oldnesting = oldnesting;
 		__entry->newnesting = newnesting;
-		__entry->dynticks = dynticks;
+		__entry->counter = counter;
 	),
 
 	TP_printk("%s %lx %lx %#3x", __entry->polarity,
 		  __entry->oldnesting, __entry->newnesting,
-		  __entry->dynticks & 0xfff)
+		  __entry->counter & 0xfff)
 );
 
 /*
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index e64bb746cd9b3..152b485a62db5 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -137,7 +137,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 
 	instrumentation_begin();
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), ct_nesting(), 0, ct_rcu_watching());
+	trace_rcu_watching(TPS("End"), ct_nesting(), 0, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rcu_preempt_deferred_qs(current);
 
@@ -182,7 +182,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	// instrumentation for the noinstr ct_kernel_enter_state()
 	instrument_atomic_write(&ct->state, sizeof(ct->state));
 
-	trace_rcu_dyntick(TPS("End"), ct_nesting(), 1, ct_rcu_watching());
+	trace_rcu_watching(TPS("Start"), ct_nesting(), 1, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(ct->nesting, 1);
 	WARN_ON_ONCE(ct_nmi_nesting());
@@ -219,7 +219,7 @@ void noinstr ct_nmi_exit(void)
 	 * leave it in non-RCU-idle state.
 	 */
 	if (ct_nmi_nesting() != 1) {
-		trace_rcu_dyntick(TPS("--="), ct_nmi_nesting(), ct_nmi_nesting() - 2,
+		trace_rcu_watching(TPS("--="), ct_nmi_nesting(), ct_nmi_nesting() - 2,
 				  ct_rcu_watching());
 		WRITE_ONCE(ct->nmi_nesting, /* No store tearing. */
 			   ct_nmi_nesting() - 2);
@@ -228,7 +228,7 @@ void noinstr ct_nmi_exit(void)
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), ct_nmi_nesting(), 0, ct_rcu_watching());
+	trace_rcu_watching(TPS("Endirq"), ct_nmi_nesting(), 0, ct_rcu_watching());
 	WRITE_ONCE(ct->nmi_nesting, 0); /* Avoid store tearing. */
 
 	// instrumentation for the noinstr ct_kernel_exit_state()
@@ -294,7 +294,7 @@ void noinstr ct_nmi_enter(void)
 		instrumentation_begin();
 	}
 
-	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
+	trace_rcu_watching(incby == 1 ? TPS("Startirq") : TPS("++="),
 			  ct_nmi_nesting(),
 			  ct_nmi_nesting() + incby, ct_rcu_watching());
 	instrumentation_end();
-- 
2.43.0

