Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB389C4332F
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B183961186
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhIOXfF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232908AbhIOXfE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0275761157;
        Wed, 15 Sep 2021 23:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748825;
        bh=xsgx0GpeQAclTej5LlLjRn0cECyUgrdxHaCISoqSx7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8n9Zw0HEbwpFJDZyq0/hxL+uIVkcK9FXe+F51CN8/PjfyPMaO8EhDq9BdFqd1nDe
         segZn6INYpHiLJG2XYs/bcQ98esuxyHJZOZ29ua9xku1DuMXVtRlvONrpD8KH7CAfN
         CVrT8yqkVeb3TLoTaylAhuFFk1DmY23jMYQhhJ+WAJLMIb34ip9LBslJbiywUo8Acc
         fIUgaioS5onWEEg5kfNCaXLmQNRp1AKnFvz4g7tNoFtyWzdlsDxRAGAi8OyDtrwOkE
         AuOdkEdJTujWkvwcU3wVK63pVuBpQ3rPaeVYeTuqkaS08ze9HEqTwrL5g3r5+41Q2c
         f/7gg4NVPeGQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C13A55C08E8; Wed, 15 Sep 2021 16:33:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/14] rcu: Eliminate rcu_implicit_dynticks_qs() local variable ruqp
Date:   Wed, 15 Sep 2021 16:33:33 -0700
Message-Id: <20210915233343.3906738-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The rcu_implicit_dynticks_qs() function's local variable ruqp references
the ->rcu_urgent_qs field in the rcu_data structure referenced by the
function parameter rdp, with a rather odd method for computing the
pointer to this field.  This commit therefore simplifies things and
saves a couple of lines of code by replacing each instance of ruqp with
&rdp->need_heavy_qs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 18d2f35d1450..0bfebec94277 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1219,7 +1219,6 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 {
 	unsigned long jtsq;
-	bool *ruqp;
 	struct rcu_node *rnp = rdp->mynode;
 
 	/*
@@ -1284,16 +1283,15 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * is set way high.
 	 */
 	jtsq = READ_ONCE(jiffies_to_sched_qs);
-	ruqp = per_cpu_ptr(&rcu_data.rcu_urgent_qs, rdp->cpu);
 	if (!READ_ONCE(rdp->rcu_need_heavy_qs) &&
 	    (time_after(jiffies, rcu_state.gp_start + jtsq * 2) ||
 	     time_after(jiffies, rcu_state.jiffies_resched) ||
 	     rcu_state.cbovld)) {
 		WRITE_ONCE(rdp->rcu_need_heavy_qs, true);
 		/* Store rcu_need_heavy_qs before rcu_urgent_qs. */
-		smp_store_release(ruqp, true);
+		smp_store_release(&rdp->rcu_urgent_qs, true);
 	} else if (time_after(jiffies, rcu_state.gp_start + jtsq)) {
-		WRITE_ONCE(*ruqp, true);
+		WRITE_ONCE(rdp->rcu_urgent_qs, true);
 	}
 
 	/*
@@ -1307,7 +1305,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	if (tick_nohz_full_cpu(rdp->cpu) &&
 	    (time_after(jiffies, READ_ONCE(rdp->last_fqs_resched) + jtsq * 3) ||
 	     rcu_state.cbovld)) {
-		WRITE_ONCE(*ruqp, true);
+		WRITE_ONCE(rdp->rcu_urgent_qs, true);
 		resched_cpu(rdp->cpu);
 		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
 	}
-- 
2.31.1.189.g2e36527f23

