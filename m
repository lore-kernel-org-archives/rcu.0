Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651CDC433F5
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D78E611C7
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhIOXfI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232934AbhIOXfE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C2FE611CE;
        Wed, 15 Sep 2021 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748825;
        bh=gO1MMFnm1zCJjS/gCVvB0Xfe7BwmJf6Jg0wu6mIXWAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5LfraBiX/Y1Drs5JcY3RnY9JStA8qh7UOabyHv15hBoMFOq9526N56VL0ieYZFuL
         WfnyTQ/5DK25J0/RB37Yl+W5SdEOqi9pTHQfeEqB4IcilVqXBqN6Zw9frUwofSAP6o
         SYjKYzcrzww9irevbCNRYWOAWA0lidRc0LMuXAj+3M0LQcId9XSFPvsIL/E7pAGNPx
         1R6J2w5r/zFoMZJrWrj1PyIqrSfXiMM9SyFmsUbFTQ8gdSDbww5jZXunIgKlbc6G+h
         XyDXojajoqk6TPPW6NuN4te1kvI5rx8IUmSXl82GyXDSQBYyyKmvOeQlx8Pd6K0qol
         950V1VIsCGSGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C543A5C0954; Wed, 15 Sep 2021 16:33:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/14] rcu: Fix undefined Kconfig macros
Date:   Wed, 15 Sep 2021 16:33:35 -0700
Message-Id: <20210915233343.3906738-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

Invoking scripts/checkkconfigsymbols.py in the Linux-kernel source tree
located the following issues:

1. TREE_PREEMPT_RCU
Referencing files: arch/sh/configs/sdk7786_defconfig

It should now be CONFIG_PREEMPT_RCU. Except that the CONFIG_PREEMPT=y in
that same file implies CONFIG_PREEMPT_RCU=y.  Therefore, delete the
CONFIG_TREE_PREEMPT_RCU=y line.

The reason is as follows:

In kernel/rcu/Kconfig, we have
config PREEMPT_RCU
        bool
        default y if PREEMPTION

https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt says,
"The default value is only assigned to the config symbol if no other value
 was set by the user (via the input prompt above)."
there is no prompt in config PREEMPT_RCU entry, so we are guaranteed to
get CONFIG_PREEMPT_RCU=y when CONFIG_PREEMPT is present.

2. RCU_CPU_STALL_INFO
Referencing files: arch/xtensa/configs/nommu_kc705_defconfig

The old Kconfig option RCU_CPU_STALL_INFO was removed by commit
75c27f119b64 ("rcu: Remove CONFIG_RCU_CPU_STALL_INFO"), and the kernel
now acts as if this Kconfig option was unconditionally enabled.

3. RCU_NOCB_CPU_ALL
Referencing files:
Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst

This is an old snapshot of the code. I update this from the real
rcu_prepare_for_idle() function in kernel/rcu/tree_plugin.h.
This change was tested by invoking "make htmldocs".

4. RCU_TORTURE_TESTS
Referencing files: kernel/rcu/rcutorture.c

Forward-progress checking conflicts with CPU-stall testing, so we should
complain at "modprobe rcutorture" when both are enabled.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../Tree-RCU-Memory-Ordering.rst              | 69 +++++++++----------
 arch/sh/configs/sdk7786_defconfig             |  1 -
 arch/xtensa/configs/nommu_kc705_defconfig     |  1 -
 kernel/rcu/rcutorture.c                       |  2 +-
 4 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index eeb351296df1..7fdf151a8680 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -202,49 +202,44 @@ newly arrived RCU callbacks against future grace periods:
     1 static void rcu_prepare_for_idle(void)
     2 {
     3   bool needwake;
-    4   struct rcu_data *rdp;
-    5   struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
-    6   struct rcu_node *rnp;
-    7   struct rcu_state *rsp;
-    8   int tne;
-    9
-   10   if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_ALL) ||
-   11       rcu_is_nocb_cpu(smp_processor_id()))
-   12     return;
+    4   struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+    5   struct rcu_node *rnp;
+    6   int tne;
+    7
+    8   lockdep_assert_irqs_disabled();
+    9   if (rcu_rdp_is_offloaded(rdp))
+   10     return;
+   11
+   12   /* Handle nohz enablement switches conservatively. */
    13   tne = READ_ONCE(tick_nohz_active);
