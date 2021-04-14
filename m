Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0EDC433B4
	for <rcu@archiver.kernel.org>; Wed, 14 Apr 2021 23:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EB6611B0
	for <rcu@archiver.kernel.org>; Wed, 14 Apr 2021 23:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhDNXsr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Apr 2021 19:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhDNXsq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Apr 2021 19:48:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DABE7611AD;
        Wed, 14 Apr 2021 23:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618444104;
        bh=IR12TWORQZbaSrvAqiFIvHh7U8GjQYljtfBf4zfVH+M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IsMPa4ExKt7vkrY0Py/D0+WlIis497+qUgK9GaOfe9pXnEvPI9arJrsgjNPl4zbhn
         6Apul6j+FBrb/ct9RdmGaBCximiX9+5HULVMbi9KoTv5hNnuam22HD93QN+SNk8T8O
         EyRNmc/E0S+8Na/1Wo0XMfRoDFTfPEfyGWAG0reiTRtPZ6ITJLt+KIXIaNyrz0d+di
         YIi9v0LEUSZHksGYHG1udxzOlKIaQqilgXcSX7k58CwKcrpbQ9t8XYvhaK7PiK1LRx
         Cb/HuUYJ0Pze6WrRRL7PPtNInw0C8RKGXvxCo3wSt5NAHya+b8l6sJfghbEodcu8Lz
         WSGjZ8aq2tPxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A99375C2738; Wed, 14 Apr 2021 16:48:24 -0700 (PDT)
Date:   Wed, 14 Apr 2021 16:48:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: Should RCU_BOOST kernels use hrtimers in GP kthread?
Message-ID: <20210414234824.GZ4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210216183609.GA7027@paulmck-ThinkPad-P72>
 <20210217153253.fy2mhxo3o3ehsuix@linutronix.de>
 <20210217155447.GC2743@paulmck-ThinkPad-P72>
 <20210217180159.c4lr3h34lkkvjn7s@linutronix.de>
 <20210217191907.GH2743@paulmck-ThinkPad-P72>
 <20210217194359.m647inivfp4frzc7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217194359.m647inivfp4frzc7@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Feb 17, 2021 at 08:43:59PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-02-17 11:19:07 [-0800], Paul E. McKenney wrote:
> > > Ah. One nice thing is that you can move the RCU threads to a house
> > > keeping CPU - away from the CPU(s) running the RT tasks. Would this
> > > scenario be still affected (if ksoftirqd would be blocked)?
> > 
> > At this point, I am going to say that it is the sysadm's job to place
> > the rcuo kthreads, and if they are placed poorly, life is hard.
> 
> Good. Because that is what I suggest :)
> 
> > > Oh. One thing I forgot to mention: the timer_list timer is nice in terms
> > > of moving forward (the timer did not fire, the condition is true and you
> > > move the timeout forward).
> > > A hrtimer timer on the other hand needs to be removed, forwarded and
> > > added back to the "timer tree". This is considered more expensive
> > > especially if the timer does not fire.
> > 
> > There are some timers that are used to cause a wakeup to happen from
> > a clean environment, but maybe these can instead use irq-work.
> 
> irq-work has also a "hard" mode because people ended up to throwing
> everything in there.

So after beating on this a bit, I decided that the timer problems are
specific to rcutorture.  The problem is making a test that reliably
and quickly finds RCU priority boosting failures, while not destroying
the rest of the kernel's ability to function.  The current approach is
CPU-bound FIFO priority-1 real-time processes, and with the RT throttling
disabled.  And one such process on each online CPU, all running
concurrently for a four-second time period.

This is of course a great way to destroy the rest of the kernel.  And
in any other context, this would be abuse that was expected to destroy
the kernel.

So rather than make large changes to RCU, I instead check to see whether
rcutorture is built into the kernel, and in that case crank all of the
ksoftirqd kthreads up to FIFO priority 2, the same as the various RCU
kthreads.  This is a simple change, and if you are running rcutorture
built-in in production you are in a world of hurt anyway, so realtime
ksoftirqd kthreads are the least of your problems.

