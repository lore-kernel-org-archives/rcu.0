Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A65C43460
	for <rcu@archiver.kernel.org>; Wed, 19 May 2021 00:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28FD561369
	for <rcu@archiver.kernel.org>; Wed, 19 May 2021 00:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352256AbhESAK6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 May 2021 20:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233435AbhESAK6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 May 2021 20:10:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6425460FF1;
        Wed, 19 May 2021 00:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621382979;
        bh=w1sRwjCUGzp468nhcMNWkshNtD5uW1LnyYfli6fztT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WP/JCn0RNVeuH3qL2sfV47gI3SBi0HybW4eKjNdnWzoWibYaSIKduncPB/BoR78sY
         NzUL8NycDZuLQuUdObVUfvZy7zCRpgAX1YKXA85H6hUjAAojaebsmB01jameJsKurJ
         xl1J6uwAiTSJWUV6zusjKH76JHsCY5Y5eMP1lceKPgO0686rfGKl6s5HQ9IoJxUH9J
         XOXpyvRU4vKjCOJRWFrbz3VulkDPxqatU/K5kIzHfyQH8QXeUiea54I9kWpobyVPH7
         2z9flfiZDUHjLUPrEwraDzjVJvpGueMHYL3UoxNQSoSvEqZ7/m4jLvznvpwSOp5IpN
         vUujSx27P5ntQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: [PATCH 2/3] rcu/nocb: Remove NOCB deferred wakeup from rcutree_dead_cpu()
Date:   Wed, 19 May 2021 02:09:29 +0200
Message-Id: <20210519000930.15702-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519000930.15702-1-frederic@kernel.org>
References: <20210519000930.15702-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

At CPU offline time, we make sure to flush any pending wakeup for the
nocb_gp kthread linked to the outgoing CPU.

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
---
 kernel/rcu/tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 28f1093027b9..a6b448e6e059 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2469,9 +2469,6 @@ int rcutree_dead_cpu(unsigned int cpu)
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
2.25.1

