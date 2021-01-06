Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D27C433E6
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C7E23106
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbhAFRSz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:18:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbhAFRSf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:18:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F5B823133;
        Wed,  6 Jan 2021 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953434;
        bh=lg15qmE9TMvnNiqJ8jpY1kaRpNu5ZZdEeFU6u/ZyAcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hHBkgxjToXdD/tgIt0kWNEjMW6bsk8qDrJoU2OecGSsX/sTbas3lgFQla2vIrCEzi
         Qa7TUHS3M6WZ4YlnpTDB/z3IeYn+4uiR3B9fa8rIqvXLMndMOhq+BbmkXyoPIuOUHw
         88daOhcPB6kX5UvU6SuyIFvabTmD5I6HUsYoa0CRChmm1WmhJsoONiZRdegc+LlGPh
         uwsgNEVl1RgGzIn2eB6ZCIs6xkTTibAHZbpqcCHbtP9pFSM7Ligog/N4DDt96/b6E4
         Kl6VjRwWnhcAICd6oro1fw670cu7/G1jyR00kKuWTKx5h7MVtKDwuEpcQHrkfuYlbL
         eoeSJr01Yu8hQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/17] rcutorture: Make object_debug also double call_rcu() heap object
Date:   Wed,  6 Jan 2021 09:17:06 -0800
Message-Id: <20210106171710.22239-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit provides a test for call_rcu() printing the allocation address
of a double-freed callback by double-freeing a callback allocated via
kmalloc().  However, this commit does not depend on any other commit.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 4a0c6e6..72fd6bb 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2782,6 +2782,7 @@ static void rcu_test_debug_objects(void)
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 	struct rcu_head rh1;
 	struct rcu_head rh2;
+	struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 
 	init_rcu_head_on_stack(&rh1);
 	init_rcu_head_on_stack(&rh2);
@@ -2794,6 +2795,10 @@ static void rcu_test_debug_objects(void)
 	local_irq_disable(); /* Make it harder to start a new grace period. */
 	call_rcu(&rh2, rcu_torture_leak_cb);
 	call_rcu(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
+	if (rhp) {
+		call_rcu(rhp, rcu_torture_leak_cb);
+		call_rcu(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
+	}
 	local_irq_enable();
 	rcu_read_unlock();
 	preempt_enable();
-- 
2.9.5

