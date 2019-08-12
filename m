Return-Path: <SRS0=P5Uu=WI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94931C433FF
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 23:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E918206A2
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 23:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfHLXBk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Aug 2019 19:01:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbfHLXBj (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 12 Aug 2019 19:01:39 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CMuhWM090194;
        Mon, 12 Aug 2019 19:01:36 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ubg6ha7gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 19:01:36 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7CN0LIM011843;
        Mon, 12 Aug 2019 23:01:35 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 2u9nj6hwsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 23:01:35 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7CN1YpD52101524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Aug 2019 23:01:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D80D9B2066;
        Mon, 12 Aug 2019 23:01:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7390B205F;
        Mon, 12 Aug 2019 23:01:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Aug 2019 23:01:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D6E1C16C08C2; Mon, 12 Aug 2019 16:01:38 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:01:38 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190812230138.GS28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190811180852.GA128944@google.com>
 <20190811211318.GX28441@linux.ibm.com>
 <20190812032142.GA171001@google.com>
 <20190812035306.GE28441@linux.ibm.com>
 <20190812212013.GB48751@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812212013.GB48751@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120224
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 12, 2019 at 05:20:13PM -0400, Joel Fernandes wrote:
> On Sun, Aug 11, 2019 at 08:53:06PM -0700, Paul E. McKenney wrote:
> > On Sun, Aug 11, 2019 at 11:21:42PM -0400, Joel Fernandes wrote:
> > > On Sun, Aug 11, 2019 at 02:13:18PM -0700, Paul E. McKenney wrote:
> > > [snip]
> > > > This leaves NO_HZ_FULL=y&&PREEMPT=y kernels.  In that case, RCU is
> > > > more aggressive about using resched_cpu() on CPUs that have not yet
> > > > reported a quiescent state for the current grace period.
> > > 
> > > Just wanted to ask something - how does resched_cpu() help for this case?
> > > 
> > > Consider a nohz_full CPU and a PREEMPT=y kernel. Say a single task is running
> > > in kernel mode with scheduler tick off. As we discussed, we have no help from
> > > cond_resched() (since its a PREEMPT=y kernel).  Because enough time has
> > > passed (jtsq*3), we send the CPU a re-scheduling IPI.
> > > 
> > > This seems not that useful. Even if we enter the scheduler due to the
> > > rescheduling flags set on that CPU, nothing will do the rcu_report_qs_rdp()
> > > or rcu_report_qs_rnp() on those CPUs, which are needed to propagate the
> > > quiescent state to the leaf node. Neither will anything to do a
> > > rcu_momentary_dyntick_idle() for that CPU. Without this, the grace period
> > > will still end up getting blocked.
> > > 
> > > Could you clarify which code paths on a nohz_full CPU running PREEMPT=y
> > > kernel actually helps to end the grace period when we call resched_cpu() on
> > > it?  Don't we need atleast do a rcu_momentary_dyntick_idle() from the
> > > scheduler IPI handler or from resched_cpu() for the benefit of a nohz_full
> > > CPU? Maybe I should do an experiment to see this all play out.
> > 
> > An experiment would be good!
> 
> Hi Paul,
> Some very interesting findings!
> 
> Experiment: a tight loop rcuperf thread bound to a nohz_full CPU with
> CONFIG_PREEMPT=y and CONFIG_NO_HZ_FULL=y. Executes for 5000 jiffies and
> exits. Diff for test is appended.
> 
> Inference: I see that the tick is off on the nohz_full CPU 3 (the looping
> thread is affined to CPU 3). The FQS loop does resched_cpu on 3, but the
> grace period is unable to come to an end with the hold up seemingly due to
> CPU 3.

Good catch!

> I see that the scheduler tick is off mostly, but occasionally is turned back
> on during the test loop. However it has no effect and the grace period is
> stuck on the same rcu_state.gp_seq value for the duration of the test. I
> think the scheduler-tick ineffectiveness could be because of this patch?
> https://lore.kernel.org/patchwork/patch/446044/

Unlikely, given that __rcu_pending(), which is now just rcu_pending(),
is only invoked from the scheduler-clock interrupt.

But from your traces below, clearly something is in need of repair.

> Relevant traces, sorry I did not wrap it for better readability:
> 
> Here I marked the start of the test:
> 
> [   24.852639] rcu_perf-163    13.... 1828278us : rcu_perf_writer: Start of rcuperf test
> [   24.853651] rcu_perf-163    13dN.1 1828284us : rcu_grace_period: rcu_preempt 18446744073709550677 cpuqs
> [   24.971709] rcu_pree-10      0d..1 1833228us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   26.493607] rcu_pree-10      0d..1 2137286us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   28.090618] rcu_pree-10      0d..1 2441290us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> 
> Scheduler tick came in but almost 6 seconds of start of test, probably because migrate thread increase number of tasks queued on RQ:
> 
> [   28.355513] rcu_perf-163     3d.h. 2487447us : rcu_sched_clock_irq: sched-tick
> [   29.592912] rcu_pree-10      0d..1 2745293us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   30.238041] rcu_perf-163     3d..2 2879562us : sched_switch: prev_comm=rcu_perf_writer prev_pid=163 prev_prio=98 prev_state=R+ ==> next_comm=migration/3 next_pid=26 next_prio=0
> [   30.269203] migratio-26      3d..2 2879745us : sched_switch: prev_comm=migration/3 prev_pid=26 prev_prio=0 prev_state=S ==> next_comm=rcu_perf_writer next_pid=163 next_prio=98
> [   31.109635] rcu_pree-10      0d..1 3049301us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   32.627686] rcu_pree-10      0d..1 3353298us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   34.071163] rcu_pree-10      0d..1 3657299us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> 
> Several context-switches on CPU 3, but grace-period is still extended:
> 
> [   34.634814] rcu_perf-163     3d..2 3775310us : sched_switch: prev_comm=rcu_perf_writer prev_pid=163 prev_prio=98 prev_state=R+ ==> next_comm=kworker/3:0 next_pid=28 next_prio=120
> [   34.638532] kworker/-28      3d..2 3775343us : sched_switch: prev_comm=kworker/3:0 prev_pid=28 prev_prio=120 prev_state=D ==> next_comm=cpuhp/3 next_pid=25 next_prio=120
> [   34.640338]  cpuhp/3-25      3d..2 3775348us : sched_switch: prev_comm=cpuhp/3 prev_pid=25 prev_prio=120 prev_state=S ==> next_comm=swapper/3 next_pid=0 next_prio=120
> [   34.653831]   <idle>-0       3d..2 3775522us : sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/3:0 next_pid=28 next_prio=120
> [   34.657770] kworker/-28      3d..2 3775536us : sched_switch: prev_comm=kworker/3:0 prev_pid=28 prev_prio=120 prev_state=I ==> next_comm=kworker/3:1 next_pid=177 next_prio=120
> [   34.661758] kworker/-177     3d..2 3775543us : sched_switch: prev_comm=kworker/3:1 prev_pid=177 prev_prio=120 prev_state=I ==> next_comm=swapper/3 next_pid=0 next_prio=120
> [   34.866007]   <idle>-0       3d..2 3789967us : sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/3:0H next_pid=29 next_prio=100
> [   34.874200] kworker/-29      3d..2 3789988us : sched_switch: prev_comm=kworker/3:0H prev_pid=29 prev_prio=100 prev_state=I ==> next_comm=swapper/3 next_pid=0 next_prio=120
> [   35.128506]   <idle>-0       3d..2 3816391us : sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=cpuhp/3 next_pid=25 next_prio=120
> [   35.130481]  cpuhp/3-25      3d..2 3816503us : sched_switch: prev_comm=cpuhp/3 prev_pid=25 prev_prio=120 prev_state=S ==> next_comm=swapper/3 next_pid=0 next_prio=120
> [   35.509469]   <idle>-0       3d..2 3828462us : sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_perf_writer next_pid=163 next_prio=98
> 
> Scheduler tick doesn't do much to help:
> 
> [   35.512436] rcu_perf-163     3d.h. 3829210us : rcu_sched_clock_irq: sched-tick
> 
> Now scheduler tick is completely off for the next 29 seconds. FQS loops keeps
> doing resched_cpu on CPU 3 at 300 jiffy intervals (my HZ=1000):
> 
> [   36.160145] rcu_pree-10      0d..1 3958214us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   38.778574] rcu_pree-10      0d..1 4262288us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   40.604108] rcu_pree-10      0d..1 4566246us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   42.565345] rcu_pree-10      0d..1 4870294us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   44.322041] rcu_pree-10      0d..1 5174293us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   46.083710] rcu_pree-10      0d..1 5478290us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   47.851449] rcu_pree-10      0d..1 5782289us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   49.693127] rcu_pree-10      0d..1 6086293us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   51.432018] rcu_pree-10      0d..1 6390283us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   53.187991] rcu_pree-10      0d..1 6694294us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   53.970850] rcu_perf-163     3.... 6828237us : rcu_perf_writer: End of rcuperf test
> 
> I feel we could do one of:
> 1. Call rcu_momentary_dyntick_idle() from the re-schedule IPI handler

