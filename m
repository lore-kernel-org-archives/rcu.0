Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86745C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5268622BF3
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbhAFEtg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbhAFEtf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:49:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC17E22BF3;
        Wed,  6 Jan 2021 04:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908534;
        bh=hzRekz/qkB4gSiswq1KEvcP3lwbreNJQzdQzCIjeNs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JbKyec84hR+WyLoCiaVQALe1Ol2Osl0kdSo58eGBkmAuE2+4WsBLYmTCUQ7Abizl0
         X1NpN8TDuYW5q2old6rR8+n+s/0b+/T9vWi52eB/GntxJa3JB+ge6UtaA1gqIhEuzj
         iVzvLguRvARkeSbC7JwAHJnhSfHl7lspMySde5rhgOUNvlMo07MZv/87O39HsHvBje
         4cIV0BtT2wcnBmYj9LwWKp3vTheolxHPL0cuepOVtMTk3GdVCuz7W2tI9BmHMN4glu
         zhV1WmMqSMi1eN1GDvbu21yGG78i0NBLxB57gpLTVnPAI6IiqSkfaqMdOeHD1HR1Tz
         2ANZ745hqFrww==
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
Subject: [PATCH tip/core/rcu 01/21] rcu/nocb: Turn enabled/offload states into a common flag
Date:   Tue,  5 Jan 2021 20:48:33 -0800
Message-Id: <20210106044853.20812-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

This commit gathers the rcu_segcblist ->enabled and ->offloaded property
field into a single ->flags bitmask to avoid further proliferation of
individual u8 fields in the structure.  This change prepares for the
state formerly known as ->offloaded state to be modified at runtime.

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
 include/linux/rcu_segcblist.h |  6 ++++--
 kernel/rcu/rcu_segcblist.c    |  6 +++---
 kernel/rcu/rcu_segcblist.h    | 23 +++++++++++++++++++++--
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 6c01f09..4714b02 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -63,6 +63,9 @@ struct rcu_cblist {
 #define RCU_NEXT_TAIL		3
 #define RCU_CBLIST_NSEGS	4
 
+#define SEGCBLIST_ENABLED	BIT(0)
+#define SEGCBLIST_OFFLOADED	BIT(1)
+
 struct rcu_segcblist {
 	struct rcu_head *head;
 	struct rcu_head **tails[RCU_CBLIST_NSEGS];
@@ -73,8 +76,7 @@ struct rcu_segcblist {
 	long len;
 #endif
 	long seglen[RCU_CBLIST_NSEGS];
-	u8 enabled;
-	u8 offloaded;
+	u8 flags;
 };
 
 #define RCU_SEGCBLIST_INITIALIZER(n) \
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 094de25..406c67b 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -246,7 +246,7 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
 		rcu_segcblist_set_seglen(rsclp, i, 0);
 	}
 	rcu_segcblist_set_len(rsclp, 0);
-	rsclp->enabled = 1;
+	rcu_segcblist_set_flags(rsclp, SEGCBLIST_ENABLED);
 }
 
 /*
@@ -257,7 +257,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
 {
 	WARN_ON_ONCE(!rcu_segcblist_empty(rsclp));
 	WARN_ON_ONCE(rcu_segcblist_n_cbs(rsclp));
-	rsclp->enabled = 0;
+	rcu_segcblist_clear_flags(rsclp, SEGCBLIST_ENABLED);
 }
 
 /*
@@ -266,7 +266,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
  */
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
 {
-	rsclp->offloaded = 1;
+	rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
 }
 
 /*
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 18e101d..ff372db 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -53,19 +53,38 @@ static inline long rcu_segcblist_n_cbs(struct rcu_segcblist *rsclp)
 #endif
 }
 
+static inline void rcu_segcblist_set_flags(struct rcu_segcblist *rsclp,
+					   int flags)
+{
+	rsclp->flags |= flags;
+}
+
+static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
+					     int flags)
+{
+	rsclp->flags &= ~flags;
+}
+
+static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
+					    int flags)
+{
+	return READ_ONCE(rsclp->flags) & flags;
+}
+
 /*
  * Is the specified rcu_segcblist enabled, for example, not corresponding
  * to an offline CPU?
  */
 static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 {
-	return rsclp->enabled;
+	return rcu_segcblist_test_flags(rsclp, SEGCBLIST_ENABLED);
 }
 
 /* Is the specified rcu_segcblist offloaded?  */
 static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 {
-	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) && rsclp->offloaded;
+	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
+		rcu_segcblist_test_flags(rsclp, SEGCBLIST_OFFLOADED);
 }
 
 /*
-- 
2.9.5

