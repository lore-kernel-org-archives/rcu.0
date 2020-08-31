Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8CDC2BB4D
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B642068E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897507;
	bh=ygQ6D8KC9ffu+KIsgwq1BeUWCEEDS1BVH6fpRhqdzUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UZCLNJ2PkdgAtyV9HWeEfiqO+BirEL5O66UgXikOh1eNB0M665ms5Qx/5kZhM6ylq
	 UhrVo0DTCctMzZt++0IoXiasDryGSpumJmw18Ossn0Pj0fC8qekMmDLEWG9WCIQ/SC
	 bgKska7DXi3NZ51FwBeAoBEhRb5xxULVObYPgpGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgHaSLq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbgHaSL0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:11:26 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B73C22158C;
        Mon, 31 Aug 2020 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897483;
        bh=ygQ6D8KC9ffu+KIsgwq1BeUWCEEDS1BVH6fpRhqdzUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXoz2K88hlp56Bs+rRSYCQg2imMNyixgHDGI/lgHvQ2IJBdm4Y/4j0zNae0L9NuGO
         uh8XL/6nM6daoZASzQcJzROxbqnxZZeR2wnQIiePrNofo6geg/AAF0kQqODqNv4U/C
         bZygallZZts0co+PqONu8haES2n2iTuNnF7+ys2M=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/13] rcu: Provide optional RCU-reader exit delay for strict GPs
Date:   Mon, 31 Aug 2020 11:11:17 -0700
Message-Id: <20200831181120.1044-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181101.GA950@paulmck-ThinkPad-P72>
References: <20200831181101.GA950@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The goal of this series is to increase the probability of tools like
KASAN detecting that an RCU-protected pointer was used outside of its
RCU read-side critical section.  Thus far, the approach has been to make
grace periods and callback processing happen faster.  Another approach
is to delay the pointer leaker.  This commit therefore allows a delay
to be applied to exit from RCU read-side critical sections.

This slowdown is specified by a new rcutree.rcu_unlock_delay kernel boot
parameter that specifies this delay in microseconds, defaulting to zero.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 kernel/rcu/tree_plugin.h                        | 12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdc1f33..cb90624 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4152,6 +4152,15 @@
 			This wake_up() will be accompanied by a
 			WARN_ONCE() splat and an ftrace_dump().
 
+	rcutree.rcu_unlock_delay= [KNL]
+			In CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels,
+			this specifies an rcu_read_unlock()-time delay
+			in microseconds.  This defaults to zero.
+			Larger delays increase the probability of
+			catching RCU pointer leaks, that is, buggy use
+			of RCU-protected pointers after the relevant
+			rcu_read_unlock() has completed.
+
 	rcutree.sysrq_rcu= [KNL]
 			Commandeer a sysrq key to dump out Tree RCU's
 			rcu_node tree with an eye towards determining
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dfdb902..3f3a4ff 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -430,6 +430,12 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
 	return !list_empty(&rnp->blkd_tasks);
 }
 
+// Add delay to rcu_read_unlock() for strict grace periods.
+static int rcu_unlock_delay;
+#ifdef CONFIG_RCU_STRICT_GRACE_PERIOD
+module_param(rcu_unlock_delay, int, 0444);
+#endif
+
 /*
  * Report deferred quiescent states.  The deferral time can
  * be quite short, for example, in the case of the call from
@@ -460,10 +466,12 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	}
 	t->rcu_read_unlock_special.s = 0;
 	if (special.b.need_qs) {
-		if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)) {
 			rcu_report_qs_rdp(rdp->cpu, rdp);
-		else
+			udelay(rcu_unlock_delay);
+		} else {
 			rcu_qs();
+		}
 	}
 
 	/*
-- 
2.9.5