> > That it can!  Aravinda Prasad prototyped a mechanism hinting to the
> > hypervisor in such cases, but I don't know that this ever saw the light
> > of day.
> 
> Ah, good to know.
> 
> > > My understanding of the need for RCU boosting is to get a task,
> > > preempted (by a RT task) within a RCU section, back on the CPU to
> > > at least close the RCU section. So it is possible to run RCU callbacks
> > > and free memory.
> > > The 10 seconds without RCU callbacks shouldn't be bad unless the OOM
> > > killer got nervous (and if we had memory allocation failures).
> > > Also, running thousands of accumulated callbacks isn't good either.
> > 
> > Sounds good, thank you!
> 
> I hope my understanding was correct. Glad to be if service :)

So far, so good!  ;-)

After reworking rcu_torture_boost() to use the polling interfaces, thus
getting callback invocation out of the way, there did turn out to be a
bug in RCU priority boosting.  If you had a system with more than one
CPU, but also having an rcu_node structure with only one CPU, and task
that blocked while running on that one CPU would never be RCU priority
boosted.

How did this happen?  One step at a time...

o	A bug I was chasing a few years back reproduced much more
	quickly if I enabled CPU hotplug on TREE03.

o	And in addition, x86 no longer supports configurations where CPUs
	cannot be hotplugged (mumble mumble security mumble mumble),
	which means that the rcutorture scripting is always going to
	test CPU hotplug.

o	TREE03 was the one scenario that tested RCU priority boosting.

o	But RCU priority-boost testing assumes that CPU hotplug
	was disabled.  So much so that if it saw that there was any
	CPU-hotplug work going on, it would disable itself.

o	So RCU priority boosting has gone completely untested for
	quite a few years.

o	Quite a few more years back, I learned that firmware sometimes
	lies about the number of CPUs.  I learned this from bug reports
	noting that RCU was creating way more kthreads than made any
	sense on small CPUs.

o	So the spawning of kthreads that are per-CPU or per-group-of-CPUs
	is done at CPU-online time.  Which ensures that systems get
	the right number of RCU kthreads even in the presence of lying
	firmware.  In the case of the RCU boost kthreads, the code
	verifies that the rcu_node structure in question has at least
	one online CPU before spawning the corresponding kthread.

o	Except that changes in CPU hotplug mean that it is quite possible
	for the incoming CPU to not be fully online at the time that
	rcutree_online_cpu() executes.  This means that the RCU boost
	kthread will be spawned when the second for a given rcu_node
	structure comes online.

o	Which means that rcu_node structures that have only one CPU
	never get an RCU boost kthread.  This is unusual, requiring 17,
	33, 49, 65, ... CPUs on the system given default values for RCU
	kconfig options.  But it can be made to happen, especially when
	using the rcutorture scripting.
	('--kconfig "CONFIG_NR_CPUS=17" ...')

The fix is to push the check for at least one online CPU up into the
loop that is executed during early boot, which means that the calls
from rcutree_online_cpu() can be moved to rcutree_prepare_cpu(), and
can simply assume that the CPU will eventually come online.  The patch
is shown below.

The rcu_torture_boost() function required additional rework because CPUs
can fail to pass through a quiescent state for some seconds from time to
time, and there is nothing that RCU priority boosting can do about this.
I therefore added checks for this condition, and refrain from reporting
an error in such cases.

I also created a new BUSTED-BOOST scenario that tests RCU priority
boosting on a kernel built with CONFIG_RCU_BOOST=y.  This fails within a
few tens of seconds, so the test might actually be working.  If testing
continues to go well, I expect to submit these into the v5.14 merge window
(not the upcoming one, but the one after that).

More than you probably wanted to know, but at least both the boosting
and its tests now seem to be doing something useful.

							Thanx, Paul

