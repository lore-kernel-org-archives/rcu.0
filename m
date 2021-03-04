Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160C8C4332D
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8C964F09
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbhCDBBC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:48842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448499AbhCDAZz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:25:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2492564EF4;
        Thu,  4 Mar 2021 00:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817396;
        bh=OiSaEiNkEhwRX2z/bYu15I/KCOQQY7pPfHiI87nRh5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KqoBXGZFZcvVm5nUWsuf+KavqK2fgwNlDhaCOFkBWWlrdGwFNCMUXhAi2ektg6t4G
         nKUXFqyV5ZSHY6JGZhlJRKgFy0MmMU49fv6juC147JsI8ipYOrm7mL6sLjdt2WIoHv
         LC7X/lylenFTQcK7gXtBvjqCqtjHSoBYT3AgGnKBYS9sdWifcUmDTgNTZ0sjx8RRqK
         h0g04kS4U6IB9i62Bsb+6TNzpbDEDOwvsmb5XG74AFW8RYZ3Mx1MNvg6qRS7Wi9HJk
         94BTqekGcn2HfnCt5HZVz6tg/ikNP7uXFJvsmsh8CsR3fnR3WKdUP5xdXqxRWkI851
         H1FK0hSHaj3lQ==
From:   paulmck@kernel.org
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
Subject: [PATCH tip/core/rcu 12/12] rcu/nocb: Move trace_rcu_nocb_wake() calls outside nocb_lock when possible
Date:   Wed,  3 Mar 2021 16:23:11 -0800
Message-Id: <20210304002311.23655-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002225.GA23492@paulmck-ThinkPad-P72>
References: <20210304002225.GA23492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Those tracing calls don't need to be under ->nocb_lock.  This commit
therefore moves them outside of that lock.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b08564b..9846c8a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1703,9 +1703,9 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force,
 
 	lockdep_assert_held(&rdp->nocb_lock);
 	if (!READ_ONCE(rdp_gp->nocb_gp_kthread)) {
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 				    TPS("AlreadyAwake"));
-		rcu_nocb_unlock_irqrestore(rdp, flags);
 		return false;
 	}
 
@@ -1955,9 +1955,9 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	// If we are being polled or there is no kthread, just leave.
 	t = READ_ONCE(rdp->nocb_gp_kthread);
 	if (rcu_nocb_poll || !t) {
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 				    TPS("WakeNotPoll"));
-		rcu_nocb_unlock_irqrestore(rdp, flags);
 		return;
 	}
 	// Need to actually to a wakeup.
@@ -1992,8 +1992,8 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 					   TPS("WakeOvfIsDeferred"));
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 	} else {
-		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 		rcu_nocb_unlock_irqrestore(rdp, flags);
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 	}
 	return;
 }
-- 
2.9.5

