Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352F2C4332F
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C2A6121F
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhIOXfI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232935AbhIOXfE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44DDF61212;
        Wed, 15 Sep 2021 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748825;
        bh=+hj63Mjsm9/ZDQadWxfRWJSN0LT4l+ZeTY9+sSnyZZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPWbsWdxR0VqxPHGzpSyHV3v/DYjqwBARqN48OFCWTzQ2VUlYq87qxAKKkW3lqxsC
         3D4sM+dVwegf5PI5yfqIGD+MawMWv/uf3t2QkXrjRq9dgiXE0B407zgLkkqiUZnwbd
         QCv4XGMq7GfM28+htSaAqOlzopBGejav4NarCM+7R3GYm3j4hVVc+ks0dm4vbBo3hZ
         NA0AbP3WrLqhfWqpS7hWrIcuI/HKvKHefqGJ0vWKo7KfCYpjqCP7w+LKyOFzWpyfO8
         WbWVtKQaRo2Om4kaLDV0Eul1pxwBb9AwtLr4Vx54H6a5UOCH7t/FY5AX9rVNjI59DH
         jVLTXcTxrdWfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CAAF75C0B1B; Wed, 15 Sep 2021 16:33:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/14] rcu: Simplify rcu_report_dead() call to rcu_report_exp_rdp()
Date:   Wed, 15 Sep 2021 16:33:38 -0700
Message-Id: <20210915233343.3906738-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, rcu_report_dead() disables preemption across its call to
rcu_report_exp_rdp(), but this is pointless because interrupts are
already disabled by the caller.  In addition, rcu_report_dead() computes
the address of the outgoing CPU's rcu_data structure, which is also
pointless because this address is already present in local variable rdp.
This commit therefore drops the preemption disabling and passes rdp
to rcu_report_exp_rdp().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 801075e36515..dc2968473593 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4294,9 +4294,7 @@ void rcu_report_dead(unsigned int cpu)
 	do_nocb_deferred_wakeup(rdp);
 
 	/* QS for any half-done expedited grace period. */
-	preempt_disable();
-	rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
-	preempt_enable();
+	rcu_report_exp_rdp(rdp);
 	rcu_preempt_deferred_qs(current);
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
-- 
2.31.1.189.g2e36527f23

