Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E3FC433E2
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465C22145D
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598896890;
	bh=/yTUs0FVay3sAqB0eTJiMOJcG5gY0G1ZMAr1sjY9mug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lDp2Gmyzo6hL3SlzUUZmbq11H5bmC7WPvv7qffOPFRwfUTK8FBHG34cwIWQ/MyHkJ
	 5RbsQGoExsC1L7kR2BkfxD1gae+DGCy7ZC+DLSq6wtCh66n7v8z3W8hkUmotfmF1O9
	 RbIahbfUeC5iiUxNK9O50oF934HdwyTm1zztr+tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgHaSB1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbgHaSBW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:22 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B87B421534;
        Mon, 31 Aug 2020 18:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896882;
        bh=/yTUs0FVay3sAqB0eTJiMOJcG5gY0G1ZMAr1sjY9mug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnwei98lujhVttzUCeKUU0xGi31zidZO/Lm2XPrwytbawfMewQLxQfdY6OMCInimR
         XFXFquMbwxTfPS1jIEqR745GejCR+25BcsaTtSdpuUA2sTX2JIvzDCELIqaSQD2cN4
         eb3rGjzN8wAItKpFxpOqNZiJ+LpDNbfvtfJSYpoY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/24] rcu/tree: Force quiescent state on callback overload
Date:   Mon, 31 Aug 2020 11:01:00 -0700
Message-Id: <20200831180116.32690-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

On callback overload, it is necessary to quickly detect idle CPUs,
and rcu_gp_fqs_check_wake() checks for this condition.  Unfortunately,
the code following the call to this function does not repeat this check,
which means that in reality no actual quiescent-state forcing, instead
only a couple of quick and pointless wakeups at the beginning of the
grace period.

This commit therefore adds a check for the RCU_GP_FLAG_OVLD flag in
the post-wakeup "if" statement in rcu_gp_fqs_loop().

Fixes: 1fca4d12f4637 ("rcu: Expedite first two FQS scans under callback-overload conditions")
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8969120..4770d77 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1884,7 +1884,7 @@ static void rcu_gp_fqs_loop(void)
 			break;
 		/* If time for quiescent-state forcing, do it. */
 		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
-		    (gf & RCU_GP_FLAG_FQS)) {
+		    (gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
 			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqsstart"));
 			rcu_gp_fqs(first_gp_fqs);
-- 
2.9.5

