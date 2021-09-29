Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1259BC433FE
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 22:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DBD60FC2
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 22:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347091AbhI2WMC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345332AbhI2WMC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Sep 2021 18:12:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6325461423;
        Wed, 29 Sep 2021 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632953420;
        bh=tWGx8AK8+DXnZ3HGoe4uLYBFj6XGvOZmZrpZv1xbMQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQwaSQvn2b6wnBM2WY+7cFIPZ2uy9glAfzgxrZ9HY5X4TLzkc0dcG+DQWDIKaT5eU
         nNmX7FugxV+8ruPZCuJXn89jHLT5is1rTJku6SsadG9Odj1HPStKObd1OMTvffogPw
         wyhVTWTZ51ohv9GeCDa6e7mMmyMzzha74Tj41UJpBU+6G0Zo5J/K75dSA37FKXqqy2
         sKPwO8PmSEprPk0EwHPQpf8Glrj4PJhf0IkUB4Q8FF8/WpBWIm57NadOX273T+ucS4
         DEEWdHFaJj5m+sMy8sZdxs733tvKkkEzdAMzS+gbZpxoeFCnZK8jWF5Pdje+3Z/X5p
         uYYHWAXTzaTpQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 01/11] rcu/nocb: Make local rcu_nocb_lock_irqsave() safe against concurrent deoffloading
Date:   Thu, 30 Sep 2021 00:10:02 +0200
Message-Id: <20210929221012.228270-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929221012.228270-1-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org>
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

Reported-by: Valentin Schneider <valentin.schneider@arm.com>
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

