Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45801C35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8C3217F4
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724645;
	bh=nZvacCHrP3x9jXc1xmLGNfnhtdirujNkmaBc1LB6elU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bOh1ie84HMxsDHSuo1EDq/HLycqoPzyNSPIos8gp0fr+nXpz35jsfH7fzTmuLoT8V
	 l6Zb2LnMGuoR3u8pdYa2/yxIbGCivpwojaGaQJGCHRwi9NMh5SnzkZX/seRMgCWDuq
	 GH83YnH+3AXYlN4RqsximRBtsFz4d4Sw3no0QIAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgBNX5Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:57:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgBNX5Y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:24 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58CD82467B;
        Fri, 14 Feb 2020 23:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724643;
        bh=nZvacCHrP3x9jXc1xmLGNfnhtdirujNkmaBc1LB6elU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVIoemD2tq0SSnRnE5ckSMYQQDFIfz4X+sdti/mg8pR5gnnfhUYalw19Rmw/NlZmy
         jHRj7RD3FSjGq+ctzgXPl5if3YuNqYLmRI+AIapiQayH8NjKWJQL3AqaBxJDsNsZ0m
         xAr9M+bReOq75Lc29uvAu9zkY12htZgdHPfaoi/A=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 20/30] rcu: Fix rcu_barrier_callback() race condition
Date:   Fri, 14 Feb 2020 15:55:57 -0800
Message-Id: <20200214235607.13749-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_barrier_callback() function does an atomic_dec_and_test(), and
if it is the last CPU to check in, does the required wakeup.  Either way,
it does an event trace.  Unfortunately, this is susceptible to the
following sequence of events:

o	CPU 0 invokes rcu_barrier_callback(), but atomic_dec_and_test()
	says that it is not last.  But at this point, CPU 0 is delayed,
	perhaps due to an NMI, SMI, or vCPU preemption.

o	CPU 1 invokes rcu_barrier_callback(), and atomic_dec_and_test()
	says that it is last.  So CPU 1 traces completion and does
	the needed wakeup.

o	The awakened rcu_barrier() function does cleanup and releases
	rcu_state.barrier_mutex.

o	Another CPU now acquires rcu_state.barrier_mutex and starts
	another round of rcu_barrier() processing, including updating
	rcu_state.barrier_sequence.

o	CPU 0 gets its act back together and does its tracing.  Except
	that rcu_state.barrier_sequence has already been updated, so
	its tracing is incorrect and probably quite confusing.
	(Wait!  Why did this CPU check in twice for one rcu_barrier()
	invocation???)

This commit therefore causes rcu_barrier_callback() to take a
snapshot of the value of rcu_state.barrier_sequence before invoking
atomic_dec_and_test(), thus guaranteeing that the event-trace output
is sensible, even if the timing of the event-trace output might still
be confusing.  (Wait!  Why did the old rcu_barrier() complete before
all of its CPUs checked in???)  But being that this is RCU, only so much
confusion can reasonably be eliminated.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely and due to the mild consequences of the
failure, namely a confusing event trace.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index be59a5d..62383ce 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3077,15 +3077,22 @@ static void rcu_barrier_trace(const char *s, int cpu, unsigned long done)
 /*
  * RCU callback function for rcu_barrier().  If we are last, wake
  * up the task executing rcu_barrier().
+ *
+ * Note that the value of rcu_state.barrier_sequence must be captured
+ * before the atomic_dec_and_test().  Otherwise, if this CPU is not last,
+ * other CPUs might count the value down to zero before this CPU gets
+ * around to invoking rcu_barrier_trace(), which might result in bogus
+ * data from the next instance of rcu_barrier().
  */
 static void rcu_barrier_callback(struct rcu_head *rhp)
 {
+	unsigned long __maybe_unused s = rcu_state.barrier_sequence;
+
 	if (atomic_dec_and_test(&rcu_state.barrier_cpu_count)) {
-		rcu_barrier_trace(TPS("LastCB"), -1,
-				  rcu_state.barrier_sequence);
+		rcu_barrier_trace(TPS("LastCB"), -1, s);
 		complete(&rcu_state.barrier_completion);
 	} else {
-		rcu_barrier_trace(TPS("CB"), -1, rcu_state.barrier_sequence);
+		rcu_barrier_trace(TPS("CB"), -1, s);
 	}
 }
 
-- 
2.9.5

