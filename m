Return-Path: <SRS0=Mmc0=5N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A45C2D0EE
	for <rcu@archiver.kernel.org>; Sat, 28 Mar 2020 22:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610EC20714
	for <rcu@archiver.kernel.org>; Sat, 28 Mar 2020 22:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="f9CeW+bJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgC1WRO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 28 Mar 2020 18:17:14 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34028 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgC1WRN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 28 Mar 2020 18:17:13 -0400
Received: by mail-qv1-f68.google.com with SMTP id s18so2501776qvn.1
        for <rcu@vger.kernel.org>; Sat, 28 Mar 2020 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cAyFIM0mnBQtBZ564kWpq6/xxWyZPQeG1vrzaz7IV9U=;
        b=f9CeW+bJZcqsXN53P4RVlzvsmYds41O3hWKn9vvcfcss0k6kthnHiCvR5cFE0s4X8a
         2fc7wlu/7Pf16xcG1R+NkIDjmBHwrVJTqP262Hpdw9mnBeCU1KEg2ReyvJSzvFinAl+k
         PTw9/wHcrS330iM7i20mvhhmmvZGwJdHKYCrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cAyFIM0mnBQtBZ564kWpq6/xxWyZPQeG1vrzaz7IV9U=;
        b=rFQBlcduWdQdkhlqcQqtTUZsy2B2JZ9Tsdms5FF4mHwRf8SvLuGUEmrc+BU+WWUOWk
         dWxOFmcWmlN+LsNyeJnEoV0awObFgBlaD7BHDW3LkrCWIYryJ5xaftdhNLqfEMIfYRxs
         7zHreOLdV5Pyvd7hllAODg3cngtqTVTGhKemU11PXpPZZo/rxTSUDLntWM3LY6HQEONM
         gr5P97DKuawq6CfEKqc1WZG2HZxUvRtOUu3StQS5UiqYkywCR03avl4eTLktZ1mncfLK
         abelizVkU9T0ebAkf5N2EivAIgzjttMY0AZK3XSQvJ1cvbj2DHbWux0PfT2ubz3dn+B1
         6bow==
X-Gm-Message-State: ANhLgQ2LebT7goPtP2C79GCD+at1EYqF8ptTqgLfhc3Kowyjq3AExrZj
        /Ai9n9PoU+8fZSfp5Z94vv8Qxg==
X-Google-Smtp-Source: ADFU+vuPD672hJHWBg475PbbpNrJWI7ZhbWFmijAbj5yrUICF5sGV5n17kAgPjFNOvVcbhW8pYXX0g==
X-Received: by 2002:ad4:496b:: with SMTP id p11mr5540437qvy.202.1585433832601;
        Sat, 28 Mar 2020 15:17:12 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k66sm6742950qke.10.2020.03.28.15.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 15:17:12 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
        Petr Mladek <pmladek@suse.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, tglx@linutronix.de, vpillai@digitalocean.com
Subject: [PATCH v2 2/4] rcu/tree: Add better tracing for dyntick-idle
Date:   Sat, 28 Mar 2020 18:17:01 -0400
Message-Id: <20200328221703.48171-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200328221703.48171-1-joel@joelfernandes.org>
References: <20200328221703.48171-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The dyntick-idle traces are a bit confusing. This patch makes it simpler
and adds some missing cases such as EQS-enter due to user vs idle mode.

Following are the changes:
(1) Add a new context field to trace_rcu_dyntick tracepoint. This
    context field can be "USER", "IDLE" or "IRQ".

