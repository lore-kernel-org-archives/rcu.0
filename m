Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAA1C4332B
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 04:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9172313B
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 04:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbhATEdb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Jan 2021 23:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbhATEdT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Jan 2021 23:33:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A21C32332B;
        Wed, 20 Jan 2021 04:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611117159;
        bh=C2eCzqPlT6BpIIK6gpaGBighn/FNw3gd4qUeJ00kb6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqbv/AxDOn1jEDC5ESSTjZLSC+xh4Fl7Fi8ZP3ADBgzOxW3K2pjUNsmBRMiII9qSU
         k+dkDB9Na6Bl97V79Wgxk0AKT9eaJgeAtxo/d7ivDTtIFH4VTuwPZ9bWmAbvYVB7Po
         1bv9r1Fu7x0Lw9ZF8PgEhpV5Wh6EN8yvshw4vo9OWSaS9fgaleRqmsiPysBsFaB8nC
         OWKyrC5ojnnSi//LWBkg+cNJnCbaefhKvyhwvsfGAmrXRbXP3eKOh3rlp5c6orv0t7
         88F8kx7DCbA1CzMTqIIgO9Hm2sGO+Z5WxzaDopT+nwg+gUxnlaiOHwbuZvtVWDatWK
         0ayuo1UznURuA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH tip/core/rcu 3/4] rcu: Run rcuo kthreads at elevated priority in CONFIG_RCU_BOOST kernels
Date:   Tue, 19 Jan 2021 20:32:35 -0800
Message-Id: <20210120043236.7254-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210120043144.GA7045@paulmck-ThinkPad-P72>
References: <20210120043144.GA7045@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The priority level of the rcuo kthreads is the system administrator's
responsibility, but kernels that priority-boost RCU readers probably need
the rcuo kthreads running at the rcutree.kthread_prio level.  This commit
therefore sets these kthreads to that priority level at creation time,
providing a sensible default.  The system administrator is free to adjust
as needed at any time.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Scott Wood <swood@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fca31c6..7e33dae0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2197,6 +2197,7 @@ static int rcu_nocb_gp_kthread(void *arg)
 {
 	struct rcu_data *rdp = arg;
 
+	rcu_cpu_kthread_setup(-1);
 	for (;;) {
 		WRITE_ONCE(rdp->nocb_gp_loops, rdp->nocb_gp_loops + 1);
 		nocb_gp_wait(rdp);
@@ -2298,6 +2299,7 @@ static int rcu_nocb_cb_kthread(void *arg)
 
 	// Each pass through this loop does one callback batch, and,
 	// if there are no more ready callbacks, waits for them.
+	rcu_cpu_kthread_setup(-1);
 	for (;;) {
 		nocb_cb_wait(rdp);
 		cond_resched_tasks_rcu_qs();
-- 
2.9.5

