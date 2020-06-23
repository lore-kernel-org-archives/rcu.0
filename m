Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DA5C433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0B02053B
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872273;
	bh=bZg5gBncijoyMWdgbYgciJ0sPWgsDJ5wkZfgfN5L2DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YLzf8B9xNykC5yE4+SGvila/+GG+0ack3TglDi7cFIsxfmt6TewadXGNqFSQITLnJ
	 ZMmPBk5r/YlVMQR8fJvHsq6ZeT8Yxf/13Ln1zyDK1Gs3UNR6TvxppzvErnag9HbQ/C
	 BWtM5CVaNHPhQqKEfWxJobo/F/deFww6HpkDKKIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgFWAbL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731689AbgFWAaU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 438E2208B8;
        Tue, 23 Jun 2020 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872219;
        bh=bZg5gBncijoyMWdgbYgciJ0sPWgsDJ5wkZfgfN5L2DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V75LN1StpBbfVYMH0Ywd1gn7pSoFauo7c5xiXMtF11DNxSmcYZRXPKZPirKnVc2cc
         EjpHwUZyUagLntfDInShjf3UwikiOE0DQJ4ofJMkkMCRbql+49ZUSXuT01S6ySK3Zb
         bukeA9mljNQc8Wo5BY8+wjSPL3hgMCcnna0PLtwg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 20/30] refperf: Add read-side delay module parameter
Date:   Mon, 22 Jun 2020 17:30:03 -0700
Message-Id: <20200623003013.26252-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a refperf.readdelay module parameter that controls the
duration of each critical section.  This parameter allows gathering data
showing how the performance differences between the various primitives
vary with critical-section length.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 108 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 89 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 7839237..57a750b 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -66,8 +66,8 @@ torture_param(long, loops, 10000000, "Number of loops per experiment.");
 torture_param(int, nreaders, -1, "Number of readers, -1 for 75% of CPUs.");
 // Number of runs.
 torture_param(int, nruns, 30, "Number of experiments to run.");
-// Reader delay in nanoseconds, 0 for no delay.
-torture_param(int, readdelay, 0, "Read-side delay in nanoseconds.");
+// Reader delay in microseconds, 0 for no delay.
+torture_param(int, readdelay, 0, "Read-side delay in microseconds.");
 
 #ifdef MODULE
 # define REFPERF_SHUTDOWN 0
@@ -111,6 +111,7 @@ struct ref_perf_ops {
 	void (*init)(void);
 	void (*cleanup)(void);
 	void (*readsection)(const int nloops);
+	void (*delaysection)(const int nloops, const int ndelay);
 	const char *name;
 };
 
@@ -126,6 +127,17 @@ static void ref_rcu_read_section(const int nloops)
 	}
 }
 
+static void ref_rcu_delay_section(const int nloops, const int ndelay)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		rcu_read_lock();
+		udelay(ndelay);
+		rcu_read_unlock();
+	}
+}
+
 static void rcu_sync_perf_init(void)
 {
 }
@@ -133,6 +145,7 @@ static void rcu_sync_perf_init(void)
 static struct ref_perf_ops rcu_ops = {
 	.init		= rcu_sync_perf_init,
 	.readsection	= ref_rcu_read_section,
+	.delaysection	= ref_rcu_delay_section,
 	.name		= "rcu"
 };
 
@@ -141,7 +154,7 @@ static struct ref_perf_ops rcu_ops = {
 DEFINE_STATIC_SRCU(srcu_refctl_perf);
 static struct srcu_struct *srcu_ctlp = &srcu_refctl_perf;
 
-static void srcu_ref_perf_read_section(int nloops)
+static void srcu_ref_perf_read_section(const int nloops)
 {
 	int i;
 	int idx;
@@ -152,16 +165,29 @@ static void srcu_ref_perf_read_section(int nloops)
 	}
 }
 
+static void srcu_ref_perf_delay_section(const int nloops, const int ndelay)
+{
+	int i;
+	int idx;
+
+	for (i = nloops; i >= 0; i--) {
+		idx = srcu_read_lock(srcu_ctlp);
+		udelay(ndelay);
+		srcu_read_unlock(srcu_ctlp, idx);
+	}
+}
+
 static struct ref_perf_ops srcu_ops = {
 	.init		= rcu_sync_perf_init,
 	.readsection	= srcu_ref_perf_read_section,
+	.delaysection	= srcu_ref_perf_delay_section,
 	.name		= "srcu"
 };
 
 // Definitions for reference count
 static atomic_t refcnt;
 
-static void ref_perf_refcnt_section(const int nloops)
+static void ref_refcnt_section(const int nloops)
 {
 	int i;
 
@@ -171,45 +197,69 @@ static void ref_perf_refcnt_section(const int nloops)
 	}
 }
 
