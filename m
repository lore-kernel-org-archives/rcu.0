Return-Path: <SRS0=nsBp=BW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039EEC433E0
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 22:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60B820885
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 22:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597273057;
	bh=XzBQoVrOnHgaqrHtYsCX/fntFyQ4dilXOfXZS7my/8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UC55bkmP5RE8+BAgE3LbcqIkJDHbCSIwb+1dY9SDpQnz3qGeH86Z1+LOLrGkW+9am
	 ozADvm1b44LwAy0W0TpJazoNpNFC/fw/6lZf3nhrIbKB8xPo/yaiChR3qf3s4qBrFs
	 H193ivcC9yKFk9APvKM3cR6ZuacVKh0b51PA5UhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgHLW5h (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgHLW5h (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Aug 2020 18:57:37 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78E122177B;
        Wed, 12 Aug 2020 22:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597273056;
        bh=XzBQoVrOnHgaqrHtYsCX/fntFyQ4dilXOfXZS7my/8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLhBYCnJDgnkSfhV4S6eN+f2ftxsFj+VMCGXdhMZNRDf2Z7MNOtMBeQUYeWrMt3OH
         7idvf6JN36kagVwQu/aK/4RMAJ4tgjJooHQV0X/+H6zUUAnB2L8v7aZ3PyYhHu867E
         yWCUTQUkR11afs5yTa3zeH17Tp4Dn9loCvCSYwww=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        elver@google.com, dvyukov@google.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/12] rcu: Provide optional RCU-reader exit delay for strict GPs
Date:   Wed, 12 Aug 2020 15:57:30 -0700
Message-Id: <20200812225732.20068-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200812225632.GA19759@paulmck-ThinkPad-P72>
References: <20200812225632.GA19759@paulmck-ThinkPad-P72>
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
index 60e2c6e..c532c70 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4128,6 +4128,15 @@
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
index 1761ff4..25c9ee4 100644
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

