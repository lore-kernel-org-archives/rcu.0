Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45148C433FE
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 15:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C16061BFA
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 15:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbhKQP7t (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:59:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238824AbhKQP7r (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 10:59:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36FE661BFA;
        Wed, 17 Nov 2021 15:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637164609;
        bh=TPBhqafTAPoIyGqVQFC4YAlNibLp53CChd60beVYa6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rR4NemBf4Y+VUgGq6jNiEGGXZ0B7elTC+dRtcR5FE5LfLDktr6zVPPIwOIkXXsLNV
         1OdKZWS5LHMZAZuhK4/uTEVwU634RUjtmNxFgS9r2BRFv7RVajqiuAsSMVzGEQ5QSS
         XG3H5XYHxIOa3sH8zLs8kolAPVLffSmUonXQdP8cay1YLO1B5cqjTHAvINHTBsgT/1
         +Sohfj64i+ROR6CcgFMZtzupHkIC/VRq7F3EstlR/I4sKLgj/T2PfgtXiCB+3B2Xew
         nJMm46IMizGVGKUztTGom7BfM52EN8tyYw+sF7MmjbLbT+gnJzCqfiw135SViJ/mCZ
         SbDHS7vaI4VYQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 2/6] rcu/nocb: Prepare nocb_cb_wait() to start with a non-offloaded rdp
Date:   Wed, 17 Nov 2021 16:56:33 +0100
Message-Id: <20211117155637.363706-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117155637.363706-1-frederic@kernel.org>
References: <20211117155637.363706-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In order to be able to toggle the offloaded state from cpusets, a nocb
kthread will need to be created for all possible CPUs whenever the
"rcu_nocbs=" parameter is passed.

Therefore nocb_cb_wait() kthread must prepare to start running on a
de-offloaded rdp. Simply move the sleeping condition in the beginning
of the kthread callback is enough to prevent from running callbacks
before the rdp ever becomes offloaded.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index e728128be02a..0543d5e913bb 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -789,6 +789,18 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	bool can_sleep = true;
 	struct rcu_node *rnp = rdp->mynode;
 
+	do {
+		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
+						    nocb_cb_wait_cond(rdp));
+
+		// VVV Ensure CB invocation follows _sleep test.
+		if (smp_load_acquire(&rdp->nocb_cb_sleep)) { // ^^^
+			WARN_ON(signal_pending(current));
+			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
+		}
+	} while (!nocb_cb_can_run(rdp));
+
+
 	local_irq_save(flags);
 	rcu_momentary_dyntick_idle();
 	local_irq_restore(flags);
@@ -841,17 +853,6 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 
 	if (needwake_state)
 		swake_up_one(&rdp->nocb_state_wq);
-
-	do {
-		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
-						    nocb_cb_wait_cond(rdp));
-
-		// VVV Ensure CB invocation follows _sleep test.
-		if (smp_load_acquire(&rdp->nocb_cb_sleep)) { // ^^^
-			WARN_ON(signal_pending(current));
-			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
-		}
-	} while (!nocb_cb_can_run(rdp));
 }
 
 /*
-- 
2.25.1

