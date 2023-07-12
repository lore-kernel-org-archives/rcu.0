Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8BAEB64D9
	for <rcu@archiver.kernel.org>; Wed, 12 Jul 2023 15:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGLPQU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Jul 2023 11:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjGLPQT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Jul 2023 11:16:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E091BD1;
        Wed, 12 Jul 2023 08:16:17 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R1LqR4nv8zPk5W;
        Wed, 12 Jul 2023 23:13:55 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 23:16:15 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 2/2] rcu: Don't dump the stalled CPU on where RCU GP kthread last ran twice
Date:   Wed, 12 Jul 2023 23:15:57 +0800
Message-ID: <20230712151557.760-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230712151557.760-1-thunder.leizhen@huawei.com>
References: <20230712151557.760-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The stacks of all stalled CPUs will be dumped in rcu_dump_cpu_stacks().
If the CPU on where RCU GP kthread last ran is stalled, its stack does
not need to be dumped again. We can search the corresponding backtrace
based on the printed CPU ID.

For example:
[   87.328275] rcu: rcu_sched kthread starved for ... ->cpu=3  <--------|
... ...                                                                 |
[   89.385007] NMI backtrace for cpu 3                         <--------|
[   89.385179] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.10.0+ #22 <--|
[   89.385188] Hardware name: linux,dummy-virt (DT)
[   89.385196] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[   89.385204] pc : arch_cpu_idle+0x40/0xc0
[   89.385211] lr : arch_cpu_idle+0x2c/0xc0
... ...
[   89.385566] Call trace:
[   89.385574]  arch_cpu_idle+0x40/0xc0
[   89.385581]  default_idle_call+0x100/0x450
[   89.385589]  cpuidle_idle_call+0x2f8/0x460
[   89.385596]  do_idle+0x1dc/0x3d0
[   89.385604]  cpu_startup_entry+0x5c/0xb0
[   89.385613]  secondary_start_kernel+0x35c/0x520

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_stall.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index dcfaa3d5db2cbc7..cc884cd49e026a3 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -534,12 +534,14 @@ static void rcu_check_gp_kthread_starvation(void)
 		       data_race(READ_ONCE(rcu_state.gp_state)),
 		       gpk ? data_race(READ_ONCE(gpk->__state)) : ~0, cpu);
 		if (gpk) {
+			struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
 			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
 			pr_err("RCU grace-period kthread stack dump:\n");
 			sched_show_task(gpk);
 			if (cpu_is_offline(cpu)) {
 				pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
-			} else  {
+			} else if (!(data_race(READ_ONCE(rdp->mynode->qsmask)) & rdp->grpmask)) {
 				pr_err("Stack dump where RCU GP kthread last ran:\n");
 				dump_cpu_task(cpu);
 			}
-- 
2.25.1

