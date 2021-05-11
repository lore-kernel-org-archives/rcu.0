Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBE8C43461
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963E861928
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhEKW41 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230017AbhEKW4Z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:56:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CDE661421;
        Tue, 11 May 2021 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773718;
        bh=lSGOxx3+YkiZSRfEEFSU9OlYaV3B+jh4/sXJDRwctj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EnZgMNPSd7yxriCalMHubFyLT0Du1ub8D96PCs2wIO5++xcyQxxD4VXq8VLqiibPj
         UMnImQ0TYYx88d94aQRaKX0senxXimVCVrwnIpcLxTtGkMecKBPK5hlejA/VdOrJ2e
         2pFNgmltMqg9BicAgHuf+COd/tG7VwoEiJclGc35PJAA2JpzFG28fq3W5A8NWTUyqg
         dPB5S0N7ImkghapbbUYHhXAVBJQRwUSnGmAB8gnZNli+OeGQkoOpQCqesEdLoKnQJR
         jYLbTNdjrHq5ecUAHLNHGPPA/nH7v/z6uu6iQcpknSCf/pEnkmrI1afHvTTwjbFlYV
         JiZrZ7W5YUMMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0EB405C0D4A; Tue, 11 May 2021 15:55:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 5/7] kvfree_rcu: Use kfree_rcu_monitor() instead of open-coded variant
Date:   Tue, 11 May 2021 15:55:14 -0700
Message-Id: <20210511225516.2893420-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Replace an open-coded version of the kfree_rcu_monitor() function body
with a call to that function.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1ae5f88e475f..d643fd8327b6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3697,7 +3697,6 @@ static unsigned long
 kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu, freed = 0;
-	unsigned long flags;
 
 	for_each_possible_cpu(cpu) {
 		int count;
@@ -3705,12 +3704,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 
 		count = krcp->count;
 		count += drain_page_cache(krcp);
-
-		raw_spin_lock_irqsave(&krcp->lock, flags);
-		if (krcp->monitor_todo)
-			kfree_rcu_drain_unlock(krcp, flags);
-		else
-			raw_spin_unlock_irqrestore(&krcp->lock, flags);
+		kfree_rcu_monitor(&krcp->monitor_work.work);
 
 		sc->nr_to_scan -= count;
 		freed += count;
-- 
2.31.1.189.g2e36527f23

