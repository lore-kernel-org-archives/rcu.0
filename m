Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BB2C4363A
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F38214DB
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tI/D15KA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgJ2Qvi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgJ2Quk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C4DC0613D6;
        Thu, 29 Oct 2020 09:50:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d25so3812779ljc.11;
        Thu, 29 Oct 2020 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmEwRfNnZdS9anl7yW2D/JU4OlvavdxGws91ruK0yPI=;
        b=tI/D15KA4CVN/hRZpgwLxVhnD+kMtLUyIWS5sraP6dSgmMwoGW0uTxdemH61ZgXHna
         4iNTNQ/XPrfIb0jT//FVv53oqYK+KcjAxpcrKZw/wv+ncDKuNJbIuSMV9VaGTlr4jyMn
         5Ir308Kk5eKaU+6idpJLo7RsIPY/CO6amt502P+u2o1q4wsGBgN4VEKK6kfqdqF4ZkFa
         Wi9E0hvxij/rvaauOv5dBKK2tUCQkzPVvr1Z+bC6+sZUeYM4B3IuIe4aOBFiI/eHL3Gq
         /yhnyC9MBOSahBq2EB3jKBkP+Ephw+dlD7iWr5tC910pAWqL7+Zhe/JXpS180aP+5xy+
         KKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmEwRfNnZdS9anl7yW2D/JU4OlvavdxGws91ruK0yPI=;
        b=kWIRSGlEewWWBNwR+UAkL3C9MsH/qIRla+S9cl5vsuQ5cIqpRwc4m7Wo4GMCfDlKpz
         1hfG337aDvGPOAzILgfKYMqKgfI2xi9G3tyerOzcmUCNWvztNw5m5+NGx7LW0tKde34c
         BxL8lcpoGYeRzL99doORT+jWSO4a+Wi5LxoFqyMlpRljpLuKs8+4eaSOWapG25X2tKKJ
         E1unUB7XSoFkLwVVR+t5n5SB0GD07zXmUBlDsHR934qf65Bgs6Y2mi1alx9LuP2fUItC
         KJi0nni5toC9H0OOASPh2qh9PPLt/iDZM6RRdOY67dM8nt+rGi3isGWkCgG6bXGDpsG0
         dStg==
X-Gm-Message-State: AOAM533mBfAx8W2+Y6PZR2InYJeSMQgLnt0MuWQ4H6Qt38+cqL0jvZT+
        rmhQo7d95OYcuJDdc3k/mWBGGXcvzwWz9g==
X-Google-Smtp-Source: ABdhPJyo+jxb1d2Ojke/8fw45gmNXsvmhgdx2P9lDKSODTsq7q1JONbfxDXTA6fRKBacLgvXusA6VQ==
X-Received: by 2002:a2e:2202:: with SMTP id i2mr2112758lji.70.1603990237694;
        Thu, 29 Oct 2020 09:50:37 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:37 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 04/16] preempt: Cleanup PREEMPT_COUNT leftovers
Date:   Thu, 29 Oct 2020 17:50:07 +0100
Message-Id: <20201029165019.14218-4-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201029165019.14218-1-urezki@gmail.com>
References: <20201029165019.14218-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/preempt.h | 37 ++++---------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7d9c1c0e149c..513769b1edf8 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -56,8 +56,7 @@
 #define PREEMPT_DISABLED	(PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
 
 /*
- * Disable preemption until the scheduler is running -- use an unconditional
- * value so that it also works on !PREEMPT_COUNT kernels.
+ * Disable preemption until the scheduler is running.
  *
  * Reset by start_kernel()->sched_init()->init_idle()->init_idle_preempt_count().
  */
@@ -69,7 +68,6 @@
  *
  *    preempt_count() == 2*PREEMPT_DISABLE_OFFSET
  *
- * Note: PREEMPT_DISABLE_OFFSET is 0 for !PREEMPT_COUNT kernels.
  * Note: See finish_task_switch().
  */
 #define FORK_PREEMPT_COUNT	(2*PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
@@ -106,11 +104,7 @@
 /*
  * The preempt_count offset after preempt_disable();
  */
-#if defined(CONFIG_PREEMPT_COUNT)
-# define PREEMPT_DISABLE_OFFSET	PREEMPT_OFFSET
-#else
-# define PREEMPT_DISABLE_OFFSET	0
-#endif
+#define PREEMPT_DISABLE_OFFSET	PREEMPT_OFFSET
 
 /*
  * The preempt_count offset after spin_lock()
@@ -122,8 +116,8 @@
  *
  *  spin_lock_bh()
  *
- * Which need to disable both preemption (CONFIG_PREEMPT_COUNT) and
- * softirqs, such that unlock sequences of:
+ * Which need to disable both preemption and softirqs, such that unlock
+ * sequences of:
  *
  *  spin_unlock();
  *  local_bh_enable();
@@ -164,8 +158,6 @@ extern void preempt_count_sub(int val);
 #define preempt_count_inc() preempt_count_add(1)
 #define preempt_count_dec() preempt_count_sub(1)
 
-#ifdef CONFIG_PREEMPT_COUNT
-
 #define preempt_disable() \
 do { \
 	preempt_count_inc(); \
@@ -231,27 +223,6 @@ do { \
 	__preempt_count_dec(); \
 } while (0)
 
-#else /* !CONFIG_PREEMPT_COUNT */
-
-/*
- * Even if we don't have any preemption, we need preempt disable/enable
- * to be barriers, so that we don't have things like get_user/put_user
- * that can cause faults and scheduling migrate into our preempt-protected
- * region.
- */
-#define preempt_disable()			barrier()
-#define sched_preempt_enable_no_resched()	barrier()
-#define preempt_enable_no_resched()		barrier()
-#define preempt_enable()			barrier()
-#define preempt_check_resched()			do { } while (0)
-
-#define preempt_disable_notrace()		barrier()
-#define preempt_enable_no_resched_notrace()	barrier()
-#define preempt_enable_notrace()		barrier()
-#define preemptible()				0
-
-#endif /* CONFIG_PREEMPT_COUNT */
-
 #ifdef MODULE
 /*
  * Modules have no business playing preemption tricks.
-- 
2.20.1

