Return-Path: <SRS0=jKPx=DA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15E5C2D0E2
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 21:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898642145D
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600894995;
	bh=bcl9B3aiM59ZItVr3Jp9XQUxtRE7/ZJkDPBZSxzguo4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=X77xr7cpHf1kE5QoPYAD4NfGPRzNglYVHz96fAqK2+A1/vfKDkOyLX4PIfus+Khz5
	 yo1bIvhsSQFa3oZkuYq+9FOippUX5cLzRh0O1+6Dtp2qxZafJdqrMNHqueC6VLL8xv
	 a1Vz5+aGu0lmjJbeH6dKueWnUrASfkw06NMloUjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIWVDP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Sep 2020 17:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgIWVDO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Sep 2020 17:03:14 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9694320888;
        Wed, 23 Sep 2020 21:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600894993;
        bh=bcl9B3aiM59ZItVr3Jp9XQUxtRE7/ZJkDPBZSxzguo4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uMJhlZDQqB9qaz1Zfch92QLYnPO2rCjxZpPaez9vpWMzC8+AnzvmGOuRbsly3dx9v
         I4WHoG354rx2uZ5Net0/bZ9OErduVd++VS+BN29DWLYR1i0OUo4Jf+YQvyEOsA0PyH
         OD+2d49uUMKmIinJEr1NAWjto06kJ+sRl94Qf9aQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 531B635226CB; Wed, 23 Sep 2020 14:03:13 -0700 (PDT)
Date:   Wed, 23 Sep 2020 14:03:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] rcu/tree: Correctly handle single cpu check in
 rcu_blocking_is_gp
Message-ID: <20200923210313.GS29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1600846173-26085-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600846173-26085-1-git-send-email-neeraju@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 23, 2020 at 12:59:33PM +0530, Neeraj Upadhyay wrote:
> Currently, for non-preempt kernels (with CONFIG_PREEMPTION=n),
> rcu_blocking_is_gp() checks (with preemption disabled), whether
> there is only one cpu online. It uses num_online_cpus() to
> decide whether only one cpu is online. If there is only single
> cpu online, synchronize_rcu() is optimized to return without
> doing all the work to wait for grace period. However, there are
> few issues with the num_online_cpus() check used, for transition
> of __num_online_cpus from 2 -> 1 for cpu down path and 1 -> 2
> for cpu up path.

Again, good catch!

As usual, I could not resist editing the commit log and comments, so
could you please look the following over to make sure that I did not
mess anything up?

							Thanx, Paul

------------------------------------------------------------------------

commit 7af8c1c8d13c6c9c7013fbfef77f843dbc430c4b
Author: Neeraj Upadhyay <neeraju@codeaurora.org>
Date:   Wed Sep 23 12:59:33 2020 +0530

    rcu: Fix single-CPU check in rcu_blocking_is_gp()
    
    Currently, for CONFIG_PREEMPTION=n kernels, rcu_blocking_is_gp() uses
    num_online_cpus() to determine whether there is only one CPU online.  When
    there is only single CPU online, the simple fact that synchronize_rcu()
    could be legally called implies that a full grace period has elapsed.
    Therefore, in the single-CPU case, synchronize_rcu() simply returns
    immediately.  Unfortunately, num_online_cpus() is unreliable while a
    CPU-hotplug operation is transitioning to or from single-CPU operation
    because:
    
    1.      num_online_cpus() uses atomic_read(&__num_online_cpus) to
            locklessly sample the number of online CPUs.  The hotplug locks
            are not held, which means that an incoming CPU can concurrently
            update this count.  This in turn means that an RCU read-side
            critical section on the incoming CPU might observe updates
            prior to the grace period, but also that this critical section
            might extend beyond the end of the optimized synchronize_rcu().
            This breaks RCU's fundamental guarantee.
    
    2.      In addition, num_online_cpus() does no ordering, thus providing
            another way that RCU's fundamental guarantee can be broken by
            the current code.
    
    3.      The most probable failure mode happens on outgoing CPUs.
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
    
    Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6d9ec8e..9c56b63 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2402,6 +2402,7 @@ int rcutree_dead_cpu(unsigned int cpu)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
+	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
 	/* Adjust any no-longer-needed kthreads. */
 	rcu_boost_kthread_setaffinity(rnp, -1);
 	/* Do any needed no-CB deferred wakeups from this CPU. */
@@ -3604,7 +3605,20 @@ static int rcu_blocking_is_gp(void)
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
@@ -3649,7 +3663,7 @@ void synchronize_rcu(void)
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu() in RCU read-side critical section");
 	if (rcu_blocking_is_gp())
-		return;
+		return;  // Context allows vacuous grace periods.
 	if (rcu_gp_is_expedited())
 		synchronize_rcu_expedited();
 	else
@@ -3989,6 +4003,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
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
 
