Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E2FC433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900C62083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897013;
	bh=Zv8CPkwO+8Sx8yjhF3kXqyIGO3+PF6wlIFtXzoJQavw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mpmjKW24n0ABSH/yHCdKb4Gnb9XsVrL+UPj0HJoHhTgVx/FWdJUP3GerDzLOFHC4j
	 A9ow5TCg2T+ERiXYTb2GTToEGP9HTk+zwfB9knW7npup0h4ABCqC9ja4EGJ1YQI9Bm
	 +JYDRiKBBzp1M3FcgeGRB3ql4P4obFhXmW9v1oio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgHaSC6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbgHaSBY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:24 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9086920866;
        Mon, 31 Aug 2020 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896883;
        bh=Zv8CPkwO+8Sx8yjhF3kXqyIGO3+PF6wlIFtXzoJQavw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUkdiMtGmBH5rc5Mis/B3HC1DZ2jg4moYq59lTM1pi+jCF+8uF53hFRAEG0kaEh6U
         vtWWFAzdNfoxNgjfoSt7B/8jQnL6HsNQif2qJLMiZlkrKemgRzBicK1fmat3BXhckM
         K1x04Wc8X+PZ7kkmFkzK4mCE26xSlkTn0Z61//MA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/24] rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_resched_ns
Date:   Mon, 31 Aug 2020 11:01:04 -0700
Message-Id: <20200831180116.32690-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Given that sysfs can change the value of rcu_resched_ns at any time,
this commit adds a READ_ONCE() to the sole access to that variable.
While in the area, this commit also adds bounds checking, clamping the
value to at least a millisecond, but no longer than a second.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1dca14c..da05afc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2394,8 +2394,12 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	div = READ_ONCE(rcu_divisor);
 	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
 	bl = max(rdp->blimit, pending >> div);
-	if (unlikely(bl > 100))
-		tlimit = local_clock() + rcu_resched_ns;
+	if (unlikely(bl > 100)) {
+		long rrn = READ_ONCE(rcu_resched_ns);
+
+		rrn = rrn < NSEC_PER_MSEC ? NSEC_PER_MSEC : rrn > NSEC_PER_SEC ? NSEC_PER_SEC : rrn;
+		tlimit = local_clock() + rrn;
+	}
 	trace_rcu_batch_start(rcu_state.name,
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
-- 
2.9.5

