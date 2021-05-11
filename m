Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EBDC43461
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB3161925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhEKXEr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhEKXEp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:04:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9531661919;
        Tue, 11 May 2021 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774218;
        bh=tTSEGsPeJpal4Gw1QbQbcE7Z/PUHV59MCh8YZrEBrx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdOdUKNV2OAuHz3rUiOosNLr/9lPZJiTWKg3zbceQoT1i3K7nrACon8Tlw0Un++pm
         bpIy6NWl4VJAd7hl5dpjVFbVtGvJF+Ap2J8HAV8DQ1o/t52BaPssYseDKT1QpIGjVg
         1mynzbUWrp+jVk2DYAPhekYPq8q14DV3y2RVlKuvdrLo9V35yfINUFM7AABkAtVBzL
         b8fZ+hS9c2Nk117BsVzlcV4IbHmv88jan9N7cPMMrKsHp67ddKT8Ch+dsWd3QcvecX
         3iQmoG3UaV77mJGrHNdBC2QuqcAB4TTluNKlUaIvYrEGCy9NLK0OR728bJLA//ijNM
         /n3BVkbUEuZpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5D4085C09EF; Tue, 11 May 2021 16:03:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/10] rcu/nocb: Directly call __wake_nocb_gp() from bypass timer
Date:   Tue, 11 May 2021 16:03:29 -0700
Message-Id: <20210511230336.2894314-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

The bypass timer calls __call_rcu_nocb_wake() instead of directly
calling __wake_nocb_gp().  The only difference here is that
rdp->qlen_last_fqs_check gets overriden.  But resetting the deferred
force quiescent state base shouldn't be relevant for that timer.  In fact
the bypass queue in question can be for any rdp from the group and not
necessarily the rdp leader on which the bypass timer is attached.

This commit therefore calls __wake_nocb_gp() directly.  This way we
don't even need to lock the ->nocb_lock.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5a2aa9c4e569..82e9ffb92347 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2015,9 +2015,10 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
 	struct rcu_data *rdp = from_timer(rdp, t, nocb_bypass_timer);
 
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
-	rcu_nocb_lock_irqsave(rdp, flags);
+
+	raw_spin_lock_irqsave(&rdp->nocb_gp_lock, flags);
 	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
-	__call_rcu_nocb_wake(rdp, true, flags);
+	__wake_nocb_gp(rdp, rdp, false, flags);
 }
 
 /*
-- 
2.31.1.189.g2e36527f23

