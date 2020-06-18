Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DFAC433E1
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D81206D7
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="W3VDq+m3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgFRUaQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbgFRUaL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 16:30:11 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD25C061796
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 13:30:10 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q2so6957794qkb.2
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTcBLAYXV1mQv30WKNwQeGVM54AorwT8x0vvBfoVBt4=;
        b=W3VDq+m3U9sl+nkLQVzDBj1FJvGteF3MCwrC/vpIWVJt1dJ9TTzu/y9/0IWlCWFaIy
         mlKjCH/WVmzAXtr/2nU0IWANYpKXL2HwKQuZBQ9DQZnl1NN3d0+CWesspUMKWagUfdmU
         PwPqjddPip40GKmxjrE39LcUuqqL7J4Tw8l08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTcBLAYXV1mQv30WKNwQeGVM54AorwT8x0vvBfoVBt4=;
        b=JGB/4tAOFA/50AEFcJay/jojbZf1mvn/Qh1KrVRETpQB71ibzpNW14kRu6VHHXOk2q
         h3/NrkXqBCz2YZCizGzm69gq0AgL7/vFQwg69XEpJgZBwQzRPlr4cRtxsSHExzEH0bEA
         dw5uu35Y5XkRWUKlMK2iMkVbDY9Qcn3hK5osLc1AGfSH8gDAFy01y9VuPAOQ2gFsiQ5l
         qUWphsXU02/OD/G2WzFkb/qMMViXbY0FKTKk7bmcbhUS9ONkwgfP0couTH+Hi197zeUL
         3PVT9pBgBCBKu8vV83h6HRxveX4wGkE7Gadqjq3jTzRYeLENvoAKHxn3uMLh4x4ilx+N
         +n5A==
X-Gm-Message-State: AOAM533M8Lzxe39fT6Xhz59vf/qRG78y62eVImXh4PX2lNTcWs5Oeu9E
        //4F40yv4ecylbXoNCfzQhzSLFZKaw4=
X-Google-Smtp-Source: ABdhPJzk/UpqhK9CJMV2D48jHJzfTKxZ3OnjfyQQRxXrVWC1G9hioqx+84NwFD6UumlC6IfUrSJduQ==
X-Received: by 2002:a37:7803:: with SMTP id t3mr233909qkc.358.1592512209457;
        Thu, 18 Jun 2020 13:30:09 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v3sm4027503qkh.130.2020.06.18.13.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:30:09 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 6/7] rcutorture: Add support to get the number of wakeups of main GP kthread
Date:   Thu, 18 Jun 2020 16:29:54 -0400
Message-Id: <20200618202955.4024-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200618202955.4024-1-joel@joelfernandes.org>
References: <20200618202955.4024-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is useful to check for any improvements or degradation related to
number of GP kthread wakeups during testing.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/Kconfig.debug |  1 +
 kernel/rcu/rcu.h         |  2 ++
 kernel/rcu/rcutorture.c  | 23 ++++++++++++++++++++++-
 kernel/rcu/tree.c        |  7 +++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 3cf6132a4bb9f..3323e3378af5a 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -50,6 +50,7 @@ config RCU_TORTURE_TEST
 	select TASKS_RCU
 	select TASKS_RUDE_RCU
 	select TASKS_TRACE_RCU
+	select SCHEDSTATS
 	default n
 	help
 	  This option provides a kernel module that runs torture tests
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index cf66a3ccd7573..7e867e81d9738 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -511,6 +511,7 @@ srcu_batches_completed(struct srcu_struct *sp) { return 0; }
 static inline void rcu_force_quiescent_state(void) { }
 static inline void show_rcu_gp_kthreads(void) { }
 static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
+static inline struct task_struct *rcu_get_main_gp_kthread(void) { return 0; }
 static inline void rcu_fwd_progress_check(unsigned long j) { }
 #else /* #ifdef CONFIG_TINY_RCU */
 bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
@@ -519,6 +520,7 @@ unsigned long rcu_exp_batches_completed(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
 void show_rcu_gp_kthreads(void);
 int rcu_get_gp_kthreads_prio(void);
+struct task_struct *rcu_get_main_gp_kthread(void);
 void rcu_fwd_progress_check(unsigned long j);
 void rcu_force_quiescent_state(void);
 extern struct workqueue_struct *rcu_gp_wq;
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d0d265304d147..959a1f84d6904 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -23,6 +23,7 @@
 #include <linux/rcupdate_wait.h>
 #include <linux/interrupt.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/stat.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
@@ -460,9 +461,29 @@ static void rcu_sync_torture_init(void)
 	INIT_LIST_HEAD(&rcu_torture_removed);
 }
 
+unsigned long rcu_gp_nr_wakeups;
+
+static void rcu_flavor_init(void)
+{
+	rcu_sync_torture_init();
+
+	/* Make sure schedstat is enabled for GP thread wakeup count. */
+	force_schedstat_enabled();
+	rcu_gp_nr_wakeups = rcu_get_main_gp_kthread()->se.statistics.nr_wakeups;
+}
+
+static void rcu_flavor_cleanup(void)
+{
+	unsigned long now_nr = rcu_get_main_gp_kthread()->se.statistics.nr_wakeups;
+
+	pr_alert("End-test: Cleanup: Total GP-kthread wakeups: %lu\n",
+		now_nr - rcu_gp_nr_wakeups);
+}
+
 static struct rcu_torture_ops rcu_ops = {
 	.ttype		= RCU_FLAVOR,
-	.init		= rcu_sync_torture_init,
+	.init		= rcu_flavor_init,
+	.cleanup	= rcu_flavor_cleanup,
 	.readlock	= rcu_torture_read_lock,
 	.read_delay	= rcu_read_delay,
 	.readunlock	= rcu_torture_read_unlock,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c3bae7a83d792..a3a175feb310a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -175,6 +175,13 @@ int rcu_get_gp_kthreads_prio(void)
 }
 EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
 
+/* Retrieve RCU's main GP kthread task_struct */
+struct task_struct *rcu_get_main_gp_kthread(void)
+{
+	return rcu_state.gp_kthread;
+}
+EXPORT_SYMBOL_GPL(rcu_get_main_gp_kthread);
+
 /*
  * Number of grace periods between delays, normalized by the duration of
  * the delay.  The longer the delay, the more the grace periods between
-- 
2.27.0.111.gc72c7da667-goog

