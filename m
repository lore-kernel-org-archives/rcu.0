Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F11C7EE2C
	for <rcu@archiver.kernel.org>; Fri,  5 May 2023 11:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjEELYb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 5 May 2023 07:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjEELYa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 5 May 2023 07:24:30 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E281A124;
        Fri,  5 May 2023 04:24:29 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QCSwk4v4PzpW4T;
        Fri,  5 May 2023 19:23:18 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 5 May
 2023 19:24:25 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <corbet@lwn.net>, <paulmck@kernel.org>, <frederic@kernel.org>,
        <quic_neeraju@quicinc.com>, <joel@joelfernandes.org>,
        <josh@joshtriplett.org>, <boqun.feng@gmail.com>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <qiang1.zhang@intel.com>,
        <jstultz@google.com>, <tglx@linutronix.de>, <sboyd@kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <peterz@infradead.org>, <frankwoo@google.com>,
        <Rhinewuwu@google.com>
CC:     <liujian56@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH 2/9] softirq: Use sched_clock() based timeout
Date:   Fri, 5 May 2023 19:33:08 +0800
Message-ID: <20230505113315.3307723-3-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505113315.3307723-1-liujian56@huawei.com>
References: <20230505113315.3307723-1-liujian56@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Replace the jiffies based timeout with a sched_clock() based one.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 kernel/softirq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index bff5debf6ce6..59f16a9af5d1 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -27,6 +27,7 @@
 #include <linux/tick.h>
 #include <linux/irq.h>
 #include <linux/wait_bit.h>
+#include <linux/sched/clock.h>
 
 #include <asm/softirq_stack.h>
 
@@ -489,7 +490,7 @@ asmlinkage __visible void do_softirq(void)
  * we want to handle softirqs as soon as possible, but they
  * should not be able to lock up the box.
  */
-#define MAX_SOFTIRQ_TIME  msecs_to_jiffies(2)
+#define MAX_SOFTIRQ_TIME	(2 * NSEC_PER_MSEC)
 #define MAX_SOFTIRQ_RESTART 10
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -527,9 +528,9 @@ static inline void lockdep_softirq_end(bool in_hardirq) { }
 
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
-	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
+	u64 start = sched_clock();
 	struct softirq_action *h;
 	unsigned long pending;
 	unsigned int vec_nr;
@@ -584,7 +585,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	pending = local_softirq_pending();
 	if (pending) {
-		if (time_before(jiffies, end) && !need_resched() &&
+		if (sched_clock() - start < MAX_SOFTIRQ_TIME && !need_resched() &&
 		    --max_restart)
 			goto restart;
 
-- 
2.34.1

