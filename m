Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D983C433EF
	for <rcu@archiver.kernel.org>; Sun, 24 Oct 2021 00:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EFF60EFE
	for <rcu@archiver.kernel.org>; Sun, 24 Oct 2021 00:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhJXAj1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 23 Oct 2021 20:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhJXAj1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 23 Oct 2021 20:39:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76768C061764
        for <rcu@vger.kernel.org>; Sat, 23 Oct 2021 17:37:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q187so7066042pgq.2
        for <rcu@vger.kernel.org>; Sat, 23 Oct 2021 17:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qHe1354eGv/ZGRiPRny/+zhQkdqYKgjehVtJqJKS51s=;
        b=BXCYS60StIVsx1TY52QYyhrRjlYazl3u0RhBJx21B9z2mG0K8hEvyjMYcQKthC6+ci
         ZbzDwmLv235ieWUGuK/u69Hh6/hqKQPWle2rm/wBQ/BZkOy9uzHn6P6OG2DFvgBIUOn6
         jS8HLE+PQXhdN4MHtNxPRgwTsMBkq4nhmj+5S8TFE9b2PbGhSk94XRAoLplfRGpBTzYR
         t62LAKJQt4qJm1XJC2npxuHnBRBNULfO6HC+wVdeOYEOXgxGTn3gnn18C1d6yu+desNo
         bln2Wj1XZOyKqrLXL+e3HLOfyRgb+KE3PKTGoSHWyB/Mc6eSxiwhE69y/ez2JhbMvyqX
         eAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qHe1354eGv/ZGRiPRny/+zhQkdqYKgjehVtJqJKS51s=;
        b=zvEXA9ExlcqA4kIXpX2n+1S+QaeosLGzL1Zf9jiMBNMti6GoHnWMYc59KzDg43kAvp
         wxqmqAY23+qC1UjSTzN3Ms8ec52ynqLvd001Ah+4K2L4tO8j0QrgUz1EEdGez6/dh1AC
         Rixng2jIUoA4ZCxSQnwTbiAfT6UQpisVD1PMpF4lc7kuw8U9UzmboHgQdYYTv0ABV4Kj
         Tn3q0oUik/dGvJHEivarx2kKzg7OTyBM9xsPjFJSkcQNawvZnJLuD6VvDKdjvc/HAEGj
         pchhPhXSBjUPpLSdhEbB1R+dR3o9INZwfnaMPmdUIG1fXN1moEh1HQXubRd1AFRSjInL
         K6xw==
X-Gm-Message-State: AOAM533RadH85+lCw06fZsjyeLHC0ojVuA242jsoXaxcPJQKJ7LupUtK
        VSx5RTO5Dufs5m766r1P8H0=
X-Google-Smtp-Source: ABdhPJzwxwA+sozh+o7YWMZHr4p+FD8XfjCMKu2K4KXp4w1NOnZKJBID0hXdRpgW7lHjLEH/xPPN6g==
X-Received: by 2002:a62:5585:0:b0:44d:e30f:fa7c with SMTP id j127-20020a625585000000b0044de30ffa7cmr8941205pfb.53.1635035826825;
        Sat, 23 Oct 2021 17:37:06 -0700 (PDT)
Received: from localhost.localdomain ([45.145.248.165])
        by smtp.gmail.com with ESMTPSA id m10sm2785965pjz.4.2021.10.23.17.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 17:37:06 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] rcu: Improve tree_plugin.h comments and add code cleanups
Date:   Sun, 24 Oct 2021 08:36:34 +0800
Message-Id: <20211024003634.8017-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit cleans up some comments and code in kernel/rcu/tree_plugin.h.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Hi Paul,

I perform some comments and code cleans up in kernel/rcu/tree_plugin.h
while learning RCU.

Thanks
Zhouyi
--
 kernel/rcu/tree_plugin.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d070059163d7..dde7fa17ae2b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -16,7 +16,7 @@
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 {
 	/*
-	 * In order to read the offloaded state of an rdp is a safe
+	 * In order to read the offloaded state of an rdp in a safe
 	 * and stable way and prevent from its value to be changed
 	 * under us, we must either hold the barrier mutex, the cpu
 	 * hotplug lock (read or write) or the nocb lock. Local
@@ -56,7 +56,7 @@ static void __init rcu_bootup_announce_oddness(void)
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
 		pr_info("\tRCU lockdep checking is enabled.\n");
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
-		pr_info("\tRCU strict (and thus non-scalable) grace periods enabled.\n");
+		pr_info("\tRCU strict (and thus non-scalable) grace periods are enabled.\n");
 	if (RCU_NUM_LVLS >= 4)
 		pr_info("\tFour(or more)-level hierarchy is enabled.\n");
 	if (RCU_FANOUT_LEAF != 16)
@@ -88,13 +88,13 @@ static void __init rcu_bootup_announce_oddness(void)
 	if (rcu_kick_kthreads)
 		pr_info("\tKick kthreads if too-long grace period.\n");
 	if (IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD))
-		pr_info("\tRCU callback double-/use-after-free debug enabled.\n");
+		pr_info("\tRCU callback double-/use-after-free debug is enabled.\n");
 	if (gp_preinit_delay)
 		pr_info("\tRCU debug GP pre-init slowdown %d jiffies.\n", gp_preinit_delay);
 	if (gp_init_delay)
 		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_init_delay);
 	if (gp_cleanup_delay)
-		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_cleanup_delay);
+		pr_info("\tRCU debug GP cleanup slowdown %d jiffies.\n", gp_cleanup_delay);
 	if (!use_softirq)
 		pr_info("\tRCU_SOFTIRQ processing moved to rcuc kthreads.\n");
 	if (IS_ENABLED(CONFIG_RCU_EQS_DEBUG))
@@ -1154,7 +1154,6 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
 /*
  * Create an RCU-boost kthread for the specified node if one does not
  * already exist.  We only create this kthread for preemptible RCU.
- * Returns zero if all is well, a negated errno otherwise.
  */
 static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
@@ -1456,7 +1455,7 @@ static void rcu_cleanup_after_idle(void)
  * CPU unless the grace period has extended for too long.
  *
  * This code relies on the fact that all NO_HZ_FULL CPUs are also
- * CONFIG_RCU_NOCB_CPU CPUs.
+ * RCU_NOCB_CPU CPUs.
  */
 static bool rcu_nohz_full_cpu(void)
 {
-- 
2.25.1

