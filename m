Return-Path: <SRS0=jKPx=DA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23689C4363D
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 07:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12222076B
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 07:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mRgx6lax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIWH3l (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:29:41 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:46077 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgIWH3l (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Sep 2020 03:29:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600846180; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=BDisFRRmcUDs5uCCaaIFb74ApP99M54Ee5MnB8sB5qQ=; b=mRgx6laxrdzZOT7C0LMTszPbowSi7a9QiA2xrIZ11erxckj+Kj2gRP1l4S+hJQRnqCJNRErH
 70ohsZ8vcIsdRlwkW1N4386gUf+3cWwlyBbydG5rDKM7bTLmoQGkLDu6PbwsjBBJmVf8Bq5G
 e7d7aPJJC/gNDrEfFFgYWg86ozU=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f6af96431df7883e502abd2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Sep 2020 07:29:40
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0B3D3C433CB; Wed, 23 Sep 2020 07:29:40 +0000 (UTC)
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EDB93C433C8;
        Wed, 23 Sep 2020 07:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDB93C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH V2] rcu/tree: Correctly handle single cpu check in rcu_blocking_is_gp
Date:   Wed, 23 Sep 2020 12:59:33 +0530
Message-Id: <1600846173-26085-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, for non-preempt kernels (with CONFIG_PREEMPTION=n),
rcu_blocking_is_gp() checks (with preemption disabled), whether
there is only one cpu online. It uses num_online_cpus() to
decide whether only one cpu is online. If there is only single
cpu online, synchronize_rcu() is optimized to return without
doing all the work to wait for grace period. However, there are
few issues with the num_online_cpus() check used, for transition
of __num_online_cpus from 2 -> 1 for cpu down path and 1 -> 2
for cpu up path.

1. For CPU path, num_online_cpus() does a atomic_read(&__num_online_cpus).
   As hotplug locks are not held, this does not ensure that
   new incoming cpus update of the count is visible. This can
   result in read side section on new incoming cpu, observe
   updates which should not be visible beyond the grace period
   corresponding to synchronize_rcu().

   For e.g. below litmus test, where P0 process corresponds to
   synchronize_rcu() and P1 corresponds to new online cpu,  has
   positive witnesses; confirming the possibility of read side
   section to extend before and after the grace period, thereby
   breaking guarantees provided by synchronize_rcu().

   {
     int x = 0;
     atomic_t numonline = ATOMIC_INIT(1);
   }

   P0(int *x, atomic_t *numonline)
   {
     int r0;
     WRITE_ONCE(*x, 1);
     r0 = atomic_read(numonline);
     if (r0 == 1) {
       smp_mb();
     } else {
       synchronize_rcu();
     }
     WRITE_ONCE(*x, 2);
   }

   P1(int *x, atomic_t *numonline)
   {
     int r0; int r1;

     atomic_inc(numonline);
     smp_mb();
     rcu_read_lock();
     r0 = READ_ONCE(*x);
     smp_rmb();
     r1 = READ_ONCE(*x);
     rcu_read_unlock();
   }

   locations [x;numonline;]

   exists (1:r0=0 /\ 1:r1=2)

2. Second problem is, the same early exit, from synchronize_rcu()
   does not provide full ordering, memory barrier, w.r.t. memory
   accesses after synchronize_rcu() call.

3. Third, more important issue is related to outgoing cpu. Checking
   only for __num_online_cpus with preemotion disabled isn't sufficient
   for RCU, as, on completion of CPUHP_TEARDOWN_CPU stop machine (which
   clears outgoing cpu from __num_online_cpus, the CPU switches to idle
   task. So, checking only for __num_online_cpus does not consider
   RCU read side sections in scheduler code (before switching to idle
   task) and any potential read side sections in idle task, before final
   RCU-quiesce entry into cpuhp_report_idle_dead() -> rcu_report_dead().

The problem here is, changes to number of online cpus happen from places
that are not helpful for lockless access from synchronize_rcu() :
for offlining cpu, it happens from stop machine on that cpu, before
cpu is marked offline in rcu bookkeeping, resulting in unwatched RCU
critical sections; and for onlining cpu, it happens on the new cpu,
after it is online, resulting in visibility issues.

To handle these issues, add a new rcu_state member n_online_cpus, to keep
count of the current number of online cpus. This counter is incremented
early in the CPU-hotplug CPU-online process, that is, on the control CPU,
prior to the new CPU coming online. For outgoing cpu, counter is
decremented on the control cpu, after the offlining cpu is long gone.

Update of this counter from control cpu means that, if rcu_state.
n_online_cpus is equal to one in rcu_blocking_is_gp(), below is
guaranteed:

a. There is only one CPU, and that CPU sees all prior accesses made by
   any CPU that was online at the time of its access.  Furthermore,
   rcu_state.n_online_cpus value cannot change, as CONFIG_PREEMPTION=n.

b. All later CPUs (both this one and any that come online later on) are
   guaranteed to see all accesses by any CPU prior to this point in the
   code. The CPU-hotplug code provides the required memory barriers to
   ensure this.

This eliminates the need for any additional memory barriers for the single
cpu online case; it also eliminates the early counter update and visibility
problems with __num_online_cpus value. For multiple cpu online case,
synchronize_rcu() does all the work of grace period initiation and wait
and that provides the required ordering gurantees. rcu_state.n_online_cpus
update from control cpu would result in unnecessary calls to
synchronize_rcu() slow path during the CPU-online process, but that
should have negligible impact.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---

Changes in V2:

- Make rcu_state.n_online_cpus int, instead of atomic_t.
- Move counter updates to rcutree_prepare_cpu() and rcutree_dead_cpu().
- Update commit log and code comments to highlight single-cpu behavior.

 kernel/rcu/tree.c | 21 ++++++++++++++++++++-
 kernel/rcu/tree.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2424e2a..facdec9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2405,6 +2405,7 @@ int rcutree_dead_cpu(unsigned int cpu)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
+	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
 	/* Adjust any no-longer-needed kthreads. */
 	rcu_boost_kthread_setaffinity(rnp, -1);
 	/* Do any needed no-CB deferred wakeups from this CPU. */
@@ -3610,7 +3611,20 @@ static int rcu_blocking_is_gp(void)
 		return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
 	might_sleep();  /* Check for RCU read-side critical section. */
 	preempt_disable();
-	ret = num_online_cpus() <= 1;
+	/*
+	 * If rcu_state.n_online_cpus is equal to one, there is only one CPU,
+	 * and that CPU sees all prior accesses made by any CPU that was
+	 * online at the time of its access.  Furthermore, if rcu_state.
+	 * n_online_cpus is equal to one, its value cannot change until
+	 * after the preempt_enable() below.
+	 *
+	 * Furthermore, if n_online_cpus is equal to one here, all later CPUs
+	 * (both this one and any that come online later on) are guaranteed to
+	 * see all accesses by any CPU prior to this point in the code,
+	 * without the need for additional memory barriers. Those memory
+	 * barriers are provided by CPU-hotplug code.
+	 */
+	ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
 	preempt_enable();
 	return ret;
 }
@@ -3655,6 +3669,10 @@ void synchronize_rcu(void)
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu() in RCU read-side critical section");
 	if (rcu_blocking_is_gp())
+		/*
+		 * Single cpu-state (see comment in rcu_blocking_is_gp())
+		 * guarantees memory ordering.
+		 */
 		return;
 	if (rcu_gp_is_expedited())
 		synchronize_rcu_expedited();
@@ -3996,6 +4014,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	rcu_prepare_kthreads(cpu);
 	rcu_spawn_cpu_nocb_kthread(cpu);
+	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus + 1);
 
 	return 0;
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e4f66b8..805c9eb 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -298,6 +298,7 @@ struct rcu_state {
 						/* Hierarchy levels (+1 to */
 						/*  shut bogus gcc warning) */
 	int ncpus;				/* # CPUs seen so far. */
+	int n_online_cpus;			/* # CPUs online for RCU. */
 
 	/* The following fields are guarded by the root rcu_node's lock. */
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

