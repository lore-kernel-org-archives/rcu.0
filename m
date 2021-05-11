Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25738C43616
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A1761925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhEKXNl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhEKXNc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03A6C61936;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=8L0Fb9zyNbvzAUdwJcC0IEvS3grjXT8FIfklPROi/4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L987zsYSk9zCIVjEIsfX7EZtKexihSQCpqAyBz98lcz6QBcRKC6zmqAPoS5tJ6jZ+
         d+A0hSKLYtQG/DBdb/k0Df/m8fS0R+sgahRywesiYdcKBR0d3h4mekx69Z+9634F4l
         jxcnRtppzjjanXx0MJ6PncnjcKXQfEK5y1+BM61oMlphdMfJx3cgHw49vnSRR5o7kn
         Pv+Rq8TfJG3773btrd2unGhq7PadKg3Is1+0j/MXBTZDara1sg8Z3aCGVLrufo8yQX
         gdAT0vlojDTotIpmH9nvg43R2b890M4FCM6gzuVIxd2d6SUad1Y/qtQ6nWtxdSwVhf
         kI0jFGYoXxrrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 77CE15C0DE5; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/26] rcutorture: Abstract read-lock-held checks
Date:   Tue, 11 May 2021 16:12:05 -0700
Message-Id: <20210511231223.2895398-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds a (*readlock_held)() function pointer to the
rcu_torture_ops structure in order to make the rcu_torture_one_read()
function's rcu_dereference_check() lockdep expression more appropriate
for a given run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 29d2f4c647d3..bf488f957948 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -331,6 +331,7 @@ struct rcu_torture_ops {
 	void (*read_delay)(struct torture_random_state *rrsp,
 			   struct rt_read_seg *rtrsp);
 	void (*readunlock)(int idx);
+	int (*readlock_held)(void);
 	unsigned long (*get_gp_seq)(void);
 	unsigned long (*gp_diff)(unsigned long new, unsigned long old);
 	void (*deferred_free)(struct rcu_torture *p);
@@ -359,6 +360,11 @@ static struct rcu_torture_ops *cur_ops;
  * Definitions for rcu torture testing.
  */
 
+static int torture_readlock_not_held(void)
+{
+	return rcu_read_lock_bh_held() || rcu_read_lock_sched_held();
+}
+
 static int rcu_torture_read_lock(void) __acquires(RCU)
 {
 	rcu_read_lock();
@@ -488,6 +494,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.readlock	= rcu_torture_read_lock,
 	.read_delay	= rcu_read_delay,
 	.readunlock	= rcu_torture_read_unlock,
+	.readlock_held	= torture_readlock_not_held,
 	.get_gp_seq	= rcu_get_gp_seq,
 	.gp_diff	= rcu_seq_diff,
 	.deferred_free	= rcu_torture_deferred_free,
@@ -540,6 +547,7 @@ static struct rcu_torture_ops rcu_busted_ops = {
 	.readlock	= rcu_torture_read_lock,
 	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
 	.readunlock	= rcu_torture_read_unlock,
+	.readlock_held	= torture_readlock_not_held,
 	.get_gp_seq	= rcu_no_completed,
 	.deferred_free	= rcu_busted_torture_deferred_free,
 	.sync		= synchronize_rcu_busted,
@@ -589,6 +597,11 @@ static void srcu_torture_read_unlock(int idx) __releases(srcu_ctlp)
 	srcu_read_unlock(srcu_ctlp, idx);
 }
 
+static int torture_srcu_read_lock_held(void)
+{
+	return srcu_read_lock_held(srcu_ctlp);
+}
+
 static unsigned long srcu_torture_completed(void)
 {
 	return srcu_batches_completed(srcu_ctlp);
@@ -646,6 +659,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
+	.readlock_held	= torture_srcu_read_lock_held,
 	.get_gp_seq	= srcu_torture_completed,
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
@@ -681,6 +695,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
+	.readlock_held	= torture_srcu_read_lock_held,
 	.get_gp_seq	= srcu_torture_completed,
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
@@ -700,6 +715,7 @@ static struct rcu_torture_ops busted_srcud_ops = {
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= rcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
+	.readlock_held	= torture_srcu_read_lock_held,
 	.get_gp_seq	= srcu_torture_completed,
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
@@ -787,6 +803,7 @@ static struct rcu_torture_ops trivial_ops = {
 	.readlock	= rcu_torture_read_lock_trivial,
 	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
 	.readunlock	= rcu_torture_read_unlock_trivial,
+	.readlock_held	= torture_readlock_not_held,
 	.get_gp_seq	= rcu_no_completed,
 	.sync		= synchronize_rcu_trivial,
 	.exp_sync	= synchronize_rcu_trivial,
@@ -850,6 +867,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.readlock	= tasks_tracing_torture_read_lock,
 	.read_delay	= srcu_read_delay,  /* just reuse srcu's version. */
 	.readunlock	= tasks_tracing_torture_read_unlock,
+	.readlock_held	= rcu_read_lock_trace_held,
 	.get_gp_seq	= rcu_no_completed,
 	.deferred_free	= rcu_tasks_tracing_torture_deferred_free,
 	.sync		= synchronize_rcu_tasks_trace,
@@ -871,11 +889,6 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 	return cur_ops->gp_diff(new, old);
 }
 
-static bool __maybe_unused torturing_tasks(void)
-{
-	return cur_ops == &tasks_ops || cur_ops == &tasks_rude_ops;
-}
-
 /*
  * RCU torture priority-boost testing.  Runs one real-time thread per
  * CPU for moderate bursts, repeatedly registering RCU callbacks and
@@ -1553,11 +1566,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	started = cur_ops->get_gp_seq();
 	ts = rcu_trace_clock_local();
 	p = rcu_dereference_check(rcu_torture_current,
-				  rcu_read_lock_bh_held() ||
-				  rcu_read_lock_sched_held() ||
-				  srcu_read_lock_held(srcu_ctlp) ||
-				  rcu_read_lock_trace_held() ||
-				  torturing_tasks());
+				  !cur_ops->readlock_held || cur_ops->readlock_held());
 	if (p == NULL) {
 		/* Wait for rcu_torture_writer to get underway */
 		rcutorture_one_extend(&readstate, 0, trsp, rtrsp);
-- 
2.31.1.189.g2e36527f23

