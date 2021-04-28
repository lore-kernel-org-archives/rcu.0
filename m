Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701C1C43461
	for <rcu@archiver.kernel.org>; Wed, 28 Apr 2021 13:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39344600D1
	for <rcu@archiver.kernel.org>; Wed, 28 Apr 2021 13:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbhD1Np4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Apr 2021 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239837AbhD1Npz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Apr 2021 09:45:55 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB5CC061574;
        Wed, 28 Apr 2021 06:45:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z13so18325270lft.1;
        Wed, 28 Apr 2021 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGKAwmRoHgHGco8r7gxeBMiFxoAxPEkLhHKUCbERRDk=;
        b=oiDExTF3miEbD2wnxAJ+0YNV6WydpsisfWp4h+Cds8tXRTqrhb9owqUyJaUP/HSly5
         CG6Be95CbWyzwRb7CLO/+dGGvAYVfWhMg2NkUvbGHwDKS7w3rToYv8u++JeoiJBAqQSi
         zA2XYYL5gIw+5P57z31Ultoq11beFvClXfRMCTxeDfm6LJGpPaQwMc3HkLeIkZuw3Sx1
         dSnbDS1HHLhBGcSXhYg3UcMhrTAliS2EI+aYThqikohg3pdKPIcb1rXt+eIZ5ebWHZcl
         5b0259O+++Ehq95I9ctizN8lR11MSIeZf01dYACMdhBmLQAWxjhZtzZN4EXxFFOvQ9Wb
         GYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGKAwmRoHgHGco8r7gxeBMiFxoAxPEkLhHKUCbERRDk=;
        b=uDFuV4Yf6yuQhkY7hhA836BZ7jNpfy4wiGM17umLfN1GbPGmkKhwPTh+FxQQ0IZjSn
         e6nZMUH309OUN4yaEdxVC6ql9ONBFOCLy+hFLxfRCd8m8uTFbybnL9wyVz2CTaTlUV6J
         jV0lfyu5/gA0bs8BbcrZhy0fgt2GYSnGnnIMszCoUKoYEQUU2Wx3gxEGCQ6/C4ksV1do
         X7ebToT2j6ShgZtAXpmEPLWd1WVfUEfIk3wpRJIqyQZ9ocUNzr441Cvo+KG/kiCi5q8O
         poRRM9vWstjKbmP5giB+YT41qAsZ9c/BTTcBSQ6bmeslFy3bXRDQQLOkxNaa3SSm6jtH
         ri2g==
X-Gm-Message-State: AOAM530xy1Ct2RMwzULgQq82IrX3goymqUDwo/miCDD9Shx/R9iZovMV
        b714tCqso61JYgL7JPy5wj5BGztmQKf8YBTnxvs=
X-Google-Smtp-Source: ABdhPJzeKyzY4XEfy2UnPJQL0M3XBvYSYQuA/sEe8W6afq1SdwAwHpD3y+AbVhcpmrLt26AmItPeXA==
X-Received: by 2002:ac2:5316:: with SMTP id c22mr20304286lfh.469.1619617508976;
        Wed, 28 Apr 2021 06:45:08 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id o16sm730253lfu.228.2021.04.28.06.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 06:45:08 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v1 4/5] kvfree_rcu: Refactor kfree_rcu_monitor() function
Date:   Wed, 28 Apr 2021 15:44:21 +0200
Message-Id: <20210428134422.1894-4-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210428134422.1894-1-urezki@gmail.com>
References: <20210428134422.1894-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Rearm the monitor work directly from its own function that
is kfree_rcu_monitor(). So this patch puts the invocation
timing control in one place.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e44d6f8c56f0..229e909ad437 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3415,37 +3415,44 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 	return !repeat;
 }
 
-static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
-					  unsigned long flags)
+/*
+ * This function queues a new batch. If success or nothing to
+ * drain it returns 1. Otherwise 0 is returned indicating that
+ * a reclaim kthread has not processed a previous batch.
+ */
+static inline int kfree_rcu_drain(struct kfree_rcu_cpu *krcp)
 {
+	unsigned long flags;
+	int ret;
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+
 	// Attempt to start a new batch.
-	if (queue_kfree_rcu_work(krcp)) {
+	ret = queue_kfree_rcu_work(krcp);
+	if (ret)
 		// Success! Our job is done here.
 		krcp->monitor_todo = false;
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
-		return;
-	}
 
 	// Previous RCU batch still in progress, try again later.
-	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+	return ret;
 }
 
 /*
  * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
- * It invokes kfree_rcu_drain_unlock() to attempt to start another batch.
+ * It invokes kfree_rcu_drain() to attempt to start another batch.
  */
 static void kfree_rcu_monitor(struct work_struct *work)
 {
-	unsigned long flags;
 	struct kfree_rcu_cpu *krcp = container_of(work, struct kfree_rcu_cpu,
 						 monitor_work.work);
 
-	raw_spin_lock_irqsave(&krcp->lock, flags);
-	if (krcp->monitor_todo)
-		kfree_rcu_drain_unlock(krcp, flags);
-	else
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
+	if (kfree_rcu_drain(krcp))
+		return;
+
+	// Not success. A previous batch is still in progress.
+	// Rearm a work to repeat an attempt of starting another batch.
+	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 }
 
 static enum hrtimer_restart
-- 
2.20.1

