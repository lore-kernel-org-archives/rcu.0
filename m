Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E14CC77B75
	for <rcu@archiver.kernel.org>; Fri,  5 May 2023 11:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjEELYa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 5 May 2023 07:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjEELY2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 5 May 2023 07:24:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15D51A1C9;
        Fri,  5 May 2023 04:24:27 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QCSvy37N9zsR6B;
        Fri,  5 May 2023 19:22:38 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 5 May
 2023 19:24:24 +0800
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
Subject: [PATCH 1/9] softirq: Rewrite softirq processing loop
Date:   Fri, 5 May 2023 19:33:07 +0800
Message-ID: <20230505113315.3307723-2-liujian56@huawei.com>
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

Simplify the softirq processing loop by using the bitmap APIs

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 kernel/softirq.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 1b725510dd0f..bff5debf6ce6 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -531,9 +531,9 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
+	unsigned long pending;
+	unsigned int vec_nr;
 	bool in_hardirq;
-	__u32 pending;
-	int softirq_bit;
 
 	/*
 	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
@@ -554,15 +554,13 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	local_irq_enable();
 
-	h = softirq_vec;
+	for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS) {
+		unsigned int prev_count;
 
-	while ((softirq_bit = ffs(pending))) {
-		unsigned int vec_nr;
-		int prev_count;
+		__clear_bit(vec_nr, &pending);
 
-		h += softirq_bit - 1;
+		h = softirq_vec + vec_nr;
 
-		vec_nr = h - softirq_vec;
 		prev_count = preempt_count();
 
 		kstat_incr_softirqs_this_cpu(vec_nr);
@@ -576,8 +574,6 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 			       prev_count, preempt_count());
 			preempt_count_set(prev_count);
 		}
-		h++;
-		pending >>= softirq_bit;
 	}
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-- 
2.34.1

