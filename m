Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1920C43461
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6AE20EDD
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897096;
	bh=IDjZSku/tK67QHlgrC59Pps37RT68a2m1he5aAMny40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qAnmQIb2c2yBIIFCZVliOZDggCmLZWW5GYp4v/ZQsixXAgXkwDs1Arzq78ozY+5z4
	 SpuI58bpi0Mx2sKezs3hUMc0PKH1OEImOKS0a2fs8UV0mCj8sJ1/AHlyH54XOVueTs
	 GSCw/ww0vfheThj+sjRSVozl0UDp71TW1gpagd8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgHaSEf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729369AbgHaSEM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:12 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3C682176B;
        Mon, 31 Aug 2020 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897052;
        bh=IDjZSku/tK67QHlgrC59Pps37RT68a2m1he5aAMny40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PvL3RzoVPQfsSrGzSkMdm/vUqq6slxQbChmqnSiEXZXXLF4bO4+y7D1C0DZIOGNN0
         jogahDGTCHL3gdw7K+K3gPpN8XLB/1GPHHmwIQbGafrLrFC5GST8mtD3OsVFN8NMgS
         FTVWchSbyasILKeo5c+v7qf4IRn+h/7rZSKUr2Eg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/14] rcutorture: Allow pointer leaks to test diagnostic code
Date:   Mon, 31 Aug 2020 11:04:05 -0700
Message-Id: <20200831180406.494-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180348.GA416@paulmck-ThinkPad-P72>
References: <20200831180348.GA416@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds an rcutorture.leakpointer module parameter that
intentionally leaks an RCU-protected pointer out of the RCU read-side
critical section and checks to see if the corresponding grace period
has elapsed, emitting a WARN_ON_ONCE() if so.  This module parameter can
be used to test facilities like CONFIG_RCU_STRICT_GRACE_PERIOD that end
grace periods quickly.

While in the area, also document rcutorture.irqreader, which was
previously left out.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
 kernel/rcu/rcutorture.c                         |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdc1f33..6d984f1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4269,6 +4269,18 @@
 			are zero, rcutorture acts as if is interpreted
 			they are all non-zero.
 
+	rcutorture.irqreader= [KNL]
+			Run RCU readers from irq handlers, or, more
+			accurately, from a timer handler.  Not all RCU
+			flavors take kindly to this sort of thing.
+
+	rcutorture.leakpointer= [KNL]
+			Leak an RCU-protected pointer out of the reader.
+			This can of course result in splats, and is
+			intended to test the ability of things like
+			CONFIG_RCU_STRICT_GRACE_PERIOD=y to detect
+			such leaks.
+
 	rcutorture.n_barrier_cbs= [KNL]
 			Set callbacks/threads for rcu_barrier() testing.
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 983f82f..916ea4f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -87,6 +87,7 @@ torture_param(bool, gp_normal, false,
 	     "Use normal (non-expedited) GP wait primitives");
 torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
 torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
+torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
 torture_param(int, n_barrier_cbs, 0,
 	     "# of callbacks/kthreads for barrier testing");
 torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
@@ -1401,6 +1402,9 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	preempt_enable();
 	rcutorture_one_extend(&readstate, 0, trsp, rtrsp);
 	WARN_ON_ONCE(readstate & RCUTORTURE_RDR_MASK);
+	// This next splat is expected behavior if leakpointer, especially
+	// for CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels.
+	WARN_ON_ONCE(leakpointer && READ_ONCE(p->rtort_pipe_count) > 1);
 
 	/* If error or close call, record the sequence of reader protections. */
 	if ((pipe_count > 1 || completed > 1) && !xchg(&err_segs_recorded, 1)) {
-- 
2.9.5

