Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBF330B3A;
	Thu, 18 Dec 2025 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042677; cv=none; b=nwK3+xJqdgl4JoZkKH6m4QGGkupIB7wgToDJhurvvWRA0SDyMiXNXkjLRmDjp1xtquOgM2fmRFstoqiiIXCusEx4jb1i3qT0nZz30zoLbK/Xa5+02cJsKGMyBTRmcg9LTMtujshiLlDr+gAOwCDJkJbav6Q3z/nA3ImDprLfrJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042677; c=relaxed/simple;
	bh=Fxh1yOFuUFw7s9UGMvAQkbDjoO2JSEnKnT5OvJFwIj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D/fcrT+Okm74Et5JIYid3H3/h7i7HTjzOgk4FlPduxyKofLOcn4YOrDS7lQAOV2dJG3Pqc45bx/n1B+P8w0miFnzT02m9ujfNkXXsdCVlCaTkt7dQgYMrvHki8kHmtt6CtdAL9uSXZZyhFku08F0kToMKU60qSpRuFpugIZvI2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JDQ98oIM; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JDQ98oIM"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=s9ueUb7mHMddXtVp6V1CaY7uvr1LADEmgSAEoMucgJ8=;
	b=JDQ98oIMCjJFbP8OjvVSrGu+JvU1Tcm9rZDfTBqTvewhJbpXxHuYhfcgl4c8ftvW66VQp88/n
	UR1UDv2XnzoCtE25OO/oNQzThg3fxnEwwMKJ6+p05pq8moOM5g6c1RE03f4OJaxJ1Seq8TyAeGD
	6BCxsJ5qgCcnPAgDrxpR3rU=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dX2CP38ZKzKm5C;
	Thu, 18 Dec 2025 15:21:21 +0800 (CST)
Received: from dggpemr500006.china.huawei.com (unknown [7.185.36.185])
	by mail.maildlp.com (Postfix) with ESMTPS id 582C11A0188;
	Thu, 18 Dec 2025 15:24:25 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 dggpemr500006.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 15:24:24 +0800
From: Yao Kai <yaokai34@huawei.com>
To: <rcu@vger.kernel.org>
CC: <liuyongqiang13@huawei.com>, <paulmck@kernel.org>, <frederic@kernel.org>,
	<neeraj.upadhyay@kernel.org>, <joelagnelf@nvidia.com>,
	<josh@joshtriplett.org>, <boqun.feng@gmail.com>, <urezki@gmail.com>,
	<rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
	<jiangshanlai@gmail.com>, <qiang.zhang@linux.dev>,
	<linux-kernel@vger.kernel.org>, <yujiacheng3@huawei.com>
Subject: [PATCH] rcu: Fix rcu_read_unlock() deadloop due to softirq
Date: Thu, 18 Dec 2025 15:49:50 +0800
Message-ID: <20251218074950.1936014-1-yaokai34@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemr500006.china.huawei.com (7.185.36.185)

Commit 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in
__rcu_read_unlock()") removes the recursion-protection code from
__rcu_read_unlock(). Therefore, we could invoke the deadloop in
raise_softirq_irqoff() with ftrace enabled as follows:

