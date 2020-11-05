Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCA4C388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBBE20A8B
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617772;
	bh=+8GqqX8NxxFcawTQQI+m68mJtIGxuqgH4Tf0uCM8ISk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PYnEQHlCuMx8IR+Z9NvjYTOkOCQ5V+gptGABf/o+mGEr4CmzE8fzFQAwlEXYuh+bi
	 4b4WngaiI1HKNrXF3yTXUyA9knpLx/0g7tTifqglh8NlvO9K7WBJ0aOrPzeenMaXcU
	 NtSW+u8JbXwNOEIuT1OcGMwyWukTp/yzzewujW+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbgKEXJb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:09:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732682AbgKEXJa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:30 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 265FC2222B;
        Thu,  5 Nov 2020 23:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617769;
        bh=+8GqqX8NxxFcawTQQI+m68mJtIGxuqgH4Tf0uCM8ISk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+nBPeHu4o29QyCJJfMgukguRnQ9dVfCM1v8FTaeW0xZe4WzR+D/BTFJd93M5ywxJ
         7KiFoJD09FZWPBE81jCqkPtm+is2M0VB+rLjVZwvygJ5CoWzYRwJHB9wP52PFmy96t
         lQ59XunsQCpPHXAA08CxtewJHSagVyM1daygKuJ4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jann Horn <jannh@google.com>
Subject: [PATCH tip/core/rcu 14/16] rcu: Do not report strict GPs for outgoing CPUs
Date:   Thu,  5 Nov 2020 15:09:19 -0800
Message-Id: <20201105230921.19017-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

An outgoing CPU is marked offline in a stop-machine handler and most
of that CPU's services stop at that point, including IRQ work queues.
However, that CPU must take another pass through the scheduler and through
a number of CPU-hotplug notifiers, many of which contain RCU readers.
In the past, these readers were not a problem because the outgoing CPU
has interrupts disabled, so that rcu_read_unlock_special() would not
be invoked, and thus RCU would never attempt to queue IRQ work on the
outgoing CPU.

This changed with the advent of the CONFIG_RCU_STRICT_GRACE_PERIOD
Kconfig option, in which rcu_read_unlock_special() is invoked upon exit
from almost all RCU read-side critical sections.  Worse yet, because
interrupts are disabled, rcu_read_unlock_special() cannot immediately
report a quiescent state and will therefore attempt to defer this
reporting, for example, by queueing IRQ work.  Which fails with a splat
because the CPU is already marked as being offline.

But it turns out that there is no need to report this quiescent state
because rcu_report_dead() will do this job shortly after the outgoing
CPU makes its final dive into the idle loop.  This commit therefore
makes rcu_read_unlock_special() refrain from queuing IRQ work onto
outgoing CPUs.

Fixes: 44bad5b3cca2 ("rcu: Do full report for .need_qs for strict GPs")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jann Horn <jannh@google.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fd8a52e..7e291ce 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -628,7 +628,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    !rdp->defer_qs_iw_pending && exp) {
+			    !rdp->defer_qs_iw_pending && exp && cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
 				init_irq_work(&rdp->defer_qs_iw,
-- 
2.9.5

