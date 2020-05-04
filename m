Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0F7C3A5A9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDB0206A5
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MICFRYVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgEDMFU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 08:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728718AbgEDMFT (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 08:05:19 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64917C061A0E
        for <rcu@vger.kernel.org>; Mon,  4 May 2020 05:05:18 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k12so13674062qtm.4
        for <rcu@vger.kernel.org>; Mon, 04 May 2020 05:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xcapwzPcsZdv7RSLxxp3TggpKWch67MSN39MnzPNw0Y=;
        b=MICFRYVK6GtuotDzprAe+cVkJWuM5Hjx/F4lDbO/M9kYdGwQv+wg131E+o86m/IdEL
         zv6czefK0PY0c3+byltma+sL0iJHgyFPZsM+cABRRVosp2roOtOrSH70LkO4nPKaMzZ6
         xOZ3BcqaZoAcpCy6PpcOrImDmi04ScPKXmVX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcapwzPcsZdv7RSLxxp3TggpKWch67MSN39MnzPNw0Y=;
        b=GWB7vZsPzouBamRWRMUpSeB8Dbuodh6YZ2G7R2W0qV76SdHuFS7nA4ij2xD/laycGQ
         5uYX1J2ZsKpuarAptNeaJtYSIYnGNsbuor+CF9doU+kuvtrUWagx+/e5a7tgOxmuOHsr
         RKcljEz601kOWkZsbIx02HyHOmvsK6xko/hAZSxEUHa4y9f8RlZCY4W0hGovJeDXPJal
         vXWT8TmTOlp17JTplewlALSSkLZhxDIpSRMROexVMGZK6Pa9RA9uZu90tzEK7EAh3Hbr
         A1QK975MD4v6j8VtwNxB7vn2As8XiMJsobrmaFr9Qcg2TcowmVU6h3DcSNVHGfLSiqlu
         2rCA==
X-Gm-Message-State: AGi0Puai3MmFjbeL2S6nmn2aNHad8Qf7GIAyHUcF8iJtIYynNef+8vDN
        EBscj2WmmYirYkZvDCmVFdscuw==
X-Google-Smtp-Source: APiQypJWzJEuSo7bNx8ZTNjXP+kgfFh2Qa534pjBQgzO2h0BFb/cx+0W3G0jQCa0DubsuyqTtXVY1g==
X-Received: by 2002:ac8:4809:: with SMTP id g9mr16808013qtq.33.1588593917214;
        Mon, 04 May 2020 05:05:17 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y50sm6194534qta.56.2020.05.04.05.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:05:16 -0700 (PDT)
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
Subject: [PATCH v3 1/5] Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom of ->dynticks counter")
Date:   Mon,  4 May 2020 08:05:01 -0400
Message-Id: <20200504120505.89351-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200504120505.89351-1-joel@joelfernandes.org>
References: <20200504120505.89351-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This code is unused and can be removed now. Revert was straightforward.

Tested with rcutorture on all TREE configurations.

Link: http://lore.kernel.org/r/CALCETrWNPOOdTrFabTDd=H7+wc6xJ9rJceg6OL1S0rTV5pfSsA@mail.gmail.com
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcutiny.h |  3 --
 kernel/rcu/tree.c       | 93 +++++++++++------------------------------
 2 files changed, 24 insertions(+), 72 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 3465ba704a111..dbcddc7b26b94 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -14,9 +14,6 @@
 
 #include <asm/param.h> /* for HZ */
 
-/* Never flag non-existent other CPUs! */
-static inline bool rcu_eqs_special_set(int cpu) { return false; }
-
 static inline unsigned long get_state_synchronize_rcu(void)
 {
 	return 0;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6d39485f7f517..1ec7b1d4a03c4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -82,20 +82,10 @@
 
 /* Data structures. */
 
-/*
- * Steal a bit from the bottom of ->dynticks for idle entry/exit
- * control.  Initially this is for TLB flushing.
- */
-#define RCU_DYNTICK_CTRL_MASK 0x1
-#define RCU_DYNTICK_CTRL_CTR  (RCU_DYNTICK_CTRL_MASK + 1)
-#ifndef rcu_eqs_special_exit
-#define rcu_eqs_special_exit() do { } while (0)
-#endif
-
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
-	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
+	.dynticks = ATOMIC_INIT(1),
 };
 static struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
@@ -245,21 +235,18 @@ void rcu_softirq_qs(void)
 static void rcu_dynticks_eqs_enter(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	int seq;
+	int special;
+
+	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
 
 	/*
-	 * CPUs seeing atomic_add_return() must see prior RCU read-side
+	 * CPUs seeing atomic_inc_return() must see prior RCU read-side
 	 * critical sections, and we also must force ordering with the
 	 * next idle sojourn.
 	 */
-	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
-	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
+	special = atomic_inc_return(&rdp->dynticks);
 	// RCU is no longer watching.  Better be in extended quiescent state!
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     (seq & RCU_DYNTICK_CTRL_CTR));
-	/* Better not have special action (TLB flush) pending! */
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     (seq & RCU_DYNTICK_CTRL_MASK));
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && special & 0x1);
 }
 
 /*
@@ -270,24 +257,18 @@ static void rcu_dynticks_eqs_enter(void)
 static void rcu_dynticks_eqs_exit(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	int seq;
+	int special;
 
 	/*
-	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
+	 * CPUs seeing atomic_inc_return() must see prior idle sojourns,
 	 * and we also must force ordering with the next RCU read-side
 	 * critical section.
 	 */
