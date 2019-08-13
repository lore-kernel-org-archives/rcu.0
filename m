Return-Path: <SRS0=0MOJ=WJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6177C433FF
	for <rcu@archiver.kernel.org>; Tue, 13 Aug 2019 02:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA28206A2
	for <rcu@archiver.kernel.org>; Tue, 13 Aug 2019 02:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfHMC1b (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Aug 2019 22:27:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbfHMC1b (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 12 Aug 2019 22:27:31 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7D2RA1C102992;
        Mon, 12 Aug 2019 22:27:28 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ubm2t8p35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 22:27:28 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7D2Ql6b011632;
        Tue, 13 Aug 2019 02:27:27 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 2u9nj62vtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 02:27:27 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7D2RQEI24707340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 02:27:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB4CAB2068;
        Tue, 13 Aug 2019 02:27:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88995B205F;
        Tue, 13 Aug 2019 02:27:26 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.215.124])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Aug 2019 02:27:26 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 34ED716C1109; Mon, 12 Aug 2019 19:27:26 -0700 (PDT)
Date:   Mon, 12 Aug 2019 19:27:26 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190813022726.GW28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190811180852.GA128944@google.com>
 <20190811211318.GX28441@linux.ibm.com>
 <20190812032142.GA171001@google.com>
 <20190812035306.GE28441@linux.ibm.com>
 <20190812212013.GB48751@google.com>
 <20190812230138.GS28441@linux.ibm.com>
 <20190813010249.GA129011@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813010249.GA129011@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130025
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 12, 2019 at 09:02:49PM -0400, Joel Fernandes wrote:
> On Mon, Aug 12, 2019 at 04:01:38PM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 12, 2019 at 05:20:13PM -0400, Joel Fernandes wrote:
> > > On Sun, Aug 11, 2019 at 08:53:06PM -0700, Paul E. McKenney wrote:
> > > > On Sun, Aug 11, 2019 at 11:21:42PM -0400, Joel Fernandes wrote:
> > > > > On Sun, Aug 11, 2019 at 02:13:18PM -0700, Paul E. McKenney wrote:
> > > > > [snip]
> > > > > > This leaves NO_HZ_FULL=y&&PREEMPT=y kernels.  In that case, RCU is
> > > > > > more aggressive about using resched_cpu() on CPUs that have not yet
> > > > > > reported a quiescent state for the current grace period.
> > > > > 
> > > > > Just wanted to ask something - how does resched_cpu() help for this case?
> > > > > 
> > > > > Consider a nohz_full CPU and a PREEMPT=y kernel. Say a single task is running
> > > > > in kernel mode with scheduler tick off. As we discussed, we have no help from
> > > > > cond_resched() (since its a PREEMPT=y kernel).  Because enough time has
> > > > > passed (jtsq*3), we send the CPU a re-scheduling IPI.
> > > > > 
> > > > > This seems not that useful. Even if we enter the scheduler due to the
> > > > > rescheduling flags set on that CPU, nothing will do the rcu_report_qs_rdp()
> > > > > or rcu_report_qs_rnp() on those CPUs, which are needed to propagate the
> > > > > quiescent state to the leaf node. Neither will anything to do a
> > > > > rcu_momentary_dyntick_idle() for that CPU. Without this, the grace period
> > > > > will still end up getting blocked.
> > > > > 
> > > > > Could you clarify which code paths on a nohz_full CPU running PREEMPT=y
> > > > > kernel actually helps to end the grace period when we call resched_cpu() on
> > > > > it?  Don't we need atleast do a rcu_momentary_dyntick_idle() from the
> > > > > scheduler IPI handler or from resched_cpu() for the benefit of a nohz_full
> > > > > CPU? Maybe I should do an experiment to see this all play out.
> > > > 
> > > > An experiment would be good!
> > > 
> > > Hi Paul,
> > > Some very interesting findings!
> > > 
> > > Experiment: a tight loop rcuperf thread bound to a nohz_full CPU with
> > > CONFIG_PREEMPT=y and CONFIG_NO_HZ_FULL=y. Executes for 5000 jiffies and
> > > exits. Diff for test is appended.
> > > 
> > > Inference: I see that the tick is off on the nohz_full CPU 3 (the looping
> > > thread is affined to CPU 3). The FQS loop does resched_cpu on 3, but the
> > > grace period is unable to come to an end with the hold up seemingly due to
> > > CPU 3.
> > 
> > Good catch!
> 
> Thanks!
> 
> > > I see that the scheduler tick is off mostly, but occasionally is turned back
> > > on during the test loop. However it has no effect and the grace period is
> > > stuck on the same rcu_state.gp_seq value for the duration of the test. I
> > > think the scheduler-tick ineffectiveness could be because of this patch?
> > > https://lore.kernel.org/patchwork/patch/446044/
> > 
> > Unlikely, given that __rcu_pending(), which is now just rcu_pending(),
> > is only invoked from the scheduler-clock interrupt.
> 
> True, plus I missed that after a second, the RCU core is invoked from the
> tick (via rcu_pending) even from a CPU designated as nohz_full
> (rcu_nohz_full_cpu returns false).
> 
> > But from your traces below, clearly something is in need of repair.
> 
> Ok.
> 
> > > Relevant traces, sorry I did not wrap it for better readability:
> [snip]
> > > I feel we could do one of:
> > > 1. Call rcu_momentary_dyntick_idle() from the re-schedule IPI handler
> > 
> > This would not be so good in the case where said handler interrupted
> > an RCU read-side critical section.
> 
> Agreed, let us scratch that idea.
> 
> > > 2. Raise the RCU softirq for NOHZ_FULL CPUs from re-schedule IPI handler or timer tick.
> > 
> > This could work, but we normally need multiple softirq invocations to
> > get to a quiescent state.  So we really need to turn the scheduler-clock
> > interrupt on.
> 
> I did not fully understand why multiple softirq invocation would be needed.
> But I think it would mean moving the complexity of the tick to the IPI
> handler, which could possibly cause code duplication and missing of other
> features that the tick already has. So it is better to turn on the tick as
> you pointed.
> 
> > We do have a hook into the interrupt handlers in the guise of the
> > irq==true case in rcu_nmi_exit_common().  When switching to an extended
> > quiescent state, there is nothing to do because FQS will detect the
> > quiescent state on the next pass.  Otherwise, the scheduler-clock
> > tick could be turned on.  But only if this is a nohz_full CPU and the
> > rdp->rcu_urgent_qs flag is set and the rdp->dynticks_nmi_nesting value
> > is 2.
> 
> dynticks_nmi_nesting == 2 means it is an outer-most IRQ that interrupted
> the CPU when it was not in a dynticks EQS state. Right?

