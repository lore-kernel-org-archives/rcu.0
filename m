Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E008C432BE
	for <rcu@archiver.kernel.org>; Sun, 25 Jul 2021 21:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D9160F39
	for <rcu@archiver.kernel.org>; Sun, 25 Jul 2021 21:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhGYVEQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 25 Jul 2021 17:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGYVEP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 25 Jul 2021 17:04:15 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC57C061757;
        Sun, 25 Jul 2021 14:44:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n10so1636206plc.2;
        Sun, 25 Jul 2021 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=431vP1SxHYzCIo6ntAnuLBVEe3pf46VJ4JXhlmOI2v4=;
        b=Xzy4h3V6xdLwKf/7drpCjyw1/O5N388GGNhlDWc/SAWEpOBCKpwxxLg1oB4p+HN5VX
         cf2HVFXPvTmtirQlkVO0rNAuKwvD8HuT3v0X/VymL881ezdHCsNA1DqeDU/uvtifh2Zv
         aqdGC9szEMmMTau/KJR9zIeacQfEtJyEWQrmpziCUhGcMr/lnsrPqyXdmTDNhTZ7ujMk
         KC8qyS/bITngDSCl/BZmxaaPoKAA005tkoIcWzeh4fPJRYbH5rCMXozzXWTJFuiutRYi
         IwYJrDwKHSHHB6CRl9IFv6GPTfh01zzD84U8cj8BYKXKTGlhA2xC8q2b+pRhCpu9F6So
         NiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=431vP1SxHYzCIo6ntAnuLBVEe3pf46VJ4JXhlmOI2v4=;
        b=Qqd6SWH1/Wd/ABpQQg4izquVUZ8psoBzWHdNshJyt1cCbqDNrXOgF/rTr0W8rnz9Mo
         kHahgYrACxa3o+uc1dHNJnXkY3FCPFleQZClyOxcfWlA9oxD7PZuZsCNCfYb4kY+nbQy
         SS+h2lkq6NZaleMKrbcmOgahsc66tigtUcb+PHKJMHcm3m9c3foKdkBn3QFtrk6zouJG
         nPRJVDeHa+Gi8WseYmR3HPkfDlHXbys7XG936F8wL2jbUlRbksAP3ZhM4bmmL7OyJZlO
         71nv328KPlq60vHoH/Tz4jkxzTUGzybSlbn3HpkqpZlRq2WScFX8QoVz2xoVM/EB/25b
         t6Qw==
X-Gm-Message-State: AOAM530ucqv1MLl6W2nZ+BbyBN8a7myLB/WiDFbPsVY7aQFjuISjw4dD
        08zMlqH8jiM1quL2p2aUsln/2ibGYOZ+xgx3
X-Google-Smtp-Source: ABdhPJw9S1QRJbqPMtG0DZ4UEwyu630syaVRSRj8woXEYkCyOCYysFG9MBAn/F6H1oG6MzgIA5OgMw==
X-Received: by 2002:a17:903:2445:b029:12b:9d0e:6b97 with SMTP id l5-20020a1709032445b029012b9d0e6b97mr12080514pls.84.1627249483722;
        Sun, 25 Jul 2021 14:44:43 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.87])
        by smtp.gmail.com with ESMTPSA id on9sm464193pjb.47.2021.07.25.14.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 14:44:43 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, ysato@users.sourceforge.jp,
        dalias@libc.org, chris@zankel.net, jcmvbkbc@gmail.com,
        dave@stgolabs.net, tiwai@suse.de, frederic@kernel.org,
        mchehab+huawei@kernel.org, nfraprado@protonmail.com,
        wcohen@redhat.com, tglx@linutronix.de, viro@zeniv.linux.org.uk,
        rric@kernel.org, viresh.kumar@linaro.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] RCU: Fix undefined Kconfig macros
Date:   Mon, 26 Jul 2021 05:43:33 +0800
Message-Id: <20210725214333.10623-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

After I invoking scripts/checkkconfigsymbols.py in linux kernel source
tree, I find 4 undefined Kconfig macros. I examine them one by one, and
fix them following your advice.

1. TREE_PREEMPT_RCU
Referencing files: arch/sh/configs/sdk7786_defconfig

It should now be CONFIG_PREEMPT_RCU. Except that the CONFIG_PREEMPT=y in
that same file implies CONFIG_PREEMPT_RCU=y, so I delete the
CONFIG_TREE_PREEMPT_RCU=y line.

The reason is as follows.
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

We now get RCU_CPU_STALL_INFO whether we want it or not, so this
line should be deleted.
(RCU_CPU_STALL_INFO is removed in 75c27f119b6475d95374bdad872c6938b5c26196)

3. RCU_NOCB_CPU_ALL
Referencing files:
Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst

This is an old snapshot of the code. I update this from the real
rcu_prepare_for_idle() function in kernel/rcu/tree_plugin.h.
I have invoked "make htmldocs" to ensure the result of above updating.

4. RCU_TORTURE_TESTS
Referencing files: kernel/rcu/rcutorture.c

forward-progress checking conflicts with CPU-stall testing, so we should
complain when modprobe the rcutorture.ko if that happens.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 .../Tree-RCU-Memory-Ordering.rst              | 69 +++++++++----------
 arch/sh/configs/sdk7786_defconfig             |  1 -
 arch/xtensa/configs/nommu_kc705_defconfig     |  1 -
 kernel/rcu/rcutorture.c                       |  2 +-
 4 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 11cdab037bff..0c4b730bffd7 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -173,49 +173,44 @@ newly arrived RCU callbacks against future grace periods:
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
index 40ef5417d954..434ac28949c0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2444,7 +2444,7 @@ static int __init rcu_torture_fwd_prog_init(void)
 	}
 	if (stall_cpu > 0) {
 		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, conflicts with CPU-stall testing");
-		if (IS_MODULE(CONFIG_RCU_TORTURE_TESTS))
+		if (IS_MODULE(CONFIG_RCU_TORTURE_TEST))
 			return -EINVAL; /* In module, can fail back to user. */
 		WARN_ON(1); /* Make sure rcutorture notices conflict. */
 		return 0;
-- 
2.25.1

