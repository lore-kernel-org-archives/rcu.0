Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182A4C35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71A92082F
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581725942;
	bh=iVK3s2tfT6lPptAkJ01jWcx1WlzANXy4ULDzyR3GZYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gesk09q355Jx0R/pc464Vc5N50y37MNiRsaUBcV2xvQ5/EVvMETnJDCn3tMQ9dAQQ
	 C/cX9K/4kBvfq3EVVhof2AdZ8xHzJIE47UcBLCEjQ1FrkeLZW0YIi2Hlk9n1ZxK1F8
	 CwY5mDSvDxO0JZ69B3qy8cL/7UpTYiw8+Ve04w4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBOATB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:19:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgBOATB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:19:01 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C4412187F;
        Sat, 15 Feb 2020 00:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581725940;
        bh=iVK3s2tfT6lPptAkJ01jWcx1WlzANXy4ULDzyR3GZYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uiTuOE9AvUQ8auI2BxyrRcnx2tJI0IcviphOm48mArMC66fwoK7rE1XrGLTE4NxSN
         Gmst4gZKrZpl/A+PCyiwtB52BhC2jNxnsSEmbmIqZRc4GeyHsTLRygfRg+P4E2Jh39
         uDAmQDODq0iXu3GIOez3OjZ7hcL6JS/rt8XvvKXs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/5] rcu: React to callback overload by boosting RCU readers
Date:   Fri, 14 Feb 2020 16:18:43 -0800
Message-Id: <20200215001845.15432-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215001816.GA15284@paulmck-ThinkPad-P72>
References: <20200215001816.GA15284@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

RCU priority boosting currently is not applied until the grace period
is at least 250 milliseconds old (or the number of milliseconds specified
by the CONFIG_RCU_BOOST_DELAY Kconfig option).  Although this has worked
well, it can result in OOM under conditions of RCU callback flooding.
One can argue that the real-time systems using RCU priority boosting
should carefully avoid RCU callback flooding, but one can just as well
argue that an OOM is a rather obnoxious error message.

This commit therefore disables the RCU priority boosting delay when
there are excessive numbers of callbacks queued.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0be8fad..4d4637c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1079,7 +1079,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	    (rnp->gp_tasks != NULL &&
 	     rnp->boost_tasks == NULL &&
 	     rnp->qsmask == 0 &&
-	     ULONG_CMP_GE(jiffies, rnp->boost_time))) {
+	     (ULONG_CMP_GE(jiffies, rnp->boost_time) || rcu_state.cbovld))) {
 		if (rnp->exp_tasks == NULL)
 			rnp->boost_tasks = rnp->gp_tasks;
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-- 
2.9.5

