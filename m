Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61670C77B7F
	for <rcu@archiver.kernel.org>; Fri,  5 May 2023 11:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjEELYd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 5 May 2023 07:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjEELYc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 5 May 2023 07:24:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F03F1A498;
        Fri,  5 May 2023 04:24:31 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QCSrt3jlczTjxM;
        Fri,  5 May 2023 19:19:58 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 5 May
 2023 19:24:28 +0800
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
Subject: [PATCH 4/9] softirq: Allow early break
Date:   Fri, 5 May 2023 19:33:10 +0800
Message-ID: <20230505113315.3307723-5-liujian56@huawei.com>
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

Allow terminating the softirq processing loop without finishing the
vectors.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 kernel/softirq.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 48a81d8ae49a..e2cad5d108c8 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -582,6 +582,9 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 			       prev_count, preempt_count());
 			preempt_count_set(prev_count);
 		}
+
+		if (pending && __softirq_needs_break(start))
+			break;
 	}
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
@@ -590,13 +593,14 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	local_irq_disable();
 
-	pending = local_softirq_pending();
-	if (pending) {
-		if (!__softirq_needs_break(start) && --max_restart)
-			goto restart;
+	if (pending)
+		or_softirq_pending(pending);
+	else if ((pending = local_softirq_pending()) &&
+		 !__softirq_needs_break(start) &&
+		 --max_restart)
+		goto restart;
 
-		wakeup_softirqd();
-	}
+	wakeup_softirqd();
 
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-- 
2.34.1

