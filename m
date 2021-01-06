Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D03C4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685A5230FD
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbhAFA6c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:58:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbhAFA6T (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 19:58:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EC36230FB;
        Wed,  6 Jan 2021 00:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894658;
        bh=c8pNqvTvHY/gLSnjtC+oe158U/JTDPDcYcVU+r3qDeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hgq/eAYXS2IvaJxQ98dgxfjUxnG59RPFCM1udzuBHdMUrEj1b/NT7BSeapxHs2xSM
         M3OVJizQTWmvd5W75YGF7q1KkTrw1WJtHrMoxVlCZ20mxdA1cPc1ZBx4zs9XwXVC9C
         Tee1bM+5CBhqCxUx40QKckJdV0OpB+P/zZ6MH+rWjGdvtVEP44Oak8fbstgNf99Q3N
         l9uqtvsb1O3E6ormJqlnm8I8Pf8gzPhPy86wHGlIAoNcWhS7IzxhZoFwRC2RpGQYGQ
         TY/TFxfqw8gnmE7B96Vvg5SnWwujfbIIaZb4zymyd/pnbq7k9TI+6LoBLLLxXK0+si
         UqYKPtlVuzycQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/6] rcu: Add lockdep_assert_irqs_disabled() to raw_spin_unlock_rcu_node() macros
Date:   Tue,  5 Jan 2021 16:57:34 -0800
Message-Id: <20210106005736.12613-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106005713.GA12492@paulmck-ThinkPad-P72>
References: <20210106005713.GA12492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a lockdep_assert_irqs_disabled() call to the
helper macros that release the rcu_node structure's ->lock, namely
to raw_spin_unlock_rcu_node(), raw_spin_unlock_irq_rcu_node() and
raw_spin_unlock_irqrestore_rcu_node().  The point of this is to help track
down a situation where lockdep appears to be insisting that interrupts
are enabled while holding an rcu_node structure's ->lock.

Link: https://lore.kernel.org/lkml/20201111133813.GA81547@elver.google.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index e01cba5..839f5be 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -378,7 +378,11 @@ do {									\
 	smp_mb__after_unlock_lock();					\
 } while (0)
 
-#define raw_spin_unlock_rcu_node(p) raw_spin_unlock(&ACCESS_PRIVATE(p, lock))
+#define raw_spin_unlock_rcu_node(p)					\
+do {									\
+	lockdep_assert_irqs_disabled();					\
+	raw_spin_unlock(&ACCESS_PRIVATE(p, lock));			\
+} while (0)
 
 #define raw_spin_lock_irq_rcu_node(p)					\
 do {									\
@@ -387,7 +391,10 @@ do {									\
 } while (0)
 
 #define raw_spin_unlock_irq_rcu_node(p)					\
-	raw_spin_unlock_irq(&ACCESS_PRIVATE(p, lock))
+do {									\
+	lockdep_assert_irqs_disabled();					\
+	raw_spin_unlock_irq(&ACCESS_PRIVATE(p, lock));			\
+} while (0)
 
 #define raw_spin_lock_irqsave_rcu_node(p, flags)			\
 do {									\
@@ -396,7 +403,10 @@ do {									\
 } while (0)
 
 #define raw_spin_unlock_irqrestore_rcu_node(p, flags)			\
-	raw_spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags)
+do {									\
+	lockdep_assert_irqs_disabled();					\
+	raw_spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags);	\
+} while (0)
 
 #define raw_spin_trylock_rcu_node(p)					\
 ({									\
-- 
2.9.5

