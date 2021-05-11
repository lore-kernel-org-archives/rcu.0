Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB4AC433B4
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED83761432
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhEKW40 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhEKW4Z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:56:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6972D61184;
        Tue, 11 May 2021 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773718;
        bh=+wNMvDFSm5zQM5DKXkwEgFct5QFOXlYkVHbBJ0esl5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4koPlP6+H89Nby0U2S4lg4qpUgidZxhPVLZNdWn+IPyZZwGT1gvK2GevfK0Rmwiu
         3whq/d8D8Nxd8BSfTP/wXusg0RMYoAD2IxxZ4CorsUI9ZpGzg/gyHDc1n2zRt/G9EP
         Ch7Z6EcOFvPrC7BuH7E9WqWt1QjvXmq/6oFfg82i1+qXxN0siTerFT0hLsqt7o5D/D
         sKkL5BVub56q4w8cG0MMoZmLildBo4cWIprp3vnw3NJo+4VRjScIKnJzKxaPWowlI1
         LGBvFofc9CCCQ6+DP6JEuqhD0LBosk2fO35nXKBWvnZ1iD95QRYHBak7K5+Sm1nPAt
         63U4s8MkyFAuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0CC965C0B55; Tue, 11 May 2021 15:55:18 -0700 (PDT)
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
Subject: [PATCH tip/core/rcu 4/7] kvfree_rcu: Update "monitor_todo" once a batch is started
Date:   Tue, 11 May 2021 15:55:13 -0700
Message-Id: <20210511225516.2893420-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Before attempting to start a new batch the "monitor_todo" variable is
set to "false" and set back to "true" when a previous RCU batch is still
in progress.  This is at best confusing.

Thus change this variable to "false" only when a new batch has been
successfully queued, otherwise, just leave it be.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e86f32d6b8f9..1ae5f88e475f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3442,15 +3442,14 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 					  unsigned long flags)
 {
 	// Attempt to start a new batch.
-	krcp->monitor_todo = false;
 	if (queue_kfree_rcu_work(krcp)) {
 		// Success! Our job is done here.
+		krcp->monitor_todo = false;
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 		return;
 	}
 
 	// Previous RCU batch still in progress, try again later.
-	krcp->monitor_todo = true;
 	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
-- 
2.31.1.189.g2e36527f23