Yes, that is the idea.

> > We also would need to turn the scheduler-clock interrupt off at some
> > point, presumably when a CPU reports its quiescent state to RCU core.
> 
> Makes sense, both the sites you add this to look like the right places.
> 
> > Interestingly enough, rcu_torture_fwd_prog_nr() detected this, but
> > my response was to add this to the beginning and end of it:
> > 
> > 	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
> > 		tick_dep_set_task(current, TICK_DEP_MASK_RCU);
> 
> Ok, not sure about the internals of this. But I am guessing this has the
> effect of immediately turning on the tick.

For that task, yes, but I am not so sure about the "immediately" part.

> > 	...
> > 
> > 	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
> > 		tick_dep_clear_task(current, TICK_DEP_MASK_RCU);
> > 
> > Thus, one could argue that this functionality should instead be in the
> > nohz_full code, but one has to start somewhere.  The goal would be to
> > be able to remove these statements from rcu_torture_fwd_prog_nr().
> 
> Agreed.
> 
> > > What do you think?  Also test diff is below.
> > 
> > Looks reasonable, though the long-term approach is to remove the above
> > lines from rcu_torture_fwd_prog_nr().  :-/
> > 
> > Untested patch below that includes some inadvertent whitespace fixes,
> > probably does not even build.  Thoughts?
> 
> It looks correct to me, one comment below:
> 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 8c494a692728..ad906d6a74fb 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -651,6 +651,12 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> >  	 */
> >  	if (rdp->dynticks_nmi_nesting != 1) {
> >  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> > +		if (tick_nohz_full_cpu(rdp->cpu) &&
> > +		    rdp->dynticks_nmi_nesting == 2 &&
> > +		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > +			rdp->rcu_forced_tick = true;
> > +			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > +		}
> 
> 
> Instead of checking dynticks_nmi_nesting == 2 in rcu_nmi_exit_common(), can
> we do the tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU)  from
> rcu_nmi_enter_common() ? We could add this code there, under the "if
> (rcu_dynticks_curr_cpu_in_eqs())".

It might well make sense to do this on entry, especially if doing so
might safe an instruction or two.  It won't make the tick happen much
faster, given that interrupts are disabled throughout the handler.

> I will test this patch tomorrow and let you know how it goes.

