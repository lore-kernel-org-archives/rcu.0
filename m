Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE8BC5517A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E2320715
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617799;
	bh=J0pCgm8yDuVI9WBlF1NLDFS23KWldiId0CqNoFnLIco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PZczWzXhITdv0WeNZ91EgMYQB7XDxaM91S6ent30o6z6RkhDbzzpIeEvGO2bzIy/l
	 X/xeA6fisyYfLq7hk+egqn+BPxX7Gvkzjoc4+ArAmVyLwCZZps3JOC55iCETbBMxEk
	 +V1m/+RH/75ckdxO3hUNe35+FxR+OlXrtyClv8/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbgKEXJ7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:09:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732619AbgKEXJ1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC60420719;
        Thu,  5 Nov 2020 23:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617767;
        bh=J0pCgm8yDuVI9WBlF1NLDFS23KWldiId0CqNoFnLIco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGBQ8hS/S3HtMT7pqneok8jrybcBIDwjM54pTtnUkmTx+UUiPL8hONagCVBiwKHAU
         4BYIdjVJAj0b1mqqFxtK6EGhC8eRrL44Pc4YgQizgvI4FCJgRsu1mErSZK4hzpXiTI
         tB/y73G6SKIQOhKGnBVPlvyvbaQ5SyYNhmYZg+j4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/16] rcu/tree: Add a warning if CPU being onlined did not report QS already
Date:   Thu,  5 Nov 2020 15:09:13 -0800
Message-Id: <20201105230921.19017-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Currently, rcu_cpu_starting() checks to see if the RCU core expects a
quiescent state from the incoming CPU.  However, the current interaction
between RCU quiescent-state reporting and CPU-hotplug operations should
mean that the incoming CPU never needs to report a quiescent state.
First, the outgoing CPU reports a quiescent state if needed.  Second,
the race where the CPU is leaving just as RCU is initializing a new
grace period is handled by an explicit check for this condition.  Third,
the CPU's leaf rcu_node structure's ->lock serializes these checks.

This means that if rcu_cpu_starting() ever feels the need to report
a quiescent state, then there is a bug somewhere in the CPU hotplug
code or the RCU grace-period handling code.  This commit therefore
adds a WARN_ON_ONCE() to bring that bug to everyone's attention.

Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2ff22a4c..bf1513e5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4075,7 +4075,9 @@ void rcu_cpu_starting(unsigned int cpu)
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
-	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
+
+	/* An incoming CPU should never be blocking a grace period. */
+	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
 		rcu_disable_urgency_upon_qs(rdp);
 		/* Report QS -after- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
-- 
2.9.5