WARNING: CPU: 0 PID: 0 at kernel/trace/trace.c:3021 __ftrace_trace_stack.constprop.0+0x172/0x180
Modules linked in: my_irq_work(O)
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G O 6.18.0-rc7-dirty #23 PREEMPT(full)
Tainted: [O]=OOT_MODULE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__ftrace_trace_stack.constprop.0+0x172/0x180
RSP: 0018:ffffc900000034a8 EFLAGS: 00010002
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffffff826d7b87 RDI: ffffffff826e9329
RBP: 0000000000090009 R08: 0000000000000005 R09: ffffffff82afbc4c
R10: 0000000000000008 R11: 0000000000011d7a R12: 0000000000000000
R13: ffff888003874100 R14: 0000000000000003 R15: ffff8880038c1054
FS:  0000000000000000(0000) GS:ffff8880fa8ea000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b31fa7f540 CR3: 00000000078f4005 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 trace_buffer_unlock_commit_regs+0x6d/0x220
 trace_event_buffer_commit+0x5c/0x260
 trace_event_raw_event_softirq+0x47/0x80
 raise_softirq_irqoff+0x6e/0xa0
 rcu_read_unlock_special+0xb1/0x160
 unwind_next_frame+0x203/0x9b0
 __unwind_start+0x15d/0x1c0
 arch_stack_walk+0x62/0xf0
 stack_trace_save+0x48/0x70
 __ftrace_trace_stack.constprop.0+0x144/0x180
 trace_buffer_unlock_commit_regs+0x6d/0x220
 trace_event_buffer_commit+0x5c/0x260
 trace_event_raw_event_softirq+0x47/0x80
 raise_softirq_irqoff+0x6e/0xa0
 rcu_read_unlock_special+0xb1/0x160
 unwind_next_frame+0x203/0x9b0
 __unwind_start+0x15d/0x1c0
 arch_stack_walk+0x62/0xf0
 stack_trace_save+0x48/0x70
 __ftrace_trace_stack.constprop.0+0x144/0x180
 trace_buffer_unlock_commit_regs+0x6d/0x220
 trace_event_buffer_commit+0x5c/0x260
 trace_event_raw_event_softirq+0x47/0x80
 raise_softirq_irqoff+0x6e/0xa0
 rcu_read_unlock_special+0xb1/0x160
 unwind_next_frame+0x203/0x9b0
 __unwind_start+0x15d/0x1c0
 arch_stack_walk+0x62/0xf0
 stack_trace_save+0x48/0x70
 __ftrace_trace_stack.constprop.0+0x144/0x180
 trace_buffer_unlock_commit_regs+0x6d/0x220
 trace_event_buffer_commit+0x5c/0x260
 trace_event_raw_event_softirq+0x47/0x80
 raise_softirq_irqoff+0x6e/0xa0
 rcu_read_unlock_special+0xb1/0x160
 __is_insn_slot_addr+0x54/0x70
 kernel_text_address+0x48/0xc0
 __kernel_text_address+0xd/0x40
 unwind_get_return_address+0x1e/0x40
 arch_stack_walk+0x9c/0xf0
 stack_trace_save+0x48/0x70
 __ftrace_trace_stack.constprop.0+0x144/0x180
 trace_buffer_unlock_commit_regs+0x6d/0x220
 trace_event_buffer_commit+0x5c/0x260
 trace_event_raw_event_softirq+0x47/0x80
 __raise_softirq_irqoff+0x61/0x80
 __flush_smp_call_function_queue+0x115/0x420
 __sysvec_call_function_single+0x17/0xb0
 sysvec_call_function_single+0x8c/0xc0
 </IRQ>

Commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
fixed the infinite loop in rcu_read_unlock_special() for IRQ work by
setting a flag before calling irq_work_queue_on(). We fix this issue by
setting the same flag before calling raise_softirq_irqoff() and rename the
flag to defer_qs_pending for more common.

Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read_unlock()")
Reported-by: Tengda Wu <wutengda2@huawei.com>
Signed-off-by: Yao Kai <yaokai34@huawei.com>
---
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h | 15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b8bbe7960cda..2265b9c2906e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -203,7 +203,7 @@ struct rcu_data {
 					/*  during and after the last grace */
 					/* period it is aware of. */
 	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
-	int defer_qs_iw_pending;	/* Scheduler attention pending? */
+	int defer_qs_pending;		/* irqwork or softirq pending? */
 	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
 
 	/* 2) batch handling */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dbe2d02be824..95ad967adcf3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -487,8 +487,8 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	union rcu_special special;
 
 	rdp = this_cpu_ptr(&rcu_data);
-	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
-		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
+	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
+		rdp->defer_qs_pending = DEFER_QS_IDLE;
 
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
@@ -645,7 +645,7 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	 * 5. Deferred QS reporting does not happen.
 	 */
 	if (rcu_preempt_depth() > 0)
-		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
+		WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
 }
 
 /*
@@ -747,7 +747,10 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Using softirq, safe to awaken, and either the
 			// wakeup is free or there is either an expedited
 			// GP in flight or a potential need to deboost.
-			raise_softirq_irqoff(RCU_SOFTIRQ);
+			if (rdp->defer_qs_pending != DEFER_QS_PENDING) {
+				rdp->defer_qs_pending = DEFER_QS_PENDING;
+				raise_softirq_irqoff(RCU_SOFTIRQ);
+			}
 		} else {
 			// Enabling BH or preempt does reschedule, so...
 			// Also if no expediting and no possible deboosting,
@@ -755,11 +758,11 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// tick enabled.
 			set_need_resched_current();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    needs_exp && rdp->defer_qs_iw_pending != DEFER_QS_PENDING &&
+			    needs_exp && rdp->defer_qs_pending != DEFER_QS_PENDING &&
 			    cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
-				rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
+				rdp->defer_qs_pending = DEFER_QS_PENDING;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
 		}
-- 
2.43.0

