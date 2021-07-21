Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7206EC6377B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E19961222
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhGUTrG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231247AbhGUTrF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:47:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E282D61241;
        Wed, 21 Jul 2021 20:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626899261;
        bh=bY2h45O1WGp4EAcbrVOvoTnaHbm43ttm/JmeBcWYJwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZzTmQPPOZ+VZkiybRvFq0WduwGXe4tAlzN4nL+YUsjj2cgRssBvCucq9Eiap9eSP
         v/djQadojNyT77NMk2CvrkOupnwQGimf5pm+XaplfNnGI9MbkSquPgWrZOmDzG9h6k
         ni5XQX8zi9tWl8zJqWF5bNEteUzSYGT5CHnxwmnuhV9A/pQx2hyqXiSF0lV8Dms3eo
         llOO0kfFLx6T484eth6Senl4Gp5zMwpV5akZt9eYjet3Cn3qOmeZqzMC7dTFsCUBKS
         cqBpNQ+JH4LOZ5oGFVCZSa9qeuoJHnoqWDfcas2TroAa7C7JMjkIYXnETD4M+u45H3
         bSDA6zJF5YBMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B4EEB5C0A03; Wed, 21 Jul 2021 13:27:41 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/2] rcu/nocb: Remove NOCB deferred wakeup from rcutree_dead_cpu()
Date:   Wed, 21 Jul 2021 13:27:39 -0700
Message-Id: <20210721202739.2784140-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202716.GA2679705@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202716.GA2679705@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

At CPU offline time, we must handle any pending wakeup for the nocb_gp
kthread linked to the outgoing CPU.

Now we are making sure of that twice:

1) From rcu_report_dead() when the outgoing CPU makes the very last
   local cleanups by itself before switching offline.

2) From rcutree_dead_cpu(). Here the offlining CPU has gone and is truly
   now offline. Another CPU takes care of post-portem cleaning up and
   check if the offline CPU had pending wakeup.

Both ways are fine but we have to choose one or the other because we
don't need to repeat that action. Simply benefit from cache locality
and keep only the first solution.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b6eb480402e05..0fda98a0d12e9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2471,9 +2471,6 @@ int rcutree_dead_cpu(unsigned int cpu)
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
 	/* Adjust any no-longer-needed kthreads. */
 	rcu_boost_kthread_setaffinity(rnp, -1);
-	/* Do any needed no-CB deferred wakeups from this CPU. */
-	do_nocb_deferred_wakeup(per_cpu_ptr(&rcu_data, cpu));
-
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
 	return 0;
-- 
2.31.1.189.g2e36527f23

