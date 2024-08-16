Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32113F012;
	Fri, 16 Aug 2024 04:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781202; cv=none; b=BzBJVQoruPShfq4ik4F6phl4t41Q1xumVR3XrjV2/lPCS1De7BpYHXHL1RKnwD5hEDbKBm8neCXEGKKQlZREGYVxEnykaf49J3aFX36fvzUbeH6rTaq6ac9l0/K/NBZVH3j1eV6m37DPE5jvDeMmr+zXmN7J/N5cUh4zYEHiTlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781202; c=relaxed/simple;
	bh=rGaOumaoYMNca3yrX/V+ugm7iILw3Vxku/c6CrZHQjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iHsaVgX9BKAWEnGs+Z56lxBjWz2DDzRIoh1svPejuBQgs9bduRIqTGFhFZ/WDPSd1Y/Clj9FaLiuGklFITbpetBlZ2UgxPpBYR35PQeXdWBvQPzCAA5Ho2fb3mKEdAVKkmTqX1uz6Sb92aFud/rZ/K17oJgMYeD2G/CJ0b2piJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckI0wkv0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckI0wkv0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2017FC32782;
	Fri, 16 Aug 2024 04:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781201;
	bh=rGaOumaoYMNca3yrX/V+ugm7iILw3Vxku/c6CrZHQjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckI0wkv0XxWhUGNFY5JA9IcQ7XRNzJkDUvmnLavF/or4BzW3Q78EzSPHAcfVnFxOV
	 RnDZFX3cydsVQThpimTn5dF+y6I2/mPL9aY4iL9GiNq8NOmdYGHvUw6DNNg+8V3BDI
	 kfdtl3jUv9eN0BdBdSwonPvgVoDLixYQQDDGx2Hefht7jHKchdk0QJ6tEfP6y1AORZ
	 JIPgg7KFAjWhd+TNZETi/hcIdDxChFh+8vesreRK8qNOvUJ57EuLvBi+38aqsihYW4
	 aE7Lq2psSXoL8BYaoc3IhmoQabcjqHjot7ueXfLzmaJZHx/tX2JYg0zQ1G4Eeuge3b
	 Q7BuRbNvcBJgQ==
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
Subject: [PATCH rcu 25/26] context_tracking, rcu: Rename rcu_dyntick trace event into rcu_watching
Date: Fri, 16 Aug 2024 09:32:40 +0530
Message-Id: <20240816040241.17776-25-neeraj.upadhyay@kernel.org>
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

The "rcu_dyntick" naming convention has been turned into "rcu_watching" for
all helpers now, align the trace event to that.

To add to the confusion, the strings passed to the trace event are now
reversed: when RCU "starts" the dyntick / EQS state, it "stops" watching.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/trace/events/rcu.h | 18 +++++++++---------
 kernel/context_tracking.c  | 10 +++++-----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 4066b6d51e46..e81431deaa50 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -466,40 +466,40 @@ TRACE_EVENT(rcu_stall_warning,
 /*
  * Tracepoint for dyntick-idle entry/exit events.  These take 2 strings
  * as argument:
- * polarity: "Start", "End", "StillNonIdle" for entering, exiting or still not
- *            being in dyntick-idle mode.
+ * polarity: "Start", "End", "StillWatching" for entering, exiting or still not
+ *            being in EQS mode.
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
index 31c6d0c1b79d..938c48952d26 100644
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
2.40.1

