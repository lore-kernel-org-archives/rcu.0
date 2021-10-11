Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B939C433FE
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568A960E98
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbhJKOya (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237811AbhJKOy0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Oct 2021 10:54:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97A7260BD3;
        Mon, 11 Oct 2021 14:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633963946;
        bh=iaUZfJFRip9ouAlmnyaHzyPKLPOsL/VzwlUShGOmbKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iynkktKsGUIlDk0V3L+Yj1mf4smNOSy0tEmbJnnloNnzRxl0wBmRmktWi/lNXfvzA
         RJ7gEtmDHGcq4j5caC9vIGYMkZNzh56NyuDz6aFPXOwwFglJ6RQfGPIdr/8bYMwjL3
         JdzLZSkS9zuha0qQ+nHHEQwkBsjpFfuRt+wadmh33C4obMqM3mo7V76cVoNsWZtUV2
         Y2gfmv3inOsd9J+pEFy1XUy9WjaSwin9IVKbSqC7t1b9tKB+F2O7tWu0EAbd7WKJ7N
         KK15/e91vBM3qKsFFv7p3y4bP3cnVk5B5OUb2b2osg7vMofdpbDnNkmIkLaLXxeBCW
         9gucXDgqdHDZQ==
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
Subject: [PATCH 09/11] rcu: Fix callbacks processing time limit retaining cond_resched()
Date:   Mon, 11 Oct 2021 16:51:38 +0200
Message-Id: <20211011145140.359412-10-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011145140.359412-1-frederic@kernel.org>
References: <20211011145140.359412-1-frederic@kernel.org>
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

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
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
 kernel/rcu/tree.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 716dead1509d..7a655d93a28a 100644
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

