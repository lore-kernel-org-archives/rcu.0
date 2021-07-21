Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBE3C63793
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D279461244
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbhGUTlC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240379AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E032C61279;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898889;
        bh=BsMVES/4pOvZzzTWNbQuBOd0AUGBlVJkPvguuj5ByGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4wV1bMxLAnON3LUOonogDOSRTjL1mT9c330TUXOpkylBmoYkb9pMZPY32magCquF
         WIV1J2T+PJCNq1XepoKLN+xKtHXbJMiyZCnuFuabIU9QDzOtBGHkqGl14T3skJvLNB
         GiA8JRwTZWTu6gYS4NkmY5dpyqetAWKtSmQJXo6bwJyqdNTyI6oYtWj7/5FWWxpZP6
         +y/cn1EqxKUrpNXAuOUumu76sYrNACQxC0aUoXOI9xox57Cxg+7IbC7RS6NQvjJ4Fi
         Vm1nXdfdmFzxp2bOjvn5C9L+fbi13u6YxGMY8ZLFhmhL47VZ+LaK4YzweMm9XiCmd4
         2W0dQNDgZNXUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4BB0E5C0F64; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/18] srcutiny: Mark read-side data races
Date:   Wed, 21 Jul 2021 13:21:18 -0700
Message-Id: <20210721202127.2129660-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit marks some interrupt-induced read-side data races in
__srcu_read_lock(), __srcu_read_unlock(), and srcu_torture_stats_print().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutiny.h | 8 ++++----
 kernel/rcu/srcutiny.c    | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 0e0cf4d6a72a0..6cfaa0a9a9b96 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -61,7 +61,7 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 	int idx;
 
 	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
-	WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
+	WRITE_ONCE(ssp->srcu_lock_nesting[idx], READ_ONCE(ssp->srcu_lock_nesting[idx]) + 1);
 	return idx;
 }
 
@@ -81,11 +81,11 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
 {
 	int idx;
 
-	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
+	idx = ((data_race(READ_ONCE(ssp->srcu_idx)) + 1) & 0x2) >> 1;
 	pr_alert("%s%s Tiny SRCU per-CPU(idx=%d): (%hd,%hd)\n",
 		 tt, tf, idx,
-		 READ_ONCE(ssp->srcu_lock_nesting[!idx]),
-		 READ_ONCE(ssp->srcu_lock_nesting[idx]));
+		 data_race(READ_ONCE(ssp->srcu_lock_nesting[!idx])),
+		 data_race(READ_ONCE(ssp->srcu_lock_nesting[idx])));
 }
 
 #endif
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 26344dc6483b0..a0ba2ed49bc61 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -96,7 +96,7 @@ EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
  */
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
-	int newval = ssp->srcu_lock_nesting[idx] - 1;
+	int newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
 
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
 	if (!newval && READ_ONCE(ssp->srcu_gp_waiting))
-- 
2.31.1.189.g2e36527f23

