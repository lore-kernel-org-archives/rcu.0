Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E396215ECE8
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832414; cv=none; b=KJo+4OZiwAkzgqsBzOtgncFEsuQ8ADJWLxiVOrufQ5qB+Ze9vf2kNO8k6fWODHvyEJNL+OEb55Q3yzGFf1Ph60mnB0wW0lW4CFcZyTy+ygLA8rf7JVMBpy8dbpNX/nPtQcLXS4a4QJoiQg+ietOSeCpRL/1tincZKM6uLb91GXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832414; c=relaxed/simple;
	bh=+KW6CRxXW4zqzD1hQeFHBT4HQqNex/mgRGhiDNFOUYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsQjoeWDBGvViSmcx0IqM68UjGRqWdbSbcAR8DDy3F5+j6h3f63cxX88y0wzD4X93LQ/TEWP2OkFIv9p4cSGYJND/IrUhB5kuxoI2xjvkGAGcAqf/so+hYX5TLsyM7zv9piv3sVCzodwx8PtdBlqYaDTWxrgWc+b+3ocaKGRLXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyTmqMQY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyTmqMQY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLcr37OkXf9eibtNx20tDj5cCUmV70TmpFgGkscx8Tc=;
	b=eyTmqMQYOBA5ryv+ZbmlFU2Ph2x5F4aDjNO8wMTYmaJkemRmFP9iVlkgoxI+TJz5M1vUg9
	YodhNIrWT/0gKF8gTlxvi1EIGcwgZLnZ6pEYssUnR7L5GhrE/d4Gu86bpI5BkVXTdHB6nW
	Bv/Hu/n80Y/6Dp42m2q7ziDJkm0uFkk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-z1EN1HF3M5iLb1StJlAx5Q-1; Wed,
 24 Jul 2024 10:46:47 -0400
X-MC-Unique: z1EN1HF3M5iLb1StJlAx5Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55AD11955D4A;
	Wed, 24 Jul 2024 14:46:45 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BE14194511F;
	Wed, 24 Jul 2024 14:46:30 +0000 (UTC)
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
Subject: [PATCH v3 23/25] rcu: Rename rcu_momentary_dyntick_idle() into rcu_momentary_eqs()
Date: Wed, 24 Jul 2024 16:43:23 +0200
Message-ID: <20240724144325.3307148-24-vschneid@redhat.com>
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
RCU_WATCHING, replace "dyntick_idle" into "eqs" to drop the dyntick
reference.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/rcutiny.h      | 2 +-
 include/linux/rcutree.h      | 2 +-
 kernel/rcu/rcutorture.c      | 4 ++--
 kernel/rcu/tree.c            | 4 ++--
 kernel/rcu/tree_nocb.h       | 2 +-
 kernel/rcu/tree_plugin.h     | 6 +++---
 kernel/stop_machine.c        | 2 +-
 kernel/trace/trace_osnoise.c | 4 ++--
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index d9ac7b136aeab..cf2b5a188f783 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -158,7 +158,7 @@ void rcu_scheduler_starting(void);
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
-static inline void rcu_momentary_dyntick_idle(void) { }
+static inline void rcu_momentary_eqs(void) { }
 static inline void kfree_rcu_scheduler_running(void) { }
 static inline bool rcu_gp_might_be_stalled(void) { return false; }
 
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 254244202ea97..7dbde2b6f714a 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -37,7 +37,7 @@ void synchronize_rcu_expedited(void);
 void kvfree_call_rcu(struct rcu_head *head, void *ptr);
 
 void rcu_barrier(void);
-void rcu_momentary_dyntick_idle(void);
+void rcu_momentary_eqs(void);
 void kfree_rcu_scheduler_running(void);
 bool rcu_gp_might_be_stalled(void);
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 08bf7c669dd3d..ef757c3e84a27 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2680,7 +2680,7 @@ static unsigned long rcu_torture_fwd_prog_cbfree(struct rcu_fwd *rfp)
 		rcu_torture_fwd_prog_cond_resched(freed);
 		if (tick_nohz_full_enabled()) {
 			local_irq_save(flags);
-			rcu_momentary_dyntick_idle();
+			rcu_momentary_eqs();
 			local_irq_restore(flags);
 		}
 	}
