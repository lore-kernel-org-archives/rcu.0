Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CD4C001B0
	for <rcu@archiver.kernel.org>; Wed,  5 Jul 2023 07:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjGEHbw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 5 Jul 2023 03:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjGEHbv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 5 Jul 2023 03:31:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5460197;
        Wed,  5 Jul 2023 00:31:50 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qwrqh0rZdzMqLm;
        Wed,  5 Jul 2023 15:28:32 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 15:31:45 +0800
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
Subject: [PATCH 1/2] rcu: Delete a redundant check in rcu_check_gp_kthread_starvation()
Date:   Wed, 5 Jul 2023 15:30:19 +0800
Message-ID: <20230705073020.2030-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230705073020.2030-1-thunder.leizhen@huawei.com>
References: <20230705073020.2030-1-thunder.leizhen@huawei.com>
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

The above condition "if (gpk)" already ensures that gp_kthread is created,
so the local variable 'cpu' cannot be negative here.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/rcu/tree_stall.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b10b8349bb2a48b..dcfaa3d5db2cbc7 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -537,13 +537,11 @@ static void rcu_check_gp_kthread_starvation(void)
 			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
 			pr_err("RCU grace-period kthread stack dump:\n");
 			sched_show_task(gpk);
-			if (cpu >= 0) {
-				if (cpu_is_offline(cpu)) {
-					pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
-				} else  {
-					pr_err("Stack dump where RCU GP kthread last ran:\n");
-					dump_cpu_task(cpu);
-				}
+			if (cpu_is_offline(cpu)) {
+				pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
+			} else  {
+				pr_err("Stack dump where RCU GP kthread last ran:\n");
+				dump_cpu_task(cpu);
 			}
 			wake_up_process(gpk);
 		}
-- 
2.25.1

