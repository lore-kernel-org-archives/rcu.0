Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B8EC433B4
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36BA616E8
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhEKXI4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhEKXIz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:08:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39B6161624;
        Tue, 11 May 2021 23:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774468;
        bh=0G1IOLWTiKY5Csh1SI3Ny5X7AfG0EfwDXqnowWwhwl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Khiv9h2F7LGVWlQ1Mrfoye9m3Vn8DGgCcEneWhj7deT4enV+TL6D5AfOOCycVzvs7
         Ya0j6Dkkjbo9iO84b/KFo8Aayvwgk1ej6F1QMZZu9Qcgddm/JI7fjcvj7waLqjUXoP
         uEtI/EJLLHi+N6wbV+4v7IuAKQyM7+vjoj+OENUItKqS67BIzrBAGyFoOnVVzdUbjI
         IP1YEov7/quPHv3JSEYvV6RFiSrgggkyAyq/zG1P0KpYjlzWzJ2387xVlpxGnhW0kH
         x1R8HsjNbyJ6HfT9aUsl0hrH/KHBhOM2ZChz+elBI5Ce7U2/CZGmsCe3wQSfzfAtOx
         9n1mXtGqg6A4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DA43A5C0138; Tue, 11 May 2021 16:07:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/6] srcu: Remove superfluous sdp->srcu_lock_count zero filling
Date:   Tue, 11 May 2021 16:07:40 -0700
Message-Id: <20210511230745.2894650-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Because alloc_percpu() zeroes out the allocated memory, there is no need
to zero-fill newly allocated per-CPU memory.  This commit therefore removes
the loop zeroing the ->srcu_lock_count and ->srcu_unlock_count arrays
from init_srcu_struct_nodes().  This is the only use of that function's
is_static parameter, which this commit also removes.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e26547b34ad3..3414aff2a4b0 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -80,7 +80,7 @@ do {									\
  * srcu_read_unlock() running against them.  So if the is_static parameter
  * is set, don't initialize ->srcu_lock_count[] and ->srcu_unlock_count[].
  */
-static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
+static void init_srcu_struct_nodes(struct srcu_struct *ssp)
 {
 	int cpu;
 	int i;
@@ -148,14 +148,6 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
 		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
 		sdp->ssp = ssp;
 		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
-		if (is_static)
-			continue;
-
-		/* Dynamically allocated, better be no srcu_read_locks()! */
-		for (i = 0; i < ARRAY_SIZE(sdp->srcu_lock_count); i++) {
-			sdp->srcu_lock_count[i] = 0;
-			sdp->srcu_unlock_count[i] = 0;
-		}
 	}
 }
 
@@ -179,7 +171,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
 	if (!ssp->sda)
 		return -ENOMEM;
-	init_srcu_struct_nodes(ssp, is_static);
+	init_srcu_struct_nodes(ssp);
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
-- 
2.31.1.189.g2e36527f23

