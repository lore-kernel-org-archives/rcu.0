Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE63C4332E
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB8723135
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbhAFQsw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:48:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbhAFQsw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:48:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3025A23118;
        Wed,  6 Jan 2021 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609951691;
        bh=heSMN5xcKRabpSBv4fJMPtXPF24uDi8PAuzbiJca4Zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9G09+HetkNNUdeowdfN6KSll51PJbyIgIGbCd9Y1dg927Dzfya8y/2SBsL8LfTZD
         p6Dhwfm4EOZxOX1lKMEcGgcNL5Kucpwm+oJXpW9S5steRTf0tn/oPuxR0S/MUunS5H
         mfMombfSkoJZTX9BG8sAQRt4N/OVBloXAa4apEZyUJmpQ2bto/pQ8tAm+GTckWQMje
         w5VKXD4NJ1Z3xiMzQvpsaGJfJO2zxLBivTjTNQwF770NCJsZOrDUQfNPSV+wp3PA4S
         ROGmn8rpW0utTouw0i6gHqqXnD44p4YdrPXKxb+D0lraolLXGoiQc8QRRs/pnT290A
         pD7zW2OGgDwBA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/3] rcu: Make RCU_BOOST default on CONFIG_PREEMPT_RT
Date:   Wed,  6 Jan 2021 08:48:07 -0800
Message-Id: <20210106164809.20068-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106164746.GA19969@paulmck-ThinkPad-P72>
References: <20210106164746.GA19969@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On PREEMPT_RT kernels, RCU callbacks are deferred to the `rcuc' kthread.
This can stall RCU grace periods due to lengthy preemption not only of RCU
readers but also of 'rcuc' kthreads, either of which prevent grace periods
from completing, which can in turn result in OOM.  Because PREEMPT_RT
kernels have more kthreads that can block grace periods, it is more
important for such kernels to enable RCU_BOOST.

This commit therefore makes RCU_BOOST the default on PREEMPT_RT.
RCU_BOOST can still be manually disabled if need be.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index cdc57b4..aa8cc8c9 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -188,8 +188,8 @@ config RCU_FAST_NO_HZ
 
 config RCU_BOOST
 	bool "Enable RCU priority boosting"
-	depends on RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT
-	default n
+	depends on (RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT) || PREEMPT_RT
+	default y if PREEMPT_RT
 	help
 	  This option boosts the priority of preempted RCU readers that
 	  block the current preemptible RCU grace period for too long.
-- 
2.9.5

