Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9D1C433E9
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9493B22DD3
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbhAFAzL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:55:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbhAFAyu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 19:54:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E08222E00;
        Wed,  6 Jan 2021 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894449;
        bh=Xe/hxDp+RtJJZTYrEMf5QL77n6FHCyQ2RwhKnyNyl2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPrBxjCr6Rtwx3JKxbmNTs/DgxllWY9c3fEitbHw9kBMjZgV529b9QNEboC8st+Ye
         XbZmbTt58qQc7FAtGYgw3zj0p49iyNqWoOWV8z0iOBCaPj0ZuZjErJfTmjho9woXC9
         JJr+hOu82C33WeBvUFxaUs37mjYoY2F9PGmjeWadIggf2Rh9fuAV9dUm0XOtwz0Yuq
         81ErRYGfQTAhb+IoRHNlvX00ZKoNZjZtsc2g8taA0bGgYxPuHOElCKIw3wEVL33GcO
         oDCcJJpnxWDvbj9PlGnwhzNXZxo0c0iF8+7APAHepnswBpOrwOPj2+iyi9+5bL4S7o
         +KJ2iaatUFgfQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/8] doc: Remove obsolete RCU-bh and RCU-sched update-side API members
Date:   Tue,  5 Jan 2021 16:54:01 -0800
Message-Id: <20210106005407.12295-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106005334.GA12159@paulmck-ThinkPad-P72>
References: <20210106005334.GA12159@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

synchronize_rcu_bh(), synchronize_rcu_bh_expedited(), call_rcu_bh(),
rcu_barrier_bh(), synchronize_sched(), synchronize_rcu_sched_expedited(),
call_rcu_sched(), and rcu_barrier_sched() no longer exist, so this
commit removes mention of them.

Reported-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../RCU/Design/Requirements/Requirements.rst       | 28 +++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 9b23be6..1e3df77 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2438,13 +2438,13 @@ glance as if rcu_read_unlock_bh() was executing very slowly.
 
 The `RCU-bh
 API <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
-includes rcu_read_lock_bh(), rcu_read_unlock_bh(),
-rcu_dereference_bh(), rcu_dereference_bh_check(),
-synchronize_rcu_bh(), synchronize_rcu_bh_expedited(),
-call_rcu_bh(), rcu_barrier_bh(), and
-rcu_read_lock_bh_held(). However, the update-side APIs are now
-simple wrappers for other RCU flavors, namely RCU-sched in
-CONFIG_PREEMPT=n kernels and RCU-preempt otherwise.
+includes rcu_read_lock_bh(), rcu_read_unlock_bh(), rcu_dereference_bh(),
+rcu_dereference_bh_check(), and rcu_read_lock_bh_held(). However, the
+old RCU-bh update-side APIs are now gone, replaced by synchronize_rcu(),
+synchronize_rcu_expedited(), call_rcu(), and rcu_barrier().  In addition,
+anything that disables bottom halves also marks an RCU-bh read-side
+critical section, including local_bh_disable() and local_bh_enable(),
+local_irq_save() and local_irq_restore(), and so on.
 
 Sched Flavor (Historical)
 ~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -2481,13 +2481,13 @@ The `RCU-sched
 API <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
 includes rcu_read_lock_sched(), rcu_read_unlock_sched(),
 rcu_read_lock_sched_notrace(), rcu_read_unlock_sched_notrace(),
-rcu_dereference_sched(), rcu_dereference_sched_check(),
-synchronize_sched(), synchronize_rcu_sched_expedited(),
-call_rcu_sched(), rcu_barrier_sched(), and
-rcu_read_lock_sched_held(). However, anything that disables
-preemption also marks an RCU-sched read-side critical section, including
-preempt_disable() and preempt_enable(), local_irq_save() and
-local_irq_restore(), and so on.
+rcu_dereference_sched(), rcu_dereference_sched_check(), and
+rcu_read_lock_sched_held().  However, the old RCU-sched update-side APIs
+are now gone, replaced by synchronize_rcu(), synchronize_rcu_expedited(),
+call_rcu(), and rcu_barrier().  In addition, anything that disables
+preemption also marks an RCU-sched read-side critical section,
+including preempt_disable() and preempt_enable(), local_irq_save()
+and local_irq_restore(), and so on.
 
 Sleepable RCU
 ~~~~~~~~~~~~~
-- 
2.9.5

