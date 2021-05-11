Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF40AC43611
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5D561933
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhEKWyW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhEKWyP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F65B61944;
        Tue, 11 May 2021 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773587;
        bh=Ud2n0T8oZD2qnxbpdVkRyBdjRbcSWf12xNXu/Qey03s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZsZUQPuRsU13u2ncYJUanG1pWSHRLRdJP8lVZ3Gh4VnHpW22mkCKYE+/WefPJ8694
         LV7wEoBMHHADMjYfOeiCOmf9ScYm/Q58Bko2WuZIeNQHQh1JjONsZoVz+BpJ+KtYH6
         rXhCj6Khw09JGiTroJFvdstaQVuRlv3e/UZExcD3cOp4PsU7LrplJE5Yy4vZ5WUW2o
         eKDbHFO5oYtZgin+XPIwSS/TUcEy1CeSS686F0KOngKY7f+tOCoOzXC8N/Pae9PNUO
         SEhP7o4CsigKU0J1Is4zu9Kj9gRh0ypPkNaf70Lcubf50G12mOvcsp6RsCEhOFl0Go
         4b4S9mj6QP9cQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9E7A65C0DFD; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/19] rcu: Make rcu_gp_cleanup() be noinline for tracing
Date:   Tue, 11 May 2021 15:52:58 -0700
Message-Id: <20210511225304.2893154-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Although there are trace events for RCU grace periods, these are only
enabled in CONFIG_RCU_TRACE=y kernels.  This commit therefore marks
rcu_gp_cleanup() noinline in order to provide a function that can be
traced that is invoked near the end of each grace period.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 00a3ebca70b8..6eb64e44bdcd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2026,7 +2026,7 @@ static void rcu_gp_fqs_loop(void)
 /*
  * Clean up after the old grace period.
  */
-static void rcu_gp_cleanup(void)
+static noinline void rcu_gp_cleanup(void)
 {
 	int cpu;
 	bool needgp = false;
-- 
2.31.1.189.g2e36527f23

