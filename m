Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C07C433B4
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860556192C
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhEKWpr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhEKWpr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:45:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 162B861927;
        Tue, 11 May 2021 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773080;
        bh=/Gtu2CufHYyyGem7LcnB9pn9BK/SpPgwek2yC8LPhn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KcGVf2J1QCm30KFG0CU56tp8n1R8tv5f/trI89jIeITOA5RtdDXDiEJCyEHCZHbsO
         09qjb3/nrnDxaYTWk1nA3McbANLbu6nVj7mYLlOoeDG71qrbhz610+lIJ92bVI8dUB
         YFmlwOJB+aFjMoSnf4fGlxmPleY8cNewLyPp5ouOaezX6NYDS4WmL3fBxXwsN3MPfA
         TtFONSGA3dyfCHC9At24nmlELbb7c9CoJPBMB46qx7AOKR+6a0rWsGfMIDOUZAoTUU
         VgmxD1f4L6ozCg8OJ920AEpDaE8wbMppxPhmJUg8KUzF7AZpEaPra3L+k2o1/aiJBs
         oWhXdSgYFQPsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DA8EF5C014E; Tue, 11 May 2021 15:44:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/3] doc: Fix diagram references in memory-ordering document
Date:   Tue, 11 May 2021 15:44:37 -0700
Message-Id: <20210511224438.2892442-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511224402.GA2892361@paulmck-ThinkPad-P17-Gen-1>
References: <20210511224402.GA2892361@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

The three diagrams describing rcu_gp_init() all spuriously refer to
the same figure, probably due to a copy/paste issue.  This commit fixes
these references.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 3f6ce41ee0c5..11cdab037bff 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -339,14 +339,14 @@ The diagram below shows the path of ordering if the leftmost
 leftmost ``rcu_node`` structure offlines its last CPU and if the next
 ``rcu_node`` structure has no online CPUs).
 
-.. kernel-figure:: TreeRCU-gp-init-1.svg
+.. kernel-figure:: TreeRCU-gp-init-2.svg
 
 The final ``rcu_gp_init()`` pass through the ``rcu_node`` tree traverses
 breadth-first, setting each ``rcu_node`` structure's ``->gp_seq`` field
 to the newly advanced value from the ``rcu_state`` structure, as shown
 in the following diagram.
 
-.. kernel-figure:: TreeRCU-gp-init-1.svg
+.. kernel-figure:: TreeRCU-gp-init-3.svg
 
 This change will also cause each CPU's next call to
 ``__note_gp_changes()`` to notice that a new grace period has started,
-- 
2.31.1.189.g2e36527f23

