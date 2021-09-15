Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE72C43217
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C4961242
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhIOXfJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232975AbhIOXfF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:35:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6991F61214;
        Wed, 15 Sep 2021 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748825;
        bh=TzDqD6Jg0IFtMG9iujxz5Eb0K/H6NQ9luT+UwRjIScA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s//Kb80TMk+NTumbxlP+aWYiyY6bNRv+dqtz5a15R3k0QSHPW3L2/y390R0paK4+S
         AguDUXHw+5+mvz4js1vjBAuRyVh/k/Z/OPP3UTjYJH8D5gQqi41P00ziM+DVlJ7Dyd
         uo9xUQAMYqwnKNQT6msrr1MiGfzMFG76/PcDlgBpDXCU2BugV9wSIM5OYqpb9gPev9
         9SPL6Pc/E4QdJOQFHjdV9VMzjNJH3sooaImMJADtGSvWRUF+HZbKB3i0UTSDyHtFve
         rCrrKatHLp7OLFmQ+iQL18vpRII2/rtQB5dsDDwqEryXP8PCtTzRg79RYjLtfq2AUB
         vXdBVXRD1uk0A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D08975C0DBF; Wed, 15 Sep 2021 16:33:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Juri Lelli <juri.lelli@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 12/14] rcu: Make rcu update module parameters world-readable
Date:   Wed, 15 Sep 2021 16:33:41 -0700
Message-Id: <20210915233343.3906738-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Juri Lelli <juri.lelli@redhat.com>

rcu update module parameters currently don't appear in sysfs and this is
a serviceability issue as it might be needed to access their default
values at runtime.

Fix this issue by changing rcu update module parameters permissions to
world-readable.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index bd551134e2f4..94282dc12bab 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -54,11 +54,11 @@
 #define MODULE_PARAM_PREFIX "rcupdate."
 
 #ifndef CONFIG_TINY_RCU
-module_param(rcu_expedited, int, 0);
-module_param(rcu_normal, int, 0);
+module_param(rcu_expedited, int, 0444);
+module_param(rcu_normal, int, 0444);
 static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
 #if !defined(CONFIG_PREEMPT_RT) || defined(CONFIG_NO_HZ_FULL)
-module_param(rcu_normal_after_boot, int, 0);
+module_param(rcu_normal_after_boot, int, 0444);
 #endif
 #endif /* #ifndef CONFIG_TINY_RCU */
 
-- 
2.31.1.189.g2e36527f23

