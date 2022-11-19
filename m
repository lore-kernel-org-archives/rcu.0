Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6501AC4332F
	for <rcu@archiver.kernel.org>; Sat, 19 Nov 2022 09:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKSJ0t (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 19 Nov 2022 04:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSJ0s (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 19 Nov 2022 04:26:48 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D96776F1;
        Sat, 19 Nov 2022 01:26:47 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NDp9d4ZPMzFqQj;
        Sat, 19 Nov 2022 17:23:33 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 17:26:45 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 17:26:44 +0800
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
Subject: [PATCH v8 0/6] rcu: Add RCU stall diagnosis information
Date:   Sat, 19 Nov 2022 17:25:02 +0800
Message-ID: <20221119092508.1766-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

v7 --> v8:
1. Change call jiffies64_to_msecs() to call jiffies_to_msecs().
2. Mention that rcupdate.rcu_cpu_stall_cputime overrides
   CONFIG_RCU_CPU_STALL_CPUTIME behaviour in the Kconfig help text.
3. Fix a make htmldocs warning, change "|...|" to ":...:".

v6 --> v7:
1. Use kcpustat_field() to obtain the cputime.
2. Make the output start with "\t" to match other related prints.
3. Aligns the output of the last line of RCU stall.

v5 --> v6:
1. When there are more than two continuous RCU stallings, correctly handle the
   value of the second and subsequent sampling periods. Update comments and
   document.
   Thanks to Elliott, Robert for the test.
2. Change "rcu stall" to "RCU stall".

v4 --> v5:
1. Resolve a git am conflict. No code change.

v3 --> v4:
1. Rename rcu_cpu_stall_deep_debug to rcu_cpu_stall_cputime.

v2 --> v3:
1. Fix the return type of kstat_cpu_irqs_sum()
2. Add Kconfig option CONFIG_RCU_CPU_STALL_DEEP_DEBUG and boot parameter
   rcupdate.rcu_cpu_stall_deep_debug.
3. Add comments and normalize local variable name

v1 --> v2:
1. Fixed a bug in the code. If the rcu stall is detected by another CPU,
   kcpustat_this_cpu cannot be used.
@@ -451,7 +451,7 @@ static void print_cpu_stat_info(int cpu)
        if (r->gp_seq != rdp->gp_seq)
                return;

-       cpustat = kcpustat_this_cpu->cpustat;
+       cpustat = kcpustat_cpu(cpu).cpustat;
2. Move the start point of statistics from rcu_stall_kick_kthreads() to
   rcu_implicit_dynticks_qs(), removing the dependency on irq_work.

v1:
In some extreme cases, such as the I/O pressure test, the CPU usage may
be 100%, causing RCU stall. In this case, the printed information about
current is not useful. Displays the number and usage of hard interrupts,
soft interrupts, and context switches that are generated within half of
the CPU stall timeout, can help us make a general judgment. In other
cases, we can preliminarily determine whether an infinite loop occurs
when local_irq, local_bh or preempt is disabled.

Zhen Lei (6):
  genirq: Fix the return type of kstat_cpu_irqs_sum()
  sched: Add helper kstat_cpu_softirqs_sum()
  sched: Add helper nr_context_switches_cpu()
  rcu: Add RCU stall diagnosis information
  doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
  rcu: Align the output of RCU stall

 Documentation/RCU/stallwarn.rst               | 88 +++++++++++++++++++
 .../admin-guide/kernel-parameters.txt         |  6 ++
 include/linux/kernel_stat.h                   | 14 ++-
 kernel/rcu/Kconfig.debug                      | 13 +++
 kernel/rcu/rcu.h                              |  1 +
 kernel/rcu/tree.c                             | 18 ++++
 kernel/rcu/tree.h                             | 19 ++++
 kernel/rcu/tree_stall.h                       | 35 +++++++-
 kernel/rcu/update.c                           |  2 +
 kernel/sched/core.c                           |  5 ++
 10 files changed, 198 insertions(+), 3 deletions(-)

-- 
2.25.1

