Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6457DC47247
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DDA206A4
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RLh3ufIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgEDMFV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 08:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728610AbgEDMFU (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 08:05:20 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F57EC061A0E
        for <rcu@vger.kernel.org>; Mon,  4 May 2020 05:05:20 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b6so2715211qkh.11
        for <rcu@vger.kernel.org>; Mon, 04 May 2020 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VDKqK5vboDPN0MSXFBVx837WJ5aTs/ItYy0UQe5d/bA=;
        b=RLh3ufIYu+6pP0zyIJ/DVmenRYKyezNLIgKu+QFjzYmj1qNXlWtqOSq1NDXqWxc39d
         I0hL1CCE69n7rGmHq2J/OLnoI8FtSBNsUnL3X6tx3Ue9RLcQAOg+TZz4MYLKKsg5z53j
         acqkikq0cvAYrDhiDjcsyagbHsq52I6O6voaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VDKqK5vboDPN0MSXFBVx837WJ5aTs/ItYy0UQe5d/bA=;
        b=acA9vxzk+LFJC3oJQUx+KPI7dP8Bnu7Z/nDexX+KvklNAhGPlrsySEvCuRRkNgn0AC
         6sud490btsF33doOFNlGYMWpIC4psukfSHIkDZb+e0+rh4ak/ecFurqD6gKX2YaV+Vdy
         /UA03BNJ+xY4/hhCtIRdqwbCkJ4/hpUeaTWGGAo671xu+sP7NR5Si8m3p3L0TWZPUWpT
         PAooJJTqf3SZvCLoJBgT9TqzeUT8qtPeGFc7BWMnFN/dgRyNhgAErSIJ3pQ09WIA53CX
         yyz+uLjv4/qLCmUP63IJ2+aIWtg6qOMBGA3kak5sODHLNl9xWgdyl3MKNZETaBVKfyXB
         Zjrw==
X-Gm-Message-State: AGi0PuZpxRhQ2sEz3/1Hm5LZ8dEfeUoWvWOFykBlJyQJw49qeoOM6WGv
        R4PKfTkjYauwh9nguqQZhADV7Q==
X-Google-Smtp-Source: APiQypJmtYdA2jscBR+3U0tbmE/OVOy8UnvuKOA5X9n8+WSeEH5F+0mt00jXgfPewO/v0VnmsM9EDg==
X-Received: by 2002:a37:d247:: with SMTP id f68mr14708199qkj.362.1588593919651;
        Mon, 04 May 2020 05:05:19 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y50sm6194534qta.56.2020.05.04.05.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:05:19 -0700 (PDT)
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
Subject: [PATCH v3 3/5] rcu/tree: Clean up dynticks counter usage
Date:   Mon,  4 May 2020 08:05:03 -0400
Message-Id: <20200504120505.89351-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200504120505.89351-1-joel@joelfernandes.org>
References: <20200504120505.89351-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The dynticks counter are confusing due to crowbar writes of
DYNTICK_IRQ_NONIDLE whose purpose is to detect half-interrupts (i.e. we
see rcu_irq_enter() but not rcu_irq_exit() due to a usermode upcall) and
if so then do a reset of the dyntick_nmi_nesting counters. This patch
tries to get rid of DYNTICK_IRQ_NONIDLE while still keeping the code
working, fully functional, and less confusing. The confusion recently
has even led to patches forgetting that DYNTICK_IRQ_NONIDLE was written
to which wasted lots of time.

The patch has the following changes:

(1) Use dynticks_nesting instead of dynticks_nmi_nesting for determining
outer most "EQS exit". This is needed to detect in
rcu_nmi_enter_common() if we have already EQS-exited, such as because of
a syscall. Currently we rely on a forced write of DYNTICK_IRQ_NONIDLE
from rcu_eqs_exit() for this purpose. This is one purpose of the
DYNTICK_IRQ_NONIDLE write (other than detecting half-interrupts).
However, we do not need to do that. dyntick_nesting already tells us that
we have EQS-exited so just use that thus removing the dependence of
dynticks_nmi_nesting for this purpose.

(2) Keep dynticks_nmi_nesting around because:

  (a) rcu_is_cpu_rrupt_from_idle() needs to be able to detect first
      interrupt nesting level.

  (b) We need to detect half-interrupts till we are sure they're not an
      issue. However, change the comparison to DYNTICK_IRQ_NONIDLE with 0.

(3) Since we got rid of DYNTICK_IRQ_NONIDLE, we also do cheaper
comparisons with zero instead for the code that keeps the tick on in
rcu_nmi_enter_common().

In the next patch, both of the concerns of (2) will be addressed and
then we can get rid of dynticks_nmi_nesting, however one step at a time.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu.h  |  4 ----
 kernel/rcu/tree.c | 58 +++++++++++++++++++++++++++--------------------
 2 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index cf66a3ccd7573..b9f64abc48b85 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -12,10 +12,6 @@
 
 #include <trace/events/rcu.h>
 
-/* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
-#define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
-
-
 /*
  * Grace-period counter management.
  */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index eb7a4d90b3b91..d6df8abdcc21f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -84,7 +84,6 @@
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nesting = 1,
-	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 	.dynticks = ATOMIC_INIT(1),
 };
 static struct rcu_state rcu_state = {
@@ -553,17 +552,19 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 /*
  * Enter an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
- *
- * We crowbar the ->dynticks_nmi_nesting field to zero to allow for
- * the possibility of usermode upcalls having messed up our count
- * of interrupt nesting level during the prior busy period.
  */
 static void rcu_eqs_enter(bool user)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
+	/*
+	 * Entering usermode/idle from interrupt is not handled. These would
+	 * mean usermode upcalls or idle exit happened from interrupts. Remove
+	 * the warning by 2020.
+	 */
+	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
+		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
+
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     rdp->dynticks_nesting == 0);
 	if (rdp->dynticks_nesting != 1) {
@@ -641,26 +642,29 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	 * (We are exiting an NMI handler, so RCU better be paying attention
 	 * to us!)
 	 */
+	WARN_ON_ONCE(rdp->dynticks_nesting <= 0);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting <= 0);
 	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
 