------------------------------------------------------------------------

commit 8193d3465bc8fb8bd3ee765c42df2f551c01329a
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon Apr 5 20:42:09 2021 -0700

    rcu: Make RCU priority boosting work on single-CPU rcu_node structures
    
    When any CPU comes online, it checks to see if an RCU-boost kthread has
    already been created for that CPU's leaf rcu_node structure, and if
    not, it creates one.  Unfortunately, it also verifies that this leaf
    rcu_node structure actually has at least one online CPU, and if not,
    it declines to create the kthread.  Although this behavior makes sense
    during early boot, especially on systems that claim far more CPUs than
    they actually have, it makes no sense for the first CPU to come online
    for a given rcu_node structure.  There is no point in checking because
    we know there is a CPU on its way in.
    
    The problem is that timing differences can cause this incoming CPU to not
    yet be reflected in the various bit masks even at rcutree_online_cpu()
    time, and there is no chance at rcutree_prepare_cpu() time.  Plus it
    would be better to create the RCU-boost kthread at rcutree_prepare_cpu()
    to handle the case where the CPU is involved in an RCU priority inversion
    very shortly after it comes online.
    
    This commit therefore moves the checking to rcu_prepare_kthreads(), which
    is called only at early boot, when the check is appropriate.  In addition,
    it makes rcutree_prepare_cpu() invoke rcu_spawn_one_boost_kthread(), which
    no longer does any checking for online CPUs.
    
    With this change, RCU priority boosting tests now pass for short rcutorture
    runs, even with single-CPU leaf rcu_node structures.
    
    Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Cc: Scott Wood <swood@redhat.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 03282196953a..5c214705c33f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4167,7 +4167,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
 	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	rcu_prepare_kthreads(cpu);
+	rcu_spawn_one_boost_kthread(rnp);
 	rcu_spawn_cpu_nocb_kthread(cpu);
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus + 1);
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 007be551803e..305cf6aeb408 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -417,8 +417,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
 static bool rcu_is_callbacks_kthread(void);
 static void rcu_cpu_kthread_setup(unsigned int cpu);
+static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp);
 static void __init rcu_spawn_boost_kthreads(void);
-static void rcu_prepare_kthreads(int cpu);
 static void rcu_cleanup_after_idle(void);
 static void rcu_prepare_for_idle(void);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 6bf72c4132a6..464b16132866 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1188,22 +1188,16 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
  */
 static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
-	int rnp_index = rnp - rcu_get_root();
 	unsigned long flags;
+	int rnp_index = rnp - rcu_get_root();
 	struct sched_param sp;
 	struct task_struct *t;
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
-		return;
-
-	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
+	if (rnp->boost_kthread_task || !rcu_scheduler_fully_active)
 		return;
 
 	rcu_state.boost = 1;
 
-	if (rnp->boost_kthread_task != NULL)
-		return;
-
 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
 			   "rcub/%d", rnp_index);
 	if (WARN_ON_ONCE(IS_ERR(t)))
@@ -1255,17 +1249,8 @@ static void __init rcu_spawn_boost_kthreads(void)
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp)
-		rcu_spawn_one_boost_kthread(rnp);
-}
-
-static void rcu_prepare_kthreads(int cpu)
-{
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_node *rnp = rdp->mynode;
-
-	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
-	if (rcu_scheduler_fully_active)
-		rcu_spawn_one_boost_kthread(rnp);
+		if (rcu_rnp_online_cpus(rnp))
+			rcu_spawn_one_boost_kthread(rnp);
 }
 
 #else /* #ifdef CONFIG_RCU_BOOST */
@@ -1285,15 +1270,15 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
 {
 }
 
-static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
+static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
 }
 
-static void __init rcu_spawn_boost_kthreads(void)
+static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 {
 }
 
-static void rcu_prepare_kthreads(int cpu)
+static void __init rcu_spawn_boost_kthreads(void)
 {
 }
 