-	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
+	special = atomic_inc_return(&rdp->dynticks);
 	// RCU is now watching.  Better not be in an extended quiescent state!
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(special & 0x1));
+
 	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     !(seq & RCU_DYNTICK_CTRL_CTR));
-	if (seq & RCU_DYNTICK_CTRL_MASK) {
-		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
-		smp_mb__after_atomic(); /* _exit after clearing mask. */
-		/* Prefer duplicate flushes to losing a flush. */
-		rcu_eqs_special_exit();
-	}
 }
 
 /*
@@ -304,9 +285,9 @@ static void rcu_dynticks_eqs_online(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	if (atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR)
+	if (atomic_read(&rdp->dynticks) & 0x1)
 		return;
-	atomic_add(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
+	atomic_add(0x1, &rdp->dynticks);
 }
 
 /*
@@ -318,7 +299,7 @@ static bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	return !(atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
+	return !(atomic_read(&rdp->dynticks) & 0x1);
 }
 
 /*
@@ -329,7 +310,7 @@ static int rcu_dynticks_snap(struct rcu_data *rdp)
 {
 	int snap = atomic_add_return(0, &rdp->dynticks);
 
-	return snap & ~RCU_DYNTICK_CTRL_MASK;
+	return snap;
 }
 
 /*
@@ -338,7 +319,7 @@ static int rcu_dynticks_snap(struct rcu_data *rdp)
  */
 static bool rcu_dynticks_in_eqs(int snap)
 {
-	return !(snap & RCU_DYNTICK_CTRL_CTR);
+	return !(snap & 0x1);
 }
 
 /*
@@ -361,8 +342,7 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 	int snap;
 
 	// If not quiescent, force back to earlier extended quiescent state.
-	snap = atomic_read(&rdp->dynticks) & ~(RCU_DYNTICK_CTRL_MASK |
-					       RCU_DYNTICK_CTRL_CTR);
+	snap = atomic_read(&rdp->dynticks) & ~(0x1);
 
 	smp_rmb(); // Order ->dynticks and *vp reads.
 	if (READ_ONCE(*vp))
@@ -370,32 +350,7 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 	smp_rmb(); // Order *vp read and ->dynticks re-read.
 
 	// If still in the same extended quiescent state, we are good!
-	return snap == (atomic_read(&rdp->dynticks) & ~RCU_DYNTICK_CTRL_MASK);
-}
-
-/*
- * Set the special (bottom) bit of the specified CPU so that it
- * will take special action (such as flushing its TLB) on the
- * next exit from an extended quiescent state.  Returns true if
- * the bit was successfully set, or false if the CPU was not in
- * an extended quiescent state.
- */
-bool rcu_eqs_special_set(int cpu)
-{
-	int old;
-	int new;
-	int new_old;
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-
-	new_old = atomic_read(&rdp->dynticks);
-	do {
-		old = new_old;
-		if (old & RCU_DYNTICK_CTRL_CTR)
-			return false;
-		new = old | RCU_DYNTICK_CTRL_MASK;
-		new_old = atomic_cmpxchg(&rdp->dynticks, old, new);
-	} while (new_old != old);
-	return true;
+	return snap == atomic_read(&rdp->dynticks);
 }
 
 /*
@@ -411,13 +366,13 @@ bool rcu_eqs_special_set(int cpu)
  */
 void rcu_momentary_dyntick_idle(void)
 {
-	int special;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	int special = atomic_add_return(2, &rdp->dynticks);
 
-	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
-	special = atomic_add_return(2 * RCU_DYNTICK_CTRL_CTR,
-				    &this_cpu_ptr(&rcu_data)->dynticks);
 	/* It is illegal to call this from idle state. */
-	WARN_ON_ONCE(!(special & RCU_DYNTICK_CTRL_CTR));
+	WARN_ON_ONCE(!(special & 0x1));
+
+	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
 	rcu_preempt_deferred_qs(current);
 }
 EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
-- 
2.26.2.526.g744177e7f7-goog

