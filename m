Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B67C4742C
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A0A2085B
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtQS55vI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgKMMN6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:13:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgKMMNy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:13:54 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55BF22250;
        Fri, 13 Nov 2020 12:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269633;
        bh=T067CQjBvkzjrbVpLcedNlKm/8QexJ5Rr4+AG2W/nQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtQS55vIa6pK7U3fFRNFs6mLKhASfpqyuHFphdhyhhozN88QJLa9zduHcqWIRXRL4
         sBYplnARFOdfLUwfML5ONCJvFlXwKHRWDFp+TrUcIUGcTVnyIn+JeLJOftjw3FKYOv
         aC4CqGZ06NjSCSmrWGCsxrSeOm94ddcVRghX3SA4=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: [PATCH 03/19] rcu/nocb: Always init segcblist on CPU up
Date:   Fri, 13 Nov 2020 13:13:18 +0100
Message-Id: <20201113121334.166723-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

An rdp's segcblist enabled state is treated differently on CPU hotplug
operations, depending on whether it is offloaded or not.

1) Not offloaded: An rdp is disabled on CPU down. All its callbacks are
   migrated and no more aren't supposed to be enqueued until it gets
   re-enabled on CPU up.

2) Offloaded: An rdp is not disabled on CPU down in order to let the
   CB/GP kthreads finish their jobs on remaining callbacks. Hence it is
   not re-enabled on CPU up either.

Since an rdp's offloaded state is set in stone at boot, we expect the
offloaded state to remain the same between CPU down and CPU up. So 1)
and 2) are symmetrical.

Now the offloaded state will become toggable at runtime. Hence the new
possible asymmetrical scenarios:

3) An rdp goes into CPU down while in a not-offloaded state. It gets
   later set to offloaded and finally goes into CPU up.

4) An rdp goes into CPU down while in an offloaded state. It gets
   later set to not-offloaded and finally goes into CPU up.

The scenario 4) is currently well handled. The rdp isn't disabled on
CPU down and it gets re-initialized on CPU up. We require the segcblist
to be empty in order to toggle to non-offloaded state while a CPU is
offlined.

The scenario 3) would run into trouble though, as the rdp is disabled
on CPU down and not re-initialized/re-enabled on CPU up.

In order to fix this, always re-initialize/re-enable an rdp on CPU up
unless it still has callbacks at that time, which anyway can only happen
when the rdp went down and up in offloaded state (case 2), the only
case that doesn't need re-initialization.

NOTE: The proper longer term fix will be to wait for all the offloaded
callbacks to be processed before completing CPU down operations. So we
can unconditionally re-initialize on CPU up.

Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 48e8e63cdeb2..049433d0fa05 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4004,12 +4004,18 @@ int rcutree_prepare_cpu(unsigned int cpu)
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
2.25.1

