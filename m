Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F44C4332F
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 22:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD39960FC2
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 22:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347238AbhI2WMV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347206AbhI2WMT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Sep 2021 18:12:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D34276142A;
        Wed, 29 Sep 2021 22:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632953438;
        bh=NpWASncjnZvaQzKCsA4GIJ7sPEOD6tKMBIZnvj8DI4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BeNNNT/J92Amxy6cs9QBytFbKL/H9muPYNEaw/ZMwdOJ8z5Tb193+EASaxh6z3tKh
         FUO3/f7HIxdAjXvDP/MWSl730l4zChO7HkgACcwd6WBiKaLon0y++FnhHSJRPlYpzR
         Urgq1b32Ud66HStAsBaaS63ZQ7PPyf9lSI6hLIgPfHHQMnSW7vzs2+UxeprtGIO7JH
         y1LF3bS/2fnFweXPwjTk4QOCg9jQfrLQe+6zc4wr9IEc1NepcItvQXHy8mmvb014U+
         g99dkXDMaqMo3XI80vF5ar4e0WYxwOo1utpDBs6bS/n8ayHEtY3C8zlDMABSmPacgS
         8QZMha/tXCZIA==
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
Subject: [PATCH 07/11] rcu/nocb: Use appropriate rcu_nocb_lock_irqsave()
Date:   Thu, 30 Sep 2021 00:10:08 +0200
Message-Id: <20210929221012.228270-8-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929221012.228270-1-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Instead of hardcoding IRQ save and nocb lock, use the consolidated
API.

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
 kernel/rcu/tree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b1fc6e498d90..1971a4e15e96 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2492,8 +2492,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	 * races with call_rcu() from interrupt handlers.  Leave the
 	 * callback counts, as rcu_barrier() needs to be conservative.
 	 */
-	local_irq_save(flags);
-	rcu_nocb_lock(rdp);
+	rcu_nocb_lock_irqsave(rdp, flags);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
 	pending = rcu_segcblist_n_cbs(&rdp->cblist);
 	div = READ_ONCE(rcu_divisor);
@@ -2556,8 +2555,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		}
 	}
 
-	local_irq_save(flags);
-	rcu_nocb_lock(rdp);
+	rcu_nocb_lock_irqsave(rdp, flags);
 	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
 			    is_idle_task(current), rcu_is_callbacks_kthread());
-- 
2.25.1

