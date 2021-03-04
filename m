Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF7BC433E6
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD36C64F09
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbhCDBBD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448595AbhCDAZ6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:25:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD77064EBA;
        Thu,  4 Mar 2021 00:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817396;
        bh=OGdGOODUp4/8zIi8MgBFgAqE3trdWnuuEqxNa7WSqPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcQtQqcuWrKTzYg7BsSyf/N1yVD6VqL4JCLikTF9jRZ+091L3qypNfz6H8CjErHCW
         swDJnkNg9RH5zEmCf3mOKhQD/EidUiOV95y5wGSo2km2ptl/fsEHH3T8Dr6WAhT/Jz
         1tLRII+uDQ6QPw2tbQ4NjiamKto69EsNhiId7Sy8lq45YdYpRyrqwVm7cxg1kl/Hnu
         PasiJ5dupeq7G/w1D8vDpv9Njgk5GLHKj6zziJXQPkawm2p62WdCaQEhSevxFNjKIO
         x5oQnjttHu4Fj0QfkeIgYv2GoMrn63vpXn+zeyLa+cAaeTqnlY8aIQwbZkzbKzLKD2
         HrQWcxsW9+N5Q==
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
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/12] rcu/nocb: Remove stale comment above rcu_segcblist_offload()
Date:   Wed,  3 Mar 2021 16:23:10 -0800
Message-Id: <20210304002311.23655-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002225.GA23492@paulmck-ThinkPad-P72>
References: <20210304002225.GA23492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

This commit removes a stale comment claiming that the cblist must be
empty before changing the offloading state.  This claim was correct back
when the offloaded state was defined exclusively at boot.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 7f181c9..aaa1112 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -261,8 +261,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
 }
 
 /*
- * Mark the specified rcu_segcblist structure as offloaded.  This
- * structure must be empty.
+ * Mark the specified rcu_segcblist structure as offloaded.
  */
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload)
 {
-- 
2.9.5

