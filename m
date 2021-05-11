Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6304C43460
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D3E61925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhEKWyT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230320AbhEKWyP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20BC861940;
        Tue, 11 May 2021 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773587;
        bh=zqWSt7mdCZDZMSepNpHEhs2zC/B9ca2+lQbeD8jY2xQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2aHEIi7SL+6uOWjff4jm3LYSjJADiD8Sc1Bv4r9pzpgekOusgMeMVCowpoOWUzNS
         Kwui8/7Qc1cqkMmkOnbgjl83RbBiWBia5QMYNcI+XRITotJY/acJOJTPyZsNQgLR1O
         wTCL3moRsdFDsN6TKr1AjcfU9ojZozV1w+OgJORxx1vowu971Bddk+73VyyfczBxXr
         uyN36E1OWJaw2K43CiTeLBSeXZXvQ2+M95/kkXz9K9Li0h8/vbNudxnUgCL+AiLggr
         J5MBEwHLbtdq/3VEme0VJzuv5B4OJSpCP/8hpiZQoKuMMQqffwSoUeMoYOQyz1b3Fx
         Uil9gpxqAOB8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 95F5B5C0DE5; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        syzbot+dde0cc33951735441301@syzkaller.appspotmail.com,
        Matthew Wilcox <willy@infradead.org>,
        syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH tip/core/rcu 08/19] rcu: Reject RCU_LOCKDEP_WARN() false positives
Date:   Tue, 11 May 2021 15:52:53 -0700
Message-Id: <20210511225304.2893154-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

If another lockdep report runs concurrently with an RCU lockdep report
from RCU_LOCKDEP_WARN(), the following sequence of events can occur:

1.	debug_lockdep_rcu_enabled() sees that lockdep is enabled
	when called from (say) synchronize_rcu().

2.	Lockdep is disabled by a concurrent lockdep report.

3.	debug_lockdep_rcu_enabled() evaluates its lockdep-expression
	argument, for example, lock_is_held(&rcu_bh_lock_map).

4.	Because lockdep is now disabled, lock_is_held() plays it safe and
	returns the constant 1.

5.	But in this case, the constant 1 is not safe, because invoking
	synchronize_rcu() under rcu_read_lock_bh() is disallowed.

6.	debug_lockdep_rcu_enabled() wrongly invokes lockdep_rcu_suspicious(),
	resulting in a false-positive splat.

This commit therefore changes RCU_LOCKDEP_WARN() to check
debug_lockdep_rcu_enabled() after checking the lockdep expression,
so that any "safe" returns from lock_is_held() are rejected by
debug_lockdep_rcu_enabled().  This requires memory ordering, which is
supplied by READ_ONCE(debug_locks).  The resulting volatile accesses
prevent the compiler from reordering and the fact that only one variable
is being accessed prevents the underlying hardware from reordering.
The combination works for IA64, which can reorder reads to the same
location, but this is defeated by the volatile accesses, which compile
to load instructions that provide ordering.

Reported-by: syzbot+dde0cc33951735441301@syzkaller.appspotmail.com
Reported-by: Matthew Wilcox <willy@infradead.org>
Reported-by: syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 2 +-
 kernel/rcu/update.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 9455476c5ba2..1199ffd305d1 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -315,7 +315,7 @@ static inline int rcu_read_lock_any_held(void)
 #define RCU_LOCKDEP_WARN(c, s)						\
 	do {								\
 		static bool __section(".data.unlikely") __warned;	\
-		if (debug_lockdep_rcu_enabled() && !__warned && (c)) {	\
+		if ((c) && debug_lockdep_rcu_enabled() && !__warned) {	\
 			__warned = true;				\
 			lockdep_rcu_suspicious(__FILE__, __LINE__, s);	\
 		}							\
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index b95ae86c40a7..dd94a602a6d2 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -277,7 +277,7 @@ EXPORT_SYMBOL_GPL(rcu_callback_map);
 
 noinstr int notrace debug_lockdep_rcu_enabled(void)
 {
-	return rcu_scheduler_active != RCU_SCHEDULER_INACTIVE && debug_locks &&
+	return rcu_scheduler_active != RCU_SCHEDULER_INACTIVE && READ_ONCE(debug_locks) &&
 	       current->lockdep_recursion == 0;
 }
 EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
-- 
2.31.1.189.g2e36527f23

