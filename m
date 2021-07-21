Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E743C63793
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C11A6128D
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbhGUT2V (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232757AbhGUT2U (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:28:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCC716124B;
        Wed, 21 Jul 2021 20:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898134;
        bh=6g92C+wAvL9J1SYNRz3QrTrQRktobpS9wHiznuq1Lqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TapG03q3WN1+LsRa7qqdx7Wz5Mghpp+SRsWJdwZNUrPYqjpPfDe6SgjR6iS/3LgFy
         8tPEz3i3w3vSXQnRfDkxYotB2oG+CJaeT9WnEgcI6VVLXohwpMag3XZXnvx5Lo/uFw
         C6X0X8L4ZrFlWPZWwDf5URLNAGpzTIHHtOUrX3O2jCdE+UpQrwJWGIn4AE0CsPQBB/
         bqPZxmyOZlgUxCaH8S8ieAq3I9FihfGHM4hhRVf2R4Nlj5Vm/CCKssbLI7S8v1eOBm
         MTIp+iP0b3J1nlTm8EqI4JGhnKZ4WJQc9bsJeFWz+L+iWMs/3SCT+y9QpG3toP5P9A
         0pnIgvDwRWidQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8B91E5C0A2D; Wed, 21 Jul 2021 13:08:54 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/5] rcu/doc: Add a quick quiz to explain further why we need smp_mb__after_unlock_lock()
Date:   Wed, 21 Jul 2021 13:08:52 -0700
Message-Id: <20210721200853.1175189-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721200806.GA950569@paulmck-ThinkPad-P17-Gen-1>
References: <20210721200806.GA950569@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Add some missing critical pieces of explanation to understand the need
for full memory barriers throughout the whole grace period state machine,
thanks to Paul's explanations.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
[ paulmck: Adjust code block per Akira Yokosawa. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../Tree-RCU-Memory-Ordering.rst              | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 11cdab037bff6..eeb351296df11 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -112,6 +112,35 @@ on PowerPC.
 The ``smp_mb__after_unlock_lock()`` invocations prevent this
 ``WARN_ON()`` from triggering.
 
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| But the chain of rcu_node-structure lock acquisitions guarantees      |
+| that new readers will see all of the updater's pre-grace-period       |
+| accesses and also guarantees that the updater's post-grace-period     |
+| accesses will see all of the old reader's accesses.  So why do we     |
+| need all of those calls to smp_mb__after_unlock_lock()?               |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Because we must provide ordering for RCU's polling grace-period       |
+| primitives, for example, get_state_synchronize_rcu() and              |
+| poll_state_synchronize_rcu().  Consider this code::                   |
+|                                                                       |
+|  CPU 0                                     CPU 1                      |
+|  ----                                      ----                       |
+|  WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)           |
+|  g = get_state_synchronize_rcu()           smp_mb()                   |
+|  while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)          |
+|          continue;                                                    |
+|  r0 = READ_ONCE(Y)                                                    |
+|                                                                       |
+| RCU guarantees that the outcome r0 == 0 && r1 == 0 will not           |
+| happen, even if CPU 1 is in an RCU extended quiescent state           |
+| (idle or offline) and thus won't interact directly with the RCU       |
+| core processing at all.                                               |
++-----------------------------------------------------------------------+
+
 This approach must be extended to include idle CPUs, which need
 RCU's grace-period memory ordering guarantee to extend to any
 RCU read-side critical sections preceding and following the current
-- 
2.31.1.189.g2e36527f23

