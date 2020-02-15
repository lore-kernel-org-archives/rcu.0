Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DAAC35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83743207FF
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581727039;
	bh=px8g1b89fnvKMi7OBxKtuIcO0tXx2IGDGf7XzgIf18c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V1h5NbLqk7Y7qTxt4hCL4+ii8TKr9r0nfnAMN1iXu81SqXgjDWtbXr1UmRnbksG0Y
	 QXKLi0znsEQYfhNHNSb59bSCPQUg9kVUr+O1+0P5ej34udXE+IAPPfZR6CCj2ts+IN
	 4zMLJNj/i3C83yNYHFCTlnPzRj9nDciO9lm1GyFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgBOAhT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:37:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:47370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbgBOAhS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:37:18 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBDE8206CC;
        Sat, 15 Feb 2020 00:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727038;
        bh=px8g1b89fnvKMi7OBxKtuIcO0tXx2IGDGf7XzgIf18c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHWTcB+oZLu0B8i7a2ddBA16Vgr2/HDR5AQqQKkcwBkmpPIrTy+7vHuCerl8BJY6V
         tS4J8dlmVTgDAt4YtdD06dmswnAq4EXa/HgS+5jmEYO460IlUiDj933NHgdF76k/cC
         4ay36q6iUgsMFVK+Bk9K0odGcY6E0uJNjAnGgEY4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/18] rcutorture: Suppress forward-progress complaints during early boot
Date:   Fri, 14 Feb 2020 16:36:54 -0800
Message-Id: <20200215003711.16463-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Some larger systems can take in excess of 50 seconds to complete their
early boot initcalls prior to spawing init.  This does not in any way
help the forward-progress judgments of built-in rcutorture (when
rcutorture is built as a module, the insmod or modprobe command normally
cannot happen until some time after boot completes).  This commit
therefore suppresses such complaints until about the time that init
is spawned.

This also includes a fix to a stupid error located by kbuild test robot.

[ paulmck: Apply kbuild test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ paulmck: Fix to nohz_full slow-expediting recovery logic, per bpetkov. ]
[ paulmck: Restrict splat to CONFIG_PREEMPT_RT=y kernels and simplify. ]
Tested-by: Borislav Petkov <bp@alien8.de>
---
 include/linux/rcutiny.h |  1 +
 include/linux/rcutree.h |  1 +
 kernel/rcu/rcutorture.c |  3 ++-
 kernel/rcu/tree_exp.h   |  7 ++++++-
 kernel/rcu/update.c     | 12 ++++++++++++
 5 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index b2b2dc9..045c28b 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -83,6 +83,7 @@ void rcu_scheduler_starting(void);
 static inline void rcu_scheduler_starting(void) { }
 #endif /* #else #ifndef CONFIG_SRCU */
 static inline void rcu_end_inkernel_boot(void) { }
+static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
 static inline void rcu_momentary_dyntick_idle(void) { }
 static inline void kfree_rcu_scheduler_running(void) { }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 2f787b9..45f3f66 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -54,6 +54,7 @@ void exit_rcu(void);
 void rcu_scheduler_starting(void);
 extern int rcu_scheduler_active __read_mostly;
 void rcu_end_inkernel_boot(void);
+bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
 #ifndef CONFIG_PREEMPTION
 void rcu_all_qs(void);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1aeecc1..9ba4978 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1067,7 +1067,8 @@ rcu_torture_writer(void *arg)
 		if (stutter_wait("rcu_torture_writer") &&
 		    !READ_ONCE(rcu_fwd_cb_nodelay) &&
 		    !cur_ops->slow_gps &&
-		    !torture_must_stop())
+		    !torture_must_stop() &&
+		    rcu_inkernel_boot_has_ended())
 			for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++)
 				if (list_empty(&rcu_tortures[i].rtort_free) &&
 				    rcu_access_pointer(rcu_torture_current) !=
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index dcbd757..a72d16e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -485,6 +485,7 @@ static bool synchronize_rcu_expedited_wait_once(long tlimit)
 static void synchronize_rcu_expedited_wait(void)
 {
 	int cpu;
+	unsigned long j;
 	unsigned long jiffies_stall;
 	unsigned long jiffies_start;
 	unsigned long mask;
@@ -496,7 +497,7 @@ static void synchronize_rcu_expedited_wait(void)
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
 	jiffies_stall = rcu_jiffies_till_stall_check();
 	jiffies_start = jiffies;
-	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
+	if (tick_nohz_full_enabled() && rcu_inkernel_boot_has_ended()) {
 		if (synchronize_rcu_expedited_wait_once(1))
 			return;
 		rcu_for_each_leaf_node(rnp) {
@@ -508,6 +509,10 @@ static void synchronize_rcu_expedited_wait(void)
 				tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
 			}
 		}
+		j = READ_ONCE(jiffies_till_first_fqs);
+		if (synchronize_rcu_expedited_wait_once(j + HZ))
+			return;
+		WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT));
 	}
 
 	for (;;) {
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 6c4b862..feaaec5 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -183,6 +183,8 @@ void rcu_unexpedite_gp(void)
 }
 EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
 
+static bool rcu_boot_ended __read_mostly;
+
 /*
  * Inform RCU of the end of the in-kernel boot sequence.
  */
@@ -191,7 +193,17 @@ void rcu_end_inkernel_boot(void)
 	rcu_unexpedite_gp();
 	if (rcu_normal_after_boot)
 		WRITE_ONCE(rcu_normal, 1);
+	rcu_boot_ended = 1;
+}
+
+/*
+ * Let rcutorture know when it is OK to turn it up to eleven.
+ */
+bool rcu_inkernel_boot_has_ended(void)
+{
+	return rcu_boot_ended;
 }
+EXPORT_SYMBOL_GPL(rcu_inkernel_boot_has_ended);
 
 #endif /* #ifndef CONFIG_TINY_RCU */
 
-- 
2.9.5

