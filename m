Return-Path: <SRS0=ayKe=WL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5574BC3A589
	for <rcu@archiver.kernel.org>; Thu, 15 Aug 2019 20:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB972083B
	for <rcu@archiver.kernel.org>; Thu, 15 Aug 2019 20:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfHOUbL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:31:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730018AbfHOUbL (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 15 Aug 2019 16:31:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7FKR1gs037549;
        Thu, 15 Aug 2019 16:31:09 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udby9e23m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 16:31:08 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7FKRvZD019523;
        Thu, 15 Aug 2019 20:31:07 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01wdc.us.ibm.com with ESMTP id 2u9nj755y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 20:31:07 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7FKV7el49152490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 20:31:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34C8BB205F;
        Thu, 15 Aug 2019 20:31:07 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19067B2066;
        Thu, 15 Aug 2019 20:31:07 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Aug 2019 20:31:07 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0396B16C1D04; Thu, 15 Aug 2019 13:31:08 -0700 (PDT)
Date:   Thu, 15 Aug 2019 13:31:07 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, frederic@kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190815203107.GL28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190811180852.GA128944@google.com>
 <20190811211318.GX28441@linux.ibm.com>
 <20190812032142.GA171001@google.com>
 <20190812035306.GE28441@linux.ibm.com>
 <20190812212013.GB48751@google.com>
 <20190812230138.GS28441@linux.ibm.com>
 <20190813010249.GA129011@google.com>
 <20190815171714.GA1023@linux.ibm.com>
 <20190815200432.GB23194@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815200432.GB23194@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150194
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 15, 2019 at 04:04:32PM -0400, Joel Fernandes wrote:
> On Thu, Aug 15, 2019 at 10:17:14AM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 12, 2019 at 09:02:49PM -0400, Joel Fernandes wrote:
> > > On Mon, Aug 12, 2019 at 04:01:38PM -0700, Paul E. McKenney wrote:
> > 
> > [ . . . ]
> > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 8c494a692728..ad906d6a74fb 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -651,6 +651,12 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> > > >  	 */
> > > >  	if (rdp->dynticks_nmi_nesting != 1) {
> > > >  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> > > > +		if (tick_nohz_full_cpu(rdp->cpu) &&
> > > > +		    rdp->dynticks_nmi_nesting == 2 &&
> > > > +		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > > > +			rdp->rcu_forced_tick = true;
> > > > +			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > > > +		}
> > > 
> > > 
> > > Instead of checking dynticks_nmi_nesting == 2 in rcu_nmi_exit_common(), can
> > > we do the tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU)  from
> > > rcu_nmi_enter_common() ? We could add this code there, under the "if
> > > (rcu_dynticks_curr_cpu_in_eqs())".
> > 
> > This would need to go in an "else" clause, correct?  But there would still
> > want to be a check for interrupt from base level (which would admittedly
> > be an equality comparison with zero) and we would also still need to check
> > for rdp->rcu_urgent_qs && !rdp->rcu_forced_tick.
> 
> True, agreed. I replied to this before saying it should be
> !rcu_dynticks_curr_cpu_in_eqs() in the "if" ;) But it seems I could also be
> missing the check for TICK_DEP_MASK_RCU in my tree so I think we need this as
> well which is below as diff. Testing it more now!
> 
> And, with this I do get many more ticks during the test. But there are
> intervals where the tick is not seen. Still it is much better than before:
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index be9707f68024..e697c7a2ce67 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -198,6 +198,10 @@ static bool check_tick_dependency(atomic_t *dep)
>  		return true;
>  	}
>  
> +	if (val & TICK_DEP_MASK_CLOCK_RCU) {
> +		return true;
> +	}
> +
>  	return false;
>  }

That one is not in my tree, either.  Frederic, should I add this to
your patch?  For that matter, may I add your Signed-off-by as well?
Your original is in my -rcu tree at:

0cb41806c799 ("EXP nohz: Add TICK_DEP_BIT_RCU")

I am testing Joel's suggested addition now.

							Thanx, Paul

> > Still, an equal-zero comparison is probably going to be a bit cheaper than
> > an equals-two comparison, and this is on the interrupt-entry fastpath,
> > so this change is likely worth making.  Good call!!!
> 
> Thanks!!
> 
>  - Joel
> 
> [snip]
