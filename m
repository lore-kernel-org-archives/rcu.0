Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C79C433FE
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BED61130
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhIOXfF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhIOXfE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA7FC610E8;
        Wed, 15 Sep 2021 23:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748825;
        bh=oWPrLMqEqfIJmt+1FiniGYvMomnXruPa0VdlYxlWDtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCmnXNMUuXE5fIZrTR/rxBAlVkZVFFfCUuNR5RGX/IyIxsQms5FjVBO6MA/5cfq5A
         ggocibfM+K9wbMm7bxZQbY6LLN8ftnu22d7zxlyU3TjZAGQStXPPDrv0NYI+vf2Xe3
         9/p3YeWirvm2/BGnVtn/361JU2KNT0pjUBGF9czPmTjwNJ91BBk41EZ/UjvAZoG92T
         3AqYdMrd81Yqs9l9ZTVWwwjsnuXiiMg5bdOL4EyyV+hc1X18Pz77uLJCTpNX6uOI45
         teSXRhmkt0uLNduONSKkufIMh118VLQZS3TGH881Adu9Bc+wS9pPXuURb+PfYhvG8x
         +RPeKOLgl4rng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BA2CD5C054E; Wed, 15 Sep 2021 16:33:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>
Subject: [PATCH rcu 01/14] rcu: Mark accesses to rcu_state.n_force_qs
Date:   Wed, 15 Sep 2021 16:33:30 -0700
Message-Id: <20210915233343.3906738-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit marks accesses to the rcu_state.n_force_qs.  These data
races are hard to make happen, but syzkaller was equal to the task.

Reported-by: syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com
Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bce848e50512..c89f5e6c4154 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1907,7 +1907,7 @@ static void rcu_gp_fqs(bool first_time)
 	struct rcu_node *rnp = rcu_get_root();
 
 	WRITE_ONCE(rcu_state.gp_activity, jiffies);
-	rcu_state.n_force_qs++;
+	WRITE_ONCE(rcu_state.n_force_qs, rcu_state.n_force_qs + 1);
 	if (first_time) {
 		/* Collect dyntick-idle snapshots. */
 		force_qs_rnp(dyntick_save_progress_counter);
@@ -2550,7 +2550,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Reset ->qlen_last_fqs_check trigger if enough CBs have drained. */
 	if (count == 0 && rdp->qlen_last_fqs_check != 0) {
 		rdp->qlen_last_fqs_check = 0;
-		rdp->n_force_qs_snap = rcu_state.n_force_qs;
+		rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
 	} else if (count < rdp->qlen_last_fqs_check - qhimark)
 		rdp->qlen_last_fqs_check = count;
 
@@ -2898,10 +2898,10 @@ static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
 		} else {
 			/* Give the grace period a kick. */
 			rdp->blimit = DEFAULT_MAX_RCU_BLIMIT;
-			if (rcu_state.n_force_qs == rdp->n_force_qs_snap &&
+			if (READ_ONCE(rcu_state.n_force_qs) == rdp->n_force_qs_snap &&
 			    rcu_segcblist_first_pend_cb(&rdp->cblist) != head)
 				rcu_force_quiescent_state();
-			rdp->n_force_qs_snap = rcu_state.n_force_qs;
+			rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
 			rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
 		}
 	}
@@ -4128,7 +4128,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	/* Set up local state, ensuring consistent view of global state. */
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rdp->qlen_last_fqs_check = 0;
-	rdp->n_force_qs_snap = rcu_state.n_force_qs;
+	rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
 	rdp->blimit = blimit;
 	rdp->dynticks_nesting = 1;	/* CPU not up, no tearing. */
 	rcu_dynticks_eqs_online();
-- 
2.31.1.189.g2e36527f23

