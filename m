Return-Path: <SRS0=Ms3y=WH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD13EC0650F
	for <rcu@archiver.kernel.org>; Sun, 11 Aug 2019 21:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2F6208C2
	for <rcu@archiver.kernel.org>; Sun, 11 Aug 2019 21:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfHKVQr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:16:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbfHKVQr (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 11 Aug 2019 17:16:47 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7BL6bmP133343;
        Sun, 11 Aug 2019 17:16:45 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uab19y7qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 17:16:45 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7BL4diR003427;
        Sun, 11 Aug 2019 21:16:44 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 2u9nj6an37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 21:16:44 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7BLGhtm32899512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Aug 2019 21:16:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AB04B2064;
        Sun, 11 Aug 2019 21:16:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A858B205F;
        Sun, 11 Aug 2019 21:16:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.198])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Aug 2019 21:16:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1D14F16C124D; Sun, 11 Aug 2019 14:16:46 -0700 (PDT)
Date:   Sun, 11 Aug 2019 14:16:46 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190811211646.GY28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190811180852.GA128944@google.com>
 <CAEXW_YSbGCSLVrqD-_pDO5KJzLR2goYt8otOd65hWPQtZGkGUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSbGCSLVrqD-_pDO5KJzLR2goYt8otOd65hWPQtZGkGUA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-11_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908110236
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 11, 2019 at 02:34:08PM -0400, Joel Fernandes wrote:
> On Sun, Aug 11, 2019 at 2:08 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Hi Paul, everyone,
> >
> > I noticed on reading code that the need_heavy_qs check and
> > rcu_momentary_dyntick_idle() is only called for !PREEMPT kernels. Don't we
> > need to call this for PREEMPT kernels for the benefit of nohz_full CPUs?
> >
> > Consider the following events:
> > 1. Kernel is PREEMPT=y configuration.
> > 2. CPU 2 is a nohz_full CPU running only a single task and the tick is off.
> > 3. CPU 2 is running only in kernel mode and does not enter user mode or idle.
> > 4. Grace period thread running on CPU 3 enter the fqs loop.
> > 5. Enough time passes and it sets the need_heavy_qs for CPU2.
> > 6. CPU 2 is still in kernel mode but does cond_resched().
> > 7. cond_resched() does not call rcu_momentary_dyntick_idle() because PREEMPT=y.
> >
> > Is 7. not calling rcu_momentary_dyntick_idle() a lost opportunity for the FQS
> > loop to detect that the CPU has crossed a quiescent point?
> >
> > Is this done so that cond_resched() is fast for PREEMPT=y kernels?
> 
> Oh, so I take it this bit of code in rcu_implicit_dynticks_qs(), with
> the accompanying comments, takes care of the scenario I describe?
> Another way could be just call rcu_momentary_dyntick_idle() during
> cond_resched() for nohz_full CPUs? Is that pricey?
>         /*
>          * NO_HZ_FULL CPUs can run in-kernel without rcu_sched_clock_irq!
>          * The above code handles this, but only for straight cond_resched().
>          * And some in-kernel loops check need_resched() before calling
>          * cond_resched(), which defeats the above code for CPUs that are
>          * running in-kernel with scheduling-clock interrupts disabled.
>          * So hit them over the head with the resched_cpu() hammer!
>          */
>         if (tick_nohz_full_cpu(rdp->cpu) &&
>                    time_after(jiffies,
>                               READ_ONCE(rdp->last_fqs_resched) + jtsq * 3)) {
>                 resched_cpu(rdp->cpu);
>                 WRITE_ONCE(rdp->last_fqs_resched, jiffies);
>         }

Yes, for NO_HZ_FULL=y&&PREEMPT=y kernels.

Your thought of including rcu_momentary_dyntick_idle() would function
correctly, but would cause performance issues.  Even adding additional
compares and branches in that hot codepath is visible to 0day test robot!
So adding a read-modify-write atomic operation to that code path would
get attention of the wrong kind.  ;-)

But please see my earlier email on how things work out for kernels
built with NO_HZ_FULL=n&&PREEMPT=y.

							Thanx, Paul
