Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D53AC433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2521064F11
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbhCDBAy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1388886AbhCDAMW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:12:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B28B564FDF;
        Thu,  4 Mar 2021 00:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816696;
        bh=cjh6VmiHvrnhfJBshUF8siGxpPXrWEtbO/M1VD8ZxlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uspH3LB+mARmWbuktqi58vh+Z3KuChAAZE5JMC2HuzYOhWBGZ1kM6Ui07u8lZq5ym
         F780fPnwoAUEFnSMXkoUhphP2Ua6a3LipTeGrAndARpHDgDWhWv2rAWQQTS4v9fG4/
         oGxtSxphGeGK29K/TlYpptjsSDkgyhu0ObeJNl0Xg2g+MnhN44BMlIGK5rLW79y4FK
         T1hgVFt7eTuLY5wfE6BV4VvlHChz5hOHpPlTcJU9ZyjUsaR04wZtSdJh3v2Pi3mSxY
         7Ftdb/BD9aXcKTgIWRsRUkqmQH9Q5rTh16naBjIaIkW6CIRKTU9lLuzGsxAtXlFFF4
         6QOg9bqyHhlOw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/6] kvfree_rcu: Replace __GFP_RETRY_MAYFAIL by __GFP_NORETRY
Date:   Wed,  3 Mar 2021 16:11:32 -0800
Message-Id: <20210304001134.22977-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304001044.GA22871@paulmck-ThinkPad-P72>
References: <20210304001044.GA22871@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

__GFP_RETRY_MAYFAIL can spend quite a bit of time reclaiming, and this
can be wasted effort given that there is a fallback code path in case
memory allocation fails.

__GFP_NORETRY does perform some light-weight reclaim, but it will fail
under OOM conditions, allowing the fallback to be taken as an alternative
to hard-OOMing the system.

There is a four-way tradeoff that must be balanced:
    1) Minimize use of the fallback path;
    2) Avoid full-up OOM;
    3) Do a light-wait allocation request;
    4) Avoid dipping into the emergency reserves.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7ee83f3..0ecc1fb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3517,8 +3517,20 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 		bnode = get_cached_bnode(*krcp);
 		if (!bnode && can_alloc) {
 			krc_this_cpu_unlock(*krcp, *flags);
+
+			// __GFP_NORETRY - allows a light-weight direct reclaim
+			// what is OK from minimizing of fallback hitting point of
+			// view. Apart of that it forbids any OOM invoking what is
+			// also beneficial since we are about to release memory soon.
+			//
+			// __GFP_NOMEMALLOC - prevents from consuming of all the
+			// memory reserves. Please note we have a fallback path.
+			//
+			// __GFP_NOWARN - it is supposed that an allocation can
+			// be failed under low memory or high memory pressure
+			// scenarios.
 			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
+				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 			*krcp = krc_this_cpu_lock(flags);
 		}
 
-- 
2.9.5

