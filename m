Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAA3C433E2
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467162083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897526;
	bh=le7fEqI0tORFtFuazA+HPMB7FLkwN72j/hJq3YfB/ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sXdylMjt6/1aguTdGxIvqWOVh7DBpqCZepfn59etVz4ggKDoy80qAxFlm5Mr0+r8W
	 /saiKhiDAK6fliCW25pR1ZXhU9NXpjyNSUZOA2FwDN1KRgV41BwKy5SkAem62uIKoc
	 dBbWrBbeo/Ihct0SBlKN41oPaH/GK0NpXh+8A2rA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgHaSME (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbgHaSLX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:11:23 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C542620EDD;
        Mon, 31 Aug 2020 18:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897482;
        bh=le7fEqI0tORFtFuazA+HPMB7FLkwN72j/hJq3YfB/ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w/46SgQ8YiEP6H/qYfh/Fh7W9LFRP4ybasZGLlzC+azAU9piDFarLpS3cXP/d4lf8
         9oHBLPF7Z/npgPOi51SS+CGv81V8yKpVP4UvR6qkshP+smQGM9DWstq1m7CzeklU9r
         xhMb3KbJhD8ZOJ5RtBYKJ3Rxdn1S6J3tYIApIrfM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/13] rcu: Always set .need_qs from __rcu_read_lock() for strict GPs
Date:   Mon, 31 Aug 2020 11:11:12 -0700
Message-Id: <20200831181120.1044-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181101.GA950@paulmck-ThinkPad-P72>
References: <20200831181101.GA950@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The ->rcu_read_unlock_special.b.need_qs field in the task_struct
structure indicates that the RCU core needs a quiscent state from the
corresponding task.  The __rcu_read_unlock() function checks this (via
an eventual call to rcu_preempt_deferred_qs_irqrestore()), and if set
reports a quiscent state immediately upon exit from the outermost RCU
read-side critical section.

Currently, this flag is only set when the scheduling-clock interrupt
decides that the current RCU grace period is too old, as in about
one full second too old.  But if the kernel has been built with
CONFIG_RCU_STRICT_GRACE_PERIOD=y, we clearly do not want to wait that
long.  This commit therefore sets the .need_qs field immediately at the
start of the RCU read-side critical section from within __rcu_read_lock()
in order to unconditionally enlist help from __rcu_read_unlock().

But note the additional check for rcu_state.gp_kthread, which prevents
attempts to awaken RCU's grace-period kthread during early boot before
there is a scheduler.  Leaving off this check results in early boot hangs.
So early that there is no console output.  Thus, this additional check
fails until such time as RCU's grace-period kthread has been created,
avoiding these empty-console hangs.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 44cf77d..668bbd2 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -376,6 +376,8 @@ void __rcu_read_lock(void)
 	rcu_preempt_read_enter();
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 		WARN_ON_ONCE(rcu_preempt_depth() > RCU_NEST_PMAX);
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) && rcu_state.gp_kthread)
+		WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
 	barrier();  /* critical section after entry code. */
 }
 EXPORT_SYMBOL_GPL(__rcu_read_lock);
-- 
2.9.5

