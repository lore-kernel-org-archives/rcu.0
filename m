Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6EBC3A59D
	for <rcu@archiver.kernel.org>; Sat, 22 Oct 2022 12:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJVMqK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 22 Oct 2022 08:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJVMqJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 22 Oct 2022 08:46:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B372FF220;
        Sat, 22 Oct 2022 05:46:08 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mvgx76Dn7zJn4x;
        Sat, 22 Oct 2022 20:43:23 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 20:46:06 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 20:46:05 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/3] sched: Add helper kstat_cpu_softirqs_sum()
Date:   Sat, 22 Oct 2022 20:45:23 +0800
Message-ID: <20221022124525.2080-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221022124525.2080-1-thunder.leizhen@huawei.com>
References: <20221022124525.2080-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Similar to kstat_cpu_irqs_sum(), it counts the sum of all software
interrupts on a specified CPU.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/kernel_stat.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index ddb5a358fd829f4..61d427c1962bf1c 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -67,6 +67,17 @@ static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
        return kstat_cpu(cpu).softirqs[irq];
 }
 
+static inline unsigned int kstat_cpu_softirqs_sum(int cpu)
+{
+	int i;
+	unsigned int sum = 0;
+
+	for (i = 0; i < NR_SOFTIRQS; i++)
+		sum += kstat_softirqs_cpu(i, cpu);
+
+	return sum;
+}
+
 /*
  * Number of interrupts per specific IRQ source, since bootup
  */
-- 
2.25.1

