Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C8AC43460
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C37EC61606
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhEKXEt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhEKXEq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:04:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9D116193B;
        Tue, 11 May 2021 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774219;
        bh=+ZPEzWcBhC8CW1lLwq3R4VXDvbMtMTe4n5aOF0YI22c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BmANMUluu2aDavOKH6jFxVsUPnhn5PJP3lpWzhq+KgI3TL4qv4fJham0Nz6pwBzf7
         CoXX7XePnSkLMqxTghS34kHCPMd/QgKGQ2x4JO2isaE6h66/wr25gbgu4r7E7sY50Q
         K2KT9rPrXnnf5BuUjcbKrMJIHnYwYtYFsb7MmuyjXZwmJNuKDNdRM3PyvXDLgeD+5m
         YqwqO9LMwy3tgjNVfILU8/wHWyXlW/Y1Xj7PWWCOD9TP/KandL7wgq0u338DfgpQ3V
         mhLfQ9guf38VsrGOU99I8wRN21rDFYdIAe2Sa2WePz6EysXW5He53fGTscQGIgtRuh
         +SKAJ1FUyaDZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 632FC5C0DB3; Tue, 11 May 2021 16:03:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/10] rcu/nocb: Delete bypass_timer upon nocb_gp wakeup
Date:   Tue, 11 May 2021 16:03:32 -0700
Message-Id: <20210511230336.2894314-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

A NOCB-gp wake p can safely delete the ->nocb_bypass_timer because
nocb_gp_wait() will recheck again the bypass state and rearm the bypass
timer if necessary.  This commit therefore deletes this timer.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index a667551a5501..4253a0ecc14f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1701,6 +1701,8 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 		del_timer(&rdp_gp->nocb_timer);
 	}
 
+	del_timer(&rdp_gp->nocb_bypass_timer);
+
 	if (force || READ_ONCE(rdp_gp->nocb_gp_sleep)) {
 		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
 		needwake = true;
-- 
2.31.1.189.g2e36527f23

