Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6FAC6377B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C4D61363
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhGUUYJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229682AbhGUUYH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:24:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44F4661001;
        Wed, 21 Jul 2021 21:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901483;
        bh=ObGy8V6cEg8aYBOyo0XPD2qmVdUjzVNCC1lAcCY6Kj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lqRk3e34IDJ4YXIIKqeAospFRi8d8Om5g6BSAVWP5Ifu0TupQlG3jrWZwXYQ1jKfz
         2dLSRrO7iEeY7MQreGCkLdtFeM3NRlBGy03iZu2fZsK3EwjW8VBbL+xeZLTXv1N+Xt
         7zT03gUIUDiZnDhrDV8PeCHeh2FcAiBxixAXvzcP7MPptY9N6dWBRhiOItHbzhs4f2
         5vcFUVTYAsBoaXFB7wNaOsxPaoKiI2Va48Tm121xCto0ZC8e28fZl/jXRlkELS2oaU
         E7S+skSgT4VlKnqHah7uOhYx/cw5LgYDRaNGLV6bB28C9Mh4Hg8rzBL2+dpdKBNNFH
         byN6iKsYr7nVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1D5285C0A03; Wed, 21 Jul 2021 14:04:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/7] rcutorture: Preempt rather than block when testing task stalls
Date:   Wed, 21 Jul 2021 14:04:36 -0700
Message-Id: <20210721210441.796995-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, rcu_torture_stall() does a one-jiffy timed wait when
stall_cpu_block is set.  This works, but emits a pointless splat in
CONFIG_PREEMPT=y kernels.  This commit avoids this splat by instead
invoking preempt_schedule() in CONFIG_PREEMPT=y kernels.

This uses an admittedly ugly #ifdef, but abstracted approaches just
looked worse.  A prettier approach would provide a preempt_schedule()
definition with a WARN_ON() for CONFIG_PREEMPT=n kernels, but this seems
quite silly.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 40ef5417d9545..ab4215266ebee 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2022,8 +2022,13 @@ static int rcu_torture_stall(void *args)
 			  __func__, raw_smp_processor_id());
 		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
 				    stop_at))
-			if (stall_cpu_block)
+			if (stall_cpu_block) {
+#ifdef CONFIG_PREEMPTION
+				preempt_schedule();
+#else
 				schedule_timeout_uninterruptible(HZ);
+#endif
+			}
 		if (stall_cpu_irqsoff)
 			local_irq_enable();
 		else if (!stall_cpu_block)
-- 
2.31.1.189.g2e36527f23

