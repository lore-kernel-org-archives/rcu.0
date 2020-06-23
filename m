Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1AAC433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6227220DD4
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872220;
	bh=nyQeh8flDROkmEBHFnAc9Eq59qY4dCjQxdLV3qah2e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RAFdUQ+s31Ii7zTkTDihhDFs8qEukpV7eTpMwYwrpmY0AkLI79vfFGREJIEpt8rPI
	 crRMoOfvagaKjdhDnxZh9Pr8sVHeIGj6x11c37zc358fTnEvnNbvhOgGX3M4rT31Pn
	 1KO8crMVDWk3tiiNIOSEbUA1xUH6YuguRm1MUAWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbgFWAaT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731668AbgFWAaS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B5520857;
        Tue, 23 Jun 2020 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872218;
        bh=nyQeh8flDROkmEBHFnAc9Eq59qY4dCjQxdLV3qah2e0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hsqwPVg5yx/RCuesFx6eSikjWbGZRPo/d4MnxOZuZMUdHh9x0DCLNRVd6FGpHmsor
         MtI0+NztI0tddqNAip1RXGnzFhMDsdXPgqJLhVI/m03ulV+LQG2rzHeOxxYZvtkOjr
         8SVzmL+IxqU5ETmecyTVrk8+++kR2Y3qazGI4uhI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/30] refperf: Convert reader_task structure's "start" field to int
Date:   Mon, 22 Jun 2020 17:29:57 -0700
Message-Id: <20200623003013.26252-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit converts the reader_task structure's "start" field to int
in order to demote a full barrier to an smp_load_acquire() and also to
simplify the code a bit.  While in the area, and to enlist the compiler's
help in ensuring that nothing was missed, the field's name was changed
to start_reader.

Also while in the area, change the main_func() store to use
smp_store_release() to further fortify against wait/wake races.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 8815ccf..2fd3ed1 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -80,7 +80,7 @@ torture_param(bool, shutdown, REFPERF_SHUTDOWN,
 
 struct reader_task {
 	struct task_struct *task;
-	atomic_t start;
+	int start_reader;
 	wait_queue_head_t wq;
 	u64 last_duration_ns;
 };
@@ -243,7 +243,7 @@ ref_perf_reader(void *arg)
 	VERBOSE_PERFOUT("ref_perf_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
 
 	// Wait for signal that this reader can start.
-	wait_event(rt->wq, (atomic_read(&nreaders_exp) && atomic_read(&rt->start)) ||
+	wait_event(rt->wq, (atomic_read(&nreaders_exp) && smp_load_acquire(&rt->start_reader)) ||
 			   torture_must_stop());
 
 	if (torture_must_stop())
@@ -252,8 +252,7 @@ ref_perf_reader(void *arg)
 	// Make sure that the CPU is affinitized appropriately during testing.
 	WARN_ON_ONCE(smp_processor_id() != me);
 
-	smp_mb__before_atomic();
-	atomic_dec(&rt->start);
+	WRITE_ONCE(rt->start_reader, 0);
 
 	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
 
@@ -372,7 +371,7 @@ static int main_func(void *arg)
 		exp_idx = exp;
 
 		for (r = 0; r < nreaders; r++) {
-			atomic_set(&reader_tasks[r].start, 1);
+			smp_store_release(&reader_tasks[r].start_reader, 1);
 			wake_up(&reader_tasks[r].wq);
 		}
 
-- 
2.9.5

