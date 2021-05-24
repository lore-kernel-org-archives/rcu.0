Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3782C04FF3
	for <rcu@archiver.kernel.org>; Mon, 24 May 2021 08:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B53611CE
	for <rcu@archiver.kernel.org>; Mon, 24 May 2021 08:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhEXI6s (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 May 2021 04:58:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5528 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhEXI6r (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 May 2021 04:58:47 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpWH81gPDzkY1t;
        Mon, 24 May 2021 16:54:28 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 16:57:18 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 16:57:17 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] rcu: fix spelling mistakes
Date:   Mon, 24 May 2021 16:54:11 +0800
Message-ID: <20210524085411.8783-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210524085411.8783-1-thunder.leizhen@huawei.com>
References: <20210524085411.8783-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Fix some spelling mistakes in comments:
data-strcuture ==> data-structure
responsibilty ==> responsibility
interrrupts ==> interrupts

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/rcu/tasks.h | 6 +++---
 kernel/rcu/tree.c  | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 350ebf5051f9..311aa7b14830 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -504,7 +504,7 @@ DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
  * or transition to usermode execution.  As such, there are no read-side
  * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
  * this primitive is intended to determine that all tasks have passed
- * through a safe state, not so much for data-strcuture synchronization.
+ * through a safe state, not so much for data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
@@ -637,7 +637,7 @@ DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
  * there are no read-side primitives analogous to rcu_read_lock() and
  * rcu_read_unlock() because this primitive is intended to determine
  * that all tasks have passed through a safe state, not so much for
- * data-strcuture synchronization.
+ * data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
@@ -1163,7 +1163,7 @@ static void exit_tasks_rcu_finish_trace(struct task_struct *t)
  * there are no read-side primitives analogous to rcu_read_lock() and
  * rcu_read_unlock() because this primitive is intended to determine
  * that all tasks have passed through a safe state, not so much for
- * data-strcuture synchronization.
+ * data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e78b2430c16..c32891763955 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3848,7 +3848,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
  *
  * If a full RCU grace period has elapsed since the earlier call from
  * which oldstate was obtained, return @true, otherwise return @false.
- * If @false is returned, it is the caller's responsibilty to invoke this
+ * If @false is returned, it is the caller's responsibility to invoke this
  * function later on until it does return @true.  Alternatively, the caller
  * can explicitly wait for a grace period, for example, by passing @oldstate
  * to cond_synchronize_rcu() or by directly invoking synchronize_rcu().
@@ -4094,7 +4094,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier);
 /*
  * Propagate ->qsinitmask bits up the rcu_node tree to account for the
  * first CPU in a given leaf rcu_node structure coming online.  The caller
- * must hold the corresponding leaf rcu_node ->lock with interrrupts
+ * must hold the corresponding leaf rcu_node ->lock with interrupts
  * disabled.
  */
 static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
-- 
2.25.1