This would not be so good in the case where said handler interrupted
an RCU read-side critical section.

> 2. Raise the RCU softirq for NOHZ_FULL CPUs from re-schedule IPI handler or timer tick.

This could work, but we normally need multiple softirq invocations to
get to a quiescent state.  So we really need to turn the scheduler-clock
interrupt on.

We do have a hook into the interrupt handlers in the guise of the
irq==true case in rcu_nmi_exit_common().  When switching to an extended
quiescent state, there is nothing to do because FQS will detect the
quiescent state on the next pass.  Otherwise, the scheduler-clock
tick could be turned on.  But only if this is a nohz_full CPU and the
rdp->rcu_urgent_qs flag is set and the rdp->dynticks_nmi_nesting value
is 2.

We also would need to turn the scheduler-clock interrupt off at some
point, presumably when a CPU reports its quiescent state to RCU core.

Interestingly enough, rcu_torture_fwd_prog_nr() detected this, but
my response was to add this to the beginning and end of it:

	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
		tick_dep_set_task(current, TICK_DEP_MASK_RCU);

	...

	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
		tick_dep_clear_task(current, TICK_DEP_MASK_RCU);

Thus, one could argue that this functionality should instead be in the
nohz_full code, but one has to start somewhere.  The goal would be to
be able to remove these statements from rcu_torture_fwd_prog_nr().