+	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
+		   rdp->dynticks_nmi_nesting - 1);
 	/*
 	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
 	 * leave it in non-RCU-idle state.
 	 */
-	if (rdp->dynticks_nmi_nesting != 1) {
+	if (rdp->dynticks_nesting != 1) {
 		trace_rcu_dyntick(TPS("StillNonIdle"), TPS("IRQ"),
-				  rdp->dynticks_nmi_nesting,
-				  rdp->dynticks_nmi_nesting - 2, atomic_read(&rdp->dynticks));
-		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
-			   rdp->dynticks_nmi_nesting - 2);
+				  rdp->dynticks_nesting,
+				  rdp->dynticks_nesting - 2, atomic_read(&rdp->dynticks));
+		WRITE_ONCE(rdp->dynticks_nesting, /* No store tearing. */
+			   rdp->dynticks_nesting - 2);
 		return;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Start"), TPS("IRQ"), rdp->dynticks_nmi_nesting,
+	trace_rcu_dyntick(TPS("Start"), TPS("IRQ"), rdp->dynticks_nesting,
 			  0, atomic_read(&rdp->dynticks));
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
+	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid store tearing. */
 
 	if (irq)
 		rcu_prepare_for_idle();
@@ -727,10 +731,6 @@ void rcu_irq_exit_irqson(void)
 /*
  * Exit an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
- *
- * We crowbar the ->dynticks_nmi_nesting field to DYNTICK_IRQ_NONIDLE to
- * allow for the possibility of usermode upcalls messing up our count of
- * interrupt nesting level during the busy period that is just now starting.
  */
 static void rcu_eqs_exit(bool user)
 {
@@ -755,8 +755,14 @@ static void rcu_eqs_exit(bool user)
 			  rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
-	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
+
+	/*
+	 * Exiting usermode/idle from interrupt is not handled. These would
+	 * mean usermode upcalls or idle exit happened from interrupts. Remove
+	 * the warning by 2020.
+	 */
+	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
+		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
 }
 
 /**
@@ -812,6 +818,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	/* Complain about underflow. */
+	WARN_ON_ONCE(rdp->dynticks_nesting < 0);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
 
 	/*
@@ -836,7 +843,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 
 		incby = 1;
 	} else if (irq && tick_nohz_full_cpu(rdp->cpu) &&
-		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
+		   !rdp->dynticks_nmi_nesting &&
 		   READ_ONCE(rdp->rcu_urgent_qs) &&
 		   !READ_ONCE(rdp->rcu_forced_tick)) {
 		// We get here only if we had already exited the extended
@@ -856,11 +863,14 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 	}
 
 	trace_rcu_dyntick(incby == 1 ? TPS("End") : TPS("StillNonIdle"),
-			  TPS("IRQ"), rdp->dynticks_nmi_nesting,
-			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
+			  TPS("IRQ"), rdp->dynticks_nesting,
+			  rdp->dynticks_nesting + incby, atomic_read(&rdp->dynticks));
+
+	WRITE_ONCE(rdp->dynticks_nesting, /* Prevent store tearing. */
+		   rdp->dynticks_nesting + incby);
 
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
-		   rdp->dynticks_nmi_nesting + incby);
+		   rdp->dynticks_nmi_nesting + 1);
 	barrier();
 }
 
-- 
2.26.2.526.g744177e7f7-goog

