Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9CFC433F5
	for <rcu@archiver.kernel.org>; Mon, 18 Apr 2022 22:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiDRW5B (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 18 Apr 2022 18:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiDRW4s (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 18 Apr 2022 18:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED612CCB9;
        Mon, 18 Apr 2022 15:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D79756112D;
        Mon, 18 Apr 2022 22:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A40C385A9;
        Mon, 18 Apr 2022 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322441;
        bh=5pKw21ROdvL8mIx9oLf8vDqfS0PiGcNeehbP1/+zfCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVxz5Anhp90StSHZZp3f0jD9hYsyxxquGMbncxrx9grbgLZIJlgHkU5xfNHkCDR8h
         fYan2rmSX45Ccm3oz/iQ1GHXESMFgiply1ur1XqNcoIegvuZ0Oh2UqmUQ/u6iD0oA8
         4qL3HrR9a/kaE/sJPjagHaOZdIfw86jevvgQRZZkz6NIbvTDUSDQ1Qh8LRw56fBnIw
         qST8By1VqngzONq3L21lOvSxeWU35vAjgQaPfNI7C04xDrVyZdbGoN/koC+J878aye
         n0pyhJuERn5z2a2sYiDpg3MKKTjl40Pa9BkLM0jeiZpaxHZhrGSwikme8xGCMUI95Z
         bhuXrGxsk4wXA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DE20D5C04BD; Mon, 18 Apr 2022 15:54:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH rcu 01/11] rcu: Clarify fill-the-gap comment in rcu_segcblist_advance()
Date:   Mon, 18 Apr 2022 15:53:49 -0700
Message-Id: <20220418225359.3945217-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Reported-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Reported-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 81145c3ece25..c54ea2b6a36b 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -505,10 +505,10 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 		WRITE_ONCE(rsclp->tails[j], rsclp->tails[RCU_DONE_TAIL]);
 
 	/*
-	 * Callbacks moved, so clean up the misordered ->tails[] pointers
-	 * that now point into the middle of the list of ready-to-invoke
-	 * callbacks.  The overall effect is to copy down the later pointers
-	 * into the gap that was created by the now-ready segments.
+	 * Callbacks moved, so there might be an empty RCU_WAIT_TAIL
+	 * and a non-empty RCU_NEXT_READY_TAIL.  If so, copy the
+	 * RCU_NEXT_READY_TAIL segment to fill the RCU_WAIT_TAIL gap
+	 * created by the now-ready-to-invoke segments.
 	 */
 	for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++, j++) {
 		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
-- 
2.31.1.189.g2e36527f23

