Return-Path: <SRS0=P5Uu=WI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596C1C31E40
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 03:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDF720842
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 03:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfHLDxH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 11 Aug 2019 23:53:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726185AbfHLDxH (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 11 Aug 2019 23:53:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7C3pwxM136738;
        Sun, 11 Aug 2019 23:53:05 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uavmxe6ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 23:53:04 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7C3pdQJ002447;
        Mon, 12 Aug 2019 03:53:04 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 2u9nj6cd9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 03:53:03 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7C3r3m449480016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Aug 2019 03:53:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 361BDB2066;
        Mon, 12 Aug 2019 03:53:03 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1565EB205F;
        Mon, 12 Aug 2019 03:53:03 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.198])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Aug 2019 03:53:03 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 29C1616C9A72; Sun, 11 Aug 2019 20:53:06 -0700 (PDT)
Date:   Sun, 11 Aug 2019 20:53:06 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190812035306.GE28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190811180852.GA128944@google.com>
 <20190811211318.GX28441@linux.ibm.com>
 <20190812032142.GA171001@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812032142.GA171001@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120041
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 11, 2019 at 11:21:42PM -0400, Joel Fernandes wrote:
> On Sun, Aug 11, 2019 at 02:13:18PM -0700, Paul E. McKenney wrote:
> [snip]
> > This leaves NO_HZ_FULL=y&&PREEMPT=y kernels.  In that case, RCU is
> > more aggressive about using resched_cpu() on CPUs that have not yet
> > reported a quiescent state for the current grace period.
> 
> Just wanted to ask something - how does resched_cpu() help for this case?
> 
> Consider a nohz_full CPU and a PREEMPT=y kernel. Say a single task is running
> in kernel mode with scheduler tick off. As we discussed, we have no help from
> cond_resched() (since its a PREEMPT=y kernel).  Because enough time has
> passed (jtsq*3), we send the CPU a re-scheduling IPI.
> 
> This seems not that useful. Even if we enter the scheduler due to the
> rescheduling flags set on that CPU, nothing will do the rcu_report_qs_rdp()
> or rcu_report_qs_rnp() on those CPUs, which are needed to propagate the
> quiescent state to the leaf node. Neither will anything to do a
> rcu_momentary_dyntick_idle() for that CPU. Without this, the grace period
> will still end up getting blocked.
> 
> Could you clarify which code paths on a nohz_full CPU running PREEMPT=y
> kernel actually helps to end the grace period when we call resched_cpu() on
> it?  Don't we need atleast do a rcu_momentary_dyntick_idle() from the
> scheduler IPI handler or from resched_cpu() for the benefit of a nohz_full
> CPU? Maybe I should do an experiment to see this all play out.

An experiment would be good!

> And I need to write down everything I learnt today before I go crazy... ;-)

I know that feeling!  ;-)

							Thanx, Paul
