Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C6FC0015E
	for <rcu@archiver.kernel.org>; Sun,  9 Jul 2023 14:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjGIO4s (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 9 Jul 2023 10:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGIO4l (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 9 Jul 2023 10:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08913E6A;
        Sun,  9 Jul 2023 07:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 212FD60BFF;
        Sun,  9 Jul 2023 14:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A260C433C7;
        Sun,  9 Jul 2023 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688914561;
        bh=WfXYU0XTwimX7hvx+kdyEaHoUwk4tWIpYOn2FNmkAa4=;
        h=From:To:Cc:Subject:Date:From;
        b=VljG7WR1URF+pAxTspoFXc4fLHyauVk/qtI+NGS35TkBEc7KzyTLR0MPGZKCn6JgJ
         7d9uPrGo0ohAyZ833tTW2TzAbzXpm1Gc2SOvejnuzpxtqPDIEOVCnaoVYFppMRL0sf
         Mm/pB3BTCZmjPFGRvyNeCgLHmP2TgPN7UNSR7vKL4O7pwH2TARDJdiV8d7s+zJ5R5+
         WuEYzjR9N6/pF8TqOCgFf/id9YEaBg2YxgHildPpHiQIa5BSzwboahKz2vq2KioqxH
         OI4RgbimuNQw/+GOwdPdKFzjlZJPdNEklx3JNaDZL8TsvoX+2DKDM5gglnBHKvkotJ
         iVfmM1pfSNzIQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4] rcu: Mark rcu_cpu_kthread() accesses to ->rcu_cpu_has_work
Date:   Sun,  9 Jul 2023 10:55:58 -0400
Message-Id: <20230709145558.512392-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.249
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
index 615283404d9dc..98d64f107fbb7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2457,12 +2457,12 @@ static void rcu_cpu_kthread(unsigned int cpu)
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

