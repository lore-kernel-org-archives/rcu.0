Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727FDC43603
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4887061925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhEKXNp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhEKXNd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D03161954;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=U4HSy9n8wC4qfQJ+6wc/qNxwpq3Y+Rj0l00awjo/XK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UwIjGS1xHn9YnGHwSaqRHSppRbqiWZSapCgibaw+1l/gZdTeX3d/2O2Nf78r+5EW2
         AQScjRGBE3pKWZbGv6/Fv+YQg7nsoOut3Ek58q5Q+RjSdp/xNdAHSRky+3uRoFj0hX
         +h3SE5y2h0u49T4ONmQjTltygee66TQ+mRftIsluDW2dHQjJGoxWslMuHn7ys77H0h
         zsctTQZbQ2Cw/W4+SHbNMClx+gfygg6f21xzDcU1967GiTlFnEdXy6i/2iSQHjmIVE
         wrS7WjlK7WbVNkDDp8Y1FlJ37weikWE/gkQKsJ41m7uER9GIPWhGYSR+9UunQfTK0D
         GF5bHr63tv7FA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8872A5C0E59; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/26] rcutorture: Delay-based false positives for RCU priority boosting tests
Date:   Tue, 11 May 2021 16:12:14 -0700
Message-Id: <20210511231223.2895398-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

If an rcu_torture_boost() kthread determines that its grace period
has not yet ended, it invokes rcu_torture_boost_failed() which checks
whether enough time has elapsed for this to be considered a failure of
RCU priority boosting, and, if so, flags the error.

Unfortunately, that kthread might be preempted for some seconds between
the time that it checks the grace period and the time that it checks the
time.  This delay can result in a false positive, featuring a complaint
that a particular grace period has not ended, followed by a diagnostic
dump featuring a much later grace period.

This commit avoids these false positives by rechecking for the end of
the grace period after the time check.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 06d08f4f3e52..3defd0febe15 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -921,6 +921,10 @@ static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start
 	static int dbg_done;
 
 	if (end - start > test_boost_duration * HZ - HZ / 2) {
+		// Recheck after checking time to avoid false positives.
+		smp_mb(); // Time check before grace-period check.
+		if (cur_ops->poll_gp_state(gp_state))
+			return false; // passed, though perhaps just barely
 		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
 		n_rcu_torture_boost_failure++;
 		if (!xchg(&dbg_done, 1) && cur_ops->gp_kthread_dbg) {
@@ -929,10 +933,10 @@ static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start
 			cur_ops->gp_kthread_dbg();
 		}
 
-		return true; /* failed */
+		return true; // failed
 	}
 
-	return false; /* passed */
+	return false; // passed
 }
 
 static int rcu_torture_boost(void *arg)
-- 
2.31.1.189.g2e36527f23

