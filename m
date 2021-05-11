Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2B2C2B9F5
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE66A61925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhEKXNq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhEKXNc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 029C561937;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=DxBhv9EVvKuU9XTN8XRXyc+TeqOt5jOmLL3qGBXfNXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iS6HN4zWCSuCylHP/QPbfduoiLrsPmustn/QTRW4jUthXb2DQIgLbr6pi1dWfK77/
         yFIiBOfEvD45967kQ5FRUSVs9mXEbu/RfohtEpaZHLiOvYFWopQs/J818qUMXIgTB0
         t0ciPezahehJ8BnIZc06UL0g3oVKU4UHyM7LR3u5NmyG7O2WestW3bvtLN+kh1Qnn5
         lvU8ui5OvW34MjJwLhxn4FWB57XNhL6tpqNdJggiwtvkvkfjiDsnL7hTw0h5Zi6Xwa
         AM9ZWp9pKi/t1YOwY2HNNgLubdqGsX6SyuhKrFndaV0mrkQlu3pEivimWJ16u8bkp1
         CkeFn/bPMhqng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 760055C0DD7; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/26] refscale: Add acqrel, lock, and lock-irq
Date:   Tue, 11 May 2021 16:12:04 -0700
Message-Id: <20210511231223.2895398-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds scale_type of acqrel, lock, and lock-irq to
test acquisition and release.  Note that the refscale.nreaders=1
module parameter is required if you wish to test uncontended locking.
In contrast, acqrel uses a per-CPU variable, so should be just fine with
large values of the refscale.nreaders=1 module parameter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 109 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 02dd9767b559..313d4547cbc7 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -362,6 +362,111 @@ static struct ref_scale_ops rwsem_ops = {
 	.name		= "rwsem"
 };
 
+// Definitions for global spinlock
+static DEFINE_SPINLOCK(test_lock);
+
+static void ref_lock_section(const int nloops)
+{
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		spin_lock(&test_lock);
+		spin_unlock(&test_lock);
+	}
+	preempt_enable();
+}
+
+static void ref_lock_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		spin_lock(&test_lock);
+		un_delay(udl, ndl);
+		spin_unlock(&test_lock);
+	}
+	preempt_enable();
+}
+
+static struct ref_scale_ops lock_ops = {
+	.readsection	= ref_lock_section,
+	.delaysection	= ref_lock_delay_section,
+	.name		= "lock"
+};
+
+// Definitions for global irq-save spinlock
+
+static void ref_lock_irq_section(const int nloops)
+{
+	unsigned long flags;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		spin_lock_irqsave(&test_lock, flags);
+		spin_unlock_irqrestore(&test_lock, flags);
+	}
+	preempt_enable();
+}
+
+static void ref_lock_irq_delay_section(const int nloops, const int udl, const int ndl)
+{
+	unsigned long flags;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		spin_lock_irqsave(&test_lock, flags);
+		un_delay(udl, ndl);
+		spin_unlock_irqrestore(&test_lock, flags);
+	}
+	preempt_enable();
+}
+
+static struct ref_scale_ops lock_irq_ops = {
+	.readsection	= ref_lock_irq_section,
+	.delaysection	= ref_lock_irq_delay_section,
+	.name		= "lock-irq"
+};
+
+// Definitions acquire-release.
+static DEFINE_PER_CPU(unsigned long, test_acqrel);
+
+static void ref_acqrel_section(const int nloops)
+{
+	unsigned long x;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		x = smp_load_acquire(this_cpu_ptr(&test_acqrel));
+		smp_store_release(this_cpu_ptr(&test_acqrel), x + 1);
+	}
+	preempt_enable();
+}
+
+static void ref_acqrel_delay_section(const int nloops, const int udl, const int ndl)
+{
+	unsigned long x;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		x = smp_load_acquire(this_cpu_ptr(&test_acqrel));
+		un_delay(udl, ndl);
+		smp_store_release(this_cpu_ptr(&test_acqrel), x + 1);
+	}
+	preempt_enable();
+}
+
+static struct ref_scale_ops acqrel_ops = {
+	.readsection	= ref_acqrel_section,
+	.delaysection	= ref_acqrel_delay_section,
+	.name		= "acqrel"
+};
+
 static void rcu_scale_one_reader(void)
 {
 	if (readdelay <= 0)
@@ -653,8 +758,8 @@ ref_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static struct ref_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &rcu_trace_ops, &rcu_tasks_ops,
-		&refcnt_ops, &rwlock_ops, &rwsem_ops,
+		&rcu_ops, &srcu_ops, &rcu_trace_ops, &rcu_tasks_ops, &refcnt_ops, &rwlock_ops,
+		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.31.1.189.g2e36527f23

