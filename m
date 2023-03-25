Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0868C76196
	for <rcu@archiver.kernel.org>; Sat, 25 Mar 2023 17:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCYReV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 25 Mar 2023 13:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjCYReK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:10 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CE5EC6E
        for <rcu@vger.kernel.org>; Sat, 25 Mar 2023 10:34:05 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c19so4481216qtn.13
        for <rcu@vger.kernel.org>; Sat, 25 Mar 2023 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDgsb2d+hZmc+VQbS7ffR7EbpJzTOYghTZrLGYmTtWc=;
        b=jhaF7jMZ0YB7rLiRDFZrRklRXt1OS7zPKXAlOrC6Ofk00510pCD4FnDFVqfLxhpUjD
         BgjbV9/qa/zMtSEVZ9i8O8NwPGlXueA5d8pnRbjRaOifUjtUqVzrrbg4wXpX7QQON0Ga
         h2cXsbZfUrcDoLDyKLO+AqiHanYO7hZFWtMyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDgsb2d+hZmc+VQbS7ffR7EbpJzTOYghTZrLGYmTtWc=;
        b=kGmXtgoEhSA7+M7xzwz0HCRkhJOEk+7G6EPo4SLSI1RMNIRn+3f/PacYhVHrVhihM1
         sRgm1wkj6W/SZ/oiIFI+UMa4jH74EXgbcuneN4HED5V5dsE0Tb3iduCBtD+bENOoZNK9
         0ZqLdCupTbr+7VF+Z5Xc9YqPI8++2+0JRo5i78ojyUw3VGzUrf0ZkOZEPaaRhuRx+kvJ
         GIY0/yu2bXnRnY4m2K0GSifgfQHNFOPoLqH+iGHrdtcOzshd8J26+KusBq3rpcZQ10n5
         WQuGoSX0GC9Ip0iBmxrlk71zycFsbF4j+pnnag+ocRv1DoqtPJcmxrdF0kXLfKLW5K6u
         FtyQ==
X-Gm-Message-State: AO0yUKU621newZ04iYd6GLUXbSHOLy0YcRWGZ9ElQLdkEAnHnS3f1MCF
        aqyFxoyiVmrFW8RfFppwM1slHKMx0JPZbI+YKok=
X-Google-Smtp-Source: AKy350ZKIT2t3gxR4Zylf8zYlF3puKJt9xTfHezSW7rx/lBHNOBE+j7Z/Q9dY0lrU51bFaQa0S0IRA==
X-Received: by 2002:ac8:5755:0:b0:3e1:7465:91f5 with SMTP id 21-20020ac85755000000b003e1746591f5mr12423604qtx.10.1679765644872;
        Sat, 25 Mar 2023 10:34:04 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:34:04 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Cc:     Mark Brown <broonie@kernel.org>, rcu@vger.kernel.org
Subject: [PATCH v2 11/13] rcu-tasks: Report stalls during synchronize_srcu() in rcu_tasks_postscan()
Date:   Sat, 25 Mar 2023 17:33:14 +0000
Message-Id: <20230325173316.3118674-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230325173316.3118674-1-joel@joelfernandes.org>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Neeraj Upadhyay <quic_neeraju@quicinc.com>

The call to synchronize_srcu() from rcu_tasks_postscan() can be stalled
by a task getting stuck in do_exit() between that function's calls to
exit_tasks_rcu_start() and exit_tasks_rcu_finish().   To ease diagnosis
of this situation, print a stall warning message every rcu_task_stall_info
period when rcu_tasks_postscan() is stalled.

[ paulmck: Adjust to handle CONFIG_SMP=n. ]

Reported-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/rcu/20230111212736.GA1062057@paulmck-ThinkPad-P17-Gen-1/
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tasks.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bfb5e1549f2b..baf7ec178155 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -139,6 +139,12 @@ static struct rcu_tasks rt_name =							\
 /* Track exiting tasks in order to allow them to be waited for. */
 DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 
+#ifdef CONFIG_TASKS_RCU
+/* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
+static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
+static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);
+#endif
+
 /* Avoid IPIing CPUs early in the grace period. */
 #define RCU_TASK_IPI_DELAY (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) ? HZ / 2 : 0)
 static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
@@ -830,6 +836,13 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 /* Processing between scanning taskslist and draining the holdout list. */
 static void rcu_tasks_postscan(struct list_head *hop)
 {
+	int rtsi = READ_ONCE(rcu_task_stall_info);
+
+	if (!IS_ENABLED(CONFIG_TINY_RCU)) {
+		tasks_rcu_exit_srcu_stall_timer.expires = jiffies + rtsi;
+		add_timer(&tasks_rcu_exit_srcu_stall_timer);
+	}
+
 	/*
 	 * Exiting tasks may escape the tasklist scan. Those are vulnerable
 	 * until their final schedule() with TASK_DEAD state. To cope with
@@ -848,6 +861,9 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	 * call to synchronize_rcu().
 	 */
 	synchronize_srcu(&tasks_rcu_exit_srcu);
+
+	if (!IS_ENABLED(CONFIG_TINY_RCU))
+		del_timer_sync(&tasks_rcu_exit_srcu_stall_timer);
 }
 
 /* See if tasks are still holding out, complain if so. */
@@ -923,6 +939,21 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
 
+static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
+{
+#ifndef CONFIG_TINY_RCU
+	int rtsi;
+
+	rtsi = READ_ONCE(rcu_task_stall_info);
+	pr_info("%s: %s grace period number %lu (since boot) gp_state: %s is %lu jiffies old.\n",
+		__func__, rcu_tasks.kname, rcu_tasks.tasks_gp_seq,
+		tasks_gp_state_getname(&rcu_tasks), jiffies - rcu_tasks.gp_jiffies);
+	pr_info("Please check any exiting tasks stuck between calls to exit_tasks_rcu_start() and exit_tasks_rcu_finish()\n");
+	tasks_rcu_exit_srcu_stall_timer.expires = jiffies + rtsi;
+	add_timer(&tasks_rcu_exit_srcu_stall_timer);
+#endif // #ifndef CONFIG_TINY_RCU
+}
+
 /**
  * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
  * @rhp: structure to be used for queueing the RCU updates.
-- 
2.40.0.348.gf938b09366-goog