No need, it dies horribly and quickly with rcutorture.  Not exactly
a surprise.  ;-)

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> 
> 
> >  		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> >  			   rdp->dynticks_nmi_nesting - 2);
> >  		return;
> > @@ -886,6 +892,16 @@ void rcu_irq_enter_irqson(void)
> >  	local_irq_restore(flags);
> >  }
> >  
> > +/*
> > + * If the scheduler-clock interrupt was enabled on a nohz_full CPU
> > + * in order to get to a quiescent state, disable it.
> > + */
> > +void rcu_disable_tick_upon_qs(struct rcu_data *rdp)
> > +{
> > +	if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick)
> > +		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > +}
> > +
> >  /**
> >   * rcu_is_watching - see if RCU thinks that the current CPU is not idle
> >   *
> > @@ -1980,6 +1996,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
> >  		if (!offloaded)
> >  			needwake = rcu_accelerate_cbs(rnp, rdp);
> >  
> > +		rcu_disable_tick_upon_qs(rdp);
> >  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> >  		/* ^^^ Released rnp->lock */
> >  		if (needwake)
> > @@ -2269,6 +2286,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
> >  	int cpu;
> >  	unsigned long flags;
> >  	unsigned long mask;
> > +	struct rcu_data *rdp;
> >  	struct rcu_node *rnp;
> >  
> >  	rcu_for_each_leaf_node(rnp) {
> > @@ -2293,8 +2311,10 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
> >  		for_each_leaf_node_possible_cpu(rnp, cpu) {
> >  			unsigned long bit = leaf_node_cpu_bit(rnp, cpu);
> >  			if ((rnp->qsmask & bit) != 0) {
> > -				if (f(per_cpu_ptr(&rcu_data, cpu)))
> > -					mask |= bit;
> > +				rdp = per_cpu_ptr(&rcu_data, cpu);
> > +				if (f(rdp))
> > +					rcu_disable_tick_upon_qs(rdp);
> > +				mask |= bit;
> >  			}
> >  		}
> >  		if (mask != 0) {
> > @@ -2322,7 +2342,7 @@ void rcu_force_quiescent_state(void)
> >  	rnp = __this_cpu_read(rcu_data.mynode);
> >  	for (; rnp != NULL; rnp = rnp->parent) {
> >  		ret = (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) ||
> > -		      !raw_spin_trylock(&rnp->fqslock);
> > +		       !raw_spin_trylock(&rnp->fqslock);
> >  		if (rnp_old != NULL)
> >  			raw_spin_unlock(&rnp_old->fqslock);
> >  		if (ret)
> > @@ -2855,7 +2875,7 @@ static void rcu_barrier_callback(struct rcu_head *rhp)
> >  {
> >  	if (atomic_dec_and_test(&rcu_state.barrier_cpu_count)) {
> >  		rcu_barrier_trace(TPS("LastCB"), -1,
> > -				   rcu_state.barrier_sequence);
> > +				  rcu_state.barrier_sequence);
> >  		complete(&rcu_state.barrier_completion);
> >  	} else {
> >  		rcu_barrier_trace(TPS("CB"), -1, rcu_state.barrier_sequence);
> > @@ -2879,7 +2899,7 @@ static void rcu_barrier_func(void *unused)
> >  	} else {
> >  		debug_rcu_head_unqueue(&rdp->barrier_head);
> >  		rcu_barrier_trace(TPS("IRQNQ"), -1,
> > -				   rcu_state.barrier_sequence);
> > +				  rcu_state.barrier_sequence);
> >  	}
> >  	rcu_nocb_unlock(rdp);
> >  }
> > @@ -2906,7 +2926,7 @@ void rcu_barrier(void)
> >  	/* Did someone else do our work for us? */
> >  	if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
> >  		rcu_barrier_trace(TPS("EarlyExit"), -1,
> > -				   rcu_state.barrier_sequence);
> > +				  rcu_state.barrier_sequence);
> >  		smp_mb(); /* caller's subsequent code after above check. */
> >  		mutex_unlock(&rcu_state.barrier_mutex);
> >  		return;
> > @@ -2938,11 +2958,11 @@ void rcu_barrier(void)
> >  			continue;
> >  		if (rcu_segcblist_n_cbs(&rdp->cblist)) {
> >  			rcu_barrier_trace(TPS("OnlineQ"), cpu,
> > -					   rcu_state.barrier_sequence);
> > +					  rcu_state.barrier_sequence);
> >  			smp_call_function_single(cpu, rcu_barrier_func, NULL, 1);
> >  		} else {
> >  			rcu_barrier_trace(TPS("OnlineNQ"), cpu,
> > -					   rcu_state.barrier_sequence);
> > +					  rcu_state.barrier_sequence);
> >  		}
> >  	}
> >  	put_online_cpus();
> > @@ -3168,6 +3188,7 @@ void rcu_cpu_starting(unsigned int cpu)
> >  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> >  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> >  	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
> > +		rcu_disable_tick_upon_qs(rdp);
> >  		/* Report QS -after- changing ->qsmaskinitnext! */
> >  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> >  	} else {
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index c612f306fe89..055c31781d3a 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -181,6 +181,7 @@ struct rcu_data {
> >  	atomic_t dynticks;		/* Even value for idle, else odd. */
> >  	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
> >  	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
> > +	bool rcu_forced_tick;		/* Forced tick to provide QS. */
> >  #ifdef CONFIG_RCU_FAST_NO_HZ
> >  	bool all_lazy;			/* All CPU's CBs lazy at idle start? */
> >  	unsigned long last_accelerate;	/* Last jiffy CBs were accelerated. */
