Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805F8C433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A6D61184
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhEKWyP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230012AbhEKWyN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD5A961928;
        Tue, 11 May 2021 22:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773586;
        bh=B7ur2L0bEuQWoB0Xyaqdy5OOu/Zub/NIDQtO1pZbSfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgUBBv3aZAzb8OEmEqRFOVK6z8Xf0SUs2wiq/XHZk7uLr0I1mBNxoh3jpEtLr4wxS
         32qAr9cSuk33rn4AH+OX2jdwl5jPFtSailxKpdplyczINKOVEEUYVeiKCfRtLTIRoS
         z20HBijxGod4DKmiu29uiMgYZ/5Z/bVZf/3LyrigYdhqb2F13Oa2it1epL3S0lV48c
         IUfuejsPPctXASEUhrDQ5zfw+EnipYZgkoZX97qGq/o5eIT/pihPD9b/6VhvOWKInH
         zL/Cm9nfUdjxjRP9nHZeiDQsMjB5XztaPIOs92LtuO5n5/nUTqTE8X1kg9UM5jz+8D
         jjgnwfqlZWHBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 891505C0138; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Rolf Eike Beer <eb@emlix.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/19] rcu: Fix typo in comment: kthead -> kthread
Date:   Tue, 11 May 2021 15:52:46 -0700
Message-Id: <20210511225304.2893154-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Rolf Eike Beer <eb@emlix.com>

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 mm/oom_kill.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ad0156b86937..2cbe8f8456e6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1940,7 +1940,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 }
 
 /*
- * Awaken the no-CBs grace-period kthead if needed, either due to it
+ * Awaken the no-CBs grace-period kthread if needed, either due to it
  * legitimately being asleep or due to overload conditions.
  *
  * If warranted, also wake up the kthread servicing this CPUs queues.
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eefd3f5fde46..54527de9cd2d 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -922,7 +922,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 			continue;
 		}
 		/*
-		 * No kthead_use_mm() user needs to read from the userspace so
+		 * No kthread_use_mm() user needs to read from the userspace so
 		 * we are ok to reap it.
 		 */
 		if (unlikely(p->flags & PF_KTHREAD))
-- 
2.31.1.189.g2e36527f23

