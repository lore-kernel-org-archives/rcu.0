Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F73C433DF
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E5620823
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029607;
	bh=7PRSmwXRt+CrreGfiCD0MNS6UfD6diKqGp83Myw2DTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g3c2A2mXmWqy4PkkBjso9hiXa9X/XBRJl9ClyWH/1OYCsQf5jqu0wyYVJnC0kFB1L
	 16gojTXRzY7aL+4ySMPFxWtkHQSvUg/eheo4BuB+IZVysa+vF36CMFE3bHPRGJfGcY
	 oXQy8a0Rt8qQfEGV2tF+/7jQhu+IPkqhYo7q2j/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406384AbgFXUN0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406251AbgFXUMa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B75920E65;
        Wed, 24 Jun 2020 20:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029549;
        bh=7PRSmwXRt+CrreGfiCD0MNS6UfD6diKqGp83Myw2DTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=soWj4b8Jd8MKtBdEOjiLFpFG9PU01G4pCAne4kTj4wVfL5THRO/9aknm8EBFudoOQ
         tg8ylG8P67zmP8mRkEtpuwzk04dh6KTHqgcLgCcS0IhacPRQa4J6OpU6fs3SFyx2zN
         zLIFJlwytGRQ4GiwLzb5gdeZriRa8uAqILLgGqTc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/17] rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro
Date:   Wed, 24 Jun 2020 13:12:15 -0700
Message-Id: <20200624201226.21197-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

We can simplify KFREE_BULK_MAX_ENTR macro and get rid of
magic numbers which were used to make the structure to be
exactly one page.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index dc5369a..519a3f5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2940,13 +2940,6 @@ EXPORT_SYMBOL_GPL(call_rcu);
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
 #define KFREE_N_BATCHES 2
 
-/*
- * This macro defines how many entries the "records" array
- * will contain. It is based on the fact that the size of
- * kfree_rcu_bulk_data structure becomes exactly one page.
- */
-#define KFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 3)
-
 /**
  * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
  * @nr_records: Number of active pointers in the array
@@ -2955,10 +2948,18 @@ EXPORT_SYMBOL_GPL(call_rcu);
  */
 struct kfree_rcu_bulk_data {
 	unsigned long nr_records;
-	void *records[KFREE_BULK_MAX_ENTR];
 	struct kfree_rcu_bulk_data *next;
+	void *records[];
 };
 
+/*
+ * This macro defines how many entries the "records" array
+ * will contain. It is based on the fact that the size of
+ * kfree_rcu_bulk_data structure becomes exactly one page.
+ */
+#define KFREE_BULK_MAX_ENTR \
+	((PAGE_SIZE - sizeof(struct kfree_rcu_bulk_data)) / sizeof(void *))
+
 /**
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
-- 
2.9.5

