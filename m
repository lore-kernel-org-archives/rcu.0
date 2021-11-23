Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA24C433F5
	for <rcu@archiver.kernel.org>; Tue, 23 Nov 2021 00:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhKWAka (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231937AbhKWAk1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Nov 2021 19:40:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F70F60F70;
        Tue, 23 Nov 2021 00:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637627840;
        bh=Dr4/h+NQHreQm/AZUr+jLC88zQocF18H4nOZHLlG98g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYuHV6wrp0L6iRBRxd/KwrCljEV4i+AOZ+Gf/s5DIdTPedryxF39SPGVFHIFdoYP+
         QUE2+r4jQp+OlGd3KYiISujZc+QwbOWfdovxYPCuTom74qRIblZgexVxw5/k/QdRr2
         H3Y2kEG1BWh9qJKwgHArNVA6/M04TiAh9jMzDmqwSojNN2lPIdEbmqTE2oQLR3JVYD
         APt0AyCmdch5AOfsM03bxAaBcaR0++7L1J7ha3kucxrOiZhGGEHZEcwk8zjFRY+XLu
         AJueS6663Tj5/yz3qcSn8gGxzSYjkSjKqwx+F1ynwd96ncqu1a6FPnEYTm16nyJFMv
         CbZxcY67RU+dA==
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
Date:   Tue, 23 Nov 2021 01:37:04 +0100
Message-Id: <20211123003708.468409-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211123003708.468409-1-frederic@kernel.org>
References: <20211123003708.468409-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In order to be able to toggle the offloaded state from cpusets, a nocb
kthread will need to be created for all possible CPUs whenever the
"rcu_nocbs=" or "nohz_full=" parameters are passed.

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
index cc1165559177..e1cb06840454 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -797,6 +797,18 @@ static void nocb_cb_wait(struct rcu_data *rdp)
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
@@ -849,17 +861,6 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 
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

