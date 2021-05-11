Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77563C43460
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548866192F
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhEKWyX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhEKWyP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3175061946;
        Tue, 11 May 2021 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773587;
        bh=wUdaSFc5MlL9R/weJL4BK5WyqaGeP7pB4eQbiGMG6yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/fr6QW0V/VZdgWxNBBpjHn4Lk1HYwNkpQgZK/q+Fn1A1baU3cjUDes4GebZnmDrn
         Mc2e0K2VIV/Lclr78u9W83aAD3GZAp2RgOK9TNqBejOaT61rRccZ8DB/whFRldmVk3
         5blJOq8xvZjHcOs8fBlrgiqjBq+LKE1fWmgf9m40JF9qXf57nXsTu4kuI4kF5gk+PR
         i9KD6Rx10XA6OXZtPCOXCo/rZuvuPE2RAYwR/V9pcfueEKSxpKJ5V2tdAjaRQ3w7Yb
         jzOBPjxLm88b1yXDGuM2Aa1UplWGGgwWEGRTMqO4L3u23iJYBdD8yy0fU1sdA8xIuZ
         93K99Itz0hehQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9B26B5C0DF3; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/19] rcu: Make show_rcu_gp_kthreads() dump rcu_node structures blocking GP
Date:   Tue, 11 May 2021 15:52:56 -0700
Message-Id: <20210511225304.2893154-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, show_rcu_gp_kthreads() only dumps rcu_node structures that
have outdated ideas of the current grace-period number.  This commit
also dumps those that are in any way blocking the current grace period.
This helps diagnose RCU priority boosting failures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index c1f83864a18e..e6bd518e0bc4 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -746,8 +746,9 @@ void show_rcu_gp_kthreads(void)
 		data_race(rcu_state.gp_max),
 		data_race(rcu_state.gp_flags));
 	rcu_for_each_node_breadth_first(rnp) {
-		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
-				 READ_ONCE(rnp->gp_seq_needed)))
+		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq), READ_ONCE(rnp->gp_seq_needed)) &&
+		    !data_race(rnp->qsmask) && !data_race(rnp->boost_tasks) &&
+		    !data_race(rnp->exp_tasks) && !data_race(rnp->gp_tasks))
 			continue;
 		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
 			rnp->grplo, rnp->grphi,
-- 
2.31.1.189.g2e36527f23

