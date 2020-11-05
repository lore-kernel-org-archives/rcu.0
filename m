Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5826C4742C
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707B520715
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617810;
	bh=r7m2GK3bbUTNMQp19960qyEcGyCY7thMRIE6XnbHqwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yTTHSDDd6wIr6HWawbbd0J8bbZEfzdI1HjWfEOxI8oabz0p8hXHNG0KY8rGuQng0+
	 fEmcqDfEkzwSiHb5Q1aMKtjKCDJsN+ovujV5SwUK8SQjqTSojzcIhQNVXpLvaZ2R6E
	 st16LSQ4sZv04f/Q18BrS6taoPBBcZYeZsld/dVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbgKEXJ1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:09:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732046AbgKEXJ0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:26 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E304D22201;
        Thu,  5 Nov 2020 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617766;
        bh=r7m2GK3bbUTNMQp19960qyEcGyCY7thMRIE6XnbHqwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TrBSFWxms1PlGkHed0VEr74LLHhe6IooTf7IeNeRi3fnNsy/qxHTqdhlqBp62WBTo
         Ll8EoqfUpHHpOupBv+AZaMI7nT8eCNZ6YxWYwvMS20YvOiz+IS5HlRKXtykWEi7Omj
         qmOGgdzcgz2IlhUn++x+z33XfZOyGzxt7aipqDWQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/16] rcu: Fix single-CPU check in rcu_blocking_is_gp()
Date:   Thu,  5 Nov 2020 15:09:11 -0800
Message-Id: <20201105230921.19017-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

Currently, for CONFIG_PREEMPTION=n kernels, rcu_blocking_is_gp() uses
num_online_cpus() to determine whether there is only one CPU online.  When
there is only a single CPU online, the simple fact that synchronize_rcu()
could be legally called implies that a full grace period has elapsed.
Therefore, in the single-CPU case, synchronize_rcu() simply returns
immediately.  Unfortunately, num_online_cpus() is unreliable while a
CPU-hotplug operation is transitioning to or from single-CPU operation
because:

1.	num_online_cpus() uses atomic_read(&__num_online_cpus) to
	locklessly sample the number of online CPUs.  The hotplug locks
	are not held, which means that an incoming CPU can concurrently
	update this count.  This in turn means that an RCU read-side
	critical section on the incoming CPU might observe updates
	prior to the grace period, but also that this critical section
	might extend beyond the end of the optimized synchronize_rcu().
	This breaks RCU's fundamental guarantee.

2.	In addition, num_online_cpus() does no ordering, thus providing
	another way that RCU's fundamental guarantee can be broken by
	the current code.

3.	The most probable failure mode happens on outgoing CPUs.
	The outgoing CPU updates the count of online CPUs in the
	CPUHP_TEARDOWN_CPU stop-machine handler, which is fine in
	and of itself due to preemption being disabled at the call
	to num_online_cpus().  Unfortunately, after that stop-machine
	handler returns, the CPU takes one last trip through the
	scheduler (which has RCU readers) and, after the resulting
	context switch, one final dive into the idle loop.  During this
	time, RCU needs to keep track of two CPUs, but num_online_cpus()
	will say that there is only one, which in turn means that the
	surviving CPU will incorrectly ignore the outgoing CPU's RCU
	read-side critical sections.

This problem is illustrated by the following litmus test in which P0()
corresponds to synchronize_rcu() and P1() corresponds to the incoming CPU.
The herd7 tool confirms that the "exists" clause can be satisfied,
thus demonstrating that this breakage can happen according to the Linux
kernel memory model.

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

It is important to note that these problems arise only when the system
is transitioning to or from single-CPU operation.

One solution would be to hold the CPU-hotplug locks while sampling
num_online_cpus(), which was in fact the intent of the (redundant)
preempt_disable() and preempt_enable() surrounding this call to
num_online_cpus().  Actually blocking CPU hotplug would not only result
in excessive overhead, but would also unnecessarily impede CPU-hotplug
operations.

This commit therefore follows long-standing RCU tradition by maintaining
a separate RCU-specific set of CPU-hotplug books.

This separate set of books is implemented by a new ->n_online_cpus field
in the rcu_state structure that maintains RCU's count of the online CPUs.
This count is incremented early in the CPU-online process, so that
the critical transition away from single-CPU operation will occur when
there is only a single CPU.  Similarly for the critical transition to
single-CPU operation, the counter is decremented late in the CPU-offline
process, again while there is only a single CPU.  Because there is only
ever a single CPU when the ->n_online_cpus field undergoes the critical
1->2 and 2->1 transitions, full memory ordering and mutual exclusion is
provided implicitly and, better yet, for free.

In the case where the CPU is coming online, nothing will happen until
the current CPU helps it come online.  Therefore, the new CPU will see
all accesses prior to the optimized grace period, which means that RCU
does not need to further delay this new CPU.  In the case where the CPU
is going offline, the outgoing CPU is totally out of the picture before
the optimized grace period starts, which means that this outgoing CPU
cannot see any of the accesses following that grace period.  Again,
RCU needs no further interaction with the outgoing CPU.

This does mean that synchronize_rcu() will unnecessarily do a few grace
periods the hard way just before the second CPU comes online and just
after the second-to-last CPU goes offline, but it is not worth optimizing
this uncommon case.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 19 +++++++++++++++++--
 kernel/rcu/tree.h |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index dc1e578..2ff22a4c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2396,6 +2396,7 @@ int rcutree_dead_cpu(unsigned int cpu)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
+	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
 	/* Adjust any no-longer-needed kthreads. */
 	rcu_boost_kthread_setaffinity(rnp, -1);
 	/* Do any needed no-CB deferred wakeups from this CPU. */
@@ -3577,7 +3578,20 @@ static int rcu_blocking_is_gp(void)
 		return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
 	might_sleep();  /* Check for RCU read-side critical section. */
 	preempt_disable();
-	ret = num_online_cpus() <= 1;
+	/*
+	 * If the rcu_state.n_online_cpus counter is equal to one,
+	 * there is only one CPU, and that CPU sees all prior accesses
+	 * made by any CPU that was online at the time of its access.
+	 * Furthermore, if this counter is equal to one, its value cannot
+	 * change until after the preempt_enable() below.
+	 *
+	 * Furthermore, if rcu_state.n_online_cpus is equal to one here,
+	 * all later CPUs (both this one and any that come online later
+	 * on) are guaranteed to see all accesses prior to this point
+	 * in the code, without the need for additional memory barriers.
+	 * Those memory barriers are provided by CPU-hotplug code.
+	 */
+	ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
 	preempt_enable();
 	return ret;
 }
@@ -3622,7 +3636,7 @@ void synchronize_rcu(void)
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu() in RCU read-side critical section");
 	if (rcu_blocking_is_gp())
-		return;
+		return;  // Context allows vacuous grace periods.
 	if (rcu_gp_is_expedited())
 		synchronize_rcu_expedited();
 	else
@@ -3962,6 +3976,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
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
2.9.5

