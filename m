Return-Path: <SRS0=HCMS=WM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E852DC3A589
	for <rcu@archiver.kernel.org>; Fri, 16 Aug 2019 02:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DFF2086C
	for <rcu@archiver.kernel.org>; Fri, 16 Aug 2019 02:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cne4Uy0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfHPCxi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:53:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46961 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfHPCxi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Aug 2019 22:53:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3so1596920pgv.13
        for <rcu@vger.kernel.org>; Thu, 15 Aug 2019 19:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6C7nsEWeVGB4888cN8q/jWIS1P5u9hq1V6DhL0RVWe8=;
        b=cne4Uy0chp6xXGf5/NPrrQ1rTDHu4xTxyOdhFhYq/KAJNdVDz+vD+0zD0Gap9PndIB
         cfdOpNHZk1lhhE0sqqUYUnEvyV5Ougv5wyIophewCy2RW1BOxr7Ny7YWbJXBBnqxO/oY
         aXAQfwthwibtfeOJ2wRL+khB7q4160zGWVvyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6C7nsEWeVGB4888cN8q/jWIS1P5u9hq1V6DhL0RVWe8=;
        b=N96jGij+BTlv5OtYGZEQA+Z9jhbqDDOcn1lcdkqcP1m4tOGOEsxW0zA+pphPG1fwno
         SSYCyE8tBTURW7E9OCN6rtapnnjGFzrEnD61j2VE+9l7h0drvUnD9OPTUSjW3AEbz9VC
         cw3/XUilhBV3BAczFOuksBC3aEbvytJqB1KBCxzEzSD9b/945uuESGRX3ZRtHqt2yrOB
         PWv0T/ZUbk6JTd/N4eXqWGFgSDCD564ADlIFpOuBW4Nx/m9SkiYYUDHvVGKwnc9pk9HP
         InY6d/l2EQS/uVD4qvge0G6+zXf11O1upjRZBWY242bx4Eqmg3K3P8bHzvMsFcYkz1Vk
         0xcw==
X-Gm-Message-State: APjAAAUt2cFj/ImTgIkN3X4gLQsHme2N57m+lCwqLbwPSOns27oCN5Ia
        dhCFDJ9f+gnLdCKl+/dt4YPZjgHV6Zs=
X-Google-Smtp-Source: APXvYqwenGZSyYNmDl5chXWdMBNMV19H3KiRONvj973n+jLJ0Vv7EAyJdhjZndMbR6qEq0gHwoNq1A==
X-Received: by 2002:aa7:8e17:: with SMTP id c23mr8576153pfr.227.1565924017537;
        Thu, 15 Aug 2019 19:53:37 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id v14sm4181258pfm.164.2019.08.15.19.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 19:53:36 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        frederic@kernel.org
Subject: [PATCH -rcu dev 1/3] rcu/tree: tick_dep_set/clear_cpu should accept bits instead of masks
Date:   Thu, 15 Aug 2019 22:53:09 -0400
Message-Id: <20190816025311.241257-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit fixes the issue.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0512de9ead20..322b1b57967c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -829,7 +829,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		   !rdp->dynticks_nmi_nesting &&
 		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
 		rdp->rcu_forced_tick = true;
-		tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
+		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 	}
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  rdp->dynticks_nmi_nesting,
@@ -898,7 +898,7 @@ void rcu_irq_enter_irqson(void)
 void rcu_disable_tick_upon_qs(struct rcu_data *rdp)
 {
 	if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick) {
-		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
+		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 		rdp->rcu_forced_tick = false;
 	}
 }
@@ -2123,8 +2123,9 @@ int rcutree_dead_cpu(unsigned int cpu)
 	do_nocb_deferred_wakeup(per_cpu_ptr(&rcu_data, cpu));
 
 	// Stop-machine done, so allow nohz_full to disable tick.
-	for_each_online_cpu(c)
-		tick_dep_clear_cpu(c, TICK_DEP_MASK_RCU);
+	for_each_online_cpu(c) {
+		tick_dep_clear_cpu(c, TICK_DEP_BIT_RCU);
+	}
 	return 0;
 }
 
@@ -2175,8 +2176,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
 	/* Invoke callbacks. */
-	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
-		tick_dep_set_task(current, TICK_DEP_MASK_RCU);
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
+		tick_dep_set_task(current, TICK_DEP_BIT_RCU);
+	}
 	rhp = rcu_cblist_dequeue(&rcl);
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		debug_rcu_head_unqueue(rhp);
@@ -2243,8 +2245,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Re-invoke RCU core processing if there are callbacks remaining. */
 	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist))
 		invoke_rcu_core();
-	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
-		tick_dep_clear_task(current, TICK_DEP_MASK_RCU);
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
+		tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
+	}
 }
 
 /*
@@ -3118,8 +3121,9 @@ int rcutree_online_cpu(unsigned int cpu)
 	rcutree_affinity_setting(cpu, -1);
 
 	// Stop-machine done, so allow nohz_full to disable tick.
-	for_each_online_cpu(c)
-		tick_dep_clear_cpu(c, TICK_DEP_MASK_RCU);
+	for_each_online_cpu(c) {
+		tick_dep_clear_cpu(c, TICK_DEP_BIT_RCU);
+	}
 	return 0;
 }
 
@@ -3143,8 +3147,9 @@ int rcutree_offline_cpu(unsigned int cpu)
 	rcutree_affinity_setting(cpu, cpu);
 
 	// nohz_full CPUs need the tick for stop-machine to work quickly
-	for_each_online_cpu(c)
-		tick_dep_set_cpu(c, TICK_DEP_MASK_RCU);
+	for_each_online_cpu(c) {
+		tick_dep_set_cpu(c, TICK_DEP_BIT_RCU);
+	}
 	return 0;
 }
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

