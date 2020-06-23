Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AB4C433E1
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52B22053B
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872328;
	bh=/J6j4X9LsA8kV8awz8jCjnD599VPo9Se78X3TUv/yio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bmsIty46e8v28sZqfAMghrSO23/8IKbt2IQTFafdOedBiydboA1M0LKemxPIV/zvt
	 VWK1I6jBFBbLKhmEilKOAzKv2I+D4X3OvBqDrSgmjYH0a7hw0YL5yW7Otb9Dp0E8QZ
	 y/34+6aB/9Xbo7mYoP6sqpV72tipCsT7vTLuLqz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgFWAcI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731222AbgFWAaR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ADF02053B;
        Tue, 23 Jun 2020 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872216;
        bh=/J6j4X9LsA8kV8awz8jCjnD599VPo9Se78X3TUv/yio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MlTdTyQoAcKMvp0rBtp8iH8z2XPzyPEVcE8F7DKfubLG7fzfTokcKywnNnVg2xbDC
         1a3o175lgz1smqGmTZydRBNcWrgggrp/6oefNw+pGmHnLRp2yKe+XjNIzy4E+/QwDJ
         KFtRwaG10kjxm0cEiFDPDNhTdnBnCNY0D2CBJaCQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/30] refperf: Hoist function-pointer calls out of the loop
Date:   Mon, 22 Jun 2020 17:29:49 -0700
Message-Id: <20200623003013.26252-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Current runs show PREEMPT=n rcu_read_lock()/rcu_read_unlock() pairs
consuming between 20 and 30 nanoseconds, when in fact the actual value is
zero, give or take the barrier() asm's effect on compiler optimizations.
The additional overhead is caused by function calls through pointers
(especially in these days of Spectre mitigations) and perhaps also
needless argument passing, a non-const loop limit, and an upcounting loop.

This commit therefore combines the ->readlock() and ->readunlock()
function pointers into a single ->readsection() function pointer that
takes the loop count as a const parameter and keeps any data passed
from the read-lock to the read-unlock internal to this new function.

These changes reduce the measured overhead of the aforementioned
PREEMPT=n rcu_read_lock()/rcu_read_unlock() pairs from between 20 and
30 nanoseconds to somewhere south of 500 picoseconds.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 92 ++++++++++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 54 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 4d686fd..57c7b7a 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -108,23 +108,20 @@ static int exp_idx;
 struct ref_perf_ops {
 	void (*init)(void);
 	void (*cleanup)(void);
-	int (*readlock)(void);
-	void (*readunlock)(int idx);
+	void (*readsection)(const int nloops);
 	const char *name;
 };
 
 static struct ref_perf_ops *cur_ops;
 
-// Definitions for RCU ref perf testing.
-static int ref_rcu_read_lock(void) __acquires(RCU)
+static void ref_rcu_read_section(const int nloops)
 {
-	rcu_read_lock();
-	return 0;
-}
+	int i;
 
-static void ref_rcu_read_unlock(int idx) __releases(RCU)
-{
-	rcu_read_unlock();
+	for (i = nloops; i >= 0; i--) {
+		rcu_read_lock();
+		rcu_read_unlock();
+	}
 }
 
 static void rcu_sync_perf_init(void)
@@ -133,8 +130,7 @@ static void rcu_sync_perf_init(void)
 
 static struct ref_perf_ops rcu_ops = {
 	.init		= rcu_sync_perf_init,
-	.readlock	= ref_rcu_read_lock,
-	.readunlock	= ref_rcu_read_unlock,
+	.readsection	= ref_rcu_read_section,
 	.name		= "rcu"
 };
 
