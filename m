Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76784C56202
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E9242085B
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yHTWZTHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgKMMOV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:14:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgKMMOM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:14:12 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D908622256;
        Fri, 13 Nov 2020 12:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269651;
        bh=IjHN6FJZQNuUqJqIsvv8P68KcVqB1SYMXMfYEjj/c5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yHTWZTHs+SFXiT5zex/ZgHWnqHKcuzen8jAVom2WRksmzln3hhcavIWLaVZrNCicb
         +ztfT0P+oP/WY0ycwsrke3mKw0YA5HZo88YR85VxzR7nfkEUw9iK5JT01IWLqoy2mB
         H6zDowpDS9QlOSpTvXg4g3BueVLsRMmXh7/pgp3c=
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
Subject: [PATCH 09/19] rcu: Flush bypass before setting SEGCBLIST_SOFTIRQ_ONLY
Date:   Fri, 13 Nov 2020 13:13:24 +0100
Message-Id: <20201113121334.166723-10-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Make sure to handle the pending bypass queue before we switch to the
final de-offload state. We'll have to be careful and later set
SEGCBLIST_SOFTIRQ_ONLY before re-enabling again IRQs, or new bypass
callbacks could be queued in the meantine.

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
 kernel/rcu/tree_plugin.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 44b4ab9b3953..dfb4b62c6b88 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2339,12 +2339,21 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
+	rcu_nocb_lock_irqsave(rdp, flags);
 	/* Make sure nocb timer won't stay around */
-	rcu_nocb_lock_irqsave(rdp, flags);
 	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_OFF);
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 	del_timer_sync(&rdp->nocb_timer);
 
+	/*
+	 * Flush bypass. While IRQs are disabled and once we set
+	 * SEGCBLIST_SOFTIRQ_ONLY, no callback is supposed to be
+	 * enqueued on bypass.
+	 */
+	rcu_nocb_lock_irqsave(rdp, flags);
+	rcu_nocb_flush_bypass(rdp, NULL, jiffies);
+	rcu_nocb_unlock_irqrestore(rdp, flags);
+
 	return ret;
 }
 
-- 
2.25.1

