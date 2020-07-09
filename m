Return-Path: <SRS0=ITGo=AU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE32C433E0
	for <rcu@archiver.kernel.org>; Thu,  9 Jul 2020 13:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424E32076A
	for <rcu@archiver.kernel.org>; Thu,  9 Jul 2020 13:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGINGC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:06:02 -0400
Received: from sym2.noone.org ([178.63.92.236]:33192 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgGINGC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 9 Jul 2020 09:06:02 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4B2byb5mjYzvjc1; Thu,  9 Jul 2020 15:05:59 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     rcu@vger.kernel.org
Subject: [PATCH v2] rcu: fix kerneldoc comments in rcuupdate.h
Date:   Thu,  9 Jul 2020 15:05:59 +0200
Message-Id: <20200709130559.25588-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Fix the kerneldoc comments for rcu_read_unlock_bh(),
rcu_read_unlock_sched() and rcu_head_after_call_rcu() so they e.g. get
properly linked in the API documentation. Also add parenthesis after
function names to match the notation used in other kerneldoc comments in
the same file.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
v2: extend commit message to explain added "()" after functio  names

 include/linux/rcupdate.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d15d46db61f7..b47d6b66665e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -709,8 +709,8 @@ static inline void rcu_read_lock_bh(void)
 			 "rcu_read_lock_bh() used illegally while idle");
 }
 
-/*
- * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
+/**
+ * rcu_read_unlock_bh() - marks the end of a softirq-only RCU critical section
  *
  * See rcu_read_lock_bh() for more information.
  */
@@ -751,10 +751,10 @@ static inline notrace void rcu_read_lock_sched_notrace(void)
 	__acquire(RCU_SCHED);
 }
 
-/*
- * rcu_read_unlock_sched - marks the end of a RCU-classic critical section
+/**
+ * rcu_read_unlock_sched() - marks the end of a RCU-classic critical section
  *
- * See rcu_read_lock_sched for more information.
+ * See rcu_read_lock_sched() for more information.
  */
 static inline void rcu_read_unlock_sched(void)
 {
@@ -945,7 +945,7 @@ static inline void rcu_head_init(struct rcu_head *rhp)
 }
 
 /**
- * rcu_head_after_call_rcu - Has this rcu_head been passed to call_rcu()?
+ * rcu_head_after_call_rcu() - Has this rcu_head been passed to call_rcu()?
  * @rhp: The rcu_head structure to test.
  * @f: The function passed to call_rcu() along with @rhp.
  *
-- 
2.27.0