> What do you think?  Also test diff is below.

Looks reasonable, though the long-term approach is to remove the above
lines from rcu_torture_fwd_prog_nr().  :-/

Untested patch below that includes some inadvertent whitespace fixes,
probably does not even build.  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8c494a692728..ad906d6a74fb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -651,6 +651,12 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	 */
 	if (rdp->dynticks_nmi_nesting != 1) {
 		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
+		if (tick_nohz_full_cpu(rdp->cpu) &&
+		    rdp->dynticks_nmi_nesting == 2 &&
+		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+			rdp->rcu_forced_tick = true;
+			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
+		}
 		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
 			   rdp->dynticks_nmi_nesting - 2);
 		return;
@@ -886,6 +892,16 @@ void rcu_irq_enter_irqson(void)
 	local_irq_restore(flags);
 }
 
+/*
+ * If the scheduler-clock interrupt was enabled on a nohz_full CPU
+ * in order to get to a quiescent state, disable it.
+ */
+void rcu_disable_tick_upon_qs(struct rcu_data *rdp)
+{
+	if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick)
+		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
+}
+
 /**
  * rcu_is_watching - see if RCU thinks that the current CPU is not idle
  *
@@ -1980,6 +1996,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		if (!offloaded)
 			needwake = rcu_accelerate_cbs(rnp, rdp);
 
+		rcu_disable_tick_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
 		if (needwake)
@@ -2269,6 +2286,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 	int cpu;
 	unsigned long flags;
 	unsigned long mask;
+	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp) {
@@ -2293,8 +2311,10 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
 			unsigned long bit = leaf_node_cpu_bit(rnp, cpu);
 			if ((rnp->qsmask & bit) != 0) {
-				if (f(per_cpu_ptr(&rcu_data, cpu)))
-					mask |= bit;
+				rdp = per_cpu_ptr(&rcu_data, cpu);
+				if (f(rdp))
+					rcu_disable_tick_upon_qs(rdp);
+				mask |= bit;
 			}
 		}
 		if (mask != 0) {
@@ -2322,7 +2342,7 @@ void rcu_force_quiescent_state(void)
 	rnp = __this_cpu_read(rcu_data.mynode);
 	for (; rnp != NULL; rnp = rnp->parent) {
 		ret = (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) ||
-		      !raw_spin_trylock(&rnp->fqslock);
+		       !raw_spin_trylock(&rnp->fqslock);
 		if (rnp_old != NULL)
 			raw_spin_unlock(&rnp_old->fqslock);
 		if (ret)
@@ -2855,7 +2875,7 @@ static void rcu_barrier_callback(struct rcu_head *rhp)
 {
 	if (atomic_dec_and_test(&rcu_state.barrier_cpu_count)) {
 		rcu_barrier_trace(TPS("LastCB"), -1,
-				   rcu_state.barrier_sequence);
+				  rcu_state.barrier_sequence);
 		complete(&rcu_state.barrier_completion);
 	} else {
 		rcu_barrier_trace(TPS("CB"), -1, rcu_state.barrier_sequence);
@@ -2879,7 +2899,7 @@ static void rcu_barrier_func(void *unused)
 	} else {
 		debug_rcu_head_unqueue(&rdp->barrier_head);
 		rcu_barrier_trace(TPS("IRQNQ"), -1,
-				   rcu_state.barrier_sequence);
+				  rcu_state.barrier_sequence);
 	}
 	rcu_nocb_unlock(rdp);
 }
@@ -2906,7 +2926,7 @@ void rcu_barrier(void)
 	/* Did someone else do our work for us? */
 	if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
 		rcu_barrier_trace(TPS("EarlyExit"), -1,
-				   rcu_state.barrier_sequence);
+				  rcu_state.barrier_sequence);
 		smp_mb(); /* caller's subsequent code after above check. */
 		mutex_unlock(&rcu_state.barrier_mutex);
 		return;
