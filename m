Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51443C4742C
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0852F2073A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620110;
	bh=hF1NO7KIDMcNTZmIydXOIBUoL7ZkScx98CT2WtMiwYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rwLcXt1ItFoz9hmMb7YnaoSEXk5SmFsH1QXaGq52p6w7vDdcNSlF/dWoAEM35DcU8
	 10AcN5Bvcr5ITDh073xv3aet+qkd8rylIMeFtpgHx4xWPUWu+OeTB94uDiaPOtVB19
	 6e+L7WK9KvBmi4pbs3dG1iTfLbTGhyW551LDq97I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbgKEXs3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732785AbgKEXra (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:30 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7A4C22248;
        Thu,  5 Nov 2020 23:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620050;
        bh=hF1NO7KIDMcNTZmIydXOIBUoL7ZkScx98CT2WtMiwYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzkERnkvyEhi4ad2sfHWHIfC526ZtjrMWsHqYC3H0esW8d5F3jXF29gJZC9fvC9FH
         ZQ/Pw8AfTdgj/nrJv1JI/dOwI41Yc8vwCAHcCr2GYAQLWAqEVn1OYfS+OE6X0k09zT
         3mnpGgWqnM0TIu/dt21gXSYqFDaYhSuDtL8ptdFI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Hou Tao <houtao1@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 23/28] locktorture: Invoke percpu_free_rwsem() to do percpu-rwsem cleanup
Date:   Thu,  5 Nov 2020 15:47:14 -0800
Message-Id: <20201105234719.23307-23-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

When executing the LOCK06 locktorture scenario featuring percpu-rwsem,
the RCU callback rcu_sync_func() may still be pending after locktorture
module is removed.  This can in turn lead to the following Oops:

  BUG: unable to handle page fault for address: ffffffffc00eb920
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 6500a067 P4D 6500a067 PUD 6500c067 PMD 13a36c067 PTE 800000013691c163
  Oops: 0000 [#1] PREEMPT SMP
  CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0-rc5+ #4
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  RIP: 0010:rcu_cblist_dequeue+0x12/0x30
  Call Trace:
   <IRQ>
   rcu_core+0x1b1/0x860
   __do_softirq+0xfe/0x326
   asm_call_on_stack+0x12/0x20
   </IRQ>
   do_softirq_own_stack+0x5f/0x80
   irq_exit_rcu+0xaf/0xc0
   sysvec_apic_timer_interrupt+0x2e/0xb0
   asm_sysvec_apic_timer_interrupt+0x12/0x20

This commit avoids tis problem by adding an exit hook in lock_torture_ops
and using it to call percpu_free_rwsem() for percpu rwsem torture during
the module-cleanup function, thus ensuring that rcu_sync_func() completes
before module exits.

It is also necessary to call the exit hook if lock_torture_init()
fails half-way, so this commit also adds an ->init_called field in
lock_torture_cxt to indicate that exit hook, if present, must be called.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 79fbd97..fd838ce 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -76,6 +76,7 @@ static void lock_torture_cleanup(void);
  */
 struct lock_torture_ops {
 	void (*init)(void);
+	void (*exit)(void);
 	int (*writelock)(void);
 	void (*write_delay)(struct torture_random_state *trsp);
 	void (*task_boost)(struct torture_random_state *trsp);
@@ -92,12 +93,13 @@ struct lock_torture_cxt {
 	int nrealwriters_stress;
 	int nrealreaders_stress;
 	bool debug_lock;
+	bool init_called;
 	atomic_t n_lock_torture_errors;
 	struct lock_torture_ops *cur_ops;
 	struct lock_stress_stats *lwsa; /* writer statistics */
 	struct lock_stress_stats *lrsa; /* reader statistics */
 };
-static struct lock_torture_cxt cxt = { 0, 0, false,
+static struct lock_torture_cxt cxt = { 0, 0, false, false,
 				       ATOMIC_INIT(0),
 				       NULL, NULL};
 /*
@@ -573,6 +575,11 @@ static void torture_percpu_rwsem_init(void)
 	BUG_ON(percpu_init_rwsem(&pcpu_rwsem));
 }
 
+static void torture_percpu_rwsem_exit(void)
+{
+	percpu_free_rwsem(&pcpu_rwsem);
+}
+
 static int torture_percpu_rwsem_down_write(void) __acquires(pcpu_rwsem)
 {
 	percpu_down_write(&pcpu_rwsem);
@@ -597,6 +604,7 @@ static void torture_percpu_rwsem_up_read(void) __releases(pcpu_rwsem)
 
 static struct lock_torture_ops percpu_rwsem_lock_ops = {
 	.init		= torture_percpu_rwsem_init,
+	.exit		= torture_percpu_rwsem_exit,
 	.writelock	= torture_percpu_rwsem_down_write,
 	.write_delay	= torture_rwsem_write_delay,
 	.task_boost     = torture_boost_dummy,
@@ -789,9 +797,10 @@ static void lock_torture_cleanup(void)
 
 	/*
 	 * Indicates early cleanup, meaning that the test has not run,
-	 * such as when passing bogus args when loading the module. As
-	 * such, only perform the underlying torture-specific cleanups,
-	 * and avoid anything related to locktorture.
+	 * such as when passing bogus args when loading the module.
+	 * However cxt->cur_ops.init() may have been invoked, so beside
+	 * perform the underlying torture-specific cleanups, cur_ops.exit()
+	 * will be invoked if needed.
 	 */
 	if (!cxt.lwsa && !cxt.lrsa)
 		goto end;
@@ -831,6 +840,11 @@ static void lock_torture_cleanup(void)
 	cxt.lrsa = NULL;
 
 end:
+	if (cxt.init_called) {
+		if (cxt.cur_ops->exit)
+			cxt.cur_ops->exit();
+		cxt.init_called = false;
+	}
 	torture_cleanup_end();
 }
 
@@ -878,8 +892,10 @@ static int __init lock_torture_init(void)
 		goto unwind;
 	}
 
-	if (cxt.cur_ops->init)
+	if (cxt.cur_ops->init) {
 		cxt.cur_ops->init();
+		cxt.init_called = true;
+	}
 
 	if (nwriters_stress >= 0)
 		cxt.nrealwriters_stress = nwriters_stress;
-- 
2.9.5

