Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C79C4332D
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5992422BF3
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbhAFEts (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:49:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbhAFEtg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:49:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4800C22E00;
        Wed,  6 Jan 2021 04:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908535;
        bh=YewQ1IJ3cuXWYqOZiYkr0j4/c2AYBNL/svbmvQsNen8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wc3j9NrDpIibBr+a6z16YjCPz7Fd/o3i7CulrZaNfxqkiALM/2ilA4qRlOKBGIqcf
         VejY6y/hKpc0GkHxtch4QTcSVMgoZkNYZi/pwC4Yb6ifWDf+0w657fa3OIY+VZelH1
         RgmAUrdQkNVx5NWGN9X2kIU0iF4dgE5H780sppn2zfVbVT38kuNnywfp0raSDrGc5s
         VrofqDc5c9XJy+1dfznPZpRG5P7xjgVtXzmYqOfDBdQ5DD1FZCdRRMCV9ddSh1q87m
         e1hrpOpTz4GsEpi9WHdE0tdRncdRT1tCqSqyt7f3ohTwJ1FeXQ5pzpUHl5K/0NzHQe
         PYA+hrYj317cA==
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
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/21] rcu/nocb: Always init segcblist on CPU up
Date:   Tue,  5 Jan 2021 20:48:35 -0800
Message-Id: <20210106044853.20812-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

How the rdp->cblist enabled state is treated at CPU-hotplug time depends
on whether or not that ->cblist is offloaded.

1) Not offloaded: The ->cblist is disabled when the CPU goes down. All
   its callbacks are migrated and none can to enqueued until after some
   later CPU-hotplug operation brings the CPU back up.

2) Offloaded: The ->cblist is not disabled on CPU down because the CB/GP
   kthreads must finish invoking the remaining callbacks. There is thus
   no need to re-enable it on CPU up.

Since the ->cblist offloaded state is set in stone at boot, it cannot
change between CPU down and CPU up. So 1) and 2) are symmetrical.

However, given runtime toggling of the offloaded state, there are two
additional asymmetrical scenarios:

3) The ->cblist is not offloaded when the CPU goes down. The ->cblist
   is later toggled to offloaded and then the CPU comes back up.

4) The ->cblist is offloaded when the CPU goes down. The ->cblist is
   later toggled to no longer be offloaded and then the CPU comes back up.

Scenario 4) is currently handled correctly. The ->cblist remains enabled
on CPU down and gets re-initialized on CPU up. The toggling operation
will wait until ->cblist is empty, so ->cblist will remain empty until
CPU-up time.

The scenario 3) would run into trouble though, as the rdp is disabled
on CPU down and not re-initialized/re-enabled on CPU up.  Except that
in this case, ->cblist is guaranteed to be empty because all its
callbacks were migrated away at CPU-down time.  And the CPU-up code
already initializes and enables any empty ->cblist structures in order
to handle the possibility of early-boot invocations of call_rcu() in
the case where such invocations don't occur.  So all that need be done
is to adjust the locking.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7cfc2e8..83362f6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4015,12 +4015,18 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->qlen_last_fqs_check = 0;
 	rdp->n_force_qs_snap = rcu_state.n_force_qs;
 	rdp->blimit = blimit;
-	if (rcu_segcblist_empty(&rdp->cblist) && /* No early-boot CBs? */
-	    !rcu_segcblist_is_offloaded(&rdp->cblist))
-		rcu_segcblist_init(&rdp->cblist);  /* Re-enable callbacks. */
 	rdp->dynticks_nesting = 1;	/* CPU not up, no tearing. */
 	rcu_dynticks_eqs_online();
 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
+	/*
+	 * Lock in case the CB/GP kthreads are still around handling
+	 * old callbacks (longer term we should flush all callbacks
+	 * before completing CPU offline)
+	 */
+	rcu_nocb_lock(rdp);
+	if (rcu_segcblist_empty(&rdp->cblist)) /* No early-boot CBs? */
+		rcu_segcblist_init(&rdp->cblist);  /* Re-enable callbacks. */
+	rcu_nocb_unlock(rdp);
 
 	/*
 	 * Add CPU to leaf rcu_node pending-online bitmask.  Any needed
-- 
2.9.5

