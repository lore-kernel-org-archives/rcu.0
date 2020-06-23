Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55A8C433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA7D2053B
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872308;
	bh=vsWLwEM2zL/AkX3vJvTMHn7tUWtKduFj/He0315EYPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LGim9jO8dk1iN30sIJ41a/OPO4i1HpbLQzKZ8uGR7fjHvOPUurkXw8dYCJVN7KGSD
	 bdRm0vwA0Q4ihYQ6syCAtVWOBiSpQlxs1Kh91Wxi3Lpzq7w+5ctrjviC0pp2DewLRh
	 yCxXzOj+3BfWo9bCGukJ1lLhiwGyh2/Ukgg2vCBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbgFWAbY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731684AbgFWAaT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1165F20720;
        Tue, 23 Jun 2020 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872219;
        bh=vsWLwEM2zL/AkX3vJvTMHn7tUWtKduFj/He0315EYPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjM56YrgSiu1KZqRWHd5TbNP7lArjBUTCRoS5WM+6RavWNUP2n1fyM729HVYYjRBz
         YDJHcupZtQ9ex3p17JVKU5t09oWpyz4pa3Uige3ZmxwjL8EoIGK6wXTT7tYmIbPYxH
         HbJhdLwhx66p9y71Xu3PxhNOV1dupPoNFZhspSjw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/30] refperf: Simplify initialization-time wakeup protocol
Date:   Mon, 22 Jun 2020 17:30:02 -0700
Message-Id: <20200623003013.26252-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit moves the reader-launch wait loop from ref_perf_init()
to main_func(), removing one layer of wakeup and allowing slightly
faster system boot.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 2d2d227..7839237 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -369,13 +369,14 @@ static int main_func(void *arg)
 		VERBOSE_PERFOUT_ERRSTRING("out of memory");
 		errexit = true;
 	}
-	atomic_inc(&n_init);
-
-	// Wait for all threads to start.
-	wait_event(main_wq, atomic_read(&n_init) == (nreaders + 1));
 	if (holdoff)
 		schedule_timeout_interruptible(holdoff * HZ);
 
+	// Wait for all threads to start.
+	atomic_inc(&n_init);
+	while (atomic_read(&n_init) < nreaders + 1)
+		schedule_timeout_uninterruptible(1);
+
 	// Start exp readers up per experiment
 	for (exp = 0; exp < nruns && !torture_must_stop(); exp++) {
 		if (errexit)
@@ -565,14 +566,6 @@ ref_perf_init(void)
 	firsterr = torture_create_kthread(main_func, NULL, main_task);
 	if (firsterr)
 		goto unwind;
-	schedule_timeout_uninterruptible(1);
-
-
-	// Wait until all threads start
-	while (atomic_read(&n_init) < nreaders + 1)
-		schedule_timeout_uninterruptible(1);
-
-	wake_up(&main_wq);
 
 	torture_init_end();
 	return 0;
-- 
2.9.5

