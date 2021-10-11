Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF68C433EF
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8600C60BD3
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhJKOyS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243740AbhJKOyN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Oct 2021 10:54:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5BB560E98;
        Mon, 11 Oct 2021 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633963933;
        bh=X6BQChvAkCEdmj61KMthJYDPC8qxnuN2+eT17Bd85UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQnrGsLtTdPbgfqsva+9i/e7SogbyoXohbKguQCMPmOiP6UjGjQUIoA0y+T5/H2dM
         +5U6fQwsYTungbg6FhRfvtod+vnJ22O3t0zadUzzAKpMGFJFXh8Djy2n4O7T1kQVUJ
         ofE9PEinbCFJ1gzflvLkUos18pNfz+HB+IlbcQBgpQd6ZeW977yijRBSrL9kDqc7qw
         SIcd3S7XlDhi3859JUefeCaGl4tq7QHqMEZ2jkNXD6V+AWLrhM/Jas54z3s19DL1b9
         d0IqhnmFzhgCjYowV4tX/OzJKEqet/kqH9IHmLn693axpJsAilJApxLl8fyLfu2/vp
         VsUrMUfggfdcw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 06/11] rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check
Date:   Mon, 11 Oct 2021 16:51:35 +0200
Message-Id: <20211011145140.359412-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011145140.359412-1-frederic@kernel.org>
References: <20211011145140.359412-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

It's not entirely clear why rdp->qlen_last_fqs_check is updated before
processing the queue only on offloaded rdp. There can be different
effect to that, either in favour of triggering the force quiescent state
path or not. For example:

1) If the number of callbacks has decreased since the last
   rdp->qlen_last_fqs_check update (because we recently called
   rcu_do_batch() and we executed below qhimark callbacks) and the number
   of processed callbacks on a subsequent do_batch() arranges for
   exceeding qhimark on non-offloaded but not on offloaded setup, then we
   may spare a later run to the force quiescent state
   slow path on __call_rcu_nocb_wake(), as compared to the non-offloaded
   counterpart scenario.

   Here is such an offloaded scenario instance:

    qhimark = 1000
    rdp->last_qlen_last_fqs_check = 3000
    rcu_segcblist_n_cbs(rdp) = 2000

    rcu_do_batch() {
        if (offloaded)
            rdp->last_qlen_fqs_check = rcu_segcblist_n_cbs(rdp) // 2000
        // run 1000 callback
        rcu_segcblist_n_cbs(rdp) = 1000
        // Not updating rdp->qlen_last_fqs_check
        if (count < rdp->qlen_last_fqs_check - qhimark)
            rdp->qlen_last_fqs_check = count;
    }

    call_rcu() * 1001 {
        __call_rcu_nocb_wake() {
            // not taking the fqs slowpath:
            // rcu_segcblist_n_cbs(rdp) == 2001
            // rdp->qlen_last_fqs_check == 2000
            // qhimark == 1000
            if (len > rdp->qlen_last_fqs_check + qhimark)
                ...
    }

    In the case of a non-offloaded scenario, rdp->qlen_last_fqs_check
    would be 1000 and the fqs slowpath would have executed.

2) If the number of callbacks has increased since the last
   rdp->qlen_last_fqs_check update (because we recently queued below
   qhimark callbacks) and the number of callbacks executed in rcu_do_batch()
   doesn't exceed qhimark for either offloaded or non-offloaded setup,
   then it's possible that the offloaded scenario later run the force
   quiescent state slow path on __call_rcu_nocb_wake() while the
   non-offloaded doesn't.

    qhimark = 1000
    rdp->last_qlen_last_fqs_check = 3000
    rcu_segcblist_n_cbs(rdp) = 2000

    rcu_do_batch() {
        if (offloaded)
            rdp->last_qlen_last_fqs_check = rcu_segcblist_n_cbs(rdp) // 2000
        // run 100 callbacks
        // concurrent queued 100
        rcu_segcblist_n_cbs(rdp) = 2000
        // Not updating rdp->qlen_last_fqs_check
        if (count < rdp->qlen_last_fqs_check - qhimark)
            rdp->qlen_last_fqs_check = count;
    }

    call_rcu() * 1001 {
        __call_rcu_nocb_wake() {
            // Taking the fqs slowpath:
            // rcu_segcblist_n_cbs(rdp) == 3001
            // rdp->qlen_last_fqs_check == 2000
            // qhimark == 1000
            if (len > rdp->qlen_last_fqs_check + qhimark)
                ...
    }

    In the case of a non-offloaded scenario, rdp->qlen_last_fqs_check
    would be 3000 and the fqs slowpath would have executed.

Until we sort this out, keep the current behaviour, whatever the
original intent is, but make sure we check a stable and not volatile
offloading state in order not to raise a useless alarm on -rt

Reported-and-tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Original-patch-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a43924244000..27500981d4b1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2508,7 +2508,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	trace_rcu_batch_start(rcu_state.name,
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
-	if (offloaded)
+	if (rcu_rdp_is_offloaded(rdp))
 		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
 
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
-- 
2.25.1

