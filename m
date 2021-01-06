Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749D0C4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5513922B2B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbhAFRRz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:17:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbhAFRRy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:17:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37FFC22B2B;
        Wed,  6 Jan 2021 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953432;
        bh=YIvhkYeIvuNCngyVVokHfsTVnExKy1uVvMgJ/LtUyac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJ9+00eja8BLysbcxvgizj6PEq8fAnmi2tEyqrHwanSLz5apNnzmw0odAnddaJTx1
         93rjQfyTBiLMtq7r3slyFzs/aFXrPEmyM9o9U5GpG1m6rOj/U8DHCVi76LhgGRIO9S
         /yObHImmjq1ZDXJi8P3nsQO2+DvWdLLq0EgTCnW2CiWg6CPBGtO03LkHAqj58qGwpK
         C5dYCUJTHYlv/zhE4ZE/+cpu9K5LFirX+tbGp3deWUC9ZziywOiJXOUCzxum2UZ5K6
         PAI7AB9i382Gy7Sq6IYgtvycVdyG/fvVz/zNg+bpCC5rG71BAqDMDxc64mnXFtZpFZ
         ahBZaghEWr9lw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/17] rcutorture: Add testing for RCU's global memory ordering
Date:   Wed,  6 Jan 2021 09:16:54 -0800
Message-Id: <20210106171710.22239-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

RCU guarantees that anything seen by a given reader will also be seen
after any grace period that must wait on that reader.  This is very likely
to hold based on inspection, but the advantage of having rcutorture do
the inspecting is that rcutorture doesn't mind inspecting frequently
and often.

This commit therefore adds code to test RCU's global memory ordering.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 96d55f0..338e118 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -143,11 +143,22 @@ static struct task_struct *read_exit_task;
 
 #define RCU_TORTURE_PIPE_LEN 10
 
+// Mailbox-like structure to check RCU global memory ordering.
+struct rcu_torture_reader_check {
+	unsigned long rtc_myloops;
+	int rtc_chkrdr;
+	unsigned long rtc_chkloops;
+	int rtc_ready;
+	struct rcu_torture_reader_check *rtc_assigner;
+} ____cacheline_internodealigned_in_smp;
+
+// Update-side data structure used to check RCU readers.
 struct rcu_torture {
 	struct rcu_head rtort_rcu;
 	int rtort_pipe_count;
 	struct list_head rtort_free;
 	int rtort_mbtest;
+	struct rcu_torture_reader_check *rtort_chkp;
 };
 
 static LIST_HEAD(rcu_torture_freelist);
@@ -158,10 +169,13 @@ static DEFINE_SPINLOCK(rcu_torture_lock);
 static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_count);
 static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_batch);
 static atomic_t rcu_torture_wcount[RCU_TORTURE_PIPE_LEN + 1];
+static struct rcu_torture_reader_check *rcu_torture_reader_mbchk;
 static atomic_t n_rcu_torture_alloc;
 static atomic_t n_rcu_torture_alloc_fail;
 static atomic_t n_rcu_torture_free;
 static atomic_t n_rcu_torture_mberror;
+static atomic_t n_rcu_torture_mbchk_fail;
+static atomic_t n_rcu_torture_mbchk_tries;
 static atomic_t n_rcu_torture_error;
 static long n_rcu_torture_barrier_error;
 static long n_rcu_torture_boost_ktrerror;
@@ -393,7 +407,12 @@ static bool
 rcu_torture_pipe_update_one(struct rcu_torture *rp)
 {
 	int i;
+	struct rcu_torture_reader_check *rtrcp = READ_ONCE(rp->rtort_chkp);
 
+	if (rtrcp) {
+		WRITE_ONCE(rp->rtort_chkp, NULL);
+		smp_store_release(&rtrcp->rtc_ready, 1); // Pair with smp_load_acquire().
+	}
 	i = READ_ONCE(rp->rtort_pipe_count);
 	if (i > RCU_TORTURE_PIPE_LEN)
 		i = RCU_TORTURE_PIPE_LEN;
@@ -1292,6 +1311,62 @@ static void rcu_torture_timer_cb(struct rcu_head *rhp)
 	kfree(rhp);
 }
 
