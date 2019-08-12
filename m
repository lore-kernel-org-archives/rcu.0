Return-Path: <SRS0=P5Uu=WI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76313C433FF
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 03:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497C720842
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 03:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfHLD5L (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 11 Aug 2019 23:57:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbfHLD5K (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 11 Aug 2019 23:57:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7C3utV1138305;
        Sun, 11 Aug 2019 23:57:09 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uaw50dfu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 23:57:09 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7C3tmNS020827;
        Mon, 12 Aug 2019 03:57:08 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 2u9nj61evs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 03:57:08 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7C3v7XG46793116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Aug 2019 03:57:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D418B2064;
        Mon, 12 Aug 2019 03:57:07 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D509B205F;
        Mon, 12 Aug 2019 03:57:07 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.198])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Aug 2019 03:57:07 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 718D616C124D; Sun, 11 Aug 2019 20:57:10 -0700 (PDT)
Date:   Sun, 11 Aug 2019 20:57:10 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190812035710.GF28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190811180852.GA128944@google.com>
 <CAEXW_YSbGCSLVrqD-_pDO5KJzLR2goYt8otOd65hWPQtZGkGUA@mail.gmail.com>
 <20190811211646.GY28441@linux.ibm.com>
 <20190811212505.GB128944@google.com>
 <20190811233024.GZ28441@linux.ibm.com>
 <20190812012431.GC128944@google.com>
 <20190812014053.GD128944@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812014053.GD128944@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120042
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 11, 2019 at 09:40:53PM -0400, Joel Fernandes wrote:
> On Sun, Aug 11, 2019 at 09:24:31PM -0400, Joel Fernandes wrote:
> > On Sun, Aug 11, 2019 at 04:30:24PM -0700, Paul E. McKenney wrote:
> [snip]
> > > Next question:  Why does rcu_implicit_dynticks_qs() check only for
> > > tick_nohz_full_cpu() and not also IS_ENABLED(CONFIG_PREEMPT)?  After
> > > all, a nohz_full CPU in a !CONFIG_PREEMPT kernel should be able to
> > > rely on cond_resched(), right?
> > > 
> > > Should this change?  Why or why not?
> > 
> > Let me think more about this :) I have an answer in mind but I will think a
> > bit more about it and responsd :)
> 
> It should not change. That's because (as somewhat mentioned in the comments),
> some code paths in the kernel check need_resched() before invoking
> cond_resched(). So even with PREEMPT=n having the help of cond_resched(), the
> cond_resched() may actually not even be invoked.  So in this case, the
> resched_cpu() from rcu_implicit_dynticks_qs() does the needful by setting the
> rescheduling flags on the CPU, so that cond_resched() on those CPUs actually
> get called. Is that a correct analysis?

Looks valid to me!  There might well be other scenarios as well, but
only one is required to justify the resched_cpu().

							Thanx, Paul
