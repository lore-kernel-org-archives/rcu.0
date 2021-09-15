Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D23AC433EF
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757EA61283
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhIOXfJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232929AbhIOXfE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C55661207;
        Wed, 15 Sep 2021 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748825;
        bh=BjlXYbFOl31ev3C3Ez5YMdXPBUC8U17GefDyk4NGw1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TTYF/hgJKli+PvqZINZwE/KzXmO1/0rHy6Y/7oB+bhqMf9sAEUT73SbG0ealWC+YI
         LLlEgy1ZbXz43Fo8YskisB0o8h8erc4ljlwSPmOi8wqbIDeUh+bHZvjEdTcx+MWd2e
         u2kGWU0EztbODBqBsCWtzdNuct1rxTq4Yc2y2MM7eavzMgRR/vEYLZ+qBSSwFByD9e
         EGGCXAFI6E3VegLH6rHW9OFR2UwYiuWp91lF4NkCGMqrtsaeQ3iLjNiPSbZV5nrpvJ
         nbQSkZnpNhHRFRtyt3vWzLbFL4ciFnEYJysmS8t2TT1Ws78ecbRqhWy+kzfNXmLj7H
         lJJB0JccMRhAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C709A5C09F9; Wed, 15 Sep 2021 16:33:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/14] rcu: Comment rcu_gp_init() code waiting for CPU-hotplug operations
Date:   Wed, 15 Sep 2021 16:33:36 -0700
Message-Id: <20210915233343.3906738-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Near the beginning of rcu_gp_init() is a per-rcu_node loop that waits
for CPU-hotplug operations that might have started before the new
grace period did.  This commit adds a comment explaining that this
wait does not exclude CPU-hotplug operations.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0bfebec94277..e6e1b9281530 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1775,6 +1775,8 @@ static noinline_for_stack bool rcu_gp_init(void)
 	 */
 	WRITE_ONCE(rcu_state.gp_state, RCU_GP_ONOFF);
 	rcu_for_each_leaf_node(rnp) {
+		// Wait for CPU-hotplug operations that might have
+		// started before this grace period did.
 		smp_mb(); // Pair with barriers used when updating ->ofl_seq to odd values.
 		firstseq = READ_ONCE(rnp->ofl_seq);
 		if (firstseq & 0x1)
-- 
2.31.1.189.g2e36527f23

