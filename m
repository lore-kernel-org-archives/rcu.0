Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE7AC433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10DA2083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897490;
	bh=Pc4xELlIewnQVLl8AuOOtULOmaWAGKvPWQaIu3f7uYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kmuyjxZbIpwT+le27dwLhKfNaeJU+pIyvnJjzYFcsA4+EjjYsRYJHXjmuKo2uMNCX
	 3+Lp8IlCbx7KMT0hjsABzJ+w2WOO/XpTQCzlUg2ANbsF8hirMughEWMJd9jBWaN8fb
	 87X5zHLsaw50WZTlxm7BZVuJUCjIrdlAzENYQKhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgHaSL1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbgHaSLW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:11:22 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 066532068E;
        Mon, 31 Aug 2020 18:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897482;
        bh=Pc4xELlIewnQVLl8AuOOtULOmaWAGKvPWQaIu3f7uYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUJBlqaqa7SF2T5Mz421IkNJgJYx2HN3pOQjN+Fj2qNZj7lR4htrCskMtprVsI/EY
         26AeOPLZoUAhpxNcD/SZTUcPvu+KGYDA1dvrzPOIgigC1BVyeFadpD2YSgiy6hNjpj
         h34V7ZOcdExG0eTXDY8i5jFb80TEAFUsb3KAwXdg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/13] rcu: Add Kconfig option for strict RCU grace periods
Date:   Mon, 31 Aug 2020 11:11:08 -0700
Message-Id: <20200831181120.1044-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181101.GA950@paulmck-ThinkPad-P72>
References: <20200831181101.GA950@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

People running automated tests have asked for a way to make RCU minimize
grace-period duration in order to increase the probability of KASAN
detecting a pointer being improperly leaked from an RCU read-side critical
section, for example, like this:

	rcu_read_lock();
	p = rcu_dereference(gp);
	do_something_with(p); // OK
	rcu_read_unlock();
	do_something_else_with(p); // BUG!!!

The rcupdate.rcu_expedited boot parameter is a start in this direction,
given that it makes calls to synchronize_rcu() instead invoke the faster
(and more wasteful) synchronize_rcu_expedited().  However, this does
nothing to shorten RCU grace periods that are instead initiated by
call_rcu(), and RCU pointer-leak bugs can involve call_rcu() just as
surely as they can synchronize_rcu().

This commit therefore adds a RCU_STRICT_GRACE_PERIOD Kconfig option
that will be used to shorten normal (non-expedited) RCU grace periods.
This commit also dumps out a message when this option is in effect.
Later commits will actually shorten grace periods.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug | 15 +++++++++++++++
 kernel/rcu/tree_plugin.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 3cf6132..cab5a4b 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -114,4 +114,19 @@ config RCU_EQS_DEBUG
 	  Say N here if you need ultimate kernel/user switch latencies
 	  Say Y if you are unsure
 
+config RCU_STRICT_GRACE_PERIOD
+	bool "Provide debug RCU implementation with short grace periods"
+	depends on DEBUG_KERNEL && RCU_EXPERT
+	default n
+	select PREEMPT_COUNT if PREEMPT=n
+	help
+	  Select this option to build an RCU variant that is strict about
+	  grace periods, making them as short as it can.  This limits
+	  scalability, destroys real-time response, degrades battery
+	  lifetime and kills performance.  Don't try this on large
+	  machines, as in systems with more than about 10 or 20 CPUs.
+	  But in conjunction with tools like KASAN, it can be helpful
+	  when looking for certain types of RCU usage bugs, for example,
+	  too-short RCU read-side critical sections.
+
 endmenu # "RCU Debugging"
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 982fc5b..44cf77d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -36,6 +36,8 @@ static void __init rcu_bootup_announce_oddness(void)
 		pr_info("\tRCU dyntick-idle grace-period acceleration is enabled.\n");
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
 		pr_info("\tRCU lockdep checking is enabled.\n");
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		pr_info("\tRCU strict (and thus non-scalable) grace periods enabled.\n");
 	if (RCU_NUM_LVLS >= 4)
 		pr_info("\tFour(or more)-level hierarchy is enabled.\n");
 	if (RCU_FANOUT_LEAF != 16)
-- 
2.9.5