+// Set up and carry out testing of RCU's global memory ordering
+static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
+					struct torture_random_state *trsp)
+{
+	unsigned long loops;
+	int noc = num_online_cpus();
+	int rdrchked;
+	int rdrchker;
+	struct rcu_torture_reader_check *rtrcp; // Me.
+	struct rcu_torture_reader_check *rtrcp_assigner; // Assigned us to do checking.
+	struct rcu_torture_reader_check *rtrcp_chked; // Reader being checked.
+	struct rcu_torture_reader_check *rtrcp_chker; // Reader doing checking when not me.
+
+	if (myid < 0)
+		return; // Don't try this from timer handlers.
+
+	// Increment my counter.
+	rtrcp = &rcu_torture_reader_mbchk[myid];
+	WRITE_ONCE(rtrcp->rtc_myloops, rtrcp->rtc_myloops + 1);
+
+	// Attempt to assign someone else some checking work.
+	rdrchked = torture_random(trsp) % nrealreaders;
+	rtrcp_chked = &rcu_torture_reader_mbchk[rdrchked];
+	rdrchker = torture_random(trsp) % nrealreaders;
+	rtrcp_chker = &rcu_torture_reader_mbchk[rdrchker];
+	if (rdrchked != myid && rdrchked != rdrchker && noc >= rdrchked && noc >= rdrchker &&
+	    smp_load_acquire(&rtrcp->rtc_chkrdr) < 0 && // Pairs with smp_store_release below.
+	    !READ_ONCE(rtp->rtort_chkp) &&
+	    !smp_load_acquire(&rtrcp_chker->rtc_assigner)) { // Pairs with smp_store_release below.
+		rtrcp->rtc_chkloops = READ_ONCE(rtrcp_chked->rtc_myloops);
+		WARN_ON_ONCE(rtrcp->rtc_chkrdr >= 0);
+		rtrcp->rtc_chkrdr = rdrchked;
+		WARN_ON_ONCE(rtrcp->rtc_ready); // This gets set after the grace period ends.
+		if (cmpxchg_relaxed(&rtrcp_chker->rtc_assigner, NULL, rtrcp) ||
+		    cmpxchg_relaxed(&rtp->rtort_chkp, NULL, rtrcp))
+			(void)cmpxchg_relaxed(&rtrcp_chker->rtc_assigner, rtrcp, NULL); // Back out.
+	}
+
+	// If assigned some completed work, do it!
+	rtrcp_assigner = READ_ONCE(rtrcp->rtc_assigner);
+	if (!rtrcp_assigner || !smp_load_acquire(&rtrcp_assigner->rtc_ready))
+		return; // No work or work not yet ready.
+	rdrchked = rtrcp_assigner->rtc_chkrdr;
+	if (WARN_ON_ONCE(rdrchked < 0))
+		return;
+	rtrcp_chked = &rcu_torture_reader_mbchk[rdrchked];
+	loops = READ_ONCE(rtrcp_chked->rtc_myloops);
+	atomic_inc(&n_rcu_torture_mbchk_tries);
+	if (ULONG_CMP_LT(loops, rtrcp_assigner->rtc_chkloops))
+		atomic_inc(&n_rcu_torture_mbchk_fail);
+	rtrcp_assigner->rtc_chkloops = loops + ULONG_MAX / 2;
+	rtrcp_assigner->rtc_ready = 0;
+	smp_store_release(&rtrcp->rtc_assigner, NULL); // Someone else can assign us work.
+	smp_store_release(&rtrcp_assigner->rtc_chkrdr, -1); // Assigner can again assign.
+}
+
 /*
  * Do one extension of an RCU read-side critical section using the
  * current reader state in readstate (set to zero for initial entry
@@ -1427,7 +1502,7 @@ rcutorture_loop_extend(int *readstate, struct torture_random_state *trsp,
  * no data to read.  Can be invoked both from process context and
  * from a timer handler.
  */
-static bool rcu_torture_one_read(struct torture_random_state *trsp)
+static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 {
 	unsigned long cookie;
 	int i;
@@ -1462,6 +1537,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	}
 	if (p->rtort_mbtest == 0)
 		atomic_inc(&n_rcu_torture_mberror);
+	rcu_torture_reader_do_mbchk(myid, p, trsp);
 	rtrsp = rcutorture_loop_extend(&readstate, trsp, rtrsp);
 	preempt_disable();
 	pipe_count = READ_ONCE(p->rtort_pipe_count);
