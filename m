Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D5EC77B7A
	for <rcu@archiver.kernel.org>; Wed, 31 May 2023 10:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjEaKR7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 31 May 2023 06:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbjEaKRz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 31 May 2023 06:17:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA5B189;
        Wed, 31 May 2023 03:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A3C763082;
        Wed, 31 May 2023 10:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8369EC433D2;
        Wed, 31 May 2023 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685528272;
        bh=3ZmWcklXUR3MN9rHzHFfe6CnosWBzUs6vc5XNpXadQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b/QCg1wWiNj9X/gkuZ0Hj0YPkz0x7EprEOoUIVhh1cluWe91jhRxuFn8VRtDjkl4O
         iteyi2K+SmcZskb3rmpPuP0P3oGf5/hw3qwZaFJPI00YJqSRR4hhpUi1ooL57mSfqy
         VrPHr7pluMcGH2DlYoj5SJaMnv3vGzZlGgFN/XKRbAhNpQvLCjeaL0AypR8OP+EaAx
         W/dYpCC154dWA/qjMzSp639es5o6NbwKg/gfoIajV5C1FGsjTU3wlhfiqdV2+ScOHL
         Dq4+opCaI1ey7lfmIq3PQPlHdKaE84JOw36SmyM8t4rCU4s0IWscLODhwAmTD4773B
         Pyfs+GtT3zSrQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 2/9] rcu: Use rcu_segcblist_segempty() instead of open coding it
Date:   Wed, 31 May 2023 12:17:29 +0200
Message-Id: <20230531101736.12981-3-frederic@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531101736.12981-1-frederic@kernel.org>
References: <20230531101736.12981-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This makes the code more readable.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index f71fac422c8f..1693ea22ef1b 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -368,7 +368,7 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 	smp_mb(); /* Ensure counts are updated before callback is entrained. */
 	rhp->next = NULL;
 	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
-		if (rsclp->tails[i] != rsclp->tails[i - 1])
+		if (!rcu_segcblist_segempty(rsclp, i))
 			break;
 	rcu_segcblist_inc_seglen(rsclp, i);
 	WRITE_ONCE(*rsclp->tails[i], rhp);
@@ -551,7 +551,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	 * as their ->gp_seq[] grace-period completion sequence number.
 	 */
 	for (i = RCU_NEXT_READY_TAIL; i > RCU_DONE_TAIL; i--)
-		if (rsclp->tails[i] != rsclp->tails[i - 1] &&
+		if (!rcu_segcblist_segempty(rsclp, i) &&
 		    ULONG_CMP_LT(rsclp->gp_seq[i], seq))
 			break;
 
-- 
2.40.1

