Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB35C433F5
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A78BD60EE5
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbhJKOyZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243520AbhJKOyS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Oct 2021 10:54:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5662960EBD;
        Mon, 11 Oct 2021 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633963938;
        bh=OLRwTLPmsyZPETfT3LBTzsYk5WO2bfKfwaIg3B+hfog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OcaRBOVBWBeHn4IlYNR6gdV5EAK1TbRNpz7ONAiX74jlg1nTvRKCOLSn53pO0gTdN
         oUGJ7804WuduPpkO30BBdo5jpZkZ9hfSRYjCTfqJCZVEAuNoaAThK5PoswXb7e+BeH
         XAMDvEKJhfI/enB06gqMzveVmixEjCCKBd6QEVSTwZ+XayCRClOTNwS+B9ZfbIdSSH
         UPx8O2M/HwpQ5LfS6I01KV8DBn2R/VSL4HWvxxXelwN9gXJVWD0J9L+vu1jN7wtnHu
         JbsDZc1p78RqBc/grH+XI7/kErWmEdTRCKCreCXyMsLwfBnAs5wo1CnfLsPVXLNKOE
         OeFDQfmkZM/LQ==
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
Subject: [PATCH 07/11] rcu/nocb: Use appropriate rcu_nocb_lock_irqsave()
Date:   Mon, 11 Oct 2021 16:51:36 +0200
Message-Id: <20211011145140.359412-8-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011145140.359412-1-frederic@kernel.org>
References: <20211011145140.359412-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Instead of hardcoding IRQ save and nocb lock, use the consolidated
API (and fix a comment as per Valentin Schneider's suggestion).

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
 kernel/rcu/tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 27500981d4b1..eaa9c7ce91bb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2488,12 +2488,11 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	}
 
 	/*
-	 * Extract the list of ready callbacks, disabling to prevent
+	 * Extract the list of ready callbacks, disabling IRQs to prevent
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

