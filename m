Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C18C4332F
	for <rcu@archiver.kernel.org>; Fri,  4 Nov 2022 02:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKDCMo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Nov 2022 22:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKDCMn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Nov 2022 22:12:43 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A25D24A;
        Thu,  3 Nov 2022 19:12:41 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N3PFz6LSCzJnT9;
        Fri,  4 Nov 2022 10:09:43 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 10:12:39 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 10:12:38 +0800
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
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 1/4] genirq: Fix the return type of kstat_cpu_irqs_sum()
Date:   Fri, 4 Nov 2022 10:12:20 +0800
Message-ID: <20221104021224.102-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221104021224.102-1-thunder.leizhen@huawei.com>
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
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

The type of member irqs_sum is unsigned long, so kstat_cpu_irqs_sum()
should also return unsigned long. Otherwise, the value maybe truncated.

Fixes: f2c66cd8eedd ("/proc/stat: scalability of irq num per cpu")
Reported-by: Elliott, Robert (Servers) <elliott@hpe.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/kernel_stat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index ddb5a358fd829f4..90e2fdc17d79ff8 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -75,7 +75,7 @@ extern unsigned int kstat_irqs_usr(unsigned int irq);
 /*
  * Number of interrupts per cpu, since bootup
  */
-static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
+static inline unsigned long kstat_cpu_irqs_sum(unsigned int cpu)
 {
 	return kstat_cpu(cpu).irqs_sum;
 }
-- 
2.25.1

