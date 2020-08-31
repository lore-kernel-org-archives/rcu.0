Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF32C433E7
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A6E920866
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598896971;
	bh=WQvxHjrMr7Wy1mM1Q9O6pBb2oem88hcom7Xn7VGv8vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VMPS22+R1DXZ9HxKnImYzrjPJf1QW8e7UbQjqLWyYOiBNfCaRneYSe+hIh17V2rG3
	 aVnggTeDwpfOWU1WeH3dWpZBDZeSjupXRStbjt0pQkGy0ZvTMMzsvKEMzkvN/Hh5Lb
	 HXTGk2RRyODBsjomc+FFNpINJGAQB2nkuifGN6cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgHaSBi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgHaSB2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:28 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BD052177B;
        Mon, 31 Aug 2020 18:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896887;
        bh=WQvxHjrMr7Wy1mM1Q9O6pBb2oem88hcom7Xn7VGv8vA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E1XE8aLZE3u0Zn5cC+qugfbR65bAwSIpUsQ+aJhgXiSoa6Wi7noX3BKTKnPwpGQgX
         Vs2gbyRaqccUalEojdxQ0PuTSs4FnU9GD3k14inWZDK2BTc9laL6n2fOn8o8y6qMpt
         FoMBdgnMEqSXX7UTnG2jOZFPkxS9XpBhLhFmgsow=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH tip/core/rcu 22/24] rcu: Remove unused __rcu_is_watching() function
Date:   Mon, 31 Aug 2020 11:01:14 -0700
Message-Id: <20200831180116.32690-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The x86/entry work removed all uses of __rcu_is_watching(), therefore
this commit removes it entirely.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h | 1 -
 include/linux/rcutree.h | 1 -
 kernel/entry/common.c   | 2 +-
 kernel/rcu/tree.c       | 5 -----
 4 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 5cc9637..7c1ecdb 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -103,7 +103,6 @@ static inline void rcu_scheduler_starting(void) { }
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
-static inline bool __rcu_is_watching(void) { return true; }
 static inline void rcu_momentary_dyntick_idle(void) { }
 static inline void kfree_rcu_scheduler_running(void) { }
 static inline bool rcu_gp_might_be_stalled(void) { return false; }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index d2f4064..59eb5cd 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -64,7 +64,6 @@ extern int rcu_scheduler_active __read_mostly;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-bool __rcu_is_watching(void);
 #ifndef CONFIG_PREEMPTION
 void rcu_all_qs(void);
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 9852e0d..ad794a1 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -278,7 +278,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * terminate a grace period, if and only if the timer interrupt is
 	 * not nested into another interrupt.
 	 *
-	 * Checking for __rcu_is_watching() here would prevent the nesting
+	 * Checking for rcu_is_watching() here would prevent the nesting
 	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
 	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
 	 * assume that it is the first interupt and eventually claim
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 396abe0..2323622 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1077,11 +1077,6 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
 	}
 }
 
-noinstr bool __rcu_is_watching(void)
-{
-	return !rcu_dynticks_curr_cpu_in_eqs();
-}
-
 /**
  * rcu_is_watching - see if RCU thinks that the current CPU is not idle
  *
-- 
2.9.5

