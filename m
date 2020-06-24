Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11325C433DF
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8A920885
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029618;
	bh=qZiGFZJ7CbgHMHQDzAwiU/MwuJbSwOc7xfMxb2POM70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AUu1E/lbEhqFQiYWlRDnFakS0W8dFj+GkMmzf9eaHkvYng8/v0mWC+JEXucRV/3AD
	 D1Q7e34O4ofJL55fgMcnLjKkDfP8tkoZsR7m0MwEqv16wokcH1BdBwUvc5cLHw6UjZ
	 jmRD2HEDiNaDP9plQIwqBoNY+lajFcoiZht3VvxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406522AbgFXUN1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406378AbgFXUM3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:29 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE6F32137B;
        Wed, 24 Jun 2020 20:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029548;
        bh=qZiGFZJ7CbgHMHQDzAwiU/MwuJbSwOc7xfMxb2POM70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRtnN15DHCLVpUxcpepum/t4ehq5kOCp9+gqEP0sZDHsfH4Be6YMnZ+vsiYb8iPTU
         KOUm2MT0YRADhRVhluZ/fhAw3Uhk8RbrtQsMD8Qh7/0Vdc+Ji6GTK+AWX9b861Cjoi
         mFk4qYeY8pQG3FL1RRc0IvigdyFHMv7bjY5QfOBo=
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
Subject: [PATCH tip/core/rcu 04/17] rcu/tree: Repeat the monitor if any free channel is busy
Date:   Wed, 24 Jun 2020 13:12:13 -0700
Message-Id: <20200624201226.21197-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

It is possible that one of the channels cannot be detached
because its free channel is busy and previously queued data
has not been processed yet. On the other hand, another
channel can be successfully detached causing the monitor
work to stop.

Prevent that by rescheduling the monitor work if there are
any channels in the pending state after a detach attempt.

Fixes: 34c881745549e ("rcu: Support kfree_bulk() interface in kfree_rcu()")
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index dbdd509..31d3b2c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3087,7 +3087,7 @@ static void kfree_rcu_work(struct work_struct *work)
 static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 {
 	struct kfree_rcu_cpu_work *krwp;
-	bool queued = false;
+	bool repeat = false;
 	int i;
 
 	lockdep_assert_held(&krcp->lock);
@@ -3125,11 +3125,14 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 			 * been detached following each other, one by one.
 			 */
 			queue_rcu_work(system_wq, &krwp->rcu_work);
-			queued = true;
 		}
+
+		/* Repeat if any "free" corresponding channel is still busy. */
+		if (krcp->bhead || krcp->head)
+			repeat = true;
 	}
 
-	return queued;
+	return !repeat;
 }
 
 static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
-- 
2.9.5