@@ -2938,11 +2958,11 @@ void rcu_barrier(void)
 			continue;
 		if (rcu_segcblist_n_cbs(&rdp->cblist)) {
 			rcu_barrier_trace(TPS("OnlineQ"), cpu,
-					   rcu_state.barrier_sequence);
+					  rcu_state.barrier_sequence);
 			smp_call_function_single(cpu, rcu_barrier_func, NULL, 1);
 		} else {
 			rcu_barrier_trace(TPS("OnlineNQ"), cpu,
-					   rcu_state.barrier_sequence);
+					  rcu_state.barrier_sequence);
 		}
 	}
 	put_online_cpus();
@@ -3168,6 +3188,7 @@ void rcu_cpu_starting(unsigned int cpu)
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
 	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
+		rcu_disable_tick_upon_qs(rdp);
 		/* Report QS -after- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 	} else {
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index c612f306fe89..055c31781d3a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -181,6 +181,7 @@ struct rcu_data {
 	atomic_t dynticks;		/* Even value for idle, else odd. */
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
+	bool rcu_forced_tick;		/* Forced tick to provide QS. */
 #ifdef CONFIG_RCU_FAST_NO_HZ
 	bool all_lazy;			/* All CPU's CBs lazy at idle start? */
 	unsigned long last_accelerate;	/* Last jiffy CBs were accelerated. */