@@ -143,42 +139,39 @@ static struct ref_perf_ops rcu_ops = {
 DEFINE_STATIC_SRCU(srcu_refctl_perf);
 static struct srcu_struct *srcu_ctlp = &srcu_refctl_perf;
 
-static int srcu_ref_perf_read_lock(void) __acquires(srcu_ctlp)
+static void srcu_ref_perf_read_section(int nloops)
 {
-	return srcu_read_lock(srcu_ctlp);
-}
+	int i;
+	int idx;
 
-static void srcu_ref_perf_read_unlock(int idx) __releases(srcu_ctlp)
-{
-	srcu_read_unlock(srcu_ctlp, idx);
+	for (i = nloops; i >= 0; i--) {
+		idx = srcu_read_lock(srcu_ctlp);
+		srcu_read_unlock(srcu_ctlp, idx);
+	}
 }
 
 static struct ref_perf_ops srcu_ops = {
 	.init		= rcu_sync_perf_init,
-	.readlock	= srcu_ref_perf_read_lock,
-	.readunlock	= srcu_ref_perf_read_unlock,
+	.readsection	= srcu_ref_perf_read_section,
 	.name		= "srcu"
 };
 
 // Definitions for reference count
 static atomic_t refcnt;
 
-static int srcu_ref_perf_refcnt_lock(void)
+static void ref_perf_refcnt_section(const int nloops)
 {
-	atomic_inc(&refcnt);
-	return 0;
-}
+	int i;
 
-static void srcu_ref_perf_refcnt_unlock(int idx) __releases(srcu_ctlp)
-{
-	atomic_dec(&refcnt);
-	srcu_read_unlock(srcu_ctlp, idx);
+	for (i = nloops; i >= 0; i--) {
+		atomic_inc(&refcnt);
+		atomic_dec(&refcnt);
+	}
 }
 
 static struct ref_perf_ops refcnt_ops = {
 	.init		= rcu_sync_perf_init,
-	.readlock	= srcu_ref_perf_refcnt_lock,
-	.readunlock	= srcu_ref_perf_refcnt_unlock,
+	.readsection	= ref_perf_refcnt_section,
 	.name		= "refcnt"
 };
 
@@ -190,21 +183,19 @@ static void ref_perf_rwlock_init(void)
 	rwlock_init(&test_rwlock);
 }
 
-static int ref_perf_rwlock_lock(void)
+static void ref_perf_rwlock_section(const int nloops)
 {
-	read_lock(&test_rwlock);
-	return 0;
-}
+	int i;
 
-static void ref_perf_rwlock_unlock(int idx)
-{
-	read_unlock(&test_rwlock);
+	for (i = nloops; i >= 0; i--) {
+		read_lock(&test_rwlock);
+		read_unlock(&test_rwlock);
+	}
 }
 
 static struct ref_perf_ops rwlock_ops = {
 	.init		= ref_perf_rwlock_init,
-	.readlock	= ref_perf_rwlock_lock,
-	.readunlock	= ref_perf_rwlock_unlock,
+	.readsection	= ref_perf_rwlock_section,
 	.name		= "rwlock"
 };
 
@@ -216,21 +207,19 @@ static void ref_perf_rwsem_init(void)
 	init_rwsem(&test_rwsem);
 }
 
-static int ref_perf_rwsem_lock(void)
+static void ref_perf_rwsem_section(const int nloops)
 {
-	down_read(&test_rwsem);
-	return 0;
-}
+	int i;
 
-static void ref_perf_rwsem_unlock(int idx)
-{
-	up_read(&test_rwsem);
+	for (i = nloops; i >= 0; i--) {
+		down_read(&test_rwsem);
+		up_read(&test_rwsem);
+	}
 }
 
 static struct ref_perf_ops rwsem_ops = {
 	.init		= ref_perf_rwsem_init,
-	.readlock	= ref_perf_rwsem_lock,
-	.readunlock	= ref_perf_rwsem_unlock,
+	.readsection	= ref_perf_rwsem_section,
 	.name		= "rwsem"
 };
 
@@ -242,8 +231,6 @@ ref_perf_reader(void *arg)
 	unsigned long flags;
 	long me = (long)arg;
 	struct reader_task *rt = &(reader_tasks[me]);
-	unsigned long spincnt;
-	int idx;
 	u64 start;
 	s64 duration;
 
@@ -275,10 +262,7 @@ ref_perf_reader(void *arg)
 
 	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
 
-	for (spincnt = 0; spincnt < loops; spincnt++) {
-		idx = cur_ops->readlock();
-		cur_ops->readunlock(idx);
-	}
+	cur_ops->readsection(loops);
 
 	duration = ktime_get_mono_fast_ns() - start;
 	local_irq_restore(flags);
-- 
2.9.5