+static void ref_refcnt_delay_section(const int nloops, const int ndelay)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		atomic_inc(&refcnt);
+		udelay(ndelay);
+		atomic_dec(&refcnt);
+	}
+}
+
 static struct ref_perf_ops refcnt_ops = {
 	.init		= rcu_sync_perf_init,
-	.readsection	= ref_perf_refcnt_section,
+	.readsection	= ref_refcnt_section,
+	.delaysection	= ref_refcnt_delay_section,
 	.name		= "refcnt"
 };
 
 // Definitions for rwlock
 static rwlock_t test_rwlock;
 
-static void ref_perf_rwlock_init(void)
+static void ref_rwlock_init(void)
 {
 	rwlock_init(&test_rwlock);
 }
 
-static void ref_perf_rwlock_section(const int nloops)
+static void ref_rwlock_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		read_lock(&test_rwlock);
+		read_unlock(&test_rwlock);
+	}
+}
+
+static void ref_rwlock_delay_section(const int nloops, const int ndelay)
 {
 	int i;
 
 	for (i = nloops; i >= 0; i--) {
 		read_lock(&test_rwlock);
+		udelay(ndelay);
 		read_unlock(&test_rwlock);
 	}
 }
 
 static struct ref_perf_ops rwlock_ops = {
-	.init		= ref_perf_rwlock_init,
-	.readsection	= ref_perf_rwlock_section,
+	.init		= ref_rwlock_init,
+	.readsection	= ref_rwlock_section,
+	.delaysection	= ref_rwlock_delay_section,
 	.name		= "rwlock"
 };
 
 // Definitions for rwsem
 static struct rw_semaphore test_rwsem;
 
-static void ref_perf_rwsem_init(void)
+static void ref_rwsem_init(void)
 {
 	init_rwsem(&test_rwsem);
 }
 
-static void ref_perf_rwsem_section(const int nloops)
+static void ref_rwsem_section(const int nloops)
 {
 	int i;
 
@@ -219,12 +269,32 @@ static void ref_perf_rwsem_section(const int nloops)
 	}
 }
 
+static void ref_rwsem_delay_section(const int nloops, const int ndelay)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		down_read(&test_rwsem);
+		udelay(ndelay);
+		up_read(&test_rwsem);
+	}
+}
+
 static struct ref_perf_ops rwsem_ops = {
-	.init		= ref_perf_rwsem_init,
-	.readsection	= ref_perf_rwsem_section,
+	.init		= ref_rwsem_init,
+	.readsection	= ref_rwsem_section,
+	.delaysection	= ref_rwsem_delay_section,
 	.name		= "rwsem"
 };
 
+static void rcu_perf_one_reader(void)
+{
+	if (readdelay <= 0)
+		cur_ops->readsection(loops);
+	else
+		cur_ops->delaysection(loops, readdelay);
+}
+
 // Reader kthread.  Repeatedly does empty RCU read-side
 // critical section, minimizing update-side interference.
 static int
@@ -265,16 +335,16 @@ ref_perf_reader(void *arg)
 
 	// To reduce noise, do an initial cache-warming invocation, check
 	// in, and then keep warming until everyone has checked in.
-	cur_ops->readsection(loops);
+	rcu_perf_one_reader();
 	if (!atomic_dec_return(&n_warmedup))
 		while (atomic_read_acquire(&n_warmedup))
-			cur_ops->readsection(loops);
+			rcu_perf_one_reader();
 	// Also keep interrupts disabled.  This also has the effect
 	// of preventing entries into slow path for rcu_read_unlock().
 	local_irq_save(flags);
 	start = ktime_get_mono_fast_ns();
 
-	cur_ops->readsection(loops);
+	rcu_perf_one_reader();
 
 	duration = ktime_get_mono_fast_ns() - start;
 	local_irq_restore(flags);
@@ -284,7 +354,7 @@ ref_perf_reader(void *arg)
 	// everyone is done.
 	if (!atomic_dec_return(&n_cooleddown))
 		while (atomic_read_acquire(&n_cooleddown))
-			cur_ops->readsection(loops);
+			rcu_perf_one_reader();
 
 	if (atomic_dec_and_test(&nreaders_exp))
 		wake_up(&main_wq);
@@ -449,8 +519,8 @@ static void
 ref_perf_print_module_parms(struct ref_perf_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" PERF_FLAG
-		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d nruns=%d\n", perf_type, tag,
-		 verbose, shutdown, holdoff, loops, nreaders, nruns);
+		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d nruns=%d readdelay=%d\n", perf_type, tag,
+		 verbose, shutdown, holdoff, loops, nreaders, nruns, readdelay);
 }
 
 static void
-- 
2.9.5

