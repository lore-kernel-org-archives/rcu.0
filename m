Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF254C433EF
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 22:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAAFF60FC2
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 22:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347289AbhI2WMl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:32900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347255AbhI2WMZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Sep 2021 18:12:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9818361425;
        Wed, 29 Sep 2021 22:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632953444;
        bh=bWGuMKX/2J0zp8HS74KRYMqzjTCxrHugNyNTncu2H3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBKuCagfiLkehqBlDkyOONZdoAs5yRE9tK/zpAJEBfurwh1NL0YOKIAavuuBDIwvy
         P/R4iFv+hj0muGwVPDA/tFiCO9Royn+3lgMhKjXzCe86HceUOnU24M3b8Sy0VdGaAa
         faLDHn6DZ49P9wCNYcZ/ZQpnVm7CdKSZqbXxUb8u4lq1HlWnKYmCx+8o9uqYAGPI8u
         bKeAE7uvUN7eKZ+iRlFLfacZDNlr977/aXA/VcC0B/RwPu0VAz+YqFNXMy9t5GHgLC
         whVj7XJ9hLQOop7iX4sv/6CYCaIhS9Kb+wXB90N6tgrXQU5XvYwgCisqpCQFE13s4V
         +lvTg+EZSM/nA==
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
Subject: [PATCH 09/11] rcu: Fix callbacks processing time limit retaining cond_resched()
Date:   Thu, 30 Sep 2021 00:10:10 +0200
Message-Id: <20210929221012.228270-10-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929221012.228270-1-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The callbacks processing time limit makes sure we are not exceeding a
given amount of time executing the queue.

However its "continue" clause bypasses the cond_resched() call on
rcuc and NOCB kthreads, delaying it until we reach the limit, which can
be very long...

Make sure the scheduler has a higher priority than the time limit.

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
 kernel/rcu/tree.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 35c4abc8df99..bfc8e2727e35 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2535,9 +2535,21 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		/*
 		 * Stop only if limit reached and CPU has something to do.
 		 */
-		if (count >= bl && in_serving_softirq() &&
-		    (need_resched() || !is_idle_task(current)))
-			break;
+		if (in_serving_softirq()) {
+			if (count >= bl && (need_resched() || !is_idle_task(current)))
+				break;
+		} else {
+			local_bh_enable();
+			lockdep_assert_irqs_enabled();
+			cond_resched_tasks_rcu_qs();
+			lockdep_assert_irqs_enabled();
+			local_bh_disable();
+		}
+
+		/*
+		 * Make sure we don't spend too much time here and deprive other
+		 * softirq vectors of CPU cycles.
+		 */
 		if (unlikely(tlimit)) {
 			/* only call local_clock() every 32 callbacks */
 			if (likely((count & 31) || local_clock() < tlimit))
@@ -2545,13 +2557,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			/* Exceeded the time limit, so leave. */
 			break;
 		}
-		if (!in_serving_softirq()) {
-			local_bh_enable();
-			lockdep_assert_irqs_enabled();
-			cond_resched_tasks_rcu_qs();
-			lockdep_assert_irqs_enabled();
-			local_bh_disable();
-		}
 	}
 
 	rcu_nocb_lock_irqsave(rdp, flags);
-- 
2.25.1

