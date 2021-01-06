Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687F8C4332E
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267BE22CE3
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbhAFEu5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:50:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbhAFEu5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A21F623106;
        Wed,  6 Jan 2021 04:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908540;
        bh=+nyg0HbAXghhDDYanpwv9o5k98g9Mx695vVR3eZM25E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWS/ryTHEEaDMpSm8oqcfDLPC+Jia1626frF7I7n+h97ymdg57IaWQ53Nw5XNKH3C
         eEubxaZqRIYmvlM1XuW88edP0/X1FhVjz2Xx0YpGl/u9D8Ye9k8JJLDiZXNzifLdA9
         OFC+I77lhUYbIpav4bsUIbhLDl5mBpxu+bStUHGwRC38JbcFSwNxfuFRuqvh/TWpz5
         3VdK5G60Zs8eJeWXjexEFc87vFhi3ElGGAQuLUsJIumQ0LeYtFjPKGbQZcUNrpwtzA
         rz6ojYp/KglTJVcxrOFsEj76ssfzmnM4ecIIQD1cFjG0CPoyB5cojM33s+2z+iiRPH
         +8DIp8B9oQu0g==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 21/21] rcu: Do any deferred nocb wakeups at CPU offline time
Date:   Tue,  5 Jan 2021 20:48:53 -0800
Message-Id: <20210106044853.20812-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Because the need to wake a nocb GP kthread ("rcuog") is sometimes
detected when wakeups cannot be done, these wakeups can be deferred.
The wakeups are then carried out by calls to do_nocb_deferred_wakeup()
at various safe points in the code, including RCU's idle hooks.  However,
when a CPU goes offline, it invokes arch_cpu_idle_dead() without invoking
any of RCU's idle hooks.

This commit therefore adds a call to do_nocb_deferred_wakeup() in
rcu_report_dead() in order to handle any deferred wakeups that have been
requested by the outgoing CPU.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 03810a5..e6dee71 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4178,6 +4178,9 @@ void rcu_report_dead(unsigned int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
+	// Do any dangling deferred wakeups.
+	do_nocb_deferred_wakeup(rdp);
+
 	/* QS for any half-done expedited grace period. */
 	preempt_disable();
 	rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
-- 
2.9.5

