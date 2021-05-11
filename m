Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9755C433B4
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C73A61184
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhEKWyP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhEKWyN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8C4361606;
        Tue, 11 May 2021 22:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773586;
        bh=IxZUyRJKXHqt1jMzH6xJ7QOAHg5TorZXYUdMp/9Zjvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTvuvwnZQeYZU/wq6oQsCBuVJuBMtURuIusLafFUOpeApcG0Q/yGd41b+IX5FE1i8
         OcWAjmRLhIDIH+TuwFEvgwR6liP/iMJcNTtlX5Gh7mvg9u5Pej7SJs7qp7qfmh0vXE
         df4ZyF1ZSAMkPUwspuP1yKmeolLcv1lkSr1K1LvffzPUz+K9pSYFu5W9YVAZbYMHRr
         5Gvfp28B5v4kV7SdDHQ1tRuBonQjelOzRjdkJJ8UwJeHJdEpMdhGRaBrvY4LFejri3
         2roYyf20sSPRMOZEupyGxKxwCKXmfCwrRCDYodoLrA+vfkH102OK/hUD4qekYr1r31
         BtZczZ+5m1viw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8B13F5C014E; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/19] rcu: Remove the unused rcu_irq_exit_preempt() function
Date:   Tue, 11 May 2021 15:52:47 -0700
Message-Id: <20210511225304.2893154-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Commit 9ee01e0f69a9 ("x86/entry: Clean up idtentry_enter/exit()
leftovers") left the rcu_irq_exit_preempt() in place in order to avoid
conflicts with the -rcu tree.  Now that this change has long since hit
mainline, this commit removes the no-longer-used rcu_irq_exit_preempt()
function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h |  1 -
 include/linux/rcutree.h |  1 -
 kernel/rcu/tree.c       | 22 ----------------------
 3 files changed, 24 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 35e0be326ffc..953e70fafe38 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -86,7 +86,6 @@ static inline void rcu_irq_enter(void) { }
 static inline void rcu_irq_exit_irqson(void) { }
 static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
-static inline void rcu_irq_exit_preempt(void) { }
 static inline void rcu_irq_exit_check_preempt(void) { }
 #define rcu_is_idle_cpu(cpu) \
 	(is_idle_task(current) && !in_nmi() && !in_irq() && !in_serving_softirq())
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index b89b54130f49..53209d669400 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -49,7 +49,6 @@ void rcu_idle_enter(void);
 void rcu_idle_exit(void);
 void rcu_irq_enter(void);
 void rcu_irq_exit(void);
-void rcu_irq_exit_preempt(void);
 void rcu_irq_enter_irqson(void);
 void rcu_irq_exit_irqson(void);
 bool rcu_is_idle_cpu(int cpu);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e78b2430c16..f6543b8004c0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -833,28 +833,6 @@ void noinstr rcu_irq_exit(void)
 	rcu_nmi_exit();
 }
 
-/**
- * rcu_irq_exit_preempt - Inform RCU that current CPU is exiting irq
- *			  towards in kernel preemption
- *
- * Same as rcu_irq_exit() but has a sanity check that scheduling is safe
- * from RCU point of view. Invoked from return from interrupt before kernel
- * preemption.
- */
-void rcu_irq_exit_preempt(void)
-{
-	lockdep_assert_irqs_disabled();
-	rcu_nmi_exit();
-
-	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) <= 0,
-			 "RCU dynticks_nesting counter underflow/zero!");
-	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) !=
-			 DYNTICK_IRQ_NONIDLE,
-			 "Bad RCU  dynticks_nmi_nesting counter\n");
-	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
-			 "RCU in extended quiescent state!");
-}
-
 #ifdef CONFIG_PROVE_RCU
 /**
  * rcu_irq_exit_check_preempt - Validate that scheduling is possible
-- 
2.31.1.189.g2e36527f23

