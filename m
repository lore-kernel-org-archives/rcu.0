Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F061C433DB
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F70364F09
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349799AbhCDBAx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1388757AbhCDAMR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:12:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 548D164EBD;
        Thu,  4 Mar 2021 00:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816696;
        bh=OMCAxkhR1Vd19P5YP0klYvGEyOmKgsP2O47it1wjT90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7MeaZBn+m1IFPjrHrEAaeNXL1d49EtgHVVrUvQE2o1EUtmwKGCKdPvLWc3fIFDRV
         ZDk+YvLnHuz5fxYH816YUESzKfiRjhcXAAaF5h9sWpxffqtTvveSpTA5JVC55Oxvs+
         4TkkLbkliUIJFjzown5nmyJlueHhfdcVF1DWqml0OQl0+yltV2BAXkFgVjlSXb7+/E
         BQLZUyIXBgoKTdAuJ8sJvSSB640OUn7T6yEVYsgn8pXn8dxxKX4f9bGRy7ertJ+DGw
         0HTP+9ZFrA03SNdeete990g8P/mrpP53lQ1KpiNJ5wfNIiWptjncyKjU7XpKt2y8RY
         2tBDdZBtMuvOw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/6] kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument kvfree_rcu()
Date:   Wed,  3 Mar 2021 16:11:30 -0800
Message-Id: <20210304001134.22977-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304001044.GA22871@paulmck-ThinkPad-P72>
References: <20210304001044.GA22871@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit applies the __GFP_NOMEMALLOC gfp flag to memory allocations
carried out by the single-argument variant of kvfree_rcu(), thus avoiding
this can-sleep code path from dipping into the emergency reserves.

Acked-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1f8c980..08b5044 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3519,7 +3519,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 		if (!bnode && can_alloc) {
 			krc_this_cpu_unlock(*krcp, *flags);
 			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
+				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
 			*krcp = krc_this_cpu_lock(flags);
 		}
 
-- 
2.9.5