-   14   if (tne != rdtp->tick_nohz_enabled_snap) {
-   15     if (rcu_cpu_has_callbacks(NULL))
-   16       invoke_rcu_core();
-   17     rdtp->tick_nohz_enabled_snap = tne;
+   14   if (tne != rdp->tick_nohz_enabled_snap) {
+   15     if (!rcu_segcblist_empty(&rdp->cblist))
+   16       invoke_rcu_core(); /* force nohz to see update. */
+   17     rdp->tick_nohz_enabled_snap = tne;
    18     return;
-   19   }
+   19	}
    20   if (!tne)
    21     return;
-   22   if (rdtp->all_lazy &&
-   23       rdtp->nonlazy_posted != rdtp->nonlazy_posted_snap) {
-   24     rdtp->all_lazy = false;
-   25     rdtp->nonlazy_posted_snap = rdtp->nonlazy_posted;
-   26     invoke_rcu_core();
-   27     return;
-   28   }
-   29   if (rdtp->last_accelerate == jiffies)
-   30     return;
-   31   rdtp->last_accelerate = jiffies;
-   32   for_each_rcu_flavor(rsp) {
-   33     rdp = this_cpu_ptr(rsp->rda);
-   34     if (rcu_segcblist_pend_cbs(&rdp->cblist))
-   35       continue;
-   36     rnp = rdp->mynode;
-   37     raw_spin_lock_rcu_node(rnp);
-   38     needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
-   39     raw_spin_unlock_rcu_node(rnp);
-   40     if (needwake)
-   41       rcu_gp_kthread_wake(rsp);
-   42   }
-   43 }
+   22
+   23   /*
+   24    * If we have not yet accelerated this jiffy, accelerate all
+   25    * callbacks on this CPU.
+   26   */
+   27   if (rdp->last_accelerate == jiffies)
+   28     return;
+   29   rdp->last_accelerate = jiffies;
+   30   if (rcu_segcblist_pend_cbs(&rdp->cblist)) {
+   31     rnp = rdp->mynode;
+   32     raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
+   33     needwake = rcu_accelerate_cbs(rnp, rdp);
+   34     raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
+   35     if (needwake)
+   36       rcu_gp_kthread_wake();
+   37   }
+   38 }
 
 But the only part of ``rcu_prepare_for_idle()`` that really matters for
-this discussion are lines 37–39. We will therefore abbreviate this
+this discussion are lines 32–34. We will therefore abbreviate this
 function as follows:
 
 .. kernel-figure:: rcu_node-lock.svg
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index f776a1d0d277..a8662b6927ec 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -5,7 +5,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_AUDIT=y
 CONFIG_AUDITSYSCALL=y
-CONFIG_TREE_PREEMPT_RCU=y
 CONFIG_RCU_TRACE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index 88b2e222d4bf..fcb620ef3799 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -119,7 +119,6 @@ CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
 CONFIG_STACKTRACE=y
-# CONFIG_RCU_CPU_STALL_INFO is not set
 CONFIG_RCU_TRACE=y
 # CONFIG_FTRACE is not set
 # CONFIG_LD_NO_RELAX is not set
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ab4215266ebe..f640cbd9262c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2449,7 +2449,7 @@ static int __init rcu_torture_fwd_prog_init(void)
 	}
 	if (stall_cpu > 0) {
 		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, conflicts with CPU-stall testing");
-		if (IS_MODULE(CONFIG_RCU_TORTURE_TESTS))
+		if (IS_MODULE(CONFIG_RCU_TORTURE_TEST))
 			return -EINVAL; /* In module, can fail back to user. */
 		WARN_ON(1); /* Make sure rcutorture notices conflict. */
 		return 0;
-- 
2.31.1.189.g2e36527f23