(2) Remove the "++=" and "--=" strings and replace them with
   "StillNonIdle". This is much easier on the eyes, and the -- and ++
   are easily apparent in the dynticks_nesting counters we are printing
   anyway.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 29 ++++++++++++++++-------------
 kernel/rcu/tree.c          | 20 +++++++++++++-------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 5e49b06e81044..c9ac71e2afd46 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -435,26 +435,28 @@ TRACE_EVENT_RCU(rcu_fqs,
 #endif /* #if defined(CONFIG_TREE_RCU) */
 
 /*
- * Tracepoint for dyntick-idle entry/exit events.  These take a string
- * as argument: "Start" for entering dyntick-idle mode, "Startirq" for
- * entering it from irq/NMI, "End" for leaving it, "Endirq" for leaving it
- * to irq/NMI, "--=" for events moving towards idle, and "++=" for events
- * moving away from idle.
+ * Tracepoint for dyntick-idle entry/exit events.  These take 2 strings
+ * as argument:
+ * polarilty: "Start", "End", "StillIdle" for entering, exiting or still being
+ * in dyntick-idle mode.
+ * context: "USER" or "KERNEL" or "IRQ".
+ * NMIs nested in IRQs are inferred with dynticks_nesting > 1 in IRQ context.
  *
  * These events also take a pair of numbers, which indicate the nesting
  * depth before and after the event of interest, and a third number that is
- * the ->dynticks counter.  Note that task-related and interrupt-related
- * events use two separate counters, and that the "++=" and "--=" events
- * for irq/NMI will change the counter by two, otherwise by one.
+ * the ->dynticks counter. During NMI nesting within IRQs, the dynticks_nesting
+ * counter changes by two, otherwise one.
  */
 TRACE_EVENT_RCU(rcu_dyntick,
 
-	TP_PROTO(const char *polarity, long oldnesting, long newnesting, int dynticks),
+	TP_PROTO(const char *polarity, const char *context, long oldnesting,
+		 long newnesting, int dynticks),
 
-	TP_ARGS(polarity, oldnesting, newnesting, dynticks),
+	TP_ARGS(polarity, context, oldnesting, newnesting, dynticks),
 
 	TP_STRUCT__entry(
 		__field(const char *, polarity)
+		__field(const char *, context)
 		__field(long, oldnesting)
 		__field(long, newnesting)
 		__field(int, dynticks)
@@ -462,14 +464,15 @@ TRACE_EVENT_RCU(rcu_dyntick,
 
 	TP_fast_assign(
 		__entry->polarity = polarity;
+		__entry->context = context;
 		__entry->oldnesting = oldnesting;
 		__entry->newnesting = newnesting;
 		__entry->dynticks = dynticks;
 	),
 
-	TP_printk("%s %lx %lx %#3x", __entry->polarity,
-		  __entry->oldnesting, __entry->newnesting,
-		  __entry->dynticks & 0xfff)
+	TP_printk("%s %s %lx %lx %#3x", __entry->polarity,
+		__entry->context, __entry->oldnesting, __entry->newnesting,
+		__entry->dynticks & 0xfff)
 );
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a011bebe7d0e0..0e5304bad705a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -523,7 +523,8 @@ static void rcu_eqs_enter(bool user)
 	}
 
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("Start"), (user ? TPS("USER") : TPS("IDLE")),
+			  rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rdp = this_cpu_ptr(&rcu_data);
 	do_nocb_deferred_wakeup(rdp);
@@ -596,15 +597,17 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	 * leave it in non-RCU-idle state.
 	 */
 	if (rdp->dynticks_nmi_nesting != 1) {
-		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
-				  atomic_read(&rdp->dynticks));
+		trace_rcu_dyntick(TPS("StillNonIdle"), TPS("IRQ"),
+				  rdp->dynticks_nmi_nesting,
+				  rdp->dynticks_nmi_nesting - 2, atomic_read(&rdp->dynticks));
 		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
 			   rdp->dynticks_nmi_nesting - 2);
 		return;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("Start"), TPS("IRQ"), rdp->dynticks_nmi_nesting,
+			  0, atomic_read(&rdp->dynticks));
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
 	if (irq)
@@ -691,7 +694,8 @@ static void rcu_eqs_exit(bool user)
 	rcu_dynticks_task_exit();
 	rcu_dynticks_eqs_exit();
 	rcu_cleanup_after_idle();
-	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("End"), (user ? TPS("USER") : TPS("IDLE")),
+			  rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
@@ -783,9 +787,11 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		}
 		raw_spin_unlock_rcu_node(rdp->mynode);
 	}
-	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
-			  rdp->dynticks_nmi_nesting,
+
+	trace_rcu_dyntick(incby == 1 ? TPS("End") : TPS("StillNonIdle"),
+			  TPS("IRQ"), rdp->dynticks_nmi_nesting,
 			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
+
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
 		   rdp->dynticks_nmi_nesting + incby);
 	barrier();
-- 
2.26.0.rc2.310.g2932bb562d-goog

