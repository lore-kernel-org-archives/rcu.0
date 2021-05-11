Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C66C43461
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B7061925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhEKXNn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230301AbhEKXNd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AB2961953;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=N3DvynfywbR4vMcPllaNtoW+0w0OcoOfnSuf8rhnS7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7T0L4Dur3N8LblX6jCptlHrf8PhjlWmHw8PChhQKwlNANJNdpv/cM3ymkt907AAi
         5moGPlZmi0npy6QfaUMYBSPBU87IQXdb2ResoMudSHnsD+Rn5Qt8RpXAj97/vV2Ods
         SUMqwQUSIA4gA+kMxv7DXEDeXMUXezZYWm4z2tx0GFvmVmcvntdhUzWhwdwTmfbPm4
         zcb6nNlxVr5WOuNDK4gQGk1tXVSNyZIon+74tqk+yhLgs86MKrs2CjnH5FLcLoxbCN
         VHPLYRzU+wn5M0iP5KBzvpgGHrydFXhQaofcJBsaQ2cxKnknI8D+fdYbNUDYp7Rqot
         J+iUAkXfoYVgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8A1E55C0E5B; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/26] rcutorture: Consolidate rcu_torture_boost() timing and statistics
Date:   Tue, 11 May 2021 16:12:15 -0700
Message-Id: <20210511231223.2895398-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit consolidates two loops in rcu_torture_boost(), one of which
counts the number of boost-test episodes and the other of which computes
the start time of the next episode, into one loop that does both with but
a single acquisition of boost_mutex.  This means that the count of the
number of boost-test episodes is incremented after an episode completes
rather than before it starts, but it also avoids the over-counting that
was possible previously.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3defd0febe15..31338b2d6609 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -956,15 +956,6 @@ static int rcu_torture_boost(void *arg)
 		bool failed = false; // Test failed already in this test interval
 		bool gp_initiated = false;
 
-		/* Increment n_rcu_torture_boosts once per boost-test */
-		while (!kthread_should_stop()) {
-			if (mutex_trylock(&boost_mutex)) {
-				n_rcu_torture_boosts++;
-				mutex_unlock(&boost_mutex);
-				break;
-			}
-			schedule_timeout_uninterruptible(1);
-		}
 		if (kthread_should_stop())
 			goto checkwait;
 
@@ -1015,7 +1006,10 @@ static int rcu_torture_boost(void *arg)
 		 */
 		while (oldstarttime == boost_starttime && !kthread_should_stop()) {
 			if (mutex_trylock(&boost_mutex)) {
-				boost_starttime = jiffies + test_boost_interval * HZ;
+				if (oldstarttime == boost_starttime) {
+					boost_starttime = jiffies + test_boost_interval * HZ;
+					n_rcu_torture_boosts++;
+				}
 				mutex_unlock(&boost_mutex);
 				break;
 			}
-- 
2.31.1.189.g2e36527f23

