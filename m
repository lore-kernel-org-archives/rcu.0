Return-Path: <SRS0=ayKe=WL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F839C3A589
	for <rcu@archiver.kernel.org>; Thu, 15 Aug 2019 17:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47336205F4
	for <rcu@archiver.kernel.org>; Thu, 15 Aug 2019 17:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfHORR0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:17:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730277AbfHORRZ (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 15 Aug 2019 13:17:25 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7FHF2hb066453
        for <rcu@vger.kernel.org>; Thu, 15 Aug 2019 13:17:20 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ud8jd84x1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Thu, 15 Aug 2019 13:17:20 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 15 Aug 2019 18:17:17 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 15 Aug 2019 18:17:15 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7FHHE3U15991622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 17:17:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17BDDB2064;
        Thu, 15 Aug 2019 17:17:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFD6BB205F;
        Thu, 15 Aug 2019 17:17:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Aug 2019 17:17:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9AD4C16C1B4C; Thu, 15 Aug 2019 10:17:14 -0700 (PDT)
Date:   Thu, 15 Aug 2019 10:17:14 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
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
x-cbid: 19081517-0064-0000-0000-00000408E4AC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011594; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01247258; UDB=6.00658254; IPR=6.01028765;
 MB=3.00028186; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-15 17:17:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081517-0065-0000-0000-00003EAE20B6
Message-Id: <20190815171714.GA1023@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150166
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 12, 2019 at 09:02:49PM -0400, Joel Fernandes wrote:
> On Mon, Aug 12, 2019 at 04:01:38PM -0700, Paul E. McKenney wrote:

[ . . . ]

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

This would need to go in an "else" clause, correct?  But there would still
want to be a check for interrupt from base level (which would admittedly
be an equality comparison with zero) and we would also still need to check
for rdp->rcu_urgent_qs && !rdp->rcu_forced_tick.

Still, an equal-zero comparison is probably going to be a bit cheaper than
an equals-two comparison, and this is on the interrupt-entry fastpath,
so this change is likely worth making.  Good call!!!

							Thanx, Paul

> I will test this patch tomorrow and let you know how it goes.
> 
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