@@ -1518,7 +1594,7 @@ static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
 static void rcu_torture_timer(struct timer_list *unused)
 {
 	atomic_long_inc(&n_rcu_torture_timers);
-	(void)rcu_torture_one_read(this_cpu_ptr(&rcu_torture_timer_rand));
+	(void)rcu_torture_one_read(this_cpu_ptr(&rcu_torture_timer_rand), -1);
 
 	/* Test call_rcu() invocation from interrupt handler. */
 	if (cur_ops->call) {
@@ -1554,7 +1630,7 @@ rcu_torture_reader(void *arg)
 			if (!timer_pending(&t))
 				mod_timer(&t, jiffies + 1);
 		}
-		if (!rcu_torture_one_read(&rand) && !torture_must_stop())
+		if (!rcu_torture_one_read(&rand, myid) && !torture_must_stop())
 			schedule_timeout_interruptible(HZ);
 		if (time_after(jiffies, lastsleep) && !torture_must_stop()) {
 			schedule_timeout_interruptible(1);
@@ -1614,8 +1690,9 @@ rcu_torture_stats_print(void)
 		atomic_read(&n_rcu_torture_alloc),
 		atomic_read(&n_rcu_torture_alloc_fail),
 		atomic_read(&n_rcu_torture_free));
-	pr_cont("rtmbe: %d rtbe: %ld rtbke: %ld rtbre: %ld ",
+	pr_cont("rtmbe: %d rtmbkf: %d/%d rtbe: %ld rtbke: %ld rtbre: %ld ",
 		atomic_read(&n_rcu_torture_mberror),
+		atomic_read(&n_rcu_torture_mbchk_fail), atomic_read(&n_rcu_torture_mbchk_tries),
 		n_rcu_torture_barrier_error,
 		n_rcu_torture_boost_ktrerror,
 		n_rcu_torture_boost_rterror);
@@ -1632,12 +1709,14 @@ rcu_torture_stats_print(void)
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
+	    atomic_read(&n_rcu_torture_mbchk_fail) ||
 	    n_rcu_torture_barrier_error || n_rcu_torture_boost_ktrerror ||
 	    n_rcu_torture_boost_rterror || n_rcu_torture_boost_failure ||
 	    i > 1) {
 		pr_cont("%s", "!!! ");
 		atomic_inc(&n_rcu_torture_error);
 		WARN_ON_ONCE(atomic_read(&n_rcu_torture_mberror));
+		WARN_ON_ONCE(atomic_read(&n_rcu_torture_mbchk_fail));
 		WARN_ON_ONCE(n_rcu_torture_barrier_error);  // rcu_barrier()
 		WARN_ON_ONCE(n_rcu_torture_boost_ktrerror); // no boost kthread
 		WARN_ON_ONCE(n_rcu_torture_boost_rterror); // can't set RT prio
@@ -2467,7 +2546,7 @@ static int rcu_torture_read_exit_child(void *trsp_in)
 	// Minimize time between reading and exiting.
 	while (!kthread_should_stop())
 		schedule_timeout_uninterruptible(1);
-	(void)rcu_torture_one_read(trsp);
+	(void)rcu_torture_one_read(trsp, -1);
 	return 0;
 }
 
@@ -2582,6 +2661,8 @@ rcu_torture_cleanup(void)
 		kfree(reader_tasks);
 		reader_tasks = NULL;
 	}
+	kfree(rcu_torture_reader_mbchk);
+	rcu_torture_reader_mbchk = NULL;
 
 	if (fakewriter_tasks) {
 		for (i = 0; i < nfakewriters; i++)
@@ -2785,6 +2866,8 @@ rcu_torture_init(void)
 	atomic_set(&n_rcu_torture_alloc_fail, 0);
 	atomic_set(&n_rcu_torture_free, 0);
 	atomic_set(&n_rcu_torture_mberror, 0);
+	atomic_set(&n_rcu_torture_mbchk_fail, 0);
+	atomic_set(&n_rcu_torture_mbchk_tries, 0);
 	atomic_set(&n_rcu_torture_error, 0);
 	n_rcu_torture_barrier_error = 0;
 	n_rcu_torture_boost_ktrerror = 0;
@@ -2826,12 +2909,15 @@ rcu_torture_init(void)
 	}
 	reader_tasks = kcalloc(nrealreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
-	if (reader_tasks == NULL) {
+	rcu_torture_reader_mbchk = kcalloc(nrealreaders, sizeof(*rcu_torture_reader_mbchk),
+					   GFP_KERNEL);
+	if (!reader_tasks || !rcu_torture_reader_mbchk) {
 		VERBOSE_TOROUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
 	for (i = 0; i < nrealreaders; i++) {
+		rcu_torture_reader_mbchk[i].rtc_chkrdr = -1;
 		firsterr = torture_create_kthread(rcu_torture_reader, (void *)i,
 						  reader_tasks[i]);
 		if (firsterr)
-- 
2.9.5

