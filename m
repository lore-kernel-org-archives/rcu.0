Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2F9C433FE
	for <rcu@archiver.kernel.org>; Fri,  4 Nov 2022 02:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiKDCMr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Nov 2022 22:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiKDCMp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Nov 2022 22:12:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF172E8;
        Thu,  3 Nov 2022 19:12:42 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N3PKH0YNtzmVcH;
        Fri,  4 Nov 2022 10:12:35 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 10:12:41 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 10:12:40 +0800
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
Subject: [PATCH v4 3/4] sched: Add helper nr_context_switches_cpu()
Date:   Fri, 4 Nov 2022 10:12:22 +0800
Message-ID: <20221104021224.102-4-thunder.leizhen@huawei.com>
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

Returns the number of context switches on the specified CPU, which can be
used to diagnose rcu stall.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/kernel_stat.h | 1 +
 kernel/sched/core.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 898076e173a928a..9935f7ecbfb9e31 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -52,6 +52,7 @@ DECLARE_PER_CPU(struct kernel_cpustat, kernel_cpustat);
 #define kstat_cpu(cpu) per_cpu(kstat, cpu)
 #define kcpustat_cpu(cpu) per_cpu(kernel_cpustat, cpu)
 
+extern unsigned long long nr_context_switches_cpu(int cpu);
 extern unsigned long long nr_context_switches(void);
 
 extern unsigned int kstat_irqs_cpu(unsigned int irq, int cpu);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 06e268c15f14ae4..380c521170d68f3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5234,6 +5234,11 @@ bool single_task_running(void)
 }
 EXPORT_SYMBOL(single_task_running);
 
+unsigned long long nr_context_switches_cpu(int cpu)
+{
+	return cpu_rq(cpu)->nr_switches;
+}
+
 unsigned long long nr_context_switches(void)
 {
 	int i;
-- 
2.25.1

