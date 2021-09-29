Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C709AC433F5
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 22:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B6360FC2
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 22:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347310AbhI2WMr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347235AbhI2WMb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Sep 2021 18:12:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5815C61529;
        Wed, 29 Sep 2021 22:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632953449;
        bh=5PvqZQ5qnk2I6xO0f6MuVKzqATnTaiknkLZJeVgkG6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KR6ul31Lk8Y61P7V2V7Y2OwcjrXy0kYrFZW/c6h68bUrYBEXOE48gqmw9xZqqXhu/
         R/VKaw4QH+gLdqt7OU03RRYdH4lo4zvzEBm2QOSATZoxbiYlfottyLGGcgDhoRhBTw
         DOJh4MtvEieXcfiZ0SCvdb9KZ5OOhJnitThSNDzDFBD6R3Mj2fdQ6JbnBisHjTudMU
         saSpKioKqMs+Y0SJLYRnn9TrEE7dr04GejzzLOGgc7XAE/LhKR77azrYmA8kMRK2q8
         yXHImdmbF7nVq+la/wIYyzUWKfXGAAUTcHBdyRSdoqMFV9g+G3Jx5hTCplgwY9kd1i
         Gg+vleksO25xQ==
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
Subject: [PATCH 11/11] rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread
Date:   Thu, 30 Sep 2021 00:10:12 +0200
Message-Id: <20210929221012.228270-12-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929221012.228270-1-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcu_core() tries to ensure that its self-invocation in case of callbacks
overload only happen in softirq/rcuc mode. Indeed it doesn't make sense
to trigger local RCU core from nocb_cb kthread since it can execute
on a CPU different from the target rdp. Also in case of overload, the
nocb_cb kthread simply iterates a new loop of callbacks processing.

However the "offloaded" check that aims at preventing that is wrong.
First of all that state is volatile and second: softirq/rcuc can
execute while the target rdp is offloaded. As a result rcu_core() can

Fix that with moving the rcu_core() self-invocation to rcu_core() itself,
irrespective of the rdp offloaded state.

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
 kernel/rcu/tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b538094e21d9..600bffe4f121 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2470,7 +2470,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	int div;
 	bool __maybe_unused empty;
 	unsigned long flags;
-	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count = 0;
@@ -2592,9 +2591,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
-	/* Re-invoke RCU core processing if there are callbacks remaining. */
-	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist))
-		invoke_rcu_core();
 	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
 }
 
@@ -2781,8 +2777,12 @@ static __latent_entropy void rcu_core(void)
 
 	/* If there are callbacks ready, invoke them. */
 	if (do_batch && rcu_segcblist_ready_cbs(&rdp->cblist) &&
-	    likely(READ_ONCE(rcu_scheduler_fully_active)))
+	    likely(READ_ONCE(rcu_scheduler_fully_active))) {
 		rcu_do_batch(rdp);
+		/* Re-invoke RCU core processing if there are callbacks remaining. */
+		if (rcu_segcblist_ready_cbs(&rdp->cblist))
+			invoke_rcu_core();
+	}
 
 	/* Do any needed deferred wakeups of rcuo kthreads. */
 	do_nocb_deferred_wakeup(rdp);
-- 
2.25.1

