Return-Path: <SRS0=Ms3y=WH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22129C0650F
	for <rcu@archiver.kernel.org>; Sun, 11 Aug 2019 21:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAC8208C2
	for <rcu@archiver.kernel.org>; Sun, 11 Aug 2019 21:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfHKVNU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:13:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726014AbfHKVNU (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 11 Aug 2019 17:13:20 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7BL6bvT018018;
        Sun, 11 Aug 2019 17:13:17 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uaqynkwn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 17:13:16 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7BL4d34003417;
        Sun, 11 Aug 2019 21:13:16 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 2u9nj6abm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 21:13:16 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7BLDGOX40894858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Aug 2019 21:13:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED263B2068;
        Sun, 11 Aug 2019 21:13:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD306B2064;
        Sun, 11 Aug 2019 21:13:15 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.198])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Aug 2019 21:13:15 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7BB2516C170F; Sun, 11 Aug 2019 14:13:18 -0700 (PDT)
Date:   Sun, 11 Aug 2019 14:13:18 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190811211318.GX28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190811180852.GA128944@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811180852.GA128944@google.com>
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

On Sun, Aug 11, 2019 at 02:08:52PM -0400, Joel Fernandes wrote:
> Hi Paul, everyone,
> 
> I noticed on reading code that the need_heavy_qs check and
> rcu_momentary_dyntick_idle() is only called for !PREEMPT kernels. Don't we
> need to call this for PREEMPT kernels for the benefit of nohz_full CPUs?
> 
> Consider the following events:
> 1. Kernel is PREEMPT=y configuration.
> 2. CPU 2 is a nohz_full CPU running only a single task and the tick is off.
> 3. CPU 2 is running only in kernel mode and does not enter user mode or idle.
> 4. Grace period thread running on CPU 3 enter the fqs loop.
> 5. Enough time passes and it sets the need_heavy_qs for CPU2.
> 6. CPU 2 is still in kernel mode but does cond_resched().
> 7. cond_resched() does not call rcu_momentary_dyntick_idle() because PREEMPT=y.
> 
> Is 7. not calling rcu_momentary_dyntick_idle() a lost opportunity for the FQS
> loop to detect that the CPU has crossed a quiescent point?
> 
> Is this done so that cond_resched() is fast for PREEMPT=y kernels?

The problem is that the definiton of cond_resched() in PREEMPT=y
kernels is as follows:

	static inline int _cond_resched(void) { return 0; }

If (but only if!) someone shows a problem in a PREEMPT=y kernel, the
code could be updated to do something like a resched_cpu() earlier
rather than later.

The reason that I do not expect a problem in NO_HZ_FULL=n&&PREEMPT=y
kernels is that the scheduling-clock tick will with high probability
happen when the CPU is not in an RCU read-side critical section, and
this quiescent state will be reported reasonably quickly.

This leaves NO_HZ_FULL=y&&PREEMPT=y kernels.  In that case, RCU is
more aggressive about using resched_cpu() on CPUs that have not yet
reported a quiescent state for the current grace period.

So we should be good as is.

Or am I missing a key corner case here?

							Thanx, Paul