@@ -2830,7 +2830,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 		rcu_torture_fwd_prog_cond_resched(n_launders + n_max_cbs);
 		if (tick_nohz_full_enabled()) {
 			local_irq_save(flags);
-			rcu_momentary_dyntick_idle();
+			rcu_momentary_eqs();
 			local_irq_restore(flags);
 		}
 	}
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3c607e45532bd..2c9482b962a99 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -359,7 +359,7 @@ bool rcu_watching_zero_in_eqs(int cpu, int *vp)
  *
  * The caller must have disabled interrupts and must not be idle.
  */
-notrace void rcu_momentary_dyntick_idle(void)
+notrace void rcu_momentary_eqs(void)
 {
 	int seq;
 
@@ -369,7 +369,7 @@ notrace void rcu_momentary_dyntick_idle(void)
 	WARN_ON_ONCE(!(seq & CT_RCU_WATCHING));
 	rcu_preempt_deferred_qs(current);
 }
-EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
+EXPORT_SYMBOL_GPL(rcu_momentary_eqs);
 
 /**
  * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 3ce30841119ad..e629646ac6f52 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -917,7 +917,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
 
 	local_irq_save(flags);
-	rcu_momentary_dyntick_idle();
+	rcu_momentary_eqs();
 	local_irq_restore(flags);
 	/*
 	 * Disable BH to provide the expected environment.  Also, when
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 51125f4130fd4..5fc7309187e1f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -869,7 +869,7 @@ static void rcu_qs(void)
 
 /*
  * Register an urgently needed quiescent state.  If there is an
- * emergency, invoke rcu_momentary_dyntick_idle() to do a heavy-weight
+ * emergency, invoke rcu_momentary_eqs() to do a heavy-weight
  * dyntick-idle quiescent state visible to other CPUs, which will in
  * some cases serve for expedited as well as normal grace periods.
  * Either way, register a lightweight quiescent state.
@@ -889,7 +889,7 @@ void rcu_all_qs(void)
 	this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs))) {
 		local_irq_save(flags);
-		rcu_momentary_dyntick_idle();
+		rcu_momentary_eqs();
 		local_irq_restore(flags);
 	}
 	rcu_qs();
@@ -909,7 +909,7 @@ void rcu_note_context_switch(bool preempt)
 		goto out;
 	this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs)))
-		rcu_momentary_dyntick_idle();
+		rcu_momentary_eqs();
 out:
 	rcu_tasks_qs(current, preempt);
 	trace_rcu_utilization(TPS("End context switch"));
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a9..da821ce258ea7 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -251,7 +251,7 @@ static int multi_cpu_stop(void *data)
 			 */
 			touch_nmi_watchdog();
 		}
-		rcu_momentary_dyntick_idle();
+		rcu_momentary_eqs();
 	} while (curstate != MULTI_STOP_EXIT);
 
 	local_irq_restore(flags);
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a8e28f9b9271c..a41e8a8212647 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1535,7 +1535,7 @@ static int run_osnoise(void)
 		 * This will eventually cause unwarranted noise as PREEMPT_RCU
 		 * will force preemption as the means of ending the current
 		 * grace period. We avoid this problem by calling
-		 * rcu_momentary_dyntick_idle(), which performs a zero duration
+		 * rcu_momentary_eqs(), which performs a zero duration
 		 * EQS allowing PREEMPT_RCU to end the current grace period.
 		 * This call shouldn't be wrapped inside an RCU critical
 		 * section.
@@ -1547,7 +1547,7 @@ static int run_osnoise(void)
 			if (!disable_irq)
 				local_irq_disable();
 
-			rcu_momentary_dyntick_idle();
+			rcu_momentary_eqs();
 
 			if (!disable_irq)
 				local_irq_enable();
-- 
2.43.0

