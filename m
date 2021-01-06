Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A83CC4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397BC22CE3
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbhAFEua (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:50:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbhAFEuT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D2A6230FD;
        Wed,  6 Jan 2021 04:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908537;
        bh=D1m3BF8ayF7685no0WewgN1Fftbnj9LqYHWO2mgiERY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGkpvwnXNULHDLrVZokN5O3NOMsQSz5NImNcv12mKxgHxvYQCECtUyoXfNeYhaOVv
         Y2aIXMdzllpukU24Rtw3OUYlqdGITeMk+w7ZGxiQ9lUrLklLNdAelp3YBSw7POJmFK
         kC14zxjCXPGTTFyM2YgH3Qe7nTtUJomBnlou3odsH9LcIEyIQL41ugFvOtLvUnBq6f
         nOCk7/Z33AlEpXgVO+0rIlsXhiKFXrCGXZgAf5lkNVhpmoWMKIrKcbiTvTIkS4zmhL
         NfqCQra8EKcwWUxf7hnF7tmD3QZxbvheHCTO7HsQx9Vd+Fd/j9APj5qfiaLJfGfX70
         tiPc3KUgBUTdw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/21] rcu/nocb: Process batch locally as long as offloading isn't complete
Date:   Tue,  5 Jan 2021 20:48:44 -0800
Message-Id: <20210106044853.20812-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

This commit makes sure to process the callbacks locally (via either
RCU_SOFTIRQ or the rcuc kthread) whenever the segcblist isn't entirely
offloaded.  This ensures that callbacks are invoked one way or another
while a CPU is in the middle of a toggle operation.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.h | 12 ++++++++++++
 kernel/rcu/tree.c          |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 28c9a52..afad6fc 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -95,6 +95,18 @@ static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 	return false;
 }
 
+static inline bool rcu_segcblist_completely_offloaded(struct rcu_segcblist *rsclp)
+{
+	int flags = SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP | SEGCBLIST_OFFLOADED;
+
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU)) {
+		if ((rsclp->flags & flags) == flags)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Are all segments following the specified segment of the specified
  * rcu_segcblist structure empty of callbacks?  (The specified
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4ef59a5..ec14c01 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2700,6 +2700,7 @@ static __latent_entropy void rcu_core(void)
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool do_batch = !rcu_segcblist_completely_offloaded(&rdp->cblist);
 
 	if (cpu_is_offline(smp_processor_id()))
 		return;
@@ -2729,7 +2730,7 @@ static __latent_entropy void rcu_core(void)
 	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
 
 	/* If there are callbacks ready, invoke them. */
-	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist) &&
+	if (do_batch && rcu_segcblist_ready_cbs(&rdp->cblist) &&
 	    likely(READ_ONCE(rcu_scheduler_fully_active)))
 		rcu_do_batch(rdp);
 
-- 
2.9.5

