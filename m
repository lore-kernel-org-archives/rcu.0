Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556CEC388F7
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FDE22240
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojkWV7xK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgKMMOH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:14:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgKMMOD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:14:03 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDDF422240;
        Fri, 13 Nov 2020 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269642;
        bh=O2YNfKfdbvZKEPzUFrnQ6SOg4WUfkuqB3OuXDbejqfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojkWV7xKIESVNFnNQJf8HHvtSah7AvRozj5hlf8zJRFFEIUogN0moMxK22zfQobN8
         6BAm/ABY6PIte75lKdfGKh9FXqmOTJg2qhFL3JEOpm/18/wVpSCDS8bWyqS77y1t4k
         v4f+M/p0DvLNlmnATuEkrgPIarZ7xUaZPg3X9rYI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: [PATCH 06/19] rcu/nocb: De-offloading GP kthread
Date:   Fri, 13 Nov 2020 13:13:21 +0100
Message-Id: <20201113121334.166723-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In order to de-offload the callbacks processing of an rdp, we must clear
SEGCBLIST_OFFLOAD and notify the GP kthread so that it clears its own
bit flag and ignore the target rdp from its loop. The CB kthread
is also notified the same way. Whoever acknowledges and clears its
own bit last must notify the de-offloading worker so that it can resume
the de-offloading while being sure that callbacks won't be handled
remotely anymore.

Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_plugin.h | 54 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5075bf219b23..10e7a8962a47 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1928,6 +1928,33 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
 	__call_rcu_nocb_wake(rdp, true, flags);
 }
 
+static inline bool nocb_gp_enabled_cb(struct rcu_data *rdp)
+{
+	u8 flags = SEGCBLIST_OFFLOADED | SEGCBLIST_KTHREAD_GP;
+
+	return rcu_segcblist_test_flags(&rdp->cblist, flags);
+}
+
+static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_state)
+{
+	struct rcu_segcblist *cblist = &rdp->cblist;
+
+	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
+		return true;
+	} else {
+		/*
+		 * De-offloading. Clear our flag and notify the de-offload worker.
+		 * We will ignore this rdp until it ever gets re-offloaded.
+		 */
+		WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
+		rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);
+		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
+			*needwake_state = true;
+		return false;
+	}
+}
+
+
 /*
  * No-CBs GP kthreads come here to wait for additional callbacks to show up
  * or for grace periods to end.
@@ -1956,8 +1983,17 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 */
 	WARN_ON_ONCE(my_rdp->nocb_gp_rdp != my_rdp);
 	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
+		bool needwake_state = false;
+		if (!nocb_gp_enabled_cb(rdp))
+			continue;
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
 		rcu_nocb_lock_irqsave(rdp, flags);
+		if (!nocb_gp_update_state(rdp, &needwake_state)) {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+			if (needwake_state)
+				swake_up_one(&rdp->nocb_state_wq);
+			continue;
+		}
 		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		if (bypass_ncbs &&
 		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
@@ -2221,7 +2257,8 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
 static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
-	bool wake_cb = false;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
+	bool wake_cb = false, wake_gp = false;
 	unsigned long flags;
 
 	printk("De-offloading %d\n", rdp->cpu);
@@ -2247,9 +2284,19 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	if (wake_cb)
 		swake_up_one(&rdp->nocb_cb_wq);
 
+	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
+	if (rdp_gp->nocb_gp_sleep) {
+		rdp_gp->nocb_gp_sleep = false;
+		wake_gp = true;
+	}
+	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
+
+	if (wake_gp)
+		wake_up_process(rdp_gp->nocb_gp_kthread);
+
 	swait_event_exclusive(rdp->nocb_state_wq,
-			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
-
+			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
+							SEGCBLIST_KTHREAD_GP));
 	return 0;
 }
 
@@ -2331,6 +2378,7 @@ void __init rcu_init_nohz(void)
 			rcu_segcblist_init(&rdp->cblist);
 		rcu_segcblist_offload(&rdp->cblist, true);
 		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
+		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
 	}
 	rcu_organize_nocb_kthreads();
 }
-- 
2.25.1

