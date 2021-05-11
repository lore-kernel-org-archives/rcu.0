Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D52FC43460
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633A7616E8
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhEKXKw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhEKXKv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:10:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B961B6191D;
        Tue, 11 May 2021 23:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774584;
        bh=+nquWZndN1aE3ASNE8akUAlwQVxp/0FBTEaXYM2bZrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNW9abFqbGmoYWorqLY3+MECFOL1Sj2ack5LbUBWCMyIu37psvBJWIKlzj1jRAvB7
         fDXw+CBuwxxwtM3U84kxTYtgNL5K8MWmNxTNSTUKJxN4aucD6rL7swM0k62GT+xV4q
         ngVtowrzusoWAHx1U+wrRDgw+LCkwpPxtz0XOu4zSlDTVn9VwBrry0o2ZMSjceP/9Z
         4ehFlpiawFwADCPGwoNMxmdpo825Pl8m8XHr61Ga0BgvRbXmKCkvKdEBXXScCdGmMe
         IoxKxei63Nj0LerW7SHmTYXTB+MC/hP+PQyeAmT06pCsUQ90MHyQM745irp+JCeYkA
         AMxxXSVS3Rbwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 54AC05C014E; Tue, 11 May 2021 16:09:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/4] rcu-tasks: Add block comment laying out RCU Rude design
Date:   Tue, 11 May 2021 16:09:40 -0700
Message-Id: <20210511230942.2894861-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds a block comment that gives a high-level overview of
how RCU Rude grace periods progress.  It also gives an overview of the
memory ordering.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 94d2c2c7f0ab..d6aa352cd705 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -645,8 +645,13 @@ void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
 // passing an empty function to schedule_on_each_cpu().  This approach
 // provides an asynchronous call_rcu_tasks_rude() API and batching
 // of concurrent calls to the synchronous synchronize_rcu_rude() API.
-// This sends IPIs far and wide and induces otherwise unnecessary context
-// switches on all online CPUs, whether idle or not.
+// This invokes schedule_on_each_cpu() in order to send IPIs far and wide
+// and induces otherwise unnecessary context switches on all online CPUs,
+// whether idle or not.
+//
+// Callback handling is provided by the rcu_tasks_kthread() function.
+//
+// Ordering is provided by the scheduler's context-switch code.
 
 // Empty function to allow workqueues to force a context switch.
 static void rcu_tasks_be_rude(struct work_struct *work)
-- 
2.31.1.189.g2e36527f23

