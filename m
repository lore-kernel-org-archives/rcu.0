Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08E1C433F5
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D54B60E98
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243534AbhJKOy2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243761AbhJKOyV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Oct 2021 10:54:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA78F60EB6;
        Mon, 11 Oct 2021 14:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633963941;
        bh=U3DQ0qQlHAIb6fp6TjgBnqiVp7Le/MfFRGgFfN2WGR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LM31/O6uKJkdIQeVtB5DL7u2lOR0rZv+HkFMkI6t2jWm3KBIEVh+JcD78lr27nAd/
         z8PIBPz+27/z6w0Riv+fLF5ihBo68My83i/jGwcGBiLs65Ep8e2ymTyMmYFkwKkH2f
         e2sHLlSO77h2ZNRkSQqFfEuu2MRq7TYHktC5hmLDmwrrVO7GNfeYL8nDr85SUSgGoe
         HxT9hXVwLSUyXwJPFbrE7F/C3Bxql6GgWQJ8BIkaO1vTPE3fWdVhntq52/aUN30sGC
         xlD0VpOQGV2tGmzTvlVJgmFugTW7sGCRM0mpgpbLyx2Huescog5SpdEUo8Hw4wIjs7
         ouoDm43aSri5w==
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
Subject: [PATCH 08/11] rcu/nocb: Limit number of softirq callbacks only on softirq
Date:   Mon, 11 Oct 2021 16:51:37 +0200
Message-Id: <20211011145140.359412-9-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011145140.359412-1-frederic@kernel.org>
References: <20211011145140.359412-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The current condition to limit the number of callbacks executed in a
row checks the offloaded state of the rdp. Not only is it volatile
but it is also misleading: the rcu_core() may well be executing
callbacks concurrently with NOCB kthreads, and the offloaded state
would then be verified on both cases. As a result the limit would
spuriously not apply anymore on softirq while in the middle of
(de-)offloading process.

Fix and clarify the condition with those constraints in mind:

_ If callbacks are processed either by rcuc or NOCB kthread, the call
  to cond_resched_tasks_rcu_qs() is enough to take care of the overload.

_ If instead callbacks are processed by softirqs:
  * If need_resched(), exit the callbacks processing
  * Otherwise if CPU is idle we can continue
  * Otherwise exit because a softirq shouldn't interrupt a task for too
    long nor deprive other pending softirq vectors of the CPU.

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
 kernel/rcu/tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index eaa9c7ce91bb..716dead1509d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2535,9 +2535,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		/*
 		 * Stop only if limit reached and CPU has something to do.
 		 */
-		if (count >= bl && !offloaded &&
-		    (need_resched() ||
-		     (!is_idle_task(current) && !rcu_is_callbacks_kthread())))
+		if (count >= bl && in_serving_softirq() &&
+		    (need_resched() || !is_idle_task(current)))
 			break;
 		if (unlikely(tlimit)) {
 			/* only call local_clock() every 32 callbacks */
-- 
2.25.1

