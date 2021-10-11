Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F79FC433EF
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 607C660EB6
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbhJKOym (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244038AbhJKOye (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Oct 2021 10:54:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE92160BD3;
        Mon, 11 Oct 2021 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633963954;
        bh=8IgY3wMFqOpx4rMhJDcKyAY4whn8NSW4m12oeeuW8Ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZS8rLFxg3wcgkZJBtR7dd7dwh6s+0lyjvOUj7rh59R1lcO4HVwri/glKXUQLzphFG
         1gHHLVf8/fcmKTzCiw08oYjkteqhSH14KwPj9mWublxylbhCMZkWkus8YJ1axtwoYd
         Y1VJTZR6aBlfsD/Xd1aZdFdXeVZ8j+BE+Ipe495PTz06qT7S3kcN4b3gjsxYZLPfFj
         1hiKQNaeBP+eBO9C2hpLr40I83wtOiVX1N93xvi1dOpkKMXlT8TP0cYy756/YVHmJS
         kgGgp9P0O7YCWdT6n2k1oapwGHWurmQd1Mrpz6jiuuvJ4RdWE5v4d2XIpB6kBtY5Mw
         3VXWQRlH71eIA==
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
Subject: [PATCH 11/11] rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread
Date:   Mon, 11 Oct 2021 16:51:40 +0200
Message-Id: <20211011145140.359412-12-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011145140.359412-1-frederic@kernel.org>
References: <20211011145140.359412-1-frederic@kernel.org>
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

However the "offloaded" check that aims at preventing misplaced
rcu_core() invocations is wrong. First of all that state is volatile
and second: softirq/rcuc can execute while the target rdp is offloaded.
As a result rcu_core() can be invoked on the wrong CPU while in the
process of (de-)offloading.

Fix that with moving the rcu_core() self-invocation to rcu_core() itself,
irrespective of the rdp offloaded state.

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
 kernel/rcu/tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0ca4f4ec724d..8270e58cd0f3 100644
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

