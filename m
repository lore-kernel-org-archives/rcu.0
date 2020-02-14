Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C89BC35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D98206B6
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724678;
	bh=EWaEpSMKaY0FCAqVa0hpnXDzFDnfMqFMXfz1EdwE0R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wm8IG2HBdt4IHIjX2tIDEbutg52J9529kVhsHaGZ6EeiaRzcCaILNYD3iXRH9egzp
	 KcIwBfK2CKjggDwXBcptTcGuIalaH0HvR5iH4YxA+HAzrW3gf27r/2dCTO6lhEjfsE
	 NIVnTa9R9A2LC7C25qyVCY2veuQ0gEYGSrHcwH2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgBNX56 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:57:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbgBNX55 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:57 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 777ED24676;
        Fri, 14 Feb 2020 23:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724676;
        bh=EWaEpSMKaY0FCAqVa0hpnXDzFDnfMqFMXfz1EdwE0R4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cPI8fmD+UmAheY24TdvCflfiJfXIxVjtiUyOUvoE5pO+TuInk4DA/boJOejILpv/o
         alOfzFlEBZmhD2J/BBr9yDq2EJKHtMug13ew8dM9A3eiMXRuhE8uYZAfH8YlHXmenB
         OUPcReaE8hPpAPWUp9sYfvmIDz0ITrm8uZPzbDrQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 29/30] rcu: Mark rcu_state.gp_seq to detect concurrent writes
Date:   Fri, 14 Feb 2020 15:56:06 -0800
Message-Id: <20200214235607.13749-29-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_state structure's gp_seq field is only to be modified by the RCU
grace-period kthread, which is single-threaded.  This commit therefore
enlists KCSAN's help in enforcing this restriction.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3a60a160..d15041f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1209,7 +1209,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
-	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rcu_state.gp_seq), TPS("newreq"));
+	trace_rcu_grace_period(rcu_state.name, data_race(rcu_state.gp_seq), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
@@ -1494,6 +1494,7 @@ static bool rcu_gp_init(void)
 	record_gp_stall_check_time();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rcu_state.gp_seq);
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	raw_spin_unlock_irq_rcu_node(rnp);
 
@@ -1656,8 +1657,7 @@ static void rcu_gp_fqs_loop(void)
 			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
 				   jiffies + (j ? 3 * j : 2));
 		}
-		trace_rcu_grace_period(rcu_state.name,
-				       READ_ONCE(rcu_state.gp_seq),
+		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 				       TPS("fqswait"));
 		rcu_state.gp_state = RCU_GP_WAIT_FQS;
 		ret = swait_event_idle_timeout_exclusive(
@@ -1671,13 +1671,11 @@ static void rcu_gp_fqs_loop(void)
 		/* If time for quiescent-state forcing, do it. */
 		if (ULONG_CMP_GE(jiffies, rcu_state.jiffies_force_qs) ||
 		    (gf & RCU_GP_FLAG_FQS)) {
-			trace_rcu_grace_period(rcu_state.name,
-					       READ_ONCE(rcu_state.gp_seq),
+			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqsstart"));
 			rcu_gp_fqs(first_gp_fqs);
 			first_gp_fqs = false;
-			trace_rcu_grace_period(rcu_state.name,
-					       READ_ONCE(rcu_state.gp_seq),
+			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqsend"));
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
@@ -1688,8 +1686,7 @@ static void rcu_gp_fqs_loop(void)
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
 			WARN_ON(signal_pending(current));
-			trace_rcu_grace_period(rcu_state.name,
-					       READ_ONCE(rcu_state.gp_seq),
+			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqswaitsig"));
 			ret = 1; /* Keep old FQS timing. */
 			j = jiffies;
@@ -1766,6 +1763,7 @@ static void rcu_gp_cleanup(void)
 	/* Declare grace period done, trace first to use old GP number. */
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
 	rcu_seq_end(&rcu_state.gp_seq);
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	rcu_state.gp_state = RCU_GP_IDLE;
 	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(&rcu_data);
@@ -1781,7 +1779,7 @@ static void rcu_gp_cleanup(void)
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
 		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
 		trace_rcu_grace_period(rcu_state.name,
-				       READ_ONCE(rcu_state.gp_seq),
+				       rcu_state.gp_seq,
 				       TPS("newreq"));
 	} else {
 		WRITE_ONCE(rcu_state.gp_flags,
@@ -1800,8 +1798,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
 
 		/* Handle grace-period start. */
 		for (;;) {
-			trace_rcu_grace_period(rcu_state.name,
-					       READ_ONCE(rcu_state.gp_seq),
+			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("reqwait"));
 			rcu_state.gp_state = RCU_GP_WAIT_GPS;
 			swait_event_idle_exclusive(rcu_state.gp_wq,
@@ -1814,8 +1811,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
 			WARN_ON(signal_pending(current));
-			trace_rcu_grace_period(rcu_state.name,
-					       READ_ONCE(rcu_state.gp_seq),
+			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("reqwaitsig"));
 		}
 
-- 
2.9.5

