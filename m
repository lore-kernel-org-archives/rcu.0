Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44448C63697
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E882822240
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="koMXFZnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgKMMNu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:13:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKMMNr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:13:47 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 789D22224B;
        Fri, 13 Nov 2020 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269627;
        bh=sujLKVw46d3MU1NqvO30Z15mMB9Z4AXw745RHEipyUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koMXFZnNGjggK7MiYc1svqIhk5YCemnctWAMOARdvDWea/vStw9/9Qo0xARXF+c8t
         2sN78rRSu6HA/xWgdLCQplXa+zCaGHgYVh4el1Y5hGTB6R8dH0jN4l7+RamUtN+lvI
         +sH7QZa/oQfTP9X+zQ8QU/IqbT5ZpM05+aprGQeg=
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
Subject: [PATCH 01/19] rcu/nocb: Turn enabled/offload states into a common flag
Date:   Fri, 13 Nov 2020 13:13:16 +0100
Message-Id: <20201113121334.166723-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Gather the segcblist properties in a common map to avoid spreading
booleans in the structure. And this prepares for the offloaded state to
be mutable on runtime.

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
 include/linux/rcu_segcblist.h |  6 ++++--
 kernel/rcu/rcu_segcblist.c    |  6 +++---
 kernel/rcu/rcu_segcblist.h    | 23 +++++++++++++++++++++--
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 6c01f09a6456..4714b0263c76 100644
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
index 5059b6102afe..e374f9c3ec2c 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -234,7 +234,7 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
 		rcu_segcblist_set_seglen(rsclp, i, 0);
 	}
 	rcu_segcblist_set_len(rsclp, 0);
-	rsclp->enabled = 1;
+	rcu_segcblist_set_flags(rsclp, SEGCBLIST_ENABLED);
 }
 
 /*
@@ -245,7 +245,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
 {
 	WARN_ON_ONCE(!rcu_segcblist_empty(rsclp));
 	WARN_ON_ONCE(rcu_segcblist_n_cbs(rsclp));
-	rsclp->enabled = 0;
+	rcu_segcblist_clear_flags(rsclp, SEGCBLIST_ENABLED);
 }
 
 /*
@@ -254,7 +254,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
  */
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
 {
-	rsclp->offloaded = 1;
+	rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
 }
 
 /*
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index cd35c9faaf51..3d1195dbf030 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -50,19 +50,38 @@ static inline long rcu_segcblist_n_cbs(struct rcu_segcblist *rsclp)
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
2.25.1

