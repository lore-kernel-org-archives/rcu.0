Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ECBC2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2ACD21707
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586970730;
	bh=oy40i2pM5Z+ESCD1y3h5EWmr1S7cNVaJphUwIC2ZofA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OV8A5THhdxtGWgof0G/yDg+HEvYbh/X2LyMjtk2FAbI9PsWg5ebMoygSp8xLhfhRw
	 QLXWc1K30atiFCb17joO4xK0haE1o2oRdyrK64pINrEyylbZMouWxOTZSx7No7Msr+
	 paiTSseRFU3zYHgnhm9559hkeP+UDM9WbRP7G5Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgDORME (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410716AbgDORK7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:10:59 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85F2321D7A;
        Wed, 15 Apr 2020 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970658;
        bh=oy40i2pM5Z+ESCD1y3h5EWmr1S7cNVaJphUwIC2ZofA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDUzmJ9rgbLHsW8X2VQMQ2m/NHDYZoVq83h7vY7e7ajOMtI6w4MWl6WJr0HPl5okd
         OIYwFiyNXfzI3Nn6HwNr/A7nXbTD1NvDDNlA/Tj8BR3NA++FvAaDv1APMmTSRpbbtc
         27IUsdk4iSGz4zck+6pk1ZBtKwe9HSjDaH0vUxdw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/19] rcu: Use data_race() for RCU CPU stall-warning prints
Date:   Wed, 15 Apr 2020 10:10:43 -0700
Message-Id: <20200415171054.9013-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Although the accesses used to determine whether or not a stall should
be printed are an integral part of the concurrency algorithm governing
use of the corresponding variables, the values that are simply printed
are ancillary.  As such, it is best to use data_race() for these accesses
in order to provide the greatest latitude in the use of KCSAN for the
other accesses that are an integral part of the algorithm.  This commit
therefore changes the relevant uses of READ_ONCE() to data_race().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 119ed6a..e7da111 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -360,7 +360,7 @@ static void rcu_check_gp_kthread_starvation(void)
 		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
 		       rcu_state.name, j,
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
-		       READ_ONCE(rcu_state.gp_flags),
+		       data_race(rcu_state.gp_flags),
 		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
 		       gpk ? gpk->state : ~0, gpk ? task_cpu(gpk) : -1);
 		if (gpk) {
@@ -421,10 +421,10 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 			pr_err("INFO: Stall ended before state dump start\n");
 		} else {
 			j = jiffies;
-			gpa = READ_ONCE(rcu_state.gp_activity);
+			gpa = data_race(rcu_state.gp_activity);
 			pr_err("All QSes seen, last %s kthread activity %ld (%ld-%ld), jiffies_till_next_fqs=%ld, root ->qsmask %#lx\n",
 			       rcu_state.name, j - gpa, j, gpa,
-			       READ_ONCE(jiffies_till_next_fqs),
+			       data_race(jiffies_till_next_fqs),
 			       rcu_get_root()->qsmask);
 			/* In this case, the current CPU might be at fault. */
 			sched_show_task(current);
@@ -581,23 +581,23 @@ void show_rcu_gp_kthreads(void)
 	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
 
 	j = jiffies;
-	ja = j - READ_ONCE(rcu_state.gp_activity);
-	jr = j - READ_ONCE(rcu_state.gp_req_activity);
-	jw = j - READ_ONCE(rcu_state.gp_wake_time);
+	ja = j - data_race(rcu_state.gp_activity);
+	jr = j - data_race(rcu_state.gp_req_activity);
+	jw = j - data_race(rcu_state.gp_wake_time);
 	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
 		rcu_state.gp_state, t ? t->state : 0x1ffffL,
-		ja, jr, jw, (long)READ_ONCE(rcu_state.gp_wake_seq),
-		(long)READ_ONCE(rcu_state.gp_seq),
-		(long)READ_ONCE(rcu_get_root()->gp_seq_needed),
-		READ_ONCE(rcu_state.gp_flags));
+		ja, jr, jw, (long)data_race(rcu_state.gp_wake_seq),
+		(long)data_race(rcu_state.gp_seq),
+		(long)data_race(rcu_get_root()->gp_seq_needed),
+		data_race(rcu_state.gp_flags));
 	rcu_for_each_node_breadth_first(rnp) {
 		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
 				 READ_ONCE(rnp->gp_seq_needed)))
 			continue;
 		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld\n",
-			rnp->grplo, rnp->grphi, (long)READ_ONCE(rnp->gp_seq),
-			(long)READ_ONCE(rnp->gp_seq_needed));
+			rnp->grplo, rnp->grphi, (long)data_race(rnp->gp_seq),
+			(long)data_race(rnp->gp_seq_needed));
 		if (!rcu_is_leaf_node(rnp))
 			continue;
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
@@ -607,7 +607,7 @@ void show_rcu_gp_kthreads(void)
 					 READ_ONCE(rdp->gp_seq_needed)))
 				continue;
 			pr_info("\tcpu %d ->gp_seq_needed %ld\n",
-				cpu, (long)READ_ONCE(rdp->gp_seq_needed));
+				cpu, (long)data_race(rdp->gp_seq_needed));
 		}
 	}
 	for_each_possible_cpu(cpu) {
-- 
2.9.5

