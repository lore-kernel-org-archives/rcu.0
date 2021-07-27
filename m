Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5F6C432BE
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 07:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBAA611C7
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 07:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbhG0Hpz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jul 2021 03:45:55 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:45384 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235675AbhG0Hpz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jul 2021 03:45:55 -0400
X-UUID: 87635f62e5434238bf905967941fe625-20210727
X-UUID: 87635f62e5434238bf905967941fe625-20210727
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <cheng-jui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 297846516; Tue, 27 Jul 2021 15:45:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Jul 2021 15:45:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Jul 2021 15:45:49 +0800
From:   Cheng Jui Wang <cheng-jui.wang@mediatek.com>
To:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <clang-built-linux@googlegroups.com>
CC:     <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <matthias.bgg@gmail.com>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <wsd_upstream@mediatek.com>,
        <eason-yh.lin@mediatek.com>,
        Cheng Jui Wang <cheng-jui.wang@mediatek.com>
Subject: [PATCH] rcu: Add missing unlock in rcu_print_task_stall
Date:   Tue, 27 Jul 2021 15:45:42 +0800
Message-ID: <20210727074542.25095-1-cheng-jui.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

We encouterd a deadlock with following lockdep warning. The
rcu_print_task_stall is supposed to release rnp->lock, but may just
return without unlock.

	if (!rcu_preempt_blocked_readers_cgp(rnp))
		return 0;

Add missing unlock before return to fix it.

============================================
WARNING: possible recursive locking detected
5.10.43
--------------------------------------------
swapper/7/0 is trying to acquire lock:
ffffffc01268c018 (rcu_node_0){-.-.}-{2:2}, at: rcu_dump_cpu_stacks+0x94/0x138

but task is already holding lock:
ffffffc01268c018 (rcu_node_0){-.-.}-{2:2}, at: check_cpu_stall+0x34c/0x6f8

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(rcu_node_0);
  lock(rcu_node_0);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by swapper/7/0:
 #0: ffffffc01268c018 (rcu_node_0){-.-.}-{2:2},  at: check_cpu_stall+0x34c/0x6f8

stack backtrace:
CPU: 7 PID: 0 Comm: swapper/7
Call trace:
 dump_backtrace.cfi_jt+0x0/0x8
 show_stack+0x1c/0x2c
 dump_stack_lvl+0xd8/0x16c
 validate_chain+0x2124/0x2d34
 __lock_acquire+0x7e4/0xed4
 lock_acquire+0x114/0x394
 _raw_spin_lock_irqsave+0x88/0xd4
 rcu_dump_cpu_stacks+0x94/0x138
 check_cpu_stall+0x498/0x6f8
 rcu_sched_clock_irq+0xd4/0x214
 update_process_times+0xb4/0xf4
 tick_sched_timer+0x98/0x110
 __hrtimer_run_queues+0x19c/0x2bc
 hrtimer_interrupt+0x10c/0x3a8
 arch_timer_handler_phys+0x5c/0x98
 handle_percpu_devid_irq+0xe0/0x2a8
 __handle_domain_irq+0xd0/0x19c
 gic_handle_irq+0x6c/0x134
 el1_irq+0xe0/0x1c0
 arch_cpu_idle+0x1c/0x30
 default_idle_call+0x58/0xcc
 do_idle.llvm.13807299673429836468+0x118/0x2e8
 cpu_startup_entry+0x28/0x2c
 secondary_start_kernel+0x1d0/0x23c

Signed-off-by: Cheng Jui Wang <cheng-jui.wang@mediatek.com>
---
 kernel/rcu/tree_stall.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 6c76988cc019..3dc464d4d9a5 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -267,8 +267,10 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	struct task_struct *ts[8];
 
 	lockdep_assert_irqs_disabled();
-	if (!rcu_preempt_blocked_readers_cgp(rnp))
+	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return 0;
+	}
 	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
 	       rnp->level, rnp->grplo, rnp->grphi);
 	t = list_entry(rnp->gp_tasks->prev,
-- 
2.18.0

