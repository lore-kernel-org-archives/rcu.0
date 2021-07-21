Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698CBC6379C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5134A61244
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbhGUTlB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240396AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEF6761376;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898890;
        bh=gYGT2TdvW7CGqArE81oxQ37v9JGE/2qRSNuOECdP1Rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lQ1Wn3tIm2vxQZfPGlY2NHQYdQTegLvtZn2RDZh/N5LylHnD0LLqX60zD7dxXAbxy
         yg9KY5hEGHYA8NNaP+xM/SWgk7zlmCCY1q0ehgL2uckUOLoz/tAPo/digk9X1ChiMW
         Z4wDLYhm3CZAlnZ4IZ68FLv/Ryy6GdwrsuwUpsQ69Qv96d3xcR4ROsIPUiixTzVD0+
         FOiKF2H11qiHazh+oDkPXEt4H9ym6MfBkmFXJqVQpjNZrwLgfK+skzey4qdMpGUVJW
         yniGD9WCJ13yWw60miCH85s9kGif2QkpLe8x/nI1eGrOA5ANHeapbiad7F74tjSASR
         +CtpH8Qqu/Mdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4DA995C2315; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 18/18] rcu: Print human-readable message for schedule() in RCU reader
Date:   Wed, 21 Jul 2021 13:21:26 -0700
Message-Id: <20210721202127.2129660-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The WARN_ON_ONCE() invocation within the CONFIG_PREEMPT=y version of
rcu_note_context_switch() triggers when there is a voluntary context
switch in an RCU read-side critical section, but there is quite a gap
between the output of that WARN_ON_ONCE() and this RCU-usage error.
This commit therefore converts the WARN_ON_ONCE() to a WARN_ONCE()
that explicitly describes the problem in its message.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 83a702a4e2963..e8b45ab72a799 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -346,7 +346,7 @@ void rcu_note_context_switch(bool preempt)
 
 	trace_rcu_utilization(TPS("Start context switch"));
 	lockdep_assert_irqs_disabled();
-	WARN_ON_ONCE(!preempt && rcu_preempt_depth() > 0);
+	WARN_ONCE(!preempt && rcu_preempt_depth() > 0, "Voluntary context switch within RCU read-side critical section!");
 	if (rcu_preempt_depth() > 0 &&
 	    !t->rcu_read_unlock_special.b.blocked) {
 
-- 
2.31.1.189.g2e36527f23

