Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3BFC43616
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C965B61260
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhEKWyW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhEKWyP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B6FF61958;
        Tue, 11 May 2021 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773587;
        bh=EotQ6cg7YP76P2IiUcgViwV/juVh+1b5V3AQ01poaqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sjVhl1SYcF/nSFYdhPCGq2qvIXT/fxMkEvg7YDg5Rjqv2t8dV7M7zhdXZZD0+5PQl
         dJjBqeX5Jcdgi2wDdGQLBQCvWMY/r31gZOwP2UL7348Yax0fbGF6m5MjzK92x46BKE
         KLXZdMHcIc9x212F6/w0JsFeoaQHqQx18m2mLrgO6WNR5hsZtvUg64DSl/3xIoZXh5
         wylgTxbyHJ5oUWfxhg/ZzY3VpehLuDcXiOofvtkj3nQIjj0ZNXcv31qj3y9kgTvWvG
         8Ig2/c9cV8jLiFtUWzUM1ULfQzr0K4QjIbuCUGhC4/7TOd4dQ+5r0FTBwxfkuUsHkU
         MyZyBd+5SE/Nw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A9D2D5C0E5C; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Jules Irenge <jbi.octave@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/19] rcu: Add missing __releases() annotation
Date:   Tue, 11 May 2021 15:53:04 -0700
Message-Id: <20210511225304.2893154-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Jules Irenge <jbi.octave@gmail.com>

Sparse reports a warning at rcu_print_task_stall():

"warning: context imbalance in rcu_print_task_stall - unexpected unlock"

The root cause is a missing annotation on rcu_print_task_stall().

This commit therefore adds the missing __releases(rnp->lock) annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index e6bd518e0bc4..ffb8cf6c6437 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -314,6 +314,7 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
  * tasks blocked within RCU read-side critical sections.
  */
 static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
+	__releases(rnp->lock)
 {
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	return 0;
-- 
2.31.1.189.g2e36527f23

