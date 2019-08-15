Return-Path: <SRS0=ayKe=WL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8360C3A589
	for <rcu@archiver.kernel.org>; Thu, 15 Aug 2019 21:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C932083B
	for <rcu@archiver.kernel.org>; Thu, 15 Aug 2019 21:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfHOV5b (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:57:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730803AbfHOV5b (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 15 Aug 2019 17:57:31 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7FLq4YS088475;
        Thu, 15 Aug 2019 17:57:29 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udemdad5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 17:57:29 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7FLvSXT001423;
        Thu, 15 Aug 2019 21:57:28 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 2u9nj6djr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 21:57:27 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7FLvRhP55378268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 21:57:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8912EB2066;
        Thu, 15 Aug 2019 21:57:27 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D4CBB2064;
        Thu, 15 Aug 2019 21:57:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Aug 2019 21:57:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5EBFF16C1D04; Thu, 15 Aug 2019 14:57:28 -0700 (PDT)
Date:   Thu, 15 Aug 2019 14:57:28 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, frederic@kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190815215728.GN28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190812035306.GE28441@linux.ibm.com>
 <20190812212013.GB48751@google.com>
 <20190812230138.GS28441@linux.ibm.com>
 <20190813010249.GA129011@google.com>
 <20190815171714.GA1023@linux.ibm.com>
 <20190815200432.GB23194@google.com>
 <20190815203107.GL28441@linux.ibm.com>
 <20190815212216.GA224191@google.com>
 <20190815212756.GA225926@google.com>
 <20190815213412.GB225926@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815213412.GB225926@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150205
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 15, 2019 at 05:34:12PM -0400, Joel Fernandes wrote:
> On Thu, Aug 15, 2019 at 05:27:56PM -0400, Joel Fernandes wrote:
> > On Thu, Aug 15, 2019 at 05:22:16PM -0400, Joel Fernandes wrote:
> > > On Thu, Aug 15, 2019 at 01:31:07PM -0700, Paul E. McKenney wrote:
> > > > On Thu, Aug 15, 2019 at 04:04:32PM -0400, Joel Fernandes wrote:
> > > > > On Thu, Aug 15, 2019 at 10:17:14AM -0700, Paul E. McKenney wrote:
> > > > > > On Mon, Aug 12, 2019 at 09:02:49PM -0400, Joel Fernandes wrote:
> > > > > > > On Mon, Aug 12, 2019 at 04:01:38PM -0700, Paul E. McKenney wrote:
> > > > > > 
> > > > > > [ . . . ]
> > > > > > 
> > > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > > index 8c494a692728..ad906d6a74fb 100644
> > > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > > @@ -651,6 +651,12 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> > > > > > > >  	 */
> > > > > > > >  	if (rdp->dynticks_nmi_nesting != 1) {
> > > > > > > >  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> > > > > > > > +		if (tick_nohz_full_cpu(rdp->cpu) &&
> > > > > > > > +		    rdp->dynticks_nmi_nesting == 2 &&
> > > > > > > > +		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > > > > > > > +			rdp->rcu_forced_tick = true;
> > > > > > > > +			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > > > > > > > +		}
> > > > > > > 
> > > > > > > 
> > > > > > > Instead of checking dynticks_nmi_nesting == 2 in rcu_nmi_exit_common(), can
> > > > > > > we do the tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU)  from
> > > > > > > rcu_nmi_enter_common() ? We could add this code there, under the "if
> > > > > > > (rcu_dynticks_curr_cpu_in_eqs())".
> > > > > > 
> > > > > > This would need to go in an "else" clause, correct?  But there would still
> > > > > > want to be a check for interrupt from base level (which would admittedly
> > > > > > be an equality comparison with zero) and we would also still need to check
> > > > > > for rdp->rcu_urgent_qs && !rdp->rcu_forced_tick.
> > > > > 
> > > > > True, agreed. I replied to this before saying it should be
> > > > > !rcu_dynticks_curr_cpu_in_eqs() in the "if" ;) But it seems I could also be
> > > > > missing the check for TICK_DEP_MASK_RCU in my tree so I think we need this as
> > > > > well which is below as diff. Testing it more now!
> > > > > 
> > > > > And, with this I do get many more ticks during the test. But there are
> > > > > intervals where the tick is not seen. Still it is much better than before:
> > > > > 
> > > > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > > > index be9707f68024..e697c7a2ce67 100644
> > > > > --- a/kernel/time/tick-sched.c
> > > > > +++ b/kernel/time/tick-sched.c
> > > > > @@ -198,6 +198,10 @@ static bool check_tick_dependency(atomic_t *dep)
> > > > >  		return true;
> > > > >  	}
> > > > >  
> > > > > +	if (val & TICK_DEP_MASK_CLOCK_RCU) {
> > > > > +		return true;
> > > > > +	}
> > > > > +
> > > > >  	return false;
> > > > >  }
> > > > 
> > > > That one is not in my tree, either.  Frederic, should I add this to
> > > > your patch?  For that matter, may I add your Signed-off-by as well?
> > > > Your original is in my -rcu tree at:
> > > > 
> > > > 0cb41806c799 ("EXP nohz: Add TICK_DEP_BIT_RCU")
> > > > 
> > > > I am testing Joel's suggested addition now.
> > > 
> > > Actually there's more addition needed! I found another thing missing:
> > > 
> > > There's a per-cpu &tick_dep_mask and a per-cpu ts->tick_dep_mask. It seems
> > > RCU is setting the latter.
> > > 
> > > So I added a check for both, below is the diff:
> > > 
> > > However, I see in some cases that the tick_dep_mask is just 0 but I have to
> > > debug that tomorrow if that's an issue on the RCU side of things. For now,
> > > below should be the completed Frederick patch which you could squash into his
> > > if he's Ok with it:
> > > 
> > > ---8<-----------------------
> > > 
> > > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > > index f92a10b5e112..3f476e2a4bf7 100644
> > > --- a/include/linux/tick.h
> > > +++ b/include/linux/tick.h
> > > @@ -108,7 +108,8 @@ enum tick_dep_bits {
> > >  	TICK_DEP_BIT_POSIX_TIMER	= 0,
> > >  	TICK_DEP_BIT_PERF_EVENTS	= 1,
> > >  	TICK_DEP_BIT_SCHED		= 2,
> > > -	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3
> > > +	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
> > > +	TICK_DEP_BIT_RCU		= 4
> > >  };
> > >  
> > >  #define TICK_DEP_MASK_NONE		0
> > > @@ -116,6 +117,7 @@ enum tick_dep_bits {
> > >  #define TICK_DEP_MASK_PERF_EVENTS	(1 << TICK_DEP_BIT_PERF_EVENTS)
> > >  #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
> > >  #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
> > > +#define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
> > >  
> > >  #ifdef CONFIG_NO_HZ_COMMON
> > >  extern bool tick_nohz_enabled;
> > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > index be9707f68024..a613916cc3f0 100644
> > > --- a/kernel/time/tick-sched.c
> > > +++ b/kernel/time/tick-sched.c
> > > @@ -198,6 +198,11 @@ static bool check_tick_dependency(atomic_t *dep)
> > >  		return true;
> > >  	}
> > >  
> > > +	if (val & TICK_DEP_MASK_RCU) {
> > > +		trace_tick_stop(0, TICK_DEP_MASK_RCU);
> > > +		return true;
> > > +	}
> > > +
> > >  	return false;
> > >  }
> > >  
> > > @@ -208,8 +213,13 @@ static bool can_stop_full_tick(int cpu, struct tick_sched *ts)
> > >  	if (unlikely(!cpu_online(cpu)))
> > >  		return false;
> > >  
> > > -	if (check_tick_dependency(&tick_dep_mask))
> > > +	if (check_tick_dependency(&ts->tick_dep_mask)) {
> > >  		return false;
> > > +	}
> > > +
> > > +	if (check_tick_dependency(&tick_dep_mask)) {
> > > +		return false;
> > > +	}
> > >  
> > >  	if (check_tick_dependency(&ts->tick_dep_mask))
> > >  		return false;
> > 
> > Ah, I was being silly... this is already taken care off here. So you could
> > just drop this hunk and keep the other hunks.
> 
> Sorry for the noise, to truly prevent the tick from getting turned off, I had
> to do something like the following, it is a complete hack but it worked well
> for me. I will debug this more and try to come up with a better solution
> tomorrow:

Hmmm...  In the cases where the tick is not being turned off, is it
possible that the CPU in question has already supplied its quiescent
state for the current grace period?  Or is ->rcu_urgent_qs being cleared
before RCU's dyntick-idle code can see it?

Ah, the latter, I bet.  Another argument for making the dyntick-idle
irq-entry code turn on the tick!  ;-)

I pushed a commit making that change to -rcu branch dev.

							Thanx, Paul

> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] HACK: Force tick to not turn off if RCU is in urgent need of QS report
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c        | 12 ++++++++++++
>  kernel/time/tick-sched.c | 15 +++++++++++----
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a86c3c705e4d..60f81e151538 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -215,6 +215,18 @@ static long rcu_get_n_cbs_cpu(int cpu)
>  	return rcu_get_n_cbs_nocb_cpu(rdp); /* Works for offline, too. */
>  }
>  
> +int rdp_nhq(void) {
> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> +
> +	return !!rdp->rcu_need_heavy_qs;
> +}
> +
> +int  rdp_uq(void) {
> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> +
> +	return !!rdp->rcu_urgent_qs;
> +}
> +
>  void rcu_softirq_qs(void)
>  {
>  	rcu_qs();
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index b14fc72c3b31..40df90222e34 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -851,6 +851,9 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
>  	tick_nohz_restart(ts, now);
>  }
>  
> +int rdp_nhq(void);
> +int  rdp_uq(void);
> +
>  static void tick_nohz_full_update_tick(struct tick_sched *ts)
>  {
>  #ifdef CONFIG_NO_HZ_FULL
> @@ -862,14 +865,18 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
>  	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
>  		return;
>  
> -	if (can_stop_full_tick(cpu, ts)) {
> -		trace_printk("stopping sched-tick: need_heavy_qs=%d urgent_qs=%d\n", rdp_nhq(), rdp_uq());
> -		trace_printk("stopping sched-tick: tick_dep_rcu=%d\n",
> -				(atomic_read(&ts->tick_dep_mask) | TICK_DEP_MASK_RCU));
> +	if (can_stop_full_tick(cpu, ts) && !rdp_nhq() && !rdp_uq()) {
> +#if 0
> +		trace_printk("stopping sched-tick: need_heavy_qs=%d urgent_qs=%d\n", );
> +		trace_printk("stopping sched-tick: tick_dep_rcu=%d , ts %lu\n",
> +				(atomic_read(&ts->tick_dep_mask) & TICK_DEP_MASK_RCU), (unsigned long)(&ts->tick_dep_mask));
> +#endif
>  		tick_nohz_stop_sched_tick(ts, cpu);
>  	}
>  	else if (ts->tick_stopped) {
> +#if 0
>  		trace_printk("restarting sched-tick\n");
> +#endif
>  		tick_nohz_restart_sched_tick(ts, ktime_get());
>  	}
>  #endif
> -- 
> 2.23.0.rc1.153.gdeed80330f-goog
> 
