Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A88EB64DD
	for <rcu@archiver.kernel.org>; Sun,  9 Jul 2023 14:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjGIOzj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 9 Jul 2023 10:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjGIOzi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 9 Jul 2023 10:55:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62F5126;
        Sun,  9 Jul 2023 07:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A8A360BF9;
        Sun,  9 Jul 2023 14:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A21C433CC;
        Sun,  9 Jul 2023 14:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688914536;
        bh=xtky2eZeYE1ot9ktlv6JCxZlIIkGO633lZ/UL2RCaNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QlMVMS1cqOeCDgfbzb2TBdUnhxT+ofAhunZ3pWHJPz1uxsU9Jlh2eGRqJHrbBM5OE
         fiUD0vXnpR3mZhTj45KSFTny9nI5p53u/IwlE7HJx47YNFTqzqjiannzyPeDdMs1+d
         xnSjs4OoAattxM8xvlIIWOynz/CtBQ6hrd/N6CVcbYf1CPi3H+9w3uNck4depnHy1W
         NXF+tnJ7M9bwEhzZsNE/S5m0dtqYLA45PeXxDcOnlOf2Yq9sWZFbihUz3PfITXwBHW
         myjPiIcl8L+Fgc0/8MBRSNGhLktV4La8eNaMTcPa7p3MrhJtrOxdsNYGVDtWJOVWgD
         xirCZbBuwbb/w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 3/4] rcu: Mark rcu_cpu_kthread() accesses to ->rcu_cpu_has_work
Date:   Sun,  9 Jul 2023 10:55:29 -0400
Message-Id: <20230709145530.512177-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709145530.512177-1-sashal@kernel.org>
References: <20230709145530.512177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.2
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
index f52ff72410416..fe649dd0165c3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2459,12 +2459,12 @@ static void rcu_cpu_kthread(unsigned int cpu)
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

