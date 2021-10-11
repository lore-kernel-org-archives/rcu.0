Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A59FC4332F
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451E860EB6
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbhJKOyO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243520AbhJKOyK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Oct 2021 10:54:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6A9C60EFE;
        Mon, 11 Oct 2021 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633963929;
        bh=7F09mN7KGbtK5Vtlkamegsal+hNH6XJ6A18U2KwoN5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zl+9K8t36TeM+X9n09HWC0jLGapedRuSpaNnq7tOVxA00mWSsnEANq8dZ9E6/vBdw
         AIxO9QEfqpPxKI7kSJwqj4+rQI0UEBT2UZ0A0RN6vIg1VxRGCosPkcsdi8etPiRo5G
         1+WqNJ5RmSFFkQsU3ZzyAPKxNPWL7NNMPUhUDb94kMS/+hlFjOzZYTSgcGrjIpFpkx
         q0f3rFiXqAlLMSft6cQyThnml2MTVUCei1CdgQSCqT18xSbDDSmTjJFFJNLU5nJknc
         EoQNg8EY8YaMpCmzztTBhvBTWc5yvrnP5isCKK3MH/kgPDllvOSlg5fIZv52vvIOcv
         FAaLX57WQNU5Q==
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
Subject: [PATCH 05/11] rcu/nocb: Make rcu_core() callbacks acceleration (de-)offloading safe
Date:   Mon, 11 Oct 2021 16:51:34 +0200
Message-Id: <20211011145140.359412-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011145140.359412-1-frederic@kernel.org>
References: <20211011145140.359412-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When callbacks are offloaded, the NOCB kthreads handle the callbacks
progression on behalf of rcu_core().

However during the (de-)offloading process, the kthread may not be
entirely up to the task. As a result some callbacks grace period
sequence number may remain stale for a while because rcu_core() won't
take care of them either.

Fix this with forcing callbacks acceleration from rcu_core() as long
as the offloading process isn't complete.

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
 kernel/rcu/tree.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4869a6856bf1..a43924244000 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2288,6 +2288,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	unsigned long flags;
 	unsigned long mask;
 	bool needwake = false;
+	bool needacc = false;
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2315,16 +2316,29 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		 * This GP can't end until cpu checks in, so all of our
 		 * callbacks can be processed during the next GP.
 		 *
-		 * NOCB kthreads have their own way to deal with that.
+		 * NOCB kthreads have their own way to deal with that...
 		 */
-		if (!rcu_rdp_is_offloaded(rdp))
+		if (!rcu_rdp_is_offloaded(rdp)) {
 			needwake = rcu_accelerate_cbs(rnp, rdp);
+		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
+			/*
+			 * ...but NOCB kthreads may miss or delay callbacks acceleration
+			 * if in the middle of a (de-)offloading process.
+			 */
+			needacc = true;
+		}
 
 		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
 		if (needwake)
 			rcu_gp_kthread_wake();
+
+		if (needacc) {
+			rcu_nocb_lock_irqsave(rdp, flags);
+			rcu_accelerate_cbs_unlocked(rnp, rdp);
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+		}
 	}
 }
 
-- 
2.25.1

