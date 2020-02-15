Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98633C35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C85F2082F
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581725934;
	bh=zD8j4Kz3cR7iNFCcKdyu8XC+oQJpI7FqPVapUF0WhBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B/M1AcbGKvaICyaaLhY6frN2i10XRaA60dpHx1efVne21lJ6rNKYz5P3gq2BZAwWj
	 vTO7BderU4TTB3yL6habvCH45h6qRVRWIpmy3ZLjwroJex0Wli3fr/OQPJYTuhMjCi
	 KEs4mTa1MG+2aE0dfW+0Z52FHdRMoaCchgQkNEIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBOASy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:18:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgBOASx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:18:53 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2D5B207FF;
        Sat, 15 Feb 2020 00:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581725933;
        bh=zD8j4Kz3cR7iNFCcKdyu8XC+oQJpI7FqPVapUF0WhBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvXIuYoDEMP+FaOQQ+5tpxp/gSJdDytHFFCWpZLeTEXcbGcemwnbX99KCqJXgc8ML
         SqviyyFyoX/vh1A8CpGETQN2v7/PzIZyz5YbGpGL88Hs21EPP8HL1XgKi9PAC48ttw
         XI6g2Q2FcW20f4LyT89wkqIIkd8RyUeB7nQUpx+I=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/5] rcu: Clear ->core_needs_qs at GP end or self-reported QS
Date:   Fri, 14 Feb 2020 16:18:41 -0800
Message-Id: <20200215001845.15432-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215001816.GA15284@paulmck-ThinkPad-P72>
References: <20200215001816.GA15284@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_data structure's ->core_needs_qs field does not necessarily get
cleared in a timely fashion after the corresponding CPUs' quiescent state
has been reported.  From a functional viewpoint, no harm done, but this
can result in excessive invocation of RCU core processing, as witnessed
by the kernel test robot, which saw greatly increased softirq overhead.

This commit therefore restores the rcu_report_qs_rdp() function's
clearing of this field, but only when running on the corresponding CPU.
Cases where some other CPU reports the quiescent state (for example, on
behalf of an idle CPU) are handled by setting this field appropriately
within the __note_gp_changes() function's end-of-grace-period checks.
This handling is carried out regardless of whether the end of a grace
period actually happened, thus handling the case where a CPU goes non-idle
after a quiescent state is reported on its behalf, but before the grace
period ends.  This fix also avoids cross-CPU updates to ->core_needs_qs,

While in the area, this commit changes the __note_gp_changes() need_gp
variable's name to need_qs because it is a quiescent state that is needed
from the CPU in question.

Fixes: ed93dfc6bc00 ("rcu: Confine ->core_needs_qs accesses to the corresponding CPU")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d91c915..31d01f8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1386,7 +1386,7 @@ static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
 static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	bool ret = false;
-	bool need_gp;
+	bool need_qs;
 	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
 			       rcu_segcblist_is_offloaded(&rdp->cblist);
 
@@ -1400,10 +1400,13 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	    unlikely(READ_ONCE(rdp->gpwrap))) {
 		if (!offloaded)
 			ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
+		rdp->core_needs_qs = false;
 		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuend"));
 	} else {
 		if (!offloaded)
 			ret = rcu_accelerate_cbs(rnp, rdp); /* Recent CBs. */
+		if (rdp->core_needs_qs)
+			rdp->core_needs_qs = !!(rnp->qsmask & rdp->grpmask);
 	}
 
 	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
@@ -1415,9 +1418,9 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 		 * go looking for one.
 		 */
 		trace_rcu_grace_period(rcu_state.name, rnp->gp_seq, TPS("cpustart"));
-		need_gp = !!(rnp->qsmask & rdp->grpmask);
-		rdp->cpu_no_qs.b.norm = need_gp;
-		rdp->core_needs_qs = need_gp;
+		need_qs = !!(rnp->qsmask & rdp->grpmask);
+		rdp->cpu_no_qs.b.norm = need_qs;
+		rdp->core_needs_qs = need_qs;
 		zero_cpu_stall_ticks(rdp);
 	}
 	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
@@ -1987,6 +1990,8 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		return;
 	}
 	mask = rdp->grpmask;
+	if (rdp->cpu == smp_processor_id())
+		rdp->core_needs_qs = false;
 	if ((rnp->qsmask & mask) == 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	} else {
-- 
2.9.5

