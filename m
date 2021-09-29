Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA5C433F5
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 22:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA7960FC2
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 22:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347260AbhI2WM2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347247AbhI2WMW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Sep 2021 18:12:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9CD161423;
        Wed, 29 Sep 2021 22:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632953441;
        bh=n/68oBtmr6qIYwDDlyCGFdycSkrFGc8mKE26O+8/IOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqIxEEiZxtg31wyzDfSS45f/wKVxRG42BH6Wm+7btkfloqelFFr4MbpU3mm/I8IDl
         YG08RdwmqRHvkHX5ZWR+fq67qiFz/NIy4pCS9bs3i8bjmorCZn01mWtaSt+TWn2iYO
         4JSXslPkT8W11Q/lnEwfoXUpo45a7dVmVd4Prc8V1RCV/s+tOWx/qRQLroriRGm5U6
         Nj8V1RRi0o82bRlL46VO5fFLByYo2OO/UI+bJbtf9KhSo8uyvi+B+sBt1qAn699OcQ
         SXjYrkJAKfY296fVTUsmGYrat/hR5he+5qYI0HBZYhAqLRbTCpVgl4iQ71LFRxACP5
         8yLWZMSuKMz6A==
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
Subject: [PATCH 08/11] rcu/nocb: Limit number of softirq callbacks only on softirq
Date:   Thu, 30 Sep 2021 00:10:09 +0200
Message-Id: <20210929221012.228270-9-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929221012.228270-1-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org>
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

Another issue with the condition is that rcu_is_callbacks_kthread()
doesn't check if we are actually running callbacks from rcuc itself or
from a softirq interrupting rcuc.

Fix and clarify the condition with those constraints in mind:

_ If callbacks are processed either by rcuc or NOCB kthread, the call
  to cond_resched_tasks_rcu_qs() is enough to take care of the overload.

_ If instead callbacks are processed by softirqs:
  * If need_resched(), exit the callbacks processing
  * Otherwise if CPU is idle we can continue
  * Otherwise exit because a softirq shouldn't interrupt a task for too
    long nor deprive other pending softirq vectors of the CPU.

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
index 1971a4e15e96..35c4abc8df99 100644
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

