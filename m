Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A6EC433E6
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F54164EE1
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhCDBA7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1388624AbhCDAZF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:25:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BEC964EDF;
        Thu,  4 Mar 2021 00:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817394;
        bh=nqO6TCOJhj9m7vFGpNCgO5kA+pzLX+aLpvXtcO7bMFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Li29YnL4knzKbhz4QlThEAV2niOb35zxKqlnwEW6YDoZVEssz5m1M0qeIis+BAqLN
         tWIlQWjFr2+vCO1Z1sl06GyHWgpmpiTQbZ4CFd6oBpcRRgCFRLJusAb0xhCZLZ+JVF
         jwlCwb9EJGiBGHL9Wcbe/gOv/tjVzWrheGyP7SYxeGPPdVWX8ld07CpiwM3ymXMgCm
         0eDG4zWon5ABrsOpmMV+DJc3+heWIo1hmUkD3IlKwvXikaQGuA85EMkkb/krcpVF2K
         9+WZBkX905vEZ6WVZiQAeORAs4Ry8hmRHJdiQxzzVw1ogbM0oc7H7o2PmS1/YcQy40
         efpFV4rbTltEQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/12] rcu/nocb: Only (re-)initialize segcblist when needed on CPU up
Date:   Wed,  3 Mar 2021 16:23:05 -0800
Message-Id: <20210304002311.23655-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002225.GA23492@paulmck-ThinkPad-P72>
References: <20210304002225.GA23492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

At the start of a CPU-hotplug operation, the incoming CPU's callback
list can be in a number of states:

1.	Disabled and empty.  This is the case when the boot CPU has
	not invoked call_rcu(), when a non-boot CPU first comes online,
	and when a non-offloaded CPU comes back online.  In this case,
	it is both necessary and permissible to initialize ->cblist.
	Because either the CPU is currently running with interrupts
	disabled (boot CPU) or is not yet running at all (other CPUs),
	it is not necessary to acquire ->nocb_lock.

	In this case, initialization is required.

2.	Disabled and non-empty.  This cannot occur, because early boot
	call_rcu() invocations enable the callback list before enqueuing
	their callback.

3.	Enabled, whether empty or not.	In this case, the callback
	list has already been initialized.  This case occurs when the
	boot CPU has executed an early boot call_rcu() and also when
	an offloaded CPU comes back online.  In both cases, there is
	no need to initialize the callback list: In the boot-CPU case,
	the CPU has not (yet) gone offline, and in the offloaded case,
	the rcuo kthreads are taking care of business.

	Because it is not necessary to initialize the callback list,
	it is also not necessary to acquire ->nocb_lock.

Therefore, checking if the segcblist is enabled suffices.  This commit
therefore initializes the callback list at rcutree_prepare_cpu() time
only if that list is disabled.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ee77858..402ea36 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4084,14 +4084,13 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->dynticks_nesting = 1;	/* CPU not up, no tearing. */
 	rcu_dynticks_eqs_online();
 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
+
 	/*
-	 * Lock in case the CB/GP kthreads are still around handling
-	 * old callbacks.
+	 * Only non-NOCB CPUs that didn't have early-boot callbacks need to be
+	 * (re-)initialized.
 	 */
-	rcu_nocb_lock(rdp);
-	if (rcu_segcblist_empty(&rdp->cblist)) /* No early-boot CBs? */
+	if (!rcu_segcblist_is_enabled(&rdp->cblist))
 		rcu_segcblist_init(&rdp->cblist);  /* Re-enable callbacks. */
-	rcu_nocb_unlock(rdp);
 
 	/*
 	 * Add CPU to leaf rcu_node pending-online bitmask.  Any needed
-- 
2.9.5

