Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D627EC6FA82
	for <rcu@archiver.kernel.org>; Mon, 26 Sep 2022 02:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiIZCCt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 25 Sep 2022 22:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiIZCCt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 25 Sep 2022 22:02:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB97248F2
        for <rcu@vger.kernel.org>; Sun, 25 Sep 2022 19:02:45 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MbQs21FB0zlXR1;
        Mon, 26 Sep 2022 09:58:30 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 10:02:43 +0800
Received: from huawei.com (10.67.175.41) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 10:02:42 +0800
From:   Yipeng Zou <zouyipeng@huawei.com>
To:     <rcu@vger.kernel.org>, <paulmck@kernel.org>, <frederic@kernel.org>,
        <quic_neeraju@quicinc.com>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <rafael.j.wysocki@intel.com>, <peterz@infradead.org>
CC:     <zouyipeng@huawei.com>
Subject: [PATCH] rcu: remove rcu_is_idle_cpu
Date:   Mon, 26 Sep 2022 09:58:27 +0800
Message-ID: <20220926015827.227050-1-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.41]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The commit "x86/cpu: Avoid cpuinfo-induced IPIing of idle CPUs" introduce
this function to identify the current CPU idle state.
But after commit "x86/aperfmperf: Replace arch_freq_get_on_cpu()" we
just use MAX_SAMPLE_AGE to do that, So there is no use of this function.

Fixes: f3eca381bd49 ("x86/aperfmperf: Replace arch_freq_get_on_cpu()")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
---
 include/linux/rcutiny.h | 2 --
 include/linux/rcutree.h | 2 --
 kernel/rcu/tree.c       | 6 ------
 3 files changed, 10 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 9bc025aa79a3..5c271bf3a1e7 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -146,8 +146,6 @@ static inline void rcu_virt_note_context_switch(void) { }
 static inline void rcu_cpu_stall_reset(void) { }
 static inline int rcu_jiffies_till_stall_check(void) { return 21 * HZ; }
 static inline void rcu_irq_exit_check_preempt(void) { }
-#define rcu_is_idle_cpu(cpu) \
-	(is_idle_task(current) && !in_nmi() && !in_hardirq() && !in_serving_softirq())
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 70795386b9ff..4003bf6cfa1c 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -87,8 +87,6 @@ bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 void cond_synchronize_rcu(unsigned long oldstate);
 void cond_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 
-bool rcu_is_idle_cpu(int cpu);
-
 #ifdef CONFIG_PROVE_RCU
 void rcu_irq_exit_check_preempt(void);
 #else
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5ec97e3f7468..f6561aa401c0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -301,12 +301,6 @@ static bool rcu_dynticks_in_eqs(int snap)
 	return !(snap & RCU_DYNTICKS_IDX);
 }
 
-/* Return true if the specified CPU is currently idle from an RCU viewpoint.  */
-bool rcu_is_idle_cpu(int cpu)
-{
-	return rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
-}
-
 /*
  * Return true if the CPU corresponding to the specified rcu_data
  * structure has spent some time in an extended quiescent state since
-- 
2.17.1

