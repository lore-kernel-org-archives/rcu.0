Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B9CC4361B
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C604B61931
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhEKXNm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhEKXNd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6767561952;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=z5Ue1qKxYKPogfXdLCoyPZEQoULfCVbxyQmjN0XplRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d745UZO5cevgy/t6JPgDCHxLsgkWF3Eu1+GovVpfRBRJbzC3W/KDTTBnpqaJz/TEV
         wPMQFni3Logk+AUzh8sA2KSrAozVarInPgEvt/+CZCdvbMDG3Er0iW5sTQW6t1F9C3
         hxZYJoEu+GM+40Zo51xsDlOhlwIl3GVQffM6fJ6sZgTm+B/KLXBWK5itMNbnmxuiK2
         DZCQSteOcUbajiNRytgO7lqBAJl8lf9ky+8XqMuly/7Jb80qxwT2rYrpjheKGbO57c
         N0C7XrkzT+rd/RTFq3dloBk7xAtglIilWkxDXsQhw64ukNguPdUjXTtjfc5rmkNZQz
         6B9Z+O5vmlygA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8C2E15C0E5C; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/26] rcutorture: Make rcu_torture_boost_failed() check for GP end
Date:   Tue, 11 May 2021 16:12:16 -0700
Message-Id: <20210511231223.2895398-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

It is possible that a delayed grace period that rcu_torture_boost()
was polling for ended while rcu_torture_boost_failed() was printing the
failure splat.  It would be good to know when this happens.  This commit
therefore has rcu_torture_boost_failed() recheck the grace period after
printing the splat, and printing a message indicating whether or not
the grace period has ended.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 31338b2d6609..02a14dfcae67 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -919,6 +919,7 @@ static void rcu_torture_enable_rt_throttle(void)
 static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start, unsigned long end)
 {
 	static int dbg_done;
+	bool gp_done;
 
 	if (end - start > test_boost_duration * HZ - HZ / 2) {
 		// Recheck after checking time to avoid false positives.
@@ -931,6 +932,11 @@ static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start
 			pr_info("Boost inversion thread ->rt_priority %u gp_state %lu jiffies %lu\n",
 				current->rt_priority, gp_state, end - start);
 			cur_ops->gp_kthread_dbg();
+			// Recheck after print to flag grace period ending during splat.
+			gp_done = cur_ops->poll_gp_state(gp_state);
+			pr_info("Boost inversion: GP %lu %s.\n", gp_state,
+				gp_done ? "ended already" : "still pending");
+
 		}
 
 		return true; // failed
-- 
2.31.1.189.g2e36527f23

