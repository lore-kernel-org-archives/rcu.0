Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43033C433FE
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F16A60EE7
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbhJKOxx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:32864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238546AbhJKOxw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Oct 2021 10:53:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AF5360EBD;
        Mon, 11 Oct 2021 14:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633963911;
        bh=WusddlDCqZhxpwipenZWXYdMRRimpXEckXZ0alKShnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbZ3MpYzvXUjhE5QDUodaN0qiOj+KoozABvo+8lmNHRw/Oc1EAvgqxi0ix3w9FGw8
         32VMHi62VyZMnUSj26i+4DZlwJWxz75wzG1vNjaAvirWK3dGNNaeyaU8+dwJQzsU+P
         RiLcvMoHAE/d+f20uaX7tpsDvGctoaAQDoxpc976Ub0C3xBuRpQy76YNVVIiynWesS
         tPNotlvhTSFFTsqEOxXVXbGu0SYNE6FevooD/d3Lr/uavQif3ihduG+IBQQLIKj9Iw
         NlN/kSPtjYj6WLDKr1Uu5Mb/m132jhxWLW5SY5IIXsJxt6mNaT0cPl4GrFdJlOLjtG
         s3gTGC9sri+VQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 01/11] rcu/nocb: Make local rcu_nocb_lock_irqsave() safe against concurrent deoffloading
Date:   Mon, 11 Oct 2021 16:51:30 +0200
Message-Id: <20211011145140.359412-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011145140.359412-1-frederic@kernel.org>
References: <20211011145140.359412-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcu_nocb_lock_irqsave() can be preempted between the call to
rcu_segcblist_is_offloaded() and the actual locking. This matters now
that rcu_core() is preemptible on PREEMPT_RT and the (de-)offloading
process can interrupt the softirq or the rcuc kthread.

As a result we may locklessly call into code that requires nocb locking.
In practice this is a problem while we accelerate callbacks on rcu_core().

Simply disabling interrupts before (instead of after) checking the NOCB
offload state fixes the issue.

Reported-and-tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/rcu/tree.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 70188cb42473..deeaf2fee714 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -439,12 +439,16 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
 #ifdef CONFIG_RCU_NOCB_CPU
 static void __init rcu_organize_nocb_kthreads(void);
-#define rcu_nocb_lock_irqsave(rdp, flags)				\
-do {									\
-	if (!rcu_segcblist_is_offloaded(&(rdp)->cblist))		\
-		local_irq_save(flags);					\
-	else								\
-		raw_spin_lock_irqsave(&(rdp)->nocb_lock, (flags));	\
+
+/*
+ * Disable IRQs before checking offloaded state so that local
+ * locking is safe against concurrent de-offloading.
+ */
+#define rcu_nocb_lock_irqsave(rdp, flags)			\
+do {								\
+	local_irq_save(flags);					\
+	if (rcu_segcblist_is_offloaded(&(rdp)->cblist))	\
+		raw_spin_lock(&(rdp)->nocb_lock);		\
 } while (0)
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 #define rcu_nocb_lock_irqsave(rdp, flags) local_irq_save(flags)
-- 
2.25.1

