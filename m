Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F314FC433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90CE2083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598896975;
	bh=Vpctbcz91EPQKPK/qQzLu3zabu/JJYgSbl7lkU+PAQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c0JZtP/dOFVKBLEufb4n+5BzYtv+unpa6sfgZj4xBfJDz8AQ6PjqTlk0zqa7Cppqf
	 bI5wvPOdPs1N054Fa8Z/8Ga+lkUVQL9PDV9SGS95WcavBZYO8hKNTO/TkvAKa2lvp/
	 FEPY2HHFWYAvWzyNQU9/+oxEXeHMRxLOc/IcrkQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgHaSBg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbgHaSB1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:27 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F14DB2176B;
        Mon, 31 Aug 2020 18:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896887;
        bh=Vpctbcz91EPQKPK/qQzLu3zabu/JJYgSbl7lkU+PAQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKa2exXWTCXoVOhpueE/EFMwdsuqmcF/yxZmvlLvlUuFVgzgXKOQckgYMLle2IlSF
         tRy3xenqLhqIizipDix4pizP1ywWcJtyoV6R8vnzn3Gu3PAoZPGqoQJIQ0a6g1uFB7
         BMlqQseZ0Rx8ANg1OeJJ2Hk882UaM+6rZefvszGo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 21/24] rcu: Make FQS more aggressive in complaining about offline CPUs
Date:   Mon, 31 Aug 2020 11:01:13 -0700
Message-Id: <20200831180116.32690-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The RCU grace-period kthread's force-quiescent state (FQS) loop should
never see an offline CPU that has not yet reported a quiescent state.
After all, the offline CPU should have reported a quiescent state
during the CPU-offline process, or, failing that, by rcu_gp_init()
if it ran concurrently with either the CPU going offline or the last
task on a leaf rcu_node structure exiting its RCU read-side critical
section while all CPUs corresponding to that structure are offline.
The FQS loop should therefore complain if it does see an offline CPU
that has not yet reported a quiescent state.

And it does, but only once the grace period has been in force for a
full second.  This commit therefore makes this warning more aggressive,
so that it will trigger as soon as the condition makes its appearance.

Light testing with TREE03 and hotplug shows no warnings.  This commit
also converts the warning to WARN_ON_ONCE() in order to stave off possible
log spam.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2c7afe4..396abe0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1214,13 +1214,28 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		return 1;
 	}
 
-	/* If waiting too long on an offline CPU, complain. */
-	if (!(rdp->grpmask & rcu_rnp_online_cpus(rnp)) &&
-	    time_after(jiffies, rcu_state.gp_start + HZ)) {
+	/*
+	 * Complain if a CPU that is considered to be offline from RCU's
+	 * perspective has not yet reported a quiescent state.  After all,
+	 * the offline CPU should have reported a quiescent state during
+	 * the CPU-offline process, or, failing that, by rcu_gp_init()
+	 * if it ran concurrently with either the CPU going offline or the
+	 * last task on a leaf rcu_node structure exiting its RCU read-side
+	 * critical section while all CPUs corresponding to that structure
+	 * are offline.  This added warning detects bugs in any of these
+	 * code paths.
+	 *
+	 * The rcu_node structure's ->lock is held here, which excludes
+	 * the relevant portions the CPU-hotplug code, the grace-period
+	 * initialization code, and the rcu_read_unlock() code paths.
+	 *
+	 * For more detail, please refer to the "Hotplug CPU" section
+	 * of RCU's Requirements documentation.
+	 */
+	if (WARN_ON_ONCE(!(rdp->grpmask & rcu_rnp_online_cpus(rnp)))) {
 		bool onl;
 		struct rcu_node *rnp1;
 
-		WARN_ON(1);  /* Offline CPUs are supposed to report QS! */
 		pr_info("%s: grp: %d-%d level: %d ->gp_seq %ld ->completedqs %ld\n",
 			__func__, rnp->grplo, rnp->grphi, rnp->level,
 			(long)rnp->gp_seq, (long)rnp->completedqs);
-- 
2.9.5

