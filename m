Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2CDC4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E1B23142
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbhAFQ4z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:56:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbhAFQ4x (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:56:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DF8D2313C;
        Wed,  6 Jan 2021 16:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609952134;
        bh=5N4yy6vCgBYA88AYbYBNwRYZKoVb53QM2QFfeDuwqq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Acm4zyoAS4r5/CWIZ+l6KnysOZ3clsALA5U9AaDUXh9lx1LQ2OfxGwepVOnuzs/dc
         WZ9P+VnJV45HjMvlG12NhraiUi+b89qUNOX4xdQLhj2gwW6KqJ/tWrOO0mwiZQbvtV
         vvWb604REDgjwcELwiqk5sTOHEOfIWjPQbLh1LRyBXUT2AQwG2pFV3Q4jZCFZokIb+
         ZhrB6QkACXvDW+AFvs1R6wp4SfLbvq2iolWnCObhcPaMSQqL+2u7Z/+dPRg3a6jrQK
         1bSvO1Q/vazfu5tKU+YL03G/wSE3LEsZbIVUGUy3EAsSqRjVgLn+jWdstRlsoB2czC
         D1YzbdyV5ELGw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/10] rcutorture: Add reader-side tests of polling grace-period API
Date:   Wed,  6 Jan 2021 08:55:31 -0800
Message-Id: <20210106165531.20697-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106165511.GA20555@paulmck-ThinkPad-P72>
References: <20210106165511.GA20555@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds reader-side testing of the polling grace-period API.
This testing verifies that a cookie obtained in an SRCU read-side critical
section does not get a true return from poll_state_synchronize_srcu()
within that same critical section.

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 78ba95d..96d55f0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1429,6 +1429,7 @@ rcutorture_loop_extend(int *readstate, struct torture_random_state *trsp,
  */
 static bool rcu_torture_one_read(struct torture_random_state *trsp)
 {
+	unsigned long cookie;
 	int i;
 	unsigned long started;
 	unsigned long completed;
@@ -1444,6 +1445,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	WARN_ON_ONCE(!rcu_is_watching());
 	newstate = rcutorture_extend_mask(readstate, trsp);
 	rcutorture_one_extend(&readstate, newstate, trsp, rtrsp++);
+	if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
+		cookie = cur_ops->get_gp_state();
 	started = cur_ops->get_gp_seq();
 	ts = rcu_trace_clock_local();
 	p = rcu_dereference_check(rcu_torture_current,
@@ -1480,6 +1483,13 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	}
 	__this_cpu_inc(rcu_torture_batch[completed]);
 	preempt_enable();
+	if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
+		WARN_ONCE(cur_ops->poll_gp_state(cookie),
+			  "%s: Cookie check 3 failed %s(%d) %lu->%lu\n",
+			  __func__,
+			  rcu_torture_writer_state_getname(),
+			  rcu_torture_writer_state,
+			  cookie, cur_ops->get_gp_state());
 	rcutorture_one_extend(&readstate, 0, trsp, rtrsp);
 	WARN_ON_ONCE(readstate & RCUTORTURE_RDR_MASK);
 	// This next splat is expected behavior if leakpointer, especially
-- 
2.9.5

