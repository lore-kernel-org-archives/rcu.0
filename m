Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD667C433FE
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6251611C8
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhIOXfH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232921AbhIOXfE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4494F611EE;
        Wed, 15 Sep 2021 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748825;
        bh=iKxtBFtnlFJKCzP28q4TeWj9wDiFG/P/SG4jrI0Qdxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXADJ5myXBrYC2USO+d358WPGtDh9ermM/ZBPZ59iHEytHTfbdNFwyU0MQUtow2Ir
         MnyBrVw0AZRGgbUPGtb6mTiK4ZK6UQps362nTxEolzjsXINiFOe1qYZyOiwLlY1JGd
         5V0Vo5dhAdBDHmGwKOkeGr9VLP+ogNIBoNoZAKtG5gZtSrikhmi4d1cEqpOE46n5vi
         1HLWt/2lOeDRReq1GkQt4fwkJGEZRcWo0JzNcz8Dd5X5sDkEWLKiAhzk00dkuwMC6x
         Js3yziM1GZPd255/UG+5KhAmimmSJeHBgVkAhB0gR1i+YRYoMAOo2UFC15EoyNNLou
         EQSQMjZjOFLIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CCA815C0CCE; Wed, 15 Sep 2021 16:33:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/14] rcu: Make rcutree_dying_cpu() use its "cpu" parameter
Date:   Wed, 15 Sep 2021 16:33:39 -0700
Message-Id: <20210915233343.3906738-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The CPU-hotplug functions take a "cpu" parameter, but rcutree_dying_cpu()
ignores it in favor of this_cpu_ptr().  This works at the moment, but
it would be better to be consistent.  This might also work better given
some possible future changes.  This commit therefore uses per_cpu_ptr()
to avoid ignoring the rcutree_dying_cpu() function's argument.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index dc2968473593..6a1e9d3374db 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2356,7 +2356,7 @@ rcu_check_quiescent_state(struct rcu_data *rdp)
 int rcutree_dying_cpu(unsigned int cpu)
 {
 	bool blkd;
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
-- 
2.31.1.189.g2e36527f23

