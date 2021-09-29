Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51172C433F5
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 22:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBF260FC2
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 22:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347304AbhI2WMq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:32958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347266AbhI2WM2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Sep 2021 18:12:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77C646142A;
        Wed, 29 Sep 2021 22:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632953446;
        bh=x2o57B7E1opnNa11Cu9xBDFvBtxss3CHBCC7T4dl9yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0fyA/NmLvJVqowtyXIuBO/dtVUNqxwLDLx17P0OdDF9J/QqpoPPJKGKl/MdtKtWj
         MFcvV/8r/HTzFfGNP42JK4W3c4yo+s37lDjVg7xFd7jyaIBvN6oE9ythyjhL46PJcP
         tjtl33MMZZgcYhp19NPDRu4R2LgAcv77sFI+KmCjk1T6ha7I8V7FalYityX6OpMqPp
         WJLUpy6+hJ4r1oxAoV0ySivSrdwa9x8gNTJv9Lwe4a2zr5v3BYw8IWnew1agH1z/FX
         cOTpWF0ctiKG3AueY6kQNPu1X6tcFmYZfyFjZntEIouUheUXItWRaCzdK2+A0RuDuR
         5hmz+lstHCKdw==
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
Subject: [PATCH 10/11] rcu: Apply callbacks processing time limit only on softirq
Date:   Thu, 30 Sep 2021 00:10:11 +0200
Message-Id: <20210929221012.228270-11-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929221012.228270-1-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Time limit only makes sense when callbacks are serviced in softirq mode
because:

_ In case we need to get back to the scheduler,
  cond_resched_tasks_rcu_qs() is called after each callback.

_ In case some other softirq vector needs the CPU, the call to
  local_bh_enable() before cond_resched_tasks_rcu_qs() takes care about
  them via a call to do_softirq().

_ The time spent on other tasks after scheduling out, or on softirqs
  processing, is spuriously accounted to the time limit.

Therefore, make sure the time limit only applies to softirq mode.

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
 kernel/rcu/tree.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bfc8e2727e35..b538094e21d9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2498,7 +2498,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	div = READ_ONCE(rcu_divisor);
 	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
 	bl = max(rdp->blimit, pending >> div);
-	if (unlikely(bl > 100)) {
+	if (in_serving_softirq() && unlikely(bl > 100)) {
 		long rrn = READ_ONCE(rcu_resched_ns);
 
 		rrn = rrn < NSEC_PER_MSEC ? NSEC_PER_MSEC : rrn > NSEC_PER_SEC ? NSEC_PER_SEC : rrn;
@@ -2538,6 +2538,17 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		if (in_serving_softirq()) {
 			if (count >= bl && (need_resched() || !is_idle_task(current)))
 				break;
+			/*
+			 * Make sure we don't spend too much time here and deprive other
+			 * softirq vectors of CPU cycles.
+			 */
+			if (unlikely(tlimit)) {
+				/* only call local_clock() every 32 callbacks */
+				if (likely((count & 31) || local_clock() < tlimit))
+					continue;
+				/* Exceeded the time limit, so leave. */
+				break;
+			}
 		} else {
 			local_bh_enable();
 			lockdep_assert_irqs_enabled();
@@ -2545,18 +2556,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			lockdep_assert_irqs_enabled();
 			local_bh_disable();
 		}
-
-		/*
-		 * Make sure we don't spend too much time here and deprive other
-		 * softirq vectors of CPU cycles.
-		 */
-		if (unlikely(tlimit)) {
-			/* only call local_clock() every 32 callbacks */
-			if (likely((count & 31) || local_clock() < tlimit))
-				continue;
-			/* Exceeded the time limit, so leave. */
-			break;
-		}
 	}
 
 	rcu_nocb_lock_irqsave(rdp, flags);
-- 
2.25.1

