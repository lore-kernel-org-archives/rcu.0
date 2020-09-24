Return-Path: <SRS0=Gqt/=DB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6858C4363D
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 14:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B03212CC
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 14:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgIXOM3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Sep 2020 10:12:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727859AbgIXOM2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Sep 2020 10:12:28 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 10A64827C70A2C2D438C;
        Thu, 24 Sep 2020 22:12:05 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 24 Sep 2020
 22:12:00 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>
Subject: [PATCH v2 2/2] locktorture: call percpu_free_rwsem() to do percpu-rwsem cleanup
Date:   Thu, 24 Sep 2020 22:18:54 +0800
Message-ID: <20200924141854.134835-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.25.0.4.g0ad7144999
In-Reply-To: <20200923035137.GN29330@paulmck-ThinkPad-P72>
References: <20200923035137.GN29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When do percpu-rwsem writer lock torture, the RCU callback
rcu_sync_func() may still be pending after locktorture module
is removed, and it will lead to the following Oops:

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

Fix it by adding an exit hook in lock_torture_ops and
use it to call percpu_free_rwsem() for percpu rwsem torture
before the module is removed, so we can ensure rcu_sync_func()
completes before module exits.

Also needs to call exit hook if lock_torture_init() fails half-way,
so add init_called field in lock_torture_cxt to indicate that
init hook has been called.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
v2: add init_called field in lock_torture_cxt instead of reusing
    cxt->cur_ops for error handling

 kernel/locking/locktorture.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index bebdf98e6cd78..1fbbcf76f495b 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -74,6 +74,7 @@ static void lock_torture_cleanup(void);
  */
 struct lock_torture_ops {
 	void (*init)(void);
+	void (*exit)(void);
 	int (*writelock)(void);
 	void (*write_delay)(struct torture_random_state *trsp);
 	void (*task_boost)(struct torture_random_state *trsp);
@@ -90,12 +91,13 @@ struct lock_torture_cxt {
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
@@ -571,6 +573,11 @@ void torture_percpu_rwsem_init(void)
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
@@ -595,6 +602,7 @@ static void torture_percpu_rwsem_up_read(void) __releases(pcpu_rwsem)
 
 static struct lock_torture_ops percpu_rwsem_lock_ops = {
 	.init		= torture_percpu_rwsem_init,
+	.exit		= torture_percpu_rwsem_exit,
 	.writelock	= torture_percpu_rwsem_down_write,
 	.write_delay	= torture_rwsem_write_delay,
 	.task_boost     = torture_boost_dummy,
@@ -786,9 +794,10 @@ static void lock_torture_cleanup(void)
 
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
@@ -828,6 +837,11 @@ static void lock_torture_cleanup(void)
 	cxt.lrsa = NULL;
 
 end:
+	if (cxt.init_called) {
+		if (cxt.cur_ops->exit)
+			cxt.cur_ops->exit();
+		cxt.init_called = false;
+	}
 	torture_cleanup_end();
 }
 
@@ -875,8 +889,10 @@ static int __init lock_torture_init(void)
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
2.25.0.4.g0ad7144999

