Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE14C433EF
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbiELDFU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244533AbiELDFN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:05:13 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4971FC2E2
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:12 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z126so3756942qkb.2
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oeVCD28BZkKVAoFgJA0eT8P+UE+HQoj/imzw07R+UyA=;
        b=LA+We+R2/2fOk4tZjx61kMwo3Z96H6NWU9bCb7Ue5UFhME2AuZVFEj8DfSyT/7tvBb
         RlWBRbrguE/iuCXvBo+l/3x7grMqV3YR8e0o1vt5zdyO6V6AChJH4019LztmyG5V2RhX
         qc1mOsdDXWx5mHXaNq6Fs7yZGjx1b1yVqJX9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oeVCD28BZkKVAoFgJA0eT8P+UE+HQoj/imzw07R+UyA=;
        b=16ynmBs8rgn6vv3jifyG9sMn+oaohp3Q3QsUON6UVUzMvImtGRJ8zfD0aOx2c8koW3
         Di9GNf1ttmqxpwnbRl6WFK3m3E9oE4v17BmW/EXJrD11xSEzLd74vEHhQQHPKbhuoMX0
         OdmMqdoeFV+jtMZjCKFZKyLe3Z9ODS8J7kbK0t+bZ8nxgFtZkyZYfFVVG26yLJuXluLE
         015K1Mbq3hu1IQn6KCVbb1asEjm82vPJ6Hz1CIKxm3y//ZzNiZalW+qNwHaVQZtx4BSH
         6MpNCF3Qig6+kDgjp8ntboAgVR+tF868jJ35g3aiWoPAItMzIeVvQgN10L4tA5WMdiUG
         qefw==
X-Gm-Message-State: AOAM531QpaSIKvaF59ChvJPUJO414MywsHYwvxxxpJ44hYOSPvAvR7sV
        NQCluWhqQ3qCmdeHjeoMX1o8t8OHN7SW3w==
X-Google-Smtp-Source: ABdhPJyWKNe3rKNuaPfIwj4ZWoycKgk939N7IuqQqUSnRr8uP00q4tO40J3wFiEKe2wbwU4JCPuk9Q==
X-Received: by 2002:a05:620a:1903:b0:67d:243b:a8ae with SMTP id bj3-20020a05620a190300b0067d243ba8aemr21149211qkb.142.1652324711253;
        Wed, 11 May 2022 20:05:11 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2270334qkc.52.2022.05.11.20.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:05:10 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v1 12/14] rcu/kfree: remove useless monitor_todo flag
Date:   Thu, 12 May 2022 03:04:40 +0000
Message-Id: <20220512030442.2530552-13-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220512030442.2530552-1-joel@joelfernandes.org>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

monitor_todo is not needed as the work struct already tracks if work is
pending. Just use that to know if work is pending using
delayed_work_pending() helper.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3baf29014f86..3828ac3bf1c4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3155,7 +3155,6 @@ struct kfree_rcu_cpu_work {
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
- * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
  * @initialized: The @rcu_work fields have been initialized
  * @count: Number of objects for which GP not started
  * @bkvcache:
@@ -3180,7 +3179,6 @@ struct kfree_rcu_cpu {
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
-	bool monitor_todo;
 	bool initialized;
 	int count;
 
@@ -3416,9 +3414,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	// of the channels that is still busy we should rearm the
 	// work to repeat an attempt. Because previous batches are
 	// still in progress.
-	if (!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head)
-		krcp->monitor_todo = false;
-	else
+	if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head)
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
@@ -3607,10 +3603,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
-	    !krcp->monitor_todo) {
-		krcp->monitor_todo = true;
+	    !delayed_work_pending(&krcp->monitor_work))
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
-	}
 
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
@@ -3685,14 +3679,12 @@ void __init kfree_rcu_scheduler_running(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
-		if ((!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head) ||
-				krcp->monitor_todo) {
-			raw_spin_unlock_irqrestore(&krcp->lock, flags);
-			continue;
+		if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head) {
+			if (delayed_work_pending(&krcp->monitor_work)) {
+				schedule_delayed_work_on(cpu, &krcp->monitor_work,
+						KFREE_DRAIN_JIFFIES);
+			}
 		}
-		krcp->monitor_todo = true;
-		schedule_delayed_work_on(cpu, &krcp->monitor_work,
-					 KFREE_DRAIN_JIFFIES);
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 	}
 }
-- 
2.36.0.550.gb090851708-goog

