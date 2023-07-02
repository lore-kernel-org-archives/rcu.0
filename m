Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B051EB64DA
	for <rcu@archiver.kernel.org>; Sun,  2 Jul 2023 20:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjGBUIM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Jul 2023 16:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjGBUHi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Jul 2023 16:07:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4EFE79;
        Sun,  2 Jul 2023 13:05:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82F2660CB9;
        Sun,  2 Jul 2023 19:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF172C433CC;
        Sun,  2 Jul 2023 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327883;
        bh=Lw5FUHGXYbMN7CUZSGPeOSaJjViqljPJkZoPNIpw0PY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1C2RS4l9VK5WTC1IfLkfnHgxc1Ijq21+3hkTYgv1QpHbotDaeq4/Kk+vVvfwNJaM
         wjjz4ZEWPcG88+1a6DNmr98BjxCP7WxlaIBKdBWLZvbLRFUjw3/zXcuW7n8RRV9zcR
         YWMGfhkZppnDzeHPbny+nNnen4ViyirPDIhyJSc2Xl4g9dbWRbOwKhY3KPydlPTq9K
         ufHDPOQUC4PwgctBA0lKahQ5gqORtg5ReCByX+xNnoSDNYVT+Jan4Fn18tBHrR5kpv
         T9lCnAVdBw1fBhz1rv/3xTUQccqhWarpi3dMxUvLQi9padGokBsvr5mn8k46IFHCLL
         npmEWJMjB/JpQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 3/3] rcu: Mark rcu_cpu_kthread() accesses to ->rcu_cpu_has_work
Date:   Sun,  2 Jul 2023 15:57:56 -0400
Message-Id: <20230702195756.1793443-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195756.1793443-1-sashal@kernel.org>
References: <20230702195756.1793443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.37
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit a24c1aab652ebacf9ea62470a166514174c96fe1 ]

The rcu_data structure's ->rcu_cpu_has_work field can be modified by
any CPU attempting to wake up the rcuc kthread.  Therefore, this commit
marks accesses to this field from the rcu_cpu_kthread() function.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d03122f90cc48..0f07d44c389eb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2593,12 +2593,12 @@ static void rcu_cpu_kthread(unsigned int cpu)
 		*statusp = RCU_KTHREAD_RUNNING;
 		local_irq_disable();
 		work = *workp;
-		*workp = 0;
+		WRITE_ONCE(*workp, 0);
 		local_irq_enable();
 		if (work)
 			rcu_core();
 		local_bh_enable();
-		if (*workp == 0) {
+		if (!READ_ONCE(*workp)) {
 			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
 			*statusp = RCU_KTHREAD_WAITING;
 			return;
-- 
2.39.2

