Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DB8C7EE23
	for <rcu@archiver.kernel.org>; Fri,  5 May 2023 11:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjEELYe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 5 May 2023 07:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjEELYd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 5 May 2023 07:24:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5031A12A;
        Fri,  5 May 2023 04:24:32 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QCStt1LK8zLpDg;
        Fri,  5 May 2023 19:21:42 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 5 May
 2023 19:24:29 +0800
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
Subject: [PATCH 5/9] softirq: Context aware timeout
Date:   Fri, 5 May 2023 19:33:11 +0800
Message-ID: <20230505113315.3307723-6-liujian56@huawei.com>
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

Reduce the softirq timeout when it is preempting an RT task.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 kernel/softirq.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index e2cad5d108c8..baa08ae1604f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -522,12 +522,12 @@ static inline void lockdep_softirq_end(bool in_hardirq) { }
 #define MAX_SOFTIRQ_TIME	(2 * NSEC_PER_MSEC)
 #define MAX_SOFTIRQ_RESTART	10
 
-static inline bool __softirq_needs_break(u64 start)
+static inline bool __softirq_needs_break(u64 start, u64 timo)
 {
 	if (need_resched())
 		return true;
 
-	if (sched_clock() - start >= MAX_SOFTIRQ_TIME)
+	if (sched_clock() - start >= timo)
 		return true;
 
 	return false;
@@ -537,6 +537,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
 	unsigned int max_restart = MAX_SOFTIRQ_RESTART;
 	unsigned long old_flags = current->flags;
+	u64 timo = MAX_SOFTIRQ_TIME;
 	u64 start = sched_clock();
 	struct softirq_action *h;
 	unsigned long pending;
@@ -556,6 +557,9 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	in_hardirq = lockdep_softirq_start();
 	account_softirq_enter(current);
 
+	if (__this_cpu_read(ksoftirqd) != current && task_is_realtime(current))
+		timo >>= 2;
+
 restart:
 	/* Reset the pending bitmask before enabling irqs */
 	set_softirq_pending(0);
@@ -583,7 +587,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 			preempt_count_set(prev_count);
 		}
 
-		if (pending && __softirq_needs_break(start))
+		if (pending && __softirq_needs_break(start, timo))
 			break;
 	}
 
@@ -596,7 +600,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	if (pending)
 		or_softirq_pending(pending);
 	else if ((pending = local_softirq_pending()) &&
-		 !__softirq_needs_break(start) &&
+		 !__softirq_needs_break(start, timo) &&
 		 --max_restart)
 		goto restart;
 
-- 
2.34.1

