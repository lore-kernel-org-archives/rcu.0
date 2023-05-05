Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5D9C7EE26
	for <rcu@archiver.kernel.org>; Fri,  5 May 2023 11:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjEELYt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 5 May 2023 07:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjEELYl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 5 May 2023 07:24:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916191A62E;
        Fri,  5 May 2023 04:24:36 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QCSty42qczLpCd;
        Fri,  5 May 2023 19:21:46 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 5 May
 2023 19:24:33 +0800
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
Subject: [PATCH 9/9] softirq, timer: Use softirq_needs_break()
Date:   Fri, 5 May 2023 19:33:15 +0800
Message-ID: <20230505113315.3307723-10-liujian56@huawei.com>
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

In the while loop of __run_timers(), because there are too many timers or
improper timer handler functions, if the processing time of the expired
timers is always greater than the time wheel's next_expiry, the function
will loop infinitely.

To prevent this, use the timeout/break logic provided by SoftIRQs. If the
running time exceeds the limit, break the loop and an additional
TIMER_SOFTIRQ is triggered.

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 kernel/time/timer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..70744a469a39 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1992,7 +1992,7 @@ void timer_clear_idle(void)
  * __run_timers - run all expired timers (if any) on this CPU.
  * @base: the timer vector to be processed.
  */
-static inline void __run_timers(struct timer_base *base)
+static inline void __run_timers(struct timer_base *base, struct softirq_action *h)
 {
 	struct hlist_head heads[LVL_DEPTH];
 	int levels;
@@ -2020,6 +2020,12 @@ static inline void __run_timers(struct timer_base *base)
 
 		while (levels--)
 			expire_timers(base, heads + levels);
+
+		if (softirq_needs_break(h)) {
+			if (time_after_eq(jiffies, base->next_expiry))
+				__raise_softirq_irqoff(TIMER_SOFTIRQ);
+			break;
+		}
 	}
 	raw_spin_unlock_irq(&base->lock);
 	timer_base_unlock_expiry(base);
@@ -2032,9 +2038,9 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
-	__run_timers(base);
+	__run_timers(base, h);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
-		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]), h);
 }
 
 /*
-- 
2.34.1

