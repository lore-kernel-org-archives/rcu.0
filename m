Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188E9C43461
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4392068E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897522;
	bh=ViAWtvn3usd66rqJtaroi085cgtiibnhS55Z9A5KbxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hyNOE/h6AgKkOvupfXBHPcUB4rU1aYkA/nsnhY1lTzkRMixIQF6rJgIFKy+0i64tr
	 2/TrC044EEe12IZXJC1bh4qm8ZzU9edFDgTXGqRjguW8ZCuaxJ9NEKszIOpSZwa1Om
	 z4mFxR3jb3EOR57r8pP63f7YaXI6WCQQ57xo4JR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgHaSLq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbgHaSL1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:11:27 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20B3121655;
        Mon, 31 Aug 2020 18:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897484;
        bh=ViAWtvn3usd66rqJtaroi085cgtiibnhS55Z9A5KbxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xGTFkfipwcUJE9esrk7E770I5q7i2oQmElZxEMayhZhhVI01aZzCKP2kuY6UO/c46
         nAKdj1QmC2kdPhppcOqho/em7ZDQj1c++R8am5nb1uMl3q8uImH5tEApVzT9Xe5WUF
         793ysbgm0Fn6Bfv4rQC/IUkenwUsFySm0FA7MCfI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/13] rcu: Report QS for outermost PREEMPT=n rcu_read_unlock() for strict GPs
Date:   Mon, 31 Aug 2020 11:11:19 -0700
Message-Id: <20200831181120.1044-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181101.GA950@paulmck-ThinkPad-P72>
References: <20200831181101.GA950@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The CONFIG_PREEMPT=n instance of rcu_read_unlock is even more
aggressively than that of CONFIG_PREEMPT=y in deferring reporting
quiescent states to the RCU core.  This is just what is wanted in normal
use because it reduces overhead, but the resulting delay is not what
is wanted for kernels built with CONFIG_RCU_STRICT_GRACE_PERIOD=y.
This commit therefore adds an rcu_read_unlock_strict() function that
checks for exceptional conditions, and reports the newly started
quiescent state if it is safe to do so, also doing a spin-delay if
requested via rcutree.rcu_unlock_delay.  This commit also adds a call
to rcu_read_unlock_strict() from the CONFIG_PREEMPT=n instance of
__rcu_read_unlock().

[ paulmck: Fixed bug located by kernel test robot <lkp@intel.com> ]
Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |  7 +++++++
 kernel/rcu/tree.c        |  6 ++++++
 kernel/rcu/tree_plugin.h | 24 ++++++++++++++++++------
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d15d46d..522529a 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -55,6 +55,12 @@ void __rcu_read_unlock(void);
 
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
+#ifdef CONFIG_TINY_RCU
+#define rcu_read_unlock_strict() do { } while (0)
+#else
+void rcu_read_unlock_strict(void);
+#endif
+
 static inline void __rcu_read_lock(void)
 {
 	preempt_disable();
@@ -63,6 +69,7 @@ static inline void __rcu_read_lock(void)
 static inline void __rcu_read_unlock(void)
 {
 	preempt_enable();
+	rcu_read_unlock_strict();
 }
 
 static inline int rcu_preempt_depth(void)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 31995b3..a295cadf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -178,6 +178,12 @@ module_param(gp_init_delay, int, 0444);
 static int gp_cleanup_delay;
 module_param(gp_cleanup_delay, int, 0444);
 
+// Add delay to rcu_read_unlock() for strict grace periods.
+static int rcu_unlock_delay;
+#ifdef CONFIG_RCU_STRICT_GRACE_PERIOD
+module_param(rcu_unlock_delay, int, 0444);
+#endif
+
 /*
  * This rcu parameter is runtime-read-only. It reflects
  * a minimum allowed number of objects which can be cached
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3f3a4ff..25a676d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -430,12 +430,6 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
 	return !list_empty(&rnp->blkd_tasks);
 }
 
-// Add delay to rcu_read_unlock() for strict grace periods.
-static int rcu_unlock_delay;
-#ifdef CONFIG_RCU_STRICT_GRACE_PERIOD
-module_param(rcu_unlock_delay, int, 0444);
-#endif
-
 /*
  * Report deferred quiescent states.  The deferral time can
  * be quite short, for example, in the case of the call from
@@ -785,6 +779,24 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
 /*
+ * If strict grace periods are enabled, and if the calling
+ * __rcu_read_unlock() marks the beginning of a quiescent state, immediately
+ * report that quiescent state and, if requested, spin for a bit.
+ */
+void rcu_read_unlock_strict(void)
+{
+	struct rcu_data *rdp;
+
+	if (!IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
+	   irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+		return;
+	rdp = this_cpu_ptr(&rcu_data);
+	rcu_report_qs_rdp(rdp->cpu, rdp);
+	udelay(rcu_unlock_delay);
+}
+EXPORT_SYMBOL_GPL(rcu_read_unlock_strict);
+
+/*
  * Tell them what RCU they are running.
  */
 static void __init rcu_bootup_announce(void)
-- 
2.9.5

