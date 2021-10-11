Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B19C433EF
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E54260BD3
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243213AbhJKOyG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236485AbhJKOyF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Oct 2021 10:54:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EB1F60EE5;
        Mon, 11 Oct 2021 14:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633963925;
        bh=I1a8/kKu9a/hafg5Ydgep9cD3WJyqbEG/mE+yUwREes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CmoSMJbD7RN1Wf2EFO2jvOPl+eYMZ7fOk/UaKHKv7m+596BqIL9k7CLOAfAYQ8KVI
         r18nKCqiCPiF9ueG6sN/zuNF/vxmykgvFNC3FqtanJ4JT/OiEdtkR3n0lgX5sK3ajW
         i1xyPcN3XpJjZKzYAHGELJlVhiYnMskfY+2NxiPKYfkuVh7upHmRLZoU9IY4xIVxSi
         gWDBigTsUtQrmubIH1NuA+ov8mNeU80o8OlSfuKwDd+MlQynZsC5PlZYKHykwBs5wZ
         CN8XEBcPYRfUV0WzVJ5emG7Kcs+jpkr/fGXnG6GfpB4phqA68EAhv2injEKz9Uxsz5
         f5GojhxTGuJyQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 04/11] rcu/nocb: Make rcu_core() callbacks acceleration preempt-safe
Date:   Mon, 11 Oct 2021 16:51:33 +0200
Message-Id: <20211011145140.359412-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011145140.359412-1-frederic@kernel.org>
References: <20211011145140.359412-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

While reporting a quiescent state for a given CPU, rcu_core() takes
advantage of the freshly loaded grace period sequence number and the
locked rnp to accelerate the callbacks whose sequence number have been
assigned a stale value.

This action is only necessary when the rdp isn't offloaded, otherwise
the NOCB kthreads already take care of the callbacks progression.

However the check for the offloaded state is volatile because it is
performed outside the IRQs disabled section. It's possible for the
offloading process to preempt rcu_core() at that point on PREEMPT_RT.

This is dangerous because rcu_core() may end up accelerating callbacks
concurrently with NOCB kthreads without appropriate locking.

Fix this with moving the offloaded check inside the rnp locking section.

Reported-and-tested-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b236271b9022..4869a6856bf1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2288,7 +2288,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	unsigned long flags;
 	unsigned long mask;
 	bool needwake = false;
-	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2315,8 +2314,10 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		/*
 		 * This GP can't end until cpu checks in, so all of our
 		 * callbacks can be processed during the next GP.
+		 *
+		 * NOCB kthreads have their own way to deal with that.
 		 */
-		if (!offloaded)
+		if (!rcu_rdp_is_offloaded(rdp))
 			needwake = rcu_accelerate_cbs(rnp, rdp);
 
 		rcu_disable_urgency_upon_qs(rdp);
-- 
2.25.1

