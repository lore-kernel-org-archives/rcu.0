Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08265C56202
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC85F2085B
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVwEVqm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKMMPV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgKMMOV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:14:21 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 095722224C;
        Fri, 13 Nov 2020 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269660;
        bh=AxqLxiSfOX4K5X6IEiPxgLnChOMqGLJMiRAYXamrkj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVwEVqm9igwYSVDGFY7o1YZJm+blZ7QrghqVqKHa5fdUqIO4tfpFcQMOysIYZREUq
         2fUyHH2M9My9Hl2J0FccwPaa9kgePH4NYg0oF0lagXW5RdASLEx1mXolMT6ynSQlKV
         VADqqfCt/rd1mYzb/NHgYGnk++ansYre5WegE13M=
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
Subject: [PATCH 12/19] rcu/nocb: Process batch locally as long as offloading isn't complete
Date:   Fri, 13 Nov 2020 13:13:27 +0100
Message-Id: <20201113121334.166723-13-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

During the offloading or de-offloading process, make sure to process
the callbacks batch locally whenever the segcblist isn't entirely
offloaded. This enforces callback service processing while we are still
in intermediate (de-)offloading state.

CHECKME: Note that __call_rcu_core() isn't called during these intermediate
states. Some pieces there may still be necessary.

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
 kernel/rcu/rcu_segcblist.h | 12 ++++++++++++
 kernel/rcu/tree.c          |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index f42f7a13faa0..c8f4d4ac650f 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -92,6 +92,18 @@ static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
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
index da1ecf60c541..cc141337f3f9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2691,6 +2691,7 @@ static __latent_entropy void rcu_core(void)
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool do_batch = !rcu_segcblist_completely_offloaded(&rdp->cblist);
 
 	if (cpu_is_offline(smp_processor_id()))
 		return;
@@ -2720,7 +2721,7 @@ static __latent_entropy void rcu_core(void)
 	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
 
 	/* If there are callbacks ready, invoke them. */
-	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist) &&
+	if (do_batch && rcu_segcblist_ready_cbs(&rdp->cblist) &&
 	    likely(READ_ONCE(rcu_scheduler_fully_active)))
 		rcu_do_batch(rdp);
 
-- 
2.25.1

